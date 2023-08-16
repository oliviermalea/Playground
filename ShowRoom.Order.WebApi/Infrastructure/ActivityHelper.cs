using ShowRoom.Order.WebApi.Infrastructure.Observability;
using System.Diagnostics;

namespace ShowRoom.Order.WebApi.Infrastructure;

public static class ActivityHelper
{
    public readonly static ActivitySource Source = new ActivitySource(Instrumentation.ActivitySourceName);
}
