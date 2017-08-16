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
        public UserDTO _TempUser = null;
        public BusinessBase()
        {
        }

        public BusinessBase(UserDTO user)
        {
            this._TempUser = user;
        }

        public UserDTO UserInfo
        {
            get
            {
                if (_TempUser != null)
                {
                    return _TempUser;
                }
                return CubeSSOContext.Current.UserInfo;
            }
        }
    }
}
