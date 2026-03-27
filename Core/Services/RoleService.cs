using Core.DTOs;
using Core.Entities;
using Core.Interfaces;
using Core.Security;
using Dapper;
using Microsoft.AspNetCore.Http;
using Serilog;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Core.Services
{
    public class RoleService : IRoleService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public RoleService(IUnitOfWork uow, IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }
        public async Task<int> CreateRoleAsync(CreateRoleDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
            var table = new DataTable();
            table.Columns.Add("PermissionId", typeof(int));

            foreach (var id in dto.PermissionIds)
            {
                table.Rows.Add(id);
            }

            var parameters = new DynamicParameters();
            parameters.Add("@name", dto.Name);
            parameters.Add("@description", dto.Description);
            parameters.Add("@@CreatedBy", userId);
            parameters.Add("@@CreatedOn", DateTime.UtcNow);
            parameters.Add("@PermissionIds", table.AsTableValuedParameter("PermissionIdTableType"));
            var Role_Id = await _uow.Repository.ExecuteScalarAsync(
                "sp_Role_Create",
                parameters,
                CommandType.StoredProcedure);
            _uow.Commit();
            return Role_Id;
        }

        public async Task<bool> UpdateRoleAsync(RoleDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
            var table = new DataTable();
            table.Columns.Add("PermissionId", typeof(int));

            foreach (var id in dto.PermissionIds)
            {
                table.Rows.Add(id);
            }

            var parameters = new DynamicParameters();
            parameters.Add("@role_id", dto.Role_Id);
            parameters.Add("@name", dto.Name);
            parameters.Add("@description", dto.Description);
            parameters.Add("@@UpdatedBy", userId);
            parameters.Add("@@UpdatedOn", DateTime.UtcNow);
            parameters.Add("@PermissionIds", table.AsTableValuedParameter("PermissionIdTableType"));
            var rows = await _uow.Repository.ExecuteScalarAsync(
                "sp_Role_Update",
                parameters,
                CommandType.StoredProcedure);
            _uow.Commit();
            return rows > 0;
        }

        public async Task<IEnumerable<RoleDto>> GetRoles()
        {
            var result = await _uow.Repository.QueryAsync<Role>("sp_Role_GetAll");

            var roles = result
                .GroupBy(x => x.Role_Id)
                .Select(group =>
                {
                    var first = group.First();

                    return new RoleDto
                    {
                        Role_Id = first.Role_Id,
                        Name = first.Name,
                        Description = first.Description,
                        Is_Active=first.Is_Active,
                        PermissionIds = group
                            .Where(c => c.Prm_Id != null && c.Prm_Id != 0) // ✅ avoid nulls
                            .Select(c => c.Prm_Id)
                            .Distinct() // ✅ avoid duplicates
                            .ToList()
                    };
                })
                .ToList();

            return roles;
        }
        public async Task DeleteRoleAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Role_Delete",
                new
                {
                    Id = id
                });

            _uow.Commit();
        }
        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Role_Toggle",
                new
                {
                    Id = id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
        }
        public async Task<bool> CheckNameExists(string name, int id)
        {
            var sql = "SELECT  *  FROM [Roles] where name=@name and role_id!=@id is_deleted=0";

            var lastCode = await _uow.Repository.QuerySingleAsync<Role>(sql, new
            {
                name,
                id
            }, CommandType.Text);

            return lastCode != null;
        }
        public async Task<IEnumerable<PermissionList>> GetPermissions()
        {
            var permissionlist = new List<PermissionList>();

            string sql = "SELECT * FROM Permissions";
            var permissions = await _uow.Repository.QueryAsync<Permission>(sql, null, CommandType.Text);

            var groups = permissions.GroupBy(m => m.Parent);

            foreach (var group in groups)
            {
                var parentlist = new List<ParentPermission>();
                var childresn=group.GroupBy(m => m.Label);
                foreach(var child in childresn)
                {
                    parentlist.Add(new ParentPermission
                    {
                        Label = child.Key,
                        Children = child.Select(c => new PermissionNode
                        {
                            Prm_id = c.Prm_Id,          // 👈 IMPORTANT (used for saving)
                            Name = c.Name,             // 👈 UNIQUE (VIEW_CUSTOMERS)
                            Description = c.Description // 👈 FIXED
                        }).ToList()
                    });
                }

                permissionlist.Add(new PermissionList
                {
                    Label = group.Key,
                    Permissions = parentlist



                });
            }

            return permissionlist;
        }
    }
}
