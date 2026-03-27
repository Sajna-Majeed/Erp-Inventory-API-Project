using Core.DTOs;
using Core.Entities;
using Core.Interfaces;
using Core.Security;
using Microsoft.AspNetCore.Http;
using Serilog;
using System.Data;

namespace Core.Services
{
 

    public class AuthService : IAuthService
    {
        private readonly IUnitOfWork _uow;
        private readonly JwtTokenGenerator _jwt;
        private readonly RefreshTokenService _refresh;
        private readonly IHttpContextAccessor _httpContextAccessor;
       
        public AuthService(IUnitOfWork uow,
                           JwtTokenGenerator jwt,
                           RefreshTokenService refresh, 
                           IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _jwt = jwt;
            _refresh = refresh;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<object> LoginAsync(LoginDto dto)
        {
            string sql= "Select *,r.Name as role from Users u join roles r on u.role_id=r.role_id where user_name=@Username";
            var user = await _uow.Repository.QuerySingleAsync<User>(sql, new { dto.Username },CommandType.Text);

            if (user == null || !PasswordHasher.Verify(dto.Password, user.Password))
                throw new Exception("Invalid credentials");


            var accessToken = _jwt.Generate(user.User_Id,user.User_Name, user.Role_Id);
            var refreshToken = _refresh.Generate();

            await _uow.Repository.ExecuteAsync(
                "sp_SaveRefreshToken",
                new
                {
                    UserId=user.User_Id,
                    Token = refreshToken,
                    Expiry = _refresh.Expiry()
                });

            var company=await _uow.Repository.QuerySingleAsync<Company>("sp_Company_GetById", new
            {
                id = 1
            });


            var menu = await _uow.Repository.QueryAsync<Menu>("sp_Company_Menu", new
            {
                id = 1
            });

            var menulist=new List<MenuList>();
            var parentMenus = menu.Where(m => m.Parent_Id == null).OrderBy(m => m.Display_Order);
            foreach (var item in parentMenus)
            {
                var childres = menu.Where(m => m.Parent_Id == item.Menu_Id).OrderBy(m => m.Display_Order);
                menulist.Add(new MenuList
                {
                    Name = item.Name,
                    DisplayOrder = item.Display_Order,
                    Icon=item.Icon,
                    Link = item.Link,
                    MenuItems = childres.Select(c => new MenuItem
                    {
                        Name = c.Name,
                        DisplayOrder = c.Display_Order,
                         Icon = c.Icon,
                        Link = c.Link,
                    }).ToList()
                });
            }
            Log.Information("User {User} is logged in", user.User_Name);
            return new
            {   
                user.User_Name,
                user.Name,
                user.Role,
                user.Role_Id,
                user.Email,
                user.Mobile_Number,
                accessToken,
                refreshToken,
                company,
                menulist
            };
        }


        public async Task<object> RefreshAsync(string oldToken)
        {
            var token = await _uow.Repository.QuerySingleAsync<RefreshToken>(
                "sp_GetRefreshToken",
                new { Token = oldToken });

            if (token == null || token.IsRevoked || token.ExpiryDate < DateTime.UtcNow)
                throw new Exception("Invalid refresh token");

            await _uow.Repository.ExecuteAsync(
                "sp_RevokeRefreshToken",
                new { oldToken });

            var newRefresh = _refresh.Generate();

            await _uow.Repository.ExecuteAsync(
                "sp_SaveRefreshToken",
                new
                {
                    token.UserId,
                    Token = newRefresh,
                    Expiry = _refresh.Expiry()
                });

            var user = await _uow.Repository.QuerySingleAsync<User>(
                "sp_User_GetById",
                new { token.UserId });

            var access = _jwt.Generate(user.User_Id,user.User_Name, user.Role);

            return new { access, refresh = newRefresh };
        }

        public async Task UpdateUserProfile(UserProfile dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_User_Update",
                new
                {
                    Id = userId,
                    Username = "",
                    FullName = dto.Name,
                    dto.Email,
                    Mobile = dto.Mobile_Number,
                    Role = 0,
                    UpdatedBy = userId,
                    UpdatedOn = DateTime.UtcNow,
                    IsPartialUpdate = true
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a user with id {Id}", user, userId);
        }

        public async Task UpdatePassword(PassWordChange dto)
        {
            var Password = PasswordHasher.Hash(dto.NewPassword);
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
            string sql = "Select *,r.Name as role from Users u join roles r on u.role_id=r.role_id where user_id=@userId";
            var user = await _uow.Repository.QuerySingleAsync<User>(sql, new { userId }, CommandType.Text);
            if (user == null || !PasswordHasher.Verify(dto.CurrentPassword, user.Password))
                throw new Exception("Invalid Password");
            
            await _uow.Repository.ExecuteAsync(
                "sp_UserPassword_Update",
                new
                {
                    Id = userId,
                    Password = PasswordHasher.Hash(dto.NewPassword),
                    UpdatedBy = userId,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            Log.Information("User {User} updated a user with id {Id}", user.Name, userId);
        }

    }

}
