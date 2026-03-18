using Core.DTOs;
using Core.Interfaces;
using Core.Shared;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.IO;

namespace API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class QuoteController : ControllerBase
    {
        private readonly IQuoteService _service;

        public QuoteController(IQuoteService service)
        {
            _service = service;
        }
        [HttpGet("Quotenumber")]
        public async Task<IActionResult> GenerateQuoteNumberAsync()
        {
            var result = await _service.GenerateQuoteNumberAsync();
            return Ok(ApiResponse<string>.Ok(result));
        }



        [HttpPost]
        public async Task<IActionResult> CreateQuote(CreateQuoteDto dto)
        {
            var id = await _service.CreateQuoteAsync(dto);
            return Ok(ApiResponse<int>.Ok(id));
        }


        [HttpPut]
        public async Task<IActionResult> UpdateQuote(UpdateQuoteDto dto)
        {
            await _service.UpdateQuoteAsync(dto);
            return Ok(ApiResponse<string>.Ok("Quote updated"));
        }

        [HttpGet]
        public async Task<IActionResult> GetQuoteData()
        {
            var Quotes = await _service.GetQuotes();
            return Ok(ApiResponse<object>.Ok(Quotes));
        }

        [HttpGet("{id}")]
        public async Task<IActionResult> GetQuoteById(int id)
        {
            var Quotes = await _service.GetQuoteById(id);
            return Ok(ApiResponse<object>.Ok(Quotes));
        }


        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteQuote(int id)
        {
             await _service.DeleteQuoteAsync(id);
            return Ok(ApiResponse<object>.Ok("Quote Deleted"));
        }

        [HttpPost("delete-multiple")]
        public async Task<IActionResult> DeleteMultiple([FromBody] List<int> ids)
        {
            if (ids == null || ids.Count == 0)
                return BadRequest("No ids provided");

            

            foreach (var id in ids)
            {
                var file = await _service.GetFiles(id);
                var filePath = Path.Combine(
                    Directory.GetCurrentDirectory(),
                    "wwwroot",
                    file.File_Path.TrimStart('/')
                );

                if (System.IO.File.Exists(filePath))
                {
                    System.IO.File.Delete(filePath);
                }
            }

            return Ok(new { success = true });
        }


        // 
        [HttpPost("upload")]
        public async Task<IActionResult> UploadFiles([FromForm] List<IFormFile> files)
        {
            if (files == null || files.Count == 0)
                return BadRequest("No files uploaded");

            var uploadPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/uploads");

            if (!Directory.Exists(uploadPath))
                Directory.CreateDirectory(uploadPath);

            var uploadedFiles = new List<object>();

            foreach (var file in files)
            {
                if (file.Length > 0)
                {
                    var fileName = Guid.NewGuid().ToString()+"_" + Path.GetExtension(file.FileName);
                    var filePath = Path.Combine(uploadPath, fileName);

                    using (var stream = new FileStream(filePath, FileMode.Create))
                    {
                        await file.CopyToAsync(stream);
                    }

                    uploadedFiles.Add(new
                    {
                        originalName = file.FileName,
                        savedName = fileName,
                        path = "/uploads/" + fileName
                    });
                }
            }

            return Ok(new
            {
                success = true,
                files = uploadedFiles
            });
        }


    }
}
