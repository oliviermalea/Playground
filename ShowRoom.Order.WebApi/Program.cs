using Carter;
using FluentValidation;
using MassTransit.Logging;
using MassTransit.Monitoring;
using MediatR;
using OpenTelemetry.Metrics;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using Serilog;
using Serilog.Events;
using Serilog.Sinks.OpenTelemetry;
using ShowRoom.Order.WebApi.Infrastructure.Behaviour;
using ShowRoom.Order.WebApi.Infrastructure.Observability;
using ShowRoom.Order.WebApi.Infrastructure.ServicesSetup;
using System.Diagnostics.CodeAnalysis;

var builder = WebApplication.CreateBuilder(args);

var env = builder.Environment;
var serviceName = env.ApplicationName;

//// Note: Switch between Zipkin/Jaeger/OTLP/Console by setting UseTracingExporter in appsettings.json.
//var tracingExporter = builder.Configuration.GetValue<string>("UseTracingExporter").ToLowerInvariant();

//// Note: Switch between Prometheus/OTLP/Console by setting UseMetricsExporter in appsettings.json.
//var metricsExporter = builder.Configuration.GetValue<string>("UseMetricsExporter").ToLowerInvariant();

// Note: Switch between Console/OTLP by setting UseLogExporter in appsettings.json.
//var logExporter = builder.Configuration.GetValue<string>("UseLogExporter").ToLowerInvariant();

//// Note: Switch between Explicit/Exponential by setting HistogramAggregation in appsettings.json
//var histogramAggregation = builder.Configuration.GetValue<string>("HistogramAggregation").ToLowerInvariant();

// Build a resource configuration action to set service information.
Action<ResourceBuilder> configureResource = r => r.AddService(
    //serviceName: builder.Configuration.GetValue<string>("ServiceName"),
    serviceName: serviceName,
    serviceVersion: typeof(Program).Assembly.GetName().Version?.ToString() ?? "unknown",
    serviceInstanceId: Environment.MachineName);

// Create a service to expose ActivitySource, and Metric Instruments
// for manual instrumentation
builder.Services.AddSingleton<Instrumentation>();

builder.Services.AddOpenTelemetry()
    .ConfigureResource(configureResource)
    .WithTracing(traceBuilder =>
    {
        // Ensure the TracerProvider subscribes to any custom ActivitySources.
        traceBuilder
            .AddSource(Instrumentation.ActivitySourceName)
            .AddSource(DiagnosticHeaders.DefaultListenerName)
            .SetResourceBuilder(ResourceBuilder.CreateDefault().AddService(serviceName))
            .SetSampler(new AlwaysOnSampler())
            .AddHttpClientInstrumentation()
            .AddAspNetCoreInstrumentation()

            .AddConsoleExporter();

        traceBuilder.AddOtlpExporter(otlpOptions =>
        {
            // Use IConfiguration directly for Otlp exporter endpoint option.
            otlpOptions.Endpoint = new Uri(builder.Configuration.GetValue<string>("Otlp:Endpoint"));
        });
    })
    .WithMetrics(metricBuilder =>
    {
        metricBuilder
            .AddMeter(Instrumentation.MeterName)
            .AddMeter(InstrumentationOptions.MeterName)
            .AddHttpClientInstrumentation()
            .AddAspNetCoreInstrumentation();

        metricBuilder.AddOtlpExporter(otlpOptions =>
        {
            // Use IConfiguration directly for Otlp exporter endpoint option.
            otlpOptions.Endpoint = new Uri(builder.Configuration.GetValue<string>("Otlp:Endpoint"));
        });
    });

//// Logs
Log.Logger = CreateSerilogAppLogger();
Log.Information("Starting up");
Log.Information($"Launching {serviceName} app");
builder.Host.UseSerilog();
//// End Logs

var configuration = builder.Configuration;
configuration.SetBasePath(env.ContentRootPath);
configuration.AddJsonFile("appsettings.json", false, true);
//configuration.AddJsonFile("appsettings.Development.json", false, true);
//// In case of multiple dev environements
//configuration.AddJsonFile($"appsettings.{Environment.MachineName}.json", true, true);
configuration.AddEnvironmentVariables();
builder.Services.AddHealthChecks();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddMediatR(cfg => cfg.RegisterServicesFromAssembly(typeof(Program).Assembly))
    .AddScoped(typeof(IPipelineBehavior<,>), typeof(LoggingBehaviour<,>))
    .AddScoped(typeof(IPipelineBehavior<,>), typeof(ObservabilityBehaviour<,>))
    .AddScoped(typeof(IPipelineBehavior<,>), typeof(ValidationBehaviour<,>));
builder.Services.AddMTRabbitMqBroker(configuration);
builder.Services.AddSwaggerGen();
builder.Services.AddValidatorsFromAssembly(typeof(Program).Assembly);
builder.Services.AddCarter();
builder.Services.AddProblemDetails(o => o.CustomizeProblemDetails = ctx =>
{
    var problemCorrelationId = Guid.NewGuid().ToString();
    ctx.ProblemDetails.Instance = problemCorrelationId;
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.MapCarter();
app.MapHealthChecks("/health");

app.Run();

/// <summary>
/// Parametrizes the serilog App logger. 
/// </summary>
/// <returns><see cref="ILogger"/></returns>
static Serilog.ILogger CreateSerilogAppLogger(/*WebApplicationBuilder builder*/)
{
    var outputTemplate = "{Timestamp:yyyy-MM-dd HH:mm:ss.fff zzz} [{Level:u3}] | {Message:lj} >{NewLine}{Exception}";

    return new LoggerConfiguration()
        .MinimumLevel.Debug()
        .MinimumLevel.Override("Microsoft", LogEventLevel.Information)
        .MinimumLevel.Override("Microsoft.AspNetCore", LogEventLevel.Warning)
        ////.MinimumLevel.Override("Microsoft.EntityFrameworkCore", LogEventLevel.Warning)
        .MinimumLevel.Override("System", LogEventLevel.Warning)
        .MinimumLevel.Override("System.Net.Http.HttpClient", LogEventLevel.Warning)
        .Enrich.FromLogContext()
        .WriteTo.Console(outputTemplate: outputTemplate)
        .WriteTo.File(
            $"logs/log-{DateTime.Now:yyyy-MM-dd}.txt",
            outputTemplate: outputTemplate,
            fileSizeLimitBytes: default,
            rollOnFileSizeLimit: true)
        .WriteTo.OpenTelemetry(options =>
        {
            //// Use protobuff because Grpc is broken with non https stuff
            ////options.Endpoint = new Uri(builder.Configuration.GetValue<string>("Otlp:Endpoint")).ToString();
            options.Endpoint = new Uri("http://otel-collector:4318/v1/logs").ToString();
            options.Protocol = OtlpProtocol.HttpProtobuf;
            options.IncludedData = IncludedData.MessageTemplateTextAttribute |
                          IncludedData.TraceIdField | IncludedData.SpanIdField;
        })
        .CreateBootstrapLogger();
}

[ExcludeFromCodeCoverage]
public partial class Program
{
    protected Program() { }
}