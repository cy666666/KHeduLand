<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="KHeduLand._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="dropdownlistbutton" style="height: 436px">
        
        行政區域<br />
&nbsp;&nbsp;
        
        <asp:DropDownList ID="DropDownList1" runat="server" Height="24px" Width="104px" DataSourceID="SqlDataSource2" DataTextField="region_name" DataValueField="region_id" AppendDataBoundItems="true" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
            <asp:ListItem Selected="True" Value="all">所有區域</asp:ListItem>
        </asp:DropDownList>
        
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:SQLDB %>" SelectCommand="SELECT [region_name], [region_id] FROM [tb_REGION] ORDER BY [region_id]"></asp:SqlDataSource>
        
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" AllowPaging="True" AllowSorting="True" DataKeyNames="land_id" DataSourceID="SqlDataSource3" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" Width="625px">
            <Columns>
                <asp:BoundField DataField="land_id" HeaderText="land_id" InsertVisible="False" ReadOnly="True" SortExpression="land_id" />
                <asp:BoundField DataField="region_name" HeaderText="行政區域" SortExpression="region_name" />
                <asp:BoundField DataField="land_name" HeaderText="land_name" SortExpression="land_name" />
                <asp:BoundField DataField="area" HeaderText="面積(單位:公頃)" SortExpression="area" />
                <asp:HyperLinkField HeaderText="詳細資料" NavigateUrl="Detail.aspx" DataNavigateUrlFields="land_id,region_name,land_name" Text="詳細資料" DataNavigateUrlFormatString="Detail.aspx?land_id={0}&region_name={1}&land_name={2}" Target="_blank"/>
            </Columns>
        </asp:GridView>
        <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:SQLDB %>" SelectCommand="SELECT land_id,region_name,land_name,area FROM tb_LAND,tb_REGION WHERE tb_LAND.region_id = tb_REGION.region_id "></asp:SqlDataSource>
        
    </div>

</asp:Content>
