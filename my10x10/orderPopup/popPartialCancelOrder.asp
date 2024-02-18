<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_couponcls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<!-- #include virtual="/cscenter/lib/csAsfunction.asp"-->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/frontGiftCls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 부분취소 접수 팝업"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim userid, orderserial, pflag
''dim checkidx, beasongpayidx
''dim isallrefund, isupbea, makeridbeasongpay, beasongmakerid, realmakeridbeasongpay, vIsPacked

userid = getEncLoginUserID()
orderserial = requestCheckvar(request("orderserial"),11)

if orderserial="" then
	Call Alert_Close("선택된 주문번호가 없습니다.")
	dbget.close()	:	response.End
end if


'==============================================================================
dim myorder
set myorder = new CMyOrder
if IsUserLoginOK() then
    '// myorder.FRectUserID = GetLoginUserID()
    myorder.FRectUserID = getEncLoginUserID()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder

elseif IsGuestLoginOK() then
    orderserial = GetGuestLoginOrderserial()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder

end if

if orderserial="" then
	Call Alert_Close("선택된 주문번호가 없습니다.")
	dbget.close()	:	response.End
end if

dim InValidPayType : InValidPayType = False
'// 실시간계좌이체, 신용카드, 무통장
if (myorder.FOneItem.Faccountdiv <> "7") and (myorder.FOneItem.Faccountdiv <> "100") and (myorder.FOneItem.Faccountdiv <> "20") then
	InValidPayType = True
end if

'// 보조결제금액 있는 결제
if (myorder.FOneItem.FsumPaymentEtc <> 0) then
	InValidPayType = True
end if

dim isNaverPay : isNaverPay = False                 ''2016/07/21 추가
isNaverPay = (myorder.FOneItem.Fpggubun="NP")

dim isTossPay : isTossPay = False                   ''2019/10/23 추가
isTossPay = (myorder.FOneItem.Fpggubun="TS")

dim isChaiPay : isChaiPay = False                   ''2020/04/24 추가
isChaiPay = (myorder.FOneItem.Fpggubun="CH")

dim isKakaoPay : isKakaoPay = False                 ''2020/12/07 추가
isKakaoPay = (myorder.FOneItem.Fpggubun="KK")

'==============================================================================
dim IsValidOrder, IsTicketOrder, IsTravelOrder
dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectOrderserial = orderserial

IsValidOrder = False
if myorder.FResultCount>0 then
	myorderdetail.FRectUserID = userid
    myorderdetail.GetOrderDetail
    IsValidOrder = True
end if


if (myorder.FResultCount<1) or (myorderdetail.FResultCount<1) Then
	response.write "<script>alert('잘못된 접속입니다.'); opener.focus(); window.close();</script>"
    dbget.close()	:	response.End
end if

if Not myorder.FOneItem.IsWebOrderPartialCancelEnable or Not myorder.FOneItem.IsRequestPartialCancelEnable(myorderdetail) then
	response.write "<script>alert('잘못된 접속입니다.'); opener.focus(); window.close();</script>"
    dbget.close()	:	response.End
end if


'==============================================================================
dim NotFinisherCancelCSMakeridList
NotFinisherCancelCSMakeridList = CheckNotFinishedCancelCSMakeridList(orderserial)


'==============================================================================
'// 신용카드 부분취소 가능한지.
dim omainpayment
dim mainpaymentorg
dim cardPartialCancelok, cardcancelerrormsg, cardcancelcount, cardcancelsum, cardcodeall

cardPartialCancelok = "N"

