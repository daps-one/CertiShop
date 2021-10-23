using System;
using CertiShop.NetCore.Infraestructure.Data.DataContext;
using CertiShop.NetCore.Infraestructure.Data.Repositories;
using CertiShop.NetCore.Infraestructure.Generic.Utils;
using Microsoft.AspNetCore.Mvc;

namespace CertiShop.NetCore.Services.Products.Controllers
{
    [ApiController]
    [Route("api/products")]
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
                var products = _productRepository.GetAllInStock();
                return Ok(products);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                return NotFound();
            }
        }

        [HttpGet("{productId}")]
        public IActionResult GetProduct(int productId)
        {
            try
            {
                var product = _productRepository.Get(productId);
                return Ok(product);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                return NotFound();
            }
        }

        [HttpGet("addToCart/{productId}")]
        public IActionResult AddProductToCart(int productId)
        {
            try
            {
                var product = _productRepository.AddProductToCart(productId);
                return Ok(product);
            }
            catch (Exception)
            {
                // TODO: implementar log de errores.
                return NotFound();
            }
        }
    }
}