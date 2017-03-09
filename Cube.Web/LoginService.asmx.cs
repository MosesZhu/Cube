using Cube.Base;
using Cube.DTO;
using Cube.Model.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Cube.Web
{
    public class LoginService : PageServiceBase
    {
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)] 
        [WebMethod]
        public ResultDTO login(string userName, string password)
        {
            ResultDTO result = new ResultDTO();
            List<Cb_User> userList = _Db.From<Cb_User>().Where(Cb_User._.Login_Name == userName).ToList();
            if (userList.Count() != 1)
            {
                result.success = false;
                result.errorcode = "E0001";
            }
            else
            {
                string newToken = Guid.NewGuid().ToString();
                Cb_User user = userList.FirstOrDefault();
                Cb_Token tokenInfo = _Db.From<Cb_Token>().Where(Cb_Token._.User_Id == user.Id).ToList().FirstOrDefault();
                if (tokenInfo == null)
                {
                    tokenInfo = new Cb_Token();
                    tokenInfo.User_Id = user.Id;
                    tokenInfo.Login_Time = DateTime.Now;
                    tokenInfo.Token = newToken;
                    _Db.Insert<Cb_Token>(tokenInfo);
                }
                else 
                {
                    tokenInfo.Login_Time = DateTime.Now;
                    tokenInfo.Token = newToken;
                    _Db.Update<Cb_Token>(tokenInfo);
                }
                result.success = true;
                result.data = tokenInfo.Token;
            }
            //Test
            //result.data = "TestToken";
            //Test
            return result;
        }
    }
}
