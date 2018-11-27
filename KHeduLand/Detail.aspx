<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Detail.aspx.cs" Inherits="KHeduLand.Detail" %>


<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:TextBox ID="TextBox1" runat="server" ></asp:TextBox>
    <h4>
        <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataSourceID="SqlDataSource1" Height="50px" Width="125px" Font-Names="標楷體">
            <FieldHeaderStyle Wrap="False" />
            <Fields>
                <asp:BoundField DataField="region_name" HeaderText="region_name" SortExpression="region_name" >
                </asp:BoundField>
                <asp:BoundField DataField="land_name" HeaderText="land_name" SortExpression="land_name" />
                <asp:BoundField DataField="location_street" HeaderText="location_street" SortExpression="location_street" />
                <asp:BoundField DataField="authority" HeaderText="authority" SortExpression="authority" />
                <asp:BoundField DataField="area" HeaderText="area" SortExpression="area" />
                <asp:BoundField DataField="land_ownership" HeaderText="land_ownership" SortExpression="land_ownership" />
                <asp:BoundField DataField="land_value" HeaderText="land_value" SortExpression="land_value" />
                <asp:BoundField DataField="neighbor_east" HeaderText="neighbor_east" SortExpression="neighbor_east" />
                <asp:BoundField DataField="neighbor_south" HeaderText="neighbor_south" SortExpression="neighbor_south" />
                <asp:BoundField DataField="neighbor_west" HeaderText="neighbor_west" SortExpression="neighbor_west" />
                <asp:BoundField DataField="neighbor_north" HeaderText="neighbor_north" SortExpression="neighbor_north" />
                <asp:BoundField DataField="getway" HeaderText="getway" SortExpression="getway" />
                <asp:BoundField DataField="use_period" HeaderText="use_period" SortExpression="use_period" />
                <asp:BoundField DataField="situation" HeaderText="situation" SortExpression="situation" />
                <asp:BoundField DataField="review" HeaderText="review" SortExpression="review" />
                <asp:BoundField DataField="maintain" HeaderText="maintain" SortExpression="maintain" />
                <asp:BoundField DataField="other" HeaderText="other" SortExpression="other" />
                <asp:BoundField DataField="coordinate_x" HeaderText="coordinate_x" SortExpression="coordinate_x" />
                <asp:BoundField DataField="coordinate_y" HeaderText="coordinate_y" SortExpression="coordinate_y" />
            </Fields>
            <RowStyle Wrap="False" />
        </asp:DetailsView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:SQLDB %>" SelectCommand="SELECT tb_REGION.region_name, tb_LAND.land_name, tb_LAND.location_street, tb_LAND.authority, tb_LAND.area, tb_LAND.land_ownership, tb_LAND.land_value, tb_LAND.neighbor_east, tb_LAND.neighbor_south, tb_LAND.neighbor_west, tb_LAND.neighbor_north, tb_LAND.getway, tb_LAND.use_period, tb_LAND.situation, tb_LAND.review, tb_LAND.maintain, tb_LAND.other, tb_LAND.coordinate_x, tb_LAND.coordinate_y FROM tb_LAND INNER JOIN tb_REGION ON tb_LAND.region_id = tb_REGION.region_id WHERE (tb_LAND.land_id = @land_id)">
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
            pMap.setCenter(new TGOS.TGPoint(<%=DetailsView1.Rows[17].Cells[1].Text %>, <%=DetailsView1.Rows[18].Cells[1].Text %>));
            pMap.setZoom(11);

            var infoWindowOptions = { maxWidth: 800, pixelOffset: { x: 0, y:0 }};
            var info = {
                /*
                attrFields: [
                    { name: "ADDRESS", alias: "地址" },
                    { name: "MARKNAME1", alias: "名稱" }
                ] // 點選 (click) 時, 顯示的欄位, 若未指定則會全部顯示.
                */
            };
            var opts = {
                queryable: true,//查詢開關
                visible: true, //圖層開關
                opacity: 1.0,
                infoWindowOptions: infoWindowOptions, // 點選 (click) 時, 顯示的 InfoWindow 設定值
                /*pointSymbol: {
                    field1: "MARKTYPE",
	                field2: "MARKNAME1",
                    symbols: {
                        "99630"  : university,
                        "99631"  : university,
                        "99614"  : university,
                        "99611"  : university,
                        "99613A" : university,
                        "99640"  : university,
                        "99311"  : university
                    }
                }*/
            };
            VectorTiledLayer = new TGOS.TGVectorTilePoiLayer("Vector Tile Layer", pMap, info, opts);  //建立地標圖層物件
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
            if (kmlLayer) {
                kmlLayer.removeKml();							//假如圖面上已經有KML疊加層, 則先移除掉現有的kml圖層再加入新圖層
            }
            var list = document.getElementById("urlList");
            var url = list.options[list.selectedIndex].value;	//取得下拉選單的KML網址
            kmlLayer = new TGOS.TGKmlLayer(url, {				//設定KML圖層
                map: pMap,									//設定欲疊加的底圖
                suppressInfoWindows: false,				//可點選KML圖徵顯示訊息視窗, 若設為true則無法顯示訊息視窗
                preserveViewport: false						//疊加KML後將圖面縮放至KML的範圍, 若設為false則取消這個功能
            });
        }
        function setCenter() {
            var CenterX = Number(document.getElementById("<%=DetailsView1.Rows[17].Cells[1].Text %>").value);
            var CenterY = Number(document.getElementById("<%=DetailsView1.Rows[18].Cells[1].Text %>").value);
            pMap.setCenter(new TGOS.TGPoint(CenterX, CenterY)); //移至此地圖坐標
        }
         function removeKML(){
             if(kmlLayer){
                 kmlLayer.removeKml();
             }
         }
         </script>

         <script type="text/javascript">             //查詢學校
            var markers = new Array();		//建立空陣列, 作為載入標記點物件的容器使用
            var Query = new TGOS.TGAttriQuery();	//建立屬性查詢物件, 準備執行屬性查詢時使用
            var strs = "";		//建立一個空字串備用
            function search() {
             var txtBox = document.getElementById("result");	//取得網頁上的空白DIV, 作為顯示查詢結果用的區塊
             txtBox.innerHTML = "";	//每次查詢都先清空DIV的內容
             strs = "";				//重設空白字串
	
             if (markers.length > 0) {		//假設地圖上已存在查詢後得到的標記點, 則先行移除
                 for (var i = 0; i < markers.length; i++) {
                     markers[i].setMap(null);
                 }
                 markers = [];		
             }
             var KH = "高雄市";	//取得使用者輸入的縣市名稱
             var TN = document.getElementById("TownName").value;	//取得使用者輸入的鄉鎮市區名稱
             var KW = document.getElementById("Keyword").value;		//取得使用者輸入的關鍵字
             var queryRequst = {		//設定屬性查詢參數
                 county: KH,
                 town: TN,
                 keyword: KW
             };
             Query.identify(TGOS.TGMapServiceId.SCHOOL, TGOS.TGMapId.SCHOOL, queryRequst, TGOS.TGCoordSys.EPSG3826, function(result, status){
                 //使用方法identify進行屬性查詢, 輸入參數包含欲查詢的服務、欲查詢的圖層、查詢參數、坐標系統及查詢後的函式, result及status分別代表查詢結果及查詢狀態
                 if (status == TGOS.TGQueryStatus.ZERO_RESULTS) {	//判斷查詢結果是否為查無結果
                     txtBox.innerHTML = '查無結果';
                     return;
                 } else {		//若查詢產生結果, 則執行以下函式
                     var attris = result.fieldAttr;	//取得圖徵屬性
                     for (i = 0; i < attris.length; i++) {
                         //使用迴圈將符合查詢條件的結果全部取出
                         var str = 'ID: ' + attris[i][1] + '; Name: ' + attris[i][2] + '; Address: ' + attris[i][5] + " " +
                             '<input type="button" value="定位" onclick="locate(' + attris[i][12] + ',' + attris[i][13] + ');">' + '<br>';
                         //將結果圖徵的部份屬性取出, 組合成一個html語法的字串, 另外每條結果後方全部都加上一顆按鈕,
                         //按下後執行function locate(), 並將坐標資訊傳到locate()使用.
				
                         strs += str;	//將每次迴圈的字串結果加在一起
				
                         var tip = attris[i][1];	//取出查詢結果的各個圖徵名稱, 準備作為標記點的顯示文字
                         var marker = new TGOS.TGMarker(pMap, new TGOS.TGPoint(attris[i][13], attris[i][14]), tip);	//將查詢結果作成標記點顯示在圖面上
                         markers.push(marker);	//將所有標記點加入陣列markers
                     }
                 }
                 txtBox.innerHTML = strs;	//將查詢後的文字結果寫入到空白DIV內
             });
         }
         function locate(x, y)	{						//定位按鈕執行的函式
             pMap.setZoom(12);							//將地圖縮放至最後一個層級
             pMap.setCenter(new TGOS.TGPoint(x, y));	//取得傳入的坐標, 並將地圖中心移至該坐標位置
         }
        </script>
         
        <script type="text/javascript">
            function initialize() {
                var mapOptions = {
                    zoom: 8,
                    center: new google.maps.LatLng(-34.397, 150.644)
                };

                var gmap = new google.maps.Map(document.getElementById('GGMap'),mapOptions);
            }
        </script>
         <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCKm4JTJlHZYc4NY57nGsCkVeHnH_v57Cs&callback=initialize"async defer type="text/javascript"></script>
    <script type="text/javascript">
        document.body.onload = function () { InitWnd(); }
    </script>
        <div id="TGMap" style="width: 640px; height: 480px; border: 1px solid #C0C0C0; ">
        </div>
        <div id="GGMap" style="width:500px; height:500px;"></div>

        <div id="legend">
        

         </div>
    
    	<div>
        <select id="TownName">
		<script>
		    var myArray = new Array("三民區","大社區","小港區","仁武區","左營區","前鎮區","鳥松區","湖內區","楠梓區","路竹區","鼓山區","旗津區","鳳山區","橋頭區","燕巢區","大寮區","大樹區","林園區","茄萣區","旗山區","彌陀區");
        for(i=0; i<myArray.length; i++) {  
            document.write('<option value="' + myArray[i] +'">' + myArray[i] + '</option>');
        }
        </script>
	    </select>		
		關鍵字: <input type="text" id="Keyword" value="" size=18/>
		<input type="button" value="學校查詢" onclick="search();"/>
	    </div>
        <div id="result" style="width:640px; height:150px; border: 1px solid #C0C0C0; overflow-y:auto"></div>

      
        <div>
        <select id="urlList">
		<option value="https://sites.google.com/site/khurbankml/01-高雄市都市計畫主要計畫範圍圖.kml">1.高雄市都市計畫主要計畫範圍圖</option>
		<option value="https://sites.google.com/site/khurbankml/02-高雄市都市計畫細部計畫範圍圖.kml">2.高雄市都市計畫細部計畫範圍圖</option>
	    </select>  
        <input type="button" value="加入圖層" onclick="AddKML();">
        <input type="button" value="清空圖層" onclick="removeKML();">
         </div>

         <div>
         X<input type="text" id="CenterX" value="<%=DetailsView1.Rows[17].Cells[1].Text %>" size="7" />
         Y<input type="text" id="CenterY" value="<%=DetailsView1.Rows[18].Cells[1].Text %>" size="7" />
         <button onclick="setCenter();">移至此地圖坐標</button>
         </div>
         <br />
    </div>

</asp:Content>

