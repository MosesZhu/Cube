using Cube.Base;
using Cube.Model.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Cube.Management.AccountMaintain
{
    /// <summary>
    /// Summary description for UserMaintainService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class UserMaintainService : PageServiceBase
    {

        [WebMethod(EnableSession = true)]
        public List<Cb_User> Inquiry(string login_name, string name)
        {
            List<Cb_User> result = Db.From<Cb_User>().Where(Cb_User._.Login_Name.Contain(login_name)
                && Cb_User._.Name.Contain(name)).Select().ToList();
            return result;
        }
    }
}
