<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
dim userid, userpass
userid = getEncLoginUserID
userpass = requestCheckVar(request.Form("userpass"),32)


	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 개인정보수정"		'페이지 타이틀 (필수)
'####### POINT1010 에서 넘어온건지 체크 #######
Dim pFlag, vParam
pFlag	= requestCheckVar(request("pflag"),1)
If pFlag = "o" Then
vParam	= "?pflag=o"
End If
If pFlag = "g" Then
	Response.Redirect "/offshop/point/point_search.asp"
	Response.End
End If
'####### POINT1010 에서 넘어온건지 체크 #######


''개인정보보호를 위해 패스워드로 한번더 Check
dim sqlStr, checkedPass, userdiv
dim Enc_userpass, Enc_userpass64
checkedPass = false

dim EcChk : EcChk = TenDec(request.Cookies("tinfo")("EcChk"))

if (LCase(Session("InfoConfirmFlag"))<>LCase(userid)) or (LCase(EcChk)<>LCase(userid)) then
    ''패스워드없이 쿠키로만 들어온경우
    if (userpass="") then
        response.redirect SSLUrl&"/my10x10/userinfo/confirmuser.asp" & vParam
        response.end
    end if

    Enc_userpass = MD5(CStr(userpass))
    Enc_userpass64 = SHA256(MD5(CStr(userpass)))

    ''비암호화
    ''sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and userpass='" & userpass & "'"

    ''암호화 사용
    ''sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and Enc_userpass='" & Enc_userpass & "'"

    ''암호화 사용(SHA256) ''2018/07/02 
    sqlStr = "select userid, IsNULL(userdiv,'02') as userdiv from [db_user].[dbo].tbl_logindata where userid='" & userid & "' and Enc_userpass64='" & Enc_userpass64 & "'"
    
    rsget.Open sqlStr, dbget, 1
    if Not rsget.Eof then
        checkedPass = true
        userdiv = rsget("userdiv")
    end if
    rsget.close

    ''패스워드올바르지 않음
    if (Not checkedPass) then
        response.redirect wwwUrl & SSLUrl&"/my10x10/userinfo/confirmuser.asp?errcode=1" & Replace(vParam,"?","&") & ""
        response.end
    end if

    ''업체인경우 Biz 회원정보 수정페이지로 이동
    if (userdiv="02") or (userdiv="03") or (userdiv="09") then
        response.redirect SSLUrl & "/biz/membermodify.asp" & vParam & ""
        response.end
    end if
end if

'// 세션 체크 후에는 세션 삭제(새로고침 하면 다시 confirmuser 페이지로 이동함)
Session("InfoConfirmFlag") = ""

'// 세션이 유지되어 있고 쿠키가 있어도 confirm을 통해서 넘어오지 않았다면 다시 confirm 페이지로 넘긴다.
If InStr(lcase(request.ServerVariables("HTTP_REFERER")),"10x10.co.kr")<1 Then
	response.redirect SSLUrl&"/my10x10/userinfo/confirmuser.asp" & vParam
	response.end
End If

dim myUserInfo, chkKakao
chkKakao = false
set myUserInfo = new CUserInfo
myUserInfo.FRectUserID = userid
if (userid<>"") then
    myUserInfo.GetUserData
    chkKakao = myUserInfo.chkKakaoAuthUser	'// 카카오톡 인증여부
end if

dim oAllowsite
dim IsAcademyUsing
IsAcademyUsing = false  ''Default True

set oAllowsite = new CUserInfo
oAllowsite.FRectUserID = userid
oAllowsite.FRectSitegubun = "academy"
if (userid<>"") then
    oAllowsite.GetOneAllowSite

    if (oAllowsite.FOneItem.Fsiteusing="N") then IsAcademyUsing=false
end if

set oAllowsite = Nothing

Dim arrEmail, E1, E2
IF myUserInfo.FOneItem.FUsermail  <> "" THEN
	arrEmail = split(myUserInfo.FOneItem.FUsermail,"@")
	if ubound(arrEmail)>0 then
		E1	= arrEmail(0)
		E2	= arrEmail(1)
	end if
END IF

if (myUserInfo.FResultCount<1) then
    response.write "<script>alert('정보를 가져올 수 없습니다.');</script>"
    response.end
end if

if (myUserInfo.FOneItem.Fuserphone = "") or IsNull(myUserInfo.FOneItem.Fuserphone) then
	myUserInfo.FOneItem.Fuserphone = "--"
end if

''간편로그인수정;허진원 2018.04.24
'SNS회원 여부
dim isSNSMember: isSNSMember = false
if GetLoginUserDiv="05" then
	isSNSMember = true
end if

'네비바 내용 작성
'strMidNav = "MY 개인정보 > <b>개인정보 수정</b>"
%>
<script type="text/javascript" SRC="/lib/js/confirm.js"></script>
<script type="text/javascript">
$(document).unbind("dblclick");
function ModiImage(){
	window.open("<%=SSLUrl%>/my10x10/lib/modiuserimage.asp","myimageedit",'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=330,height=377');
}

function ChangeMyPass(frm){
	if (frm.oldpass.value.length<1){
		alert('기존 패스워드를 입력하세요.');
		frm.oldpass.focus();
		return;
	}

	if (jsChkBlank(frm.newpass1.value)){
		alert('새로운 패스워드를 입력하세요.');
		frm.newpass1.focus();
		return;
	}

	if (frm.newpass1.value.length<8){
		alert('새로운 패스워드는 8자 이상으로 입력하세요.');
		frm.newpass1.focus();
		return;
	}

	if (frm.newpass1.value=='<%=userid%>'){
		alert('아이디와 동일한 패스워드는 사용하실 수 없습니다.');
		frm.newpass1.focus();
		return;
	}

	if (!fnChkComplexPassword(frm.newpass1.value)) {
		alert('새로운 패스워드는 영문/숫자 등 두가지 이상의 조합으로 입력하세요.');
		frm.newpass1.focus();
		return;
	}

	if (frm.newpass1.value!=frm.newpass2.value){
		alert('새로운 패스워드가 일치하지 않습니다.');
		frm.newpass1.focus();
		return;
	}

    if(frm.newpass1.value.indexOf("'") > 0){
        alert("새로운 비밀번호는 특수문자(')를 포함 하실 수 없습니다.");
        frm.newpass1.focus();
        return;
    }

	var ret = confirm('패스워드를 수정하시겠습니까?');

	if(ret){
		frm.submit();
	}
}


