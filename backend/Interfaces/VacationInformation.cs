using backend.Models;

namespace backend.Interfaces;

public class VacationInformation
{

    public DateOnly Begin { get;  }

    public DateOnly End { get;  }

    public string? Status { get;  }

    public DateOnly Changed { get;  }

    public VacationInformation(Vacation vacation)
    {
        this.Begin = vacation.Begin;
        this.End = vacation.End;
        this.Status = vacation.Status;
        this.Changed = vacation.Changed;
    }
    
}