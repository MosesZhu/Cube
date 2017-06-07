﻿using Cube.Base.Config;
using Cube.Base.Utility;
using ITS.WebFramework.SSO.SSOModule;
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
            //if (CubeConfig.AuthorityMode == Enums.AuthorityModeEnum.WFK)
            //{
            //    SSOModule wfkSSOModule = new SSOModule();
            //    context.BeginRequest += wfkSSOModule.BeginRequest;
            //}
            //else
            //{
            //    context.BeginRequest += process;
            //}

            //SSOModule wfkSSOModule = new SSOModule();
            //context.BeginRequest += wfkSSOModule.BeginRequest;
            context.BeginRequest += cubeProcess;
        }

        private static void cubeProcess(Object source, EventArgs args)
        {
#if DEBUG
            //HttpApplication application = (HttpApplication)source;
            //HttpContext context = application.Context;
            //string requestPath = context.Request.AppRelativeCurrentExecutionFilePath;
            //string requestFile = System.IO.Path.GetFileName(requestPath);
            //if (!requestFile.Equals("@debug.aspx", StringComparison.CurrentCultureIgnoreCase))
            //{
            //    context.Response.Write("Hahaha");
            //    context.Response.End();
            //}            
#endif
            SSOModule wfkSSOModule = new SSOModule();
            wfkSSOModule.BeginRequest(source, args);
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

    }
}