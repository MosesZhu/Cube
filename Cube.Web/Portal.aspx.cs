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
        override
        protected List<string> GetFormMultiLanguageKeyList()
        {
            List<string> _multyKeyArray = new List<string>();
            _multyKeyArray.Add("lang_Language");
            _multyKeyArray.Add("lang_Confirm");
            _multyKeyArray.Add("lang_Themes");
            _multyKeyArray.Add("lang_menu_aaa");
            return _multyKeyArray;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
    }
}