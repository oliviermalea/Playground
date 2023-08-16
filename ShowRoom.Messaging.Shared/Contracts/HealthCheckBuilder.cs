namespace ShowRoom.Messaging.Shared.Contracts;

using System;
using System.Reflection;

public static class HealthCheckBuilder
{
    public static dynamic Build() =>
        new
        {
            SentDate = DateTime.Now,
            Service = Assembly.GetEntryAssembly().GetName().Name,
            IsHealthy = true
        };
}
