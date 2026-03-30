using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class PriceList : Base_Entity
    {
        public int? Pl_Id { get; set; }
        public int St_Id { get; set; }
        public int Cat_Id { get; set; }
        public int Pd_Id { get; set; }
        public int? Lt_Id { get; set; }
        public int? Lm_Id { get; set; }
        public decimal? Unit_Rate { get; set; }
        public decimal? Alf_Rate { get; set; }
        public DateTime? Effective_From { get; set; }
        public DateTime? Effective_To { get; set; }

        public string? ServiceType { get; set; }
        public string? Category { get; set; }
        public string? Product { get; set; }
        public string? LicenseType { get; set; }
       public string? LicenseMode { get; set; }

    }
}
