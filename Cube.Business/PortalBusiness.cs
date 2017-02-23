using Cube.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cube.Business
{
    public class PortalBusiness
    {
        public List<MenuDTO> getMenu()
        {
            //Test
            List<MenuDTO> menuList = new List<MenuDTO>();
            MenuDTO Domain_MFG = new MenuDTO();
            Domain_MFG.ID = "xxx";
            Domain_MFG.Code = "MFG";
            Domain_MFG.LanguageID = "lang_MFG";

            MenuDTO System_QML = new MenuDTO();
            System_QML.ID = "xxx_1";
            System_QML.Code = "QML";
            Domain_MFG.LanguageID = "lang_QML";

            MenuDTO Function_QML_1 = new MenuDTO();
            Function_QML_1.ID = "xxx_1_1";
            Function_QML_1.Code = "QML_BASE_DATA_MAINTAIN";
            Function_QML_1.LanguageID = "lang_menu_aaa";
            Function_QML_1.Url = "http://localhost:28937/Forms/TestDataMaintainForm.aspx";

            System_QML.SubMenuList.Add(Function_QML_1);
            Domain_MFG.SubMenuList.Add(System_QML);
            menuList.Add(Domain_MFG);

            return menuList;
        }
    }
}
