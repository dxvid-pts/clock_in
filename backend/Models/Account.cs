using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class Account
{
    public int Id { get; set; }

    public string Email { get; set; } = null!;

    public string Password { get; set; } = null!;

    public string Role { get; set; } = null!;

    public DateTime? LastLogin { get; set; }

    public bool? Blocked { get; set; }

    public virtual ICollection<ManagerEmployee> ManagerEmployeeEmployees { get; } = new List<ManagerEmployee>();

    public virtual ICollection<ManagerEmployee> ManagerEmployeeManagers { get; } = new List<ManagerEmployee>();

    public virtual ICollection<Token> Tokens { get; } = new List<Token>();

    public virtual ICollection<Work> Works { get; } = new List<Work>();
}
