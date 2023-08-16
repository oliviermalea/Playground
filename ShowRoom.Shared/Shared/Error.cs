namespace ShowRoom.Core.Shared.Shared;

public record struct Error(string ErrorName, string Message)
{
    public static readonly Error None = new(string.Empty, string.Empty);
    public static readonly Error NullValue = new("Error.NullValue", "The specified result value is null.");

    public static implicit operator string(Error error) => error.ErrorName;
}