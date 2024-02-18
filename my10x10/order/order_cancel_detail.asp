<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 주문 취소"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_orderList_v1.jpg"
	strPageDesc = "주문취소접수(Web)와 취소내역을 조회할수 있습니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 주문 취소"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/order/order_cancel_detail.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/frontGiftCls.asp" -->
<!-- #include virtual="/inipay/iniWeb/aspJSON1.17.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cancelOrderLib.asp" -->
<%
Dim IsValidOrder : IsValidOrder = False   '''정상 주문인가.
Dim IsBiSearch   : IsBiSearch   = False   '''비회원 주문인가.
Dim IsTicketOrder : IsTicketOrder = FALSE ''티켓주문인가
Dim IsTravelOrder : IsTravelOrder = FALSE ''여행상품인가
Dim isEvtGiftDisplay : isEvtGiftDisplay = TRUE		''사은품 표시 여부
dim mode : mode = "cancelorder"

dim i, j
dim userid, orderserial
dim etype

userid = getEncLoginUserID()
orderserial  = requestCheckVar(request("idx"),11)
etype        = requestCheckVar(request("etype"),10)

if (orderserial = "") then
	orderserial = requestCheckVar(request("orderserial"), 11)
end if

if requestCheckVar(request("mode"),2) = "so" then
	mode = "stockout"
end if


dim myorder
set myorder = new CMyOrder

if IsUserLoginOK() then
        myorder.FRectUserID = getEncLoginUserID()
        myorder.FRectOrderserial = orderserial
        myorder.GetOneOrder
elseif IsGuestLoginOK() then
        myorder.FRectOrderserial = GetGuestLoginOrderserial()
        myorder.GetOneOrder

        IsBiSearch = True
        orderserial = myorder.FRectOrderserial
end if

dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectOrderserial = orderserial

if myorder.FResultCount>0 then
	myorderdetail.FRectUserID = userid
    myorderdetail.GetOrderDetail
    IsValidOrder = True

    IsTicketOrder = myorder.FOneItem.IsTicketOrder
    IsTravelOrder = myorder.FOneItem.IsTravelOrder
end if

dim oSubPayment
set oSubPayment = new CMyOrder
oSubPayment.FRectOrderserial = orderserial
oSubPayment.getSubPaymentList

if (Not myorder.FOneItem.IsValidOrder) then
    IsValidOrder = False
    'response.write "<script language='javascript'>alert('취소된 주문건 또는 올바른 주문이 아닙니다.');</script>"
end if

dim ocslist, IsCSASCancelRequireListExists
IsCSASCancelRequireListExists = False

Dim IsWebEditEnabled
'// MyOrdActType : /lib/inc/incMytentenHeader.asp 에서 생성
IsWebEditEnabled = (MyOrdActType = "E")

If myorder.FOneItem.FAccountDiv="150" Then
	'// 이니렌탈 월 납입금액, 렌탈 개월 수 가져오기
	dim iniRentalInfoData, tmpRentalInfoData, iniRentalMonthLength, iniRentalMonthPrice, iniRentalAesEncodeTid, iniRentalMid, strData, oJSON
	iniRentalInfoData = fnGetIniRentalOrderInfo(orderserial)
	If instr(lcase(iniRentalInfoData),"|") > 0 Then
		tmpRentalInfoData = split(iniRentalInfoData,"|")
		iniRentalMonthLength = tmpRentalInfoData(0)
		iniRentalMonthPrice = tmpRentalInfoData(1)
	Else
		iniRentalMonthLength = ""
		iniRentalMonthPrice = ""
	End If
	strData = ""
	iniRentalMid = ""
	Call fnGetIniRentalAesEncodeTid(myorder.FOneItem.Fpaygatetid,strData,iniRentalMid)
	Set oJSON = New aspJSON
	oJSON.loadJSON(strData)
	iniRentalAesEncodeTid = oJSON.data("output")
	Set oJSON = Nothing
	iniRentalAesEncodeTid = Server.URLEncode(iniRentalAesEncodeTid)
End If

dim IsAddSongjangExist : IsAddSongjangExist = False

'response.write myorder.FOneItem.Fpaygatetid&"<br>"&strData&"<br>"&iniRentalMid
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script type="text/javascript">
$(function() {
	$('.infoMoreViewV15').mouseover(function(){
		$(this).children('.infoViewLyrV15').show();
	});
	$('.infoMoreViewV15').mouseleave(function(){
		$(this).children('.infoViewLyrV15').hide();
	});
});

