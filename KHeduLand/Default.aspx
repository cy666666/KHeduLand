<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="KHeduLand._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="dropdownlistbutton" style="height: 226px">
        
        行政區域<br />
&nbsp;&nbsp;
        
        <asp:DropDownList ID="DropDownList1" runat="server" Height="24px" Width="104px">
        </asp:DropDownList>
        
    </div>

</asp:Content>
