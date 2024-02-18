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
				<h1>수집 내용 자세히 보기</h1>
			</div>
			<div class="popContent tPad30">
				<dl>
					<dt class="cr000">수집 항목</dt>
					<dd class="cr999">
						본인확인정보, 이름, 이메일 주소, 휴대폰 번호, 전화번호, 주소, 결제수단 정보, 개인통관고유번호(해외직구 상품 구매 시), 현금영수증 카드번호
					</dd>
					<dt class="cr000 tMar05">수집 목적</dt>
					<dd class="cr999">
						주문한 물품의 배송/설치 등 고객과 체결한 계약의 이행, 민원/불만/건의사항의 상담 및 처리, 서비스 주문/결제, 관세법에 따른 세관 신고, 기타 구매 활동에 필요한 본인 확인
					</dd>
					<dt class="cr000 tMar05">이용 기간</dt>
					<dd class="cr999">
						계약 또는 청약철회 등에 관한 기록 : 주문일 이후 5년간 보관<br>
						대금결제 및 재화 등의 공급에 관한 기록 : 주문일 이후 5년간 보관<br>
						소비자의 불만 또는 분쟁처리에 관한 기록 : 주문일 이후 3년간 보관
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
