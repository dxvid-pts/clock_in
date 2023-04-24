using System.ComponentModel.DataAnnotations;
using backend.Utils;
using Microsoft.OpenApi.Models;

namespace backend.Models;

/// <summary>
/// Vacation model as in the database
/// </summary>
public class VacationModel
{
    /// <summary>
    /// id
    /// </summary>
    [Required]
    public int Id { get; set; } = 0;

    /// <summary>
    /// account id of user matching to this vacation dataset
    /// </summary>
    [Required]
    public int AccountId { get; set; } = 0;
    
    /// <summary>
    /// begin of vacation
    /// </summary>
    [Required]
    public DateOnly Begin { get; set; }
    
    /// <summary>
    /// end of vacation
    /// </summary>
    public DateOnly End { get; set; }
    
    /// <summary>
    /// status can be "PENDING", "APPROVED", "DECLINED", "CANCELED"
    /// </summary>
    [Required]
    public string Status { get; set; } = string.Empty;
    
    /// <summary>
    /// when was the dataset changed?
    /// </summary>
    [Required]
    public DateOnly Changed { get; set; }

    public VacationModel(Vacation vacation)
    {
        Id = vacation.Id;
        AccountId = vacation.AccountId;
        Begin = vacation.Begin;
        End = vacation.End;
        Status = vacation.Status;
        Changed = vacation.Changed.ToDateOnly();
    }
}

/// <summary>
/// input data for creating/editing a vacation request
/// </summary>
public class VacationInput
{
    // /// <summary>
    // /// begin date, time doesnt matter but has to be specified
    // /// </summary>
    // public DateTime begin { get; set; }
    //
    // /// <summary>
    // /// end date, time doesnt matter but has to be specified
    // /// </summary>
    // public DateTime end { get; set; }
    
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

// /// <summary>
// /// input data for reviewing a vacation request
// /// </summary>
// public class VacationReviewInput
// {
//     /// <summary>
//     /// the status the request should be set to
//     /// </summary>
//     [Required]
//     [RegularExpression("APPROVED|DECLINED", ErrorMessage = "Allowed values for status property: 'APPROVED', 'DECLINED'")]
//     public string status { get; set; } = string.Empty;
// }