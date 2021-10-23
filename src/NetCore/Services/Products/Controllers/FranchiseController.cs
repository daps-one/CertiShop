using System;
using CertiShop.NetCore.Infraestructure.Data.DataContext;
using CertiShop.NetCore.Infraestructure.Data.Repositories;
using CertiShop.NetCore.Infraestructure.Generic.Utils;
using Microsoft.AspNetCore.Mvc;

namespace CertiShop.NetCore.Services.Products.Controllers
{
    [ApiController]
    [Route("api/franchises")]
    public class FranchiseController : ControllerBase
    {
        private readonly IUnitOfWork<BaseDbContext> _unitOfWork;
        private readonly FranchiseRepository _franchiseRepository;

        public FranchiseController(IUnitOfWork<BaseDbContext> unitOfWork)
        {
            _unitOfWork = unitOfWork;
            _franchiseRepository = new FranchiseRepository(_unitOfWork);
        }

        [HttpGet]
        public IActionResult GetFranchises()
        {
            try
            {
                var franchises = _franchiseRepository.GetAll();
                return Ok(franchises);
            }
            catch (Exception)
            {
                // TODO
                return NotFound();
            }
        }
    }
}