using ShowRoom.Core.Shared.Messages.CustomerOrders;
using System.Diagnostics.Metrics;

namespace ShowRoom.Customer.WebApi.Infrastructure.Observability;

public class OtelMetric
{
    private Counter<int> CustomerQueriedCount { get; }
    private Histogram<long> CustomerItemsRequestDuration { get; }

    public OtelMetric()
    {
        var meter = new Meter(Instrumentation.MeterName);

        CustomerQueriedCount = meter.CreateCounter<int>(name:"customer_requests", unit:"Customer");
        CustomerItemsRequestDuration = meter.CreateHistogram<long>(name:"customer_items_request_duration", unit: "ms");
    }

    public void IncreaseCustomersQueried() => CustomerQueriedCount.Add(1);
    public void RecordCustomerItemsRequestDuration(long duration) => CustomerItemsRequestDuration.Record(duration, 
        tag1: KeyValuePair.Create<string, object?>("Request", nameof(CustomerOrdersRequest)),
        tag2: KeyValuePair.Create<string, object?>("Ellapsed-time", duration));
}
