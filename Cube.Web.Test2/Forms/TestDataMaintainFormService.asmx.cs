using Cube.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Cube.Web.Test2.Forms
{
    public class TestDataMaintainFormService : PageServiceBase
    {

        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }
    }
}
