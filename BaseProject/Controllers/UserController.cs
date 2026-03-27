using Core.DTOs;
using Core.Interfaces;
using Core.Shared;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    //[Authorize(Roles = "Admin")]
    [ApiController]
    [Route("api/users")]
    public class UsersController : ControllerBase
    {
        private readonly IUserService _service;

        public UsersController(IUserService service)
        {
            _service = service;
        }

        [HttpPost]
        public async Task<IActionResult> Create(CreateUserDto dto)
        {
            var id = await _service.CreateUserAsync(dto);
            return Ok(ApiResponse<int>.Ok(id,"New User CreatedSuccessfully"));
        }
        
        [HttpPut]
        public async Task<IActionResult> Update(UpdateUserDto dto)
        {
            await _service.UpdateUserAsync(dto);
            return Ok(ApiResponse<string>.Ok("User updated"));
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            await _service.DeleteUserAsync(id);
            return Ok(ApiResponse<string>.Ok("User deleted"));
        }
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var users = await _service.GetUsersAsync();
            return Ok(ApiResponse<object>.Ok(users));
        }
        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("User status updated"));
        }
        [HttpGet("Check")]
        public async Task<IActionResult> CheckName(string name, int id)
        {
            var product = await _service.CheckNameExists(name, id);
            return Ok(ApiResponse<object>.Ok(product));
        }
    }

}
