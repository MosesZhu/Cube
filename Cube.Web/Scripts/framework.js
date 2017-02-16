﻿jQuery.extend({
    "ask": function (method, data, options) {
        var ssoToken = getQueryStringByName("SSOToken") ? getQueryStringByName("SSOToken") : "";
        if (!ssoToken) {            
            //return false;
            //ssoToken = "aaa";
        }

        if (!method) {
            //return false;
        }

        var url = (location.href + "").split("#")[0].split("?")[0];
        var tempList = url.split("/");
        var tempName = tempList[tempList.length - 1];
        var ashxName = tempName.split(".")[0] + "Handler.ashx";
        var tempUrl = url.substring(0, url.length - tempName.length);
        url = tempUrl + ashxName + "?func=" + method;

        var cusSuccess = (options && options.success) ? options.success : $.answer.success;
        var cusError = (options && options.error) ? options.error : $.answer.error;
        
        $.ajax({
            url: url,
            dataType: "json",
            type: "POST",
            contentType: "application/json",
            data: {},
            beforeSend: function (request) {
                request.setRequestHeader("SSOToken", ssoToken);
            },
            success: function (d) {
                if (!d.success && d.errorcode == "E0001") {
                    location.href = "Login";
                } else {
                    cusSuccess(d);
                }
            },
            error: function (e) {
                cusError(e);
            }
        });        
    },

    "answer": {
        "success": function (d) {
            alert("Success");            
        },

        "failed": function () {
            alert("Error");

        }
    }
});

var _Context = {
    "CurrentFunctionId": "",
    "CurrentLang": "EnUS",
};
var _CurrentLang = _Lang_ZhCN ? _Lang_ZhCN : {};
var _RefreshMultiLanguage = function (language) {
    _Context.CurrentLang = language;
    switch (_Context.CurrentLang) {
        case "ZhCN":
            _CurrentLang = _Lang_ZhCN;
            break;
        case "ZhTW":
            _CurrentLang = _Lang_ZhTW;
            break;
            //case "EnUS":
        default:
            _CurrentLang = _Lang_EnUS;
            break;
    }
    for (key in _CurrentLang) {
        $("[lang=" + key + "]").text(_CurrentLang[key]);
    }
}

$(function () {
    $(window).bind('hashchange', onHashChange);
    var qLang = getQueryStringByName("lang");
    if (!qLang) {
        qLang = "ZhCN";
    }
    _RefreshMultiLanguage(qLang);
});

var onHashChange = function () {
    _RefreshMultiLanguage($.uriAnchor.makeAnchorMap()["lang"]);
    //alert($.uriAnchor.makeAnchorMap()["lang"]);
}

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

var changeSkin = function (themeName) {
    $("body").removeClass().addClass("skin-" + themeName).addClass("fixed");
};

jQuery.extend({
    "dialog": {
        "dialog": {},
        "closeDialog": function () {
            $("#messageDialog").modal('hide');
        },
        "showDialog": function (title, content, warning, type) {
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
        "showWarning": function (title, content, warning) {

        },
    }
});