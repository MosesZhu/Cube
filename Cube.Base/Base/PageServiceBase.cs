using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Services;

namespace Cube.Base
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class PageServiceBase : WebService
    {
        public PageServiceBase()
        {
            string token = HttpContext.Current.Request.Headers["SSOToken"];
            string language = HttpContext.Current.Request.Headers["Language"];
            if(!ValidateToken(token)) {
                throw new Exception("");
            }
        }

        public bool ValidateToken(string token)
        {
            return true;
        }
    }
}
