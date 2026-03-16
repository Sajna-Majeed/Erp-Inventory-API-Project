using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface ICustomerService
    {
        Task<string> GenerateCodeAsync();
        Task<int> CreateCustomerAsync(CreateCustomerDto dto);
        Task<IEnumerable<Customer>> GetCustomerAsync();
        Task<Customer> GetCustomerByIdAsync(int userId);
        Task UpdateCustomerAsync(UpdateCustomerDto dto);
        Task ToggleStatusAsync(int id);
        Task DeleteCustomerAsync(int id);
    }
}