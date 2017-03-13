using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Model.DTO
{
    public class SystemGroupDTO
    {
        public string Id { get; set; }
        public string Code { get; set; }
        public string Domain_Id { get; set; }
        public string Language_Key { get; set; }
        public List<SystemDTO> SystemList { get; set; }
        public SystemGroupDTO()
        {
            SystemList = new List<SystemDTO>();
        }
    }
}
