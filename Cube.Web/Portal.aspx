<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Portal.Master" AutoEventWireup="true" CodeBehind="Portal.aspx.cs" Inherits="Cube.Web.Portal" %>

<asp:Content ID="PageStyleContent" ContentPlaceHolderID="PageStyleContentHolder" runat="server">
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContentHolder" runat="server">
    <div class="wrapper" style="height: 100%; background-color: transparent;">
        <a class="header-toggle" data-toggle="" role="button" id="btnShowHeader" onclick="return _header.toggleHeader();">
            <span class="fa fa-sort-down"></span>
        </a>
        <header class="main-header">
            <!-- Logo -->
            <div class="logo" style="padding: 0px;">
                <span class="logo-lg">
                    <asp:Literal ID="textHeaderInfo" runat="server"></asp:Literal>
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
                        <!-- News -->
                        <li class="dropdown messages-menu" id="navNews">
                            <!-- Menu toggle button -->
                            <a class="dropdown-toggle" data-toggle="dropdown">
                                <i class="fa fa-envelope-o"></i>
                                <span class="label label-success" id="lblNewsCount" style="display: none;"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <ul class="menu" id="newsList">
                                        
                                    </ul>
                                </li>
                                <li class="footer"><a style="text-align: right;"><span lang="lang_total"></span><span>: </span><span id="lblTotalNews">0</span></a></li>
                            </ul>
                        </li>
                        <!-- User -->
                        <li class="dropdown user user-menu" id="navUser">
                            <a class="dropdown-toggle" data-toggle="dropdown">
                                <img src="img/user.jpg" class="user-image userImage" alt="User Image">
                                <span class="hidden-xs" id="lblUserName">Moses.Zhu</span>
                            </a>
                            <ul class="dropdown-menu">
                                <li class="user-header">
                                    <img src="img/user.jpg" class="img-circle userImage" alt="User Image">
                                    <p id="lblUserDepartment">
                                        Moses.Zhu - AIC12
                                        <small>tel: +88861873</small>
                                        <small id="lblLoginTime"></small>
                                    </p>
                                </li>
                                <li class="user-footer">
                                    <div class="pull-right">
                                        <a class="btn btn-default btn-flat" lang="lang_logout" onclick="return _portal.logout();">Logout</a>
                                    </div>
                                </li>
                            </ul>
                        </li>
                        <!-- Right Sidebar Button -->
                        <li id="btnToggleSettingSidebar" class="sidebar_button" onclick="return _setting.toggleSettingSidebar(this);">
                            <a data-toggle="control-sidebar" data-target="control_sidebar"><i class="fa fa-gears"></i></a>
                        </li>
                        <li id="btnToggleBookmarkSidebar" class="sidebar_button" onclick="return _bookmark.toggleBookmarkSidebar(this);">
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
                    <div class="input-group" style="position: absolute; top: 0px;">
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
                <div id="_BreadcrumbBar" style="height: 0px;">
                    <div id="_BreadcrumbContent"></div>
                </div>
                <div class="tab-content" style="height: 100%;" id="_FormTabContent">
                </div>

            </section>
            <!-- /.content -->
        </div>
        <!-- /.content-wrapper -->

        <!-- Main Footer -->
        <footer class="main-footer" style="position: fixed; bottom: 0px; width: 100%; padding: 8px;">
            <div id="footerContainer"><asp:Literal ID="textFooterInfo" runat="server"></asp:Literal></div>
        </footer>

        <!-- Bookmark Sidebar -->
        <aside class="control-sidebar control-sidebar-light" id="bookmark_sidebar">
            <ul class="nav sidebar-menu" id="_BookmarkMenu" style="overflow: hidden;">
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
                                        <button type="button" class="btn btn-success btn-flat btn-skin-primary" onclick="return _state.changeLanguage();" lang="lang_confirm">Confirm</button>
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
            <li class="divider"></li>
            <li><a menuindex="MENU_REFRESH" lang="lang_refresh">collapse all</a></li>            
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
            "SystemMode": null,
            "MenuList": null,
            "BookmarkList": null,
            "CurrentFunctionId": null,
            "UserInfo": null,
            "News": null,
            "HeaderVisible": true,
            "MenuVisible": function () {
                return !$("body").hasClass("sidebar-collapse");
            }
        };

        $(function () {
            _portal.init();           
        });
    </script>
</asp:Content>

