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
  

    public class LicenseModeService : ILicenseModeService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public LicenseModeService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }



        public async Task<bool> CheckNameExists(string name, int id)
        {
            var sql = "SELECT  *  FROM [License_Mode] where name=@name and lm_id!=@id and is_deleted=0";

            var lastCode = await _uow.Repository.QuerySingleAsync<LicenseMode>(sql, new
            {
                name,
                id
            }, CommandType.Text);

            return lastCode != null;
        }
        public async Task<string> GenerateCodeAsync()
        {
            var sql = "SELECT TOP (1)  *  FROM [License_Mode] order by lm_id desc";
            
            var lastCode = await _uow.Repository.QuerySingleAsync<LicenseMode>(sql,null,CommandType.Text);
            
            int nextNumber = lastCode != null
                ? 1
                : int.Parse(lastCode.Code.Split('-').Last()) + 1;

            return $"LM-{nextNumber:D3}";
        }



        public async Task<int> CreateLicenseModeAsync(LicenseMode dto)
        {
           var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
        
            var result= await _uow.Repository.ExecuteAsync(
                "sp_License_Mode_Insert",
                new
                {
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    CreatedBy = userId,
                    CreatedOn=DateTime.UtcNow
                });
            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} created a new license Mode with id {Id}", user, result);
            return result;
        }
        public async Task UpdateLicenseModeAsync(LicenseMode dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_License_Mode_Update",
                new
                {
                    dto.Lm_Id,
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    UpdatedBy = userId,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a license Mode with id {Id}", user, dto.Lm_Id);
        }

        public async Task DeleteLicenseModeAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_License_Mode_Delete",
                new
                {
                   id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a license Mode with id {Id}", user, id);
        }

        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_License_Mode_Toggle",
                new
                {
                    id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a license Mode status with id {Id}", user, id);
        }
        public async Task<IEnumerable<LicenseMode>> GetLicenseModeAsync()
        {
            return await _uow.Repository.QueryAsync<LicenseMode>(
                "sp_License_Mode_GetAll");
        }
        
    }

}
