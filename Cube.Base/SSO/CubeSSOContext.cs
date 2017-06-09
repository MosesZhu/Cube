using Cube.Base.Config;
using Cube.Base.Utility;
using Cube.Common;
using Cube.DTO;
using Cube.Model.DTO;
using Cube.Model.Entity;
using ITS.WebFramework.Common.Constants;
using ITS.WebFramework.PermissionComponent.ServiceProxy;
using ITS.WebFramework.SSO.Session;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Cube.Base.SSO
{
    public class CubeSSOContext
    {
        private static readonly Dictionary<string, CubeSSOContext> _clientContextList =
            new Dictionary<string, CubeSSOContext>();
        public static CubeSSOContext Current
        {
            get
            {
                if (!_clientContextList.ContainsKey(Token))
                {
                    CubeSSOContext context = new CubeSSOContext(Token);
                    lock (_clientContextList)
                    {
                        if (!_clientContextList.ContainsKey(Token))
                        {
                            _clientContextList.Add(Token, context);
                        }
                    }
                }
                return _clientContextList[Token];
            }
        }

        public static string Token
        {
            get
            {
                return !string.IsNullOrEmpty(HttpContext.Current.Request.Headers["SSOToken"]) ? HttpContext.Current.Request.Headers["SSOToken"] : HttpContext.Current.Request["SSOToken"];
            }
        }
        public static bool IsDebug
        {
            get
            {
                return (!string.IsNullOrEmpty(HttpContext.Current.Request["IsDebug"]) && HttpContext.Current.Request["IsDebug"] == "Y")
                    || !string.IsNullOrEmpty(HttpContext.Current.Request.Headers["IsDebug"]) && HttpContext.Current.Request.Headers["IsDebug"] == "Y";
            }
        }
        public static string LocalDebugUrl
        {
            get
            {
                if (IsDebug)
                {
                    return string.IsNullOrEmpty(HttpContext.Current.Request["LocalDebugUrl"]) ? HttpContext.Current.Request.Headers["LocalDebugUrl"] : HttpContext.Current.Request["LocalDebugUrl"];
                }
                else
                {
                    return "";
                }
            }
        }
        public static string Language
        {
            get
            {
                return string.IsNullOrEmpty(HttpContext.Current.Request["Language"]) ? HttpContext.Current.Request.Headers["Language"] : HttpContext.Current.Request["Language"];
            }
        }

        public Mc_User User { get; set; }

        public UserDTO UserInfo
        {
            get; set;
        }

        public Guid ProductId { get; set; }

        public string ProductName { get; set; }

        public Guid OrgId { get; set; }

        public TokenDTO TokenInfo { get; set; }

        public SSOContext WfkSSOContext { get; set; }
        public CubeSSOContext(string token) 
        {            
            WfkSSOContext = SSOContext.Current;
            UserInfo = new UserDTO()
            {
                User_ID = WfkSSOContext.UserID,
                User_Name = WfkSSOContext.UserName
            };
            ProductId = WfkSSOContext.ProductID;
            ProductName = WfkSSOContext.ProductName;

            //User = DBUtility.CubeDb.From<Mc_User>().Where(Mc_User._.Id == UserInfo.User_ID).Select(Mc_User._.All).FirstDefault();
        }            
    }
}
