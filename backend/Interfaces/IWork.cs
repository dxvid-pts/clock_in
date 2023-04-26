using backend.Models;

namespace backend.Interfaces;

public class IWork
{
    public int Id { get;  }

    public DateTime Begin { get;  }

    public DateTime? End { get;  }

    public DateTime Changed { get;  }

    public IWork(Work work)
    {
        this.Id = work.Id;
        this.Begin = work.Begin;
        this.End = work.End;
        this.Changed = work.Changed;

    }
}