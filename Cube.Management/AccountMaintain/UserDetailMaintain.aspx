<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="UserDetailMaintain.aspx.cs" Inherits="Cube.Management.AccountMaintain.UserDetailMaintain" %>

<asp:Content ID="PageStyleContent" ContentPlaceHolderID="PageStyleContentHolder" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContentHolder" runat="server">
    <!--inquiry area & toolbar-->
    <div class="row">
        <div class="col-lg-8 col-xs-8">
            <table class="col-lg-12 col-xs-12">
                <tr>
                    <td lang="lang_login_id">Login ID</td>
                    <td class="text-bold" style="padding: 10px;">
                        <input type="text" data-clear-btn="true" name="tbxLoginName" class="form-control"
                            id="tbxLoginName" value="" />
                    </td>
                </tr>
                <tr>
                    <td lang="lang_name">Name</td>
                    <td class="text-bold" style="padding: 10px;">
                        <input type="text" data-clear-btn="true" name="tbxName" class="form-control"
                            id="tbxName" value="" />
                    </td>
                </tr>
                <tr>
                    <td lang="lang_mail">Mail</td>
                    <td class="text-bold" style="padding: 10px;">
                        <input type="text" data-clear-btn="true" name="tbxMail" class="form-control"
                            id="tbxMail" value="" />
                    </td>
                </tr>
            </table>
        </div>

        <div class="col-lg-4 col-xs-4">
            <div class="btn-toolbar" role="toolbar" style="float: right;">
                <button type="button" class="btn btn-primary" onclick="return save();" lang="lang_save">
                    Save
                </button>
                <button type="button" class="btn btn-default" onclick="return cancel();" lang="lang_cancel">
                    Cancel
                </button>
            </div>
        </div>
    </div>    

    <!--edit dialog-->
    
</asp:Content>
<asp:Content ID="PageScriptContent" ContentPlaceHolderID="PageScriptContentHolder" runat="server">
    <script>        
        $(function () {
            init();
        });

        var _UserId;
        var init = function () {
            _UserId = getQueryStringByName("id");
            alert(_UserId);
        };

        var cancel = function () {
            $.goto("UserMaintain.aspx", true);
        };

    </script>
</asp:Content>
