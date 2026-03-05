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


    public class InvoiceService : IInvoiceService
    {
        private readonly IExternalApiService _externalApi;
        private readonly IUnitOfWork _uow;
        private readonly IHttpContextAccessor _httpContextAccessor;
        public InvoiceService(IExternalApiService externalApi, IUnitOfWork uow, IHttpContextAccessor httpContextAccessor)
        {
            _externalApi = externalApi;
            _uow = uow;
            _httpContextAccessor = httpContextAccessor;
        }


        public async Task<string> GenerateInvoiceNumberAsync()
        {
            using var multi = await _uow.Repository.QueryMultipleAsync("sp_Invoice_GetAll");
            var headers = (await multi.ReadAsync<InvoiceHeader>()).ToList();
            var lastInvoice =  headers.OrderByDescending(x => x.Invoice_Id)
                .FirstOrDefault();

            int nextNumber = lastInvoice == null
                ? 1
                : int.Parse(lastInvoice.Invoice_No.Split('-').Last()) + 1;

            return $"INV-{DateTime.UtcNow.Year}-{nextNumber:D5}";
        }

        public async Task<InvoiceHeader> GetInvoiceById(int id)
        {
            using var multi = await _uow.Repository.QueryMultipleAsync("sp_Invoice_GetById",
                                new
                                {
                                    invoice_id = id
                                },
                                commandType: CommandType.StoredProcedure);

            var header = await multi.ReadFirstAsync<InvoiceHeader>();
            var lines = (await multi.ReadAsync<InvoiceLine>()).ToList();

            header.Lines = lines;
            return header;
        }


        public async Task<IEnumerable<InvoiceDto>> GetInvoices()
        {
             return  await _uow.Repository.QueryAsync<InvoiceDto>("sp_Invoice_GetAll");

        }

        public async Task<int> CreateInvoiceAsync(CreateInvoiceDto dto)
        {
            var parameters = new DynamicParameters();
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
            MapHeaderParameters(parameters, dto);

            parameters.Add("@created_by", userId);
            parameters.Add("@created_on", DateTime.UtcNow);

            // Add TVP
            parameters.Add("@Lines",
                CreateInvoiceLineDataTable(dto.Lines)
                    .AsTableValuedParameter("dbo.InvoiceLineType"));

            var invoiceId = await _uow.Repository.ExecuteAsync(
                "sp_Invoice_Create",
                parameters,
                CommandType.StoredProcedure);
            _uow.Commit();
            return invoiceId;
        }

        public async Task<bool> UpdateInvoiceAsync( UpdateInvoiceDto dto)
        {
            var userId = _httpContextAccessor.HttpContext?.Items["UserId"] as int?;
            var parameters = new DynamicParameters();

            MapHeaderParameters(parameters, dto);
            parameters.Add("@updated_by", userId);
            parameters.Add("@updated_on", DateTime.UtcNow);
            parameters.Add("@Lines",
                CreateInvoiceLineDataTable(dto.Lines)
                    .AsTableValuedParameter("dbo.InvoiceLineType"));

            var rows = await _uow.Repository.ExecuteAsync(
                "sp_Invoice_Update",
                parameters);
            _uow.Commit();
            return rows > 0;
        }

        public async Task DeleteInvoiceAsync(int id)
        {
            await _uow.Repository.ExecuteAsync(
                "sp_Invoice_Delete",
                new
                {
                    Invoice_id = id
                });

            _uow.Commit();
        }



        #region Private Methods

        private void MapHeaderParameters(DynamicParameters parameters, CreateInvoiceDto dto)
        {
            parameters.Add("@invoice_no", dto.Invoice_No);
            parameters.Add("@invoice_date", dto.Invoice_Date);
            parameters.Add("@invoice_type_code", dto.Invoice_Type_Code);
            parameters.Add("@invoice_curreny_code", dto.Invoice_Curreny_Code);
            parameters.Add("@invoice_tsn_code", dto.Invoice_Tsn_Code);
            parameters.Add("@due_date", dto.Due_Date);
            parameters.Add("@bsn_process_type", dto.Bsn_Process_Type);
            parameters.Add("@specification_identifier", dto.Specification_Identifier);
            parameters.Add("@payment_means_type_code", dto.Payment_Means_Type_Code);
            parameters.Add("@net_amt", dto.Net_Amt);
            parameters.Add("@total_wo_tax", dto.Total_Wo_Tax);
            parameters.Add("@total_tax_amt", dto.Total_Tax_Amt);
            parameters.Add("@total_w_tax", dto.Total_W_Tax);
            parameters.Add("@payment_due_amt", dto.Payment_Due_Amt);
            parameters.Add("@tax_cat_taxable_amt", dto.Tax_Cat_Taxable_Amt);
            parameters.Add("@tax_cat_tax_amt", dto.Tax_Cat_Tax_Amt);
            parameters.Add("@tax_cat_code", dto.Tax_Cat_Code);
            parameters.Add("@tax_cat_rate", dto.Tax_Cat_Rate);
            parameters.Add("@address_line", dto.AddressLine);
            parameters.Add("@bp_id", dto.Bp_Id);
        }
        private void MapHeaderParameters(DynamicParameters parameters, UpdateInvoiceDto dto)
        {
            parameters.Add("@invoice_id", dto.Invoice_Id);
            parameters.Add("@invoice_no", dto.Invoice_No);
            parameters.Add("@invoice_date", dto.Invoice_Date);
            parameters.Add("@invoice_type_code", dto.Invoice_Type_Code);
            parameters.Add("@invoice_curreny_code", dto.Invoice_Curreny_Code);
            parameters.Add("@invoice_tsn_code", dto.Invoice_Tsn_Code);
            parameters.Add("@due_date", dto.Due_Date);
            parameters.Add("@bsn_process_type", dto.Bsn_Process_Type);
            parameters.Add("@specification_identifier", dto.Specification_Identifier);
            parameters.Add("@payment_means_type_code", dto.Payment_Means_Type_Code);
            parameters.Add("@net_amt", dto.Net_Amt);
            parameters.Add("@total_wo_tax", dto.Total_Wo_Tax);
            parameters.Add("@total_tax_amt", dto.Total_Tax_Amt);
            parameters.Add("@total_w_tax", dto.Total_W_Tax);
            parameters.Add("@payment_due_amt", dto.Payment_Due_Amt);
            parameters.Add("@tax_cat_taxable_amt", dto.Tax_Cat_Taxable_Amt);
            parameters.Add("@tax_cat_tax_amt", dto.Tax_Cat_Tax_Amt);
            parameters.Add("@tax_cat_code", dto.Tax_Cat_Code);
            parameters.Add("@tax_cat_rate", dto.Tax_Cat_Rate);
            parameters.Add("@address_line", dto.AddressLine);
            parameters.Add("@bp_id", dto.Bp_Id);
        }
        private DataTable CreateInvoiceLineDataTable(List<CreateInvoiceLineDto> lines)
        {
            var table = new DataTable();

            table.Columns.Add("item_name", typeof(string));
            table.Columns.Add("description", typeof(string));
            table.Columns.Add("inv_line_identifier", typeof(string));
            table.Columns.Add("unit_of_measure_code", typeof(string));
            table.Columns.Add("net_amt", typeof(decimal));
            table.Columns.Add("item_net_price", typeof(decimal));
            table.Columns.Add("item_gross_price", typeof(decimal));
            table.Columns.Add("item_price_base_qty", typeof(int));
            table.Columns.Add("item_tax_cat_code", typeof(string));
            table.Columns.Add("item_tax_rate", typeof(decimal));
            table.Columns.Add("vat_in_aed", typeof(decimal));
            table.Columns.Add("amt_in_aed", typeof(decimal));

            foreach (var line in lines)
            {
                table.Rows.Add(
                    line.Item_Name,
                    line.Description,
                    line.Inv_Line_Identifier,
                    line.Unit_Of_Measure_Code,
                    line.Net_Amt ?? 0,
                    line.Item_Net_Price ?? 0,
                    line.Item_Gross_Price ?? 0,
                    line.Item_Price_Base_Qty ?? 0,
                    line.Item_Tax_Cat_Code,
                    line.Item_Tax_Rate ?? 0,
                    line.Vat_In_Aed ?? 0,
                    line.Amt_In_Aed ?? 0
                );
            }

            return table;
        }

        #endregion

        #region Mock External API Calls
        public async Task<object?> GetInvoiceTraking()
        {
            var url = "FakeInvoice";
            var result = await _externalApi.GetAsync<object>(url);

            if (!result.Success)
                return result.ErrorMessage ?? "External API failed";

            return result;
        }

        public async Task<string> SetInvoiceTraking()
        {
            var payload = new
            {
                name = "test"
            };

            var response = await _externalApi.PostAsync<object>(
                "v1/some-endpoint",   // relative URL
                payload);

            if (!response.Success)
                return response.ErrorMessage ?? "External API POST failed";

            return "Success";
        }

        #endregion

    }


}
