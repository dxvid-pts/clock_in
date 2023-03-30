using Microsoft.AspNetCore.Mvc;

namespace backend.Controllers;

/// <summary>
/// 
/// </summary>
[ApiController]
[Route("api/[controller]")]
public class AdminController : ControllerBase
{
    private readonly ILogger<AdminController> _logger;

    /// <summary>
    /// constructor
    /// </summary>
    /// <param name="logger"></param>
    public AdminController(ILogger<AdminController> logger)
    {
        _logger = logger;
    }
}