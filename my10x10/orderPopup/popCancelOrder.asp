<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/frontGiftCls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cancelOrderLib.asp" -->
<%
'####### 선물포장은 전체취소만 가능.

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 주문취소 팝업"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


'// ============================================================================
dim orderserial, mode
orderserial = requestCheckvar(request("orderserial"),11)
mode = requestCheckvar(request("mode"),11)

if (mode = "so") then
	'// 품절취소
	mode = "stockoutcancel"
	if IsAllStockOutCancel(orderserial) = True then
		mode = "socancelorder"
	end if
else
	'// 주문취소
	mode = "cancelorder"
end if


'// ============================================================================
dim IsAllCancelProcess, IsPartCancelProcess, IsStockoutCancelProcess, isEvtGiftDisplay

IsAllCancelProcess = ((mode = "socancelorder") or (mode = "cancelorder"))
IsPartCancelProcess = (mode = "stockoutcancel")
IsStockoutCancelProcess = ((mode = "socancelorder") or (mode = "stockoutcancel"))
isEvtGiftDisplay = IsAllCancelProcess


'// ============================================================================
dim userid
userid = getEncLoginUserID()

dim myorder
set myorder = new CMyOrder

if (IsUserLoginOK()) then
    myorder.FRectUserID = userid
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
elseif (IsGuestLoginOK()) then
    orderserial = GetGuestLoginOrderserial()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
end if

dim myorderdetail
set myorderdetail = new CMyOrder

if (IsUserLoginOK()) then
    myorderdetail.FRectOrderserial = orderserial
elseif (IsGuestLoginOK()) then
    myorderdetail.FRectOrderserial = GetGuestLoginOrderserial()
end if

if (myorder.FResultCount>0) then
	myorderdetail.FRectUserID = userid
    myorderdetail.GetOrderDetail
end if


'// ============================================================================
dim IsCancelOK, CancelFailMSG

IsCancelOK = True
CancelFailMSG = ""


'// ============================================================================
'// 주문상태 체크
CancelFailMSG = OrderCancelValidMSG(myorder, myorderdetail, IsAllCancelProcess, IsPartCancelProcess, IsStockoutCancelProcess)
if CancelFailMSG <> "" then
	IsCancelOK = False
end if


'// ============================================================================
'// 환불 가능한지
dim IsCancelOrderByOne : IsCancelOrderByOne = False
if IsCancelOK then
	'// 한방 주문 전체취소인지
	IsCancelOrderByOne = GetIsCancelOrderByOne(myorder, mode)
end if

dim validReturnMethod : validReturnMethod = "R000"
if IsCancelOK then
	validReturnMethod = GetValidReturnMethod(myorder, IsCancelOrderByOne)
end if

if (validReturnMethod = "FAIL") then
	IsCancelOK = False
	CancelFailMSG = "웹취소 불가 주문입니다. <a href='javascript:GotoCSCenter()'><font color='blue'>1:1 상담</font></a> 또는 고객센터로 문의주세요."
end if


'// ============================================================================
if (myorder.FResultCount<1) and (myorderdetail.FResultCount<1) then
    response.write "<script language='javascript'>alert('주문 내역이 없거나 취소된 거래건 입니다.');</script>"
    response.write "<script language='javascript'>window.close();</script>"
    dbget.close()	:	response.End
end if

'###########기존 부분취소 건 이 있으면 실시간 취소 안됨.########### ==>원 승인금액과 현재 결제금액이 다른지체크 (원승인금액이 필요)
''if (userid <> "10x10green") and (myorder.FOneItem.Faccountdiv<>"7") and (myorder.getPreCancelorAddItemCount>0) then
''    response.write "<script language='javascript'>alert('기존 부분 변경/취소 내역이 있어 취소가 불가합니다. 고객센터로 문의해 주세요.');</script>"
''    response.write "<script language='javascript'>window.close();</script>"
''    dbget.close()	:	response.End
''end if


'// ============================================================================
'// 핸드폰 결제 취소일과 결제일 비교. UP이 취소월이 결제월보다 뒤
Dim vIsMobileCancelDateUpDown
'If myorder.FOneItem.Faccountdiv = "400" AND DateDiff("m", myorder.FOneItem.FIpkumDate, Now) = 0 Then
If myorder.FOneItem.Faccountdiv = "400" AND DateDiff("m", myorder.FOneItem.FIpkumDate, Now) > 0 Then
	vIsMobileCancelDateUpDown = "UP"
