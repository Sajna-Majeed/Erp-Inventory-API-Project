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
  

    public class LicenseTypeService : ILicenseTypeService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public LicenseTypeService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }


        public async Task<bool> CheckNameExists(string name, int id)
        {
            var sql = "SELECT  *  FROM [ALF_License_Type] where name=@name and lt_id!=@id  and is_deleted=0";

            var lastCode = await _uow.Repository.QuerySingleAsync<LicenseType>(sql, new
            {
                name,
                id
            }, CommandType.Text);

            return lastCode != null;
        }

        public async Task<string> GenerateLicenseTypeCodeAsync()
        {
            var sql = "SELECT TOP (1)  *  FROM [ALF_License_Type] order by lt_id desc";
            
            var lastCode = await _uow.Repository.QuerySingleAsync<LicenseType>(sql,null,CommandType.Text);
            
            int nextNumber = lastCode == null
                ? 1
                : int.Parse(lastCode.Code.Split('-').Last()) + 1;

            return $"LT-{nextNumber:D3}";
        }



        public async Task<int> CreateLicenseTypeAsync(CreateLicenseTypeDto dto)
        {
           var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
        
            var result= await _uow.Repository.ExecuteAsync(
                "sp_License_Type_Insert",
                new
                {
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    dto.Pd_Id,
                    dto.Unit_Rate,
                    dto.Alf_Rate,
                    dto.S_Rate,
                    dto.P_Rate,
                    CreatedBy = userId??1,
                    CreatedOn=DateTime.UtcNow
                });
            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} created a new License_Type with id {Id}", user, result);
            return result;
        }
        public async Task UpdateLicenseTypeAsync(UpdateLicenseTypeDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_License_Type_Update",
                new
                {
                    dto.Lt_Id,
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    dto.Pd_Id,
                    dto.Unit_Rate,
                    dto.Alf_Rate,
                    dto.S_Rate,
                    dto.P_Rate,
                    UpdatedBy = userId??1,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a LicenseType with id {Id}", user, dto.Lt_Id);
        }

        public async Task DeleteLicenseTypeAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_License_Type_Delete",
                new
                {
                    id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a LicenseType with id {Id}", user, id);
        }
        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_License_Type_Toggle",
                new
                {
                    id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a LicenseType status with id {Id}", user, id);
        }

        public async Task<IEnumerable<LicenseType>> GetLicenseTypeAsync()
        {
            return await _uow.Repository.QueryAsync<LicenseType>(
                "sp_License_Type_GetAll");
        }

        public async Task<IEnumerable<LicenseType>> GetLicenseTypeByProductId(int id)
        {
            return await _uow.Repository.QueryAsync<LicenseType>("sp_LicenseType_GetByProductId", new
            {
               pd_id = id
            });
        }
        public async Task<LicenseType> GetLicenseTypeByIdAsync(int id)
        {
            return await _uow.Repository.QuerySingleAsync<LicenseType>("sp_LicenseType_GetById", new
            {
                LicenseType_id = id
            });
        }

        public async Task<IEnumerable<LicenseType>> GetLicenseTypeBySearchAsync(string term)
        {
            return await _uow.Repository.QueryAsync<LicenseType>("sp_LicenseType_Search", new
                  {
                      SearchTerm= term
                  });
        }
    }

}
