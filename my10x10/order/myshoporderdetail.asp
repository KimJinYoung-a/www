<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<% const MenuSelect = "01" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/frontGiftCls.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim IsValidOrder : IsValidOrder = False   '''정상 주문인가.
Dim IsBiSearch   : IsBiSearch   = False   '''비회원 주문인가.
Dim IsTicketOrder : IsTicketOrder = FALSE ''티켓주문인가
Dim isEvtGiftDisplay : isEvtGiftDisplay = TRUE		''사은품 표시 여부

dim i, j
dim userid, orderserial, etype
dim pflag, cflag
dim tensongjangdiv, itemtotal, mode


userid       = getEncLoginUserID()

orderserial  = requestCheckVar(request("idx"),16)
etype        = requestCheckVar(request("etype"),10)
pflag        = requestCheckVar(request("pflag"),10)
cflag        = requestCheckVar(request("cflag"),10)
mode        = requestCheckVar(request("mode"),1)
itemtotal=0

'If mode="N" Then
'	Dim retOrderSerial : retOrderSerial = getUserShopRecentOrder(userid)
'	orderserial=retOrderSerial
'End If

if (orderserial = "") then
	orderserial = requestCheckVar(request("orderserial"), 16)
end if

dim myorder
set myorder = new CMyOrder
myorder.FRectOldjumun = CHKIIF(pflag="P","on","")

if IsUserLoginOK() then
    myorder.FRectUserID = userid
    myorder.FRectOrderserial = orderserial
    myorder.GetShopOneOrder
end if

dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectOrderserial = orderserial

if myorder.FResultCount>0 then
	myorderdetail.FRectUserID = userid
    myorderdetail.GetShopOrderDetail
    IsValidOrder = True

    IsTicketOrder = myorder.FOneItem.IsTicketOrder
end if

if (Not myorder.FOneItem.IsValidOrder) then
    IsValidOrder = False
end if

%>
</head>

<script type="text/javascript">
$(function() {
	$('.infoMoreViewV15').mouseover(function(){
		$(this).children('.infoViewLyrV15').show();
	});
	$('.infoMoreViewV15').mouseleave(function(){
		$(this).children('.infoViewLyrV15').hide();
	});
});

