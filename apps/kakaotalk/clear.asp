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
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%
'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 카카오톡 인증 해제"		'페이지 타이틀 (필수)
dim userid, username, usrHp1, usrHp2, usrHp3
userid = GetLoginUserID
username = GetLoginUserName

dim myUserInfo, chkKakao
chkKakao = false
set myUserInfo = new CUserInfo
myUserInfo.FRectUserID = userid
if (userid<>"") then
    myUserInfo.GetUserData
    chkKakao = myUserInfo.chkKakaoAuthUser	'// 카카오톡 인증여부
    usrHp1 = SplitValue(myUserInfo.FOneItem.Fusercell,"-",0)
    usrHp2 = SplitValue(myUserInfo.FOneItem.Fusercell,"-",1)
    usrHp3 = SplitValue(myUserInfo.FOneItem.Fusercell,"-",2)
end if
set myUserInfo = Nothing

if Not(chkKakao) then
	Call Alert_Close("카카오톡 서비스가 신청되어있지 않습니다.")
	Response.End
end if
%>

<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
<!--
	function chkForm() {
		var frm = document.frm;

		if(confirm("카카오톡 서비스를 해제하시겠습니까?")) {
			frm.target="ifmProc";
			frm.action="kakaoTalk_proc.asp";
			frm.mode.value="clear";
			frm.submit();
		}
	}
//-->
</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_kakao_talk_clear.gif" alt="카카오톡 회원 인증 해제" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="certCont">
					<fieldset>
					<legend>카카오톡 회원 인증하기</legend>
						<p class="result"><strong>카카오톡 맞춤정보 <em class="crRed">서비스를 해제</em>합니다.</strong></p>
						<p class="cr6aa7cc fs11 lsM1 tPad13"><strong><%=username%></strong>님의 개인정보에 저장된 휴대전화번호는 아래와 같습니다.</p>
						<div class="tMar25">
							<strong class="rPad10 fs12">휴대전화</strong>
							<input type="text" name="" maxlength="4" value="<%=usrHp1%>" title="휴대전화 앞자리" value="010" class="txtInp crRed fb" style="width:48px;" readonly />
							<span class="symbol">-</span>
							<input type="text" name="" maxlength="4" value="<%=usrHp2%>" title="휴대전화 가운데자리" value="1234" class="txtInp crRed fb" style="width:48px;" readonly />
							<span class="symbol">-</span>
							<input type="text" name="" maxlength="4" value="<%=usrHp3%>" title="휴대전화 뒷자리" value="1234" class="txtInp crRed fb" style="width:48px;" readonly />
						</div>

						<ul class="help tMar25">
							<li>서비스를 해제하시면, 카카오톡 맞춤정보 서비스를 받을 수 없게 됩니다.<br />
							단, 서비스 해제시에도 주문 및 배송관련 메일은 정보수신동의와는 별도로<br />
							SMS로 자동 발송 됩니다.</li>
						</ul>
						<div class="btnArea ct tMar20">
							<input type="submit" onClick="chkForm()" class="btn btnS1 btnRed btnW160 fs12" value="서비스 해제하기" />
						<!--	<button type="button" class="btn btnS1 btnGry btnW160 fs12">취소하기</button>	-->
						</div>
					</fieldset>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
<form name="frm" method="POST" style="margin:0px;">
<input type="hidden" name="mode" value="clear">
</form>
<iframe name="ifmProc" id="ifmProc" frameborder=0 width="0" height="0"></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->