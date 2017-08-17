using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cube.Base;
using System.Web.UI.HtmlControls;
using Cube.Base.Config;
using ITS.WebFramework.Common;
using ITS.WebFramework.SSO.Common;

namespace Cube.Web
{
    public partial class Portal : PageBase
    {
        public override List<string> GetFormMultiLanguageKeyList()
        {
            List<string> _multyKeyArray = new List<string>();
            _multyKeyArray.Add("msg_confirm_close_tab");
            _multyKeyArray.Add("msg_confirm_close_window");
            _multyKeyArray.Add("lang_success");
            _multyKeyArray.Add("msg_save_success");
            _multyKeyArray.Add("lang_favorites");
            _multyKeyArray.Add("lang_message");
            _multyKeyArray.Add("lang_change_password");
            _multyKeyArray.Add("lang_new_password");
            _multyKeyArray.Add("lang_old_password");
            _multyKeyArray.Add("lang_confirm_password");
            _multyKeyArray.Add("msg_change_pwd_successed");
            _multyKeyArray.Add("msg_change_pwd_failed");
            return _multyKeyArray;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            this.Title = CubeConfig.CubePortalTitle;
            this.textHeaderInfo.Text = CubeConfig.CubePortalHeaderInfo;
            if (CubeConfig.CubeEnvironmentVisible)
            {
                this.textEnvironmentInfo.Text = "(" + CubeConfig.CubeEnvironment + ")";
            }            
            this.textFooterInfo.Text = CubeConfig.CubePortalFooterInfo;
        }
    }
}