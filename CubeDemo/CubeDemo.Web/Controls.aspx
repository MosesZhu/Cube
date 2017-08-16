<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Controls.aspx.cs" Inherits="CubeDemo.Web.Controls" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/bootstrap.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/AdminLTE/AdminLTE.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/AdminLTE/skins/_all-skins.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/datepicker/datepicker3.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/timepicker/bootstrap-timepicker.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/bootstrap-table.min.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/cube.framework.css">
</head>
<body class="skin-red">
    <form id="form1" runat="server">
        <!--inquiry area & toolbar-->
        <div class="cube-input-area">
            <div class="cube-inputbar">
                <div class="cube-form-row-2">
                    <label for="tbxDemo1" lang="lang_item_no"></label>
                    <input type="text" id="tbxDemo1" />
                    <label for="tbxDemo1" lang="lang_trans_time"></label>
                    <input type="text" class="cube-datepicker" data-format="yyyy/mm/dd" id="dateCallbackDate" 
                        value="2010/01/01" onchange="return pickDate(this);" />
                </div>

                <div class="cube-form-row-2">
                    <label for="ddlLanguage" lang="lang_language"></label>
                    <select class="cube-select" id="ddlLanguage">
                        <option selected="selected" value="EnUS">English</option>
                        <option value="ZhCN">中文简体</option>
                        <option value="ZhTW">中文繁體</option>
                    </select>
                    <label for="tbxDemo4" lang="lang_telephone_number"></label>
                    <div class="bootstrap-timepicker">
                        <input type="text" class="cube-timepicker" />
                    </div>
                </div>

                <div class="cube-form-row-1">
                    <label for="tbxDemo5" lang="lang_language"></label>
                    <input type="text" id="tbxDemo5" />
                </div>

                <div class="cube-form-row-1">
                    <label for="tbxDemo6" lang="lang_telephone_number"></label>
                    <input type="text" id="tbxDemo6" />
                </div>

                <div class="cube-form-row-1">
                    <label for="tbxItemNoInquiry" lang="lang_item_no"></label>
                    <div class="input-group">
                        <input type="text" class="form-control"
                            id="tbxItemNoInquiry" value="" />
                        <span class="input-group-btn">
                            <button class="cube-btn-inquiry" onclick="return inquiryItem();"></button>
                        </span>
                    </div>
                </div>

            </div>
            <div class="cube-toolbar">
                <button class="cube-btn-add" onclick="return createItem();"></button>
                <button class="cube-btn-delete" onclick="return deleteItem();"></button>
                <button class="cube-btn-edit" onclick=""></button>
                <button class="cube-btn-test" onclick="return testHttpHandlerBase();"></button>
                <button class="cube-btn-test" onclick="return testBusinessBase();"></button>
                <button class="cube-btn-export" onclick=""></button>
                <button class="cube-btn-import" onclick=""></button>
                <button class="cube-btn-send" onclick=""></button>
                <button class="cube-btn-mail" onclick=""></button>
                <button class="cube-btn-confirm" onclick=""></button>
                <button class="cube-btn-close" onclick=""></button>
                <button class="cube-btn-cancel" onclick=""></button>
                <button class="cube-btn-save" onclick=""></button>
                <button class="cube-btn-inquiry" onclick=""></button>
                <button class="cube-btn-detail" onclick=""></button>
                <button class="cube-btn-info" onclick=""></button>
                <button class="cube-btn-print" onclick=""></button>
                <button class="cube-btn-config" onclick=""></button>
            </div>
        </div>

        <!--inquiry result grid-->
        <div class="cube-data-area">
            <table id="gridItem" class="cube-bootstrap-table" data-sort-name="item_no" >
                <thead>
                    <tr>
                        <th data-field="state" data-checkbox="true" data-width="10%"></th>
                        <th data-field="Id" data-sortable="true" data-visible="false" data-searchable="false">ID</th>
                        <th data-field="Item_No" data-sortable="true" data-formatter="itemNoFormatter" data-search-formatter="false" lang="lang_item_no" data-width="30%">Item NO.</th>
                        <th data-field="Description" data-sortable="true" lang="lang_description" data-width="60%">Description</th>
                    </tr>
                </thead>
            </table>
        </div>

        <!--edit dialog-->
        <div id="itemMaintainDialog" class="cube-modal">
            <div class="cube-modal-header">
                <h1 class="modal-title" lang="lang_edit"></h1>
            </div>
            <div class="cube-modal-body">
                <%--<div class="cube-form-row-1">
                    <label for="tbxItemNo" lang="lang_item_no">Item No.</label>
                    <input type="text" class="cube-tbx cube-tbx-required" id="tbxItemNo" />
                </div>
                <div class="cube-form-row-1">
                    <label for="tbxDescription" lang="lang_description">Description</label>
                    <input type="text" class="cube-tbx cube-tbx-required" id="tbxDescription" />
                </div>--%>
                <div class="cube-input-area">
                    <div class="cube-inputbar">
                        <div class="cube-form-row-1">
                            <label for="tbxUserName" lang="lang_user_name"></label>
                            <div class="input-group">
                                <input type="text" class="form-control" disabled="disabled"
                                    id="tbxUserName" value="" />
                                <span class="input-group-btn">
                                    <button class="btn btn-primary" id="btnSearch" lang="lang_select_user"></button>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="cube-data-area">
                    <table id="companyTable" class="bootstrapTable cube-bootstrap-table" data-toggle="table"  data-method="post"
                            data-url="" data-pagination="true" data-show-refresh="false" 
                            data-search="false" 
                            data-show-toggle="false" data-striped="true" data-page-size="10" data-page-list="[5,10,20]" 
                            data-click-to-select="false" data-single-select="false">
                        <thead>
                            <tr>
                                <th data-field="state" data-formatter="checkboxFormatter" data-checkbox="true" data-valign="middle" data-align="center"></th>
                                <th data-field="Company_Code" lang="lang_company_id">Company ID</th>
                                <th data-field="Company_Name" lang="lang_company_name">Company Name</th>
                            </tr>
                        </thead>
                    </table>
                </div>
            </div>
            <div class="cube-modal-footer">
                <button class="cube-btn-save" onclick="return saveItem()"></button>
                <button class="cube-btn-cancel" data-dismiss="modal"></button>
            </div>
        </div>


    </form>
    <%--<script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery-2.2.3.min.js"></script>--%>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery-1.12.4.min.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/cube.framework.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery.uriAnchor.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery.slimscroll.min.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/timepicker/bootstrap-timepicker.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/datepicker/bootstrap-datepicker.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/input-mask/jquery.inputmask.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap-table.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap-table-zh-TW.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap-table-zh-CN.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap-table-en-US.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/AdminLTE.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery.wresize.js"></script>
    <script>        
        var _opt;
        var currentMaintainItemId = null;
        var _SelectedItemIdList;

        var itemNoFormatter = function (value, row) {
            return '<a onclick="updateItem(\'' + row.Id + '\')" style="cursor:pointer">' + value + '</a>';
        };

        var inquiryItem = function () {
            var options = {
                "success": function (d) {
                    $("#gridItem").bootstrapTable("load", d);
                }
            };

            var itemNo = $('#tbxItemNoInquiry').val();
            $.callWebService("Inquiry", { 'itemNo': itemNo }, options);
            return true;
        };

        var updateItem = function (itemId) {
            var allItemList = $("#gridItem").bootstrapTable('getData');
            $.each(allItemList, function (i, item) {
                if (item.Id == itemId) {
                    $("#tbxItemNo").val(item.Item_No);
                    $("#tbxDescription").val(item.Description);
                    return false;
                }
            });

            $("#itemMaintainDialog").modal('show');
            _opt = "Update";
            currentMaintainItemId = itemId;
        };

        var createItem = function () {
            $("#tbxItemNo").val("");
            $("#tbxDescription").val("");
            $("#itemMaintainDialog").modal('show');
            _opt = "Create";
        };

        var saveItem = function () {
            var itemNo = $("#tbxItemNo").val();
            var description = $("#tbxDescription").val();
            if (itemNo == "") {
                $.dialog.showMessage({
                    "title": _CurrentLang["lang_error"],
                    "content": _CurrentLang["msg_item_no_can_not_empty"]
                });
                return false;
            }


            var options = {
                "success": function (d) {
                    $("#itemMaintainDialog").modal('hide');
                    $.dialog.showMessage({
                        "title": _CurrentLang["lang_success"],
                        "content": _CurrentLang["msg_save_success"]
                    });
                    inquiryItem();
                }
            };

            var mydata = {
                'id': currentMaintainItemId,
                'itemNo': itemNo,
                'description': description
            };

            var serviceFuncName = "UpdateItem";
            if (_opt == "Create") {
                serviceFuncName = "CreateItem";
            }

            $.callWebService(serviceFuncName, mydata, options);

            return true;
        }

        var deleteItem = function () {
            var selectedItems = $("#gridItem").bootstrapTable("getSelections");
            if (selectedItems.length == 0) {
                $.dialog.showMessage(
                    {
                        "title": _CurrentLang['lang_error'],
                        "content": _CurrentLang['msg_must_select_one_data']
                    }
                );
                return false;
            }

            _SelectedItemIdList = [];
            $.each(selectedItems, function (i, item) {
                _SelectedItemIdList.push(item.Id);
            });

            var confirmData = {
                "title": _CurrentLang["lang_confirm"],
                "content": _CurrentLang["msg_confirm_delete_data"],
                "okfuncname": "doDeleteItem",
            };
            $.dialog.showConfirm(confirmData);
            return false;
        };

        var doDeleteItem = function () {
            var options = {
                "success": function (d) {
                    $("#itemMaintainDialog").modal('hide');
                    $.dialog.showMessage({
                        "title": 'Success',
                        "content": 'Delete success'
                    });
                    inquiryItem();
                }
            };

            var mydata = {
                'idList': _SelectedItemIdList
            };

            $.callWebService("DeleteItems", mydata, options);
            return true;
        };

        var testHttpHandlerBase = function () {
            var options = {
                "success": function (d) {
                    alert(d);
                }
            };

            var mydata = {
                'action': 'GetUserInfo'
            };

            $.post('ItemInquiryHandler.ashx', mydata, function (data) {
                alert(data);

            }, "json");

            //$.ajax({
            //    url: 'ItemInquiryHandler.ashx',
            //    dataType: "json",
            //    type: "POST",
            //    contentType: "application/json;charset=utf-8",
            //    data: mydata,
            //    success: function (d) {
            //        alert(d);
            //    },
            //    error: function (e) {
            //        alert(e);
            //    }
            //});

            return true;
        };

        var testBusinessBase = function () {
            var options = {
                "success": function (d) {
                    alert(d);
                }
            };

            var mydata = {};

            var serviceFuncName = "GetUserInfo";

            $.callWebService(serviceFuncName, mydata, options);

            return true;
        };

        var pickDate = function (ctrl) {
            $.dialog.showMessage({ "content": $(ctrl).val()});
        }
    </script>
</body>
</html>
