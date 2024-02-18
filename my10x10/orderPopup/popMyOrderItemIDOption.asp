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
strPageTitle = "텐바이텐 10X10 : 주문 상품 검색"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim i

''로그인 한 경우만 가능 ( 주문번호 로그인은 불가)
dim userid
userid = getEncLoginUserID()

dim frmname, targetname, targetdetailname
frmname     		= request("frmname")
targetname  		= request("targetname")
targetdetailname  	= request("targetdetailname")

Dim page	: page = req("page",1)



Dim orderSerial
if IsUserLoginOK() then
	orderSerial	= req("orderSerial","")
elseif IsGuestLoginOK() then
	orderSerial	= GetGuestLoginOrderserial()
end if


dim myorderdetail
set myorderdetail = new CMyOrder

If orderSerial <> "" Then
	myorderdetail.FRectOrderserial = orderserial
	myorderdetail.GetOrderDetail
ElseIf userid <> "" Then
	myorderdetail.FPageSize = 10
	myorderdetail.FCurrpage = page
	myorderdetail.GetMyOrderItemList
Else
	response.write "<script>" & vbCrLf
	response.write "alert('잘못된 호출입니다.');" & vbCrLf
	response.write "window.close();" & vbCrLf
	response.write "</script>" & vbCrLf
	Set myorderdetail	= Nothing
	dbget.close()	:	response.End
End If

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language='javascript'>

function RetItemID(orderSerial, itemid, orderdetailidx) {
	var frm = eval('opener.<%= frmname %>');

    var citemid = eval('opener.<%= frmname %>.<%= targetname %>');
    var corderdetailidx = eval('opener.<%= frmname %>.<%= targetdetailname %>');

	frm.orderserial.value = orderSerial;
    citemid.value = itemid;
    corderdetailidx.value = orderdetailidx;

    frm.submit();
    window.close();
}

function goPage(page){
    location.href = "?orderserial=<%= orderserial %>&frmname=<%= frmname %>&targetname=<%= targetname %>&targetdetailname=<%= targetdetailname %>&page=" + page;
}

</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_order_item.gif" alt="내가 주문한 상품" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<ul class="list">
						<li>최근 6개월 이내에 구매하신 상품입니다.</li>
						<li>이전 주문상품을 문의하실 경우에는 해당상품의 코드를 직접 입력해 주시기 바랍니다.</li>
						<li>상품 가격은 현재 판매가로 표시되므로 구매하신 금액과 달라질 수 있습니다.</li>
					</ul>

					<table class="baseTable tMar15">
					<caption>최근 6개월이내에 내가 주문한 상품 목록</caption>
					<colgroup>
						<col width="90" /> <col width="90" /> <col width="70" /> <col width="*" /> <col width="90" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col">상품코드</th>
						<th scope="col">주문번호</th>
						<th colspan="2" scope="col">상품명</th>
						<th scope="col">판매가</th>
					</tr>
					</thead>
					<tbody>
					<% for i = 0 to (myorderdetail.FResultCount - 1) 
						if myorderdetail.FItemList(i).FItemid <> "100" then
					%>
					<tr>
						<td><%= myorderdetail.FItemList(i).FItemid %></td>
						<td><%= myorderdetail.FItemList(i).ForderSerial %></td>
						<td><a href="javascript:RetItemID('<%= myorderdetail.FItemList(i).ForderSerial %>', '<%= myorderdetail.FItemList(i).FItemid %>', '<%= myorderdetail.FItemList(i).Fidx %>');"><img src="<%= Replace(myorderdetail.FItemList(i).FImageSmall,"http://webimage.10x10.co.kr/","/webimage/") %>" width="50" height="50" alt="[iconic] <%= myorderdetail.FItemList(i).FItemName %>" /></a></td>
						<td class="lt">
							<div><a href="javascript:RetItemID('<%= myorderdetail.FItemList(i).ForderSerial %>', '<%= myorderdetail.FItemList(i).FItemid %>', '<%= myorderdetail.FItemList(i).Fidx %>');">[<%= myorderdetail.FItemList(i).Fbrandname%>]</a></div>
							<div><a href="javascript:RetItemID('<%= myorderdetail.FItemList(i).ForderSerial %>', '<%= myorderdetail.FItemList(i).FItemid %>', '<%= myorderdetail.FItemList(i).Fidx %>');"><%= myorderdetail.FItemList(i).FItemName %></a></div>
						</td>
						<td><%= FormatNumber(myorderdetail.FItemList(i).FItemCost,0) %>원</td>
					</tr>
					<%
						end if
					next %>
					</tbody>
					</table>

					<div class="pageWrapV15 tMar20"><%= fnDisplayPaging_New_nottextboxdirect(myorderdetail.FcurrPage, myorderdetail.FtotalCount, myorderdetail.FPageSize, 10, "goPage") %></div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%

set myorderdetail = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
