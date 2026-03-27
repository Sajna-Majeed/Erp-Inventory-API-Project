using Core.DTOs;
using Core.Entities;
using Core.Interfaces;
using Core.Security;
using Microsoft.AspNetCore.Http;
using Serilog;
using System.Data;
using static System.Net.WebRequestMethods;

namespace Core.Services
{
  

    public class UserService : IUserService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public UserService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<int> CreateUserAsync(CreateUserDto dto)
        {
            var hashed = PasswordHasher.Hash(dto.Password);
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
            userId = 1;
            var result= await _uow.Repository.ExecuteAsync(
                "sp_User_Create",
                new
                {
                    Username=dto.User_Name,
                    FullName=dto.Name,
                    dto.Email,
                    Mobile=dto.Mobile_Number,
                    Password = hashed,
                    Role = dto.Role_Id,
                    CreatedBy = userId,
                    CreatedOn=DateTime.UtcNow
                });
            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} created a new user with id {Id}", user, result);
            return result;
        }
        public async Task UpdateUserAsync(UpdateUserDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_User_Update",
                new
                {
                    Id=dto.User_Id,
                    Username = dto.User_Name,
                    FullName = dto.Name,
                    dto.Email,
                    Mobile = dto.Mobile_Number,
                    Role =dto.Role_Id,
                    UpdatedBy = userId,
                    UpdatedOn = DateTime.UtcNow,
                    IsPartialUpdate=false
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a user with id {Id}", user, dto.User_Id);
        }

        public async Task DeleteUserAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_User_Delete",
                new
                {
                    Id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a user with id {Id}", user, id);
        }


        public async Task<IEnumerable<User>> GetUsersAsync()
        {
            return await _uow.Repository.QueryAsync<User>(
                "sp_User_GetAll");
        }
        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_User_Toggle",
                new
                {
                    id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a User status with id {Id}", user, id);
        }

        public async Task<bool> CheckNameExists(string name, int id)
        {
            var sql = "SELECT  *  FROM [Users] where user_name=@name and user_id!=@id";

            var lastCode = await _uow.Repository.QuerySingleAsync<User>(sql, new
            {
                name,
                id
            }, CommandType.Text);

            return lastCode != null;
        }
    }

}
