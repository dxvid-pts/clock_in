using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace backend.Models;

public class Account
{
    
}

public class LoginCredentials
{
    /// <summary>
    /// user account email address
    /// </summary>
    [Required]
    [EmailAddress(ErrorMessage = "Specified E-Mail address is invalid")]
    public string email { get; set; } = string.Empty;
    
    /// <summary>
    /// user account password
    /// </summary>
    [Required]
    [MinLength(8, ErrorMessage = "Specified password is invalid")]
    public string password { get; set; } = string.Empty;
}

public class TokenResponse
{
    /// <summary>
    /// token_type
    /// </summary>
    [Required]
    public string token_type { get; set; } = string.Empty;

    /// <summary>
    /// access_token
    /// </summary>
    [Required]
    public string access_token { get; set; } = string.Empty;
    
    /// <summary>
    /// expires_in
    /// </summary>
    [Required]
    public string expires_in { get; set; } = string.Empty;
}

public class ChangePassword
{
    /// <summary>
    /// user account email address
    /// </summary>
    [Required]
    [EmailAddress(ErrorMessage = "Specified E-Mail address is invalid")]
    public string email { get; set; } = string.Empty;

    /// <summary>
    /// old password about to be changed
    /// </summary>
    [Required]
    [MinLength(8, ErrorMessage = "Specified password is invalid")]
    public string old_password { get; set; } = string.Empty;

    /// <summary>
    /// new password
    /// </summary>
    [Required]
    [MinLength(8, ErrorMessage = "Specified password is invalid")]
    public string new_password { get; set; } = string.Empty;
}