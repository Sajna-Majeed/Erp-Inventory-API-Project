using Core.DTOs;
using Core.Entities;
using Core.Interfaces;
using Core.Security;
using Dapper;
using Microsoft.AspNetCore.Http;
using System.Data;

namespace Core.Services
{
  

    public class BussinessPointService : IBussinessPointService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public BussinessPointService(IUnitOfWork uow,IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }

        public async Task<int> CreateBussinessPointAsync(CreateBussinessPointDto dto)
        {
           var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
        
            var result= await _uow.Repository.ExecuteAsync(
                "sp_BussinessPartner_Insert",
                new
                {
                    dto.Name,
                    dto.Contact_Person,
                    dto.Email,
                    dto.Mobile_Number,
                    dto.E_Identifier,
                    dto.Legal_Reg_Identifier,
                    dto.Legal_Reg_Type,
                    dto.Tax_Identifier,
                    dto.Tax_Scheme_Code,
                    dto.AddressLine1,
                    dto.City,
                    dto.Country_Subdivision,
                    dto.Country_Code,
                    dto.Is_Customer,
                    dto.Is_Seller,
                    CreatedBy = userId,
                    CreatedOn=DateTime.UtcNow
                });
            _uow.Commit();  

            return result;
        }
        public async Task UpdateBussinessPointAsync(UpdateBussinessPointDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;

            await _uow.Repository.ExecuteAsync(
                "sp_BussinessPartner_Update",
                new
                {
                    dto.Bp_Id,
                    dto.Name,
                    dto.Contact_Person,
                    dto.Email,
                    dto.Mobile_Number,
                    dto.E_Identifier,
                    dto.Legal_Reg_Identifier,
                    dto.Legal_Reg_Type,
                    dto.Tax_Identifier,
                    dto.Tax_Scheme_Code,
                    dto.AddressLine1,
                    dto.City,
                    dto.Country_Subdivision,
                    dto.Country_Code,
                    dto.Is_Customer,
                    dto.Is_Seller,
                    UpdatedBy = userId,
                    UpdatedOn = DateTime.UtcNow
                });

            _uow.Commit();
        }

        public async Task DeleteBussinessPointAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_BussinessPartner_Delete",
                new
                {
                    bp_Id = id
                });

            _uow.Commit();
        }


        public async Task<IEnumerable<BussinessPoint>> GetBussinessPointAsync()
        {
            return await _uow.Repository.QueryAsync<BussinessPoint>(
                "sp_BussinessPartner_GetAll");
        }
        public async Task<BussinessPoint> GetBussinessPointByIdAsync(int bpId)
        {
            return await _uow.Repository.QuerySingleAsync<BussinessPoint>("sp_BussinessPartner_GetById", new
            {
                bp_Id = bpId
            });
        }
    }

}
