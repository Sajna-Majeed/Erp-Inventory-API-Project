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
    public class LicenseModeController : ControllerBase
    {
        private readonly ILicenseModeService _service;

        public LicenseModeController(ILicenseModeService service)
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
        public async Task<IActionResult> CreateServiceMode(LicenseMode dto)
        {
            var id = await _service.CreateLicenseModeAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }


        [HttpPut]
        public async Task<IActionResult> UpdateServiceMode(LicenseMode dto)
        {
            await _service.UpdateLicenseModeAsync(dto);
            return Ok(ApiResponse<string>.Ok("LicenseMode updated"));
        }

        [HttpGet]
        public async Task<IActionResult> GetServiceMode()
        {
            var serviceMode = await _service.GetLicenseModeAsync();
            return Ok(ApiResponse<object>.Ok(serviceMode));
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteServiceMode(int id)
        {
             await _service.DeleteLicenseModeAsync(id);
            return Ok(ApiResponse<object>.Ok("LicenseMode Deleted"));
        }

        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("LicenseMode status updated"));
        }

        [HttpGet("Check")]
        public async Task<IActionResult> CheckName(string name, int id)
        {
            var product = await _service.CheckNameExists(name, id);
            return Ok(ApiResponse<object>.Ok(product));
        }

    }
}
