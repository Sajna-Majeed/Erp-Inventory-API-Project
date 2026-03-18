using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class QuoteLine
    {
        public int Q_Line_Id { get; set; }
        public int Q_Id { get; set; }
        public int RowNum { get; set; }
        public int? St_Id { get; set; }
        public int? Pd_Id { get; set; }
        public int? Module_Id { get; set; }
        public decimal? Rate { get; set; }
        public int? License_Count { get; set; }
    }

}
