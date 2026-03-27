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
    public class RoleController : ControllerBase
    {
        private readonly IRoleService _service;

        public RoleController(IRoleService service)
        {
            _service = service;
        }
        [HttpPost]
        public async Task<IActionResult> CreateRole(CreateRoleDto dto)
        {
            var id = await _service.CreateRoleAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }


        [HttpPut]
        public async Task<IActionResult> UpdateRole(RoleDto dto)
        {
            await _service.UpdateRoleAsync(dto);
            return Ok(ApiResponse<string>.Ok("Role updated"));
        }

        [HttpGet]
        public async Task<IActionResult> GetRole()
        {
            var Role = await _service.GetRoles();
            return Ok(ApiResponse<object>.Ok(Role));
        }
        [HttpGet("permissions")]
        public async Task<IActionResult> GetPermissions()
        {
            var Role = await _service.GetPermissions();
            
            return Ok(ApiResponse<object>.Ok(Role));
        }
        

       [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteRole(int id)
        {
             await _service.DeleteRoleAsync(id);
            return Ok(ApiResponse<object>.Ok("Role Deleted"));
        }


        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("Role status updated"));
        }
        [HttpGet("Check")]
        public async Task<IActionResult> CheckName(string name, int id)
        {
            var product = await _service.CheckNameExists(name, id);
            return Ok(ApiResponse<object>.Ok(product));
        }
    }
}
