<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemInquiry.aspx.cs" Inherits="CubeDemo.Web.ItemInquiry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/bootstrap.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/AdminLTE/AdminLTE.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/AdminLTE/skins/_all-skins.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/bootstrap-table.min.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/cube.framework.css">
</head>
<body class="skin-red">
    <form id="form1" runat="server">
        <!--inquiry area & toolbar-->
        <div class="cube-input-area">
            <div class="cube-inputbar">
                <div class="input-group cube-page-header-input">
                    <input type="text" class="form-control"
                        id="tbxItemNoInquiry" value="" placeholder="Item No." lang="lang_item_no" />
                    <span class="input-group-btn">
                        <button class="cube-btn-inquiry" onclick="return inquiryItem();"></button>
                    </span>
                </div>
            </div>
            <div class="cube-toolbar">
                <button class="cube-btn-add" onclick="return createItem();"></button>
                <button class="cube-btn-delete" onclick="return deleteItem();"></button>
            </div>
        </div>

        <!--inquiry result grid-->
        <div class="cube-data-area">
            <table id="gridItem" class="bootstrapTable cube-bootstrap-table" data-toggle="table" data-sort-name="item_no" data-toolbar="#toolbar"
                data-url="" data-height="391" data-pagination="true"
                data-show-refresh="true" data-row-style="rowStyle" data-search="false"
                data-show-toggle="true" data-sortable="true"
                data-striped="true" data-page-size="10" data-page-list="[5,10,20]"
                data-click-to-select="false" data-single-select="false" >
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
                <input type="text" class="cube-tbx cube-tbx-required"
                        placeholder="Item No." lang="lang_item_no" id="tbxItemNo" value=""/>  
                <input type="text" class="cube-tbx" 
                        placeholder="Description" lang="lang_description" id="tbxDescription" value=""/>
            </div>
            <div class="cube-modal-footer">
                <button class="cube-btn-save cube-btn-dlg-toolbar" onclick="return saveItem()"></button>
                <button class="cube-btn-cancel cube-btn-dlg-toolbar" data-dismiss="modal"></button>
            </div>
        </div>
    </form>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery-2.2.3.min.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery.uriAnchor.js"></script>    
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery.slimscroll.min.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap-table.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap-table-zh-TW.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap-table-zh-CN.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap-table-en-US.js"></script>
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery.wresize.js"></script>    
    <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/cube.framework.js"></script>
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

    </script>
</body>
</html>
