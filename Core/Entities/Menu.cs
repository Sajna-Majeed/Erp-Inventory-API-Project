using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Menu
    {
        public int Menu_Id { get; set; }
        public string? Name { get; set; }
        public int Display_Order { get; set; }
        public int? Parent_Id { get; set; }
        public string? Icon { get; set; }
        public string? Link { get; set; }
    }
}
