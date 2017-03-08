<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TestDataMaintainForm.aspx.cs" Inherits="Cube.Web.Test2.Forms.TestDataMaintainForm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div lang="lang_BaseDataMaintain">
            Base Data Maintain
        </div>    
        <input type="button" value="Get Data" onclick="return getData()" />
    </form>    
    <script src="http://localhost/CubePortal/Scripts/jquery-2.2.3.min.js" ></script>    
    <script src="http://localhost/CubePortal/Scripts/jquery.uriAnchor.js" ></script>
    <script src="http://localhost/CubePortal/Scripts/framework.js" ></script>
</body>
</html>