function ChangeMyInfo(frm){
	if (frm.username.value.length<2){
		alert('이름을 입력해 주세요.');
		frm.username.focus();
		return;
	}

	/*
	if (frm.txZip1.value.length<3){
		alert('우편번호를 입력해 주세요.');
		frm.txZip1.focus();
		return;
	}

	if (frm.txAddr2.value.length<1){
		alert('나머지 주소를 입력해 주세요.');
		frm.txAddr2.focus();
		return;
	}
	*/
	if (GetByteLength(frm.txAddr2.value)>80){
		alert('나머지 주소가 너무 깁니다. 80byte이내로 작성해주세요.\n※한글 1글자는 2byte입니다.');
		frm.txAddr2.focus();
		return;
	}

	var sEm = chkEmailForm(frm)
	if(!sEm) {
		return;
	} else {
		frm.usermail.value = sEm;
	}

	var sHp = chkPhoneForm(frm)
	if(!sHp) {
		return;
	} else {

	}

<% ''간편로그인수정;허진원 2018.04.24 - 생일입력검사 스크립트 제거%>

	if (frm.isEmailChk.value=="N"&&(frm.isMobileChk.value=="N"||frm.orgUsercell.value!=sHp)) {
		if (frm.orgUsercell.value != sHp) {
			alert('휴대전화 번호를 수정중이십니다.\n\n이메일 또는 휴대전화 중 하나는 반드시 인증을 받으셔야 합니다.\n(비밀번호 분실시 본인인증에 사용됩니다.)');
		} else {
			alert('이메일 또는 휴대전화 중 하나는 반드시 인증을 받으셔야 합니다.\n(비밀번호 분실시 본인인증에 사용됩니다.)');
		}

		return;
	}

	<%
		''간편로그인수정;허진원 2018.04.24
		if Not(isSNSMember) then
	%>
	if (frm.oldpass.value.length < 1){
		alert('정보를 변경 하시려면 기존 비밀번호를 입력해주세요.');
		frm.oldpass.focus();
		return;
	}
	<% end if %>

    <% if (IsAcademyUsing) then %>
    if (frm.allow_other[1].checked){
        alert('핑거스 아케데미 서비스를 이용하지않음 으로 설정하실 경우 \n핑거스 아카데미 로그인 및 관련 서비스를 이용하실 수 없습니다.');
    }
    <% end if %>

	var ret = confirm('정보를 수정 하시겠습니까?');
	if (ret){
	frm.submit();
	}
}

function checkSiteComp(comp){
    var frm = comp.form;

    if (comp.value=="Y"){
        frm.email_way2way[0].disabled = false;
        frm.email_way2way[1].disabled = false;

        frm.smsok_fingers[0].disabled = false;
        frm.smsok_fingers[1].disabled = false;
    }else{
        frm.email_way2way[1].checked = true;
        frm.email_way2way[0].disabled = true;
        frm.email_way2way[1].disabled = true;

        frm.smsok_fingers[1].checked = true;
        frm.smsok_fingers[0].disabled = true;
        frm.smsok_fingers[1].disabled = true;
    }
}

function disableEmail(frm, comp){
	if (comp.checked){
		frm.email_way2way.checked = false;
		frm.email_10x10.checked = false;
		frm.emailok.value="N";
	}else{
		frm.email_way2way.checked = true;
		frm.email_10x10.checked = true;
		frm.emailok.value="Y";
	}
}


function TnTabNumber(thisform,target,num) {
   if (eval("document.frminfo." + thisform + ".value.length") == num) {
	  eval("document.frminfo." + target + ".focus()");
   }
}

function NewEmailChecker(){
  var frm = document.frminfo;
  if( frm.txEmail2.value == "etc")  {
    frm.selfemail.style.display = '';
    frm.selfemail.focus();
  }else{
    frm.selfemail.style.display = 'none';
  }
  return;
}

// 카카오톡 인증
function popKakaoAuth() {
	<% if Not(chkKakao) then %>
	var kakaopop = window.open("/apps/kakaotalk/step1.asp","popKakao","width=460,height=470");
	<% else %>
	var kakaopop = window.open("/apps/kakaotalk/clear.asp","popKakao","width=460,height=430");
	<% end if %>
	kakaopop.focus();
}

// 본인인증 이메일 발송
function sendCnfEmail(frm) {
	var sEm = chkEmailForm(frm)
	if(!sEm) return;

	if(sEm==frm.orgUsermail.value&&frm.isEmailChk.value=="Y") {
		alert("'"+sEm+"'(은)는 이미 인증이 완료된 이메일입니다.");
		return;
	}

	if(confirm("입력하신 이메일 '"+sEm+"'(으)로 인증을 받으시겠습니까?\n\n※인증메일에서 링크를 클릭하시면 인증이 완료되며 이메일정보가 수정됩니다.")) {
		var rstStr = $.ajax({
			type: "POST",
			url: "ajaxSendModifyEmail.asp",
			data: "id=<%=userid%>&mail="+sEm,
			dataType: "text",
			async: false
		}).responseText;

		$("#popResult").empty();
		$("#popResult").html(rstStr);
	}
}

