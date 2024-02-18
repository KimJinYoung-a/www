<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 1:1 상담
' History : 2015.05.27 이상구 생성
'			2016.03.25 한용민 수정(문의분야 모두 DB화 시킴)
'###########################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkPopUserGuestLogin.asp" -->
<!-- #include virtual="/lib/util/forceSSL.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/classes/cscenter/myqnacls.asp" -->
<%
'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 1:1 상담 신청하기"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

'SSL확인 및 이동
dim iparams, orderserial, itemid, qadiv, orderdetailidx, gorderserial, eorderserial, userid, i, tmpqadivname, tmpqadivcnt
	orderserial 	= requestCheckVar(request("orderserial"),11)
	qadiv       	= requestCheckVar(request("qadiv"),4)
	itemid      	= requestCheckVar(getNumeric(request("itemid")),9)
	orderdetailidx  = requestCheckVar(request("orderdetailidx"),15)

'// /lib/util/forceSSL.asp 에서 수행한다.(skyer9)
''
'' if request.ServerVariables("SERVER_PORT_SECURE")<>1 then
'' 	if (orderserial<>"") or (qadiv<>"") or (itemid<>"") or (orderdetailidx<>"") then
'' 		iparams = "?orderserial="&orderserial&"&qadiv="&qadiv&"&itemid="&itemid&"&orderdetailidx="&orderdetailidx
'' 	end if
''
''     IF application("Svr_Info")="Dev" THEN
'' 		response.write SSLUrl&"/my10x10/qna/myqnawrite.asp"&iparams
'' 		response.end
''     	response.redirect SSLUrl&"/my10x10/qna/myqnawrite.asp"&iparams
''     else
''     	response.redirect SSLUrl&"/my10x10/qna/myqnawrite.asp"&iparams
''     end if
''     response.end
'' end if

'// request 로 데이타가 않나오면 request.Form 에서 가져온다.
If orderserial = "" Then
	orderserial = requestCheckVar(request.Form("orderserial"), 20)
End If

If itemID = "" Then
	itemID = requestCheckVar(request.Form("itemID"), 20)
End If

If orderdetailidx = "" Then
	orderdetailidx = requestCheckVar(request.Form("orderdetailidx"), 20)
End If

If qadiv = "" Then
	qadiv = requestCheckVar(request.Form("qadiv"), 20)
End If

if (itemID = "") then
	orderdetailidx = ""
end if

'if (orderserial<>"") then itemid=""

if IsGuestLoginOK() then
	orderserial = GetGuestLoginOrderserial()
	gorderserial = GetGuestLoginOrderserial()
	eorderserial = CStr(((gorderserial + 53287) * 3) - 59309)			'// 대강 암호화(이미지 업로드 서버와 숫자가 동일해야 한다., skyer9)
end if

''201006 추가==================================
if IsUserLoginOK() then getDBUserLevel2Cookie()
''=============================================

dim myorder, myorderList, myorderdetail, OUserInfo, usermail, itemno, itemnoInput
set myorder = new CMyOrder
set myorderList = new CMyOrder
set myorderdetail = new CMyOrder

if IsUserLoginOK() then
	set OUserInfo = new CUserInfo
	OUserInfo.FRectUserID = getEncLoginUserID()
	OUserInfo.GetUserData()

	if OUserInfo.FResultCount > 0 then
		usermail = OUserInfo.FOneItem.FUsermail
	end if

	set OUserInfo = Nothing

	if (orderserial = "") then
		'// 회원인 경우 주문번호 자동설정
		myorderList.FRectUserID = getEncLoginUserID()
		myorderList.FPageSize = 10
		myorderList.FCurrpage = 1
        myorderList.FRectStartDate = Left(DateAdd("d", -30, Now()), 10)
        myorderList.FrectSiteName = "10x10"
        myorderList.FrectSearchGubun = "incCancel"

        myorderList.GetMyOrderListProc

		if myorderList.FResultCount = 1 then
            '// 최근 한달 주문이 한건일 경우만 자동설정
			orderserial = myorderList.FItemList(0).FOrderSerial
		end if
	end if
