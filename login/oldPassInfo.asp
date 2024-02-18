<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.CharSet = "UTF-8"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<%
dim backpath
backpath 		= ReplaceRequestSpecialChar(request("backpath"))
if backpath="" then backpath=wwwUrl &"/"
%>
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 비빌번호 변경 안내"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader_ssl.asp" -->
	<div class="container">
		<div id="contentWrap">
		<!-- // 본문 시작 //-->
			<script type='text/javascript'>
			<!--
				function chkForm(frm) {
					if(!frm.orgpwd.value) {
						alert("현재 비밀번호를 입력해주세요.");
						frm.orgpwd.focus();
						return false;
					}
			
					if(!frm.upwd.value) {
						alert("새 비밀번호를 입력해주세요.");
						frm.upwd.focus();
						return false;
					}
					if(!frm.upwd2.value) {
						alert("새 비밀번호 확인을 입력해주세요.");
						frm.upwd2.focus();
						return false;
					}
					if(frm.orgpwd.value==frm.upwd.value) {
						alert("현재 비밀번호를 그대로 사용하실 수 없습니다.\n다른 비밀번호를 사용해주세요.");
						frm.upwd.focus();
						return false;
					}
					if(frm.upwd.value==frm.uid.value) {
						alert("아이디와 다른 비밀번호를 사용해주세요.");
						frm.upwd.focus();
						return false;
					}

					if (frm.upwd.value.length < 8 || frm.upwd.value.length > 16){
						alert("비밀번호는 공백없이 8~16자입니다.");
						frm.upwd.focus();
						return false;
					}

					if(frm.upwd.value!=frm.upwd2.value) {
						alert("새 비밀번호 확인이 틀립니다.\n정확한 비밀번호를 입력해주세요.");
						frm.upwd2.focus();
						return false;
					}

					if (!fnChkComplexPassword(frm.upwd.value)) {
						alert('패스워드는 영문/숫자/특수문자 중 두 가지 이상의 조합으로 입력해주세요.');
						frm.upwd.focus();
						return false;
					} else {
						return true;
					}
				}
			
				// 쿠키 설정
				function setCookie( name, value, expiredays) {
					var todayDate = new Date();
					var dom = document.domain;
					var _domain = "";
					if(dom.indexOf("10x10.co.kr") > 0){
						_domain = "10x10.co.kr";
					}
					todayDate.setDate( todayDate.getDate() + expiredays );
					document.cookie = name + "=" + escape( value ) + "; domain="+_domain+"; path=/; expires=" + todayDate.toGMTString() + ";"
				}
			
				// 다음에변경 클릭(1주일간 변경페이지 표시 안함)
				function chgNextTime() {
					setCookie( "chkChgPass", "done" , 7 ); 
					location.replace("<%=backpath%>");
				}
			//-->
			</script>
			<form name="chgpass" method="post" action="/login/doPassModi.asp" target="FrameCKP" onSubmit="return chkForm(this)" style="margin:0px;padding:20px 0;">
			<input type="hidden" name="backpath" value="<%= backpath %>">
			<input type="hidden" name="uid" value="<%= getLoginUserId() %>">
			<table width="960" border="0" align="center" cellpadding="8" cellspacing="0">
			<tr>
				<td align="center" bgcolor="#eaeaea" align="center">
					<table width="944" border="0" cellpadding="0" cellspacing="0" bgcolor="#ffffff" >
					<tr>
						<td align="center" style="background:url(/fiximage/web2011/password/img_top.gif) repeat-x 0 0;"><img src="/fiximage/web2011/password/img_top.gif" width="944" height="191" /></td>
					</tr>
					<tr>
						<td align="center" style="padding:50px 50px;"><img src="/fiximage/web2011/password/img_top02.gif" width="690" height="42" /></td>
					</tr>
					<tr>
						<td align="center">
							<table width="690" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<!-- 비밀번호 변경박스 시작 -->
								<td align="center" valign="middle" bgcolor="#f7f7f7">
									<table border="0" cellspacing="0" cellpadding="0" style="width:70%;">
									<tr>
										<td align="center">
											<table border="0" cellspacing="0" cellpadding="0" style="width:70%;">
											<tr>
												<td style="width:120px; text-align:left;"><img src="/fiximage/web2011/password/img_tit01.gif" width="78" height="15" /></td>
												<td><input type="password" name="orgpwd" value="" style="width:250px; ime-mode:disable;" class="txtInp" /></td>
											</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td height="20" class="red_11px"><!-- * 키보드에 Capslook이 켜져 있습니다. --></td>
									</tr>
									<tr><td height="3" bgcolor="#dddddd"></td></tr>
									<tr>
										<td align="center" style="padding-top:20px;">
											<table border="0" cellspacing="0" cellpadding="0" style="width:70%;">
											<tr>
												<td style="width:120px; text-align:left;"><img src="/fiximage/web2011/password/img_tit02.gif" width="66" height="15" /></td>
												<td><input type="password" name="upwd" value="" style="width:250px; ime-mode:disable;" class="txtInp" /></td>
											</tr>
											</table>
										</td>
									</tr>
									<tr>
										<td class="fs11" style="padding:8px 0 15px 200px; text-align:left;">* 공백없는 8~16자의 영문/숫자 조합</td>
									</tr>
									<tr>
										<td align="center">
											<table border="0" cellspacing="0" cellpadding="0" style="width:70%;">
											<tr>
												<td style="width:120px; text-align:left;"><img src="/fiximage/web2011/password/img_tit03.gif" width="95" height="15" /></td>
												<td><input type="password" name="upwd2" value="" style="width:250px; ime-mode:disable;" class="txtInp" /></td>
											</tr>
											</table>
										</td>
									</tr>
									</table>
								</td>
								<!-- 비밀번호 변경박스 끝 -->
								<td width="340" valign="top" style="padding-left:10px;"><img src="/fiximage/web2011/password/img_caution.gif" width="340" height="225" style="display:inline; vertical-align:top;"/></td>
							</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td align="center" style="padding-top:50px;">
							<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td align="right" style="vertical-align:top;"><input type="image" src="/fiximage/web2011/password/btn_pw.gif" border="0" style="width:172px; height:48px;"></td>
								<td style="padding-left:10px; vertical-align:top; text-align:left;"><a href="#" onclick="chgNextTime()"><img src="/fiximage/web2011/password/btn_pwpass.gif" width="172" height="48" border="0"></a></td>
							</tr>
							</table>
						</td>
					</tr>
					</table>
				</td>
			</tr>
			</table>
			</form>
			<iframe name="FrameCKP" src="" frameborder="0" width="0" height="0"></iframe>
		<!-- // 본문 끝 //-->
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter_ssl.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->