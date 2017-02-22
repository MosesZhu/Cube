using Cube.Common;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Base
{
    public static class Config
    {
        private static void InitCache() 
        {
            //ConfigurationManager.AppSettings[];
            LastCacheTime = DateTime.Now;
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
            return Cache[key] == null ? Cache[key] : defaultValue;
            //return Cache.FirstOrDefault(kv => kv.Key == key) == null ? Cache.FirstOrDefault(kv => kv.Key == key).Value : defaultValue;
        }

        private static Dictionary<string, string> _cache;
        public static Dictionary<string, string> Cache
        {
            get { 
                if(_cache == null || IsCacheOverTime())
                {
                    InitCache();
                }
                
                return _cache;
            }
            set {
                _cache = value;
            }
        }

        public static bool IsDebugMode 
        {
            get {
                return String.Equals(FindCacheValue(ConfigContents.IS_DEBUG_MODE), "true", StringComparison.CurrentCultureIgnoreCase);
            }
        }

        public static string DebugPortalUrl
        {
            get {
                return FindCacheValue(ConfigContents.DEBUG_PORTAL_URL);
            }
        }

        
    }
}
