﻿<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Portal.Master" AutoEventWireup="true" CodeBehind="Portal.aspx.cs" Inherits="Cube.Web.Portal" %>

<asp:Content ID="PageStyleContent" ContentPlaceHolderID="PageStyleContentHolder" runat="server">
    <style>
        .icon_close_form {
            cursor: pointer;
        }

        .skin_button {
            cursor: pointer;
        }

        body {
            overflow: hidden;
        }

        .alpha60 {
            opacity: 0.6;
        }

        .nav-tabs > li > a {
            border: 1px solid #ddd;
            border-bottom-color: transparent;
        }

            .nav-tabs > li > a:hover, .nav-tabs > li > a:active, .nav-tabs > li > a:focus {
                border: 1px solid #ddd;
                border-bottom-color: transparent;
            }
    </style>
    >
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContentHolder" runat="server">

    <div class="wrapper" style="height: 100%; background-color: transparent;">

        <header class="main-header">
            <!-- Logo -->
            <a href="index2.html" class="logo">
                <!-- mini logo for sidebar mini 50x50 pixels -->
                <span class="logo-mini"><b>A</b>LT</span>
                <!-- logo for regular state and mobile devices -->
                <span class="logo-lg">WebFramework GT</span>
            </a>

            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                </a>
                <!-- Navbar Right Menu -->
                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <!-- Messages: style can be found in dropdown.less-->
                        <li class="dropdown messages-menu">
                            <!-- Menu toggle button -->
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-envelope-o"></i>
                                <span class="label label-success">4</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have 4 messages</li>
                                <li>
                                    <!-- inner menu: contains the messages -->
                                    <ul class="menu">
                                        <li>
                                            <!-- start message -->
                                            <a href="#">
                                                <div class="pull-left">
                                                    <!-- User Image -->
                                                    <img src="img/user2-160x160.jpg" class="img-circle" alt="User Image">
                                                </div>
                                                <!-- Message title and timestamp -->
                                                <h4>Support Team
                            <small><i class="fa fa-clock-o"></i>5 mins</small>
                                                </h4>
                                                <!-- The message -->
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li>
                                        <!-- end message -->
                                    </ul>
                                    <!-- /.menu -->
                                </li>
                                <li class="footer"><a href="#">See All Messages</a></li>
                            </ul>
                        </li>
                        <!-- /.messages-menu -->
                        <!--                       
                        <li class="dropdown notifications-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-bell-o"></i>
                                <span class="label label-warning">10</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have 10 notifications</li>
                                <li>
                                    <ul class="menu">
                                        <li>
                                            <a href="#">
                                                <i class="fa fa-users text-aqua"></i>5 new members joined today
                                            </a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="footer"><a href="#">View all</a></li>
                            </ul>
                        </li>-->
                        <!-- Tasks Menu -->
                        <!--
                        <li class="dropdown tasks-menu">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-flag-o"></i>
                                <span class="label label-danger">9</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="header">You have 9 tasks</li>
                                <li>
                                    <ul class="menu">
                                        <li>
                                            <a href="#">
                                                <h3>Design some buttons
                            <small class="pull-right">20%</small>
                                                </h3>
                                                <div class="progress xs">
                                                    <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100">
                                                        <span class="sr-only">20% Complete</span>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>
                                </li>                            
                                <li class="footer">
                                    <a href="#">View all tasks</a>
                                </li>
                            </ul>
                        </li>
                            -->
                        <!-- User Account Menu -->
                        <li class="dropdown user user-menu">
                            <!-- Menu Toggle Button -->
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                                <!-- The user image in the navbar-->
                                <img src="img/user2-160x160.jpg" class="user-image" alt="User Image">
                                <!-- hidden-xs hides the username on small devices so only the image appears. -->
                                <span class="hidden-xs">Moses.Zhu</span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- The user image in the menu -->
                                <li class="user-header">
                                    <img src="img/user2-160x160.jpg" class="img-circle" alt="User Image">

                                    <p>
                                        Moses.Zhu - AIC12
                      <small>tel: +88861873</small>
                                    </p>
                                </li>
                                <!-- Menu Body -->
                                <!--
                  <li class="user-body">
                    <div class="row">
                      <div class="col-xs-4 text-center">
                        <a href="#">Followers</a>
                      </div>
                      <div class="col-xs-4 text-center">
                        <a href="#">Sales</a>
                      </div>
                      <div class="col-xs-4 text-center">
                        <a href="#">Friends</a>
                      </div>
                    </div>
                  </li>
                  -->
                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <!--
                    <div class="pull-left">
                      <a href="#" class="btn btn-default btn-flat">Profile</a>
                    </div>
                    -->
                                    <div class="pull-right">
                                        <a href="#" class="btn btn-default btn-flat" lang="lang_logout" onclick="logout()">Logout</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <!-- Control Sidebar Toggle Button -->
                        <li>
                            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <!-- Left side column. contains the logo and sidebar -->
        <aside class="main-sidebar">

            <!-- sidebar: style can be found in sidebar.less -->
            <section class="sidebar" id="scrollspy">

                <!-- search form (Optional) -->
                <form action="#" method="get" class="sidebar-form">
                    <div class="input-group">
                        <input type="text" name="q" id="tbxSearchMenu" class="form-control" placeholder="Search...">
                        <span class="input-group-btn">
                            <button type="button" name="search" id="search-btn" class="btn btn-flat">
                                <i class="fa fa-search"></i>
                            </button>
                        </span>
                    </div>
                </form>
                <!-- /.search form -->

                <!-- Sidebar Menu -->
                <ul class="nav sidebar-menu" id="_FunctionMenu">
                    <%--<li class="header"><i class="fa fa-bank"></i>MFG</li>
                    <li class="treeview active">
                        <a href="#">
                            <i class="fa fa-laptop text-blue"></i>
                            <span>QML</span>
                            <span class="pull-right-container">
                                <i class="fa fa-angle-left pull-right"></i>
                            </span>
                        </a>
                        <ul class="treeview-menu">
                            <li class="active" onclick="return openForm(this);" functionid="aaa" functionurl="http://localhost:28937/Forms/TestDataMaintainForm.aspx"><a href="#"><i class="fa fa-puzzle-piece text-light-blue"></i><span lang="lang_menu_aaa">QML Maintain Form</span></a></li>
                            <li onclick="return openForm(this);" functionid="bbb" functionurl="http://localhost:28937/Forms/TestDataMaintainForm.aspx"><a href="#"><i class="fa fa-puzzle-piece text-light-blue"></i>QML Inquiry By PO Data</a></li>
                            <li onclick="return openForm(this);" functionid="ccc" functionurl="http://localhost:28937/Forms/TestDataMaintainForm.aspx"><a href="#"><i class="fa fa-puzzle-piece text-light-blue"></i>QML Vendor Inquiry</a></li>
                        </ul>
                    </li>
                    <li class="treeview">
                        <a href="#">
                            <i class="fa fa-laptop text-blue"></i>
                            <span>RSO</span>
                            <span class="pull-right-container">
                                <i class="fa fa-angle-left pull-right"></i>
                            </span>
                        </a>
                        <ul class="treeview-menu">
                            <li><a href="#"><i class="fa fa-puzzle-piece text-light-blue"></i>Level One</a></li>
                            <li>
                                <a href="#"><i class="fa fa-puzzle-piece text-light-blue"></i>Level One
                <span class="pull-right-container">
                    <i class="fa fa-angle-left pull-right"></i>
                </span>
                                </a>
                                <ul class="treeview-menu">
                                    <li>
                                        <a href="#"><i class="fa fa-circle-o"></i>Level Two</a>
                                    </li>
                                    <li>
                                        <a href="#"><i class="fa fa-circle-o"></i>Level Two<span class="pull-right-container"><i class="fa fa-angle-left pull-right"></i></span></a>
                                        <ul class="treeview-menu">
                                            <li><a href="#"><i class="fa fa-circle-o"></i>Level Three</a></li>
                                            <li><a href="#"><i class="fa fa-circle-o"></i>Level Three</a></li>
                                        </ul>
                                    </li>
                                </ul>
                            </li>
                            <li><a href="#"><i class="fa fa-puzzle-piece text-light-blue"></i>Level One</a></li>
                        </ul>
                    </li>

                    <li class="header"><i class="fa fa-bank"></i>FIN</li>
                    <li class="treeview">
                        <a href="#"><i class="fa fa-laptop text-blue"></i>
                            <span>BTP</span>
                            <span class="pull-right-container">
                                <i class="fa fa-angle-left pull-right"></i>
                            </span>
                        </a>
                        <ul class="treeview-menu">
                            <li><a href="#"><i class="fa fa-puzzle-piece text-light-blue"></i>BTP Data Inquiry</a></li>
                        </ul>
                    </li>--%>
                </ul>
                <!-- /.sidebar-menu -->
            </section>
            <!-- /.sidebar -->
        </aside>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            <!-- Content Header (Page header) -->
            <section class="content-header">
                <!--<h1>QML Maintain Form
                    <small>QML基础数据维护</small>
                </h1>-->
                <ol class="breadcrumb" style="top: -20px;">
                    <li><a href="#"><i class="fa fa-dashboard"></i>MFG</a></li>
                    <li><a href="#">QML</a></li>
                    <li class="active">QML Maintain Form</li>
                </ol>
            </section>

            <!-- Main content -->
            <section class="content body" style="padding-top: 0px; margin-top: -5px;">
                <div id="_FormTabsContainer">
                    <ul class="nav nav-tabs" role="tablist" id="_FormTabs"
                        style="display: -webkit-inline-box;">
                    </ul>
                </div>

                <div class="tab-content" style="height: 100%;" id="_FormTabContent">
                </div>

            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- Main Footer -->
        <footer class="main-footer" style="position: fixed; bottom: 0px; width: 100%; padding: 8px;">
            <!-- To the right -->
            <div class="pull-right hidden-xs">
                Anything you want
            </div>
            <!-- Default to the left -->
            Moses Demo<strong> WebFramework GT</strong>
        </footer>

        <!-- Control Sidebar -->
        <aside class="control-sidebar control-sidebar-dark">
            <!-- Create the tabs -->
            <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
                <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
                <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <!-- Home tab content -->
                <div class="tab-pane active" id="control-sidebar-home-tab">
                    <h3 class="control-sidebar-heading" lang="lang_Language">Language</h3>
                    <ul class="control-sidebar-menu">
                        <li>
                            <a href="javascript:;">
                                <div class="input-group">
                                    <select class="form-control select2" style="width: 100%;" id="ddlLanguage">
                                        <option selected="selected" value="EnUS">English</option>
                                        <option value="ZhCN">中文简体</option>
                                        <option value="ZhTW">中文繁體</option>
                                    </select>
                                    <div class="input-group-btn">
                                        <button type="button" class="btn btn-success" onclick="return changeLanguage();" lang="lang_Confirm">Confirm</button>
                                    </div>
                                </div>
                            </a>
                        </li>
                    </ul>
                    <!-- /.control-sidebar-menu -->

                    <h3 class="control-sidebar-heading" lang="lang_Themes">Themes</h3>
                    <ul class="control-sidebar-menu">
                        <li>
                            <div class="btn-group" style="width: 100%; padding: 20px;">
                                <!--<button type="button" id="color-chooser-btn" class="btn btn-info btn-block dropdown-toggle" data-toggle="dropdown">Color <span class="caret"></span></button>-->
                                <ul class="fc-color-picker" id="color-chooser">
                                    <li>
                                        <div class="text-blue skin_button" onclick="setSkin('blue')"><i class="fa fa-square skin_button"></i></div>
                                    </li>
                                    <li>
                                        <div class="text-blue alpha60 skin_button" onclick="setSkin('blue-light')"><i class="fa fa-square"></i></div>
                                    </li>
                                    <li>
                                        <div class="text-orange skin_button" onclick="setSkin('yellow')"><i class="fa fa-square"></i></div>
                                    </li>
                                    <li>
                                        <div class="text-orange alpha60 skin_button" onclick="setSkin('yellow-light')"><i class="fa fa-square"></i></div>
                                    </li>
                                    <li>
                                        <div class="text-green skin_button" onclick="setSkin('green')"><i class="fa fa-square"></i></div>
                                    </li>
                                    <li>
                                        <div class="text-green alpha60 skin_button" onclick="setSkin('green-light')"><i class="fa fa-square"></i></div>
                                    </li>
                                    <li>
                                        <div class="text-red skin_button" onclick="setSkin('red')"><i class="fa fa-square"></i></div>
                                    </li>
                                    <li>
                                        <div class="text-red alpha60 skin_button" onclick="setSkin('red-light')"><i class="fa fa-square"></i></div>
                                    </li>
                                    <li>
                                        <div class="text-purple skin_button" onclick="setSkin('purple')"><i class="fa fa-square"></i></div>
                                    </li>
                                    <li>
                                        <div class="text-purple alpha60 skin_button" onclick="setSkin('purple-light')"><i class="fa fa-square"></i></div>
                                    </li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- /.control-sidebar-menu -->

                </div>
                <!-- /.tab-pane -->
                <!-- Settings tab content -->
                <div class="tab-pane" id="control-sidebar-settings-tab">
                    <form method="post">
                        <h3 class="control-sidebar-heading">General Settings</h3>

                        <div class="form-group">
                            <label class="control-sidebar-subheading">
                                Report panel usage
                  <input type="checkbox" class="pull-right" checked>
                            </label>

                            <p>
                                Some information about this general settings option
                            </p>
                        </div>
                        <!-- /.form-group -->
                    </form>
                </div>
                <!-- /.tab-pane -->
            </div>
        </aside>
        <!-- /.control-sidebar -->
        <!-- Add the sidebar's background. This div must be placed
           immediately after the control sidebar -->
        <div class="control-sidebar-bg"></div>
    </div>
