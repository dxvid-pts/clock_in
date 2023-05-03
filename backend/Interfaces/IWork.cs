using System.ComponentModel.DataAnnotations;
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

public class IMonthSelector
{
    [Required]
    [Range(typeof(int), "1", "12", ErrorMessage = "Invalid Month")]
    public int Month { get; init; }
    
    [Required]
    [Range(typeof(int), "2000", "2100", ErrorMessage = "Invalid Year")]
    public int Year { get; init; }
}

public class IWorkDateRange
{
    [Required]
    public DateTime begin { get; init; }
    
    [Required]
    public DateTime end { get; init; }
}

public class IWorkTimeRange
{
    [Required]
    public TimeOnly begin { get; init; }
    
    [Required]
    public TimeOnly end { get; init; }
}

public class IWorkNBreakTime
{
    [Required]
    public TimeOnly worktime { get; init; }
    
    [Required]
    public TimeOnly breaktime { get; init; }
}