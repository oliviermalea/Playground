namespace ShowRoom.Messaging.Shared.Extensions;

using MassTransit;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Serilog;
using System;

public static class MassTransitExtensions
{
    public static RabbitMQConfiguration MessageBrokerSettings { get; set; }

    public static IServiceCollection AddMassTransitRabbitMq(this IServiceCollection services, ConfigurationManager configuration, Action<IServiceProvider, IRabbitMqBusFactoryConfigurator> callback)
    {
        try
        {
            MessageBrokerSettings = configuration.GetSection(nameof(RabbitMQConfiguration)).Get<RabbitMQConfiguration>();

            services.AddSingleton(provider => Bus.Factory.CreateUsingRabbitMq(cfg =>
            {
                cfg.ConfigureRabbitMQ();
                callback(provider, cfg);
            }));

            services.AddSingleton<IPublishEndpoint>(provider => provider.GetRequiredService<IBusControl>());
            services.AddSingleton<ISendEndpointProvider>(provider => provider.GetRequiredService<IBusControl>());
            services.AddSingleton<IBus>(provider => provider.GetRequiredService<IBusControl>());

            services.AddHostedService<MassTransitBusControlService>();
        }
        catch(Exception e)
        {
            Log.Error($"Something went wrong while starting RabbitMq Broker");
            Log.Error($"With following message : {e.Message}");
        }


        return services;
    }

    public static void ConfigureEndpoint(this IRabbitMqBusFactoryConfigurator cfg, IServiceProvider provider, string endpointName, Action<IRabbitMqReceiveEndpointConfigurator, IServiceProvider> cb)
    {
        cfg.ReceiveEndpoint(endpointName,
               cfgEndpoint =>
               {
                   cb(cfgEndpoint, provider);
                   cfgEndpoint.UseMessageRetry(cfgRetry =>
                   {
                       cfgRetry.Interval(3, TimeSpan.FromSeconds(5));
                   });
               });
    }

    private static void ConfigureRabbitMQ(this IRabbitMqBusFactoryConfigurator cfg)
    {
        cfg.Host(new Uri(uriString: $"rabbitmq://{MessageBrokerSettings.Host}/{MessageBrokerSettings.VirtualHost}"),
            h =>
            {
                h.Username(MessageBrokerSettings.UserName);
                h.Password(MessageBrokerSettings.Password);
                h.Heartbeat(10);
            });
    }  
}
