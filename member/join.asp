<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	Description : 회원가입 Step1
'	History	:  2013.02.06 허진원 : 신규 회원가입 로직 생성
'              2013.07.29 허진원 : 2013리뉴얼
'              2017.05.19 유태욱 : 2017리뉴얼+sns회원가입
'			   2020.12.16 정태훈 : 테스트 원복
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/incForceSSL.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 회원가입 STEP.01"		'페이지 타이틀 (필수)

	'## 로그인 여부 확인
	if (IsUserLoginOK) then
		''Call Alert_Return("이미 회원가입이 되어있습니다.") 
		'Call Alert_move("이미 회원가입이 되어있습니다.","/")  ''2015/04/09 변경. 한글 얼럿관련
		response.redirect "/"
	    response.end
		dbget.close(): response.End
	end if

	'==============================================================================
	'외부 URL 체크
	dim backurl
	backurl = request.ServerVariables("HTTP_REFERER")
	If application("Svr_Info")<>"Dev" Then
	if InStr(LCase(backurl),"10x10.co.kr") < 1 then 
	    if (Len(backurl)>0) then
	        response.redirect backurl
	        response.end
	    else
'	        response.write "<script>alert('유효한 접근이 아닙니다.');history.back();</script>"
'	        response.end
	    end if
	end if
	end if

	'####### POINT1010 에서 넘어온건지 체크 #######
	Dim pFlag
	pFlag	= requestCheckVar(request("pflag"),1)

	'// Biz 회원가입 여부(SNS회원가입에서는 비활성화)
	Dim isBiz : isBiz = ChkIIF(request("biz")="Y" and snsid ="" and snsusermail="" and snsgubun="","Y","N")

	'// 유입경로
	Dim ihideventid
	ihideventid = session("hideventid")
	If ihideventid="" Then
		ihideventid = request.cookies("rdsite")
	End If
	
	dim snsid, tenbytenid, snsusermail, tmpsnsusermail, snsusermailid, snsusermaildomain, snsisusing, snsgubun, tokenval, snsusername, sns_sexflag, kakaoterms, code, state, acc_token_val
	snsid	= requestCheckVar(request("snsid"),64)
	tenbytenid	= requestCheckVar(request("tenbytenid"),32)
	snsusermail	= requestCheckVar(request("usermail"),128)
	snsisusing	= requestCheckVar(request("snsisusing"),1)
	snsgubun	= requestCheckVar(request("snsgubun"),2)
	snsusername	= requestCheckVar(request("snsusername"),16)
	sns_sexflag	= requestCheckVar(request("sexflag"),10)
	tokenval	= request("tokenval")
	kakaoterms 	= requestCheckVar(request("kakaoterms"),2400)	
	code 	= requestCheckVar(request("code"),2400)
	state 	= requestCheckVar(request("state"),10)

	if snsusermail <> "" Then
		tmpsnsusermail = Split(snsusermail,"@")
		if isArray(tmpsnsusermail) then
			snsusermailid = tmpsnsusermail(0)
			snsusermaildomain = tmpsnsusermail(1)
		end if
	end if

	Dim strBackPath, strGetData, strPostData
	strBackPath = ReplaceRequestSpecialChar(request("backpath"))
	strGetData  = ReplaceRequestSpecialChar(request("strGD"))
	strPostData = ReplaceRequestSpecialChar(request("strPD"))

	'// refferer가 없으면 생성
	if strBackPath="" and request.ServerVariables("HTTP_REFERER")<>"" then
   		strBackPath 	= replace(request.ServerVariables("HTTP_REFERER"),wwwUrl,"")
   		strBackPath 	= replace(strBackPath,replace(wwwUrl,"www.",""),"")
   		strBackPath 	= replace(strBackPath,SSLUrl,"")
   		strBackPath 	= replace(strBackPath,replace(SSLUrl,"www.",""),"")
	end if
	
%>
<!-- #include virtual="/lib/inc/head_ssl.asp" -->
<script type="text/javascript" src="/lib/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script language="javascript" SRC="/lib/js/confirm.js"></script>
<script type="text/javascript">
$(function() {
	$('.flexFormV17 .txtInp').each(function() {
		var defaultVal = this.value;
		$(this).focus(function() {
			if(this.value == defaultVal){
				$(this).prev("label").addClass("hide");
			}
		});
		$(this).blur(function(){
			if(this.value == ''){
				$(this).prev("label").removeClass("hide");
			}
		});
	});

	<% if snsid ="" and snsusermail="" and snsgubun="" then %>
		//var maskHeight = $(document).height();
		//var maskWidth = $(document).width();
		//$('#mask').css({'width':maskWidth,'height':maskHeight});
		//$('#boxes').show();
		//$('#mask').show();
		//$('#mask').click(function(){
		//	$(".joinLayerV17").hide();
		//});
	<% end if %>

	$("#memId").focus();

	<%' amplitude 이벤트 로깅 %>
		tagScriptSend('', 'signupstep1', '', 'amplitude');
	<%'// amplitude 이벤트 로깅 %>
	<%'카카오톡 약관 동의를 통해 들어온 회원은 하단 약관 전체 체크를 해준다. %>
	<% If Trim(kakaoterms)<>"" Then %>
		$("#policyY").prop("checked",true);
		$("#agreeUse,#agreePrivate,#agreePrivate2,#agreeUseAdult,#tenMailY").attr("checked",$("#policyY").is(":checked"));
	<% End If %>	
});

