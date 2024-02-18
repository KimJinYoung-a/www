<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 카카오톡 회원 인증하기 STEP1"		'페이지 타이틀 (필수)
dim userid, username, usrHp1, usrHp2, usrHp3
userid = GetLoginUserID
username = GetLoginUserName

dim myUserInfo
set myUserInfo = new CUserInfo
myUserInfo.FRectUserID = userid
if (userid<>"") then
    myUserInfo.GetUserData
    on Error Resume Next
    usrHp1 = SplitValue(myUserInfo.FOneItem.Fusercell,"-",0)
    usrHp2 = SplitValue(myUserInfo.FOneItem.Fusercell,"-",1)
    usrHp3 = SplitValue(myUserInfo.FOneItem.Fusercell,"-",2)
    On Error Goto 0
end if
set myUserInfo = Nothing
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
<!--
	function chkForm() {
		var frm = document.frm;

		if(!frm.hpNo1.value) {
			alert("휴대폰국번을 입력해주세요.")
			frm.hpNo1.focus();
			return false;
		}
		if(!IsDigit(frm.hpNo1.value)) {
			alert("휴대폰국번을 숫자로 입력해주세요.")
			frm.hpNo1.focus();
			return false;
		}

		if(!frm.hpNo2.value) {
			alert("휴대폰 앞자리를 입력해주세요.")
			frm.hpNo2.focus();
			return false;
		}
		if(!IsDigit(frm.hpNo2.value)) {
			alert("휴대폰 앞자리를 숫자로 입력해주세요.")
			frm.hpNo2.focus();
			return false;
		}

		if(!frm.hpNo3.value) {
			alert("휴대폰 뒷자리를 입력해주세요.")
			frm.hpNo3.focus();
			return false;
		}
		if(!IsDigit(frm.hpNo3.value)) {
			alert("휴대폰 뒷자리를 숫자로 입력해주세요.")
			frm.hpNo3.focus();
			return false;
		}

		if(!frm.infoSend.checked) {
			alert("서비스 이용에 동의하셔야 카카오톡 맞춤정보 서비스 신청이 가능합니다.")
			return false;
		}

		// 인증번호 받기 전송
		frm.target="ifmProc";
		frm.action="kakaoTalk_proc.asp";
		frm.mode.value="step1";
		return true;
	}
//-->
</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_kakao_talk_certify.gif" alt="카카오톡 인증 해제" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<form name="frm" method="POST" style="margin:0px;" onsubmit="return chkForm()">
				<input type="hidden" name="mode" value="step1">
				<input type="hidden" name="fullhp" value="">
				<div class="certCont">
					<fieldset>
					<legend>카카오톡 회원 인증하기</legend>
						<p class="result"><strong><%=username%>님의 개인정보에<br /> 저장된 휴대전화 번호는 아래와 같습니다.</strong></p>
						<!--p class="cr6aa7cc fs11 lsM1 tPad13">휴대전화번호를 수정하실 경우, 회원님 개인정보의 휴대전화번호도 수정됩니다.</p-->
						<div class="tMar25">
							<strong class="rPad10 fs12">휴대전화</strong>
							<input type="text" name="hpNo1" maxlength="4" value="<%=usrHp1%>" title="휴대전화 앞자리" value="010" class="txtInp crRed fb" style="width:48px;" />
							<span class="symbol">-</span>
							<input type="text" name="hpNo2" maxlength="4" value="<%=usrHp2%>" title="휴대전화 가운데자리" value="1234" class="txtInp crRed fb" style="width:48px;" />
							<span class="symbol">-</span>
							<input type="text" name="hpNo3" maxlength="4" value="<%=usrHp3%>" title="휴대전화 뒷자리" value="1234" class="txtInp crRed fb" style="width:48px;" />
						</div>

						<div class="help tMar25">
							<input type="checkbox" name="infoSend" id="agreeCheck" class="check" /> <label for="agreeCheck" class="lPad05"><strong class="cr555">카카오톡 사용자 확인을 위한 정보 제공 동의</strong></label>
							<p class="handling">(주)텐바이텐은 고객님의 휴대전화번호를 카카오톡 사용자 인증 목적으로<br />
							(주)카카오에 제공하게 되며, 인증 목적으로 제공된 휴대전화번호는<br />
							사용자 인증이 완료되는 대로 폐기됩니다.</p>
						</div>
						<div class="btnArea ct tMar20">
							<input type="submit" class="btn btnS1 btnRed btnW160 fs12" value="인증번호받기" />
							<button type="button" onClick="self.close()" class="btn btnS1 btnGry btnW160 fs12">취소하기</button>
						</div>
					</fieldset>
				</div>
				</form>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
	<iframe name="ifmProc" id="ifmProc" frameborder=0 width="0" height="0"></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->