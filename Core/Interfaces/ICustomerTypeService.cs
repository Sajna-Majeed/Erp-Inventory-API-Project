using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface ICustomerTypeService
    {
        Task<bool> CheckNameExists(string name, int id);
        Task<string> GenerateCustomerTypeCodeAsync();
        Task<int> CreateCustomerTypeAsync(CreateCustomerTypeDto dto);
        Task<IEnumerable<CustomerType>> GetCustomerTypeAsync();
        Task<CustomerType> GetCustomerTypeByIdAsync(int userId);
        Task UpdateCustomerTypeAsync(UpdateCustomerTypeDto dto);
        Task DeleteCustomerTypeAsync(int id);
        Task ToggleStatusAsync(int id);
        Task<IEnumerable<CustomerType>> GetCustomerTypeBySearchAsync(string term);
    }
}