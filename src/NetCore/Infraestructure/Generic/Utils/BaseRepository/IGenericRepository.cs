using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace CertiShop.NetCore.Infraestructure.Generic.Utils.BaseRepository
{
    public interface IGenericRepository<TModel, T>
        where T : class
        where TModel : DbContext
    {
        IEnumerable<T> GetAll(bool isNoTracking = false);
        Task<IEnumerable<T>> GetAllAsync(bool isNoTracking = false);
        T Get(object id, bool isAsNoTracking = false);
        Task<T> GetAsync(object id, bool isAsNoTracking = false);
        T Insert(T entity);
        void InsertRange(params T[] entities);
        Task<T> InsertAsync(T entity);
        Task InsertRangeAsync(params T[] entities);
        T Update(T entity);
        void UpdateRange(params T[] entities);
        T Delete(T entity);
        void DeleteRange(params T[] entities);
    }
}