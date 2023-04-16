﻿using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class SickLeave
{
    public int Id { get; set; }

    public int AccountId { get; set; }

    public DateOnly Begin { get; set; }

    public DateOnly End { get; set; }

    public virtual Account Account { get; set; } = null!;
}
