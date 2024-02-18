<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbHelper.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/inipay/iniWeb/INIWeb_Util.asp" -->
<!-- #include virtual="/lib/classes/cscenter/cancelOrderLib.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 페이지명"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

'' 주문 내역 변경
'' etype          [recv         , ordr          , payn        , flow          , ]
''                [배송정보수정 , 주문자정보수정, 입금자명변경, 플라워정보수정, ]

dim i
dim userid, orderserial
dim etype
Dim G_PG_100_USE_INIWEB : G_PG_100_USE_INIWEB = TRUE ''(NOT G_IsIE) ''INIWEB 사용. (plugin 지원종료 2020.09.01)

userid = getEncLoginUserID()
orderserial  = requestCheckvar(request("orderserial"),11)
etype        = requestCheckvar(request("etype"),10)

Select Case etype
	Case "recv"
		strPageTitle = "텐바이텐 10X10 : 배송정보수정"
	Case "ordr"
		strPageTitle = "텐바이텐 10X10 : 주문자정보수정"
	Case "payn"
		strPageTitle = "텐바이텐 10X10 : 입금자명변경"
	Case "flow"
		strPageTitle = "텐바이텐 10X10 : 플라워정보수정"
	Case Else
		dbget.close()
		response.end
End Select


dim myorder
set myorder = new CMyOrder

if IsUserLoginOK() then
        myorder.FRectUserID = GetLoginUserID()
        myorder.FRectOrderserial = orderserial
        myorder.GetOneOrder
elseif IsGuestLoginOK() then
        orderserial = GetGuestLoginOrderserial()
        myorder.FRectOrderserial = orderserial
        myorder.GetOneOrder
end if

dim myorderdetail
set myorderdetail = new CMyOrder
myorderdetail.FRectOrderserial = orderserial

if myorder.FResultCount>0 then
    myorderdetail.GetOrderDetail
end if

dim IsWebEditEnabled
IsWebEditEnabled = myorder.FOneItem.IsWebOrderInfoEditEnable

''상세내역도 체크
if (IsWebEditEnabled) then
    IsWebEditEnabled = IsWebEditEnabled and myorder.FOneItem.IsEditEnable_BuyerInfo(myorderdetail)
end if

if (Not IsWebEditEnabled) then
    ''response.write "<script language='javascript'>alert('주문/배송정보 수정 가능 상태가 아닙니다. - 고객센터로 문의해 주세요.');</script>"
	ShowAlertAndClosePopup("주문/배송정보 수정 가능 상태가 아닙니다. - 고객센터로 문의해 주세요.")
    dbget.close()	:	response.End
end if

if myorder.FOneItem.GetTotalOrderItemCount(myorderdetail)=0 and (etype="recv") then
	'// 고객추가결제건 배송지정보 수정불가
	ShowAlertAndClosePopup("주문/배송정보를 수정할 수 없습니다. - 출고가능한 상품이 없습니다.")
    dbget.close()	:	response.End
end if

'// 티켓주문일경우 관련 정보 접수
dim IsTicketOrder, TicketDlvType
IsTicketOrder = myorder.FOneItem.IsTicketOrder
if IsTicketOrder then

    Dim oticketItem

    Set oticketItem = new CTicketItem
    oticketItem.FRectItemID = myorderdetail.FItemList(0).FItemID
    oticketItem.GetOneTicketItem
	TicketDlvType = oticketItem.FOneItem.FticketDlvType		'// 티켓수령방법
	Set oticketItem = Nothing

end if

dim captionTitle

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script language="javascript" src="/lib/js/confirm.js"></script>
<script language="javascript">

<% if (etype="ordr") then %>
    function CheckNSubmit(frm){
        if (validate(frm)) {
            if (check_form_email(frm.buyemail.value) == false) {
    		    alert('이메일 주소가 유효하지 않습니다.');
    		    frm.buyemail.focus();
    		    return ;
    		}
    		if (confirm('수정 하시겠습니까?')){
                frm.submit();
            }
        }
    }

