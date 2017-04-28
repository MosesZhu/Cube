var cube = window.cube ? window.cube : {};
if (!cube.plugin) {
    cube.plugin = {};
}

jQuery.extend({
    "ask": function (method, data, options, not_self_service) {
        $.dialog.showLoading();
        var ssoToken = getQueryStringByName("SSOToken") ? getQueryStringByName("SSOToken") : "";
        if (!ssoToken) {
            window.location.href = "Login";
        }

        if (!method) {
            return false;
        }

        var url = "";
        if (not_self_service) {
            url = method;
        } else {
            url = (location.href + "").split("#")[0].split("?")[0];
            var tempList = url.split("/");
            var tempName = tempList[tempList.length - 1];
            var tempUrl = url.substring(0, url.length - tempName.length);
            var serviceName = tempName.split(".")[0] + "Service.asmx";
            url = tempUrl + serviceName + "/" + method;
        }

        var cusSuccess = (options && options.success) ? options.success : $.answer.success;
        var cusError = (options && options.error) ? options.error : $.answer.error;

        $.ajax({
            url: url,
            dataType: "json",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            async: options.async ? options.async : true,
            beforeSend: function (request) {
                request.setRequestHeader("SSOToken", ssoToken);
                request.setRequestHeader("Language", _Context.CurrentLang);
                if (getQueryStringByName("IsDebug") == "Y") {
                    request.setRequestHeader("IsDebug", "Y");
                    request.setRequestHeader("LocalDebugUrl", getQueryStringByName("LocalDebugUrl"));
                }
            },
            success: function (d) {
                $.dialog.closeLoading();
                var resultData = d.d;
                if (!resultData.success && resultData.errorcode == "E0001") {
                    location.href = "Login";
                } else {
                    cusSuccess(resultData);
                }
            },
            error: function (e) {
                $.dialog.closeLoading();
                cusError(e);
            }
        });
    },

    "answer": {
        "success": function (d) {
            alert("Success");            
        },

        "failed": function () {
            alert("Failed");

        },

        "error": function (e) {
            $.dialog.showMessage("error", e.responseText);
        }
    }
});

jQuery.extend({
    "goto": function (url, useCurrentMap, map) {
        var finalUrl = url;
        var ssoToken = getQueryStringByName("SSOToken") ? getQueryStringByName("SSOToken") : "";
        finalUrl += (finalUrl.indexOf("?") >= 0 ? "&" : "?") + "SSOToken=" + ssoToken;

        if (useCurrentMap) {
            var currentMap = $.uriAnchor.makeAnchorMap();
            finalUrl += "#!lang=" + currentMap["lang"] + "&skin=" + currentMap["skin"];            
        } else {
            if (map) {
                finalUrl += "#!lang=" + map["lang"] + "&skin=" + map["skin"];
            }
        }
        window.location.href = finalUrl;
    }
});

var _Context = {
    "CurrentFunctionId": "",
    "CurrentLang": "EnUS",
    "CurrentSkin": "blue",
};
var _CurrentLang = window._Lang_ZhCN ? window._Lang_ZhCN : {};

$(function () {
    $(window).bind('hashchange', $.CubeEvent.onHashChange);
    //$(window).bind('beforeunload', $.CubeEvent.onUnload);

    var map = $.uriAnchor.makeAnchorMap();
    var needSetAnchor = false;
    if (!map["lang"]) {
        map["lang"] = $.language.type.default;        
        needSetAnchor = true;
    }

    if (!map["skin"]) {
        map["skin"] = $.skin.type.default;
        needSetAnchor = true;
    }

    _Context.CurrentLang = map["lang"];
    _Context.CurrentSkin = map["skin"];

    if (needSetAnchor) {
        $.uriAnchor.setAnchor(map);
    }    

    $.language.change(_Context.CurrentLang);
    $.skin.change(_Context.CurrentSkin);
});

//start proxy function
var setSkin = function (skinName) {
    _Context.CurrentSkin = skinName;
    $.skin.set(skinName);
    return false;
}

var setLanguage = function (languageName) {
    _Context.CurrentLang = languageName;
    $.language.set(languageName);
    return false;
}

var showMessage = function (title, content, warning, type, times) {
    $.dialog.showMessage(title, content, warning, type, times);
};

var closeMessage = function (times) {
    $.dialog.closeMessage(times);
};

