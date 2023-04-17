using System.ComponentModel.DataAnnotations;

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
    public int id { get; set; } = 0;

    /// <summary>
    /// account id of user matching to this vacation dataset
    /// </summary>
    [Required]
    public int account_id { get; set; } = 0;
    
    /// <summary>
    /// begin of vacation
    /// </summary>
    [Required]
    public DateTime begin { get; set; }
    
    /// <summary>
    /// end of vacation
    /// </summary>
    public DateTime end { get; set; }
    
    /// <summary>
    /// status can be "PENDING", "APPROVED", "DECLINED", "CANCELED"
    /// </summary>
    [Required]
    public string status { get; set; } = string.Empty;
    
    /// <summary>
    /// when was the dataset changed?
    /// </summary>
    [Required]
    public DateTime changed { get; set; }
}

/// <summary>
/// input data for creating/editing a vacation request
/// </summary>
public class VacationInput
{
    /// <summary>
    /// begin time
    /// </summary>
    public DateTime begin { get; set; }
    
    /// <summary>
    /// end time
    /// </summary>
    public DateTime end { get; set; }
}

/// <summary>
/// input data for reviewing a vacation request
/// </summary>
public class VacationReviewInput
{
    /// <summary>
    /// the status the request should be set to
    /// </summary>
    [Required]
    [RegularExpression("APPROVED|DECLINED", ErrorMessage = "Allowed values for status property: 'APPROVED', 'DECLINED'")]
    public string status { get; set; } = string.Empty;
}