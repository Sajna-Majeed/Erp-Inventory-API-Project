using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.DTOs
{
    public class CreateBussinessPointDto
    {
        public string? Name { get; set; }
        public string? Contact_Person { get; set; }
        public string? Email { get; set; }
        public string? Mobile_Number { get; set; }
        public string? E_Identifier { get; set; }
        public string? Legal_Reg_Identifier { get; set; }
        public string? Legal_Reg_Type { get; set; }
        public string? Tax_Identifier { get; set; }
        public string? Tax_Scheme_Code { get; set; }
        public string? AddressLine1 { get; set; }
        public string? City { get; set; }
        public string? Country_Subdivision { get; set; }
        public string? Country { get; set; }
        public bool Is_Seller { get; set; }
        public bool Is_Customer { get; set; }
    }

    public class UpdateBussinessPointDto
    {
        public int Bp_Id { get; set; }
        public string? Name { get; set; }
        public string? Contact_Person { get; set; }
        public string? Email { get; set; }
        public string? Mobile_Number { get; set; }
        public string? E_Identifier { get; set; }
        public string? Legal_Reg_Identifier { get; set; }
        public string? Legal_Reg_Type { get; set; }
        public string? Tax_Identifier { get; set; }
        public string? Tax_Scheme_Code { get; set; }
        public string? AddressLine1 { get; set; }
        public string? City { get; set; }
        public string? Country_Subdivision { get; set; }
        public string? Country{ get; set; }
        public bool Is_Seller { get; set; }
        public bool Is_Customer { get; set; }
    }

}
