using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class Work
{
    public int Id { get; set; }

    public int AccountId { get; set; }

    public DateTime Begin { get; set; }

    public DateTime? End { get; set; }

    public DateOnly Changed { get; set; }

    public virtual Account Account { get; set; } = null!;
}
