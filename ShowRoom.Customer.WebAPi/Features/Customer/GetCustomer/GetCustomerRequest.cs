using MediatR;
using ShowRoom.Core.Shared.Shared;

namespace ShowRoom.Customer.WebApi.Features.Customer.GetCustomer;

public record struct GetCustomerRequest(Guid? CustomerId = null, bool? IsActive = true) : IRequest<Result<GetCustomerResponse>>;



