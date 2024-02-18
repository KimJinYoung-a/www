<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 예치금 관리"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_money_v1.jpg"
	strPageDesc = "예치금 잔액 조회가 가능합니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 예치금 조회"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/myTenCash.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<%
dim userid, page, dType
userid	= getEncLoginUserID
page	= requestCheckvar(request("page"),9)

if page="" then page=1

dim oTenCash
set oTenCash = new CTenCash
oTenCash.FRectUserID = userid

if (userid<>"") then
	oTenCash.getUserCurrentTenCash
end if

dim oTenCashLog
set oTenCashLog = New CTenCash
oTenCashLog.FPageSize=10
oTenCashLog.FCurrPage= page
oTenCashLog.FRectUserid = userid

if (userid<>"") then
	oTenCashLog.gettenCashLog
end if

dim i,lp

if (GetLoginCurrentTenCash() <> oTenCash.Fcurrentdeposit) then
	Call SetLoginCurrentTenCash(oTenCash.Fcurrentdeposit)
end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language='javascript'>
function goPage(pg){
	var frm = document.researchForm;
	frm.page.value = pg;
	frm.submit();
}
</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_tencash.gif" alt="예치금 관리" /></h3>
						<ul class="list">
							<li>텐바이텐 온라인 쇼핑몰에서 반품/취소 시 해당 반환 금액을 현금처럼 사용 가능한 예치금으로 돌려 드립니다.</li>
							<li>예치금은 사용 유효기간이 없으며 최소 구매 금액 제한 없이 사용 가능합니다.</li>
							<li>예치금은 현금 반환 신청이 가능하며  신청일 기준 약 2-3일 내 모든 반환 처리가 완료됩니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<div class="myservice">
							<h4 style="padding-bottom:0;">나의 예치금</h4>
							<a href="/my10x10/poprewardcash.asp" onclick="window.open(this.href, 'popDepositor', 'width=550, height=890, scrollbars=yes'); return false;" class="btn btnS2 btnGrylight btn-deposit" style="position:relative; bottom:-2px;"><span class="fn"><%=CHKIIF(IsVIPUser()=True,"VIP ","")%>예치금 반환 신청</span></a>
						</div>
						<div class="myTopic">
							<div class="box">
								<div class="price ct">현재 나의 예치금 : <strong><%= FormatNumber(oTenCash.Fcurrentdeposit,0) %></strong><span>원</span></div>
							</div>
						</div>

						<div class="etcInfo">
							<h4>예치금 적립 및 사용내역</h4>
							<table class="baseTable">
							<caption>예치금 적립 및 사용내역 현황</caption>
							<colgroup>
								<col width="145" /> <col width="130" /> <col width="*" /> <col width="140" /> <col width="140" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">주문번호</th>
								<th scope="col">일자</th>
								<th scope="col">적용내용</th>
								<th scope="col">금액</th>
								<th scope="col">잔액</th>
							</tr>
							</thead>
							<tbody>
							<%
							if (oTenCashLog.FTotalCount > 0) then
								for i=0 to oTenCashLog.FResultCount-1
							%>
							<tr>
								<td><%= oTenCashLog.FItemList(i).Forderserial %></td>
								<td><%= Replace(Left(oTenCashLog.FItemList(i).Fregdate,10), "-", "/") %></td>
								<td><%= oTenCashLog.FItemList(i).Fjukyo %></td>
								<td><%= FormatNumber(oTenCashLog.FItemList(i).Fdeposit,0) %> 원</td>
								<td><%= FormatNumber(oTenCashLog.FItemList(i).FRemain,0) %> 원</td>
							</tr>
							<%
								next
							else
							%>
							<tr>
								<td colspan="5">예치금 적립/사용 내역이 없습니다.</td>
							</tr>
							<% end if %>
							</tbody>
							</table>

							<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(oTenCashLog.FcurrPage, oTenCashLog.FtotalCount, oTenCashLog.FPageSize, 10, "goPage") %></div>
						</div>
					</div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

<form name="researchForm" method="get" action="">
<input type="hidden" name="page" value="">
<input type="hidden" name="dType" value="<%= dType %>">
</form>

</body>
</html>
<%

Set oTenCash = Nothing
Set oTenCashLog = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->