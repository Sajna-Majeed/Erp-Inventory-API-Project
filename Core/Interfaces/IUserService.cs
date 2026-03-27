using Core.DTOs;
using Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Interfaces
{
    public interface IUserService
    {
        Task<int> CreateUserAsync(CreateUserDto dto);
        Task<IEnumerable<User>> GetUsersAsync();
        Task ToggleStatusAsync(int id);
        Task UpdateUserAsync(UpdateUserDto dto);
        Task DeleteUserAsync(int id);
        Task<bool> CheckNameExists(string name, int id);

    }
}
