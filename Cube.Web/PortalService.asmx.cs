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
                success = true,
                data = GetMenuImp()
            };
            return result;
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
            DBUtility.CubeDb.Delete<Mc_Token>(Mc_Token._.User_Id == User.Id);
            ResultDTO result = new ResultDTO() { success = true };
            return result;
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        [WebMethod]
        public ResultDTO addToBookmark(string functionId)
        {
            ResultDTO result = new ResultDTO();
            if (hasFunctionRight(User.Id.ToString(), functionId))
            {
                List<Mc_Bookmark> existBookmarkList = CubeDb.From<Mc_Bookmark>()
                    .Where(Mc_Bookmark._.User_Id == User.Id && Mc_Bookmark._.Function_Id == functionId)
                    .ToList();
                if (existBookmarkList.Count() == 0)
                {
                    Mc_Bookmark newBookmark = new Mc_Bookmark()
                    {
                        User_Id = User.Id,
                        Function_Id = Guid.Parse(functionId)
                    };
                    CubeDb.Insert<Mc_Bookmark>(newBookmark);
                    result.success = true;
                }
            }
            else
            {
                result.success = false;
                result.message = "No permission";
            }
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

        /// <summary>
        /// 从DB中取得user完整信息
        /// </summary>
        /// <returns></returns>
        private UserInfoDTO GetUserInfoImp()
        {
            UserInfoDTO user = new UserInfoDTO();
            //(1)基础信息
            UserBasicInfoDTO basicInfo = GetUserBasicInfo();
            user.Id = basicInfo.Id;
            user.Login_Name = basicInfo.Login_Name;
            user.Name = basicInfo.Name;
            user.Mail = basicInfo.Mail;
            //(2)偏好设置
            user.preference = GetUserPreferenceImp();
            //(3)Role列表
            user.RoleList = GetRoleList();
            //(4)菜单
            user.MenuList = GetMenuImp().ProductList;
            return user;
        }


        private void FoundParentFunctionWithoutRight(FunctionDTO currentFunction, List<FunctionDTO> opFunctionList, List<FunctionDTO> baseFunctionList)
        {
            FunctionDTO parentFunction = CubeDb.From<Mc_Function>()
                    .Where(Mc_Function._.Id == currentFunction.Parent_Function_Id)
                    .Select(Mc_Function._.All)
                    .ToList<FunctionDTO>().FirstOrDefault();
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
                .Where(Mc_User_Function._.User_Id == User.Id)
                .Select(Mc_User_Function._.Function_Id)
                .ToList<Guid>();
            List<FunctionDTO> functionList = functionList = new List<FunctionDTO>();
            if (function_id_list != null)
            {
                functionList = CubeDb.From<Mc_Function>()
                .Where(Mc_Function._.Id.In(function_id_list))
                .Select(Mc_Function._.All)
                .OrderBy(Mc_Function._.Code.Asc)
                .ToList<FunctionDTO>();
            }

            //应对子功能有权限而父功能没有权限的情况
            List<FunctionDTO> parentFunctionList = new List<FunctionDTO>();
            foreach(FunctionDTO function in functionList)
            {
                if (function.Parent_Function_Id != null && function.Parent_Function_Id != Guid.Empty
                     && !functionList.Exists(f => f.Id == function.Parent_Function_Id))
                {
                    FoundParentFunctionWithoutRight(function, parentFunctionList, functionList);
                }                
            }
            functionList.AddRange(parentFunctionList);

            List<string> system_id_list = functionList.Where(f => f.System_Id != null).Select(f => f.System_Id).ToList();
            List<SystemDTO> systemList = CubeDb.From<Mc_System>()
                .Where(Mc_System._.Id.In(system_id_list))
                .Select(Mc_System._.All)
                .ToList<SystemDTO>();

            List<Guid> domain_id_list = systemList.Where(s => s.Domain_Id != null).Select(s => s.Domain_Id).ToList();
            List<DomainDTO> domainList = CubeDb.From<Mc_Domain>()
                .Where(Mc_Domain._.Id.In(domain_id_list))
                .Select(Mc_Domain._.All)
                .ToList<DomainDTO>();

            List<Guid> product_id_list_from_system = systemList.Where(s => s.Product_Id != null).Select(s => s.Product_Id).ToList();
            List<Guid> product_id_list_from_domain = domainList.Where(d => d.Product_Id != null).Select(d => d.Product_Id).ToList();
            List<Guid> product_id_list = product_id_list_from_system.Union(product_id_list_from_domain).ToList();
            List<ProductDTO> productList = CubeDb.From<Mc_Product>()
                .Where(Mc_Product._.Id.In(product_id_list))
                .Select(Mc_Product._.All)
                .ToList<ProductDTO>();            

            //2.组装function
            foreach (FunctionDTO function in functionList)
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
            foreach (SystemDTO system in systemList)
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
            foreach (DomainDTO domain in domainList)
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
            foreach (ProductDTO product in productList)
            {
                product.DomainList = domainList.FindAll(d => d.Product_Id != null
                    && d.Product_Id.ToString().Equals(product.Id.ToString(), StringComparison.CurrentCultureIgnoreCase));
                product.SystemList = systemList.FindAll(s => (s.Domain_Id == null || s.Domain_Id == Guid.Empty) && s.Product_Id != null
                    && s.Product_Id.ToString().Equals(product.Id.ToString(), StringComparison.CurrentCultureIgnoreCase));
            }

            //去除多余的Others
            ProductDTO othersProduct = new ProductDTO()
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

            if (SSOContext.IsDebug)
            {
                string debugUrl = System.Web.HttpUtility.UrlDecode(SSOContext.LocalDebugUrl).Replace("http://", "").Replace("https://", "");
                ProductDTO debugProduct = new ProductDTO();
                debugProduct.Id = Guid.NewGuid();
                debugProduct.Name = "Debug";

                SystemDTO debugSystem = new SystemDTO();
                debugSystem.Code = "DEBUG";
                debugSystem.Id = Guid.NewGuid();

                FunctionDTO debugFunction = new FunctionDTO();
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
                .Where(Mc_Bookmark._.User_Id == User.Id)
                .Select(Mc_Bookmark._.Function_Id).ToList<Guid>();
            List<FunctionDTO> bookmarkFunctionList = CubeDb.From<Mc_Function>()
                .Where(Mc_Function._.Id.In(BookmarkIdList))
                .Select(Mc_Function._.All)
                .OrderBy(Mc_Function._.Code.Asc)
                .ToList<FunctionDTO>();
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
        private FunctionDTO FindInFunctionTree(FunctionDTO current_function, string function_id)
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
        private List<RoleDTO> GetRoleList()
        {
            List<RoleDTO> list = DBUtility.CubeDb.From<Mc_User_Role>()
                .LeftJoin<Mc_Role>(Mc_Role._.Id == Mc_User_Role._.Role_Id)
                .Where(Mc_User_Role._.User_Id == User.Id)
                .Select(
                Mc_User_Role._.Role_Id
                , Mc_Role._.Name
                )
                .ToList<RoleDTO>();
            return list;

        }

        /// <summary>
        /// 获得用户片偏好设置
        /// </summary>
        /// <returns></returns>
        private PreferenceDTO GetUserPreferenceImp()
        {
            PreferenceDTO preference = DBUtility.CubeDb.From<Mc_Preference>()
                .Where(Mc_Preference._.User_Id == User.Id)
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
                .Where(Mc_User._.Id == User.Id)
                .Select(Mc_User._.All)
                .First<UserBasicInfoDTO>();
            return user ?? new UserBasicInfoDTO();
        }

        #endregion
    }
}