if (Trim(myorder.FOneItem.FAccountDiv) = "100") or (Trim(myorder.FOneItem.FAccountDiv) = "110") or isNaverPay or IsTossPay or isChaiPay or isKakaoPay then
	set omainpayment = new CMyOrder

	omainpayment.FRectOrderSerial = orderserial

	Call omainpayment.getMainPaymentInfo(myorder.FOneItem.Faccountdiv, mainpaymentorg, cardPartialCancelok, cardcancelerrormsg, cardcancelcount, cardcancelsum, cardcodeall)

    ''할불개월수
    ''installment = Right(cardcodeall,2) 14|26|00 ==> 14|26|00|1 ''마지막 코드 부분취소 가능여부 (2011-08-25)--------
    IF Not IsNULL(cardcodeall) THEN
        cardcodeall= TRIM(cardcodeall)
        cardcodeall = LEft(cardcodeall,10)   '''모바일쪽 코드 이상함 (빈값 또는 이상한 값)
    END IF

    if (LEN(TRIM(cardcodeall))=10) or (LEN(TRIM(cardcodeall))=9) then
        if (Right(Trim(cardcodeall),1)="1") then
            cardPartialCancelok = "Y"
        elseif (Right(Trim(cardcodeall),1)="0") then
            cardPartialCancelok = "N"
            if (cardcancelerrormsg="") then cardcancelerrormsg  = "부분취소 <strong>불가</strong> 거래 (충전식 카드 or 복합거래)"
        end if
    elseif (isNaverPay) and (LEN(TRIM(cardcodeall))=7) then  ''2016/07/21 추가
        if (Right(Trim(cardcodeall),1)="1") then
            cardPartialCancelok = "Y"
        end if
	elseif (IsTossPay) then
		cardPartialCancelok = "Y"
	elseif (isChaiPay) then
		cardPartialCancelok = "Y"
    elseif (isKakaoPay) then
        cardPartialCancelok = "Y"
    end if
end if


dim oGift
set oGift = new CopenGift
oGift.FRectOrderSerial = orderserial
oGift.getOpenGiftInOrder


dim i, j, k

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV18.css" />
<script language='javascript'>

function recalcPrice(obj, idx) {
	var frm = document.frmPartialCancel;
	frm.mode.value = 'recalcPrice';
	var url = "calcAjax.asp";
	var checkidx, regitemno, makerid;

	checkidx = document.getElementById('checkidx_' + idx);
	regitemno = document.getElementById('regitemno_' + idx);
	makerid = document.getElementById('makerid_' + idx);

	if (NotFinisherCancelCSMakeridList.indexOf('|' + makerid.value + '|') != -1) {
		alert('[접수불가]\n완료되지 않은 주문취소 접수건이 있습니다.\n업체에서 취소승인 후 취소추가접수 가능합니다.');
		checkidx.checked = false;
		regitemno.value = '0';
		return;
	}

	if (obj == checkidx) {
		if (regitemno.value == '0') {
			return;
		}
	} else {
		if (regitemno.value != '0') {
			checkidx.checked = true;
		} else {
			checkidx.checked = false;
		}
	}

	EnDisableRegItemNo(false);
    var param = jQuery("#frmPartialCancel").serialize();
	EnDisableRegItemNo(true);

    var ajaxCallParam = {
        url: url,
        data: param,
        type: "POST",
        beforeSend: function () { },
        success: function (data) {
			if (data.resultCode == 'ERR') { alert('잘못된 접근입니다.'); return; }
			disableidxarr = data.disableidxarr;
			EnDisableMakerID();

			var totItemPay = document.getElementById('totItemPay');
			var totDeliveryPay = document.getElementById('totDeliveryPay');
			var cancelPrdPrc = document.getElementById('cancelPrdPrc');
			var cancelDlvPrc = document.getElementById('cancelDlvPrc');
			var addDlvPrc = document.getElementById('addDlvPrc');
			var totCancelPrc = document.getElementById('totCancelPrc');
			var divRefundRequire = document.getElementById('divRefundRequire');

			totItemPay.innerHTML = data.totItemPay;
			totDeliveryPay.innerHTML = data.totDeliveryPay;
			cancelPrdPrc.innerHTML = data.cancelPrdPrc;
			cancelDlvPrc.innerHTML = data.cancelDlvPrc;
			addDlvPrc.innerHTML = data.addDlvPrc;
			totCancelPrc.innerHTML = data.totCancelPrc;
			divRefundRequire.innerHTML = data.totCancelPrc;
        },
        error: function (error) {
            alert('서버와의 통신이 원할하지 않습니다.\n다시 시도해 주십시오.');
			console.log(error);
        },
        complete: function () { }
    };

	jQuery.ajax(ajaxCallParam);
}

function EnDisableRegItemNo(enableregitemno) {
	var checkidx, regitemno, i;

	for (i = 0; ; i++) {
		checkidx = document.getElementById('checkidx_' + i);
		regitemno = document.getElementById('regitemno_' + i);

		if (checkidx == undefined) { break; }
		if (checkidx.disabled == true) { continue; }

		if (enableregitemno == true) {
			regitemno.disabled = false;
		} else {
			regitemno.disabled = checkidx.checked ? false : true;
		}
	}
}

var disableidxarr = [];
function EnDisableMakerID() {
	var i, checkidx, regitemno;
	for (i = 0; ; i++) {
		checkidx = document.getElementById('checkidx_' + i);
		regitemno = document.getElementById('regitemno_' + i);
		if (checkidx == undefined) { return; }

		if (disableidxarr.indexOf(checkidx.value) >= 0) {
			checkidx.disabled = true;
			regitemno.disabled = true;
		} else {
            if (regitemno.type == 'text') { continue; }
			checkidx.disabled = false;
			regitemno.disabled = false;
		}
	}
}

var NotFinisherCancelCSMakeridList = '<%= LCase(NotFinisherCancelCSMakeridList) %>';

function trim(value) {
	return value.replace(/^\s+|\s+$/g,"");
}

function checkSubmit(frm) {
	var i, checkidx, regitemno, checkedItemExists;
	var divRefundRequire = document.getElementById('divRefundRequire');

	<% if (oGift.FResultCount > 0) then %>
	alert('죄송합니다. 사은품이 있는 경우 부분취소 불가입니다.\n고객센터로 문의주시기 바랍니다.');
	return;
	<% end if %>
	checkedItemExists = false;
	for (i = 0; ; i++) {
		checkidx = document.getElementById('checkidx_' + i);
		regitemno = document.getElementById('regitemno_' + i);
		if (checkidx == undefined) { break; }
		if (checkidx.disabled == true) { continue; }
		if (checkidx.checked == true && regitemno.value != '0') { checkedItemExists = true; }
	}

	if (checkedItemExists != true) {
		alert('선택된 상품이 없습니다.');
		return;
	}

	if (divRefundRequire.innerHTML == '0') {
		alert('환불불가!\n환불할 금액이 없습니다.');
		return;
	}

	frm.contents_jupsu.value = trim(frm.contents_jupsu.value);
    if (frm.contents_jupsu.value.length<1){
        alert('취소 사유 및 요청 사항을 입력하세요.');
        frm.contents_jupsu.focus();
        return
    }

    if (frm.returnmethod.length==undefined){
        var returnmethod = frm.returnmethod.value;
    }else{
        var returnmethod = frm.returnmethod[getCheckedIndex(frm.returnmethod)].value;
    }

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

    if (confirm('취소신청 하시겠습니까?\n\n상품이 이미 출고된 경우, 취소가 불가할 수 있습니다.')) {

		for (i = 0; ; i++) {
			checkidx = document.getElementById('checkidx_' + i);
			regitemno = document.getElementById('regitemno_' + i);
			if (checkidx == undefined) { break; }
			if (checkidx.disabled == true) { continue; }
			if ((checkidx.checked == true) && (regitemno.value == '0')) { checkidx.checked = false; }
			if (checkidx.checked != true) { regitemno.disabled = true; }
		}

		frm.mode.value = 'partialcancel';
        frm.submit();
    }
}

</script>
</head>
<body>
	<div class="heightgird popV18 cancel">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="pop-header">
			<h1>일부취소신청</h1>
		</div>
		<div class="pop-content">
			<!-- content -->
			<div class="guidance-msg">
				<p class="txt01">취소하실 상품의 수량과 사유를 선택하세요.</p>
				<p class="txt02">무료배송 주문의 경우, 취소금액에 따라 <span class="color-red">추가배송비</span>가 발생할 수 있습니다.</p>
				<p class="txt03">일부취소는 <span class="color-red">업체별로만</span> 신청가능합니다.</p>
				<p class="txt04">주문상태가 <span class="color-red">상품준비중</span>인 경우, 이미 배송이 되어 취소가 안될 수 있습니다.(반품접수 하시기 바랍니다.)</p>
			</div>

			<form name="frmPartialCancel" id="frmPartialCancel" method="post" action="CancelOrder_process.asp">
			<input type="hidden" name="mode" value="">
			<input type="hidden" name="orderserial" value="<%= orderserial %>">
			<div class="cancel-detail">
				<div class="hgroup01">
					<h2 class="tit tit01">주문 상품 정보</h2>
				</div>
				<table class="table01">
				<caption>주문 상품 정보 목록</caption>
				<colgroup>
					<col style="width:30px">
					<col style="width:110px">
					<col style="width:70px">
					<col style="width:auto">
					<col style="width:90px">
					<col style="width:80px">
					<col style="width:100px">
					<col style="width:100px">
				</colgroup>
				<thead>
				<tr>
					<th scope="col"></th>
					<th scope="col">상품코드/배송</th>
					<th scope="col" colspan="2">상품정보</th>
					<th scope="col">판매가</th>
					<th scope="col">주문수량</th>
					<th scope="col">취소수량</th>
					<th scope="col">소계금액</th>
					<th scope="col">주문상태</th>
				</tr>
				</thead>
				<tfoot>
				<tr>
					<td colspan="9">
						선택 브랜드 결제금액 = 결제 상품금액 <span class="color-red"><span id="totItemPay" name="totItemPay"><%= FormatNumber(0,0) %></span> 원</span> + 결제 배송비 <span class="color-red"><span id="totDeliveryPay" name="totDeliveryPay"><%= FormatNumber(0,0) %></span> 원</span><br />
						취소예정 금액 = 취소 상품금액 <span class="color-red"><span id="cancelPrdPrc" name="cancelPrdPrc"><%= FormatNumber(0,0) %></span> 원</span> + 취소 배송비 <span class="color-red"><span id="cancelDlvPrc" name="cancelDlvPrc"><%= FormatNumber(0,0) %></span> 원</span><br />
						추가배송비 금액 = <span class="color-red"><span id="addDlvPrc" name="addDlvPrc"><%= FormatNumber(0,0) %></span> 원</span>
						<div class="total">환불 예정 금액 = <span class="color-red fs18"><span id="totCancelPrc" name="totCancelPrc"><%= FormatNumber(0,0) %></span> 원</span></div>
					</td>
				</tr>
				</tfoot>
				<tbody>
				<% for i=0 to myorderdetail.FResultCount-1 %>
				<tr>
					<td>
						<% if (IsNull(myorderdetail.FItemList(i).Fcurrstate) or myorderdetail.FItemList(i).Fcurrstate <> "7") and myorderdetail.FItemList(i).IsRequireCancelEnable then %>
						<input type="checkbox" name="checkidx" id="checkidx_<%= i %>" value="<%= myorderdetail.FItemList(i).Fidx %>" title="취소할 상품 선택" onClick="recalcPrice(this, <%= i %>);" />
						<input type="hidden" name="makerid" id="makerid_<%= i %>" value="<%= myorderdetail.FItemList(i).FMakerid %>">
                        <% else %>
                        <input type="checkbox" name="checkidx" id="checkidx_<%= i %>" disabled />
						<% end if %>
					</td>
					<td>
						<div><%=myorderdetail.FItemList(i).FItemid%></div>
						<div>
							<% if myorderdetail.FItemList(i).Fisupchebeasong="N" then %>
								텐바이텐배송
							<% elseif myorderdetail.FItemList(i).Fisupchebeasong="Y" then %>
								업체개별배송
							<% end if %>
						</div>
					</td>
					<td><img src="<%= myorderdetail.FItemList(i).FImageSmall %>" width="50" height="50" alt="<%= myorderdetail.FItemList(i).FItemName %>" /></td>
					<td class="lt">
						<div>[<%= myorderdetail.FItemList(i).FMakerid %>]</div>
						<div><%= myorderdetail.FItemList(i).FItemName %></div>
						<% if myorderdetail.FItemList(i).FItemoptionName <> "" then %>
						<div><strong>옵션 : <%= myorderdetail.FItemList(i).FItemoptionName %></strong></div>
						<% end if %>
					</td>
					<td>
						<%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
					</td>
					<td>
						<%= myorderdetail.FItemList(i).FItemNo %>
					</td>
					<td>
						<% if (IsNull(myorderdetail.FItemList(i).Fcurrstate) or myorderdetail.FItemList(i).Fcurrstate <> "7") and myorderdetail.FItemList(i).IsRequireCancelEnable then %>
						<select name="regitemno" id="regitemno_<%= i %>" onChange="recalcPrice(this, <%= i %>)">
							<option value="0">0</option><% for j = myorderdetail.FItemList(i).FItemNo to 1 step -1 %><option value="<%= j %>"><%= j %></option><% next %>
						</select>
                        <% else %>
                        <input type="text" name="regitemno" id="regitemno_<%= i %>" value="0" size="1" disabled readonly />
						<% end if %>
					</td>
					<td>
						<%= FormatNumber(myorderdetail.FItemList(i).FItemCost*myorderdetail.FItemList(i).FItemNo,0) %> <%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
						<% if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
						<p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice*myorderdetail.FItemList(i).FItemNo,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
						<% end if %>
					</td>
					<td>
						<%= myorderdetail.FItemList(i).GetItemDeliverStateName(myorder.FOneItem.FIpkumDiv, myorder.FOneItem.FCancelyn) %>
						<% if Not myorderdetail.FItemList(i).IsRequireCancelEnable then %>
						<br /><font color="red"><%= myorderdetail.FItemList(i).GetRequireCancelUnableReason %></font>
						<% end if %>
					</td>
				</tr>
				<% next %>
				</tbody>
				</table>

				<div class="hgroup01">
					<h2 class="tit tit01">취소 상세 정보</h2>
				</div>
				<fieldset>
				<legend>취소 상세 정보 입력 폼</legend>
					<table class="table02">
					<caption>환불정보</caption>
					<colgroup>
						<col style="width:140px">
						<col style="width:190px">
						<col style="width:330px">
						<col style="width:auto">
					</colgroup>
					<tbody>
					<tr>
						<th scope="row">취소사유</th>
						<td colspan="3">
							<div class="radio-box">
								<input type="radio" id="returnType1" name="gubuncode" value="C004|CD01" onClick="RecalcuPartialCancelPrice(frmPartialCancel);fnPartialCancelReasonSelect(this.value);" checked /><label for="returnType1">구매의사 없음(단순변심)</label>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="ruturnReason">취소 사유 및<br> 기타 요청사항</label></th>
						<td colspan="3" class="lt">
							<textarea id="ruturnReason" name="contents_jupsu" cols="60" rows="8" style="width:686px; height:188px;"></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row">결제정보</th>
						<td colspan="3" class="lt">
							<%= myorder.FOneItem.GetAccountdivName %> 결제
						</td>
					</tr>
					<tr>
						<th scope="row">환불방법</th>
						<td colspan="3" class="lt">
							<div class="radio-box">
								<% if (isNaverPay) then %>
									<% if myorder.FOneItem.FAccountDiv="100" then %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R120" checked><label for="refundWay1">네이버페이 (부분)취소</label>
									<% else %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R022" checked><label for="refundWay1">네이버페이 (부분)취소</label>
									<% end if %>
								<% elseif (isTossPay) then %>
									<% if myorder.FOneItem.FAccountDiv="100" then %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R120" checked><label for="refundWay1">토스페이 (부분)취소</label>
									<% else %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R022" checked><label for="refundWay1">토스페이 (부분)취소</label>
									<% end if %>
								<% elseif (isChaiPay) then %>
									<% if myorder.FOneItem.FAccountDiv="100" then %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R120" checked><label for="refundWay1">차이페이 (부분)취소</label>
									<% else %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R022" checked><label for="refundWay1">차이페이 (부분)취소</label>
                                    <% end if %>
							    <% elseif (isKakaoPay) then %>
									<% if myorder.FOneItem.FAccountDiv="100" then %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R120" checked><label for="refundWay1">카카오페이 (부분)취소</label>
									<% else %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R022" checked><label for="refundWay1">카카오페이 (부분)취소</label>
							    	<% end if %>
								<% else %>
									<% if cardPartialCancelok = "Y" then %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R120" checked><label for="refundWay1">신용카드 (부분)취소</label>
									<% end if %>
									<input type="radio" id="refundWay2" name="returnmethod" value="R007" <% if cardPartialCancelok = "Y" then %>disabled<% else %>checked<% end if %> ><label for="refundWay2">무통장입금</label>
								<% end if %>


								<% if (userid<>"") then %>
									<input type="radio" id="refundWay3" name="returnmethod" value="R910" <% if cardPartialCancelok = "Y" then %>disabled<% end if %> ><label for="refundWay3">예치금 적립</label>
								<% end if %>
							</div>
						</td>
					</tr>
					<% if cardPartialCancelok <> "Y" then %>
					<tr id="divAccount1">
						<th scope="row">환불 계좌 정보</th>
						<td class="lt ">
							<% Call DrawBankCombo("rebankname","") %>
						</td>
						<td class="lt">
							<label for="accountNum" class="bulletDot fs12">계좌번호</label>
							<input type="text" id="accountNum" name="rebankaccount" value="" class="txt-inp focusOn" style="width:218px;" autocomplete="off" />
						</td>
						<td class="lt">
							<label for="accountHolder" class="bulletDot fs12">예금주</label>
							<input type="text" id="accountHolder" name="rebankownername" class="txt-inp focusOn" style="width:93px;" />
						</td>
					</tr>
					<% end if %>
					<tr>
						<th scope="row">환불 예정 금액</th>
						<td colspan="3" class="lt">
							<input type="hidden" name="refundrequire" value="0" >
							<strong id="divRefundRequire" class="crRed">0</strong>원
							&nbsp;
							<span id="imsg"></span>
						</td>
					</tr>
					</tbody>
					</table>
				</fieldset>
			</div>
			</form>

			<div class="tMar30 bMar25 ct">
				<p class="fs14">상품이 이미 출고된 경우, <span class="color-red">취소가 불가</span>할 수 있습니다.</p>
				<button style="width:400px; margin-top:30px" onclick="checkSubmit(frmPartialCancel);return false;" class="btn01 btn-red">일부취소 신청하기</button>
			</div>
			<!-- //content -->
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
