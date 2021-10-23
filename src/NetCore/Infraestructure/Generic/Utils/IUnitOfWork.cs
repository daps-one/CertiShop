using System;

namespace CertiShop.NetCore.Infraestructure.Generic.Utils
{
    public interface IUnitOfWork<T> : IDisposable
    {
        T Context { get; }
        void Commit();
        void Save();
        void Rollback();
        void CreateTransaction();
    }
}