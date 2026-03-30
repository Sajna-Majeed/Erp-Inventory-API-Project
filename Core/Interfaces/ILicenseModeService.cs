using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface ILicenseModeService
    {
        Task<bool> CheckNameExists(string name, int id);
        Task<string> GenerateCodeAsync();
        Task<int> CreateLicenseModeAsync(LicenseMode dto);
        Task<IEnumerable<LicenseMode>> GetLicenseModeAsync();
        Task UpdateLicenseModeAsync(LicenseMode dto);
        Task DeleteLicenseModeAsync(int id);
        Task ToggleStatusAsync(int id);
    }
}