Else
	vIsMobileCancelDateUpDown = "DOWN"
End If


'// ============================================================================
dim returnmethod, returnmethodstring, returnmethodhelpstring
dim ismoneyrefundok			'무통장, 마일리지 환불 가능한지


if IsCancelOK then
	returnmethod = validReturnMethod
end if

ismoneyrefundok = false
if returnmethod = "R007" then
	ismoneyrefundok = true
end if

if (myorder.FOneItem.IsNPayCancelRequire(true)) and (returnmethod <> "R007") then

	returnmethodstring		= "네이버페이 취소"

	returnmethodhelpstring	= "- 간편 신용카드/체크카드 : 취소 완료 후 3~5영업일 이후 환불(승인/매입 구분 불가)<br />"
	returnmethodhelpstring	= returnmethodhelpstring & "- 간편 계좌이체 : 취소 완료 즉시 환불(단, 은행 정기점검시간등에는 환불 실패)<br />"
	returnmethodhelpstring	= returnmethodhelpstring & "- 네이버페이 포인트 : 취소 완료 즉시 환불<br /><br />"
	returnmethodhelpstring	= returnmethodhelpstring & "[은행 점검 관련]<br />"
	returnmethodhelpstring	= returnmethodhelpstring & "1. 정기 점검 시간 : 23시 30분 ~ 00시 30분<br />"
	returnmethodhelpstring	= returnmethodhelpstring & "2. 추가 점검 시간: 정기 점검 시간 외에 은행별 추가 점검 시간에는 해당 은행을 이용하기 어렵습니다.<br />"
	returnmethodhelpstring	= returnmethodhelpstring & "&nbsp; - 우리은행 : 매월 두 번째 토요일 23시 30분 ~ 일요일 06시까지<br />"
	returnmethodhelpstring	= returnmethodhelpstring & "&nbsp; - 농협은행 : 매월 세 번째 일요일 23시 30분 ~ 월요일 04시까지"

elseif (myorder.FOneItem.IsTossPayCancelRequire(true)) and (returnmethod <> "R007") then

	returnmethodstring		= "토스페이 (부분)취소"

elseif (myorder.FOneItem.IsCardCancelRequire(true)) and (myorder.FOneItem.Faccountdiv<>"80") and (returnmethod <> "R007") then

	if (myorder.FOneItem.Faccountdiv="80") then
		''returnmethod			= "R080"
		''returnmethodstring		= "올엣카드 승인취소"

		''returnmethodhelpstring	= "카드 승인 취소는 취소 접수후 영업일 7시 이전에 일괄 취소 됩니다.<br>"
		''returnmethodhelpstring	= returnmethodhelpstring + "카드사에 기 매입 처리된 거래는 별도 취소 매입이 이루어져야 하는 만큼 최장 5일 정도 소요가 됩니다.<br><br>"
		''returnmethodhelpstring	= returnmethodhelpstring + "매입 후 취소의 경우: <br>"
		''returnmethodhelpstring	= returnmethodhelpstring + "고객이 카드청구서를 받으셨다 하더라도, 카드 결제일 4~5일 전에 취소매입이 완료될 시는 카드대금을 납부하지 않으셔도 됩니다. <br>"
		''returnmethodhelpstring	= returnmethodhelpstring + "이미 청구액이 고객통장에서 빠져나간 경우는 다음달에 결제구좌로 환급 처리됩니다"
	else
		if (returnmethod = "R100") then
			returnmethodstring		= "카드승인 취소"
		else
			returnmethodstring		= "카드승인 부분취소"
		end if

		returnmethodhelpstring	= returnmethodhelpstring + "카드 승인 취소는 취소 접수후 영업일 7시 이전에 일괄 취소 됩니다.<br>"
		returnmethodhelpstring	= returnmethodhelpstring + "카드사에 기 매입 처리된 거래는 별도 취소 매입이 이루어져야 하는 만큼 최장 5일 정도 소요가 됩니다. <br>"
		returnmethodhelpstring	= returnmethodhelpstring + "매입 후 취소의 경우:<br />"
		returnmethodhelpstring	= returnmethodhelpstring + "고객이 카드청구서를 받으셨다 하더라도, 카드 결제일 4~5일 전에 취소매입이 완료될 시는 카드대금을 납부하지 않으셔도 됩니다.<br />"
		returnmethodhelpstring	= returnmethodhelpstring + "(단 BC카드의 경우 익월 결제일에 환급됨. 1588-4500으로 문의 하시기 바랍니다.)<br />"
		returnmethodhelpstring	= returnmethodhelpstring + "이미 청구액이 고객통장에서 빠져나간 경우는 다음달에 결제구좌로 환급 처리됩니다.<br />"
	end if

