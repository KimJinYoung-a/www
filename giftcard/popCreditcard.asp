<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
<!-- for dev msg : 팝업 창 사이즈 width=500, height=625 -->
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2015/giftcard/tit_creditcard.png" alt="신용카드 결제 안내" /></h1>
		</div>
		<div class="popContent">
			<div class="giftcardPayGuideV15a">
				<p>신용카드 결제 시 &apos;결제하기&apos;버튼을 클릭하시면 신용카드 결제 창이 나타납니다.<br /> 신용카드 결제 창을 통해 입력되는 고객님의 카드 정보는 128bit로 안전하게 암호화되어 전송되며, 승인 처리 후 카드 정보는 승인 성공 / 실패 여부에 상관없이 자동으로 폐기되므로 안전합니다.<br /> 신용카드 결제 신청 시 승인 진행에 다소 시간이 소요될 수 있으므로 '중지', '새로고침'을 누르지 마시고 결과 화면이 나타 날때까지 기다려 주시길 바랍니다.</p>
				<!-- 웹표준 결제: X
				<p>※ 결제하기 버튼 클릭 시 결제창이 나타나지 않을 경우 아래 버튼을 눌러 수동으로 플러그인을 설치해주세요.</p>

				<div class="btnGroupV15a">
					<a href="http://plugin.inicis.com/repair/INIpayWizard.exe" target="_blank" class="btn btnS1 btnWhite btnW160">플러그인 수동설치</a>
				</div>
				//-->
				<div class="box5">
					<ul class="listTypeHypen">
						<li>- 국내 모든 카드 사용이 가능하며 해외에서 발행된 카드는 해외카드 3D 인증을 통해 사용 가능합니다.</li>
						<li>- 신용카드 / 실시간 이체는 결제 후, 무통장입금은 입금확인 후 인증번호 전송이 이루어집니다.</li>
						<li>- 실시간계좌이체 및 무통장 입금으로 구매 시 현금영수증, 세금계산서 증빙서류는 발급이 불가하며, GIFT 카드로 상품을 구매할 때 현금영수증 발행이 가능합니다.</li>
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