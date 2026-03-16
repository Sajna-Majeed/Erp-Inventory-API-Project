using Core.DTOs;
using Core.Entities;
using Core.Interfaces;
using Core.Security;
using Dapper;
using Microsoft.AspNetCore.Http;
using Serilog;
using System.Data;

namespace Core.Services
{
  

    public class CustomPriceService : ICustomPriceService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public CustomPriceService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }
        public async Task<string> GenerateCodeAsync()
        {
            var sql = "SELECT TOP (1)  *  FROM [Custom_Price] order by custom_prod_id desc";

            var lastCode = await _uow.Repository.QuerySingleAsync<Customer>(sql, null, CommandType.Text);

            int nextNumber = lastCode == null
                ? 1
                : int.Parse(lastCode.Code.Split('-').Last()) + 1;

            return $"CP-{nextNumber:D3}";
        }
        public async Task<int> CreateCustomPriceAsync(CreateCustomPriceDto dto)
        {
           var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
        
            var result= await _uow.Repository.ExecuteAsync(
                "sp_Custom_Price_Insert",
                new
                {
                    dto.Code,
                    dto.Customer_Id,
                    dto.St_Id,
                    dto.Pd_Id,
                    dto.Module_Id,
                    dto.Unit_Price,
                    CreatedBy = userId,
                    CreatedOn=DateTime.UtcNow
                });
            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} created a new custom product price with id {Id}", user, result);
            return result;
        }
        public async Task UpdateCustomPriceAsync(UpdateCustomPriceDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_Custom_Price_Update",
                new
                {
                    dto.Code,
                    dto.Custom_Prod_Id,
                    dto.Customer_Id,
                    dto.St_Id,
                    dto.Pd_Id,
                    dto.Module_Id,
                    dto.Unit_Price,
                    UpdatedBy = userId,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a custom product price with id {Id}", user, dto.Custom_Prod_Id);
        }

        public async Task DeleteCustomPriceAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Custom_Price_Delete",
                new
                {
                    id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a custom product price  with id {Id}", user, id);
        }
        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Custom_Price_Toggle",
                new
                {
                     id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a custom product price status with id {Id}", user, id);
        }

        public async Task<IEnumerable<CustomPriceDto>> GetCustomPriceAsync()
        {
            return await _uow.Repository.QueryAsync<CustomPriceDto>(
                "sp_Custom_Price_GetAll");
        }
        public async Task<CustomPrice> GetCustomPriceByIdAsync(int Id)
        {
            return await _uow.Repository.QuerySingleAsync<CustomPrice>("sp_Custom_Price_GetById", new
            {
                 Id
            });
        }
    }

}
