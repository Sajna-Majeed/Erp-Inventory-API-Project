using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IBussinessPointService
    {
        Task<int> CreateBussinessPointAsync(CreateBussinessPointDto dto);
        Task<IEnumerable<BussinessPoint>> GetBussinessPointAsync();
        Task<BussinessPoint> GetBussinessPointByIdAsync(int userId);
        Task UpdateBussinessPointAsync(UpdateBussinessPointDto dto);
        Task DeleteBussinessPointAsync(int id);
    }
}