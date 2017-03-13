using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Model.DTO
{
    public class SystemDTO
    {
        public string Id { get; set; }
        public string Code { get; set; }
        public string Language_Key { get; set; }
        public string Description { get; set; }
        public string Domain_Id { get; set; }
        public string Group_Id { get; set; }
        public List<FunctionDTO> FunctionList { get; set; }
        public SystemDTO()
        {
            FunctionList = new List<FunctionDTO>();
        }
    }
}
