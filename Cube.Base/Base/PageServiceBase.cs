﻿//using ITS.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Services;

namespace Cube.Base
{
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class PageServiceBase : WebService
    {
        //public DbSession _Db { get; set; }

        public PageServiceBase()
        {
            //_Db = CreateDbSession("cube");

            string token = HttpContext.Current.Request["SSOToken"];
            string language = HttpContext.Current.Request.Headers["Language"];
            if(!ValidateToken(token)) {
                throw new Exception("");
            }

            
        }

        /// <summary>
        /// Create a DB session
        /// </summary>
        /// <param name="settingName"></param>
        /// <returns>DbSession</returns>
        //public DbSession CreateDbSession(string settingName)
        //{
        //    //读取config文件，并解析连接字符串            
        //    string connString = ConfigurationManager.ConnectionStrings[settingName].ConnectionString;
        //    string providerName = ConfigurationManager.ConnectionStrings[settingName].ProviderName;

        //    ConnectionStringSettings connectionStringSettings = new ConnectionStringSettings();
        //    connectionStringSettings.ConnectionString = connString;
        //    connectionStringSettings.ProviderName = providerName;
        //    connectionStringSettings.Name = settingName;

        //    return new DbSession(connectionStringSettings);
        //}

        public bool ValidateToken(string token)
        {
            return true;
        }
    }
}