end if

if (orderserial<>"") then
    if IsUserLoginOK() then
        myorder.FRectUserID = getEncLoginUserID()
        myorder.FRectOrderserial = orderserial
        myorder.GetOneOrder
    elseif IsGuestLoginOK() then
        myorder.FRectUserID = userid
        myorder.FRectOrderserial = orderserial
        myorder.GetOneOrder
    end if

	if (itemid = "") then
		'// 상품 한가지만 주문한 경우 자동설정
		Call myorder.GetOneOrderDetailIfOneItem(itemid, orderdetailidx)
	end if

	if orderdetailidx <> "" then
	    if IsUserLoginOK() then
	        myorderdetail.FRectUserID = userid
	        myorderdetail.FRectOrderserial = orderserial
	        myorderdetail.FRectIdx = orderdetailidx
	        myorderdetail.GetOneOrderDetail
	    elseif IsGuestLoginOK() then
	        myorderdetail.FRectOrderserial = orderserial
	        myorderdetail.FRectIdx = orderdetailidx
	        myorderdetail.GetOneOrderDetail
	    end if

		if myorderdetail.FTotalcount>0 then
			itemno = myorderdetail.FOneItem.FItemNo
		end if

		if (itemno = 1) then
			itemnoInput = 1
		end if
	end if
end if

dim oItem, ItemExists
set oItem = New CatePrdCls

if itemid<>"" then
	if itemid<>0 then
	    oItem.GetItemData itemid

	    if (oItem.Prd.FItemid="") then
	        response.write "<script language='javascript'>alert('검색된 상품이 없습니다.');</script>"

	        itemid = ""
	        orderdetailidx = ""
	    else
	        ItemExists = True
	    end if
	end if
end if

dim cqadiv
set cqadiv = new CMyQNA
	cqadiv.FPageSize = 500
	cqadiv.FCurrPage = 1
	cqadiv.frectcomm_isdel = "N"
	cqadiv.frectdispyn = "Y"
	cqadiv.getqadiv_list()

%>

<!-- #include virtual="/lib/inc/head_ssl.asp" -->

<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup_ssl.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">

/* global $, IsDigit, getValue, setValue, getCheckedIndex */

self.resizeTo(925,800);
self.focus();

$(function(){
	// layer popup
	$('#addInfo1').hover(function(){
		$('#contLyr1').toggle();
	});

    $('#addInfo2').hover(function(){
		$('#contLyr2').toggle();
	});
});

function popMyOrderNo() {
	var frm = document.SubmitFrm;
	var url = "/my10x10/orderPopup/popMyOrderNo.asp?frmname=" + frm.name + "&targetname=" + frm.orderserial.name;
	window.open(url,'popMyOrderNo','width=750,height=565,scrollbars=yes,resizable=yes');
}

function popMyOrderItemIDOption() {
	var frm = document.SubmitFrm;
	var url = "/my10x10/orderPopup/popMyOrderItemIDOption.asp?frmname=" + frm.name + "&targetname=" + frm.itemid.name + "&targetdetailname=" + frm.orderdetailidx.name + "&orderserial=" + frm.orderserial.value;
	window.open(url,'popMyOrderItemIDOption','width=700,height=800,scrollbars=yes,resizable=yes');
}

function getItemInfo(frm){
	if (frm.tmpitemid.value.length<1){
		alert("상품번호를 먼저 넣어주세요.");
		frm.tmpitemid.focus();
		return;
	}

	if (!IsDigit(frm.tmpitemid.value)||(frm.tmpitemid.value=="")) {
	    alert("상품번호는 숫자만 가능합니다.");
		frm.tmpitemid.focus();
		return;
	} if (getValue(frm.qadiv)!="02") {
		alert("직접입력은 상품문의일때만 가능합니다.");
	} else {
		frm.orderserial.value= "";
		frm.orderdetailidx.value= "";
		frm.itemid.value = frm.tmpitemid.value;
		frm.submit();
	}
}

