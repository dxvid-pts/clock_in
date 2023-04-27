using backend.Attributes;
using backend.Database;
using backend.Interfaces;
using backend.Models;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

/// <summary>
/// contains routes used for sick leave operations
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class SickLeaveController : ControllerBase
{
    private readonly ILogger<SickLeaveController> _logger;
    private readonly ClockInContext _clockInContext;

    /// <summary>
    /// constructor
    /// </summary>
    /// <param name="logger"></param>
    public SickLeaveController(ILogger<SickLeaveController> logger, ClockInContext clockInContext)
    {
        _logger = logger;
        _clockInContext = clockInContext;
    }
    
    /// <summary>
    /// Hand in a sick leave request
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [SuperiorAuthorize(Roles = Roles.Employee + Roles.Manager)]
    [HttpPost]
    public IActionResult NewSickLeave([FromBody] ISickLeaveInput input)
    {
        Account account = (Account)HttpContext.Items["User"]!;
        SickLeave sickLeave = new SickLeave()
        {
            AccountId = account.Id,
            Begin = input.begin,
            End = input.end
        };
        _clockInContext.SickLeaves.Add(sickLeave);
        _clockInContext.SaveChanges();
        
        return Ok();
    }
}