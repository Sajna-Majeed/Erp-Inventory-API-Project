using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class InvoiceHeader:Base_Entity
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
        public List<InvoiceLine> Lines { get; set; } = new();
    }

}