function jsDelUpFile() {
	document.getElementById("idDivInputFile").innerHTML = document.getElementById("idDivInputFile").innerHTML;
}

function jsDelUpFile2() {
	document.getElementById("idDivInputFile2").innerHTML = document.getElementById("idDivInputFile2").innerHTML;
}

function SubmitForm(frm){
    var qaIdx = getCheckedIndex(frm.qadiv);

    if (qaIdx<0){
        alert("상담구분을 선택해주세요!!");
        frm.qadiv[0].focus();
        return;
    }
    var qadiv = frm.qadiv[qaIdx].value;

/*
	if (qadiv=="10") {
		//시스템문의
		if(frm.OS.value=="")
		{
			alert("운영체제를 선택해주세요.");
			return;
		}
	}
*/
    if (frm.title.value.length<1) {
        alert("제목을 입력하세요.");
        frm.title.focus();
        return;
    }

	if (frm.contentsView.value.length<1) {
        alert("내용을 입력하세요.");
        frm.contentsView.focus();
        return;
    }

    if (frm.usermail.value.length<1) {
        alert("이메일을 입력하세요.");
        frm.usermail.focus();
        return;
    }

    if (!check_form_email(frm.usermail.value)){
        alert("이메일 주소가 유효하지 않습니다.");
        frm.usermail.focus();
        return;
    }

	if (document.getElementById("layoutView1").style.display == "none") {
		// 주문번호 없는 경우
		frm.orderserial.value= "";
	}

	if ((document.getElementById("layoutView2").style.display == "none") && (document.getElementById("layoutView3").style.display == "none")) {
		// 상품코드 없는 경우
		frm.itemid.value= "";
		frm.orderdetailidx.value= "";
	} else if (document.getElementById("layoutView3").style.display != "none") {
		frm.orderserial.value= "";
		frm.orderdetailidx.value= "";
		frm.itemid.value = frm.tmpitemid.value;
	}

	if ((frm.itemid.value != "") && (IsDigit(frm.itemid.value) != true)) {
		alert("상품번호는 숫자만 가능합니다.");
		return;
	}

	if (calculate_msglen(frm.title.value) > 100) {
		alert("제목은 100자까지만 가능합니다.");
		frm.title.focus();
        return;
	}

	if (calculate_msglen(frm.contentsView.value) > 16000) {
		alert("내용은 16000자까지만 가능합니다.\n\n상담내용을 나누어 입력하세요.");
		frm.contentsView.focus();
        return;
	}

	if (qadiv == "14") {
		if (frm.orderserial.value == "") {
			alert("주문번호를 선택하세요");
			return;
		}

		if (frm.orderdetailidx.value == "") {
			alert("상품코드를 선택하세요");
			return;
		}

		if ((frm.returnItemNo.value == "") || (IsDigit(frm.returnItemNo.value) != true)) {
			alert("반품수량을 입력하세요.");
			return;
		}

		if (frm.returnReason.selectedIndex == 0) {
			alert("반품사유를 선택하세요.");
        	return;
		}
	}

    if (confirm("내용을 정확히 입력하셨습니까?")) {
		if (qadiv == "14") {
			frm.contents.value = "\n&gt;&gt;&gt; <b>반품정보 : 수량 :" + frm.returnItemNo.value + "개 / 사유 : " + frm.returnReason.value + "</b>\n\n" + frm.contentsView.value;
		}else{
		    frm.contents.value =frm.contentsView.value;
		}

		frm.backurl.value = "/my10x10/qna/myqnalist.asp";
		frm.method = 'post';
		frm.target = "hiddenFrm";
		if (frm.sfile.value != "" || frm.sfile2.value != "") {
			document.getElementById('idfrm').encoding = 'multipart/form-data';
			frm.action = '<%= Replace(uploadImgUrl, "http://", "https://") %>/linkweb/my10x10/uploadMyQnaFileUTF8_New.asp';
		} else {
			frm.action = "myqna_process.asp";
		}
        frm.submit();
    }
}

