<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 마이텐바이텐 - 반품 Step3
' History : 2018.10.15 원승현 생성
'           2019.11.29 한용민 수정
'####################################################
%>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_couponcls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<!-- #include virtual="/cscenter/lib/csAsfunction.asp"-->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 반품접수 팝업"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim userid,orderserial,pflag
dim checkidx, beasongpayidx
dim isallrefund, isupbea, makeridbeasongpay, beasongmakerid, realmakeridbeasongpay, vIsPacked

userid = getEncLoginUserID()
orderserial = request.Form("orderserial")
checkidx    = request.Form("checkidx")

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

dim isTossPay : isTossPay = False                   ''2019/10/24 추가
isTossPay = (myorder.FOneItem.Fpggubun="TS")

dim isChaiPay : isChaiPay = False                   ''2020/12/07 추가
isChaiPay = (myorder.FOneItem.Fpggubun="CH")

dim isKakaoPay : isKakaoPay = False                 ''2020/12/07 추가
isKakaoPay = (myorder.FOneItem.Fpggubun="KK")

'==============================================================================
dim myorderdetail
set myorderdetail = new CCSASList
myorderdetail.FRectOrderserial = orderserial
myorderdetail.FRectIdxArray = checkidx

if (myorder.FResultCount>0) Then
    myorderdetail.GetOrderDetailWithReturnDetail
else

end if

if (myorder.FResultCount<1) or (myorderdetail.FResultCount<1) Then
	response.write "<script>alert('잘못된 접속입니다.'); opener.focus(); window.close();</script>"
    dbget.close()	:	response.End

end if


'==============================================================================
isupbea = "N"
beasongmakerid = ""
for i = 0 to myorderdetail.FResultCount - 1
	if myorderdetail.FItemList(i).Fisupchebeasong = "Y" then
		isupbea = "Y"
		beasongmakerid = myorderdetail.FItemList(i).FMakerid
		exit for
	end if
next


Call myorderdetail.GetOrderDetailRefundBeasongPay(isallrefund, makeridbeasongpay, isupbea, beasongmakerid, orderserial, checkidx)
realmakeridbeasongpay = myorderdetail.getUpcheBeasongPayOneBrand(beasongmakerid)

dim i, subttlitemsum



dim IsUpcheBeasong, IsTenBeasong
IsUpcheBeasong  = false
IsTenBeasong    = false

dim ReturnMakerid, ReturnItemNo



'==============================================================================
Dim detailDeliveryName, detailSongjangNo, detailDeliveryTel

detailDeliveryName	= myorderdetail.FitemList(0).FDeliveryName
detailSongjangNo	= myorderdetail.FitemList(0).FsongjangNo
detailDeliveryTel	= myorderdetail.FitemList(0).FDeliveryTel

isupbea				= myorderdetail.FitemList(0).Fisupchebeasong
beasongmakerid		= myorderdetail.FitemList(0).Fmakerid

dim OCSBrandMemo, CUSTOMER_RETURN_DENY
set OCSBrandMemo = new CCSBrandMemo

OCSBrandMemo.FRectMakerid = beasongmakerid
OCSBrandMemo.GetBrandMemo

CUSTOMER_RETURN_DENY = False
IF OCSBrandMemo.Fcustomer_return_deny = "Y" then
    '// 고객 직접반품 불가 브랜드
    CUSTOMER_RETURN_DENY = True
end if



'==============================================================================
''사용한 할인권 내역
dim OCoupon
set OCoupon = new CCoupon
OCoupon.FRectUserID      = userid
OCoupon.FRectOrderserial = orderserial
OCoupon.FRectIsUsing     = "Y"   ''사용했는지여부
OCoupon.FRectDeleteYn    = "N"
OCoupon.getOneUserCoupon



'==============================================================================
''기존 반품내역 합계
dim oPreReturn
set oPreReturn = new CCSASList
oPreReturn.FRectOrderserial = orderserial
oPreReturn.FRectExcA003 = "Y"
oPreReturn.GetOneOldRefundSum


dim InvalidItemNoExists
InvalidItemNoExists = false



'==============================================================================
dim beasongpaystr
if (makeridbeasongpay = 0) then
	beasongpaystr = "무료배송"
else
	if (isupbea = "Y") then
		beasongpaystr = "업체배송비 : " + FormatNumber(makeridbeasongpay, 0) + "원"
	else
		beasongpaystr = "배송비 : " + FormatNumber(makeridbeasongpay, 0) + "원"
	end if
end if

'==============================================================================
if (isupbea = "Y") then
	beasongpayidx = GetWebCSDetailReturnBeasongPay(orderserial, beasongmakerid)
else
	beasongpayidx = GetWebCSDetailReturnBeasongPay(orderserial, "")
end if

dim myorderdetailbeasongpay
set myorderdetailbeasongpay = new CCSASList
myorderdetailbeasongpay.FRectOrderserial = orderserial
myorderdetailbeasongpay.FRectIdxArray = beasongpayidx

'// 배송비 쿠폰
dim beasongpayCouponPrice : beasongpayCouponPrice = 0
if (myorder.FResultCount>0) and (CStr(beasongpayidx) <> "0") Then
    myorderdetailbeasongpay.GetOrderDetailWithReturnDetail
	if (myorderdetailbeasongpay.FResultcount > 0) then
		beasongpayCouponPrice = myorderdetailbeasongpay.FitemList(0).FItemCost - myorderdetailbeasongpay.FitemList(0).FdiscountAssingedCost
	end if
end if

'==============================================================================
'// 신용카드 부분취소 가능한지.
dim omainpayment
dim mainpaymentorg
dim cardPartialCancelok, cardcancelerrormsg, cardcancelcount, cardcancelsum, cardcodeall

cardPartialCancelok = "N"

if (Trim(myorder.FOneItem.FAccountDiv) = "100") or (Trim(myorder.FOneItem.FAccountDiv) = "110") or isNaverPay or isTossPay or isChaiPay or isKakaoPay then
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

'// 임시 이벤트
'// 브랜드 : laundrymat
'// 출고금액 : 50000
'// 주문당 : 1
'// 기간 : 2016.03.07~2016.03.29
'// 입점몰 제외
dim IsTempEventAvail : IsTempEventAvail = True
dim IsTempEventAvail_Str : IsTempEventAvail_Str = ""
dim IsTempEventAvail_Makerid

