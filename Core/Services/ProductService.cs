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
  

    public class ProductService : IProductService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public ProductService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }




        public async Task<string> GenerateProductCodeAsync()
        {
            var sql = "SELECT TOP (1)  *  FROM [Product] order by prod_id desc";
            
            var lastCode = await _uow.Repository.QuerySingleAsync<Product>(sql,null,CommandType.Text);
            
            int nextNumber = lastCode == null
                ? 1
                : int.Parse(lastCode.Code.Split('-').Last()) + 1;

            return $"PRD-{nextNumber:D3}";
        }

        public async Task<bool> CheckNameExists(string name,int id)
        {
            var sql = "SELECT  *  FROM [Product] where name=@name and prod_id!=@id and is_deleted=0";

            var lastCode = await _uow.Repository.QuerySingleAsync<Product>(sql, new
            {
               name,
               id
            }, CommandType.Text);

            return lastCode != null ;
        }

        public async Task<int> CreateProductAsync(CreateProductDto dto)
        {
           var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
        
            var result= await _uow.Repository.ExecuteAsync(
                "sp_Product_Insert",
                new
                {
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    dto.Uom_Id,
                    dto.Unit_Price,
                    dto.Tax_Rate,
                    CreatedBy = userId,
                    CreatedOn=DateTime.UtcNow
                });
            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} created a new  product  with id {Id}", user, result);
            return result;
        }
        public async Task UpdateProductAsync(UpdateProductDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_Product_Update",
                new
                {
                    dto.Prod_Id,
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    dto.Uom_Id,
                    dto.Unit_Price,
                    dto.Tax_Rate,
                    UpdatedBy = userId,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a product with id {Id}", user, dto.Prod_Id);
        }

        public async Task DeleteProductAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Product_Delete",
                new
                {
                    prod_Id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a product with id {Id}", user, id);
        }

        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Product_Toggle",
                new
                {
                    prod_Id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a product status with id {Id}", user, id);
        }
     
        public async Task<IEnumerable<UnitOfMeasure>> GetUomAsync()
        {
            return await _uow.Repository.QueryAsync<UnitOfMeasure>(
                "sp_UOM_GetAll");
        }

        public async Task<IEnumerable<Product>> GetProductAsync()
        {
            return await _uow.Repository.QueryAsync<Product>(
                "sp_Product_GetAll");
        }
        public async Task<Product> GetProductByIdAsync(int id)
        {
            return await _uow.Repository.QuerySingleAsync<Product>("sp_Product_GetById", new
            {
                prod_Id = id
            });
        }

        public async Task<IEnumerable<Product>> GetProductBySearchAsync(string term)
        {
            return await _uow.Repository.QueryAsync<Product>("sp_Product_Search", new
                  {
                      SearchTerm= term
                  });
        }
    }

}
