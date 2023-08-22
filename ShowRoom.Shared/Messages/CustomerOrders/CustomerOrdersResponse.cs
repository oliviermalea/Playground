using MassTransit;
using ShowRoom.Core.Shared.Models;

namespace ShowRoom.Core.Shared.Messages.CustomerOrders;

public record CustomerOrdersResponse(Guid CorrelationId, Order[] Orders) :
     CorrelatedBy<Guid>
{
}
