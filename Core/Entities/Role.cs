using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class Role:Base_Entity
    {
        public int Role_Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }

        public int Prm_Id { get; set; }
    }
}
