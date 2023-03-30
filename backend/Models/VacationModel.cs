using System.ComponentModel.DataAnnotations;

namespace backend.Models;

/// <summary>
/// Vacation model as in the database
/// </summary>
public class Vacation
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