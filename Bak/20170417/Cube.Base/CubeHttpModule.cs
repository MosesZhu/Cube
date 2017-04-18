using Cube.Base.Config;
using Cube.Base.Utility;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace Cube.Base
{
    public class CubeHttpModule : IHttpModule
    {
        public static List<string> mUnCheckUrlList = null;
        public static List<string> UnCheckUrlList 
        {
            get
            { 
                if(mUnCheckUrlList == null)
                {
                    mUnCheckUrlList = new List<string>();                    
                    mUnCheckUrlList.Add(CubeConfig.LoginUrl);
                    mUnCheckUrlList.Add("Test.aspx");
                    mUnCheckUrlList.Add("LoginService.asmx/login");
                }
                return mUnCheckUrlList;
            }
        }

        public void Dispose() { }
        public void Init(HttpApplication context)
        {
            //context.BeginRequest += new EventHandler(Application_BeginRequest);
            //context.EndRequest += new EventHandler(Application_EndRequest);
            context.PreRequestHandlerExecute += process;
        }

        private static void process(Object source, EventArgs args)
        {

            HttpApplication application = (HttpApplication)source;

            HttpContext context = application.Context;

            string token = context.Request["SSOToken"] == null ? context.Request.Headers["SSOToken"] : context.Request["SSOToken"];

            string extensionName = Path.GetExtension(context.Request.Url.LocalPath).ToLower();
            string loginUrl = CubeConfig.LoginUrl;
            if (
                (extensionName == ".aspx" || extensionName == ".asmx" ||
               context.Request.CurrentExecutionFilePathExtension == ".aspx" || context.Request.CurrentExecutionFilePathExtension == ".asmx" )
                && 
                !CubeHttpModule.UnCheckUrlList.Exists(u => context.Request.Url.ToString().ToUpper().Contains(u.ToUpper()))
                )
                //!context.Request.Url.ToString().ToUpper().Contains(loginUrl.ToUpper()))
            {
                if (String.IsNullOrEmpty(token) || !TokenUtility.ValidToken(System.Web.HttpUtility.UrlDecode(token)))
                {
                    #if DEBUG
                    loginUrl += (loginUrl.Contains("?") ? "&" : "?") + "IsDebug=Y&LocalDebugUrl=" + System.Web.HttpUtility.UrlEncode(context.Request.Url.ToString());
                    #endif
                    if (extensionName == ".aspx" || context.Request.CurrentExecutionFilePathExtension.ToLower() == ".aspx")
                    {
                        context.Response.Redirect(loginUrl);
                    }                    
                }
            }            
        }

        public void Application_BeginRequest(object sender, EventArgs e)
        {
            HttpApplication application = (HttpApplication)sender;

            HttpContext context = application.Context;

            string token = (context.Request["SSOToken"] == null || context.Request["SSOToken"] == "null") 
                ? context.Request.Headers["SSOToken"] : context.Request["SSOToken"];

            string extensionName = Path.GetExtension(context.Request.Url.LocalPath);
            string loginUrl = CubeConfig.LoginUrl;
            if (extensionName == ".aspx" || extensionName == ".asmx" ||
               context.Request.CurrentExecutionFilePathExtension == ".aspx" || context.Request.CurrentExecutionFilePathExtension == ".asmx"
                && !context.Request.Url.ToString().ToUpper().Contains(loginUrl.ToUpper()))
            {
                if (String.IsNullOrEmpty(token) || !TokenUtility.ValidToken(System.Web.HttpUtility.UrlDecode(token)))
                {
#if DEBUG
                    loginUrl += loginUrl.Contains("?") ? "&" : "?" + "IsDebug=Y&LocalDebugUrl=" + System.Web.HttpUtility.UrlEncode(context.Request.Url.ToString());
                    //context.Request.Headers.Add("IsDebug", "Y");
                    //context.Request.Headers.Add("LocalDebugUrl", context.Request.Url.ToString());
#endif
                    context.Response.Redirect(loginUrl);
                }
            }            
        }

        public void Application_EndRequest(object sender, EventArgs e)
        {
            HttpApplication application = sender as HttpApplication;
            HttpContext context = application.Context;
            HttpResponse response = context.Response;
            response.Write("这是来自自定义HttpModule中有EndRequest");
        }
    }
}