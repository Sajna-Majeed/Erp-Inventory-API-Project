using Core.DTOs;
using Core.Interfaces;
using Core.Shared;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class InvoiceController : ControllerBase
    {
        private readonly IInvoiceService _service;

        public InvoiceController(IInvoiceService service)
        {
            _service = service;
        }

        [HttpPost]
        public async Task<IActionResult> CreateInvoice(CreateInvoiceDto dto)
        {
            var id = await _service.CreateInvoiceAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }


        [HttpPut]
        public async Task<IActionResult> UpdateInvoice(UpdateInvoiceDto dto)
        {
            await _service.UpdateInvoiceAsync(dto);
            return Ok(ApiResponse<string>.Ok("Invoice updated"));
        }

        [HttpGet]
        public async Task<IActionResult> GetInvoiceData()
        {
            var invoices = await _service.GetInvoices();
            return Ok(ApiResponse<object>.Ok(invoices));
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetInvoiceById(int id)
        {
            var invoices = await _service.GetInvoiceById(id);
            return Ok(ApiResponse<object>.Ok(invoices));
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteInvoice(int id)
        {
             await _service.DeleteInvoiceAsync(id);
            return Ok(ApiResponse<object>.Ok("Invoice Deleted"));
        }




    }
}
