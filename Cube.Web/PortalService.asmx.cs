using Cube.Base;
using Cube.Base.SSO;
using Cube.DTO;
using Cube.Model.DTO;
using Cube.Model.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using ITS.Data;
using Cube.Base.Utility;
using ITS.WebFramework.PermissionComponent.ServiceProxy;
using System.Xml;
using Cube.Base.Config;
using ITS.WebFramework.SSO.Business;
using ITS.WebFramework.SSO.Common;
using ITS.WebFramework.Configuration;
using ITS.WebFramework.SSO.Session;
using ITS.WebFramework.PermissionManagement.Entity;
using ITS.WebFramework.PermissionManagement.DTO;
using ITS.WebFramework.Common;
using System.Xml.Linq;

namespace Cube.Web
{
    public class PortalService : PageServiceBase
    {
        #region Web Method

        /// <summary>
        /// API：获得菜单
        /// </summary>
        /// <returns></returns>
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public ResultDTO getMenu()
        {
            ResultDTO result = new ResultDTO()
            {
                success = true
            };            

            List<Guid> BookmarkIdList = CubeDb.From<Mc_Bookmark>()
                .Where(Mc_Bookmark._.User_Id == SSOContext.Current.UserID)
                .Select(Mc_Bookmark._.Function_Id).ToList<Guid>();

            MenuDTO cubeMenu = getMenuFromWfk(BookmarkIdList);
            if (CubeConfig.SystemMode == Base.Enums.CubeSystemModeEnum.Mulity)
            {
                cubeMenu.CubeSystemMode = Base.Enums.CubeSystemModeEnum.Mulity.ToString();
                result.data = cubeMenu;
            }
            else
            {
                if (CubeConfig.CubeSystemId != null)
                {
                    string systemId = CubeConfig.CubeSystemId;
                    string permissionSystemId = CubeConfig.PermissionSystemId;
                    Model.DTO.ProductDTO product = cubeMenu.ProductList.FirstOrDefault(p => 
                        p.DomainList.Exists(d => d.SystemList.Exists(s => s.Id.ToString().Equals(systemId, StringComparison.CurrentCultureIgnoreCase))));
                    Model.DTO.ProductDTO permissionProduct = cubeMenu.ProductList.FirstOrDefault(p =>
                        p.DomainList.Exists(d => d.SystemList.Exists(s => s.Id.ToString().Equals(permissionSystemId, StringComparison.CurrentCultureIgnoreCase))));
                    if (product != null)
                    {
                        Model.DTO.DomainDTO domain = product.DomainList.FirstOrDefault(d => d.SystemList.Exists(s => s.Id.ToString().Equals(systemId, StringComparison.CurrentCultureIgnoreCase)));
                        Model.DTO.SystemDTO system = domain.SystemList.FirstOrDefault(s => s.Id.ToString().Equals(systemId, StringComparison.CurrentCultureIgnoreCase));

                        Model.DTO.DomainDTO permissionDomain = null;
                        Model.DTO.SystemDTO permissionSystem = null;
                        if (permissionProduct != null)
                        {
                            permissionDomain = permissionProduct.DomainList.FirstOrDefault(d => d.SystemList.Exists(s => s.Id.ToString().Equals(permissionSystemId, StringComparison.CurrentCultureIgnoreCase)));
                            permissionSystem = permissionDomain.SystemList.FirstOrDefault(s => s.Id.ToString().Equals(permissionSystemId, StringComparison.CurrentCultureIgnoreCase));
                            if (permissionDomain.Id != domain.Id)
                            {
                                permissionDomain = permissionProduct.DomainList.FirstOrDefault(d => d.SystemList.Exists(s => s.Id.ToString().Equals(permissionSystemId, StringComparison.CurrentCultureIgnoreCase)));
                                permissionSystem = permissionDomain.SystemList.FirstOrDefault(s => s.Id.ToString().Equals(permissionSystemId, StringComparison.CurrentCultureIgnoreCase));
                                permissionDomain.SystemList.Clear();
                                permissionDomain.SystemList.Add(permissionSystem);
                            }
                            else
                            {
                                Model.DTO.DomainDTO tempPermissionDomain = new Model.DTO.DomainDTO();
                                tempPermissionDomain.Id = permissionDomain.Id;
                                tempPermissionDomain.Code = permissionDomain.Code;
                                tempPermissionDomain.Language_Key = permissionDomain.Language_Key;
                                tempPermissionDomain.Product_Id = permissionDomain.Product_Id;
                                tempPermissionDomain.SystemList = new List<Model.DTO.SystemDTO>();
                                tempPermissionDomain.SystemList.Add(permissionSystem);
                                permissionDomain = tempPermissionDomain;
                            }
                        }

                        domain.SystemList.Clear();
                        domain.SystemList.Add(system);                        
                        product.DomainList.Clear();
                        product.DomainList.Add(domain);
                        if (permissionDomain != null)
                        {
                            product.DomainList.Add(permissionDomain);
                        }

                        cubeMenu.BookmarkList.RemoveAll(b => !b.System_Id.Equals(systemId, StringComparison.CurrentCultureIgnoreCase)
                            && !b.System_Id.Equals(permissionSystemId, StringComparison.CurrentCultureIgnoreCase));

                        cubeMenu.CubeSystemMode = Base.Enums.CubeSystemModeEnum.Single.ToString();
                        result.data = cubeMenu;
                    }                    
                }                
            }

            return result;
        }
        public string GetDebugUserSystemFunctionTree(Guid userID, Guid orgID, Guid productID, string systemName, string baseUrl)
        {
            //Get user authorized product function tree data
            string sql = string.Format("select * from dbo.GetDebugUserSystemFunctionTree('{0}','{1}','{2}','{3}','{4}')",
                userID, orgID, productID, systemName, baseUrl);
            List<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO> functionList = WFKDb.FromSql(sql).ToEntityQuery().ToList<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO>();
            return GetFunctionTreeXml(functionList, true);
        }
        private MenuDTO getMenuFromWfk(List<Guid> BookmarkIdList)
        {
            MenuDTO cubeMenu = new MenuDTO();
            string menuXmlStr = "";
            if (DebugHelper.IsDebugMode)
            {
                string systemName = SSOContext.Current.Session["SystemName"].ToString();
                string baseUrl = SSOContext.Current.Session["BaseUrl"].ToString();                
                menuXmlStr = GetDebugUserSystemFunctionTree(SSOContext.Current.UserID,
                        SSOContext.Current.OrgID,
                        SSOContext.Current.ProductID,
                        systemName, baseUrl);
            }
            else
            {
                try
                {
                    menuXmlStr = PermissionService.GetAuthorizedProductFunctionTree(CubeSSOContext.Current.WfkSSOContext.UserID,
                        CubeSSOContext.Current.WfkSSOContext.OrgID,
                        CubeSSOContext.Current.WfkSSOContext.ProductID, true);                    
                }
                catch (Exception ex) { }
            }

            if (!string.IsNullOrEmpty(menuXmlStr))
            {
                Model.DTO.ProductDTO bachProduct = new Model.DTO.ProductDTO()
                {
                    Id = Guid.NewGuid(),
                    Name = CubeSSOContext.Current.ProductName,
                    DomainList = new List<Model.DTO.DomainDTO>()
                };

                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.LoadXml(menuXmlStr);
                XmlNodeList domainNodes = xmlDoc.SelectNodes("/Tree/TreeNode");
                foreach (XmlNode domainNode in domainNodes)
                {
                    if (domainNode.HasChildNodes)
                    {
                        Model.DTO.DomainDTO domain = new Model.DTO.DomainDTO()
                        {
                            Id = Guid.Parse(domainNode.Attributes["NodeID"].Value),
                            Code = domainNode.Attributes["Text"].Value
                        };

                        foreach (XmlNode systemNode in domainNode.ChildNodes)
                        {
                            Model.DTO.SystemDTO system = new Model.DTO.SystemDTO()
                            {
                                Id = Guid.Parse(systemNode.Attributes["NodeID"].Value),
                                Code = systemNode.Attributes["Text"].Value
                            };

                            foreach (XmlNode functionNode in systemNode.ChildNodes)
                            {
                                Model.DTO.FunctionDTO function = new Model.DTO.FunctionDTO()
                                {
                                    Id = Guid.Parse(functionNode.Attributes["NodeID"].Value),
                                    Code = functionNode.Attributes["Text"].Value,
                                    Url = functionNode.Attributes["NavigateUrl"] != null ? functionNode.Attributes["NavigateUrl"].Value : "",
                                    System_Id = system.Id.ToString()
                                };
                                foreach (XmlNode subFunctionNode in functionNode.ChildNodes)
                                {
                                    Model.DTO.FunctionDTO subFunction = new Model.DTO.FunctionDTO()
                                    {
                                        Id = Guid.Parse(subFunctionNode.Attributes["NodeID"].Value),
                                        Code = subFunctionNode.Attributes["Text"].Value,
                                        Url = subFunctionNode.Attributes["NavigateUrl"] != null ? subFunctionNode.Attributes["NavigateUrl"].Value : "",
                                        System_Id = system.Id.ToString()
                                    };
                                    if (BookmarkIdList.Contains(subFunction.Id))
                                    {
                                        cubeMenu.BookmarkList.Add(subFunction);
                                    }
                                    function.SubFunctionList.Add(subFunction);
                                }

                                if (BookmarkIdList.Contains(function.Id))
                                {
                                    cubeMenu.BookmarkList.Add(function);
                                }

                                system.FunctionList.Add(function);
                            }

                            domain.SystemList.Add(system);
                        }

                        bachProduct.DomainList.Add(domain);
                    }
                }
                cubeMenu.ProductList.Add(bachProduct);
            }
            return cubeMenu;
        }

