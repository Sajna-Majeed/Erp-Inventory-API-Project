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


    public class QuoteService : IQuoteService
    {
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public QuoteService( IUnitOfWork uow, IHttpContextAccessor httpContextAccessor)
        {
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }


        public async Task<string> GenerateQuoteNumberAsync()
        {
            using var multi = await _uow.Repository.QueryMultipleAsync("sp_Quote_GetAll");
            var headers = (await multi.ReadAsync<QuoteHeader>()).ToList();
            var lastQuote =  headers.OrderByDescending(x => x.Q_Id)
                .FirstOrDefault();

            int nextNumber = lastQuote == null
                ? 1
                : int.Parse(lastQuote.Quote_No.Split('-').Last()) + 1;

            return $"QTN/-{DateTime.UtcNow.ToString("yy")}/-{nextNumber:D5}";
        }

        public async Task<QuoteHeader> GetQuoteById(int id)
        {
            using var multi = await _uow.Repository.QueryMultipleAsync("sp_Quote_GetById",
                                new
                                {
                                    q_id = id
                                },
                                commandType: CommandType.StoredProcedure);

            var header = await multi.ReadFirstAsync<QuoteHeader>();
            var lines = (await multi.ReadAsync<QuoteLine>()).ToList();
            var files= (await multi.ReadAsync<FileAttchments>()).ToList();
            header.Lines = lines;
            header.Attchments= files;
            return header;
        }
        public async Task<QuoteInvoice> GetQuoteViewById(int id)
        {
            using var multi = await _uow.Repository.QueryMultipleAsync("sp_Quote_GetViewById",
                                new
                                {
                                    q_id = id
                                },
                                commandType: CommandType.StoredProcedure);

            var header = await multi.ReadFirstAsync<QuoteInvoice>();
            var customer = await multi.ReadFirstAsync<Customer>();
            var lines = (await multi.ReadAsync<QuoteInvoiceLine>()).ToList();
            var files = (await multi.ReadAsync<FileAttchmentsDto>()).ToList();
            header.Customer = customer;
            header.Lines = lines;
            header.Attchments = files;
            return header;
        }
        
        public async Task<IEnumerable<QuoteDto>> GetQuotes()
        {
             return  await _uow.Repository.QueryAsync<QuoteDto>("sp_Quote_GetAll");

        }
        public async Task<IEnumerable<FileAttchments>> GetFiles(int id)
        {
            string sql = "select File_Name,File_Path from Quote_Attachments where q_id=@id";
            return await _uow.Repository.QueryAsync<FileAttchments>(sql,new
            {
                id = id
            },
            CommandType.Text);

        }
        public async Task<int> CreateQuoteAsync(CreateQuoteDto dto)
        {
            var parameters = new DynamicParameters();
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
            MapHeaderParameters(parameters, dto);

            parameters.Add("@created_by", userId);
            parameters.Add("@created_on", DateTime.UtcNow);

            // Add TVP
            parameters.Add("@Lines",
                CreateQuoteLineDataTable(dto.Lines)
                    .AsTableValuedParameter("dbo.QuoteLineType"));

            var Q_Id = await _uow.Repository.ExecuteScalarAsync(
                "sp_Quote_Create",
                parameters,
                CommandType.StoredProcedure);

            

            _uow.Commit();
            return Q_Id;
        }

        public async Task<bool> UpdateQuoteAsync( UpdateQuoteDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
            var parameters = new DynamicParameters();

            MapHeaderParameters(parameters, dto);
            parameters.Add("@updated_by", userId);
            parameters.Add("@updated_on", DateTime.UtcNow);
            parameters.Add("@Lines",
                CreateQuoteLineDataTable(dto.Lines)
                    .AsTableValuedParameter("dbo.QuoteLineType"));

            var rows = await _uow.Repository.ExecuteAsync(
                "sp_Quote_Update",
                parameters);
            _uow.Commit();
            return rows > 0;
        }


        public async Task SaveQuoteFiles(List<FileAttchmentsDto> dto,int quoteId,List<int> deletedIds)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
            if (dto != null)
            {
                var table = new DataTable();
                table.Columns.Add("Original_Name", typeof(string));
                table.Columns.Add("File_Name", typeof(string));
                table.Columns.Add("File_Path", typeof(string));

                foreach (var file in dto)
                {
                    table.Rows.Add(file.Original_Name, file.File_Name,file.File_Path);
                }
                var deletedIdsTable = new DataTable();
                deletedIdsTable.Columns.Add("Id", typeof(int));

                foreach (var id in deletedIds)
                {
                    deletedIdsTable.Rows.Add(id);
                }
                var fileparameters = new DynamicParameters();
                fileparameters.Add("@q_id", quoteId);
                fileparameters.Add("@created_by", userId);
                fileparameters.Add("@created_on", DateTime.UtcNow);
                fileparameters.Add("@DeletedIds", deletedIdsTable.AsTableValuedParameter("IntListType"));
                fileparameters.Add("@Files", table.AsTableValuedParameter("AttachmentType"));
                await _uow.Repository.ExecuteAsync(
                "sp_Quote_Attachments_Save",
                fileparameters,
                CommandType.StoredProcedure);
            }
        }
        public async Task DeleteQuoteAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Quote_Delete",
                new
                {
                    Q_id = id
                });

            _uow.Commit();
        }



        #region Private Methods

        private void MapHeaderParameters(DynamicParameters parameters, CreateQuoteDto dto)
        {
            parameters.Add("@Quote_no", dto.Quote_No);
            parameters.Add("@Quote_date", dto.Quote_Date);
            parameters.Add("@Customer_Id", dto.Customer_Id);
            parameters.Add("@Total_Amt", dto.Total_Amt);
            parameters.Add("@Discount", dto.Discount);
            parameters.Add("@Net_Amt", dto.Net_Amt);
            parameters.Add("@t_c", dto.T_C);
            parameters.Add("@Increased_Rate", dto.Increased_Rate);
            parameters.Add("@Quote_Send", dto.Quote_Send);
            parameters.Add("@Contract_Signed", dto.Contract_Signed);
            parameters.Add("@Invoiced", dto.Invoiced);
            parameters.Add("@payment_received", dto.Payment_Received);
        }
        private void MapHeaderParameters(DynamicParameters parameters, UpdateQuoteDto dto)
        {
            parameters.Add("@Q_id", dto.Q_Id);
            parameters.Add("@Quote_no", dto.Quote_No);
            parameters.Add("@Quote_date", dto.Quote_Date);
            parameters.Add("@Customer_Id", dto.Customer_Id);
            parameters.Add("@Total_Amt", dto.Total_Amt);
            parameters.Add("@Discount", dto.Discount);
            parameters.Add("@Net_Amt", dto.Net_Amt);
            parameters.Add("@t_c", dto.T_C);
            parameters.Add("@Increased_Rate", dto.Increased_Rate);
            parameters.Add("@Quote_Send", dto.Quote_Send);
            parameters.Add("@Contract_Signed", dto.Contract_Signed);
            parameters.Add("@Invoiced", dto.Invoiced);
            parameters.Add("@payment_received", dto.Payment_Received);
        }
        private DataTable CreateQuoteLineDataTable(List<CreateQuoteLine> lines)
        {
            var table = new DataTable();

            table.Columns.Add("st_id", typeof(int));
            table.Columns.Add("pd_id", typeof(int));
            table.Columns.Add("module_id", typeof(int));
            table.Columns.Add("rate", typeof(decimal));
            table.Columns.Add("license_count", typeof(int));

            foreach (var line in lines)
            {
                table.Rows.Add(
                    line.St_Id,
                    line.Pd_Id,
                    line.Module_Id,
                    line.Rate??0,
                    line.License_Count ?? 0
                );
            }

            return table;
        }

        #endregion

      

    }


}
