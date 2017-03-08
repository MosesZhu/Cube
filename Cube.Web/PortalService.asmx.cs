using Cube.Base;
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
            
            //result.data = (new PortalBusiness()).getMenu();

            return result;
        }

        [WebMethod]
        public ResultDTO logout()
        {
            return new ResultDTO();
        }

        [WebMethod]
        public ResultDTO getUserPreference()
        {
            return new ResultDTO();
        }

        [WebMethod]
        public ResultDTO getUserInfo()
        {
            return new ResultDTO();
        }
    }
}
