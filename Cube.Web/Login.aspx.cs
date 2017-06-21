using Cube.Base;
using Cube.Base.Config;
using Cube.DTO;
using ITS.WebFramework.Configuration;
using ITS.WebFramework.PermissionComponent.ServiceProxy;
using ITS.WebFramework.SSO.Business;
using ITS.WebFramework.SSO.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using static Cube.Web.LoginService;

namespace Cube.Web
{
    public partial class Login : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                InitializeSSORequest();

                if (_SSORequest != null)
                {
                    if (_SSORequest.LoginType == LoginTypeEnum.Debug)
                    {
                        string[] datas = _SSORequest.Data.Split(',');
                        if (datas.Length >= 5)
                        {
                            if (!string.IsNullOrWhiteSpace(datas[2]) && !string.IsNullOrWhiteSpace(datas[3]))
                            {
                                string productName = datas[2];
                                string orgName = datas[3];
                                string userName = datas[4];
                                LoginService service = new LoginService();

                                List<SimpleProductOrgDTO> productOrgList = (List<SimpleProductOrgDTO>)service.getProductOrgList().data;
                                SimpleProductOrgDTO product = productOrgList.FirstOrDefault(p => p.Name.Equals(productName, StringComparison.CurrentCultureIgnoreCase));
                                if (product != null)
                                {
                                    OrgDTO org = product.OrgList.FirstOrDefault(o => o.Name.Equals(orgName, StringComparison.CurrentCultureIgnoreCase));
                                    if (org != null)
                                    {
                                        LogonInfo logonInfo = new LogonInfo();
                                        logonInfo.SSORequest = _SSORequest;
                                        logonInfo.IsNT = true;
                                        logonInfo.OrgID = org.Id;
                                        logonInfo.OrgName = orgName;
                                        logonInfo.ProductID = product.Id;
                                        logonInfo.ProductName = productName;
                                        logonInfo.UserName = userName;
                                        logonInfo.Language = "zh-CN";
                                        service.wfkLoginForDebug(logonInfo);
                                    }
                                }
                            }
                        }
                    }
                    else if (_SSORequest.LoginType == LoginTypeEnum.AdminSimulate)
                    {
                        Page.ClientScript.RegisterStartupScript(GetType(), "HidePassword", "$('#tbxPassword').hide();", true);
                    }
                }

                if (CubeConfig.SystemMode == Base.Enums.CubeSystemModeEnum.Single)
                {
                    lblSystemName.Text = CubeConfig.CubeSystemName;
                    lblSystemName.Attributes["lang"] = "";
                }

                if (CubeConfig.CubeEnvironmentVisible)
                {
                    this.textEnvironmentInfo.Text = CubeConfig.CubeEnvironment;
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {

        }

        override
        public List<string> GetFormMultiLanguageKeyList() 
        {
            List<string> keyList = new List<string>();
            keyList.Add("lang_error");
            keyList.Add("lang_msg_login_failed");
            keyList.Add("lang_msg_must_input_login_name");
            keyList.Add("lang_msg_must_choose_org");
            return keyList;
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

        private void InitializeSSORequest()
        {
            string encrypedSSORequest = Request.QueryString["SSORequest"];
            string encryptedSSOTicket = Request.QueryString["SSOTicket"];

            if (!string.IsNullOrEmpty(encryptedSSOTicket))
            {
                try
                {
                    SSOTicket ssoTicket = _SSOHelper.DecryptSSOTicket(encryptedSSOTicket);
                    _SSOHelper.SaveSSOTicket(ssoTicket);
                    //_SSOAuth.RedirectToOnSuccessUrl(ssoTicket, _SSOAuth.GetSSOPortalUrl(ssoTicket));
                }
                catch (System.Exception ex)
                {
                    Response.Write(ex.Message);
                }
                Response.End();
            }

            if (!string.IsNullOrEmpty(encrypedSSORequest))
            {
                _SSORequest = _SSOHelper.DecryptSSORequest(encrypedSSORequest);
            }
            else
            {
                _SSORequest = null;
            }

            if (_SSORequest == null
                && !string.IsNullOrEmpty(Request.QueryString["FromExternalSystemCall"]))
            {
                _SSORequest = new SSORequest();
                _SSORequest.LoginType = LoginTypeEnum.AutoLogon;
                _SSORequest.RequestDate = DateTime.UtcNow;
                if (Request.UrlReferrer != null)
                {
                    _SSORequest.ReturnUrl = Request.UrlReferrer.ToString();
                    //_SSORequest.ReturnUrl = "http://aic0-s2.qcs.qcorp.com/PermissionManagement/OrgUser/Department/DepartmentInquiry.aspx";
                }
            }

            if (_SSORequest == null
                || _SSORequest.LoginType == LoginTypeEnum.Logout)
            {
                _SSORequest = new SSORequest();
                _SSORequest.LoginType = LoginTypeEnum.DirectLogin;
                _SSORequest.RequestDate = DateTime.UtcNow;
                _SSORequest.ReturnUrl = "";
            }

        }
    }
}