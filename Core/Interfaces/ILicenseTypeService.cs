using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface ILicenseTypeService
    {
        Task<bool> CheckNameExists(string name, int id);
        Task<string> GenerateCodeAsync();
        Task<int> CreateLicenseTypeAsync(LicenseType dto);
        Task<IEnumerable<LicenseType>> GetLicenseTypeAsync();
        Task UpdateLicenseTypeAsync(LicenseType dto);
        Task DeleteLicenseTypeAsync(int id);
        Task ToggleStatusAsync(int id);
    }
}