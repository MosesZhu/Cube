using Cube.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cube.Web
{
    public partial class Login : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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
    }
}