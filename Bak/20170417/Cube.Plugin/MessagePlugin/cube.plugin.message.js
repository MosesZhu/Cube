var cube = window.cube ? window.cube : {};
if (!cube.plugin) {
    cube.plugin = {};
}
if (!cube.plugin.message) {

}
jQuery.extend({
    "cube": {
        "dialog": {},
        "showMessage": function (title, content, warning, type, times) {
            if (parent && parent.showMessage) {
                if (!times) {
                    var times = 1;
                    parent.showMessage(title, content, warning, type, times);
                    return;+98
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
            if (parent && parent.showLoading) {
                if (!times) {
                    var times = 1;
                    parent.showLoading(times);
                    return;
                }
            }
            $("#loader").show();
        },
        "closeLoading": function (times) {
            if (parent && parent.closeLoading) {
                if (!times) {
                    var times = 1;
                    parent.closeLoading(times);
                    return;
                }
            }
            $("#loader").hide();
        },
    }
});