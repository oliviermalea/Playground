namespace ShowRoom.Customer.WebApi.Features.Customer.GetCustomer
{
    using FluentValidation;

    public class GetCustomerRequestValidator : AbstractValidator<GetCustomerRequest>
    {
        public GetCustomerRequestValidator()
        {
            RuleFor(x => x.CustomerId).NotEmpty();
        }
    }
}
