using System;
using System.Collections.Generic;
using System.Linq;
using CertiShop.NetCore.Infraestructure.Common.Entities;
using CertiShop.NetCore.Infraestructure.Data.DataContext;
using CertiShop.NetCore.Infraestructure.Generic.Utils;
using CertiShop.NetCore.Infraestructure.Generic.Utils.BaseRepository;

namespace CertiShop.NetCore.Infraestructure.Data.Repositories
{
    public class ProductRepository : GenericRepository<BaseDbContext, Product>
    {
        public ProductRepository(IUnitOfWork<BaseDbContext> unitOfWork) : base(unitOfWork) { }

        public IEnumerable<Product> GetAllInStock()
        {
            try
            {
                return _unitOfWork.Context.Products
                    .Where(x => x.Amount > 0);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public Product AddProductToCart(int productId)
        {
            try
            {
                return _unitOfWork.Context.Products
                    .SingleOrDefault(x => x.Amount > 0 && x.ProductId == productId);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }
    }
}