//이니렌탈 매출전표 PopUp
function receiptinirental(tid, mid){
	var receiptUrl = "https://inirt.inicis.com/statement/v1/statement?mid=" + mid +"&encdata=" + tid;
	var popwin = window.open(receiptUrl,"receiptinirental","width=670,height=670,scrollbars=yes,resizable=yes");
	popwin.focus();
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
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_cancel.gif" alt="주문취소" /></h3>
						<ul class="list">
							<li>주문번호를 검색하시면, 주문건에 대한 취소가능여부를 안내해드립니다. (주문검색 버튼을 눌러주세요)</li>
							<li>고객님이 직접 주문취소가 가능합니다. <em class="crRed">일부취소를 원하시는 경우, 고객센터로 문의 부탁드립니다.</em></li>
							<li>상품 일부만 취소하고자 하시는 경우, [1:1 상담] 또는 [고객센터]로 문의주시기 바랍니다.</li>
							<li>'상품 포장 중'인 상품의 경우, [1:1 상담] 또는 [고객센터]를 통해 취소가 가능하며, 고객센터에서 배송 시작 여부를 확인 후에 취소여부를 안내해드립니다.</li>
							<li>이미 출고된 상품이 있는 경우 주문을 취소할 수 없습니다. 반품 메뉴를 이용하시기 바랍니다.</li>
							<li>품절된 상품이나 출고가 지연된 상품은 고객님이 직접 상품취소가 가능합니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<fieldset>
						<legend>주문번호 검색</legend>

							<!-- #include virtual ="/my10x10/order/inc/inc_ordersearch_box.asp" -->

							<% if (IsTicketOrder) then %>
								<%
									if (Not myorder.FOneItem.IsWebOrderCancelEnable) then
										if (myorder.FOneItem.FticketCancelDisabled) then
								%>
							<ul class="list">
								<li><strong class="crRed">티켓 주문</strong>의 경우 아래 예매 취소 유의사항을 참고 하시기 바랍니다.( <%= myorder.FOneItem.FticketCancelStr %> )</li>
							</ul>
								<%
										else
								%>
							<ul class="list">
								<li><strong class="crRed">티켓 주문</strong>의 경우 아래 예매 취소 유의사항을 참고 하시어 고객센터 또는 1:1상담으로 문의 하시기 바랍니다.<br /><%= myorder.FOneItem.FticketCancelStr %> 취소 수수료 <%= myorder.FOneItem.FmayTicketCancelChargePro %>% 차감 후 환불해 드립니다.</li>
							</ul>
								<%
										end if
									else
								%>
							<ul class="list">
								<li><strong class="crRed">티켓 주문</strong>의 경우 아래 예매 취소 유의사항을 참고 하시기 바랍니다.</li>
							</ul>
								<%
									end if
								%>
							<% end if %>
							<% if (IsTravelOrder) then %>
							<ul class="list">
								<li>본 상품은 특별 구성된 상품으로, 별도의 환불규정이 적용되어 취소수수료가 발생될 수 있습니다. 해당 상품페이지 내 유의사항/취소/환불 규정을 확인해주세요.</li>
							</ul>
							<% end if %>

<% if (isValidOrder) then %>

							<!-- #include virtual ="/my10x10/order/inc/inc_orderitemlist_box.asp" -->

							<%
							if myorder.FOneItem.IsWebOrderCancelEnable or _
								(myorder.FOneItem.IsWebOrderPartialCancelEnable) or _
								(ChkStockoutItemExist(myorderdetail) and (myorder.FOneItem.IsWebStockOutItemCancelEnable) and (myorder.FOneItem.IsDirectStockOutPartialCancelEnable(myorderdetail))) then
							%>

							<% if mode = "cancelorder" then %>
							<ul class="list">
								<li>사용하신 예치금, 마일리지 및 할인권은 취소 즉시 복원 됩니다.</li>
								<li><em class="crRed">주문제작상품</em>의 특성상 제작이 들어간 경우, 취소가 불가능할 수 있습니다.</li>
								<li>보너스쿠폰 중 금액할인쿠폰을 사용하여 복수의 상품을 구매 하시는 경우, 상품별 판매가에 따라 쿠폰할인금액이 각각 분할되어 적용됩니다.</li>
							</ul>
							<% end if %>

							<div class="btnArea ct tPad25">
								<% if mode = "cancelorder" then %>
								<% if myorder.FOneItem.IsWebOrderCancelEnable then %>
								<a href="javascript:popCancel('<%= myorder.FOneItem.FOrderSerial %>');" class="btn btnS1 btnRed btnW175" title="주문 전체취소하기">주문취소</a>
								<% end if %>
								<% if myorder.FOneItem.IsWebOrderPartialCancelEnable and myorder.FOneItem.IsRequestPartialCancelEnable(myorderdetail) and myorder.FOneItem.IsChargeFreebiesItemExistsCheck(myorderdetail) then %>
								<a href="javascript:popPartialCancel('<%= myorder.FOneItem.FOrderSerial %>');" class="btn btnS1 btnRed btnW175" title="주문 일부취소신청하기">일부취소신청</a>
								<% end if %>
								<% end if %>
								<% if mode = "stockout" or ((myorder.FOneItem.IsValidOrder) and (myorder.FOneItem.IsWebStockOutItemCancelEnable) and (myorder.FOneItem.IsDirectStockOutPartialCancelEnable(myorderdetail))) then %>
								<a href="javascript:popSoldOutCancel('<%= myorder.FOneItem.FOrderSerial %>');" class="btn btnS1 btnRed btnW175" title="품절상품 취소">품절상품 취소</a>
								<% end if %>
							</div>

							<% end if %>

							<!-- #include virtual ="/my10x10/order/inc/inc_orderpaymentinfo_box.asp" -->

<% end if %>
						</fieldset>
					</div>

<% if IsTicketOrder then %>

					<!-- #include virtual ="/cscenter/help/help_order_refundTicket.asp" -->

<% else %>
					<!-- #include virtual ="/cscenter/help/help_order_detail.asp" -->
<% end if %>

				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%

set myorder = Nothing
set myorderdetail = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
