using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class QuoteHeader:Base_Entity
    {
        public int Q_Id { get; set; }
        public string? Quote_No { get; set; }
        public DateTime? Quote_Date { get; set; }
        public int? Customer_Id { get; set; }
        public decimal? Total_Amt { get; set; }
        public decimal? Discount { get; set; }
        public decimal? Net_Amt { get; set; }
        public decimal? Increased_Rate { get; set; }
        public string? T_C { get; set; }
        public bool Quote_Send { get; set; }
        public bool Contract_Signed { get; set; }
        public bool Invoiced { get; set; }
        public bool Payment_Received { get; set; }
        public List<QuoteLine> Lines { get; set; } = new();
    }

}
