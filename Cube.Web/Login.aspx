﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Portal.Master" CodeBehind="Login.aspx.cs" Inherits="Cube.Web.Login" %>

<asp:Content ID="PageStyleContent" ContentPlaceHolderID="PageHeadContentHolder" runat="server">
    <title>Login</title>
    <style>
        body {
            background-color: #d2d6de;
        }

        .login_system_name, .cube-environment {
            text-shadow: 5px 2px 6px gray;
            color: #fff;
            font-style: italic;
        }
    </style>
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContentHolder" runat="server">
    <div id="container" style="width: 100%; height: 700px; position: absolute; top: 0px; opacity: .3; z-index: -99;">
        <div id="anitOut"></div>
    </div>
    <div class="login-box">
        <div class="login-logo">
            <asp:Label ID="lblSystemName" runat="server" Text="Login" CssClass="login_system_name" lang="lang_login"></asp:Label>
            <span class="cube-environment">
                <asp:Literal ID="textEnvironmentInfo" runat="server"></asp:Literal>
            </span>
        </div>
        <div class="login-box-body">
            <p class="login-box-msg" lang="lang_please_loginin">please login</p>
            <div class="form-group has-feedback">
                <div class="col-md-6 col-lg-6 col-sm-6">
                    <input type="radio" name="isNT" checked="checked" value="Y" id="rdoInternalUser" onchange="return changeUserPosition();" />
                    <label for="rdoInternalUser" lang="lang_for_internal_user" style="font-weight: normal;">For Internal User</label>
                </div>
                <div class="col-md-6 col-lg-6 col-sm-6">
                    <input type="radio" name="isNT" value="N" id="rdoExternalUser" onchange="return changeUserPosition();" />
                    <label for="rdoExternalUser" lang="lang_for_external_user" style="font-weight: normal;">For External User</label>
                </div>
            </div>
            <table style="width: 100%;">
                <tr>
                    <td style="padding-bottom: 14px;" lang="lang_product">Product</td>
                    <td>
                        <div class="form-group has-feedback">
                            <select class="form-control select2" style="width: 100%; padding-right: 20px;" id="ddlProduct" onchange="changeProduct()">
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 14px;" lang="lang_org">Org</td>
                    <td>
                        <div class="form-group has-feedback">
                            <select class="form-control select2" style="width: 100%; padding-right: 20px;" id="ddlOrg" onchange="changeOrg()">
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 14px;" lang="lang_user_name">User Name</td>
                    <td>
                        <div class="form-group has-feedback">
                            <input type="text" class="form-control" placeholder="Name" id="tbxName" lang="lang_user_name">
                            <span class="glyphicon glyphicon-user form-control-feedback"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 14px;" lang="lang_password">Password</td>
                    <td>
                        <div class="form-group has-feedback">
                            <input type="password" class="form-control" placeholder="Password" id="tbxPassword" lang="lang_password">
                            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 14px;" lang="lang_domain">Domain</td>
                    <td>
                        <div class="form-group has-feedback">
                            <select class="form-control select2" style="width: 100%; padding-right: 20px;" id="ddlDomain">
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="padding-bottom: 14px;" lang="lang_language">Language</td>
                    <td>
                        <div class="form-group has-feedback">
                            <select class="form-control select2" style="width: 100%; padding-right: 20px;" id="ddlLanguage" onchange="return changeLanguage();">
                                <option selected="selected" value="EnUS">English</option>
                                <option value="ZhCN">中文简体</option>
                                <option value="ZhTW">中文繁體</option>
                            </select>
                        </div>
                    </td>
                </tr>
            </table>

            <div class="row">
                <div class="col-xs-8">
                    <div class="checkbox icheck">
                        <label>

                            <input id="cbxRememberMe" type="checkbox">
                            <label for="cbxRememberMe" lang="lang_remember_me" style="padding-left: 10px;">Remember Me</label>
                        </label>
                    </div>
                </div>
                <!-- /.col -->
                <div class="col-xs-4">
                    <div class="btn btn-skin-primary btn-block btn-flat" lang="lang_login" onclick="return login();">Login</div>
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

            var productName = $("#ddlProduct").find("option:selected").text();
            var orgId = $("#ddlOrg").val();
            var orgName = $("#ddlOrg").find("option:selected").text();
            var domain = $("#ddlDomain").val();
            var isInternal = $("#rdoInternalUser").prop('checked');
            var language = $("#ddlLanguage").val();
            var needRemember = $("#cbxRememberMe").prop("checked");

            //for demo
            if ($("#MainContentHolder_lblSystemName").text() == "Cube Demo") {
                $("#ddlProduct").parents("tr").hide();
                $("#ddlOrg").parents("tr").hide();
                $("#ddlDomain").parents("tr").hide();
            }
            //end for demo
        });

        var changeUserPosition = function () {
            var isNT = $("#rdoInternalUser").prop('checked');
            if (!isNT) {
                $("#ddlDomain").parents("tr").hide(200);
            } else {
                $("#ddlDomain").parents("tr").show(200);
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

            //for demo
            if ($("#MainContentHolder_lblSystemName").text() == "Cube Demo") {
                productId = "3202985d-ad51-428e-ac7e-9912de03c045";
                productName = "Administration";
                orgId = "ed9ac3f5-4d01-49d0-8c55-843e7e65110e";
                orgName = "Global";
                domain = "QGROUP";
            }
            //end for demo

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

        $(function () {
            if (!window.ActiveXObject && !!document.createElement("canvas").getContext) {
                $.getScript("Scripts/login_bg.js",
                    function () {
                        var t = {
                            width: 1.5,
                            height: 1.5,
                            depth: 10,
                            segments: 12,
                            slices: 6,
                            xRange: 0.8,
                            yRange: 0.1,
                            zRange: 1,
                            ambient: "#525252",
                            diffuse: "#FFFFFF",
                            speed: 0.0002
                        };
                        var G = {
                            count: 2,
                            xyScalar: 1,
                            zOffset: 100,
                            ambient: "#002c4a",
                            diffuse: "#005584",
                            speed: 0.001,
                            gravity: 1200,
                            dampening: 0.95,
                            minLimit: 10,
                            maxLimit: null,
                            minDistance: 20,
                            maxDistance: 400,
                            autopilot: false,
                            draw: false,
                            bounds: CAV.Vector3.create(),
                            step: CAV.Vector3.create(Math.randomInRange(0.2, 1), Math.randomInRange(0.2, 1), Math.randomInRange(0.2, 1))
                        };
                        var m = "canvas";
                        var E = "svg";
                        var x = {
                            renderer: m
                        };
                        var i, n = Date.now();
                        var L = CAV.Vector3.create();
                        var k = CAV.Vector3.create();
                        var z = document.getElementById("container");
                        var w = document.getElementById("anitOut");
                        var D, I, h, q, y;
                        var g;
                        var r;

                        function C() {
                            F();
                            p();
                            s();
                            B();
                            v();
                            K(z.offsetWidth, z.offsetHeight);
                            o()
                        }

                        function F() {
                            g = new CAV.CanvasRenderer();
                            H(x.renderer)
                        }

                        function H(N) {
                            if (D) {
                                w.removeChild(D.element)
                            }
                            switch (N) {
                                case m:
                                    D = g;
                                    break
                            }
                            D.setSize(z.offsetWidth, z.offsetHeight);
                            w.appendChild(D.element)
                        }

                        function p() {
                            I = new CAV.Scene()
                        }

                        function s() {
                            I.remove(h);
                            D.clear();
                            q = new CAV.Plane(t.width * D.width, t.height * D.height, t.segments, t.slices);
                            y = new CAV.Material(t.ambient, t.diffuse);
                            h = new CAV.Mesh(q, y);
                            I.add(h);
                            var N, O;
                            for (N = q.vertices.length - 1; N >= 0; N--) {
                                O = q.vertices[N];
                                O.anchor = CAV.Vector3.clone(O.position);
                                O.step = CAV.Vector3.create(Math.randomInRange(0.2, 1), Math.randomInRange(0.2, 1), Math.randomInRange(0.2, 1));
                                O.time = Math.randomInRange(0, Math.PIM2)
                            }
                        }

                        function B() {
                            var O, N;
                            for (O = I.lights.length - 1; O >= 0; O--) {
                                N = I.lights[O];
                                I.remove(N)
                            }
                            D.clear();
                            for (O = 0; O < G.count; O++) {
                                N = new CAV.Light(G.ambient, G.diffuse);
                                N.ambientHex = N.ambient.format();
                                N.diffuseHex = N.diffuse.format();
                                I.add(N);
                                N.mass = Math.randomInRange(0.5, 1);
                                N.velocity = CAV.Vector3.create();
                                N.acceleration = CAV.Vector3.create();
                                N.force = CAV.Vector3.create()
                            }
                        }

                        function K(O, N) {
                            D.setSize(O, N);
                            CAV.Vector3.set(L, D.halfWidth, D.halfHeight);
                            s()
                        }

                        function o() {
                            i = Date.now() - n;
                            u();
                            M();
                            requestAnimationFrame(o)
                        }

                        function u() {
                            var Q, P, O, R, T, V, U, S = t.depth / 2;
                            CAV.Vector3.copy(G.bounds, L);
                            CAV.Vector3.multiplyScalar(G.bounds, G.xyScalar);
                            CAV.Vector3.setZ(k, G.zOffset);
                            for (R = I.lights.length - 1; R >= 0; R--) {
                                T = I.lights[R];
                                CAV.Vector3.setZ(T.position, G.zOffset);
                                var N = Math.clamp(CAV.Vector3.distanceSquared(T.position, k), G.minDistance, G.maxDistance);
                                var W = G.gravity * T.mass / N;
                                CAV.Vector3.subtractVectors(T.force, k, T.position);
                                CAV.Vector3.normalise(T.force);
                                CAV.Vector3.multiplyScalar(T.force, W);
                                CAV.Vector3.set(T.acceleration);
                                CAV.Vector3.add(T.acceleration, T.force);
                                CAV.Vector3.add(T.velocity, T.acceleration);
                                CAV.Vector3.multiplyScalar(T.velocity, G.dampening);
                                CAV.Vector3.limit(T.velocity, G.minLimit, G.maxLimit);
                                CAV.Vector3.add(T.position, T.velocity)
                            }
                            for (V = q.vertices.length - 1; V >= 0; V--) {
                                U = q.vertices[V];
                                Q = Math.sin(U.time + U.step[0] * i * t.speed);
                                P = Math.cos(U.time + U.step[1] * i * t.speed);
                                O = Math.sin(U.time + U.step[2] * i * t.speed);
                                CAV.Vector3.set(U.position, t.xRange * q.segmentWidth * Q, t.yRange * q.sliceHeight * P, t.zRange * S * O - S);
                                CAV.Vector3.add(U.position, U.anchor)
                            }
                            q.dirty = true
                        }

                        function M() {
                            D.render(I)
                        }

                        function J(O) {
                            var Q, N, S = O;
                            var P = function (T) {
                                for (Q = 0, l = I.lights.length; Q < l; Q++) {
                                    N = I.lights[Q];
                                    N.ambient.set(T);
                                    N.ambientHex = N.ambient.format()
                                }
                            };
                            var R = function (T) {
                                for (Q = 0, l = I.lights.length; Q < l; Q++) {
                                    N = I.lights[Q];
                                    N.diffuse.set(T);
                                    N.diffuseHex = N.diffuse.format()
                                }
                            };
                            return {
                                set: function () {
                                    P(S[0]);
                                    R(S[1])
                                }
                            }
                        }

                        function v() {
                            window.addEventListener("resize", j)
                        }

                        function A(N) {
                            CAV.Vector3.set(k, N.x, D.height - N.y);
                            CAV.Vector3.subtract(k, L)
                        }

                        function j(N) {
                            K(z.offsetWidth, z.offsetHeight);
                            M()
                        }

                        C();
                    })
            } else {
                alert('调用cav.js失败');
            }
        });
    </script>
</asp:Content>

