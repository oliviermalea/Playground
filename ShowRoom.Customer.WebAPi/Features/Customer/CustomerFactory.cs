[assembly: System.Runtime.CompilerServices.InternalsVisibleTo("ShowRoom.Tests")]
namespace ShowRoom.Customer.WebApi.Features.Customer
{
    using Bogus;
    using ShowRoom.Customer.WebApi.Features.Customer.GetCustomer;

    internal static class CustomerFactory
    {
        internal static async Task<GetCustomerResponse> GenerateCustomer(Guid id, bool? isActive, CancellationToken cancellation = default)
        {
            return await Task.Run(() =>
            {
                var item = new Faker<GetCustomerResponse>()
                    .CustomInstantiator(f => new GetCustomerResponse())
                    .RuleFor(u => u.CustomerId, id)
                    .RuleFor(u => u.IsActive, isActive ?? true)
                    .RuleFor(u => u.FirstName, (f, u) => f.Name.FirstName())
                    .RuleFor(u => u.LastName, (f, u) => f.Name.LastName())
                    .RuleFor(u => u.Email, (f, u) => f.Internet.Email(u.FirstName, u.LastName));

                return item.Generate();
            },
            cancellation
            );
        }
    }
}