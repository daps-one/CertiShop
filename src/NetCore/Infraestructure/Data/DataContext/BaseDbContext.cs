using CertiShop.NetCore.Infraestructure.Common.Entities;
using CertiShop.NetCore.Infraestructure.Data.EntityConfig;
using Microsoft.EntityFrameworkCore;

namespace CertiShop.NetCore.Infraestructure.Data.DataContext
{
    public class BaseDbContext : DbContext
    {
        public BaseDbContext() { }

        public DbSet<Product> Products { get; set; }
        public DbSet<Franchise> Franchises { get; set; }
        
        public BaseDbContext(DbContextOptions<BaseDbContext> options) : base(options) { }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
        }

        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.ApplyConfiguration(new ProductEntityTypeConfiguration());
            builder.ApplyConfiguration(new FranchiseEntityTypeConfiguration());
        }
    }
}