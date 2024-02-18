<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	Dim vQuery, vIdx, vResult, vOrderserial, vCouponNo, vSellCash, vItemID, vSoldOUT, vItemName
	vIdx 		= requestCheckVar(request("idx"),20)
	vSoldOUT	= requestCheckVar(request("soldout"),10)
	If vIdx = "" Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		dbget.close()
		Response.End
	End If
	IF IsNumeric(vIdx) = false Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		dbget.close()
		Response.End
	End If
	
	vQuery = "SELECT * From [db_order].[dbo].[tbl_mobile_gift] Where idx = '" & vIdx & "' AND IsPAy = 'N'"
	rsget.Open vQuery,dbget,1
	IF Not rsget.EOF THEN
		vItemID		= rsget("itemid")
		rsget.close
	Else
		rsget.close
		dbget.close()
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		Response.End
	End IF
	
	vQuery = "SELECT sellcash, itemname From [db_item].[dbo].[tbl_item] Where itemid = '" & vItemID & "'"
	rsget.Open vQuery,dbget,1
	IF Not rsget.EOF THEN
		vSellCash = rsget("sellcash")
		vItemName = rsget("itemname")
	End IF
	rsget.close
	

	Dim vValue, vImage, i, vNowDate, v60LaterDate
	vImage 	= ""
	vValue = vSellCash
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
<script language="javascript">
function goGetGiftCard()
{
	j = document.getElementsByName("chk").length;
	var k = new Array();
	m = 0;
	for(var i=0; i < j ; i++){
		if (document.getElementsByName("chk")[i].checked == true)
		{
			k[m] = document.getElementsByName("chk")[i].value;
			m = m+1;
		}
	}
	
	if(k != "ok")
	{
		alert("이용 약관에 동의를 하셔야 합니다.");
		return;
	}
	
	<% If IsUserLoginOK() = "False" Then %>
	alert("쿠폰 교환 및 사용을 위해서는\n회원가입이 필요합니다.");
	<% Else %>
	document.frm1.submit();
	<% End If %>
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
	<form name="frm1" method="post" action="get_giftcard_proc.asp" target="iframechk" style="margin:0px;">
	<input type="hidden" name="idx" value="<%=vIdx%>">
	</form>
		<div id="contentWrap">
			<div class="gifticonCardWrap">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/cart/tit_giftcard_use_regist.gif" alt="Gift 카드 온라인 사용 등록" /></h2>
				<div class="box1 tMar10">
					<div class="ct box5 pad15">
						<p><strong class="fs15 crRed">텐바이텐 Gift 카드 <%=Right(vItemName,3)%>권</strong></p>
						<p class="fs11 tPad05">텐바이텐 Gift 카드를 온라인 홈페이지에서 사용하실 수 있도록 등록하는 서비스입니다.</p>
					</div>

					<h3 class="ct tMar50 bPad10"><img src="http://fiximage.10x10.co.kr/web2013/cart/txt_agree.gif" alt="약관동의" /></h3>
					<iframe src="/my10x10/giftcard/giftcard_terms.html" frameborder="0" scrolling="yes" class="bdr1" style="width:758px; height:318px;"></iframe>
					<p class="pad15 ct cr000"><input type="checkbox" class="check" id="cardAgree" name="chk" value="ok" /> <label for="cardAgree">텐바이텐 Gift 카드 이용약관을 확인하였으며 약관에 동의합니다.</label></p>
					<p class="ct tPad05"><a href="javascript:goGetGiftCard();" class="btn btnM1 btnRed btnW130">등록</a></p>

					<div class="note01 tBdr2 tMar40 pad15">
						<ul class="list01">
							<li>사용등록이 완료된 Gift 카드는 텐바이텐 온라인 및 모바일에서 사용이 가능합니다.</li>
							<li>교환 및 환불이 되지 않으며, 유효기간은 구매일로부터 5년 입니다.</li>
							<li>Gift 카드 금액이 1만원 초과일 경우 100분의 60 이상, 1만원 이하일 경우 100분의 80 이상 사용하면 남은 금액은 온라인 예치금으로 전환이 가능합니다.</li>
							<li>인증번호 등록이 완료된 Gift 카드는 상품 구매 시 결제 페이지에서 현금처럼 사용할 수 있으며, 다른 결제 수단과 중복으로 사용 가능합니다.</li>
						</ul>
					</div>
				</div>
				<p class="rt pad15 bBdr2"><img src="http://fiximage.10x10.co.kr/web2013/cart/txt_gifticon_cscenter.gif" alt="기프티콘 고객센터" /></p>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<iframe name="iframechk" src="" width="0" height="0"></iframe>
</body>
</html>