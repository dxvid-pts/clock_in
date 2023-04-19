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