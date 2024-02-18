<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 주문 검색"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

''로그인 한 경우만 가능 ( 주문번호 로그인은 불가)
dim userid
userid = getEncLoginUserID ''GetLoginUserID

dim frmname, targetname
frmname     = request("frmname")
targetname  = request("targetname")

Dim page	: page = req("page",1)

dim myorderList
set myorderList = new CMyOrder
myorderList.FRectUserID = userid
myorderList.FPageSize = 10
myorderList.FCurrpage = page

if IsUserLoginOK() then
    myorderList.GetMyOrderListProc
end if

dim i

Dim IsSSL, iFiximageURL
IsSSL = (request.ServerVariables("SERVER_PORT_SECURE")="1")
if (IsSSL) then
	iFiximageURL = "/fiximage"
else
	iFiximageURL = "http://fiximage.10x10.co.kr"
end if

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language='javascript'>

function goPage(pg){
    location.href='?page='+pg+'&frmname=<%= frmname %>&targetname<%= targetname %>';
}

function RetOrderSerial(orderserial){
    var frm = eval('opener.document.<%= frmname %>');
    frm.orderserial.value = orderserial;
    frm.itemid.value = "";
    frm.submit();
    window.close();
}

</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_search_order.gif" alt="주문검색" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<p class="comment">최근 6개월간 고객님의 주문내역입니다. <strong class="crRed">주문번호/주문상품</strong>을 선택해주세요.</p>
					<table class="baseTable">
					<caption>주문검색 목록</caption>
					<colgroup>
						<col width="90" /> <col width="90" /> <col width="*" /> <col width="90" /> <col width="70" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col">주문번호</th>
						<th scope="col">주문일자</th>
						<th scope="col">주문상품</th>
						<th scope="col">총 구매금액</th>
						<th scope="col">주문상태</th>
					</tr>
					</thead>
					<tbody>
					<%
					if myorderList.FResultCount > 0 then
						for i = 0 to (myorderList.FResultCount - 1)
					%>
					<tr>
						<td><a href="javascript:RetOrderSerial('<%= myorderList.FItemList(i).FOrderSerial %>');" title="주문 선택하기"><%= myorderList.FItemList(i).FOrderSerial %></a></td>
						<td><%= Replace(Left(CStr(myorderList.FItemList(i).Fregdate),10), "-", "/") %></td>
						<td class="lt"><a href="javascript:RetOrderSerial('<%= myorderList.FItemList(i).FOrderSerial %>');" title="주문 선택하기"><%= myorderList.FItemList(i).GetItemNames %></a></td>
						<td><%= FormatNumber(myorderList.FItemList(i).FSubTotalPrice,0) %> 원</td>
						<td><em class="<%= myorderList.FItemList(i).GetIpkumDivCSS() %>"><%= myorderList.FItemList(i).GetIpkumDivName %></em></td>
					</tr>
					<%
						next
					else
					%>
					<tr>
						<td colspan="5">검색된 주문내역이 없습니다.</td>
					</tr>
					<%
					end if
					%>
					</tbody>
					</table>

					<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(myorderList.FcurrPage, myorderList.FtotalCount, myorderList.FPageSize, 10, "goPage") %></div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%

set myorderList = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