var showConfirm = function (title, content, warning, type, oktodo, canceltodo, times) {
    $.dialog.showConfirm(title, content, warning, type, oktodo, canceltodo, times);
};

var closeConfirm = function (times) {
    $.dialog.closeConfirm(times);
};

var showLoading = function (times) {
    $.dialog.showLoading(times);
};

var closeLoading = function (times) {
    $.dialog.closeLoading(times);
};

var showDialogOnTop = function (dialogId, dialogHtml, times) {
    $.dialog.showDialogOnTop(dialogId, dialogHtml, times);
};

//end proxy function

jQuery.extend({
    "CubeEvent": {
        "onHashChange": function () {
            var map = $.uriAnchor.makeAnchorMap();

            var languageName = map["lang"];
            if (!languageName) {
                languageName = $.language.type.default;
            }
            $.language.change(languageName);

            var skinName = map["skin"];
            if (!skinName) {
                skinName = $.skin.type.default;
            }
            $.skin.change(skinName);
        },

        "onUnload": function () {
            if (window.ConfirmClose || $("iframe").length <= 0) {
                window.opener = null;
                window.open('', '_self', '');
                window.close();
                return;
            }

            $.dialog.showConfirm(_CurrentLang['msg_confirm_close_window'], '', '',
                function () {
                    window.ConfirmClose = true;
                    window.opener = null;
                    window.open('', '_self', '');
                    window.close();
                },
                function () {
                    $.dialog.closeConfirm();
                    return false;
                });

            return false;
        },
    }
})

jQuery.extend({
    "dialog": {
        "dialog": {},        
        "showMessage": function (title, content, warning, type, times) {
            if (parent && parent.showMessage) {
                if (!times) {
                    var times = 1;
                    parent.showMessage(title, content, warning, type, times);
                    return;
                }             
            }
            $("#messageDialogTitle").text("");
            $("#messageDialogContent").html("");
            $("#messageDialogWarningContent").html("");

            if (title) {
                $("#messageDialogTitle").text(title);
            }

            if (content) {
                $("#messageDialogContent").html(content);
            }

            if (warning) {
                $("#messageDialogWarningContent").html(warning);
            }

            $("#messageDialog").modal('show');
        },
        "closeMessage": function (times) {
            if (parent && parent.closeMessage) {
                if (!times) {
                    var times = 1;
                    parent.closeMessage(times);
                    return;
                }
            }
            $("#messageDialog").modal('hide');
        },
        "showConfirm": function (content, warning, type, oktodo, canceltodo, times) {
            if (parent && parent.showConfirm) {
                if (!times) {
                    var times = 1;
                    parent.showConfirm(content, warning, type, oktodo, canceltodo, times);
                    return;
                }
            } 
            
            $("#confirmDialogContent").html("");
            $("#confirmDialogWarningContent").html("");

            if (content) {
                $("#confirmDialogContent").html(content);
            }

            if (warning) {
                $("#confirmDialogWarningContent").html(warning);
            }

            $("#btnConfirmDialogConfirm").off('click');
            $("#btnConfirmDialogCancel").off('click');

            if (oktodo) {
                $("#btnConfirmDialogConfirm").on('click', oktodo);
            }

            if (canceltodo) {
                $("#btnConfirmDialogCancel").on('click', canceltodo);
            }

            $("#confirmDialog").modal('show');
        },
        "closeConfirm": function (times) {
            if (parent && parent.closeConfirm) {
                if (!times) {
                    var times = 1;
                    parent.closeConfirm(times);
                    return;
                }
            }
            $("#confirmDialog").modal('hide');
        },
        "showDialog": function (dialogId) {
            $("#" + dialogId).modal('show');
        },
        "closeDialog": function (dialogId) {
            $("#" + dialogId).modal('hide');
        },
        "showDialogOnTop": function (dialogId, dialogHtml, times) {
            if (parent && parent.showDialogOnTop) {
                if (!dialogHtml) {
                    dialogHtml = $("<div></div>").append($("#" + dialogId).clone()).html();
                }
                if (!times) {
                    var times = 1;
                    parent.showDialogOnTop(dialogId, dialogHtml, times);
                    return;
                }
            }
            $("#customerDialogContainer").html(dialogHtml);
            $("#" + dialogId).modal('show');
        },
        "showLoading": function (times) {
            try {
                if (parent && parent.showLoading) {
                    if (!times) {
                        var times = 1;
                        parent.showLoading(times);
                        return;
                    }
                }
            } catch (error) {}
            
            $("#loader").show();
        },
        "closeLoading": function (times) {
            try {
                if (parent && parent.closeLoading) {
                    if (!times) {
                        var times = 1;
                        parent.closeLoading(times);
                        return;
                    }
                }
            } catch (error) { }
            
            $("#loader").hide();
        },
    }
});

