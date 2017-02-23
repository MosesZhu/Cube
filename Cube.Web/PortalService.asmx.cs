using Cube.Base;
using Cube.Business;
using Cube.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Cube.Web
{
    public class PortalService : PageServiceBase
    {

        [WebMethod]
        public ResultDTO getMenu()
        {
            ResultDTO result = new ResultDTO();            
            
            result.data = (new PortalBusiness()).getMenu();            

            return result;
        }

        [WebMethod]
        public ResultDTO logout()
        {
            return new ResultDTO();
        }
    }
}
