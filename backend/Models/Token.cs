using System;
using System.Collections.Generic;

namespace backend.Models;

public partial class Token
{
    public int Id { get; set; }

    public int AccountId { get; set; }

    public DateTime Expiration { get; set; }

    public string Content { get; set; } = null!;

    public virtual Account Account { get; set; } = null!;
}
