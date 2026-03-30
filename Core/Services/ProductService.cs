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
  

    public class ProductService : IProducteService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public ProductService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }


        public async Task<bool> CheckNameExists(string name, int id)
        {
            var sql = "SELECT  *  FROM [Products] where name=@name and pd_id!=@id  and is_deleted=0";

            var lastCode = await _uow.Repository.QuerySingleAsync<Product>(sql, new
            {
                name,
                id
            }, CommandType.Text);

            return lastCode != null;
        }

        public async Task<string> GenerateCodeAsync()
        {
            var sql = "SELECT TOP (1)  *  FROM [Products] order by pd_id desc";
            
            var lastCode = await _uow.Repository.QuerySingleAsync<Product>(sql,null,CommandType.Text);
            
            int nextNumber = lastCode == null
                ? 1
                : int.Parse(lastCode.Code.Split('-').Last()) + 1;

            return $"PRD-{nextNumber:D3}";
        }



        public async Task<int> CreateProductAsync(Product dto)
        {
           var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
        
            var result= await _uow.Repository.ExecuteAsync(
                "sp_Product_Insert",
                new
                {
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    dto.Cat_Id,
                    CreatedBy = userId??1,
                    CreatedOn=DateTime.UtcNow
                });
            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} created a new Product with id {Id}", user, result);
            return result;
        }
        public async Task UpdateProductAsync(Product dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_Product_Update",
                new
                {
                    dto.Pd_Id,
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    dto.Cat_Id,
                    UpdatedBy = userId??1,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a Product with id {Id}", user, dto.Pd_Id);
        }

        public async Task DeleteProductAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Product_Delete",
                new
                {
                    id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a Product with id {Id}", user, id);
        }
        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Product_Toggle",
                new
                {
                    id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a Product status with id {Id}", user, id);
        }

        public async Task<IEnumerable<Product>> GetProductAsync()
        {
            return await _uow.Repository.QueryAsync<Product>(
                "sp_Product_GetAll",
                new
                {
                    id=0
                });
        }
        public async Task<IEnumerable<Product>> GetFilteredProductAsync(int id)
        {
            return await _uow.Repository.QueryAsync<Product>(
                "sp_Product_GetAll",
                new
                {
                    id = id
                });
        }
    }

}
