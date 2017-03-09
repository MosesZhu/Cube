using Cube.Base;
using CubeDemo.Model.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace CubeDemo.Web
{
    /// <summary>
    /// Summary description for ItemInquiryService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    // [System.Web.Script.Services.ScriptService]
    public class ItemInquiryService : PageServiceBase
    {
        [WebMethod(EnableSession = true)]
        public List<Item> Inquiry(string itemNo)
        {
            List<Item> result = _Db.From<Item>().Where(Item._.Item_No.Contain(itemNo)).Select().ToList();
            return result;
        }
    }
}
