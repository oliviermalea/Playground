using MassTransit;
using ShowRoom.Core.Shared.Models;

namespace ShowRoom.Core.Shared.Messages.CustomerOrders;

public interface CustomerOrdersResponse :
     CorrelatedBy<Guid>
{
    Order[] Orders { get; }
}
