using CertiShop.NetCore.Infraestructure.Common.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace CertiShop.NetCore.Infraestructure.Data.EntityConfig
{
    public class FranchiseEntityTypeConfiguration : IEntityTypeConfiguration<Franchise>
    {
        public void Configure(EntityTypeBuilder<Franchise> builder)
        {
            builder.ToTable("Franchise");
            builder.HasKey(x => x.FranchiseId);
        }
    }
}