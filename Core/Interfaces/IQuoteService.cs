using Core.DTOs;
using Core.Entities;

namespace Core.Interfaces
{
    public interface IQuoteService
    {
        Task<string> GenerateQuoteNumberAsync();
        Task<IEnumerable<QuoteDto>> GetQuotes();
        Task<FileAttchments> GetFiles(int id);
        Task<QuoteHeader> GetQuoteById(int id);
        Task<int> CreateQuoteAsync(CreateQuoteDto dto);
        Task<bool> UpdateQuoteAsync( UpdateQuoteDto dto);
        Task DeleteQuoteAsync(int id);
    }
}