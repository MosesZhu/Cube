using ITS.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Base.Utility
{
    public class DBUtility
    {
        private static DbSession _DBSession;
        public static DbSession Db
        {
            get
            {
                //if (_DBSession == null)
                //{
                    _DBSession = CreateDbSession("system");
                //}
                return _DBSession;
            }
            set
            {
                _DBSession = value;
            }
        }

        private static DbSession _CubeDBSession;
        public static DbSession CubeDb
        {
            get
            {
                //if (_CubeDBSession == null)
                //{
                    _CubeDBSession = CreateDbSession("cube");
                //}
                return _CubeDBSession;
            }
            set
            {
                _CubeDBSession = value;
            }
        }

        /// <summary>
        /// Create a DB session
        /// </summary>
        /// <param name="settingName"></param>
        /// <returns>DbSession</returns>
        public static DbSession CreateDbSession(string settingName)
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
    }
}
