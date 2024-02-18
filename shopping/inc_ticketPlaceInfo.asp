	<div class="section pdtExplanV15" id="detail05">
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=523d793577f1c5116aacc1452942a0e5&libraries=services"></script>
		<script>
		$(function(){
			// 최초 지도 표시
			initMap();
		});

		function initMap(rtaddr,nm) {
			if(!rtaddr) rtaddr="<%=oTicket.FOneItem.FtPAddress%>";
			if(!nm)		nm="<%=trim(oTicket.FOneItem.FticketPlaceName)%>";
			
			$("#mapViewBig").empty();
			
			setTimeout(function() {
				var mapContainer = document.getElementById('mapViewBig'),
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
		</script>

		<h3>위치 정보</h3>
		<div class="tPad10">
			<h4><%=oTicket.FOneItem.FticketPlaceName%></h4>
			<ul class="list01V15">
				<li>주소 : <%=oTicket.FOneItem.FtPAddress%></li>
				<li>전화번호 : <%=oTicket.FOneItem.FtPTel%></li>
			</ul>
		</div>
		<div class="tPad15">
			<% if Not(oTicket.FOneItem.FplaceImgURL="" or isNull(oTicket.FOneItem.FplaceImgURL)) then %>
			<img src="<%=oTicket.FOneItem.FplaceImgURL%>" />
			<% end if %>
			<div id="mapViewBig" style="width:1000px; height:400px; background-color: #eee; color:#ddd; font-size:10px;"></div>
			<%'=oTicket.FOneItem.FplaceContents%>
		</div>
		
		<% if not(oTicket.FOneItem.FparkingGuide="" or isnull(oTicket.FOneItem.FparkingGuide)) then %>
		<h3 class="tMar25">주차 안내</h3>
		<div class="tPad10 lh16"><%=nl2br(oTicket.FOneItem.FparkingGuide)%></div>
		<% end if %>
	</div>