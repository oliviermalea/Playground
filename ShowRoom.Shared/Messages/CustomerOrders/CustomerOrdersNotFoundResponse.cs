using MassTransit;

namespace ShowRoom.Core.Shared.Messages.CustomerOrders;

public interface CustomerOrdersNotFoundResponse :
     CorrelatedBy<Guid>
{
    Guid CorrelationId { get; }
}
