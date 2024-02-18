<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2009.06.16 허진원 생성
'	Description : 네이트온 알리미 연동전용 로그인 팝업
'#######################################################

response.end  ''2017/04/20
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>네이트온 알리미</title>
<link rel="stylesheet" type="text/css" href="./css/popup.css" />
<script language="javascript">
<!--
function checkLogin() {
	frm = document.login;
	if(!document.getElementsByName("agree")[0].checked&&!document.getElementsByName("agree")[1].checked) {
		alert("회원연동 동의여부를 체크해주세요.");
		return;
	} else if(document.getElementsByName("agree")[1].checked) {
		alert("동의하지 않으시면 연동하실 수 없습니다.");
		return;
	}

	if (frm.userid.value.length<1) {
		alert('아이디를 입력하세요.');
		frm.userid.focus();
		return;
	}

	if (frm.userpass.value.length<1) {
		alert('패스워드를 입력하세요.');
		frm.userpass.focus();
		return;
	}
	frm.action = '<%=SSLUrl%>/apps/nateon/dologin.asp';
	frm.submit();
	
}

function selfClose() {
	if (/MSIE/.test(navigator.userAgent)) { 
		if(navigator.appVersion.indexOf("MSIE 8.0")>=0) {
			window.opener='Self';
			window.open('','_parent','');
			window.close();
		} else if(navigator.appVersion.indexOf("MSIE 7.0")>=0) {
			window.open('about:blank','_self').close();
		} else { 
			window.opener = self;
			self.close();
		}
	} else {
		self.close();
	}
}
//-->
</script>
</head>
<body scroll=no>
<div class="wrap auth_linkage">
	<h1>NATE connect</h1>
	<p class="connect">
		<a href="http://hello.nate.com/nateconnect" target = "_blank"><strong>네이트커넥트</strong>란?</a>
	</p>
	<h2>네이트온 알리미</h2>
	
	<h3><b>텐바이텐</b> - 네이트온 회원연동</h3>

	<hr class="layout" />

	<p class="help">
		<a href="http://nateonalarm.nate.com/service_info.php" target = "_blank">알리미서비스란?</a>
	</p>

	<div class="container">
		<h4><img src="./img/popup_BI_01.gif" alt="텐바이텐" /></h4>
		<div class="agreement">
			<ul>
				<li> 네이트온에서 <b>텐바이텐</b> 알리미를 이용하기 위해서는 <b>텐바이텐</b> 아이디와 비밀번호를 입력하여 네이트온과 연동해야 합니다. 
				<li> 연동 과정에서 회원님의 <b>텐바이텐</b>의 아이디 정보가 네이트온에 전달되고, 네이트온과 <b>텐바이텐</b>의 연동만을 위해서 사용됩니다. 
				<li> 연동 해제시, 연동을 위해 네이트온에 저장된 회원님의 정보는 삭제됩니다. 
				<li> 네이트온에서 <b>텐바이텐</b> 알리미 이용 시, 최초 1회만 연동 관련 사항에 대한 동의를 받습니다. 
				<li> 위 사항에 동의 후 연동하면, 네이트온에서 <b>텐바이텐</b> 알리미를 실시간으로 받아보실 수 있습니다.
					
			</ul>

			<p>
				<strong>위 사항에 동의하시겠습니까?</strong>
				<input type="radio" id="agree" name="agree" /><label for="agree">동의함</label>
				<input type="radio" id="disagree" name="agree" /><label for="disagree">동의하지 않음</label>
			</p>
		</div>

		<p class="info">
			네이트온 알리미 이용을 위해 <b>텐바이텐</b> 아이디/비밀번호를 입력해 주세요. <BR>
		</p>

		<!-- 연동 폼 -->
		<div class="linkage_form">
			<form id="login" name="login" action="" target="_top" method="post" onsubmit="return chkForm(this)">
			<fieldset>
				<legend>연동하기</legend>
				<span class="email">
					<label for="email">아이디</label><input type="text" name="userid" autocomplete="off" maxlength="32" title="아이디 입력" />
				</span>
				<span class="passwd">
					<label for="passwd">비밀번호</label><input type="password" name="userpass" maxlength="32" title="비밀번호 입력" onkeypress="this.className='bg'; if (13 == event.keyCode) checkLogin();"/>
				</span>
				<input type="button" class="submit" title="연동하기" value="연동하기" onClick="checkLogin()" />
			</fieldset>
			</form>
			<p class="login_account">
				<a href='http://www.10x10.co.kr/member/forget.asp?rdsite=nateon' target="_blank">아이디·비밀번호찾기</a>
				<i>|</i>
				<a href='http://www.10x10.co.kr/member/join.asp?rdsite=nateon' target="_blank">텐바이텐 회원가입하기</a>
			</p>
		</div>
		<!-- //연동 폼 -->
	</div>

	<hr class="layout" />

	<div class="button">
		<button type="button" class="close" onclick="selfClose();">닫기</button>
	</div>
</div>
</body>
</html>
