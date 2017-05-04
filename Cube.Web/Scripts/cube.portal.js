jQuery.extend({
	"cube": {
		"portal": {
			"ui": {
				"resetContentSize": function () {
					var headerHeight = $("header").height();
					if (!_PortalContext.HeaderVisible) {
						headerHeight = 0;
					}
					var footerHeight = $(".main-footer").height();
					$("section.content").height($(window).height() - headerHeight - footerHeight - 72);
				},

				"header": {
					"toggleHeader": function () {
						if (_PortalContext.HeaderVisible) {
							this.hideHeader();
						} else {
							this.showHeader();
						}
					},

					"hideHeader": function () {
						var headerHeight = $("header").height();
						$(".main-sidebar").animate({ "padding-top": "0px" }, 200);
						$("#bookmark_sidebar").animate({ "padding-top": "0px" }, 200);
						$("#control_sidebar").animate({ "padding-top": "0px" }, 200);
						var contentHeight = $("section.content").height();
						$("section.content").height(contentHeight + headerHeight - 30);
						var menuHeight = $("aside > .slimScrollDiv").height();
						$("aside > .slimScrollDiv").height(menuHeight + headerHeight);
						$("section.sidebar").height(menuHeight + headerHeight);

						$(".content-wrapper").animate({
							"padding-top": "0px"
						}, 200);

						$("header").slideUp(200, function () {
							$("#btnShowHeader").animate({ "top": "0px" }, 200);
							_PortalContext.HeaderVisible = false;
							_ui.resetContentSize();
						});
					},

					"showHeader": function () {
						var headerHeight = $("header").height();
						$("#btnShowHeader").animate({ "top": "-50px" }, 200, function () {
							$(".main-sidebar").animate({ "padding-top": headerHeight + "px" }, 200);
							$("#bookmark_sidebar").animate({ "padding-top": headerHeight + "px" }, 200);
							$("#control_sidebar").animate({ "padding-top": headerHeight + "px" }, 200);
							var contentHeight = $("section.content").height();
							$("section.content").height(contentHeight - headerHeight - 30);
							var menuHeight = $("aside > .slimScrollDiv").height();
							$("aside > .slimScrollDiv").height(menuHeight - headerHeight);
							$("section.sidebar").height(menuHeight - headerHeight);

							$(".content-wrapper").animate({
								"padding-top": headerHeight + "px"
							}, 200);

							$("header").slideDown(200, function () {
								_PortalContext.HeaderVisible = true;
								_ui.resetContentSize();
							});
						});
					}
				},

				"menu": {
					"initMenu": function () {
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
									_menu.refreshMenu();
								}
							}
						};

						$.ask("getMenu", {}, options);
					},

					"refreshMenu": function () {
						var menuHtml = "";
						$.each(_PortalContext.MenuList, function (i, product) {
							menuHtml
								+= '<li class="header">'
								+ '<i class="fa fa-bank"></i>'
								+ '<span lang="' + product.LanguageID + '" style="padding-left:5px;">' + product.Name + '</span>'
								+ '</li>';
							$.each(product.DomainList, function (j, domainMenu) {
								menuHtml += _menu.getDomainMenuHtml(domainMenu);

							});

							$.each(product.SystemList, function (j, systemMenu) {
								menuHtml += _menu.getSystemMenuHtml(systemMenu);
							});
						});

						$("#_FunctionMenu").html(menuHtml);
						var bookmarkMenuHtml = "";
						$.each(_PortalContext.BookmarkList, function (i, bookmark) {
							bookmarkMenuHtml += _menu.getBookmarkMenuHtml(bookmark);
						});
						$("#_BookmarkMenu").html(bookmarkMenuHtml);

						_cmenu.bindMenuContextMenu();

						$.language.change(_Context.CurrentLang);
					},

					"getDomainMenuHtml": function (domainMenu) {
						var menuHtml = '<li class="treeview">'
							+ '<a href="#">'
							+ '<i class="fa fa-bank text-blue"></i>'
							+ '<span lang="' + domainMenu.Language_Key + '">' + domainMenu.Code + '</span>'
							+ '<span class="pull-right-container">'
							+ '<i class="fa fa-angle-left pull-right"></i>'
							+ '</span>'
							+ '</a>';
						menuHtml += '<ul class="treeview-menu">';
						$.each(domainMenu.SystemList, function (k, systemMenu) {
							menuHtml += _menu.getSystemMenuHtml(systemMenu);
						});
						menuHtml += '</ul></li>';
						return menuHtml;
					},

					"getSystemMenuHtml": function (systemMenu) {
						var menuHtml = '<li class="treeview">'
							+ '<a href="#">'
							+ '<i class="fa fa-laptop text-blue"></i>'
							+ '<span lang="' + systemMenu.Language_Key + '">' + systemMenu.Code + '</span>'
							+ '<span class="pull-right-container">'
							+ '<i class="fa fa-angle-left pull-right"></i>'
							+ '</span>'
							+ '</a>';
						menuHtml += '<ul class="treeview-menu">';
						$.each(systemMenu.FunctionList, function (k, functionMenu) {
							menuHtml += _menu.getFunctionMenuHtml(functionMenu);
						});
						menuHtml += '</ul></li>';
						return menuHtml;
					},

					"getFunctionMenuHtml": function (functionMenu) {
						var menuHtml = '';
						if (functionMenu.SubFunctionList && functionMenu.SubFunctionList.length > 0) {
							menuHtml += '<li class="treeview">'
								+ '<a href="#">'
								+ '<i class="fa fa-puzzle-piece text-blue"></i>'
								+ '<span lang="' + functionMenu.Language_Key + '" data-toggle="tooltip" data-placement="top" title="' + functionMenu.Code + '">' + functionMenu.Code + '</span>'
								+ '<span class="pull-right-container">'
								+ '<i class="fa fa-angle-left pull-right"></i>'
								+ '</span>'
								+ '</a>';
							menuHtml += '<ul class="treeview-menu">';
							$.each(functionMenu.SubFunctionList, function (k, subFunctionMenu) {
								menuHtml += _menu.getFunctionMenuHtml(subFunctionMenu);
							});
							menuHtml += '</ul></li>';
						} else {
							menuHtml += '<li onclick="return openForm(this);" functionid="' + functionMenu.Id + '" ';
							if (functionMenu.Url) {
								menuHtml += ' functionurl="'//' functionurl="http://'
									+ functionMenu.Url + '" ';
							}
							menuHtml += '>'
								+ '<a href="#" class="function_menu_item">'
								+ '<i class="fa fa-circle-o text-light-blue"></i>'
								+ '<span lang="' + functionMenu.Language_Key + '" data-toggle="tooltip" data-placement="top" title="' + functionMenu.Code + '">' + functionMenu.Code + '</span>'
								+ '</a>'
								+ '</li>';
						}

						return menuHtml;
					},

					"getBookmarkMenuHtml": function (bookmarkMenu) {
						var menuHtml = "";
						menuHtml += '<li class="bookmark-item" onclick="return openForm(this);" functionid="bk_' + bookmarkMenu.Id + '" ';
						if (bookmarkMenu.Url) {
							menuHtml += ' functionurl="'//' functionurl="http://'
								+ bookmarkMenu.Url + '" ';
						}
						menuHtml += '>'
							+ '<a href="#">'
							+ '<i class="fa fa-circle-o text-light-blue"></i>'
							+ '<span lang="' + bookmarkMenu.Language_Key + '">' + bookmarkMenu.Code + '</span>'
							+ '</a>'
							+ '</li>';
						return menuHtml;
					},

					"searchMenu": function () {
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
													_menu.searchFunctionMenu(search, subFunction, functionMenu, domain, groupMenu, systemMenu);
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
												_menu.searchFunctionMenu(search, subFunction, functionMenu, domain, null, systemMenu);
											});
										}
									});
								});
							});

							_menu.refreshSearchMenu(tempMenuList);
						} else {
							_menu.refreshMenu();
						}
					},

					"refreshSearchMenu": function (menuList) {
						var menuHtml = "";
						$.each(menuList, function (i, domain) {
							if (domain.bingo) {
								menuHtml
									+= '<li class="header">'
									+ '<i class="fa fa-bank"></i>'
									+ '<span lang="' + domain.LanguageID + '" style="padding-left:5px;">' + domain.Name + '</span>'
									+ '</li>';
								$.each(domain.SystemGroupList, function (j, groupMenu) {
									menuHtml += _menu.getSearchDomainMenuHtml(groupMenu);

								});

								$.each(domain.SystemList, function (j, systemMenu) {
									menuHtml += _menu.getSearchSystemMenuHtml(systemMenu);
								});
							}
						});

						if (_PortalContext.BookmarkList.length > 0) {
							menuHtml
								+= '<li class="header">'
								+ '<i class="fa fa-star"></i>'
								+ '<span lang="lang_favorites" style="padding-left:5px;">Bookmark</span>'
								+ '</li>';
						}

						$("#_FunctionMenu").html(menuHtml);

						_cmenu.bindMenuContextMenu();

						$.language.change(_Context.CurrentLang);
					},

					"getSearchDomainMenuHtml": function (domainMenu) {
						var menuHtml = '';
						if (domainMenu.bingo) {
							menuHtml = '<li class="treeview">'
								+ '<a href="#">'
								+ '<i class="fa fa-bank text-blue"></i>'
								+ '<span lang="' + domainMenu.Language_Key + '">' + domainMenu.Code + '</span>'
								+ '<span class="pull-right-container">'
								+ '<i class="fa fa-angle-left pull-right"></i>'
								+ '</span>'
								+ '</a>';
							menuHtml += '<ul class="treeview-menu">';
							$.each(domainMenu.SystemList, function (k, systemMenu) {
								menuHtml += _menu.getSystemMenuHtml(systemMenu);
							});
							menuHtml += '</ul></li>';
						}
						return menuHtml;
					},

					"getSearchSystemMenuHtml": function (systemMenu) {
						var menuHtml = '';
						if (systemMenu.bingo) {
							menuHtml = '<li class="treeview">'
								+ '<a href="#">'
								+ '<i class="fa fa-laptop text-blue"></i>'
								+ '<span lang="' + systemMenu.Language_Key + '">' + systemMenu.Code + '</span>'
								+ '<span class="pull-right-container">'
								+ '<i class="fa fa-angle-left pull-right"></i>'
								+ '</span>'
								+ '</a>';
							menuHtml += '<ul class="treeview-menu">';
							$.each(systemMenu.FunctionList, function (k, functionMenu) {
								menuHtml += _menu.getSearchFunctionMenuHtml(functionMenu);
							});
							menuHtml += '</ul></li>';
						}
						return menuHtml;
					},

					"getSearchFunctionMenuHtml": function (functionMenu) {
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
									menuHtml += _menu.getFunctionMenuHtml(subFunctionMenu);
								});
								menuHtml += '</ul></li>';
							} else {
								menuHtml += '<li onclick="return openForm(this);" functionid="' + functionMenu.Id + '" ';
								if (functionMenu.Url) {
									menuHtml += ' functionurl="'
										+ functionMenu.Url + '" ';
								}
								menuHtml += '>'
									+ '<a href="#" class="function_menu_item">'
									+ '<i class="fa fa-circle-o text-light-blue"></i>'
									+ '<span lang="' + functionMenu.Language_Key + '">' + functionMenu.Code + '</span>'
									+ '</a>'
									+ '</li>';
							}
						}
						return menuHtml;
					},

					"searchFunctionMenu": function (search, subFunction, functionMenu, domain, groupMenu, systemMenu) {
						if (functionMenu.bingo) {
							subFunction.bingo = true;
						} else if (subFunction.Code.indexOf(search) >= 0
							|| (_Lang_ZhCN[subFunction.Language_Key] && _Lang_ZhCN[subFunction.Language_Key].indexOf(search) >= 0)
							|| (_Lang_ZhTW[subFunction.Language_Key] && _Lang_ZhTW[subFunction.Language_Key].indexOf(search) >= 0)
							|| (_Lang_EnUS[subFunction.Language_Key] && _Lang_EnUS[subFunction.Language_Key].indexOf(search) >= 0)) {
							domainMenu.bingo = true;
							if (groupMenu) {
								groupMenu.bingo = true;
							}
							systemMenu.bingo = true;
							functionMenu.bingo = true;
						}

						if (subFunction.SubFunctionList && subFunction.SubFunctionList.length > 0) {
							$.each(subFunction.SubFunctionList, function (i, subSubFunction) {
								_menu.searchFunctionMenu(search, subSubFunction, subFunction, domainMenu, groupMenu, systemMenu);
							});
						}
					},

					"expandOneMenu": function (menu) {
						$.each($(menu).children("li.treeview"), function (i, l) {
							$(l).children("ul.treeview-menu").slideDown(500, function () {
								_menu.expandOneMenu(this);
							});
						});
					}
				},

				"context_menu": {
					"bindTabContextMenu": function () {
						$('.form-tab').contextmenu({
							target: '#tab-context-menu',
							onItem: function (context, e) {
								var menuIndex = $(e.target).attr('menuindex');
								var functionid = $(context).find("a").attr("functionid");
								if (menuIndex == "MENU_OPEN_IN_NEW_WINDOW") {
									var url = $("#" + functionid).find("iframe").attr("src");
									window.open(url);
								} else if (menuIndex == "MENU_CLOSE") {
									$.dialog.showConfirm(_CurrentLang['msg_confirm_close_tab'], '', '',
										function () {
											closeFormByFunctionId(functionid);
										},
										function () { });
								} else if (menuIndex == "MENU_CLOSE_OTHERS") {
									$.dialog.showConfirm(_CurrentLang['msg_confirm_close_tab'], '', '',
										function () {
											$("#_FormTabs a").each(function (i, tab) {
												if ($(tab).attr("functionid") != functionid) {
													closeFormByFunctionId($(tab).attr("functionid"));
												}
											});
										},
										function () { });
								} else if (menuIndex == "MENU_CLOSE_ALL") {
									$.dialog.showConfirm(_CurrentLang['msg_confirm_close_tab'], '', '',
										function () {
											$("#_FormTabs a").each(function (i, tab) {
												closeFormByFunctionId($(tab).attr("functionid"));
											});
										},
										function () { });
								} else if (menuIndex == "MENU_REFRESH") {
									var frameName = "frm_" + functionid;
									var url = $("iframe[name=" + frameName + "]").attr("src");
									$("iframe[name=" + frameName + "]").attr("src", url);
									showFormByFunctionId(functionid);
								} else if (menuIndex == "MENU_ADD_TO_FAVORITES") {
									addToBookmark(functionid);
								}
							}
						});
					},

					"bindMenuContextMenu": function () {
						$('#_FunctionMenu').find(".treeview,.header").contextmenu({
							target: '#menu-context-menu',
							onItem: function (context, e) {
								var menuIndex = $(e.target).attr('menuindex');
								if (menuIndex == "MENU_EXPAND") {
									if ($(context).hasClass("header")) {
										var current = $(context);
										while (true) {
											current = current.next("li");
											if (!current || current.hasClass("header")) {
												break;
											}
											$(current).children("ul.treeview-menu").slideDown(500, function () {
												_menu.expandOneMenu(this);
											});
										}
									} else {
										$(context).children("ul.treeview-menu").slideDown(500, function () {
											_menu.expandOneMenu(this);
										});
									}
								} else if (menuIndex == "MENU_EXPAND_ALL") {
									$.each($('#_FunctionMenu').children("li.treeview"), function (i, l) {
										$(l).children("ul.treeview-menu").slideDown(500, function () {
											_menu.expandOneMenu(this);
										});
									});
								} else if (menuIndex == "MENU_COLLAPSE") {
									if ($(context).hasClass("header")) {
										var current = $(context);
										while (true) {
											current = current.next("li");
											if (!current || current.hasClass("header")) {
												break;
											}
											current.find("ul").slideUp(500);
										}
									} else {
										$(context).find("ul").slideUp(500);
									}
								} else if (menuIndex == "MENU_COLLAPSE_ALL") {
									$('#_FunctionMenu').find("ul").slideUp(500);
								}
							}
						});

						_cmenu.bindBookmarkContextMenu();
					},

					"bindBookmarkContextMenu": function () {
						$('#_BookmarkMenu').find(".bookmark-item").contextmenu({
							target: '#bookmark-context-menu',
							onItem: function (context, e) {
								var menuIndex = $(e.target).attr('menuindex');
								if (menuIndex == "MENU_REMOVE_FROM_FAVORITES") {
									var functionid = $(context).attr("functionid").substring(3);;
									removeFromBookmark(functionid);
								}
							}
						});
					}
				},

				"bookmark": {

				}
			}
		}
	}
});

var _ui = $.cube.portal.ui;
var _header = $.cube.portal.ui.header;
var _menu = $.cube.portal.ui.menu;
var _cmenu = $.cube.portal.ui.context_menu;
var _bookmark = $.cube.portal.ui.bookmark;