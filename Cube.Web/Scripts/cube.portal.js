jQuery.extend({
	"cube": {
		"portal": {
			"ui": {
				"resetContentSize": function () {
					var headerHeight = $("header").height();
					if (!_PortalContext.HeaderVisible) {
						headerHeight = 0;
                    }
                    if (headerHeight == 100 && $(window).width() >= 768) {
                        headerHeight = 50;
                    }
					var footerHeight = $(".main-footer").height();
					$("section.content").height($(window).height() - headerHeight - footerHeight - 72);

					$(".content-wrapper").css("padding-top", headerHeight + "px");
					//$(".content-wrapper").animate({
					//	"padding-top": headerHeight + "px"
					//}, 200);
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

						var bookmarkMenuHtml = _menu.getBookmarkMenuHtml();						
						$("#_BookmarkMenu").html(bookmarkMenuHtml);

						_cmenu.bindMenuContextMenu();

						$.language.change(_Context.CurrentLang);
					},

					"getDomainMenuHtml": function (domainMenu) {
						var menuHtml = '<li class="treeview">'
							+ '<a>'
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
							+ '<a>'
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
								+ '<a>'
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
							menuHtml += '<li onclick="return _form.openForm(this);" functionid="' + functionMenu.Id + '" ';
							if (functionMenu.Url) {
								menuHtml += ' functionurl="'//' functionurl="http://'
									+ functionMenu.Url + '" ';
							}
							menuHtml += '>'
								+ '<a class="function_menu_item">'
								+ '<i class="fa fa-circle-o text-light-blue"></i>'
								+ '<span lang="' + functionMenu.Language_Key + '" data-toggle="tooltip" data-placement="top" title="' + functionMenu.Code + '">' + functionMenu.Code + '</span>'
								+ '</a>'
								+ '</li>';
						}

						return menuHtml;
					},

					"getBookmarkMenuHtml": function () {
						var bookmarkMenuHtml = "";
						var tempBookmarkSystemList = new Array();
						$.each(_PortalContext.BookmarkList, function (i, bookmark) {
							var bookmarkSystemId = bookmark.System_Id;
							$.each(_PortalContext.MenuList, function (i, product) {
								$.each(product.DomainList, function (j, domain) {
									$.each(domain.SystemList, function (j, system) {
										if (system.Id == bookmarkSystemId) {
											var exist = false;
											for (var x = 0; x < tempBookmarkSystemList.length; x++) {
												if (tempBookmarkSystemList[x].System.Id == bookmarkSystemId) {
													exist = true;
													tempBookmarkSystemList[x].BookmarkList.push(bookmark);
													break;
												}
											}
											if (!exist) {
												tempBookmarkSystemList.push({
													"System": system,
													"BookmarkList": [bookmark]
												});
											}
											return false;
										}
									});
								});
							});
							//bookmarkMenuHtml += _menu.getBookmarkMenuItemHtml(bookmark);
						});

						$.each(tempBookmarkSystemList, function (i, system) {
							bookmarkMenuHtml += '<li class="header text-blue">'
								+ '<i class="fa fa-laptop text-blue"></i>'
								+ '<span lang="' + system.System.Language_Key + '" style="padding-left:5px;">' + system.System.Code + '</span>'
								+ '</li>';
							$.each(system.BookmarkList, function (k, bookmark) {
								bookmarkMenuHtml += _menu.getBookmarkMenuItemHtml(bookmark);
							});
							bookmarkMenuHtml += '</ul></li>';
						});

						return bookmarkMenuHtml;
					},

					"getBookmarkMenuItemHtml": function (bookmarkMenu) {
						var menuHtml = "";
						menuHtml += '<li class="bookmark-item" onclick="return _form.openForm(this);" functionid="bk_' + bookmarkMenu.Id + '" ';
						if (bookmarkMenu.Url) {
							menuHtml += ' functionurl="'
								+ bookmarkMenu.Url + '" ';
						}
						menuHtml += '>'
							+ '<a style="padding-left: 30px;">'
							+ '<i class="fa fa-circle-o text-light-blue"></i>'
							+ '<span lang="' + bookmarkMenu.Language_Key + '" data-toggle="tooltip" data-placement="top" title="' + bookmarkMenu.Code + '">' + bookmarkMenu.Code + '</span>'
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
								+ '<a>'
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
								+ '<a>'
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
									+ '<a>'
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
								menuHtml += '<li onclick="return _form.openForm(this);" functionid="' + functionMenu.Id + '" ';
								if (functionMenu.Url) {
									menuHtml += ' functionurl="'
										+ functionMenu.Url + '" ';
								}
								menuHtml += '>'
									+ '<a class="function_menu_item">'
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
					},

					"activeMenu": function (functionid) {
						if (functionid.substring(0, 3) == "bk_") {
							functionid = functionid.substring(3);
						}
						$("#_FunctionMenu li").removeClass("active");
						$("#_FunctionMenu li[functionid=" + functionid + "]").parents(".treeview").addClass("active");
						$("#_FunctionMenu li[functionid=" + functionid + "]").addClass("active");

						var bkFunctionId = "bk_" + functionid;
						$("#_BookmarkMenu li").removeClass("active");						
						$("#_BookmarkMenu li[functionid=" + bkFunctionId + "]").addClass("active");
					},

					"getFunctionArray": function (targetFunctionId, functionMenu, searchFlag) {
						searchFlag.founctionArray.push(functionMenu);
						if (functionMenu.Id == targetFunctionId) {
							searchFlag.found = true;
							return;
						}
						if (functionMenu.SubFunctionList && functionMenu.SubFunctionList.length > 0) {
							$.each(functionMenu.SubFunctionList, function (j, subFunctionMenu) {
								var currentIndex = searchFlag.founctionArray.length - 1;
								_menu.getFunctionArray(targetFunctionId, subFunctionMenu, searchFlag);
								if (searchFlag.found) {
									return false;
								} else {
									for (var i = searchFlag.founctionArray.length - 1; i > currentIndex; i--) {
										searchFlag.founctionArray.pop(i);
									}
								}
							});
						}
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
											_form.closeFormByFunctionId(functionid);
										},
										function () { });
								} else if (menuIndex == "MENU_CLOSE_OTHERS") {
									$.dialog.showConfirm(_CurrentLang['msg_confirm_close_tab'], '', '',
										function () {
											$("#_FormTabs a").each(function (i, tab) {
												if ($(tab).attr("functionid") != functionid) {
													_form.closeFormByFunctionId($(tab).attr("functionid"));
												}
											});
										},
										function () { });
								} else if (menuIndex == "MENU_CLOSE_ALL") {
									$.dialog.showConfirm(_CurrentLang['msg_confirm_close_tab'], '', '',
										function () {
											$("#_FormTabs a").each(function (i, tab) {
												_form.closeFormByFunctionId($(tab).attr("functionid"));
											});
										},
										function () { });
								} else if (menuIndex == "MENU_REFRESH") {
									var frameName = "frm_" + functionid;
									var url = $("iframe[name=" + frameName + "]").attr("src");
									$("iframe[name=" + frameName + "]").attr("src", url);
									_form.showFormByFunctionId(functionid);
								} else if (menuIndex == "MENU_ADD_TO_FAVORITES") {
									_bookmark.addToBookmark(functionid);
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
									_bookmark.removeFromBookmark(functionid);
								}
							}
						});
					}
				},
				"bookmark": {
					"addToBookmark": function (functionid) {
						if (functionid.substring(0, 3) == "bk_") {
							functionid = functionid.substring(3);
						}
						var options = {
							"success": function (d) {
								if (d.success) {
									$.dialog.showMessage(_CurrentLang['lang_success'], _CurrentLang['msg_save_success']);
									_menu.initMenu();
								}
							}
						};
						var data = {
							'functionId': functionid
						};

						$.ask("addToBookmark", data, options);
					},

					"removeFromBookmark": function (functionid) {
						var options = {
							"success": function (d) {
								if (d.success) {
									$.dialog.showMessage(_CurrentLang['lang_success'], _CurrentLang['msg_save_success']);
									_menu.initMenu();
								}
							}
						};
						var data = {
							'functionId': functionid
						};

						$.ask("removeFromBookmark", data, options);
					}
				},
				"breadcrumb": {
					"toggleBreadcrumb": function () {
						var hasForm = ($("#_FormTabs>li").length > 0);
						var breadcrumbHeight = 0;
						if (hasForm) {
							breadcrumbHeight = 20;
							$("#_BreadcrumbContent").show(200);
						} else {
							$("#_BreadcrumbContent").hide(200);
						}
						$("#_BreadcrumbBar").animate({ "height": breadcrumbHeight + "px" }, 200);
					},

					"changeBreadCrumb": function () {
						var bread = "Portal";
						if (_PortalContext.CurrentFunctionId) {
							$.each(_PortalContext.MenuList, function (i, product) {
								var found = false;
								$.each(product.DomainList, function (j, domainMenu) {
									if (found) {
										return false;
									}
									$.each(domainMenu.SystemList, function (j, systemMenu) {
										if (found) {
											return false;
										}
										$.each(systemMenu.FunctionList, function (j, functionMenu) {
											var searchFlag = {
												"found": false,
												"founctionArray": new Array()
											};
											_menu.getFunctionArray(_PortalContext.CurrentFunctionId, functionMenu, searchFlag);
											if (searchFlag.found) {
												found = true;
												bread += "<span class='text-gray'> > </span><span lang='" + product.Language_Key + "'>" + product.Name + "</span>"
													+ "<span class='text-gray'> > </span><span lang='" + domainMenu.Language_Key + "'>" + domainMenu.Code + "</span>";
												+ "<span class='text-gray'> > </span><span lang='" + systemMenu.Language_Key + "'>" + systemMenu.Code + "</span>";
												$.each(searchFlag.founctionArray, function (k, f) {
													bread += "<span class='text-gray'> > </span><span lang='" + f.Language_Key + "'>" + f.Code + "</span>";
												});
												return false;
											}
										});
									});
								});

								if (!found) {
									$.each(product.SystemList, function (i, systemMenu) {
										if (found) {
											return false;
										}
										$.each(systemMenu.FunctionList, function (j, functionMenu) {
											var searchFlag = {
												"found": false,
												"founctionArray": new Array()
											};
											_menu.getFunctionArray(_PortalContext.CurrentFunctionId, functionMenu, searchFlag);
											if (searchFlag.found) {
												found = true;
												bread += "<span class='text-gray'> > </span><span lang='" + product.Language_Key + "'>" + product.Name + "</span>"
													+ "<span class='text-gray'> > </span><span lang='" + systemMenu.Language_Key + "'>" + systemMenu.Code + "</span>";
												$.each(searchFlag.founctionArray, function (k, f) {
													bread += "<span class='text-gray'> > </span><span lang='" + f.Language_Key + "'>" + f.Code + "</span>";
												});
												return false;
											}
										});
									});
								} else {
									return false;
								}
							});
						}
						//$("#_BreadcrumbContent").hide().html(bread).show(300);
                        $("#_BreadcrumbContent").html(bread);
						$.language.change(_Context.CurrentLang);
					}
				},
				"form": {
					"openForm": function (menu) {
						var functionurl = $(menu).attr("functionurl");
						if (functionurl) {
							var functionname = $(menu).text();
							var functionid = $(menu).attr("functionid");
							$("#_FunctionMenu .treeview li").removeClass("active");
							$("#_BookmarkMenu li").removeClass("active");

							$(menu).addClass("active");

							var opend = this.showFormByFunctionId(functionid);

							if (!opend) {
								var tabHtml = '<li class="nav-item form-tab">'
									+ '<a class="nav-link" data-toggle="tab" href="#' + functionid + '" onclick="_form.showFormByFunctionId(\'' + functionid + '\'); return false;" role="tab" aria-controls="' + functionid + '" functionid="' + functionid + '">'
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
									+ '<button type="button" class="close" data-dismiss="alert" aria-hidden="true" onclick="return _form.closeForm(this);">&times;</button >'//<span class="fa fa-times icon_close_form" onclick="return closeForm(this);">'
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
								_cmenu.bindTabContextMenu();
								this.showFormByFunctionId(functionid);
							}
						}
						_breadcrumb.toggleBreadcrumb();
						return false;
					},

					"showFormByFunctionId": function (functionid) {
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
								_PortalContext.CurrentFunctionId = functionid;
								return false;
							}
						});
						_breadcrumb.changeBreadCrumb();
						return opened;
					},

					"closeFormByFunctionId": function (functionid) {
						var preTab = $("a[functionid=" + functionid + "]").parent().prev();
						var nextTab = $("a[functionid=" + functionid + "]").parent().next();
						_PortalContext.CurrentFunctionId = null;
						$("a[functionid=" + functionid + "]").parent().remove();
						$("#" + functionid).remove();
						_breadcrumb.changeBreadCrumb();

						if (preTab.length > 0) {
							var preFunctionId = preTab.find("a").attr("functionid");
							this.showFormByFunctionId(preFunctionId);
						} else if (nextTab.length > 0) {
							var nextFunctionId = nextTab.find("a").attr("functionid");
							this.showFormByFunctionId(nextFunctionId);
						}
					},

					"closeForm": function (ctrl) {
						$.dialog.showConfirm(_CurrentLang['msg_confirm_close_tab'], '', '',
							function () {
								var functionid = $(ctrl).parents('a').attr("functionid");
								_form.closeFormByFunctionId(functionid);
								_breadcrumb.toggleBreadcrumb();
							},
							function () {});

						return false;
					}
				}
			},
			"user": {
				"initUserInfo": function () {
					var options = {
						"success": function (d) {
							if (d.success) {
								_PortalContext.UserInfo = d.data;
								_user.refreshUserInfo();
							}
						}
					};

					$.ask("getUserInfo", {}, options);
				},
				"refreshUserInfo": function () {
					$("#lblUserName").text(_PortalContext.UserInfo.Name);
					$("#lblLoginTime").text(_PortalContext.UserInfo.LoginTime);

					var imgBinary = _PortalContext.UserInfo.ImageUrl;
					$(".userImage").hide(200).attr("src", imgBinary).show(200);
				}
			},
			"news": {
				"initNews": function () {
					var options = {
						"success": function (d) {
							if (d.success) {
								_PortalContext.News = d.data;
								_news.refreshNews();
							}
						},
						"show_mask": false
					};

					$.ask("getNews", {}, options);

					if (this.options.TIMER_ENABLE) {
						clearInterval(this.timer);
						this.timer = setInterval("this._news.initNews()", this.options.REFRESH_INTERVAL);
					}
				},
				"refreshNews": function () {
					var newsCount = _PortalContext.News.length;
					if (newsCount > 0) {
						if ($("#lblNewsCount").text() != newsCount) {
							$("#lblNewsCount").hide(200).text(newsCount).show(300);
						}						
						$("#lblTotalNews").text(newsCount);

						var html = "";
						$.each(_PortalContext.News, function (i, news) {
							html += _news.getNewsItemHtml(news);
						});
						$("#newsList").html(html);
					} else {
						$("#lblNewsCount").text(newsCount).hide(200);
					}
				},
				"getNewsItemHtml": function (news) {
					var date = new Date(parseInt(news.Created_Date.replace("/Date(", "").replace(")/", ""), 10));
					var html = "<li>"
                        + "<a onclick='return _news.openNews(\"" + news.Id + "\")' >"
						//+ "<h4 style='overflow:hidden;'>" + news.Subject + "<small><i class='fa fa-clock-o'></i>&nbsp;" + (new Date(date)).Format("yyyy-MM-dd") + "</small>"
						//+ "</h4>"
                        //+ "<p><i class='fa fa-user'></i>&nbsp;" + news.Created_By + "</p>"
                        + "<div>"
                        + "<h4 style='overflow:hidden;text-overflow:ellipsis;'>" + news.Subject + "</h4>"
                        + "</div>"
                        + "<small><i class='fa fa-clock-o'></i>&nbsp;" + (new Date(date)).Format("yyyy-MM-dd") + "</small>"
                        + "&nbsp;&nbsp;<small><i class='fa fa-user'></i>&nbsp;" + news.Created_By + "</small>"
                        + "</a></li>";
					return html;
				},
				"openNews": function (newsId) {
					var url = "PortalNewsDetail.aspx?" + $.param({ "id": newsId });
					window.open(url, "PortalNewsDetail", '', "_blank");
				},
				"timer": null,
				"options": {
					"TIMER_ENABLE": true,
					"REFRESH_INTERVAL": 5000
				}
			},
			"init": function () {
				this.ui.resetContentSize();
				$(window).on("resize", function () {
					_ui.resetContentSize();
                });

				$("#search-btn").on("click", function () {
					_menu.searchMenu();
				});

				$("#ddlLanguage").val($.uriAnchor.makeAnchorMap()["lang"]);

				this.ui.menu.initMenu();

				//Tabs Event
				$('#_FormTabs').on('shown.bs.tab', function (e) {
					var functionid = $(e.target).attr("functionid");
					_menu.activeMenu(functionid);
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

				this.user.initUserInfo();
				this.news.initNews();
			},
			"logout": function () {
				var options = {
					"success": function (d) {
						if (d.success) {
							$.cookie("SSOToken", null);
							$.goto("Login");
						}
					}
				};
				$.ask("logout", {}, options);
				return false;
			}
		}
	}
});

var _portal = $.cube.portal;
var _ui = _portal.ui;
var _header = _ui.header;
var _menu = _ui.menu;
var _cmenu = _ui.context_menu;
var _bookmark = _ui.bookmark;
var _breadcrumb = _ui.breadcrumb;
var _form = _ui.form;
var _user = _portal.user;
var _news = _portal.news;