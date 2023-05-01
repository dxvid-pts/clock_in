using System.Runtime.InteropServices.JavaScript;
using Microsoft.AspNetCore.Mvc;
using backend.Models;
using backend.Attributes;
using backend.Database;
using backend.Interfaces;
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
    /// <param name="tokenUtils"></param>
    /// <param name="clockInContext"></param>
    public AccountController(IConfiguration configuration, ILogger<AccountController> logger, TokenUtils tokenUtils,
        ClockInContext clockInContext)
    {
        _logger = logger;
        _configuration = configuration;
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
        
        user.LastLogin = DateTime.Now;
        _clockInContext.SaveChanges();

        return Ok(_tokenUtils.CreateAccessToken(user));
    }

    /// <summary>
    /// Change a users password
    /// </summary>
    /// <returns></returns>
    [SuperiorAuthorize]
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
    [SuperiorAuthorize]
    [HttpPost("refresh_token")]
    [ProducesResponseType(typeof(TokenResponse), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public IActionResult RefreshToken()
    {
        return Ok("Logic not implemented yet");
    }

    /// <summary>
    /// Create a new Account
    /// </summary>
    /// <returns>Password for the new Account</returns>
    [SuperiorAuthorize(Roles = Roles.Admin)]
    [HttpPost("create")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(String))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult CreateAccount(ICreateAccount account)
    {
        var account_with_same_email = _clockInContext.Accounts.FirstOrDefault(a => a.Email == account.Email);
        
        if (account_with_same_email != null)
        {
            return BadRequest();
        }
        
        try
        {
            var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            var password_array = new char[12];
            var random = new Random();

            for (int i = 0; i < password_array.Length; i++)
            {
                password_array[i] = chars[random.Next(chars.Length)];
            }

            var password = new String(password_array);
            
            Console.WriteLine(account.BeginTime);
            
            var new_account = new Account
            {
                Email = account.Email,
                Role = account.Role,
                Password = password,
                WorkTime = account.WorkTime,
                BeginTime = account.BeginTime,
                EndTime = account.EndTime,
                BreakTime = account.BreakTime,
                VacationDays = account.VacationDays
            };

            _clockInContext.Accounts.Add(new_account);
            _clockInContext.SaveChanges();

            if (account.ManagerId > 0)
            {
                var newRelation = new ManagerEmployee
                {
                    EmployeeId = new_account.Id,
                    ManagerId = account.ManagerId
                };

                _clockInContext.ManagerEmployees.Add(newRelation);
                _clockInContext.SaveChanges();
            }

            return Ok(password);
        }
        catch (Exception e)
        {
            return BadRequest();
        }
    }
    
    /// <summary>
    /// Get account specific information
    /// </summary>
    /// <returns></returns>
    [SuperiorAuthorize(Roles = Roles.Employee + Roles.Manager + Roles.Admin)]
    [HttpGet("{userId}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult GetAccountInformation(int userId)
    {
        var account = (Account) HttpContext.Items["User"]!;

        if (account.Role == Roles.Employee && userId != account.Id)
        {
            return Forbid();
        }

        if (userId != account.Id && account.Role == Roles.Manager && _clockInContext.ManagerEmployees.FirstOrDefault(relation =>
                relation.Employee.Id == userId && relation.Manager.Id == account.Id) == null)
        {
            return Forbid();
        }

        Account? result = _clockInContext.Accounts.Find(userId);

        if (result == null)
        {
            return NotFound("Account does not exist");
        }

        return Ok(new IAccount(result));
    }
    
    /// <summary>
    /// Update role of an account
    /// </summary>
    /// <returns></returns>
    [SuperiorAuthorize(Roles = Roles.Admin)]
    [HttpPatch("{userId}/{role}")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult ChangeRole(int userId, string role)
    {
        var account = _clockInContext.Accounts.Find(userId);

        if (account == null)
        {
            return NotFound();
        }

        try
        {
            account.Role = role;
            _clockInContext.Accounts.Update(account);
            _clockInContext.SaveChanges();
        }
        catch
        {
            return BadRequest();
        }

        return Ok();
    }

    /// <summary>
    /// Assign Employee/Manager to manager. If a relation already exists, it will be updated
    /// </summary>
    /// <param name="employeeId"></param>
    /// <param name="managerId"></param>
    /// <returns></returns>
    [SuperiorAuthorize(Roles = Roles.Admin)]
    [HttpPatch("employeetomanager/{employeeId}/{managerId}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult AddEmployeeToManager(int employeeId, int managerId)
    {
        var employee = _clockInContext.Accounts.Find(employeeId);
        var manager = _clockInContext.Accounts.Find(managerId);

        if (employee == null || manager is not { Role: Roles.Manager })
        {
            return BadRequest();
        }

        var relation = _clockInContext.ManagerEmployees.FirstOrDefault(
            r =>
                r.EmployeeId == employeeId
        );

        if (relation == null)
        {
            relation = new ManagerEmployee
            {
                EmployeeId = employeeId,
                ManagerId = managerId
            };
            _clockInContext.ManagerEmployees.Add(relation);
        }
        else
        {
            relation.ManagerId = managerId;
            _clockInContext.ManagerEmployees.Update(relation);
        }

        _clockInContext.SaveChanges();
        return NoContent();
    }

    /// <summary>
    /// rm -rf user
    /// </summary>
    /// <param name="accountId"></param>
    /// <returns></returns>
    [SuperiorAuthorize(Roles = Roles.Admin + Roles.Manager)]
    [HttpDelete("block/{accountId}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult BlockAccount(int accountId)
    {
        Account deletor = (Account)HttpContext.Items["User"]!;
        ManagerEmployee relation = _clockInContext.ManagerEmployees.FirstOrDefault(r => r.EmployeeId == accountId);

        if (deletor.Role != Roles.Admin && (relation == null || relation.ManagerId != deletor.Id))
        {
            return Forbid();
        }

        Account victim = _clockInContext.Accounts.Find(accountId);
        if (victim == null) return BadRequest();
        victim.Blocked = true;
        _clockInContext.SaveChanges();
        return NoContent();
    }

    /// <summary>
    /// You made a mistake? Ask an admin for help and buy the poor guy some chocolate!
    /// </summary>
    /// <param name="accountId"></param>
    /// <returns></returns>
    [SuperiorAuthorize(Roles = Roles.Admin)]
    [HttpPatch("unblock/{accountId}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult UnblockAccount(int accountId)
    {
        Account luckyGuy = _clockInContext.Accounts.Find(accountId);
        if (luckyGuy == null) return BadRequest();
        luckyGuy.Blocked = false;
        _clockInContext.SaveChanges();
        return NoContent();
    }
}