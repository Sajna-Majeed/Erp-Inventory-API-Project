using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Module:Base_Entity
    {
        public int Module_Id { get; set; }
        public string Code { get; set; }=string.Empty;
        public string Name { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public int Product_Id { get; set; }
    }
}
