using ShowRoom.Core.Shared.Models;

namespace ShowRoom.Customer.WebApi.Features.Customer.GetCustomer;

public record GetCustomerResponse    
{
    public  Guid CustomerId { get; set; }
    public bool IsActive { get; set; }
    public string LastName { get; set; }
    public string FirstName { get; set; }
    public string Email { get; set; }
    public List<Order> Orders { get; set; } = new();
}
