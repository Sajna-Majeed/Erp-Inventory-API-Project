using Core.DTOs;
using Core.Interfaces;
using Core.Shared;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [ApiController]
    [Route("api/auth")]
    public class AuthController : ControllerBase
    {
        private readonly IAuthService _service;

        public AuthController(IAuthService service)
        {
            _service = service;
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login(LoginDto dto)
        {
            var result = await _service.LoginAsync(dto);
            return Ok(ApiResponse<object>.Ok(result));
        }

        [HttpPut("profile")]
        public async Task<IActionResult> UpdateProfile(UserProfile dto)
        {
            await _service.UpdateUserProfile(dto);
            return Ok(ApiResponse<object>.Ok("Profile Updated"));
        }
        [HttpPut("password")]
        public async Task<IActionResult> UpdatePassword(PassWordChange dto)
        {
            await _service.UpdatePassword(dto);
            return Ok(ApiResponse<object>.Ok("Password Updated"));
        }
    }
}
