using Core.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.DTOs
{
    public class CreateQuoteDto
    {
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
        public List<CreateQuoteLine> Lines { get; set; } = new();
        public List<string> Attchments { get; set; } = new();
    }
    public class UpdateQuoteDto
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
        public List<CreateQuoteLine> Lines { get; set; } = new();
        public List<FileAttchments> Attchments { get; set; } = new();
    }
    public class FileAttchments    
    {
        public string File_Name { get; set; } = string.Empty;
        public string File_Path { get; set; }= string.Empty;
    }

    public class QuoteDto
    {
        public int Q_Id { get; set; }
        public string? Quote_No { get; set; }
        public DateTime? Quote_Date { get; set; }
        public string? Customer { get; set; }
        public decimal? Net_Amt { get; set; }
        public bool Quote_Send { get; set; }
        public bool Contract_Signed { get; set; }
        public bool Invoiced { get; set; }
        public bool Payment_Received { get; set; }
    } 
    public class CreateQuoteLine
    {
        public int Q_Line_Id { get; set; }
        public int Q_Id { get; set; }
        public int RowNum { get; set; }
        public int? St_Id { get; set; }
        public int? Pd_Id { get; set; }
        public int? Module_Id { get; set; }
        public decimal? Rate { get; set; }
        public int? License_Count { get; set; }
    }
}
