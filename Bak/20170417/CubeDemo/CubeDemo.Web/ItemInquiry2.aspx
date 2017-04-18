<%@ Page Title="" Language="C#" MasterPageFile="~/CubeDemo.Master" AutoEventWireup="true" CodeBehind="ItemInquiry2.aspx.cs" Inherits="CubeDemo.Web.ItemInquiry2" %>
<asp:Content ID="PageStyleContent" ContentPlaceHolderID="PageStyleContentHolder" runat="server">
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="MainContentHolder" runat="server">
    <div class="row">
        <div class="col-lg-6 col-xs-6">
            <table>
                <tr>
                    <td>Item NO.</td>
                    <td class="text-bold" style="padding: 10px;">
                        <input type="text" data-clear-btn="true" name="tbxItemNoInquiry" class="form-control"
                                       id="tbxItemNoInquiry" value="" />
                    </td>
                </tr>
            </table>
        </div>
        
        <div class="col-lg-6 col-xs-6" >
            <div class="btn-toolbar" role="toolbar" style="float: right;">
                <button type="button" class="btn btn-primary" onclick="return inquiryItem();" lang="lang_inquiry">
                    Inquiry
                </button>
            </div>
        </div>
    </div>

    <div class="row" style="padding:15px;">
        <table id="gridItem" class="bootstrapTable" data-toggle="table" data-sort-name="item_no" data-toolbar="#toolbar"
               data-url="" data-height="398" data-pagination="true"
               data-show-refresh="true" data-row-style="rowStyle" data-search="false"
               data-show-toggle="true"  data-sortable="true"
               data-striped="true" data-page-size="10" data-page-list="[5,10,20]"
               data-click-to-select="false" data-single-select="false">
            <thead>
            <tr>
                <th data-field="state" data-checkbox="true"></th>
                <th data-field="Id" data-sortable="true" data-visible="false" data-searchable="false">ID</th>
                <th data-field="Item_No" data-sortable="true" data-formatter="itemNoFormatter" data-search-formatter="false" lang="lang_item_no">Item NO.</th>
                <th data-field="Description" data-sortable="true" lang="lang_description">Description</th>
                <th data-field="item_type" data-sortable="true">Item Type</th>
            </tr>
            </thead>
        </table>
    </div>

    <div id="ItemMaintainDialog" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h1 class="modal-title" id="roleDetailMaintainDialogTitle"></h1>
                </div>
                <div class="modal-body">
                    <table style="width: 100%">
                        <tr>
                            <td>{{trans("messages.USER_COMPANY")}}:</td>
                            <td style="padding: 10px;">
                                <select placeholder="Company" name="ddlCompany" id="ddlCompany" class="form-control">
                                    @foreach($allCompanyList as $company)
                                        <option value="{{$company->company}}">{{$company->company}}</option>
                                    @endforeach
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>{{trans("messages.ROLE_NAME")}}:</td>
                            <td style="padding: 10px;">

                                <input type="text" data-clear-btn="true" name="tbxRoleName" class="form-control"
                                       id="tbxRoleName" value="" required="required"/>
                            </td>
                            <td><span style="color: red;">*</span></td>
                        </tr>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button"  class="btn btn-danger" onclick="SaveRoleMaintain()">{{trans("messages.SAVE")}}</button>
                    <button type="button"  class="btn btn-primary" data-dismiss="modal">{{trans("messages.CLOSE")}}</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="PageScriptContentHolder" ContentPlaceHolderID="PageScriptContentHolder" runat="server">
    <script>
        function itemNoFormatter(value, row) {
            return '<a href="#" onclick="updateItem(' + row.Id + ')">' + value + '</a>';
        };

        function updateItem() {
            //$("#roleDetailMaintainDialogTitle").text("{{trans("messages.MSG_EDIT_ROLE")}}");
            //$("#roleDetailMaintainDialog").modal('show');
        }

        function inquiryItem() {
            var options = {
                "success": function (d) {
                    $("#gridItem").bootstrapTable("load", d);
                }
            };

            var itemNo = $('#tbxItemNoInquiry').val();
            $.ask("Inquiry", {'itemNo':itemNo}, options);
            return true;
        }
        
    </script>
    
</asp:Content>
