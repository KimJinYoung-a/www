<%
Dim vSavedID
vSavedID = tenDec(request.cookies("mSave")("SAVED_ID"))
%>
<div id="loginLyr" class="window loginLyr">
	<div class="popHead">
		<h2><img src="/fiximage/web2013/common/tit_pop_login.gif" alt="LOGIN" /></h2>
		<p class="lyrClose"><img src="/fiximage/web2013/common/btn_pop_close.gif" alt="닫기" /></p>
	</div>
	<div class="popBody">
		<div class="lgnCont">
			<form name="frmLogin" method="post" action="">
				<fieldset>
				<legend>로그인</legend>
					<dl class="frmType">
						<dt><label for="loginId">아이디</label></dt>
						<dd class="inpFocus"><input type="text" name="userid" id="loginId" class="txtInp" value="<%=vSavedID%>" autocorrect="off" autocapitalize="off" maxlength="32" onkeypress="if (keyCode(event) == 13) frmLogin.userpass.focus();" style="ime-mode:disabled;" /></dd>
					</dl>
					<dl class="frmType">
						<dt><label for="loginPw">비밀번호</label></dt>
						<dd class="inpFocus"><input type="password" name="userpass" id="loginPw" class="txtInp" autocomplete="off" autocorrect="off" autocapitalize="off" onkeypress="if (keyCode(event) == 13) TnDologin(document.frmLogin);" /></dd>
					</dl>
				</fieldset>
				<p class="saveId"><input type="checkbox" name="saved_id" id="saveId" class="check" value="o" <% If vSavedID <> "" Then Response.Write "checked" End If %> /> <label for="saveId">아이디 저장</label></p>
				<p class="lgnBtn"><a href="" onclick="TnDologin(document.frmLogin); return false;" class="btn btnB1 btnRed btnW130">로그인</a></p>
			</form>
		</div>
		<ul class="help">
			<li>아직 텐바이텐 회원이 아니세요?<br /><a href="/member/join.asp" class="und">회원가입하기 &gt;</a></li>
			<li>아이디와 비밀번호를 잊으셨나요?<br /><a href="/member/forget.asp" class="und">아이디/비밀번호 찾기 &gt;</a></li>
		</ul>
	</div>
	<script type="text/javascript">
		function TnDologin(frm){
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
			frm.action = '<%=Replace(wwwUrl,"http://", "https://")%>/login/dologin.asp';
			frm.submit();
		}
	</script>
</div>