using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Cube.Web.Startup))]
namespace Cube.Web
{
    public partial class Startup {

        public void Configuration(IAppBuilder app) {
            //ConfigureAuth(app);
            //app.Run(context => {
            //    context.Response.ContentType = "text/plain";
            //    return context.Response.WriteAsync("Hi Moses");
            //});
        }

    }
}
