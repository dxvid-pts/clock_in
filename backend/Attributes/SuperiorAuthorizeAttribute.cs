using backend.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace backend.Attributes;

[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method)]

public class SuperiorAuthorizeAttribute : Attribute, IAuthorizationFilter
{
    /// <summary>
    /// the required role to authorize the account with<br/>
    /// used with the [Authorize] tag to secure an http action
    /// </summary>
    /// <remarks>
    /// <b>always</b> use <b>this attribute</b>, not the one from .net!<br/>
    /// use...<br/>
    /// - <b>[Authorize(Roles = Roles.Employee)]</b> to grant access to employees<br/>
    /// - <b>[Authorize(Roles = Roles.Manager)]</b> to grant access to managers<br/>
    /// - <b>[Authorize(Roles = Roles.Admin)]</b> to grant access to admins<br/>
    /// - <b>[Authorize(Roles = Roles.Employee + Roles.Manager)]</b> to combine roles
    /// </remarks>
    /// <param name="context"></param>
    public string Roles { get; set; } = string.Empty;
    
    /// <summary>
    /// used with the [Authorize] tag to secure an http action
    /// </summary>
    /// <remarks>
    /// <b>always</b> use <b>this attribute</b>, not the one from .net!<br/>
    /// use...<br/>
    /// - <b>[Authorize(Roles = Roles.Employee)]</b> to grant access to employees<br/>
    /// - <b>[Authorize(Roles = Roles.Manager)]</b> to grant access to managers<br/>
    /// - <b>[Authorize(Roles = Roles.Admin)]</b> to grant access to admins<br/>
    /// - <b>[Authorize(Roles = Roles.Employee + Roles.Manager)]</b> to combine roles
    /// </remarks>
    /// <param name="context"></param>
    public void OnAuthorization(AuthorizationFilterContext context)
    {
        var account = (Account?)context.HttpContext.Items["User"];

        if (account == null)
        {
            context.Result = new JsonResult(new
                {
                    message = new ProblemDetails()
                    {
                        Title = "Unauthorized",
                        Status = StatusCodes.Status401Unauthorized,
                        Detail = "No user is logged in"
                    }
                })
                { StatusCode = StatusCodes.Status401Unauthorized };
            return;
        }

        if (account.Blocked == true)
        {
            context.Result = new JsonResult(new
                {
                    message = new ProblemDetails()
                    {
                        Title = "Forbidden",
                        Status = StatusCodes.Status403Forbidden,
                        Detail = "You have been deleted. Get a new life."
                    }
                })
                { StatusCode = StatusCodes.Status403Forbidden };
        }

        if (Roles != string.Empty && !Roles.ToUpper().Contains(account.Role.ToUpper()))
        {
            context.Result = new JsonResult(new
                {
                    message = new ProblemDetails()
                    {
                        Title = "Forbidden",
                        Status = StatusCodes.Status403Forbidden,
                        Detail = "Logged in user has insufficient permissions for requested route"
                    }
                })
                { StatusCode = StatusCodes.Status403Forbidden };
            return;
        }
    }
}