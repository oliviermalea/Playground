namespace ShowRoom.Messaging.Shared;

using MassTransit;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Threading;
using System.Threading.Tasks;

public class MassTransitBusControlService : IHostedService
{
    private readonly ILogger<MassTransitBusControlService> logger;
    private readonly IBusControl busControl;

    public MassTransitBusControlService(
        ILogger<MassTransitBusControlService> logger, 
        IBusControl busControl
        )
    {
        this.logger = logger;
        this.busControl = busControl;
    }

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        this.logger.LogInformation("Starting bus");
        CancellationTokenSource cts = new CancellationTokenSource(new TimeSpan(0, 0, 30));
        CancellationToken token = cts.Token;
        await this.busControl.StartAsync(token).ConfigureAwait(false);
    }

    public async Task StopAsync(CancellationToken cancellationToken)
    {
        this.logger.LogInformation("Stopping bus");
        await this.busControl.StopAsync(cancellationToken);
    }
}