<% elseif (etype="flow") then %>
    function CheckNSubmit(frm){
        if (validate(frm)) {
    		<% if (myorder.FOneItem.IsFixDeliverItemExists) then %>
            <%
                Dim nowdate,nowtime,yyyy,mm,dd,tt,hh
                nowdate = Left(CStr(now()),10)
                nowtime = Left(FormatDateTime(CStr(now()),4),2)

                if (yyyy="") then
                	yyyy = Left(nowdate,4)
                	mm   = Mid(nowdate,6,2)
                	dd   = Mid(nowdate,9,2)
                	hh = nowtime
                    tt = nowtime + 6
                end if
            %>

            var oyear = <%= yyyy %>;
            var omonth = <%= mm %>;
            var odate = <%= dd %>;
            var ohours = <%= hh %>;
            var MinTime = <%= tt %>;


            var reqDate = new Date(frm.yyyy.value,frm.mm.value,frm.dd.value,frm.tt.value);
            var nowDate = new Date(oyear,omonth,odate,ohours);
            var nextDay = new Date(oyear,omonth,odate,24);
            var fixDate = new Date(oyear,omonth,odate,MinTime);


            if (nowDate>reqDate){
                //수정 내역이므로 지난 시간 가능.?
            	alert("지난 시간은 선택하실 수 없습니다.");
            	frm.tt.focus();
            	return;
            }else if (fixDate>reqDate){
            	alert("상품준비 시간이 최소 4~6시간입니다!\n좀더 넉넉한 시간을 선택해주세요!");
            	frm.tt.focus();
            	return;
            }
            <% end if %>

    		if (confirm('수정 하시겠습니까?')){
                frm.submit();
            }
    	}
	}

	$(document).ready(function() {
	    $("select").removeClass("input_02").addClass("select");
	});

<% elseif (etype="payn") then %>

	function showHideObj(acctdiv) {
		if (acctdiv=="7") {
			$( "#iTr100_1" ).hide();
			$( "#iTr100_2" ).hide();
			$( "#nextbutton2" ).hide();

			$( "#iTr7_1" ).show();
			$( "#iTr7_11" ).show();
			$( "#iTr7_2" ).show();
		}else if (acctdiv=="100"){
			$( "#iTr100_1" ).show();
			$( "#iTr100_2" ).show();
			$( "#nextbutton2" ).hide();

			$( "#iTr7_1" ).hide();
			$( "#iTr7_11" ).hide();
			$( "#iTr7_2" ).hide();
		}
	}

	/*
	function switchDv(comp){
		var frm = comp.form;
		var acctdiv = getValue(comp);
		if (acctdiv=="7") {
			document.getElementById("iTr100_1").style.display="none"
			document.getElementById("iTr100_2").style.display="none"
			document.getElementById("iTr7_1").style.display="inline"
			document.getElementById("iTr7_11").style.display="inline"
			document.getElementById("iTr7_2").style.display="inline"
		}else if (acctdiv=="100"){
			document.getElementById("iTr7_1").style.display="none"
			document.getElementById("iTr7_11").style.display="none"
			document.getElementById("iTr7_2").style.display="none"
			document.getElementById("iTr100_1").style.display="inline"
			document.getElementById("iTr100_2").style.display="inline"
		}
	}
	*/

    function CheckNSubmit(frm){
        if (frm.acctdiv[0].checked){
            if (validate(frm)) {

        		if (confirm('수정 하시겠습니까?')){
                    frm.submit();
                }
            }
        }
    }

    var iclicked = false;

    function checkDblClick(){
        if (iclicked) return true;
        iclicked = true;
        setTimeout("iclicked=false;",1000);
        return false;
    }

    function payChange(frm){
        if (frm.price.value<1000){
    		alert('신용카드 최소 결제 금액은 1000원 이상입니다.');
    		return;
    	}

        if (checkDblClick()) return;

        <% if (G_PG_100_USE_INIWEB) then %>
			payInI_Web(frm);
        <% else %>
			if (payInI(frm)==true){
				frm.target = "";
				frm.action = "/my10x10/orderPopup/INIChangePay.asp"
				frm.submit();
			}
		<% End If %>
    }

	function payInI_Web(frm){

		$.ajax({
			url: "/inipay/iniWeb/getIniWebSegniture.asp?ords=<%=orderserial%>&prc="+frm.price.value,
			cache: false,
			async: false,
			success: function(vRst) {
				if(vRst!="") {
					$("#INIWEB_SIG").empty().html(vRst);
					
					frm.gopaymethod.value = "Card";
					frm.nointerest.value = "";
					if (parseInt(frm.price.value) < 50000){
						frm.quotabase.value = ""; //ini_web
					}else{
						frm.quotabase.value = "2:3:4:5:6:7:8:9:10:11:12";
					}
					INIStdPay.pay(frm.name);
				}
			}
			,error: function(err) {
				alert('죄송합니다. 통신중 오류가 발생하였습니다.');
				//alert(err.responseText);
				//$("#INIWEB_SIG").empty().html(vRst);
			}
		});
	}

    function payInI(frm){
    	if(frm.clickcontrol.value == "enable"){
    		//if(document.INIpay==null||document.INIpay.object==null){
    		if ( ( navigator.userAgent.indexOf("MSIE") >= 0 || navigator.appName == 'Microsoft Internet Explorer' ) && (document.INIpay == null || document.INIpay.object == null) ){
    			alert("플러그인을 설치 후 다시 시도 하십시오.");
    			return false;
    		}else{
    			/*
    			 * 플러그인 기동전에 각종 지불옵션을 자바스크립트를 통하여
    			 * 처리하시려면 이곳에서 수행하여 주십시오.
    			 */
    			// 50000원 미만은 할부불가
    			if(parseInt(frm.price.value) < 50000)
    				frm.quotabase.value = "일시불";

    			if (MakePayMessage(frm)){
    				disable_click();
    				return true;
    			}else{
    			    if( IsPluginModule() ){     //plugin타입 체크
    				    alert("지불에 실패하였습니다.");
    				}else{
    				    //이니페이 플래시라면 Form 값을 먼저 채울것 MakePayMessage(frm) 이후 리턴값없이 submit 됨.. //2012-01
                        if (ini_IsUseFlash==true){
                    	    frm.target = "";
                    	    frm.action = "/my10x10/orderPopup/INIChangePay.asp"
                    	}
    				}

    				return false;
    			}
    		}
    	}else{
    		return false;
    	}
    }

    function enable_click(){
    	document.frmorder.clickcontrol.value = "enable"
		$( "#nextbutton1" ).show();
		$( "#cancelbutton1" ).show();
		$( "#nextbutton2" ).hide();
    }

    function disable_click(){
    	document.frmorder.clickcontrol.value = "disable";
		$( "#nextbutton1" ).hide();
		$( "#cancelbutton1" ).hide();
		$( "#nextbutton2" ).show();
    }