var CustomerDialogOption = function () {
    this.ElementId = null,
    this.ElementType = null,
    this.ElementAction = null
};

jQuery.extend({
    "language": {
        "type": {
            "default": "ZhCN",
            "ZhCN": "ZhCN",
            "ZhTW": "ZhTW",
            "EnUS": "EnUS"
        },
        "set": function (languageName) {
            if (!$.language.type[languageName]) {
                languageName = $.language.type.default;
            }

            var map = $.uriAnchor.makeAnchorMap();
            if (map["lang"] != languageName) {
                map["lang"] = languageName;
                $.uriAnchor.setAnchor(map);
            }           
        },
        "change": function (languageName) {
            _Context.CurrentLang = languageName;
            switch (_Context.CurrentLang) {
                case "ZhCN":
                    _CurrentLang = window._Lang_ZhCN;
                    break;
                case "ZhTW":
                    _CurrentLang = window._Lang_ZhTW;
                    break;
                default:
                    _CurrentLang = window._Lang_EnUS;
                    break;
            }
            for (key in _CurrentLang) {
                $.each($("[lang=" + key + "]"), function (i, item) {
                    if (typeof ($(item).attr("placeholder")) == "undefined") {
                        $(item).text(_CurrentLang[key]);
                    } else {
                        $(item).attr("placeholder", _CurrentLang[key]);
                    }
                });                                                              
            }
            if (this.onchanged) {
                this.onchanged();
            }
        },
        "onchanged": function () {
        }
    }
});

jQuery.extend({
    "skin": {
        "type": {
            "default": "blue",
            "blue": "blue",
            "blue-light": "blue-light",
            "yellow": "yellow",
            "yellow-light": "yellow-light",
            "green": "green",
            "green-light": "green-light",
            "red": "red",
            "red-light": "red-light",
            "purple": "purple",
            "purple-light": "purple-light",
            "black": "black",
            "black-light": "black-light"
        },
        "set": function (skinName) {
            if (!$.skin.type[skinName]) {
                skinName = $.skin.type.default;
            }

            var map = $.uriAnchor.makeAnchorMap();
            if (map["skin"] != skinName) {
                map["skin"] = skinName;
                $.uriAnchor.setAnchor(map);
            }
        },
        "change": function (skinName) {
            _Context.CurrentSkin = skinName;
            $("body").removeClass().addClass("skin-" + skinName).addClass("fixed");
        }
    }
});

//Common Function
function getQueryString() {
    var result = location.search.match(new RegExp("[\?\&][^\?\&]+=[^\?\&]+", "g"));
    for (var i = 0; i < result.length; i++) {
        result[i] = result[i].substring(1);
        result[i] = { "key": result[i].split("=")[0], "value": result[i].split("=")[2] };
    }
    return result;
}

function getQueryStringFromSearch(url) {
    var result = url.match(new RegExp("[\?\&][^\?\&]+=[^\?\&]+", "g"));
    if (result != null) {
        for (var i = 0; i < result.length; i++) {
            result[i] = result[i].substring(1);
            result[i] = { "key": result[i].split("=")[0], "value": result[i].split("=")[1] };
        }
    } else {
        return [];
    }
    return result;
}

//根据QueryString参数名称获取值 
function getQueryStringByName(name) {
    var result = location.search.match(new RegExp("[\?\&]" + name + "=([^\&]+)", "i"));
    if (result == null || result.length < 1) {
        return "";
    }
    return result[1];
}
//根据QueryString参数索引获取值 

function getQueryStringByIndex(index) {
    if (index == null) {
        return "";
    }
    var queryStringList = getQueryString();
    if (index >= queryStringList.length) {
        return "";
    }
    var result = queryStringList[index];
    var startIndex = result.indexOf("=") + 1;
    result = result.substring(startIndex);
    return result;
}