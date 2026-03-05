using Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.DTOs
{
    public class CreateInvoiceDto
    {
        public string? Invoice_No { get; set; }
        public DateTime? Invoice_Date { get; set; }
        public string? Invoice_Type_Code { get; set; }
        public string? Invoice_Curreny_Code { get; set; }
        public string? Invoice_Tsn_Code { get; set; }
        public DateTime? Due_Date { get; set; }
        public string? Bsn_Process_Type { get; set; }
        public string? Specification_Identifier { get; set; }
        public string? Payment_Means_Type_Code { get; set; }
        public decimal? Net_Amt { get; set; }
        public decimal? Total_Wo_Tax { get; set; }
        public decimal? Total_Tax_Amt { get; set; }
        public decimal? Total_W_Tax { get; set; }
        public decimal? Payment_Due_Amt { get; set; }
        public decimal? Tax_Cat_Taxable_Amt { get; set; }
        public decimal? Tax_Cat_Tax_Amt { get; set; }
        public string? Tax_Cat_Code { get; set; }
        public decimal? Tax_Cat_Rate { get; set; }
        public int Bp_Id { get; set; }
        public string? AddressLine { get; set; }
        public List<CreateInvoiceLineDto> Lines { get; set; } = new();
    }

    public class UpdateInvoiceDto
    {
        public int Invoice_Id { get; set; }
        public string? Invoice_No { get; set; }
        public DateTime? Invoice_Date { get; set; }
        public string? Invoice_Type_Code { get; set; }
        public string? Invoice_Curreny_Code { get; set; }
        public string? Invoice_Tsn_Code { get; set; }
        public DateTime? Due_Date { get; set; }
        public string? Bsn_Process_Type { get; set; }
        public string? Specification_Identifier { get; set; }
        public string? Payment_Means_Type_Code { get; set; }
        public decimal? Net_Amt { get; set; }
        public decimal? Total_Wo_Tax { get; set; }
        public decimal? Total_Tax_Amt { get; set; }
        public decimal? Total_W_Tax { get; set; }
        public decimal? Payment_Due_Amt { get; set; }
        public decimal? Tax_Cat_Taxable_Amt { get; set; }
        public decimal? Tax_Cat_Tax_Amt { get; set; }
        public string? Tax_Cat_Code { get; set; }
        public decimal? Tax_Cat_Rate { get; set; }
        public int Bp_Id { get; set; }
        public string? AddressLine { get; set; }
        public List<CreateInvoiceLineDto> Lines { get; set; } = new();
    }

    public class InvoiceDto
    {
        public int Invoice_Id { get; set; }
        public string? Invoice_No { get; set; }
        public DateTime? Invoice_Date { get; set; }
        public DateTime? Due_Date { get; set; }
        public decimal? Total { get; set; }
        public string? Partner { get; set; }
        public string? Status { get; set; }
    }
    public class CreateInvoiceLineDto
    {
        public int Invoice_Id { get; set; }
        public int RowNum { get; set; }
        public string? Item_Name { get; set; }
        public string? Description { get; set; }
        public string? Inv_Line_Identifier { get; set; }
        public string? Unit_Of_Measure_Code { get; set; }
        public decimal? Net_Amt { get; set; }
        public decimal? Item_Net_Price { get; set; }
        public decimal? Item_Gross_Price { get; set; }
        public int? Item_Price_Base_Qty { get; set; }
        public string? Item_Tax_Cat_Code { get; set; }
        public decimal? Item_Tax_Rate { get; set; }
        public decimal? Vat_In_Aed { get; set; }
        public decimal? Amt_In_Aed { get; set; }
    }
}
