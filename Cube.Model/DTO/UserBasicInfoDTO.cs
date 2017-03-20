using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Model.DTO
{
    public class UserBasicInfoDTO
    {
        public Guid Id { get; set; }
        public string Login_Name { get; set; }
        public string Name { get; set; }
        public string Mail { get; set; }
    }
}
