<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 회원가입 STEP.02"		'페이지 타이틀 (필수)

	'## 로그인 여부 확인
	if IsUserLoginOK then
		Call Alert_Return("이미 회원가입이 되어있습니다.")
		dbget.close(): response.End
	end if

	'==============================================================================
	'외부 URL 체크
	dim backurl
	backurl = request.ServerVariables("HTTP_REFERER")
	if InStr(LCase(backurl),"10x10.co.kr") < 1 then 
	    if (Len(backurl)>0) then
	        response.redirect backurl
	        response.end
	    else
	        response.write "<script>alert('유효한 접근이 아닙니다.');history.back();</script>"
	        response.end
	    end if
	end if
	
	'### 약관체크
	Dim agreeUse, agreePrivate, agreeUseAdult
	agreeUse = requestCheckVar(request("agreeUse"),1)
	agreePrivate = requestCheckVar(request("agreePrivate"),1)
	agreeUseAdult = requestCheckVar(request("agreeUseAdult"),1)

	If agreeUse <> "o" OR agreePrivate <> "o" OR agreeUseAdult <> "o" Then
        response.write "<script>alert('약관에 모두 체크 하셔야 합니다.');history.back();</script>"
        response.end
	End If
	

	'####### POINT1010 에서 넘어온건지 체크 #######
	Dim pFlag
	pFlag	= requestCheckVar(request("pflag"),1)

	'// 유입경로
	Dim ihideventid
	ihideventid = session("hideventid")
	If ihideventid="" Then
		ihideventid = request.cookies("rdsite")
	End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script language="javascript" SRC="/lib/js/confirm.js"></script>
<script type="text/javascript">
<!--
var chkID = false, chkAjaxID = false;
var chkEmail = false, chkAjaxEmail = false;

//아이디 중복확인
function DuplicateIDCheck(comp){
	var id;
	id = comp.value;

	if (id == ''){
		return;
	}else if((id.length<3) || (id.length>16)){
		alert('아이디는 공백없는 3~15자의 영문/숫자 조합입니다.');
		comp.focus();
	}else{
		var rstStr = $.ajax({
			type: "POST",
			url: "ajaxIdCheck.asp",
			data: "id="+id,
			dataType: "text",
			async: false
		}).responseText;

		if (rstStr == "ERR"){
			$("#checkMsgID").html("오류가 발생했습니다.");
			chkID = false;
			document.myinfoForm.txuserid.focus();
		}else if (rstStr == "3"){
			$("#checkMsgID").html("특수문자나 한글/한문은 사용불가능합니다.");
			chkID = false;
			document.myinfoForm.txuserid.focus();
		}else if(rstStr == "2"){
			$("#checkMsgID").html("<font class='crRed'>사용하실 수 없는 아이디입니다.</font>");
			chkID = false;
			document.myinfoForm.txuserid.focus();
		}else{
			$("#checkMsgID").html("사용하실 수 있습니다.");
			chkID = true;
		}
		chkAjaxID = true;
	}
}

function jsChkID(){
	if(chkID){
		$("#checkMsgID").html("공백없는 3~15자의 영문/숫자를 조합하여 입력해야 합니다.");
		chkID = false;
	}
}

function jsChkEmail(){
	if(chkEmail){
		$("#checkMsgEmail").html("이메일을 입력해주세요.");
		chkEmail = false;
	}
}

//소문자로 변환; index를 지정할 경우 index길이만큼만 소문자로 변환
function isToLowerCase(obj, index){
	if(typeof(index) != 'undefined' && index != ""){
		obj.value =
			obj.value.substring(0, index).toLowerCase()
			+ obj.value.substring(index, obj.value.length);
		return;
	}
	obj.value = obj.value.toLowerCase();
}

// 이벤트 키코드 체크
function keyCodeCheckID(event,id) {
	if(event.keyCode == 13){
		DuplicateIDCheck(id);
	}
}
function keyCodeCheckEmail(event) {
	if(event.keyCode == 13){
		DuplicateEmailCheck();
	}
}

// 이메일 폼 양식
function NewEmailChecker(){
	var frm = document.myinfoForm;
	if( frm.txEmail2.value == "etc")  {
		frm.selfemail.style.display = '';
		frm.selfemail.focus();
	}else{
		frm.selfemail.style.display = 'none';
	}
	jsChkEmail();
	return;
}

