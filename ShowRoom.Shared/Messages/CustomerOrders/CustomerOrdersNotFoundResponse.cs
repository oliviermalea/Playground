using MassTransit;

namespace ShowRoom.Core.Shared.Messages.CustomerOrders;

public record CustomerOrdersNotFoundResponse(Guid CorrelationId) :
     CorrelatedBy<Guid>
{
}
