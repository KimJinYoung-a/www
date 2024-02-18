<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "10X10 : 기프트카드 주문취소"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/giftcard/cs_giftcard_ordercls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cs_aslistcls.asp" -->
<%

dim giftorderserial
giftorderserial = requestCheckvar(request("giftorderserial"),11)

dim userid
userid = getEncLoginUserID()



'==============================================================================
dim oGiftOrder

set oGiftOrder = new cGiftCardOrder

if (giftorderserial <> "") then
	oGiftOrder.FRectGiftOrderSerial = giftorderserial

	if (IsUserLoginOK()) then
		oGiftOrder.getCSGiftcardOrderDetail
	end if
end if




'==============================================================================
dim ErrMsg

if (oGiftOrder.FResultCount = 0) or (oGiftOrder.FOneItem.Fuserid <> userid) then
	ErrMsg = "잘못된 접속입니다."
else
	if (oGiftOrder.FOneItem.Fcancelyn <> "N") then
		ErrMsg = "취소된 주문입니다."
	end if

	if (oGiftOrder.FOneItem.Fjumundiv = "7") then
		ErrMsg = "Gift카드가 이미 등록되었습니다. 취소할 수 없습니다."
	end if

	if (oGiftOrder.FOneItem.FAccountdiv <> "7") and (oGiftOrder.FOneItem.FAccountdiv <> "100") and (oGiftOrder.FOneItem.FAccountdiv <> "20") then
		ErrMsg = "취소할 수 없습니다.\n\n오류정보 : 잘못된 결제정보"
	end if
end if

if (ErrMsg <> "") then
    response.write "<script type='text/javascript'>alert('" + CStr(ErrMsg) + "');</script>"
    response.write "<script type='text/javascript'>window.close();</script>"
    dbget.close()	:	response.End
end if



'==============================================================================
dim returnmethod, returnmethodstring, refundrequire

if (oGiftOrder.FOneItem.FAccountdiv = "7") and (oGiftOrder.FOneItem.Fipkumdiv < "4") and (oGiftOrder.FOneItem.Fipkumdiv >= "2") then
	'결제이전 취소
	returnmethod		= "R000"
	returnmethodstring	= "환불없음"
	refundrequire 		= "0"
elseif (oGiftOrder.FOneItem.FAccountdiv = "7") and (oGiftOrder.FOneItem.Fipkumdiv >= "4") and (oGiftOrder.FOneItem.Fipkumdiv <> "9") then
	'결제이전 취소
	returnmethod		= "R007"
	returnmethodstring	= "무통장환불"
	refundrequire 		= oGiftOrder.FOneItem.Fsubtotalprice
elseif (oGiftOrder.FOneItem.FAccountdiv = "20") then
	'실시간이체 취소
	returnmethod		= "R020"
	returnmethodstring	= "실시간이체 취소"
	refundrequire 		= oGiftOrder.FOneItem.Fsubtotalprice
elseif (oGiftOrder.FOneItem.FAccountdiv = "100") then
	'결제이전 취소
	returnmethod		= "R100"
	returnmethodstring	= "신용카드 취소"
	refundrequire 		= oGiftOrder.FOneItem.Fsubtotalprice
else
	ErrMsg = "취소할 수 없습니다.\n\n오류정보 : 잘못된 결제정보"

    response.write "<script type='text/javascript'>alert('" + CStr(ErrMsg) + "');</script>"
    response.write "<script type='text/javascript'>window.close();</script>"
    dbget.close()	:	response.End
end if

%>
<script type='text/javascript'>
function PartialCancelProc(frm){
    // Nothing
}

function GotoCSCenter() {
    opener.location.href = "/my10x10/qna/myqnalist.asp";
}