IF application("Svr_Info")="Dev" THEN
	IsTempEventAvail_Makerid = "laundrymat001"
else
	IsTempEventAvail_Makerid = "laundrymat"
end if

IsTempEventAvail = False
for i = 0 to myorderdetail.FResultCount - 1
	if (myorderdetail.FItemList(i).Fmakerid = IsTempEventAvail_Makerid) then
		IF application("Svr_Info")="Dev" THEN
			IsTempEventAvail_Str = CheckFreeReturnDeliveryAvail(orderserial, IsTempEventAvail_Makerid, "2016-03-03", "2016-03-29", 3000, 1)
		else
			IsTempEventAvail_Str = CheckFreeReturnDeliveryAvail(orderserial, IsTempEventAvail_Makerid, "2016-03-07", "2016-03-29", 50000, 1)
		end if

		if (IsTempEventAvail_Str = "") then
			IsTempEventAvail = True
		end if

		exit for
	end if
next

'// 주문상품 수
dim TotalItemNo
TotalItemNo = GetTotalItemNo(orderserial)

dim TenbaeProhibitBrandExists :TenbaeProhibitBrandExists = False

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV18.css" />
<%' modal layer control area %>
<div id="boxes">
	<div id="mask" class="pngFix"></div>
	<div id="freeForm"></div>
</div>
<%' //modal layer control area %>
<script language='javascript'>

// getReturnItemTotal() 에서 계산된다.
var selectedAllatDiscount 			= 0;
var selectedPercentCouponDiscount 	= 0;

var FDisabledReturn = false;

var isallrefund             = "<%= isallrefund %>"; 		// 해당 상품 전부취소시 한개 브랜드 전체반품(취소 포함)!!
var makeridbeasongpay       = <%= makeridbeasongpay %>; 	// 해당 브랜드 배송비(주문시 입력된 배송비)
var realmakeridbeasongpay   = <%= realmakeridbeasongpay %>; // 실제 브랜드 배송비

var beasongpayCouponPrice	= <%= beasongpayCouponPrice %>;	// 배송비 쿠폰

var TotalItemNo = <%= TotalItemNo %>;						// 주문상품 수


