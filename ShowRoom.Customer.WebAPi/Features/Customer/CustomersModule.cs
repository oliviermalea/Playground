using Carter;
using MediatR;
using ShowRoom.Customer.WebApi.Features.Customer.GetCustomer;

namespace ShowRoom.Customer.WebApi.Features.Customer;

public class CustomersModule : CarterModule
{
    ////private HostString host;
    ////private string httpString;
    const string baseRoute = "/api/customers";

    public CustomersModule() : base(baseRoute)
    {
        this.IncludeInOpenApi();

        this.Before = context =>
        {
            ////host = context.HttpContext.Request.Host;
            ////httpString = context.HttpContext.Request.IsHttps ? "https" : "http";
            var logger = context.HttpContext.RequestServices.GetRequiredService<ILogger<CustomersModule>>();
            logger.LogDebug("Before");
            return null;
        };

        this.After = context =>
        {
            var logger = context.HttpContext.RequestServices.GetRequiredService<ILogger<CustomersModule>>();
            logger.LogDebug("After");
        };
    }

    public override void AddRoutes(IEndpointRouteBuilder app)
    {
        app.MapGet("/", async ([AsParameters] GetCustomerRequest request, ILogger<CustomersModule> logger, IMediator mediator) =>
        {
            request.CustomerId ??= Guid.NewGuid();

            var result = await mediator.Send(request);

            logger.LogInformation("Response value: {Value}", result.Value);

            if (result.Value is null)
                return Results.Empty;

            return Results.Ok(result.Value);
        });
    }
}
