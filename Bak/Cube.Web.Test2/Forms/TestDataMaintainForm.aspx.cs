using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cube.Base;
using System.Web.UI.HtmlControls;

namespace Cube.Web.Test2.Forms
{
    public partial class TestDataMaintainForm : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            foreach (Control control in this.Controls)
            {
                if (control is HtmlForm)
                {

                }
            }
        }
    }
}