using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Model.DTO
{
    [Serializable]
    public class DomainDTO
    {
        public Guid Id { get; set; }
        public string Name { get; set; }
        public List<SystemDTO> SystemList { get; set; }
        public List<SystemGroupDTO> SystemGropList { get; set; }
        public DomainDTO()
        {
            SystemList = new List<SystemDTO>();
            SystemGropList = new List<SystemGroupDTO>();
        }
    }
}
