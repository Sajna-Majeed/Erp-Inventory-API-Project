using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IPriceListService
    {
        Task<int> CreatePriceListAsync(PriceListDto dto);
        Task<IEnumerable<PriceList>> GetPriceListAsync();
        Task UpdatePriceListAsync(PriceListDto dto);
        Task ToggleStatusAsync(int id);
        Task DeletePriceListAsync(int id);
    }
}