//이메일 중복확인
function DuplicateEmailCheck(){
	var email, frm = document.myinfoForm;
	
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
	}else{
		var rstStr = $.ajax({
			type: "POST",
			url: "ajaxEmailCheck.asp",
			data: "email="+email,
			dataType: "text",
			async: false
		}).responseText;

		if (rstStr == "ERR"){
			$("#checkMsgEmail").html("오류가 발생했습니다.");
			chkEmail = false;
			document.myinfoForm.txEmail1.focus();
		}else if (rstStr == "3"){
			$("#checkMsgEmail").html("이메일 주소가 유효하지 않습니다.");
			chkEmail = false;
			document.myinfoForm.txEmail1.focus();
		}else if(rstStr == "2"){
			$("#checkMsgEmail").html("<font class='crRed'>입력하신 이메일로 이미 가입된 아이디가 있습니다.</font>");
			chkEmail = false;
			document.myinfoForm.txEmail1.focus();
		}else{
			$("#checkMsgEmail").html("사용가능 한 이메일 주소입니다.");
			chkEmail = true;
		}
		chkAjaxEmail = true;
	}
}

function TnTabNumber(thisform,target,num) {
	if (eval("document.myinfoForm." + thisform + ".value.length") == num) {
		eval("document.myinfoForm." + target + ".focus()");
	}
}

// 본인인증 휴대폰SMS 발송
function sendSMS() {
	var frm = document.myinfoForm;
	if(!chkID){
		if((!chkAjaxID) && frm.txuserid.value.length>3 && frm.txuserid.value.length<16) {}
		else {
			alert("아이디를 확인해주세요");
		   	DuplicateIDCheck(frm.txuserid);
		   	frm.txuserid.focus();
		   	return;
		}
	}

	if (jsChkBlank(frm.txCell2.value) || jsChkBlank(frm.txCell3.value)){
	    alert("휴대전화 번호를 입력해주세요");
		frm.txCell2.focus();
		return ;
	}

	if (!jsChkNumber(frm.txCell2.value) || !jsChkNumber(frm.txCell3.value)){
	    alert("휴대전화 번호는 공백없는 숫자로 입력해주세요.");
		frm.txCell2.focus();
		return ;
	}
	
	var usrph = frm.txCell1.value + "-" + frm.txCell2.value + "-" + frm.txCell3.value;
	var rstStr = $.ajax({
		type: "POST",
		url: "ajaxSendConfirmSMS2015.asp",
		data: "id="+frm.txuserid.value+"&ph="+usrph+"",
		dataType: "text",
		async: false
	}).responseText;

	$("#sendSMSnumber").empty().html(rstStr);
	if(rstStr.length == 31){
		$("#certNum").val("").focus();
	}	
}

function fnConfirmSMS() {
	var frm = document.myinfoForm;
	if(frm.crtfyNo.value.length<6) {
		alert("휴대폰으로 받으신 인증번호를 정확히 입력해주세요.");
		frm.crtfyNo.focus();
		return;
	}
	
	var rstStr = $.ajax({
		type: "POST",
		url: "ajaxCheckConfirmSMS2015.asp",
		data: "id="+frm.txuserid.value+"&chkFlag=N&key="+frm.crtfyNo.value,
		dataType: "text",
		async: false
	}).responseText;
	
	if (rstStr == "1"){
		$("#smsRstMsg").html("인증이 완료되었습니다.");
		$("#certNum").attr("readonly", true);
		$("#txCell2").attr("readonly", true);
		$("#txCell3").attr("readonly", true);
		$("#smsButtonn1").hide();
		$("#smsButtonn2").hide();
		$("#sendSMSnumber").hide();
	}else if (rstStr == "2"){
		$("#smsRstMsg").html("인증번호가 정확하지 않습니다.");
	}else{
		$("#smsRstMsg").html("인증번호를 입력해주세요.");
		alert("처리중 오류가 발생했습니다."+rstStr);
	}
}

