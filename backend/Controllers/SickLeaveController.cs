using backend.Database;
using backend.Interfaces;
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

    
    public IActionResult Post(int accountId, [FromBody] SickLeaveInput input)
    {
        return Ok();
    }
}