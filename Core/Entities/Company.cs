namespace Core.Entities
{
    public class Company : Base_Entity
    {
        public int Company_Id { get; set; }
        public string Name { get; set; } = string.Empty;
        public string Address_Line { get; set; } = string.Empty;
        public string City { get; set; } = string.Empty;
        public string Country_Subdivision { get; set; } = string.Empty;
        public string Country { get; set; } = string.Empty;
        public string Zip_Code { get; set; } = string.Empty;
        public string Contact_Person { get; set; } = string.Empty;
        public string Contact_Email { get; set; } = string.Empty;
        public string Contact_Number { get; set; } = string.Empty;
        public string Currency { get; set; } = string.Empty;
        public int Decimalplace { get; set; } 
        public int Taxlimit { get; set; } 
    }
}
