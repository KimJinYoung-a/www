<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
    Response.AddHeader "Cache-Control","no-cache"
    Response.AddHeader "Expires","0"
    Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
	<div class="heightgird popV18">
		<div class="popWrap">
			<div class="popHeader">
				<h1>제공 내용 자세히 보기</h1>
			</div>
			<div class="popContent tPad30">
				<dl>
					<dt class="cr000">제공 항목</dt>
					<dd class="cr999">
                        본인확인정보, 이름, 이메일 주소, 휴대폰 번호, 전화번호, 주소, 개인통관고유번호(해외직구 상품 구매 시)
					</dd>
					<dt class="cr000 tMar05">이용 목적</dt>
					<dd class="cr999">
						판매자 : 주문한 물품의 배송/설치 등 고객과 체결한 계약의 이행, 민원/불만/건의사항의 상담 및 처리, 서비스<br>
						주문/결제, 관세법에 따른 세관 신고, 기타 구매 활동에 필요한 본인 확인<br>
						㈜케이지이니시스 : 이니렌탈 서비스 이용
					<dt class="cr000 tMar05">보유 기간</dt>
					<dd class="cr999">
						판매자 : 서비스 종료 후 6개월 까지<br>
						㈜케이지이니시스 : 서비스 계약 기간 종료 시 까지	
					</dd>
					<dt class="cr000 tMar05">동의 거부권 등에 대한 고지</dt>
					<dd class="cr999">
						개인정보 수집은 서비스 이용을 위해 꼭 필요합니다.<br>
						개인정보 수집을 거부하실 수 있으나 이 경우 서비스 이용이 제한될 수 있음을 알려드립니다.
					</dd>
				</dl>
			</div>
			<div class="popFooter">
				<div class="btnArea">
					<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->