// 본인인증 휴대폰SMS 발송
function sendCnfSMS(frm) {
	var sHp = chkPhoneForm(frm)
	if(!sHp) return;

	if(sHp==frm.orgUsercell.value&&frm.isMobileChk.value=="Y") {
		alert("'"+sHp+"'(은)는 이미 인증이 완료된 휴대폰입니다.");
		return;
	}

	if(confirm("입력하신 휴대폰 '"+sHp+"'(으)로 인증을 받으시겠습니까?\n\n※전송된 인증번호를 입력창에 넣으시면 인증이 완료되며 휴대폰정보가 수정됩니다.")) {
		var rstStr = $.ajax({
			type: "POST",
			url: "ajaxSendModifySMS.asp",
			data: "id=<%=userid%>&phone="+sHp,
			dataType: "text",
			async: false
		}).responseText;

		$("#popResult").empty();
		$("#popResult").html(rstStr);
	}
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

	if (jsChkBlank(frm.usercell2.value)||frm.usercell2.value.length<3){
	    alert("휴대전화 번호를 입력해주세요");
		frm.usercell2.focus();
		return ;
	}

	if (jsChkBlank(frm.usercell3.value)||frm.usercell3.value.length<4){
	    alert("휴대전화 번호를 입력해주세요");
		frm.usercell3.focus();
		return ;
	}

	if (!jsChkNumber(frm.usercell2.value) || !jsChkNumber(frm.usercell3.value)){
	    alert("휴대전화 번호는 공백없는 숫자로 입력해주세요.");
		frm.usercell2.focus();
		return ;
	}

	phone = frm.usercell1.value+"-"+frm.usercell2.value+"-"+frm.usercell3.value
	return phone;
}

// 인증값 변경 확인
function chkChangeAuth(frm,dv) {
	switch(dv) {
		case "E" :
			if(frm.isEmailChk.value=="Y") {
				var email;
				if( frm.txEmail2.value == "etc"){
				    email = frm.txEmail1.value + '@' + frm.selfemail.value;
				}else{
				    email = frm.txEmail1.value + frm.txEmail2.value;
				}

				if(frm.orgUsermail.value!=email) {
					$("#lyrMailAuthMsg").attr("class","cr777");
					$("#lyrMailAuthMsg").html("상태 : 인증대기");
				} else {
					$("#lyrMailAuthMsg").attr("class","crRed");
					$("#lyrMailAuthMsg").html("상태 : 인증완료");
				}
			}
			break;
		case "P" :
			if(frm.isMobileChk.value=="Y") {
				var cellphone;
				cellphone = frm.usercell1.value+"-"+frm.usercell2.value+"-"+frm.usercell3.value;
				if(frm.orgUsercell.value!=cellphone) {
					$("#lyrPhoneAuthMsg").attr("class","cr777");
					$("#lyrPhoneAuthMsg").html("상태 : 인증대기");
				} else {
					$("#lyrPhoneAuthMsg").attr("class","crRed");
					$("#lyrPhoneAuthMsg").html("상태 : 인증완료");
				}
			}
			break;
	}
}