function closePopup() {
	location.href='<%= wwwUrl %>/my10x10/qna/closePopup.asp';
}

function check_form_email(email){
	var pos;
	pos = email.indexOf('@');
	if (pos < 0){				//@가 포함되어 있지 않음
		return(false);
	}else{

		pos = email.indexOf('@', pos + 1);
		if (pos >= 0)			//@가 두번이상 포함되어 있음
			return(false);
	}

	pos = email.indexOf('.');

	if (pos < 0){				//@가 포함되어 있지 않음
		return false;
    }
	return(true);
}

window.onload = function() {
	setValue(document.SubmitFrm.qadiv,"<%=qaDiv%>");
	initDiv();
};

function initDiv() {
	var frm = document.SubmitFrm;
	var qaDiv = getValue(frm.qadiv);

	document.getElementById("layoutView1").style.display = "none";
	document.getElementById("layoutView2").style.display = "none";
	document.getElementById("layoutView3").style.display = "none";
	document.getElementById("layoutView4").style.display = "none";
	document.getElementById("layoutView5").style.display = "none";
	document.getElementById("layoutView6").style.display = "none";
	document.getElementById("layoutView7").style.display = "none";

	if (qaDiv=="02") {
		document.getElementById("layoutView3").style.display = "";
	} else if (qaDiv=="00" || qaDiv=="01" || qaDiv=="04" || qaDiv=="14" || qaDiv=="06" || qaDiv=="05"  || qaDiv=="15" || qaDiv=="09" || qaDiv=="23" || qaDiv=="25") {
		document.getElementById("layoutView1").style.display = "";
		document.getElementById("layoutView2").style.display = "";

		if (qaDiv == "14") {
			// 반품문의
			document.getElementById("layoutView4").style.display = "";
		}
	} else if (qaDiv=="10") {
		//시스템문의
		document.getElementById("layoutView5").style.display = "";
		document.getElementById("layoutView6").style.display = "";
	}
}

function fnSystemChoiceDiv(div) {
	document.getElementById("layoutView7").style.display = "none";
	if (div=="P") {
		document.getElementById("layoutView7").style.display = "none";
		$("#OS option").remove();
		$("#OS").append("<option value=''>선택안함</option>");
		$("#OS").append("<option value='Mac'>Mac</option>");
		$("#OS").append("<option value='WIN10'>WIN10</option>");
		$("#OS").append("<option value='WIN8'>WIN8</option>");
		$("#OS").append("<option value='WIN7'>WIN7</option>");
		$("#OS").append("<option value='WIN XP 이하'>WIN XP 이하</option>");
		$("#OS").append("<option value='WIN NT'>WIN NT</option>");
		$("#OS").append("<option value='Linux'>Linux</option>");
	} else {
		document.getElementById("layoutView7").style.display = "";
		$("#OS option").remove();
		$("#OS").append("<option value=''>선택안함</option>");
		$("#OS").append("<option value='iOS'>iOS</option>");
		$("#OS").append("<option value='Android'>Android</option>");
	}
}

function updateChar(val) {
	var len = calculate_msglen(val);

	document.getElementById("charlen").innerHTML = "(" + len + "/16000)";
}

function calculate_msglen(msg) {
	var nbytes = 0;

	for (var i = 0; i < msg.length; i++) {
		var ch = msg.charAt(i);

		if(escape(ch).length > 4) {
			nbytes += 2;
		} else if(ch == '\n') {
			if (msg.charAt(i-1) != '\r') {
				nbytes += 1;
			}
		} else {
			nbytes += 1;
		}
	}

	return nbytes;
}

