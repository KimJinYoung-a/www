<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head_ssl.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<%
	'// 입력된 주소를 접수
	'- 폴더명이 상품번호인지 확인 후 숫자이면 맞으면 상품페이지로 점프 (2010.06.16: 허진원)
	'- 이벤트, 디자인핑거스 추가 및 모바일 이동 추가 (2010.07.19; 허진원)

	Dim QrStr, arrQr
	QrStr = Request.ServerVariables("QUERY_STRING")
	arrQr = Split(QrStr,"/")
	QrStr = arrQr(ubound(arrQr))

	'// facebook 특정 파라메터 붙는 경우 한번 더 정재
	if instr(QrStr,"?") > 0 then 
		arrQr = Split(QrStr,"?")
		QrStr = arrQr(0)
	end if 

	if isNumeric(QrStr) then
		QrStr = getNumeric(QrStr)

		'폴더단위 분기
		Select Case arrQr(ubound(arrQr)-1)
			Case "shopping"
				'상품페이지
				if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
					Response.redirect mobileUrl & "/category/category_itemPrd.asp?itemid=" & QrStr
				else
					Response.redirect wwwUrl & "/shopping/category_prd.asp?itemid=" & QrStr
				end if
			Case "event","ev","evt"
				'이벤트
				if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
					Response.redirect mobileUrl & "/event/eventmain.asp?eventid=" & QrStr
				else
					Response.redirect wwwUrl & "/event/eventmain.asp?eventid=" & QrStr
				end if
			Case "evm","evtm"
				'모바일 전용 이벤트
				Response.redirect mobileUrl & "/event/eventmain.asp?eventid=" & QrStr
			Case "designfingers","df"
				'디자인핑거스
				if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
					Response.redirect mobileUrl & "/designfingers/fingers.asp?fingerid=" & QrStr
				else
					Response.redirect wwwUrl & "/play/playdesignfingers.asp?fingerid=" & QrStr
				end if
			Case "just1day","j1d"
				'Just1Day
				if len(QrStr)=8 then
					if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
						Response.redirect mobileUrl & "/just1day/index.asp?justDate=" & dateSerial(left(QrStr,4),mid(QrStr,5,2),right(QrStr,2))
					else
						Response.redirect wwwUrl & "/just1day/index.asp?justDate=" & dateSerial(left(QrStr,4),mid(QrStr,5,2),right(QrStr,2))
					end if
				end if
			Case "dayand","day"
				'Day&
				Response.redirect wwwUrl & "/guidebook/dayand.asp?eventid=" & QrStr
			Case "culturestation","culture","cts"
				'컬쳐스테이션
				if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
					Response.redirect mobileUrl & "/culturestation/index.asp?evt_code=" & QrStr
				else
					Response.redirect wwwUrl & "/culturestation/culturestation_event.asp?evt_code=" & QrStr
				end if
			Case "view"
				'상품 이미지뷰
				Response.redirect wwwUrl & "/shopping/itemImageView.asp?itemid=" & QrStr
			Case "diarystory", "diary"
				'다이어리 스토리
				Response.redirect wwwUrl & "/diarystory/event/diary_event_view.asp?eventid=" & QrStr
			Case "talk"
				'쇼핑톡
				if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
					Response.redirect mobileUrl & "/gift/gifttalk/talk_view.asp?talkidx=" & QrStr
				else
					Response.redirect wwwUrl & "/gift/talk/view.asp?talkidx=" & QrStr
				end if
			Case "theme"
				'기프트샾 테마
				Response.redirect wwwUrl & "/gift/shop/themeView.asp?themeIdx=" & QrStr
			Case "ord"
				'주문상세보기
				if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
					Response.redirect mobileUrl & "/my10x10/order/myorderdetail.asp?idx=" & QrStr
				else
					Response.redirect wwwUrl & "/my10x10/order/myorderdetail.asp?idx=" & QrStr
				end if
			Case "q"
				'배송 주문내역 QR코드 대체 주문상세보기
				Response.redirect mobileUrl & "/my10x10/order/myorderdetail.asp?idx=" & QrStr				
			Case Else
				if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
					Response.redirect mobileUrl & "/category/category_itemPrd.asp?itemid=" & QrStr
				else
					Response.redirect wwwUrl & "/shopping/category_prd.asp?itemid=" & QrStr
				end if
		End Select
		'dbget.close() : Response.End
	elseif QrStr="dayand" then
		'Day&
		Response.redirect wwwUrl & "/guidebook/dayand.asp"
	end if
%>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader_SSL.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="notFound">
				<p><img src="http://fiximage.10x10.co.kr/web2013/common/txt_not_found.gif" alt="요청하신 페이지를 찾을 수 없습니다." /></p>
				<p>문하시려는 페이지의 주소가 잘못 입력 되었거나,<br /> 변경 혹은 삭제되어 페이지를 찾을 수 없습니다.<br /> 입력하신 주소가 정확한지 다시 한번 확인해 주시기 바랍니다.</p>
				<div class="btnArea">
					<a href="" class="btn btnB1 btnWhite btnW185" onclick="history.back();return false;"><span class="redArr03">이전화면</span></a>
					<a href="/" class="btn btnB1 btnRed btnW185">홈 바로가기</a>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter_SSL.asp" -->
</div>
</body>
</html>