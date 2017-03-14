using Cube.Base.Utility;
using Cube.Model.DTO;
using Cube.Model.Entity;
using ITS.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;

namespace Cube.Base
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class PageServiceBase : WebService
    {
        public static DbSession _DBSession;
        public DbSession Db 
        {
            get {
                if (_DBSession == null)
                {
                    _DBSession = DBUtility.Db;
                }
                return _DBSession;
            }
            set
            {
                _DBSession = value;
            }
        }

        public Cb_User _user;
        public Cb_User User {
            get {
                if (_user == null)
                {
                    TokenDTO tokenInfo = TokenUtility.GetTokenInfo(Token);
                    string userId = DBUtility.CubeDb.From<Cb_Token>().Where(Cb_Token._.Secret_Key == tokenInfo.SecretKey)
                        .Select(Cb_Token._.All).ToList().FirstOrDefault().User_Id.ToString();
                    _user = Db.From<Cb_User>().Where(Cb_User._.Id == userId).Select(Cb_User._.All).FirstDefault();
                }
                return _user;
            }
        }

        public string Token {
            get {
                return string.IsNullOrEmpty(HttpContext.Current.Request["SSOToken"]) ? HttpContext.Current.Request.Headers["SSOToken"] : HttpContext.Current.Request["SSOToken"];
            }
        }

        public string Language {
            get
            {
                return string.IsNullOrEmpty(HttpContext.Current.Request["Language"]) ? HttpContext.Current.Request.Headers["Language"] : HttpContext.Current.Request["Language"];
            }
        }

        public PageServiceBase()
        {
            if(!ValidateToken()) {
                throw new Exception("");
            }
        }

        public bool ValidateToken()
        {
            return true;
        }
    }
}
