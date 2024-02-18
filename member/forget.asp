<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'#######################################################
'	Description : 아이디/비밀번호 찾기
'	History	:  2013.02.12 허진원 - 실명인증 없는 방법
'              2013.07.30 허진원 - 2013리뉴얼
'              2016.06.27 허진원 - pingInfo 사용할때만 ajax로 가져오도록 수정
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/member/iPin/nice.nuguya.oivs.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 아이디/비밀번호 찾기"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_member_v1.jpg"
	strPageDesc = "회원정보로 아이디&비밀번호를 찾을수 있습니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 아이디/비밀번호 찾기"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/member/forget.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	Dim C_dumiKey
	C_dumiKey = session.sessionid

	'## 로그인 여부 확인
	if IsUserLoginOK then		
		Response.Write "<script>alert('이미 로그인이 되어있습니다.'); location.href='http://www.10x10.co.kr/'</script>"				
		dbget.close(): response.End
	end if

	'####### 본인인증(아이핀) 사용여부 ("N"으로하면 본인인증 없이 패스~) #######
	Dim rnflag
	rnflag	= "Y"

	'#######################################################################################
	'#####	개인인증키(대체인증키;아이핀) 서비스				한국신용정보(주)
	'#######################################################################################
	Dim NiceId, SIKey, ReturnURL, pingInfo, strOrderNo
	'// 텐바이텐
	NiceId = "Ntenxten4"		'// 회원사 ID
	SIKey = "N0001N013276"		'// 사이트식별번호 12자리

	ReturnURL = SSLUrl & "/member/popCheckIDPWiPin.asp"	'// 한국신용정보(주)로 부터 서비스처리 결과를 전달 받아 처리할 페이지
' js Ajax 처리로 서버단 통신은 제거
'	On Error Resume Next
'		pingInfo = getPingInfo()
'		If Err.Number>0 Then
'	        rnflag="N"
'		end if
'	on error Goto 0

	randomize(time())
	strOrderNo = Replace(date, "-", "")  & round(rnd*(999999999999-100000000000)+100000000000)

	'// 해킹방지를 위해 요청정보를 세션에 저장
	session("niceOrderNo") = strOrderNo
