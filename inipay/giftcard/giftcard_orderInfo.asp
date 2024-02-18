<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardinfoCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardOptionCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_orderCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 기프트카드 주문 결제하기"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)


Const CLimitElecInsureUnder = 0 ''현금 전주문 (5만원이상->전체;2013.11.28; 허진원) 전자보증서 발행 가능
Const IsCyberAcctValid = TRUE  '' 가상계좌사용여부
Const CLimitMonthlyBuy = 1000000 ''월 100만원 구매 제한

dim cardid, cardOption
cardid = requestCheckVar(request("cardid"),3)
cardOption = requestCheckVar(request("cardopt"),4)

if cardid="" or cardOption="" then
	Alert_return("Gift카드번호 또는 옵션이 없습니다.")
	dbget.close: response.End
end if

dim userid, userlevel
userid          = GetLoginUserID
userlevel       = GetLoginUserLevel

'// 카드-옵션 정보 접수
dim oCardItem
Set oCardItem = new CItemOption
oCardItem.FRectItemID = cardid
oCardItem.FRectItemOption = cardOption
oCardItem.GetItemOneOptionInfo

if oCardItem.FResultCount<=0 then
	Alert_return("판매중인 Gift카드가 아니거나 없는 Gift카드번호 입니다.")
	dbget.close: response.End
elseif oCardItem.FOneItem.FoptSellYn="N" then
	Alert_return(oCardItem.FOneItem.FcardOptionName & "은(는) 품절된 Gift카드 옵션입니다.")
	dbget.close: response.End
end if

dim subtotalPrice : subtotalPrice= oCardItem.FOneItem.FcardSellCash		'실결제 총액
dim cardPrice : cardPrice= oCardItem.FOneItem.FcardOrgPrice				'카드에 명시된 금액
dim goodname : goodname = oCardItem.FOneItem.FCardItemName & " " & oCardItem.FOneItem.FcardOptionName '구매카드명(+옵션명)

'// 고객 정보접수
dim oUserInfo
set oUserInfo = new CUserInfo
oUserInfo.FRectUserID = userid
oUserInfo.GetUserData

if (oUserInfo.FresultCount<1) then
	set oUserInfo.FOneItem    = new CUserInfoItem
end if

'// 월간 고객 주문 총 금액 접수 및 제한 검사
dim myorder, nTotalBuy
set myorder = new cGiftcardOrder
	myorder.FUserID = userid
	nTotalBuy = myorder.getGiftcardOrderTotalPrice
set myorder = Nothing

if (nTotalBuy+cardPrice)>CLimitMonthlyBuy then
	Alert_return("Gift카드는 한달에 " & int(CLimitMonthlyBuy/10000) & "만원을 초과하여 구매하실 수 없습니다.")
	dbget.close: response.End
end if

''가상계좌 입금기한 마감일
function getVbankValue()
	dim retVal
	retVal = Left(replace(dateAdd("d",7,Now()),"-",""),8)
	getVbankValue = retVal
