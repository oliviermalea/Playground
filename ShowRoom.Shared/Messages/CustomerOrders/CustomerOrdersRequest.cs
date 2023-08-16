using MassTransit;

namespace ShowRoom.Core.Shared.Messages.CustomerOrders;

public record CustomerOrdersRequest(Guid CorrelationId, Guid CustomerId) :
     CorrelatedBy<Guid>
{ }

