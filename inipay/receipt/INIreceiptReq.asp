<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/cashreceiptcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/inipay/naverpay/incNaverpayCommon.asp"-->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 현급영수증 발행요청"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


dim i, j
dim userid, sitename
sitename = requestCheckvar(request.form("sitename"),32)
if sitename="" then sitename="10x10"

userid = getLoginUserID

dim orderserial
dim IsBiSearch  : IsBiSearch=False
orderserial = requestCheckvar(request.form("orderserial"),11)
dim pflag       : pflag       = requestCheckVar(request("pflag"),10)

userid = getEncLoginUserID()

if (orderserial="") then
    orderserial = GetGuestLoginOrderserial
end if


if (userid<>"") then
	IsBiSearch = false
elseif (orderserial<>"") then
	IsBiSearch = true

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
else
	response.write "<script>alert('올바른 접속이 아닙니다.');</script>"
	response.write "<script>window.close();</script>"
	response.end
end if

if (orderserial="") then
    response.write "<script>alert('올바른 주문건이 아닙니다.'); window.close();</script>"
    response.end
end if

myorder.GetOrderDetail

''발급가능날짜 - 최대 2달로 설정
''dim availdate
''availdate = dateAdd("d",-61,now())
''if (myorder.FOneItem.FIpkumdate<availdate) then
if (dateDiff("d",myorder.FOneItem.Fipkumdate,date())>61) then  ''sp_myordercls와 맞춤 2016/08/09
	response.write "<script>alert('최근 두달 이내 주문건에 대해서만 현금 영수증 발급가능합니다.');</script>"
	response.write "<script>window.close();</script>"
	response.end
end if

dim minusSubtotalprice : minusSubtotalprice=GetReceiptMinusOrderSUM(orderserial)
dim isNaverPay : isNaverPay = False                 ''2016/07/21 추가
dim mayNpayPoint : mayNpayPoint = 0
isNaverPay = (myorder.FOneItem.Fpggubun="NP")
if (isNaverPay) then
    mayNpayPoint = fnGetNpaySpendPointSUM(orderserial)*-1   ''현금성 포인트 있음;;
end if

dim NPay_Result

dim i_cr_price  
dim i_sup_price 
dim i_tax       

if ((minusSubtotalprice<>0) or (mayNpayPoint<>0)) then
    i_cr_price    =   myorder.FOneItem.getCashDocTargetSum+minusSubtotalprice+mayNpayPoint
    i_sup_price   =   CLng((i_cr_price)/1.1)
    i_tax         =   i_cr_price-i_sup_price
    
else
    i_cr_price    =   myorder.FOneItem.getCashDocTargetSum
    i_sup_price   =   myorder.FOneItem.GetSuppPrice
    i_tax         =   myorder.FOneItem.GetTaxPrice
end if

if (isNaverPay) then ''포인트 금액이 맞다면 굳이 조회 안해도 될듯.. => 조회 해야함;; 현금성 포인트 금액이 있음.
    Set NPay_Result = fnCallNaverPayCashAmt(myorder.FOneItem.Fpaygatetid)
    if NPay_Result.code="Success" then
        i_cr_price    = CLng(NPay_Result.body.totalCashAmount) + myorder.FOneItem.FsumPaymentEtc	'// 총 대상금액
		i_sup_price   = CLng(NPay_Result.body.supplyCashAmount) + CLng(myorder.FOneItem.FsumPaymentEtc*10/11)	'// 현금성 공급가
		i_tax         = i_cr_price - i_sup_price													'// 현금성 과세액
		
		''response.write i_cr_price&"|"&i_sup_price&"|"&i_tax
    end if
    Set NPay_Result = Nothing
end if

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language="JavaScript" type="text/JavaScript">
$( document ).ready(function() {
    if (document.ini.cr_price.value < 1) {
		alert("현금영수증 발행시 최소금액은 1 원입니다. 발행 가능급액이 없거나 올바른 금액이 아닙니다.");
		return;
	}
});