var IsRegisterOK = true;
function RecalcuReturnPrice(frm){

	// ========================================================================
    var selectedItemTotal 		= getReturnItemTotal(frm);
    var preRefundSum    		= <%= oPreReturn.FOneItem.FtotalMayRefundSum  %>;
	var orgSubtotalPrice        = <%= myorder.FOneItem.FSubtotalPrice %>;
	var sumPaymentEtc        	= <%= myorder.FOneItem.FsumPaymentEtc %>;

    var orgTenCardSpend         = <%= myorder.FOneItem.FTenCardSpend %>;
    var orgMileTotalPrice       = <%= myorder.FOneItem.FMileTotalPrice %>;
    var orgAllatDiscountPrice   = <%= myorder.FOneItem.FAllatDiscountPrice %>;
    var orgDeposit   			= <%= myorder.FOneItem.Fspendtencash %>;
    var orgGiftMoney   			= <%= myorder.FOneItem.Fspendgiftmoney %>;

    var orgbeasongpay           = <%= myorder.FOneItem.FDeliverPrice %>;

    var orgCouponType   		= "<%= chkIIF(OCoupon.FResultCount>0,OCoupon.FOneItem.Fcoupontype,0) %>";
    var orgCouponValue  		= <%= chkIIF(OCoupon.FResultCount>0,OCoupon.FOneItem.Fcouponvalue,0) %>;


	// ========================================================================
    var refundCoupon 			= 0;
    var refundMile   			= 0;
    var refundAllat 			= 0;
    var refundDeposit 			= 0;
    var refundGiftmoney 		= 0;

    //구매배송비
    var refundbeasongpay 		= 0;

    //회수배송비
    var refunddeliverypay 		= 0;


	// ========================================================================
    var refundrequire   = 0;

    if (frm.returnmethod.length==undefined){
        var returnmethod = frm.returnmethod.value;
    }else{
        var returnmethod = frm.returnmethod[getCheckedIndex(frm.returnmethod)].value;
    }

    if (returnmethod=="R007") {
		document.getElementById("divAccount1").style.display = "";
     }else{
		document.getElementById("divAccount1").style.display = "none";
     }


	// ========================================================================
    // 한개 브랜드 전체 반품인 경우
	if (IsAllreturn(frm) == true) {
		refundbeasongpay = makeridbeasongpay;
		// 배송비 쿠폰
		refundCoupon = refundCoupon + beasongpayCouponPrice;
	}

    if (frm.gubuncode[0].checked) {
		if (IsAllreturn(frm) == true) {
			// 고객 변심에 의한 전체 반품이면 왕복배송비(업체별로 다름) 차감
			refunddeliverypay = realmakeridbeasongpay * 2;
		} else {
			// 기타 회수배송비
			refunddeliverypay = realmakeridbeasongpay;
		}
    }


	// ========================================================================
    // % 보너스쿠폰 할인 차감
    if (selectedPercentCouponDiscount > 0){
        refundCoupon = refundCoupon + selectedPercentCouponDiscount;
	}

	// ========================================================================
    //올엣카드 할인금액이 있을경우 :
    if (selectedAllatDiscount > 0) {
        refundAllat = selectedAllatDiscount;
    }


	// ========================================================================
	refundrequire = selectedItemTotal - refundCoupon - refundAllat + refundbeasongpay

	// ========================================================================
	refundrequire = refundrequire - refunddeliverypay

	// ========================================================================
	// 환급순서를 바꾸면 안된다.(Process 참조)

	// 정액 보너스쿠폰
	if (refundrequire > (orgSubtotalPrice - sumPaymentEtc - preRefundSum)) {
		if ((refundCoupon == 0) && (orgTenCardSpend != 0) && (orgCouponType != "1")) {
			refundCoupon = orgTenCardSpend;
			refundrequire = refundrequire - refundCoupon;
		}
	}

	var SelectedItemNo = GetSelectedItemNo(frm);

	// 마일리지
	if ((refundrequire > (orgSubtotalPrice - sumPaymentEtc - preRefundSum)) || (SelectedItemNo == TotalItemNo)) {
		if (orgMileTotalPrice > 0) {
			if (orgMileTotalPrice <= refundrequire) {
				refundMile = orgMileTotalPrice;
			} else {
				refundMile = refundrequire;
			}

			refundrequire = refundrequire - refundMile;
		}
	}

	// 기프트카드
	if ((refundrequire > (orgSubtotalPrice - sumPaymentEtc - preRefundSum)) || (SelectedItemNo == TotalItemNo)) {
		if (orgGiftMoney > 0) {
			if (orgGiftMoney <= refundrequire) {
				refundGiftmoney = orgGiftMoney;
			} else {
				refundGiftmoney = refundrequire;
			}

			refundrequire = refundrequire - refundGiftmoney;
		}
	}

	// 예치금
	if ((refundrequire > (orgSubtotalPrice - sumPaymentEtc - preRefundSum)) || (SelectedItemNo == TotalItemNo)) {
		if (orgDeposit > 0) {
			if (orgDeposit <= refundrequire) {
				refundDeposit = orgDeposit;
			} else {
				refundDeposit = refundrequire;
			}

			refundrequire = refundrequire - refundDeposit;
		}
	}


	// ========================================================================
	// 에러
	IsRegisterOK = true;
	if (refundrequire > (orgSubtotalPrice - sumPaymentEtc - preRefundSum)) {
            //반품불가.
            IsRegisterOK = false;
	}


	// 에러
    if (refundrequire*1 < 0) {
        IsRegisterOK = false;
    }


    document.all["subttlitemsum"].innerHTML = plusComma(selectedItemTotal);

    frm.refundrequire.value = refundrequire;
    frm.canceltotal.value = refundrequire;

    frm.refunditemcostsum.value 	= selectedItemTotal;  	// 반품상품 총액
    frm.allatsubtractsum.value  	= refundAllat;  		// 올엣할인 차감
    frm.refundcouponsum.value   	= refundCoupon; 		// 쿠폰 환급액
    frm.refundmileagesum.value  	= refundMile;  			// 마일리지 환급액
    frm.refunddepositsum.value  	= refundDeposit;  		// 예치금 환급액
    frm.refundgiftmoneysum.value	= refundGiftmoney;  	// 기프트카드 환급액

    frm.refundbeasongpay.value  	= refundbeasongpay;  	// 구매배송비
    frm.refunddeliverypay.value 	= refunddeliverypay;  	// 회수배송비 차감

    var imsgstr = "";
    if ((refunddeliverypay - refundbeasongpay) > 0) {
   		imsgstr += "반품배송비 차감 : <font color='red'>" + plusComma(refunddeliverypay - refundbeasongpay) + "</font> ";
    } else if ((refunddeliverypay - refundbeasongpay) < 0) {
		imsgstr += "배송비 환급 : <font color='red'>" + plusComma(-1 * (refunddeliverypay - refundbeasongpay)) + "</font> ";
	}

    if (refundCoupon > 0) {
         imsgstr += "쿠폰 할인차감 : <font color='red'>" + plusComma(refundCoupon) + "</font> ";
    }

    if (refundAllat > 0) {
        imsgstr += "기타 카드할인차감 : <font color='red'>" + plusComma(refundAllat) + "</font> ";
    }

    if (refundMile > 0) {
         imsgstr += "마일리지 환급 : <font color='red'>" + plusComma(refundMile) + "</font> ";
    }

    if (refundGiftmoney > 0) {
         imsgstr += "기프트카드 환급 : <font color='red'>" + plusComma(refundGiftmoney) + "</font> ";
    }

    if (refundDeposit > 0) {
         imsgstr += "예치금 환급 : <font color='red'>" + plusComma(refundDeposit) + "</font> ";
    }

	if (imsgstr != "") {
		imsgstr = "("+imsgstr+")";
	}

    document.getElementById("divRefundRequire").innerHTML = plusComma(refundrequire);
    document.getElementById("imsg").innerHTML = imsgstr;

    if (IsRegisterOK != true) {
        if (refundrequire*1 < 0){
			if (frm.regitemno.value != "") {
				alert('죄송합니다. 환불예정액이 마이너스일경우 반품 접수가 불가합니다.');
			}
        }else{
            alert('죄송합니다. 반품 접수가 불가하오니, 고객센터로 문의해 주세요.');
        }
    }
}

function IsAllreturn(frm) {
	// 표시된 상품이 전부 선택되면 전부반품(취소포함)인가
	if (frm.regitemno.length == undefined) {
		// 상품한개
	    if (isallrefund == "Y") {
	        if ((frm.regitemno.value*1 + frm.preregitemno.value*1) == frm.orderitemno.value*1) {
	            return true;
	        }
	    }
	} else {
		// 두개이상
		if (isallrefund == "Y") {
			for (var i = 0; i < frm.regitemno.length; i++) {
		        if ((frm.regitemno[i].value*1 + frm.preregitemno[i].value*1) != frm.orderitemno[i].value*1) {
		            return false;
		        }
			}

			return true;
		}
	}

    return false;
}

function GetSelectedItemNo(frm) {
	var totSelectedItemNo = 0;

	if (frm.regitemno.length == undefined) {
		var e = frm.regitemno;
		if (e.value == "") { return totSelectedItemNo; }
		totSelectedItemNo = e.value*1;
	} else {
		for (var i = 0; i < frm.regitemno.length; i++) {
			var e = frm.regitemno[i];
			if (e.value == "") { continue; }
			if (IsDigit(e.value) != true) { continue; }

			totSelectedItemNo = totSelectedItemNo + e.value*1;
		}
	}

	return totSelectedItemNo;
}

