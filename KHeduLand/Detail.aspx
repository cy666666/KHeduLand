<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detail.aspx.cs" Inherits="KHeduLand.Detail" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:TextBox ID="TextBox1" runat="server" ></asp:TextBox>
    <h4>
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="SqlDataSource1" Height="50px" Width="125px" Font-Names="標楷體">
            <FieldHeaderStyle Wrap="False" />
            <Fields>
                <asp:BoundField DataField="region_name" HeaderText="區域" SortExpression="region_name" >
                <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="land_name" HeaderText="校地編號" SortExpression="land_name" />
                <asp:BoundField DataField="location_street" HeaderText="位置" SortExpression="location_street" />
                <asp:BoundField DataField="authority" HeaderText="代管單位" SortExpression="authority" />
                <asp:BoundField DataField="area" HeaderText="總面積" SortExpression="area" />
                <asp:BoundField DataField="land_ownership" HeaderText="土地權屬" SortExpression="land_ownership" />
                <asp:BoundField DataField="land_value" HeaderText="公告現值" SortExpression="land_value" />
                <asp:BoundField DataField="neighbor_east" HeaderText="鄰近都市計畫使用分區(東)" SortExpression="neighbor_east" />
                <asp:BoundField DataField="neighbor_west" HeaderText="鄰近都市計畫使用分區(西)" SortExpression="neighbor_west" />
                <asp:BoundField DataField="neighbor_south" HeaderText="鄰近都市計畫使用分區(南)" SortExpression="neighbor_south" />
                <asp:BoundField DataField="neighbor_north" HeaderText="鄰近都市計畫使用分區(北)" SortExpression="neighbor_north" />
                <asp:BoundField DataField="getway" HeaderText="取得方式" SortExpression="getway" />
                <asp:BoundField DataField="use_period" HeaderText="徵收計畫使用期程" SortExpression="use_period" />
                <asp:BoundField DataField="situation" HeaderText="現況" SortExpression="situation" />
                <asp:BoundField DataField="review" HeaderText="重新檢討及後續處理情形" SortExpression="review" />
                <asp:BoundField DataField="maintain" HeaderText="維護管理措施" SortExpression="maintain" />
                <asp:BoundField DataField="other" HeaderText="其他" SortExpression="other" />
            </Fields>
            <RowStyle Wrap="False" />
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLDB %>" SelectCommand="SELECT tb_REGION.region_name, tb_LAND.land_name, tb_LAND.location_street, tb_LAND.authority, tb_LAND.area, tb_LAND.land_ownership, tb_LAND.land_value, tb_LAND.neighbor_east, tb_LAND.neighbor_south, tb_LAND.neighbor_west, tb_LAND.neighbor_north, tb_LAND.getway, tb_LAND.use_period, tb_LAND.situation, tb_LAND.review, tb_LAND.maintain, tb_LAND.other FROM tb_LAND INNER JOIN tb_REGION ON tb_LAND.region_id = tb_REGION.region_id WHERE (tb_LAND.land_id = @land_id)">
            <SelectParameters>
                <asp:QueryStringParameter Name="land_id" QueryStringField="land_id" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        </h4>
        
     <div id="tgosdv" runat="server">
     <script type="text/javascript" >
        var pMap=null;
        function InitWnd() {
            var pOMap = document.getElementById("TGMap");
            var mapOptions = {
                mapTypeControl: false	//mapTypeControl(關閉地圖類型控制項)
            };
            pMap = new TGOS.TGOnlineMap(pOMap, TGOS.TGCoordSys.EPSG3826); //宣告TGOnlineMap地圖物件並設定坐標系統
        }
        var TileLayer = null;
        var kmlLayer = null;

        var TileType;
        function AddTile() {
            if (TileLayer) {		//如圖面上已經存在主題圖磚圖層，則在切換新的圖磚之前先行移除舊主題圖磚
                TileLayer.removeTileOverlay(TileType);
            }
            var bounds = pMap.getBounds();			//取得目前地圖圖面邊界值
            TileLayer = new TGOS.TGTileOverlay();	//宣告主題圖磚物件
            var req = {								//設定主題圖磚需求參數
                scaleLevel: 0,						//地圖層級
                left: parseFloat(bounds.left),		//圖磚需求範圍邊界
                top: parseFloat(bounds.top),
                right: parseFloat(bounds.right),
                bottom: parseFloat(bounds.bottom),
                map: pMap,							//套疊目標地圖
                overlay: true						//是否套疊主題圖磚
            };

            if (document.getElementById("TileList").value == 1) {			//取得下拉選單的值
                TileType = TGOS.TGMapServiceId.CITYZONING;					//依照取得值來指定主題圖磚的種類
                document.getElementById("legend").innerHTML = "<img src='https://api.tgos.tw/TGOS_API/ThemeLegend/CITYZONING.jpg' title='都市計畫圖'/>";
            } else if (document.getElementById("TileList").value == 2) {
                TileType = TGOS.TGMapServiceId.SCHOOL;
                document.getElementById("legend").innerHTML = "<img src='https://api.tgos.tw/TGOS_API/ThemeLegend/SCHOOL.jpg' title='學校'/>";
            } else if (document.getElementById("TileList").value == 3) {
                TileType = TGOS.TGMapServiceId.LANDUSE;
                document.getElementById("legend").innerHTML = "<img src='https://api.tgos.tw/TGOS_API/ThemeLegend/LANDUSE.png' title='國土利用調查'/>";
            } else {
                TileType = TGOS.TGMapServiceId.TOPO1000;
                document.getElementById("legend").innerHTML = "";
            }
            TileLayer.getThemeTile(TileType, req, 0.7, function () { });		//取得主題圖磚進行套疊, 並設定透明度
        }
        function AddKML() {
            var kmlLayer = new TGOS.TGKmlLayer('https://sites.google.com/site/khurbankml/kh.kml', {
                map: pMap,
                suppressInfoWindows: false,
                preserveViewport: true
            }, function () {
                var meta = kmlLayer.getMetadata();
            });
        }
    </script>

    <script type="text/javascript">
        document.body.onload = function () { InitWnd(); }
    </script>

        <div id="TGMap" style="width: 640px; height: 480px; border: 1px solid #C0C0C0; ">
        </div>
        <br />
         <div id="legend"></div>

        <select id="TileList">
            <option value=1>都市計畫圖</option>
            <option value=2>學校</option>
            <option value=3>國土利用調查</option>
            <option value=4>一千分之一地形圖</option>
        </select>
        <input type="button" value="加入主題圖磚" onclick="AddTile();">

         
        <input type="button" value="高雄市都市計畫範圍" onclick="AddKML();">
    </div>

</asp:Content>