<% else %>
    function CheckNSubmit(frm){
        if (validate(frm)) {

    		if (confirm('수정 하시겠습니까?')){
                frm.submit();
            }
        }
    }
<% end if %>


function PopOldAddress() {
	if (document.frmorder.emsAreaCode.value=="KR" || document.frmorder.emsAreaCode.value=="") {
		var url = "/my10x10/MyAddress/popMyAddressList.asp";
		var win = "popMyAddressList";
	} else {
		var url = "/my10x10/MyAddress/popSeaAddressList.asp";
		var win = "popSeaAddressList";
	}

	window.open(url,win,'width=600,height=300,scrollbars=yes,resizable=yes');
}

window.onload = function()
{
<%
Dim popWidth, popHeight : popHeight=0
Select Case etype
	Case "ordr"
		popWidth = 640
		popHeight= 525
	Case "payn"
		popWidth = 640
		popHeight= 450
	Case "recv"
		if Not (IsTicketOrder and TicketDlvType="1") then
			popWidth = 670
			popHeight= 700
		else
			popWidth = 670
			popHeight= 640
		end if
	Case "flow"
		popWidth = 620
		popHeight= 620
	Case Else
		popWidth = 395
End Select
%>
	<% if (popHeight<>0) then %>
		//popupResize(<%=popWidth%>+2,<%=popHeight%>+2);
		window.resizeTo(<%=popWidth%>,<%=popHeight%>);
	<% else %>
		popupResize(<%=popWidth%>+2);
	<% end if %>

	<% if (etype="payn") then %>
	enable_click();
	document.frmorder.acctdiv[0].checked=true;

	// switchDv(document.frmorder.acctdiv[0]);
	$(document).ready(function() {
		showHideObj("<%= myorder.FOneItem.FAccountDiv %>");
	});

	<% end if %>
}
</script>
</head>
<body>
	<div class="heightgird">
		<form name="frmorder" method="post" action="EditOrderInfo_process.asp">
		<input type="hidden" name="mode" value="<%= etype %>">
		<input type="hidden" name="orderserial" value="<%= orderserial %>">