// 영수증 선택에 따른 분류
function RCP1(){
	document.ini.useopt.value="0" // 소비자 소득공제용
}

function RCP2(){
	document.ini.useopt.value="1" // 사업자 지출증빙용
}

function pay(frm) {
	// 필수항목 체크 (상품명, 상품가격, 구매자명, 구매자 이메일주소, 구매자 전화번호, 영수증 발행 용도)
    if(frm.cr_price.value < 1) {
		alert("현금영수증 발행시 최소금액은 1 원입니다. 발행 가능급액이 없거나 올바른 금액이 아닙니다.");
		return;
	}
	
	frm.reg_num.value = frm.reg_num.value.replace(/-/g, '');

	if(frm.useopt.value == "") {
		alert("현금영수증 발행용도를 선택하세요. 필수항목입니다.");
		return;
	} else if(frm.useopt.value == "0") {

		if(frm.reg_num.value.length !=10 && frm.reg_num.value.length !=11 && frm.reg_num.value.length !=18) {
			alert("현금영수증카드 18자리 또는 올바른 휴대폰 번호 10자리(11자리)를 입력하세요.");
			frm.reg_num.focus();
			return;
		} else if(frm.reg_num.value.length == 11 ||frm.reg_num.value.length == 10 ) {
			var obj = frm.reg_num.value;
			if (obj.substring(0,3)!= "011" && obj.substring(0,3)!= "017" && obj.substring(0,3)!= "016" && obj.substring(0,3)!= "018" && obj.substring(0,3)!= "019" && obj.substring(0,3)!= "010") {
				alert("올바른 휴대폰 번호 10자리(11자리)를 입력하세요. ");
				frm.reg_num.focus();
				return;
			}

			var chr;
			for(var i=0; i<obj.length; i++) {
				chr = obj.substr(i, 1);
				if( chr < '0' || chr > '9') {
					alert("숫자가 아닌 문자가 휴대폰 번호에 추가되어 오류가 있습니다, 다시 확인 하십시오. ");
					frm.reg_num.focus();
					return;
				}
			}
		} else if(frm.reg_num.value.length == 18) {
			var obj = frm.reg_num.value, chr;
			for(var i=0; i<obj.length; i++) {
				chr = obj.substr(i, 1);
				if( chr < '0' || chr > '9') {
					alert("숫자가 아닌 문자가 카드 번호에 추가되어 오류가 있습니다, 다시 확인 하십시오. ");
					frm.reg_num.focus();
					return;
				}
			}
		}

	} else if(frm.useopt.value == "1") {

		if(frm.reg_num.value.length !=10  && frm.reg_num.value.length !=11 && frm.reg_num.value.length !=18) {
			alert("올바른 현금영수증카드 18자리, 사업자등록번호 10자리 또는 휴대폰 번호 10자리(11자리)를 입력하세요.");
			frm.reg_num.focus();
			return;
		} else if(frm.reg_num.value.length == 10 && frm.reg_num.value.substring(0,1)!= "0") {
   			var vencod = frm.reg_num.value;
   			var sum = 0;
   			var getlist =new Array(10);
   			var chkvalue =new Array("1","3","7","1","3","7","1","3","5");
   			for(var i=0; i<10; i++) { getlist[i] = vencod.substring(i, i+1); }
   			for(var i=0; i<9; i++) { sum += getlist[i]*chkvalue[i]; }
   			sum = sum + parseInt((getlist[8]*5)/10);
   			sidliy = sum % 10;
   			sidchk = 0;
   			if(sidliy != 0) { sidchk = 10 - sidliy; }
   			else { sidchk = 0; }
   			if(sidchk != getlist[9]) {
   				alert("올바른 사업자 번호를 입력하시기 바랍니다. ");
   				frm.reg_num.focus();
   			    return;
   			} else {
			    //alert("number ok");
			    //return;
			}
		} else if(frm.reg_num.value.length == 11 ||frm.reg_num.value.length == 10 ) {
        	var obj = frm.reg_num.value;
        	if (obj.substring(0,3)!= "011" && obj.substring(0,3)!= "017" && obj.substring(0,3)!= "016" && obj.substring(0,3)!= "018" && obj.substring(0,3)!= "019" && obj.substring(0,3)!= "010") {
        		alert("실제 번호를 입력하시지 않아 실행에 실패하였습니다. 다시 입력하시기 바랍니다. ");
        		frm.reg_num.focus();
        		return;
        	}

        	var chr;
        	for(var i=0; i<obj.length; i++) {
        		chr = obj.substr(i, 1);
        		if( chr < '0' || chr > '9') {
        			alert("실제 번호를 입력하시지 않아 실행에 실패하였습니다. 다시 입력하시기 바랍니다. ");
        			frm.reg_num.focus();
        			return;
        		}
        	}
        } else if(frm.reg_num.value.length == 18) {
			var obj = frm.reg_num.value, chr;
			for(var i=0; i<obj.length; i++) {
				chr = obj.substr(i, 1);
				if( chr < '0' || chr > '9') {
					alert("숫자가 아닌 문자가 카드 번호에 추가되어 오류가 있습니다, 다시 확인 하십시오. ");
					frm.reg_num.focus();
					return;
				}
			}
		}
	}

	var sum_price = eval(frm.sup_price.value) + eval(frm.tax.value) + eval(frm.srvc_price.value);
	if(frm.cr_price.value != sum_price) {
		alert("총액은 공급가+부가세+봉사료입니다.더한 금액이 틀립니다");
		return;
	}


	if(frm.goodname.value == "") {
		alert("상품명이 빠졌습니다. 필수항목입니다.");
		return;
	} else if(frm.cr_price.value == "") {
		alert("현금결제금액이 빠졌습니다. 필수항목입니다.");
		return;
	} else if(frm.sup_price.value == "") {
		alert("공급가액이 빠졌습니다. 필수항목입니다.");
		return;
	} else if(frm.tax.value == "") {
		alert("부가세가 빠졌습니다. 필수항목입니다.");
		return;
	} else if(frm.srvc_price.value == "") {
		alert("봉사료가 빠졌습니다. 필수항목입니다.");
		return;
	} else if(frm.buyername.value == "") {
		alert("구매자명이 빠졌습니다. 필수항목입니다.");
		return;
	} else if(frm.reg_num.value == "") {
		alert("주민등록번호(또는 사업자번호)가 빠졌습니다. 필수항목입니다.");
		return;

	} else if(frm.buyeremail.value == "") {
		alert("구매자 이메일주소가 빠졌습니다. 필수항목입니다.");
		return;
	} else if(frm.buyertel.value == "") {
		alert("구매자 전화번호가 빠졌습니다. 필수항목입니다.");
		return;
	}

	// 더블클릭으로 인한 중복요청을 방지하려면 반드시 confirm()을
	// 사용하십시오.
	if(confirm("현금영수증을 발행하시겠습니까?")) {
		disable_click();
		//openwin = window.open("childwin.html","childwin","width=299,height=149");
		frm.submit();
	} else {
		return;
	}
}

