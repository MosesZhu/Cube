using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cube.Base;
using System.Web.UI.HtmlControls;

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
            return _multyKeyArray;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}