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
    public class CategoryController : ControllerBase
    {
        private readonly ICategoryService _service;

        public CategoryController(ICategoryService service)
        {
            _service = service;
        }
       
        [HttpGet("code")]
        public async Task<IActionResult> GenerateCodeAsync()
        {
            var result = await _service.GenerateCategoryCodeAsync();
            return Ok(ApiResponse<string>.Ok(result));
        }

        [HttpPost]
        public async Task<IActionResult> CreateCategory(Category dto)
        {
            var id = await _service.CreateCategoryAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }


        [HttpPut]
        public async Task<IActionResult> UpdateCategory(Category dto)
        {
            await _service.UpdateCategoryAsync(dto);
            return Ok(ApiResponse<string>.Ok("Category updated"));
        }

        [HttpGet]
        public async Task<IActionResult> GetCategory()
        {
            var Category = await _service.GetCategoryAsync();
            return Ok(ApiResponse<object>.Ok(Category));
        }

        [HttpGet("filter/{id}")]
        public async Task<IActionResult> GetCategoryBySt(int id)
        {
            var Category = await _service.GetCategoryFilteredAsync(id);
            return Ok(ApiResponse<object>.Ok(Category));
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCategory(int id)
        {
             await _service.DeleteCategoryAsync(id);
            return Ok(ApiResponse<object>.Ok("Category Deleted"));
        }

        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("Category status updated"));
        }



        [HttpGet("Check")]
        public async Task<IActionResult> CheckName(string name,int id)
        {
            var Category = await _service.CheckNameExists(name,id);
            return Ok(ApiResponse<object>.Ok(Category));
        }

    }
}
