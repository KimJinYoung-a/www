<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
<!-- for dev msg : 팝업 창 사이즈 width=500, height=670 -->
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2015/giftcard/tit_account_transfer.png" alt="실시간 계좌이체 안내" /></h1>
		</div>
		<div class="popContent">
			<div class="giftcardPayGuideV15a">
				<p>실시간 이체 결제 시 '결제하기'버튼을 클릭하시면 결제 창이 나타납니다.<br /> 실시간 이체 결제 창을 통해 입력되는 고객님의 정보는 128bit로 안전하게 암호화되어 전송되며 승인 처리 후 정보는 승인 성공/ 실패 여부에 상관없이 자동으로 폐기되므로 안전합니다. 실시간 이체 결제 신청 시 승인 진행에 다소 시간이 소요될 수 있으므로 '중지', '새로고침'을 누르지 마시고 결과 화면이 나타날 때까지 기다려 주시길 바랍니다. </p>
				<!-- 웹표준 결제: X
				<p>※ 결제하기 버튼 클릭 시 결제창이 나타나지 않을 경우 아래 버튼을 눌러 수동으로 플러그인을 설치해주세요.</p>

				<div class="btnGroupV15a">
					<a href="" class="btn btnS1 btnWhite btnW160">플러그인 수동설치</a>
				</div>
				//-->
				<div class="box5">
					<ul class="listTypeHypen">
						<li>- 실시간 계좌 이체 서비스는 은행계좌만 있으면 누구나 이용하실 수 있는 서비스로, 별도의 신청 없이 그 대금을 자신의 거래은행의 계좌로부터 바로 지불하는 서비스입니다.</li>
						<li>- 결제 시 공인인증서가 반드시 필요합니다.</li>
						<li>- 결제 후 1시간 이내에 확인되며, 입금 확인 시 배송이 이루어 집니다.</li>
						<li>- 은행 이용가능 서비스 시간은 은행사정에 따라 다소 변동될 수 있습니다.</li>
						<li>- 신용카드/ 실시간 이체는 결제 후, 무통장입금은 입금확인 후 인증번호 전송이 이루어집니다.</li>
						<li>- 결제완료 후 취소요청 시, <b class="cRd0V15">마이텐바이텐 &gt; Gift 카드 &gt; 카드주문내역</b>을 이용하시면 됩니다.</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="popFooter">
		<div class="btnArea">
			<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
		</div>
	</div>
</div>
</body>
</html>