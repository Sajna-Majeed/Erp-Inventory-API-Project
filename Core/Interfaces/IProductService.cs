using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IProductService
    {
        Task<bool> CheckNameExists(string name, int id);
        Task<string> GenerateProductCodeAsync();
        Task<int> CreateProductAsync(CreateProductDto dto);
        Task<IEnumerable<Product>> GetProductAsync();
        Task<Product> GetProductByIdAsync(int userId);
        Task UpdateProductAsync(UpdateProductDto dto);
        Task DeleteProductAsync(int id);
        Task ToggleStatusAsync(int id);
        Task<IEnumerable<Product>> GetProductBySearchAsync(string term);
        Task<IEnumerable<UnitOfMeasure>> GetUomAsync();
    }
}