end function

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language="javascript">
<!--
    document.ondblclick = function(event) { };  // kill dblclick

	//이메일 입력폼 on/off
	function swSendDiv(blnChk) {
		if(blnChk) {
			document.getElementById("tblEmail").style.display="";
			document.getElementById("pPreviewEmail").style.display="";
		} else {
			document.getElementById("tblEmail").style.display="none";
			document.getElementById("pPreviewEmail").style.display="none";
		}
	}

	//카드 디자인 클릭
	function selDesign(sid) {
		document.frmorder.designid[sid].checked=true;
	}

	//입력내용 길이검사/표시
	function chkContentLength(txt,ln,pfm) {
		if(getByteLength(txt)>ln) {
			document.getElementById(pfm).className = "red_11px";
		} else {
			document.getElementById(pfm).className = "";
		}
		document.getElementById(pfm).innerHTML = getByteLength(txt);
	}

	// 이메일 미리보기 팝업
	function popPreviewEmailCard() {
		var frmO = document.frmorder, frmP = document.frmPreview;
		var chkDsn=-1;

		for(var i=0;i<frmO.designid.length;i++) {
			if(frmO.designid[i].checked) chkDsn=i;
		}
		if(chkDsn<0) {alert("카드 이미지를 선택해주세요.");return;} else {frmP.designid.value = frmO.designid[chkDsn].value;}
		if(!frmO.buyname.value) {alert("주문자이름을 입력해주세요.");return;} else {frmP.buyname.value = frmO.buyname.value;}
		if(!frmO.emailTitle.value) {alert("이메일 제목을 입력해주세요.");return;} else {frmP.emailTitle.value=frmO.emailTitle.value}

		frmP.emailContent.value=frmO.emailContent.value

		var cardPop = window.open("","cardPreview","width=860, height=900, scrollbars=yes");
		cardPop.focus();
		frmP.target = "cardPreview";
		frmP.action = "<%=wwwURL%>/inipay/giftcard/popPreviewEmailCard.asp";
		frmP.submit();

	}

	//문자열 Byte
	function getByteLength(inputValue) {
	     var byteLength = 0;
	     for (var inx = 0; inx < inputValue.length; inx++) {
	         var oneChar = escape(inputValue.charAt(inx));
	         if ( oneChar.length == 1 ) {
	             byteLength ++;
	         } else if (oneChar.indexOf("%u") != -1) {
	             byteLength += 2;
	         } else if (oneChar.indexOf("%") != -1) {
	             byteLength += oneChar.length/3;
	         }
	     }
	     return byteLength;
	 }

	//전화(휴대폰) 입력폼 검사
	function getFrmPhoneNum(fnm,inm,chk) {
	    var oPn, strRst="";

		for(var i=1; i<=3; i++) {
			oPn = eval(fnm + "." + inm + i);

		    if(chk) {
				if ((oPn.value.length<1)||(!IsDigit(oPn.value))){
					alert(oPn.alt + '을(를) 입력하세요.');
					oPn.focus();
					return false;
				}
			}
			if(i<3) {
				strRst+=oPn.value + "-";
			} else {
				strRst+=oPn.value;
			}
		}
		if(strRst=="--") strRst="";
		return strRst;
	}

	//이메일 입력폼 검사
	function getFrmEmail(fnm,inm,chk) {
	    var oPre = eval(fnm + "." + inm + "_Pre");
	    var oBx = eval(fnm + "." + inm + "_Bx");
	    var oTx = eval(fnm + "." + inm + "_Tx");
	    var strRst;

	    if(chk) {
		    if (oPre.value.length<1){
		        alert(oPre.alt + ' 주소를 입력해주세요.');
		        oPre.focus();
		        return false;
		    }
		    if (oBx.value.length<4){
		        if (!check_form_email(oPre.value + '@' + oTx.value)){
		            alert(oPre.alt + ' 주소가 올바르지 않습니다.');
		            oTx.focus();
		            return false;
		        }
		    }
		}

	    if(oPre.value.length>0) {
		    if (oBx.value.length<4){
		        strRst = oPre.value + '@' + oTx.value;
		    }else{
		        strRst = oPre.value + '@' + oBx.value;
		    }
		}
	    return strRst;
	}

	//이메일 형태 검사
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

	// 결제구분 선택
	function CheckPayMethod(comp){
	    var paymethod = comp.value;

	$("#paymethod_desc1_100").hide();
	$("#paymethod_desc1_20").hide();
	$("#paymethod_desc1_7").hide();

	$("#paymethod_desc1_" + paymethod).show();
	/*
	    document.getElementById("paymethod_desc1_100").style.display = "none";
	    document.getElementById("paymethod_desc1_20").style.display = "none";
	    document.getElementById("paymethod_desc1_7").style.display = "none";

	    document.getElementById("paymethod_desc1_" + paymethod).style.display = "block";
	*/
	    <% if (Not IsCyberAcctValid) then %>
	    if (paymethod=='7'){
	        alert('현재 가상계좌 오류로 가상계좌는 발급되지 않으며 아래 선택한 텐바이텐 계좌로 입금해 주시기 바랍니다..');
	    }
	    <% end if %>
	}

	// 플러그인 설치(확인) 아래
    //StartSmartUpdate();

    function payInI(frm){
    	// MakePayMessage()를 호출함으로써 플러그인이 화면에 나타나며, Hidden Field
    	// 에 값들이 채워지게 됩니다. 플러그인은 통신을 하는 것이 아니라, Hidden
    	// Field의 값들을 채우고 종료한다는 사실에 유의하십시오.

    	if(frm.clickcontrol.value == "enable"){
    		if(document.INIpay==null||document.INIpay.object==null){
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
    				//openwin = window.open("childwin.html","childwin","width=300,height=160");
    				/****
    				무이자용 상점아이디가 따로 존재하는 경우(자체가맹점) 상점아이디
    				를 동적으로	적용하는 코드. (대표가맹점인 경우에는 주석을 해제하
    				지 마십시오.

    				// 사용자가 무이자할부 조건에 부합하는 카드와 개월수를 선택했음
    				// (조건 설정은 하단 quotabase field 부분, 매뉴얼 참조)
    				if(frm.quotainterest.value == "1")
    				{
    					frm.mid.value = "{무이자용 상점아이디}";
    				}
    				****/

    				return true;
    			}else{
    				alert("지불에 실패하였습니다.");
    				return false;
    			}
    		}
    	}else{
    		return false;
    	}
    }

    function enable_click(){
    	document.frmorder.clickcontrol.value = "enable"
    	document.getElementById("nextbutton1").style.display = "";
    	document.getElementById("nextbutton2").style.display = "none";
    }

    function disable_click(){
    	document.frmorder.clickcontrol.value = "disable";
    	document.getElementById("nextbutton1").style.display = "none";
    	document.getElementById("nextbutton2").style.display = "";
    }

	//입력폼 검사
	function CheckForm(frm){
		// 주문공객 정보
		if (frm.buyname.value.length<1){
			alert('주문자 명을 입력해주세요.');
			frm.buyname.focus();
			return false;
		}
		if(!getFrmEmail("document.frmorder","buyemail",true)) {return false;} else {frm.buyemail.value=getFrmEmail("document.frmorder","buyemail",false);}
		if(!getFrmPhoneNum("document.frmorder","buyhp",true)) {return false;} else {frm.buyhp.value=getFrmPhoneNum("document.frmorder","buyhp",false);}
		frm.buyphone.value=getFrmPhoneNum("document.frmorder","buyphone",false);

		// 전송정보(MMS)
		/*
		if(frm.bookingYN.checked) {
			if(TnCheckCompDate("<%=date%>",">",frm.bookYY.value+"-"+frm.bookMM.value+"-"+frm.bookDD.value)) {
				alert("예약발송일은 과거날짜를 선택할 수 없습니다.");
				frm.bookYY.focus();
				return false;
			}
			if(TnCheckCompDate("<%=dateadd("d",5,date)%>","<",frm.bookYY.value+"-"+frm.bookMM.value+"-"+frm.bookDD.value)) {
				alert("예약발송일을 5일이내로 설정해주세요.");
				frm.bookYY.focus();
				return false;
			}
			frm.bookingDate.value=frm.bookYY.value+"-"+frm.bookMM.value+"-"+frm.bookDD.value+" "+frm.bookHH.value+":00:00";
		}
		*/

		if(!getFrmPhoneNum("document.frmorder","sendhp",true)) {return false;} else {frm.sendhp.value=getFrmPhoneNum("document.frmorder","sendhp",false);}
		if(!getFrmPhoneNum("document.frmorder","reqhp",true)) {return false;} else {frm.reqhp.value=getFrmPhoneNum("document.frmorder","reqhp",false);}

		if(!frm.MMSTitle.value) {
			alert("메시지 제목을 입력해주세요.");
			frm.MMSTitle.focus();
			return false;
		}
		if(getByteLength(frm.MMSContent.value)>200) {
			alert("메시지 내용은 200byte를 넘을 수 없습니다.");
			frm.MMSContent.focus();
			return false;
		}

		// 전송정보(이메일)
		if(frm.sendDiv.checked) {
			var chkDsn=-1;

			for(var i=0;i<frm.designid.length;i++) {
				if(frm.designid[i].checked) chkDsn=i;
			}
			if(chkDsn<0) {alert("카드 이미지를 선택해주세요.");return false;}
			if(!getFrmEmail("document.frmorder","sendemail",true)) {return false;} else {frm.sendemail.value=getFrmEmail("document.frmorder","sendemail",false);}
			if(!getFrmEmail("document.frmorder","reqemail",true)) {return false;} else {frm.reqemail.value=getFrmEmail("document.frmorder","reqemail",false);}

			if(frm.reqemail.value!=getFrmEmail("document.frmorder","reqemail2",false)) {
				alert("받은분 이메일과 재확인 주소가 다릅니다.");
				frm.reqemail_Pre.focus();
				return false;
			}

			if(!frm.emailTitle.value) {
				alert("이메일 제목을 입력해주세요.");
				frm.emailTitle.focus();
				return false;
			}
			if(getByteLength(frm.emailContent.value)>400) {
				alert("이메일 내용은 400byte를 넘을 수 없습니다.");
				frm.emailContent.focus();
				return false;
			}
		}

		// Gift카드 사용약관
	    if(frm.areement.checked != true) {
		    alert("텐바이텐 Gift카드 사용 약관에 동의하셔야만 주문이 가능합니다.");
		    return false;
		}

		return true;
	}

	function OrderProc(frm){

	    if (frm.Tn_paymethod.length){
	        var paymethod = frm.Tn_paymethod[getCheckedIndex(frm.Tn_paymethod)].value;
	    }else{
	        var paymethod = frm.Tn_paymethod.value;
	    }

	    //Check Default Form
	    if (!CheckForm(frm)){
	        return;
	    }

	    //신용카드
	    if (paymethod=="100"){

	    	if (frm.price.value<1000){
	    		alert('신용카드 최소 결제 금액은 1000원 이상입니다.');
	    		return;
	    	}

            frm.gopaymethod.value = "onlycard";
	        frm.buyername.value = frm.buyname.value;
    	    frm.buyeremail.value = frm.buyemail.value;
		    frm.buyertel.value = frm.buyhp.value;

	    	if (payInI(frm)==true){
	    	    frm.target = "";
	    	    frm.action = "/inipay/giftcard/giftcard_INIpay.asp"
	    		frm.submit();
	    	}
	    }

	    //실시간 이체
	    if (paymethod=="20"){
	    	if (frm.price.value<1000){
	    		alert('실시간 이체 최소 결제 금액은 1000원 이상입니다.');
	    		return;
	    	}

	        frm.gopaymethod.value = "onlydbank";

	        frm.buyername.value = frm.buyname.value;
    	    frm.buyeremail.value = frm.buyemail.value;
		    frm.buyertel.value = frm.buyhp.value;

	    	if (payInI(frm)==true){
	    	    frm.target = "";
	    	    frm.action = "/inipay/giftcard/giftcard_INIpay.asp"
	    		frm.submit();
	    	}
	    }

		//모바일
	    if (paymethod=="400")
	    {
	    	if(document.frmorder.mobileprdprice.value > 300000){
	    		alert("휴대폰결제는 결제 최대 금액이 30만원 이하 입니다.");
	    		return;
	    	}else if(document.frmorder.mobileprdprice.value <100){
	    	    alert("휴대폰결제는 결제 최소 금액은 100원 이상입니다.");
	    		return;
	    	}else{
	    		PopMobileOrder(paymethod);
	    	}
	    }


 <% if (IsCyberAcctValid) then %>
        //무통장-가상계좌
        if (paymethod=="7"){

        	if (frm.price.value<0){
        		alert('무통장입금 최소 결제 금액은 0원 이상입니다.');
        		return;
        	}

        //임시
        frm.mid.value="teenxteen8";

            frm.gopaymethod.value = "onlyvbank";  //가상계좌

	        frm.buyername.value = frm.buyname.value;
    	    frm.buyeremail.value = frm.buyemail.value;
		    frm.buyertel.value = frm.buyhp.value;

        	if (payInI(frm)==true){
        	    frm.target = "";
        	    frm.action = "/inipay/giftcard/giftcard_INIpay.asp"
        		frm.submit();
        	}
        }
 <% else %>
	    //무통장(기존)
	    if (paymethod=="7"){
	        if (frm.acctno.value.length<1){
	    		alert('입금하실 은행을 선택하세요. \r\n문자 메세지로 안내해 드립니다.');
	    		frm.acctno.focus();
	    		return;
	    	}

	    	if (frm.acctname.value.length<1){
	    		alert('입금자성명을 입력하세요..');
	    		frm.acctname.focus();
	    		return;
	    	}

	    	if (frm.price.value<0){
	    		alert('무통장입금 최소 결제 금액은 0원 이상입니다.');
	    		return;
	    	}else if (frm.price.value*1==0){
	    	    alert('쿠폰 또는 마일리지 사용으로 결제금액이 0원인 경우 주문 후 고객센터로 연락바랍니다.');
	    	}


	    	// 전자보증서 발급에 필요한 추가 정보 입력 검사 (추가 2006.6.13; 시스템팀 허진원)
	    	if (frm.reqInsureChk!=undefined){
	        	if ((frm.reqInsureChk.value=="Y")&&(frm.reqInsureChk.checked)){
	        		if(!frm.insureSsn1.value||frm.insureSsn1.value.length<6)
	        		{
	        			alert("전자보증서 발급에 필요한 주민등록번호를 입력해주십시요.\n※ 주민등록번호 첫째자리는 6자리입니다.");
	        			frm.insureSsn1.focus();
	        			return;
	        		}

	        		if(!frm.insureSsn2.value||frm.insureSsn2.value.length<7)
	        		{
	        			alert("전자보증서 발급에 필요한 주민등록번호를 입력해주십시요.\n※ 주민등록번호 둘째자리는 7자리입니다.");
	        			frm.insureSsn2.focus();
	        			return;
	        		}

	        		if(frm.agreeInsure[1].checked)
	        		{
	        			alert("전자보증서 발급에 필요한 개인정보이용에 동의를 하지 않으시면 전자보증서를 발급할 수 없습니다.");
	        			return;
	        		}
	        	}
	        }

	    	var ret = confirm('주문 하시겠습니까?');
	    	if (ret){
	    		frm.target = "";
	    		frm.action = "/inipay/giftcard/AcctResult.asp";
	    		frm.submit();
	    	}

	    }
<% end if %>
	}

	function popansim(){
		var popwin;
		popwin = window.open('http://www.inicis.com/popup/C_popup/popup_C_02.html','popansim','scrollbars=yes,resizable=yes,width=620,height=600')
	}

	function popGongIn(){
	    var popwin;
		popwin = window.open('http://www.inicis.com/popup/C_popup/popup_C_01.html','popGongIn','scrollbars=yes,resizable=yes,width=620,height=600')

	}
