using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace CertiShop.NetCore.Infraestructure.Generic.Utils.BaseRepository
{
    public class GenericRepository<TContext, TModel> : IGenericRepository<TContext, TModel>
        where TModel : class
        where TContext : DbContext
    {
        protected readonly IUnitOfWork<TContext> _unitOfWork;

        public GenericRepository(IUnitOfWork<TContext> unitOfWork) => _unitOfWork = unitOfWork;

        private void QueryTracking(bool isAsNoTracking)
        {
            _unitOfWork.Context.ChangeTracker.QueryTrackingBehavior = isAsNoTracking ? QueryTrackingBehavior.NoTracking : QueryTrackingBehavior.TrackAll;
        }

        public TModel Delete(TModel entity)
        {
            try
            {
                return _unitOfWork.Context.Set<TModel>().Remove(entity).Entity;
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public TModel Get(object id, bool isAsNoTracking = false)
        {
            try
            {
                QueryTracking(isAsNoTracking);
                return _unitOfWork.Context.Set<TModel>().Find(id);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public IEnumerable<TModel> GetAll(bool isAsNoTracking = false)
        {
            try
            {
                QueryTracking(isAsNoTracking);
                return _unitOfWork.Context.Set<TModel>().ToList();
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public async Task<IEnumerable<TModel>> GetAllAsync(bool isAsNoTracking = false)
        {
            try
            {
                QueryTracking(isAsNoTracking);
                return await _unitOfWork.Context.Set<TModel>().ToListAsync();
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public async Task<TModel> GetAsync(object id, bool isAsNoTracking = false)
        {
            try
            {
                QueryTracking(isAsNoTracking);
            return await _unitOfWork.Context.Set<TModel>().FindAsync(id);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public TModel Insert(TModel entity)
        {
            try
            {
                return _unitOfWork.Context.Set<TModel>().Add(entity).Entity;
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public async Task<TModel> InsertAsync(TModel entity)
        {
            try
            {
                return (await _unitOfWork.Context.Set<TModel>().AddAsync(entity)).Entity;
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public TModel Update(TModel entity)
        {
            try
            {
                return _unitOfWork.Context.Set<TModel>().Update(entity).Entity;
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public void InsertRange(params TModel[] entities)
        {
            try
            {
                _unitOfWork.Context.Set<TModel>().AddRange(entities);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public async Task InsertRangeAsync(params TModel[] entities)
        {
            try
            {
                await _unitOfWork.Context.Set<TModel>().AddRangeAsync(entities);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public void UpdateRange(params TModel[] entities)
        {
            try
            {
                _unitOfWork.Context.Set<TModel>().UpdateRange(entities);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }

        public void DeleteRange(params TModel[] entities)
        {
            try
            {
                _unitOfWork.Context.Set<TModel>().RemoveRange(entities);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                throw;
            }
        }
    }
}