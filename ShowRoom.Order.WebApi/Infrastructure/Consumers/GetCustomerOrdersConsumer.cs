namespace ShowRoom.Order.WebApi.Infrastructure.Consumers
{
    using Ardalis.GuardClauses;
    using MassTransit;
    using ShowRoom.Order.WebApi.Features.Order;
    using System.Diagnostics.Metrics;
    using ShowRoom.Order.WebApi.Infrastructure.Observability;
    using System.Diagnostics;
    using System.Collections.Generic;
    using ShowRoom.Core.Shared.Messages.CustomerOrders;
    using ShowRoom.Core.Shared.Models;

    public class GetCustomerOrdersConsumer : IConsumer<CustomerOrdersRequest>
    {
        public readonly ILogger<GetCustomerOrdersConsumer> logger;

        public GetCustomerOrdersConsumer
            (
                ILogger<GetCustomerOrdersConsumer> logger
            )
        {
            this.logger = logger;
        }

        public async Task Consume(ConsumeContext<CustomerOrdersRequest> context)
        {
            Guard.Against.Null(context, nameof(context));
            Guard.Against.Null(context.Message, nameof(context.Message));

            var activityConsumer = nameof(CustomerOrdersRequest);
            var meter = new Meter(Instrumentation.MeterName);

            var counter = meter.CreateCounter<int>("compute_requests");
            var histogram = meter.CreateHistogram<float>("request_duration", unit: "ms");
            meter.CreateObservableGauge("ThreadCount", () => new[] { new Measurement<int>(ThreadPool.ThreadCount) });
            // Measure the number of requests
            counter.Add(1, KeyValuePair.Create<string, object?>("name", nameof(CustomerOrdersRequest)));
            logger.LogInformation("Received {request} with following content : {content}", nameof(CustomerOrdersRequest), context.Message?.CustomerId);

            CustomerOrdersRequest? request = context.Message;
            List<Order> customerOrders = new();

            var stopwatch = Stopwatch.StartNew();

            using (Activity activity = ActivityHelper.Source.StartActivity(activityConsumer, ActivityKind.Server))
            {
                activity?.AddTag("Query", nameof(CustomerOrdersRequest));
                activity?.AddBaggage("Context", nameof(CustomerOrdersRequest));                

                customerOrders = OrderFactory.GenerateManyOrders();
            }

            histogram.Record(stopwatch.ElapsedMilliseconds,
                tag: KeyValuePair.Create<string, object?>("response", nameof(CustomerOrdersRequest)));

            // Case of null list result returned by query, ther it's a factory with fake data, so it always have value
            if (customerOrders == null || !customerOrders.Any())
            {
                logger.LogInformation("No order will be return to requester for customer id : {CustomerId}.", request.CustomerId);
                await context.RespondAsync<CustomerOrdersNotFoundResponse>(new
                {
                }).ConfigureAwait(false);
            }
            else
            {
                logger.LogInformation("{ordersCount} order(s) will be returned to requester for customer id : {customerId}.", customerOrders.Count, request.CustomerId);
                await context.RespondAsync<CustomerOrdersResponse>(new
                {
                    orders = customerOrders,
                }).ConfigureAwait(false);
            }
        }
    }
}
