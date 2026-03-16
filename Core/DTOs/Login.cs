
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
        public List<MenuItem>? MenuItems { get; set; }
    }
    public class MenuItem
    {
        public string Name { get; set; } = string.Empty;
        public int DisplayOrder { get; set; }
    }
}
