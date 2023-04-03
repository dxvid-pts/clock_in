using backend.Database;
using backend.Models;
using backend.Utils;
using Microsoft.IdentityModel.Tokens;

namespace backend.Middlewares;

public class JwtMiddleware
{
    private readonly RequestDelegate _next;

    /// <summary>
    /// constructor
    /// </summary>
    /// <param name="next"></param>
    public JwtMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    /// <summary>
    /// Invoked in the Request Pipeline. Validates token and adds user account to the request context.
    /// </summary>
    /// <param name="context"></param>
    /// <param name="clockInContext"></param>
    /// <param name="tokenUtils"></param>
    public async Task Invoke(HttpContext context, ClockInContext clockInContext, TokenUtils tokenUtils)
    {
        string token = context.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();
        string userId = tokenUtils.ValidateToken(token);
        if (!userId.IsNullOrEmpty())
        {
            context.Items["User"] = clockInContext.Accounts.FirstOrDefault(p => p.Id.ToString() == userId);
        }

        await _next(context);
    }
}