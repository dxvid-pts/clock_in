using backend.Database;
using backend.Models;
using backend.Utils;
using Microsoft.IdentityModel.Tokens;

namespace backend.Middlewares;

public class JwtMiddleware
{
    private readonly RequestDelegate _next;

    public JwtMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task Invoke(HttpContext context, ClockInContext _clockInContext, TokenUtils tokenUtils)
    {
        string token = context.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();
        string userId = tokenUtils.ValidateToken(token);
        if (!userId.IsNullOrEmpty())
        {
            context.Items["User"] = _clockInContext.Accounts.FirstOrDefault(p => p.Id.ToString() == userId);
        }

        await _next(context);
    }
}