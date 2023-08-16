namespace ShowRoom.Order.WebApi.Infrastructure.ServicesSetup;

using MassTransit;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using ShowRoom.Core.Shared.Messages.CustomerOrders;
using ShowRoom.Messaging.Shared.Consumers;
using ShowRoom.Messaging.Shared.Contracts;
using ShowRoom.Messaging.Shared.Extensions;
using ShowRoom.Order.WebApi.Infrastructure.Consumers;

public static class MassTransitRabbitMqExtensions
{
    public static void AddMTRabbitMqBroker(this IServiceCollection services, ConfigurationManager configuration)
    {
        services.AddMassTransit(m =>
        {
            m.SetKebabCaseEndpointNameFormatter();
            m.AddRequestClient<IHealthCheckRequest>();
            m.AddRequestClient<CustomerOrdersRequest>();
            m.AddConsumer<HealthCheckConsumer>();
            m.AddConsumer<GetCustomerOrdersConsumer>();
        });

        services.AddMassTransitRabbitMq(configuration, (provider, cfg) =>
        {
            cfg.ConfigureEndpoint(provider, nameof(IHealthCheckRequest),
                (cfgEndpoint, provider) => cfgEndpoint.Consumer<HealthCheckConsumer>(provider));
            cfg.ConfigureEndpoint(provider, nameof(CustomerOrdersRequest),
                (cfgEndpoint, provider) => cfgEndpoint.Consumer<GetCustomerOrdersConsumer>(provider));

            cfg.Send<CustomerOrdersResponse>(x =>
            {
                x.UseCorrelationId(context => context.CorrelationId);
            });
        });
    }
}
