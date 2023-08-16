namespace ShowRoom.Core.Shared.Shared;

public class Result
{
    protected internal Result(bool isSuccess, Error error)
    {
        if (isSuccess && error != Error.None)
        {
            throw new InvalidOperationException();
        }

        if (!isSuccess && error == Error.None)
        {
            throw new InvalidOperationException();
        }

        IsSuccess = isSuccess;
        Error = error;
        Errors = new[] { error };
    }

    protected internal Result(bool isSuccess, Error[] errors)
    {
        IsSuccess = isSuccess;
        Errors = errors;
    }

    public bool IsSuccess { get; }

    public bool IsFailure => !IsSuccess;

    public Error Error { get; }

    public Error[] Errors { get; }

    public static Result Success() => new(true, Error.None);

    public static Result<TValue> Success<TValue>(TValue value) =>
        new(value, true, Error.None);

    public static Result<TValue> Failure<TValue>(TValue value, Error error) =>
        new(value, false, error);

    public static Result Failure(Error error) => new(false, error);

    public static Result Failure(Error[] errors) => new(false, errors);

    public static Result<TValue> Failure<TValue>(Error error) => new(default, false, error);

    public static Result<TValue> Failure<TValue>(Error[] errors) => new(default, false, errors);

    public static Result Create(bool isSuccess, Error error) => new(isSuccess, error);

    public static Result<TValue> Create<TValue>(TValue? value) =>
        value is not null ? Success(value) : Failure<TValue>(Error.NullValue);

    public static Result<TValue> Ensure<TValue>(TValue value, Func<TValue, bool> predicate, Error error)
    {
        return predicate(value) ?
            Success(value) :
            Failure<TValue>(error);
    }

    public static Result<TValue> Combine<TValue>(params Result<TValue>[] results)
    {
        if (results.Any(r => r.IsFailure))
        {
            return Failure<TValue>(
                results.SelectMany(r => r.Errors).Distinct().ToArray()
            );
        }

        return Success(results[0].Value);
    }
}