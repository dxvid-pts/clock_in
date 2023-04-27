using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class SickLeave
{
    public int Id { get; set; }

    public int AccountId { get; set; }

    public DateOnly Begin { get; set; }

    public DateOnly End { get; set; }

    public DateTime Created { get; set; }

    public DateTime Changed { get; set; }
    
    public string Status { get; set; }

    public virtual Account Account { get; set; } = null!;
}
