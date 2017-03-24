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
        public string ToString()
        {
            return LoginName + "!" + LoginTime.Ticks + "!" + SecretKey.ToString();
        }
        public static TokenDTO Decode(string tokenStr)
        {
            string[] array = tokenStr.Split('!');
            return new TokenDTO() { LoginName = array[0], LoginTime = new DateTime(Convert.ToInt64(array[1])), SecretKey=Guid.Parse(array[2])};
        }
    }
}
