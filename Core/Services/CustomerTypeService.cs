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
  

    public class CustomerTypeService : ICustomerTypeService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public CustomerTypeService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }




        public async Task<string> GenerateCustomerTypeCodeAsync()
        {
            var sql = "SELECT TOP (1)  *  FROM [Customer_Type] order by ct_id desc";
            
            var lastCode = await _uow.Repository.QuerySingleAsync<CustomerType>(sql,null,CommandType.Text);
            
            int nextNumber = lastCode == null
                ? 1
                : int.Parse(lastCode.Code.Split('-').Last()) + 1;

            return $"CT-{nextNumber:D3}";
        }



        public async Task<int> CreateCustomerTypeAsync(CreateCustomerTypeDto dto)
        {
           var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
        
            var result= await _uow.Repository.ExecuteAsync(
                "sp_Customer_Type_Insert",
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
            Log.Information("User {User} created a new customer type with id {Id}", user, result);
            return result;
        }
        public async Task UpdateCustomerTypeAsync(UpdateCustomerTypeDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_Customer_Type_Update",
                new
                {
                    dto.Ct_Id,
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    UpdatedBy = userId,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a customer type with id {Id}", user, dto.Ct_Id);
        }

        public async Task DeleteCustomerTypeAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Customer_Type_Delete",
                new
                {
                    ct_id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a customer type with id {Id}", user,id);
        }

        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Customer_Type_Toggle",
                new
                {
                    ct_id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a customer type status with id {Id}", user, id);
        }
        public async Task<IEnumerable<CustomerType>> GetCustomerTypeAsync()
        {
            return await _uow.Repository.QueryAsync<CustomerType>(
                "sp_Customer_Type_GetAll");
        }
        public async Task<CustomerType> GetCustomerTypeByIdAsync(int id)
        {
            return await _uow.Repository.QuerySingleAsync<CustomerType>("sp_Customer_Type_GetById", new
            {
                ct_id = id
            });
        }

        public async Task<IEnumerable<CustomerType>> GetCustomerTypeBySearchAsync(string term)
        {
            return await _uow.Repository.QueryAsync<CustomerType>("sp_Customer_Type_Search", new
                  {
                      SearchTerm= term
                  });
        }

        public async Task<bool> CheckNameExists(string name, int id)
        {
            var sql = "SELECT  *  FROM [Customer_Type] where name=@name and ct_id!=@id";

            var lastCode = await _uow.Repository.QuerySingleAsync<CustomerType>(sql, new
            {
                name,
                id
            }, CommandType.Text);

            return lastCode != null;
        }
    }

}
