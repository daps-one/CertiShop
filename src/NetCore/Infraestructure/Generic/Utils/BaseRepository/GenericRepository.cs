using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace CertiShop.NetCore.Infraestructure.Generic.Utils.BaseRepository
{
    public class GenericRepository<TModel, T> : IGenericRepository<TModel, T>
        where T : class
        where TModel : DbContext
    {
        private readonly IUnitOfWork<TModel> _unitOfWork;

        public GenericRepository(IUnitOfWork<TModel> unitOfWork) => _unitOfWork = unitOfWork;

        private void QueryTracking(bool isAsNoTracking)
        {
            _unitOfWork.Context.ChangeTracker.QueryTrackingBehavior = isAsNoTracking ? QueryTrackingBehavior.NoTracking : QueryTrackingBehavior.TrackAll;
        }

        public T Delete(T entity)
        {
            try
            {
                return _unitOfWork.Context.Set<T>().Remove(entity).Entity;
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public T Get(object id, bool isAsNoTracking = false)
        {
            try
            {
                QueryTracking(isAsNoTracking);
                return _unitOfWork.Context.Set<T>().Find(id);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public IEnumerable<T> GetAll(bool isAsNoTracking = false)
        {
            try
            {
                QueryTracking(isAsNoTracking);
                return _unitOfWork.Context.Set<T>().ToList();
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public async Task<IEnumerable<T>> GetAllAsync(bool isAsNoTracking = false)
        {
            try
            {
                QueryTracking(isAsNoTracking);
                return await _unitOfWork.Context.Set<T>().ToListAsync();
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public async Task<T> GetAsync(object id, bool isAsNoTracking = false)
        {
            try
            {
                QueryTracking(isAsNoTracking);
            return await _unitOfWork.Context.Set<T>().FindAsync(id);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public T Insert(T entity)
        {
            try
            {
                return _unitOfWork.Context.Set<T>().Add(entity).Entity;
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public async Task<T> InsertAsync(T entity)
        {
            try
            {
                return (await _unitOfWork.Context.Set<T>().AddAsync(entity)).Entity;
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public T Update(T entity)
        {
            try
            {
                return _unitOfWork.Context.Set<T>().Update(entity).Entity;
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public void InsertRange(params T[] entities)
        {
            try
            {
                _unitOfWork.Context.Set<T>().AddRange(entities);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public async Task InsertRangeAsync(params T[] entities)
        {
            try
            {
                await _unitOfWork.Context.Set<T>().AddRangeAsync(entities);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public void UpdateRange(params T[] entities)
        {
            try
            {
                _unitOfWork.Context.Set<T>().UpdateRange(entities);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public void DeleteRange(params T[] entities)
        {
            try
            {
                _unitOfWork.Context.Set<T>().RemoveRange(entities);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }
    }
}