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
    /// Hand in a sick leave request (gets approved automatically)
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [SuperiorAuthorize(Roles = Roles.Employee + Roles.Manager)]
    [HttpPost]
    [ProducesResponseType(typeof(ISickLeave), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    public IActionResult NewSickLeave([FromBody] ISickLeaveInput input)
    {
        Account account = (Account)HttpContext.Items["User"]!;
        
        if (input.begin > input.end)
        {
            return Conflict();
        }

        SickLeave existingSickLeave = _clockInContext.SickLeaves.FirstOrDefault(s => s.Account.Id == account.Id &&
            ((input.begin >= s.Begin && input.begin <= s.End) ||
             (input.end >= s.Begin && input.end <= s.End))
        );
        if (existingSickLeave != null)
        {
            if (input.end > existingSickLeave.End)
            {
                existingSickLeave.End = input.end;
            }

            if (input.begin < existingSickLeave.Begin)
            {
                existingSickLeave.Begin = input.begin;
            }

            _clockInContext.SaveChanges();
            cancelVacation(account.Id, existingSickLeave.Begin, existingSickLeave.End);
            return Ok(new ISickLeave(existingSickLeave));
        }
        
        // string status = _clockInContext.ManagerEmployees.Any(r => r.Employee.Id == account.Id) ? "Pending" : "Approved";
        string status = "Approved";
        
        SickLeave sickLeave = new SickLeave()
        {
            AccountId = account.Id,
            Begin = input.begin,
            End = input.end,
            Status = status
        };
        _clockInContext.SickLeaves.Add(sickLeave);
        _clockInContext.SaveChanges();

        if (status == "Approved")
        {
            cancelVacation(account.Id, input.begin, input.end);
        }
        
        return Ok(new ISickLeave(sickLeave));
    }


    private void cancelVacation(int accountId, DateOnly begin, DateOnly end)
    {
        Vacation vacation = _clockInContext.Vacations.FirstOrDefault(v => v.Account.Id == accountId &&
                                                      ((begin >= v.Begin && begin <= v.End) ||
                                                       (end >= v.Begin && end <= v.End))
        );
        if (vacation == null) return;
        vacation.Status = "Canceled";
        _clockInContext.SaveChanges();
    }
}