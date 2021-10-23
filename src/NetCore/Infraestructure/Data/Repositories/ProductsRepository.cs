using CertiShop.NetCore.Infraestructure.Common.Entities;
using CertiShop.NetCore.Infraestructure.Data.DataContext;
using CertiShop.NetCore.Infraestructure.Generic.Utils;
using CertiShop.NetCore.Infraestructure.Generic.Utils.BaseRepository;

namespace CertiShop.NetCore.Infraestructure.Data.Repositories
{
    public class ProductRepository : GenericRepository<BaseDbContext, Product>
    {
        public ProductRepository(IUnitOfWork<BaseDbContext> unitOfWork) : base(unitOfWork) { }
    }
}