</asp:Content>
<asp:Content ID="PageScriptContent" ContentPlaceHolderID="PageScriptContentHolder" runat="server">
    <script>
        $(function () {
            //Main Content Size
            resetContentSize();
            $(window).on("resize", function () {
                resetContentSize();
            });

            $("#search-btn").on("click", function () {
                searchMenu();
            });

            $("#ddlLanguage").val($.uriAnchor.makeAnchorMap()["lang"]);

            initMenu();

            //Tabs Event
            $('#_FormTabs').on('shown.bs.tab', function (e) {
                //var previousTabText = $(e.relatedTarget).text();
                var actionFunctionId = $(e.target).attr("functionid");
                //alert(actionFunctionId);
                $("#_FunctionMenu li").removeClass("active");
                $("#_FunctionMenu li[functionid=" + actionFunctionId + "]").parents(".treeview").addClass("active");
                $("#_FunctionMenu li[functionid=" + actionFunctionId + "]").addClass("active");
            });
        });

        //TODO:function 现在还不是递归的
        var initMenu = function () {
            var options = {
                "success": function (d) {
                    if (d.success) {
                        var menuList = d.data.DomainList;
                        var menuHtml = "";
                        $.each(menuList, function (i, domain) {
                            menuHtml += '<li class="header"><i class="fa fa-bank"></i><span lang="' + domain.LanguageID + '">' + domain.Name + '</span></li>';
                            $.each(domain.SystemGropList, function (j, group) {
                                menuHtml += '<li class="treeview active"><a href="#"><i class="fa fa-laptop text-blue"></i><spanlang="' + group.Language_Key + '">'
                                + group.Code + '</span><span class="pull-right-container"><i class="fa fa-angle-left pull-right"></i></span></a>'
                                + '<ul class="treeview-menu">'
                                $.each(group.SystemList, function (j, systemMenu) {
                                    menuHtml += '<li class="treeview active"><a href="#"><i class="fa fa-laptop text-blue"></i><span>'
                                    + systemMenu.Code + '</span><span class="pull-right-container"><i class="fa fa-angle-left pull-right"></i></span></a>'
                                    + '<ul class="treeview-menu">'
                                    $.each(systemMenu.FunctionList, function (k, functionMenu) {
                                        menuHtml += '<li class="active" onclick="return openForm(this);" functionid="'
                                                  + functionMenu.Id
                                                  + '" functionurl="http://'
                                                  + functionMenu.Url
                                                  + '"><a href="#"><i class="fa fa-puzzle-piece text-light-blue"></i><span lang="'
                                                  + functionMenu.Language_Key
                                                  + '">' + functionMenu.Code + '</span></a></li>';
                                    });
                                    + '</ul></li>';
                                });

                            });

                            $.each(domain.SystemList, function (j, systemMenu) {
                                menuHtml += '<li class="treeview"><a href="#"><i class="fa fa-laptop text-blue"></i><span>'
                                + systemMenu.Code + '</span><span class="pull-right-container"><i class="fa fa-angle-left pull-right"></i></span></a>'
                                + '<ul class="treeview-menu">';
                                $.each(systemMenu.FunctionList, function (k, functionMenu) {
                                    menuHtml += '<li onclick="return openForm(this);" functionid="'
                                              + functionMenu.Id
                                              + '" functionurl="http://'
                                              + functionMenu.Url
                                              + '"><a href="#"><i class="fa fa-puzzle-piece text-light-blue"></i><span lang="'
                                              + functionMenu.Language_Key
                                              + '">' + functionMenu.Code + '</span></a></li>';
                                });
                                menuHtml += '</ul></li>';
                            });                            
                        });

                        $.each(d.data.LanguageList, function (i, lang) {
                            _Lang_ZhCN[lang.Language_Key] = lang.Zh_Cn;
                            _Lang_ZhTW[lang.Language_Key] = lang.Zh_Tw;
                            _Lang_EnUS[lang.Language_Key] = lang.En_Us;
                        });

                        $("#_FunctionMenu").append(menuHtml);
                    }
                }
            };

            $.ask("getMenu", {}, options);
        };

        var logout = function () {
            var options = {
                "success": function (d) {
                    if (d.success) {
                        $.cookie("SSOToken", null);
                        $.goto("Login");
                        //window.location.href = "Login";
                    }
                }
            };
            $.ask("logout", {}, options);
        };

        var searchMenu = function () {
            alert($("#tbxSearchMenu").val());
        };

        var openForm = function (menu) {
            var functionurl = $(menu).attr("functionurl");
            var functionname = $(menu).text();
            var functionid = $(menu).attr("functionid");
            $("#_FunctionMenu .treeview li").removeClass("active");
            $(menu).addClass("active");

            var opend = false;
            $("#_FormTabs a").each(function (i, tab) {
                if ($(tab).attr("functionid") == functionid) {
                    opend = true;
                    $(tab).tab("show");
                }
            });

            if (!opend) {
                $("#_FormTabs").append('<li class="nav-item">'
                    + '<a class="nav-link" data-toggle="tab" href="#' + functionid + '" role="tab" aria-controls="' + functionid + '" functionid="' + functionid + '">'
                    + functionname + '<span class="fa fa-times icon_close_form" onclick="return closeForm(this);"></span></a></li>');
                $("#_FormTabContent").append('<div class="tab-pane" id="' + functionid + '" role="tabpanel" style="height: 100%; padding: 0px;">'
                    + '<iframe name="frm_' + functionid + '" src="' + functionurl + '?SSOToken=' + getQueryStringByName('SSOToken')
                    + "#!lang=" + _Context.CurrentLang
                    + '" class="col-md-12 col-lg-12 col-sm-12" style="height: 100%; width:100%;padding: 0px;border:0px;"></iframe></div>');
                $("#_FormTabs a[functionid=" + functionid + "]").tab("show");
            }
        };

        var closeForm = function (ctrl) {
            $.dialog.showDialog("aa", "bb", "cc");
            var functionid = $(ctrl).parent().attr("functionid");
            $("a[functionid=" + functionid + "]").parent().remove();
            $("#" + functionid).remove();
            return false;
        };

        var resetContentSize = function () {
            //$("section.content")
            //alert($(window).height());
            var isMenuVisible = ($('.main-sidebar').first().css('transform') === "none");
            var isBreadCrumbBlock = ($('.breadcrumb').first().css("position") === 'relative');
            var baseHeight = $(window).height() - 115;
            var tempHeight = baseHeight;
            if (isBreadCrumbBlock) {
                tempHeight = baseHeight - 140;
            } else {
                tempHeight = baseHeight - 55;
            }

            if (isMenuVisible && isBreadCrumbBlock) {
                tempHeight += 55;
            }
            $("section.content").height(tempHeight);
        };

        var changeLanguage = function () {
            setLanguage($("#ddlLanguage").val());
            syncFramesState();
        };

        var syncFramesState = function () {
            $("iframe").each(function (i, f) {
                var oldSrc = $(f).attr("src");
                var oldUrl = oldSrc.split("#!")[0];
                var map = {};
                map = $.uriAnchor.makeAnchorMap(oldSrc);
                map["lang"] = _Context.CurrentLang;
                var mapStr = $.uriAnchor.makeAnchorString(map);
                $(f).attr("src", oldUrl + "#!" + mapStr);
            });
        }
    </script>
</asp:Content>

