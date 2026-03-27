using Core.DTOs;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Core.Interfaces
{
    public interface IAuthService
    {
        Task<object> LoginAsync(LoginDto dto);
        Task UpdatePassword(PassWordChange dto);
        Task UpdateUserProfile(UserProfile dto);
    }
}
