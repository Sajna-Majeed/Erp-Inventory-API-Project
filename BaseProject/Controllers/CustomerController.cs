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
    public class CustomerController : ControllerBase
    {
        private readonly ICustomerService _service;

        public CustomerController(ICustomerService service)
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
        public async Task<IActionResult> Create(CreateCustomerDto dto)
        {
            var id = await _service.CreateCustomerAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }
        
        [HttpPut]
        public async Task<IActionResult> Update(UpdateCustomerDto dto)
        {
            await _service.UpdateCustomerAsync(dto);
            return Ok(ApiResponse<string>.Ok("Customer updated"));
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            await _service.DeleteCustomerAsync(id);
            return Ok(ApiResponse<string>.Ok("Customer deleted"));
        }
      
        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("Customer status updated"));
        }
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var users = await _service.GetCustomerAsync();
            return Ok(ApiResponse<object>.Ok(users));
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var users = await _service.GetCustomerByIdAsync(id);
            return Ok(ApiResponse<object>.Ok(users));
        }
    }

}
