
using Core.Common;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Core.DTOs
{
    public class CreateUserDto
    {
        [Required] 
        public string User_Name { get; set; } = string.Empty;
        [Required]
        public string Name { get; set; } = string.Empty;
        [Required]
        [EmailAddress]
        public string Email { get; set; } = string.Empty;
        [Required]
        public string Mobile_Number { get; set; } = string.Empty;
        
        public string? Password { get; set; } = string.Empty;
        public int Role_Id { get; set; } 
    }
  
    public class UpdateUserDto
    {
        [Required]
        public int User_Id { get; set; }
        [Required]
        public string User_Name { get; set; } = string.Empty;
        [Required]
        public string Name { get; set; } = string.Empty;
        [Required]
        [EmailAddress]
        public string Email { get; set; } = string.Empty;
        [Required]
        public string Mobile_Number { get; set; } = string.Empty;
       
        public string? Password { get; set; } = string.Empty;
        public int Role_Id { get; set; }
    }

}
