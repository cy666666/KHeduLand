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
         var markers = [];		//建立空陣列, 作為載入標記點物件的容器使用
         var infowindow;
         var TileLayer = null;
         var kmlLayer = null;
         var BufferArea = null;
         var TileType;
         strs= "";
        function InitWnd() {
            var pOMap = document.getElementById("TGMap");
            var mapOptions = {
                mapTypeControl: false	//mapTypeControl(關閉地圖類型控制項)
            };
            pMap = new TGOS.TGOnlineMap(pOMap, TGOS.TGCoordSys.EPSG3826); //宣告TGOnlineMap地圖物件並設定坐標系統
            pMap.setCenter(new TGOS.TGPoint(<%=DetailsView1.Rows[17].Cells[1].Text %>, <%=DetailsView1.Rows[18].Cells[1].Text %>));
            pMap.setZoom(11);
            infowindow = new TGOS.TGInfoWindow();  
            buffer();
            var infoWindowOptions = { maxWidth: 800, pixelOffset: { x: 0, y:0 }};
            var info = {
                // 點選 (click) 時, 顯示的欄位, 若未指定則會全部顯示.
            };
            var opts = {
                queryable: false,//查詢開關
                visible: true, //圖層開關
                opacity: 1.0,
                infoWindowOptions: infoWindowOptions, 
                // 點選 (click) 時, 顯示的 InfoWindow 設定值
            };				

          //  VectorTiledLayer = new TGOS.TGVectorTilePoiLayer("Vector Tile Layer", pMap, info, opts);  //建立地標圖層物件
            
        }


        var Query = new TGOS.TGPointBuffer();	//建立TGPointBuffer物件, 準備執行環域查詢使用

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
         function locate(x, y)	{						//定位按鈕執行的函式
             pMap.setZoom(12);							//將地圖縮放至最後一個層級
             pMap.setCenter(new TGOS.TGPoint(x, y));	//取得傳入的坐標, 並將地圖中心移至該坐標位置
         }
         </script>
        
    <script type="text/javascript">
        function buffer() {
            
            TGOS.TGEvent.addListener(pMap, "click", function(tEvent) {	//建立滑鼠地圖點擊事件監聽器
                var txtBox = document.getElementById("result");	//取得網頁上的空白DIV, 作為顯示查詢結果用的區塊
                txtBox.innerHTML = "";	//每次查詢都先清空DIV的內容
                strs = "";				//重設空白字串
                if (BufferArea)		//假設地圖上已存在環域圖形(TGFill), 則先行移除
                    BufferArea.setMap(null);
                if (markers.length > 0) {	//假設地圖上已存在查詢後得到的標記點, 則先行移除
                    for (var i = 0; i < markers.length; i++) {
                        markers[i].setMap(null);
                    }
                    markers = [];		
                }
                //----------------繪製環域圖形-------------------
                var radius = parseFloat(document.getElementById("BufferDist").value);	//取得使用者輸入的環域半徑
                var pt = tEvent.point;	//取得滑鼠點擊位置的坐標點位,為TGPoint物件形式
                var circle = new TGOS.TGCircle();	//建立一個圓形物件(TGCircle)
                circle.setCenter(pt);				//以滑鼠點擊位置為圓心
                circle.setRadius(radius);			//設定半徑
                var pgnOption = {					//設定圖形樣式
                    fillColor: "#0099FF",
                    fillOpacity : 0.1,
                    strokeWeight : 2,
                    strokeColor : "#ff00ff"
                };
                BufferArea = new TGOS.TGFill(pMap, circle, pgnOption);	//使用TGFill物件將圓形繪製出來
                pMap.fitBounds(BufferArea.getBounds());
                pMap.setZoom(pMap.getZoom()-1);			//取得環域圖形的邊界後, 調整地圖顯示的範圍
		
                //----------------環域查詢部份-------------------
                var queryRequst = {		//設定點環域查詢條件, 包含圓心(pt)及半徑(radius)
                    position: pt,
                    distance: radius
                };
                //var schooltype = document.getElementById().;
                Query.identify(TGOS.TGMapServiceId.SCHOOL, TGOS.TGMapId.SCHOOL, queryRequst, TGOS.TGCoordSys.EPSG3826, function(result, status){
                    console.log(result);
                    //使用方法identify進行點環域查詢, 輸入參數包含欲查詢的服務、欲查詢的圖層、點環域參數、坐標系統及查詢後的函式, result及status分別代表查詢結果及查詢狀態
                    if (status == TGOS.TGBufferStatus.ZERO_RESULTS) {	//判斷查詢結果是否為查無結果
                        txtBox.innerHTML = '查無結果';
                        return;
                    } else {		//若查詢產生結果, 則執行以下函式
                        var attris = result.fieldAttr;	//取得圖徵屬性
                        var pts = result.position;		//取得圖徵點位
                        console.log(result.fieldAttr.length);
                        for (var i = 0; i < result.fieldAttr.length; i++) {
                            var re = result.fieldAttr[i];
                            var po = result.position[i];
                            console.log(re);
                            var marker = new TGOS.TGMarker(pMap, po);
                            marker.setTitle(re[2]);
                            marker.annotation = re;
                            
                            TGOS.TGEvent.addListener(marker, "mouseover", function (e) {
                                //設定InfoWindow內容
                                infowindow.setContent(this.annotation[3]+this.annotation[4]+'<br>'+this.annotation[2]+'<br>'+this.annotation[5]+'<br>'+this.annotation[6]+'<br>'+ this.annotation[8] );
                                infowindow.setPosition(this.position);
                                infowindow.open(pMap);
                                
                            })
                            markers.push(marker);	//將所有標記點加入陣列markers
                        }
                    }
                    txtBox.innerHTML = strs;	//將查詢後的文字結果寫入到空白DIV內
                });
            });
        }

        function removebuffer(){
            if (BufferArea)		//假設地圖上已存在環域圖形(TGFill), 則先行移除
                BufferArea.setMap(null);
            if (markers.length > 0) {	//假設地圖上已存在查詢後得到的標記點, 則先行移除
                for (var i = 0; i < markers.length; i++) {
                    markers[i].setMap(null);
                }
                markers = [];		
            }
            var txtBox = document.getElementById("result");	//取得網頁上的空白DIV, 作為顯示查詢結果用的區塊
            txtBox.innerHTML = "";
        }
    </script>
    <script type="text/javascript">
        document.body.onload = function () { InitWnd(); }
    </script>
        <div id="TGMap" style="width: 640px; height: 480px; border: 1px solid #C0C0C0; ">
        </div>
       <!-- <div id="GGMap" style="width:500px; height:500px;"></div>-->

        <div id="legend">
        

         </div>
        <div>
        環域查詢半徑:<input type="text" id="BufferDist" value="1000" size="2"><br>
	    請點選圖面進行環域查詢<br>
        <div id="result" style="width:640px; height:150px; border: 1px solid #C0C0C0; overflow-y:auto"></div>
        <input type="button" value="清除環域" onclick="removebuffer();">
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

