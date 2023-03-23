using backend.Database;
using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Route("[controller]")]
public class VacationController : ControllerBase
{
    private readonly ILogger<VacationController> _logger;
    private readonly ClockInContext clockInContext;

    public VacationController(ILogger<VacationController> logger, ClockInContext clockInContext)
    {
        _logger = logger;
        this.clockInContext = clockInContext;
    }

    /// <summary>
    /// Creates a new Vacation Request
    /// </summary>
    /// <param name="begin">Timestamp which defines the begin of the vacation</param>
    /// <param name="end">Timestamp which defines the end of the vacation</param>
    /// <returns></returns>
    /// <response code="201">Submission successful</response>
    /// <response code="400">Submission rejected</response>
    [HttpPost(Name = "PostVacation")]
    [ProducesResponseType(StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult Post(int begin, int end)
    {
        return Ok();
    }

    /// <summary>
    /// Update a Vacation Request
    /// </summary>
    /// <param name="end">Timestamp to change the end to</param>
    /// <param name="status">New status to change the status to</param>
    /// <returns></returns>
    /// <response code="200">Change successful</response>
    /// <response code="400">Change rejected</response>
    [HttpPatch(Name = "PatchVacation")]
    [ProducesResponseType(StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public IActionResult Patch(int end, Status status)
    {
        return Ok();
    }
}