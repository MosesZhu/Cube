using Cube.Model.DTO;
using Cube.Model.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.DTO
{
    [Serializable]
    public class MenuDTO
    {
        public List<DomainDTO> DomainList { get; set; }
        public List<Cb_Language> LanguageList { get; set; }
        public MenuDTO()
        {
            DomainList = new List<DomainDTO>();
            LanguageList = new List<Cb_Language>();
        }
    }
}
