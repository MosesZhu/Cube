using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Model.DTO
{
    [Serializable]
    public class PortalInfoDTO
    {
        public string HeaderInfo
        {
            get; set;
        }

        public string FooterInfo
        {
            get; set;
        }
    }
}
