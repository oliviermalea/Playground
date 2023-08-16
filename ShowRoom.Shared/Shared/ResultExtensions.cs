namespace ShowRoom.Core.Shared.Shared;

public static class ResultExtensions
{
    public static Result<T> Ensure<T>(
        this Result<T> result,
        Func<T, bool> predicate,
        Error error)
    {
        if (result.IsFailure)
        { return result; }

        return predicate(result.Value) ?
            result :
            Result.Failure<T>(error);
    }

    public static Result<TOut> Map<TIn, TOut>(
        this Result<TIn> result,
        Func<TIn, TOut> mappinFunc
        )
    {
        return result.IsSuccess ?
            Result.Success(mappinFunc(result.Value)) :
            Result.Failure<TOut>(result.Error);
    }
}
