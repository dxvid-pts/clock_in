using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class Vacation
{
    public int Id { get; set; }

    public int AccountId { get; set; }

    public DateOnly Begin { get; set; }

    public DateOnly End { get; set; }

    public string? Status { get; set; }

    public DateOnly Changed { get; set; }

    public virtual Account Account { get; set; } = null!;
}
