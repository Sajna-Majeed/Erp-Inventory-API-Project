
using Core.Common;
using Core.Entities;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Core.DTOs
{
    public class CreateProductDto
    {
        [Required]
        public string Code { get; set; }=string.Empty;
        [Required]
        public string Name { get; set; }= string.Empty;
        public string? Description { get; set; }=string.Empty ;
        public int St_Id { get; set; }
        public decimal Unit_Price { get; set; }
    }
    public class UpdateProductDto
    {
        [Required]
        public int Pd_Id { get; set; }
        [Required]
        public string Code { get; set; } = string.Empty;
        [Required]
        public string Name { get; set; } = string.Empty;
        public string? Description { get; set; } = string.Empty;
        public int St_Id { get; set; } 
        public decimal Unit_Price { get; set; }
    }

}
