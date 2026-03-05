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
    public class ServiceTypeController : ControllerBase
    {
        private readonly IServiceTypeService _service;

        public ServiceTypeController(IServiceTypeService service)
        {
            _service = service;
        }
        [HttpGet("search")]
        public async Task<IActionResult> GetSearch(string term)
        {
            var result = await _service.GetServiceTypeBySearchAsync(term);
            return Ok(ApiResponse<object>.Ok(result));
        }
        [HttpGet("ServiceTypecode")]
        public async Task<IActionResult> GenerateServiceTypeCodeAsync()
        {
            var result = await _service.GenerateServiceTypeCodeAsync();
            return Ok(ApiResponse<string>.Ok(result));
        }

        [HttpPost]
        public async Task<IActionResult> CreateServiceType(CreateServiceTypeDto dto)
        {
            var id = await _service.CreateServiceTypeAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }


        [HttpPut]
        public async Task<IActionResult> UpdateServiceType(UpdateServiceTypeDto dto)
        {
            await _service.UpdateServiceTypeAsync(dto);
            return Ok(ApiResponse<string>.Ok("ServiceType updated"));
        }

        [HttpGet]
        public async Task<IActionResult> GetServiceType()
        {
            var serviceType = await _service.GetServiceTypeAsync();
            return Ok(ApiResponse<object>.Ok(serviceType));
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetServiceTypeById(int id)
        {
            var serviceType = await _service.GetServiceTypeByIdAsync(id);
            return Ok(ApiResponse<object>.Ok(serviceType));
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteServiceType(int id)
        {
             await _service.DeleteServiceTypeAsync(id);
            return Ok(ApiResponse<object>.Ok("ServiceType Deleted"));
        }

        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("ServiceType status updated"));
        }

        [HttpGet("Check")]
        public async Task<IActionResult> CheckName(string name, int id)
        {
            var product = await _service.CheckNameExists(name, id);
            return Ok(ApiResponse<object>.Ok(product));
        }

    }
}
