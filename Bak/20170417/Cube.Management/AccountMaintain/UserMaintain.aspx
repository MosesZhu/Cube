<%@ Page Title="" Language="C#" MasterPageFile="~/Master.Master" AutoEventWireup="true" CodeBehind="UserMaintain.aspx.cs" Inherits="Cube.Management.AccountMaintain.UserMaintain" %>

<asp:Content ID="PageStyleContent" ContentPlaceHolderID="PageStyleContentHolder" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContentHolder" runat="server">
    <!--inquiry area & toolbar-->
    <div class="row">
        <div class="col-lg-6 col-xs-6">
            <table class="col-lg-12 col-xs-12">
                <tr>
                    <td lang="lang_login_id">Login ID</td>
                    <td class="text-bold" style="padding: 10px;">
                        <input type="text" data-clear-btn="true" name="tbxLoginNameInquiry" class="form-control"
                            id="tbxLoginNameInquiry" value="" />
                    </td>
                </tr>
                <tr>
                    <td lang="lang_name">Name</td>
                    <td class="text-bold" style="padding: 10px;">
                        <input type="text" data-clear-btn="true" name="tbxNameInquiry" class="form-control"
                            id="tbxNameInquiry" value="" />
                    </td>
                </tr>
            </table>
        </div>

        <div class="col-lg-6 col-xs-6">
            <div class="btn-toolbar" role="toolbar" style="float: right;">
                <button type="button" class="btn btn-primary" onclick="return inquiryUser();" lang="lang_inquiry">
                    Inquiry
                </button>
            </div>
        </div>
    </div>

    <!--inquiry result grid-->
    <div class="row" style="padding: 15px;">
        <table id="gridUser" class="bootstrapTable" data-toggle="table" data-sort-name="item_no" data-toolbar="#toolbar"
            data-url="" data-height="398" data-pagination="true"
            data-show-refresh="true" data-row-style="rowStyle" data-search="false"
            data-show-toggle="true" data-sortable="true"
            data-striped="true" data-page-size="10" data-page-list="[5,10,20]"
            data-click-to-select="false" data-single-select="false">
            <thead>
                <tr>
                    <th data-field="state" data-checkbox="true"></th>
                    <th data-field="Id" data-sortable="true" data-visible="false" data-searchable="false">ID</th>
                    <th data-field="Login_Name" data-width="200" data-sortable="true" data-formatter="loginNameFormatter" data-search-formatter="false" lang="lang_login_id">Login ID.</th>
                    <th data-field="Name" data-width="200" data-sortable="true" lang="lang_name">Name</th>
                    <th data-field="Mail" data-sortable="true" lang="lang_mail">Mail</th>
                    <th data-field="Id" data-width="80" data-sortable="false" data-formatter="editColumnFormatter" data-search-formatter="false" lang="lang_edit">Edit</th>
                </tr>
            </thead>
        </table>
    </div>

    <!--edit dialog-->
    <div id="userBaseMaintainDialog" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h1 class="modal-title" lang="lang_edit"></h1>
                </div>
                <div class="modal-body">
                    <table style="width: 100%">
                        <tr>
                            <td lang="lang_login_id"></td>
                            <td style="padding: 10px;">
                                <input type="text" data-clear-btn="true" name="tbxLoginName" class="form-control"
                                    id="tbxLoginName" value="" required="required" />
                            </td>
                            <td><span style="color: red;">*</span></td>
                        </tr>
                        <tr>
                            <td lang="lang_name"></td>
                            <td style="padding: 10px;">
                                <input type="text" data-clear-btn="true" name="tbxName" class="form-control"
                                    id="tbxName" value="" required="required" />
                            </td>
                            <td><span style="color: red;">*</span></td>
                        </tr>
                        <tr>
                            <td lang="lang_mail"></td>
                            <td style="padding: 10px;">

                                <input type="text" data-clear-btn="true" name="tbxMail" class="form-control"
                                    id="tbxMail" value="" />
                            </td>
                            <td></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" onclick="saveUserBaseMaintain()" lang="lang_save">Save</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" lang="lang_cancel">Cancel</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="PageScriptContent" ContentPlaceHolderID="PageScriptContentHolder" runat="server">
    <script>
        /**
         * login id formatter
         */
        var loginNameFormatter = function (value, row) {
            return '<a style="cursor:pointer;" onclick="updateUser(\'' + row.Id + '\')">' + value + '</a>';
        };

        /**
         * edit column formatter
         */
        var editColumnFormatter = function (value, row) {
            return '<a style="cursor:pointer;" onclick="userDetailMaintain(\'' + row.Id + '\')" lang="lang_edit">' + _CurrentLang['lang_edit'] + '</a>';
        };

        var currentMaintainUserId = null;
        /**
         * open edit user dialog
         */
        var updateUser = function (userId) {
            var allUserList = $("#gridUser").bootstrapTable('getData');
            $.each(allUserList, function (i, user) {
                if (user.Id == userId) {
                    $("#tbxLoginName").val(user.Login_Name);
                    $("#tbxName").val(user.Name);
                    $("#tbxMail").val(user.Mail);
                    return false;
                }
            });

            //$.dialog.showDialog("userBaseMaintainDialog");
            $.dialog.showDialogOnTop("userBaseMaintainDialog");
            currentMaintainUserId = userId;
        };

        /**
         * save user
         */
        var saveUserBaseMaintain = function () {
            var loginName = $("#tbxLoginName").val();
            var name = $("#tbxName").val();
            var mail = $("#tbxMail").val();
            if (loginName == "") {
                $.dialog.showMessage(_CurrentLang['lang_error'], _CurrentLang['msg_login_name_can_not_empty']);
                return false;
            }
            if (name == "") {
                $.dialog.showMessage(_CurrentLang['lang_error'], _CurrentLang['msg_name_can_not_empty']);
                return false;
            }

            var options = {
                "success": function (d) {
                    $.dialog.closeDialog("userBaseMaintainDialog");
                    $.dialog.showMessage(_CurrentLang['lang_success'], _CurrentLang['msg_save_success']);
                    inquiryUser();
                }
            };

            var data = {
                'id': currentMaintainUserId,
                'loginName': loginName,
                'name': name,
                'mail': mail
            };

            $.ask("Update", data, options);
            return true;
        }

        /**
         * inquiry user
         */
        var inquiryUser = function () {
            var options = {
                "success": function (d) {
                    $("#gridUser").bootstrapTable("load", d);
                }
            };

            var itemNo = $('#tbxItemNoInquiry').val();
            var data = {
                'login_name': $('#tbxLoginNameInquiry').val(),
                'name': $('#tbxNameInquiry').val()
            };
            $.ask("Inquiry", data, options);
            return true;
        };

        $(function () {
            inquiryUser();
        });

        var userDetailMaintain = function (userId) {
            $.goto("UserDetailMaintain.aspx?id=" + userId, true);
        }

    </script>
</asp:Content>
