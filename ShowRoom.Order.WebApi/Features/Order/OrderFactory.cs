namespace ShowRoom.Order.WebApi.Features.Order
{
    using Bogus;
    using ShowRoom.Core.Shared.Models;

    internal static class OrderFactory
    {
        internal static async Task<Order> GenerateOrderAsync(CancellationToken cancellationToken = default)
        {
            var fruit = new[] { "apple", "banana", "orange", "strawberry", "kiwi" };

            return await Task.Run(() =>
            {
                var item = new Faker<Order>()
                .CustomInstantiator(f => new Order())
                .RuleFor(u => u.Id, Guid.NewGuid())
                .RuleFor(o => o.Item, f => f.PickRandom(fruit))
                .RuleFor(o => o.Quantity, f => f.Random.Number(1, 10));

                return item.Generate();
            },
            cancellationToken
            );
        }

        internal static Order GenerateOrder()
        {
            var products = new Bogus.DataSets.Commerce();

            var item = new Faker<Order>()
                .CustomInstantiator(f => new Order())
                .RuleFor(u => u.Id, Guid.NewGuid())
                .RuleFor(o => o.Item, products.ProductName)
                .RuleFor(o => o.Ean, products.Ean13)
                .RuleFor(o => o.Quantity, f => f.Random.Number(1, 10))
                .RuleFor(o => o.CreatedOn, f => f.Date.RecentOffset(60).LocalDateTime);

            return item.Generate();
        }

        internal static List<Order> GenerateManyOrders()
        {
            var qty = new Random().Next(0, 12);
            return Enumerable.Range(1, qty).Select(c => GenerateOrder()).ToList();
        }
    }
}