function changeReturnDeliveryPay() {
	var frm = document.SubmitFrm;

	if (frm.returnReason.selectedIndex == 1) {
		$( ".returnDeliveryPay" ).html( "환불시 반품배송비가 차감됩니다." );
	} else if (frm.returnReason.selectedIndex == 2) {
		$( ".returnDeliveryPay" ).html( "반품배송비 : 무료<br />(상품확인 후 '상품불량'이 아닐 경우, 환불시 반품배송비가 차감됩니다.)" );
	} else if (frm.returnReason.selectedIndex == 3) {
		$( ".returnDeliveryPay" ).html( "반품배송비 : 무료<br />(상품확인 후 '누락/오배송'이 아닐 경우, 환불시 반품배송비가 차감됩니다.)" );
	} else {
		$( ".returnDeliveryPay" ).html( "" );
	}
}

</script>
</head>
<body>
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="/fiximage/web2013/my10x10/tit_consult_apply<%=CHKIIF(IsVIPUser()=True,"_vip","")%>.gif" alt="<%=CHKIIF(IsVIPUser()=True,"VIP ","")%>1:1 상담신청" /></h1>
		</div>
		<div class="popContent">
			<!-- content -->
			<div class="mySection">
				<ul class="list">
					<li>문의하실 분야를 선택하신 후 내용을 입력하신 다음 &quot;신청하기 &quot; 버튼을 눌러주세요.</li>
					<li><em class="crRed">한번 등록한 상담내용은 수정이 불가능합니다. 수정을 원하시는 경우, 삭제 후 재등록 하셔야 합니다.</em></li>
				</ul>
				<form id="idfrm" name="SubmitFrm" method="get" action="" onsubmit="return false;">
				<input type="hidden" name="mode" value="">
				<input type="hidden" name="backurl" value="">
				<input type="hidden" name="gorderserial" value="<%= gorderserial %>">
				<input type="hidden" name="eorderserial" value="<%= eorderserial %>">
				<fieldset>
					<legend>1:1 상담신청</legend>
					<table class="baseTable rowTable docForm tMar15">
					<caption>1:1 상담신청</caption>
					<colgroup>
						<col width="120" /> <col width="*" /> <col width="120" /> <col width="290" />
					</colgroup>
					<tbody>
					<tr>
						<th scope="row" rowspan="3" class="ct">문의분야</th>
						<td colspan="3">
							<div class="itemField">
								<span>구매관련 문의</span>
								<ul>
									<%
									tmpqadivcnt=0
									if cqadiv.FResultCount > 0 then
									%>
										<%
										for i = 0 to cqadiv.FResultCount - 1

										if isarray(split(cqadiv.FItemList(i).fcomm_name,"!@#")) then
											if ubound(split(cqadiv.FItemList(i).fcomm_name,"!@#")) > 0 then
												tmpqadivname =  split(cqadiv.FItemList(i).fcomm_name,"!@#")(1)
											end if
										end if
										%>
											<%
											'/구매관련 문의만 뿌림
											if cqadiv.FItemList(i).fcomm_group="D001" then

											tmpqadivcnt = tmpqadivcnt + 1
											%>
												<% if instr(tmpqadivname,"선물포장")>0 then %>
													<% If G_IsPojangok Then %>
														<li><input type="radio" id="aboutBuy<%= Format00(2,tmpqadivcnt) %>" name="qadiv" value="<%= right(cqadiv.FItemList(i).fcomm_cd,2) %>" onClick="initDiv();" /> <label for="aboutBuy<%= Format00(2,tmpqadivcnt) %>"><%= tmpqadivname %></label></li>
													<% End If %>
												<% else %>
													<li><input type="radio" id="aboutBuy<%= Format00(2,tmpqadivcnt) %>" name="qadiv" value="<%= right(cqadiv.FItemList(i).fcomm_cd,2) %>" onClick="initDiv();" /> <label for="aboutBuy<%= Format00(2,tmpqadivcnt) %>"><%= tmpqadivname %></label></li>
												<% end if %>
											<% end if %>
										<%
										tmpqadivname = ""

										next
										%>
									<% end if %>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div class="itemField">
								<span>일반상담 문의</span>
								<ul>
									<%
									tmpqadivcnt=0
									if cqadiv.FResultCount > 0 then
									%>
										<%
										for i = 0 to cqadiv.FResultCount - 1

										if isarray(split(cqadiv.FItemList(i).fcomm_name,"!@#")) then
											if ubound(split(cqadiv.FItemList(i).fcomm_name,"!@#")) > 0 then
												tmpqadivname =  split(cqadiv.FItemList(i).fcomm_name,"!@#")(1)
											end if
										end if
										%>
											<%
											'/일반상담 문의만 뿌림
											if cqadiv.FItemList(i).fcomm_group="D002" then

											tmpqadivcnt = tmpqadivcnt + 1
											%>
												<li><input type="radio" id="aboutCommon<%= Format00(2,tmpqadivcnt) %>" name="qadiv" value="<%= right(cqadiv.FItemList(i).fcomm_cd,2) %>" onClick="initDiv();" /> <label for="aboutCommon<%= Format00(2,tmpqadivcnt) %>"><%= tmpqadivname %></label></li>
											<% end if %>
										<%
										tmpqadivname = ""

										next
										%>
									<% end if %>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div class="itemField">
							<span>기타 문의</span>
								<ul>
									<%
									tmpqadivcnt=0
									if cqadiv.FResultCount > 0 then
									%>
										<%
										for i = 0 to cqadiv.FResultCount - 1

										if isarray(split(cqadiv.FItemList(i).fcomm_name,"!@#")) then
											if ubound(split(cqadiv.FItemList(i).fcomm_name,"!@#")) > 0 then
												tmpqadivname =  split(cqadiv.FItemList(i).fcomm_name,"!@#")(1)
											end if
										end if
										%>
											<%
											'/기타 문의만 뿌림
											if cqadiv.FItemList(i).fcomm_group="D003" then

											tmpqadivcnt = tmpqadivcnt + 1
											%>
												<li><input type="radio" id="aboutEtc<%= Format00(2,tmpqadivcnt) %>" name="qadiv" value="<%= right(cqadiv.FItemList(i).fcomm_cd,2) %>" onClick="initDiv();" /> <label for="aboutEtc<%= Format00(2,tmpqadivcnt) %>"><%= tmpqadivname %></label></li>
											<% end if %>
										<%
										tmpqadivname = ""

										next
										%>
									<% end if %>
								</ul>
							</div>
						</td>
					</tr>
					<tr id="layoutView1" name="layoutView1" >
						<th scope="row" class="ct"><label for="orderNum">주문번호</label></th>
						<td colspan="3">
							<input type="text" id="orderNum" name="orderserial" value="<%= orderserial %>" class="txtInp rMar05 crRed fb" style="width:118px;" />
							<a href="javascript:popMyOrderNo();" class="btn btnS2 btnRed btnW80"><span class="fn">주문검색</span></a>
							<% if myorder.FResultCount>0 then %>
							<span class="lPad05">주문일 <%= Left(myorder.FOneItem.FRegdate,10) %> <strong class="crRed lPad10">총 결제금액 <%= FormatNumber(myorder.FOneItem.FSubTotalPrice,0) %> 원 (<%= myorder.FOneItem.getAccountDivName %>)</strong></span>
							<% end if %>
						</td>
					</tr>
					<tr id="layoutView2" name="layoutView2" >
						<th scope="row" class="ct"><label for="productCode01">상품코드</label></th>
						<td colspan="3">
							<input type="text" id="productCode01" name="itemid" value="<%= itemid %>" class="txtInp cr555 fb rMar05" style="width:118px;" />
							<input type="hidden" name="orderdetailidx" value="<%= orderdetailidx %>">
							<a href="javascript:popMyOrderItemIDOption();" class="btn btnS2 btnGry2 btnW80"><span class="fn">주문한상품</span></a>
							<% if (ItemExists) then %>
							<span class="lPad05">
								<%= chrbyte(oItem.Prd.FItemName,30,"Y") %>
								<% if myorder.FResultCount>0 then %>
									<% if myorderdetail.FTotalcount>0 then %>
										<% if myorderdetail.FOneItem.FItemOption <> "0000" then %>
											[<%= myorderdetail.FOneItem.FItemOptionName %>]
										<% end if %>
									<% end if %>
								<% end if %>
							</span>
							<% end if %>
						</td>
					</tr>

					<tr id="layoutView3" name="layoutView3" >
						<th scope="row" class="ct">
							<div class="layPop">
								<label for="productCode02">상품코드</label> <a href="#" class="addInfo" id="addInfo1"><img src="/fiximage/web2013/common/ico_help.gif" alt="정보 더보기" /></a>
								<div class="contLyr" id="contLyr1">
									<div class="contLyrInner moreInfo">
										<p><strong>상품페이지 우측 상단<br /> 판매정보에서 확인하실 수 있습니다</strong></p>
										<ul>
											<li><span class="title">판매가</span> <span class="con"><strong class="cr000">123,000원</strong></span></li>
											<li><span class="title">배송구분</span> <span class="con">텐바이텐배송+해외배송</span></li>
										</ul>
										<div class="code"><em>상품코드 : 123456</em></div>
									</div>
								</div>
							</div>
						</th>
						<td colspan="3">
							<input type="text" id="productCode02" name="tmpitemid" value="<%= itemid %>" class="txtInp cr555 fb rMar05" style="width:118px;" />
							<a href="javascript:getItemInfo(document.SubmitFrm);" class="btn btnS2 btnRed btnW80"><span class="fn">직접입력</span></a>
							<% if (ItemExists) then %>
							<span class="lPad05">
								<%= chrbyte(oItem.Prd.FItemName,30,"Y") %>
								<% if myorder.FResultCount>0 then %>
									<% if myorderdetail.FTotalcount>0 then %>
										<% if myorderdetail.FOneItem.FItemOption <> "0000" then %>
											[<%= myorderdetail.FOneItem.FItemOptionName %>]
										<% end if %>
									<% end if %>
								<% end if %>
							</span>
							<% end if %>
						</td>
					</tr>

					<tr id="layoutView4" name="layoutView4" >
						<th scope="row" class="ct">반품수량 및 사유</th>
						<td colspan="3">
							<span class="ftLt tPad07">수량 : </span>
							<span class="ftLt lPad05 rPad20">
								<input type="text" id="returnItemNo" name="returnItemNo" class="txtInp" style="width:20px;" value="<%= itemnoInput %>"/>
								<% if itemno <> "" then %>
								/ <%= itemno %>
								<% end if %>
							</span>
							<span class="lPad30 ftLt tPad07">사유 : </span>
							<span class="ftLt lPad05">
								<select class="select" name="returnReason" onChange="changeReturnDeliveryPay()">
									<option value="">사유를 선택하세요</option>
									<option value="단순변심">단순변심</option>
									<option value="상품불량">상품불량</option>
									<option value="상품누락/오배송">상품누락/오배송</option>
								</select>
							</span>
							<span class="ftLt tPad07 lPad05 fs11 returnDeliveryPay"></span>
						</td>
					</tr>
					<tr id="layoutView5" name="layoutView5" >
						<th scope="row" class="ct">시스템 환경</th>
						<td colspan="3">
							<div class="itemField">
								<ul>
									<li><input type="radio" name="device" value="P" checked onClick="fnSystemChoiceDiv('P');" /><label>PC</label></li>
									<li><input type="radio" name="device" value="M" onClick="fnSystemChoiceDiv('M');" /><label>Moblie</label></li>
								</ul>
							</div>
						</td>
					</tr>
					<tr id="layoutView6" name="layoutView6" >
						<th scope="row" class="ct">운영체제 및 기기</th>
						<td colspan="3">
							<span class="ftLt lPad05">
								<select class="select" name="OS" id="OS">
									<option value="">선택안함</option>
									<option value="Mac">Mac</option>
									<option value="WIN10">WIN10</option>
									<option value="WIN8">WIN8</option>
									<option value="WIN7">WIN7</option>
									<option value="WIN XP 이하">WIN XP 이하</option>
									<option value="WIN NT">WIN NT</option>
									<option value="Linux">Linux</option>
								</select>
							</span>
							<span class="ftLt lPad05 rPad20" id="layoutView7">
								<input type="text" id="OSetc" name="OSetc" class="txtInp" placeholder="예:아이폰X" maxlength="15" style="width:100px;"/>
							</span>
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct">주문자</th>
						<td>
							<% if GetLoginUserName() <> "" then %>
							<%=GetLoginUserName()%>
							<% else %>
							<input type="text" name="username" class="txtInp" value="" maxlength="16">
							<% end if %>
						</td>
						<th scope="row" class="ct">아이디</th>
						<td>
							<% if getLoginUserID() <> "" then %>
								<%= getLoginUserID() %> [<span class="<%= GetUserLevelCSSClass() %>"><strong><%= GetUserLevelStr(GetLoginUserLevel) %></strong></span>고객]
							<% end if %>
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct"><label for="subject">제목</label></th>
						<td colspan="3">
							<input type="text" id="subject" name="title" class="txtInp" style="width:670px;" />
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct"><label for="message">내용<br><div id="charlen">(0/16000)</div></label></th>
						<input type="hidden" name="contents" value="">
						<td colspan="3">
							<textarea id="message" name="contentsView" cols="60" rows="8" style="width:680px; height:188px;" onKeyUp="updateChar(this.value)"></textarea>
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct">
							<div class="layPop">
								사진 첨부 <a href="#" class="addInfo" id="addInfo2"><img src="/fiximage/web2013/common/ico_help.gif" alt="정보 더보기" /></a>
								<div class="contLyr" id="contLyr2">
									<div class="contLyrInner moreInfo">
										<p>상담시 이미지가 필요하신 경우 입력해 주시기 바랍니다.</p>
									</div>
								</div>
							</div>
						</th>
						<td colspan="3">
							<div class="attachFile" id="idDivInputFile">
								<input type="file" title="첨부이미지 찾아보기" name="sfile" class="inputFile" style="width:570px;" />
								<button type="button" class="btnListDel" onClick="jsDelUpFile();">삭제</button>
							</div>
							<div class="attachFile tMar10" id="idDivInputFile2">
								<input type="file" title="첨부이미지 찾아보기" name="sfile2" class="inputFile" style="width:570px;" />
								<button type="button" class="btnListDel" onClick="jsDelUpFile2();">삭제</button>
							</div>
							<p class="tMar07 fs12">파일크기는 3MB이하, JPG, PNG 또는 GIF형식의 파일만 가능합니다.</p>
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct">이메일주소</th>
						<td colspan="3">
							<input type="text" title="이메일 아이디 입력" name="usermail" value="<%= usermail %>" class="txtInp" style="width:200px;" />
						</td>
					</tr>
					<tr>
						<th scope="row" class="ct">휴대전화번호</th>
						<td colspan="3">
							<input type="text" name="userphone" title="휴대전화 입력" class="txtInp" style="width:150px;" />
							<span class="lPad05">답변등록시 알림을 원하실 경우 연락처 등록부탁드립니다.</span>
						</td>
					</tr>
					</tbody>
					</table>

					<div class="btnArea ct tPad30">
						<input type="button" class="btn btnS1 btnRed btnW160" value="신청하기" onClick="SubmitForm(document.SubmitFrm);" />
						<button type="button" class="btn btnS1 btnGry btnW160" onClick="window.close();">취소하기</button>
					</div>
				</fieldset>
				</form>
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

<iframe name="hiddenFrm" src="" width="0" height="0" style="visibility:hidden;display:none"></iframe>

</body>
</html>

<%
set cqadiv = nothing
set myorder = Nothing
set oItem = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
