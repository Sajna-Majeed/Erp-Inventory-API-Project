
namespace Core.DTOs
{
    public class LoginDto
    {
        public string Username { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
    }
    public class MenuList
    {
        public string Name { get; set; } = string.Empty;
        public int DisplayOrder { get; set; }
        public string? Icon { get; set; }
        public string? Link { get; set; } 
        public List<MenuItem>? MenuItems { get; set; }
    }
    public class MenuItem
    {
        public string Name { get; set; } = string.Empty;
        public string? Icon { get; set; }
        public string? Link { get; set; }
        public int DisplayOrder { get; set; }
    }

    public class UserProfile
    {
        public string Name { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Mobile_Number { get; set; } = string.Empty;
        public string? Password { get; set; } = string.Empty;
    }
    public class PassWordChange
    {
        public string? CurrentPassword { get; set; } = string.Empty;
        public string? NewPassword { get; set; } = string.Empty;
    }
}
