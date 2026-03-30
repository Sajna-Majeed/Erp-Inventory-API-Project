using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Entities
{
    public class ServiceTypeDto: Base_Entity
    {
        public int Id { get; set; }
        public string Code { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
    }
    public class ServiceItemDto: Base_Entity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int ServiceTypeId { get; set; }
        public string? Description { get; set; }
    }
    public class ProductDto: Base_Entity
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string? Description { get; set; }
    }
    public class LicenseTypeDto: Base_Entity
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }

    public class LicenseModelDto: Base_Entity
    {
        public int Id { get; set; }
        public string Name { get; set; }
    }
    public class PriceListDto: Base_Entity
    {
        public int Id { get; set; }

        public int ServiceTypeId { get; set; }
        public int ServiceItemId { get; set; }

        public int? ProductId { get; set; }
        public int? LicenseTypeId { get; set; }
        public int? LicenseModelId { get; set; }

        public decimal UnitRate { get; set; }
        public decimal? AlfRate { get; set; }

        public DateTime? EffectiveFrom { get; set; }
        public DateTime? EffectiveTo { get; set; }
    }
    public class ContractDto:   Base_Entity
    {
        public int Id { get; set; }
        public string QuoteNo { get; set; }
        public DateTime QuoteDate { get; set; }
        public int CustomerId { get; set; }

        public decimal TotalAmount { get; set; }
        public decimal Discount { get; set; }
        public decimal NetAmount { get; set; }

        public string? Terms { get; set; }

        public bool QuoteSent { get; set; }
        public bool ContractSigned { get; set; }
        public bool Invoiced { get; set; }
        public bool PaymentReceived { get; set; }
    }
    public class ContractLineDto: Base_Entity
    {
        public int Id { get; set; }
        public int ContractId { get; set; }

        public int ServiceTypeId { get; set; }
        public int ServiceItemId { get; set; }

        public int? ProductId { get; set; }
        public int? LicenseTypeId { get; set; }
        public int? LicenseModelId { get; set; }

        public DateTime? StartDate { get; set; }
        public DateTime? EndDate { get; set; }

        public int? Quantity { get; set; }
        public decimal? UnitRate { get; set; }
        public decimal? Total { get; set; }

        public decimal? AlfRate { get; set; }
        public decimal? AlfAmount { get; set; }

        public string? WorkOrderNo { get; set; }
        public decimal? WorkOrderAmount { get; set; }
    }

    public class PriceRequestDto
    {
        public int ServiceTypeId { get; set; }
        public int ServiceItemId { get; set; }

        public int? ProductId { get; set; }
        public int? LicenseTypeId { get; set; }
        public int? LicenseModelId { get; set; }
    }
}
