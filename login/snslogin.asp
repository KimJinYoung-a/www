<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head_ssl.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/membercls/snsloginCls.asp" -->
<script language="jscript" runat="server" src="/lib/util/JSON_PARSER_JS.asp"></script>
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	'			   2020.12.16 정태훈 : 테스트 원복
	strPageTitle = "텐바이텐 10X10 : 로그인"		'페이지 타이틀 (필수)

	Dim userid, referer
	userid = GetencLoginUserID

	dim mysns, mysnsgb, snsbackpath, snsjoingubun, itemid, blnclose
	dim returnScriptName , returnScriptFormName, snstoten, tokenval
	mysns = session("snsParam")		'id-기본로그인, my-마이페이지, mc-개인정보수정확인 , mo-주문 입력 주소 수정 팝업
	mysnsgb = session("snsgbParam") 'nv-네이버, fb-페이스북, ka-카카오, gl-구글
	snsbackpath = session("snsbackpath")
	snsjoingubun = session("snsjoingubun")
	itemid = session("snsitemid")
	blnclose = "YY"
	returnScriptName = session("returnScriptName")
	returnScriptFormName = session("returnScriptFormName")

	snstoten = request("snstoten")
	tokenval = request("tokenval")
	

	''간편로그인수정;허진원 2018.04.24
	if Not(mysns="my" or mysns="mc" or mysns="mo") then
		If (userid<>"") Then
			Response.Write "<script type=""text/javascript"">window.close();</script>"
			response.end
		End If
	end if

	dim errormsg, fberrorcode
	errormsg = request("error")
	fberrorcode = request("error_code")
	if errormsg <> "" or fberrorcode <> "" then
		Response.Write "<script type=""text/javascript"">window.close();</script>"
		response.end
	end if

	''vType : G : 비회원 로그인포함, B : 장바구니 비회원주문 포함.
	Dim vType
	vType = requestCheckVar(request("vType"),1)

	dim strBackPath, strGetData, strPostData
'		strBackPath = ReplaceRequestSpecialChar(request("backpath"))
		strBackPath = snsbackpath
		strBackPath = Replace(strBackPath,"^^","&")
'		strGetData  = ReplaceRequestSpecialChar(request("strGD"))
'		strPostData = ReplaceRequestSpecialChar(request("strPD"))
		strGetData  = session("strGD")
		if strGetData <> "" and itemid <> "" then
			strGetData = strGetData&"&itemid="&itemid
			blnclose = "YI"
		end if
		strPostData = session("strPD")
		if instr(strBackPath,"join.asp")>0 then
			strBackPath = ""
		end if

'==============================================================================
dim nvid, nvaccess_token, nvemail, snstitlename, loginsnsname, reoJsns
dim nvrefresh_token, nvtoken_type, nvexpires_in
dim client_id, client_secret
dim code : code = request("code")
dim state : state = request("state")
dim redirectURI
dim url
dim kakaoTermsData, roopVal

