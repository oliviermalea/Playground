namespace ShowRoom.Customer.WebApi.Infrastructure.ServicesSetup
{
    using MassTransit;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.DependencyInjection;
    using ShowRoom.Messaging.Shared.Extensions;
    using ShowRoom.Messaging.Shared.Contracts;
    using ShowRoom.Messaging.Shared.Consumers;
    using ShowRoom.Core.Shared.Messages.CustomerOrders;

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
            });

            services.AddMassTransitRabbitMq(configuration, (provider, cfg) =>
            {
                cfg.ConfigureEndpoint(provider, nameof(IHealthCheckRequest),
                    (cfgEndpoint, provider) => cfgEndpoint.Consumer<HealthCheckConsumer>(provider));

                cfg.Send<CustomerOrdersRequest>(x =>
                {
                    x.UseCorrelationId(context => context.CorrelationId);
                });
            });
        }
    }
}
