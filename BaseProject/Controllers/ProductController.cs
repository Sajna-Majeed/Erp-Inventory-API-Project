using Core.DTOs;
using Core.Entities;
using Core.Interfaces;
using Core.Shared;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Security.Cryptography;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly IProducteService _service;

        public ProductController(IProducteService service)
        {
            _service = service;
        }
       
        [HttpGet("code")]
        public async Task<IActionResult> GenerateCodeAsync()
        {
            var result = await _service.GenerateCodeAsync();
            return Ok(ApiResponse<string>.Ok(result));
        }

        [HttpPost]
        public async Task<IActionResult> CreateProduct(Product dto)
        {
            var id = await _service.CreateProductAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }


        [HttpPut]
        public async Task<IActionResult> UpdateProduct(Product dto)
        {
            await _service.UpdateProductAsync(dto);
            return Ok(ApiResponse<string>.Ok("Product updated"));
        }

        [HttpGet]
        public async Task<IActionResult> GetProduct()
        {
            var LicenseType = await _service.GetProductAsync();
            return Ok(ApiResponse<object>.Ok(LicenseType));
        }
        [HttpGet("filter/{id}")]
        public async Task<IActionResult> GetFilteredProduct(int id)
        {
            var LicenseType = await _service.GetFilteredProductAsync(id);
            return Ok(ApiResponse<object>.Ok(LicenseType));
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteProduct(int id)
        {
             await _service.DeleteProductAsync(id);
            return Ok(ApiResponse<object>.Ok("Product Deleted"));
        }

        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("Product status updated"));
        }

        [HttpGet("Check")]
        public async Task<IActionResult> CheckName(string name, int id)
        {
            var product = await _service.CheckNameExists(name, id);
            return Ok(ApiResponse<object>.Ok(product));
        }
    }
}