function getReturnItemTotal(frm){

    var ItemTotalItemCouponDiscounted = 0;

    var RefundAllatDiscount = 0;
    var RefundPercentCouponDiscount = 0;
    var emptyItemNoFound;

    emptyItemNoFound = false;

    if (frm.regitemno.length==undefined){
        var e = frm.regitemno;

		if ((e.value == "") && (emptyItemNoFound == false)) {
			alert('수량을 입력하세요.');
			e.focus();
			emptyItemNoFound = true;
		}

        if (!IsDigit(e.value)){
            alert('수량은 숫자만 가능합니다.');
            e.value= "1";
        }

        if ((e.value*1>(frm.orderitemno.value*1 - frm.preregitemno.value*1))){
            alert('반품 수량은 주문 수량/기접수수량을 초과할 수 없습니다.');
            e.value= frm.orderitemno.value*1 - frm.preregitemno.value*1;
        }

        ItemTotalItemCouponDiscounted = e.value*frm.itemcost.value*1;
        RefundAllatDiscount = e.value*frm.allatsubstract.value*1;
        RefundPercentCouponDiscount = e.value*frm.percentcoupondiscount.value*1;
    }else{
        for (i=0;i<frm.regitemno.length;i++){
            var e = frm.regitemno[i];

			if ((e.value == "") && (emptyItemNoFound == false)) {
				alert('수량을 입력하세요.');
				e.focus();
				emptyItemNoFound = true;
			}

            if (!IsDigit(e.value)){
                alert('수량은 숫자만 가능합니다.');
                e.value= "1";
            }

            if ((e.value*1>(frm.orderitemno[i].value*1 - frm.preregitemno[i].value*1))){
                alert('반품 수량은 주문 수량/기접수수량을 초과할 수 없습니다.');
                e.value= frm.orderitemno[i].value*1 - frm.preregitemno[i].value*1;
            }

            ItemTotalItemCouponDiscounted = ItemTotalItemCouponDiscounted + e.value*frm.itemcost[i].value*1;
            RefundAllatDiscount = RefundAllatDiscount + e.value*frm.allatsubstract[i].value*1;
            RefundPercentCouponDiscount = RefundPercentCouponDiscount + e.value*frm.percentcoupondiscount[i].value*1;
        }
    }

    selectedAllatDiscount = RefundAllatDiscount;
    selectedPercentCouponDiscount = RefundPercentCouponDiscount;

    return ItemTotalItemCouponDiscounted;
}


function checkSubmit(frm){

	if (IsRegisterOK != true) {
		alert("반품접수 불가!!\n\n1:1상담 또는 고객센터 으로 문의주시기 바랍니다.");
		return;
	}

    if (frm.regitemno.length==undefined){
        var e = frm.regitemno;

        if (!IsDigit(e.value)){
            alert('수량은 숫자만 가능합니다.');
            e.focus();
            return;
        }

        if ((e.value*1>(frm.orderitemno.value*1 - frm.preregitemno.value*1))){
            alert('반품 수량은 주문 수량/기접수수량을 초과할 수 없습니다.');
            e.focus();
            return;
        }

        if (e.value*1<1){
                alert('접수 갯수는 1개 이상 가능합니다. \n접수 하지 않으실 상품은 이전단계에서 선택하지 마시고 진행하세요');
                e.focus();
                return;
            }
    }else{
        for (i=0;i<frm.regitemno.length;i++){
            var e = frm.regitemno[i];

            if (!IsDigit(e.value)){
                alert('수량은 숫자만 가능합니다.');
                e.focus();
                return;
            }

            if ((e.value*1>(frm.orderitemno[i].value*1 - frm.preregitemno[i].value*1))){
                alert('반품 수량은 주문 수량/기접수수량을 초과할 수 없습니다.');
                e.focus();
                return;
            }

            if (e.value*1<1){
                alert('접수 갯수는 1개 이상 가능합니다. \n접수 하지 않으실 상품은 이전단계에서 선택하지 마시고 진행하세요');
                e.focus();
                return;
            }

        }
    }


    var chkidx = getCheckedIndex(frm.gubuncode);

    if (chkidx<0){
        alert('반품 사유를 선택해 주세요.');
        frm.gubuncode[0].focus();
        return;
    }

	if (frm.gubuncode[chkidx].value=="C005|CE01"){
		if ($("#etcUserOrder").val()==""){
			alert('자세한 상품 결함/오배송 등의 내용을 선택해주세요.');
			$("#etcUserOrder").focus();
			return;
		}
		if ($("#etcUserOrder").val()=="직접입력"){
			if ($("#ruturnReason").val()==""){
				alert('자세한 상품 결함/오배송 등의 내용을 입력해주세요.');
				$("#ruturnReason").focus();
				return;
			}
		}
	}

    var gubuncode = frm.gubuncode[chkidx].value;

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

    //마일리지로 적립
    if (returnmethod=="R900"){

    }

    //마일리지로 예치금 환불
    if (returnmethod=="R910"){
		//
	}

	frm.contents_jupsu.value = trim(frm.contents_jupsu.value);
    if (frm.contents_jupsu.value.length<1){
        alert('반품 사유 및 요청 사항을 입력하세요.');
        frm.contents_jupsu.focus();
        return
    }

    if (confirm('반품 접수 하시겠습니까?')){
        frm.submit();
    }
}

function trim(value) {
 return value.replace(/^\s+|\s+$/g,"");
}


function plusComma(num){
	if (num < 0) { num *= -1; var minus = true}
	else var minus = false

	var dotPos = (num+"").split(".")
	var dotU = dotPos[0]
	var dotD = dotPos[1]
	var commaFlag = dotU.length%3

	if(commaFlag) {
		var out = dotU.substring(0, commaFlag)
		if (dotU.length > 3) out += ","
	}
	else var out = ""

	for (var i=commaFlag; i < dotU.length; i+=3) {
		out += dotU.substring(i, i+3)
		if( i < dotU.length-3) out += ","
	}

	if(minus) out = "-" + out
	if(dotD) return out + "." + dotD
	else return out
}

function getOnload(){
    RecalcuReturnPrice(frmReturn);
}

window.onload = getOnload;

$(document).ready(function() {
	<% If G_IsPojangok Then %>
		$("#divAccount1 select").addClass("select").css("width:106px;");

		$('.infoMoreViewV15').mouseover(function(){
			$(this).children('.infoViewLyrV15').show();
		});
		$('.infoMoreViewV15').mouseleave(function(){
			$(this).children('.infoViewLyrV15').hide();
		});
	<% End If %>
	//selectbox
	$(".selectbox p").click(function(){
		if ($(this).closest(".selectbox").hasClass("current")) {
			$(this).closest(".selectbox").removeClass("current");
		} else {
			$(".selectbox").removeClass("current");
			$(this).closest(".selectbox").addClass("current");
		}
	});
	$(".selectbox li").click(function(){
		var selectedVal = $(this).text();
		$(this).closest("ul").prev("p").text(selectedVal);
		$('.selectbox p').css('color','#000');
		$(this).closest(".selectbox").removeClass("current");
	});

});

