using Core.Common;
using Core.DTOs;
using Core.Interfaces;
using Core.Shared;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    //[Authorize(Roles = "User")]
    [ApiController]
    [Route("api/[controller]")]
    public class CustomPriceController : ControllerBase
    {
        private readonly ICustomPriceService _service;

        public CustomPriceController(ICustomPriceService service)
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
        public async Task<IActionResult> Create(CreateCustomPriceDto dto)
        {
            var id = await _service.CreateCustomPriceAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }
        
        [HttpPut]
        public async Task<IActionResult> Update(UpdateCustomPriceDto dto)
        {
            await _service.UpdateCustomPriceAsync(dto);
            return Ok(ApiResponse<string>.Ok("CustomPrice updated"));
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            await _service.DeleteCustomPriceAsync(id);
            return Ok(ApiResponse<string>.Ok("CustomPrice deleted"));
        }
      
        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("CustomPrice status updated"));
        }
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var users = await _service.GetCustomPriceAsync();
            return Ok(ApiResponse<object>.Ok(users));
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var users = await _service.GetCustomPriceByIdAsync(id);
            return Ok(ApiResponse<object>.Ok(users));
        }
    }

}
