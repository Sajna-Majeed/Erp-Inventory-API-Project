using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Customer : Base_Entity
    {
        public int Customer_Id { get; set; }
        public string? Code { get; set; }
        public int Customer_Type_Id { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public string? Contact_Person { get; set; }
        public string? Email { get; set; }
        public string? Mobile_No { get; set; }
        public string? AddressLine1 { get; set; }
        public string? City { get; set; }
        public string? Country_Subdivision { get; set; }
        public string? Country { get; set; }
        public string? Zip_code { get; set; }
    }
}
