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
        public List<ProductDTO> ProductList { get; set; }
        public List<FunctionDTO> BookmarkList { get; set; }
        public List<Mc_Language> LanguageList { get; set; }

        public string WfkResourceUrl { get; set; }

        public string CubeSystemMode { get; set; }
        public MenuDTO()
        {
            ProductList = new List<ProductDTO>();
            LanguageList = new List<Mc_Language>();
            BookmarkList = new List<FunctionDTO>();
        }
    }
}
