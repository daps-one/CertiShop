using System;
using CertiShop.NetCore.Infraestructure.Data.DataContext;
using CertiShop.NetCore.Infraestructure.Data.Repositories;
using CertiShop.NetCore.Infraestructure.Generic.Utils;
using Microsoft.AspNetCore.Mvc;

namespace CertiShop.NetCore.Services.Products.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ProductController : ControllerBase
    {
        private readonly IUnitOfWork<BaseDbContext> _unitOfWork;
        private readonly ProductRepository _productRepository;

        public ProductController(IUnitOfWork<BaseDbContext> unitOfWork)
        {
            _unitOfWork = unitOfWork;
            _productRepository = new ProductRepository(_unitOfWork);
        }

        [HttpGet]
        public IActionResult GetProducts()
        {
            try
            {
                var products = _productRepository.GetAll(isAsNoTracking: true);
                return Ok(products);
            }
            catch (Exception)
            {
                // TODO: 
                return NotFound();
            }
        }
    }
}