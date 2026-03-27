namespace Core.Entities
{
    public class User : Base_Entity
    {
        public int User_Id { get; set; }
        public string User_Name { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public string Email { get; set; } = string.Empty;
        public string Mobile_Number { get; set; } = string.Empty;
        public string Password { get; set; } = string.Empty;
        public string Role_Id { get; set; } = string.Empty;
        public string Role { get; set; } = string.Empty;
    }
}
