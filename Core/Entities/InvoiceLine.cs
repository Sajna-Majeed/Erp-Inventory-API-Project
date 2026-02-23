using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class InvoiceLine
    {
        public int Invoice_Line_Id { get; set; }
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
