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

        /// <summary>
        /// 获得用户菜单
        /// </summary>
        /// <returns></returns>
        private MenuDTO GetMenuImp()
        {
            MenuDTO result = new MenuDTO();
            //1.当前user的所有function_id_list(并集)
            //List<Cb_User_Function> userFunctionList = DBUtility.CubeDb.From<Cb_User_Function>()
            //    .Where(Cb_User_Function._.User_Id == User.Id)
            //    .Select(Cb_User_Function._.All)
            //    .ToList();
            //List<Guid> roleList = GetRoleList().Select(x => x.Role_Id).ToList();
            //List<Cb_Role_Function> roleFunctionList = DBUtility.CubeDb.From<Cb_Role_Function>()
            //    .Where(Cb_Role_Function._.Role_Id.In(roleList))
            //    .Select(Cb_Role_Function._.All)
            //    .ToList();
            //List<Guid> functionm_id_list =
            //    userFunctionList.Select(x => x.Function_Id).ToList()
            //    .Union(
            //        (roleFunctionList.Select(x => x.Function_Id).ToList())
            //    ).ToList();
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

            List<DomainDTO> domainList = new List<DomainDTO>();
            domainList.Add(new DomainDTO()
            {
                Id = Guid.Empty
                ,
                Name = "Others"
            });
            List<SystemGroupDTO> systemGroupList = new List<SystemGroupDTO>();
            List<SystemDTO> systemList = new List<SystemDTO>();
            List<FunctionDTO> rootFunctionList = new List<FunctionDTO>(); //父function
            //2.组装function_tree
            foreach (FunctionDTO function in functionList)
            {
                string parent_function_id = function.Parent_Function_Id.ToString();
                //(1)向上查找：parent_function
                if (parent_function_id != null && parent_function_id != Guid.Empty.ToString())
                {
                    //(1.1)先在现有的root_function中查找
                    FunctionDTO current_parent_function = null;
                    rootFunctionList.ForEach(x =>
                    {
                        current_parent_function = FindInFunctionTree(x, parent_function_id);
                    });
                    if (current_parent_function != null && parent_function_id != Guid.Empty.ToString())
                    {
                        current_parent_function.SubFunctionList.Add(function);
                    }
                    else
                    {
                        //(1.2)在还剩下的所有function_list里面查找
                        current_parent_function = functionList.Find(x => x.Id.ToString() == parent_function_id);
                        if (current_parent_function != null)
                        {
                            current_parent_function.SubFunctionList.Add(function);
                            rootFunctionList.Add(current_parent_function);
                            functionList.Remove(current_parent_function);//需要将未循环到的parent_function删除
                        }

                    }
                }
                else
                {
                    rootFunctionList.Add(function);
                }
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

            //3.function-system
            foreach (FunctionDTO root_function in rootFunctionList)
            {
                string current_system_id = root_function.System_Id;
                //3.1 现有的systemlist中查找
                SystemDTO system = systemList.Find(x => x.Id.ToString() == current_system_id);
                if (system != null)
                {
                    system.FunctionList.Add(root_function);
                }
                else
                {
                    if (current_system_id != null && current_system_id != Guid.Empty.ToString())
                    {
                        SystemDTO newSystem = CubeDb.From<Cb_System>()
                        .Where(Cb_System._.Id == current_system_id)
                        .Select(Cb_System._.All)
                        .First<SystemDTO>();
                        if (newSystem != null)
                        {
                            newSystem.FunctionList.Add(root_function);
                            systemList.Add(newSystem);
                        }
                    }
                }
                if (root_function.Language_Key != null && !result.LanguageList.Exists(l => l.Language_Key == root_function.Language_Key))
                {
                    Cb_Language l = CubeDb.From<Cb_Language>()
                        .Where(Cb_Language._.Language_Key == root_function.Language_Key)
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

            //4.system-system_group-domain
            foreach (SystemDTO system in systemList)
            {
                string group_id = system.Group_Id.ToString();
                string domain_id = system.Domain_Id.ToString();
                if ((group_id == null || group_id == Guid.Empty.ToString()) && (domain_id == null || domain_id == Guid.Empty.ToString())) //system直接挂到Others下
                {
                    domainList[0].SystemList.Add(system); //[0]默认为Others
                }
                else if (group_id != null && group_id != Guid.Empty.ToString()) //有group_id优先挂到group_id上
                {
                    SystemGroupDTO group = systemGroupList.Find(x => x.Id.ToString() == group_id);
                    if (group != null)
                    {
                        group.SystemList.Add(system);
                    }
                    else
                    {
                        SystemGroupDTO newGroup = CubeDb.From<Cb_System_Group>()
                            .Where(Cb_System_Group._.Id == group)
                            .Select(Cb_System_Group._.All)
                            .First<SystemGroupDTO>();
                        if (newGroup != null)
                        {
                            newGroup.SystemList.Add(system);
                            systemGroupList.Add(newGroup);
                        }

                    }
                }
                else if (domain_id != null && domain_id != Guid.Empty.ToString())
                {
                    DomainDTO domain = domainList.Find(x => x.Id.ToString() == domain_id);
                    if (domain != null)
                    {
                        domain.SystemList.Add(system);
                    }
                    else
                    {
                        DomainDTO newDomain = CubeDb.From<Cb_Domain>()
                            .Where(Cb_Domain._.Id == domain_id)
                            .Select(Cb_Domain._.All)
                            .First<DomainDTO>();
                        if (newDomain != null)
                        {
                            newDomain.SystemList.Add(system);
                            domainList.Add(newDomain);
                        }
                    }
                }
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
            //system_group排序
            systemGroupList = systemGroupList.OrderBy(x => x.Code).ToList();

            //5.system_group-domain
            foreach (SystemGroupDTO group in systemGroupList)
            {
                string domain_id = group.Domain_Id.ToString();
                if (domain_id != null && domain_id != Guid.Empty.ToString())
                {
                    DomainDTO domain = domainList.Find(x => x.Id.ToString() == domain_id);
                    if (domain != null)
                    {
                        domain.SystemGropList.Add(group);
                    }
                    else
                    {
                        DomainDTO newDomain = CubeDb.From<Cb_Domain>()
                            .Where(Cb_Domain._.Id == domain_id)
                            .Select(Cb_Domain._.All)
                            .First<DomainDTO>();
                        if (newDomain != null)
                        {
                            newDomain.SystemGropList.Add(group);
                            domainList.Add(newDomain);
                        }
                    }
                }
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

            //去除多余的Others
            if (domainList[0].SystemList.Count == 0 && domainList[0].SystemGropList.Count == 0)
            {
                domainList.Remove(domainList[0]);
                domainList = domainList.OrderBy(x => x.Name).ToList();
            }
            else
            {
                List<DomainDTO> needOrderDomainList = domainList.Skip(1).OrderBy(x => x.Name).ToList();
                needOrderDomainList.Add(domainList[0]);
                domainList = needOrderDomainList;
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


