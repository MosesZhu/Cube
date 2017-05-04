<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Portal.Master" AutoEventWireup="true" CodeBehind="Portal.aspx.cs" Inherits="Cube.Web.Portal" %>

<asp:Content ID="PageStyleContent" ContentPlaceHolderID="PageStyleContentHolder" runat="server">
    <style>
        #_BookmarkMenu > li.bookmark-item:hover > a, #_BookmarkMenu > li.active > a {
            background-color: lightgray;
        }

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

        .dropdown-menu > li > a {
            cursor: pointer;
        }

        #_FormTabContent > .tab-pane {
            border: 1px solid #ddd;
            border-top: 0px;
        }

        .function_menu_item {
            overflow: auto;
        }

        ::-webkit-scrollbar {  
            width: 12px;  
            height: 12px;  
            background-color: #1e282c;  
            opacity: .8;
        }

        ::-webkit-scrollbar-thumb {
            background-color: gray;
            opacity: .5;
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

        /*.header-toggle {
            float: left;
            font-size: 14px;
            width: 30px;
        }*/

        #btnShowHeader {
            position: fixed;
            right: 0px;
            top: -50px;
            height: 20px;
            text-align: center;
            padding-bottom: 3px;
            z-index:9999;            
            width: 38px;
            height: 34px;
        }

        #_FunctionMenu > li:first-child {
            padding-top: 45px;
        }

        section.content {
            padding: 0px 0px 15px 0px;
        }

        .nav-tabs > li > a {
            border-radius: 0px;
            padding: 6px 15px;
        }

        #_FormTabs {
            padding-left: 10px;
            border-bottom: 0px;
        }

        #_BreadcrumbBar {
            background-color: white;
            height: 20px;
            margin-left: 1px;
            margin-right: 1px;
        }

        #_BreadcrumbContent {
            float: right;
            padding-right: 10px;
            font-size: 10px;
        }

        #_FunctionMenu a:hover,  header a:hover, aside a:hover{
            cursor: pointer;
        }
    </style>
    
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContentHolder" runat="server">

    <div class="wrapper" style="height: 100%; background-color: transparent;">
        <a class="header-toggle" data-toggle="" role="button" id="btnShowHeader" onclick="return _header.toggleHeader();" >
            <span class="fa fa-sort-down"></span>
        </a>
        <header class="main-header">
            <!-- Logo -->
            <div class="logo" style="padding:0px;">         
                <span class="logo-lg">
                    WebFramework GT 
                </span>                
            </div>            

            <!-- Header Navbar -->
            <nav class="navbar navbar-static-top" role="navigation">
                <!-- Sidebar toggle button-->
                <a class="sidebar-toggle" data-toggle="offcanvas" role="button">
                    <span class="sr-only">Toggle navigation</span>
                </a>                
                <!-- Navbar Right Menu -->
                <div class="navbar-custom-menu">
                    <ul class="nav navbar-nav">
                        <!-- Messages: style can be found in dropdown.less-->
                        <li class="dropdown messages-menu">
                            <!-- Menu toggle button -->
                            <a class="dropdown-toggle" data-toggle="dropdown">
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
                                            <a>
                                                <div class="pull-left">
                                                    <!-- User Image -->
                                                    <img src="img/user2-160x160.jpg" class="img-circle" alt="User Image">
                                                </div>
                                                <!-- Message title and timestamp -->
                                                <h4>Support Team<small><i class="fa fa-clock-o"></i>5 mins</small>
                                                </h4>
                                                <!-- The message -->
                                                <p>Why not buy a new awesome theme?</p>
                                            </a>
                                        </li>
                                        <!-- end message -->
                                    </ul>
                                    <!-- /.menu -->
                                </li>
                                <li class="footer"><a>See All Messages</a></li>
                            </ul>
                        </li>

                        <!-- User Account Menu -->
                        <li class="dropdown user user-menu">
                            <!-- Menu Toggle Button -->
                            <a class="dropdown-toggle" data-toggle="dropdown">
                                <!-- The user image in the navbar-->
                                <img src="img/user2-160x160.jpg" class="user-image" alt="User Image">
                                <!-- hidden-xs hides the username on small devices so only the image appears. -->
                                <span class="hidden-xs" id="lblUserName">Moses.Zhu</span>
                            </a>
                            <ul class="dropdown-menu">
                                <!-- The user image in the menu -->
                                <li class="user-header">
                                    <img src="img/user2-160x160.jpg" class="img-circle" alt="User Image">

                                    <p id="lblUserDepartment">
                                        Moses.Zhu - AIC12
                      <small>tel: +88861873</small>
                                        <small id="lblLoginTime"></small>
                                    </p>
                                </li>

                                <!-- Menu Footer-->
                                <li class="user-footer">
                                    <div class="pull-right">
                                        <a class="btn btn-default btn-flat" lang="lang_logout" onclick="logout()">Logout</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <!-- Control Sidebar Toggle Button -->
                        <li>
                            <a data-toggle="control-sidebar" data-target="control_sidebar"><i class="fa fa-gears"></i></a>
                        </li>
                        <li>
                            <a data-toggle="control-sidebar" data-target="bookmark_sidebar" ><i class="fa fa-star"></i></a>
                        </li>
                        <li>                           
                            <a class="header-toggle" data-toggle="" role="button" id="btnHideHeader" onclick="return _header.toggleHeader();">
                                <i class="fa fa-sort-up"></i>
                            </a>
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
                <form method="get" class="sidebar-form">
                    <div class="input-group" style="position:absolute; top:0px;">
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
                </ul>
                <!-- /.sidebar-menu -->
            </section>
            <!-- /.sidebar -->
        </aside>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">            
            <!-- Main content -->
            <section class="content body">
                <div id="_FormTabsContainer">
                    <ul class="nav nav-tabs" role="tablist" id="_FormTabs"
                        style="display: -webkit-inline-box;">
                    </ul>
                </div>
                <div id="_BreadcrumbBar" style="height: 0px;"><div id="_BreadcrumbContent"></div></div>
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

        <!-- Bookmark Sidebar -->
        <aside class="control-sidebar control-sidebar-light" id="bookmark_sidebar">
            <ul class="nav sidebar-menu" id="_BookmarkMenu">
            </ul>
        </aside>        
        <div class="control-sidebar-bg" data-target="bookmark_sidebar"></div>

        <!-- Control Sidebar -->
        <aside class="control-sidebar control-sidebar-dark" id="control_sidebar">
            <!-- Create the tabs -->
            <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
                <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
                <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
            </ul>
            <!-- Tab panes -->
            <div class="tab-content">
                <!-- Home tab content -->
                <div class="tab-pane active" id="control-sidebar-home-tab">
                    <h3 class="control-sidebar-heading" lang="lang_language">Language</h3>
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
                                        <button type="button" class="btn btn-success" onclick="return changeLanguage();" lang="lang_confirm">Confirm</button>
                                    </div>
                                </div>
                            </a>
                        </li>
                    </ul>
                    <!-- /.control-sidebar-menu -->

                    <h3 class="control-sidebar-heading" lang="lang_themes">Themes</h3>
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
                                    <li>
                                        <div class="text-black skin_button" onclick="setSkin('black')"><i class="fa fa-square"></i></div>
                                    </li>
                                    <li>
                                        <div class="text-black alpha60 skin_button" onclick="setSkin('black-light')"><i class="fa fa-square"></i></div>
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
        <div class="control-sidebar-bg" data-target="control_sidebar"></div>
        
    </div>
    <div id="tab-context-menu">
        <ul class="dropdown-menu" role="menu">
            <li><a menuindex="MENU_OPEN_IN_NEW_WINDOW" lang="lang_open_in_new_window">open in new window</a></li>
            <li><a menuindex="MENU_CLOSE" lang="lang_close">close</a></li>
            <li><a menuindex="MENU_CLOSE_OTHERS" lang="lang_close_others">close others</a></li>
            <li><a menuindex="MENU_CLOSE_ALL" lang="lang_close_all">close all</a></li>
            <li class="divider"></li>
            <li><a menuindex="MENU_REFRESH" lang="lang_refresh">refresh</a></li>
            <li class="divider"></li>
            <li><a menuindex="MENU_ADD_TO_FAVORITES" lang="lang_add_to_favorites">add to my favourite</a></li>
        </ul>
    </div>
    <div id="menu-context-menu">
        <ul class="dropdown-menu" role="menu">
            <li><a menuindex="MENU_EXPAND" lang="lang_expand">expand</a></li>
            <li><a menuindex="MENU_EXPAND_ALL" lang="lang_expand_all">expand all</a></li>
            <li><a menuindex="MENU_COLLAPSE" lang="lang_collapse">collapse</a></li>
            <li><a menuindex="MENU_COLLAPSE_ALL" lang="lang_collapse_all">collapse all</a></li>
        </ul>
    </div>
    <div id="bookmark-context-menu">
        <ul class="dropdown-menu" role="menu">
            <li><a menuindex="MENU_REMOVE_FROM_FAVORITES" lang="lang_remove">remove</a></li>
        </ul>
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
        var _PortalContext = {
            "MenuList": null,
            "BookmarkList": null,
            "CurrentFunctionId": null,
            "UserInfo": null,
            "HeaderVisible": true,
            "MenuVisible": function () {
                return !$("body").hasClass("sidebar-collapse");
            }
        };

        $(function () {
            _ui.resetContentSize();
            $(window).on("resize", function () {
                _ui.resetContentSize();
            });

            $("#search-btn").on("click", function () {
                _menu.searchMenu();
            });

            $("#ddlLanguage").val($.uriAnchor.makeAnchorMap()["lang"]);

            _menu.initMenu();

            //Tabs Event
            $('#_FormTabs').on('shown.bs.tab', function (e) {
                var actionFunctionId = $(e.target).attr("functionid");
                $("#_FunctionMenu li").removeClass("active");
                $("#_FunctionMenu li[functionid=" + actionFunctionId + "]").parents(".treeview").addClass("active");
                $("#_FunctionMenu li[functionid=" + actionFunctionId + "]").addClass("active");
            });

            $('#tbxSearchMenu').on('keydown', function (e) {
                if (e.keyCode == 13) {
                    _menu.searchMenu();
                    return false;
                }
                return true;
            });

            $('#_FormTabsContainer').slimscroll({
                height: '34px',
                width: '100%',
                axis: 'x',
                alwaysVisible: false,
                opacity: .2, //滚动条透明度
                borderRadius: '7px', //滚动条圆角
            });

            initUserInfo();
        });                        

        var initUserInfo = function () {
            var options = {
                "success": function (d) {
                    if (d.success) {
                        _PortalContext.UserInfo = d.data;
                        refreshUserInfo();
                    }
                }
            };

            $.ask("getUserInfo", {}, options);
        };

        var refreshUserInfo = function () {
            $("#lblUserName").text(_PortalContext.UserInfo.Name);
            $("#lblLoginTime").text(_PortalContext.UserInfo.LoginTime);
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


        var getFunctionArray = function (targetFunctionId, functionMenu, searchFlag) {
            searchFlag.founctionArray.push(functionMenu);
            if (functionMenu.Id == targetFunctionId) {
                searchFlag.found = true;
                return;
            }            
            if (functionMenu.SubFunctionList && functionMenu.SubFunctionList.length > 0) {
                $.each(functionMenu.SubFunctionList, function (j, subFunctionMenu) {
                    var currentIndex = searchFlag.founctionArray.length - 1;
                    getFunctionArray(targetFunctionId, subFunctionMenu, searchFlag);
                    if (searchFlag.found) {
                        return false;
                    } else {
                        for (var i = searchFlag.founctionArray.length - 1; i > currentIndex; i--) {
                            searchFlag.founctionArray.pop(i);
                        }
                    }
                });
            }       
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

