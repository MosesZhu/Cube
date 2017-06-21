using Cube.Base.Enums;
using Cube.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Base.Config
{
    public static class CubeConfig
    {
        private static void InitCache()
        {
            //ConfigurationManager.AppSettings[];
            LastCacheTime = DateTime.Now;
            _cache = new Dictionary<string, string>();
            _cache[ConfigContents.AUTHORITY_MODE] = Convert.ToInt32((AuthorityModeEnum)Enum.Parse(typeof(AuthorityModeEnum), ConfigurationManager.AppSettings[ConfigContents.AUTHORITY_MODE])).ToString();
        }


        private static readonly long CACHE_SURVIVAL_TIME = 100000;
        private static DateTime LastCacheTime
        {
            get;
            set;
        }
        private static bool IsCacheOverTime()
        {
            return (DateTime.Now - LastCacheTime).Seconds > CACHE_SURVIVAL_TIME;
        }
        private static string FindCacheValue(string key, string defaultValue = null)
        {
            return ConfigurationManager.AppSettings[key];
            //return Cache[key] == null ? Cache[key] : defaultValue;
            //return Cache.FirstOrDefault(kv => kv.Key == key) == null ? Cache.FirstOrDefault(kv => kv.Key == key).Value : defaultValue;
        }

        private static Dictionary<string, string> _cache;
        public static Dictionary<string, string> Cache
        {
            get {
                if (_cache == null || IsCacheOverTime())
                {
                    InitCache();
                }

                return _cache;
            }
            set {
                _cache = value;
            }
        }

        public static CubeSystemModeEnum SystemMode
        {
            get {
                return ConfigurationManager.AppSettings[ConfigContents.CUBE_SYSTEM_MODE] == null ? CubeSystemModeEnum.Mulity :
                    (CubeSystemModeEnum)Enum.Parse(typeof(CubeSystemModeEnum), ConfigurationManager.AppSettings[ConfigContents.CUBE_SYSTEM_MODE]);
            }
        }

        public static string CubeSystemId
        {
            get
            {
                return ConfigurationManager.AppSettings[ConfigContents.CUBE_SYSTEM_ID] == null ? string.Empty :
                    ConfigurationManager.AppSettings[ConfigContents.CUBE_SYSTEM_ID];
            }
        }

        public static string CubeSystemName
        {
            get
            {
                return ConfigurationManager.AppSettings[ConfigContents.CUBE_SYSTEM_NAME] == null ? string.Empty :
                    ConfigurationManager.AppSettings[ConfigContents.CUBE_SYSTEM_NAME];
            }
        }

        public static string PermissionSystemId
        {
            get
            {
                return ConfigurationManager.AppSettings[ConfigContents.PERMISSION_SYSTEM_ID];
            }
        }

        public static string WfkResourceUrl
        {
            get
            {
                return ConfigurationManager.AppSettings[ConfigContents.WFK_RESOURCE_URL] == null ? "" : ConfigurationManager.AppSettings[ConfigContents.WFK_RESOURCE_URL];
            }
        }

        public static string CubePortalHeaderInfo
        {
            get
            {
                string header = ConfigurationManager.AppSettings[ConfigContents.CUBE_PORTAL_HEADER_INFO] == null ? CubePortalTitle :
                    ConfigurationManager.AppSettings[ConfigContents.CUBE_PORTAL_HEADER_INFO];

                return header;
            }
        }

        public static string CubeEnvironment
        {
            get
            {
                string env = ConfigurationManager.AppSettings[ConfigContents.CUBE_ENVIRONMENT] == null ? "" :
                    ConfigurationManager.AppSettings[ConfigContents.CUBE_ENVIRONMENT];

                return env;
            }
        }

        public static bool CubeEnvironmentVisible
        {
            get
            {
                return ConfigurationManager.AppSettings[ConfigContents.CUBE_ENVIRONMENT_VISIBLE] != null && ConfigurationManager.AppSettings[ConfigContents.CUBE_ENVIRONMENT_VISIBLE] == "true";
            }
        }

        public static string CubePortalTitle
        {
            get
            {
                string title = ConfigurationManager.AppSettings[ConfigContents.CUBE_PORTAL_TITLE] == null ? "" :
                    ConfigurationManager.AppSettings[ConfigContents.CUBE_PORTAL_TITLE];
                if (string.IsNullOrEmpty(title) && CubeConfig.SystemMode == CubeSystemModeEnum.Single)
                {
                    title = CubeSystemName;
                }
                if (string.IsNullOrEmpty(title)) {
                    title = "Portal";
                }

                return title;
            }
        }

        public static string CubePortalFooterInfo
        {
            get
            {
                return ConfigurationManager.AppSettings[ConfigContents.CUBE_PORTAL_FOOTER_INFO] == null ? string.Empty :
                    ConfigurationManager.AppSettings[ConfigContents.CUBE_PORTAL_FOOTER_INFO];
            }
        }

        public static int TokenOverdueMiniute
        {
            get
            {
                return Convert.ToInt32(FindCacheValue(ConfigContents.TOKEN_OVERDUE_MINIUTE));
            }
        }

        //public static AuthorityModeEnum AuthorityMode
        //{
        //    get
        //    {
        //        //return (AuthorityModeEnum)Convert.ToInt32(FindCacheValue(ConfigContents.AUTHORITY_MODE));
        //        return ConfigurationManager.AppSettings[ConfigContents.AUTHORITY_MODE] == null ? AuthorityModeEnum.Cube :
        //            (AuthorityModeEnum)Enum.Parse(typeof(AuthorityModeEnum), ConfigurationManager.AppSettings[ConfigContents.AUTHORITY_MODE]);
        //    }
        //}
    }
}
