using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Common
{   
    public class SessionContents
    {
        public static readonly string SESSION_ID = "SessionID";
        public static readonly string SSO_TOKEN = "SSOToken";
        public static readonly string DEBUG_MODE = "DebugMode";
        public static readonly string SIGN = "Sign";
        public static readonly string PERMISSION_SERVICE_URL = "PermissionServiceUrl";
    }

    public class ConfigContents
    {
        public static readonly string AUTHORITY_MODE = "AuthorityMode";
        public static readonly string CUBE_SYSTEM_MODE = "CubeSystemMode";        
        public static readonly string CUBE_SYSTEM_ID = "CubeSystemId";
        public static readonly string PERMISSION_SYSTEM_ID = "PermissionSystemId";
        public static readonly string CUBE_SYSTEM_NAME = "CubeSystemName";
        public static readonly string CUBE_PORTAL_TITLE = "CubePortalTitle";
        public static readonly string CUBE_PORTAL_HEADER_INFO = "CubePortalHeaderInfo";        
        public static readonly string CUBE_PORTAL_FOOTER_INFO = "CubePortalFooterInfo";
        public static readonly string CUBE_IS_DEBUG_MODE = "CubeIsDebugMode";
        public static readonly string CUBE_LOGIN_URL = "CubeLoginUrl";
        public static readonly string TOKEN_OVERDUE_MINIUTE = "CubeTokenOverdueMiniute";
    }

    public class ErrorCode
    {
        public static readonly string NO_SSO_INFO = "E0001";
        public static readonly string USER_AUTH_FAILED = "E0002";
    }
}
