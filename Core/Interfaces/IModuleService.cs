using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IModuleService
    {
        Task<bool> CheckNameExists(string name, int id);
        Task<string> GenerateModuleCodeAsync();
        Task<int> CreateModuleAsync(CreateModuleDto dto);
        Task<IEnumerable<Module>> GetModuleAsync();
        Task<Module> GetModuleByIdAsync(int userId);
        Task UpdateModuleAsync(UpdateModuleDto dto);
        Task DeleteModuleAsync(int id);
        Task ToggleStatusAsync(int id);
        Task<IEnumerable<Module>> GetModuleBySearchAsync(string term);
    }
}