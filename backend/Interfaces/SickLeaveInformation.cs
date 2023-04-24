using System.ComponentModel.DataAnnotations;
using backend.Models;

namespace backend.Interfaces;

public class SickLeaveInformation
{
    public int Id { get; set; }

    public int AccountId { get; set; }

    public DateOnly Begin { get; set; }

    public DateOnly End { get; set; }

    public SickLeaveInformation(SickLeave sickLeave)
    {
        Id = sickLeave.Id;
        AccountId = sickLeave.AccountId;
        Begin = sickLeave.Begin;
        End = sickLeave.End;
    }
}

public class SickLeaveInput
{
    /// <summary>
    /// begin date
    /// <example>yyyy-MM-dd</example>
    /// </summary>
    [RegularExpression(@"20\d{2}-(0\d|1[012])-([012]\d|3[01])")]
    public string begin { get; set; }
    
    /// <summary>
    /// end date
    /// <example>yyyy-MM-dd</example>
    /// </summary>
    [RegularExpression(@"20\d{2}-(0\d|1[012])-([012]\d|3[01])")]
    public string end { get; set; }
}