        private static string GetFunctionTreeXml(List<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO> functionList, bool isInternal)
        {
            if (functionList == null || functionList.Count == 0)
            {
                return "";
            }
            //Get domain list
            List<string> domainList = functionList
                .Select<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO, string>(f => f.domain_name)
                .Distinct<string>().ToList<string>();
            if (domainList == null)
            {
                return string.Empty;
            }
            //Get domain,system list
            Dictionary<string, List<string>> domainSystemDicinary = new Dictionary<string, List<string>>();
            domainList.ForEach(d =>
                domainSystemDicinary.Add(d,
                    functionList.Where<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO>(f1 => f1.domain_name == d)
                        .Select<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO, string>(f2 => f2.system_name)
                    .Distinct<string>().ToList<string>()));

            var productFunctionTreeDocument = new XDocument();
            XAttribute clickExpandAttribute = new XAttribute("SingleClickExpand", true);
            try
            {
                Func<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO, XElement> getSubTree = null;
                getSubTree = delegate (ITS.WebFramework.PermissionComponent.DTO.FunctionDTO function)
                {
                    XElement subTree = new XElement("TreeNode");

                    XAttribute nodeId = new XAttribute("NodeID", function.function_id == null ? Guid.Empty : function.function_id);
                    XAttribute text = new XAttribute("Text", GetDefaultValueIfNull(function.function_name));
                    XAttribute code = new XAttribute("Code", GetDefaultValueIfNull(function.function_code));
                    XAttribute description = new XAttribute("Description", GetDefaultValueIfNull(function.function_description));
                    XAttribute assembly = new XAttribute("Assembly", GetDefaultValueIfNull(function.assembly));
                    XAttribute formClass = new XAttribute("FormClass", GetDefaultValueIfNull(function.form_class));
                    XAttribute target = new XAttribute("Target", GetDefaultValueIfNull(function.target));
                    XAttribute instanceType = new XAttribute("InstanceType", GetDefaultValueIfNull(function.instance_type));
                    XAttribute isPublic = new XAttribute("IsPublic", function.is_public);
                    XAttribute systemIconName = new XAttribute("SystemIconName", GetDefaultValueIfNull(function.system_icon_name));
                    XAttribute customIconUrl = new XAttribute("CustomIconUrl", GetDefaultValueIfNull(function.custom_icon_url));
                    XAttribute nodeType = new XAttribute("NodeType", GetDefaultValueIfNull(function.node_type));
                    XAttribute nodeLevelCode = new XAttribute("NodeLevelCode", GetDefaultValueIfNull(function.node_level_code));
                    XAttribute sortCode = new XAttribute("SortCode", function.function_sort_code == null ? 0 : function.function_sort_code);
                    if (string.Compare(function.node_type, "Function", StringComparison.OrdinalIgnoreCase) == 0)
                    {
                        XAttribute navigateUrl;
                        if (isInternal)
                        {
                            navigateUrl = new XAttribute("NavigateUrl", GetDefaultValueIfNull(function.navigate_url));
                        }
                        else
                        {
                            navigateUrl = new XAttribute("NavigateUrl", GetDefaultValueIfNull(function.external_navigate_url));

                        }
                        subTree.Add(nodeId, text, navigateUrl, code, description, assembly, formClass, target, instanceType, isPublic, systemIconName, customIconUrl, nodeType, nodeLevelCode, sortCode);
                    }
                    else
                    {
                        subTree.Add(nodeId, text, code, description, assembly, formClass, target, instanceType, isPublic, systemIconName, customIconUrl, nodeType, nodeLevelCode, sortCode, clickExpandAttribute);
                    }
                    subTree.Add(functionList.Where(f1 =>
                        f1.parent_function_id == function.function_id)
                        .Select<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO, XElement>(f2 => getSubTree(f2)));
                    return subTree;
                };

                //Generate XML tree structure using Linq to XML      
                productFunctionTreeDocument.Add(
                    new XElement("Tree", domainList.Select<string, XElement>(domain_name =>
                        new XElement("TreeNode", new XAttribute("NodeID", functionList.Where<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO>(f => f.domain_name == domain_name).Select<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO, Guid?>(d => d.domain_id).FirstOrDefault<Guid?>()),
                                new XAttribute("Text", GetDefaultValueIfNull(domain_name)),
                                new XAttribute("NodeType", "Domain"),
                                clickExpandAttribute,
                                domainSystemDicinary[domain_name].Select<string, XElement>(system_name =>
                            new XElement("TreeNode", new XAttribute("Text", system_name),
                                new XAttribute("NodeID", functionList.Where<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO>(f => f.system_name == system_name).Select<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO, Guid?>(s => s.system_id).FirstOrDefault<Guid?>()),
                                new XAttribute("DomainID", functionList.Where<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO>(f => f.system_name == system_name).Select<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO, Guid?>(s => s.domain_id).FirstOrDefault<Guid?>()),
                                new XAttribute("Domain", GetDefaultValueIfNull(domain_name)),
                                new XAttribute("Description", functionList.Where<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO>(f => f.system_name == system_name).Select<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO, string>(s => s.system_description).FirstOrDefault<string>()),
                                new XAttribute("InstanceName", functionList.Where<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO>(f => f.system_name == system_name).Select<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO, string>(s => s.instance_name).FirstOrDefault<string>()),
                                new XAttribute("SystemType", functionList.Where<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO>(f => f.system_name == system_name).Select<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO, string>(s => s.system_type).FirstOrDefault<string>()),
                                new XAttribute("NodeType", "System"),
                                clickExpandAttribute,
                                functionList.Where<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO>(f1 => f1.domain_name == domain_name
                                                                    && f1.system_name == system_name
                                                                    && f1.parent_function_id == null)
                                    .Select<ITS.WebFramework.PermissionComponent.DTO.FunctionDTO, XElement>(f2 => getSubTree(f2))))))));
                //productFunctionTreeDocument.Save("filename.xml");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return productFunctionTreeDocument.ToString();
        }

        private static string GetDefaultValueIfNull(string str)
        {
            return string.IsNullOrEmpty(str) ? "" : str;
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public ResultDTO getNews()
        {
            ResultDTO result = new ResultDTO();
            WhereClause where =
                WhereClause.All.And(Portal_News._.Active == 1
                                    && Portal_News._.Due_Date >= DateTime.Today
                                    && Portal_News._.Org_Id == SSOContext.Current.OrgID
                                    && Portal_News._.Product_Id == SSOContext.Current.ProductID);
            result.data = WFKDb.From<Portal_News>().Where(where).ToList<PortalNewsDTO>();
            result.success = true;
            return result;
        }


        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public ResultDTO getPorterInfo()
        {
            return null;
        }
        /// <summary>
        /// API：获得用户偏好设置
        /// </summary>
        /// <returns></returns>
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public ResultDTO getUserPreference()
        {
            ResultDTO result = new ResultDTO()
            {
                success = true,
                data = GetUserPreferenceImp()
            };
            return result;
        }

        /// <summary>
        /// API:获得完整用户信息
        /// </summary>
        /// <returns></returns>
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public ResultDTO getUserInfo()
        {
            return new ResultDTO()
            {
                success = true,
                data = GetUserInfoImp()
            };
        }

        /// <summary>
        /// API：登出
        /// </summary>
        /// <returns></returns>
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public ResultDTO logout()
        {
            //if (CubeConfig.AuthorityMode == Base.Enums.AuthorityModeEnum.WFK)
            //{

            //}
            //else
            //{
            //    DBUtility.CubeDb.Delete<Mc_Token>(Mc_Token._.User_Id == User.Id);
            //}          
            SSOHelper ssoHelper = new SSOHelper { Context = HttpContext.Current };
            ssoHelper.DeleteSSOTicket(Config.Global.SSOTicketName);
            ResultDTO result = new ResultDTO() { success = true };
            return result;
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public ResultDTO addToBookmark(string functionId)
        {
            ResultDTO result = new ResultDTO();
            //if (hasFunctionRight(SSOContext.Current.UserID.ToString(), functionId))
            //{
            //    List<Mc_Bookmark> existBookmarkList = CubeDb.From<Mc_Bookmark>()
            //        .Where(Mc_Bookmark._.User_Id == User.Id && Mc_Bookmark._.Function_Id == functionId)
            //        .ToList();
            //    if (existBookmarkList.Count() == 0)
            //    {
            //        Mc_Bookmark newBookmark = new Mc_Bookmark()
            //        {
            //            User_Id = User.Id,
            //            Function_Id = Guid.Parse(functionId)
            //        };
            //        CubeDb.Insert<Mc_Bookmark>(newBookmark);
            //        result.success = true;
            //    }
            //}
            //else
            //{
            //    result.success = false;
            //    result.message = "No permission";
            //}
            List<Mc_Bookmark> existBookmarkList = CubeDb.From<Mc_Bookmark>()
                    .Where(Mc_Bookmark._.User_Id == SSOContext.Current.UserID && Mc_Bookmark._.Function_Id == functionId)
                    .ToList();
            if (existBookmarkList.Count() == 0)
            {
                Mc_Bookmark newBookmark = new Mc_Bookmark()
                {
                    User_Id = SSOContext.Current.UserID,
                    Function_Id = Guid.Parse(functionId)
                };
                CubeDb.Insert<Mc_Bookmark>(newBookmark);
                result.success = true;
            }
            return result;
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public ResultDTO removeFromBookmark(string functionId)
        {
            ResultDTO result = new ResultDTO();
            CubeDb.Delete<Mc_Bookmark>(Mc_Bookmark._.User_Id == SSOContext.Current.UserID && Mc_Bookmark._.Function_Id == functionId);
            List<Mc_Bookmark> existBookmarkList = CubeDb.From<Mc_Bookmark>()
                    .Where(Mc_Bookmark._.User_Id == SSOContext.Current.UserID && Mc_Bookmark._.Function_Id == functionId)
                    .ToList();
            result.success = true;
            return result;
        }

        private bool hasFunctionRight(string userId, string functionId)
        {
            List<Mc_User_Function> rightList = CubeDb.From<Mc_User_Function>()
                .Where(Mc_User_Function._.User_Id == userId && Mc_User_Function._.Function_Id == functionId)
                .ToList();
            return rightList.Count() > 0;
        }
        #endregion

        #region Method Implement

        public string GetLoginTime(string productName, string orgName, string userName)
        {
            List<DateTime> listLoginTime =
            WFKDb.From<Sso_Login>()
                .Where(Sso_Login._.Product_Name == productName
                       && Sso_Login._.Org_Name == orgName
                       && Sso_Login._.Login_User == userName
                       && Sso_Login._.Is_Success == 1)
                .Select(Sso_Login._.Login_Time)
                .OrderBy(Sso_Login._.Login_Time.Desc)
                .Top(2)
                .ToList<DateTime>();
            if (listLoginTime == null || listLoginTime.Count == 0)
            {
                return string.Empty;
            }
            return listLoginTime.Min().ToLocalTime().ToString("yyyy-MM-dd HH:mm:ss");
        }

        /// <summary>
        /// 从DB中取得user完整信息
        /// </summary>
        /// <returns></returns>
        private UserInfoDTO GetUserInfoImp()
        {
            UserInfoDTO result = new UserInfoDTO();
            result.Id = SSOContext.Current.UserID;
            result.Name = SSOContext.Current.UserName;
            List<Guid> deptIdList = WFKDb.From<Base_Staff_Department>()
                .Where(Base_Staff_Department._.Staff_Id == SSOContext.Current.UserID)
                .Select(Base_Staff_Department._.Department_Id).ToList<Guid>();
            result.DepartmentList = WFKDb.From<Base_Department>()
                .Where(Base_Department._.Id.In(deptIdList))
                .Select(Base_Department._.Department_Name).ToList<String>();
            Base_Staff userEntity = WFKDb.From<Base_Staff>()
                .Where(Base_Staff._.Id == SSOContext.Current.UserID).FirstDefault();
            result.Extension = userEntity.Extension;

            result.LoginTime = GetLoginTime(SSOContext.Current.ProductName, SSOContext.Current.OrgName, SSOContext.Current.UserName);

            Mc_User_Image userImage = CubeDb.From<Mc_User_Image>().Where(Mc_User_Image._.User_Id == SSOContext.Current.UserID).ToList<Mc_User_Image>().FirstOrDefault();
            if (userImage != null)
            {
                result.ImageUrl = userImage.Image;
            }
            return result;

            //UserInfoDTO user = new UserInfoDTO();
            ////(1)基础信息
            //UserBasicInfoDTO basicInfo = GetUserBasicInfo();
            //user.Id = basicInfo.Id;
            //user.Login_Name = basicInfo.Login_Name;
            //user.Name = basicInfo.Name;
            //user.Mail = basicInfo.Mail;
            ////(2)偏好设置
            //user.preference = GetUserPreferenceImp();
            ////(3)Role列表
            //user.RoleList = GetRoleList();
            ////(4)菜单
            //user.MenuList = GetMenuImp().ProductList;
            //return user;
        }


        private void FoundParentFunctionWithoutRight(Cube.Model.DTO.FunctionDTO currentFunction, List<Cube.Model.DTO.FunctionDTO> opFunctionList, List<Cube.Model.DTO.FunctionDTO> baseFunctionList)
        {
            Cube.Model.DTO.FunctionDTO parentFunction = CubeDb.From<Mc_Function>()
                    .Where(Mc_Function._.Id == currentFunction.Parent_Function_Id)
                    .Select(Mc_Function._.All)
                    .ToList<Cube.Model.DTO.FunctionDTO>().FirstOrDefault();
            if (parentFunction != null)
            {
                if (!opFunctionList.Exists(f => f.Id == currentFunction.Parent_Function_Id))
                {
                    opFunctionList.Add(parentFunction);
                }
                if (parentFunction.Parent_Function_Id != null && parentFunction.Parent_Function_Id != Guid.Empty
                     && !baseFunctionList.Exists(f => f.Id == parentFunction.Parent_Function_Id))
                {
                    FoundParentFunctionWithoutRight(parentFunction, opFunctionList, baseFunctionList);
                }  
            }
        }
        /// <summary>
        /// 获得用户菜单
        /// </summary>
        /// <returns></returns>        
        private MenuDTO GetMenuImp()
        {
            MenuDTO result = new MenuDTO();
            //1.当前user的所有function_id_list           
            List<Guid> function_id_list = CubeDb.From<Mc_User_Function>()
                .Where(Mc_User_Function._.User_Id == SSOContext.Current.UserID)
                .Select(Mc_User_Function._.Function_Id)
                .ToList<Guid>();
            List<Cube.Model.DTO.FunctionDTO> functionList = functionList = new List<Cube.Model.DTO.FunctionDTO>();
            if (function_id_list != null)
            {
                functionList = CubeDb.From<Mc_Function>()
                .Where(Mc_Function._.Id.In(function_id_list))
                .Select(Mc_Function._.All)
                .OrderBy(Mc_Function._.Code.Asc)
                .ToList<Cube.Model.DTO.FunctionDTO>();
            }

            //应对子功能有权限而父功能没有权限的情况
            List<Cube.Model.DTO.FunctionDTO> parentFunctionList = new List<Cube.Model.DTO.FunctionDTO>();
            foreach(Cube.Model.DTO.FunctionDTO function in functionList)
            {
                if (function.Parent_Function_Id != null && function.Parent_Function_Id != Guid.Empty
                     && !functionList.Exists(f => f.Id == function.Parent_Function_Id))
                {
                    FoundParentFunctionWithoutRight(function, parentFunctionList, functionList);
                }                
            }
            functionList.AddRange(parentFunctionList);

            List<string> system_id_list = functionList.Where(f => f.System_Id != null).Select(f => f.System_Id).ToList();
            List<Cube.Model.DTO.SystemDTO> systemList = CubeDb.From<Mc_System>()
                .Where(Mc_System._.Id.In(system_id_list))
                .Select(Mc_System._.All)
                .ToList<Cube.Model.DTO.SystemDTO>();

            List<Guid> domain_id_list = systemList.Where(s => s.Domain_Id != null).Select(s => s.Domain_Id).ToList();
            List<Cube.Model.DTO.DomainDTO> domainList = CubeDb.From<Mc_Domain>()
                .Where(Mc_Domain._.Id.In(domain_id_list))
                .Select(Mc_Domain._.All)
                .ToList<Cube.Model.DTO.DomainDTO>();

            List<Guid> product_id_list_from_system = systemList.Where(s => s.Product_Id != null).Select(s => s.Product_Id).ToList();
            List<Guid> product_id_list_from_domain = domainList.Where(d => d.Product_Id != null).Select(d => d.Product_Id).ToList();
            List<Guid> product_id_list = product_id_list_from_system.Union(product_id_list_from_domain).ToList();
            List<Cube.Model.DTO.ProductDTO> productList = CubeDb.From<Mc_Product>()
                .Where(Mc_Product._.Id.In(product_id_list))
                .Select(Mc_Product._.All)
                .ToList<Cube.Model.DTO.ProductDTO>();            

            //2.组装function
            foreach (Cube.Model.DTO.FunctionDTO function in functionList)
            {                
                function.SubFunctionList = functionList.FindAll(f => f.Parent_Function_Id != null && f.Parent_Function_Id.ToString().Equals(function.Id.ToString(), StringComparison.CurrentCultureIgnoreCase));

                if (function.Language_Key != null && !result.LanguageList.Exists(l => l.Language_Key == function.Language_Key))
                {
                    Mc_Language l = CubeDb.From<Mc_Language>()
                        .Where(Mc_Language._.Language_Key == function.Language_Key)
                        .Select(Mc_Language._.All)
                        .ToList().FirstOrDefault();
                    if (l != null)
                    {
                        result.LanguageList.Add(l);
                    }
                }
            }

            //3.组装system
            foreach (Cube.Model.DTO.SystemDTO system in systemList)
            {
                system.FunctionList = functionList.FindAll(f => (f.Parent_Function_Id == null || f.Parent_Function_Id == Guid.Empty)
                    && f.System_Id != null && f.System_Id.ToString().Equals(system.Id.ToString(), StringComparison.CurrentCultureIgnoreCase));

                if (system.Language_Key != null && !result.LanguageList.Exists(l => l.Language_Key == system.Language_Key))
                {
                    Mc_Language l = CubeDb.From<Mc_Language>()
                        .Where(Mc_Language._.Language_Key == system.Language_Key)
                        .Select(Mc_Language._.All)
                        .ToList().FirstOrDefault();
                    if (l != null)
                    {
                        result.LanguageList.Add(l);
                    }
                }
            }
            //System排序
            systemList = systemList.OrderBy(x => x.Code).ToList();

            //4.组装domain
            foreach (Cube.Model.DTO.DomainDTO domain in domainList)
            {
                domain.SystemList = systemList.FindAll(s => s.Domain_Id != null
                    && s.Domain_Id.ToString().Equals(domain.Id.ToString(), StringComparison.CurrentCultureIgnoreCase));
                if (domain.Language_Key != null && !result.LanguageList.Exists(l => l.Language_Key == domain.Language_Key))
                {
                    Mc_Language l = CubeDb.From<Mc_Language>()
                        .Where(Mc_Language._.Language_Key == domain.Language_Key)
                        .Select(Mc_Language._.All)
                        .ToList().FirstOrDefault();
                    if (l != null)
                    {
                        result.LanguageList.Add(l);
                    }
                }
            }
            //domain排序
            domainList = domainList.OrderBy(d => d.Code).ToList();

            //5.组装product
            foreach (Cube.Model.DTO.ProductDTO product in productList)
            {
                product.DomainList = domainList.FindAll(d => d.Product_Id != null
                    && d.Product_Id.ToString().Equals(product.Id.ToString(), StringComparison.CurrentCultureIgnoreCase));
                product.SystemList = systemList.FindAll(s => (s.Domain_Id == null || s.Domain_Id == Guid.Empty) && s.Product_Id != null
                    && s.Product_Id.ToString().Equals(product.Id.ToString(), StringComparison.CurrentCultureIgnoreCase));
            }

            //去除多余的Others
            Cube.Model.DTO.ProductDTO othersProduct = new Cube.Model.DTO.ProductDTO()
            {
                Id = Guid.Empty,
                Name = "Others"
            };
            othersProduct.SystemList = systemList.FindAll(s => (s.Product_Id == null || s.Product_Id == Guid.Empty)
                && (s.Domain_Id == null || s.Domain_Id == Guid.Empty));
            othersProduct.DomainList = domainList.FindAll(sg => sg.Product_Id == null || sg.Product_Id == Guid.Empty);
            if (othersProduct.SystemList.Count() > 0 || othersProduct.DomainList.Count() > 0)
            {
                productList.Add(othersProduct);
            }            

            if (CubeSSOContext.IsDebug)
            {
                string debugUrl = System.Web.HttpUtility.UrlDecode(CubeSSOContext.LocalDebugUrl).Replace("http://", "").Replace("https://", "");
                Cube.Model.DTO.ProductDTO debugProduct = new Cube.Model.DTO.ProductDTO();
                debugProduct.Id = Guid.NewGuid();
                debugProduct.Name = "Debug";

                Cube.Model.DTO.SystemDTO debugSystem = new Cube.Model.DTO.SystemDTO();
                debugSystem.Code = "DEBUG";
                debugSystem.Id = Guid.NewGuid();

                Cube.Model.DTO.FunctionDTO debugFunction = new Cube.Model.DTO.FunctionDTO();
                debugFunction.Code = "DEBUG";
                debugFunction.Id = Guid.NewGuid();
                debugFunction.Language_Key = "lang_debug";
                debugFunction.Url = debugUrl;

                debugSystem.FunctionList.Add(debugFunction);
                debugProduct.SystemList.Add(debugSystem);
                productList.Add(debugProduct);
            }
            result.ProductList = productList;

            List<Guid> BookmarkIdList = CubeDb.From<Mc_Bookmark>()
                .Where(Mc_Bookmark._.User_Id == SSOContext.Current.UserID)
                .Select(Mc_Bookmark._.Function_Id).ToList<Guid>();
            List<Cube.Model.DTO.FunctionDTO> bookmarkFunctionList = CubeDb.From<Mc_Function>()
                .Where(Mc_Function._.Id.In(BookmarkIdList))
                .Select(Mc_Function._.All)
                .OrderBy(Mc_Function._.Code.Asc)
                .ToList<Cube.Model.DTO.FunctionDTO>();
            bookmarkFunctionList.RemoveAll(f => !function_id_list.Contains(f.Id));
            result.BookmarkList = bookmarkFunctionList;

            return result;
        }

        /// <summary>
        /// 递归遍历Function_Tree
        /// </summary>
        /// <param name="current_function"></param>
        /// <param name="function_id"></param>
        /// <returns></returns>
        private Cube.Model.DTO.FunctionDTO FindInFunctionTree(Cube.Model.DTO.FunctionDTO current_function, string function_id)
        {
            if (current_function.SubFunctionList.Count == 0)
            {
                if (current_function.Id.ToString() == function_id)
                {
                    return current_function;
                }
            }
            else
            {
                foreach (var subFunction in current_function.SubFunctionList)
                {
                    FindInFunctionTree(subFunction, function_id);
                }
            }
            return null;
        }

        /// <summary>
        /// 获得Role
        /// </summary>
        /// <returns></returns>
        private List<Cube.Model.DTO.RoleDTO> GetRoleList()
        {
            List<Cube.Model.DTO.RoleDTO> list = DBUtility.CubeDb.From<Mc_User_Role>()
                .LeftJoin<Mc_Role>(Mc_Role._.Id == Mc_User_Role._.Role_Id)
                .Where(Mc_User_Role._.User_Id == SSOContext.Current.UserID)
                .Select(
                Mc_User_Role._.Role_Id
                , Mc_Role._.Name
                )
                .ToList<Cube.Model.DTO.RoleDTO>();
            return list;

        }

        /// <summary>
        /// 获得用户片偏好设置
        /// </summary>
        /// <returns></returns>
        private PreferenceDTO GetUserPreferenceImp()
        {
            PreferenceDTO preference = DBUtility.CubeDb.From<Mc_Preference>()
                .Where(Mc_Preference._.User_Id == SSOContext.Current.UserID)
                .Select(
                    Mc_Preference._.Skin.As("theme")
                    , Mc_Preference._.Language_Key.As("language")
                    )
                .ToList<PreferenceDTO>()
                .FirstOrDefault();
            return preference;
        }

        /// <summary>
        /// 获得用户基础信息
        /// </summary>
        /// <returns></returns>
        private UserBasicInfoDTO GetUserBasicInfo()
        {
            UserBasicInfoDTO user = DBUtility.CubeDb.From<Mc_User>()
                .Where(Mc_User._.Id == SSOContext.Current.UserID)
                .Select(Mc_User._.All)
                .First<UserBasicInfoDTO>();
            return user ?? new UserBasicInfoDTO();
        }

        [WebMethod]
        public ResultDTO getPortalLinkList()
        {
            ResultDTO result = new ResultDTO()
            {
                success = true
            };

            WhereClause where =
                WhereClause.All.And(Portal_Link._.Active == 1
                                    && Portal_Link._.Org_Id.In(SSOContext.Current.OrgID, Guid.Empty)
                                    && Portal_Link._.Product_Id == SSOContext.Current.ProductID
                                    && Portal_Link._.Position == "Top"
                                    );
            List<Portal_Link> listPortalLink =
                WFKDb.From<Portal_Link>()
                     .Where(where)
                     .OrderBy(Portal_Link._.Sort_Code.Asc)
                     .ToList<Portal_Link>();

            result.data = listPortalLink;
            return result;
        }
        #endregion
    }
}


