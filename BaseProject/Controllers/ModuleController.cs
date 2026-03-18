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
    public class ModuleController : ControllerBase
    {
        private readonly IModuleService _service;

        public ModuleController(IModuleService service)
        {
            _service = service;
        }
        [HttpGet("search")]
        public async Task<IActionResult> GetSearch(string term)
        {
            var result = await _service.GetModuleBySearchAsync(term);
            return Ok(ApiResponse<object>.Ok(result));
        }
        [HttpGet("Modulecode")]
        public async Task<IActionResult> GenerateModuleCodeAsync()
        {
            var result = await _service.GenerateModuleCodeAsync();
            return Ok(ApiResponse<string>.Ok(result));
        }

        [HttpPost]
        public async Task<IActionResult> CreateModule(CreateModuleDto dto)
        {
            var id = await _service.CreateModuleAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }


        [HttpPut]
        public async Task<IActionResult> UpdateModule(UpdateModuleDto dto)
        {
            await _service.UpdateModuleAsync(dto);
            return Ok(ApiResponse<string>.Ok("Module updated"));
        }

        [HttpGet]
        public async Task<IActionResult> GetModule()
        {
            var Module = await _service.GetModuleAsync();
            return Ok(ApiResponse<object>.Ok(Module));
        }
        [HttpGet("product/{id}")]
        public async Task<IActionResult> GetModuleByProductId(int id)
        {
            var Module = await _service.GetModuleByProductId(id);
            return Ok(ApiResponse<object>.Ok(Module));
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetModuleById(int id)
        {
            var Module = await _service.GetModuleByIdAsync(id);
            return Ok(ApiResponse<object>.Ok(Module));
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteModule(int id)
        {
             await _service.DeleteModuleAsync(id);
            return Ok(ApiResponse<object>.Ok("Module Deleted"));
        }

        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("Module status updated"));
        }

        [HttpGet("Check")]
        public async Task<IActionResult> CheckName(string name, int id)
        {
            var product = await _service.CheckNameExists(name, id);
            return Ok(ApiResponse<object>.Ok(product));
        }
    }
}
