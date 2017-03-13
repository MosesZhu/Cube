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
        public string ID { get; set; }
        public string Code { get; set; }
        // public string Type { get; set; }
        // public string DisplayName_ZhCN { get; set; }
        // public string DisplayName_ZhTW { get; set; }
        // public string DisplayName_EnUS { get; set; }
        public string LanguageID { get; set; }
        public string Url { get; set; }
        public List<MenuDTO> SubMenuList { get; set; }

        public MenuDTO() 
        {
            SubMenuList = new List<MenuDTO>();
        } 
    }
}
