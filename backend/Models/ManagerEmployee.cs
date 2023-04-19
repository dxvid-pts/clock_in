using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class ManagerEmployee
{
    public int Id { get; set; }

    public int ManagerId { get; set; }

    public int EmployeeId { get; set; }

    public DateTime Created { get; set; }

    public DateTime Changed { get; set; }

    public virtual Account Employee { get; set; } = null!;

    public virtual Account Manager { get; set; } = null!;
}