function AllCancelProc(frm){
    var returnmethod;

    returnmethod = frm.returnmethod.value;

    //무통장 환불
    if (returnmethod=="R007"){
        if (frm.rebankname.value.length<1){
            alert('환불 받으실 은행을 선택하세요');
            frm.rebankname.focus();
            return
        }

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

    if (confirm('주문을 취소 하시겠습니까?')){
        frm.submit();
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

</script>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
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
						<h2><%= returnmethodstring %></h2>
						<ul class="list">
						<% if (oGiftOrder.FOneItem.Faccountdiv="7") then %>
							<% if ((oGiftOrder.FOneItem.FAccountdiv = "7") and (oGiftOrder.FOneItem.Fipkumdiv < "4") and (oGiftOrder.FOneItem.Fipkumdiv >= "2")) then %>
								<li>주문접수 상태 주문취소입니다</li>
							<% else %>
								<li>무통장 결제 후 취소시 접수 즉시 취소 됩니다.</li>
								<li>접수 후, 1-2일내에(영업일기준) 등록하신 계좌로 환불되며, 환불시 문자메세지로 안내해 드립니다.</li>
							<% end if %>
						<% else %>
							<li>결제 후 취소시 신용카드 취소는 카드 승인 취소로 접수되며, 실시간 이체는 이체 취소로 접수됩니다.<br />(카드및 실시간 이체 취소는 접수 후 최대 5일(영업일 기준) 소요될 수 있습니다.)</li>
						<% end if %>
						</ul>
					</div>

					<div class="orderDetail">
						<div class="title">
							<h2>주문 상품 정보</h2>
						</div>
						<table class="baseTable btmLine">
						<caption>주문 상품 정보 목록</caption>
						<colgroup>
							<col width="170" /> <col width="*" /> <col width="100" /> <col width="120" />
						</colgroup>
						<thead>
						<tr>
							<th scope="col">주문번호</th>
							<th scope="col">상품명</th>
							<th scope="col">구매금액</th>
							<th scope="col">주문상태</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><%= giftorderserial %></td>
							<td><%= oGiftOrder.FOneItem.FCarditemname %> <span><%= oGiftOrder.FOneItem.FcardOptionName %></span></td>
							<td><%= FormatNumber(oGiftOrder.FOneItem.Fsubtotalprice, 0) %>원</td>
							<td><em class="crRed"><%= oGiftOrder.FOneItem.GetCardStatusName %></em></td>
						</tr>
						</tbody>
						<tfoot>
						<tr>
							<td colspan="5">주문상품 총 금액 = <strong class="crRed"><%= FormatNumber(oGiftOrder.FOneItem.Fsubtotalprice, 0) %></strong> 원</td>
						</tr>
						</tfoot>
						</table>

						<div class="title">
							<h2>결제 정보</h2>
						</div>
						<table class="baseTable rowTable">
						<caption>결제정보</caption>
						<colgroup>
							<col width="120" /> <col width="250" /> <col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">결제방법</th>
							<td>
								<strong class="fs12"><%= oGiftOrder.FOneItem.GetAccountdivName %></strong>
							</td>
							<th scope="row">결제확인일시</th>
							<td class="lt"><%= oGiftOrder.FOneItem.FIpkumDate %></td>
						</tr>
						<tr>
						<% if oGiftOrder.FOneItem.FAccountdiv = 7 then %>
	                        <th scope="row"><%= CHKIIF(refundrequire>0,"결제 금액","결제하실 금액") %></th>
	                        <td class="lt"><%= FormatNumber(oGiftOrder.FOneItem.Fsubtotalprice,0) %>원</td>
	                        <th scope="row">입금하실 계좌</th>
	                        <td class="lt"><%= oGiftOrder.FOneItem.Faccountno %>&nbsp;&nbsp;(주)텐바이텐</td>
						<% else %>
	                        <th scope="row"><%= CHKIIF(refundrequire>0,"결제 금액","결제하실 금액") %></th>
	                        <td colspan="3" class="lt"><%= FormatNumber(oGiftOrder.FOneItem.Fsubtotalprice,0) %>원</td>
						<% end if %>
						</tr>
						</tbody>
						</table>

						<div class="title">
							<h2>환불 정보</h2>
						</div>
						<fieldset>
						<legend>환불 정보 입력 폼</legend>
				        <form name="frmCancel" method="post" action="popGiftCardCancel_process.asp">
				        <input type="hidden" name="giftorderserial" value="<%= giftorderserial %>">
				        <input type="hidden" name="mode" value="cancelorder">
				        <input type="hidden" name="returnmethod" value="<%= returnmethod %>" >
				        <input type="hidden" name="refundrequire" value="<%= refundrequire %>"  >
							<table class="baseTable rowTable fs12">
							<caption>환불정보</caption>
							<colgroup>
								<col width="120" /> <col width="130" /> <col width="*" /> <col width="240" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">환불방법</th>
								<td class="lt"><%= returnmethodstring %></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<th scope="row">환불 예정 금액</th>
								<td class="lt">
									<strong class="crRed"><%= FormatNumber(refundrequire, 0) %></strong> 원
								</td>
								<td></td>
								<td></td>
							</tr>
							<% if (returnmethod = "R007") then %>
							<tr>
								<th scope="row">환불 계좌 정보</th>
								<td class="lt ">
									<% Call DrawBankCombo("rebankname","") %>
								</td>
								<td class="lt">
									<label for="accountNum" class="bulletDot fs12">계좌번호</label>
									<input type="text" name="rebankaccount" id="accountNum" value="" maxlength="20" required placeholder="-를 제외하고 입력하시기 바랍니다." class="txtInp focusOn fs11 ftDotum" style="width:218px;" />
								</td>
								<td class="lt">
									<label for="accountHolder" class="bulletDot fs12">예금주</label>
									<input type="text" name="rebankownername" id="accountHolder" value="" maxlength="16" class="txtInp focusOn" style="width:93px;" />
								</td>
							</tr>
							<% end if %>
							</tbody>
							</table>
						</form>
						</fieldset>
					</div>

					<div class="btnArea ct tPad25">
						<a href="#" class="btn btnS1 btnRed btnW160" onclick="AllCancelProc(document.frmCancel); return false;">주문 취소</a>
					</div>
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
<!-- #include virtual="/lib/db/dbclose.asp" -->