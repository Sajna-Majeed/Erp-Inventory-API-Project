using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.DTOs
{
    public class PriceListDto
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
    }

}