function disable_click(){
	// ??
	document.getElementById("ievalBtn").style.display = "none";
	document.getElementById("ievalBtn2").style.display = "";

	document.ini.clickcontrol.value = "disable"
}

window.resizeTo(640,620);

</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_cash_issue.gif" alt="현금영수증 발행요청" /></h1>
			</div>
			<form name=ini method=post action="INIreceipt.asp">
			<input type=hidden name=goodname value="<%= myorder.GetGoodsName %>">
			<% if (isNaverPay) then %>
			<input type=hidden name=cr_price value="<%= i_cr_price %>">
			<input type=hidden name=sup_price value="<%= i_sup_price %>">
			<input type=hidden name=tax value="<%= i_tax %>">
		    <% else %>
			<input type=hidden name=cr_price value="<%= myorder.FOneItem.getCashDocTargetSum %>">
			<input type=hidden name=sup_price value="<%= myorder.FOneItem.GetSuppPrice %>">
			<input type=hidden name=tax value="<%= myorder.FOneItem.GetTaxPrice %>">
		    <% end if %>
			<input type=hidden name=srvc_price value="0">
			<input type=hidden name=buyername value="<%= myorder.FOneItem.FBuyName %>">
			<input type=hidden name=orderserial value="<%= orderserial %>">
			<input type=hidden name=userid value="<%= GetLoginUserID %>">
			<input type=hidden name=sitename value="<%= sitename %>">
			<input type=hidden name=paymethod value="<%= myorder.FOneItem.FAccountDiv %>">
			<input type=hidden name=buyertel value="000-000-0000">
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<fieldset>
						<legend>현금영수증 발행요청 폼</legend>
						<table class="baseTable rowTable docForm">
						<caption class="visible">정보를 기입하신 후 발행버튼을 눌러주십시오.</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">총 발행금액</th>
							<td>
							    <% if (isNaverPay) then %>
							        <strong class="crRed"><%= FormatNumber(i_cr_price,0) %></strong> 원
							    <% else %>
    								<strong class="crRed"><%= FormatNumber(myorder.FOneItem.getCashDocTargetSum,0) %></strong> 원
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
                          	    <% end if %>
							</td>
						</tr>
						<tr>
							<th scope="row">구매자명</th>
							<td><%= myorder.FOneItem.FBuyName %></td>
						</tr>
						<tr>
							<th scope="row">이메일주소</th>
							<td>
								<input type="text" title="이메일 아이디 입력" class="txtInp focusOn" name="buyeremail" value="<%= myorder.FOneItem.FBuyEmail %>" maxlength="125" style="width:200px;" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="cashNumber">휴대전화번호<br /> 현금영수증카드 <br /> 사업자번호</label></th>
							<td>
								<input type="text" id="cashNumber" name="reg_num" size=18 maxlength=18 value="" class="txtInp focusOn" style="width:282px;" />
							</td>
						</tr>
						<tr>
							<th scope="row">발행용도</th>
							<td>
								<div class="radioBox">
									<input type="radio" id="issueUsing1" checked name=choose value=1 Onclick= "javascript:RCP1()" /><label for="issueUsing1">소비자 소득공제용</label>
									<input type="radio" id="issueUsing2" name=choose value=1 Onclick= "javascript:RCP2()" /><label for="issueUsing2">사업자 지출증빙용</label>
								</div>
							</td>
						</tr>
						</tbody>
						</table>

						<ul class="list bulletDot fs12 tMar15">
							<li>소득공제용 : 휴대전화번호 또는 현금영수증카드 번호로 발급 가능</li>
							<li>지출증빙용 : 휴대전화번호, 현금영수증카드 번호 또는 사업자번호로 발급 가능</li>
						</ul>

						<div class="btnArea ct tPad20" id="ievalBtn" name="ievalBtn">
							<input type="button" class="btn btnS1 btnRed btnW100" value="발급요청" onClick="pay(ini);" />
							<button type="button" class="btn btnS1 btnGry btnW100" onClick="window.close();">취소</button>
						</div>
						<div class="btnArea ct tPad20" id="ievalBtn2" name="ievalBtn2" style="display:none">
						    발행중입니다. 잠시 기다려주시기 바랍니다.
						</div>    
					</fieldset>
				</div>
				<!-- //content -->
			</div>

			<% if (application("Svr_Info")	= "Dev") then %>
			<input type=hidden name=mid value="INIpayTest">
			<% else %>
			<input type=hidden name=mid value="teenxteen4">
			<% end if %>

			<%
			''UID. 테스트를 마친후, 발급받은 상점아이디로 바꾸어 주십시오.(반드시 mid와 동일한 값을 입력)
			%><input type=hidden name=uid value="">

			<%
			''화폐단위 WON 또는 CENT
			''주의 : 미화승인은 별도 계약이 필요합니다.
			%><input type=hidden name=currency value="WON">

			<%
			''삭제/수정 불가
			%><input type=hidden name=clickcontrol value="">
			<input type=hidden name=useopt value="0">

			</form>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%

set myorder = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
