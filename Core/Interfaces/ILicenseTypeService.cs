using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface ILicenseTypeService
    {
        Task<bool> CheckNameExists(string name, int id);
        Task<string> GenerateLicenseTypeCodeAsync();
        Task<int> CreateLicenseTypeAsync(CreateLicenseTypeDto dto);
        Task<IEnumerable<LicenseType>> GetLicenseTypeAsync();
        Task<IEnumerable<LicenseType>> GetLicenseTypeByProductId(int id);
        Task<LicenseType> GetLicenseTypeByIdAsync(int userId);
        Task UpdateLicenseTypeAsync(UpdateLicenseTypeDto dto);
        Task DeleteLicenseTypeAsync(int id);
        Task ToggleStatusAsync(int id);
        Task<IEnumerable<LicenseType>> GetLicenseTypeBySearchAsync(string term);
    }
}