using Core.DTOs;
using Core.Entities;
using Core.Interfaces;
using Core.Security;
using Dapper;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;
using System.Data;

namespace Core.Services
{


    public class ContractService 
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public ContractService( IUnitOfWork uow, IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }


       
        public async Task<IEnumerable<Product>> GetCategory()
        {
            string sql = "select [pd_Id],[code],[name],[st_Id] from Product";
            return await _uow.Repository.QueryAsync<Product>(sql,
            null,
            CommandType.Text);

        }
        public async Task<IEnumerable<ProductDto>> GetProduct(int id)
        {
            string sql = "select [lt_id] as Id,[code],[name] FROM [ALF_License_Type] where pd_id=@id";
            return await _uow.Repository.QueryAsync<ProductDto>(sql, new
            {
                id = id
            },
            CommandType.Text);

        }
        public async Task<IEnumerable<LicenseTypeDto>> GetLicenseTypes()
        {
            string sql = "select [lt_id],[name]  FROM [BasicDb].[dbo].[License_Type]";
            return await _uow.Repository.QueryAsync<LicenseTypeDto>(sql,
            null,
            CommandType.Text);

        }

        public async Task<IEnumerable<LicenseModelDto>> GetLicenseModes()
        {
            string sql = "select [lm_id] as Id,[name]  FROM [BasicDb].[dbo].[License_Mode]";
            return await _uow.Repository.QueryAsync<LicenseModelDto>(sql,
            null,
            CommandType.Text);

        }

     
    }


}
