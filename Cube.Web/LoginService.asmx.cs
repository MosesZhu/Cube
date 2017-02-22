using Cube.Base;
using Cube.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Cube.Web
{
    public class LoginService : PageServiceBase
    {
        [WebMethod]
        public ResultDTO login()
        {
            ResultDTO result = new ResultDTO();
            //Test
            result.data = "TestToken";
            //Test
            return result;
        }
    }
}
