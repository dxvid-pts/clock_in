using backend.Models;

namespace backend.Interfaces;

public class AccountInformation
{

    public int Id { get;  } 
    public String Email { get;  } 
    public String Role { get;  } 
    public DateTime? LastLogin { get;  } 
    public bool? Blocked { get;  } 
    
    
    public AccountInformation(Account account)
    {
        this.Id = account.Id;
        this.Email = account.Email;
        this.Role = account.Role;
        this.LastLogin = account.LastLogin;
        this.Blocked = account.Blocked;
    }
}