using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface ICustomPriceService
    {
        Task<string> GenerateCodeAsync();
        Task<int> CreateCustomPriceAsync(CreateCustomPriceDto dto);
        Task<IEnumerable<CustomPriceDto>> GetCustomPriceAsync();
        Task<CustomPrice> GetCustomPriceByIdAsync(int userId);
        Task UpdateCustomPriceAsync(UpdateCustomPriceDto dto);
        Task ToggleStatusAsync(int id);
        Task DeleteCustomPriceAsync(int id);
        Task<IEnumerable<CustomPriceDto>> GetProductPriceByCustomer(int pd_id, int customer_id, int st_id, int module_id);
    }
}