using System.ComponentModel.DataAnnotations;
using backend.Models;

namespace backend.Interfaces;

public class ISickLeave
{
    public int Id { get; set; }

    public int AccountId { get; set; }

    public DateOnly Begin { get; set; }

    public DateOnly End { get; set; }
    
    public string Status { get; set; }

    public ISickLeave(SickLeave sickLeave)
    {
        Id = sickLeave.Id;
        AccountId = sickLeave.AccountId;
        Begin = sickLeave.Begin;
        End = sickLeave.End;
        Status = sickLeave.Status;
    }
}

public class ISickLeaveInput
{
    /// <summary>
    /// begin date
    /// <example>yyyy-MM-dd</example>
    /// </summary>
    //[RegularExpression(@"20\d{2}-(0\d|1[012])-([012]\d|3[01])")]
    public DateOnly begin { get; set; }
    
    /// <summary>
    /// end date
    /// <example>yyyy-MM-dd</example>
    /// </summary>
    //[RegularExpression(@"20\d{2}-(0\d|1[012])-([012]\d|3[01])")]
    public DateOnly end { get; set; }
}