<%if (etype="ordr") then %>
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_info_edit_popup.gif" alt="주문정보변경" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<fieldset>
						<legend>구매자 정보 변경 입력 폼</legend>
						<table class="baseTable rowTable docForm">
						<caption class="visible">구매자 정보 변경</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><label for="purchaserName">주문하신 분</label></th>
							<td><input type="text" id="[on,off,2,16][주문자]" name="buyname" value="<%= myorder.FOneItem.FBuyname %>" maxlength="16" class="txtInp focusOn" style="width:120px;" /></td>
						</tr>
						<tr>
							<th scope="row">이메일주소</th>
							<td>
								<input type="text" id="[on,off,3,100][주문자이메일]" name="buyemail" value="<%= myorder.FOneItem.Fbuyemail %>" maxlength="100" class="txtInp focusOn" style="width:200px;" />
							</td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td>
								<input type="text" id="[on,on,2,3][주문자전화1]" name="buyphone1" value="<%= SplitValue(myorder.FOneItem.Fbuyphone,"-",0) %>" maxlength="3" class="txtInp focusOn" style="width:40px;" />
								<span class="symbol">-</span>
								<input type="text" id="[on,on,3,4][주문자전화2]" name="buyphone2" value="<%= SplitValue(myorder.FOneItem.Fbuyphone,"-",1) %>" maxlength="4" class="txtInp focusOn" style="width:60px;" />
								<span class="symbol">-</span>
								<input type="text" id="[on,on,3,4][주문자전화3]" name="buyphone3" value="<%= SplitValue(myorder.FOneItem.Fbuyphone,"-",2) %>" maxlength="4" class="txtInp focusOn" style="width:60px;" />
							</td>
						</tr>
						<tr>
							<th scope="row">휴대전화번호</th>
							<td>
								<input type="text" id="[on,on,2,3][주문자핸드폰1]" name="buyhp1" value="<%= SplitValue(myorder.FOneItem.Fbuyhp,"-",0) %>" maxlength="3" class="txtInp focusOn" style="width:40px;" />
								<span class="symbol">-</span>
								<input type="text" id="[on,on,3,4][주문자핸드폰2]" name="buyhp2" value="<%= SplitValue(myorder.FOneItem.Fbuyhp,"-",1) %>" maxlength="4" class="txtInp focusOn" style="width:60px;" />
								<span class="symbol">-</span>
								<input type="text" id="[on,on,3,4][주문자핸드폰3]" name="buyhp3" value="<%= SplitValue(myorder.FOneItem.Fbuyhp,"-",2) %>" maxlength="4" class="txtInp focusOn" style="width:60px;" />
							</td>
						</tr>
						</tbody>
						</table>

						<div class="btnArea ct tPad20">
							<input type="button" class="btn btnS1 btnRed btnW100" onClick="CheckNSubmit(document.frmorder);" value="수정" />
							<input type="button" class="btn btnS1 btnGry btnW100" onClick="window.close();" value="취소" />
						</div>
					</fieldset>
				</div>
				<!-- //content -->
			</div>
		</div>
