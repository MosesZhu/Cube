using Cube.Base;
using Cube.Base.Utility;
using Cube.Common;
using Cube.DTO;
using Cube.Model.DTO;
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
            Mc_User user = DBUtility.CubeDb
                .From<Mc_User>()
                .Where(Mc_User._.Login_Name == userName)
                .First();
            if (user == null)
            {
                result.success = false;
                result.errorcode = ErrorCode.NO_SSO_INFO;
            }
            else if (!CheckUserAuthencationInfo(user,password))
            {
                result.success = false;
                result.data = ErrorCode.USER_AUTH_FAILED;
            }
            else
            {
                result.success = true;
                result.data = RenewToken(result, user);
            }
            return result;
        }

        /// <summary>
        /// 用户登录安全性验证
        /// </summary>
        /// <param name="user"></param>
        /// <param name="password"></param>
        /// <returns></returns>
        private bool CheckUserAuthencationInfo(Mc_User user, string password)
        {
            return true;
        }

        /// <summary>
        /// 添加或更新Token
        /// </summary>
        /// <param name="result"></param>
        /// <param name="user"></param>
        /// <returns></returns>
        private string RenewToken(ResultDTO result, Mc_User user)
        {
            string secretKey = Guid.NewGuid().ToString();
            Mc_Token tokenInfo = DBUtility.CubeDb.From<Mc_Token>()
                .Where(Mc_Token._.User_Id == user.Id)
                .ToList()
                .FirstOrDefault();
            if (tokenInfo == null)
            {
                tokenInfo = new Mc_Token();
                tokenInfo.User_Id = user.Id;
                tokenInfo.Login_Time = DateTime.Now;
                tokenInfo.Secret_Key = secretKey;
                DBUtility.CubeDb.Insert<Mc_Token>(tokenInfo);
            }
            else
            {
                tokenInfo.Login_Time = DateTime.Now;
                tokenInfo.Secret_Key = secretKey;
                DBUtility.CubeDb.Update<Mc_Token>(tokenInfo);
            }
            result.success = true;
            TokenDTO token = new TokenDTO()
            {
                LoginName = user.Login_Name,
                LoginTime = tokenInfo.Login_Time,
                SecretKey = Guid.Parse(secretKey)
            };
            return TokenUtility.GenerateToken(token);
        }
    }
}
