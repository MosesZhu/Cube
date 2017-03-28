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
            //_multyKeyArray.Add("lang_language");
            //_multyKeyArray.Add("lang_confirm");
            //_multyKeyArray.Add("lang_themes");
            _multyKeyArray.Add("msg_confirm_close_tab");
            return _multyKeyArray;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}