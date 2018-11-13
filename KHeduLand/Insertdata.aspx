<%@ Page Title="新增資料" Language="C#" MasterPageFile="~/Site.Master"  AutoEventWireup="true" CodeBehind="Insertdata.aspx.cs" Inherits="KHeduLand.Insertdata" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
            <h2><%: Title %></h2>
    
            <h4>
                <asp:Label ID="lb_regionid" runat="server" Text="行政區域 : "></asp:Label>
                <asp:DropDownList ID="ddl_regionid" runat="server" DataSourceID="SqlDataSource1" DataTextField="region_name" DataValueField="region_id" height="35px" width="117px">
                </asp:DropDownList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLDB %>" SelectCommand="SELECT * FROM [tb_REGION]"></asp:SqlDataSource>
            </h4>
            <h4>
                <asp:Label ID="lb_landname" runat="server" Text="校地編號 : "></asp:Label>
                <asp:TextBox ID="tbx_landname" runat="server" AutoCompleteType="Cellular" ></asp:TextBox>
                <asp:Label ID="Label1" runat="server" ForeColor="Red"></asp:Label>
            </h4>
            <h4>
                <asp:Label ID="lb_locationstreet" runat="server" Text="街道位置 : "></asp:Label>
                <asp:TextBox ID="tbx_locationstreet" runat="server"></asp:TextBox>
            </h4>
            <h4>
                <asp:Label ID="lb_authority" runat="server" Text="代管單位 : "></asp:Label>
                <asp:TextBox ID="tbx_authority" runat="server"></asp:TextBox>
            </h4>
            <h4>
                <asp:Label ID="lb_area" runat="server" Text="總面積 : "></asp:Label>
                <asp:TextBox ID="tbx_area" runat="server"></asp:TextBox>
            </h4>
            <h4>
                <asp:Label ID="lb_landownership" runat="server" Text="土地權屬 : "></asp:Label>
                <asp:TextBox ID="tbx_landownership" runat="server"></asp:TextBox>
            </h4>
            <h4>
                <asp:Label ID="lb_landvalue" runat="server" Text="公告現值 : "></asp:Label>
                <asp:TextBox ID="tbx_landvalue" runat="server"></asp:TextBox>
            </h4>
            <h4>
                <asp:Label ID="lb_neighbor_east" runat="server" Text="鄰近都市計畫使用分區（東） : "></asp:Label>
                <asp:TextBox ID="tbx_neighbor_east" runat="server"></asp:TextBox>
            </h4>  
            <h4>
                <asp:Label ID="lb_neighbor_south" runat="server" Text="鄰近都市計畫使用分區（南） : "></asp:Label>
                <asp:TextBox ID="tbx_neighbor_south" runat="server"></asp:TextBox>
            </h4>
            <h4>
                <asp:Label ID="lb_neighbor_west" runat="server" Text="鄰近都市計畫使用分區（西） : "></asp:Label>
                <asp:TextBox ID="tbx_neighbor_west" runat="server"></asp:TextBox>
            </h4>      
            <h4>
                <asp:Label ID="lb_neighbor_north" runat="server" Text="鄰近都市計畫使用分區（北） : "></asp:Label>
                <asp:TextBox ID="tbx_neighbor_north" runat="server"></asp:TextBox>
            </h4> 
            <h4>
                <asp:Label ID="lb_getway" runat="server" Text="取得方式 : "></asp:Label>
                <asp:TextBox ID="tbx_getway" runat="server"></asp:TextBox>
            </h4>       
            <h4>
                <asp:Label ID="lb_useperoid" runat="server" Text="徵收計畫使用期程 : "></asp:Label>
                <asp:TextBox ID="tbx_useperoid" runat="server"></asp:TextBox>
            </h4>   
            <h4>
                <asp:Label ID="lb_situation" runat="server" Text="現況 : "></asp:Label>
                <asp:TextBox ID="tbx_situation" runat="server" TextMode="MultiLine"></asp:TextBox>
            </h4>    
            <h4>
                <asp:Label ID="lb_review" runat="server" Text="重新檢討及後續處理情形 : "></asp:Label>
                <asp:TextBox ID="tbx_review" runat="server" TextMode="MultiLine"></asp:TextBox>
            </h4>  
            <h4>
                <asp:Label ID="lb_maintain" runat="server" Text="維護管理措施 : "></asp:Label>
                <asp:TextBox ID="tbx_maintain" runat="server" TextMode="MultiLine"></asp:TextBox>
            </h4>        
            <h4>
                <asp:Label ID="lb_other" runat="server" Text="其他 : "></asp:Label>
                <asp:TextBox ID="tbx_other" runat="server" TextMode="MultiLine"></asp:TextBox>
            </h4>                                 
            <p>
                &nbsp;</p>
            <p>
                <asp:Button ID="btn_insertland" runat="server" OnClick="btn_insertland_Click" Text="確認" />
                <asp:Label ID="lb_insertcheck" runat="server" Text="Label"></asp:Label>
            
            </p>
                <asp:SqlDataSource ID="SqlDataSource2" runat="server"  ConnectionString="<%$ ConnectionStrings:SQLDB %>" DeleteCommand="DELETE FROM tb_LAND WHERE (land_id = @land_id)" InsertCommand="INSERT INTO tb_LAND(region_id, land_name, location_street, authority, area, land_ownership, land_value, neighbor_east, neighbor_south, neighbor_west, neighbor_north, getway, use_period, situation, review, maintain, other) VALUES (@region_id, @land_name, @location_street, @authority, @area, @land_ownership, @land_value, @neighbor_east, @neighbor_south, @neighbor_west, @neighbor_north, @getway, @use_period, @situation, @review, @maintain, @other)" SelectCommand="SELECT tb_LAND.land_id, tb_REGION.region_name, tb_LAND.land_name, tb_LAND.location_street, tb_LAND.authority, tb_LAND.area, tb_LAND.land_ownership, tb_LAND.land_value, tb_LAND.neighbor_east, tb_LAND.neighbor_south, tb_LAND.neighbor_west, tb_LAND.neighbor_north, tb_LAND.getway, tb_LAND.use_period, tb_LAND.situation, tb_LAND.review, tb_LAND.maintain, tb_LAND.other, tb_LAND.region_id FROM tb_LAND INNER JOIN tb_REGION ON tb_LAND.region_id = tb_REGION.region_id" UpdateCommand="UPDATE tb_LAND SET region_id = @region_id, land_name = @land_name, location_street = @location_street, authority = @authority, area = @area, land_ownership = @land_ownership, land_value = @land_value, neighbor_east = @neighbor_east, neighbor_south = @neighbor_south, neighbor_west = @neighbor_west, neighbor_north = @neighbor_north, getway = @getway, use_period = @use_period, situation = @situation, review = @review, maintain = @maintain, other = @other FROM tb_LAND INNER JOIN tb_REGION ON tb_LAND.region_id = tb_REGION.region_id">
                    <DeleteParameters>
                        <asp:Parameter Name="land_id" />
                    </DeleteParameters>
                    <InsertParameters>
                        <asp:Parameter Name="region_id" Type="Int32"/>
                        <asp:Parameter Name="land_name" Type="String"/>
                        <asp:Parameter Name="location_street" Type="String"/>
                        <asp:Parameter Name="authority" Type="String"/>
                        <asp:Parameter Name="area" Type="Int32"/>
                        <asp:Parameter Name="land_ownership" Type="String"/>
                        <asp:Parameter Name="land_value" Type="String"/>
                        <asp:Parameter Name="neighbor_east" Type="String"/>
                        <asp:Parameter Name="neighbor_south" Type="String"/>
                        <asp:Parameter Name="neighbor_west" Type="String"/>
                        <asp:Parameter Name="neighbor_north" Type="String"/>
                        <asp:Parameter Name="getway" Type="String"/>
                        <asp:Parameter Name="use_period" Type="String"/>
                        <asp:Parameter Name="situation" Type="String"/>
                        <asp:Parameter Name="review" Type="String"/>
                        <asp:Parameter Name="maintain" Type="String"/>
                        <asp:Parameter Name="other" Type="String"/>
                    </InsertParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="region_id" Type="Int32"/>
                        <asp:Parameter Name="land_name" Type="String"/>
                        <asp:Parameter Name="location_street" Type="String"/>
                        <asp:Parameter Name="authority" Type="String"/>
                        <asp:Parameter Name="area" Type="Int32"/>
                        <asp:Parameter Name="land_ownership" Type="String"/>
                        <asp:Parameter Name="land_value" Type="String"/>
                        <asp:Parameter Name="neighbor_east" Type="String"/>
                        <asp:Parameter Name="neighbor_south" Type="String"/>
                        <asp:Parameter Name="neighbor_west" Type="String"/>
                        <asp:Parameter Name="neighbor_north" Type="String"/>
                        <asp:Parameter Name="getway" Type="String"/>
                        <asp:Parameter Name="use_period" Type="String"/>
                        <asp:Parameter Name="situation" Type="String"/>
                        <asp:Parameter Name="review" Type="String"/>
                        <asp:Parameter Name="maintain" Type="String"/>
                        <asp:Parameter Name="other" Type="String"/>
                    </UpdateParameters>
                </asp:SqlDataSource>
            <p>
                <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource2">
                    <Columns>
                        <asp:CommandField ShowEditButton="True" />
                        <asp:TemplateField HeaderText="新增" ShowHeader="False">
                            <EditItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="更新"></asp:LinkButton>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="新增"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <asp:DetailsView ID="DetailsView1" runat="server" DataSourceID="SqlDataSource2" DefaultMode="Insert" Height="50px" Width="125px">
                        </asp:DetailsView>
                    </EmptyDataTemplate>
                </asp:GridView>
            </p>
            <br />
                <br />
            </asp:Content>
