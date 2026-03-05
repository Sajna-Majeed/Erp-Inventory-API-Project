namespace Core.Entities
{
    public abstract class BaseEntity
    {
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedOn { get; set; }
    }
    public abstract class Base_Entity
    {
        public bool Is_Active { get; set; }
        public int Created_By { get; set; }
        public DateTime Created_On { get; set; }
        public int? Updated_By { get; set; }
        public DateTime? Updated_On { get; set; }
    }

}