function fnJoinLayerClose(){
	$(".joinLayerV17").hide();
	$('#mask').hide();
}
$(function(){
	$("input[type='checkbox']:not('#agreeUseAdult')").click(function(){
		if($(this).attr("id")=="policyY"){
			$("#agreeUse,#agreePrivate,#agreePrivate2,#agreeUseAdult,#tenMailY").attr("checked",$(this).is(":checked"));
		} else {
			$("#policyY").attr("checked",$("#agreeUse").is(":checked")&&$("#agreePrivate").is(":checked")&&$("#agreePrivate2").is(":checked")&&$("#agreeUseAdult").is(":checked")&&$("#tenMailY").is(":checked"));
		}
	});
});

var chkID = false, chkAjaxID = false;
var chkEmail = false, chkAjaxEmail = false;

//아이디 중복확인
function DuplicateIDCheck(comp){
	var id;
	id = comp.value;

	if (id == ''){
		return;
	}else if((id.length<3) || (id.length>16)){
//		alert('아이디는 공백없는 3~15자의 영문/숫자 조합입니다.');
//		comp.focus();
		$("#checkMsgID").html("<font class='crRed'>3~15자의 영문/숫자 조합으로 입력</font>");
		chkID = false;
	}else{
		var rstStr = $.ajax({
			type: "POST",
			url: "ajaxIdCheck.asp",
			data: "id="+id,
			dataType: "text",
			async: false
		}).responseText;

		if (rstStr == "ERR"){
			$("#checkMsgID").removeClass("useY");
			$("#checkMsgID").addClass("useN");
			$("#checkMsgID").html("오류가 발생했습니다.");
			chkID = false;
//			document.myinfoForm.txuserid.focus();
		}else if (rstStr == "3"){
			$("#checkMsgID").removeClass("useY");
			$("#checkMsgID").addClass("useN");
			$("#checkMsgID").html("특수문자나 한글/한문은 사용불가능합니다.");
			chkID = false;
//			document.myinfoForm.txuserid.focus();
		}else if(rstStr == "2"){
			$("#checkMsgID").removeClass("useY");
			$("#checkMsgID").addClass("useN");
			$("#checkMsgID").html("사용하실 수 없는 아이디입니다.");
			chkID = false;
//			document.myinfoForm.txuserid.focus();
		}else{
			$("#checkMsgID").removeClass("useN");
			$("#checkMsgID").addClass("useY");			
			$("#checkMsgID").html("사용하실 수 있습니다.");
			chkID = true;
		}
		chkAjaxID = true;
	}
}

function jsChkID(){
	if(chkID){
		$("#checkMsgID").removeClass("useY");
		$("#checkMsgID").addClass("useN");	
		$("#checkMsgID").html("3~15자의 영문/숫자를 조합하여 입력");
		chkID = false;
	}
}

function jsChkEmail(){
	var email, frm = document.myinfoForm;
	chkEmail=true;

	if( frm.txEmail2.value == "etc"){
	    email = frm.txEmail1.value + '@' + frm.selfemail.value;
	}else{
	    email = frm.txEmail1.value + frm.txEmail2.value;
	}

	if (email == ''){
		return;
	}else if (!check_form_email(email)){
		$("#checkMsgEmail").removeClass("useY");
		$("#checkMsgEmail").addClass("useN");
		$("#checkMsgEmail").html("잘못된 이메일 입니다.");
		chkEmail = false;
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
			$("#checkMsgEmail").removeClass("useY");
			$("#checkMsgEmail").addClass("useN");
			$("#checkMsgEmail").html("오류가 발생했습니다.");
			chkEmail = false;
		}else if (rstStr == "3"){
			$("#checkMsgEmail").removeClass("useY");
			$("#checkMsgEmail").addClass("useN");
			$("#checkMsgEmail").html("잘못된 이메일 입니다.");
			chkEmail = false;
		}else if(rstStr == "2"){
			$("#checkMsgEmail").removeClass("useY");
			$("#checkMsgEmail").addClass("useN");
			$("#checkMsgEmail").html("이미 가입된 이메일 입니다.");
			chkEmail = false;
		}else{
			$("#checkMsgEmail").removeClass("useN");
			$("#checkMsgEmail").addClass("useY");
			$("#checkMsgEmail").html("사용하실 수 있습니다.");
			chkEmail = true;
		}
		chkAjaxEmail = true;
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
		$("#checkMsgEmail").removeClass("useY");
		$("#checkMsgEmail").addClass("useN");
		$("#checkMsgEmail").html("이메일 앞부분을 입력해주세요.");
		chkEmail = false;
	}
	if (frm.txEmail1.value.indexOf('@')>-1){
		$("#checkMsgEmail").removeClass("useY");
		$("#checkMsgEmail").addClass("useN");
		$("#checkMsgEmail").html("@를 제외한 앞부분만 입력해주세요.");
		chkEmail = false;
	}

	if (frm.txEmail2.value == ""){
		$("#checkMsgEmail").removeClass("useY");
		$("#checkMsgEmail").addClass("useN");
		$("#checkMsgEmail").html("이메일 도메인을 선택해주시거나 직접 입력해주세요");
		chkEmail = false;
	}

	if ((frm.txEmail2.value == "etc")&&(frm.selfemail.value.length<1)){
		$("#checkMsgEmail").removeClass("useY");
		$("#checkMsgEmail").addClass("useN");
		$("#checkMsgEmail").html("이메일 도메인을 선택해주시거나 직접 입력해주세요");
		chkEmail = false;
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

//	if (jsChkBlank(frm.txCell1.value)){
//	    alert("휴대전화 번호를 입력해주세요");
//		frm.txCell1.focus();
//		return ;
//	}
//	if (!jsChkNumber(frm.txCell1.value)){
//	    alert("휴대전화 번호는 공백없는 숫자로 입력해주세요.");
//		frm.txCell1.focus();
//		return ;
//	}
	
	if (jsChkBlank(frm.txCell1.value) || jsChkBlank(frm.txCell2.value) || jsChkBlank(frm.txCell3.value)){
	    alert("휴대전화 번호를 입력해주세요");
		frm.txCell1.focus();
		return ;
	}

	if (!jsChkNumber(frm.txCell1.value) || !jsChkNumber(frm.txCell2.value) || !jsChkNumber(frm.txCell3.value)){
	    alert("휴대전화 번호는 공백없는 숫자로 입력해주세요.");
		frm.txCell1.focus();
		return ;
	}
	
	var usrph = frm.txCell1.value + "-" + frm.txCell2.value + "-" + frm.txCell3.value;

//	var usrph = frm.txCell1.value + "-" + frm.txCell2.value + "-" + frm.txCell3.value;
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
	_gaq.push(['_trackPageview', '/member/ajaxSendConfirmSMS2015.asp']);
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
		$("#smsRstMsg").removeClass("useN");
		$("#smsRstMsg").addClass("useY");
		$("#smsRstMsg").html("인증이 완료되었습니다.");
		$("#certNum").attr("readonly", true);
		$("#txCell1").attr("readonly", true);
		$("#txCell2").attr("readonly", true);
		$("#txCell3").attr("readonly", true);
		$("#smsButtonn1").hide();
		$("#smsButtonn2").hide();
		$("#sendSMSnumber").hide();
	}else if (rstStr == "2"){
		$("#smsRstMsg").removeClass("useY");
		$("#smsRstMsg").addClass("useN");
		$("#smsRstMsg").html("잘못된 인증번호 입니다.");
	}else{
		$("#smsRstMsg").removeClass("useY");
		$("#smsRstMsg").addClass("useN");
		$("#smsRstMsg").html("인증번호를 입력해주세요.");
		alert("처리중 오류가 발생했습니다."+rstStr);
	}
}

