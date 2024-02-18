<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->

<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/member/iPin/nice.nuguya.oivs.asp" -->
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"


	Dim C_dumiKey : 

	'#######################################################################################
	'#####	개인인증키(대체인증키;아이핀) 서비스				한국신용정보(주)
	'#######################################################################################
	Dim NiceId, SIKey, ReturnURL, pingInfo, strOrderNo
	'// 텐바이텐
	NiceId = "Ntenxten4"		'// 회원사 ID
	SIKey = "N0001N013276"		'// 사이트식별번호 12자리

	'randomize(time())
	strOrderNo = Replace(date, "-", "")  & round(rnd*(999999999999-100000000000)+100000000000)

	'// 해킹방지를 위해 요청정보를 세션에 저장
	session("niceOrderNo") = strOrderNo



	'#######################################################
	'	History	: 2013.09.12 허진원 생성
	'	Description : 로그인 팝업
	'			   2020.12.16 정태훈 : 테스트 원복
	'#######################################################

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 로그인"		'페이지 타이틀 (필수)
	dim strBackPath, strGetData, strPostData
	strBackPath = ReplaceRequestSpecialChar(request("backpath"))
	strGetData  = ReplaceRequestSpecialChar(request("strGD"))
	strPostData = ReplaceRequestSpecialChar(request("strPD"))
	session("strBackPath") = strBackPath

	'///로그인 분기처리 (TAB BAR)
	Dim bp : bp = chkiif(strBackPath<>"", strBackPath, "/")
	Dim footflag : footflag = False

	if (IsUserLoginOK() And session("isAdult") = True) then
		dim strTemp:strTemp = 	"<script language='javascript'>opener.location.href='"+bp+"';self.close();</script>"
		Response.Write strTemp
		Response.end
	end if
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
				<h1><img src="http://fiximage.10x10.co.kr/web2018/common/tit_pop_login_adult.png" alt="성인인증" /></h1>
			</div>
			<!-- 20180703 성인인증 안내 -->
			<div class="adult-text">
				<div class="inner">
					<strong>19세 미만의 청소년 접근이 제한된 정보로 본인인증이 필요합니다.</strong>
					<p>이 정보는 청소년 유해매체물로서 정보통신망이용촉진 및 정보보호 등에 관한 법률 및 청소년보호법의 규정에 의하여 19세 미만의 청소년이 이용할 수 없습니다.</p>
					<p>이 상품은 <span class="color-red">비회원 주문이 불가</span>합니다.</p>
				</div>
			</div>
			<div class="popContent">
						
				<div class="login-adult">
				<div class="nav-tab">
					<ul>
						<li><a href="javascript:return false;" <%=chkiif(IsUserLoginOK(),"","class='on'")%>>STEP 1<br /><strong>로그인</strong></a></li>
						<li><a href="javascript:return false;" <%=chkiif(IsUserLoginOK(),"class='on'","")%>>STEP 2<br /><strong>성인 본인인증</strong></a></li>
					</ul>
				</div>
				<div class="group">
					<%If IsUserLoginOK() <> True then%>
					<!-- STEP1 로그인 내용 -->
					<form name="frmLogin" method="post" action="" onSubmit="return TnCSlogin(frmLogin);">
					<input type="hidden" name="backpath" value="/login/login_adult.asp?backpath=<%=server.urlencode(strBackPath)%>">
					<!--input type="hidden" name="isopenerreload" value="on"-->
					<input type="hidden" name="strGD" value="<%=strGetData%>">
					<input type="hidden" name="strPD" value="<%=strPostData%>">	
					<div id="basicLogin" class="login-input-cont">
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
							<li class="kakao"><a href="" onclick="fnPopSNSLogin('ka','470','570');return false;"><i class="icon"></i><span class="text">카카오톡</span></a></li>
							<!--<li class="apple"><a href=""><i class="icon"></i><span class="text">애플</span></a></li>-->
							<li class="google"><a href="" onclick="fnPopSNSLogin('gl','410','420');return false;"><i class="icon"></i><span class="text">구글</span></a></li>
							<li class="naver"><a href="" onclick="fnPopSNSLogin('nv','400','800');return false;"><i class="icon"></i><span class="text">네이버</span></a></li>
							<li class="facebook"><a href="" onclick="fnPopSNSLogin('fb','410','300');return false;"><i class="icon"></i><span class="text">페이스북</span></a></li>
						</ul>
					</div>
					<div class="helpV17">
						<a href="" onclick="jsGoURL('/member/join.asp');return false;" class="ftLt">회원가입하기 &gt;</a>
						<a href="" onclick="jsGoURL('/member/forget.asp');return false;" class="ftRt">아이디/비밀번호 찾기 &gt;</a>
					</div>
					</form>
					<%else%>
					<!-- STEP2 성인 본인인증 내용 -->
					<div id="adultCertify" class="login-input-cont adult-cont">
						<p class="fs14 ct cBk0V15">본인명의 휴대폰 번호로 <br />인증이 가능합니다.</p>
						<p class="tMar50" onclick=jsOpenCert()><a href="#" class="btn btnB1 btnRed">휴대폰 인증</a></p>
						<span class="fs13 tMar40 cGy3V15">인증 후 1년간은 별도 인증단계 없이 이용하실 수 있습니다.</span>
					</div>
					<form name="reqMobiForm" id="reqMobiForm" method="post" action=""></form>
					<script>
						//window.resizeTo(400, 500);
						function jsOpenCert() {
							window.resizeTo(435, 250);
							//var popupWindow = window.open( "", "KMCISWindow", "width=425, height=550, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=435, top=250" );
							document.getElementById('reqMobiForm').action = '/member/popCheckWhoAmI.asp';
							//document.reqMobiForm.target = "KMCISWindow";
							document.getElementById('reqMobiForm').submit();
							//popupWindow.focus();
						}
					</script>
					<%End if%>
				</div>

				
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