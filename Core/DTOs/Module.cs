
using Core.Common;
using Core.Entities;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Core.DTOs
{
    public class CreateModuleDto
    {
        [Required]
        public string Code { get; set; }=string.Empty;
        [Required]
        public string Name { get; set; }= string.Empty;
        public string? Description { get; set; }=string.Empty ;
        public int Product_Id { get; set; } 
    }
    public class UpdateModuleDto
    {
        [Required]
        public int Module_Id { get; set; }
        [Required]
        public string Code { get; set; } = string.Empty;
        [Required]
        public string Name { get; set; } = string.Empty;
        public string? Description { get; set; } = string.Empty;
        public int Product_Id { get; set; }
    }

}
