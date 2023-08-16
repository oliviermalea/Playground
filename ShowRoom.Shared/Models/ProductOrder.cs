namespace ShowRoom.Core.Shared.Models;

public class ProductOrder
{
    public Product Product { get; set; }

    public double Amount { get; set; }

    public int Bargain { get; set; }

    public int Price { get; set; }

    public int FinalPrice { get; set; }
}
