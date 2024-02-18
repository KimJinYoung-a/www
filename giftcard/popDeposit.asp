<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim IsCyberAcctValid: IsCyberAcctValid = Request("bCb")="Y"
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
</head>
<body>
<!-- for dev msg : 팝업 창 사이즈 width=500, height=335 -->
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="http://fiximage.10x10.co.kr/web2015/giftcard/tit_deposit<%= CHKIIF(IsCyberAcctValid,"","_02") %>.png" alt="무통장입금 안내" /></h1>
		</div>
		<div class="popContent">
			<div class="giftcardPayGuideV15a">
				<ul class="listTypeHypen">
					<li>- 계좌번호는 주문완료 페이지에서 확인 가능하며, SMS로도 안내 드립니다.</li>
					<li>- 무통장 주문 후 7일이 지날때까지 미입금시 주문은 자동으로 취소됩니다.</li>
				<% if (IsCyberAcctValid) then %>
					<li>- 무통장 입금 시 사용되는 가상계좌는 매 주문 시마다 새로운 계좌번호(개인전용)가 부여되며 해당 주문에만 유효합니다.</li>
					<li>- 무통장 입금 확인은 입금 후 1시간 이내에 확인되며, 입금 확인 후 인증번호 전송이 이루어 집니다.</li>
					<li>- 결제완료 후 취소요청 시, <b class="cRd0V15">마이텐바이텐 &gt; Gift 카드 &gt; 카드주문내역</b>을 이용하시면 됩니다.</li>
				<% else %>
					<li>- 타행에서 입금하실경우 송금수수료가 부과 될 수 있습니다.</li>
					<li>- 입금자명, 입금액, 입금하실 은행이 일치 하여야 입금확인이 이루어집니다.</li>
					<li>- 입금후 영업일 1일 이내 확인되지 않으시면 고객센터로 문의 주시기 바랍니다.</li>
					<li>- 입금계좌번호 : <% Call DrawTenBankAccount("acctno","") %> &nbsp;&nbsp;예금주 : (주)텐바이텐</li>
				<% end if %>
				</ul>
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