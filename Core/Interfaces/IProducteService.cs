using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IProducteService
    {
        Task<bool> CheckNameExists(string name, int id);
        Task<string> GenerateCodeAsync();
        Task<int> CreateProductAsync(Product dto);
        Task<IEnumerable<Product>> GetProductAsync();
        Task<IEnumerable<Product>> GetFilteredProductAsync(int id);
        Task UpdateProductAsync(Product dto);
        Task DeleteProductAsync(int id);
        Task ToggleStatusAsync(int id);
    }
}