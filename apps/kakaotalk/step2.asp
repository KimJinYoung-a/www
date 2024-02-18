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
<%
'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 카카오톡 회원 인증하기 STEP2"		'페이지 타이틀 (필수)
dim fullhp
fullhp = requestCheckVar(Request.form("fullhp"),12)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
<!--
	function chkForm() {
		var frm = document.frm;

		if(!frm.certifyNo.value) {
			alert("카카오톡으로 받으신 인증번호를 입력해주세요.")
			frm.certifyNo.focus();
			return false;
		}
		if(!IsDigit(frm.certifyNo.value)) {
			alert("인증번호는 숫자로 입력해주세요.")
			frm.certifyNo.focus();
			return false;
		}

		// 인증번호 받기 전송
		frm.target="ifmProc";
		frm.action="kakaoTalk_proc.asp";
		frm.mode.value="step2";
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
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_kakao_talk_certify.gif" alt="카카오톡 회원 인증하기" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<form name="frm" method="POST" style="margin:0px;" onsubmit="return chkForm()">
				<input type="hidden" name="mode" value="step2">
				<input type="hidden" name="fullhp" value="<%=fullhp%>">
				<input type="hidden" name="cp" value="">
				<div class="certCont">
					<fieldset>
					<legend>카카오톡 회원 인증하기</legend>
						<p class="result"><strong>카카오톡으로 받으신<br /> 인증번호를 입력한 후 확인을 눌러주세요.</strong></p>
						<p class="cr6aa7cc fs11 lsM1 tPad13">인증을 완료하실 경우, 텐바이텐이 카카오톡 플러스 친구로 자동 추가됩니다.</p>
						<div class="tMar25">
							<label for="certifyNo"><strong class="rPad10 fs12">인증번호</strong></label>
							<input type="text" name="certifyNo" maxlength="4" value="" id="certifyNo" class="txtInp" style="width:128px;" />
						</div>

						<ul class="help tMar25">
							<li>카카오톡으로 받으신 인증번호를 입력한 후 확인을 누르면,<br />
							카카오톡 맞춤정보 서비스 신청이 완료됩니다.</li>
						</ul>
						<div class="btnArea ct tMar20">
							<input type="submit" class="btn btnS1 btnRed btnW100 fs12" value="확인" />
							<button type="button" onClick="self.close()" class="btn btnS1 btnGry btnW100 fs12">취소</button>
						</div>
					</fieldset>
				</div>
				</form>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
<iframe name="ifmProc" id="ifmProc" frameborder=0 width="100%" height="50"></iframe>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->