<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/cashreceiptcls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/taxsheet_cls.asp"-->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성

'// 아래에서 설정
strPageTitle = "텐바이텐 10X10 : 페이지명"

strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim i, j
dim userid, sitename
dim IsCancelOrder
sitename = "10x10"

dim onlyCash : onlyCash = (requestCheckVar(request("shTp"),10)<>"AL")

dim orderserial : orderserial = requestCheckVar(request("orderserial"),11)
dim pflag       : pflag       = requestCheckVar(request("pflag"),10)
dim IsBiSearch  : IsBiSearch=False

userid = getEncLoginUserID()

if (orderserial="") then
    orderserial = GetGuestLoginOrderserial
end if


dim myorder
set myorder = new CMyOrder
myorder.FRectOldjumun = pflag

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

if (orderserial="") then
    response.write "<script>alert('올바른 주문건이 아닙니다.'); window.close();</script>"
    response.end
end if

'''취소 주문건인지
IsCancelOrder = myorder.FOneItem.FCancelyn<>"N"


'''실 발급된 내역 체크후 Redirect
''세금계산서 발급건이 있으면 뿌려줌
Dim otaxlist, taxAlreadyExists
set otaxlist = new CTax
otaxlist.FRectorderserial=orderserial
otaxlist.GetTaxList

taxAlreadyExists = (otaxlist.FResultCount>0)


dim ocashreceipt, receiptAlreadyExists