function fnEtcUserOrderInsert(v){
	var prevTextValue;
	if (v=="직접입력"){
		$("#etcUserOrder").val(v);
		$("#ruturnReason").val($("#ruturnReason").val());
		//$("#ruturnReason").prop("readonly",false);
		$("#ruturnReason").focus();
	}
	else if (v==""){
		$("#etcUserOrder").val("");
		$("#ruturnReason").val("");
		alert("자세한 상품 결함/오배송 등의 내용을 선택해주세요.");
		return;
	}
	else{
		$("#etcUserOrder").val(v);
		//$("#ruturnReason").prop("readonly",true);
		$("#ruturnReason").val(v+'\r\n'+$("#ruturnReason").val());
	}
}

function fnReturnReasonSelect(v){
	if (v=="C005|CE01"){
		//$("#ruturnReason").prop("readonly",true);
		$("#ruturnReason").val("");
		$("#etcUserOrder").val("");
		var selectedVal = "자세한 상품 결함/오배송 등의 내용을 선택해주세요";
		$(".selectbox li").closest("ul").prev("p").text(selectedVal);
		$('.selectbox p').css('color','#000');
		$(".selectbox li").closest(".selectbox").removeClass("current");
		$("#etcUserOrderDiv").css("display","inline-block");
        $("#filesend").show();
	}
	else{
		//$("#ruturnReason").prop("readonly",false);
		$("#ruturnReason").val("");
		$("#etcUserOrderDiv").hide();
        $("#filesend").hide();
	}
}

function regfile(fileno){
    if (fileno==""){
        return;
    }
    fnOpenModal("/my10x10/order/myorder_return_fileup.asp?filegubun=R1&fileno="+fileno);
}

function delimage(ifile,ifileurl){
    $("#"+ifile).val("");
    $("#"+ifileurl).html("");
    $("#"+ifileurl).hide();
}