function FnJoin10x10(){
	var frm = document.myinfoForm;
	if(!chkID){
		if((!chkAjaxID) && frm.txuserid.value.length>3 && frm.txuserid.value.length<16) {}
		else {
			alert("아이디를 확인해주세요");
		   	DuplicateIDCheck(frm.txuserid);
		   	frm.txuserid.focus();
		   	return;
		}
	}

	if (jsChkBlank(frm.txpass1.value)){
		alert("비밀번호를 입력하세요");
		frm.txpass1.focus();
		return ;
	}

	if (frm.txpass1.value.length < 8 || frm.txpass1.value.length > 16){
		alert("비밀번호는 공백없이 8~16자입니다.");
		frm.txpass1.focus();
		return ;
	}

	if (frm.txpass1.value==frm.txuserid.value){
		alert('아이디와 동일한 패스워드는 사용하실 수 없습니다.');
		frm.txpass1.focus();
		return;
	}

	if (!fnChkComplexPassword(frm.txpass1.value)) {
		alert('패스워드는 영문/숫자/특수문자 중 두 가지 이상의 조합으로 입력해주세요.');
		frm.txpass1.focus();
		return;
	}

	if (frm.txpass2.value == ""){
		alert("비밀번호를 확인해주세요");
		frm.txpass2.focus();
		return ;
	}
	if (frm.txpass1.value!=frm.txpass2.value){
		alert("비밀번호가 일치하지 않습니다.");
		frm.txpass1.focus();
		return ;
	}
	
	if (frm.txName.value == ""){
		alert("성명을 입력하세요");
		frm.txName.focus();
		return ;
	}
	if (GetByteLength(frm.txName.value) > 30){
		alert("성명은 한글 15자, 영문 30자 이내 입니다.");
		frm.txName.focus();
		return ;
	}

	if (!frm.txSex[0].checked&&!frm.txSex[1].checked){
		alert("성별을 선택 해주세요");
		frm.txSex[0].focus();
		return ;
	}

	if(!chkEmail){
		alert("이메일을 확인해주세요.");
		frm.txEmail1.focus();
		return;
	}

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
	    frm.usermail.value = frm.txEmail1.value + '@' + frm.selfemail.value;
	}else{
	    frm.usermail.value = frm.txEmail1.value + frm.txEmail2.value;
	}

	if (jsChkBlank(frm.txCell2.value) || jsChkBlank(frm.txCell3.value)){
	    alert("휴대전화 번호를 입력해주세요");
		frm.txCell2.focus();
		return ;
	}

	if (!jsChkNumber(frm.txCell2.value) || !jsChkNumber(frm.txCell3.value)){
	    alert("휴대전화 번호는 공백없는 숫자로 입력해주세요.");
		frm.txCell2.focus();
		return ;
	}

	if($("#smsRstMsg").html() != "인증이 완료되었습니다."){
	    alert("휴대폰 인증이 완료되지 않았습니다.\n인증을 완료해주세요.");
		frm.crtfyNo.focus();
		return ;
	}

	var ret = confirm('텐바이텐 회원에 가입하시겠습니까?');
	if(ret){
		frm.submit();
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
			<div class="memPage">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/member/tit_join.gif" alt="회원가입" /></h2>
				<p class="tPad10 bPad20"><img src="http://fiximage.10x10.co.kr/web2013/member/txt_join.gif" alt="디자인 감성채널 텐바이텐에 오신 것을 환영합니다." /></p>
				<ol class="joinStep">
					<li><img src="http://fiximage.10x10.co.kr/web2015/member/txt_join_step01_off.gif" alt="01.약관동의" /></li>
					<li><img src="http://fiximage.10x10.co.kr/web2015/member/txt_join_step02_on.gif" alt="02.정보입력" /></li>
					<li><img src="http://fiximage.10x10.co.kr/web2015/member/txt_join_step03_off.gif" alt="03.가입완료" /></li>
				</ol>

				<div class="box2 tBdr1 infoWrite">
				<form name="myinfoForm" method="post" action="<%=SSLUrl%>/member/dojoin_step2.asp" onsubmit="return false;">
				<input type="hidden" name="pflag" value="<%=pFlag%>">
				<input type="hidden" name="hideventid" value="<%= ihideventid %>">
				<input type="hidden" name="usermail" value="">
				<input type="hidden" name="chkFlag" value="N">
					<h3 class="bPad20"><img src="http://fiximage.10x10.co.kr/web2013/member/stit_info.gif" alt="개인정보입력" /></h3>
					<fieldset>
						<legend>개인정보입력</legend>
						<div class="tblView">
							<table>
								<caption>개인정보입력</caption>
								<colgroup>
									<col style="width:20%;" /><col />
								</colgroup>
								<tr>
									<th><label for="memId">회원아이디</label></th>
									<td><input type="text" name="txuserid" id="memId" title="아이디 입력" class="txtInp offInput" style="width:150px;ime-mode:disabled;" maxlength="16" onKeyDown="keyCodeCheckID(event,this);" onKeyUp="jsChkID();" onClick="jsChkID();" onBlur="isToLowerCase(this,0); DuplicateIDCheck(this);" />
										<span onclick="isToLowerCase(document.myinfoForm.txuserid,0); DuplicateIDCheck(document.myinfoForm.txuserid); return false;" class="btn btnS1 btnGry2">중복확인</span> <span id="checkMsgID" class="cr6aa7cc lPad10">공백없는 3~15자의 영문/숫자를 조합하여 입력해야 합니다.</span></td>
								</tr>
								<tr>
									<th><label for="memPw">비밀번호</label></th>
									<td><input type="password" name="txpass1" id="memPw" title="비밀번호 입력" maxlength="16" class="txtInp offInput" style="width:150px;" /> <span class="cr6aa7cc lPad10">공백없는 8~16자의 영문/숫자를 조합하여 입력해야합니다.</span></td>
								</tr>
								<tr>
									<th><label for="memPw2">비밀번호 확인</label></th>
									<td><input type="password" name="txpass2" id="memPw2" title="비밀번호 한번 더 입력"  maxlength="16" class="txtInp offInput" style="width:150px;" /> <span class="cr6aa7cc lPad10">비밀번호 확인을 위해 다시 한번 입력해주세요.</span></td>
								</tr>
								<tr>
									<th><label for="memName">성명</label></th>
									<td><input type="text" name="txName" id="memName" class="txtInp focusOn" style="width:150px;" /> <span class="cr6aa7cc lPad10">한글 15자, 영문 30자까지 가능합니다.</span></td>
								</tr>
								<tr>
									<th>성별</th>
									<td>
										<input type="radio" name="txSex" value="M" id="memMale" class="radio" /> <label for="memMale">남</label>
										<input type="radio" name="txSex" value="F" id="memFemale" class="radio lMar10" /> <label for="memMale">여</label>
									</td>
								</tr>
								<tr>
									<th><label for="memBirth">생년월일</label></th>
									<td>
										<select name="txBirthday1" id="memBirth" class="select focusOn" title="태어난 년도 선택" style="width:60px;">
										<%
										Dim yyyy,mm,dd
											For yyyy = year(now())-100 to year(now())-14
										%>
											<option value="<%=yyyy%>" <%=chkIIF(yyyy=year(now())-14,"selected","")%>><%=yyyy%></option>
										<% Next %>
										</select>
										년
										<select name="txBirthday2" class="select lMar10 focusOn" title="태어난 월 선택" style="width:60px;">
										<% For mm = 1 to 12 %>
											<% If mm < 10 Then mm = Format00(2,mm) End If %>
											<option value="<%=mm%>"><%=mm%></option>
										<% Next %>
										</select>
										월
										<select name="txBirthday3" class="select lMar10 focusOn" title="태어난 일 선택" style="width:60px;">
										<% For dd = 1 to 31%>
											<% If dd < 10 Then dd =Format00(2,dd) End If %>
											<option value="<%=dd%>"><%=dd%></option>
										<% Next%>
										</select>
										일
										<span class="lPad15">
											<input type="radio" name="txSolar" value="Y" id="solar" class="radio" checked="checked" /> <label for="solar">양력</label>
											<input type="radio" name="txSolar" value="M" id="lunar" class="radio lMar10" /> <label for="lunar">음력</label>
										</span>
										<p class="cr6aa7cc tPad05">등록된 생일에 생일 축하 쿠폰을 선물로 드립니다. ( 생일축하쿠폰은 연1회 발급됩니다.)</p>
									</td>
								</tr>
								<tr>
									<td colspan="2" class="tPad30 cr555"><strong>본인인증을 위해 정확한 이메일 주소, 휴대폰 번호를 입력해주세요.</strong><br /><span class="cr888">(입력된 이메일 주소, 휴대폰 번호는 아이디 찾기, 비밀번호 재발급시 이용됩니다.)</span></td>
								</tr>
								<tr>
									<th><label for="memMail">이메일</label></th>
									<td>
										<input type="text" name="txEmail1" id="memMail" maxlength="32" title="이메일 아이디 입력" onKeyDown="keyCodeCheckEmail(event);" onKeyUp="jsChkEmail();" onClick="jsChkEmail();" class="txtInp focusOn" style="width:120px;ime-mode:disabled;" />
										@ 
										<input type="text" name="selfemail" id="selfemail" title="이메일 직접 입력" maxlength="80" class="txtInp" style="display:none;width:120px;ime-mode:disabled;" onKeyDown="keyCodeCheckEmail(event);" onKeyUp="jsChkEmail();" onClick="jsChkEmail();" />
										<select name="txEmail2" title="이메일 서비스 선택" class="select offInput" onchange="NewEmailChecker()">
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
										<span class="btn btnS1 btnGry2" onclick="DuplicateEmailCheck()">중복확인</span>
										<span id="checkMsgEmail" class="cr6aa7cc lPad10"></span>
									</td>
								</tr>
								<tr>
									<th><label for="memPhone">휴대폰</label></th>
									<td>
										<p>
											<select name="txCell1" id="memPhone" title="휴대전화번호 국번을 선택해 주세요" class="select focusOn" style="width:60px;">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
											</select>
											-
											<input type="text" name="txCell2" id="txCell2" title="휴대전화 가운데자리 입력" class="txtInp focusOn" style="width:65px;" maxlength="4" onkeyup="TnTabNumber('txCell2','txCell3',4);" />
											-
											<input type="text" name="txCell3" id="txCell3" title="휴대전화 뒷자리 입력" maxlength="4" class="txtInp focusOn" style="width:65px;" />
											<span id="smsButtonn1" class="btn btnS1 btnGry2" onclick="sendSMS()">인증</span>
											<span id="sendSMSnumber" class="cr6aa7cc lPad10"></span>
										</p>
										<p class="tMar05">
											<input type="text" name="crtfyNo" id="certNum" maxlength="6" title="인증번호 6자리 입력" value="인증번호 6자리를 입력해주세요" class="txtInp focusOn" style="width:234px;" />
											<span id="smsButtonn2" class="btn btnS1 btnGry2" onclick="fnConfirmSMS()">확인</span>
											<span id="smsRstMsg" class="cr6aa7cc lPad10"></span>
										</p>
									</td>
								</tr>
								<tr>
									<th>이메일/SMS 수신여부</th>
									<td>
										<ul class="sendInfo">
											<li>
												<span class="ftLt cr888" style="width:275px;">- 텐바이텐의 다양한 정보를 받아보시겠습니까?</span>
												<dl>
													<dt>이메일</dt>
													<dd>
														<input type="radio" name="email_10x10" value="Y" class="radio" id="tenMailY" checked="checked" />
														<label for="tenMailY"><span class="rMar05">예</span></label> 
														<input type="radio" name="email_10x10" value="N" class="radio" id="tenMailN" />
														<label for="tenMailN"><span>아니오</span></label>
													</dd>
												</dl>
												<span class="ftLt lPad15">|</span>
												<dl>
													<dt>SMS</dt>
													<dd>
														<input type="radio" name="smsok" value="Y" class="radio" id="tenSmsY" checked="checked" />
														<label for="tenSmsY"><span class="rMar05">예</span></label> 
														<input type="radio" name="smsok" value="N" class="radio" id="tenSmsN" />
														<label for="tenSmsN"><span>아니오</span></label>
													</dd>
												</dl>
											</li>
											<li>
												<span class="ftLt cr888" style="width:275px;">- 더핑거스의 다양한 정보를 받아보시겠습니까?</span>
												<dl>
													<dt>이메일</dt>
													<dd>
														<input type="radio" name="email_way2way" value="Y" class="radio" id="fingersMailY" checked="checked" />
														<label for="fingersMailY"><span class="rMar05">예</span></label> 
														<input type="radio" name="email_way2way" value="N" class="radio" id="fingersMailN" />
														<label for="fingersMailN"><span>아니오</span></label>
													</dd>
												</dl>
												<span class="ftLt lPad15">|</span>
												<dl>
													<dt>SMS</dt>
													<dd>
														<input type="radio" name="smsok_fingers" value="Y" class="radio" id="fingersSmsY" checked="checked" />
														<label for="fingersSmsY"><span class="rMar05">예</span></label> 
														<input type="radio" name="smsok_fingers" value="N" class="radio" id="fingersSmsN">
														<label for="fingersSmsN">아니오</label>
													</dd>
												</dl>
											</li>
										</ul>
										<p class="cr6aa7cc">텐바이텐, 더핑거스 이메일/SMS 수신 동의를 하시면 다양한 할인혜택과 이벤트/신상품 등의 정보를 빠르게 만나실 수 있습니다. <br /><strong>단, 주문 및 배송관련 정보는 수신동의와 상관없이 자동 발송됩니다.</strong></p>
									</td>
								</tr>
							</table>
						</div>
					</fieldset>
				</form>
				</div>

				<p class="btnArea ct tMar40">
					<span class="btn btnM1 btnRed btnW130" onclick="FnJoin10x10()">입력완료</span>
					<a href="/member/join.asp" class="btn btnM1 btnGry2 btnW130">뒤로</a>
				</p>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->