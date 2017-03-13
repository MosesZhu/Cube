using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.DTO
{
    [Serializable]
    public class ResultDTO
    {
        public bool success { get; set; }
        public string errorcode { get; set; }
        public string message { get; set; }
        public Object data { get; set; }

        public ResultDTO()
        {
            success = true;
        }
    }
}