function popMyOrderNo(){
	var f = document.frmOrdSearch;
	var url = "/my10x10/orderPopup/popMyShopOrderNo.asp?frmname=" + f.name + "&targetname=" + f.orderserial.name;
	var popwin = window.open(url,'popMyOrderNo','width=750,height=565,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function getRecentOrder(){
    var frm = document.frmDumi;
    frm.target="FrameRctOrd";
    frm.action="/my10x10/order/inc/ifraShopRecentOrd.asp";
	frm.submit();
}

</script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_detail_check.gif" alt="주문상세조회" /></h3>
						<ul class="list">
							<li>오프라인 주문건별 구매 내역 정보입니다.</li>
							<li>오프라인 주문 정보는 일별로 매장 마감한 상품 기준으로 갱신됩니다.</li>
							<li>오프라인 상품의 할인, 가격 정보는 매장별 정책에 따라 온라인 상품 정보와 상이할 수 있습니다.</li>
							<li>오프라인 구매 상품의 교환 및 환불 신청은 구매 매장에 문의 부탁드립니다. <a href="http://www.10x10.co.kr/offshop/shopinfo.asp?shopid=streetshop011&tabidx=1" class="cGy0V15" target="_blank"><strong>[매장정보 보기]</strong></a></li>
						</ul>
					</div>

					<div class="mySection">
						<fieldset>
						<legend>주문번호 검색</legend>
							<iframe name="FrameRctOrd" src="about:blank;" frameborder="0" width="0" height="0" ></iframe>
							<form name="frmOrdSearch" style="margin:0;">
							<input type="hidden" name="itemid">
							<div class="searchField orderNo">
								<div class="word">
									<strong>주문번호</strong>
									<input type="text" name="orderserial" value="<%= orderserial %>" readonly class="iText" />
								</div>
								<!-- <div class="option">
									<a href="javascript:popMyOrderNo();" title="새창에서 열림" class="btn btnS2 btnRed"><span class="fn">주문검색</span></a>
									<a href="javascript:getRecentOrder();" class="btn btnS2 btnWhite"><span class="fn">최근 주문건 바로보기</span></a>
								</div> -->
							</div>
							</form>
							<iframe name="FrameRctOrd" src="about:blank;" frameborder="0" width="0" height="0" ></iframe>
							<form name="frmDumi" method="post" style="margin:0;"></form>
							<div class="orderDetail">
								<div class="title">
									<h4>주문상품정보</h4>
								</div>
								<table class="baseTable btmLine">
									<caption>주문상품정보 목록</caption>
									<colgroup>
										<col width="98" /><col width="70" /><col width="*" /><col width="90" /><col width="50" /><col width="100" />
									</colgroup>
									<thead>
									<tr>
										<th scope="col">상품코드</th>
										<th scope="col" colspan="2">상품정보</th>
										<th scope="col">판매가</th>
										<th scope="col">수량</th>
										<th scope="col">소계금액</th>
									</tr>
									</thead>
									<tbody>
									<% For i=0 To myorderdetail.FResultCount-1 %>
									<tr>
										<td><%= myorderdetail.FItemList(i).FItemId %></td>
										<td><img src="<%= myorderdetail.FItemList(i).FimageSmall %>" width="50" height="50" alt="<%= myorderdetail.FItemList(i).FItemName %>" onerror="this.src='http://fiximage.10x10.co.kr/web2017/my10x10/bnr_offline.png'" /></td>
										<td class="lt">
											<div><%= myorderdetail.FItemList(i).FItemName %></div>
										</td>
										<td><%= FormatNumber(myorderdetail.FItemList(i).FSellPrice,0) %>원</td>
										<td><%= myorderdetail.FItemList(i).FItemNo %></td>
										<td><%= FormatNumber(myorderdetail.FItemList(i).FSellPrice*myorderdetail.FItemList(i).FItemNo,0) %>원</td>
									</tr>
									<%
										itemtotal = itemtotal + myorderdetail.FItemList(i).FItemNo
									%>
									<% Next %>
									</tbody>
									<tfoot>
									<tr>
										<td colspan="6">
											<div class="orderSummary">
												<span>주문상품수 <strong><%=i%>종 (<%=itemtotal%>개)</strong></span>
												<span>적립 매장 마일리지 <strong><%=FormatNumber(myorder.FOneItem.Fgainmile,0)%>P</strong></span>
												<span>상품구매 총액 <strong><%=FormatNumber(myorder.FOneItem.FTotalSum,0)%>원</strong></span>
											</div>
											<div class="orderTotal">
												총 결제금액 : 상품구매총액 <strong><%=FormatNumber(myorder.FOneItem.FTotalSum,0)%></strong>원(상품수 <%=i%>종 <%=itemtotal%>개)
												<% If myorder.FOneItem.Fspendmile>0 Then %>
												- 사용 마일리지 <%=FormatNumber(myorder.FOneItem.Fspendmile,0)%>P
												<% End If %>
												 =<br/><strong class="crRed"><%=FormatNumber(myorder.FOneItem.Frealsum,0)%></strong>원
											</div>
										</td>
									</tr>
									</tfoot>
								</table>

								<div class="title">
									<h4>결제정보</h4>
								</div>
								<table class="baseTable rowTable">
								<caption>결제정보</caption>
								<colgroup>
									<col width="130" /> <col width="295" /> <col width="130" /> <col width="*" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">결제방법</th>
									<td>
										<% If myorder.FOneItem.Fjumunmethod="01" Then %>
										현금 <img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_cash.gif" alt="현금영수증 발급" />
										<% ElseIf myorder.FOneItem.Fjumunmethod="02" Then %>
										신용카드 <img class="vMiddle" src="http://fiximage.10x10.co.kr/web2013/my10x10/ico_doc_credt.gif" alt="신용카드 매출전표" />
										<% Else %>
										복합
										<% End If %>
									</td>
									<th scope="row">결제확인 일시</th>
									<td><%= myorder.FOneItem.Fshopregdate %></td>
								</tr>
								<tr>
									<th scope="row">결제금액</th>
									<td colspan="3"><% If myorder.FOneItem.Fjumunmethod="01" Then %><%= myorder.FOneItem.Fcashsum %><% ElseIf myorder.FOneItem.Fjumunmethod="02" Then %><%= myorder.FOneItem.Fcardsum %><% Else %><%= myorder.FOneItem.Fcashsum+myorder.FOneItem.Fcardsum+myorder.FOneItem.FTenGiftCardPaySum %><% End If %>원</td>
								</tr>
								</tbody>
								</table>
							</div>
						</fieldset>
					</div>
				</div>
				<!--// content -->
			</div>

		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->