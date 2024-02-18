<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 기프티콘 교환"
	
	Dim vQuery, vIdx, vResult, vOrderserial, vCouponNo, vSellCash, vItemID
	vIdx = requestCheckVar(request("idx"),20)
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
	If IsUserLoginOK() = False Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		dbget.close()
		Response.End
	End If
	
	vQuery = "SELECT * From [db_order].[dbo].[tbl_mobile_gift] Where idx = '" & vIdx & "' AND IsPAy = 'N'"
	rsget.Open vQuery,dbget,1
	IF Not rsget.EOF THEN
		vCouponNo 	= rsget("couponno")
		vItemID		= rsget("itemid")
		rsget.close
	Else
		rsget.close
		dbget.close()
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		Response.End
	End IF
	
	vQuery = "SELECT tot_sellcash From [db_order].[dbo].[tbl_mobile_gift_item] Where itemid = '" & vItemID & "' AND gubun = 'gifticon'"
	rsget.Open vQuery,dbget,1
	IF Not rsget.EOF THEN
		vSellCash = rsget("tot_sellcash")
	End IF
	rsget.close
	

	Dim vValue, vImage, i, vNowDate, v60LaterDate
	vImage 	= ""
	vValue = vSellCash

	If IsNumeric(vValue) Then
		vValue = FormatNumber(vValue,0)
	End IF
									
	For i=1 To Len(vValue)
		If Mid(vValue,i,1) = "," Then
			vImage = vImage & "<img src='http://fiximage.10x10.co.kr/web2013/common/cp_red_num_comma.png' alt=',' />" & vbCrLf
		Else
			vImage = vImage & "<img src='http://fiximage.10x10.co.kr/web2013/common/cp_red_num0" & Mid(vValue,i,1) & ".png' alt='" & Mid(vValue,i,1) & "' />" & vbCrLf
		End If
	Next
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
<script>
function goGetCoupon()
{
	<% If IsUserLoginOK() = False Then %>
	if(confirm("예치금 및 사용을 위해서는\n로그인 및 회원가입이 필요합니다.\n로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
	}
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
	<form name="frm1" method="post" action="get_deposit_proc.asp" target="iframechk" style="margin:0px;">
	<input type="hidden" name="idx" value="<%=vIdx%>">
		<div id="contentWrap">
			<div class="gifticonCardWrap">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/cart/tit_balance_change.gif" alt="예치금으로 교환하기" /></h2>
				<div class="box1 tMar10">
					<div class="ct tPad30">
						<p><strong class="fs15 cr000">죄송합니다. 해당상품은 품절되었습니다.</strong></p>
						<p class="tPad05 fs11">상품 구매시 현금처럼 사용하실 수 있는 <span class="crRed">텐바이텐 예치금</span>으로 교환해 드리겠습니다.</p>
					</div>

					<div class="couponBox tMar30">
						<div class="box">
							<div class="title">
								<span class="tag red">
									<%=vImage%>
									<img src="http://fiximage.10x10.co.kr/web2013/common/cp_red_num_won.png" alt="원" />
								</span>
							</div>
							<div class="account">
								<ul>
									<li class="name">상품 구매시 현금처럼 사용 가능</li>
									<li class="date">사용 유효기간 없음</li>
									<li class="condition"><em class="crRed">최소 구매금액 제한 없음</em></li>
								</ul>
							</div>
						</div>
					</div>

					<p class="ct tPad20"><a href="javascript:goGetCoupon();" class="btn btnM1 btnRed btnW130">교환하기</a></p>
				</div>
				<p class="rt pad15 bBdr2"><img src="http://fiximage.10x10.co.kr/web2013/cart/txt_gifticon_cscenter.gif" alt="기프티콘 고객센터" /></p>
			</div>
		</div>
	</form>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<iframe name="iframechk" src="" width="0" height="0"></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->