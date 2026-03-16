using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IInvoiceService
    {
        Task<string> GenerateInvoiceNumberAsync();
        Task<IEnumerable<InvoiceDto>> GetInvoices();
        Task<InvoiceHeader> GetInvoiceById(int id);
        Task<int> CreateInvoiceAsync(CreateInvoiceDto dto);
        Task<bool> UpdateInvoiceAsync( UpdateInvoiceDto dto);
        Task DeleteInvoiceAsync(int id);
    }
}