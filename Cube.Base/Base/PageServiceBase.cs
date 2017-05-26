using Cube.Base.Config;
using Cube.Base.SSO;
using Cube.Base.Utility;
using Cube.Model.DTO;
using Cube.Model.Entity;
using ITS.Data;
using ITS.WebFramework.PermissionComponent.ServiceProxy;
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

        public static DbSession mCubeDBSession;
        public DbSession CubeDb
        {
            get
            {
                if (mCubeDBSession == null)
                {
                    mCubeDBSession = DBUtility.CubeDb;
                }
               
                return mCubeDBSession;
            }
            set
            {
                mCubeDBSession = value;
            }
        }

        private DbSession m_WFKDb;
        public DbSession WFKDb
        {
            get
            {
                return this.m_WFKDb ?? (this.m_WFKDb = new DbSession("WebFramework"));
            }
        }

        //public Mc_User User {
        //    get {
        //        return CubeSSOContext.Current.User;
        //    }
        //}

        //private UserDTO mUserInfo;
        public UserDTO UserInfo {
            get {
                //if (mUserInfo == null)
                //{
                //    try
                //    {
                //        PermissionService permissionService = new PermissionService();
                //        permissionService.Url = ITS.WebFramework.Configuration.Config.Global.PermissionServiceUrl;
                //        mUserInfo = permissionService.GetUserInfo(User.Login_Name);
                //    }
                //    catch (Exception ex)
                //    {
                //    }
                //}
                //return mUserInfo;
                return CubeSSOContext.Current.UserInfo;
            }
        }

        public string ProductName
        {
            get
            {
                return CubeSSOContext.Current.ProductName;
            }
        }

        public Guid ProductId
        {
            get
            {
                return CubeSSOContext.Current.ProductId;
            }
        }

        public Guid OrgId
        {
            get
            {
                return CubeSSOContext.Current.OrgId;
            }
        }

        public PermissionService mPermissionService;
        public PermissionService PermissionService
        {
            get {
                if (mPermissionService == null)
                {
                    mPermissionService = new PermissionService();
                    mPermissionService.Url = ITS.WebFramework.Configuration.Config.Global.PermissionServiceUrl;

                    if (UserInfo != null)
                    {
                        mPermissionService.PermissionServiceSoapValue = new PermissionServiceSoap
                        {
                            Org_Id = CubeSSOContext.Current.OrgId,
                            User_Id = UserInfo.User_ID,
                            Product_Id = CubeSSOContext.Current.ProductId
                        };
                    }
                }
                return mPermissionService;
            }
        }

        public string Language {
            get
            {
                return CubeSSOContext.Language;
            }
        }

        public PageServiceBase()
        {

            if (!Context.Request.Url.ToString().ToUpper().Contains(UNCHECK_URL.ToUpper()) && !ValidateToken())
            {
                throw new Exception("");
            }
        }

        public static string UNCHECK_URL = "LoginService.asmx";
        public bool ValidateToken()
        {
            return TokenUtility.ValidWfkToken();
        }
    }
}
