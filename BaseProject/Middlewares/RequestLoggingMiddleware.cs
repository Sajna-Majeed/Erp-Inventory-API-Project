namespace API.Middlewares
{
    public class RequestLoggingMiddleware
    {
        private readonly RequestDelegate _next;

        public RequestLoggingMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task Invoke(HttpContext context)
        {
            var user = context.User?.Identity?.Name;
            var ip = context.Connection.RemoteIpAddress?.ToString();

            using (Serilog.Context.LogContext.PushProperty("User", user))
            using (Serilog.Context.LogContext.PushProperty("IP", ip))
            {
                await _next(context);
            }
        }
    }
}
