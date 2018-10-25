using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(KHeduLand.Startup))]
namespace KHeduLand
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
