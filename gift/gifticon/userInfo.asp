<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "utf-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/ItemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_itemcouponcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_couponcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_mileageshopitemcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/emscls.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 기프티콘 교환"
	
	Dim vQuery, vIdx, vResult, vItemID, vItemOption, vRequiredetail, vCouponNO, vOptionname, vMakerID, vBrandName, vListImage, vItemName
	vIdx = requestCheckVar(request("idx"),10)
	vItemID = requestCheckVar(request("itemid"),10)
	If vIdx = "" Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		dbget.close()
		Response.End
	End If
	IF IsNumeric(vIdx) = false Then
		Response.Write "<script language='javascript'>alert('잘못된 접근입니다.');document.location.href = '/';</script>"
		dbget.close()
		Response.End
	End If
	
	vQuery = "SELECT itemid, itemname, itemoption, couponno, itemoption, optionname, makerid, brandname, listimage, isNull(requiredetail,'') AS requiredetail "
	vQuery = vQuery & "From [db_order].[dbo].[tbl_mobile_gift] Where idx = '" & vIdx & "' AND gubun = 'gifticon'"
	rsget.Open vQuery,dbget,1
	IF Not rsget.EOF THEN
		vItemID			= rsget("itemid")
		vItemName		= rsget("itemname")
		vItemOption		= rsget("itemoption")
		vOptionname		= rsget("optionname")
		vCouponNO		= rsget("couponno")
		vItemOption 	= rsget("itemoption")
		vMakerID		= rsget("makerid")
		vBrandName		= rsget("brandname")
		vListImage		= rsget("listimage")
		vRequiredetail 	= db2html(rsget("requiredetail"))
	End IF
	rsget.close

	Dim userid, guestSessionID, i
	userid = GetLoginUserID
	guestSessionID = GetGuestSessionKey

	Dim oUserInfo
	set oUserInfo = new CUserInfo
	oUserInfo.FRectUserID = userid
	if (userid<>"") then
	    oUserInfo.GetUserData
	end if
	
	if (oUserInfo.FresultCount<1) then
	    ''Default Setting
	    set oUserInfo.FOneItem    = new CUserInfoItem
	end if


	'################################### 옵션 ###################################
	dim oItem, ItemContent
	set oItem = new CatePrdCls
	oItem.GetItemData vItemID
	
	if oItem.FResultCount=0 then
		Call Alert_Return("존재하지 않는 상품입니다.")
		response.End
	end if

	if oItem.Prd.Fisusing="N" then
		Call Alert_Return("판매가 종료되었거나 삭제된 상품입니다.")
		response.End
	end if
	
	
	'//옵션 HTML생성
	dim ioptionBoxHtml
	IF (oitem.Prd.FOptionCnt>0) then
	    ioptionBoxHtml = GetOptionBoxHTML(vItemID, oitem.Prd.IsSoldOut)
	End IF
	If ioptionBoxHtml = "" Then
		ioptionBoxHtml = "<center>-</center>"
	End If
	
	function ImageExists(byval iimg)
		if (IsNull(iimg)) or (trim(iimg)="") or (Right(trim(iimg),1)="\") or (Right(trim(iimg),1)="/") then
			ImageExists = false
		else
			ImageExists = true
		end if
	end function
	'################################### 옵션 ###################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/contentV15.css" />
<script type="text/javascript">
$(document).unbind("dblclick");
var ChkErrMsg;

function check_form_email(email){
	var pos;
	pos = email.indexOf('@');
	if (pos < 0){				//@가 포함되어 있지 않음
		return(false);
	}else{
		
		pos = email.indexOf('@', pos + 1)
		if (pos >= 0)			//@가 두번이상 포함되어 있음
			return(false);
	}


	pos = email.indexOf('.');

	if (pos < 0){				//@가 포함되어 있지 않음
		return false;
    }
	return(true);
}

function copyDefaultinfo(comp){
    var frm = document.frmorder;
    
    if (comp.value=="O"){
        frm.reqname.value=frm.buyname.value;

		frm.reqphone1.value=frm.buyphone1.value;
		frm.reqphone2.value=frm.buyphone2.value;
		frm.reqphone3.value=frm.buyphone3.value;

		frm.reqhp1.value=frm.buyhp1.value;
		frm.reqhp2.value=frm.buyhp2.value;
		frm.reqhp3.value=frm.buyhp3.value;
		
		if (frm.buyZip1){
		    frm.txZip1.value = frm.buyZip1.value;
		    frm.txZip2.value = frm.buyZip2.value;
		    frm.txAddr1.value = frm.buyAddr1.value;
		    frm.txAddr2.value = frm.buyAddr2.value;
		}
		
    }else if (comp.value=="N"){
        frm.reqname.value = "";
        frm.reqphone1.value = "";
        frm.reqphone2.value = "";
        frm.reqphone3.value = "";
        frm.reqhp1.value = "";
        frm.reqhp2.value = "";
        frm.reqhp3.value = "";
        frm.txZip1.value = "";
        frm.txZip2.value = "";
        frm.txAddr1.value = "";
        frm.txAddr2.value = "";
    }else if (comp.value=="M"){     //해외주소New
        frm.reqname.value = "";
        frm.reqphone1.value = "";
        frm.reqphone2.value = "";
        frm.reqphone3.value = "";
        frm.reqphone4.value = "";
        
        frm.reqemail.value = "";
        frm.emsZipCode.value = "";
        
        frm.txAddr1.value = "";
        frm.txAddr2.value = "";
    }else if (comp.value=="F"){
        PopSeaAddress();
    }else if (comp.value=="P"){
        PopOldAddress();
    }
    
    
}

function copyinfo(comp){
	var frm = document.frmorder;

	if (comp.checked==true){
		frm.reqname.value=frm.buyname.value;

		frm.reqphone1.value=frm.buyphone1.value;
		frm.reqphone2.value=frm.buyphone2.value;
		frm.reqphone3.value=frm.buyphone3.value;

		frm.reqhp1.value=frm.buyhp1.value;
		frm.reqhp2.value=frm.buyhp2.value;
		frm.reqhp3.value=frm.buyhp3.value;
	}else{
		frm.reqname.value="";

		frm.reqphone1.value="";
		frm.reqphone2.value="";
		frm.reqphone3.value="";

		frm.reqhp1.value="";
		frm.reqhp2.value="";
		frm.reqhp3.value="";
	};

}

function checkArmiDlv(){
    var reTest = new RegExp('사서함'); 
    return reTest.test(frmorder.txAddr2.value);
    
}

function searchzip(frmName){
	var popwin = window.open('/common/searchzip.asp?target=' + frmName, 'searchzip10', 'width=560,height=680,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function searchzipBuyer(frmName){
	var popwin = window.open('/common/searchzip.asp?target=' + frmName + '&strMode=buyer', 'searchzip10', 'width=560,height=680,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function PopOldAddress(){
	var popwin = window.open('/my10x10/MyAddress/popMyAddressList.asp','popMyAddressList','width=600,height=300,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function PopSeaAddress(){
	var popwin = window.open('/my10x10/MyAddress/popSeaAddressList.asp','popSeaAddressList','width=600,height=300,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function optionsave(){
    var frm = document.frmorder;
    var optCode = "0000";

    var MOptPreFixCode="Z";

    if (!frm.item_option){
        //옵션 없는경우

    }else if (!frm.item_option[0].length){
        //단일 옵션
        if (frm.item_option.value.length<1){
            alert('옵션을 선택 하세요.');
            frm.item_option.focus();
            return false;
        }

        if (frm.item_option.options[frm.item_option.selectedIndex].id=="S"){
            alert('품절된 옵션은 구매하실 수 없습니다.');
            frm.item_option.focus();
            return false;
        }

        optCode = frm.item_option.value;
    }else{
        //이중 옵션 경우

        for (var i=0;i<frm.item_option.length;i++){
            if (frm.item_option[i].value.length<1){
                alert('옵션을 선택 하세요.');
                frm.item_option[i].focus();
                return false;
            }

            if (frm.item_option[i].options[frm.item_option[i].selectedIndex].id=="S"){
                alert('품절된 옵션은 구매하실 수 없습니다.');
                frm.item_option[i].focus();
                return false;
            }

            if (i==0){
                optCode = MOptPreFixCode + frm.item_option[i].value.substr(1,1);
            }else if (i==1){
                optCode = optCode + frm.item_option[i].value.substr(1,1);
            }else if (i==2){
                optCode = optCode + frm.item_option[i].value.substr(1,1);
            }
        }

        if (optCode.length==2){
            optCode = optCode + "00";
        }

        if (optCode.length==3){
            optCode = optCode + "0";
        }
    }

    frm.itemoption.value = optCode;

    if (frm.requiredetail){

		if (frm.requiredetail.value.length<1){
			alert('주문 제작 상품 문구를 작성해 주세요.');
			frm.requiredetail.focus();
			return false;
		}

		if(GetByteLength(frm.requiredetail.value)>255){
			alert('문구 입력은 한글 최대 120자 까지 가능합니다.');
			frm.requiredetail.focus();
			return false;
		}
	}
	return true;
}

function CheckForm(frm){
    if (frm.buyname.value.length<1){
        alert('주문자 명을 입력하세요.');
        frm.buyname.focus();
        return false;
    }
    
    if ((frm.buyphone1.value.length<1)||(!IsDigit(frm.buyphone1.value))){
        alert('주문자 전화번호를 입력하세요.');
        frm.buyphone1.focus();
        return false;
    }
    
    if ((frm.buyphone2.value.length<1)||(!IsDigit(frm.buyphone2.value))){
        alert('주문자 전화번호를 입력하세요.');
        frm.buyphone2.focus();
        return false;
    }
    
    if ((frm.buyphone3.value.length<1)||(!IsDigit(frm.buyphone3.value))){
        alert('주문자 전화번호를 입력하세요.');
        frm.buyphone3.focus();
        return false;
    }
    
    
    if ((frm.buyhp1.value.length<1)||(!IsDigit(frm.buyhp1.value))){
        alert('주문자 핸드폰번호를 입력하세요.');
        frm.buyhp1.focus();
        return false;
    }
    
    if ((frm.buyhp2.value.length<1)||(!IsDigit(frm.buyhp2.value))){
        alert('주문자 핸드폰번호를 입력하세요.');
        frm.buyhp2.focus();
        return false;
    }
    
    if ((frm.buyhp3.value.length<1)||(!IsDigit(frm.buyhp3.value))){
        alert('주문자 핸드폰번호를 입력하세요.');
        frm.buyhp3.focus();
        return false;
    }
    
    if (frm.buyemail_Pre.value.length<1){
        alert('주문자 이메일 주소를 입력하세요.');
        frm.buyemail_Pre.focus();
        return false;
    }
    
    if (frm.buyemail_Bx.value.length<4){
        if (!check_form_email(frm.buyemail_Pre.value + '@' + frm.buyemail_Tx.value)){
            alert('주문자 이메일 주소가 올바르지 않습니다.');
            frm.buyemail_Tx.focus();
            return false;
        }
    }
    
    if (frm.buyemail_Bx.value.length<4){
        frm.buyeremail.value = frm.buyemail_Pre.value + '@' + frm.buyemail_Tx.value;
        frm.buyemail.value   = frm.buyeremail.value;
    }else{
        frm.buyeremail.value = frm.buyemail_Pre.value + '@' + frm.buyemail_Bx.value;
        frm.buyemail.value   = frm.buyeremail.value;
    }
	    
    
    // 수령인
    if (frm.reqname.value.length<1){
        alert('수령인 명을 입력하세요.');
        frm.reqname.focus();
        return false;
    }
    
    if ((frm.reqphone1.value.length<1)||(!IsDigit(frm.reqphone1.value))){
        alert('수령인 전화번호를 입력하세요.');
        frm.reqphone1.focus();
        return false;
    }
    
    if ((frm.reqphone2.value.length<1)||(!IsDigit(frm.reqphone2.value))){
        alert('수령인 전화번호를 입력하세요.');
        frm.reqphone2.focus();
        return false;
    }
    
    if ((frm.reqphone3.value.length<1)||(!IsDigit(frm.reqphone3.value))){
        alert('수령인 전화번호를 입력하세요.');
        frm.reqphone3.focus();
        return false;
    }
    
    if ((frm.reqhp1.value.length<1)||(!IsDigit(frm.reqhp1.value))){
        alert('수령인 핸드폰번호를 입력하세요.');
        frm.reqhp1.focus();
        return false;
    }
    
    if ((frm.reqhp2.value.length<1)||(!IsDigit(frm.reqhp2.value))){
        alert('수령인 핸드폰번호를 입력하세요.');
        frm.reqhp2.focus();
        return false;
    }
    
    if ((frm.reqhp3.value.length<1)||(!IsDigit(frm.reqhp3.value))){
        alert('수령인 핸드폰번호를 입력하세요.');
        frm.reqhp3.focus();
        return false;
    }
    
    if ((frm.txZip1.value.length<1)||(frm.txZip2.value.length<1)||(frm.txAddr1.value.length<1)){
        alert('수령지 주소를  입력하세요.');
        return false;
    }
    
    if (frm.txAddr2.value.length<1){
        alert('수령지 상세 주소를  입력하세요.');
        frm.txAddr2.focus();
        return false;
    }
    
    return true;
}
    
function PayNext(frm, iErrMsg){
    if (!optionsave()){
        return;
    }

    if (!CheckForm(frm)){
        return;
    }
    
	var ret = confirm('배송 요청 하시겠습니까?');
	if (ret){
		frm.target = "";
		frm.action = "order_real_save.asp";
		frm.submit();
	}
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
	<form name="frmorder" method="post" style="margin:0px;">
	<input type="hidden" name="idx" value="<%=vIdx%>">
	<input type="hidden" name="itemid" value="<%=vItemID%>">
	<input type="hidden" name="itemoption" value="">
	<input type=hidden name=paymethod value="560">
	<input type=hidden name=price value="">
	<input type=hidden name=goodname value='<%= vItemName %>'>
	<input type=hidden name=buyername value="">
	<input type=hidden name=buyeremail value="">
	<input type=hidden name=buyemail value="">
	<input type=hidden name=buyertel value="">
		<div id="contentWrap">
			<div class="cartWrap orderWrap">
				<div class="cartHeader">
					<div class="orderGifticonStep">
						<h2><span class="step01">배송지 입력</span></h2>
						<span class="step02">배송요청 완료</span>
					</div>
					<dl class="myBenefitBox">
						<dt class="tPad15">
						<% If IsUserLoginOK() Then %>
						<strong><%=GetLoginUserName()%></strong>님 <span class="mem<%=GetUserLevelStr(GetLoginUserLevel)%>"><strong>[<%=GetUserLevelStr(GetLoginUserLevel)%>]</strong></span></dt>
						<% End If %>
						<dd class="bPad20">
							<p class="tPad03">텐바이텐을 이용해 주셔서 감사합니다.</p>
						</dd>
					</dl>
				</div>

				<div class="cartBox tMar15">
					<div class="overHidden">
						<h3>주문리스트 확인</h3>
					</div>
					<table class="baseTable tMar10">
						<caption>주문리스트</caption>
						<colgroup>
							<col width="110px" /><col width="110px" /><col width="55px" /><col width="" /><col width="220px" /><col width="150px" />
						</colgroup>
						<thead>
						<tr>
							<th>상품코드</th>
							<th>배송</th>
							<th colspan="2">상품정보</th>
							<th>옵션</th>
							<th></th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><%=vItemID%></td>
							<td><%=oItem.Prd.GetDeliveryName%></td>
							<td><a href="javascript:ZoomItemPop('<%=vItemID%>');"><img src="<%= Replace(vListImage,"http://webimage.10x10.co.kr/","/webimage/") %>" width="50px" height="50px" alt="<%=vItemName%>" /></a></td>
							<td class="lt"><p class="tPad05"><%=vItemName%></p></td>
							<td><p><%=ioptionBoxHtml%></p></td>
							<td><a href="javascript:ZoomItemPop('<%=vItemID%>');" class="btn btnS3 btnRed fn"><em class="whiteArr01">상품 상세 보기</em></a></td>
						</tr>
						</tbody>
					</table>

					<div class="overHidden tMar60">
						<h3>주문고객 정보</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>주문고객 정보 입력</caption>
						<colgroup>
							<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th><label for="sendName">보내시는 분</label></th>
							<td><input type="text" class="txtInp" id="sendName" name="buyname" maxlength="16" value="<%= doubleQuote(oUserInfo.FOneItem.FUserName) %>" /></td>
							<th>이메일</th>
							<td>
								<p>
									<input type="text" class="txtInp" name="buyemail_Pre" maxlength="40" value="<%= Splitvalue(oUserInfo.FOneItem.FUserMail,"@",0) %>" title="이메일 아이디 입력" style="width:120px;" /> @
									<% call DrawEamilBoxHTML("frmorder","buyemail_Tx","buyemail_Bx",Splitvalue(oUserInfo.FOneItem.FUserMail,"@",1)) %>
								</p>
								<p class="tPad05">주문정보를 이메일로 보내드립니다.</p>
							</td>
						</tr>
						<tr>
							<th><label for="hp01">휴대전화</label></th>
							<td>
								<input name="buyhp1" type="text" maxlength=4 class="txtInp" style="width:30px;" id="hp01" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" title="주문고객 휴대전화번호 국번 입력" /> - 
								<input name="buyhp2" type="text" maxlength=4 class="txtInp" style="width:40px;" id="hp02" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" title="주문고객 휴대전화번호 가운데 자리 번호 입력" /> - 
								<input name="buyhp3" type="text" maxlength=4 class="txtInp" style="width:40px;" id="hp03" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" title="주문고객 휴대전화번호 뒷자리 번호 입력" /> <span class="lPad10">주문정보를 SMS로 보내드립니다.</span>
							</td>
							<th><label for="phone01">전화번호</label></th>
							<td><input name="buyphone1" type="text" maxlength=4 class="txtInp" style="width:30px;" id="phone01" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",0) %>" title="주문고객 전화번호 국번 입력" /> - 
								<input name="buyphone2" type="text" maxlength=4 class="txtInp" style="width:40px;" id="phone02" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",1) %>" title="주문고객 전화번호 가운데 자리 번호 입력" /> - 
								<input name="buyphone3" type="text" maxlength=4 class="txtInp" style="width:40px;" id="phone03" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",2) %>" title="주문고객 전화번호 뒷자리 번호 입력" /></td>
						</tr>
						<% if (IsUserLoginOK) then %>
						<tr>
							<th>주소</th>
							<td colspan="3">
								<p><input name="buyZip1" ReadOnly type="text" class="txtInp" style="width:30px;" value="<%= Splitvalue(oUserInfo.FOneItem.FZipCode,"-",0) %>" title="우편번호 앞자리" /> - 
								<input name="buyZip2" type="text" ReadOnly class="txtInp" style="width:30px;" value="<%= Splitvalue(oUserInfo.FOneItem.FZipCode,"-",1) %>" title="우편번호 뒷자리" /> <a href="javascript:searchzipBuyer('frmorder');" class="btn btnS5 btnGry2 fn lMar10">우편번호 찾기</a> <span>군부대 배송의 경우 주소지 선택시 <span class="crRed">사서함</span>으로 검색해서 <span class="crRed">사서함 주소</span>로 입력해주세요.</span></p>
								<p class="tPad05"><input name="buyAddr1" type="text" ReadOnly maxlength="100" class="txtInp" style="width:270px;" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress1) %>" title="동까지의 주소 입력" /> 
								<input name="buyAddr2" type="text" maxlength="60" class="txtInp" style="width:300px;" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress2) %>" title="상세주소 입력" /></p>
							</td>
						</tr>
						<% end if %>
						</tbody>
					</table>

					<div class="overHidden tMar60">
						<h3>배송지 정보</h3>
						<span class="ftLt lPad20 fs12 tPad03">
						<% if (IsUserLoginOK) then %>
						<tr>
							<input type="radio" class="radio" name="rdDlvOpt" id="rdDlvOpt" value="O" onClick="copyDefaultinfo(this);" /> <label for="shipping01">주문고객 정보와 동일</label>
							<input type="radio" class="radio lMar20" name="rdDlvOpt" id="rdDlvOpt" value="N" checked onClick="copyDefaultinfo(this);" /> <label for="shipping02">새로운 주소</label>
							<input type="radio" class="radio lMar20" name="rdDlvOpt" id="rdDlvOpt" value="P" onClick="copyDefaultinfo(this);" /> <label for="shipping03">나의 주소록</label>
						</tr>
						<% else %>
							<input type="checkbox" name="ckcopyinfo" id="ckcopyinfo" onClick="copyinfo(this);" /> <label for="shipping01">주문고객 정보와 동일</label>
						<% end if %>
						</span>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>배송지 정보 입력</caption>
						<colgroup>
							<col width="12.5%" /><col width="38%" /><col width="12.5%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th><label for="acceptName01">받으시는 분</label></th>
							<td colspan="3"><input name="reqname" type="text" maxlength="16" class="txtInp" id="acceptName01" value="" /></td>
						</tr>
						<tr>
							<th><label for="hp11">휴대전화</label></th>
							<td><input type="text" name="reqhp1" maxlength="4" class="txtInp" style="width:30px;" id="hp11" value="" title="받으시는 고객 휴대전화번호 국번 입력" /> - 
								<input type="text" name="reqhp2" maxlength="4" class="txtInp" style="width:40px;" id="hp12" value="" title="받으시는 고객 휴대전화번호 가운데 자리 번호 입력" /> - 
								<input type="text" name="reqhp3" maxlength="4" class="txtInp" style="width:40px;" id="hp13" value="" title="받으시는 고객 휴대전화번호 뒷자리 번호 입력" /></td>
							<th><label for="phone11">전화번호</label></th>
							<td><input type="text" name="reqphone1" maxlength="4" class="txtInp" style="width:30px;" id="phone11" value="" title="받으시는 고객 전화번호 국번 입력" /> - 
								<input type="text" name="reqphone2" maxlength="4" class="txtInp" style="width:40px;" id="phone12" value="" title="받으시는 고객 전화번호 가운데자리 번호 입력" /> - 
								<input type="text" name="reqphone3" maxlength="4" class="txtInp" style="width:40px;" id="phone13" value="" title="받으시는 고객 전화번호 뒷자리 번호 입력" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td colspan="3">
								<p><input type="text" name="txZip1" ReadOnly class="txtInp" style="width:30px;" value="010" title="우편번호 앞자리" /> - 
								<input type="text" name="txZip2" type="text" ReadOnly class="txtInp" style="width:30px;" value="010" title="우편번호 뒷자리" /> <a href="javascript:searchzip('frmorder');" class="btn btnS5 btnGry2 fn lMar10">우편번호 찾기</a> <span>군부대 배송의 경우 주소지 선택시 <span class="crRed">사서함</span>으로 검색해서 <span class="crRed">사서함 주소</span>로 입력해주세요.</span></p>
								<p class="tPad05"><input type="text" name="txAddr1" ReadOnly maxlength="100" class="txtInp" style="width:270px;" value="" title="동까지의 주소 입력" /> 
								<input type="text" class="txtInp" name="txAddr2" maxlength="60" style="width:300px;" value="" title="상세주소 입력" /></p>
							</td>
						</tr>
						<tr>
							<th><label for="shippingAttention">배송 유의사항</label></th>
							<td colspan="3">
								<p><input type="text" name="comment" maxlength="60" class="txtInp" style="width:650px;" value="" id="shippingAttention" /></p>
								<p class="tPad05 fs12">주문시 요청사항은 <span class="crRed">배송기사가 배송시 참고하는 사항</span>으로써, 사전에 협의되지 않은 지정일 배송 등의 요청사항은 반영되지 않을 수 있습니다.</p>
							</td>
						</tr>
						</tbody>
					</table>

					<div class="ct tPad30 bPad20">
						<a href="#" onClick="PayNext(document.frmorder,''); return false;" class="btn btnB2 btnRed btnW220">배송요청</a>
					</div>
				</div>
			</div>
		</div>
	</form>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
set oUserInfo   = nothing
Set oItem = Nothing
%>