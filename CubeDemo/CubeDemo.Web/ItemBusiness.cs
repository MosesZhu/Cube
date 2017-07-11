using Cube.Base.Base;
using ITS.WebFramework.PermissionComponent.ServiceProxy;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CubeDemo.Web
{
    public class ItemBusiness : BusinessBase
    {
        public UserDTO getUserInfo()
        {
            return UserInfo;
        }
    }
}