<% elseif (etype="payn") then %>
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_info_edit_popup.gif" alt="주문정보변경" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<fieldset>
						<legend>결제방법 변경 폼</legend>
						<table class="baseTable rowTable docForm">
						<caption class="visible">결제방법 변경</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row">결제수단</th>
							<td>
								<div class="radioBox">
									<input type="radio" name="acctdiv" id="rdoAcctdiv1" value="7" <%= CHKIIF(myorder.FOneItem.FAccountDiv="7","checked","") %> onClick="showHideObj(this.value)" /><label for="paymentAccount">가상계좌</label>
									<input type="radio" name="acctdiv" id="rdoAcctdiv2" value="100" <%= CHKIIF(myorder.FOneItem.FAccountDiv="100","checked","") %> onClick="showHideObj(this.value)" /><label for="paymentCreditcard">신용카드</label>

									<% IF application("Svr_Info")="Dev" THEN %>
										<input type=hidden name=mid value="INIpayTest">
									<% else %>
										<input type=hidden name=mid value="teenxteen4">
									<% end if %>

									<!-- 화폐단위 -->
									<input type=hidden name=currency value="WON">
									<!-- 무이자 할부 -->
									<input type=hidden name=nointerest value="no">
									<input type=hidden name=quotabase value="선택:일시불:2개월:3개월:4개월:5개월:6개월:7개월:8개월:9개월:10개월:11개월:12개월:18개월">
									<input type=hidden name=acceptmethod value="VERIFY:NOSELF:no_receipt">

									<input type=hidden name=quotainterest value="">
									<input type=hidden name=paymethod value="">
									<input type=hidden name=cardcode value="">
									<input type=hidden name=ini_onlycardcode value="">
									<input type=hidden name=cardquota value="">
									<input type=hidden name=rbankcode value="">
									<input type=hidden name=reqsign value="DONE">
									<input type=hidden name=encrypted value="">
									<input type=hidden name=sessionkey value="">
									<input type=hidden name=uid value="">
									<input type=hidden name=sid value="">
									<% if (G_PG_100_USE_INIWEB) then %>
										<input type=hidden name=returnUrl value="<%=INIWEB_returnUrl%>">
										<input type=hidden name=version value="<%=INIWEB_ver%>">

										<input type=hidden name=mKey value="<%=INIWEB_mKey%>">
										<input type=hidden name=popupUrl value="<%=INIWEB_popupUrl%>">
										<input type=hidden name=closeUrl value="<%=INIWEB_closeUrl%>">
										<input type=hidden name=merchantData value="orderserial=<%=orderserial%>">
										<input type=hidden name=payViewType value="popup">

										<input type=hidden name=authToken value="">
										<input type=hidden name=authUrl value="">
										<div id="INIWEB_SIG"></div>
									<% else %>
										<input type=hidden name=version value=4110>
									<% end if %>									
									<input type=hidden name=clickcontrol value="enable">
									<input type=hidden name=price value="<%= myorder.FOneItem.TotalMajorPaymentPrice %>"> <% ''FSubtotalPrice %>
									<input type=hidden name=goodname value='<%= myorderdetail.GetGoodsName %>'>
									<input type=hidden name=buyername value="<%= myorder.FOneItem.FBuyName %>">
									<input type=hidden name=buyeremail value="<%= myorder.FOneItem.FBuyEmail %>">
									<input type=hidden name=buyemail value="">
									<input type=hidden name=buyertel value="<%= myorder.FOneItem.FBuyHp %>">
									<input type=hidden name=gopaymethod value="onlycard"> <!-- or onlydbank -->
									<input type=hidden name=ini_logoimage_url value="/fiximage/web2008/shoppingbag/logo2004.gif">
								</div>
							</td>
						</tr>
						<tr id="iTr7_1">
							<th scope="row"><label for="depositorName">입금예정자</label></th>
							<% if myorder.FOneItem.IsEditEnable_AccountName then %>
							<td><input type="text" id="[on,off,2,16][입금자]" name="accountname" value="<%= myorder.FOneItem.Faccountname %>" maxlength="16" class="txtInp focusOn" style="width:100px;" /></td>
							<% else %>
							<td>
								<input type="text" id="[off,off,off,off][입금자]" name="accountname" value="<%= myorder.FOneItem.Faccountname %>" maxlength="16" readonly class="txtInp focusOn" style="width:100px;" />
								(입금자명 수정 불가)
								<input type="hidden" name="accountnamedisable" value="on" />
							</td>
							<% end if %>
						</tr>
						<tr id="iTr7_11">
							<th scope="row">입금은행 정보</th>
							<td>
								<% if myorder.FOneItem.IsEditEnable_AccountNO then %>
									<% Call DrawTenBankAccount("accountno",myorder.FOneItem.Faccountno) %>
								<% else %>
									<% Response.Write myorder.FOneItem.Faccountno %>
									<input type="hidden" name="accountno" value="<%= myorder.FOneItem.Faccountno %>" />
								<% end if %>
							</td>
						</tr>
						<tr id="iTr100_1">
							<th scope="row">결제할 금액</th>
							<td><strong class="crRed"><%= FormatNumber(myorder.FOneItem.TotalMajorPaymentPrice,0)  %></strong> 원</td>
						</tr>
						</tbody>
						</table>

						<div class="btnArea ct tPad20" id="iTr7_2">
							<input type="button" class="btn btnS1 btnRed btnW100" onClick="CheckNSubmit(document.frmorder);" value="수정" />
							<input type="button" class="btn btnS1 btnGry btnW100" onClick="window.close();" value="취소" />
						</div>
						<div class="btnArea ct tPad20" id="iTr100_2">
							<input type="button" class="btn btnS1 btnRed btnW100" onClick="payChange(document.frmorder);" value="결제하기" id="nextbutton1" />
							<input type="button" class="btn btnS1 btnGry btnW100" onClick="window.close();" value="취소" id="cancelbutton1"/>
						</div>
						<div class="btnArea ct tPad20" id="nextbutton2">
							<strong class="crRed">결제 요청중입니다. 잠시만 기다려 주세요.</strong>
						</div>
					</fieldset>
				</div>
				<!-- //content -->
			</div>
		</div>
