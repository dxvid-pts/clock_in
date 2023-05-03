using backend.Models;

namespace backend.Interfaces;

public class IVacation
{
    public int Id { get; }
    public DateOnly Begin { get;  }

    public DateOnly End { get;  }

    public string? Status { get;  }

    public DateTime Changed { get;  }

    public IVacation(Vacation vacation)
    {
        this.Id = vacation.Id;
        this.Begin = vacation.Begin;
        this.End = vacation.End;
        this.Status = vacation.Status;
        this.Changed = vacation.Changed;
    }
    
}