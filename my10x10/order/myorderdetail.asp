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
<!-- #include virtual="/lib/inc/incForceSSL.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/frontGiftCls.asp" -->
<!-- #include virtual="/inipay/iniWeb/aspJSON1.17.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
Dim IsValidOrder : IsValidOrder = False	 '''정상 주문인가
Dim IsBiSearch	 : IsBiSearch	 = False	 '''비회원 주문인가
Dim IsTicketOrder : IsTicketOrder = FALSE ''티켓주문인가
Dim isEvtGiftDisplay : isEvtGiftDisplay = TRUE		''사은품 표시 여부

dim i, j
dim userid, orderserial, etype
dim pflag, cflag
dim tensongjangdiv

userid		 = getEncLoginUserID()
orderserial	= requestCheckVar(request("idx"),11)
etype		= requestCheckVar(request("etype"),10)
pflag		= requestCheckVar(request("pflag"),10)
cflag		= requestCheckVar(request("cflag"),10)

if (orderserial = "") then
	orderserial = requestCheckVar(request("orderserial"), 11)
end if

Dim kakaoPayCid, strSql, orderTempIdx, chaiPublicApiKey
if (application("Svr_Info")="Dev") then
	kakaoPayCid = "TC0ONETIME"'//테스트용
	chaiPublicApiKey = "459aae6c-2212-4e2f-9f81-d662e4df4709"'//테스트용
ElseIf (application("Svr_Info")="Staging") Then
	'kakaoPayCid = "TC0ONETIME"'//테스트용
	kakaoPayCid = "C371930065"'//실결제용
	chaiPublicApiKey = "c8aff30b-cc9b-4d03-bb4b-168e8db10d30"'//실서버용
Else
	kakaoPayCid = "C371930065"'//실결제용
	chaiPublicApiKey = "c8aff30b-cc9b-4d03-bb4b-168e8db10d30"'//실서버용
End If

dim myorder
set myorder = new CMyOrder
myorder.FRectOldjumun = CHKIIF(pflag="P","on","")

if IsUserLoginOK() then
	myorder.FRectUserID = userid
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
myorderdetail.FRectOldjumun = CHKIIF(pflag="P","on","")

if myorder.FResultCount>0 then
	myorderdetail.FRectUserID = userid
	myorderdetail.GetOrderDetail
	IsValidOrder = True

	IsTicketOrder = myorder.FOneItem.IsTicketOrder
end if

if (Not myorder.FOneItem.IsValidOrder) then
	IsValidOrder = False
end if

Dim IsWebEditEnabled
IsWebEditEnabled = (MyOrdActType = "E")