function FnJoin10x10(){
	var frm = document.myinfoForm;
	var isBiz = document.getElementById('isBiz').value;

	if( isBiz === 'Y' ) {
		// 사업자 번호 확인
		if( frm.socno.value.trim() === '' ) {
			alert('정확한 사업자 등록번호를 입력해주세요.');
			frm.socno.focus();
			return;
		}

		if( !checkSocnum(frm.socno.value) ) {
			alert('정확한 사업자 등록번호를 입력해주세요.');
			frm.socno.focus();
			return;
		}

		if( frm.socname.value.trim() === '' ) {
			alert('사업자명을 입력해주세요.');
			frm.socname.focus();
			return;
		}
	}

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
		$("#pwdCheckResult12").removeClass("useY");
		$("#pwdCheckResult12").addClass("useN");
		$("#pwdCheckResult12").html("비밀번호를 입력하세요");
		frm.txpass1.focus();
		return ;
	}

	if (frm.txpass1.value.length < 8 || frm.txpass1.value.length > 16){
		$("#pwdCheckResult12").removeClass("useY");
		$("#pwdCheckResult12").addClass("useN");
		$("#pwdCheckResult12").html("비밀번호는 공백없이 8~16자입니다.");
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

	if(frm.txpass1.value.indexOf("'") > 0){
        alert("비밀번호는 특수문자(')를 포함 하실 수 없습니다.");
        frm.txpass1.focus();
        return;
    }

	//if (frm.txName.value == ""){
	//	alert("성명을 입력하세요");
	//	frm.txName.focus();
	//	return ;
	//}


//	if (!frm.txSex[0].checked&&!frm.txSex[1].checked){
//		alert("성별을 선택 해주세요");
//		frm.txSex[0].focus();
//		return ;
//	}

//	if(!chkEmail){
//		alert("이메일을 확인해주세요.");
//		frm.txEmail1.focus();
//		return;
//	}
	//if (frm.txEmail1.value == ""){
	//	alert("이메일 앞부분을 입력해주세요");
	//	frm.txEmail1.focus();
	//	return ;
	//}


	if (jsChkBlank(frm.txCell1.value) || jsChkBlank(frm.txCell2.value) || jsChkBlank(frm.txCell3.value)){
	    alert("휴대전화 번호를 입력해주세요");
		frm.txCell1.focus();
		return ;
	}

	if (!jsChkNumber(frm.txCell1.value) || !jsChkNumber(frm.txCell2.value) || !jsChkNumber(frm.txCell3.value)){
	    alert("휴대전화 번호는 공백없는 숫자로 입력해주세요.");
		frm.txCell1.focus();
		return ;
	}

	if($("#smsRstMsg").html() != "인증이 완료되었습니다."){
	    alert("휴대폰 인증이 완료되지 않았습니다.\n인증을 완료해주세요.");
		frm.crtfyNo.focus();
		return ;
	}

	if (frm.txName.value != ""){
		if (GetByteLength(frm.txName.value) > 30){
			alert("성명은 한글 15자, 영문 30자 이내 입니다.");
			frm.txName.focus();
			return ;
		}
	}

	if (frm.txEmail1.value != ""){
		if (frm.txEmail1.value.indexOf('@')>-1){
			alert("@를 제외한 앞부분만 입력해주세요...");
			frm.txEmail1.focus();
			return ;
		}
		if (frm.txEmail2.value == ""){
			alert("이메일 도메인을 선택해주시거나 직접 입력해주세요.");
			frm.txEmail2.focus();
			return ;
		}
		if ((frm.txEmail2.value == "etc")&&(frm.selfemail.value.length<1)){
			alert("이메일 도메인을 선택해주시거나 직접 입력해주세요.");
			frm.selfemail.focus();
			return ;
		}
		if( frm.txEmail2.value == "etc"){
			frm.usermail.value = frm.txEmail1.value + '@' + frm.selfemail.value;
		}else{
			frm.usermail.value = frm.txEmail1.value + frm.txEmail2.value;
		}
	}


	if(!$("#agreeUse").is(":checked")) {
		alert("이용약관에 동의 해주세요.");
		$("#agreeUse").focus();
		return;
	}
	if(!$("#agreePrivate").is(":checked")) {
		alert("개인정보를 위한 이용자 동의사항에 동의 해주세요.");
		$("#agreePrivate").focus();
		return;
	}
	if(!$("#agreeUseAdult").is(":checked")) {
		alert("본인이 만14세 이상임을 확인 후 체크해주세요.");
		$("#agreeUseAdult").focus();
		return;
	}

	var emailchk = $("#tenMailY").is(":checked");
	var smschk = $("#tenSmsY").is(":checked");
    if(emailchk){
    	$("#tenMailY").val('Y');
    }else{
    	$("#tenMailY").val('N');  	
    }
    if(smschk){
    	$("#tenSmsY").val('Y');
    }else{
    	$("#tenSmsY").val('N');  	
    }

	var txBirthday1 = $("#txBirthday1 option:selected").val();
	var txBirthday2 = $("#txBirthday2 option:selected").val();
	var txBirthday3 = $("#txBirthday3 option:selected").val();
	if(txBirthday1=='0' || txBirthday2=='0' || txBirthday3=='0'){
		$("#txBirthday1 option:selected").val('1900');
		$("#txBirthday2 option:selected").val('1');
		$("#txBirthday3 option:selected").val('1');
	}

//	if(!chkEmail){
//		alert("이메일을 확인해주세요.");
//		frm.txEmail1.focus();
//		return;
//	}
	var ret='';
	if( isBiz === 'Y' ){
		ret= confirm('회원가입 신청 후 최대 24시간 내 가입 승인이 이루어지며 승인 후 모든 서비스를 이용하실 수 있습니다.');
	}else{
		ret = confirm('텐바이텐 회원에 가입하시겠습니까?');
	}
	
	if(ret){
		if( isBiz === 'Y' )
			frm.action = '/biz/dojoin.asp';
		frm.submit();
	}
}

