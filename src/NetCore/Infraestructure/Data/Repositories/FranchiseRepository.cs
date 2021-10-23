using CertiShop.NetCore.Infraestructure.Common.Entities;
using CertiShop.NetCore.Infraestructure.Data.DataContext;
using CertiShop.NetCore.Infraestructure.Generic.Utils;
using CertiShop.NetCore.Infraestructure.Generic.Utils.BaseRepository;

namespace CertiShop.NetCore.Infraestructure.Data.Repositories
{
    public class FranchiseRepository : GenericRepository<BaseDbContext, Franchise>
    {
        public FranchiseRepository(IUnitOfWork<BaseDbContext> unitOfWork) : base(unitOfWork) { }
    }
}