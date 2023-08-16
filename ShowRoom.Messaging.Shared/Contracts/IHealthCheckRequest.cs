namespace ShowRoom.Messaging.Shared.Contracts
{
    using System;

    public interface IHealthCheckRequest
    {
        DateTime SentDate { get; }

        string Service { get; }

        bool IsHealthy { get; }
    }
}
