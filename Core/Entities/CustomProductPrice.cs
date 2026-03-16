using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class CustomPrice : Base_Entity
    {
        public int Custom_Prod_Id { get; set; }
        public string? Code { get; set; }
        public int Customer_Id { get; set; }
        public int St_Id { get; set; }
        public int Pd_Id { get; set; }
        public int Module_Id { get; set; }
        public int Unit_Price { get; set; }
    }
}
