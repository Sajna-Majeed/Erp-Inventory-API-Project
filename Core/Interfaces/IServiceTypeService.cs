using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IServiceTypeService
    {
        Task<bool> CheckNameExists(string name, int id);
        Task<string> GenerateServiceTypeCodeAsync();
        Task<int> CreateServiceTypeAsync(CreateServiceTypeDto dto);
        Task<IEnumerable<ServiceType>> GetServiceTypeAsync();
        Task<ServiceType> GetServiceTypeByIdAsync(int userId);
        Task UpdateServiceTypeAsync(UpdateServiceTypeDto dto);
        Task DeleteServiceTypeAsync(int id);
        Task ToggleStatusAsync(int id);
        Task<IEnumerable<ServiceType>> GetServiceTypeBySearchAsync(string term);
    }
}