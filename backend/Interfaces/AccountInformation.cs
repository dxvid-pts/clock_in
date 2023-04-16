using backend.Models;

namespace backend.Interfaces;

public class AccountInformation
{
    
    private int Id { get; }
    private String Email { get; }
    private String Role { get; }
    private DateTime? LastLogin { get; }
    private bool? Blocked { get; }
    
    
    public AccountInformation(Account account)
    {
        this.Id = account.Id;
        this.Email = account.Email;
        this.Role = account.Role;
        this.LastLogin = account.LastLogin;
        this.Blocked = account.Blocked;
    }
}