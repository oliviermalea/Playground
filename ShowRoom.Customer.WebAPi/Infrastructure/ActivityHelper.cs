using ShowRoom.Customer.WebApi.Infrastructure.Observability;
using System.Diagnostics;

namespace ShowRoom.Customer.WebApi.Infrastructure;

public static  class ActivityHelper
{
    public readonly static ActivitySource Source = new ActivitySource(Instrumentation.ActivitySourceName);
}
