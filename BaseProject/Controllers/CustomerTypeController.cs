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
    public class CustomerTypeController : ControllerBase
    {
        private readonly ICustomerTypeService _service;

        public CustomerTypeController(ICustomerTypeService service)
        {
            _service = service;
        }
        [HttpGet("search")]
        public async Task<IActionResult> GetSearch(string term)
        {
            var result = await _service.GetCustomerTypeBySearchAsync(term);
            return Ok(ApiResponse<object>.Ok(result));
        }
        [HttpGet("CustomerTypecode")]
        public async Task<IActionResult> GenerateCustomerTypeCodeAsync()
        {
            var result = await _service.GenerateCustomerTypeCodeAsync();
            return Ok(ApiResponse<string>.Ok(result));
        }

        [HttpPost]
        public async Task<IActionResult> CreateCustomerType(CreateCustomerTypeDto dto)
        {
            var id = await _service.CreateCustomerTypeAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }


        [HttpPut]
        public async Task<IActionResult> UpdateCustomerType(UpdateCustomerTypeDto dto)
        {
            await _service.UpdateCustomerTypeAsync(dto);
            return Ok(ApiResponse<string>.Ok("CustomerType updated"));
        }

        [HttpGet]
        public async Task<IActionResult> GetCustomerType()
        {
            var CustomerType = await _service.GetCustomerTypeAsync();
            return Ok(ApiResponse<object>.Ok(CustomerType));
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetCustomerTypeById(int id)
        {
            var CustomerType = await _service.GetCustomerTypeByIdAsync(id);
            return Ok(ApiResponse<object>.Ok(CustomerType));
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteCustomerType(int id)
        {
             await _service.DeleteCustomerTypeAsync(id);
            return Ok(ApiResponse<object>.Ok("CustomerType Deleted"));
        }

        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("CustomerType status updated"));
        }

        [HttpGet("Check")]
        public async Task<IActionResult> CheckName(string name, int id)
        {
            var product = await _service.CheckNameExists(name, id);
            return Ok(ApiResponse<object>.Ok(product));
        }

    }
}