%>
<script language="javascript" SRC="/lib/js/confirm.js"></script>
<!--	==========================================================	-->
<!--	한국신용정보주식회사 처리 모듈                            	-->
<!--	==========================================================	-->
<script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.crypto.js"></script>
<script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.msgg.utf8.js"></script>
<script type="text/javascript" src="https://secure.nuguya.com/nuguya/nice.nuguya.oivs.util.js"></script>
<script type="text/javascript">
<!--
	function chgSelIdDiv(frm) {
		if(frm.value=="E") {
			$("#lyrIDEmail").show();
			$("#lyrIDPhone").hide();
		} else {
			$("#lyrIDEmail").hide();
			$("#lyrIDPhone").show();
		}
	}

	function chgSelPWDiv(frm) {
		if(frm.value=="E") {
			$("#lyrPWEmail").show();
			$("#lyrPWPhone").hide();
		} else {
			$("#lyrPWEmail").hide();
			$("#lyrPWPhone").show();
		}
	}

	function chgSelPWIPDiv(frm) {
		if(frm.value=="I") {
			$("#lyrPWiPin").show();
			$("#lyrPWMobi").hide();
		} else {
			$("#lyrPWiPin").hide();
			$("#lyrPWMobi").show();
		}
	}

	// 아이디 찾기 (이메일/휴대폰)
	function jsFindIDEP(frm) {
		var sNm, sEm, sHp, para

		if(frm.selIDDiv[0].checked) {
			sNm = frm.usernameE.value;
			if(!sNm) {
				alert("성명을 입력해주세요.");
				frm.usernameE.focus();
				return;
			}

			sEm = chkEmailForm(frm)
			if(!sEm) return;
			para = "nm="+escape(sNm)+"&mail="+sEm
		} else {
			sNm = frm.usernameP.value;
			if(!sNm) {
				alert("성명을 입력해주세요.");
				frm.usernameP.focus();
				return;
			}

			sHp = chkPhoneForm(frm)
			if(!sHp) return;
			para = "nm="+escape(sNm)+"&cell="+sHp
		}

		var rstStr = $.ajax({
			type: "POST",
			url: "ajaxFindIDEmailHP.asp",
			data: para,
			dataType: "text",
			async: false
		}).responseText;

		$("#lyrIDResult").hide().fadeIn();
		$("#lyrResultIdList").empty();
		$("#lyrResultIdList").html(rstStr);
	}

	// 패스워드 찾기 (이메일/휴대폰)
	function jsFindPWEP(frm) {
		var sId, sNm, sEm, sHp, para

		if(frm.selPWDiv[0].checked) {
			sId = frm.useridE.value;
			sNm = frm.usernameE.value;
			if(!sId) {
				alert("아이디를 입력해주세요.");
				frm.useridE.focus();
				return;
			}
			if(!sNm) {
				alert("성명을 입력해주세요.");
				frm.usernameE.focus();
				return;
			}

			sEm = chkEmailForm(frm)
			if(!sEm) return;
			para = "id="+sId+"&nm="+escape(sNm)+"&mail="+sEm
		} else {
			sId = frm.useridP.value;
			sNm = frm.usernameP.value;
			if(!sId) {
				alert("아이디를 입력해주세요.");
				frm.useridP.focus();
				return;
			}
			if(!sNm) {
				alert("성명을 입력해주세요.");
				frm.usernameP.focus();
				return;
			}

			sHp = chkPhoneForm(frm)
			if(!sHp) return;
			para = "id="+sId+"&nm="+escape(sNm)+"&cell="+sHp
		}

		var rstStr = $.ajax({
			type: "POST",
			url: "ajaxFindPWEmailHP.asp",
			data: para,
			dataType: "text",
			async: false
		}).responseText;

		if (rstStr == "1"){
			alert("가입시 메일로 임시 비밀번호를 보내드렸습니다.\n메일을 확인해주세요.");
		}else if (rstStr == "2"){
			alert("가입시 휴대폰으로 임시 비밀번호를 보내드렸습니다.\n문자를 확인해주세요.");
		}else if (rstStr == "3"){
			alert("핸드폰으로 본인증을 완료하신 고객입니다.\n휴대폰으로 비밀번호를 찾아주세요");
		}else if (rstStr == "4"){
			alert("이메일로 본인증을 완료하신 고객입니다.\n이메일로 비밀번호를 찾아주세요");
		}else if(rstStr == "5"){
			alert("입력하신 내용과 일치하는 정보가 없습니다.\n\n※실명인증 가입고객이라면 아이핀,본인인증으로 찾으실 수 있습니다.");
		}else if(rstStr == "6"){
			alert("SNS 계정으로 회원가입하신 고객입니다.\n\nSNS 계정으로 로그인을 통해 서비스를 이용해주세요.");
		}else{
			alert("발송 중 오류가 발생했습니다.\n\n"+rstStr);
		}
	}

	// 이메일 폼 양식
	function EmailChecker(frm){
		if( frm.txEmail2.value == "etc")  {
			frm.selfemail.value="";
			frm.selfemail.focus();
		}else{
			if(frm.txEmail2.value!="") {
				frm.selfemail.value=frm.txEmail2[frm.txEmail2.selectedIndex].text;
			} else {
				frm.selfemail.value="";
			}
		}
		return;
	}

	// 이메일 입력 확인
	function chkEmailForm(frm) {
		var email;
		if (frm.txEmail1.value == ""){
			alert("이메일 앞부분을 입력해주세요");
			frm.txEmail1.focus();
			return ;
		}
		if (frm.txEmail1.value.indexOf('@')>-1){
		    alert("@를 제외한 앞부분만 입력해주세요...");
			frm.txEmail1.focus();
			return ;
		}
		if (frm.txEmail2.value == ""){
			alert("이메일 도메인을 선택해주시거나 직접 입력해주세요...");
			frm.txEmail2.focus();
			return ;
		}
		if ((frm.txEmail2.value == "etc")&&(frm.selfemail.value.length<1)){
		    alert("이메일 도메인을 선택해주시거나 직접 입력해주세요...");
			frm.selfemail.focus();
			return ;
		}
		if( frm.txEmail2.value == "etc"){
		    email = frm.txEmail1.value + '@' + frm.selfemail.value;
		}else{
		    email = frm.txEmail1.value + frm.txEmail2.value;
		}

		if (email == ''){
			return;
		}else if (!check_form_email(email)){
	        alert("이메일 주소가 유효하지 않습니다.");
			frm.txEmail1.focus();
			return ;
		}
		return email;
	}

	// 휴대폰 입력 확인
	function chkPhoneForm(frm) {
		var phone;
		if (frm.txCell2.value.length<3){
		    alert("휴대전화 번호를 입력해주세요");
			frm.txCell2.focus();
			return ;
		}
		if (frm.txCell3.value.length<4){
		    alert("휴대전화 번호를 입력해주세요");
			frm.txCell3.focus();
			return ;
		}
		phone = frm.txCell1.value+"-"+frm.txCell2.value+"-"+frm.txCell3.value
		return phone;
	}

	// ---------- 아이핀 관련 스크립트
	function iPinValidate()
	{
		fnCheckPingInfo();
		var NiceId		= document.getElementById( "NiceId" );
		var PingInfo	= document.getElementById( "PingInfo" );
		var ReturnURL	= document.getElementById( "ReturnURL" );

		if ( NiceId.value == "" )
		{
			alert( getCheckMessage( "S60" ) );
			NiceId.focus();
			return false;
		}

		if ( PingInfo.value == "" )
		{
			alert( getCheckMessage( "S61" ) );
			return false;
		}

		if ( ReturnURL.value == "" )
		{
			alert( getCheckMessage( "S64" ) );
			ReturnURL.focus();
			return false;
		}

		return true;
	}

	// 아이디/패스워드 찾기 (아이핀)
	function jsFindIDIP(frm)
	{
	<% if pingInfo="" then %>
		//alert( "한국신용정보(주)의 개인인증키 서비스가 점검중입니다.\n잠시후 다시 시도하시기 바랍니다.\n\n상태가 계속되면 사이트관리자에게 문의하십시오" );
		//return;
	<% end if %>

		var strParam = "?mode=" + frm.mode.value;

	    if (frm.mode.value=="pass") {
	        if (frm.userid.value.length<1) {
		        alert("아이디를 입력해주세요.");
		        frm.userid.focus();
		        return;
			} else {
				strParam = strParam + "&txUserID=" + frm.userid.value;
			}
	    }

		if ( iPinValidate() == true )
		{
			fnCheckPingInfo();

			var strNiceId 	= document.getElementById( "NiceId" ).value;
			var strPingInfo	= document.getElementById( "PingInfo" ).value;
			var strOrderNo	= document.getElementById( "OrderNo" ).value;
			var strInqRsn	= document.getElementById( "InqRsn" ).value;
			var strReturnUrl= document.getElementById( "ReturnURL" ).value + strParam;
			var strSIKey 	= document.getElementById( "SIKey" ).value;

			document.reqForm.SendInfo.value = makeCertKeyInfoPA( strNiceId, strPingInfo, strOrderNo, strInqRsn, strReturnUrl, strSIKey );
			document.reqForm.ProcessType.value = strPersonalCertKey;

			var popupWindow = window.open( "", "popupCertKey", "top=100, left=200, status=0, width=417, height=490" );
			document.reqForm.target = "popupCertKey";
			document.reqForm.action = strCertKeyServiceUrl;
			document.reqForm.submit();
			popupWindow.focus();
		}

		return;
	}

	// 패스워드 찾기(모바일본인인증)
	function jsFindPWMobi(frm) {
        if (frm.userid.value.length<1) {
	        alert("아이디를 입력해주세요.");
	        frm.userid.focus();
	        return;
		}

		var popupWindow = window.open( "", "KMCISWindow", "width=425, height=550, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=435, top=250" );
		document.reqMobiForm.txUserid.value=frm.userid.value;
		document.reqMobiForm.action = 'popCheckPWMobile.asp';
		document.reqMobiForm.target = "KMCISWindow";
		document.reqMobiForm.submit();
		popupWindow.focus();
	}

	// 한국신용정보 커넥션 정보 확인
	function fnCheckPingInfo() {
		var vPingInfgo = document.getElementById( "PingInfo" ).value;
		if(vPingInfgo=="") {
			$.ajax({
				url: "/member/ipin/act_pingInfo.asp",
				cache: false,
				async: false,
				success: function(message) {
					document.getElementById( "PingInfo" ).value = message.replace(/\r\n/g, "");
				}
				,error: function(err) {
					alert( "한국신용정보(주)의 개인인증키 서비스가 점검중입니다.\n잠시후 다시 시도하시기 바랍니다.\n\n상태가 계속되면 사이트관리자에게 문의하십시오" );
					console.log(err.responseText);
				}
			});
		}
	}
