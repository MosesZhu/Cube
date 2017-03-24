using Cube.Base.SSO;
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
        public static DbSession mDBSession;
        public DbSession Db 
        {
            get {
                if (mDBSession == null)
                {
                    mDBSession = DBUtility.Db;
                }
                return mDBSession;
            }
            set
            {
                mDBSession = value;
            }
        }

        public Cb_User User {
            get {
                return SSOContext.Current.User;
            }
        }        

        public string Language {
            get
            {
                return SSOContext.Language;
            }
        }

        public PageServiceBase()
        {
            if (!Context.Request.Url.ToString().ToUpper().Contains(UNCHECK_URL.ToUpper()) && !ValidateToken())
            {
                throw new Exception("");
            }
        }

        public static string UNCHECK_URL = "LoginService.asmx/login";
        public bool ValidateToken()
        {
            return TokenUtility.ValidToken(SSOContext.Token);
        }
    }
}
