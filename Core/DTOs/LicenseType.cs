
using Core.Common;
using Core.Entities;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Core.DTOs
{
    public class CreateLicenseTypeDto
    {
        public string Code { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string? Description { get; set; } = string.Empty;
        public int Pd_Id { get; set; }
        public decimal? Unit_Rate { get; set; }
        public decimal? Alf_Rate { get; set; }
        public decimal? S_Rate { get; set; }
        public decimal? P_Rate { get; set; }
    }
    public class UpdateLicenseTypeDto
    {
        public int Lt_Id { get; set; }
        public string Code { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string? Description { get; set; } = string.Empty;
        public int Pd_Id { get; set; }
        public decimal? Unit_Rate { get; set; }
        public decimal? Alf_Rate { get; set; }
        public decimal? S_Rate { get; set; }
        public decimal? P_Rate { get; set; }
    }

}
