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
    public class LicenseTypeController : ControllerBase
    {
        private readonly ILicenseTypeService _service;

        public LicenseTypeController(ILicenseTypeService service)
        {
            _service = service;
        }
        [HttpGet("search")]
        public async Task<IActionResult> GetSearch(string term)
        {
            var result = await _service.GetLicenseTypeBySearchAsync(term);
            return Ok(ApiResponse<object>.Ok(result));
        }
        [HttpGet("LicenseTypecode")]
        public async Task<IActionResult> GenerateLicenseTypeCodeAsync()
        {
            var result = await _service.GenerateLicenseTypeCodeAsync();
            return Ok(ApiResponse<string>.Ok(result));
        }

        [HttpPost]
        public async Task<IActionResult> CreateLicenseType(CreateLicenseTypeDto dto)
        {
            var id = await _service.CreateLicenseTypeAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }


        [HttpPut]
        public async Task<IActionResult> UpdateLicenseType(UpdateLicenseTypeDto dto)
        {
            await _service.UpdateLicenseTypeAsync(dto);
            return Ok(ApiResponse<string>.Ok("LicenseType updated"));
        }

        [HttpGet]
        public async Task<IActionResult> GetLicenseType()
        {
            var LicenseType = await _service.GetLicenseTypeAsync();
            return Ok(ApiResponse<object>.Ok(LicenseType));
        }
        [HttpGet("product/{id}")]
        public async Task<IActionResult> GetLicenseTypeByProductId(int id)
        {
            var LicenseType = await _service.GetLicenseTypeByProductId(id);
            return Ok(ApiResponse<object>.Ok(LicenseType));
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetLicenseTypeById(int id)
        {
            var LicenseType = await _service.GetLicenseTypeByIdAsync(id);
            return Ok(ApiResponse<object>.Ok(LicenseType));
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteLicenseType(int id)
        {
             await _service.DeleteLicenseTypeAsync(id);
            return Ok(ApiResponse<object>.Ok("LicenseType Deleted"));
        }

        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("LicenseType status updated"));
        }

        [HttpGet("Check")]
        public async Task<IActionResult> CheckName(string name, int id)
        {
            var product = await _service.CheckNameExists(name, id);
            return Ok(ApiResponse<object>.Ok(product));
        }
    }
}
