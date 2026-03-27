using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.DTOs
{

    public class PermissionList
    {
        public string? Label { get; set; }
        public List<ParentPermission>? Permissions { get; set; }
    }
    public class ParentPermission
    {
        public string? Label { get; set; }
        public List<PermissionNode>? Children { get; set; }
    }
    public class PermissionNode
    {
        public int Prm_id { get; set; }
        public string? Name { get; set; }
        public string? Description { get; set; }
    }

}
