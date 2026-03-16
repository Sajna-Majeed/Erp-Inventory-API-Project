using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class CustomerService : Base_Entity
    {
        public int Cus_Srv_Id { get; set; }
        public int Customer_Id { get; set; }
        public int Pd_Id { get; set; }
        public int Module_Id { get; set; }
        public int License_Count { get; set; }
        public int Last_Billed_Date { get; set; }
        public int Expiary_Date { get; set; }
    }
}
