using Cube.Base.SSO;
using ITS.WebFramework.PermissionComponent.ServiceProxy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.SessionState;

namespace Cube.Base.Base
{
    public class HttpHandlerBase : IHttpHandler, IReadOnlySessionState
    {
        public UserDTO UserInfo
        {
            get
            {
                return CubeSSOContext.Current.UserInfo;
            }
        }
        public virtual void ProcessRequest(HttpContext context)
        {

        }

        public bool IsReusable
        {
            get
            {
                return true;
            }
        }
    }
}
