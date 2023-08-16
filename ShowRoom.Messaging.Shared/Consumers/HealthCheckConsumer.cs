namespace ShowRoom.Messaging.Shared.Consumers;

using MassTransit;
using Microsoft.Extensions.Logging;
using ShowRoom.Messaging.Shared.Contracts;
using System.Threading.Tasks;

public class HealthCheckConsumer : IConsumer<IHealthCheckRequest>
{
    private readonly ILogger<HealthCheckConsumer> _logger;

    public HealthCheckConsumer(ILogger<HealthCheckConsumer> logger)
    {
        _logger = logger;
    }

    public async Task Consume(ConsumeContext<IHealthCheckRequest> context)
    {
        _logger.LogInformation($"Received HealthCheck Message From : {context.Message.Service} at {context.Message.SentDate} IsHealthy {context.Message.IsHealthy}");
        await context.RespondAsync<IHealthCheckRequest>(HealthCheckBuilder.Build()).ConfigureAwait(false);
    }
}