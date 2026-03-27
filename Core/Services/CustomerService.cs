using Core.DTOs;
using Core.Entities;
using Core.Interfaces;
using Core.Security;
using Dapper;
using Microsoft.AspNetCore.Http;
using Serilog;
using System.Data;
using static System.Net.WebRequestMethods;

namespace Core.Services
{
  

    public class CustomerService : ICustomerService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public CustomerService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }
        public async Task<string> GenerateCodeAsync()
        {
            var sql = "SELECT TOP (1)  *  FROM [Customer] order by customer_id desc";

            var lastCode = await _uow.Repository.QuerySingleAsync<Customer>(sql, null, CommandType.Text);

            int nextNumber = lastCode == null
                ? 1
                : int.Parse(lastCode.Code.Split('-').Last()) + 1;

            return $"C-{nextNumber:D3}";
        }

        public async Task<int> CreateCustomerAsync(CreateCustomerDto dto)
        {
           var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
            if (userId == null)
            {
                throw new UnauthorizedAccessException("User not authenticated");
            }
            var result= await _uow.Repository.ExecuteAsync(
                "sp_Customer_Insert",
                new
                {
                    dto.Code,
                    dto.Customer_Type_Id,
                    dto.Name,
                    dto.Description,
                    dto.Contact_Person,
                    dto.Email,
                    dto.Mobile_Number,
                    dto.AddressLine1,
                    dto.City,
                    dto.Country_Subdivision,
                    dto.Country,
                    dto.Zip_code,
                    CreatedBy = userId,
                    CreatedOn=DateTime.UtcNow
                });
            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} created a new customer with id {Id}", user, result);
            return result;
        }
        public async Task UpdateCustomerAsync(UpdateCustomerDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_Customer_Update",
                new
                {
                    dto.Customer_Id,
                    dto.Code,
                    dto.Customer_Type_Id,
                    dto.Name,
                    dto.Description,
                    dto.Contact_Person,
                    dto.Email,
                    dto.Mobile_Number,
                    dto.AddressLine1,
                    dto.City,
                    dto.Country_Subdivision,
                    dto.Country,
                    dto.Zip_code,
                    UpdatedBy = userId,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a customer with id {Id}", user, dto.Customer_Id);
        }

        public async Task DeleteCustomerAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Customer_Delete",
                new
                {
                    customer_id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a customer with id {Id}", user, id);
        }
        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Customer_Toggle",
                new
                {
                    customer_id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a customer status with id {Id}", user,id);
        }

        public async Task<IEnumerable<Customer>> GetCustomerAsync()
        {
            return await _uow.Repository.QueryAsync<Customer>(
                "sp_Customer_GetAll");
        }
        public async Task<Customer> GetCustomerByIdAsync(int Id)
        {
            return await _uow.Repository.QuerySingleAsync<Customer>("sp_Customer_GetById", new
            {
                customer_id = Id
            });
        }
    }

}