//-->
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader_ssl.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="cartWrap orderWrap">

				<form name="frmorder" method="post" style="margin:0px;">
				<!-- 상점아이디 -->
				<% IF application("Svr_Info")="Dev" THEN %>
				<input type=hidden name=mid value="INIpayTest">
				<% else %>
				<input type=hidden name=mid value="teenxteen8">
				<% end if %>
				<!-- 화폐단위 -->
				<input type=hidden name=currency value="WON">
				<!-- 무이자 할부 -->
				<input type=hidden name=nointerest value="no">
				<input type=hidden name=quotabase value="선택:일시불:2개월:3개월:4개월:5개월:6개월:7개월:8개월:9개월:10개월:11개월:12개월:18개월">
				<input type=hidden name=acceptmethod value="VERIFY:NOSELF:no_receipt:Vbank(<%=getVbankValue()%>)">

				<input type=hidden name=quotainterest value="">
				<input type=hidden name=paymethod value="">
				<input type=hidden name=cardcode value="">
				<input type=hidden name=cardquota value="">
				<input type=hidden name=rbankcode value="">
				<input type=hidden name=reqsign value="DONE">
				<input type=hidden name=encrypted value="">
				<input type=hidden name=sessionkey value="">
				<input type=hidden name=uid value="">
				<input type=hidden name=sid value="">
				<input type=hidden name=version value=4110>
				<input type=hidden name=clickcontrol value="enable">
				<input type=hidden name=price value="<%= subtotalprice %>">
				<input type=hidden name=goodname value='<%= goodname %>'>
				<input type=hidden name=buyername value="">
				<input type=hidden name=buyeremail value="">
				<input type=hidden name=buyemail value="">
				<input type=hidden name=buyertel value="">
				<input type=hidden name=gopaymethod value="onlycard"> <!-- or onlydbank -->
				<input type=hidden name=ini_logoimage_url value="/fiximage/web2008/shoppingbag/logo2004.gif">

				<input type=hidden name=cardid value="<%=cardid%>">
				<input type=hidden name=cardopt value="<%=cardOption%>">
				<input type=hidden name=cardPrice value="<%=cardPrice%>">
				<input type=hidden name=buyhp value="">
				<input type=hidden name=buyphone value="">
				<input type=hidden name=sendemail value="">
				<input type=hidden name=sendhp value="">
				<input type=hidden name=reqemail value="">
				<input type=hidden name=reqhp value="">
				<input type=hidden name=bookingDate value="">

				<div class="cartHeader">
					<div class="orderGiftStep">
						<h2><span class="step01">Gift 카드 주문결제</span></h2>
						<span class="step02">Gift 카드 주문완료</span>
					</div>
					<dl class="myBenefitBox">
						<dt class="tPad10"><strong><%=GetLoginUserName%></strong>님 <span class="<%=GetUserLevelCSSClass()%>"><strong>[<%=GetUserLevelStr(userlevel)%>]</strong></span></dt>
						<dd class="bPad10">간편하고 실속 있는 <br /><strong class="crRed">텐바이텐 GIFT카드</strong>로 마음을 전하세요.</dd>
					</dl>
				</div>

				<div class="cartBox tMar15">
					<div class="overHidden">
						<h3>GIFT 카드 주문 정보 확인</h3>
					</div>
					<table class="baseTable bBdrNone tMar10">
						<caption>GIFT 카드 주문 정보 확인</caption>
						<colgroup>
							<col width="120px" /><col width="280px" /><col width="" /><col width="110px" /><col width="170px" />
						</colgroup>
						<thead>
						<tr>
							<th>상품코드</th>
							<th colspan="2">상품정보</th>
							<th>판매가격</th>
							<th>전송방법</th>
						</tr>
						</thead>
						<tbody>
						<tr>
							<td><%=oCardItem.FOneItem.FCardItemID%></td>
							<td class="rt"><a href="/shopping/giftcard/giftcard.asp?cardid=<%=oCardItem.FOneItem.FCardItemID%>"><img src="<%=oCardItem.FOneItem.GetImageSmall%>" width="50px" height="50px" alt="<%=oCardItem.FOneItem.FCardItemName%> [<%=oCardItem.FOneItem.FcardOptionName%>]" /></a></td>
							<td class="lt"><%=oCardItem.FOneItem.FCardItemName%> [<%=oCardItem.FOneItem.FcardOptionName%>]</td>
							<td><%=formatNumber(subtotalPrice,0)%>원</td>
							<td>모바일<br />(이메일 전송 선택 가능)</td>
						</tr>
						</tbody>
						<tfoot>
						<tr>
							<td colspan="5"><p class="cr555">결제예정금액 <strong class="crRed"><%=formatNumber(subtotalPrice,0)%></strong>원</p></td>
						</tr>
						</tfoot>
					</table>

					<div class="overHidden tMar80">
						<h3>주문고객 정보</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>주문고객 정보 입력</caption>
						<colgroup>
							<col width="12.5%" /><col width="38%" /><col width="12.5%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th><label for="sendName01">보내시는 분</label></th>
							<td><input type="text" class="txtInp" id="sendName01" name="buyname" maxlength="16" value="<%= doubleQuote(oUserInfo.FOneItem.FUserName) %>" /></td>
							<th>이메일</th>
							<td>
								<p>
									<input type="text" class="txtInp" name="buyemail_Pre" maxlength="40" value="<%= Splitvalue(oUserInfo.FOneItem.FUserMail,"@",0) %>" title="주문자 이메일" style="width:80px;" />
									@
									<% Call DrawEamilBoxHTML("document.frmorder","buyemail_Tx","buyemail_Bx",Splitvalue(oUserInfo.FOneItem.FUserMail,"@",1)) %>
								</p>
								<p class="tPad05">주문정보를 이메일로 보내드립니다.</p>
							</td>
						</tr>
						<tr>
							<th><label for="hp01">휴대전화</label></th>
							<td>
								<input type="text" class="txtInp" style="width:30px;" id="hp01" name="buyhp1" maxlength=4 value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" alt="주문자 휴대폰번호" /> -
								<input type="text" class="txtInp" style="width:40px;" id="hp02" name="buyhp2" maxlength=4 value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" alt="주문자 휴대폰번호" /> -
								<input type="text" class="txtInp" style="width:40px;" id="hp03" name="buyhp3" maxlength=4 value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" alt="주문자 휴대폰번호" />
								<span class="lPad10">주문정보를 SMS로 보내드립니다.</span>
							</td>
							<th><label for="phone01">전화번호</label></th>
							<td>
								<input type="text" class="txtInp" style="width:30px;" id="hp01" name="buyphone1" maxlength=4 value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",0) %>" alt="주문자 전화번호" /> -
								<input type="text" class="txtInp" style="width:40px;" id="hp02" name="buyphone2" maxlength=4 value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",1) %>" alt="주문자 전화번호" /> -
								<input type="text" class="txtInp" style="width:40px;" id="hp03" name="buyphone3" maxlength=4 value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",2) %>" alt="주문자 전화번호" />
							</td>
						</tr>
						</tbody>
					</table>

					<div class="overHidden tMar60">
						<h3>전송 정보</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>전송 정보 입력</caption>
						<colgroup>
							<col width="12.5%" /><col width="38%" /><col width="12.5%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th><label for="acceptHp01">받으시는 분<br />휴대전화</label></th>
							<td>
								<p>
									<input type="text" class="txtInp" style="width:30px;" id="acceptHp01" name="reqhp1" value="" title="받으시는 고객 휴대전화번호 국번 입력" /> - 
									<input type="text" class="txtInp" style="width:40px;" id="acceptHp02" name="reqhp2" value="" title="받으시는 고객 휴대전화번호 가운데 자리 번호 입력" /> - 
									<input type="text" class="txtInp" style="width:40px;" id="acceptHp03" name="reqhp3" title="받으시는 고객 휴대전화번호 뒷자리 번호 입력" />
								</p>
								<p class="tPad10">휴대폰 번호를 잘못 입력하실 경우 타사용자가 인증번호를 <br />등록할 수 있으며, 이 경우 환불이 불가하오니 유의해주시기 바랍니다.</p>
							</td>
							<th><label for="sendHp01">보내시는 분<br />휴대전화</label></th>
							<td>
								<p>
									<input type="text" class="txtInp" style="width:30px;" id="hp01" name="sendhp1" maxlength=4 value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" title="보내시는 고객 휴대전화번호 국번 입력" /> - 
									<input type="text" class="txtInp" style="width:40px;" id="hp02" name="sendhp2" maxlength=4 value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" title="보내시는 고객 휴대전화번호 가운데 자리 번호 입력" /> - 
									<input type="text" class="txtInp" style="width:40px;" id="hp03" name="sendhp3" maxlength=4 value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" title="보내시는 고객 휴대전화번호 뒷자리 번호 입력" />
								</p>
								<p class="tPad10"><strong>발신번호 사전등록제 시행으로 인해 메시지 발신번호가 <br />1644-6030(텐바이텐 고객센터)으로 표시됩니다.</strong></p>
							</td>
						</tr>
						<tr>
							<th><label for="msgCont">메시지 입력</label></th>
							<td colspan="3">
								<p><input type="text" class="txtInp" id="msgTitle" style="width:98.5%;" name="MMSTitle" maxlength="50" value="<%=oUserInfo.FOneItem.Fusername%>님이 텐바이텐 Gift카드를 보내셨습니다." /></p>
								<p class="tPad10"><textarea style="width:98.5%;" rows="4" id="msgCont" name="MMSContent" onkeyup="chkContentLength(this.value,200,'mmsLen')" title="메시지 내용을 입력해주세요" placeholder="메시지 내용을 입력해주세요"></textarea></p>
								<p class="rt tPad05">(<span id="mmsLen">0</span>/200byte)</p>
							</td>
						</tr>
						</tbody>
					</table>

					<p class="tMar30 fs11"><input type="checkbox" class="check" name="sendDiv" id="sendDiv" value="E" onclick="swSendDiv(this.checked)"> <label for="giftEmail"><strong>[선택사항] Gift카드 이메일로도 보내기</strong> - 선택 시 SMS와 함께 이메일로도 전송이 됩니다.</label></p>
					<table id="tblEmail" class="baseTable orderForm tMar10" style="display:none">
						<caption>Gift카드 이메일로도 보내기 입력</caption>
						<colgroup>
							<col width="12.5%" /><col width="13%" /><col width="31%" /><col width="13%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th rowspan="3">카드 이미지 선택</th>
							<td><strong class="fs12">Basic</strong></td>
							<td>
								<span><input type="radio" class="radio" id="giftBasic01" name="designid" value="101" /> <label for="giftBasic01"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_basic_thumb01.gif" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Basic] type1" class="vMiddle lMar05" /></label></span>
								<span class="lPad20"><input type="radio" class="radio" id="giftBasic02" name="designid" value="102" /> <label for="giftBasic02"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_basic_thumb02.gif" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Basic] type2" class="vMiddle lMar05" /></label></span>
								<span class="lPad20"><input type="radio" class="radio" id="giftBasic03" name="designid" value="103" /> <label for="giftBasic03"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_basic_thumb03.gif" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Basic] type3" class="vMiddle lMar05" /></label></span>
							</td>
							<td class="lBdr1"><strong class="fs12">Love</strong></td>
							<td>
								<span><input type="radio" class="radio" id="giftLove01" name="designid" value="501" /> <label for="giftLove01"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_love_thumb01.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Love] type1" class="vMiddle lMar05" /></label></span>
								<span class="lPad20"><input type="radio" class="radio" id="giftLove02" name="designid" value="502" /> <label for="giftLove02"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_love_thumb02.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Love] type2" class="vMiddle lMar05" /></label></span>
								<span class="lPad20"><input type="radio" class="radio" id="giftLove03" name="designid" value="503" /> <label for="giftLove03"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_love_thumb03.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Love] type3" class="vMiddle lMar05" /></label></span>
							</td>
						</tr>
						<tr>
							<td><strong class="fs12">Thanks</strong></td>
							<td>
								<span><input type="radio" class="radio" id="giftThanks01" name="designid" value="301" /> <label for="giftThanks01"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_thanks_thumb01.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Thanks] type1" class="vMiddle lMar05" /></label></span>
								<span class="lPad20"><input type="radio" class="radio" id="giftThanks02" name="designid" value="302" /> <label for="giftThanks02"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_thanks_thumb02.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Thanks] type2" class="vMiddle lMar05" /></label></span>
								<span class="lPad20"><input type="radio" class="radio" id="giftThanks03" name="designid" value="303" /> <label for="giftThanks03"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_thanks_thumb03.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Thanks] type3" class="vMiddle lMar05" /></label></span>
							</td>
							<td class="lBdr1"><strong class="fs12">Birthday</strong></td>
							<td>
								<span><input type="radio" class="radio" id="giftBirth01" name="designid" value="201" /> <label for="giftBirth01"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_birth_thumb01.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Birthday] type1" class="vMiddle lMar05" /></label></span>
								<span class="lPad20"><input type="radio" class="radio" id="giftBirth02" name="designid" value="202" /> <label for="giftBirth02"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_birth_thumb02.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Birthday] type2" class="vMiddle lMar05" /></label></span>
								<span class="lPad20"><input type="radio" class="radio" id="giftBirth03" name="designid" value="203" /> <label for="giftBirth03"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_birth_thumb03.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Birthday] type3" class="vMiddle lMar05" /></label></span>
							</td>
						</tr>
						<tr>
							<td><strong class="fs12">Congratulations</strong></td>
							<td>
								<span><input type="radio" class="radio" id="giftCongrat01" name="designid" value="401" /> <label for="giftCongrat01"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_congrat_thumb01.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Congratulations] type1" class="vMiddle lMar05" /></label></span>
								<span class="lPad20"><input type="radio" class="radio" id="giftCongrat02" name="designid" value="402" /> <label for="giftCongrat02"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_congrat_thumb02.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Congratulations] type2" class="vMiddle lMar05" /></label></span>
								<span class="lPad20"><input type="radio" class="radio" id="giftCongrat03" name="designid" value="403" /> <label for="giftCongrat03"><img src="http://fiximage.10x10.co.kr/web2013/cart/giftcard_congrat_thumb03.jpg" width="50px" height="50px" alt="텐바이텐 Gift 카드 [Congratulations] type3" class="vMiddle lMar05" /></label></span>
							</td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<th>보내시는 분</th>
							<td colspan="4">
								<input type="text" class="txtInp" name="sendemail_Pre" maxlength="40" value="<%= Splitvalue(oUserInfo.FOneItem.FUserMail,"@",0) %>" title="보내시는 분 이메일 아이디 입력" style="width:80px;" />
								@
								<% call DrawEamilBoxHTML("document.frmorder","sendemail_Tx","sendemail_Bx",Splitvalue(oUserInfo.FOneItem.FUserMail,"@",1)) %>
							</td>
						</tr>
						<tr>
							<th>받으시는 분</th>
							<td colspan="4">
								<input type="text" class="txtInp" name="reqemail_Pre" maxlength="40" value="" title="받으시는 분 이메일 아이디 입력" style="width:80px;" />
								@
								<% call DrawEamilBoxHTML("document.frmorder","reqemail_Tx","reqemail_Bx","") %>
								<span class="lPad10">잘못된 이메일로 전송된 인증번호가 이미 등록 된 후에는 환불이 불가 하오니 유의하시기 바랍니다.</span>
							</td>
						</tr>
						<tr>
							<th>받으시는 분<br /> 재입력</th>
							<td colspan="4">
								<input type="text" class="txtInp" name="reqemail2_Pre" maxlength="40" value="" title="받으시는 분 이메일 아이디 입력" style="width:80px;" />
								@
								<% call DrawEamilBoxHTML("document.frmorder","reqemail2_Tx","reqemail2_Bx","") %>
								<span class="lPad10">잘못된 이메일로 전송된 인증번호가 이미 등록 된 후에는 환불이 불가 하오니 유의하시기 바랍니다.</span>
							</td>
						</tr>
						<tr>
							<th><label for="giftEmailTitle">이메일 제목</label></th>
							<td colspan="4">
								<input type="text" class="txtInp" id="giftEmailTitle" name="emailTitle" maxlength="60" value="<%=oUserInfo.FOneItem.Fusername%>님이 텐바이텐 Gift카드를 보내셨습니다." title="이메일 제목을 입력해주세요" style="width:98.5%;" />
							</td>
						</tr>
						<tr>
							<th>이메일 내용</th>
							<td colspan="4">
								<p><textarea style="width:98.5%;" rows="4" name="emailContent" onkeyup="chkContentLength(this.value,400,'mailLen')" title="이메일로 보내실 내용을 입력해주세요" placeholder="이메일로 보내실 내용을 입력해주세요"></textarea></p>
								<p class="rt tPad05">(<span id="mailLen">0</span>/400자)</p>
							</td>
						</tr>
						</tbody>
					</table>
					<p class="tPad15 rt" id="pPreviewEmail" style="display:none">
						<a href="javascript:popPreviewEmailCard();" class="btn btnS1 btnRed"><em class="whiteArr01">메일 미리보기</em></a>
					</p>

					<div class="overHidden tMar50">
						<h3 class="crRed">결제 금액</h3>
					</div>
					<div class="payForm tMar10">
						<table>
						<caption>결제 금액 보기</caption>
						<tbody>
						<tr>
							<td>총 결제액 <span class="crRed lPad20"><strong class="fs20"><%=formatNumber(subtotalPrice,0)%></strong>원</span></td>
						</tr>
						</table>
					</div>

					<div class="overHidden tMar50">
						<h3 class="crRed">결제 수단</h3>
					</div>
					<div class="payMethodWrap2">
						<table class="baseTable orderForm payForm tMar10">
							<caption>결제 수단 입력</caption>
							<colgroup>
								<col width="" /><col width="35%;" />
							</colgroup>
							<thead>
							<tr>
								<td colspan="2">
									<span><input type="radio" class="radio" id="payMethod01" name="Tn_paymethod" value="100" OnClick="CheckPayMethod(this);" checked /> <label for="payMethod01"><strong>신용카드</strong></label></span>
									<span><input type="radio" class="radio" id="payMethod02" name="Tn_paymethod" value="20" OnClick="CheckPayMethod(this);" /> <label for="payMethod02"><strong>실시간 계좌이체</strong></label></span>
									<span><input type="radio" class="radio" id="payMethod03" name="Tn_paymethod" value="7" OnClick="CheckPayMethod(this);" /> <label for="payMethod03"><strong>무통장 입금(가상계좌)</strong></label></span>
								</td>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td colspan="2" class="box3">
									<ul class="list01 cr555">
										<li>Gift 카드 구매는 상품을 구매하는 것이 아니라 무기명 선불카드를 구매하는 것이므로 모든  이 비과세로 구분됩니다.</li>
										<li>신용카드로 Gift 카드 구매 시 매출전표는 부과세 표시 없이 발행되며, 거래내역서 용도로는 사용 가능합니다.</li>
										<li>실시간계좌이체 및 무통장 입금으로 Gift 카드 구매 시 현금영수증, 세금계산서 증빙서류는 발급이 불가하며, Gift 카드로 상품을 구매할 때 현금영수증 발행이 가능합니다.</li>
									</ul>
								</td>
							</tr>
							<!-- 신용카드 선택의 경우 -->
							<tr id="paymethod_desc1_100" >
								<td class="vTop">
									<p class="tPad10">신용카드 결제 시 화면 아래 '결제하기'버튼을 클릭하시면 신용카드 결제 창이 나타납니다.<br />신용카드 결제 창을 통해 입력되는 고객님의 카드 정보는 128bit로 안전하게 암호화되어 전송되며, 승인 처리 후 카드 정보는 승인 성공 / 실패 여부에 상관없이 자동으로 폐기되므로, 안전합니다. 신용카드 결제 신청 시 승인 진행에 다소 시간이 소요될 수 있으므로 '중지', '새로고침'을 누르지 마시고 결과 화면이 나타 날때까지 기다려 주십시오.<br /><br />(결제하기 버튼 클릭 시 결제창이 나타나지 않을 경우나 안전결제 모듈이 설치 되지 않을 경우 <strong><a target=_blank href="http://plugin.inicis.com/repair/INIpayWizard.exe">[여기]</a></strong>를 눌러 수동으로 플러그인을 설치하십시오.)</p>
									<dl class="note01 tPad25">
										<dt><strong class="fs13">유의사항</strong></dt>
										<dd>
											<ul class="list01">
												<li>국내 모든 카드 사용이 가능하며 해외에서 발행된 카드는 해외카드 3D 인증을 통해 사용 가능합니다.</li>
												<li>신용카드 / 실시간 이체는 결제 후, 무통장입금은 입금확인 후 인증번호 전송이 이루어집니다.</li>
												<li>결제완료 후 취소요청 시, <span class="crRed">마이텐바이텐 &gt; Gift 카드 &gt; 카드주문내역</span>을 이용하시면 됩니다.</li>
											</ul>
										</dd>
									</dl>

									<p class="tPad20"><span class="addInfo"><em class="lPad0" onClick="popansim('01');">공인인증서 안내</em></span></p>
									<p class="tPad10"><span class="addInfo"><em class="lPad0" onClick="popansim('02');">안심클릭 안내</em></span></p>
									<p class="tPad10"><span class="addInfo"><em class="lPad0" onClick="popansim('03');">안전결제(ISP) 안내</em></span></p>
								</td>
								<td class="lBdr1 vTop">
									<!-- #include virtual="/chtml/inipay/inc_Installment.asp" -->
								</td>
							</tr>
							<!-- //신용카드 선택의 경우 -->
							<!-- 실시간 계좌이체 선택의 경우 -->
							<tr id="paymethod_desc1_20" style="display:none" >
								<td class="vTop">
									<p class="tPad10">실시간 이체 결제 시 화면 아래 '결제하기'버튼을 클릭하시면 실시간 이체 결제 창이 나타납니다. 실시간 이체 결제 창을 통해 입력되는 고객님의 정보는 128bit로 안전하게 암호화되어 전송되며 승인 처리 후 정보는 승인 성공/ 실패 여부에 상관없이 자동으로 폐기되므로, 안전합니다. 실시간 이체 결제 신청 시 승인 진행에 다소 시간이 소요될 수 있으므로 '중지', '새로고침'을 누르지 마시고 결과 화면이 나타날 때까지 기다려 주십시오.<br /><br />(결제하기 버튼 클릭 시 결제창이 나타나지 않을 경우 <strong><a target=_blank href="http://plugin.inicis.com/repair/INIpayWizard.exe">[여기]</a></strong>를 눌러 수동으로 플러그인을 설치하십시오)</p>
									<dl class="note01 tPad25">
										<dt><strong class="fs13">유의사항</strong></dt>
										<dd>
											<ul class="list01">
												<li>신용카드/ 실시간 이체는 결제 후, 무통장입금은 입금확인 후 인증번호 전송이 이루어집니다.</li>
												<li>결제완료 후 취소요청 시, <span class="crRed">마이텐바이텐 &gt; Gift 카드 &gt; 카드주문내역</span>을 이용하시면 됩니다.</li>
											</ul>
										</dd>
									</dl>
								</td>
								<td class="lBdr1 vTop">
									<dl class="note01 tPad10">
										<dt><strong class="fs11">실시간 계좌이체 안내</strong></dt>
										<dd>
											<ul class="list01">
												<li>실시간 계좌 이체 서비스는 은행계좌만 있으면 누구나 이용하실 수 있는 서비스로, 별도의 신청 없이 그 대금을 자신의 거래은행의 계좌로부터 바로 지불하는 서비스입니다.</li>
												<li class="tMar05">결제 시 공인인증서가 반드시 필요합니다.</li>
												<li class="tMar05">결제 후 1시간 이내에 확인되며, 입금 확인 시 배송이 이루어 집니다.</li>
												<li class="tMar05">은행 이용가능 서비스 시간은 은행사정에 따라 다소 변동될 수 있습니다.</li>
											</ul>
										</dd>
									</dl>
								</td>
							</tr>
							<!-- //실시간 계좌이체 선택의 경우 -->
							<!-- 무통장 입금 선택의 경우 -->
							<tr id="paymethod_desc1_7" style="display:none" >
								<input type="hidden" name="isCyberAcct" value="<%= CHKIIF(IsCyberAcctValid,"Y","") %>">
								<input type="hidden" name="CST_PLATFORM" value="<%= CHKIIF(application("Svr_Info")= "Dev","test","") %>">
								<td class="vTop">
									<% if Not (IsCyberAcctValid) then %>
									<dl class="note01 tPad10">
										<dt><strong class="fs11">입금계좌번호</strong></dt>
										<dd>
											<% Call DrawTenBankAccount("acctno","") %>
											&nbsp;&nbsp;예금주 : (주)텐바이텐
										</dd>
									</dl>
									<% else %>
									<dl class="note01 tPad10">
										<dt><strong class="fs13">유의사항</strong></dt>
										<dd>

											<ul class="list01">
												<li>무통장 입금 확인은 입금 후 1시간 이내에 확인되며, 입금 확인 후 인증번호 전송이 이루어 집니다.</li>
												<li>결제완료 후 취소요청시, <span class="crRed">마이텐바이텐 &gt; Gift 카드 &gt; 카드주문내역</span>을 이용하시면 됩니다.</li>
											</ul>
										</dd>
									</dl>
									<% end if %>
								</td>
								<td class="lBdr1 vTop">
									<% if Not (IsCyberAcctValid) then %>
									<dl class="note01 tPad10">
										<dt><strong class="fs11">무통장입금 안내</strong></dt>
										<dd>
											<ul class="list01">
												<li>타행에서 입금하실경우 송금수수료가 부과 될 수 있습니다.</li>
												<li>입금자명, 입금액, 입금하실 은행이 일치 하여야 입금확인이 이루어집니다.</li>
												<li>입금후 영업일 1일 이내 확인되지 않으시면 고객센터로 문의 주시기 바랍니다.</li>
												<li>계좌번호는  주문완료 페이지에서 확인할수 있으며 sms 문자 안내도 드립니다.</li>
												<li>무통장  주문 후 7일이 지날때까지 입금이 안되면 주문은 자동으로 취소됩니다.</li>
											</ul>
										</dd>
									</dl>
									<% else %>
									<dl class="note01 tPad10">
										<dt><strong class="fs11">가상계좌 안내</strong></dt>
										<dd>
											<ul class="list01">
												<li>무통장 입금 시 사용되는 가상계좌는 매 주문 시마다 새로운 계좌번호(개인전용)가 부여되며 해당 주문에만 유효합니다.</li>
												<li class="tMar05">계좌번호는 주문완료 페이지에서 확인 가능하며, SMS로도 안내 드립니다.</li>
												<li>무통장  주문 후 7일이 지날때까지 입금이 안되면 주문은 자동으로 취소됩니다.</li>
											</ul>
										</dd>
									</dl>
									<% end if %>
								</td>
							</tr>
							<!-- //무통장 입금 선택의 경우 -->
							</tbody>
						</table>
					</div>

					<div class="overHidden tMar50">
						<h3 class="crRed">텐바이텐 Gift 카드 약관 동의</h3>
					</div>
					<table class="baseTable orderForm payForm tMar10">
					<caption>텐바이텐 Gift 카드 약관 동의 내용</caption>
					<tbody>
					<tr>
						<td>
							<div class="giftCardCont">
								<p class="fs12">&lt;텐바이텐 Gift카드 약관&gt;</p>
								<p class="tPad20">제1조 (텐바이텐 Gift 카드 정의)<br />
								① 텐바이텐 Gift 카드(이하 “Gift 카드”라 합니다)」는 텐바이텐 주식회사(이하 “회사”라 합니다)에서 발행한 무기명 선불카드로 일정 금액(이하 “권면가”라 합니다)만큼 사용하실 수 있는 카드 입니다.<br />
								② 텐바이텐 Gift 카드는 휴대폰으로 전송되는 무기명 선불카드입니다.<br />
								③ “회원”이라 함은 이 약관을 승인하고 텐바이텐㈜에 Gift 카드의 발급을 신청하여 회사로부터 Gift 카드를 구매하고 해당 Gift 카드를 발급 받은 분을 말합니다.</p>
								<p class="tPad20">제2조 (Gift 카드의 구매 및 관리)<br />
								① Gift 카드의 구매는 회사가 정한 소정의 방법에 의해 구매하실 수 있습니다. 지정하는 공식 판매처에서만 구매하실 수 있으며 이외의 곳에서 구매 하실 경우 어떠한 책임도 부담하지 않습니다.<br />
								② 회원은 Gift 카드를 제3자에게 담보로 제공할 수 없고, 선량한 관리자로서의 주의를 다하여 Gift 카드를 이용,관리하여야 합니다.<br />
								③ 회원은 유효기간이 경과한 Gift 카드는 사용할 수 없습니다.<br />
								④ 새로운 인증 번호로 재전송을 할 경우 구 인증번호는 이용할 수 없습니다.<br />
								⑤ 회원은 Gift 카드 구매를 위장한 현금융통 등의 부당한 행위를 하여서는 안됩니다.<br />
								⑥ 각 항을 위반 또는 해태 함으로써 발생하는 모든 책임은 회원에게 귀속됩니다.</p>
								<p class="tPad20">제3조 (Gift 카드의 이용 및 제한)<br />
								① Gift 카드는 잔액 내에서 횟수에 제한 없이 자유롭게 사용하실 수 있습니다.<br />
								② Gift 카드는 일시불 결제로만 사용 가능하며 할부 구매 및 현금서비스는 사용하실 수 없습니다.<br />
								③ Gift 카드는 권면금액만큼 사용할 수 있고, 지정된 사용처에서 물품의 구매나 용역의 결제 시 결제금액만큼 즉시 차감됩니다.<br />
								④ 회사는 Gift 카드가 사용중지 상태이거나, 아래 기타 사용제한이 요구되는 중대한 사유가 발생한 경우에는 고객의 Gift 카드 사용을 제한할 수 있습니다.<br />
								&nbsp;&nbsp;&nbsp;1. 약관 또는 관계법령에서 정한 사항을 위반한 경우<br />
								&nbsp;&nbsp;&nbsp;2. Gift 카드를 이용하여 공공질서와 선량한 풍속에 반하는 행위를 한 경우<br />
								⑤ Gift 카드의 최대 구매금액 및 구매방법은 관계법령에 의해 제한될 수 있습니다.</p>
								<p class="tPad20">제4조 (Gift 카드의 인터넷사용 등록)<br />
								온라인에서 물품이나 용역을 구매하기 위해서는 회사가 정한 방법에 따라 해당 Gift 카드를 인터넷사용 등록해야 합니다.</p>
								<p class="tPad20">제5조 (Gift 카드의 소득공제 등록)<br />
								① 무기명 선불카드인 Gift 카드를 회사가 정한 소정의 소득공제 등록 절차를 거쳐서 기명화할 수 있습니다.<br />
								② Gift 카드 사용액에 대한 연말소득공제를 받기 위해서는 회사가 정한 방법에 따라 해당 Gift 카드를 소득공제 등록해야 합니다.<br />
								③ Gift 카드 소득공제 등록을 하신 후라도, Gift 카드의 환불 및 대체입금에 대해서는 소득공제가 되지 않습니다.</p>
								<p class="tPad20">제6조(Gift 카드의 환불 및 잔액환급)<br />
								① 환불은 구매일로부터 7일 이내에 가능하며, 온라인 등록이 완료되었거나, 온라인과 오프라인에서 금액의 일부라도 사용된 Gift 카드는 환불이 되지 않습니다.<br />
								② Gift 카드 권면 금액이 1만원 초과일 경우 100분의 60 사용시, 1만원 이하일 경우 100분의 80 이상 사용시에는 텐바이텐 온라인에서는 예치금으로 전환 받을 수 있으며 이 조건을 충족하지 못할 경우에는 잔액 환급이 되지 않습니다.<br />
								③ 온라인에서는 여러 개의 Gift카드를 등록하신 경우, 등록한 순서에 따라 사용되며 잔액의 예치금 전환의 경우에도 이 조건이 적용됩니다.</p>
								<p class="tPad20">제7조 (Gift 카드의 유효기한)<br />
								① Gift 카드의 유효기한은 5년이고, 유효기한이 경과된 Gift 카드는 사용하실 수 없습니다.<br />
								② 5년이 지난 경우 환불 불가하며, 5년 이내에는 제 6조 잔액 환불 규정에 따라 온라인 예치금 전환이 가능합니다.</p>
								<p class="tPad20">제8조 (Gift 카드의 재발급)<br />
								① 인증번호 분실 시, 정해진 횟수에 한해 재전송이 가능합니다.<br />
								② 단, Gift 카드가 이미 온라인에 등록이 완료된 경우 재전송이 되지 않습니다.</p>
								<p class="tPad20">제9조 (Gift 카드의 도난ㆍ분실 등에 따른 책임)<br />
								회원이 잘못된 휴대폰 번호 혹은 이메일로 Gift 카드 관련 정보(인증번호)를 전송하거나 회원의 부주의로 타인에게 노출 되어 타인에 의해 온라인 등록 또는 사용된 경우, 회사는 책임을 지지 아니하며, 고객이 책임을 부담합니다.</p>
								<p class="tPad20">제10조 (Gift 카드 위/변조 등에 대한 책임)<br />
								① 위,변조로 인하여 발생된 불법매출에 대한 책임은 회사에 있습니다.<br />
								② 제①항의 규정에도 불구하고 다음 각 호의 사유로 인하여 발생한 불법매출에 대하여는 회원이 그 책임의 전부 또는 일부를 부담하여야 합니다.<br />
								&nbsp;&nbsp;&nbsp;1. 회원의 고의 또는 중대한 과실로 인해 문제가 발생한 경우<br />
								&nbsp;&nbsp;&nbsp;2. Gift 카드를 제 3자에게 대여하거나 사용위임, 양도 또는 담보 목적으로 제공한 경우<br />
								&nbsp;&nbsp;&nbsp;3. 제 3자가 권한 없이 회원의 Gift 카드를 이용하여 거래를 할 수 있음을 알았거나 쉽게 알 수 있었음에도 불구하고 Gift 카드 관련 정보(인증번호)를 누설 또는 노출하거나 방치한 경우</p>
								<p class="tPad20">제11조 (이용약관의 효력 및 변경)<br />
								① 이 약관의 내용은 특별한 규정이 없는 한 회사 및 제휴사가 제공하는 서비스 화면상에 게시하거나 기타의 방법으로 회원에게 공지함으로써 효력을 발생합니다.<br />
								② 회사는 영업상의 중요한 사유 또는 기타 필요하다고 인정되는 합리적인 사유가 발생할 경우에는 약관의 일부 또는 전부를 변경할 수 있으며, 이 경우 해당 변경 내용을 인터넷상 서비스 공지화면에 적용 예정일로부터 1개월 이전에 공지합니다.<br />
								③ 전항의 방법으로 약관이 변경ㆍ고지된 이후에도 계속적으로 서비스를 이용하는 회원은 약관의 변경사항에 동의한 것으로 간주하며, 이는 기존의 회원에게도 동일하게 적용됩니다.</p>
								<p class="tPad20">제12조 (이 약관에서 정하지 아니한 사항)<br />
								이 약관에서 정하지 아니한 사항과 이 약관의 해석에 관하여는 관계법령 또는 일반 상관례에 따릅니다.</p>
								<p class="tPad20">제13조 (관할법원)<br />
								이 약관에 따른 거래에 대하여 분쟁이 발생한 경우에는 회사의 본점 또는 영업소 소재지, 회원의 주소지를 관할하는 법원을 제1심 관할법원으로 합니다.
								</p>
							</div>
						</td>
					</tr>
					<tr>
						<td class="ct fs12"><p class="pad05 cr000"><input type="checkbox" class="check" id="giftcardAgree" name="areement" value="ok" /> <label for="giftcardAgree">텐바이텐 Gift 카드 이용약관을 확인하였으며 약관에 동의합니다.</label></p></td>
					</tr>
					</tbody>
					</table>
					<div class="ct tMar60 bPad20" id="nextbutton1">
						<a href="javascript:history.back();" class="btn btnB2 btnWhite2 btnW220"><em class="gryArr02">이전 페이지</em></a>
						<a href="javascript:OrderProc(document.frmorder);" class="lMar10 btn btnB2 btnRed btnW220">결제하기</a>
					</div>
					<div class="ct tMar60 bPad20" id="nextbutton2" style="display:none">
						<a href="#" class="btn btnB2 btnWhite2 btnW220" onClick="return false;"><em class="gryArr02">이전 페이지</em></a>
						<a href="#" class="lMar10 btn btnB2 btnRed btnW220" onClick="return false;">결제하기</a>
					</div>
				</div>
				</form>

				<form name="frmPreview" method="post" style="margin:0px;">
				<input type="hidden" name="cardid" value="<%=cardid%>">
				<input type="hidden" name="cardopt" value="<%=cardOption%>">
				<input type="hidden" name="cardPrice" value="<%=cardPrice%>">
				<input type="hidden" name="designid">
				<input type="hidden" name="buyname">
				<input type="hidden" name="emailTitle">
				<input type="hidden" name="emailContent">
				</form>

			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<script language=javascript src="https://plugin.inicis.com/pay40_ssl.js"></script>
<script type="text/javascript">
StartSmartUpdate();
</script>
</body>
</html>
<%
Set oCardItem = Nothing
set oUserInfo = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
