//using ITS.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Base
{
    public class BusinessBase
    {
        //public DbSession _Db { get; set; }

        //public BusinessBase()
        //{
        //    //DB对象
        //    _Db = CreateDbSession("cube");
        //}

        ///// <summary>
        ///// Create a DB session
        ///// </summary>
        ///// <param name="settingName"></param>
        ///// <returns>DbSession</returns>
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
    }
}
