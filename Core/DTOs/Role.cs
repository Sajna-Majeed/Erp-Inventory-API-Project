using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.DTOs
{
    public class CreateRoleDto
    {
        public string Name { get; set; }
        public string? Description { get; set; }

        public List<int> PermissionIds { get; set; }
    }

    public class RoleDto
    {
        public int Role_Id { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
        public List<int> PermissionIds { get; set; }

        public bool Is_Active { get; set; }
    }
}
