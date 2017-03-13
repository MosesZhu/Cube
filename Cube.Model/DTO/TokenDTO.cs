using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Model.DTO
{
    [Serializable]
    public class TokenDTO
    {
        public string LoginName { get; set; }
        public DateTime LoginTime { get; set; }
        public Guid SecretKey { get; set; }
    }
}
