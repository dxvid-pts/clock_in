using backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace backend.Attributes;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]

public class AuthorizeAttribute : Attribute, IAuthorizationFilter
{
    public string Roles { get; set; }
    
    public void OnAuthorization(AuthorizationFilterContext context)
    {
        var account = (Account)context.HttpContext.Items["User"];
        Console.WriteLine(account.Role);
        Console.WriteLine(Roles);
        if (account == null)
            context.Result = new JsonResult(new { message = "Unauthorized" }) { StatusCode = StatusCodes.Status401Unauthorized };
        if (!Roles.Contains(account.Role))
            context.Result = new JsonResult(new { message = "Forbidden" })
                { StatusCode = StatusCodes.Status403Forbidden };
    }
}