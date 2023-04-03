using Microsoft.AspNetCore.Mvc;
using backend.Models;
using backend.Attributes;
using backend.Database;
using backend.Utils;

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
    private readonly TokenUtils _tokenUtils;

    /// <summary>
    /// constructor
    /// </summary>
    /// <param name="configuration"></param>
    /// <param name="logger"></param>
    public AccountController(IConfiguration configuration, ILogger<AccountController> logger, TokenUtils tokenUtils,
        ClockInContext clockInContext)
    {
        _configuration = configuration;
        _logger = logger;
        _tokenUtils = tokenUtils;
        _clockInContext = clockInContext;
        _logger.Log(LogLevel.Debug, configuration.GetConnectionString("Database"));
    }

    /// <summary>
    /// Log in a user
    /// </summary>
    /// <remarks>
    /// Returned jwt token needs to be provided in the Authorization Header upon submitting a request.<br/>
    /// Authorization Header contents schema: "Bearer TOKEN"<br/>
    /// This api is session-less and provides no methods for logging a user out. The token is the key for all requests, so you can just throw it away to log a user out.
    /// </remarks>
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

        return Ok(_tokenUtils.CreateAccessToken(user));
    }

    /// <summary>
    /// Change a users password
    /// </summary>
    /// <returns></returns>
    [Authorize]
    [HttpPut("password")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public IActionResult ChangePassword(ChangePassword changePassword)
    {
        Account? account = _clockInContext.Accounts.FirstOrDefault(p =>
            p.Email == changePassword.email && p.Password == changePassword.old_password);

        if (account == null)
            return BadRequest();

        account.Password = changePassword.new_password;
        _clockInContext.SaveChanges();
        
        return NoContent();
    }

    /// <summary>
    /// Refresh an access token using a refresh token
    /// </summary>
    /// <remarks>
    /// Not implemented yet!
    /// </remarks>
    /// <returns>A newly generated JWT Token</returns>
    [Authorize]
    [HttpPost("refresh_token")]
    [ProducesResponseType(typeof(TokenResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public IActionResult RefreshToken()
    {
        return Ok("Logic not implemented yet");
    }

    /// <summary>
    /// test permissions with jwt for employee
    /// </summary>
    /// <returns></returns>
    [Authorize(Roles = Roles.Employee)]
    [HttpGet("testemp")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult TestEmployeePerms()
    {
        return Ok();
    }

    /// <summary>
    /// test permissions with jwt for manager
    /// </summary>
    /// <returns></returns>
    [Authorize(Roles = Roles.Manager)]
    [HttpGet("testman")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult TestManagerPerms(HttpContext context)
    {
        return Ok(context.Items["User"] );
    }

    /// <summary>
    /// test permissions with jwt for employee + manager
    /// </summary>
    /// <returns></returns>
    [Authorize(Roles = Roles.Employee + Roles.Manager)]
    [HttpGet("testcomb")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult TestCombinedPerms()
    {
        return Ok();
    }
}