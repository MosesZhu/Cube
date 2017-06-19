<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Portal.Master" CodeBehind="Login.aspx.cs" Inherits="Cube.Web.Login" %>

<asp:Content ID="PageStyleContent" ContentPlaceHolderID="PageHeadContentHolder" runat="server">
    <title>Login</title>
    <style>
        body {
            background-color: #d2d6de;
        }

    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContentHolder" runat="server">
    <div class="login-box">
  <div class="login-logo">
      <asp:Label ID="lblSystemName" runat="server" Text="Login"></asp:Label>
  </div>
  <div class="login-box-body">
    <p class="login-box-msg" lang="lang_please_loginin">please login</p>
      <div class="form-group has-feedback">
        <div class="col-md-6 col-lg-6 col-sm-6">
            <input type ="radio" name="isNT" checked="checked" value="Y" id="rdoInternalUser" onchange="return changeUserPosition();"/>
            <label for="rdoInternalUser" lang="lang_for_internal_user">For Internal User</label>
        </div>
        <div class="col-md-6 col-lg-6 col-sm-6">            
          <input type ="radio" name="isNT" value="N" id="rdoExternalUser" onchange="return changeUserPosition();"/>
          <label for="rdoExternalUser" lang="lang_for_external_user">For External User</label>
        </div>
      </div>
      <div class="form-group has-feedback">
        <select class="form-control select2" style="width: 100%;padding-right: 20px;" id="ddlProduct" onchange="changeProduct()">
        </select>
      </div>
      <div class="form-group has-feedback">
        <select class="form-control select2" style="width: 100%;padding-right: 20px;" id="ddlOrg" onchange="changeOrg()">
        </select>
      </div>
      <div class="form-group has-feedback">
        <input type="text" class="form-control" placeholder="Name" id="tbxName" lang="lang_user_name">
        <span class="glyphicon glyphicon-user form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" placeholder="Password" id="tbxPassword" lang="lang_password">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <select class="form-control select2" style="width: 100%;padding-right: 20px;" id="ddlDomain">
        </select>
      </div>
      <div class="form-group has-feedback">
        <select class="form-control select2" style="width: 100%;padding-right: 20px;" id="ddlLanguage" onchange="return changeLanguage();">
            <option selected="selected" value="EnUS">English</option>
            <option value="ZhCN">中文简体</option>
            <option value="ZhTW">中文繁體</option>
        </select>
      </div>
      <div class="row">
        <div class="col-xs-8">
          <div class="checkbox icheck">
            <label>

              <input id="cbxRememberMe" type="checkbox">
              <label for="cbxRememberMe" lang="lang_remember_me" style="padding-left:10px;">Remember Me</label>
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
    <div class="cube-loader-mask" id="loader-mask">
        &nbsp;
    </div>
    <div class="cube-loader" id="loader">        
        <div class="loader-inner">
            <div class="cube-loading">
		        <h2>Loading</h2>
		        <span></span>
		        <span></span>
		        <span></span>
		        <span></span>
		        <span></span>
		        <span></span>
		        <span></span>
	        </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="PageScriptContent" ContentPlaceHolderID="PageScriptContentHolder" runat="server">
    <script>
        $(function () {        
            if ($.cookie("LastNeedRemember") == "true") {
                $("#cbxRememberMe").prop("checked", true);
                $("#ddlLanguage").val($.cookie("LastLanguage"));
                setLanguage($("#ddlLanguage").val());
                $("#tbxName").val($.cookie("LastUserName"));
                if ($.cookie("LastPosition") == "true") {
                    $("#rdoInternalUser").prop('checked', true);
                } else {
                    $("#rdoInternalUser").prop('checked', false);
                }                
            }

            $('#cbxRememberMe').iCheck({
                checkboxClass: 'icheckbox_square-blue',
                radioClass: 'iradio_square-blue',
                increaseArea: '20%' // optional
            });

            $("#ddlLanguage").val($.uriAnchor.makeAnchorMap()["lang"]);
            $.language.change($.uriAnchor.makeAnchorMap()["lang"]);

            initProductOrgList();
            initDomainList();          

            $("body").on("keydown", function (e) {
                if (e.keyCode == 13) {
                    login();
                }                
            });
        });

        var changeUserPosition = function () {
            var isNT = $("#rdoInternalUser").prop('checked');
            if (!isNT) {
                $("#ddlDomain").hide(200);
            } else {
                $("#ddlDomain").show(200);
            }
            return true;
        };

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

                        if ($.cookie("LastNeedRemember") == "true") {
                            $("#ddlProduct").val($.cookie("LastProductId"));                          
                        } 

                        changeProduct();

                        if ($.cookie("LastNeedRemember") == "true") {
                            $("#ddlOrg").val($.cookie("LastOrgId"));
                        }
                    }
                },
                error: function (e) {
                    $.dialog.closeLoading();
                    $.dialog.showMessage({
                        "title": "error", 
                        "content": e.responseText
                    });
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

        var initDomainList = function () {
            $.ajax({
                url: "LoginService.asmx/getDomainList",
                dataType: "json",
                type: "POST",
                contentType: "application/json",
                success: function (data) {
                    var d = data.d;
                    $.dialog.closeLoading();
                    if (d.success) {
                        var domainHtml = "";
                        $.each(d.data, function (i, domain) {
                            domainHtml += "<option value='" + domain + "'>" + domain + "</option>";
                        });

                        $("#ddlDomain").html(domainHtml);

                        if ($.cookie("LastNeedRemember") == "true") {
                            $("#ddlDomain").val($.cookie("LastDomain"));
                        } 
                    }
                },
                error: function (e) {
                    $.dialog.closeLoading();
                    $.dialog.showMessage({
                        "title": "error",
                        "content": e.responseText
                    });
                }
            });
        };

        var changeLanguage = function () {
            setLanguage($("#ddlLanguage").val());
        };

        var login = function () {
            var userName = $("#tbxName").val();
            var password = $("#tbxPassword").val();
            var productId = $("#ddlProduct").val();
            var productName = $("#ddlProduct").find("option:selected").text();
            var orgId = $("#ddlOrg").val();
            var orgName = $("#ddlOrg").find("option:selected").text();
            var domain = $("#ddlDomain").val();
            var isInternal = $("#rdoInternalUser").prop('checked');
            var language = $("#ddlLanguage").val();
            var needRemember = $("#cbxRememberMe").prop("checked");

            if (!needRemember) {
                $.cookie("LastNeedRemember", false);
                $.cookie("LastLanguage", null);
                $.cookie("LastProductId", null);
                $.cookie("LastOrgId", null);
                $.cookie("LastUserName", null);
                $.cookie("LastDomain", null);
            }

            if (userName.length == 0) {
                $.dialog.showMessage({
                    "title": _CurrentLang.lang_error,
                    "content": _CurrentLang.lang_msg_must_input_login_name
                });
                return false;
            }

            if (orgId.length == 0) {
                $.dialog.showMessage({
                    "title": _CurrentLang.lang_error,
                    "content": _CurrentLang.lang_msg_must_choose_org
                });
                return false;
            }

            $.dialog.showLoading();
            var param = {
                "userName": userName,
                "password": password,
                "productId": productId,
                "productName": productName,
                "orgId": orgId,
                "orgName": orgName,
                "domain": domain,
                "isInternal": isInternal,
                "language": language
            };

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
                        //var token = d.data;
                        var portalUrl = d.data;
                        var lang = $("#ddlLanguage").val();
                        if (needRemember) {
                            $.cookie("LastNeedRemember", true);
                            $.cookie("LastLanguage", language);
                            $.cookie("LastProductId", productId);
                            $.cookie("LastOrgId", orgId);
                            $.cookie("LastUserName", userName);
                            $.cookie("LastDomain", domain);
                            $.cookie("LastPosition", $("#rdoInternalUser").prop('checked'));
                        }
                        //var token = getQueryStringByName("SSOToken");
                        //$.cookie("SSOToken", token);
                        //$.cookie("Language", lang);
                        //var portalUrl = "Portal?SSOToken=" + token;
                        if (getQueryStringByName('IsDebug') == "Y") {
                            portalUrl += "&IsDebug=Y&LocalDebugUrl=" + getQueryStringByName('LocalDebugUrl');
                        }
                        portalUrl += "#!lang=" + lang;                        
                        window.location.href = portalUrl;
                    } else {
                        $.dialog.showMessage({
                            "title": _CurrentLang.lang_error,
                            "content": _CurrentLang.lang_msg_login_failed
                        });
                    }
                },
                error: function (e) {
                    $.dialog.closeLoading();
                    $.dialog.showMessage({
                        "title": "error",
                        "content": e.responseText
                    });
                }
            });

            return false;
        };
    </script>
</asp:Content>