function chkMemPwd(){                                                                                                                                                                                                                                                                                                                                                                                                   
	var frm = document.myinfoForm;
	obj_pwdChk1 = document.getElementById("pwdCheckResult12");
	if(frm.txpass2.value !=null && frm.txpass2.value!= "" && frm.txpass2.value != "비밀번호 확인"){
		if(frm.txpass1.value != frm.txpass2.value){
			$("#pwdCheckResult12").removeClass("useY");
			$("#pwdCheckResult12").addClass("useN");
			$("#pwdCheckResult12").html("일치하지 않습니다.");
		}else{
			if (frm.txpass1.value.length < 8 || frm.txpass1.value.length > 16){
				$("#pwdCheckResult12").removeClass("useY");
				$("#pwdCheckResult12").addClass("useN");
				$("#pwdCheckResult12").html("비밀번호는 공백없이 8~16자입니다.");
				return ;
			}else{
				$("#pwdCheckResult12").removeClass("useN");
				$("#pwdCheckResult12").addClass("useY");
				$("#memPwtxt").html("");
				$("#pwdCheckResult12").html("사용하실 수 있습니다.");
			}
		}
	}
	if(frm.txpass2.value ==null || frm.txpass2.value== "" || frm.txpass2.value == "비밀번호 확인"){
		$("#pwdCheckResult12").hide();
	}
}


function inputLengthCheck(eventInput){
	var inputText = $(eventInput).val();
	var inputMaxLength = $(eventInput).prop("maxlength");
	var j = 0;
	var count = 0;
	for(var i = 0;i < inputText.length;i++) { 
		val = escape(inputText.charAt(i)).length; 
		if(val == 6){
			j++;
		}
		j++;
		if(j <= inputMaxLength){
			count++;
		}
	}
	if(j > inputMaxLength){
		$("#nameCheckResult").removeClass("useY");
		$("#nameCheckResult").addClass("useN");
		$("#nameCheckResult").html("한글 15자, 영문 30자까지 가능합니다.");
		$(eventInput).val(inputText.substr(0, count));
	}else{
		$("#nameCheckResult").html("");
	}
}

