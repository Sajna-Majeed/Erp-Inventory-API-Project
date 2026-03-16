using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.DTOs
{
    public class CreateCustomPriceDto
    {
        public string? Code { get; set; }
        public int Customer_Id { get; set; }
        public int St_Id { get; set; }
        public int Pd_Id { get; set; }
        public int Module_Id { get; set; }
        public int Unit_Price { get; set; }
    }

    public class UpdateCustomPriceDto
    {
        public string? Code { get; set; }
        public int Custom_Prod_Id { get; set; }
        public int Customer_Id { get; set; }
        public int St_Id { get; set; }
        public int Pd_Id { get; set; }
        public int Module_Id { get; set; }
        public int Unit_Price { get; set; }
    }
    public class CustomPriceDto
    {
        public string? Code { get; set; }
        public int Custom_Prod_Id { get; set; }
        public int Customer_Id { get; set; }
        public string? Customer { get; set; }
        public int St_Id { get; set; }
        public string? ServiceType { get; set; }
        public int Pd_Id { get; set; }
        public string? Product { get; set; }
        public int Module_Id { get; set; }
        public string? Module { get; set; }
        public int Unit_Price { get; set; }
        public bool Is_Active { get; set; }
    }

}
