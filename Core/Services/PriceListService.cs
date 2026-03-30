using Core.DTOs;
using Core.Entities;
using Core.Interfaces;
using Core.Security;
using Dapper;
using Microsoft.AspNetCore.Http;
using Serilog;
using System.Data;

namespace Core.Services
{
  

    public class PriceListService : IPriceListService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public PriceListService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }
     
        public async Task<int> CreatePriceListAsync(PriceListDto dto)
        {
           var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
        
            var result= await _uow.Repository.ExecuteAsync(
                "sp_PriceList_Insert",
                new
                {
                    dto.St_Id,
                    dto.Cat_Id,
                    dto.Pd_Id,
                    dto.Lt_Id,
                    dto.Lm_Id,
                    dto.Unit_Rate,
                    dto.Alf_Rate,
                    dto.Effective_From,
                    dto.Effective_To,
                    CreatedBy = userId ?? 1,
                    CreatedOn=DateTime.UtcNow
                });
            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} created a new price list with id {Id}", user, result);
            return result;
        }
        public async Task UpdatePriceListAsync(PriceListDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_PriceList_Update",
                new
                {
                    dto.Pl_Id,
                    dto.St_Id,
                    dto.Cat_Id,
                    dto.Pd_Id,
                    dto.Lt_Id,
                    dto.Lm_Id,
                    dto.Alf_Rate,
                    dto.Effective_From,
                    dto.Effective_To,
                    UpdatedBy = userId??1,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a custom product price with id {Id}", user, dto.Pl_Id);
        }

        public async Task DeletePriceListAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_PriceList_Delete",
                new
                {
                    id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} deleted a price list  with id {Id}", user, id);
        }
        public async Task ToggleStatusAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_PriceList_Toggle",
                new
                {
                     id
                });

            _uow.Commit();
            var user = _httpContextAccessor.HttpContext?.User?.Identity?.Name;
            Log.Information("User {User} updated a price list status with id {Id}", user, id);
        }

        public async Task<IEnumerable<PriceList>> GetPriceListAsync()
        {
            return await _uow.Repository.QueryAsync<PriceList>(
                "sp_PriceList_GetAll");
        }
    }

}
