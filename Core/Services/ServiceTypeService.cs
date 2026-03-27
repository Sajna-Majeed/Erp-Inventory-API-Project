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
  

    public class ServiceTypeService : IServiceTypeService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public ServiceTypeService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }



        public async Task<bool> CheckNameExists(string name, int id)
        {
            var sql = "SELECT  *  FROM [Service_Type] where name=@name and st_id!=@id and is_deleted=0";

            var lastCode = await _uow.Repository.QuerySingleAsync<ServiceType>(sql, new
            {
                name,
                id
            }, CommandType.Text);

            return lastCode != null;
        }
        public async Task<string> GenerateServiceTypeCodeAsync()
        {
            var sql = "SELECT TOP (1)  *  FROM [Service_Type] order by st_id desc";
            
            var lastCode = await _uow.Repository.QuerySingleAsync<ServiceType>(sql,null,CommandType.Text);
            
            int nextNumber = lastCode == null
                ? 1
                : int.Parse(lastCode.Code.Split('-').Last()) + 1;

            return $"ST-{nextNumber:D3}";
        }



        public async Task<int> CreateServiceTypeAsync(CreateServiceTypeDto dto)
        {
           var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
        
            var result= await _uow.Repository.ExecuteAsync(
                "sp_Service_Type_Insert",
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
            Log.Information("User {User} created a new service type with id {Id}", user, result);
            return result;
        }
        public async Task UpdateServiceTypeAsync(UpdateServiceTypeDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_Service_Type_Update",
                new
                {
                    dto.St_Id,
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    UpdatedBy = userId,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a service type with id {Id}", user, dto.St_Id);
        }

        public async Task DeleteServiceTypeAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Service_Type_Delete",
                new
                {
                    st_id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a service type with id {Id}", user, id);
        }

        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Service_Type_Toggle",
                new
                {
                    st_id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a service type status with id {Id}", user, id);
        }
        public async Task<IEnumerable<ServiceType>> GetServiceTypeAsync()
        {
            return await _uow.Repository.QueryAsync<ServiceType>(
                "sp_Service_Type_GetAll");
        }
        public async Task<ServiceType> GetServiceTypeByIdAsync(int id)
        {
            return await _uow.Repository.QuerySingleAsync<ServiceType>("sp_Service_Type_GetById", new
            {
                st_id = id
            });
        }

        public async Task<IEnumerable<ServiceType>> GetServiceTypeBySearchAsync(string term)
        {
            return await _uow.Repository.QueryAsync<ServiceType>("sp_ServiceType_Search", new
                  {
                      SearchTerm= term
                  });
        }
    }

}
