using backend.Database;
using backend.Models;
using backend.Attributes;
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
    private readonly ClockInContext clockInContext;

    /// <summary>
    /// constructor
    /// </summary>
    /// <param name="logger"></param>
    /// <param name="clockInContext"></param>
    public VacationController(ILogger<VacationController> logger, ClockInContext clockInContext)
    {
        _logger = logger;
        this.clockInContext = clockInContext;
    }

    /// <summary>
    /// Creates a new Vacation Request
    /// </summary>
    /// <returns></returns>
    /// <response code="201">Submission successful</response>
    /// <response code="400">Submission rejected</response>
    [Authorize(Roles = Roles.Employee)]
    [HttpPost(Name = "Request Vacation")]
    [ProducesResponseType(StatusCodes.Status201Created, Type = typeof(Vacation))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult Post([FromBody] VacationInput input)
    {
        Vacation vacation = new Vacation()
        {
            id = 1234,
            account_id = ((Account?)HttpContext.Items["User"])!.Id,
            status = "PENDING",
            begin = input.begin,
            end = input.end,
            changed = DateTime.Now
        };
        return Ok(vacation);
    }

    /// <summary>
    /// Update a Vacation Request
    /// </summary>
    /// <param name="id">ID of vacation request to be updated</param>
    /// <param name="input">input values</param>
    /// <returns></returns>
    /// <response code="200">Change successful</response>
    /// <response code="400">Change rejected</response>
    [Authorize(Roles = Roles.Employee + Roles.Manager)]
    [HttpPatch("{id}", Name = "Edit Vacation")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Vacation))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult Patch(int id, [FromBody] VacationInput input)
    {
        Vacation vacation = new Vacation()
        {
            id = id,
            account_id = ((Account?)HttpContext.Items["User"])!.Id,
            status = "PENDING",
            begin = input.begin,
            end = input.end,
            changed = DateTime.Now
        };
        return Ok(vacation);
    }

    /// <summary>
    /// Cancel a Vacation
    /// </summary>
    /// <param name="id">ID of vacation request to be canceled</param>
    /// <param name="input">input values</param>
    /// <returns></returns>
    /// <response code="200">Cancellation successful</response>
    /// <response code="400">Cancellation rejected</response>
    [Authorize(Roles = Roles.Employee)]
    [HttpDelete("{id}", Name = "Cancel Vacation")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Vacation))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult Delete(int id)
    {
        Vacation vacation = new Vacation
        {
            id = id,
            account_id = ((Account?)HttpContext.Items["User"])!.Id,
            status = "CANCELED"
        };
        return Ok(vacation);
    }

    /// <summary>
    /// Review (approve/decline) a vacation request
    /// </summary>
    /// <param name="id">ID of vacation request to be reviewed</param>
    /// <param name="input">input values</param>
    /// <returns></returns>
    /// <response code="200">Review successful</response>
    /// <response code="400">Review rejected</response>
    [Authorize(Roles = Roles.Manager)]
    [HttpPatch("review/{id}", Name = "Review Vacation")]
    [ProducesResponseType(StatusCodes.Status200OK, Type = typeof(Vacation))]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult Review(int id, [FromBody] VacationReviewInput input)
    {
        Vacation vacation = new Vacation
        {
            id = id,
            account_id = 1234,
            status = input.status
        };
        return Ok(vacation);
    }
}