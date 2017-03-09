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
        public DbSession _Db 
        {
            get {
                if (_DBSession == null)
                {
                    _DBSession = CreateDbSession("system");
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
                    string userId = _Db.From<Cb_Token>().Where(Cb_Token._.Token == Token)
                        .Select(Cb_Token._.All).ToList().FirstOrDefault().User_Id.ToString();
                    _user = _Db.From<Cb_User>().Where(Cb_User._.Id == userId).Select(Cb_User._.All).FirstDefault();
                }
                return _user;
            }
        }

        public string Token {
            get {
                return HttpContext.Current.Request["SSOToken"];
            }
        }

        public PageServiceBase()
        {
            //_Db = CreateDbSession("system");

            string token = HttpContext.Current.Request["SSOToken"];
            string language = HttpContext.Current.Request["Language"];
            if(!ValidateToken(token)) {
                throw new Exception("");
            }

            
        }

        /// <summary>
        /// Create a DB session
        /// </summary>
        /// <param name="settingName"></param>
        /// <returns>DbSession</returns>
        public DbSession CreateDbSession(string settingName)
        {
            //读取config文件，并解析连接字符串            
            string connString = ConfigurationManager.ConnectionStrings[settingName].ConnectionString;
            string providerName = ConfigurationManager.ConnectionStrings[settingName].ProviderName;

            ConnectionStringSettings connectionStringSettings = new ConnectionStringSettings();
            connectionStringSettings.ConnectionString = connString;
            connectionStringSettings.ProviderName = providerName;
            connectionStringSettings.Name = settingName;

            return new DbSession(connectionStringSettings);
        }

        public bool ValidateToken(string token)
        {
            return true;
        }
    }
}
