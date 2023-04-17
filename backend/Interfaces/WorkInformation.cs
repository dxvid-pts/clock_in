using backend.Models;

namespace backend.Interfaces;

public class WorkInformation
{
    public int Id { get;  }

    public DateTime Begin { get;  }

    public DateTime? End { get;  }

    public DateOnly Changed { get;  }

    public WorkInformation(Work work)
    {
        this.Id = work.Id;
        this.Begin = work.Begin;
        this.End = work.End;
        this.Changed = work.Changed;

    }
}