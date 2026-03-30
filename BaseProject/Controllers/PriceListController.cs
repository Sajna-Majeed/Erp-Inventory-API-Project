
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
    public class PriceListController : ControllerBase
    {
        private readonly IPriceListService _service;

        public PriceListController(IPriceListService service)
        {
            _service = service;
        }
     
        [HttpPost]
        public async Task<IActionResult> Create(PriceListDto dto)
        {
            var id = await _service.CreatePriceListAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }
        
        [HttpPut]
        public async Task<IActionResult> Update(PriceListDto dto)
        {
            await _service.UpdatePriceListAsync(dto);
            return Ok(ApiResponse<string>.Ok("PriceList updated"));
        }
        [HttpDelete("{id}")]
        public async Task<IActionResult> Delete(int id)
        {
            await _service.DeletePriceListAsync(id);
            return Ok(ApiResponse<string>.Ok("PriceList deleted"));
        }
      
        [HttpDelete("Toggle/{id}")]
        public async Task<IActionResult> Togggle(int id)
        {
            await _service.ToggleStatusAsync(id);
            return Ok(ApiResponse<string>.Ok("PriceList status updated"));
        }
        [HttpGet]
        public async Task<IActionResult> GetAllPriceLists()
        {
            var users = await _service.GetPriceListAsync();
            return Ok(ApiResponse<object>.Ok(users));
        }
    }

}