</script>
</head>
<body>
	<div class="heightgird popV18 return">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="pop-header">
			<h1>반품접수</h1>
		</div>
		<div class="pop-content">
			<!-- content -->
			<div class="guidance-msg">
				<p class="txt01">고객님께 만족을 드리지 못해 죄송합니다.</p>
				<p class="txt02">신청하신 상품의 반품을 신속하고 빠르게 처리해 드릴 수 있도록 노력하겠습니다.<br><span class="color-red">맞교환을 원하시는 경우는 꼭 고객센터로 연락 부탁드립니다.</p>
			</div>

			<form name="frmReturn" method="post" action="ReturnOrder_process.asp">
			<input type="hidden" name="mode" value="returnorder">
			<input type="hidden" name="orderserial" value="<%= orderserial %>">
			<input type="hidden" name="orgsubtotalprice" value="<%= myorder.FOneItem.FSubtotalPrice %>"><!-- 원결제액 -->
			<input type="hidden" name="orgitemcostsum" value="<%= myorder.FOneItem.Ftotalsum - myorder.FOneItem.FDeliverprice %>"><!-- 원상품총액 -->
			<input type="hidden" name="orgbeasongpay" value="<%= myorder.FOneItem.FDeliverPrice %>"><!-- 원배송비 -->
			<input type="hidden" name="orgmileagesum" value="<%= myorder.FOneItem.FMileTotalPrice %>"><!-- 원사용마일리지 -->
			<input type="hidden" name="orgcouponsum" value="<%= myorder.FOneItem.FTenCardSpend %>"><!-- 원사용쿠폰 -->
			<input type="hidden" name="orgallatdiscountsum" value="<%= myorder.FOneItem.FAllatDiscountPrice %>"><!-- 원올엣할인 -->

			<input type="hidden" name="canceltotal" value="">       <!-- 반품총액. -->
			<input type="hidden" name="refunditemcostsum" value=""> <!-- 반품상품 총액 -->
			<input type="hidden" name="refundmileagesum" value="">  <!-- 마일리지 환급액 -->
			<input type="hidden" name="refunddepositsum" value="">  <!-- 예치금 환급액 -->
			<input type="hidden" name="refundgiftmoneysum" value="">  <!-- 기프트카드 환급액 -->
			<input type="hidden" name="refundcouponsum" value="">  <!-- 쿠폰 환급액 -->
			<input type="hidden" name="allatsubtractsum" value="">  <!-- 올엣할인 차감 -->
			<input type="hidden" name="refundbeasongpay" value="">  <!-- 구매배송비 -->
			<input type="hidden" name="refunddeliverypay" value="">  <!-- 회수배송비 -->

			<div class="return-detail">
				<div class="hgroup01">
					<h2 class="tit tit01">반품 상품 정보</h2>
				</div>
				<table class="table01">
				<caption>반품 상품 정보 목록</caption>
				<colgroup>
					<col style="width:110px">
					<col style="width:70px">
					<col style="width:auto">
					<col style="width:90px">
					<col style="width:80px">
					<col style="width:100px">
					<% If G_IsPojangok Then %>
						<col style="width:100px">
					<% End If %>
				</colgroup>
				<thead>
				<tr>
					<th scope="col">상품코드/배송</th>
					<th scope="col" colspan="2">상품정보</th>
					<th scope="col">판매가</th>
					<th scope="col">수량</th>
					<th scope="col">소계금액</th>
					<% If G_IsPojangok Then %>
					<th scope="col" class="pkgInfoLyrV15a">
						<div class="infoMoreViewV15">
							<span>선물포장</span>
							<div class="infoViewLyrV15" style="display:none;">
								<div class="infoViewBoxV15">
									<dfn></dfn>
									<div class="infoViewV15">
										<div class="pad15">
											<p class="pkgOnV15a">선물포장이 <strong>가능</strong>한 상품</p>
											<p class="pkgActV15a">선물포장을 <strong>설정</strong>한 상품</p>
											<p class="pkgNoV15a">아이콘이 미표기된 상품은 선물포장을 <br />지원하지 않는 상품입니다.</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</th>
					<% End If %>
				</tr>
				</thead>
				<tfoot>
				<tr>
					<td colspan="7">
						반품상품 총 금액 = <span class="color-red"><b class="fs20"><span id="subttlitemsum" name="subttlitemsum"><%= FormatNumber(subttlitemsum,0) %></span></b> 원</span>
					</td>
				</tr>
				</tfoot>
				<tbody>
				<% for i=0 to myorderdetail.FResultCount-1 %>
				<% subttlitemsum = subttlitemsum + myorderdetail.FItemList(i).FItemCost * myorderdetail.FItemList(i).FItemNo %>
				<%
				ReturnMakerid = myorderdetail.FItemList(i).FMakerid
				ReturnItemNo = myorderdetail.FItemList(i).FItemNo - myorderdetail.FItemList(i).Fregitemno
				if (ReturnItemNo > 1) then
					'// 2개 이상이면 디폴트값 입력 않함.(고객 오입력 대비 : 한개 반품하면서 전체수량 반품 등록)
					ReturnItemNo = ""
				end if
				%>
				<tr>
					<td>
						<div><%=myorderdetail.FItemList(i).FItemid%></div>
						<div>
							<% if myorderdetail.FItemList(i).Fisupchebeasong="N" then %>
								<%
								IsTenBeasong = true
								if (myorderdetail.FItemList(i).FMakerid = "apple1010") or (myorderdetail.FItemList(i).FMakerid = "youmi10") or (myorderdetail.FItemList(i).FMakerid = "youmi20") or (myorderdetail.FItemList(i).FMakerid = "via0101") then
									TenbaeProhibitBrandExists = True
								end if
								%>
								텐바이텐배송
							<% elseif myorderdetail.FItemList(i).Fisupchebeasong="Y" then %>
								<% IsUpcheBeasong = true %>
								업체개별배송
							<% end if %>
						</div>
					</td>
					<td><img src="<%= myorderdetail.FItemList(i).FSmallImage %>" width="50" height="50" alt="<%= myorderdetail.FItemList(i).FItemName %>" /></td>
					<td class="lt">
						<div><%= myorderdetail.FItemList(i).FItemName %></div>
						<% if myorderdetail.FItemList(i).FItemoptionName <> "" then %>
						<div><strong>옵션 : <%= myorderdetail.FItemList(i).FItemoptionName %></strong></div>
						<% end if %>
					</td>
					<td>
						<%= FormatNumber(myorderdetail.FItemList(i).FItemCost,0) %>
						<% if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
						<p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
						<% end if %>
					</td>
					<td>
						<input type="hidden" name="detailidx" value="<%= myorderdetail.FItemList(i).Forderdetailidx %>">
						<input type="text" class="txtInp" name="regitemno" value="<%= ReturnItemNo %>" style="text-align:center" size="2" maxlength="2" onKeyUp="RecalcuReturnPrice(frmReturn);">
						<input type="hidden" name="preregitemno" value="<%= myorderdetail.FItemList(i).Fregitemno %>">
						<input type="hidden" name="orderitemno" value="<%= myorderdetail.FItemList(i).FItemNo %>">
						<input type="hidden" name="itemcost" value="<%= myorderdetail.FItemList(i).FItemCost %>">
						<input type="hidden" name="allatsubstract" value="<%= myorderdetail.FItemList(i).getAllAtDiscountedPrice %>">
						<input type="hidden" name="percentcoupondiscount" value="<%= myorderdetail.FItemList(i).getPercentBonusCouponDiscountedPrice %>">

						<% if myorderdetail.FItemList(i).Fregitemno<>0 then %>
						<br>(기접수 <%= myorderdetail.FItemList(i).Fregitemno %>)
						<% end if %>

						<% if (myorderdetail.FItemList(i).FItemNo - myorderdetail.FItemList(i).Fregitemno<1) then InvalidItemNoExists= true %>
					</td>
					<td>
						<%= FormatNumber(myorderdetail.FItemList(i).FItemCost*myorderdetail.FItemList(i).FItemNo,0) %> <%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
						<% if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
						<p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice*myorderdetail.FItemList(i).FItemNo,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
						<% end if %>
					</td>
					<% If G_IsPojangok Then %>
					<td>
						<%
						If myorderdetail.FItemList(i).FIsPacked = "Y" Then	'### 내가포장했는지
							vIsPacked = "Y"		'### 1개라도 포장했으면 Y
							Response.Write "<img src=""http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png"" alt=""상품요청상품"" />"
						End If
						%>
					</td>
					<% End If %>
				</tr>
				<% next %>
				</tbody>
				</table>

				<div class="hgroup01">
					<h2 class="tit tit01">반품 상세 정보</h2>
				</div>
				<fieldset>
				<legend>반품 상세 정보 입력 폼</legend>
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
						<th scope="row">반품사유</th>
						<td colspan="3">
							<div class="radio-box">
								<input type="radio" id="returnType1" name="gubuncode" value="C004|CD01" onClick="RecalcuReturnPrice(frmReturn);fnReturnReasonSelect(this.value);" /><label for="returnType1">구매의사 없음(단순변심)</label>
								<input type="radio" id="returnType2" name="gubuncode" value="C005|CE01" onClick="RecalcuReturnPrice(frmReturn);fnReturnReasonSelect(this.value);" /><label for="returnType2">상품 결함/파손/누락/오배송</label>
								<% if (IsTempEventAvail = True) then %>
								<input type="radio" id="returnType3" name="gubuncode" value="C004|CD11" onClick="RecalcuReturnPrice(frmReturn);fnReturnReasonSelect(this.value);" /><label for="returnType3">무료반품</label>
								<em class="crRed">* 무료반품 이벤트 상품입니다.</em>
								<% end if %>
								<% if (IsTempEventAvail_Str <> "") then %>
								<em class="crRed">* 무료반품불가 : <%= IsTempEventAvail_Str %></em>
								<% end if %>
								<div class="selectbox" style="display:none; width:350px;" id="etcUserOrderDiv">
									<p class="btn-linkV18 link1">자세한 상품 결함/오배송 등의 내용을 선택해주세요</p>
									<ul>
										<li onclick="fnEtcUserOrderInsert('상품에 불량/결함이 있습니다');">상품에 불량/결함이 있습니다</li>
										<li onclick="fnEtcUserOrderInsert('상품이 파손되었습니다');">상품이 파손되었습니다</li>
										<li onclick="fnEtcUserOrderInsert('상품의 구성품이 누락되었습니다');">상품의 구성품이 누락되었습니다</li>
										<li onclick="fnEtcUserOrderInsert('전혀 다른 상품이 배송되었습니다');">전혀 다른 상품이 배송되었습니다</li>
										<li onclick="fnEtcUserOrderInsert('상품은 맞으나 다른 옵션의 상품이 배송되었습니다');">상품은 맞으나 다른 옵션의 상품이 배송되었습니다</li>
										<li onclick="fnEtcUserOrderInsert('직접입력');">직접 입력 (10자 이상)</li>
									</ul>
								</div>
								<input type="hidden" name="etcUserOrder" id="etcUserOrder" value="">
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="ruturnReason">반품 사유 및<br> 기타 요청사항</label></th>
						<td colspan="3" class="lt">
							<textarea id="ruturnReason" name="contents_jupsu" cols="60" rows="8" style="width:686px; height:188px;" onkeyup="{$('input:radio[name=gubuncode]').is(':checked') ? '' : alert('반품 사유를 선택 해주세요');}"></textarea>
						</td>
					</tr>
					<tr id="filesend" name="filesend" style="display:none;">
						<th scope="row" class="ct">첨부이미지</th>
						<td colspan="3" class="lt">
							<div class="btnArea lt tMar20">
								<button type="button" onClick="regfile('1'); return false;" class="btn btnS1">파일선택</button>
								<input type="hidden" id="sfile1" name="sfile1" value="">
								<span class="inp" id="fileurl1" style="display:none;"></span>
								<a href="#" onClick="delimage('sfile1','fileurl1'); return false;" class="btnListDel" style="display:inline-block; vertical-align:middle; margin:0 0 0 3px;">삭제</a>
							</div>
							<div class="btnArea lt tMar20">
								<button type="button" onClick="regfile('2'); return false;" class="btn btnS1">파일선택</button>
								<input type="hidden" id="sfile2" name="sfile2" value="">
								<span class="inp" id="fileurl2" style="display:none;"></span>
								<a href="#" onClick="delimage('sfile2','fileurl2'); return false;" class="btnListDel" style="display:inline-block; vertical-align:middle; margin:0 0 0 3px;">삭제</a>
							</div>
							<div class="btnArea lt tMar20">
								<button type="button" onClick="regfile('3'); return false;" class="btn btnS1">파일선택</button>
								<input type="hidden" id="sfile3" name="sfile3" value="">
								<span class="inp" id="fileurl3" style="display:none;"></span>
								<a href="#" onClick="delimage('sfile3','fileurl3'); return false;" class="btnListDel" style="display:inline-block; vertical-align:middle; margin:0 0 0 3px;">삭제</a>
							</div>
							<p class="tMar07 fs11">파일이 많은경우 압축(ZIP)해서 등록해 주세요.첨부파일당 최대 5메가까지만 허용됩니다.</p>
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
										<input type="radio" id="refundWay1" name="returnmethod" value="R120" checked onClick="RecalcuReturnPrice(frmReturn);"><label for="refundWay1">네이버페이 (부분)취소</label>
									<% else %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R022" checked onClick="RecalcuReturnPrice(frmReturn);"><label for="refundWay1">네이버페이 (부분)취소</label>
									<% end if %>
								<% elseif (isTossPay) then %>
									<% if myorder.FOneItem.FAccountDiv="100" then %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R120" checked onClick="RecalcuReturnPrice(frmReturn);"><label for="refundWay1">토스페이 (부분)취소</label>
									<% else %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R022" checked onClick="RecalcuReturnPrice(frmReturn);"><label for="refundWay1">토스페이 (부분)취소</label>
									<% end if %>
								<% elseif (isChaiPay) then %>
									<% if myorder.FOneItem.FAccountDiv="100" then %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R120" checked onClick="RecalcuReturnPrice(frmReturn);"><label for="refundWay1">차이페이 (부분)취소</label>
									<% else %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R022" checked onClick="RecalcuReturnPrice(frmReturn);"><label for="refundWay1">차이페이 (부분)취소</label>
									<% end if %>
								<% elseif (isKakaoPay) then %>
									<% if myorder.FOneItem.FAccountDiv="100" then %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R120" checked onClick="RecalcuReturnPrice(frmReturn);"><label for="refundWay1">카카오페이 (부분)취소</label>
									<% else %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R022" checked onClick="RecalcuReturnPrice(frmReturn);"><label for="refundWay1">카카오페이 (부분)취소</label>
									<% end if %>
								<% else %>
									<% if cardPartialCancelok = "Y" then %>
										<input type="radio" id="refundWay1" name="returnmethod" value="R120" checked onClick="RecalcuReturnPrice(frmReturn);"><label for="refundWay1">신용카드 (부분)취소</label>
									<% end if %>
									<input type="radio" id="refundWay2" name="returnmethod" value="R007" <% if cardPartialCancelok = "Y" then %>disabled<% else %>checked<% end if %> onClick="RecalcuReturnPrice(frmReturn);"><label for="refundWay2">무통장입금</label>
								<% end if %>


								<% if (userid<>"") then %>
									<input type="radio" id="refundWay3" name="returnmethod" value="R910" <% if cardPartialCancelok = "Y" then %>disabled<% end if %> onClick="RecalcuReturnPrice(frmReturn);"><label for="refundWay3">예치금 적립</label>
								<% end if %>
							</div>
						</td>
					</tr>
					<tr id="divAccount1">
						<th scope="row">환불 계좌 정보</th>
						<td class="lt ">
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
					<tr>
						<th scope="row">환불 예정 금액</th>
						<td colspan="3" class="lt">
							<input type="hidden" name="refundrequire" value="0" >
							<strong id="divRefundRequire" class="crRed"></strong>원<!-- (<%= beasongpaystr %>) -->
							&nbsp;
							<span id="imsg"></span>
						</td>
					</tr>
					</tbody>
					</table>
				</fieldset>
			</div>

			<%if Not (IsTenBeasong) then %>
			<div class="help-section tMar30">
				<h2 class="tit tit02">반품 방법 안내</h2>
				<h3 class="tit tit03 tMar10">업체 배송상품 반품절차</h3>
				<p>반품하실 상품은 [업체개별배송]상품으로 반품접수 후, 해당 업체에 <span class="color-red">직접 반품</span>해주셔야 합니다.<br /> 택배접수는 <span class="color-red">착불반송</span>으로 접수하시면 됩니다.</p>

				<ol class="orderProcess step4">
					<li class="receipt">
						<strong>반품접수</strong>
						<p>반품신청을 하신 후,<br /> 반품하실 상품을<br /> 받으신 상태로 재포장해주세요.</p>
					</li>
					<li class="release">
						<strong>택배발송</strong>
						<p>해당 택배사로 연락 후<br /> 업체로 <em class="crRed">직접 상품</em>을 보내주세요.</p>
					</li>
					<li class="returnIng">
						<strong>반품진행</strong>
						<p>택배 발송 후<br /> [내가 신청한 서비스]에<br /> 보내신 송장번호를 입력해주세요.</p>
					</li>
					<li class="returnFinish last">
						<strong>반품완료</strong>
						<p>반품된 상품 확인 후 결제취소<br /> 또는 환불을 해드립니다.</p>
					</li>
				</ol>

				<ul class="list bulletDot tPad15 bPad15">
					<li><span class="color-red">고객변심으로 인한 전체반품의 경우 왕복배송료가 차감</span>되며, 무료배송이 아니면 회수배송비가 차감되어 환불됩니다.</li>
					<li>배송비는 업체무료배송인 경우 2,500원으로, 조건배송인 경우 업체별 배송비로 적용됩니다.</li>
				</ul>
				<%
				dim OReturnAddr
				set OReturnAddr = new CCSReturnAddress

				if (IsUpcheBeasong) and (ReturnMakerid<>"") then
					OReturnAddr.FRectMakerid = ReturnMakerid
					OReturnAddr.GetReturnAddress
				end if
				%>
				<input type="hidden" name="isupchebeasong" value="Y">
				<input type="hidden" name="returnmakerid" value="<%= ReturnMakerid %>">
				<table class="table02 tMar50">
				<caption>반품관련 택배, 판매자 및 반품주소 정보</caption>
				<colgroup>
					<col style="width:140px">
					<col style="width:310px">
					<col style="width:140px">
					<col style="width:310px">
				</colgroup>
				<tbody>
				<tr>
					<th scope="row">상품수령시 택배</th>
					<td class="lPad30"><%=detailDeliveryName%>&nbsp;<%=detailSongjangNo%></td>
					<th scope="row">택배사 대표번호</th>
					<td class="lPad30"><%=detailDeliveryTel%></td>
				</tr>
				<tr>
					<th scope="row">판매업체명</th>
					<td class="lPad30"><%=OReturnAddr.Freturnname%></td>
					<th scope="row">판매업체 연락처</th>
					<td class="lPad30"><%= OReturnAddr.Freturnphone %></td>
				</tr>
				<tr>
					<th scope="row">반품주소지</th>
					<td colspan="3" class="lt">[<%= OReturnAddr.Freturnzipcode %>] <%= OReturnAddr.Freturnzipaddr %> &nbsp;<%= OReturnAddr.Freturnetcaddr %></td>
				</tr>
				</tbody>
				</table>
			</div>
			<% else %>
			<div class="help-section tMar30">
				<h2 class="tit tit02">반품 방법 안내</h2>
				<h3 class="tit tit03 tMar10">텐바이텐 배송상품 반품절차</h3>
				<p>회수서비스를 제공하고 있습니다. 웹사이트 및 고객센터로 접수하시면, 택배기사님이 2-3일 후 방문 드립니다.</p>

				<ol class="orderProcess step3">
					<li class="receipt">
						<strong>반품접수</strong>
						<p>반품신청을 하신 후, 반품하실 상품을<br /> 받으신 상태로 재포장해주세요.</p>
					</li>
					<li class="visit">
						<strong>택배기사 방문</strong>
						<p>반품접수 후 2-3일 내에 택배기사님이<br /> 방문하여 상품을 회수합니다</p>
					</li>
					<li class="returnFinish last">
						<strong>반품완료</strong>
						<p>회수된 상품 확인 후 결제취소<br /> 또는 환불을 해드립니다.</p>
					</li>
				</ol>

				<ul class="list bulletDot tPad15 bPad15">
					<li><span class="color-red">고객변심으로 인한 전체반품의 경우 왕복배송료가 차감</span>되며, 무료배송이 아니면 회수배송비가 차감되어 환불됩니다.</li>
					<% '// 텐텐배송 2500으로 변경 %>
					<% If (Left(Now, 10) >= "2019-01-01") Then %>
						<li>무료배송이 아니면 회수배송비(2,500원)가 차감되어 환불됩니다.</li>
					<% Else %>
						<li>무료배송이 아니면 회수배송비(2,000원)가 차감되어 환불됩니다.</li>
					<% End If %>
				</ul>
			</div>
			<% end if %>

			<% if (IsUpcheBeasong) and (IsTenBeasong) then %>
			<script language='javascript'>alert('텐바이텐 배송과 업체배송 상품을 동시에 반품신청 하실 수 없습니다.');</script>
			<% elseif (InvalidItemNoExists) then %>
			<script language='javascript'>alert('기존 반품 접수 상품은 제외하고 선택해주세요.');</script>
			<% elseif (myorder.FOneItem.FSiteName <> "10x10") and (myorder.FOneItem.FSiteName <> "10x10_cs") then %>
			<script language='javascript'>alert('입점몰결제상품은 1:1문의 또는 고객센터에서 반품문의 하시기 바랍니다.');</script>
			<%
            elseif CUSTOMER_RETURN_DENY or TenbaeProhibitBrandExists  then
            %>
			<script language='javascript'>alert('업체요청으로 직접반품 불가합니다. 1:1문의 또는 고객센터에서 반품문의 하시기 바랍니다.');</script>
			<div class="tMar30 bMar25 ct">
				<p class="fs14">업체요청으로 <span class="color-red">직접반품이 불가</span>합니다. 1:1문의 또는 고객센터에서 반품문의 하시기 바랍니다.</p>
			</div>
			<% else %>
				<div class="tMar30 ct">
					<button style="width:400px;" onclick="checkSubmit(frmReturn);return false;" class="btn01 btn-red">반품 접수하기</button>
				</div>
			<% end if %>
			<!-- //content -->
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%

set OCoupon = Nothing
set oPreReturn = Nothing
set myorder = Nothing
set myorderdetail = Nothing
set OReturnAddr = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
