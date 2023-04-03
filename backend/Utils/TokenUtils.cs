using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using backend.Models;
using Microsoft.IdentityModel.Tokens;

namespace backend.Utils;

public class TokenUtils
{
    private readonly IConfiguration _configuration;

    public TokenUtils(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public TokenResponse CreateAccessToken(Account forAccount)
    {
        List<Claim> claims = new()
        {
            new Claim(ClaimTypes.NameIdentifier, forAccount.Id.ToString())
        };
        
        var symmetricKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(_configuration["Jwt:Key"] ?? throw new InvalidOperationException()));
        var exp = DateTime.UtcNow.AddMonths(1);
        JwtSecurityToken token = new JwtSecurityToken(
            _configuration["Jwt:Issuer"],
            _configuration["Jwt:Audience"],
            claims,
            expires: exp,
            signingCredentials: new SigningCredentials(symmetricKey, SecurityAlgorithms.HmacSha256)
        );
        
        var tokenHandler = new JwtSecurityTokenHandler();
        var tokenStr = tokenHandler.WriteToken(token);
        return new TokenResponse()
        {
            access_token = tokenStr,
            expires_in = (((DateTimeOffset)exp).ToUnixTimeSeconds() - (DateTimeOffset.UtcNow.ToUnixTimeSeconds())).ToString(),
            token_type = "Bearer"
        };
    }

    public string ValidateToken(string token)
    {
        if (token == null)
            return string.Empty;

        var tokenHandler = new JwtSecurityTokenHandler();
        try
        {
            tokenHandler.ValidateToken(token, new TokenValidationParameters
            {
                ValidIssuer = _configuration["Jwt:Issuer"],
                ValidAudience = _configuration["Jwt:Audience"],
                IssuerSigningKey = new SymmetricSecurityKey
                    (Encoding.UTF8.GetBytes(_configuration["Jwt:Key"])),
                ValidateIssuer = true,
                ValidateAudience = true,
                ValidateLifetime = false,
                ValidateIssuerSigningKey = true
            }, out SecurityToken validatedToken);

            var jwtToken = (JwtSecurityToken)validatedToken;
            var userId = jwtToken.Claims.First(x => x.Type == ClaimTypes.NameIdentifier).Value;

            return userId;
        }
        catch
        {
            return string.Empty;
        }
    }
}