Dim iRegedCsCNT : iRegedCsCNT=0		 '''CS 접수 건수
IF (IsValidOrder) then
	iRegedCsCNT = getHisRegedCsCount(myorder.FRectUserID,myorder.FRectOrderserial,"")
end If

'// 카카오페이는 temp_idx값이 있어야 영수증 발급이 가능하여 해당 부분 가져옴
strSql = "SELECT TOP 1 temp_idx from db_order.dbo.tbl_order_temp WITH (NOLOCK) WHERE orderserial='"&orderserial&"' "
rsget.Open strSql,dbget,1
if Not(rsget.EOF or rsget.BOF) then
	orderTempIdx = rsget(0)
end if
rsget.Close

'네비바 내용 작성
'strMidNav = "MY 쇼핑리스트 > <b>주문배송조회</b>"

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

'// 이니렌탈 매출전표 관련 mid값과 encdata 생성
if (myorder.FOneItem.FAccountDiv="150") then
	Dim iniRentalAesEncodeTid, oJSON, strData, iniRentalMid
	Call fnGetIniRentalAesEncodeTid(myorder.FOneItem.Fpaygatetid,strData,iniRentalMid)
	Set oJSON = New aspJSON
	oJSON.loadJSON(strData)
	iniRentalAesEncodeTid = oJSON.data("output")
	Set oJSON = Nothing

	'// 이니시스에 전송하기 위해선 urlencode를 함
	iniRentalAesEncodeTid = Server.URLEncode(iniRentalAesEncodeTid)
End If

dim oAddSongjang
dim IsAddSongjangExist : IsAddSongjangExist = False
set oAddSongjang = new CMyOrder

if myorder.FResultCount > 0 then
    oAddSongjang.FRectOrderSerial = orderserial
    oAddSongjang.GetAddSongjangList()

    if (oAddSongjang.FResultCount > 0) then
        IsAddSongjangExist = True
    end if
end if

'2020-10-20 상단 UI추가 정태훈
dim orderState
dim CurrStateCnt1 : CurrStateCnt1 = 0
dim CurrStateCnt2 : CurrStateCnt2 = 0
dim CurrStateCnt3 : CurrStateCnt3 = 0
dim CurrStateCnt4 : CurrStateCnt4 = 0
dim CurrStateCnt5 : CurrStateCnt5 = 0

if ((myorder.FOneItem.FCancelyn="Y") or (myorder.FOneItem.FCancelyn="D")) then'취소
	orderState = "E"
elseif ((myorder.FOneItem.Fjumundiv="6") or (myorder.FOneItem.Fjumundiv="9")) then'교환/반품
	orderState = "E"
else
	if (myorder.FOneItem.FIpkumDiv="0") then'결제오류
		orderState = "E"
	elseif (myorder.FOneItem.FIpkumDiv="1") then'주문실패
		orderState = "E"
	elseif (myorder.FOneItem.FIpkumDiv="2") or (myorder.FOneItem.FIpkumDiv="3") then'결제 대기 중
		orderState = "S"
	else
		orderState = "S"
		for i=0 to myorderdetail.FResultCount-1
			if (IsNull(myorderdetail.FItemList(i).Fcurrstate) or (myorderdetail.FItemList(i).Fcurrstate="0")) and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") then'결제완료
				if myorderdetail.FItemList(i).Fisupchebeasong="Y" then
					CurrStateCnt1=CurrStateCnt1+1
				else
					if (datediff("n",myorder.FOneItem.FIpkumDate,now()) >= 30) then
						CurrStateCnt2=CurrStateCnt2+1
					else
						CurrStateCnt1=CurrStateCnt1+1
					end if
				end if
			elseif myorderdetail.FItemList(i).Fcurrstate="2" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") then'상품 확인 중
				if myorderdetail.FItemList(i).Fisupchebeasong="Y" then
					CurrStateCnt2=CurrStateCnt2+1
				else
					if (datediff("n",myorder.FOneItem.Fbaljudate,now()) >= 30) then
						CurrStateCnt3=CurrStateCnt3+1
					else
						CurrStateCnt2=CurrStateCnt2+1
					end if
				end if
			elseif myorderdetail.FItemList(i).Fcurrstate="3" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") then'상품 포장 중
				CurrStateCnt3=CurrStateCnt3+1
			elseif myorderdetail.FItemList(i).Fcurrstate="7" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") and IsNull(myorderdetail.FItemList(i).Fdlvfinishdt) then'배송 시작
				CurrStateCnt4=CurrStateCnt4+1
			elseif myorderdetail.FItemList(i).Fcurrstate="7" and (myorderdetail.FItemList(i).Fcancelyn="N" or myorderdetail.FItemList(i).Fcancelyn="A") and not IsNull(myorderdetail.FItemList(i).Fdlvfinishdt) then'배송 완료
				CurrStateCnt5=CurrStateCnt5+1
			end if
		next
	end if
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

// 올앳카드 매출전표 팝업
function receiptallat(tid){
	var receiptUrl = "http://www.allatpay.com/servlet/AllatBizPop/member/pop_card_receipt.jsp?" +
		"shop_id=10x10_2&order_no=" + tid;
	var popwin = window.open(receiptUrl,"app","width=410,height=650,scrollbars=0");
	popwin.focus();
}

// 신용카드 매출전표 팝업_이니시스
function receiptinicis(tid){
	var receiptUrl = "https://iniweb.inicis.com/app/publication/apReceipt.jsp?" +
		"noTid=" + tid + "&noMethod=1";
	var popwin = window.open(receiptUrl,"INIreceipt","width=415,height=600");
	popwin.focus();
}

// 신용카드 전표 분기.
function receiptCardRedirect(iorderserial, tid){
	var receiptUrl = "/my10x10/receipt/pop_CardReceipt.asp?orderserial=" + iorderserial +"&tid=" + tid;
	var popwin = window.open(receiptUrl,"pop_CardReceipt","width=415,height=600,scrollbars=yes,resizable=yes");
	popwin.focus();
}

// 네이버페이 전표 팝업
function receiptNaverpay(iorderserial, tid){
	alert("[네이버페이 > 결제내역]에서 확인 하실 수 있습니다.");
	window.open("https://order.pay.naver.com/home");
	//window.open("https://m.pay.naver.com/o/home");
	return;
	var receiptUrl = "/inipay/naverpay/pop_CardReceipt.asp?orderserial=" + iorderserial +"&tid=" + tid;
	var popwin = window.open(receiptUrl,"pop_CardReceipt","width=780,height=830,scrollbars=yes,resizable=yes");
	popwin.focus();
}

// 페이코 전표 팝업
function receiptPayco(iorderserial, tid){
	<% if (application("Svr_Info")="Dev") then %>
		var receiptUrl = "https://alpha-bill.payco.com/outseller/receipt/"+tid;
	<% else %>
		var receiptUrl = "https://bill.payco.com/outseller/receipt/"+tid;
	<% end if %>
	var popwin = window.open(receiptUrl,"Paycoreceipt","width=415,height=600");
	popwin.focus();
}

// 카카오페이 신규 전표 팝업
function receiptKakaoPay(iorderserial, tid, hashValue){
	<% if (application("Svr_Info")="Dev") then %>
	var receiptUrl = "https://mockup-pg-web.kakao.com/v1/confirmation/p/"+tid+"/"+hashValue;
	<% else %>
	var receiptUrl = "https://pg-web.kakao.com/v1/confirmation/p/"+tid+"/"+hashValue;
	<% end if %>
	var popwin = window.open(receiptUrl,"KakaoPayreceipt","width=415,height=600");
	popwin.focus();
}

// 토스 전표 팝업
function receiptTossPay(tid){
	<% if (application("Svr_Info")="Dev") then %>
	var receiptUrl = "https://pay.toss.im/payfront/web/external/sales-check?payToken="+tid;
	<% else %>
	var receiptUrl = "https://pay.toss.im/payfront/web/external/sales-check?payToken="+tid;
	<% end if %>
	var popwin = window.open(receiptUrl,"Tossreceipt","width=415,height=600");
	popwin.focus();
}

// 차이 전표 팝업
function receiptChaiPay(tid){
	<% if (application("Svr_Info")="Dev") then %>
	var receiptUrl = "https://payment.chai.finance/receipt?publicAPIKey=<%=chaiPublicApiKey%>&idempotencykey="+tid;
	<% else %>
	var receiptUrl = "https://payment.chai.finance/receipt?publicAPIKey=<%=chaiPublicApiKey%>&idempotencykey="+tid;
	<% end if %>
	var popwin = window.open(receiptUrl,"Chaireceipt","width=415,height=600");
	popwin.focus();
}

// 신용카드 매출전표 팝업_KCP
function receiptkcp(tid){
	var receiptUrl = "https://admin.kcp.co.kr/Modules/Sale/CARD/ADSA_CARD_BILL_Receipt.jsp?" +
		"c_trade_no=" + tid + "&mnu_no=AA000001";
	var popwin = window.open(receiptUrl,"KCPreceipt","width=415,height=600");
	popwin.focus();
}

// 신용카드 매출전표 팝업_KAKAO
function receiptKakao(tid){
	var status = "toolbar=no,location=no,directories=no,status=yes,menubar=no,scrollbars=yes,resizable=yes,width=420,height=540";
	var url = "https://mms.cnspay.co.kr/trans/retrieveIssueLoader.do?TID="+tid+"&type=0";
	var popwin = window.open(url,"popupIssue",status);
	popwin.focus();
}

// 세금계산서 요청 팝업
function taxreceipt(orderserial, mflag){
	var receiptUrl = "/my10x10/taxSheet/pop_taxOrder.asp?orderserial=" + orderserial;
	var popwin = window.open(receiptUrl,"Taxreceipt","width=518,height=400,scrollbars=yes");
	popwin.focus();

	/* 팝업창에서 체크
	//분기
	switch(mflag)
	{
		case "new":
			var receiptUrl = "/my10x10/taxSheet/pop_taxOrder.asp?orderserial=" + orderserial;
			var popwin = window.open(receiptUrl,"Taxreceipt","width=518,height=400,scrollbars=yes");
			popwin.focus();
			break;
		case "print":
			var receiptUrl = "/my10x10/taxSheet/pop_taxPrint.asp?orderserial=" + orderserial;
			var popwin = window.open(receiptUrl,"view","width=800,height=620,status=no, scrollbars=auto, menubar=no");
			popwin.focus();
			break;
	}
	*/
}

// 전자보증서 팝업
function insurePrint(orderserial, mallid){
	var receiptUrl = "https://gateway.usafe.co.kr/esafe/ResultCheck.asp?oinfo=" + orderserial + "|" + mallid
	var popwin = window.open(receiptUrl,"insurePop","width=518,height=400,scrollbars=yes,resizable=yes");
	popwin.focus();
}

//뱅크페이 현금영수증
function receiptbankpay(tid){
	var receiptUrl = "http://www.bankpay.or.kr/pgmember/customcashreceipt.jsp?bill_key1=" + tid;
	var popwin = window.open(receiptUrl,"BankPayreceipt","width=400,height=560");
	popwin.focus();
}

//현금영수증 신청 or PopUp - 이니시스 실시간이체 or 무통장
function cashreceipt(iorderserial){
	var receiptUrl = "/inipay/receipt/checkreceipt.asp?orderserial=" + iorderserial;
	var popwin = window.open(receiptUrl,"Cashreceipt","width=670,height=260,scrollbars=yes,resizable=yes");
	popwin.focus();
}

//이니렌탈 매출전표 PopUp
function receiptinirental(tid, mid){
	var receiptUrl = "https://inirt.inicis.com/statement/v1/statement?mid=" + mid +"&encdata=" + tid;
	var popwin = window.open(receiptUrl,"receiptinirental","width=670,height=670,scrollbars=yes,resizable=yes");
	popwin.focus();
}

function jumunreceipt(orderserial,pflag){
	var receiptUrl = "myorder_receipt.asp?idx=" + orderserial + "&pflag=" + pflag;
	var popwin = window.open(receiptUrl,"orderreceipt","width=925,height=800, scrollbars=yes, resizabled=yes");
	popwin.focus();
}


function fnGoEditOrder(comp, idx){
	if (comp.value.length>0){
		if (comp.value=="cncl"){
			location.href="/my10x10/order/order_cancel.asp?idx=" + idx;
		}else{
			location.href="/my10x10/order/order_info_edit.asp?idx=" + idx + "&etype=" + comp.value;
		}
	}
}

function popEditHandMadeReq(orderserial,idx){
	var popwin = window.open('/my10x10/orderPopup/popEditHandMadeReq.asp?orderserial=' + orderserial + '&idx=' + idx,'popEditHandMadeReq','width=420,height=400,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function popTicketPlace(iplaceIdx){
	var popwin = window.open('/my10x10/popTicketPLace.asp?placeIdx='+iplaceIdx,'popTicketPlace','width=750,height=700,scrollbars=yes,resizable=yes');
	popwin.focus();
}
function popMyOrderNo(){
	var f = document.frmOrdSearch;
	var url = "/my10x10/orderPopup/popMyOrderNo.asp?frmname=" + f.name + "&targetname=" + f.orderserial.name;
	var popwin = window.open(url,'popMyOrderNo','width=750,height=565,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function getRecentOrder(){
	var frm = document.frmDumi;
	frm.target="FrameRctOrd";
	frm.action="/my10x10/order/inc/ifraRecentOrd.asp";
	frm.submit();
}

function goOrdSearch(iordno){
	if (iordno!=''){
		var f = document.frmOrdSearch;
		f.orderserial.value=iordno;
		f.submit();
	}
}

function editPhotolooks(orderserial, didx, itemid, itemoption, orgfile){
	var ws = screen.width * 0.8;
	var hs = screen.height * 0.8;
	var winspec = "width="+ ws + ",height="+ hs +",top=10,left=10, menubar=no,toolbar=no,scroolbars=no,resizable=yes";
	var popwin = window.open("/shopping/fuji/photolooks.asp?orderserial=" + orderserial + "&didx=" + didx + "&itemid="+ itemid +"&itemoption="+ itemoption +"&orgfile="+orgfile, "photolooks", winspec)
	popwin.focus();
}

function popEditOrderInfo(orderserial,etype){
	var popwin = window.open('/my10x10/orderPopup/popEditOrderInfo.asp?orderserial=' + orderserial + '&etype=' + etype,'popEditOrderInfo','width=800,height=800,scrollbars=yes,resizable=yes');
	popwin.focus();
}
</script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap skinBlue">
		<div id="contentWrap">
			<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_detail_check.gif" alt="주문상세조회" /></h3>
						<ul class="list">
							<% if Not(IsValidOrder) and (orderserial<>"") then %>
							<li><b>본 주문은 취소된 주문건이거나 올바른 주문이 아닙니다.</b></li>
							<% end if %>
							<li>주문건의 상세정보(상품별 배송현황)입니다.</li>
							<li>주문사항에 대한 변경 및 수정이 필요하신 경우, 주문검색 후 [신청가능한 서비스]를 이용하시면 빠른 처리가 가능합니다.</li>
							<li>반품의 경우, 상품출고일 기준으로 7일 이내(평일기준)에 접수 및 환불이 가능합니다.</li>
							<li>상품 교환은 1:1 상담으로 문의해주시기 바랍니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<fieldset>
						<legend>주문번호 검색</legend>
						<!-- #include virtual ="/my10x10/order/inc/inc_ordersearch_box.asp" -->

<% if (IsValidOrder) or (pflag="C") then %>
							<div class="orderDetail">

<!-- #include virtual ="/my10x10/order/inc/inc_orderitemlist_box.asp" -->

<!-- #include virtual ="/my10x10/order/inc/inc_orderbuyerinfo_box.asp" -->

<!-- #include virtual ="/my10x10/order/inc/inc_orderpaymentinfo_box.asp" -->

<!-- #include virtual ="/my10x10/order/inc/inc_orderrefundinfo_box.asp" -->

<!-- #include virtual ="/my10x10/order/inc/inc_orderreceiverinfo_box.asp" -->

<!-- /////////////////////////////////////////////////////////////////////////////// -->
<% if (myorder.FOneItem.IsRequireDetailItemExists(myorderdetail)) or (myorder.FOneItem.IsPhotoBookItemExists(myorderdetail)) then %>

	<!-- #include virtual ="/my10x10/order/inc/inc_orderhandmadeinfo_box.asp" -->

<% end if %>

<%'// 해외 직구 %>
<!-- #include virtual ="/my10x10/order/inc/inc_DirectPurchase_box.asp" -->
							</div>
							<% If IsValidOrder THEN %>
							<div class="btnArea overHidden tPad20">
								<div class="ftLt">
								<!-- All@ 결제일 경우 -->
								<% if (trim(myorder.FOneItem.Faccountdiv)="80") and (myorder.FOneItem.FIpkumDiv >= 4) then %>
									<a href="javascript:receiptallat('<%= myorder.FOneItem.Fpaygatetid %>')" title="새창에서 열림" class="btn btnS2 btnBlue"><span class="fn">신용카드매출전표</span></a>
								<% end if %>

								<!-- 신용카드 결제일 경우 -->
								<% if ((myorder.FOneItem.FAccountDiv="100") or (myorder.FOneItem.FAccountDiv="110")) and (myorder.FOneItem.FIpkumDiv >= 4) then %>
									<% if myorder.FOneItem.Fpaygatetid<>"" then %>
										<% if (myorder.FOneItem.Fpggubun = "KA") then %>
											<a href="javascript:receiptCardRedirect('<%= myorder.FOneItem.ForderSerial %>','<%= myorder.FOneItem.Fpaygatetid %>')" title="새창에서 열림" class="btn btnS2 btnBlue"><span class="fn">신용카드매출전표</span></a>
										<% elseif (myorder.FOneItem.Fpggubun = "NP") then %>
											<a href="javascript:receiptNaverpay('<%= myorder.FOneItem.ForderSerial %>','<%= myorder.FOneItem.Fpaygatetid %>')" title="새창에서 열림" class="btn btnS2 btnBlue"><span class="fn">신용카드매출전표</span></a>
										<% elseif (myorder.FOneItem.Fpggubun = "PY") then %>
											<a href="javascript:receiptPayco('<%= myorder.FOneItem.ForderSerial %>','<%= myorder.FOneItem.Fpaygatetid %>')" title="새창에서 열림" class="btn btnS2 btnBlue"><span class="fn">신용카드매출전표</span></a>
										<% elseif (myorder.FOneItem.Fpggubun = "KK") then %>
											<a href="javascript:receiptKakaoPay('<%= myorder.FOneItem.ForderSerial %>','<%= myorder.FOneItem.Fpaygatetid %>','<%=SHA256(CStr(kakaoPayCid&myorder.FOneItem.Fpaygatetid&"temp"&orderTempIdx&userid))%>')" title="새창에서 열림" class="btn btnS2 btnBlue"><span class="fn">신용카드매출전표</span></a>
										<% elseif (myorder.FOneItem.Fpggubun = "TS") then %>
											<a href="javascript:receiptTossPay('<%= myorder.FOneItem.Fpaygatetid %>')" title="새창에서 열림" class="btn btnS2 btnBlue"><span class="fn">신용카드매출전표</span></a>
										<% elseif (Left(myorder.FOneItem.Fpaygatetid,9)="IniTechPG") or (Left(myorder.FOneItem.Fpaygatetid,5)="INIMX") or (Left(myorder.FOneItem.Fpaygatetid,10)="INIpayRPAY") or (Left(myorder.FOneItem.Fpaygatetid,6)="Stdpay") or (Left(myorder.FOneItem.Fpaygatetid,3)="cns") or (Left(myorder.FOneItem.Fpaygatetid,5)="KCTEN") then %>
											<a href="javascript:receiptCardRedirect('<%= myorder.FOneItem.ForderSerial %>','<%= myorder.FOneItem.Fpaygatetid %>')" title="새창에서 열림" class="btn btnS2 btnBlue"><span class="fn">신용카드매출전표</span></a>
										<% else %>
											<a href="javascript:receiptkcp('<%= myorder.FOneItem.Fpaygatetid %>')" title="새창에서 열림" class="btn btnS2 btnBlue"><span class="fn">신용카드매출전표</span></a>
										<% end if %>
									<% end if %>
								<% end if %>
								<!-- 전자보증보험 -->
								<% if (myorder.FOneItem.IsInsureDocExists) then %>
									<a href="javascript:insurePrint('<%= myorder.FOneItem.ForderSerial %>','ZZcube1010')" title="새창에서 열림" class="btn btnS2 btnOlive"><span class="fn">전자보증보험</span></a>
								<% End If %>

								<!-- 현금결제 -->
								<% if (myorder.FOneItem.IsPaperRequestExist) then %>
									<% if (myorder.FOneItem.IsPaperFinished) then %>
										<% if (myorder.FOneItem.GetPaperType="R") then %>
											<% IF (myorder.FOneItem.IsDirectBankCashreceiptExists) then %>
												<a href="javascript:receiptinicis('<%= myorder.FOneItem.Fpaygatetid %>');" title="새창에서 열림" class="btn btnS2 btnMint"><span class="fn">현금영수증</span></a>
											<% else %>
												<% If myorder.FOneItem.Fpggubun = "KK" Then %>
													<a href="" onclick="alert('카카오페이는 카카오톡내 페이에서 확인하실 수 있습니다.');return false;" title="새창에서 열림" class="btn btnS2 btnMint"><span class="fn">현금영수증</span></a>
												<% ElseIf myorder.FOneItem.Fpggubun = "TS" Then %>
													<a href="" onclick="alert('토스 앱에서 확인하실 수 있습니다.');return false;" title="새창에서 열림" class="btn btnS2 btnMint"><span class="fn">현금영수증</span></a>
												<% ElseIf myorder.FOneItem.Fpggubun = "CH" Then %>
													<a href="" onclick="alert('차이 앱에서 확인하실 수 있습니다.');return false;" title="새창에서 열림" class="btn btnS2 btnMint"><span class="fn">현금영수증</span></a>
												<% Else %>
													<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>');" title="새창에서 열림" class="btn btnS2 btnMint"><span class="fn">현금영수증</span></a>
												<% End If %>
											<% end if %>
											<% if (myorder.FOneItem.FcashreceiptReq="J") then %>(자진발급)<% end if %>
										<% elseif (myorder.FOneItem.GetPaperType="T") then %>
											<% If myorder.FOneItem.Fpggubun = "KK" Then %>
												<a href="" onclick="alert('카카오페이는 카카오톡내 페이에서 확인하실 수 있습니다.');return false;" title="새창에서 열림" class="btn btnS2 btnGrn2"><span class="fn">세금계산서</span></a>
											<% ElseIf myorder.FOneItem.Fpggubun = "TS" Then %>
												<a href="" onclick="alert('토스 앱에서 확인하실 수 있습니다.');return false;" title="새창에서 열림" class="btn btnS2 btnGrn2"><span class="fn">세금계산서</span></a>
											<% ElseIf myorder.FOneItem.Fpggubun = "CH" Then %>
												<a href="" onclick="alert('차이 앱에서 확인하실 수 있습니다.');return false;" title="새창에서 열림" class="btn btnS2 btnGrn2"><span class="fn">세금계산서</span></a>
											<% Else %>
												<a href="javascript:cashreceipt('<%= myorder.FOneItem.ForderSerial %>');" title="새창에서 열림" class="btn btnS2 btnGrn2"><span class="fn">세금계산서</span></a>
											<% End If %>
									<% end if %>
								<% end if %>
							<% end if %>
								</div>

								<div class="ftRt">
								<% if (IsTicketOrder) then %>
									<a href="javascript:jumunreceipt('<%= myorder.FOneItem.ForderSerial %>','<%= pflag %>')" title="새창에서 열림" class="btn btnS2 btnRed"><span class="fn whiteArr01">예매확인서</span></a>
								<% else %>
									<a href="javascript:jumunreceipt('<%= myorder.FOneItem.ForderSerial %>','<%= pflag %>')" title="새창에서 열림" class="btn btnS2 btnGry"><span class="fn whiteArr01">거래 내역서</span></a>
								<% end if %>
								</div>
							</div>
							<% end if %>
						</fieldset>
					</div>
<% end if %>
<% if IsTicketOrder then %>

		<!-- #include virtual ="/cscenter/help/help_order_refundTicket.asp" -->

<% else %>

		<!-- #include virtual ="/cscenter/help/help_order_detail.asp" -->

<% end if %>

<form name="frmprt" method="post" >
<input type="hidden" name="idx" value="<%= orderserial %>">
</form>
<%
set myorder = Nothing
set myorderdetail = Nothing
%>
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
