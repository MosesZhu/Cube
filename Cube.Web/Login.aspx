<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Portal.Master" CodeBehind="Login.aspx.cs" Inherits="Cube.Web.Login" %>

<asp:Content ID="PageStyleContent" ContentPlaceHolderID="PageStyleContentHolder" runat="server">
    <style>
        body {
            background-color: #d2d6de;
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContentHolder" runat="server">
<div class="login-box">
  <div class="login-logo">
    <b style="color:blue">C</b><b style="color:yellow">u</b><b style="color:red">b</b><b style="color:green" />e</b>Framework
  </div>
  <div class="login-box-body">
    <p class="login-box-msg" lang="lang_please_loginin">please login</p>

    
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="Name" id="tbxName">
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Password" id="tbxPassword">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <select class="form-control select2" style="width: 100%;" id="ddlLanguage" onchange="changeLanguage()">
            <option selected="selected" value="EnUS">English</option>
            <option value="ZhCN">中文简体</option>
            <option value="ZhTW">中文繁體</option>
        </select>
      </div>      
      <div class="row">
        <div class="col-xs-8">
          <div class="checkbox icheck">
            <label>

              <input id="cbxRememberMe" type="checkbox" lang="lang_remember_me"> Remember Me
            </label>
          </div>
        </div>
        <!-- /.col -->
        <div class="col-xs-4">            
          <div class="btn btn-primary btn-block btn-flat" lang="lang_login" onclick="return login();" >Login</div>
            <%--<div style="padding:10px; border:1px solid black;" lang="lang_login" onclick="return login();" >Login</div>--%>
        </div>
        <!-- /.col -->
      </div>
    

  </div>
  <!-- /.login-box-body -->
</div>
</asp:Content>
<asp:Content ID="PageScriptContent" ContentPlaceHolderID="PageScriptContentHolder" runat="server">
    <script>
        $(function () {
            $('#cbxRememberMe').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%' // optional
            });

            $("#ddlLanguage").val($.uriAnchor.makeAnchorMap()["lang"]);
            $.language.change($.uriAnchor.makeAnchorMap()["lang"]);
        });

        var changeLanguage = function () {
            setLanguage($("#ddlLanguage").val());
        };

        var login = function () {
            var param = {
                userName: $("#tbxName").val(),
                password: $("#tbxPassword").val()
            }         

            $.ajax({
                url: "LoginService.asmx/login",
                dataType: "json",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(param),
                success: function (data) {
                    var d = data.d;
                    if (d.success) {
                        var token = d.data;
                        var lang = $("#ddlLanguage").val();
                        $.cookie("SSOToken", token);
                        $.cookie("Language", lang);
                        var portalUrl = "Portal?SSOToken=" + token;
                        if (getQueryStringByName('IsDebug') == "Y") {
                            portalUrl += "&IsDebug=Y&LocalDebugUrl=" + getQueryStringByName('LocalDebugUrl');
                        }
                        portalUrl += "#!lang=" + lang;
                        window.location.href = portalUrl;
                    } else {
                        $.dialog.showDialog(_CurrentLang.lang_error, _CurrentLang.lang_msg_login_failed);
                    }
                },
                error: function (e) {
                    $.dialog.showDialog("error", e.responseText);
                }
            });

            return false;
        };
    </script>
</asp:Content>

