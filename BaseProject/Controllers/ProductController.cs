using Core.DTOs;
using Core.Entities;
using Core.Interfaces;
using Core.Shared;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly IProductService _service;

        public ProductController(IProductService service)
        {
            _service = service;
        }
        [HttpGet("search")]
        public async Task<IActionResult> GetSearch(string term)
        {
            var result = await _service.GetProductBySearchAsync(term);
            return Ok(ApiResponse<object>.Ok(result));
        }
        [HttpGet("productcode")]
        public async Task<IActionResult> GenerateProductCodeAsync()
        {
            var result = await _service.GenerateProductCodeAsync();
            return Ok(ApiResponse<string>.Ok(result));
        }

        [HttpPost]
        public async Task<IActionResult> CreateProduct(CreateProductDto dto)
        {
            var id = await _service.CreateProductAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }


        [HttpPut]
        public async Task<IActionResult> UpdateProduct(UpdateProductDto dto)
        {
            await _service.UpdateProductAsync(dto);
            return Ok(ApiResponse<string>.Ok("Product updated"));
        }

        [HttpGet]
        public async Task<IActionResult> GetProduct()
        {
            var product = await _service.GetProductAsync();
            return Ok(ApiResponse<object>.Ok(product));
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetProductById(int id)
        {
            var product = await _service.GetProductByIdAsync(id);
            return Ok(ApiResponse<object>.Ok(product));
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


        [HttpGet("uom")]
        public async Task<IActionResult> GetUOM()
        {
            var product = await _service.GetUomAsync();
            return Ok(ApiResponse<object>.Ok(product));
        }

        [HttpGet("Check")]
        public async Task<IActionResult> CheckName(string name,int id)
        {
            var product = await _service.CheckNameExists(name,id);
            return Ok(ApiResponse<object>.Ok(product));
        }

    }
}