function fnPopSNSLogin(snsgb,wd,hi) {
	var snsbackpath = '<%=strBackPath%>';
	var popWidth  = wd;
	var popHeight = hi;
	var snspopHeight
	if (snsgb=="nv"){
		snspopHeight = "4"
	}else if (snsgb=="fb" || snsgb=="gl"){
		snspopHeight = "0.5"
	}else if (snsgb=="ka"){
		snspopHeight = "1"
	}
	var winWidth  = document.body.clientWidth;
	var winHeight = document.body.clientHeight;
	var winX      = window.screenX || window.screenLeft || 0;
	var winY      = window.screenY || window.screenTop || 0;
	var popupX = (winX + (winWidth - popWidth) / 2)- (wd / 4);
	var popupY = (winY + (winHeight - popHeight) / 2)- (hi / snspopHeight);
	var popup = window.open("<%=SSLUrl%>/login/mainsnslogin.asp?snsdiv="+snsgb+"&pggb=id&snsjoingubun=ji&snsbackpath="+snsbackpath,"","width="+wd+", height="+hi+", left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY);
}

function fnPopTenSNSLogin(snsgb,wd,hi) {
	var popWidth  = wd;
	var popHeight = hi;
	var snspopHeight
	if (snsgb=="nv"){
		snspopHeight = "4"
	}else if (snsgb=="fb" || snsgb=="gl"){
		snspopHeight = "0.5"
	}else if (snsgb=="ka"){
		snspopHeight = "1"
	}
	var winWidth  = document.body.clientWidth;
	var winHeight = document.body.clientHeight;
	var winX      = window.screenX || window.screenLeft || 0;
	var winY      = window.screenY || window.screenTop || 0;
	var popupX = (winX + (winWidth - popWidth) / 2)- (wd / 4);
	var popupY = (winY + (winHeight - popHeight) / 2)- (hi / snspopHeight);
	var popup = window.open("","tenSNSPopup","width="+wd+", height="+hi+", left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY);
	$('#snsForm').attr('target',"tenSNSPopup");
	$('#snsForm').submit();   
}

// 사업자번호 check
function checkSocnum(number){
	var numberMap = number.replace(/-/gi, '').split('').map(function (d){
		return parseInt(d, 10);
	});
	
	if(numberMap.length == 10){
		var keyArr = [1, 3, 7, 1, 3, 7, 1, 3, 5];
		var chk = 0;
		
		for( let i=0 ; i<keyArr.length ; i++ ) {
			chk += keyArr[i] * numberMap[i];
		}
		
		chk += parseInt((keyArr[8] * numberMap[8])/ 10, 10);
		return Math.floor(numberMap[9]) === ( (10 - (chk % 10) ) % 10);
	}
	
	return false;
}
</script>
</head>
<body>
<div class="wrap signupV17">
	<!-- #include virtual="/lib/inc/incHeader_ssl.asp" -->
	<div class="container">
		<div id="contentWrap" class="tenBiz">
			<div class="signTap">  
				<div id="tenJoinBtn" class="signTen <%=ChkIIF(isBiz="Y","","on")%>">
					<div class="signTit">
						<h3>텐바이텐 회원가입</h3>
						<p>쿠폰/마일리지 등 다양한 혜택이<br/>
						가득한 텐바이텐 계정 만들기</p>
					</div>
				</div>
				<div id="bizJoinBtn" class="signBiz <%=ChkIIF(isBiz="Y","on","")%>">
					<div class="signTit">
						<h3>BIZ 회원가입</h3>
						<p>텐바이텐 BIZ를 이용할 수 있는<br/>
							사업자 계정 만들기</p>
					</div>
				</div>
			</div>
			<form name="myinfoForm" method="post" action="<%=SSLUrl%>/member/dojoin_step2.asp" onsubmit="return false;">
			<input type="hidden" id="isBiz" value="<%=isBiz%>">
			<input type="hidden" name="pflag" value="<%=pFlag%>">
			<input type="hidden" name="hideventid" value="<%= ihideventid %>">
			<input type="hidden" name="usermail" value="">
			<input type="hidden" name="chkFlag" value="N">
			<input type="hidden" name="snsgubun" value="<%= snsgubun %>">
			<input type="hidden" name="snsid" value="<%= snsid %>">
			<input type="hidden" name="tokenval" value="<%= tokenval %>">
			<input type="hidden" name="email_way2way" value="N">
			<input type="hidden" name="smsok_fingers" value="N">
			<input type="hidden" name="sns_sexflag" value="<%= sns_sexflag %>">
			<input type="hidden" name="kakaoterms" value="<%=kakaoterms%>">
			<% if (snsid ="" and snsusermail="" and snsgubun="") then %>
			<!-- <h2><img src="/fiximage/web2017/member/tit_signup.png" alt="SIGN UP" /></h2>
			<p class="tPad10"><img src="/fiximage/web2017/member/txt_welcome.png" alt="생활 감성채널 텐바이텐에 오신 것을 환영합니다." /></p> -->
			<% else %>
            <div class="joinHeader tMar50">
                <h2>SNS 계정으로 로그인 <span>마지막 단계</span></h2>
                <p class="sub">텐바이텐만의 즐거운 쇼핑 안내를 위해 간단한 추가 정보를 입력해주세요 :)</p>
            </div>
			<a href="" onclick="fnPopTenSNSLogin('<%=snsgubun%>','530','645'); return false;" class="btn-connect-id" target="_blank">
                <img src="http://fiximage.10x10.co.kr/web2020/common/btn_already_memeber.png?v=1.01" alt="이미 텐바이텐 계정이 있다면?">
            </a>
			<% end if %>
			<div class="formBoxV17 tMar25">
				<!-- 필수항목 -->
				<div class="group type1">					
					<fieldset>
						<legend>회원가입 필수항목 입력</legend>
						
						<div id="socno" class="flexFormV17 bizForm" <%= ChkIIF(isBiz="Y", "", "style=""display:none;""") %>>
                            <div class="biz-num">
								<label for="socnoInput">사업자 등록번호</label><input type="text" id="socnoInput" name="socno" class="txtInp" />
								<p class="numNoti">입력된 사업자 정보는 가입 시 정보확인 용도로만 사용됩니다.<br/>해당 사업자에 전달되거나 별도로 조회되지 않으니 안심하고 입력해주세요 :)</p>
							</div>
                            <div>
                                <label for="socname">사업자명</label><input type="text" id="socname" name="socname" class="txtInp" />
                            </div>
                        </div>

						<div class="flexFormV17 tMar0">
							<div>
								<label for="memId"><%=chkIIF(snsusermailid="","아이디","")%></label><input type="text" name="txuserid" id="memId" value="<%= snsusermailid %>" class="txtInp" style="ime-mode:disabled;" maxlength="16" onKeyDown="keyCodeCheckID(event,this);" onKeyUp="jsChkID();" onClick="jsChkID();" onBlur="isToLowerCase(this,0); DuplicateIDCheck(this);" />
								<p class="msg" id="checkMsgID">3~15자의 영문/숫자를 조합하여 입력</p>
							</div>
						</div>
					<%
                        ''간편로그인수정;허진원 2018.04.24
                        'SNS 로그인 경유 회원가입이 아니면 비밀번호 받음(2018.04.12; 허진원)
                        if (snsid ="" and snsusermail="" and snsgubun="") then
                    %>
                        <div class="flexFormV17">
							<div>
								<label for="memPw">비밀번호</label><input type="password" name="txpass1" id="memPw" class="txtInp" maxlength="16" />
								<p class="msg" id="memPwtxt">8-16자의 영문/숫자를 조합하여 입력</p>
							</div>
						</div>
						<div class="flexFormV17">
							<div>
								<label for="memPw2">비밀번호 확인</label><input type="password" name="txpass2" id="memPw2" class="txtInp" value="" maxlength="16" style="ime-mode:disabled;" onBlur="javascript:chkMemPwd();" />
								<p class="msg" id="pwdCheckResult12"></p>
							</div>
						</div>
                    <%
                        'SNS로그인 경유일때 임의 비밀번호 설정
                        else
                            dim rndPwd
                            Randomize()
                            rndPwd = left(md5(cLng(Rnd*800000)+10000000),16)
                    %>
                        <input type="hidden" name="txpass1" value="<%=rndPwd%>" />
                        <input type="hidden" name="txpass2" value="<%=rndPwd%>" />
                    <% end if %>
						<!-- 2021.07.12 법적준거성 추가
						<div class="flexFormV17">
							<table>
								<thead>
									<tr>
										<th>수집 목적</th>
										<th>수집 항목</th>
										<th>보유 및 이용기간</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>쿠폰/혜택/이벤트 알림</td>
										<td>이메일 주소</td>
										<td>회원 탈퇴 및 서비스 이용 거부시까지</td>
									</tr>
								</tbody>
							</table>
							<p style="line-height:1.4;margin-bottom:30px"><span style="color:#acacac;">개인정보 수집 및 이용에 동의하지 않을 권리가 있으며, 동의를 거부할 경우 이벤트 및 혜택 서비스를 제공받을 수 없습니다.
							</span></p>
						</div>
						2021.07.12 법적준거성 추가 -->
						<div class="flexFormV17">
							<div>
								<label for="memPhone">휴대폰</label>
								<input type="text" name="txCell1" id="memPhone" class="txtInp" maxlength="3" />
							</div>
							<div class="ct fs14 fb cGy2V15" style="width:48px;">-</div>
							<div>
								<input type="text" name="txCell2" class="txtInp" maxlength="4" />
							</div>
							<div class="ct fs14 fb cGy2V15" style="width:48px;">-</div>
							<div>
								<input type="text" name="txCell3" class="txtInp" maxlength="4" />
							</div>
							<div class="lPad10" style="width:140px;" id="smsButtonn1"><a href="#" onclick="sendSMS(); return false;" class="btn btnB1 btnGry2">인증번호 발송</a></div>
						</div>
						<div class="flexFormV17 static">
							<p class="rt fs11" id="sendSMSnumber"></p>
						</div>
						<div class="flexFormV17">
							<div>
								<label for="certNum">카카오톡이나 SMS로 발송된 인증번호 6자리를 입력하세요</label><input type="text" name="crtfyNo" id="certNum" class="txtInp" maxlength="6" value="" />
								<p class="msg useN" id="smsRstMsg"></p>
							</div>
							<div class="lPad10" style="width:140px;" id="smsButtonn2"><a href="#" onclick="fnConfirmSMS(); return false;" class="btn btnB1 btnGry2">확인</a></div>
						</div>
						<!-- 2021.07.12 법적준거성 추가
						<div class="flexFormV17">
							<table>
								<thead>
									<tr>
										<th>수집 목적</th>
										<th>수집 항목</th>
										<th>보유 및 이용기간</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>쿠폰/혜택/이벤트 알림</td>
										<td>휴대폰 주소</td>
										<td>회원 탈퇴 및 서비스 이용 거부시까지</td>
									</tr>
								</tbody>
							</table>
							<p style="line-height:1.4;margin-bottom:30px"><span style="color:#acacac;">개인정보 수집 및 이용에 동의하지 않을 권리가 있으며, 동의를 거부할 경우 이벤트 및 혜택 서비스를 제공받을 수 없습니다.
							</span></p>
						</div>
						2021.07.12 법적준거성 추가 -->
					</fieldset>
				</div>
				<!--// 필수항목 -->

				<!-- 선택항목 -->
				<div id="selectArea" class="group type2" <%= ChkIIF(isBiz="Y", "style=""display:none;""", "") %>>
					<h3><img src="/fiximage/web2017/member/stit_choice.png" alt="선택항목" /></h3>
					<fieldset>
						<legend>회원가입 선택항목 입력</legend>
						<div class="flexFormV17">
							<div>
								<label for="memName"><% if snsusername = "" then %>성명<% end if %></label><input type="text" name="txName" id="memName" maxlength="30" value="<%= snsusername %>" onblur="inputLengthCheck(this);" class="txtInp" />
								<p class="msg" id="nameCheckResult">한글 15자, 영문 30자까지 가능합니다.</p>
							</div>
						</div>
						<div class="flexFormV17">
							<div><label for="memMail"><%=chkIIF(snsusermailid="","이메일","")%></label><input type="text" name="txEmail1" id="memMail" value="<%= snsusermailid %>" title="이메일 아이디 입력" class="txtInp" maxlength="32" onKeyDown="keyCodeCheckEmail(event);" onKeyUp="jsChkEmail();" onClick="jsChkEmail();" style="ime-mode:disabled;" onBlur="javascript:DuplicateEmailCheck();" /></div>
							<div class="ct fs14 fb cGy2V15" style="width:48px;">@</div>
							<div class="rPad10"><input type="text" title="이메일 직접 입력" class="txtInp" name="selfemail" id="selfemail" maxlength="80" style="display:none;ime-mode:disabled;" onKeyDown="keyCodeCheckEmail(event);" onKeyUp="jsChkEmail();" onClick="jsChkEmail();" /></div>
							<div>
								<select name="txEmail2" title="이메일 서비스 선택" class="select" onchange="NewEmailChecker();">
									<option value=""  <%=chkIIF(snsusermaildomain="","selected","")%>>선택해 주세요</option>
									<option value="@naver.com" <%=chkIIF(snsusermaildomain="naver.com","selected","")%>>naver.com</option>
									<option value="@gmail.com" <%=chkIIF(snsusermaildomain="gmail.com","selected","")%>>gmail.com</option>
									<option value="@daum.net" <%=chkIIF(snsusermaildomain="daum.net","selected","")%>>daum.net</option>
									<option value="@hanmail.net" <%=chkIIF(snsusermaildomain="hanmail.net","selected","")%>>hanmail.net</option>
									<option value="@nate.com" <%=chkIIF(snsusermaildomain="nate.com","selected","")%>>nate.com</option>
									<option value="@kakao.com" <%=chkIIF(snsusermaildomain="kakao.com","selected","")%>>kakao.com</option>
									<option value="@icloud.com" <%=chkIIF(snsusermaildomain="icloud.com","selected","")%>>icloud.com</option>
									<option value="etc">직접입력</option>
								</select>
							</div>
						</div>
						<div class="flexFormV17 static">
							<div>
								<p class="msg useN" style="line-height:1.4;" id="checkMsgEmail"></p>
							</div>
						</div>
						<div class="flexFormV17 tMar0">
							<div class="fb cGy2V15" style="width:70px;">생년월일</div>
							<div>
								<select name="txBirthday1" id="txBirthday1" class="select" title="태어난 년도 선택">
									<option value="0" selected="selected">년도 선택</option>
								<%
								Dim yyyy,mm,dd
									For yyyy = year(now())-100 to year(now())-14
								%>
									<option value="<%=yyyy%>"><%=yyyy%></option>
								<% Next %>
								</select>
							</div>
							<div class="lPad10">
								<select name="txBirthday2" id="txBirthday2" class="select" title="태어난 월 선택">
									<option value="0" selected="selected">월 선택</option>
								<% For mm = 1 to 12 %>
									<% If mm < 10 Then mm = Format00(2,mm) End If %>
									<option value="<%=mm%>"><%=mm%></option>
								<% Next %>
								</select>
							</div>
							<div class="lPad10">
								<select name="txBirthday3" id="txBirthday3" class="select" title="태어난 일 선택">
									<option value="0" selected="selected">일 선택</option>
								<% For dd = 1 to 31 %>
									<% If dd < 10 Then dd =Format00(2,dd) End If %>
									<option value="<%=dd%>"><%= dd %></option>
								<% Next %>
								</select>
							</div>
						</div>
						<div class="flexFormV17 static">
							<p class="rt fs11">등록된 생일에 생일 축하 쿠폰을 선물로 드립니다.</p>
						</div>
						<div class="flexFormV17 static">
							<div class="fb cGy2V15" style="width:70px;">성별</div>
							<div>
								<input type="radio" name="txSex" value="M" id="memMale" class="radio" /> <label for="memMale" class="fs12 cGy1V15">남자</label>
								<input type="radio" name="txSex" value="F" id="memFemale" class="radio lMar20" /> <label for="memFemale" class="fs12 cGy1V15">여자</label>
							</div>
						</div>
						<!-- 2021.07.12 법적준거성 추가
						<div class="flexFormV17">
							<table>
								<thead>
									<tr>
										<th style="width:40%;">수집 목적</th>
										<th style="width:30%;">수집 항목</th>
										<th style="width:30%;">보유 및 이용기간</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>회원 식별 및 회원 서비스 제공</td>
										<td>ID, 비밀번호, 가입 인증정보</td>
										<td>회원 탈퇴시까지</td>
									</tr>
									<tr>
										<td>본인 의사 확인 및 불만 처리와 같은 고객과의 의사소통 경로 확보</td>
										<td>휴대폰 번호, 이름</td>
										<td>회원 탈퇴시까지</td>
									</tr>
									<tr>
										<td>고지사항 전달</td>
										<td>이메일 주소</td>
										<td>회원 탈퇴시까지</td>
									</tr>
								</tbody>
							</table>
							<p style="line-height:1.4;margin-bottom:30px"><span style="color:#acacac;">귀하는 텐바이텐 서비스 이용에 필요한 최소한의 개인정보 수집 및 이용에 동의하지 않을 수 있으나, 동의를 거부할 경우 회원제 서비스 이용이 불가합니다.</span></p>
						</div>
						2021.07.12 법적준거성 추가 -->
					</fieldset>
				</div>
				<!--// 선택항목 -->

				<!-- 약관동의 -->
				<div class="group type3">
					<p class="fs12"><input type="checkbox" class="check" id="policyY" /> <label for="policyY"><strong>모두 동의합니다</strong></label></p>
					<ul>
						<li><input type="checkbox" class="check" id="agreeUseAdult" name="agreeUseAdult" value="o" /> <label for="agreeUseAdult">본인은 만 14세 이상입니다.</label></li>
						<li><input type="checkbox" class="check" id="agreeUse" name="agreeUse" value="o" /> <label for="agreeUse">이용약관에 동의합니다.</label> <a href="/common/join.asp" target="_blank" class="btn">내용보기</a></li>
						<li><input type="checkbox" class="check" id="agreePrivate" name="agreePrivate" /> <label for="agreePrivate">[필수] 개인정보 수집 및 이용에 동의합니다</label> <a href="/common/private2.asp" target="_blank" class="btn">내용보기</a></li>
						<li><input type="checkbox" class="check" id="agreePrivate2" name="agreePrivate2" /> <label for="agreePrivate2">[선택] 개인정보 수집 및 이용에 동의합니다</label> <a href="/common/private3.asp" target="_blank" class="btn">내용보기</a><span style="padding-left:17px;color:#888"></span></li>
						<li><input type="checkbox" name="email_10x10" value="Y" class="check vMid" id="tenMailY" /> <label for="tenMailY">[선택] 쿠폰이 발급되거나 혜택이 생기면 알림받기</label><span id="reqEmailMsg" class="color-red" style="padding-left:17px;<%= ChkIIF(isBiz="Y", "display:none;", "") %>"><br>알림을 받으면 매달 추첨을 통해 10,000p를 선물로 드려요 !</span></li>
					</ul>
				</div>
				<!--// 약관동의 -->
				<div class="btnGroupV17 ct tMar50">
					<a href="#" class="btn btnB1 btnRed" onclick="FnJoin10x10(); return false;" style="width:190px;">회원가입 신청하기</a>
				</div>
			</div>
		</form>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter_ssl.asp" -->
