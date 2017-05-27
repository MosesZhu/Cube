jQuery.extend({
    "cube": {
        "callWebService": function () {

        }
    }
});

jQuery.extend({
    "callWebService": function (method, data, options, not_self_service) {
        var showMask = true;
        if (options && options.hasOwnProperty("show_mask")) {
            showMask = options.show_mask;
        }
        if (showMask) {
            $.dialog.showLoading();
        }
        
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
            $.dialog.showMessage({
                "title": "error",
                "content": e.responseText
            });
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

var CubeFrameworkMessage = {
    "SHOW_MESSAGE": "SHOW_MESSAGE",
    "CLOSE_MESSAGE": "CLOSE_MESSAGE",
    "SHOW_CONFIRM": "SHOW_CONFIRM",
    "CLOSE_CONFIRM": "CLOSE_CONFIRM",
    "SHOW_LOADING": "SHOW_LOADING",
    "CLOSE_LOADING": "CLOSE_LOADING",
    "CUBE_CALLBACK": "CUBE_CALLBACK"
};

window.onmessage = function (e) {
    e = e || event;
    try {
        var msg = $.parseJSON(e.data);
        switch (msg.message) {
            case CubeFrameworkMessage.CUBE_CALLBACK:
                try {
                    eval("(" + msg.data + ")" + "()");
                } catch (e) { }
                break;
        }
    } catch (e) { }
}

jQuery.extend({
    "dialog": {
        "dialog": {},
        "showMessage": function (data) {
            if ($("#messageDialog") && $("#messageDialog").html()) {
                $("#messageDialogTitle").text("");
                $("#messageDialogContent").html("");
                $("#messageDialogWarningContent").html("");

                if (data.title) {
                    $("#messageDialogTitle").text(data.title);
                }

                if (data.content) {
                    $("#messageDialogContent").html(data.content);
                }

                if (data.warning) {
                    $("#messageDialogWarningContent").html(data.warning);
                }

                $("#messageDialog").modal('show');
            } else {
                if (window.parent) {
                    var msg = {
                        "wname": window.name,
                        "message": CubeFrameworkMessage.SHOW_MESSAGE,
                        "data": data
                    };
                    window.parent.postMessage(JSON.stringify(msg), "*");
                }
            }
        },
        "closeMessage": function () {
            if ($("#messageDialog") && $("#messageDialog").html()) {
                $("#messageDialog").modal('hide');
            } else {
                if (window.parent) {
                    var msg = {
                        "wname": window.name,
                        "message": CubeFrameworkMessage.CLOSE_MESSAGE
                    };
                    window.parent.postMessage(JSON.stringify(msg), "*");
                }
            }
        },
        "showConfirm": function (data, wname) {
            if ($("#confirmDialog") && $("#confirmDialog").html()) {
                $("#confirmDialogContent").html("");
                $("#confirmDialogWarningContent").html("");

                if (data.content) {
                    $("#confirmDialogContent").html(data.content);
                }

                if (data.warning) {
                    $("#confirmDialogWarningContent").html(data.warning);
                }

                $("#btnConfirmDialogConfirm").off('click');
                $("#btnConfirmDialogCancel").off('click');

                if (data.oktodo) {
                    $("#btnConfirmDialogConfirm").on('click', data.oktodo);
                }

                if (data.canceltodo) {
                    $("#btnConfirmDialogCancel").on('click', data.canceltodo);
                }

                if (wname && window.frames[wname]) {
                    var win = window.frames[wname];
                    if (data.okfuncname) {                        
                        $("#btnConfirmDialogConfirm").on('click', function () {
                            var msg = {
                                "message": CubeFrameworkMessage.CUBE_CALLBACK,
                                "data": data.okfuncname
                            };
                            win.postMessage(JSON.stringify(msg), "*");
                        });
                    }

                    if (data.okfunc) {
                        $("#btnConfirmDialogConfirm").on('click', function () {
                            var msg = {
                                "message": CubeFrameworkMessage.CUBE_CALLBACK,
                                "data": data.okfunc
                            };
                            win.postMessage(JSON.stringify(msg), "*");
                        });
                    }

                    if (data.cancelfuncname) {
                        $("#btnConfirmDialogCancel").on('click', function () {
                            var msg = {
                                "message": CubeFrameworkMessage.CUBE_CALLBACK,
                                "data": data.cancelfuncname
                            };
                            win.postMessage(JSON.stringify(msg), "*");
                        });
                    }

                    if (data.cancelfunc) {
                        $("#btnConfirmDialogCancel").on('click', function () {
                            var msg = {
                                "message": CubeFrameworkMessage.CUBE_CALLBACK,
                                "data": data.cancelfunc
                            };
                            win.postMessage(JSON.stringify(msg), "*");
                        });
                    }
                }

                $("#confirmDialog").modal('show');
            } else {
                if (window.parent) {
                    if (data.okfunc) {
                        data.okfunc = data.okfunc.toString().replace(/\r\n/g, "");
                    }
                    if (data.cancelfunc) {
                        data.cancelfunc = data.cancelfunc.toString().replace(/\r\n/g, "");;
                    }
                    var msg = {
                        "wname": window.name,
                        "message": CubeFrameworkMessage.SHOW_CONFIRM,
                        "data": data
                    };
                    window.parent.postMessage(JSON.stringify(msg), "*");
                }
            }
        },
        "closeConfirm": function () {
            if ($("#confirmDialog") && $("#confirmDialog").html()) {
                $("#confirmDialog").modal('hide');
            } else {
                if (window.parent) {
                    var msg = {
                        "wname": window.name,
                        "message": CubeFrameworkMessage.CLOSE_CONFIRM
                    };
                    window.parent.postMessage(JSON.stringify(msg), "*");
                }
            }            
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
        "showLoading": function () {
            if ($("#loader") && $("#loader").html()) {
                $("#loader").show();
            } else {
                if (window.parent) {
                    var msg = {
                        "wname": window.name,
                        "message": CubeFrameworkMessage.SHOW_LOADING
                    };
                    window.parent.postMessage(JSON.stringify(msg), "*");
                }
            }
        },
        "closeLoading": function () {
            if ($("#loader") && $("#loader").html()) {
                $("#loader").hide();
            } else {
                if (window.parent) {
                    var msg = {
                        "wname": window.name,
                        "message": CubeFrameworkMessage.CLOSE_LOADING
                    };
                    window.parent.postMessage(JSON.stringify(msg), "*");
                }
            }
        }
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
            "default": "red",
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

// 对Date的扩展，将 Date 转化为指定格式的String
// 月(M)、日(d)、小时(h)、分(m)、秒(s)、季度(q) 可以用 1-2 个占位符， 
// 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字) 
// 例子： 
// (new Date()).Format("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423 
// (new Date()).Format("yyyy-M-d h:m:s.S")      ==> 2006-7-2 8:9:4.18 
Date.prototype.Format = function (fmt) { //author: meizz 
    var o = {
        "M+": this.getMonth() + 1, //月份 
        "d+": this.getDate(), //日 
        "h+": this.getHours(), //小时 
        "m+": this.getMinutes(), //分 
        "s+": this.getSeconds(), //秒 
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
        "S": this.getMilliseconds() //毫秒 
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
}