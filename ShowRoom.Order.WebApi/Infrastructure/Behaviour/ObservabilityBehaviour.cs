using MediatR;
using ShowRoom.Order.WebApi.Infrastructure.Observability;
using System.Diagnostics;
using System.Diagnostics.Metrics;
using System.Reflection;

namespace ShowRoom.Order.WebApi.Infrastructure.Behaviour;

public class ObservabilityBehaviour<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse> where TRequest : notnull
{
    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
    {
        var activityQuery = typeof(TRequest).Name;
        var meter = new Meter(Instrumentation.MeterName);

        var counter = meter.CreateCounter<int>("compute_requests");
        var histogram = meter.CreateHistogram<float>("request_duration", unit: "ms");
        meter.CreateObservableGauge("ThreadCount", () => new[] { new Measurement<int>(ThreadPool.ThreadCount) });
        // Measure the number of requests
        counter.Add(1, KeyValuePair.Create<string, object?>("name", typeof(TRequest).Name));

        var stopwatch = Stopwatch.StartNew();

        using (Activity activity = ActivityHelper.Source.StartActivity(activityQuery, ActivityKind.Server))
        {
            activity?.AddTag("Query", typeof(TRequest).Name);
            activity?.AddBaggage("Context", typeof(TRequest).Name);

            Type myType = request.GetType();
            IList<PropertyInfo> props = new List<PropertyInfo>(myType.GetProperties());

            foreach (PropertyInfo prop in props)
            {
                object propValue = prop.GetValue(request, null);
                activity?.AddTag(prop.Name, propValue);
            }
        }
        var response = await next();

        histogram.Record(stopwatch.ElapsedMilliseconds,
            tag: KeyValuePair.Create<string, object?>("response", typeof(TResponse).Name));

        return response;
    }
}
