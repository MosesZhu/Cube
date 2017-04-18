using Cube.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Cube.Management.AccountMaintain
{
    public partial class UserMaintain : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        public override List<string> GetFormMultiLanguageKeyList()
        {
            List<string> _multyKeyArray = new List<string>();

            _multyKeyArray.Add("lang_error");
            _multyKeyArray.Add("lang_success");
            _multyKeyArray.Add("msg_login_name_can_not_empty");
            _multyKeyArray.Add("msg_name_can_not_empty");            
            _multyKeyArray.Add("msg_save_success");
            
            return _multyKeyArray;
        }
    }
}