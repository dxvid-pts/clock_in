using Microsoft.AspNetCore.Mvc;
using backend.Models;

namespace backend.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AccountController : ControllerBase
{
    private readonly ILogger<AccountController> _logger;
    
    public AccountController(ILogger<AccountController> logger)
    {
        _logger = logger;
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
        return Ok();
    }

    /// <summary>
    /// Change a users password
    /// </summary>
    /// <returns></returns>
    [HttpPut("password")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public IActionResult Register(ChangePassword changePassword)
    {
        return NoContent();
    }
}