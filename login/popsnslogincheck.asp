<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim pggb , fnname , fnform
strPageTitle = "텐바이텐 10X10 : 정보 수정"		'페이지 타이틀 (필수)
pggb = requestCheckVar(request("pggb"),2)
fnname = requestCheckVar(request("fnname"),10)
fnform = requestCheckVar(request("fnform"),20)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup_ssl.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script>
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
	var popup = window.open("/login/mainsnslogin.asp?snsdiv="+snsgb+"&pggb=<%=pggb%>&fnname=<%=fnname%>&fnform=<%=fnform%>","","width="+wd+", height="+hi+", left="+ popupX + ", top="+ popupY + ", screenX="+ popupX + ", screenY= "+ popupY);
}
</script>
</head>
<body>
<div class="heightgird">
	<div class="popWrap">
		<div class="popHeader">
			<h1><img src="//fiximage.10x10.co.kr/web2013/inipay/tit_personal_info_edit.gif" alt="개인정보 수정"></h1>
		</div>
		<div class="popContent">
			<div class="orderWrap">
				<p class="ct fs14 tMar10"><strong>개인정보 보호를 위해 계정을 다시 한번 확인합니다.<br> SNS 계정을 선택해주세요</strong></p>
				<fieldset>
					<legend>개인정보 수정</legend>
					<ul class="sns-accountV20 tMar30">
						<li class="kakao"><a href="" onclick="fnPopSNSLogin('ka','470','570');return false;" class="icon kakao"><i></i><span class="text">카카오톡</span></a></li>	
						<!--<li class="apple"><a href=""><i class="icon"></i><span class="text">애플</span></a></li>-->
						<li class="google"><a href="" onclick="fnPopSNSLogin('gl','410','420');return false;" class="icon google"><i></i><span class="text">구글</span></a></li>
						<li class="naver"><a href="" onclick="fnPopSNSLogin('nv','400','800');return false;" class="icon naver"><i></i><span class="text">네이버</span></a></li>
						<li class="facebook"><a href="" onclick="fnPopSNSLogin('fb','410','300');return false;" class="icon facebook"><i></i><span class="text">페이스북</span></a></li>
					</ul>
				</fieldset>
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

<!-- #include virtual="/lib/db/dbclose.asp" -->
