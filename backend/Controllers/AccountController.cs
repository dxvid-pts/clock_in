using Microsoft.AspNetCore.Mvc;
using backend.Models;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using backend.Attributes;
using backend.Database;
using Microsoft.IdentityModel.Tokens;

namespace backend.Controllers;

/// <summary>
/// contains routes used for account operations
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class AccountController : ControllerBase
{
    private readonly ILogger<AccountController> _logger;
    private readonly IConfiguration _configuration;
    private readonly ClockInContext _clockInContext;

    /// <summary>
    /// constructor
    /// </summary>
    /// <param name="configuration"></param>
    /// <param name="logger"></param>
    public AccountController(IConfiguration configuration, ILogger<AccountController> logger, ClockInContext clockInContext)
    {
        _configuration = configuration;
        _logger = logger;
        _clockInContext = clockInContext;
    }

    /// <summary>
    /// Log in a user
    /// </summary>
    /// <returns>JWT token containing users role as plain text in response body</returns>
    [HttpPost("login")]
    [ProducesResponseType(typeof(TokenResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public IActionResult Login(LoginCredentials loginCredentials)
    {
        Account? user = _clockInContext.Accounts
            .FirstOrDefault(p => p.Email == loginCredentials.email && p.Password == loginCredentials.password);

        if (user == null)
            return Unauthorized();
        
        List<Claim> claims = new()
        {
            new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
            new Claim(ClaimTypes.Role, user.Role)
        };
        
        var symmetricKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(_configuration["Jwt:Key"] ?? throw new InvalidOperationException()));
        var exp = DateTime.UtcNow.AddMinutes(30);
        JwtSecurityToken token = new JwtSecurityToken(
            _configuration["Jwt:Issuer"],
            _configuration["Jwt:Audience"],
            claims,
            expires: exp,
            signingCredentials: new SigningCredentials(symmetricKey, SecurityAlgorithms.HmacSha256)
        );
        
        var tokenHandler = new JwtSecurityTokenHandler();
        var tokenStr = tokenHandler.WriteToken(token);
        return Ok(new TokenResponse()
        {
            access_token = tokenStr,
            expires_in = "30",
            token_type = "Bearer"
        });
    }

    /// <summary>
    /// Change a users password
    /// </summary>
    /// <returns></returns>
    [HttpPut("password")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public IActionResult ChangePassword(ChangePassword changePassword)
    {
        return NoContent();
    }

    [Authorize(Roles = "Manager")]
    [HttpGet("test")]
    public IActionResult Test()
    {
        return NoContent();
    }
}