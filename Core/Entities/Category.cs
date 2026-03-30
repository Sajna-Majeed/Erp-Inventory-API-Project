using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Category:Base_Entity
    {
        public int? Cat_Id { get; set; }
        public string Code { get; set; }=string.Empty;
        public string Name { get; set; } = string.Empty;
        public string? Description { get; set; } = string.Empty;
        public int St_Id { get; set; }
        public string? ServiceType { get; set; }
    }
}
