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

namespace Cube.Web
{
    public class PortalService : PageServiceBase
    {
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)] 
        [WebMethod]
        public ResultDTO getMenu()
        {
            ResultDTO result = new ResultDTO();
            string userID = User.Id.ToString();
            List<Cb_User_Function> userFunctionList = Db.From<Cb_User_Function>().Where(Cb_User_Function._.User_Id == userID)
                .Select(Cb_User_Function._.All).ToList();
            List<FunctionDTO> functionList = new List<FunctionDTO>();
            List<SystemDTO> systemList = new List<SystemDTO>();
            List<DomainDTO> domainList = new List<DomainDTO>();
            foreach (Cb_User_Function userFunction in userFunctionList)
            {
                string functionId = userFunction.Function_Id.ToString();
                Cb_Function functionEntity = Db.From<Cb_Function>().Where(Cb_Function._.Id == functionId)
                    .Select(Cb_Function._.All).ToList().FirstOrDefault();
                if (functionEntity != null)
                {
                    //Find All System
                    if(!string.IsNullOrEmpty(functionEntity.System_Id))
                    {
                        string systemId = functionEntity.System_Id;
                        if (!systemList.Exists(s => s.Id.Equals(systemId, StringComparison.CurrentCultureIgnoreCase)))
                        {
                            Cb_System systemEntity = Db.From<Cb_System>().Where(Cb_System._.Id == systemId).Select(Cb_System._.All)
                                .ToList().FirstOrDefault();
                            SystemDTO system = new SystemDTO() {
                                Id = systemEntity.Id.ToString(),
                                Code = systemEntity.Code, 
                                Domain_Id = systemEntity.Domian_Id.ToString(),
                                Description = systemEntity.Description, 
                            };
                            if(string.IsNullOrEmpty(functionEntity.Parent_Function_Id)) {
                                system.FunctionList.Add(new FunctionDTO() {
                                    Id = functionEntity.Id.ToString(),
                                    Code = functionEntity.Code, 
                                    Language_Key = functionEntity.Language_Key, 
                                    System_Id = systemId, 
                                    Url = functionEntity.Url
                                });
                            } 
                            else //TODO 递归找寻子功能
                            {
                            }
                            
                            systemList.Add(system);
                        }
                        else
                        {
                            SystemDTO system = systemList.FirstOrDefault(s => s.Id.Equals(systemId, StringComparison.CurrentCultureIgnoreCase));
                            system.FunctionList.Add(new FunctionDTO()
                            {
                                Id = functionEntity.Id.ToString(),
                                Code = functionEntity.Code,
                                Language_Key = functionEntity.Language_Key,
                                System_Id = systemId,
                                Url = functionEntity.Url
                            });
                        }
                    }
                }
            }

            foreach (SystemDTO system in systemList)
            {
                string domainId = system.Domain_Id;
                if (!string.IsNullOrEmpty(domainId) && !domainList.Exists(d => d.Id.Equals(domainId, StringComparison.CurrentCultureIgnoreCase)))
                {
                    Cb_Domain domainEntity = Db.From<Cb_Domain>().Where(Cb_Domain._.Id == domainId).Select(Cb_Domain._.All).ToList().FirstOrDefault();
                    if (domainEntity != null)
                    {
                        DomainDTO domain = new DomainDTO()
                        {
                            Id = domainEntity.Id.ToString(),
                            Name = domainEntity.Name
                        };
                        domain.SystemList.Add(system);
                        domainList.Add(domain);
                    }
                }
            }

            if (SSOContext.IsDebug)
            {
                string debugUrl = System.Web.HttpUtility.UrlDecode(SSOContext.LocalDebugUrl).Replace("http://", "").Replace("https://", "");
                DomainDTO debugDomain = new DomainDTO();
                debugDomain.Id = Guid.NewGuid().ToString();
                debugDomain.Name = "Debug";

                SystemDTO debugSystem = new SystemDTO();
                debugSystem.Code = "DEBUG";
                debugSystem.Id = Guid.NewGuid().ToString();

                FunctionDTO debugFunction = new FunctionDTO();
                debugFunction.Code = "DEBUG";
                debugFunction.Id = Guid.NewGuid().ToString();
                debugFunction.Language_Key = "lang_debug";
                debugFunction.Url = debugUrl;

                debugSystem.FunctionList.Add(debugFunction);
                debugDomain.SystemList.Add(debugSystem);
                domainList.Add(debugDomain);

            }
            result.data = domainList;

            return result;
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)] 
        [WebMethod]
        public ResultDTO logout()
        {
            ResultDTO result = new ResultDTO() { success= true, data = "", errorcode = "", message ="" };
            return result;
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)] 
        [WebMethod]
        public ResultDTO getUserPreference()
        {
            return new ResultDTO();
        }

        [ScriptMethod(ResponseFormat = ResponseFormat.Json)] 
        [WebMethod]
        public ResultDTO getUserInfo()
        {
            return new ResultDTO();
        }
    }
}
