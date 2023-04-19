using backend.Attributes;
using backend.Database;
using backend.Interfaces;
using backend.Models;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

/// <summary>
/// contains routes on work path
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class WorkController : ControllerBase
{
    private readonly ILogger<VacationController> _logger;
    private readonly ClockInContext clockInContext;

    /// <summary>
    /// constructor
    /// </summary>
    /// <param name="logger"></param>
    /// <param name="clockInContext"></param>
    public WorkController(ILogger<VacationController> logger, ClockInContext clockInContext)
    {
        _logger = logger;
        this.clockInContext = clockInContext;
    }
    
    /// <summary>
    /// Start a new work session
    /// </summary>
    /// <returns></returns>
    /// <response code="200">Work session started</response>
    /// <response code="409">Not possible to start a new work session</response>
    [SuperiorAuthorize(Roles = Roles.Manager + Roles.Employee)]
    [HttpPost("start",Name = "Start Work")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public IActionResult StartWork()
    {
        var account = (Account) HttpContext.Items["User"];

        var running_work = this.clockInContext.Works.FirstOrDefault(w => w.AccountId == account.Id && w.End == null);

        if (running_work != null)
        {
            return Conflict();
        }

        try
        {
            running_work = new Work
            {
                AccountId = account.Id,
                Begin = DateTime.Now,
                End = null,
                Changed = default,
                Account = account
            };

            this.clockInContext.Works.Add(running_work);
            this.clockInContext.SaveChanges();
            
            return Ok();
        } catch
        {
            return Conflict();
        }
    }
    
    /// <summary>
    /// Stop the currently running work session
    /// </summary>
    /// <returns></returns>
    /// <response code="200">Work session stopped</response>
    /// <response code="400">Work session does not exist</response>
    /// <response code="409">Not possible to stop this work session</response>
    [SuperiorAuthorize(Roles = Roles.Employee + Roles.Admin + Roles.Manager)]
    [HttpPost("stop",Name = "Stop Work")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public IActionResult StopWork()
    {
        var account = (Account) HttpContext.Items["User"];

        var running_work = this.clockInContext.Works.FirstOrDefault(w => w.AccountId == account.Id && w.End == null);

        if (running_work == null)
        {
            return BadRequest();
        }

        running_work.End = DateTime.Now;
        
        this.clockInContext.Works.Update(running_work);
        this.clockInContext.SaveChanges();

        return Ok();
    }
    
    /// <summary>
    /// Get all work sessions of one employee in a given month and year
    /// </summary>
    /// <returns></returns>
    /// <response code="200"></response>
    [SuperiorAuthorize(Roles = Roles.Employee + Roles.Admin + Roles.Manager)]
    [HttpGet("{user_id}",Name = "Show Work")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(WorkInformation[]))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult ShowWork(int user_id, int month, int year)
    {
        var account = (Account) HttpContext.Items["User"];

        if (account.Role == Roles.Employee && user_id != account.Id)
        {
            return Forbid();
        }

        if (user_id != account.Id && account.Role == Roles.Manager && this.clockInContext.ManagerEmployees.FirstOrDefault(relation =>
                relation.Employee.Id == user_id && relation.Manager.Id == account.Id) == null)
        {
            return Forbid();
        }

        var work_list = clockInContext.Works.Where(w => w.AccountId == account.Id && w.Begin.Month == month && w.Begin.Year == year).ToList()
            .Select(w => new WorkInformation(w));
        
        return Ok(work_list);
    }
    
    /// <summary>
    /// Change a work session by a given id
    /// </summary>
    /// <returns></returns>
    /// <response code="200">Work session successfully updated</response>
    /// <response code="409">Illegal parameters</response>
    [SuperiorAuthorize(Roles = Roles.Employee + Roles.Admin + Roles.Manager)]
    [HttpPatch("session",Name = "Patch Work")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public IActionResult PatchWork(int work_id, DateTime begin, DateTime end)
    {
        var account = (Account) HttpContext.Items["User"];

        var work = clockInContext.Works.FirstOrDefault<Work>(w => w.AccountId == account.Id && w.Id == work_id);

        if (work == null || begin >= end)
        {
            return Conflict();
        }

        work.Begin = begin;
        work.End = end;

        clockInContext.Works.Update(work);
        clockInContext.SaveChanges();
        
        return Ok();
    }
    
    /// <summary>
    /// Delete a work session by a given id
    /// </summary>
    /// <returns></returns>
    /// <response code="200">Work session successfully deleted</response>
    /// <response code="409">Work session does not exist</response>
    [SuperiorAuthorize(Roles = Roles.Employee + Roles.Admin + Roles.Manager)]
    [HttpDelete("session",Name = "Delete Work")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public IActionResult DeleteWork(int work_id)
    {
        var account = (Account) HttpContext.Items["User"];

        var work = clockInContext.Works.FirstOrDefault<Work>(w => w.AccountId == account.Id && w.Id == work_id);

        if (work == null)
        {
            return Conflict();
        }

        clockInContext.Works.Remove(work);
        
        return Ok();
    }
}