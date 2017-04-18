using Cube.Base;
using Cube.DTO;
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
    public class UserDetailMaintainService : PageServiceBase
    {

        [WebMethod(EnableSession = true)]
        public ResultDTO Inquiry(string login_name, string name)
        {
            List<Mc_User> result = Db.From<Mc_User>().Where(Mc_User._.Login_Name.Contain(login_name)
                && Mc_User._.Name.Contain(name)).Select().ToList();
            return new ResultDTO() { 
                success = true,
                data = result
            };
        }

        [WebMethod(EnableSession = true)]
        public ResultDTO Update(Guid id, string loginName, string name, string mail)
        {
            Mc_User user = new Mc_User() { Id = id, Login_Name = loginName, Name = name, Mail = mail };
            Db.Update<Mc_User>(user);
            return new ResultDTO()
            {
                success = true
            };
        }
    }
}