if mysnsgb = "nv" or mysnsgb = "ka" or mysnsgb = "gl"  or mysnsgb = "fb"then
	redirectURI = SSLUrl&"/login/snslogin.asp"

	if tokenval<>"" then
		nvaccess_token=tokenval
	else
		Select Case mysnsgb
			Case "nv"
				snstitlename = "네이버"
				loginsnsname = "네이버"
				client_id = "bI8tkz5b5W5IdMPD3_AN"			''테스트용 네이버앱id : 4xjaEZMGAoiudDSz06d9
				client_secret = "Tlt0EEBPWo"				''네이버 테스트용 시크릿코드 : "wdRTtRyDCA" 
				url = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&client_id=" & client_id & "&client_secret=" & client_secret & "&redirect_uri=" & redirectURI & "&code=" & code & "&state=" & state
			Case "ka"
				snstitlename = "카카오"
				loginsnsname = "카카오"
				If application("Svr_Info")="Dev" Then
					client_id = "63d2829d10554cdd7f8fab6abde88a1a"
					client_secret = "oS4jNWkySRuGJzSTun4TcbBb8OjsTPIB"			
				Else			
					client_id = "de414684a3f15b82d7b458a1c28a29a2"
					client_secret = "IRgr5zxQEuS4uABqV30k6lik94qlk3PF"
				End If
				url = "https://kauth.kakao.com/oauth/token?grant_type=authorization_code&client_id=" & client_id & "&redirect_uri=" & redirectURI & "&code=" & code & "&client_secret=" & client_secret
			Case "gl"
				snstitlename = "구글"
				loginsnsname = "구글"
				client_id = "614712658656-s78hbq7158i9o92f57dnoiq9env0cd9q.apps.googleusercontent.com"
				client_secret = "ha-9fm6gR4iLf4VuWglsP0Vz"
				url = "https://www.googleapis.com/oauth2/v4/token?grant_type=authorization_code&access_type=offline&client_id=" & client_id & "&client_secret=" & client_secret & "&redirect_uri=" & redirectURI & "&code=" & code
			Case "fb"
				snstitlename = "페이스북"
				loginsnsname = "페이스북"
				client_id = "687769024739561"
				client_secret = "69f2a6ab39e64e3185e5c1c783617846"
				'grant_type=client_credentials&
				url = "https://graph.facebook.com/oauth/access_token?client_id=" & client_id & "&client_secret=" & client_secret & "&code="& code &"&redirect_uri=" & redirectURI
		End Select

		dim xml, params, res, oJrt, NvToken
		set xml = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
		xml.open "POST", url, false
		xml.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
		xml.send

		If xml.Status = "200" Then
			res = xml.responseText
			on error resume next
			Set oJrt = JSON.Parse(res)
				nvaccess_token = oJrt.access_token
				if mysnsgb <> "fb" then
	'				nvrefresh_token = oJrt.refresh_token	'oJrt.id_token
					nvtoken_type = oJrt.token_type
					nvexpires_in = oJrt.expires_in
				end if
			if err then
				response.write "sns 인증을 다시 시도해 주시기 바랍니다."
				Response.Write "<script type=""text/javascript"">window.close();</script>"
				response.end
			end if
			on error goto 0
		else
			response.write "sns 인증을 다시 시도해 주시기 바랍니다."
			Response.Write "<script type=""text/javascript"">window.close();</script>"
			response.end
		end if
		Set oJrt = Nothing
		set xml = Nothing
		'==============================================================================
	end if
	'==============================================================================
	'사용자 추가 정보받기
	dim nvmessage, nvname, nvage, nvgender
	dim snsemailyn, snsidyn
	dim usercallurl

	Select Case mysnsgb
		Case "nv"
			usercallurl = "https://openapi.naver.com/v1/nid/me"
		Case "ka"
			usercallurl = "https://kapi.kakao.com/v2/user/me"
		Case "gl"
			usercallurl = "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token="&nvaccess_token
		Case "fb"
			usercallurl = "https://graph.facebook.com/me?access_token="&nvaccess_token&"&fields=email,gender,age_range"
	End Select
	
	set xml = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
	xml.open "POST", usercallurl, false
	xml.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	xml.SetRequestHeader "Authorization", "Bearer " & nvaccess_token
	xml.send
	If xml.Status = "200" Then
		res = xml.responseText
		on error resume next
		Set oJrt = JSON.Parse(res)
			if mysnsgb = "nv" then
				nvmessage = oJrt.message
				if nvmessage = "success" then
					nvid = oJrt.response.id
					if Not ERR THEN
						nvemail = oJrt.response.email
						nvname = oJrt.response.name
						nvage = oJrt.response.age		'나이대 추가
						nvgender = oJrt.response.gender	'성별 추가
						if ERR THEN Err.Clear ''이메일과 이름이 없을 수 도 있음 > 건너뜀
					END IF
				else
					response.write "sns 인증을 다시 시도해 주시기 바랍니다."
					Response.Write "<script type=""text/javascript"">window.close();</script>"
					response.end
				end if
			elseif mysnsgb = "ka" or mysnsgb = "gl" or mysnsgb = "fb" then
				Select Case mysnsgb
					Case "ka"
						snsidyn = oJrt.id
						if Not ERR THEN
							snsemailyn = oJrt.kaccount_email
							if ERR THEN Err.Clear ''이메일이 없을 수 도 있음 > 건너뜀
						END IF
					Case "gl"
						snsidyn = oJrt.user_id
						if Not ERR THEN
							snsemailyn = oJrt.email
							if ERR THEN Err.Clear ''이메일이 없을 수 도 있음 > 건너뜀
						END IF
					Case "fb"
						snsidyn = oJrt.id
						if Not ERR THEN
							snsemailyn = oJrt.email
							nvgender = oJrt.gender
							if nvgender = "male" then
								nvgender = "M"
							elseif nvgender = "female" then
								nvgender = "F"
							else
								nvgender = ""
							end if
							if ERR THEN Err.Clear ''이메일이 없을 수 도 있음 > 건너뜀
						END IF
				End Select

				if snsidyn <> "" then	'snsemailyn <> "" and 
					nvid = snsidyn
					if Not ERR THEN
						nvemail = snsemailyn
						if ERR THEN Err.Clear ''이메일이 없을 수 도 있음 > 건너뜀
					END IF
				else
					response.write "sns 인증을 다시 시도해 주시기 바랍니다."
					Response.Write "<script type=""text/javascript"">window.close();</script>"
					response.end
				end if
			else
				response.write "sns 인증을 다시 시도해 주시기 바랍니다."
				Response.Write "<script type=""text/javascript"">window.close();</script>"
				response.end
			end if
			params = "snsid="&nvid&"&tokenval="&server.urlencode(nvaccess_token)&"&snsgubun="&mysnsgb&"&mysns="&mysns&"&snsusermail="&nvemail&"&mysnsuserid="&userid&"&snsjoingubun="&snsjoingubun

			if err then
				response.write "<script type=""text/javascript"">alert('추가권한을 해제할경우 가입에 제한이 있을 수 있습니다.');</script>"
				Response.Write "<script type=""text/javascript"">history.back();</script>"
				response.end
			end if
		on error goto 0
	end if
	Set oJrt = Nothing
	set xml = Nothing
	'===================================================

	'==============================================================================
	if mysnsgb = "gl" then
		'구글 사용자 추가 정보받기(email과 성별을 한번에 안주기때문에 성별만 따로 가져옴
		usercallurl = "https://www.googleapis.com/oauth2/v3/userinfo?access_token="&nvaccess_token

		set xml = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
		xml.open "POST", usercallurl, false
		xml.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
		xml.SetRequestHeader "Authorization", "Bearer " & nvaccess_token
		xml.send

		If xml.Status = "200" Then
			res = xml.responseText
			on error resume next
			Set oJrt = JSON.Parse(res)
				if Not ERR THEN
					nvgender = oJrt.gender
					if nvgender = "male" then
						nvgender = "M"
					elseif nvgender = "female" then
						nvgender = "F"
					else
						nvgender = ""
					end if			
					if ERR THEN Err.Clear ''성별이 없을 수 도 있음 > 건너뜀
				END IF

				if err then
					response.write "<script type=""text/javascript"">alert('추가권한을 해제할경우 가입에 제한이 있을 수 있습니다.');</script>"
					Response.Write "<script type=""text/javascript"">history.back();</script>"
					response.end
				end if
			on error goto 0
		end if
		Set oJrt = Nothing
		set xml = Nothing
	end if
	'===================================================

	'==============================================================================
	if mysnsgb = "ka" then
		'카카오 싱크 관련 사용자 약관 동의 정보 가져오기
		usercallurl = "https://kapi.kakao.com/v1/user/service/terms"

		set xml = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
		xml.open "GET", usercallurl, false
		xml.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
		xml.SetRequestHeader "Authorization", "Bearer " & nvaccess_token
		xml.send

		If xml.Status = "200" Then
			res = xml.responseText
			on error resume next
			Set oJrt = JSON.Parse(res)
				if Not ERR THEN
					kakaoTermsData = ""
					For roopVal=0 to oJrt.allowed_service_terms.length-1
						If roopVal = 0 Then
							kakaoTermsData = oJrt.allowed_service_terms.get(roopVal).tag&":"&oJrt.allowed_service_terms.get(roopVal).agreed_at
						Else
							kakaoTermsData = oJrt.allowed_service_terms.get(roopVal).tag&":"&oJrt.allowed_service_terms.get(roopVal).agreed_at&"|"&kakaoTermsData
						End If
					Next
					if ERR THEN Err.Clear ''카카오에서 약관 동의 관련 정보 설정 꺼놓으면 없을수도 있음 건더뜀
				END IF

				if err then
					'response.write "<script type=""text/javascript"">alert('추가권한을 해제할경우 가입에 제한이 있을 수 있습니다.');</script>"
					'Response.Write "<script type=""text/javascript"">history.back();</script>"
					'response.end
				end if
			on error goto 0
		end if
		Set oJrt = Nothing
		set xml = Nothing
	end if
	'===================================================	

	'==============================================================================
	' 텐바이텐쪽에 네이버 데이터 처리
	dim oSns
	set oSns = new cSNSLogin
		oSns.sGubun = mysnsgb
		oSns.sUserNo = nvid
		oSns.sSnsToken = nvaccess_token
		oSns.sTenUserid = userid
		oSns.sSnsPagegubun = mysns
		oSns.sEmail = nvemail
		oSns.sAge = nvage			'나이대
		oSns.sSexflag = nvgender	'성별

		if oSns.checkSNSLogin() then	'로그인처리
			if mysns = "my" then			'마이텐바이텐일경우 연동해제는 마이페이지쪽에서 따로함
				if oSns.connSNSLogin() = "OK" then
					reoJsns = "my"
				else
					reoJsns = oSns.connSNSLogin()
					reoJsns = oSns.GetErrorMsg(reoJsns)
				end if
			''간편로그인수정;허진원 2018.04.24
			elseif  mysns = "mc" then			'개인정보 수정 접근 확인
				reoJsns = oSns.connSNSLogin()
				if reoJsns="ERR01" then
					Session("InfoConfirmFlag") = userid
				    response.Cookies("tinfo").domain = "10x10.co.kr"
				    response.Cookies("tinfo")("EcChk") = TenEnc(userid)
					reoJsns = "memInfo"
				end if
			elseif  mysns = "mo" then			'주문 페이지 개인정보 수정 접근 확인
				reoJsns = oSns.connSNSLogin()
				if reoJsns="ERR01" then
					Session("InfoConfirmFlag") = userid
				    response.Cookies("tinfo").domain = "10x10.co.kr"
				    response.Cookies("tinfo")("EcChk") = TenEnc(userid)
					reoJsns = "orderMemberInfo"
				end if
			else							'로그인페이지일경우
				reoJsns = "Sns"			'연동되있으면 로그인 시킴
			end if
		else								'연동,회원가입해라
			if mysns = "my" then
				if oSns.connSNSLogin() = "OK" then
					reoJsns = "my"
				else
					reoJsns = oSns.connSNSLogin()
					reoJsns = GetErrorMsg(reoJsns)
				end if
			else
				if snsjoingubun = "ji" then
					reoJsns = "Join2"		'회원가입
				else
					reoJsns = "Join"		'회원가입 혹은 연동하기
				end if
			end if
		end if

	set oSns = Nothing
