using MassTransit;
using MediatR;
using ShowRoom.Core.Shared.Messages.CustomerOrders;
using ShowRoom.Core.Shared.Shared;
using ShowRoom.Core.Shared.Models;
using Microsoft.AspNetCore.Mvc;

namespace ShowRoom.Customer.WebApi.Features.Customer.GetCustomer;

public class GetCustomerQueryHandler : IRequestHandler<GetCustomerRequest, Result<GetCustomerResponse>>
{
    protected readonly ILogger<GetCustomerQueryHandler> _logger;
    private readonly IRequestClient<CustomerOrdersRequest> _customerOrdersClient;

    public GetCustomerQueryHandler(
        ILogger<GetCustomerQueryHandler> logger,
        IRequestClient<CustomerOrdersRequest> customerOrdersClient
        )
    {
        _logger = logger;
        this._customerOrdersClient = customerOrdersClient;
    }

    public async Task<Result<GetCustomerResponse>> Handle(GetCustomerRequest request, CancellationToken cancellationToken)
    {
        if (request.IsActive is false)
        {
            var errorMsg = "Current customer doesn't exist";
            _logger.LogError(errorMsg);

            return Result.Failure<GetCustomerResponse>(null, new Error("NotFound", errorMsg));
        }

        var customer = await CustomerFactory.GenerateCustomer(request.CustomerId.Value, request.IsActive, cancellationToken).ConfigureAwait(false);

        // Query next µS for customer orders via mass-transit Request-response (Request-Endpoint-Response)
        var customerOrders = await _customerOrdersClient
            .GetResponse<CustomerOrdersResponse, CustomerOrdersNotFoundResponse>(new CustomerOrdersRequest(Guid.NewGuid(), customer.CustomerId));        

        if (customerOrders.Is(out Response<CustomerOrdersResponse> foundOrders))
        {
            _logger.LogInformation("Some orders were found for cutomer id : {customerId}, quantity : {ordersCount}", customer.CustomerId, foundOrders.Message.Orders.Length);
            customer.Orders.AddRange(foundOrders.Message.Orders);
        }
        else if (customerOrders.Is(out Response<CustomerOrdersNotFoundResponse> notFoundOrders))
        {
            _logger.LogInformation("The customer with id : {customerId} has no orders found.", customer.CustomerId);
        }

        return Result.Success(customer);
    }
}