elseif (myorder.FOneItem.IsMobileCancelRequire(true)) and (returnmethod <> "R007") then

	returnmethodstring		= "핸드폰 결제 취소"

elseif (myorder.FOneItem.IsRealTimeAcctCancelRequire(true)) and (returnmethod <> "R007") then

	returnmethodstring		= "실시간이체 취소"

	returnmethodhelpstring	= "접수 익일(영업일 기준) 이체하신 계좌로 환불 됩니다."
elseif (myorder.FOneItem.IsInirentalCancelRequire(true)) and (returnmethod <> "R007") then
	returnmethodstring		= "이니렌탈 취소"

elseif (myorder.FOneItem.IsAcctRefundRequire(true)) or (returnmethod = "R007") then

	returnmethodhelpstring = ""
	returnmethodhelpstring = returnmethodhelpstring + "* 계좌번호 등록시에는 <font color='red'>대시(-)를 제외한 숫자만</font> 입력해주시기 바랍니다.<br>"
	returnmethodhelpstring = returnmethodhelpstring + "* <font color='red'>계좌번호 및 예금주명</font>이 정확하지 않으면 입금이 지연될 수 있으니, 정확한 입력 부탁드립니다.<br>"
	returnmethodhelpstring = returnmethodhelpstring + ""
	returnmethodhelpstring = returnmethodhelpstring + "<font color='#000000'>"
	returnmethodhelpstring = returnmethodhelpstring + "* 접수 후, 1-2일내에(영업일기준) 등록하신 계좌로 환불되며, 환불시 문자메세지로 안내해 드립니다."
	returnmethodhelpstring = returnmethodhelpstring + "</font>"

elseif (returnmethod = "R000") then

	returnmethodhelpstring = ""

else

    response.write "<script language='javascript'>alert('처리도중 오류가 발생했습니다. 고객센터로 문의 주시기 바랍니다.');</script>"
    response.write "<script language='javascript'>window.close();</script>"
    dbget.close()	:	response.End

end if

if ((myorder.FOneItem.Fsubtotalprice - myorder.FOneItem.FsumPaymentEtc) < 1) then
	returnmethod		= "R000"
	returnmethodstring	= "환불없음"
	ismoneyrefundok = false
end if


dim IsAllCancelAvail, IsAllCancelAvailMSG

IsAllCancelProcess = IsCancelOK
IsAllCancelAvail = IsCancelOK
IsAllCancelAvailMSG = CancelFailMSG


'###########기존 부분취소 건 이 있으면 실시간 취소 안됨.########### ==>원 승인금액과 현재 결제금액이 다른지체크 (원승인금액이 필요)
''if (myorder.FOneItem.Faccountdiv<>"7") and (myorder.FOneItem.Faccountdiv<>"100") and (myorder.getPreCancelorAddItemCount>0) and (mode = "cancelorder" or mode = "socancelorder") then
''    response.write "<script language='javascript'>alert('기존 부분 변경/취소 내역이 있어 취소가 불가합니다. 고객센터로 문의해 주세요.');</script>"
''    response.write "<script language='javascript'>window.close();</script>"
''    dbget.close()	:	response.End
''end ifend if


''신용카드 전체취소 : 입금후 취소, 취소가능상태, 결제완료이상, 카드결제 o, 전체취소
''IsCardCancelRequire()

''환불 필요 : 입금후 취소, 취소가능상태, 결제완료이상, (카드결제 o, 부분취소인경우) or (카드결제 x)
''IsRefundRequire()

''입금전 취소
''Not IsPayed



dim stockoutBeasongPay : stockoutBeasongPay = 0
if ((mode = "stockoutcancel") or (mode = "socancelorder")) then
	stockoutBeasongPay = GetStockOutCancelBeasongPay(orderserial)
end if


dim i, j, refundrequire, subttlitemsum


'############################## 핸드폰 결제 취소일과 결제일 비교. UP이 취소월이 결제월보다 뒤 ##############################

Dim IsWebEditEnabled
IsWebEditEnabled = true

Dim MyOrdActType

