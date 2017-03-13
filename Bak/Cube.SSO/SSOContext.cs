using Cube.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Text;
using System.Threading.Tasks;
using System.Web;

namespace Cube.SSO
{
    public class SSOContext
    {
        public long LastLoginTime { get; set; }
        public UserDTO User { get; set; }
        private static readonly Dictionary<string, SSOContext> _clientContextList = 
            new Dictionary<string, SSOContext>();
        public SSOContext() 
        {


        }

        private void Init() 
        { 
        
        }

        public static SSOContext Instance 
        {
            get 
            {
                if (!_clientContextList.ContainsKey(SessionID))
                {
                    SSOContext context = new SSOContext();
                    lock (_clientContextList)
                    {
                        if (!_clientContextList.ContainsKey(SessionID))
                        {
                            _clientContextList.Add(SessionID, context);
                        }
                    }
                }
                return _clientContextList[SessionID];
            }
        }

        public static string SessionID
        {
            get
            {
                string token = null;         
                if (HttpContext.Current != null)
                {
                    token = RequestUtility.GetQueryString<string>(SessionContents.SSO_TOKEN);
                    if (string.IsNullOrEmpty(token))
                    {
                        if (HttpContext.Current.Request.UrlReferrer != null)
                        {
                            token = RequestUtility.GetQueryString<string>(HttpContext.Current.Request.UrlReferrer, SessionContents.SSO_TOKEN);
                        }

                        if (string.IsNullOrEmpty(token)
                            && HttpContext.Current.Session[SessionContents.SESSION_ID] != null)
                        {
                            token = HttpContext.Current.Session[SessionContents.SESSION_ID].ToString();
                        }
                    }
                    if (!string.IsNullOrEmpty(token))
                    {
                        if (HttpContext.Current.Session[SessionContents.SESSION_ID] == null
                            || HttpContext.Current.Session[SessionContents.SESSION_ID] != token)
                        {
                            HttpContext.Current.Session[SessionContents.SESSION_ID] = token;
                        }
                    }
                }
                else
                {
                    token = (CallContext.GetData(SessionContents.SESSION_ID) ?? string.Empty) as string;
                }
                return token;
            }
        }
    }
}
