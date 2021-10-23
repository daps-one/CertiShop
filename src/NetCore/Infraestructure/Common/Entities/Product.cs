namespace CertiShop.NetCore.Infraestructure.Common.Entities
{
    public class Product
    {
        public int ProductId { get; set; }
        public string Name { get; set; }
        public string Image { get; set; }
        public int UnitPrice { get; set; }
        public string Description { get; set; }
        public int Amount { get; set; }
    }
}