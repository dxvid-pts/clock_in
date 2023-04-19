using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using backend.Models;

namespace backend.Interfaces;

public class IAccount
{

    public int Id { get;  } 
    public String Email { get;  } 
    public String Role { get;  } 
    public DateTime? LastLogin { get;  } 
    public bool? Blocked { get;  } 
    
    public TimeOnly WorkTime { get;  }

    public TimeOnly BeginTime { get;  }

    public TimeOnly EndTime { get;  }

    public TimeOnly BreakTime { get;  }

    public int VacationDays { get;  }

    
    public IAccount(Account account)
    {
        this.Id = account.Id;
        this.Email = account.Email;
        this.Role = account.Role;
        this.LastLogin = account.LastLogin;
        this.Blocked = account.Blocked;
        this.WorkTime = account.WorkTime;
        this.BeginTime = account.BeginTime;
        this.EndTime = account.EndTime;
        this.BreakTime = account.BreakTime;
        this.VacationDays = account.VacationDays;
    }
}

/// <summary>
/// Model for creating a new account
/// </summary>
public class ICreateAccount
{
    /// <summary>
    /// user account email address
    /// </summary>
    [Required]
    [EmailAddress(ErrorMessage = "Specified E-Mail address is invalid")]
    public string Email { get; set; } = string.Empty;
    
    [Required]
    public string Role { get; set; }
    
    [Required]
    public TimeOnly WorkTime { get; set; }
    
    [Required]
    public TimeOnly BeginTime { get; set; }
    
    [Required]
    public TimeOnly EndTime { get; set; }
    
    [Required]
    public TimeOnly BreakTime { get; set; }
    
    [Required]
    [Description("Amount of vacations days per year")]
    public int VacationDays { get; set; }
}