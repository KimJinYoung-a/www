<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

'#######################################################
'	History	: 2013.09.12 허진원 생성
'	Description : 로그인 팝업
'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 로그인"		'페이지 타이틀 (필수)

	dim userid
	userid = GetLoginUserID
	if (userid<>"") then
		Response.Write "<script type=""text/javascript"">window.close();</script>"
		response.end
	end if

	dim strBackPath, strGetData, strPostData
	strBackPath = ReplaceRequestSpecialChar(request("backpath"))
	strGetData  = ReplaceRequestSpecialChar(request("strGD"))
	strPostData = ReplaceRequestSpecialChar(request("strPD"))
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
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

function TnCSlogin(frm){	
	if (!jsChkNull("text",frm.userid,"아이디를 입력 해주세요")) {	
		frm.userid.focus();
		return false;
	}

	if (!jsChkNull("text",frm.userpass,"비밀번호를 입력 해주세요")) {	
		frm.userpass.focus();
		return false;
	}

	try {
		frm.parentprotocol.value = window.opener.document.location.protocol;
	} catch (e) {
		frm.parentprotocol.value = "http:";
	}
	
	frm.action = '<%=SSLUrl%>/login/dologin.asp';
	frm.submit();
}

function jsGoURL(strURL){
	if(typeof(opener.window)=="object"){
		opener.top.location.href = strURL;
	}	
	self.close();
}

$(function(){
	$("#loginId").focus();

	//팝업 리사이즈 (+20,50)
	resizeTo(530,<%=chkIIF(session("chkLoginLock"),"720","640")%>);
});

function fnPopSNSLogin(snsgb,wd,hi) {
	var snsbackpath = '<%=strBackPath%>';
	var popWidth  = wd;
	var popHeight = hi;
	var winWidth  = document.body.clientWidth;
	var winHeight = document.body.clientHeight;
	var winX      = window.screenX || window.screenLeft || 0;
	var winY      = window.screenY || window.screenTop || 0;
	var popupX = (winX + (winWidth - popWidth) / 2)- (wd / 4);
	var popupY = (winY + (winHeight - popHeight) / 2)- (hi / 4);
	window.close();
	var popup = opener.window.open("/login/mainsnslogin.asp?snsdiv="+snsgb+"&pggb=id&snsbackpath="+snsbackpath+"&strGD=<%=strGetData%>&strPD=<%=strPostData%>","","width="+wd+", height="+hi+", left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY);
}
</script>
</head>
<body>
	<div class="heightgird loginV17">
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/common/tit_pop_login.gif" alt="LOGIN" /></h1>
				<!-- 로그인 배너영역 -->
				<% server.Execute("/login/pop_login_banner.asp") %>			
			</div>
			<div class="popContent">
				<form name="frmLogin" method="post" action="" onSubmit="return TnCSlogin(frmLogin);">
				<input type="hidden" name="parentprotocol" value="">
				<input type="hidden" name="backpath" value="<%=strBackPath%>">
				<input type="hidden" name="isopenerreload" value="on">
				<input type="hidden" name="strGD" value="<%=strGetData%>">
				<input type="hidden" name="strPD" value="<%=strPostData%>">				
				<div class="group">
					<fieldset>
						<legend>회원 로그인</legend>
						<div class="flexFormV17 tPad15">
							<div><label for="loginId">아이디</label><input type="text" name="userid" id="loginId" class="txtInp" value="<%=vSavedID%>" autocorrect="off" autocapitalize="off" maxlength="32" onkeypress="if (keyCode(event) == 13) frmLogin.userpass.focus();" style="ime-mode:disabled;" /></div>
						</div>
						<div class="flexFormV17">
							<div><label for="loginPw">비밀번호</label><input type="password" name="userpass" id="loginPw" class="txtInp" autocomplete="off" autocorrect="off" autocapitalize="off" onkeypress="if (keyCode(event) == 13) TnCSlogin(document.frmLogin);" /></div>
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
					<p class="tPad15"><a href="" onclick="TnCSlogin(document.frmLogin); return false;" class="btn btnB1 btnRed">로그인</a></p>
					<p class="saveId tPad10"><input type="checkbox" name="saved_id" id="saveId" class="check" value="o" <% If vSavedID <> "" Then Response.Write "checked" End If %> /> <label for="saveId2">아이디 저장</label></p>
					<div class="snsLogin">
						<h2 class="title">다음 계정으로 로그인</h4>
						<ul class="sns-accountV20">
							<li class="kakao"><a href="" onclick="fnPopSNSLogin('ka','470','570');return false;" class="icon kakao"><i></i><span class="text">카카오톡</span></a></li>	
							<!--<li class="apple"><a href=""><i class="icon"></i><span class="text">애플</span></a></li>-->
							<li class="naver"><a href="" onclick="fnPopSNSLogin('nv','400','800');return false;" class="icon naver"><i></i><span class="text">네이버</span></a></li>
							<li class="facebook"><a href="" onclick="fnPopSNSLogin('fb','410','300');return false;" class="icon facebook"><i></i><span class="text">페이스북</span></a></li>
							<li class="google"><a href="" onclick="fnPopSNSLogin('gl','410','420');return false;" class="icon google"><i></i><span class="text">구글</span></a></li>
						</ul>
					</div>
					<div class="helpV17">
						<a href="" onclick="jsGoURL('/member/join.asp');return false;" class="ftLt">회원가입하기 &gt;</a>
						<a href="" onclick="jsGoURL('/member/forget.asp');return false;" class="ftRt">아이디/비밀번호 찾기 &gt;</a>
					</div>
				</div>
				</form>
			</div>
		</div>
		<div class="popFooter">
			<div class="btnArea">
				<button type="button" class="btn btnS1 btnGry2" onclick="window.close();">닫기</button>
			</div>
		</div>
	</div>
</body>
</html>