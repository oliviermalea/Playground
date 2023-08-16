namespace ShowRoom.Core.Shared.Models;

using System;

public class Order
{
    public Guid Id { get; set; }

    public string Item { get; set; }

    public double Quantity { get; set; }

    public string Ean { get; set; }

    public DateTime CreatedOn { get; set; }
}