set ocashreceipt = new CCashReceipt
ocashreceipt.FRectSuccAndReq = "on"
ocashreceipt.FRectOrderserial = orderserial
IF (IsCancelOrder) THEN
    '''D플래그 제외 전체 쿼리

ELSE
    ocashreceipt.FRectCancelyn = "N"
    ocashreceipt.FRectSuccAndReq = "Y"			'// 성공 또는 요청 내역만, 2021-04-27, skyer9
END IF
ocashreceipt.GetReceiptListByOrderSerial

receiptAlreadyExists = (ocashreceipt.FResultcount>0)



''실시간 이체시 신청하여 바로 발급된경우
if (myorder.FOneItem.IsDirectBankCashreceiptExists) then

end if



Dim receiptExists
receiptExists = (receiptAlreadyExists or taxAlreadyExists)

''현금성 영수증이 아닌경우
if (Not receiptExists) and (onlyCash) and (Not myorder.FOneItem.IsCashDocReqValid) then
    response.write "<script>alert('현금영수증 신청 가능한 상태가 아닙니다.');</script>"
    response.end
end if

if (Not receiptExists) then
	strPageTitle = "텐바이텐 10X10 : 발급할 증빙서류 선택"
else
	strPageTitle = "텐바이텐 10X10 : 증빙서류 조회"
end if


''2016/07/26 추가
dim minusSubtotalprice : minusSubtotalprice=0
dim isNaverPay : isNaverPay = False                 ''2016/07/21 추가
dim mayNpayPoint : mayNpayPoint=0
dim mayCashPrice : mayCashPrice = myorder.FOneItem.getCashDocTargetSum
isNaverPay = (myorder.FOneItem.Fpggubun="NP")

if (Not receiptExists) then
    if (isNaverPay) then
        ''mayNpayPoint = fnGetNpaySpendPointSUM(orderserial)*-1
        mayNpayPoint = 0
    else
        mayNpayPoint = 0
    end if

    minusSubtotalprice = GetReceiptMinusOrderSUM(orderserial)

    mayCashPrice = mayCashPrice +mayNpayPoint + minusSubtotalprice
end if
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language="JavaScript" type="text/JavaScript">
<% if (Not receiptExists) then %>
<% if (isNaverPay) then %>
$( document ).ready(function() {
    frmNext.action="/inipay/receipt/INIreceiptReq.asp";
    frmNext.submit();
    return;
});
<% end if %>
<% end if %>
function chkNext(frm) {
    frmNext.action="/inipay/receipt/INIreceiptReq.asp";
    frmNext.submit();
    return;

    /*
    if (frm.DocType[0].checked){
        frmNext.action="/inipay/receipt/INIreceiptReq.asp";
        frmNext.submit();
        return;
    }

    if (frm.DocType[1].checked){
        frmNext.action="/my10x10/taxSheet/pop_taxOrder.asp";
        frmNext.submit();
        return;
    }

   	alert("발급할 증빙서류를 선택하세요.");
   	*/
}

function showBill36524Tax(NO_TAX,NO_BIZ_NO){
    if (NO_TAX!=""){
        var iUrl = "http://www.bill36524.com/popupBillTax.jsp?NO_TAX=" + NO_TAX + "&NO_BIZ_NO=" + NO_BIZ_NO;
        // alert(iUrl);
        var popwin = window.open(iUrl,"showBill36524Tax","width=800,height=700, scrollbars=no,resizable=no");
    	popwin.focus();
	}
}

function cancelTaxReq(taxIdx){
    frmCancel.receiptreqidx.value=taxIdx;
    frmCancel.cType.value="T";

    if (confirm('세금계산서 발급 요청을' + ' 취소하시겠습니까?')){
        frmCancel.submit();
    }
}

function showreceipt(tid){
	var showreceiptUrl = "https://iniweb.inicis.com/DefaultWebApp/mall/cr/cm/Cash_mCmReceipt.jsp?noTid=" + tid + "&clpaymethod=22";
	var popwin = window.open(showreceiptUrl,"showreceipt","width=380,height=540, scrollbars=no,resizable=no");
	popwin.focus();
}

function cancelReceipt(iidx,cType){
    var mdgType='';
    if (cType=="R"){
        mdgType = '현금영수증 발급 요청 내역을';
    }else{
        mdgType = '현금영수증 발급 내역을';
    }

    frmCancel.receiptreqidx.value=iidx;
    frmCancel.cType.value=cType;

    if (confirm(mdgType + ' 취소하시겠습니까?')){
        frmCancel.submit();
    }
}

function forceDocEval(){
    frmNext.action="/inipay/receipt/INIreceiptReq.asp";
    frmNext.submit();
}

<% if (Not receiptExists) then %>
window.resizeTo(640,400);
<% elseif ocashreceipt.FResultCount>0 then %>
window.resizeTo(800,400);
<% end if %>

</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<%
			if (Not receiptExists) then ''발급할 증빙서류 선택
			    if (NOT isNaverPay) then ''2016/08/08 추가 //redirect
			%>
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_document_issue_select.gif" alt="발급할 증빙서류 선택" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<form name="chkFrm" method="post">
				<div class="mySection">
					<fieldset>
						<legend>발급가능 증빙서류</legend>
						<table class="baseTable rowTable docForm">
						<caption class="visible">발급 가능한 증빙서류 내역입니다.</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">총 발급금액</th>
							<td>
								<strong class="crRed"><%= FormatNumber(mayCashPrice,0) %></strong> 원
								<% if (myorder.FOneItem.Fspendtencash>0) or (myorder.FOneItem.Fspendgiftmoney>0) then %>
									<% if (myorder.FOneItem.getCashDocTargetSum=myorder.FOneItem.Fspendtencash) then %>
										(예치금)
									<% elseif (myorder.FOneItem.getCashDocTargetSum=myorder.FOneItem.Fspendgiftmoney) then %>
										(Gift카드)
									<% else %>
										(
										<%= myorder.FOneItem.GetAccountdivName %> : <%= FormatNumber(myorder.FOneItem.TotalMajorPaymentPrice,0) %>
										<% if (myorder.FOneItem.Fspendtencash>0) then %>
										+ 예치금 : <%= FormatNumber(myorder.FOneItem.Fspendtencash,0) %>
										<% end if %>
										<% if (myorder.FOneItem.Fspendgiftmoney>0) then %>
										+ Gift카드 : <%= FormatNumber(myorder.FOneItem.Fspendgiftmoney,0) %>
										<% end if %>
										)
									<% end if %>
								<% end if %>
								<% if (minusSubtotalprice<>0) then %>
									(반품 : <%= FormatNumber(minusSubtotalprice,0) %>)
								<% end if %>
								<% if (mayNpayPoint<>0) then %>
									(네이버포인트 : <%= FormatNumber(mayNpayPoint,0) %>)
								<% end if %>
							</td>
						</tr>
						<tr>
							<th scope="row">발급구분</th>
							<td>
								<div class="radioBox">
								   <% if myorder.FOneItem.getCashDocTargetSum<0 then %>
									<input type="radio" id="issueCash" name="DocType" value="R" disabled /><label for="issueCash">현금영수증</label>
									<!-- <input type="radio" id="issueTax" name="DocType" value="T" /><label for="issueTax">세금계산서</label> -->
								   <% else %>
									<input type="radio" id="issueCash" name="DocType" value="R" checked="checked" /><label for="issueCash">현금영수증</label>
									<!-- <input type="radio" id="issueTax" name="DocType" value="T" /><label for="issueTax">세금계산서</label> -->
								   <% end if %>
								</div>
							</td>
						</tr>
						</tbody>
						</table>

						<div class="btnArea ct tPad20">
							<input type="button" class="btn btnS1 btnRed btnW100" value="발급요청" onClick="chkNext(chkFrm);" />
							<button type="button" class="btn btnS1 btnGry btnW100" onClick="window.close();">취소</button>
						</div>
					</fieldset>
				</div>
				</form>
				<!-- //content -->
			</div>
			<%
		        end if
			else ''증빙서류 조회
			%>
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_document_issue_select.gif" alt="발급할 증빙서류 선택" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<% if otaxlist.FResultCount > 0 then %>
					<table class="baseTable">
					<caption class="visible">세금계산서 발급 내역입니다.</caption>
					<colgroup>
						<col width="80" /> <col width="80" /> <col width="*" /> <col width="130" /> <col width="170" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col">구분</th>
						<th scope="col">발급상태</th>
						<th scope="col">발급일</th>
						<th scope="col">사업자번호</th>
						<th scope="col">비고</th>
					</tr>
					</thead>
					<tbody class="fs12">
					<% for i = 0 to otaxlist.FResultCount - 1 %>
					<tr>
						<td>세금계산서</td>
						<td><%= otaxlist.FTaxList(i).getResultStateName %></td>
						<td><%= otaxlist.FTaxList(i).FisueDate %></td>
						<td><%= otaxlist.FTaxList(i).FbusiNo %></td>
						<td>
							<% if (otaxlist.FTaxList(i).FneoTaxNo<>"") then %>
							<a href="javascript:showBill36524Tax('<%= otaxlist.FTaxList(i).FneoTaxNo %>','<%= otaxlist.FTaxList(i).FbusiNo %>')" class="btn btnS2 btnGry"><span class="fn">계산서 출력</span></a>
							<% else %>
							<a href="javascript:cancelTaxReq('<%= otaxlist.FTaxList(i).FtaxIdx %>');" class="btn btnS2 btnGry"><span class="fn">발급요청취소</span></a>
							<% end if %>
						</td>
					</tr>
					<% next %>
					</tbody>
					</table>
					<% end if %>

					<% if ocashreceipt.FResultCount>0 then %>
						<% if (otaxlist.FResultCount > 0) then %>
						<div>&nbsp;</div>
						<% end if %>

					<table class="baseTable">
					<caption class="visible">현금영수증 발급 내역입니다.</caption>
					<colgroup>
						<col width="80" /> <col width="80" /> <col width="80" /> <col width="80" /> <col width="*" /> <col width="130" /> <col width="170" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col">구분</th>
						<th scope="col">발급상태</th>
						<th scope="col">승인번호</th>
						<th scope="col">발행(거래)일자</th>
						<th scope="col">금액</th>
						<th scope="col">발급구분</th>
						<th scope="col">비고</th>
					</tr>
					</thead>
					<tbody class="fs12">
					<% for i=0 to ocashreceipt.FResultCount-1%>
					<tr>
						<td>현금영수증</td>
						<td><%= ocashreceipt.FItemList(i).getResultStateName %></td>
						<td><%= ocashreceipt.FItemList(i).Fresultcashnoappl%> <% ''Fauthcode 에서 변경 %></td>
						<td><%= CHKIIF(IsNull(ocashreceipt.FItemList(i).FEvalDT), "", Left(ocashreceipt.FItemList(i).FEvalDT,10)) %></td>
						<td><%= FormatNumber(ocashreceipt.FItemList(i).Fcr_price,0) %></td>
						<td><%= ocashreceipt.FItemList(i).getUseoptName %></td>
						<td>
							<% if ( ocashreceipt.FItemList(i).FTid<>"") then %>
							<a href="javascript:showreceipt('<%= ocashreceipt.FItemList(i).FTid %>');" class="btn btnS2 btnGry"><span class="fn">영수증출력</span></a>
							&nbsp;
								<% if (ocashreceipt.FItemList(i).Fcancelyn="N") then %>
								<a href="javascript:cancelReceipt('<%= ocashreceipt.FItemList(i).FIdx %>','S');" class="btn btnS2 btnGry"><span class="fn">발급취소</span></a>
								<% end if %>
							<% else %>
								<a href="javascript:forceDocEval();" class="btn btnS2 btnGry"><span class="fn">즉시발급</span></a>
								<a href="javascript:cancelReceipt('<%= ocashreceipt.FItemList(i).FIdx %>','R');" class="btn btnS2 btnGry"><span class="fn">발급요청취소</span></a>
							<% end if %>
						</td>
					</tr>
					<% next %>
					</tbody>
					</table>
					<% end if %>
				</div>
				<!-- //content -->
			</div>
			<% end if %>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>

	<form name=frmNext method=post action="INIreceiptReq.asp">
		<input type=hidden name=sitename value="<%= sitename %>">
		<input type=hidden name=orderserial value="<%= orderserial %>">
	</form>

	<form name=frmCancel method=post action="INIreceipt.asp">
		<input type=hidden name=receiptreqidx value="">
		<input type=hidden name=cType value="">
		<input type=hidden name=orderserial value="<%= orderserial %>">
	</form>

	<script language='javascript'>
	//frmCashReceipt.submit();
	</script>
</body>
</html>
<%

set ocashreceipt = Nothing
set myorder = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