//-->
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="memPage findMem">
				<!-- find id -->
				<div class="findIdPw">
					<h2 class="tMar35"><img src="http://fiximage.10x10.co.kr/web2013/member/tit_find_id.gif" alt="아이디 찾기" /></h2>
					<ul class="help">
						<li>- 회원정보에 저장된 생년월일, 휴대폰/전화번호 이메일 주소로 아이디를 찾을 수 있습니다.</li>
						<li>- 아이핀으로 가입하신 회원님은 아이디를 분실하셨을 경우, 아이핀 인증을 이용하여 확인하실 수 있습니다.</li>
					</ul>
					<div class="overHidden">
						<div class="ftLt box2 tBdr1">
						<form name="frmIDfind" method="post" onsubmit="return false;">
						<input type="hidden" name="mode" value="id">
							<p class="type">
								<span><input type="radio" name="selIDDiv" id="fidMail" value="E" class="check" checked="checked" onclick="chgSelIdDiv(this)" /> <label for="fidMail">이메일</label></span>
								<span><input type="radio" name="selIDDiv" id="fidPhone" value="P" class="check" onclick="chgSelIdDiv(this)" /> <label for="fidPhone">휴대폰</label></span>
							</p>
							<div id="lyrIDEmail" class="boxCont">
								<fieldset>
									<legend>이메일주소로 아이디찾기</legend>
									<dl class="frmType">
										<dt><label for="fidName">성명</label></dt>
										<dd><input type="text" name="usernameE" id="fidName" maxlength="30" class="txtInp focusOn" style="width:201px" title="찾고자 하는 회원님의 성명을 입력해 주세요" /></dd>
									</dl>
									<dl class="frmType">
										<dt><label for="fidMail2">이메일</label></dt>
										<dd>
											<input type="text" class="txtInp" name="txEmail1" id="fidMail2" maxlength="32" title="이메일 아이디 입력" style="width:80px;ime-mode:disabled;" />
											@
											<input type="text" class="txtInp" name="selfemail" id="selfemail" maxlength="80" title="이메일 직접 입력" style="width:80px;ime-mode:disabled;" />
											<select name="txEmail2" id="txEmail2" class="select" onchange="EmailChecker(document.frmIDfind)" title="이메일 서비스 선택">
												<option value="" selected="selected">선택해 주세요</option>
												<option value="@hanmail.net">hanmail.net</option>
												<option value="@naver.com">naver.com</option>
												<option value="@hotmail.com">hotmail.com</option>
												<option value="@yahoo.co.kr">yahoo.co.kr</option>
												<option value="@hanmir.com">hanmir.com</option>
												<option value="@paran.com">paran.com</option>
												<option value="@lycos.co.kr">lycos.co.kr</option>
												<option value="@nate.com">nate.com</option>
												<option value="@dreamwiz.com">dreamwiz.com</option>
												<option value="@korea.com">korea.com</option>
												<option value="@empal.com">empal.com</option>
												<option value="@netian.com">netian.com</option>
												<option value="@freechal.com">freechal.com</option>
												<option value="@msn.com">msn.com</option>
												<option value="@gmail.com">gmail.com</option>
												<option value="etc">직접입력</option>
											</select>
										</dd>
									</dl>
								</fieldset>
								<p class="btnAlign"><span class="btn btnM1 btnRed idRst" onclick="jsFindIDEP(document.frmIDfind)">확인</span></p>
							</div>
							<div id="lyrIDPhone" class="boxCont" style="width:320px; display:none;">
								<fieldset>
									<legend>휴대폰번호로 아이디찾기</legend>
									<dl class="frmType">
										<dt><label for="fidName2">성명</label></dt>
										<dd><input type="text" name="usernameP" id="fidName2" maxlength="30" class="txtInp focusOn" style="width:228px" title="찾고자 하는 회원님의 성명을 입력해 주세요" /></dd>
									</dl>
									<dl class="frmType">
										<dt><label for="fidPhone2">휴대폰</label></dt>
										<dd>
											<select name="txCell1" id="fidPhone2" class="select focusOn" title="휴대전화 앞자리 선택" style="width:60px">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
											</select>
											-
											<input type="text" name="txCell2" class="txtInp focusOn" maxlength="4" title="휴대전화 가운데자리 입력" style="width:63px" />
											-
											<input type="text" name="txCell3" class="txtInp focusOn" maxlength="4" title="휴대전화 뒷자리 입력" style="width:64px" />
										</dd>
									</dl>
									<p class="btnAlign"><span class="btn btnM1 btnRed idRst" onclick="jsFindIDEP(document.frmIDfind)">확인</span></p>
								</fieldset>
							</div>
						</form>
						</div>
						<div class="ftRt box2 tBdr1">
							<p class="type">아이핀</p>
							<div class="boxCont sId">
								<p>아이핀(I-Pin)으로 가입하신 회원은<br />아이핀 인증으로 아이디를 확인하실 수 있습니다.</p>
								<p class="btnAlign" style="left:0;"><span class="btn btnM1 btnRed" onclick="jsFindIDIP(document.frmIDfind)">확인</span></p>
							</div>
						</div>
					</div>

					<!-- id search result -->
					<div id="lyrIDResult" class="findResult" style="display:none;">
						<p><strong>아이디 조회 결과 입력하신 정보와 일치하는 아이디는 아래와 같습니다.</strong><br /><span class="cr999">(가입정책 변경으로 신규고객과 인증절차가 이루어지지 않은 기존고객 아이디가 함께 검색될 수 있습니다.)</span></p>
						<ul id="lyrResultIdList" class="idList"></ul>
						<p id="lyrResultIDBtn" class="ct tMar20" style="display:none;"><a href="pop_findFullID.asp" onclick="window.open(this.href, 'popViewId', 'width=620, height=580, scrollbars=yes'); return false;" target="_blank" class="btn btnS1 btnW150 btnGry3">아이디 뒷자리 확인</a></p>
					</div>
					<!--// id search result -->
				</div>
				<!--// find id -->

				<!-- find password -->
				<div class="findIdPw sPw">
					<h2><img src="http://fiximage.10x10.co.kr/web2013/member/tit_find_pw.gif" alt="비밀번호 찾기" /></h2>
					<ul class="help">
						<li>- <strong>본인인증을 완료한 회원님</strong>은 이메일, 휴대폰을 이용하여 비밀번호를 찾으실 수 있습니다.</li>
						<li>- <strong>본인인증이 완료되지 않은 회원님</strong>은 본인임을 확인할 수 있는 아이핀 또는 본인인증 서비스를 이용하여 찾으실 수 있습니다.</li>
						<li>- <strong>SNS 계정</strong>으로 <strong>회원가입</strong>하신 회원님은 비밀번호 찾기가 <strong>불가</strong>합니다. 가입하신 SNS 계정을 통해 로그인을 해주세요.</li>
						<li>- 아이디가 확인되면 임시비밀번호를 보내드립니다. 로그인후 <strong>마이텐바이텐 > 개인정보수정에서 비밀번호를 수정</strong>에서 비밀번호를 수정해주세요.</li>
					</ul>
					<div class="overHidden">
						<div class="ftLt box2 tBdr1">
						<form name="frmPWfind" method="post" onsubmit="return false;">
							<p class="type">
								<span><input type="radio" name="selPWDiv" id="fpwMail" value="E" class="check" checked="checked" onclick="chgSelPWDiv(this)" /> <label for="fpwMail">이메일</label></span>
								<span><input type="radio" name="selPWDiv" id="fpwPhone" value="P" class="check" onclick="chgSelPWDiv(this)" /> <label for="fpwPhone">휴대폰</label></span>
							</p>
							<div id="lyrPWEmail" class="boxCont">
								<fieldset>
									<legend>이메일주소로 비밀번호찾기</legend>
									<dl class="frmType">
										<dt><label for="fpwId">아이디</label></dt>
										<dd><input type="text" name="useridE" id="fpwId" maxlength="32" class="txtInp focusOn" style="width:201px;ime-mode:disabled;" title="회원님의 아이디를 입력해주세요." /></dd>
									</dl>
									<dl class="frmType">
										<dt><label for="fpwName">성명</label></dt>
										<dd><input type="text" name="usernameE" id="fpwName" maxlength="30" class="txtInp focusOn" style="width:201px" title="회원님의 성명을 입력해 주세요." /></dd>
									</dl>
									<dl class="frmType">
										<dt><label for="fpwMail2">이메일</label></dt>
										<dd>
											<input type="text" class="txtInp focusOn" name="txEmail1" id="fpwMail2" maxlength="32" title="이메일 아이디 입력" style="width:80px;ime-mode:disabled;" />
											@
											<input type="text" name="selfemail" class="txtInp focusOn" maxlength="80" title="이메일 직접 입력" style="width:80px;ime-mode:disabled;" />
											<select name="txEmail2" class="select focusOn" title="이메일 서비스 선택" onchange="EmailChecker(this.form)">
												<option value="" selected="selected">선택해 주세요</option>
												<option value="@hanmail.net">hanmail.net</option>
												<option value="@naver.com">naver.com</option>
												<option value="@hotmail.com">hotmail.com</option>
												<option value="@yahoo.co.kr">yahoo.co.kr</option>
												<option value="@hanmir.com">hanmir.com</option>
												<option value="@paran.com">paran.com</option>
												<option value="@lycos.co.kr">lycos.co.kr</option>
												<option value="@nate.com">nate.com</option>
												<option value="@dreamwiz.com">dreamwiz.com</option>
												<option value="@korea.com">korea.com</option>
												<option value="@empal.com">empal.com</option>
												<option value="@netian.com">netian.com</option>
												<option value="@freechal.com">freechal.com</option>
												<option value="@msn.com">msn.com</option>
												<option value="@gmail.com">gmail.com</option>
												<option value="etc">직접입력</option>
											</select>
										</dd>
									</dl>
									<p class="btnAlign"><span class="btn btnM1 btnRed" onclick="jsFindPWEP(document.frmPWfind)">확인</span></p>
								</fieldset>
							</div>
							<div id="lyrPWPhone" class="boxCont" style="width:320px; display:none;">
								<fieldset>
									<legend>휴대폰번호로 비밀번호찾기</legend>
									<dl class="frmType">
										<dt><label for="fpwId2">아이디</label></dt>
										<dd><input type="text" name="useridP" id="fpwId2" maxlength="32" class="txtInp focusOn" style="width:228px;ime-mode:disabled;" title="회원님의 아이디를 입력해주세요." /></dd>
									</dl>
									<dl class="frmType">
										<dt><label for="fpwName2">성명</label></dt>
										<dd><input type="text" name="usernameP" id="fpwName2" maxlength="30" class="txtInp focusOn" style="width:228px;" title="찾고자 하는 회원님의 성명을 입력해 주세요" /></dd>
									</dl>
									<dl class="frmType">
										<dt><label for="fpwPhone2">휴대폰</label></dt>
										<dd>
											<select name="txCell1" id="fpwPhone2" class="select focusOn" title="휴대전화 앞자리 선택" style="width:60px">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
											</select>
											-
											<input type="text" name="txCell2" class="txtInp focusOn" maxlength="4" title="휴대전화 가운데자리 입력" style="width:63px" />
											-
											<input type="text" name="txCell3" class="txtInp focusOn" maxlength="4" title="휴대전화 뒷자리 입력"  style="width:64px" />
										</dd>
									</dl>
									<p class="btnAlign"><span class="btn btnM1 btnRed" onclick="jsFindPWEP(document.frmPWfind)">확인</span></p>
								</fieldset>
							</div>
						</form>
						</div>
						<div class="ftRt box2 tBdr1">
						<form name="frmPWIPfind" method="post" onsubmit="return false;">
						<input type="hidden" name="mode" value="pass" />
							<p class="type">
								<span><input type="radio" name="selPWDivRN" id="fpwIpin" value="I" class="check" checked="checked" onclick="chgSelPWIPDiv(this)" /> <label for="fpwIpin">아이핀(I-Pin)</label></span>
								<span><input type="radio" name="selPWDivRN" id="fpwCert" value="M" class="check" onclick="chgSelPWIPDiv(this)" /> <label for="fpwCert">본인인증 서비스</label></span>
							</p>
							<div class="boxCont sPw">
								<dl class="frmType">
									<dt><label for="fpwTenId">텐바이텐 아이디</label></dt>
									<dd>
										<input type="text" name="userid" id="fpwTenId" maxlength="32" class="txtInp focusOn" style="width:140px;ime-mode:disabled;" title="회원님의 텐바이텐 아이디를 입력해주세요." />
										<p class="tPad10">가입 시 등록하신 이메일로<br />임시 비밀번호를 보내드립니다.</p>
									</dd>
								</dl>
								<p class="btnAlign" style="left:100px;"><span class="btn btnM1 btnRed" onclick="jsFindPWMobi(document.frmPWIPfind)">확인</span></p>
							</div>
						</form>
						</div>
					</div>
				</div>
				<!--// find password -->
			</div>
		<FORM id="reqForm" name="reqForm" method="POST" action="">
		<input class="small" type="hidden" id="SendInfo" name="SendInfo" />
		<input class="small" type="hidden" id="ProcessType" name="ProcessType" />
		</FORM>
		<FORM id="pageForm" name="pageForm" method="POST" action="">
		<INPUT type="hidden" id="NiceId" name="NiceId" value="<%= NiceId %>" />
		<INPUT type="hidden" id="SIKey" name="SIKey" value="<%= SIKey %>" />
		<INPUT type="hidden" id="PingInfo" name="PingInfo" value="<%= pingInfo %>" />
		<INPUT type="hidden" id="ReturnURL" name="ReturnURL" value="<%= ReturnURL %>" />
		<input type="hidden" id="InqRsn" name="InqRsn" value="10" />
		<input type="hidden" id="OrderNo" name="OrderNo" value="<%=strOrderNo%>" />
		</form>
		<form name="reqMobiForm" method="post" action="">
		<input type="hidden" name="txUserid" value="">
		</form>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
