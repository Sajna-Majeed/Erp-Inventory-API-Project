using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Permission
    {
        public int Prm_Id { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
        public string? Label { get; set; }
        public string? Parent { get; set; }

    }
}
