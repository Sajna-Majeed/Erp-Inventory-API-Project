using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IInvoiceService
    {
        Task<IEnumerable<InvoiceHeader>> GetInvoices();
        Task<InvoiceHeader> GetInvoiceById(int id);
        Task<int> CreateInvoiceAsync(CreateInvoiceDto dto);
        Task<bool> UpdateInvoiceAsync( UpdateInvoiceDto dto);
        Task DeleteInvoiceAsync(int id);

        Task<object> GetInvoiceTraking();
    }
}