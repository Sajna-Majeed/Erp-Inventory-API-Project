using Core.DTOs;
using Core.Entities;
using Core.Interfaces;
using Core.Shared;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System.Data;
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



        //[HttpPost]
        //public async Task<IActionResult> CreateQuote(CreateQuoteDto dto)
        //{

        //    var id = await _service.CreateQuoteAsync(dto);
        //    return Ok(ApiResponse<int>.Ok(id));
        //}
        //[HttpPut]
        //public async Task<IActionResult> UpdateQuote(UpdateQuoteDto dto)
        //{
        //    await _service.UpdateQuoteAsync(dto);
        //    return Ok(ApiResponse<string>.Ok("Quote updated"));
        //}

        [HttpPost()]
        public async Task<IActionResult> CreateWithFiles([FromForm] string data,[FromForm] List<IFormFile> files)
        {
            var quote = JsonConvert.DeserializeObject<CreateQuoteDto>(data);
            var id = await _service.CreateQuoteAsync(quote);
            await UploadFiles(files,id,null);
            return Ok(ApiResponse<int>.Ok(id));
        }
        [HttpPut()]
        public async Task<IActionResult> UpdateWithFiles([FromForm] string data, [FromForm] List<IFormFile> files, [FromForm] string deletedFileIds)
        {
            var quote = JsonConvert.DeserializeObject<UpdateQuoteDto>(data);
            var deletedIds = JsonConvert.DeserializeObject<List<int>>(deletedFileIds);
            await _service.UpdateQuoteAsync(quote);
            // 2. Delete removed files
           
            await UploadFiles(files, quote.Q_Id,deletedIds);
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

        [HttpGet("view/{id}")]
        public async Task<IActionResult> GetQuoteViewById(int id)
        {
            var Quotes = await _service.GetQuoteViewById(id);
            return Ok(ApiResponse<object>.Ok(Quotes));
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteQuote(int id)
        {
             await _service.DeleteQuoteAsync(id);
            return Ok(ApiResponse<object>.Ok("Quote Deleted"));
        }



        private async Task<IActionResult> UploadFiles(List<IFormFile> files,int quoteId,List<int>? deletedIds)
        {
            if (files == null || files.Count == 0)
                return BadRequest("No files uploaded");

            var uploadPath = Path.Combine(Directory.GetCurrentDirectory(), "wwwroot/uploads");

            //Delete existing files
            var old_files = await _service.GetFiles(quoteId);
            if (deletedIds != null && deletedIds.Any())
            {
                old_files = old_files
                    .Where(x => deletedIds.Contains(x.Q_File_Id))
                    .ToList();
                foreach (var file in old_files)
                {

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
            }

            //Create directory if not exisitng
            if (!Directory.Exists(uploadPath))
                Directory.CreateDirectory(uploadPath);

            //upload Files
            var uploadedFiles = new List<FileAttchmentsDto>();

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

                    uploadedFiles.Add(new FileAttchmentsDto()
                    {
                        Original_Name = file.FileName,
                        File_Name = fileName,
                        File_Path = "/uploads/" + fileName
                    });
                }



            }
           
            await _service.SaveQuoteFiles(uploadedFiles, quoteId, deletedIds??new List<int>());
            return Ok(new
            {
                success = true,
                files = uploadedFiles
            });
        }


    }
}
