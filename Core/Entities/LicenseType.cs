using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class LicenseType:Base_Entity
    {
        public int Lt_Id { get; set; }
        public string Code { get; set; }=string.Empty;
        public string Name { get; set; } = string.Empty;
        public string Description { get; set; } = string.Empty;
        public int Pd_Id { get; set; }
        public decimal? Unit_Rate { get; set; }
        public decimal? Alf_Rate { get; set; }
        public decimal? S_Rate { get; set; }
        public decimal? P_Rate { get; set; }
    }
}
