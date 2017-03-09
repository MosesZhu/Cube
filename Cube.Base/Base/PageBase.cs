using Cube.Base.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
//using ITS.Data;

namespace Cube.Base
{
    public class PageBase : Page
    {
        public List<string> MultiLanguageKeyList { get; set; }

        public PageBase()
        {
            //string token = HttpContext.Current.Request["SSOToken"];
            //if(string.IsNullOrEmpty(token))
            //{
            //    Response.Redirect(CubeConfig.LoginUrl);
            //}

            this.MultiLanguageKeyList = new List<string>();
            List<string> formMultiLanguageKeyList = GetFormMultiLanguageKeyList();
            if (formMultiLanguageKeyList != null)
            {
                foreach (string key in formMultiLanguageKeyList)
                {
                    this.MultiLanguageKeyList.Add(key);
                }
            }

            this.PreInit += PageBase_PreInit;
        }


        protected virtual List<string> GetFormMultiLanguageKeyList()
        {
            return null;
        }

        //For Test
        public class Lang
        {
            public string Key { get; set; }
            public string Value_EnUS { get; set; }
            public string Value_ZhCN { get; set; }
            public string Value_ZhTW { get; set; }
        }

        List<Lang> _lang = new List<Lang>();
        //End Test

        //Multi-Language
        void PageBase_PreInit(object sender, EventArgs e)
        {
            //For Test
            _lang.Add(new Lang() { Key = "lang_BaseDataMaintain", Value_EnUS = "enus", Value_ZhCN = "zhcn", Value_ZhTW = "zhtw" });
            _lang.Add(new Lang() { Key = "lang_Language", Value_EnUS = "English", Value_ZhCN = "中文简体", Value_ZhTW = "中文繁體" });
            _lang.Add(new Lang() { Key = "lang_Confirm", Value_EnUS = "Confirm", Value_ZhCN = "确定", Value_ZhTW = "確認" });
            _lang.Add(new Lang() { Key = "lang_Themes", Value_EnUS = "Themes", Value_ZhCN = "皮肤", Value_ZhTW = "皮膚" });
            _lang.Add(new Lang() { Key = "lang_item_no", Value_EnUS = "Item NO.", Value_ZhCN = "料号", Value_ZhTW = "料號" });
            //End Test

            //List<string> langKeyList = new List<string>();
            foreach (Control control in this.Controls)
            {
                if (control is HtmlForm)
                {
                    string formHtmlStr = ((HtmlForm)control).InnerHtml;
                    MatchCollection matchList = Regex.Matches(formHtmlStr, "lang(\\s)*=(\\s)*(\"|\')[a-zA-Z0-9_]*(\"|\')");
                    foreach (Match match in matchList)
                    {
                        string langKeyHtmlStr = match.Value;
                        string langKey = Regex.Matches(langKeyHtmlStr, "(\"|\')[a-zA-Z0-9_]*(\"|\')")[0].Value.TrimStart('\'').TrimStart('\"').TrimEnd('\'').TrimEnd('\"');
                        if (!MultiLanguageKeyList.Contains(langKey))
                        {
                            MultiLanguageKeyList.Add(langKey);
                        }
                    }
                }
            }

            string langJsStr_ZhCN = "window._Lang_ZhCN = {";
            string langJsStr_ZhTW = "window._Lang_ZhTW = {";
            string langJsStr_EnUS = "window._Lang_EnUS = {";
            foreach (string langKey in MultiLanguageKeyList)
            {
                Lang thisLang = _lang.FirstOrDefault(l => l.Key == langKey);
                if (thisLang != null)
                {
                    langJsStr_ZhCN += "\"" + langKey + "\":\"" + thisLang.Value_ZhCN + "\",";
                    langJsStr_ZhTW += "\"" + langKey + "\":\"" + thisLang.Value_ZhTW + "\",";
                    langJsStr_EnUS += "\"" + langKey + "\":\"" + thisLang.Value_EnUS + "\",";
                }
            }
            langJsStr_ZhCN = langJsStr_ZhCN.TrimEnd(',') + "};";
            langJsStr_ZhTW = langJsStr_ZhTW.TrimEnd(',') + "};";
            langJsStr_EnUS = langJsStr_EnUS.TrimEnd(',') + "};";
            string totalJsStr = langJsStr_ZhCN + "\r\n" + langJsStr_ZhTW + "\r\n" + langJsStr_EnUS;

            if (!Page.ClientScript.IsClientScriptBlockRegistered(this.GetType(), "keys"))
            {

                Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "keys", totalJsStr, true);

            }
        }
    }
}
