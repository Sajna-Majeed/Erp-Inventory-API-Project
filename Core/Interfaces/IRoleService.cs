using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IRoleService
    {
        Task<int> CreateRoleAsync(CreateRoleDto dto);
        Task DeleteRoleAsync(int id);
        Task<IEnumerable<RoleDto>> GetRoles();
        Task<IEnumerable<PermissionList>> GetPermissions();
        Task<bool> UpdateRoleAsync(RoleDto dto);
        Task<bool> CheckNameExists(string name, int id);
        Task ToggleStatusAsync(int id);
    }
}