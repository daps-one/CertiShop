using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using CertiShop.NetCore.Infraestructure.Data.DataContext;
using CertiShop.NetCore.Infraestructure.Generic.Utils;

namespace CertiShop.NetCore.Infraestructure.Configuration.Middlewares
{
    public static class SqlServerServiceCollectionExtensions
    {
        public static IServiceCollection AddSqlServerContext(this IServiceCollection services)
        {
            services.AddDbContext<BaseDbContext>(options => options.UseSqlServer(@"Server=LAPTOP-AD26JOGF\SQLEXPRESS; Database=Shop; User Id=sa; Password=1234567890;"));
            return services;
        }

        public static IServiceCollection AddUnitOfWork(this IServiceCollection services)
        {
            services.AddScoped(typeof(IUnitOfWork<>), typeof(UnitOfWork<>));
            return services;
        }
    }
}