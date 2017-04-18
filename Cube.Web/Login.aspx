<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Portal.Master" CodeBehind="Login.aspx.cs" Inherits="Cube.Web.Login" %>

<asp:Content ID="PageStyleContent" ContentPlaceHolderID="PageStyleContentHolder" runat="server">
    <style>
        body {
            background-color: #d2d6de;
        }

        .loader {
            background: #000;
            background: -webkit-radial-gradient(#222, #000);
            background: radial-gradient(#222, #000);
            bottom: 0;
            left: 0;
            overflow: hidden;
            position: fixed;
            right: 0;
            top: 0;
            z-index: 99999;
            opacity:0.3;
            display:none;
        }

        .loader-inner {
            bottom: 0;
            height: 60px;
            left: 0;
            margin: auto;
            position: absolute;
            right: 0;
            top: 0;
            width: 100px;
        }

        .loader-line-wrap {
            -webkit-animation: spin 2000ms cubic-bezier(.175, .885, .32, 1.275) infinite;
            animation: spin 2000ms cubic-bezier(.175, .885, .32, 1.275) infinite;
            box-sizing: border-box;
            height: 50px;
            left: 0;
            overflow: hidden;
            position: absolute;
            top: 0;
            -webkit-transform-origin: 50% 100%;
            transform-origin: 50% 100%;
            width: 100px;
        }

        .loader-line {
            border: 4px solid transparent;
            border-radius: 100%;
            box-sizing: border-box;
            height: 100px;
            left: 0;
            margin: 0 auto;
            position: absolute;
            right: 0;
            top: 0;
            width: 100px;
        }

        .loader-line-wrap:nth-child(1) {
            -webkit-animation-delay: -50ms;
            animation-delay: -50ms;
        }

        .loader-line-wrap:nth-child(2) {
            -webkit-animation-delay: -100ms;
            animation-delay: -100ms;
        }

        .loader-line-wrap:nth-child(3) {
            -webkit-animation-delay: -150ms;
            animation-delay: -150ms;
        }

        .loader-line-wrap:nth-child(4) {
            -webkit-animation-delay: -200ms;
            animation-delay: -200ms;
        }

        .loader-line-wrap:nth-child(5) {
            -webkit-animation-delay: -250ms;
            animation-delay: -250ms;
        }

        .loader-line-wrap:nth-child(1) .loader-line {
            border-color: hsl(0, 80%, 60%);
            height: 90px;
            width: 90px;
            top: 7px;
        }

        .loader-line-wrap:nth-child(2) .loader-line {
            border-color: hsl(60, 80%, 60%);
            height: 76px;
            width: 76px;
            top: 14px;
        }

        .loader-line-wrap:nth-child(3) .loader-line {
            border-color: hsl(120, 80%, 60%);
            height: 62px;
            width: 62px;
            top: 21px;
        }

        .loader-line-wrap:nth-child(4) .loader-line {
            border-color: hsl(180, 80%, 60%);
            height: 48px;
            width: 48px;
            top: 28px;
        }

        .loader-line-wrap:nth-child(5) .loader-line {
            border-color: hsl(240, 80%, 60%);
            height: 34px;
            width: 34px;
            top: 35px;
        }

        @-webkit-keyframes spin {
            0%, 15% {
                -webkit-transform: rotate(0);
                transform: rotate(0);
            }

            100% {
                -webkit-transform: rotate(360deg);
                transform: rotate(360deg);
            }
        }

        @keyframes spin {
            0%, 15% {
                -webkit-transform: rotate(0);
                transform: rotate(0);
            }

            100% {
                -webkit-transform: rotate(360deg);
                transform: rotate(360deg);
            }
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
        <select class="form-control select2" style="width: 100%;" id="ddlProduct" onchange="changeProduct()">
        </select>
      </div>
      <div class="form-group has-feedback">
        <select class="form-control select2" style="width: 100%;" id="ddlOrg" onchange="changeOrg()">
        </select>
      </div>
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="Name" id="tbxName">
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Password" id="tbxPassword">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <select class="form-control select2" style="width: 100%;" id="ddlLanguage" onchange="return changeLanguage();">
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
    <div class="loader" id="loader">
        <div class="loader-inner">
            <div class="loader-line-wrap">
                <div class="loader-line"></div>
            </div>
            <div class="loader-line-wrap">
                <div class="loader-line"></div>
            </div>
            <div class="loader-line-wrap">
                <div class="loader-line"></div>
            </div>
            <div class="loader-line-wrap">
                <div class="loader-line"></div>
            </div>
            <div class="loader-line-wrap">
                <div class="loader-line"></div>
            </div>
        </div>
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

            initProductOrgList();
        });

        var ProductOrgList = null;

        var initProductOrgList = function () {
            $.ajax({
                url: "LoginService.asmx/getProductOrgList",
                dataType: "json",
                type: "POST",
                contentType: "application/json",
                success: function (data) {
                    var d = data.d;
                    $.dialog.closeLoading();
                    if (d.success) {
                        var opHtml = "";
                        ProductOrgList = d.data;
                        $.each(ProductOrgList, function (i, product) {
                            opHtml += "<option value='" + product.Id + "'>" + product.Name + "</option>";
                        });

                        $("#ddlProduct").html(opHtml);
                        changeProduct();
                    }
                },
                error: function (e) {
                    $.dialog.closeLoading();
                    $.dialog.showMessage("error", e.responseText);
                }
            });
        };

        var changeProduct = function () {
            var productId = $("#ddlProduct").val();
            $("#ddlOrg").html();
            var orgHtml = "";
            $.each(ProductOrgList, function (i, product) {
                if (productId == product.Id) {
                    $.each(product.OrgList, function (j, org) {
                        orgHtml += "<option value='" + org.Id + "'>" + org.Name + "</option>";
                    });                    
                    return false;
                }
            });
            $("#ddlOrg").html(orgHtml);
        };

        var changeLanguage = function () {
            setLanguage($("#ddlLanguage").val());
        };

        var login = function () {
            $.dialog.showLoading();
            var param = {
                userName: $("#tbxName").val(),
                password: $("#tbxPassword").val(),
                productId: $("#ddlProduct").val(),
                orgId: $("#ddlOrg").val()
            }         

            $.ajax({
                url: "LoginService.asmx/login",
                dataType: "json",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(param),
                success: function (data) {
                    $.dialog.closeLoading();
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
                        $.dialog.showMessage(_CurrentLang.lang_error, _CurrentLang.lang_msg_login_failed);
                    }
                },
                error: function (e) {
                    $.dialog.closeLoading();
                    $.dialog.showMessage("error", e.responseText);
                }
            });

            return false;
        };
    </script>
</asp:Content>

