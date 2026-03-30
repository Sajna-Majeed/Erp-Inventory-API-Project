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


    public class CategoryService : ICategoryService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public CategoryService(IUnitOfWork uow, IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }




        public async Task<string> GenerateCategoryCodeAsync()
        {
            var sql = "SELECT TOP (1)  *  FROM [Category] order by cat_id desc";

            var lastCode = await _uow.Repository.QuerySingleAsync<Category>(sql, null, CommandType.Text);

            int nextNumber = lastCode == null
                ? 1
                : int.Parse(lastCode.Code.Split('-').Last()) + 1;

            return $"CAT-{nextNumber:D3}";
        }

        public async Task<bool> CheckNameExists(string name, int id)
        {
            var sql = "SELECT  *  FROM [Category] where name=@name and cat_id!=@id and is_deleted=0";

            var lastCode = await _uow.Repository.QuerySingleAsync<Category>(sql, new
            {
                name,
                id
            }, CommandType.Text);

            return lastCode != null;
        }

        public async Task<int> CreateCategoryAsync(Category dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            var result = await _uow.Repository.ExecuteAsync(
                "sp_Category_Insert",
                new
                {
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    dto.St_Id,
                    CreatedBy = userId,
                    CreatedOn = DateTime.UtcNow
                });
            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} created a new  Category  with id {Id}", user, result);
            return result;
        }
        public async Task UpdateCategoryAsync(Category dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_Category_Update",
                new
                {
                    dto.Cat_Id,
                    dto.Code,
                    dto.Name,
                    dto.Description,
                    dto.St_Id,
                    UpdatedBy = userId,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a Category with id {Id}", user, dto.Cat_Id);
        }

        public async Task DeleteCategoryAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Category_Delete",
                new
                {
                    Id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a Category with id {Id}", user, id);
        }

        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Category_Toggle",
                new
                {
                    Id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a Category status with id {Id}", user, id);
        }


        public async Task<IEnumerable<Category>> GetCategoryAsync()
        {
            return await _uow.Repository.QueryAsync<Category>(
                "sp_Category_GetAll",
                new
                {
                    id=0
                });
        }

        public async Task<IEnumerable<Category>> GetCategoryFilteredAsync(int id)
        {
            return await _uow.Repository.QueryAsync<Category>(
                "sp_Category_GetAll",new {id=id});
        }

    }

}
