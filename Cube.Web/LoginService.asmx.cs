using Cube.Base;
using Cube.Base.Config;
using Cube.Base.Utility;
using Cube.Common;
using Cube.DTO;
using Cube.Model.DTO;
using Cube.Model.Entity;
using ITS.WebFramework.Configuration;
using ITS.WebFramework.PermissionComponent.ServiceProxy;
using ITS.WebFramework.SSO.Business;
using ITS.WebFramework.SSO.Common;
using Qisda.Common;
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
        public ResultDTO getDomainList()
        {
            ResultDTO result = new ResultDTO()
            {
                success = true,
                data = QADHelper.GetAllDomainList()
            };
            return result;
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public ResultDTO getProductOrgList()
        {
            ResultDTO result = new ResultDTO();

            try
            {
                PermissionService permissionService = new PermissionService();
                permissionService.Url = Config.Global.PermissionServiceUrl;

                List<SimpleProductOrgDTO> data = new List<SimpleProductOrgDTO>();
                ITS.WebFramework.PermissionComponent.ServiceProxy.ProductDTO[] productList = permissionService.GetProductList();
                foreach (ITS.WebFramework.PermissionComponent.ServiceProxy.ProductDTO p in productList)
                {
                    SimpleProductOrgDTO product = new SimpleProductOrgDTO() { Id = p.Id, Name = p.Name };
                    product.OrgList = permissionService.GetOrgList(p.Id).ToList();
                    data.Add(product);
                }

                result.success = true;
                result.data = data;
            }
            catch (Exception ex)
            {
                result.success = false;
                result.message = ex.Message;
            }

            return result;
        }

        [Serializable]
        public class SimpleProductOrgDTO
        {
            public Guid Id { get; set; }
            public string Name { get; set; }
            public List<OrgDTO> OrgList { get; set; }
            public SimpleProductOrgDTO()
            {
                this.OrgList = new List<OrgDTO>();
            }
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public ResultDTO login(string userName, string password, string productId, string productName, string orgId, string orgName, string domain, bool isInternal)
        {
            if (CubeConfig.AuthorityMode == Base.Enums.AuthorityModeEnum.WFK)
            {
                return wfkLogin(userName, password, productId, productName, orgId, orgName, domain, isInternal);
            }
            else
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
                else if (!CheckUserAuthencationInfo(user, password))
                {
                    result.success = false;
                    result.data = ErrorCode.USER_AUTH_FAILED;
                }
                else
                {
                    result.success = true;
                    result.data = RenewToken(result, user, Guid.Parse(productId), Guid.Parse(orgId));
                }

                return result;
            }            
        }

        private SSORequest _SSORequest
        {
            get
            {
                object obj = Session["SSORequest"];
                if (obj != null)
                    return (SSORequest)obj;
                else
                {
                    //ToDo:以后需要移除这段初始化代码
                    SSORequest request = new SSORequest();
                    request.LoginType = LoginTypeEnum.Normal;
                    return null;
                }
            }
            set
            {
                Session["SSORequest"] = value;
            }
        }

        SSOHelper _SSOHelper = new SSOHelper();

        private SSOTicket GetSSOTicketFromCookie()
        {
            SSOTicket ssoTicket = _SSOHelper.LoadSSOTicket(Config.Global.SSOTicketName);
            return ssoTicket;
        }

        public ResultDTO wfkLogin(string userName, string password, string productId, string productName, string orgId, string orgName, string domain, bool isInternal)
        {
            SSOTicket ssoTicket = GetSSOTicketFromCookie();

            LogonInfo logonInfo = new LogonInfo();
            logonInfo.SSORequest = _SSORequest;
            logonInfo.IsNT = isInternal;
            logonInfo.OrgID = Guid.Parse(orgId);
            logonInfo.OrgName = orgName;
            logonInfo.ProductID = Guid.Parse(productId);
            logonInfo.ProductName = productName;

            logonInfo.UserName = userName;

            //if (ssoTicket == null
            //    && _SSORequest.LoginType != LoginTypeEnum.AdminSimulate
            //    && _SSORequest.LoginType != LoginTypeEnum.Debug)
            //{
            //    logonInfo.Password = inputPassword.Text.Trim();
            //    if (string.IsNullOrEmpty(logonInfo.Password))
            //    {
            //        ShowMessage(MessageFillPassword, inputPassword);
            //        return;
            //    }
            //    if (logonInfo.IsNT)
            //    {
            //        logonInfo.Domain = ddlDomain.SelectedItem.Value;
            //    }
            //}
            //else
            //{
            //    logonInfo.IsSSOTicketAleadyExisted = true;
            //    //logonInfo.AutoLogon = true;
            //}
            //logonInfo.Language = ddlLang.SelectedValue;
            //DateTime expired = DateTime.Now.AddYears(1);
            //CookiesManager.Add("SSOLastLanguage", logonInfo.Language, expired);
            //CookiesManager.Add("SSOLastOrgID", logonInfo.OrgID.ToString(), expired);
            //CookiesManager.Add("SSOLastProductID", logonInfo.ProductID.ToString(), expired);

            //try
            //{
            //    if (!new SSOAuthentication().Logon(logonInfo))
            //    {
            //        ShowMessage(MessageUserPasswordError, inputPassword);
            //    }
            //}
            //catch (Exception ex)
            //{
            //    string message = string.Empty;
            //    if (ex.GetType() == typeof(SoapException))
            //    {
            //        message = DebugHelper.GetSoapExceptionMessage(ex as SoapException);
            //    }
            //    else
            //    {
            //        message = ex.Message;
            //    }
            //    if (message.IndexOf("user", StringComparison.OrdinalIgnoreCase) >= 0)
            //    {
            //        ShowMessage(message, inputUserName);
            //    }
            //    else
            //    {
            //        ShowMessage(message, inputPassword);
            //    }
            //}

            return null;
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
        private string RenewToken(ResultDTO result, Mc_User user, Guid ProductId, Guid OrgId)
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
                SecretKey = Guid.Parse(secretKey),
                ProductId = ProductId,
                OrgId = OrgId
            };
            return TokenUtility.GenerateToken(token);
        }
    }
}
