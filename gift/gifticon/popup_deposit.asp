<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>

<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<script>
function goURL(a)
{
	if(a == "1")
	{
		opener.top.location.href = "/my10x10/myTenCash.asp";
	}
	else
	{
		opener.top.location.href = "/";
	}
	window.close();
}
</script>
</head>
<body>
	<div class="balanceChg">
		<div>
			<p><img src="http://fiximage.10x10.co.kr/web2013/cart/txt_balance_change_ok.gif" alt="감사합니다. 예치금으로 교환이 완료되었습니다." /></p>
			<p class="fs11 tPad10"><span class="crRed">마이텐바이텐 &gt; 예치금관리</span>에서 확인 가능합니다.</p>
		</div>
		<p class="btnArea">
			<a href="javascript:goURL('1');" class="btn btnWhite">홈으로 가기</a>
			<a href="javascript:goURL('2');" class="btn btnRed">예치금 확인하기</a>
		</p>
	</div>
</body>
</html>