using Core.Entities;

namespace Core.Interfaces
{
    public interface ICategoryService
    {
        Task<bool> CheckNameExists(string name, int id);
        Task<int> CreateCategoryAsync(Category dto);
        Task DeleteCategoryAsync(int id);
        Task<string> GenerateCategoryCodeAsync();
        Task<IEnumerable<Category>> GetCategoryAsync();
        Task ToggleStatusAsync(int id);
        Task UpdateCategoryAsync(Category dto);
        Task<IEnumerable<Category>> GetCategoryFilteredAsync(int id);
    }
}