<% elseif (etype="recv") then %>
	<%
	captionTitle = ""

	if (IsTicketOrder and TicketDlvType="1") then
		captionTitle = "수령인 정보 변경"
	elseif (myorder.FOneItem.IsReceiveSiteOrder) then
		captionTitle = "수령인 정보 변경"
	else
		captionTitle = "배송지 정보 변경"
	end if
	%>
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_info_edit_popup.gif" alt="주문정보변경" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<fieldset>
						<legend><%= captionTitle %> 입력 폼</legend>
						<div class="delivery">
							<h2><%= captionTitle %></h2>
							<% if Not (IsTicketOrder and TicketDlvType="1") and Not (myorder.FOneItem.IsReceiveSiteOrder) then %>
							<a href="javascript:PopOldAddress();" class="btn btnS2 btnGry" title="나의 주소록"><span class="whiteArr01 fn">나의 주소록</span></a>
							<% end if %>
						</div>
						<table class="baseTable rowTable docForm">
						<caption><%= captionTitle %></caption>
						<colgroup>
							<col width="170" /> <col width="*" />
						</colgroup>
						<tbody>
						<input type="hidden" name="emsAreaCode" value="<%=myorder.FOneItem.FemsAreaCode%>" />
	<% if (myorder.FOneItem.IsForeignDeliver) then %>
	<!-- 해외 배송인 경우 -->
						<tr>
							<th scope="row"><label for="purchaserName">수령인명</label></th>
							<td><input type="text" id="[on,off,2,16][수령인]" name="reqname" value="<%= myorder.FOneItem.Freqname %>" class="txtInp focusOn" style="width:140px;" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="purchaserName">수령인 E-mail</label></th>
							<td><input type="text" id="[on,off,4,100][수령인E-mail]" name="reqemail" value="<%= myorder.FOneItem.FreqEmail %>" class="txtInp focusOn" style="width:200px;" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="purchaserName">전화번호 (Tel. No) <strong class="crRed">*</strong></label></th>
							<td>
								<input type="text" title="수령인전화1 입력" id="[on,on,2,4][수령인전화1]" name="reqphone1" class="txtInp focusOn" style="width:40px;" value="<%=SplitValue(myorder.FOneItem.Freqphone,"-",0) %>" onkeydown="onlyNumber(this,event);" />
								<span class="symbol">-</span>
								<input type="text" title="수령인전화2 입력" id="[on,on,2,4][수령인전화2]" name="reqphone2" class="txtInp focusOn" style="width:40px;" value="<%=SplitValue(myorder.FOneItem.Freqphone,"-",1) %>" onkeydown="onlyNumber(this,event);" />
								<span class="symbol">-</span>
								<input type="text" title="수령인전화3 입력" id="[on,on,2,4][수령인전화3]" name="reqphone3" class="txtInp focusOn" style="width:40px;" value="<%=SplitValue(myorder.FOneItem.Freqphone,"-",2) %>" onkeydown="onlyNumber(this,event);" />
								<span class="symbol">-</span>
								<input type="text" title="수령인전화4 입력" id="[on,on,2,4][수령인전화4]" name="reqphone4" class="txtInp focusOn" style="width:40px;" value="<%=SplitValue(myorder.FOneItem.Freqphone,"-",3) %>" onkeydown="onlyNumber(this,event);" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="purchaserName">우편번호 (Zip code) <strong class="crRed">*</strong></label></th>
							<td><input type="text" id="[on,off,3,20][우편번호]" name="emsZipCode" value="<%=myorder.FOneItem.FemsZipCode%>" onkeydown="onlyNumber(this,event);" class="txtInp focusOn" style="width:80px;" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="purchaserName">상세주소 (Address) <strong class="crRed">*</strong></label></th>
							<td><input type="text" id="[off,off,0,100][상세주소 (Address)]" name="txAddr2" value="<%= myorder.FOneItem.Freqaddress %>" class="txtInp focusOn" style="width:300px;" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="purchaserName">도시 및 주 (City/State)</label></th>
							<td><input type="text" id="[on,off,1,100][도시 및 주 (City/State)]" name="txAddr1" value="<%= myorder.FOneItem.Freqzipaddr %>" class="txtInp focusOn" style="width:200px;" /></td>
						</tr>
	<% elseif (myorder.FOneItem.IsReceiveSiteOrder) then %>
	<!-- 현장수령일 경우 -->
						<tr>
							<th scope="row"><label for="purchaserName">수령자명</label></th>
							<td><input type="text" id="[on,off,2,16][수령인]" name="reqname" value="<%= myorder.FOneItem.Freqname %>" class="txtInp focusOn" style="width:80px;" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="purchaserName">휴대폰번호</label></th>
							<td>
								<input type="text" title="수령인휴대폰1 입력" id="[on,on,2,4][수령인휴대폰1]" name="reqhp1" class="txtInp focusOn" style="width:40px;" value="<%=SplitValue(myorder.FOneItem.Freqhp,"-",0) %>" onkeydown="onlyNumber(this,event);" />
								<span class="symbol">-</span>
								<input type="text" title="수령인휴대폰2 입력" id="[on,on,2,4][수령인휴대폰2]" name="reqhp2" class="txtInp focusOn" style="width:50px;" value="<%=SplitValue(myorder.FOneItem.Freqhp,"-",1) %>" onkeydown="onlyNumber(this,event);" />
								<span class="symbol">-</span>
								<input type="text" title="수령인휴대폰3 입력" id="[on,on,2,4][수령인휴대폰3]" name="reqhp3" class="txtInp focusOn" style="width:50px;" value="<%=SplitValue(myorder.FOneItem.Freqhp,"-",2) %>" onkeydown="onlyNumber(this,event);" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="purchaserName">전화번호</label></th>
							<td>
								<input type="text" title="수령인전화1 입력" id="[on,on,2,4][수령인전화1]" name="reqphone1" class="txtInp focusOn" style="width:40px;" value="<%=SplitValue(myorder.FOneItem.Freqphone,"-",0) %>" onkeydown="onlyNumber(this,event);" />
								<span class="symbol">-</span>
								<input type="text" title="수령인전화2 입력" id="[on,on,2,4][수령인전화2]" name="reqphone2" class="txtInp focusOn" style="width:50px;" value="<%=SplitValue(myorder.FOneItem.Freqphone,"-",1) %>" onkeydown="onlyNumber(this,event);" />
								<span class="symbol">-</span>
								<input type="text" title="수령인전화3 입력" id="[on,on,2,4][수령인전화3]" name="reqphone3" class="txtInp focusOn" style="width:50px;" value="<%=SplitValue(myorder.FOneItem.Freqphone,"-",2) %>" onkeydown="onlyNumber(this,event);" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="purchaserName">수령방법</label></th>
							<td>
								현장수령
								<!--
								<select name="RcvSiteyyyymmdd" title="수령날짜 선택" class="select offInput emailSelect" style="width:102px;">
									<% if (myorder.FOneItem.Freqdate<>"2012-05-27") and (myorder.FOneItem.Freqdate<>"2012-05-26") then %>
									<option value="<%= Left(myorder.FOneItem.Freqdate,10) %>" selected ><%= Left(myorder.FOneItem.Freqdate,10) %></option>
									<% else %>
									<option value="2012-05-26" <%= CHKIIF(myorder.FOneItem.Freqdate="2012-05-26","selected","") %> >2012년 5월 26일(토)</option>
									<option value="2012-05-27" <%= CHKIIF(myorder.FOneItem.Freqdate="2012-05-27","selected","") %> >2012년 5월 27일(일)</option>
									<% end if %>
								</select>
								-->
							</td>
						</tr>
	<% else %>
	<!-- 일반주문 -->
						<tr>
							<th scope="row"><label for="purchaserName">받으시는분</label></th>
							<td><input type="text" id="[on,off,2,16][수령인]" name="reqname" value="<%= myorder.FOneItem.Freqname %>" class="txtInp focusOn" style="width:80px;" /></td>
						</tr>
						<tr>
							<th scope="row"><label for="purchaserName">휴대폰번호</label></th>
							<td>
								<input type="text" title="수령인휴대폰1 입력" id="[on,on,2,4][수령인휴대폰1]" name="reqhp1" class="txtInp focusOn" style="width:40px;" value="<%=SplitValue(myorder.FOneItem.Freqhp,"-",0) %>" onkeydown="onlyNumber(this,event);" />
								<span class="symbol">-</span>
								<input type="text" title="수령인휴대폰2 입력" id="[on,on,2,4][수령인휴대폰2]" name="reqhp2" class="txtInp focusOn" style="width:50px;" value="<%=SplitValue(myorder.FOneItem.Freqhp,"-",1) %>" onkeydown="onlyNumber(this,event);" />
								<span class="symbol">-</span>
								<input type="text" title="수령인휴대폰3 입력" id="[on,on,2,4][수령인휴대폰3]" name="reqhp3" class="txtInp focusOn" style="width:50px;" value="<%=SplitValue(myorder.FOneItem.Freqhp,"-",2) %>" onkeydown="onlyNumber(this,event);" />
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="purchaserName">전화번호</label></th>
							<td>
								<input type="text" title="수령인전화1 입력" id="[on,on,2,4][수령인전화1]" name="reqphone1" class="txtInp focusOn" style="width:40px;" value="<%=SplitValue(myorder.FOneItem.Freqphone,"-",0) %>" onkeydown="onlyNumber(this,event);" />
								<span class="symbol">-</span>
								<input type="text" title="수령인전화2 입력" id="[on,on,2,4][수령인전화2]" name="reqphone2" class="txtInp focusOn" style="width:50px;" value="<%=SplitValue(myorder.FOneItem.Freqphone,"-",1) %>" onkeydown="onlyNumber(this,event);" />
								<span class="symbol">-</span>
								<input type="text" title="수령인전화3 입력" id="[on,on,2,4][수령인전화3]" name="reqphone3" class="txtInp focusOn" style="width:50px;" value="<%=SplitValue(myorder.FOneItem.Freqphone,"-",2) %>" onkeydown="onlyNumber(this,event);" />
							</td>
						</tr>
		<% if Not (IsTicketOrder and TicketDlvType="1") then %>
						<tr>
							<th scope="row">주소</th>
							<td>
								<div>
									<input type="text" name="txZip" id="[on,off,3,10][우편번호]" value="<%=myorder.FOneItem.Freqzipcode%>" readonly title="우편번호" class="txtInp focusOn" style="width:60px;" />
									<a href="javascript:TnFindZipNew('frmorder')" class="btn btnS2 btnGry2 rMar05"><span class="fn">우편번호찾기</span></a>
								</div>
								<div class="tPad07">
									<input type="text" id="[on,off,1,100][주소1]" title="기본주소" class="txtInp focusOn" name="txAddr1" value="<%= myorder.FOneItem.Freqzipaddr %>" readonly style="width:390px;" />
								</div>
								<div class="tPad07">
									<input type="text" id="[off,off,0,100][주소2]" title="상세주소" class="txtInp focusOn" name="txAddr2" value="<%= myorder.FOneItem.Freqaddress %>" maxlength="100" style="width:390px;" />
								</div>
							</td>
						</tr>
		<% end if %>
		<% if Not(myorder.FOneItem.IsReceiveSiteOrder or (IsTicketOrder and TicketDlvType="1")) then %>
						<tr>
							<th scope="row"><label for="attention">유의사항</label></th>
							<td><input type="text" id="[off,off,off,off][배송유의사항]" name="comment" value="<%= myorder.FOneItem.Fcomment %>" maxlength="100" class="txtInp focusOn" style="width:390px;" /></td>
						</tr>
		<% end if %>
	<% end if %>
						</tbody>
						</table>

						<div class="btnArea ct tPad20">
							<input type="button" class="btn btnS1 btnRed btnW100" onClick="CheckNSubmit(document.frmorder);" value="수정" />
							<input type="button" class="btn btnS1 btnGry btnW100" onClick="window.close();" value="취소" />
						</div>
					</fieldset>
				</div>
				<!-- //content -->
			</div>
		</div>
