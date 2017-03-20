using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Cube.DTO;

namespace Cube.Model.DTO
{
    public class UserInfoDTO
    {
        public Guid Id { get; set; }
        public string Login_Name { get; set; }
        public string Name { get; set; }
        public string Mail { get; set; }
        /// <summary>
        /// 用户设置
        /// </summary>
        public PreferenceDTO preference { get; set; }
        /// <summary>
        /// user所在Role
        /// </summary>
        public List<RoleDTO> RoleList { get; set; }
        /// <summary>
        /// user菜单
        /// </summary>
        public List<DomainDTO> MenuList { get; set; }
    }
}
