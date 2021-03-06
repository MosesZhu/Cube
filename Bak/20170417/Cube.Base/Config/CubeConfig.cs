﻿using Cube.Common;
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
            _cache[ConfigContents.CUBE_LOGIN_URL] = ConfigurationManager.AppSettings[ConfigContents.CUBE_LOGIN_URL];
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
                return String.Equals(FindCacheValue(ConfigContents.CUBE_IS_DEBUG_MODE), "true", StringComparison.CurrentCultureIgnoreCase);
            }
        }

        public static string LoginUrl
        {
            get {
                return FindCacheValue(ConfigContents.CUBE_LOGIN_URL);
            }
        }

        public static int TokenOverdueMiniute
        {
            get
            {
                return Convert.ToInt32(FindCacheValue(ConfigContents.TOKEN_OVERDUE_MINIUTE));
            }
        }
    }
}