<% elseif (etype="flow") then %>
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_order_info_edit_popup.gif" alt="주문정보변경" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="mySection">
					<fieldset>
						<legend>플라워배송 정보 변경 입력 폼</legend>
						<div class="delivery">
							<h2>플라워배송 정보 변경</h2>
						</div>
						<table class="baseTable rowTable docForm">
						<caption>플라워배송 정보 변경</caption>
						<colgroup>
							<col width="120" /> <col width="*" />
						</colgroup>
						<tbody>
						<tr>
							<th scope="row"><label for="senderName">보내시는 분</label></th>
							<td><input type="text" id="[off,off,off,16]보내는 사람" name="fromname" value="<%= myorder.FOneItem.Ffromname %>" maxlength="16" class="txtInp focusOn" style="width:198px;" /></td>
						</tr>
						<tr>
							<th scope="row">희망 배송일</th>
							<td>
								<% DrawOneDateBox SplitValue(myorder.FOneItem.Freqdate,"-",0),SplitValue(myorder.FOneItem.Freqdate,"-",1),SplitValue(myorder.FOneItem.Freqdate,"-",2), myorder.FOneItem.Freqtime %>
							</td>
						</tr>
						<tr>
							<th scope="row">메시지 선택</th>
							<td>
								<div class="radioBox">
									<input type="radio" name="cardribbon" id="msgSelect01" value="1" <% if myorder.FOneItem.Fcardribbon="1" then response.write "checked" %> /><label for="msgSelect01">카드</label>
									<input type="radio" name="cardribbon" id="msgSelect02" value="2" <% if myorder.FOneItem.Fcardribbon="2" then response.write "checked" %> /><label for="msgSelect02">리본</label>
									<input type="radio" name="cardribbon" id="msgSelect03" value="3" <% if myorder.FOneItem.Fcardribbon="3" then response.write "checked" %> /><label for="msgSelect03">없음</label>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="msgText">메시지 내용</label></th>
							<td>
								<textarea id="[off,off,off,100]메세지 내용" cols="50" rows="6" name="message" style="width:402px; height:108px;"><%= myorder.FOneItem.Fmessage %></textarea>
							</td>
						</tr>
						</tbody>
						</table>

						<div class="btnArea ct tPad20">
							<% if (myorder.FOneItem.IsFixDeliverItemExists) then %>
								<input type="hidden" name="fixdeliveryedit" value="on" />
								<input type="button" class="btn btnS1 btnRed btnW100" onClick="CheckNSubmit(document.frmorder);" value="수정" />
								<input type="button" class="btn btnS1 btnGry btnW100" onClick="window.close();" value="취소" />
							<% else %>
								플라워 배송정보를 수정할 수 없습니다. 고객센터로 문의해 주세요.
							<% end if %>
						</div>
					</fieldset>
				</div>
				<!-- //content -->
			</div>
		</div>
<% end if %>
		</form>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<%
set myorder = Nothing
set myorderdetail = Nothing
%>
<% if (etype="payn") then %>
<% if (G_PG_100_USE_INIWEB) then %>
	<script language="javascript" type="text/javascript" src="<%=INIWEB_Jscript%>" charset="UTF-8"></script>
<% else %>
	<script language=javascript src="https://plugin.inicis.com/pay61_uni_cross.js"></script> <!-- non cross SSL -->
	<!-- script language=javascript src="/inipay/pay40_ssl.js"></script --> <!-- non cross -->
	<!-- script type="text/javascript" src="https://plugin.inicis.com/pay61_unissl_cross.js"></script -->
<% end if %>
<script type="text/javascript">
<% if (G_PG_100_USE_INIWEB) then %>
	//StartSmartUpdate(); //ini_web인경우 필요없음.
<% Else %>
	StartSmartUpdate();
<% End If %>
</script>
<% end if %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