'// 이니렌탈 월 납입금액, 렌탈 개월 수 가져오기
dim iniRentalInfoData, tmpRentalInfoData, iniRentalMonthLength, iniRentalMonthPrice
iniRentalInfoData = fnGetIniRentalOrderInfo(orderserial)
If instr(lcase(iniRentalInfoData),"|") > 0 Then
	tmpRentalInfoData = split(iniRentalInfoData,"|")
	iniRentalMonthLength = tmpRentalInfoData(0)
	iniRentalMonthPrice = tmpRentalInfoData(1)
Else
	iniRentalMonthLength = ""
	iniRentalMonthPrice = ""
End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script>

function GotoCSCenter() {
    opener.location.href = "/my10x10/qna/myqnalist.asp";
}

function AllCancelProc(frm){
    var returnmethod;

    if (frm.returnmethod.length==undefined){
        returnmethod = frm.returnmethod.value;
    }else{
        for (var i=0;i<frm.returnmethod.length;i++){
            if (frm.returnmethod[i].checked){
                returnmethod = frm.returnmethod[i].value;
            }
        }
    }


    if ((returnmethod!="R000")&&(frm.refundrequire.value*1<1)){
        alert('취소/환불 가능액이 없습니다. - 고객센터로 문의해 주세요.');
        return;
    }

    //무통장 환불
    if (returnmethod=="R007"){
        if (frm.rebankname.value.length<1){
            alert('환불 받으실 은행을 선택하세요');
            frm.rebankname.focus();
            return
        }

		frm.rebankaccount.value = frm.rebankaccount.value.replace(/-/g, "");

        if (frm.rebankaccount.value.length<8){
            alert('환불 받으실 계좌를 입력하세요');
            frm.rebankaccount.focus();
            return
        }

        if (!IsDigit(frm.rebankaccount.value)){
            alert('계좌번호는 숫자만 가능합니다');
            frm.rebankaccount.focus();
            return
        }

        if (frm.rebankownername.value.length<1){
            alert('예금주를 입력하세요.');
            frm.rebankownername.focus();
            return
        }

    }

    //마일리지로 적립
    if (returnmethod=="R900"){

    }

    if (confirm('주문을 취소 하시겠습니까?')){
        frm.submit();
    }
}

function showAcct(comp){
    if (comp.value=="R007"){
		$("#divAccount1").show();
    }else{
		$("#divAccount1").hide();
    }
}

var IsTenMoneyNotiShowed = false;

function toggleTenMoneyNoti() {
	if (IsTenMoneyNotiShowed == true) {
		hideTenMoneyNoti();
		IsTenMoneyNotiShowed = false;
	} else {
		showTenMoneyNoti();
		IsTenMoneyNotiShowed = true;
	}
}

function showTenMoneyNoti(){
    var comp = document.getElementById("idtenMoney");
    comp.style.visibility = "visible";
}

function hideTenMoneyNoti(){
    var comp = document.getElementById("idtenMoney");
    comp.style.visibility = "hidden";
}

$(document).ready(function() {
	$("#divAccount1 select").addClass("select").css("width:106px;");
});

