using Serilog;

namespace API.Middlewares
{
    public class ExceptionMiddleware
    {
        private readonly RequestDelegate _next;

        public ExceptionMiddleware(RequestDelegate next)
        {
            _next = next;
        }


        public async Task Invoke(HttpContext ctx)
        {
            try
            {
                await _next(ctx);
            }
            catch (UnauthorizedAccessException)
            {
                ctx.Response.StatusCode = StatusCodes.Status401Unauthorized;
                await ctx.Response.WriteAsJsonAsync(new
                {
                    message = "Session expired"
                });
            }
            catch (Exception ex)
            {
                Log.Error(ex, "Unhandled exception occurred");

                ctx.Response.StatusCode = 500;
                await ctx.Response.WriteAsJsonAsync(new
                {
                    message = ex.Message//"Internal server error"
                });
            }

        }
    }

}
