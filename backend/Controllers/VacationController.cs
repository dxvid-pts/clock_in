using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

[ApiController]
[Route("[controller]")]
public class VacationController : ControllerBase
{
    private readonly ILogger<VacationController> _logger;

    public VacationController(ILogger<VacationController> logger)
    {
        _logger = logger;
    }

    /// <summary>
    /// Creates a new Vacation Request
    /// </summary>
    /// <param name="begin">Timestamp which defines the begin of the vacation</param>
    /// <param name="end">Timestamp which defines the begin of the vacation</param>
    /// <returns></returns>
    [HttpPost(Name = "PostVacation")]
    public IActionResult Post(int begin, int end)
    {
        return Ok();
    }

    [HttpPatch(Name = "PatchVacation")]
    public IActionResult Patch(int? end, string? status)
    {
        return Ok();
    }
}