</script>
</head>
<body>
	<div class="heightgird">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_cancel_popup.gif" alt="주문취소" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<div class="guidanceMsg">
						<h2>
							<%= myorder.FOneItem.GetAccountdivName %>
							<% if (myorder.FOneItem.IsPayed) then response.write " 결제 후" else response.write " 결제 전" %>
							<% if (IsAllCancelProcess and (mode = "cancelorder" or mode = "socancelorder")) then response.write " 주문 취소" else response.write " 상품 취소" %>
						</h2>
						<ul class="list">
							<% if (mode = "cancelorder" or mode = "socancelorder") then %>
							<li>사용하신 예치금, 마일리지 및 할인권은 취소 즉시 복원 됩니다.</li>
							<% end if %>
	<% if (myorder.FOneItem.Faccountdiv="7") then %>
		<% if (Not (myorder.FOneItem.IsPayed)) then %>
							<li>주문접수 상태 주문취소입니다</li>
		<% else %>
							<li>무통장 결제 후 취소시 접수 즉시 취소 됩니다. </li>
			<% if ((myorder.FOneItem.FsubTotalPrice - myorder.FOneItem.FsumPaymentEtc) <> 0) then %>
							<li>접수 후, 1-2일내에(영업일기준) 등록하신 계좌로 환불되며, 환불시 문자메세지로 안내해 드립니다.</li>
			<% end if %>
		<% end if %>
	<% else %>
		<% if (myorder.FOneItem.Faccountdiv <> "400") then %>
			<% if myorder.FOneItem.Fpggubun<>"NP" then %>
							<li>결제 후 취소시 신용카드 취소는 카드 승인 취소로 접수되며, 실시간 이체는 이체 취소로 접수됩니다. </li>
							<li>카드및 실시간 이체 취소는 접수 후 최대 5일(영업일 기준) 소요될 수 있습니다.</li>
			<% else %>
							<li>간편 신용카드/체크카드는 최대 3~5영업일 이후 환불되며, 간편계좌이체의 경우 즉시 환불처리됩니다.(은행 정기점검시간은 예외)</li>
			<% end if %>
		<% else %>
							<li>핸드폰 결제는 결제 월과 동일한 월말일까지 가능하며, 익월 1일부터는 취소하더라도 취소가 불가능하게 됩니다.</li>
							<li>익월 취소시 환불은 고객님의 계좌로 환불이 됩니다.</li>
							<li>부분취소의 경우 무통장으로 환불됩니다.</li>
			<% If vIsMobileCancelDateUpDown = "UP" Then %>
							<li>현재 주문건은 <span class="crRed">전월에 핸드폰 결제된 주문</span>이므로 즉시 취소는 불가능하고 <span class="crRed">고객님의 계좌로 환불</span>이 됩니다.</li>
			<% End If %>
		<% end if %>
	<% end if %>
						</ul>
					</div>
	<% if (Not IsAllCancelProcess) or (Not IsAllCancelAvail) then %>
						<h2>
							<span class="crRed">주문 취소 가능 상태가 아닙니다. - <%= IsAllCancelAvailMSG %></span>
						</h2>
						<script language='javascript'>
						alert('주문 취소 가능 상태가 아닙니다.');
						</script>
	<% end if %>

					<!-- #include virtual ="/my10x10/order/inc/inc_orderitemlist_box_by_mode.asp" -->

					<div class="etcInfo">

						<!-- #include virtual ="/my10x10/order/inc/inc_orderbuyerinfo_box.asp" -->

						<!-- #include virtual ="/my10x10/order/inc/inc_orderpaymentinfo_box.asp" -->

						<form name="frmCancel" method="post" action="CancelOrder_process.asp">
						<% IF vIsPacked = "Y" Then %><input type="hidden" name="ispacked" value="Y"><% End IF %>
						<input type="hidden" name="orderserial" value="<%= orderserial %>">
						<input type="hidden" name="mode" value="<%= mode %>">
						<input type="hidden" name="IsMobileCancelDateUpDown" value="<%=vIsMobileCancelDateUpDown%>">
	<% if (Not (myorder.FOneItem.IsPayed)) or ((myorder.FOneItem.Faccountdiv="7") and (myorder.FOneItem.FsubTotalPrice=0))  then %>
						<!-- 결제 전 취소 -->
						<input type="hidden" name="returnmethod" value="R000" >
						<input type="hidden" name="refundrequire" value="0"  >
	<%
	else
		if (mode = "cancelorder") or (mode = "socancelorder") then
			'// inc_orderitemlist_box_by_mode.asp 에서 생성한다.
			vItemReducedPriceSUM = myorder.FOneItem.Fsubtotalprice - myorder.FOneItem.FsumPaymentEtc
		end if
	%>
						<input type="hidden" name="refundrequire" value="<%= vItemReducedPriceSUM %>"  >

						<h2>환불정보</h2>
						<table class="baseTable rowTable">
						<caption>환불정보</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">환불금액</th>
							<td colspan="3" class="lt">
								<strong class="fs12 crRed"><%= FormatNumber((vItemReducedPriceSUM), 0) %></strong> 원
                                <% if (myorder.FOneItem.FsumPaymentEtc > 0) and ((mode = "cancelorder") or (mode = "socancelorder")) then %>
                                (사용 예치금 또는 기프트카드금액 : <%= FormatNumber(myorder.FOneItem.FsumPaymentEtc,0) %> 원 - 주문취소시 즉시 환원됩니다.)
                                <% end if %>
							</td>
						</tr>
		<% if (ismoneyrefundok = true) then %>
						<tr>
							<th scope="row">환불방법</th>
							<td colspan="3" class="lt">
								<div class="radioBox fs12">
									<input type="radio" name="returnmethod" id="refundWay1" value="R007" checked onClick="showAcct(this);" /><label for="refundWay1">계좌환불</label>
									<% if (userid<>"") then %>
									<input type="radio" name="returnmethod" id="refundWay2" value="R910" onClick="showAcct(this);"><label for="refundWay2">예치금전환</label>

									<a href="javascript:toggleTenMoneyNoti();" class="btn btnS2 btnGry2"><span class="fn">예치금안내</span></a>
									<div id="idtenMoney" style="position:absolute;  width:320px; visibility:hidden;z-index:1000;">
										<iframe scrolling="no" frameborder="0" style="position:absolute;width:320px; height:125px; top:0px; left:0px; z-index:1000; border:none; display:block; filter:alpha(opacity=0)" ></iframe>
										<table width="100%" border="0" cellspacing="0" cellpadding="0">
											<tr>
												<td bgcolor="#FFFFFF" style="padding:15px;border:4px solid #eeeeee;">
													<table width="100%" border="0" cellspacing="0" cellpadding="0" >
														<tr>
															<td>
																<strong class="crRed">예치금</strong>은 텐바이텐 온라인 쇼핑몰에서 현금처럼 사용할 수 있는 금액으로 , 최소구매금액 제한 없이 언제라도 사용 가능합니다<br><br>
																예치금의 자세한 내용은 <a href="<%= wwwUrl %>/my10x10/myTenMoney.asp" target="_blank"><strong>my텐바이텐 &gt; 예치금 현황</strong></a>에서 확인 가능합니다.</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</div>
									<% end if %>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">환불 계좌 정보</th>
							<td colspan="3" class="lt fs12">
								<%= returnmethodhelpstring %>
							</td>
						</tr>
						<tr id="divAccount1">
							<th scope="row">환불 계좌 정보</th>
							<td class="lt ">
								<label class="bulletDot fs12">입금은행</label>
								<% Call DrawBankCombo("rebankname","") %>
							</td>
							<td class="lt">
								<label for="accountNum" class="bulletDot fs12">계좌번호</label>
								<input type="text" id="accountNum" name="rebankaccount" value="" class="txtInp focusOn fs11 ftDotum" style="width:218px;" autocomplete="off" />
							</td>
							<td class="lt">
								<label for="accountHolder" class="bulletDot fs12">예금주</label>
								<input type="text" id="accountHolder" name="rebankownername" class="txtInp focusOn" style="width:93px;" />
							</td>
						</tr>
		<% else %>
						<input type="hidden" name="returnmethod" value="<%= returnmethod %>" >
						<tr>
							<th scope="row">환불방법</th>
							<td colspan="3" class="lt"><%= returnmethodstring %></td>
						</tr>
						<tr>
							<th scope="row">환불 계좌 정보</th>
							<td colspan="3" class="lt fs12">
								<%= returnmethodhelpstring %>
							</td>
						</tr>
		<% end if %>
						</tbody>
						</table>

	<% end if %>

				<% If vIsPacked = "Y" Then

					dim ii,opackmaster, guestSessionID
					guestSessionID = GetGuestSessionKey
					set opackmaster = new Cpack
						opackmaster.FRectUserID = userid
						opackmaster.FRectSessionID = guestSessionID
						opackmaster.FRectOrderSerial = orderserial
						opackmaster.FRectCancelyn = "N"
						opackmaster.FRectSort = "ASC"
						opackmaster.Getpojang_master()
				%>
					<div class="title">
						<h4>선물포장 정보 확인</h4>
					</div>
					<table class="baseTable rowTable">
						<caption>선물포장 정보</caption>
						<colgroup><col width="130" /> <col width="*" /></colgroup>
						<tbody>
						<tr>
							<th scope="row">포장내역</th>
							<td><%=packcnt%>개 <%= FormatNumber(packpaysum,0) %>원</td>
						</tr>
						<tr>
							<th scope="row">입력 메세지</th>
							<td class="fs11 lh19">
								<%
								If opackmaster.FResultCount > 0 Then
									For ii=0 To opackmaster.FResultCount-1
										Response.Write "<p><strong>[" & opackmaster.FItemList(ii).Ftitle & "]</strong> " & opackmaster.FItemList(ii).Fmessage & "</p>" & vbCrLf
									Next
								End If
								%>
							</td>
						</tr>
					<%
						Set opackmaster = Nothing
					End If %>
					</tbody>
					</table>

					</div>

					</form>

					<% if (IsAllCancelProcess) and (IsAllCancelAvail) then %>
					<div class="btnArea ct tPad25">
						<a href="javascript:AllCancelProc(document.frmCancel);" class="btn btnS1 btnRed btnW160">주문취소</a>
					</div>
					<% end if %>
				</div>
				<!-- //content -->
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
<%

set myorder = Nothing
set myorderdetail = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