else
	response.write "sns 인증을 다시 시도해 주시기 바랍니다."
	Response.Write "<script type=""text/javascript"">window.close();</script>"
	response.end
end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup_ssl.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15_ssl.css" />
<script type="text/javascript">

$(function() {
	$('.flexFormV17 input').each(function() {
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
});

var valsnsid = "<%= nvid %>";
var valnickname = "";
var valusermail = "<%= nvemail %>";
var valsexflag = "<%= nvgender %>";
var valage = "<%= nvage %>";
var valsnsgubun = "<%= mysnsgb %>";
var valtenbytenid = "";
var valsnsname = "";
var acc_token_val = "<%= server.urlencode(nvaccess_token) %>";
var valname_val = "<%= nvname %>";
var mysns = "<%= mysns %>";
var mysnsgb = "<%= mysnsgb %>";
var kakaoterms = "<%=kakaoTermsData%>";
var snscode = "<%=code%>";
var snsstate = "<%=state%>";

function join(val) {
	var form = document.MemberJoinForm;
	form.action = "/member/join.asp";
	var param = "";
	var strURL = "";
	if (val == "snsJoin") {
		param+= "&snsid="+valsnsid;
		param+= "&usermail=" + valusermail;
		param+= "&snsusername=" + valname_val;
		param+= "&snsisusing=Y"
		param+= "&snsgubun="+valsnsgubun;
		param+= "&tenbytenid="+valtenbytenid;
		param+= "&tokenval="+acc_token_val;
		param+= "&age="+valage;
		param+= "&sexflag="+valsexflag;
		param+= "&kakaoterms="+kakaoterms;
		param+= "&code="+snscode;
		param+= "&state="+snsstate;
		strURL="<%=SSLUrl%>/member/join.asp?authtp=sns" + param;
		if(typeof(opener.window)=="object"){
			opener.top.location.href = strURL;
		}
		self.close();
	} 
}

function jsGoURL(strURL){
	if(typeof(opener.window)=="object"){
		opener.top.location.href = strURL;
	}	
	self.close();
}

function TnCSlogin(frm){
	if (frm.userid.value.length<1) {
		alert('보유하고 계신 텐바이텐 계정의 아이디를 입력해주세요');
		frm.userid.focus();
		return;
	}

	if (frm.userpass.value.length<1) {
		alert('보유하고 계신 텐바이텐 계정의 비밀번호를 입력해주세요');
		frm.userpass.focus();
		return;
	}

	var snsname = $("#loginsnsname").val();
	var tokenval = $("#tokenval").val();
	var snsMsg = frm.elements["userid"].value + " 아이디와 " + snsname + "계정을 연결하시겠습니까?";
	//if (confirm(snsMsg)) {
		frm.action = '<%=SSLUrl%>/login/dologin.asp';
		frm.submit();
	//}
}

</script>
</head>
<body>
<% if snstoten="Y" then 'SNS 텐바이텐 로그인 연동 %>
<div class="heightgird loginV17">
	<div class="popWrap">
		<div class="popHeader">
			<h1>SNS 계정 연결</h1>
		</div>

		<div class="popContent">
			<div class="group">
				<div class="txt">
					한번의 연결로 <br/>자유롭게!
					<p>연결 한번으로 텐바이텐 또는 SNS 계정으로 자유롭게 로그인하실 수 있습니다.</p>
				</div>
				<!-- 텐바이텐 로그인 -->
				<form name="frmLogin2" method="post" action="">
				<input type="hidden" name="backpath" value="<%= strBackPath %>">
				<input type="hidden" name="strGD" value="<%= strGetData %>">
				<input type="hidden" name="strPD" value="<%= strPostData %>">
				<input type="hidden" name="snsisusing" value="Y">
				<input type="hidden" id="loginsnsid" name="snsid" value="<%=nvid%>">
				<input type="hidden" id="snslogin" name="snslogin" value="">
				<input type="hidden" id="loginsnsgubun" name="snsgubun" value="<%=mysnsgb%>">
				<input type="hidden" id="loginsnusermail" name="snsusermail" value="<%=nvemail%>">
				<input type="hidden" id="loginsnsname" name="loginsnsname" value="<%= loginsnsname %>">
				<input type="hidden" id="tokenval" name="tokenval" value="<%=nvaccess_token%>">
				<input type="hidden" id="tokenval2" name="tokenval2" value="<%=nvrefresh_token%>">
				<input type="hidden" name="isopenerreload" value="on">
				<input type="hidden" name="blnclose" value="<%=blnclose%>">
				<input type="hidden" name="snsjoingubun" value="<%= snsjoingubun %>">
				<input type="hidden" name="sns_sexflag" value="<%= nvgender %>">
				<input type="hidden" name="age" value="<%= nvage %>">
                    <fieldset>
                        <legend>회원 로그인</legend>
                        <div class="flexFormV17 tPad10">
                            <div><label for="loginId">아이디</label><input type="text" name="userid" id="loginId" class="txtInp" maxlength="32" value="<%=vSavedID%>" autocomplete="off" onKeyPress="if (event.keyCode == 13) frmLogin2.userpass.focus();" /></div>
                        </div>
                        <div class="flexFormV17">
                            <div><label for="loginPw">비밀번호</label><input type="password" name="userpass" id="loginPw" class="txtInp" maxlength="32" onKeyPress="if (event.keyCode == 13) TnCSlogin(frmLogin2);" /></div>
                        </div>
                    </fieldset>
                    <% if session("chkLoginLock") then %>
                        <div class="loginLimitV15a">
                            <p class="lmtMsg1">ID/PW 입력 오류로 인해 로그인이 <br />제한되었습니다.</p>
                            <p class="fs11 tPad05 cr666">개인정보 보호를 위해 아래 항목을 입력해주세요.</p>
                        </div>
                        <div class="tPad05 bPad15">
                            <script src="https://www.google.com/recaptcha/api.js" async defer></script>
                            <div id="g-recaptcha" class="g-recaptcha" data-sitekey="6LdSrA8TAAAAAD0qwKkYWFQcex-VzjqJ6mbplGl6"></div>
                            <style>
                            .g-recaptcha {margin:0 auto; padding:0; transform:scale(0.92); -webkit-transform:scale(0.92); transform-origin:0 0; -webkit-transform-origin:0 0; zoom: 0.8\9;}
                            </style>
                        </div>
                    <% end if %>
                    <p class="tPad15"><a href="javascript:TnCSlogin(document.frmLogin2);" class="btn btnB1 btnRed">연결하기</a></p>
				</form>
				<!--// 텐바이텐 로그인 -->
			</div>
		</div>
	</div>
</div>
<% else %>
<div class="heightgird loginV17" id="snsdiv" style="display:none;">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="/fiximage/web2017/member/tit_pop_join.png" alt="텐바이텐 회원가입" /></h1>
		</div>

		<div class="popContent">
			<div class="group" style="width:338px;">
				<div class="finishSnsCertify">
					<p><span class="cRd0V15" id="snstitlename"><%= snstitlename %></span> 인증이<br />완료되었습니다</p>
				</div>
				<!-- 텐바이텐 로그인 -->
				<form name="frmLogin2" method="post" action="">
				<input type="hidden" name="backpath" value="<%= strBackPath %>">
				<input type="hidden" name="strGD" value="<%= strGetData %>">
				<input type="hidden" name="strPD" value="<%= strPostData %>">
				<input type="hidden" name="snsisusing" value="Y">
				<input type="hidden" id="loginsnsid" name="snsid" value="<%=nvid%>">
				<input type="hidden" id="snslogin" name="snslogin" value="">
				<input type="hidden" id="loginsnsgubun" name="snsgubun" value="<%=mysnsgb%>">
				<input type="hidden" id="loginsnusermail" name="snsusermail" value="<%=nvemail%>">
				<input type="hidden" id="loginsnsname" name="loginsnsname" value="<%= loginsnsname %>">
				<input type="hidden" id="tokenval" name="tokenval" value="<%=nvaccess_token%>">
				<input type="hidden" id="tokenval2" name="tokenval2" value="<%=nvrefresh_token%>">
				<input type="hidden" name="isopenerreload" value="on">
				<input type="hidden" name="blnclose" value="<%=blnclose%>">
				<input type="hidden" name="snsjoingubun" value="<%= snsjoingubun %>">
				<input type="hidden" name="sns_sexflag" value="<%= nvgender %>">
				<input type="hidden" name="age" value="<%= nvage %>">
					<div>
						<h2 class="fs16 cGy2V15">이미 텐바이텐 회원이신가요?</h2>
						<p class="cGy1V15 tPad10">로그인을 하시면, 텐바이텐 ID와 SNS계정을 연동하실 수 있습니다.</p>
						<fieldset>
							<legend>회원 로그인</legend>
							<div class="flexFormV17 tPad10">
								<div><label for="loginId">아이디</label><input type="text" name="userid" id="loginId" class="txtInp" maxlength="32" value="<%=vSavedID%>" autocomplete="off" onKeyPress="if (event.keyCode == 13) frmLogin2.userpass.focus();" /></div>
							</div>
							<div class="flexFormV17">
								<div><label for="loginPw">비밀번호</label><input type="password" name="userpass" id="loginPw" class="txtInp" maxlength="32" onKeyPress="if (event.keyCode == 13) TnCSlogin(frmLogin2);" /></div>
							</div>
						</fieldset>

						<% if session("chkLoginLock") then %>
							<div class="loginLimitV15a">
								<p class="lmtMsg1">ID/PW 입력 오류로 인해 로그인이 <br />제한되었습니다.</p>
								<p class="fs11 tPad05 cr666">개인정보 보호를 위해 아래 항목을 입력해주세요.</p>
							</div>
							<div class="tPad05 bPad15">
								<script src="https://www.google.com/recaptcha/api.js" async defer></script>
								<div id="g-recaptcha" class="g-recaptcha" data-sitekey="6LdSrA8TAAAAAD0qwKkYWFQcex-VzjqJ6mbplGl6"></div>
								<style>
								.g-recaptcha {margin:0 auto; padding:0; transform:scale(0.92); -webkit-transform:scale(0.92); transform-origin:0 0; -webkit-transform-origin:0 0; zoom: 0.8\9;}
								</style>
							</div>
						<% end if %>

						<p class="tPad15"><a href="javascript:TnCSlogin(document.frmLogin2);" class="btn btnB1 btnRed">로그인</a></p>
						<p class="rt tPad10"><a href="" onclick="jsGoURL('/member/forget.asp');return false;" class="fs11 fn cGy1V15">아이디/비밀번호 찾기 &gt;</a></p>
					</div>
				</form>
				<!--// 텐바이텐 로그인 -->

				<!-- SNS 회원가입 -->
				<FORM name="MemberJoinForm" method="post" action="<%= SSLUrl %>/member/join.asp" onSubmit="return false;" class="termHT">
				<input type="hidden" name="memId" value="">
				<input type="hidden" name="memNm" value="">
				<input type="hidden" name="memEmail" value="">
				<input type="hidden" name="pwd" value="">
				<input type="hidden" name="accessToken" value="">
				<input type="hidden" name="refreshToken" value="">
				<input type="hidden" name="onlySnsYn" value="N">
					<div class="tPad40">
						<h2 class="fs16 cGy2V15">SNS 인증으로 회원가입</h2>
						<p class="cGy1V15 tPad10">SNS 계정으로 간편하게 텐바이텐에 가입합니다.</p>
						<p class="tPad20"><a href="" onclick="join('snsJoin'); return false;" class="btn btnB1 btnRed">SNS 연동 회원가입</a></p>
					</div>
				</form>
				<!--// SNS 회원가입 -->
			</div>
		</div>
	</div>
	<div class="popFooter">
		<div class="btnArea">
			<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
		</div>
	</div>
</div>
<% end if %>
</body>
<script type="text/javascript">
//	setTimeout(function(){
//		window.resizeTo(450, 850);
//		},500);
	window.resizeTo(450, 850);
	if(mysnsgb=="nv" || mysnsgb=="ka" || mysnsgb=="gl" || mysnsgb=="fb"){
		var frm = document.frmLogin2;
		<% if reoJsns = "Sns" then %>
			<% if snsjoingubun = "ji" then %>
				alert('이미 연동된 계정 입니다.\n로그인 되었습니다.')
			<% end if %>
			$("#snslogin").val('<%= nvaccess_token %>');
			frm.action = '<%=SSLUrl%>/login/dologin.asp';
			frm.submit();
		<% elseif  reoJsns = "Join" then %>
			<% if snstoten<>"Y" then %>
			join('snsJoin');
			<% end if %>
			//$("#snsdiv").show();
		<% elseif  reoJsns = "Join2" then %>
			join('snsJoin');
		<% elseif  reoJsns = "my" then %>
			window.opener.document.location.reload();
			self.close();
		<%
			''간편로그인수정;허진원 2018.04.24
			elseif  reoJsns = "memInfo" then
		%>
//			window.opener.document.location.replace("<%=SSLUrl%>/my10x10/userinfo/membermodify.asp");
			opener.top.location.replace("<%=SSLUrl%>/my10x10/userinfo/membermodify.asp");
			self.close();
		<%
			'' 주문 페이지 개인 정보 수정 팝업
			elseif reoJsns = "orderMemberInfo" then
		%>
			var fnName = "<%=returnScriptName%>"
			var fnForm = "<%=returnScriptFormName%>"
			var fn = opener.opener.window[fnName];

			if (typeof fn === "function") {
				fn(eval("opener.opener.document."+fnForm));
			}
			opener.close();
			self.close();
		<% else %>
			alert("<%= reoJsns %>");
			alert("SNS 인증을 다시 시도해 주시기 바랍니다.");
			self.close();
		<% end if %>
	}else{
		alert('sns구분오류');
		self.close();
	}
</script>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->