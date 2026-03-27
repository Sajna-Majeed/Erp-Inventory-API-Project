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
  

    public class ModuleService : IModuleService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public ModuleService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }


        public async Task<bool> CheckNameExists(string name, int id)
        {
            var sql = "SELECT  *  FROM [Module] where name=@name and module_id!=@id  and is_deleted=0";

            var lastCode = await _uow.Repository.QuerySingleAsync<Module>(sql, new
            {
                name,
                id
            }, CommandType.Text);

            return lastCode != null;
        }

        public async Task<string> GenerateModuleCodeAsync()
        {
            var sql = "SELECT TOP (1)  *  FROM [Module] order by module_id desc";
            
            var lastCode = await _uow.Repository.QuerySingleAsync<Module>(sql,null,CommandType.Text);
            
            int nextNumber = lastCode == null
                ? 1
                : int.Parse(lastCode.Code.Split('-').Last()) + 1;

            return $"M-{nextNumber:D3}";
        }



        public async Task<int> CreateModuleAsync(CreateModuleDto dto)
        {
           var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
        
            var result= await _uow.Repository.ExecuteAsync(
                "sp_Module_Insert",
                new
                {
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    dto.Product_Id,
                    CreatedBy = userId??1,
                    CreatedOn=DateTime.UtcNow
                });
            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} created a new module with id {Id}", user, result);
            return result;
        }
        public async Task UpdateModuleAsync(UpdateModuleDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_Module_Update",
                new
                {
                    dto.Module_Id,
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    dto.Product_Id,
                    UpdatedBy = userId??1,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a module with id {Id}", user, dto.Module_Id);
        }

        public async Task DeleteModuleAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Module_Delete",
                new
                {
                    module_id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a module with id {Id}", user, id);
        }
        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Module_Toggle",
                new
                {
                    module_id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a module status with id {Id}", user, id);
        }

        public async Task<IEnumerable<Module>> GetModuleAsync()
        {
            return await _uow.Repository.QueryAsync<Module>(
                "sp_Module_GetAll");
        }

        public async Task<IEnumerable<Module>> GetModuleByProductId(int id)
        {
            return await _uow.Repository.QueryAsync<Module>("sp_Module_GetByProductId", new
            {
               pd_id = id
            });
        }
        public async Task<Module> GetModuleByIdAsync(int id)
        {
            return await _uow.Repository.QuerySingleAsync<Module>("sp_Module_GetById", new
            {
                module_id = id
            });
        }

        public async Task<IEnumerable<Module>> GetModuleBySearchAsync(string term)
        {
            return await _uow.Repository.QueryAsync<Module>("sp_Module_Search", new
                  {
                      SearchTerm= term
                  });
        }
    }

}
