<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
	'// 페이지 정보
	strPageTitle = "텐바이텐 10X10 : 회원 정보 변경"		'페이지 타이틀 (필수)
	strPageImage = "https://fiximage.10x10.co.kr/page/title/pageImage_member_v1.jpg"
	strPageDesc = "나의 정보를 수정 할 수 있습니다."
	'// 오픈그래프 메타태그
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] 회원 정보 변경"" />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""https://www.10x10.co.kr/my10x10/userinfo/confirmuser.asp"" />" & vbCrLf &_
						"<meta property=""og:description"" content=""" & strPageDesc & """>" & vbCrLf
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->

<%
dim errcode
errcode = request("errcode")

'####### POINT1010 에서 넘어온건지 체크 #######
Dim pFlag
pFlag	= requestCheckVar(request("pflag"),1)
'####### POINT1010 에서 넘어온건지 체크 #######
dim userid: userid = getEncLoginUserID ''GetLoginUserID

'네비바 내용 작성
'strMidNav = "MY 개인정보 > <b>개인정보 수정</b>"
'			   2020.12.16 정태훈 : 테스트 원복
%>
<script language='javascript'>
function TnConfirmlogin(frm){
	if (frm.userpass.value.length<1) {
		alert('비밀번호를 입력해주세요');
		frm.userpass.focus();
		return;
	}
	frm.action = '<%=SSLUrl%>/my10x10/userinfo/doConfirmUser.asp';
}

<%''간편로그인수정;허진원 2018.04.24%>
function fnPopSNSLogin(snsgb,wd,hi) {
	var snsbackpath = '<%=strBackPath%>';
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
	var popup = window.open("/login/mainsnslogin.asp?snsdiv="+snsgb+"&pggb=mc","","width="+wd+", height="+hi+", left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY);
}
</script>

<script FOR="window" EVENT="onload" LANGUAGE="javascript">
<%
	''간편로그인수정;허진원 2018.04.24
	if GetLoginUserDiv<>"05" then
%>
	$(function() {
		document.frmLoginConfirm.userpass.focus();
	});
<% end if %>
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
					</div>

					<div class="mySection">
						<form name="frmLoginConfirm" method="post" action="">
						<input type="hidden" name="pflag" value="<%=pFlag%>">
						<div class="pwConfirm">
							<fieldset>
							<legend>비밀번호 확인</legend>
							<%
								''간편로그인수정;허진원 2018.04.24
								if GetLoginUserDiv="05" then
							%>
								<h2><img src="http://fiximage.10x10.co.kr/web2018/my10x10/tit_sns_confirm.png" alt="SNS 인증 확인" /></h2>
								<p class="bPad10">회원님의 정보를 안전하게 보호하기 위해 계정을 다시 한 번 확인합니다.</p>
								<ul class="sns-accountV20">
									<li class="kakao"><a href="" onclick="fnPopSNSLogin('ka','470','570');return false;" class="icon kakao"><i class="icon"></i><span class="text">카카오톡</span></a></li>
									<li class="google"><a href="" onclick="fnPopSNSLogin('gl','410','420');return false;" class="icon google"><i class="icon"></i><span class="text">구글</span></a></li>
									<li class="naver"><a href="" onclick="fnPopSNSLogin('nv','400','800');return false;" class="icon naver"><i class="icon"></i><span class="text">네이버</span></a></li>
									<li class="facebook"><a href="" onclick="fnPopSNSLogin('fb','410','300');return false;" class="icon facebook"><i class="icon"></i><span class="text">페이스북</span></a></li>
								</ul>
							<% else %>
								<h2><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_password_confirm.gif" alt="비밀번호 확인" /></h2>
								<p class="bPad30">회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다.</p>
								<label for="pwcheck"><strong>비밀번호</strong></label>
								<input type="password" name="userpass" id="pwcheck" class="txtInp" maxlength="32" onKeyPress="if (event.keyCode == 13) TnConfirmlogin(frmLoginConfirm);" />
								<input type="submit" onclick="TnConfirmlogin(document.frmLoginConfirm);" value="확인" class="btn btnS1 btnRed btnW90" />
							<% end if %>
							</fieldset>
							<% if (errcode="1") then %>
							<!-- 비밀번호 입력 오류 --><p class="pwError"><span class="warning">비밀번호가 정확하지 않습니다.</span></p>
							<% end if %>
							<p class="handling">회원님의 개인정보를 신중히 취급하며, 회원님의 동의 없이는<br /> 기재하신 회원정보를 공개 및 변경하지 않습니다.</p>
						</div>
						</form>
					</div>

				</div>
				<!--// content -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