function fnPopSNSLogin(snsgb,wd,hi) {
	var popWidth  = wd;
	var popHeight = hi;
	var snspopHeight
	if (snsgb=="nv"){
		snspopHeight = "4"
	}else if (snsgb=="fb" || snsgb=="gl"){
		snspopHeight = "0.2"
	}else if (snsgb=="ka"){
		snspopHeight = "1"
	}
	var winWidth  = document.body.clientWidth;
	var winHeight = document.body.clientHeight;
	var winX      = window.screenX || window.screenLeft || 0;
	var winY      = window.screenY || window.screenTop || 0;
	var popupX = (winX + (winWidth - popWidth) / 2)- (wd / 4);
	var popupY = (winY + (winHeight - popHeight) / 2)- (hi / snspopHeight);
	var popup = window.open("/login/mainsnslogin.asp?snsdiv="+snsgb+"&pggb=my","","width="+wd+", height="+hi+", left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY);
}

function fnSNSdisconnect(snsgb) {
	$.ajax({
		type: "POST",
		url:"/login/snsloginprocess.asp",
		data: "mode=disc&snsgubun="+snsgb,
		dataType: "json",
		async: false,
       	success: function (responseText, statusText) {
//			resultObj = JSON.parse(responseText);
			if(responseText.response=="Disc") {
				alert("계정 연결 해제가 완료되었습니다");
				window.location.reload(true);
			}else if(responseText.response=="fail") {
				alert(responseText.faildesc);

			}else{
				alert("처리중 오류가 발생했습니다.\n" + responseText);
			}
		},
		//ajax error
		error: function(err){
			alert("ERR: " + err.responseText);
		}
	});
}


</script>
</head>
<body>
<div id="my10x10WrapV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container my10x10Wrap <%= GetMyTenTenBgColor() %>">
		<div id="contentWrap">
		<!-- #include virtual="/lib/inc/incMytentenHeader.asp" -->
			<div class="my10x10">
				<!-- #include virtual="/lib/inc/incMytentenLnb.asp" -->
				<!-- content -->
				<div class="myContent">
					<div class="titleSection">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_my_info_modify.gif" alt="개인정보 수정" /></h3>
						<ul class="list">
							<li>고객님의 주소와 연락처 등 개인정보를 수정하실 수 있습니다.</li>
							<li>휴대전화번호와 이메일은 한번 더 확인하시어, 주문하신 상품에 대한 배송 안내와 다양한 이벤트정보를 제공해 드리는 SMS, 메일서비스 혜택을 받으시기 바랍니다.</li>
						</ul>
					</div>

					<div class="mySection">
						<!-- 나의 정보관리 -->
						<h4>나의 정보관리</h4>
						<fieldset>
						<form name="frminfo" method="post" action="<%=SSLUrl%>/my10x10/userinfo/membermodify_process.asp" style="margin:0px;">
						<input type="hidden" name="mode" value="infomodi">
						<input type="hidden" name="pflag" value="<%=pFlag%>">
						<input type="hidden" name="isEmailChk" value="<%=chkIIF(myUserInfo.FOneItem.FisEmailChk="Y","Y","N")%>">
						<input type="hidden" name="isMobileChk" value="<%=chkIIF(myUserInfo.FOneItem.FisMobileChk="Y","Y","N")%>">
						<legend>나의 정보 수정</legend>
							<table class="baseTable rowTable docForm myInfoForm">
							<caption>나의 정보 수정</caption>
							<colgroup>
								<col width="140" /> <col width="" /> <col width="130" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">
									<span class="essential"><img src="http://fiximage.10x10.co.kr/web2013/common/blt_check_red.gif" alt="필수 입력정보" /></span>
									<label for="memName">성명</label>
								</th>
								<td colspan="2"><input type="text" name="username" value="<%= myUserInfo.FOneItem.FUserName %>" id="memName" class="txtInp" maxlength="30" style="width:178px;" /></td>
							</tr>
							<tr>
								<th>
									<% ''간편로그인수정;허진원 2018.04.24 - 필수 아이콘 제거 %>
									<label for="memBirth">생년월일</label>
								</th>
								<td colspan="2">
									<select name="userbirthday1" id="memBirth" class="select focusOn" title="태어난 년도 선택" style="width:65px;">
										<option value="1900">선택</option>
										<%
										Dim yyyy,mm,dd
											For yyyy = year(now())-100 to year(now())-14
										%>
											<option value="<%=yyyy%>" <% If myUserInfo.FOneItem.FBirthDay<>"1900-01-01" and SplitValue(myUserInfo.FOneItem.FBirthDay,"-",0) = format00(4,yyyy) Then response.write "selected" %>><%=yyyy%></option>
										<% Next %>
									</select>
									년
									<select name="userbirthday2" class="select lMar10 focusOn" title="태어난 월 선택" style="width:65px;">
										<option value="1">선택</option>
										<% For mm = 1 to 12 %>
											<% If mm < 10 Then mm = Format00(2,mm) End If %>
											<option value="<%=mm%>" <% If myUserInfo.FOneItem.FBirthDay<>"1900-01-01" and SplitValue(myUserInfo.FOneItem.FBirthDay,"-",1) = format00(2,mm) Then response.write "selected" %>><%=mm%></option>
										<% Next %>
									</select>
									월
									<select name="userbirthday3" class="select lMar10 focusOn" title="태어난 일 선택" style="width:65px;">
										<option value="1">선택</option>
										<% For dd = 1 to 31%>
											<% If dd < 10 Then dd =Format00(2,dd) End If %>
											<option value="<%=dd%>" <% If myUserInfo.FOneItem.FBirthDay<>"1900-01-01" and SplitValue(myUserInfo.FOneItem.FBirthDay,"-",2) = format00(2,dd) Then response.write "selected" %>><%=dd%></option>
										<% Next %>
									</select>
									일
									<span class="lPad15">
										<input type="radio" name="issolar" value="Y" id="solar" class="radio" <% if myUserInfo.FOneItem.Fissolar="Y" then response.write "checked" %> /> <label for="solar">양력</label>
										<input type="radio" name="issolar" value="N" id="lunar" class="radio lMar10" <% if myUserInfo.FOneItem.Fissolar="N" then response.write "checked" %> /> <label for="lunar">음력</label>
									</span>
									<p class="cr6aa7cc tPad13 fs11">등록된 생일에 생일 축하 쿠폰을 선물로 드립니다. ( 생일축하쿠폰은 연1회 발급됩니다.)</p>
								</td>
							</tr>
							<% ''간편로그인수정;허진원 2018.04.24 - 성별 추가 %>
							<tr>
								<th>
									<label>성별</label>
								</th>
								<td colspan="2">
									<span>
										<input type="radio" name="gender" value="1" id="male" class="radio" <% if myUserInfo.FOneItem.Fgender="M" then response.write "checked" %> /> <label for="male">남</label>
										<input type="radio" name="gender" value="2" id="female" class="radio lMar10" <% if myUserInfo.FOneItem.Fgender="F" then response.write "checked" %> /> <label for="female">여</label>
									</span>
								</td>
							</tr>
							<tr>
								<th scope="row">주소</th>
								<td colspan="2">
									<%
'										Dim txZip1, txZip2
'										if Not(isNull(myUserInfo.FOneItem.Fzipcode)) then
'											if ubound(split(myUserInfo.FOneItem.Fzipcode,"-"))>0 then
'												txZip1 = Trim(split(myUserInfo.FOneItem.Fzipcode,"-")(0))
'												txZip2 = Trim(split(myUserInfo.FOneItem.Fzipcode,"-")(1))
'											end if
'										end if
									%>
									<div>
									<%'// 주소관련수정 %>
										<input type="text" name="txZip" value="<%=myUserInfo.FOneItem.Fzipcode%>" readonly title="우편번호" class="txtInp focusOn" style="width:60px;" />

										<a href="javascript:TnFindZipNew('frminfo');" onfocus="this.blur()" class="btn btnS1 btnGry2 rMar05"><span class="fn">우편번호찾기</span></a>
									</div>
									<div class="tPad07">
										<input type="text" name="txAddr1" value="<%= myUserInfo.FOneItem.FAddress1 %>" readonly title="기본주소" class="txtInp focusOn" style="width:390px;" />
									</div>
									<div class="tPad07">
										<input type="text"  name="txAddr2" value="<%= myUserInfo.FOneItem.FAddress2 %>"  maxlength="80" title="상세주소" class="txtInp focusOn" style="width:390px;" />
									</div>
									<p class="cr6aa7cc tPad13 fs11">주소(기본배송시)는 구입하신 상품이나 이벤트 경품 등의 배송시 사용됩니다.</p>
								</td>
							</tr>
							<tr>
								<th scope="row">전화번호</th>
								<td colspan="2">
									<select name="userphone1" title="지역번호 선택" class="select focusOn" style="width:78px;">
										<option value="010" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "010" Then response.write "Selected" %>>010</option>
										<option value="02" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "02" Then response.write "Selected" %>>02</option>
										<option value="051" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "051" Then response.write "Selected" %>>051</option>
										<option value="053" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "053" Then response.write "Selected" %>>053</option>
										<option value="032" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "032" Then response.write "Selected" %>>032</option>
										<option value="062" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "062" Then response.write "Selected" %>>062</option>
										<option value="042" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "042" Then response.write "Selected" %>>042</option>
										<option value="052" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "052" Then response.write "Selected" %>>052</option>
										<option value="044" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "044" Then response.write "Selected" %>>044</option>
										<option value="031" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "031" Then response.write "Selected" %>>031</option>
										<option value="033" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "033" Then response.write "Selected" %>>033</option>
										<option value="043" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "043" Then response.write "Selected" %>>043</option>
										<option value="041" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "041" Then response.write "Selected" %>>041</option>
										<option value="063" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "063" Then response.write "Selected" %>>063</option>
										<option value="061" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "061" Then response.write "Selected" %>>061</option>
										<option value="054" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "054" Then response.write "Selected" %>>054</option>
										<option value="055" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "055" Then response.write "Selected" %>>055</option>
										<option value="064" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "064" Then response.write "Selected" %>>064</option>
										<option value="070" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "070" Then response.write "Selected" %>>070</option>
										<option value="0502" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "0502" Then response.write "Selected" %>>0502</option>
										<option value="0505" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "0505" Then response.write "Selected" %>>0505</option>
										<option value="0506" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "0506" Then response.write "Selected" %>>0506</option>
										<option value="0130" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "0130" Then response.write "Selected" %>>0130</option>
										<option value="0303" <% if SplitValue(myUserInfo.FOneItem.Fuserphone,"-",0) = "0303" Then response.write "Selected" %>>0303</option>
									</select>
									<span class="symbol">-</span>
									<input type="text" name="userphone2"  value="<%= SplitValue(myUserInfo.FOneItem.Fuserphone,"-",1) %>" onkeyup="TnTabNumber('userphone2','userphone3',4);"  maxlength="4" title="전화번호 앞자리 입력" class="txtInp focusOn" style="width:68px;" />
									<span class="symbol">-</span>
									<input type="text" name="userphone3" value="<%= SplitValue(myUserInfo.FOneItem.Fuserphone,"-",2) %>" maxlength="4" title="전화번호 뒷자리 입력" value="1234" class="txtInp focusOn" style="width:68px;" />
								</td>
							</tr>
							<tr>
								<th rowspan="3" scope="row">
									<span class="essential"><img src="http://fiximage.10x10.co.kr/web2013/common/blt_check_red.gif" alt="필수 입력정보" /></span>
									본인인증
								</th>
								<td colspan="2">
									<p><em class="crRed">본인확인을 위해 정확한 휴대폰 번호를 입력해주세요. (입력된 이메일, 휴대폰 번호는 아이디 찾기, 비밀번호 재발급시 이용됩니다)</em></p>
									<p class="cr6aa7cc">이메일, 휴대전화 수정은 [사용자 인증하기]를 통해서만 수정할 수 있습니다.</p>
								</td>
							</tr>
							<tr>
								<td class="lineColor">
									<span class="rPad15 bulletDot">이메일</span>
									<input type="text" name="txEmail1" value="<%=E1%>" onkeyup="chkChangeAuth(this.form,'E');" maxlength="32" title="이메일 아이디 입력" class="txtInp focusOn" style="width:118px;" />
									<input type="hidden" name="orgUsermail" value="<%= myUserInfo.FOneItem.FUsermail %>">
									<input type="hidden" name="usermail" value="<%= myUserInfo.FOneItem.FUsermail %>">
									<span class="symbol">@</span>
									<input type="text" name="selfemail" onkeyup="chkChangeAuth(this.form,'E');" maxlength="80"  value="<%=E2%>" title="이메일 직접 입력" class="txtInp" style="width:118px;" />
									<select name="txEmail2" onchange="NewEmailChecker();chkChangeAuth(this.form,'E');" title="이메일 서비스 선택" class="select offInput emailSelect" style="width:102px;">
										<option value="etc">직접입력</option>
										<option value="@hanmail.net" >hanmail.net</option>
										<option value="@naver.com" >naver.com</option>
										<option value="@hotmail.com" >hotmail.com</option>
										<option value="@yahoo.co.kr" >yahoo.co.kr</option>
										<option value="@hanmir.com" >hanmir.com</option>
										<option value="@paran.com" >paran.com</option>
										<option value="@lycos.co.kr" >lycos.co.kr</option>
										<option value="@nate.com" >nate.com</option>
										<option value="@dreamwiz.com" >dreamwiz.com</option>
										<option value="@korea.com" >korea.com</option>
										<option value="@empal.com" >empal.com</option>
										<option value="@netian.com" >netian.com</option>
										<option value="@freechal.com" >freechal.com</option>
										<option value="@msn.com" >msn.com</option>
										<option value="@gmail.com" >gmail.com</option>
									</select>
								</td>
								<td class="ct">
									<a href="javascript:sendCnfEmail(document.frminfo);" class="btn btnS2 btnRed"><span class="fn">사용자 인증하기</span></a>
									<div class="tPad05 fs11"><strong id="lyrMailAuthMsg" class="<%=chkIIF(myUserInfo.FOneItem.FisEmailChk="Y","crRed","cr777")%>">상태 : <%=chkIIF(myUserInfo.FOneItem.FisEmailChk="Y","인증완료","인증대기")%></strong></div>
								</td>
							</tr>
							<tr>
								<td class="lineColor">
									<span class="rPad05 bulletDot">휴대전화</span>
									<input type="hidden" name="orgUsercell" value="<%= myUserInfo.FOneItem.Fusercell %>">
									<select name="usercell1" title="휴대전화 앞자리 선택" class="select focusOn" style="width:78px;">
										<option value="010" <% if SplitValue(myUserInfo.FOneItem.Fusercell,"-",0) = "010" Then response.write "Selected" %>>010</option>
										<option value="011" <% if SplitValue(myUserInfo.FOneItem.Fusercell,"-",0) = "011" Then response.write "Selected" %>>011</option>
										<option value="016" <% if SplitValue(myUserInfo.FOneItem.Fusercell,"-",0) = "016" Then response.write "Selected" %>>016</option>
										<option value="017" <% if SplitValue(myUserInfo.FOneItem.Fusercell,"-",0) = "017" Then response.write "Selected" %>>017</option>
										<option value="018" <% if SplitValue(myUserInfo.FOneItem.Fusercell,"-",0) = "018" Then response.write "Selected" %>>018</option>
										<option value="019" <% if SplitValue(myUserInfo.FOneItem.Fusercell,"-",0) = "019" Then response.write "Selected" %>>019</option>
									</select>
									<span class="symbol">-</span>
									<input type="text" name="usercell2" value="<%= SplitValue(myUserInfo.FOneItem.Fusercell,"-",1) %>" onkeyup="TnTabNumber('usercell2','usercell3',4);chkChangeAuth(this.form,'P');" maxlength="4" title="휴대전화 가운데자리 입력" class="txtInp focusOn" style="width:68px;" />
									<span class="symbol">-</span>
									<input type="text" name="usercell3" value="<%= SplitValue(myUserInfo.FOneItem.Fusercell,"-",2) %>" onkeyup="chkChangeAuth(this.form,'P');" maxlength="4" title="휴대전화 뒷자리 입력" value="1234" class="txtInp focusOn" style="width:68px;" />
								</td>
								<td class="ct">
									<a href="javascript:sendCnfSMS(document.frminfo);" class="btn btnS2 btnRed"><span class="fn">사용자 인증하기</span></a>
									<div class="tPad05 fs11"><strong id="lyrPhoneAuthMsg" class="<%=chkIIF(myUserInfo.FOneItem.FisMobileChk="Y","crRed","")%>">상태 : <%=chkIIF(myUserInfo.FOneItem.FisMobileChk="Y","인증완료","인증대기")%></strong></div>
								</td>
							</tr>
							<tr>
								<th>
									<span class="essential"><img src="http://fiximage.10x10.co.kr/web2013/common/blt_check_red.gif" alt="필수 입력정보" /></span>
									이메일/SMS<br /> <%=chkIIF(date<="2015-12-31","카카오톡<br />","")%> 수신여부
								</th>
								<td colspan="2">
									<ul class="sendInfo">
										<li>
											<span class="ftLt" style="width:275px;">텐바이텐의 다양한 정보를 받아보시겠습니까?</span>
											<dl>
												<dt>이메일</dt>
												<dd>
													<input type="radio" name="email_10x10" value="Y" <%= ChkIIF(myUserInfo.FOneItem.Femail_10x10="Y","checked","") %> class="radio" id="tenMailY" />
													<label for="tenMailY"><span class="rMar05">예</span></label>
													<input type="radio" name="email_10x10" value="N" <%= ChkIIF(myUserInfo.FOneItem.Femail_10x10="N","checked","") %> class="radio" id="tenMailN" />
													<label for="tenMailN"><span>아니오</span></label>
												</dd>
											</dl>
											<span class="ftLt lPad15">|</span>
											<dl>
												<dt>SMS</dt>
												<dd>
													<input type="radio" name="smsok" value="Y" <%= ChkIIF(myUserInfo.FOneItem.Fsmsok="Y","checked","") %> class="radio" id="tenSmsY" />
													<label for="tenSmsY"><span class="rMar05">예</span></label>
													<input type="radio" name="smsok" value="N" <%= ChkIIF(myUserInfo.FOneItem.Fsmsok="Y","","checked") %> class="radio" id="tenSmsN" />
													<label for="tenSmsN"><span>아니오</span></label>
												</dd>
											</dl>
										</li>
									</ul>
									<p class="tPad13 lMar10 cr6aa7cc lsM1">텐바이텐 이메일/SMS 수신 동의를 하시면 다양한 할인혜택과 이벤트/신상품 등의 정보를 빠르게 만나실 수 있습니다. <br /><strong>단, 주문 및 배송관련 정보는 수신동의와 상관없이 자동 발송됩니다.</strong></p>
								</td>
							</tr>
							<input type="hidden" name="email_way2way" value="N">
							<input type="hidden" name="smsok_fingers" value="N">
							<!-- 2017.10.1 서비스 종료
							<tr>
								<td colspan="2" class="lineColor">
									<ul class="sendInfo">
										<li>
											<span class="ftLt" style="width:275px;">더핑거스의 다양한 정보를 받아보시겠습니까?</span>
											<dl>
												<dt>이메일</dt>
												<dd>
													<input type="radio" name="email_way2way" value="Y" <%= ChkIIF(myUserInfo.FOneItem.Femail_way2way="Y","checked","") %> <%= ChkIIF(IsAcademyUsing,""," disabled") %> class="radio" id="fingersMailY" />
													<label for="fingersMailY"><span class="rMar05">예</span></label>
													<input type="radio" name="email_way2way" value="N" <%= ChkIIF(myUserInfo.FOneItem.Femail_way2way="N","checked","") %> <%= ChkIIF(IsAcademyUsing,""," disabled") %> class="radio" id="fingersMailN" />
													<label for="fingersMailN"><span>아니오</span></label>
												</dd>
											</dl>
											<span class="ftLt lPad15">|</span>
											<dl>
												<dt>SMS</dt>
												<dd>
													<input type="radio" name="smsok_fingers" value="Y" <%= ChkIIF(myUserInfo.FOneItem.Fsmsok_fingers="Y","checked","") %> <%= ChkIIF(IsAcademyUsing,""," disabled") %> class="radio" id="fingersSmsY" />
													<label for="fingersSmsY"><span class="rMar05">예</span></label>
													<input type="radio" name="smsok_fingers" value="N" <%= ChkIIF(myUserInfo.FOneItem.Fsmsok_fingers="N","checked","") %> <%= ChkIIF(IsAcademyUsing,""," disabled") %> class="radio" id="fingersSmsN" />
													<label for="fingersSmsN">아니오</label>
												</dd>
											</dl>
										</li>
									</ul>
									<p class="tPad13 lMar10 cr6aa7cc lsM1">텐바이텐, 더핑거스 이메일/SMS 수신 동의를 하시면 다양한 할인혜택과 이벤트/신상품 등의 정보를 빠르게 만나실 수 있습니다. <br /><strong>단, 주문 및 배송관련 정보는 수신동의와 상관없이 자동 발송됩니다.</strong></p>
								</td>
							</tr>
							-->
							<!--tr>
								<td class="lineColor">
								<% if date<="2015-12-31" then %>
									<
									<p class="bulletDot">카카오톡으로 텐바이텐(10x10.co.kr)의 맞춤정보 서비스를 받아보시겠습니까?<br />
									<span class="cr777">카카오톡 맞춤정보 서비스는 주문 및 배송 관련 메시지 및 다양한 혜택/이벤트에 대한 정보를<br />
									SMS 대신 카카오톡으로 발송 드리는 서비스입니다. 본 서비스는 스마트폰에 카카오톡이 설치되어 있어야<br />
									이용이 가능합니다. 카카오톡이 설치 되어있지 않다면 설치 후 이용해주시기 바랍니다.<br /></span>
									
									<a href="/apps/kakaotalk/kakaotalkinfo.asp" class="linkBtn highlightBlue" target="_blank">카카오톡 맞춤 정보 서비스 안내</a>
									</p>
									
									<p>카카오톡 맞춤정보 서비스는 <em class="crRed">2015년 12월 31일부로 종료</em>됩니다.<br />
										<span class="cr777">카카오톡으로 발송 드렸던 주문 및 배송 관련 메시지는 SMS로 발송 드릴 예정이오니,<br /> 이용에 참고 부탁드립니다.</span></p>
								<% else %>
									<em class="crRed">※ 카카오톡 맞춤정보 서비스는 2015년 12월 31일부로 종료되었습니다.</em><br />
								<% end if %>
								</td>
								<td class="ct">
									<% if date<="2015-12-31" then %>
									<a href="javascript:popKakaoAuth();" class="btn btnS2 btnRed"><span class="fn"><%=chkIIF(chkKakao,"서비스 해제 및 수정","사용자 인증하기")%></span></a>
									<div class="tPad05 fs11"><strong class="<%=chkIIF(chkKakao,"crRed","cr777")%>">상태 : <%=chkIIF(chkKakao,"신청완료","신청이전")%></strong></div>
									<% end if %>
								</td>
							</tr-->
							<% if date()>="2014-03-05" and date()<="2014-03-11" then %>
							<tr>
								<th style="border-top:0;"></th>
								<td style="border-top:0; padding-top:0;" colspan="2"><a href="/event/eventmain.asp?eventid=49853"><img src="http://webimage.10x10.co.kr/eventIMG/2014/49853/mytenten_bnr02.jpg" alt="회사에서 쇼핑하기" /></a></td>
							</tr>
							<% end if %>
							<input type="hidden" name="allow_other" value="N">
							<!-- 2017.10.1 서비스 종료
							<tr>
								<th scope="row">
									<span class="essential"><img src="http://fiximage.10x10.co.kr/web2013/common/blt_check_red.gif" alt="필수 입력정보" /></span>
									이용사이트 관리
								</th>
								<td colspan="2">
									<ul class="sendInfo">
										<li>
											<span class="ftLt" style="width:275px;">더핑거스(www.Thefingers.co.kr)</span>
											<div>
												<input type="radio" name="allow_other" value="Y" <%= chkIIF(IsAcademyUsing,"checked","") %> onClick="checkSiteComp(this);" class="radio" id="fingersUseY" />
												<label for="fingersUseY"><span class="rMar05">이용함</span></label>
												<input type="radio" name="allow_other" value="N" <%= chkIIF(IsAcademyUsing,"","checked") %> onClick="checkSiteComp(this);" class="radio" id="fingersUseN" />
												<label for="fingersUseN"><span>이용하지 않음</span></label>
											</div>
										</li>
									</ul>
								</td>
							</tr>
							-->
						<%
							''간편로그인수정;허진원 2018.04.24
							if Not(isSNSMember) then
						%>
							<!-- SNS 연동관리 추가 -->
							<%
							dim mynvsnsgubun, mynvsnsregdate, myfbsnsgubun, myfbsnsregdate, mykasnsgubun, mykasnsregdate, myglsnsgubun, myglsnsregdate
							sqlstr = "select top 4 " + vbcrlf
							sqlstr = sqlstr & "   'nv' as nvsnsgubun, (select top 1 regdate From [db_user].[dbo].[tbl_user_sns] Where tenbytenid='"& userid &"' And snsgubun='nv' And isusing='Y') as nvregdate  " + vbcrlf
							sqlstr = sqlstr & " , 'fb' as fbsnsgubun, (select top 1 regdate From [db_user].[dbo].[tbl_user_sns] Where tenbytenid='"& userid &"' And snsgubun='fb' And isusing='Y') as fbregdate " + vbcrlf
							sqlstr = sqlstr & " , 'ka' as kasnsgubun, (select top 1 regdate From [db_user].[dbo].[tbl_user_sns] Where tenbytenid='"& userid &"' And snsgubun='ka' And isusing='Y') as karegdate " + vbcrlf
							sqlstr = sqlstr & " , 'gl' as glsnsgubun, (select top 1 regdate From [db_user].[dbo].[tbl_user_sns] Where tenbytenid='"& userid &"' And snsgubun='gl' And isusing='Y') as glregdate " + vbcrlf
							sqlstr = sqlstr & " From [db_user].[dbo].[tbl_user_sns] " + vbcrlf
							sqlstr = sqlstr & " Where tenbytenid='"& userid &"' And isusing='Y' "
							rsget.CursorLocation = adUseClient
							rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
							if Not rsget.Eof then
								mynvsnsgubun = rsget("nvsnsgubun")
								mynvsnsregdate = rsget("nvregdate")
								myfbsnsgubun = rsget("fbsnsgubun")
								myfbsnsregdate = rsget("fbregdate")
								mykasnsgubun = rsget("kasnsgubun")
								mykasnsregdate = rsget("karegdate")
								myglsnsgubun = rsget("glsnsgubun")
								myglsnsregdate = rsget("glregdate")
							end if
							rsget.close
							%>
							<tr>
								<th rowspan="4"><%'sns 1개당 1개씩 %>
									<span class="essential"><img src="http://fiximage.10x10.co.kr/web2013/common/blt_check_red.gif" alt="필수 입력정보" /></span>
									SNS 연동관리
								</th>

								<td>
									<div class="btnSocialV17">
										<p><i class="icon kakao"></i>kakao<% if mykasnsgubun = "ka" and mykasnsregdate <> "" then %> <span class="lPad30"><%= mykasnsregdate %> 연결완료</span><% end if %></p>
									</div>
								</td>
								<td class="ct">
									<% if mykasnsgubun = "ka" and mykasnsregdate <> "" then %>
										<a href="" onclick="fnSNSdisconnect('ka');return false;" class="btn btnS2 btnRed">
											<span class="fn">연결해제</span>
										</a>
									<% else %>
										<a href="" onclick="fnPopSNSLogin('ka','470','570');return false;" class="btn btnS2 btnWhite">
											<span class="fn">연결하기</span>
										</a>
									<% end if %>
								</td>
							</tr>

							<tr>
								<td class="lineColor">
									<div class="btnSocialV17">
										<p><i class="icon naver"></i>NAVER<% if mynvsnsgubun = "nv" and mynvsnsregdate <> "" then %> <span class="lPad30"><%= mynvsnsregdate %> 연결완료</span><% end if %></p>
									</div>
								</td>
								<td class="ct">
									<% if mynvsnsgubun = "nv" and mynvsnsregdate <> "" then %>
										<a href="" onclick="fnSNSdisconnect('nv');return false;" class="btn btnS2 btnRed">
											<span class="fn">연결해제</span>
										</a>
									<% else %>
										<a href="" onclick="fnPopSNSLogin('nv','400','800');return false;" class="btn btnS2 btnWhite">
											<span class="fn" id="snsbtnnvs">연결하기</span>
										</a>
									<% end if %>
								</td>
							</tr>

							<tr>
								<td class="lineColor">
									<div class="btnSocialV17">
										<p><i class="icon facebook"></i>Facebook<% if myfbsnsgubun = "fb" and myfbsnsregdate <> "" then %> <span class="lPad30"><%= myfbsnsregdate %> 연결완료</span><% end if %></p>
									</div>
								</td>
								<td class="ct">
									<% if myfbsnsgubun = "fb" and myfbsnsregdate <> "" then %>
										<a href="" onclick="fnSNSdisconnect('fb');return false;" class="btn btnS2 btnRed">
											<span class="fn">연결해제</span>
										</a>
									<% else %>
										<a href="" onclick="fnPopSNSLogin('fb','410','300');return false;" class="btn btnS2 btnWhite">
											<span class="fn">연결하기</span>
										</a>
									<% end if %>
								</td>
							</tr>

							<tr>
								<td class="lineColor">
									<div class="btnSocialV17">
										<p><i class="icon google"></i>Google<% if myglsnsgubun = "gl" and myglsnsregdate <> "" then %> <span class="lPad30"><%= myglsnsregdate %> 연결완료</span><% end if %></p>
									</div>
								</td>
								<td class="ct">
									<% if myglsnsgubun = "gl" and myglsnsregdate <> "" then %>
										<a href="" onclick="fnSNSdisconnect('gl');return false;" class="btn btnS2 btnRed"><span class="fn">연결해제</span></a>
									<% else %>
										<a href="" onclick="fnPopSNSLogin('gl','410','420');return false;" class="btn btnS2 btnWhite"><span class="fn">연결하기</span></a>
									<% end if %>
								</td>
							</tr>
							<!--// SNS 연동관리 추가 -->

							<tr>
								<th scope="row">
									<span class="essential"><img src="http://fiximage.10x10.co.kr/web2013/common/blt_check_red.gif" alt="필수 입력정보" /></span>
									<label for="pwConfirm">비밀번호 확인</label>
								</th>
								<td colspan="2">
									<input type="password" name="oldpass" maxlength="32" onKeyPress="if (event.keyCode == 13) ChangeMyInfo(frminfo);" id="pwConfirm" class="txtInp" style="width:178px;" />
									<em class="lPad05 cr6aa7cc">정보를 수정 하시려면 기존 비밀번호를 입력하시기 바랍니다.</em>
								</td>
							</tr>
						<% end if %>
							</tbody>
							</table>

							<div class="btnArea ct tPad30">
								<input type="button" onclick="ChangeMyInfo(document.frminfo)" class="btn btnS1 btnRed btnW160 fs12" value="나의정보 수정" />
							</div>
						</form>
						</fieldset>
						<!-- //나의 정보관리 -->

					<%
						''간편로그인수정;허진원 2018.04.24
						if Not(isSNSMember) then
					%>
						<h4>비밀번호 수정</h4>
						<form name="frmpass" method="post" action="<%=SSLUrl%>/my10x10/userinfo/membermodify_process.asp" style="margin:0px;">
						<input type="hidden" name="mode" value="passmodi">
						<input type="hidden" name="pflag" value="<%=pFlag%>">
						<fieldset>
						<legend>비밀번호 수정</legend>
							<table class="baseTable rowTable docForm myInfoForm">
							<caption>비밀번호 수정</caption>
							<colgroup>
								<col width="140" /> <col width="" />
							</colgroup>
							<tbody>
							<tr>
								<th scope="row">
									<label for="oldPw">기존 비밀번호</label>
								</th>
								<td><input type="password" name="oldpass" maxlength="32" onKeyPress="if (event.keyCode == 13) ChangeMyPass(frmpass);" id="oldPw" class="txtInp" style="width:178px;" /></td>
							</tr>
							<tr>
								<th scope="row">
									<label for="newPw">새 비밀번호</label>
								</th>
								<td>
									<input type="password" name="newpass1" maxlength="32" onKeyPress="if (event.keyCode == 13) ChangeMyPass(frmpass);" id="newPw" class="txtInp" style="width:178px;" />
									<em class="lPad05 cr6aa7cc">비밀번호는 공백없는 8~16자의 영문/숫자 등 두 가지 이상의 조합으로 입력해주세요.</em>
								</td>
							</tr>
							<tr>
								<th scope="row">
									<label for="newPwConfirm">새 비밀번호 확인</label>
								</th>
								<td>
									<input type="password" name="newpass2" maxlength="32" onKeyPress="if (event.keyCode == 13) ChangeMyPass(frmpass);" id="newPwConfirm" class="txtInp" style="width:178px;" />
									<em class="lPad05 cr6aa7cc">비밀번호 확인을 위해 한 번 더 입력해 주시기 바랍니다.</em>
								</td>
							</tr>
							<tr>
								<td colspan="2" class="borderBtm">
									<p class="bulletDot"><strong >주의하세요!</strong><br />
									아이디와 같은 비밀번호나 주민등록번호, 생일, 학번, 전화번호 등 개인정보와 관련된 숫자나 연속된 숫자, 통일 반복된 숫자 등<br />
									다른 사람이 쉽게 알아 낼 수 있는 비밀번호는 사용하지 않도록 주의하여 주시기 바랍니다.
									</p>
								</td>
							</tr>
							</tbody>
							</table>

							<div class="btnArea ct tPad30">
								<input type="button" onclick="ChangeMyPass(document.frmpass)" class="btn btnS1 btnRed btnW160 fs12" value="비밀번호 수정" />
							</div>
						</fieldset>
						</form>
					<% end if %>
					</div>
					<div id="popResult"></div>
				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<%
set myUserInfo = Nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->