</div>
<% if snsid ="" and snsusermail="" and snsgubun="" then %>
	<div class="joinLayerV17" style="display:none">
		<div class="group">
			<h2>텐바이텐 회원가입</h2>
			<p>텐바이텐 멤버십 회원가입을 합니다.</p>
			<a href="" onclick="fnAmplitudeEventMultiPropertiesAction('click_signup','action','normal'); fnJoinLayerClose(); tagScriptSend('', 'signuptenbyten', '', 'amplitude'); return false;" class="btn btnB1 btnRed">회원가입</a>
		</div>
		<div class="group">
			<h2>다음 계정으로 회원가입</h2>
			<p>SNS 계정으로 간편하게 텐바이텐에 가입합니다.</p>
			<ul class="btnSocialV17">
				<li><a href="" onclick="fnAmplitudeEventMultiPropertiesAction('click_signup','action','naver');fnPopSNSLogin('nv','400','800');tagScriptSend('', 'signupnaver', '', 'amplitude');return false;" class="icon naver">네이버</a></li>
				<li><a href="" onclick="fnAmplitudeEventMultiPropertiesAction('click_signup','action','kakao');fnPopSNSLogin('ka','470','570');tagScriptSend('', 'signupkakao', '', 'amplitude');return false;" class="icon kakao">카카오톡</a></li>
				<li><a href="" onclick="fnAmplitudeEventMultiPropertiesAction('click_signup','action','facebook');fnPopSNSLogin('fb','410','300');tagScriptSend('', 'signupfacebook', '', 'amplitude');return false;" class="icon facebook">페이스북</a></li>
				<li><a href="" onclick="fnAmplitudeEventMultiPropertiesAction('click_signup','action','google');fnPopSNSLogin('gl','410','420');tagScriptSend('', 'signupgoogle', '', 'amplitude');return false;" class="icon google">구글</a></li>
			</ul>
		</div>
		<button type="button" onclick="fnJoinLayerClose();" class="btnClose">닫기</button>
	</div>
