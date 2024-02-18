<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/offshop/inc/offshopCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/offshopcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'##################################################
' PageName : /offshop/index.asp
' Description : 오프라인숍 메인
' History : 2018.06.12 정태훈 리뉴얼
'##################################################
%>
<%
'매장 정보 가져오기
Dim offshopinfo, shopid
shopid = requestCheckVar(request("shopid"),16)
If shopid="" Then shopid="streetshop011"
'Response.write shopid
'Response.end
Set  offshopinfo = New COffShop
offshopinfo.FRectShopID=shopid
offshopinfo.GetOneOffShopContents

Dim ClsOSBoard
Dim arrNotice

set ClsOSBoard = new COffshopBoard
	ClsOSBoard.FCPage	= 1
	ClsOSBoard.FPSize	= 1
	ClsOSBoard.FShopId = shopid
	arrNotice = ClsOSBoard.fnGetNotice
set ClsOSBoard = nothing
%>
<%
	strPageTitle = "텐바이텐 10X10 : 매장안내"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_infomation_v1.jpg"
	strPageDesc = "텐바이텐 상품을 눈으로 직접 확인 해보세요!"
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 매장안내"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/offshop/"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=523d793577f1c5116aacc1452942a0e5&libraries=services"></script>
<script>
$(function(){
	// 최초 지도 표시
	initialize();
});

function initialize(rtaddr,nm) {
	if(!rtaddr) rtaddr="<%=offshopinfo.FOneItem.FShopAddr1%> <%=offshopinfo.FOneItem.FShopAddr2%>";
	if(!nm)		nm="<%=offshopinfo.FOneItem.FShopName%>";
	
	$("#mapView").empty();
	
	setTimeout(function() {
		var mapContainer = document.getElementById('mapView'),
			mapOption = {
				center: new daum.maps.LatLng(37.582708, 127.003605), // 지도의 중심좌표
				level: 3 // 지도의 확대 레벨
			};

		// 지도 생성
		var map = new daum.maps.Map(mapContainer, mapOption); 

		var geocoder = new daum.maps.services.Geocoder();	// 주소-좌표 변환 객체를 생성
		var addr=rtaddr;
		var lat="";
		var lng="";
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch(addr, function(result, status) {
			if (status === daum.maps.services.Status.OK) {
				var coords = new daum.maps.LatLng(result[0].y, result[0].x);
				var marker = new daum.maps.Marker({
					map: map,
					position: coords
				});

				// 인포윈도우로 장소에 대한 설명을 표시
				var infowindow = new daum.maps.InfoWindow({
					content: '<div style="width:150px;text-align:center;padding:6px 0;">'+nm+'</div>'
				});
				infowindow.open(map, marker);

				// 지도의 중심을 결과값으로 받은 위치로 이동
				map.setCenter(coords);
			} 
		});
	}, 200);
}

function geocodenew() {
	var address = "";
	var addrurl = "";
	address = "<%=offshopinfo.FOneItem.FShopAddr1%> <%=offshopinfo.FOneItem.FShopAddr2%>";
	addrurl = "http://map.daum.net/link/search/"+address;
	window.open(addrurl, "_blank");
}
</script>
<script type="text/javascript">
$(function(){
	// gallery
	var offSwiper = new Swiper('.offshop-index .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:2500,
		simulateTouch:false,
		pagination:'.offshop-index .pagination',
		paginationClickable:true,
		nextButton:'.offshop-index .btn-next',
		prevButton:'.offshop-index .btn-prev'
	})
	$('.offshop-index .btn-prev').on('click', function(e){
		e.preventDefault();
		offSwiper.swipePrev();
	})
	$('.offshop-index .btn-next').on('click', function(e){
		e.preventDefault();
		offSwiper.swipeNext();
	});
});
</script>
</head>
<body>
<div class="wrap fullEvt">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container offshopV18">
		<div id="contentWrap">
			<!-- #include virtual="/offshop/inc/incHeader.asp" -->
			<div class="offshop-index">
				<!-- gallery -->
				<div class="gallery">
					<div class="swiper-container">
						<div class="swiper-wrapper">
						<% If isArray(arrMainGallery) Then %>
							<% For ix = 0 To UBound(arrMainGallery,2) %>
							<div class="swiper-slide"><img src="<%=arrMainGallery(0,ix)%>" alt="" /></div>
							<% Next %>
						<% Else %>
							<div class="swiper-slide"></div>
						<% End If %>
						</div>
						<div class="pagination"></div>
						<button class="rolling-nav btn-prev" onfocus="this.blur();">이전</button>
						<button class="rolling-nav btn-next" onfocus="this.blur();">다음</button>
					</div>
				</div>
				<!--// gallery -->

				<!-- info -->
				<div class="info">
					<div class="txt">
						<% if offshopinfo.FOneItem.FMobileWorkHour<>"" then %><div class="time"><i class="icoV18"></i><%=offshopinfo.FOneItem.FMobileWorkHour%> <span>휴무일은 공지사항을 참고해주세요</span></div><% End If %>
						<% if offshopinfo.FOneItem.FShopPhone<>"" then %><div class=" tel"><i class="icoV18"></i><strong><%=offshopinfo.FOneItem.FShopPhone%></strong><% If offshopinfo.FOneItem.FShopFax<>"" Then %><span>FAX <%=offshopinfo.FOneItem.FShopFax%></span><% End If %></div><% End If %>
						<div class="noti"><% If isArray(arrNotice) Then %><i class="icoV18"></i><a href="/offshop/shopnotice.asp?shopid=<%=shopid%>&menuid=2"><em><%=chrbyte(db2html(arrNotice(3,0)),28,"Y")%></em>
						<span><%=chrbyte(db2html(arrNotice(7,0)),40,"Y")%></span>
						<span><%=FormatDate(arrNotice(6,0),"0000.00.00")%></span></a><% End If %></div>
					</div>
					<div class="map">
						<div class="address"><i class="icoV18"></i><a href="javascript:geocodenew();"><%=offshopinfo.FOneItem.FShopAddr1%>&nbsp;<%=offshopinfo.FOneItem.FShopAddr2 %></a></div>
						<div class="google-map" id="mapView"></div>
					</div>
				</div>
				<!--// info -->
			</div>

		</div>
	</div>
</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->

</body>
</html>
<% Set  offshopinfo = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->