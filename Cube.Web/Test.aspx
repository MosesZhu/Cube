<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test.aspx.cs" Inherits="Cube.Web.Test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-2.2.3.min.js" type="text/javascript"></script>
    <%--<script src="Scripts/framework.js" type="text/javascript"></script>--%>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <div style="padding:10px;border:1px solid black;text-align:center;"onclick="return login();" >login<div>            
    </div>
    </form>
    <script>
        var login = function () {
            var param = {
                userName: 'Moses.Zhu',
                password: '1'
            }

            //var options = {
            //    "success": function (d) {
            //        alert("s");
            //    }
            //};

            //$.ask("http://10.85.129.44/CubePortal/LoginService.asmx/login", param, options, true);

            $.ajax({
                url: "http://10.85.129.44/CubePortal/LoginService.asmx/login",
                dataType: "json",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(param),
                success: function (d) {
                    alert("s");
                },
                error: function (e) {
                    alert("e");
                }
            });
        };

        $(function () {
            alert();
        });
    </script>
</body>
</html>