<% else %>
	<script>
		DuplicateIDCheck(document.myinfoForm.txuserid);
		//jsChkEmail();
	</script>
	<form name="snsForm" id="snsForm" method="post" action="/login/snslogin.asp">
	<input type="hidden" name="code" value="<%= code %>">
	<input type="hidden" name="state" value="<%= state %>">
	<input type="hidden" name="tokenval" value="<%= tokenval %>">
	<input type="hidden" name="snstoten" value="Y">
	</form>
<% end if %>

<% '// SNS 회원가입에선 Biz회원가입 비활성화
	If (snsid ="" and snsusermail="" and snsgubun="") then %>
<script>
	// 회원가입 유형 변경(일반 <-> Biz)
	const tenJoinBtn = document.getElementById('tenJoinBtn');
	const bizJoinBtn = document.getElementById('bizJoinBtn');
	tenJoinBtn.addEventListener('click', changeJoinType);
	bizJoinBtn.addEventListener('click', changeJoinType);

	function changeJoinType(e) {
		
		const type = e.currentTarget.id === 'tenJoinBtn' ? 'ten' : 'biz';

		// 일반
		if( type === 'ten' ) {

			tenJoinBtn.classList.add('on');
			bizJoinBtn.classList.remove('on');
			document.getElementById('isBiz').value = 'N';

			document.getElementById('socno').style.display = 'none'; // 사업자번호 숨김
			document.getElementById('selectArea').style.display = 'block'; // 선택항목 영역 노출
			document.getElementById('reqEmailMsg').style.display = ''; // 이메일 쿠폰 알림 안내 노출

		// Biz
		} else {

			tenJoinBtn.classList.remove('on');
			bizJoinBtn.classList.add('on');
			document.getElementById('isBiz').value = 'Y';

			document.getElementById('socno').style.display = 'table'; // 사업자번호 노출
			document.getElementById('selectArea').style.display = 'none'; // 선택항목 영역 숨김
			document.getElementById('reqEmailMsg').style.display = 'none'; // 이메일 쿠폰 알림 안내 숨김

		}
	}

	const socnoInput = document.getElementById('socnoInput');
	socnoInput.addEventListener('focus', function(e) {
		e.target.value = e.target.value.replace(/-/gi, '');
	});
	socnoInput.addEventListener('blur', function(e) {
		e.target.value = socnoFormatter(e.target.value);
	});

	// 사업자 번호 format
	function socnoFormatter(num) {
		var formatNum = num;
		try{
			formatNum = num.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3');
		} catch(e) {
			formatNum = num;
		}
		return formatNum;
	}
</script>
<% End If %>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->