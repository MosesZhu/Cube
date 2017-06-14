<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ItemInquiry.aspx.cs" Inherits="CubeDemo.Web.ItemInquiry" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>    
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/bootstrap.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/AdminLTE/skins/_all-skins.css">
    <link rel="stylesheet" href="http://o-a3b2.qgroup.corp.com/CubePortal/Content/bootstrap-table.min.css">
</head>
<body class="skin-red">
    <form id="form1" runat="server">
        <div class="content-wrapper" style="padding: 20px;">
            <!--inquiry area & toolbar-->
            <div class="row">
                <div class="col-lg-6 col-xs-6">
                    <table>
                        <tr>
                            <td lang="lang_item_no">Item NO.</td>
                            <td class="text-bold" style="padding: 10px;">
                                <input type="text" data-clear-btn="true" name="tbxItemNoInquiry" class="form-control"
                                    id="tbxItemNoInquiry" value="" />                                
                            </td>
                        </tr>
                    </table>
                </div>

                <div class="col-lg-6 col-xs-6">
                    <div class="btn-toolbar" role="toolbar" style="float: right;">
                        <button type="button" class="btn btn-skin-primary" onclick="return inquiryItem();" lang="lang_inquiry">
                            Inquiry
                        </button>
                        <button type="button" class="btn btn-danger" onclick="return deleteItem();" lang="lang_delete">
                            Delete
                        </button>
                    </div>
                </div>
            </div>

            <!--inquiry result grid-->
            <div class="row" style="padding: 15px;">
                <table id="gridItem" class="bootstrapTable" data-toggle="table" data-sort-name="item_no" data-toolbar="#toolbar"
                    data-url="" data-height="398" data-pagination="true"
                    data-show-refresh="true" data-row-style="rowStyle" data-search="false"
                    data-show-toggle="true" data-sortable="true"
                    data-striped="true" data-page-size="10" data-page-list="[5,10,20]"
                    data-click-to-select="false" data-single-select="false">
                    <thead>
                        <tr>
                            <th data-field="state" data-checkbox="true"></th>
                            <th data-field="Id" data-sortable="true" data-visible="false" data-searchable="false">ID</th>
                            <th data-field="Item_No" data-sortable="true" data-formatter="itemNoFormatter" data-search-formatter="false" lang="lang_item_no">Item NO.</th>
                            <th data-field="Description" data-sortable="true" lang="lang_description">Description</th>
                        </tr>
                    </thead>
                </table>
            </div>

            <!--edit dialog-->
            <div id="itemMaintainDialog" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h1 class="modal-title" lang="lang_edit"></h1>
                        </div>
                        <div class="modal-body">
                            <table style="width: 100%">
                                <tr>
                                    <td lang="lang_item_no"></td>
                                    <td style="padding: 10px;">
                                        <input type="text" data-clear-btn="true" name="tbxItemNo" class="form-control"
                                            id="tbxItemNo" value="" required="required" />
                                    </td>
                                    <td><span style="color: red;">*</span></td>
                                </tr>
                                <tr>
                                    <td lang="lang_description"></td>
                                    <td style="padding: 10px;">

                                        <input type="text" data-clear-btn="true" name="tbxDescription" class="form-control"
                                            id="tbxDescription" value=""  />
                                    </td>
                                    <td></td>
                                </tr>
                            </table>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-danger" onclick="saveItemMaintain()" lang="lang_save">Save</button>
                            <button type="button" class="btn btn-primary" data-dismiss="modal" lang="lang_cancel">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery-2.2.3.min.js"></script>
        <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery.uriAnchor.js"></script>
        <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/cube.framework.js"></script>
        <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/jquery.slimscroll.min.js"></script>
        <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap.js"></script>
        <script src="http://o-a3b2.qgroup.corp.com/CubePortal/Scripts/bootstrap-table.js"></script>

        <script>
            /**
             * item no formatter
             */
            function itemNoFormatter(value, row) {
                return '<a onclick="updateItem(\'' + row.Id + '\')">' + value + '</a>';
            };
            
            var currentMaintainItemId = null;
            /**
             * open edit item dialog
             */
            var updateItem = function (itemId) {
                var allItemList = $("#gridItem").bootstrapTable('getData');
                $.each(allItemList, function(i, item) {
                    if(item.Id == itemId) {
                        $("#tbxItemNo").val(item.Item_No);
                        $("#tbxDescription").val(item.Description);
                        return false;
                    }
                });

                $("#itemMaintainDialog").modal('show');
                currentMaintainItemId = itemId;
            };

            /**
             * save item
             */
            var saveItemMaintain = function () {
                var itemNo = $("#tbxItemNo").val();
                var description = $("#tbxDescription").val();
                if (itemNo == "") {
                    $.dialog.showMessage({
                        "title": 'Error', 
                        "content": 'Item No can not be null'
                    });
                    return false;
                }

                
                var options = {
                    "success": function (d) {
                        $("#itemMaintainDialog").modal('hide');
                        $.dialog.showMessage({
                            "title": 'Success',
                            "content": 'Update success'
                        });
                        inquiryItem();
                    }
                };

                var mydata = {
                    'id': currentMaintainItemId,
                    'itemNo': itemNo,
                    'description': description
                };

                $.callWebService("SaveItem", mydata, options);
                return true;
            }

            /**
             * inquiry item
             */
            function inquiryItem() {
                var options = {
                    "success": function (d) {
                        $("#gridItem").bootstrapTable("load", d);
                    }
                };

                var itemNo = $('#tbxItemNoInquiry').val();
                $.callWebService("Inquiry", { 'itemNo': itemNo }, options);
                return true;
            }

            var _CurrentItemId = null;
            var deleteItem = function () {
                _CurrentItemId = 5;
                var confirmData = {
                    "title": "confir delete",
                    "content": "confirm to delete?",
                    "okfuncname": "doDeleteItem",
                    //"okfunc": function () {
                    //    alert();
                    //}
                };
                $.dialog.showConfirm(confirmData);
                return false;
            };

            var doDeleteItem = function () {
                $.dialog.showLoading();
                $.dialog.showMessage({
                    "title": "got",
                    "content": "delete current item: " + _CurrentItemId
                });
                setInterval(function () {
                    $.dialog.closeLoading();
                }, 50000);
            };

        </script>
    </form>
</body>
</html>
