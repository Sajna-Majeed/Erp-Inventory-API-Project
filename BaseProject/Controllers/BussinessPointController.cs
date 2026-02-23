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
    public class BussinessPointController : ControllerBase
    {
        private readonly IBussinessPointService _service;

        public BussinessPointController(IBussinessPointService service)
        {
            _service = service;
        }

        [HttpPost]
        public async Task<IActionResult> Create(CreateBussinessPointDto dto)
        {
            var id = await _service.CreateBussinessPointAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }
        
        [HttpPut]
        public async Task<IActionResult> Update(UpdateBussinessPointDto dto)
        {
            await _service.UpdateBussinessPointAsync(dto);
            return Ok(ApiResponse<string>.Ok("Bussiness Point updated"));
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            await _service.DeleteBussinessPointAsync(id);
            return Ok(ApiResponse<string>.Ok("Bussiness Point deleted"));
        }
        [HttpGet]
        public async Task<IActionResult> Get()
        {
            var users = await _service.GetBussinessPointAsync();
            return Ok(ApiResponse<object>.Ok(users));
        }
        [HttpGet("{id}")]
        public async Task<IActionResult> GetById(int id)
        {
            var users = await _service.GetBussinessPointByIdAsync(id);
            return Ok(ApiResponse<object>.Ok(users));
        }
    }

}
