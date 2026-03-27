using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IQuoteService
    {
        Task<string> GenerateQuoteNumberAsync();
        Task<IEnumerable<QuoteDto>> GetQuotes();
        Task<IEnumerable<FileAttchments>> GetFiles(int id);
        Task SaveQuoteFiles(List<FileAttchmentsDto> dto, int quoteId,List<int> ids);
        Task<QuoteHeader> GetQuoteById(int id);
        Task<QuoteInvoice> GetQuoteViewById(int id);
        Task<int> CreateQuoteAsync(CreateQuoteDto dto);
        Task<bool> UpdateQuoteAsync( UpdateQuoteDto dto);
        Task DeleteQuoteAsync(int id);
    }
}