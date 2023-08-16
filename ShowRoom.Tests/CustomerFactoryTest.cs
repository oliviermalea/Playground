using FluentAssertions;
using ShowRoom.Customer.WebApi.Features.Customer;
using ShowRoom.Customer.WebApi.Features.Customer.GetCustomer;

namespace ShowRoom.Tests;

public class CustomerFactoryTest
{
    [Fact]
    public async Task Should_Generate_Customer()
    {
        // Arrange 
        GetCustomerResponse customer = null;

        // Act
        var id = Guid.NewGuid();
        customer = await CustomerFactory.GenerateCustomer(id, true);

        // Assert
        customer.Should().NotBeNull();
        customer.CustomerId.Should().Be(id);
    }
}