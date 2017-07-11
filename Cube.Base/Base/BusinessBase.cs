using Cube.Base.SSO;
using ITS.WebFramework.PermissionComponent.ServiceProxy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Base.Base
{
    public class BusinessBase
    {
        public UserDTO UserInfo
        {
            get
            {
                return CubeSSOContext.Current.UserInfo;
            }
        }
    }
}
