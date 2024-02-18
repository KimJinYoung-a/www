<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 티켓주문 약도 보기"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


Dim placeIdx : placeIdx=requestCheckvar(request("placeIdx"),10)

dim oticketPLace
set oticketPLace = new CTicketPlace
oticketPLace.FRectTicketPlaceIdx = placeIdx
oticketPLace.GetOneTicketPLace

if (oticketPLace.FResultCount < 1) then
	set oticketPLace = Nothing
	dbget.close()
	response.end
end if

'// TODO : 제목, 홈페이지주소, 약도이미지만 디비에서 가져오고
'// 나머지는 html 로 박는다.(skyer9)
'//
'// 참조 : /2012www/my10x10/popTicketPLace.asp
'// 2017-11-11 > 티켓 장소 정보 내용 그대로 출력

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_traffic_guidance.gif" alt="공연장 교통안내" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<div class="trafficGuidance">
						<div class="titleArea">
							<h2>공연장 : <%= oticketPLace.FOneItem.FticketPlaceName %></h2>
							<% if Not(oticketPLace.FOneItem.FtPHomeURL="" or isnull(oticketPLace.FOneItem.FtPHomeURL)) then %>
							<a href="<%= oticketPLace.FOneItem.FtPHomeURL %>" target="_blank" class="btn btnS2 btnRed"><span class="whiteArr01 fn">홈페이지 가기</span></a>
							<% end if %>
						</div>

						<!-- // 지산 TEXT 시작
						<div class="section">
							<h3>자가용 안내</h3>
							<div class="devide">
								<h4>서울 강남</h4>
								<ul class="list bulletDot">
									<li>서울 강남에서 40분거리에 위치한 지산 포레스트 리조트는 한남대교 남단에서 56Km거리인 덕평I.C. (영동 고속도로 신갈 기점, 약 25Km지점)에서 나와 좌회전하 여 약4Km거리에 있습니다.</li>
									<li>최근에 영동고속도로가 4차선으로 확장 오픈하여 더욱 방문이 쉬워졌습니다.</li>
									<li>중부 고속도로를 이용할 경우 호법 JCT에서 수원방향으로 빠지면 바로 덕평 I.C.가 나옵니다.</li>
									<li>국도를 이용할 경우 3번국도와 45번 국도를 이용하시면 됩니다.</li>
								</ul>
							</div>

							<div class="devide">
								<h4>서울 강남</h4>
								<ul class="list bulletDot">
									<li>서울 강남에서 40분거리에 위치한 지산 포레스트 리조트는 한남대교 남단에서 56Km거리인 덕평I.C. (영동 고속도로 신갈 기점, 약 25Km지점)에서 나와 좌회전하 여 약4Km거리에 있습니다.</li>
									<li>최근에 영동고속도로가 4차선으로 확장 오픈하여 더욱 방문이 쉬워졌습니다.</li>
									<li>중부 고속도로를 이용할 경우 호법 JCT에서 수원방향으로 빠지면 바로 덕평 I.C.가 나옵니다.</li>
									<li>국도를 이용할 경우 3번국도와 45번 국도를 이용하시면 됩니다.</li>
								</ul>
							</div>

							<div class="devide">
								<h4>서울 강남</h4>
								<ul class="list bulletDot">
									<li>서울 강남에서 40분거리에 위치한 지산 포레스트 리조트는 한남대교 남단에서 56Km거리인 덕평I.C. (영동 고속도로 신갈 기점, 약 25Km지점)에서 나와 좌회전하 여 약4Km거리에 있습니다.</li>
									<li>최근에 영동고속도로가 4차선으로 확장 오픈하여 더욱 방문이 쉬워졌습니다.</li>
									<li>중부 고속도로를 이용할 경우 호법 JCT에서 수원방향으로 빠지면 바로 덕평 I.C.가 나옵니다.</li>
									<li>국도를 이용할 경우 3번국도와 45번 국도를 이용하시면 됩니다.</li>
								</ul>
							</div>

							<div class="devide parking">
								<h4>주차안내</h4>
								<ul class="list bulletDot">
									<li>행사장 인근 임시주차장이 개설되어, 일반 관객의 주차는 임시 주차장으로 안내될 예정입니다.</li>
									<li>지산포레스트리조트 인근의 숙박시설을 이용하는 분들은 자체 주차시설을 이용 부탁 드립니다.</li>
									<li>사전에 허가 받지 않은 차량은 어떠한 이유에도 리조트 안으로 진입이 불가합니다.</li>
									<li>일반관객주차공간 : 지산마트 3거리 공터 임시주차장/마장 초등학교 (셔틀버스 제공)</li>
								</ul>
							</div>
						</div>

						<div class="section">
							<h3>대중교통 안내</h3>
							<div class="devide">
								<h4>이천 시외버스 터미널-12번 버스 이용</h4>
								<ul class="list bulletDot">
									<li>소요시간 : 40분 소요</li>
									<li>요금 : 1,500원 (카드 1,400원)</li>
									<li>지산리조트 이용 고객님들은 경희마트에서 하차해 주십시오.</li>
									<li>개장 이후 버스운행사 사정에 따라 노선 및 시간이 변경 될 수 있습니다.</li>
									<li>운행사 사정으로 5~10분의 시차가 발생할 수 있습니다.</li>
								</ul>
							</div>

							<div class="devide">
								<h4>용인 터미널-103번 버스 이용</h4>
								<ul class="list bulletDot">
									<li>버스 배차 간격 : 120분</li>
								</ul>
							</div>
						</div>
						지산 TEXT 끝 //-->

						<div class="section">
							<h3>약도 안내</h3>
							<div class="devide">
								<div class="map">
								<% if Not(oticketPLace.FOneItem.FplaceImgURL="" or isNull(oticketPLace.FOneItem.FplaceImgURL)) then %>
								<img src="<%=oticketPLace.FOneItem.FplaceImgURL%>" />
								<% end if %>
								<%=oticketPLace.FOneItem.FplaceContents%>
								</div>
								<!--<div class="map"><img src="<%= oticketPLace.FOneItem.FplaceImgURL %>" alt="지산리조트 약도" /></div>-->
							</div>
						</div>
					</div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
