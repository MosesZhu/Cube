using ITS.WebFramework.PermissionManagement.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Model.DTO
{
    [Serializable]
    public class PortalLinkDTO
    {
        public string WfkResourceUrl { get; set; }
        public List<Portal_Link> PortalLinkList = new List<Portal_Link>();
    }
}
