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
    private readonly ClockInContext _clockInContext;

    /// <summary>
    /// constructor
    /// </summary>
    /// <param name="logger"></param>
    /// <param name="clockInContext"></param>
    public WorkController(ILogger<VacationController> logger, ClockInContext clockInContext)
    {
        _logger = logger;
        _clockInContext = clockInContext;
    }
    
    /// <summary>
    /// Start a new work session
    /// </summary>
    /// <returns></returns>
    /// <response code="200">Work session started</response>
    /// <response code="409">Not possible to start a new work session</response>
    [SuperiorAuthorize(Roles = Roles.Manager + Roles.Employee)]
    [HttpPost("start",Name = "Start Work")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public IActionResult StartWork()
    {
        var account = (Account) HttpContext.Items["User"]!;

        var runningWork = _clockInContext.Works.FirstOrDefault(w => w.AccountId == account.Id && w.End == null);

        if (runningWork != null)
        {
            return Conflict();
        }

        try
        {
            runningWork = new Work
            {
                Begin = DateTime.Now,
                AccountId = account.Id
            };

            _clockInContext.Works.Add(runningWork);

            return NoContent();
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
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public IActionResult StopWork()
    {
        var account = (Account) HttpContext.Items["User"]!;

        var runningWork = _clockInContext.Works.FirstOrDefault(w => w.AccountId == account.Id && w.End == null);

        if (runningWork == null)
        {
            return BadRequest();
        }

        runningWork.End = DateTime.Now;
        
        _clockInContext.Works.Update(runningWork);
        
        return NoContent();
    }
    
    /// <summary>
    /// Get all work sessions of one employee in a given month and year
    /// </summary>
    /// <returns></returns>
    /// <response code="200"></response>
    [SuperiorAuthorize(Roles = Roles.Employee + Roles.Admin + Roles.Manager)]
    [HttpGet("{userId}",Name = "Show Work")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(WorkInformation[]))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult ShowWork(int userId, int month, int year)
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

        var workList = _clockInContext.Works.Where(w => w.AccountId == account.Id && w.Begin.Month == month && w.Begin.Year == year).ToList()
            .Select(w => new WorkInformation(w));
        
        return Ok(workList);
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
    public IActionResult PatchWork(int workId, DateTime begin, DateTime end)
    {
        var account = (Account)HttpContext.Items["User"]!;

        var work = _clockInContext.Works.FirstOrDefault(w => w.AccountId == account.Id && w.Id == workId);

        if (work == null || begin >= end)
        {
            return Conflict();
        }

        work.Begin = begin;
        work.End = end;

        _clockInContext.Works.Update(work);
        
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
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    [ProducesResponseType(StatusCodes.Status409Conflict)]
    public IActionResult DeleteWork(int workId)
    {
        var account = (Account) HttpContext.Items["User"]!;

        var work = _clockInContext.Works.FirstOrDefault(w => w.AccountId == account.Id && w.Id == workId);

        if (work == null)
        {
            return Conflict();
        }

        _clockInContext.Works.Remove(work);
        
        return NoContent();
    }
}