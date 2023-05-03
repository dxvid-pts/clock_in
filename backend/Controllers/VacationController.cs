using backend.Database;
using backend.Models;
using backend.Attributes;
using backend.Interfaces;
using backend.Utils;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

/// <summary>
/// contains routes on vacation path
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class VacationController : ControllerBase
{
    private readonly ILogger<VacationController> _logger;
    private readonly ClockInContext _clockInContext;

    /// <summary>
    /// constructor
    /// </summary>
    /// <param name="logger"></param>
    /// <param name="clockInContext"></param>
    public VacationController(ILogger<VacationController> logger, ClockInContext clockInContext)
    {
        _logger = logger;
        this._clockInContext = clockInContext;
    }

    /// <summary>
    /// Creates a new Vacation Request
    /// </summary>
    /// <returns></returns>
    /// <response code="201">Submission successful</response>
    /// <response code="400">Submission rejected</response>
    [SuperiorAuthorize(Roles = Roles.Employee)]
    [HttpPost(Name = "Request Vacation")]
    [ProducesResponseType(StatusCodes.Status201Created, Type = typeof(VacationModel))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult Post([FromBody] VacationInput input)
    {
        DateOnly begin = input.begin.ToDateOnly();
        DateOnly end = input.end.ToDateOnly();
        if (end.CompareTo(begin) < 0) return BadRequest();

        int remainingVacationDays = ((Account)HttpContext.Items["User"]).VacationDays;
        var vacations = _clockInContext.Vacations.Where(v => (v.Begin.Year == DateTime.Now.Year || v.End.Year == DateTime.Now.Year) && v.Status != "Canceled");
        foreach (Vacation exVacation in vacations)
        {
            var beginEx = exVacation.Begin.Year == DateTime.Now.Year ? exVacation.Begin.ToDateTime(new TimeOnly(0,0)) : new DateTime(DateTime.Now.Year, 1, 1);
            var endEx = exVacation.End.Year == DateTime.Now.Year ? exVacation.End.ToDateTime(new TimeOnly(0, 0)) : new DateTime(DateTime.Now.Year, 12, 31);

            remainingVacationDays -= beginEx.BusinessDaysUntil(endEx);
        }

        int vacationDays = begin.ToDateTime(new TimeOnly(0, 0)).BusinessDaysUntil(end.ToDateTime(new TimeOnly(0, 0)));
        if (vacationDays > remainingVacationDays)
        {
            return BadRequest("too much vacation days requested. cancel other vacations first");
        }

        int accountId = ((Account?)HttpContext.Items["User"])!.Id;
        Vacation vacation = new Vacation()
        {
            AccountId = accountId,
            Status = "Pending",
            Begin = begin,
            End = end,
            Changed = DateTime.Now
        };
        _clockInContext.Vacations.Add(vacation);
        _clockInContext.SaveChanges();
        
        return Ok(new VacationModel(vacation));
    }

    /// <summary>
    /// Update a Vacation Request
    /// </summary>
    /// <param name="id">ID of vacation request to be updated</param>
    /// <param name="input">input values</param>
    /// <returns></returns>
    /// <response code="200">Change successful</response>
    /// <response code="400">Change rejected</response>
    [SuperiorAuthorize(Roles = Roles.Employee + Roles.Manager)]
    [HttpPatch("{id}", Name = "Edit Vacation")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(VacationModel))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult Patch(int id, [FromBody] VacationInput input)
    {
        Vacation? vacation = _clockInContext.Vacations.FirstOrDefault(v => v.Id == id);
        if (vacation == null)
        {
            return BadRequest();
        }
        
        if (vacation.AccountId != ((Account?)HttpContext.Items["User"])!.Id)
        {
            return Forbid();
        }

        DateOnly begin = input.begin.ToDateOnly();
        DateOnly end = input.end.ToDateOnly();
        if (end.CompareTo(begin) < 0)
        {
            return BadRequest();
        }
        
        int remainingVacationDays = ((Account)HttpContext.Items["User"]).VacationDays;
        var vacations = _clockInContext.Vacations.Where(v => (v.Begin.Year == DateTime.Now.Year || v.End.Year == DateTime.Now.Year) && v.Id != id && v.Status != "Canceled");
        foreach (Vacation exVacation in vacations)
        {
            var beginEx = exVacation.Begin.Year == DateTime.Now.Year ? exVacation.Begin.ToDateTime(new TimeOnly(0,0)) : new DateTime(DateTime.Now.Year, 1, 1);
            var endEx = exVacation.End.Year == DateTime.Now.Year ? exVacation.End.ToDateTime(new TimeOnly(0, 0)) : new DateTime(DateTime.Now.Year, 12, 31);

            remainingVacationDays -= beginEx.BusinessDaysUntil(endEx);
        }

        int vacationDays = begin.ToDateTime(new TimeOnly(0, 0)).BusinessDaysUntil(end.ToDateTime(new TimeOnly(0, 0)));
        if (vacationDays > remainingVacationDays)
        {
            return BadRequest("too much vacation days requested. cancel other vacations first");
        }

        vacation.Begin = begin;
        vacation.End = end;
        vacation.Status = "Pending";
        _clockInContext.SaveChanges();
        
        return Ok(new VacationModel(vacation));
    }

    /// <summary>
    /// Cancel a Vacation
    /// </summary>
    /// <param name="id">ID of vacation request to be canceled</param>
    /// <returns></returns>
    /// <response code="200">Cancellation successful</response>
    /// <response code="400">Cancellation rejected</response>
    [SuperiorAuthorize(Roles = Roles.Employee)]
    [HttpDelete("{id}", Name = "Cancel Vacation")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(VacationModel))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult Delete(int id)
    {
        Vacation? vacation = _clockInContext.Vacations.FirstOrDefault(v => v.Id == id);
        if (vacation == null || vacation.End > DateTime.Now.ToDateOnly())
        {
            return BadRequest();
        }
        
        if (vacation.AccountId != ((Account?)HttpContext.Items["User"])!.Id)
        {
            return Forbid();
        }

        vacation.Status = "Canceled";
        _clockInContext.SaveChanges();
        
        return Ok(new VacationModel(vacation));
    }

    /// <summary>
    /// Review (approve) a vacation request
    /// </summary>
    /// <param name="id">ID of vacation request to be approved</param>
    /// <returns></returns>
    /// <response code="200">Approval successful</response>
    /// <response code="400">Approval rejected</response>
    [SuperiorAuthorize(Roles = Roles.Manager)]
    [HttpPatch("approve/{id}", Name = "Approve Vacation")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(VacationModel))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult Approve(int id)
    {
        Vacation? vacation = _clockInContext.Vacations.FirstOrDefault(v => v.Id == id);
        if (vacation == null)
        {
            return BadRequest();
        }

        vacation.Status = "Approved";
        _clockInContext.SaveChanges();
        
        return Ok(new VacationModel(vacation));
    }
    
    /// <summary>
    /// Review (decline) a vacation request
    /// </summary>
    /// <param name="id">ID of vacation request to be declined</param>
    /// <returns></returns>
    /// <response code="200">Rejection successful</response>
    /// <response code="400">Rejection rejected</response>
    [SuperiorAuthorize(Roles = Roles.Manager)]
    [HttpPatch("decline/{id}", Name = "Decline Vacation")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Vacation))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult Decline(int id)
    {
        Vacation? vacation = _clockInContext.Vacations.FirstOrDefault(v => v.Id == id);
        if (vacation == null)
        {
            return BadRequest();
        }

        vacation.Status = "Declined";
        _clockInContext.SaveChanges();
        
        return Ok(new VacationModel(vacation));
    }
    
    /// <summary>
    /// Get all vacations of a user in the given year
    /// </summary>
    /// <param name="userId">User ID of whom the vacations are</param>
    /// <param name="year">Year of vacations</param>
    /// <returns>A List of all vacations in the given year</returns>
    [SuperiorAuthorize(Roles = Roles.Manager + Roles.Employee + Roles.Admin)]
    [HttpGet("{year?}/{userId?}")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(IVacation[]))]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult Get(int userId, int year)
    {
        var account = (Account) HttpContext.Items["User"]!;
        if (userId < 1)
            userId = account.Id;
        if (year < 1)
            year = DateTime.Now.Year;

        if (account.Role == Roles.Employee && userId != account.Id)
        {
            return Forbid();
        }

        if (userId != account.Id && account.Role == Roles.Manager && this._clockInContext.ManagerEmployees.FirstOrDefault(relation =>
                relation.Employee.Id == userId && relation.ManagerId == account.Id) == null)
        {
            return Forbid();
        }

        var vacations = this._clockInContext.Vacations.Where(v => v.AccountId == userId && v.Begin.Year == year).Select(v => new IVacation(v)).ToList();
        
        return Ok(vacations);
    }

    /// <summary>
    /// Update the amount of vacation days for an account
    /// </summary>
    /// <param name="accountId"></param>
    /// <param name="days"></param>
    /// <returns></returns>
    [SuperiorAuthorize(Roles = Roles.Manager)]
    [HttpPatch("setvacationdaysfor/{accountId}/{days}")]
    [ProducesResponseType(StatusCodes.Status204NoContent)]
    [ProducesResponseType(StatusCodes.Status401Unauthorized)]
    [ProducesResponseType(StatusCodes.Status403Forbidden)]
    public IActionResult SetVacationDays(int accountId, int days)
    {
        Account operatorAccount = (Account)HttpContext.Items["User"]!;
        ManagerEmployee relation = _clockInContext.ManagerEmployees.FirstOrDefault(r => r.EmployeeId == accountId && r.ManagerId == operatorAccount.Id);

        if (relation == null) return Forbid();

        Account account = _clockInContext.Accounts.Find(accountId);
        account.VacationDays = days;
        _clockInContext.SaveChanges();
        return NoContent();
    }
}