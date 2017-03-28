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
            DBUtility.CubeDb.Delete<Cb_Token>(Cb_Token._.User_Id == User.Id);
            ResultDTO result = new ResultDTO() { success = true };
            return result;
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
            user.MenuList = GetMenuImp().DomainList;
            return user;
        }


        private void FoundParentFunctionWithoutRight(FunctionDTO currentFunction, List<FunctionDTO> opFunctionList, List<FunctionDTO> baseFunctionList)
        {
            FunctionDTO parentFunction = CubeDb.From<Cb_Function>()
                    .Where(Cb_Function._.Id == currentFunction.Parent_Function_Id)
                    .Select(Cb_Function._.All)
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
            List<Guid> function_id_list = CubeDb.From<Cb_User_Function>()
                .Where(Cb_User_Function._.User_Id == User.Id)
                .Select(Cb_User_Function._.Function_Id)
                .ToList<Guid>();
            List<FunctionDTO> functionList = functionList = new List<FunctionDTO>();
            if (function_id_list != null)
            {
                functionList = CubeDb.From<Cb_Function>()
                .Where(Cb_Function._.Id.In(function_id_list))
                .Select(Cb_Function._.All)
                .OrderBy(Cb_Function._.Code.Asc)
                .ToList<FunctionDTO>();
            }

            //应为子功能有权限而父功能没有权限的情况
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
            List<SystemDTO> systemList = CubeDb.From<Cb_System>()
                .Where(Cb_System._.Id.In(system_id_list))
                .Select(Cb_System._.All)
                .ToList<SystemDTO>();

            List<Guid> system_group_id_list = systemList.Where(s => s.Group_Id != null).Select(s => s.Group_Id).ToList();
            List<SystemGroupDTO> systemGroupList = CubeDb.From<Cb_System_Group>()
                .Where(Cb_System_Group._.Id.In(system_group_id_list))
                .Select(Cb_System_Group._.All)
                .ToList<SystemGroupDTO>();

            List<Guid> domain_id_list_from_system = systemList.Where(s => s.Domain_Id != null).Select(s => s.Domain_Id).ToList();
            List<Guid> domain_id_list_from_system_group = systemGroupList.Where(sg => sg.Domain_Id != null).Select(sg => sg.Domain_Id).ToList();
            List<Guid> domain_id_list = domain_id_list_from_system.Union(domain_id_list_from_system_group).ToList();
            List<DomainDTO> domainList = CubeDb.From<Cb_Domain>()
                .Where(Cb_Domain._.Id.In(domain_id_list))
                .Select(Cb_Domain._.All)
                .ToList<DomainDTO>();            

            //2.组装function
            foreach (FunctionDTO function in functionList)
            {                
                function.SubFunctionList = functionList.FindAll(f => f.Parent_Function_Id != null && f.Parent_Function_Id.ToString().Equals(function.Id.ToString(), StringComparison.CurrentCultureIgnoreCase));

                if (function.Language_Key != null && !result.LanguageList.Exists(l => l.Language_Key == function.Language_Key))
                {
                    Cb_Language l = CubeDb.From<Cb_Language>()
                        .Where(Cb_Language._.Language_Key == function.Language_Key)
                        .Select(Cb_Language._.All)
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
                    Cb_Language l = CubeDb.From<Cb_Language>()
                        .Where(Cb_Language._.Language_Key == system.Language_Key)
                        .Select(Cb_Language._.All)
                        .ToList().FirstOrDefault();
                    if (l != null)
                    {
                        result.LanguageList.Add(l);
                    }
                }
            }
            //System排序
            systemList = systemList.OrderBy(x => x.Code).ToList();

            //4.组装system group
            foreach (SystemGroupDTO group in systemGroupList)
            {
                group.SystemList = systemList.FindAll(s => s.Group_Id != null
                    && s.Group_Id.ToString().Equals(group.Id.ToString(), StringComparison.CurrentCultureIgnoreCase));
                if (group.Language_Key != null && !result.LanguageList.Exists(l => l.Language_Key == group.Language_Key))
                {
                    Cb_Language l = CubeDb.From<Cb_Language>()
                        .Where(Cb_Language._.Language_Key == group.Language_Key)
                        .Select(Cb_Language._.All)
                        .ToList().FirstOrDefault();
                    if (l != null)
                    {
                        result.LanguageList.Add(l);
                    }
                }
            }
            //system_group排序
            systemGroupList = systemGroupList.OrderBy(x => x.Code).ToList();

            //5.组装domain
            foreach (DomainDTO domain in domainList)
            {
                domain.SystemGroupList = systemGroupList.FindAll(sg => sg.Domain_Id != null
                    && sg.Domain_Id.ToString().Equals(domain.Id.ToString(), StringComparison.CurrentCultureIgnoreCase));
                domain.SystemList = systemList.FindAll(s => (s.Group_Id == null || s.Group_Id == Guid.Empty) && s.Domain_Id != null
                    && s.Domain_Id.ToString().Equals(domain.Id.ToString(), StringComparison.CurrentCultureIgnoreCase));
            }

            //去除多余的Others
            DomainDTO othersDomain = new DomainDTO()
            {
                Id = Guid.Empty,
                Name = "Others"
            };
            othersDomain.SystemList = systemList.FindAll(s => (s.Group_Id == null || s.Group_Id == Guid.Empty)
                && (s.Domain_Id == null || s.Domain_Id == Guid.Empty));
            othersDomain.SystemGroupList = systemGroupList.FindAll(sg => sg.Domain_Id == null || sg.Domain_Id == Guid.Empty);
            if (othersDomain.SystemList.Count() > 0 || othersDomain.SystemGroupList.Count() > 0)
            {
                domainList.Add(othersDomain);
            }            

            if (SSOContext.IsDebug)
            {
                string debugUrl = System.Web.HttpUtility.UrlDecode(SSOContext.LocalDebugUrl).Replace("http://", "").Replace("https://", "");
                DomainDTO debugDomain = new DomainDTO();
                debugDomain.Id = Guid.NewGuid();
                debugDomain.Name = "Debug";

                SystemDTO debugSystem = new SystemDTO();
                debugSystem.Code = "DEBUG";
                debugSystem.Id = Guid.NewGuid();

                FunctionDTO debugFunction = new FunctionDTO();
                debugFunction.Code = "DEBUG";
                debugFunction.Id = Guid.NewGuid();
                debugFunction.Language_Key = "lang_debug";
                debugFunction.Url = debugUrl;

                debugSystem.FunctionList.Add(debugFunction);
                debugDomain.SystemList.Add(debugSystem);
                domainList.Add(debugDomain);
            }
            result.DomainList = domainList;
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
            List<RoleDTO> list = DBUtility.CubeDb.From<Cb_User_Role>()
                .LeftJoin<Cb_Role>(Cb_Role._.Id == Cb_User_Role._.Role_Id)
                .Where(Cb_User_Role._.User_Id == User.Id)
                .Select(
                Cb_User_Role._.Role_Id
                , Cb_Role._.Name
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
            PreferenceDTO preference = DBUtility.CubeDb.From<Cb_Preference>()
                .Where(Cb_Preference._.User_Id == User.Id)
                .Select(
                    Cb_Preference._.Skin.As("theme")
                    , Cb_Preference._.Language_Key.As("language")
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
            UserBasicInfoDTO user = DBUtility.CubeDb.From<Cb_User>()
                .Where(Cb_User._.Id == User.Id)
                .Select(Cb_User._.All)
                .First<UserBasicInfoDTO>();
            return user ?? new UserBasicInfoDTO();
        }

        #endregion
    }
}


