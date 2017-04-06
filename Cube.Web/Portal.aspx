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

        .dropdown-menu > li > a {
            cursor: pointer;
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
                                <li class="footer"><a href="#">See All Messages</a></li>
                            </ul>
                        </li>

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

                                <!-- Menu Footer-->
                                <li class="user-footer">
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
    <div id="context-menu">
        <ul class="dropdown-menu" role="menu">
            <li><a tabindex="MENU_OPEN_IN_NEW_WINDOW" lang="lang_open_in_new_window">open in new window</a></li>
            <li><a tabindex="MENU_CLOSE" lang="lang_close">close</a></li>
            <li><a tabindex="MENU_CLOSE_OTHERS" lang="lang_close_others">close others</a></li>
            <li><a tabindex="MENU_CLOSE_ALL" lang="lang_close_all">close all</a></li>
            <li class="divider"></li>
            <li><a tabindex="MENU_REFRESH" lang="lang_refresh">refresh</a></li>
            <li class="divider"></li>
            <li><a tabindex="MENU_ADD_TO_FAVORITES" lang="lang_add_to_favorites">add to my favourite</a></li>
        </ul>
    </div>
</asp:Content>
<asp:Content ID="PageScriptContent" ContentPlaceHolderID="PageScriptContentHolder" runat="server">
    <script>
        var _PortalContext = {
            "MenuList": null,
            "BookmarkList": null,
        };

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
                var actionFunctionId = $(e.target).attr("functionid");
                $("#_FunctionMenu li").removeClass("active");
                $("#_FunctionMenu li[functionid=" + actionFunctionId + "]").parents(".treeview").addClass("active");
                $("#_FunctionMenu li[functionid=" + actionFunctionId + "]").addClass("active");
            });

            $('#tbxSearchMenu').on('keydown', function (e) {
                if (e.keyCode == 13) {
                    searchMenu();
                    return false;
                }
                return true;
            });

        });

        var getDomainMenuHtml = function (domainMenu) {
            var menuHtml
                = '<li class="treeview">'
                + '<a href="#">'
                + '<i class="fa fa-bank text-blue"></i>'
                + '<span lang="' + domainMenu.Language_Key + '">' + domainMenu.Code + '</span>'
                + '<span class="pull-right-container">'
                + '<i class="fa fa-angle-left pull-right"></i>'
                + '</span>'
                + '</a>';
            menuHtml += '<ul class="treeview-menu">';
            $.each(domainMenu.SystemList, function (k, systemMenu) {
                menuHtml += getSystemMenuHtml(systemMenu);
            });
            menuHtml += '</ul></li>';
            return menuHtml;
        };

        var getSystemMenuHtml = function (systemMenu) {
            var menuHtml
                = '<li class="treeview">'
                + '<a href="#">'
                + '<i class="fa fa-laptop text-blue"></i>'
                + '<span lang="' + systemMenu.Language_Key + '">' + systemMenu.Code + '</span>'
                + '<span class="pull-right-container">'
                + '<i class="fa fa-angle-left pull-right"></i>'
                + '</span>'
                + '</a>';
            menuHtml += '<ul class="treeview-menu">';
            $.each(systemMenu.FunctionList, function (k, functionMenu) {
                menuHtml += getFunctionMenuHtml(functionMenu);
            });
            menuHtml += '</ul></li>';
            return menuHtml;
        };

        var getFunctionMenuHtml = function (functionMenu) {
            var menuHtml = '';
            if (functionMenu.SubFunctionList && functionMenu.SubFunctionList.length > 0) {
                menuHtml += '<li class="treeview">'
                          + '<a href="#">'
                          + '<i class="fa fa-puzzle-piece text-blue"></i>'
                          + '<span lang="' + functionMenu.Language_Key + '">' + functionMenu.Code + '</span>'
                          + '<span class="pull-right-container">'
                          + '<i class="fa fa-angle-left pull-right"></i>'
                          + '</span>'
                          + '</a>';
                menuHtml += '<ul class="treeview-menu">';
                $.each(functionMenu.SubFunctionList, function (k, subFunctionMenu) {
                    menuHtml += getFunctionMenuHtml(subFunctionMenu);
                });
                menuHtml += '</ul></li>';
            } else {
                menuHtml += '<li onclick="return openForm(this);" functionid="' + functionMenu.Id + '" ';
                if (functionMenu.Url) {
                    menuHtml += ' functionurl="http://'
                              + functionMenu.Url + '" ';
                }
                menuHtml += '>'
                          + '<a href="#">'
                          + '<i class="fa fa-circle-o text-light-blue"></i>'
                          + '<span lang="' + functionMenu.Language_Key + '">' + functionMenu.Code + '</span>'
                          + '</a>'
                          + '</li>';
            }

            return menuHtml;
        };

        var getBookmarkMenuHtml = function (bookmarkMenu) {
            var menuHtml = "";
            menuHtml += '<li onclick="return openForm(this);" functionid="bk_' + bookmarkMenu.Id + '" ';
            if (bookmarkMenu.Url) {
                menuHtml += ' functionurl="http://'
                          + bookmarkMenu.Url + '" ';
            }
            menuHtml += '>'
                      + '<a href="#">'
                      + '<i class="fa fa-circle-o text-light-blue"></i>'
                      + '<span lang="' + bookmarkMenu.Language_Key + '">' + bookmarkMenu.Code + '</span>'
                      + '</a>'
                      + '</li>';
            return menuHtml;
        };

        var initMenu = function () {
            var options = {
                "success": function (d) {
                    if (d.success) {
                        //menu muliti language
                        $.each(d.data.LanguageList, function (i, lang) {
                            _Lang_ZhCN[lang.Language_Key] = lang.Zh_Cn;
                            _Lang_ZhTW[lang.Language_Key] = lang.Zh_Tw;
                            _Lang_EnUS[lang.Language_Key] = lang.En_Us;
                        });

                        _PortalContext.MenuList = d.data.ProductList;
                        _PortalContext.BookmarkList = d.data.BookmarkList;
                        refreshMenu();
                    }
                }
            };

            $.ask("getMenu", {}, options);
        };

        var refreshMenu = function () {
            var menuHtml = "";
            $.each(_PortalContext.MenuList, function (i, product) {
                menuHtml
                    += '<li class="header">'
                    + '<i class="fa fa-bank"></i>'
                    + '<span lang="' + product.LanguageID + '" style="padding-left:5px;">' + product.Name + '</span>'
                    + '</li>';
                $.each(product.DomainList, function (j, domainMenu) {
                    menuHtml += getDomainMenuHtml(domainMenu);

                });

                $.each(product.SystemList, function (j, systemMenu) {
                    menuHtml += getSystemMenuHtml(systemMenu);
                });
            });

            if (_PortalContext.BookmarkList.length > 0) {
                menuHtml
                    += '<li class="header">'
                    + '<i class="fa fa-star"></i>'
                    + '<span lang="lang_favorites" style="padding-left:5px;">Bookmark</span>'
                    + '</li>';
                $.each(_PortalContext.BookmarkList, function (i, bookmark) {
                    menuHtml += getBookmarkMenuHtml(bookmark);
                });
            }

            $("#_FunctionMenu").html(menuHtml);

            $.language.change(_Context.CurrentLang);
        };

        var getSearchSystemGroupMenuHtml = function (groupMenu) {
            var menuHtml = '';
            if (groupMenu.bingo) {
                menuHtml
                = '<li class="treeview">'
                + '<a href="#">'
                + '<i class="fa fa-bank text-blue"></i>'
                + '<span lang="' + groupMenu.Language_Key + '">' + groupMenu.Code + '</span>'
                + '<span class="pull-right-container">'
                + '<i class="fa fa-angle-left pull-right"></i>'
                + '</span>'
                + '</a>';
                menuHtml += '<ul class="treeview-menu">';
                $.each(groupMenu.SystemList, function (k, systemMenu) {
                    menuHtml += getSystemMenuHtml(systemMenu);
                });
                menuHtml += '</ul></li>';
            }
            return menuHtml;
        };

        var getSearchSystemMenuHtml = function (systemMenu) {
            var menuHtml = '';
            if (systemMenu.bingo) {
                menuHtml
                = '<li class="treeview">'
                + '<a href="#">'
                + '<i class="fa fa-laptop text-blue"></i>'
                + '<span lang="' + systemMenu.Language_Key + '">' + systemMenu.Code + '</span>'
                + '<span class="pull-right-container">'
                + '<i class="fa fa-angle-left pull-right"></i>'
                + '</span>'
                + '</a>';
                menuHtml += '<ul class="treeview-menu">';
                $.each(systemMenu.FunctionList, function (k, functionMenu) {
                    menuHtml += getSearchFunctionMenuHtml(functionMenu);
                });
                menuHtml += '</ul></li>';
            }
            return menuHtml;
        };

        var getSearchFunctionMenuHtml = function (functionMenu) {
            var menuHtml = '';
            if (functionMenu.bingo) {
                if (functionMenu.SubFunctionList && functionMenu.SubFunctionList.length > 0) {
                    menuHtml += '<li class="treeview">'
                              + '<a href="#">'
                              + '<i class="fa fa-puzzle-piece text-blue"></i>'
                              + '<span lang="' + functionMenu.Language_Key + '">' + functionMenu.Code + '</span>'
                              + '<span class="pull-right-container">'
                              + '<i class="fa fa-angle-left pull-right"></i>'
                              + '</span>'
                              + '</a>';
                    menuHtml += '<ul class="treeview-menu">';
                    $.each(functionMenu.SubFunctionList, function (k, subFunctionMenu) {
                        menuHtml += getFunctionMenuHtml(subFunctionMenu);
                    });
                    menuHtml += '</ul></li>';
                } else {
                    menuHtml += '<li onclick="return openForm(this);" functionid="' + functionMenu.Id + '" ';
                    if (functionMenu.Url) {
                        menuHtml += ' functionurl="http://'
                                  + functionMenu.Url + '" ';
                    }
                    menuHtml += '>'
                              + '<a href="#">'
                              + '<i class="fa fa-circle-o text-light-blue"></i>'
                              + '<span lang="' + functionMenu.Language_Key + '">' + functionMenu.Code + '</span>'
                              + '</a>'
                              + '</li>';
                }
            }
            return menuHtml;
        };

        var refreshSearchMenu = function (menuList) {
            var menuHtml = "";
            $.each(menuList, function (i, domain) {
                if (domain.bingo) {
                    menuHtml
                        += '<li class="header">'
                        + '<i class="fa fa-bank"></i>'
                        + '<span lang="' + domain.LanguageID + '" style="padding-left:5px;">' + domain.Name + '</span>'
                        + '</li>';
                    $.each(domain.SystemGroupList, function (j, groupMenu) {
                        menuHtml += getSearchSystemGroupMenuHtml(groupMenu);

                    });

                    $.each(domain.SystemList, function (j, systemMenu) {
                        menuHtml += getSearchSystemMenuHtml(systemMenu);
                    });
                }
            });

            if (_PortalContext.BookmarkList.length > 0) {
                menuHtml
                    += '<li class="header">'
                    + '<i class="fa fa-star"></i>'
                    + '<span lang="lang_favorites" style="padding-left:5px;">Bookmark</span>'
                    + '</li>';
                $.each(_PortalContext.BookmarkList, function (i, bookmark) {
                    menuHtml += getBookmarkMenuHtml(bookmark);
                });
            }

            $("#_FunctionMenu").html(menuHtml);

            $.language.change(_Context.CurrentLang);
        }

        var searchFunctionMenu = function (search, subFunction, functionMenu, domain, groupMenu, systemMenu) {
            if (functionMenu.bingo) {
                subFunction.bingo = true;
            } else if (subFunction.Code.indexOf(search) >= 0
                || (_Lang_ZhCN[subFunction.Language_Key] && _Lang_ZhCN[subFunction.Language_Key].indexOf(search) >= 0)
                || (_Lang_ZhTW[subFunction.Language_Key] && _Lang_ZhTW[subFunction.Language_Key].indexOf(search) >= 0)
                || (_Lang_EnUS[subFunction.Language_Key] && _Lang_EnUS[subFunction.Language_Key].indexOf(search) >= 0)) {
                domain.bingo = true;
                if (groupMenu) {
                    groupMenu.bingo = true;
                }
                systemMenu.bingo = true;
                functionMenu.bingo = true;
            }

            if (subFunction.SubFunctionList && subFunction.SubFunctionList.length > 0) {
                $.each(subFunction.SubFunctionList, function (i, subSubFunction) {
                    searchFunctionMenu(search, subSubFunction, subFunction, domain, groupMenu, systemMenu);
                });
            }
        };

        var searchMenu = function () {
            if ($("#tbxSearchMenu").val().length > 0) {
                var search = $("#tbxSearchMenu").val();

                var tempMenuList = $.extend(true, {}, _PortalContext.MenuList);
                $.each(tempMenuList, function (i, domain) {
                    if (domain.Name.indexOf(search) >= 0) {
                        domain.bingo = true;
                    }

                    $.each(domain.SystemGroupList, function (j, groupMenu) {
                        if (domain.bingo) {
                            groupMenu.bingo = true;
                        } else if (groupMenu.Code.indexOf(search) >= 0
                            || (_Lang_ZhCN[groupMenu.Language_Key] && _Lang_ZhCN[groupMenu.Language_Key].indexOf(search) >= 0)
                            || (_Lang_ZhTW[groupMenu.Language_Key] && _Lang_ZhTW[groupMenu.Language_Key].indexOf(search) >= 0)
                            || (_Lang_EnUS[groupMenu.Language_Key] && _Lang_EnUS[groupMenu.Language_Key].indexOf(search) >= 0)) {
                            domain.bingo = true;
                            groupMenu.bingo = true;
                        }

                        $.each(groupMenu.SystemList, function (j, systemMenu) {
                            if (groupMenu.bingo) {
                                systemMenu.bingo = true;
                            } else if (systemMenu.Code.indexOf(search) >= 0
                                || (_Lang_ZhCN[systemMenu.Language_Key] && _Lang_ZhCN[systemMenu.Language_Key].indexOf(search) >= 0)
                                || (_Lang_ZhTW[systemMenu.Language_Key] && _Lang_ZhTW[systemMenu.Language_Key].indexOf(search) >= 0)
                                || (_Lang_EnUS[systemMenu.Language_Key] && _Lang_EnUS[systemMenu.Language_Key].indexOf(search) >= 0)) {
                                domain.bingo = true;
                                groupMenu.bingo = true;
                                systemMenu.bingo = true;
                            }

                            $.each(systemMenu.FunctionList, function (j, functionMenu) {
                                if (systemMenu.bingo) {
                                    functionMenu.bingo = true;
                                } else if (functionMenu.Code.indexOf(search) >= 0
                                    || (_Lang_ZhCN[functionMenu.Language_Key] && _Lang_ZhCN[functionMenu.Language_Key].indexOf(search) >= 0)
                                    || (_Lang_ZhTW[functionMenu.Language_Key] && _Lang_ZhTW[functionMenu.Language_Key].indexOf(search) >= 0)
                                    || (_Lang_EnUS[functionMenu.Language_Key] && _Lang_EnUS[functionMenu.Language_Key].indexOf(search) >= 0)) {
                                    domain.bingo = true;
                                    groupMenu.bingo = true;
                                    systemMenu.bingo = true;
                                    functionMenu.bingo = true;
                                }

                                if (functionMenu.SubFunctionList && functionMenu.SubFunctionList.length > 0) {
                                    $.each(functionMenu.SubFunctionList, function (i, subFunction) {
                                        searchFunctionMenu(search, subFunction, functionMenu, domain, groupMenu, systemMenu);
                                    });
                                }
                            });
                        });
                    });

                    $.each(domain.SystemList, function (j, systemMenu) {
                        if (domain.bingo) {
                            systemMenu.bingo = true;
                        } else if (systemMenu.Code.indexOf(search) >= 0
                            || (_Lang_ZhCN[systemMenu.Language_Key] && _Lang_ZhCN[systemMenu.Language_Key].indexOf(search) >= 0)
                            || (_Lang_ZhTW[systemMenu.Language_Key] && _Lang_ZhTW[systemMenu.Language_Key].indexOf(search) >= 0)
                            || (_Lang_EnUS[systemMenu.Language_Key] && _Lang_EnUS[systemMenu.Language_Key].indexOf(search) >= 0)) {
                            domain.bingo = true;
                            systemMenu.bingo = true;
                        }

                        $.each(systemMenu.FunctionList, function (j, functionMenu) {
                            if (systemMenu.bingo) {
                                functionMenu.bingo = true;
                            } else if (functionMenu.Code.indexOf(search) >= 0
                                || (_Lang_ZhCN[functionMenu.Language_Key] && _Lang_ZhCN[functionMenu.Language_Key].indexOf(search) >= 0)
                                || (_Lang_ZhTW[functionMenu.Language_Key] && _Lang_ZhTW[functionMenu.Language_Key].indexOf(search) >= 0)
                                || (_Lang_EnUS[functionMenu.Language_Key] && _Lang_EnUS[functionMenu.Language_Key].indexOf(search) >= 0)) {
                                domain.bingo = true;
                                systemMenu.bingo = true;
                                functionMenu.bingo = true;
                            }

                            if (functionMenu.SubFunctionList && functionMenu.SubFunctionList.length > 0) {
                                $.each(functionMenu.SubFunctionList, function (i, subFunction) {
                                    searchFunctionMenu(search, subFunction, functionMenu, domain, null, systemMenu);
                                });
                            }
                        });
                    });
                });

                refreshSearchMenu(tempMenuList);
            } else {
                refreshMenu();
            }
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

        var openForm = function (menu) {
            var functionurl = $(menu).attr("functionurl");
            if (functionurl) {
                var functionname = $(menu).text();
                var functionid = $(menu).attr("functionid");
                $("#_FunctionMenu .treeview li").removeClass("active");
                $(menu).addClass("active");

                var opend = showFormByFunctionId(functionid);

                if (!opend) {
                    var tabHtml = '<li class="nav-item form-tab">'
                        + '<a class="nav-link" data-toggle="tab" href="#' + functionid + '" role="tab" aria-controls="' + functionid + '" functionid="' + functionid + '">'
                        + '<table>'
                        + '<tr>'
                        + '<td>'
                        + '<div';

                    var tabLang = $(menu).find('span').attr('lang');
                    if (tabLang) {
                        tabHtml += ' lang="' + tabLang + '"';
                    }
                    tabHtml += ">" + functionname + '</div>'
                        + '</td>'
                        + '<td style="padding-left:5px;">'
                        + '<span class="fa fa-times icon_close_form" onclick="return closeForm(this);">'
                        + '</span>'
                        + '</td>'

                        + '</tr>'
                        + '</table>'
                        + '</a>'
                        + '</li>';
                    $("#_FormTabs").append(tabHtml);

                    $("#_FormTabContent").append('<div class="tab-pane" id="' + functionid + '" role="tabpanel" style="height: 100%; padding: 0px;">'
                        + '<iframe name="frm_' + functionid + '" src="' + functionurl + '?SSOToken=' + getQueryStringByName('SSOToken')
                        + "#!lang=" + _Context.CurrentLang
                        + '" class="col-md-12 col-lg-12 col-sm-12" style="height: 100%; width:100%;padding: 0px;border:0px;"></iframe></div>');
                    bindContextMenu();
                    $("#_FormTabs a[functionid=" + functionid + "]").tab("show");
                }
            }
            return false;
        };

        var bindContextMenu = function () {
            $('.form-tab').contextmenu({
                target: '#context-menu',
                onItem: function (context, e) {
                    var tabIndex = $(e.target).attr('tabindex');
                    var functionid = $(context).find("a").attr("functionid");
                    if (tabIndex == "MENU_OPEN_IN_NEW_WINDOW") {
                        var url = $("#" + functionid).find("iframe").attr("src");
                        window.open(url);
                    } else if (tabIndex == "MENU_CLOSE") {
                        $.dialog.showConfirm(_CurrentLang['msg_confirm_close_tab'], '', '',
                            function () {                                
                                closeFormByFunctionId(functionid);
                            },
                            function () {});
                    } else if (tabIndex == "MENU_CLOSE_OTHERS") {
                        $.dialog.showConfirm(_CurrentLang['msg_confirm_close_tab'], '', '',
                            function () {
                                $("#_FormTabs a").each(function (i, tab) {
                                    if ($(tab).attr("functionid") != functionid) {
                                        closeFormByFunctionId($(tab).attr("functionid"));
                                    }
                                });
                            },
                            function () {});
                    } else if (tabIndex == "MENU_CLOSE_ALL") {
                        $.dialog.showConfirm(_CurrentLang['msg_confirm_close_tab'], '', '',
                            function () {
                                $("#_FormTabs a").each(function (i, tab) {
                                    closeFormByFunctionId($(tab).attr("functionid"));
                                });
                            },
                            function () { });
                    } else if (tabIndex == "MENU_REFRESH") {
                        var frameName = "frm_" + functionid;
                        var url = $("iframe[name=" + frameName + "]").attr("src");
                        $("iframe[name=" + frameName + "]").attr("src", null).attr("src", url);
                    } else if (tabIndex == "MENU_ADD_TO_FAVORITES") {
                        addToBookmark(functionid);
                    }
                }
            });
        };

        var addToBookmark = function (functionid) {
            var options = {
                "success": function (d) {
                    if (d.success) {
                        $.dialog.showMessage(_CurrentLang['lang_success'], _CurrentLang['msg_save_success']);
                        initMenu();
                    }
                }
            };
            var data = {
                'functionId': functionid
            };

            $.ask("addToBookmark", data, options);
        };

        var showFormByFunctionId = function (functionid) {
            if (functionid.substring(0, 3) == "bk_") {
                functionid = functionid.substring(3);
            }
            var opened = false;
            $("#_FormTabs a").each(function (i, tab) {
                var thisFunctionId = $(tab).attr("functionid");
                if (thisFunctionId.substring(0, 3) == "bk_") {
                    thisFunctionId = thisFunctionId.substring(3);
                }
                if (thisFunctionId == functionid) {
                    opened = true;
                    $(tab).tab("show");
                }
            });
            return opened;
        };

        var closeFormByFunctionId = function (functionid) {
            var preTab = $("a[functionid=" + functionid + "]").parent().prev();
            var nextTab = $("a[functionid=" + functionid + "]").parent().next();
            $("a[functionid=" + functionid + "]").parent().remove();
            $("#" + functionid).remove();

            if (preTab.length > 0) {
                var preFunctionId = preTab.find("a").attr("functionid");
                showFormByFunctionId(preFunctionId);
            } else if (nextTab.length > 0) {
                var nextFunctionId = nextTab.find("a").attr("functionid");
                showFormByFunctionId(nextFunctionId);
            }
        };

        var closeForm = function (ctrl) {
            $.dialog.showConfirm(_CurrentLang['msg_confirm_close_tab'], '', '',
                function () {
                    var functionid = $(ctrl).parents('a').attr("functionid");
                    closeFormByFunctionId(functionid);
                },
                function () {

                });

            return false;
        };

        var resetContentSize = function () {
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

