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
dim chkCp
chkCp	= requestCheckVar(Request.form("cp"),1)

'// TMS 오픈 이벤트
if chkCp="Y" then
	'쿠폰 발급완료
	Response.Write "<script type='text/javascript'>alert('텐바이텐 맞춤정보 서비스 감사쿠폰이 발급됐습니다.\n\n쿠폰은 마이텐바이텐에서 확인하실 수 있습니다.');</script>"
end if

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/popup.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/popupV15.css" />
<script type="text/javascript">
<!--
	function doComplete() {
		try {
			opener.location.reload();
		} catch(e) {}
		self.close();
	}
//-->
</script>
</head>
<body>
	<div class="heightgird">
		<!-- #include virtual="/lib/inc/incPopupHeader.asp" -->
		<div class="popWrap">
			<div class="popHeader">
				<h1><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_kakao_talk_certify_finish.gif" alt="카카오톡 회원 인증 완료" /></h1>
			</div>
			<div class="popContent">
				<!-- content -->
				<div class="certCont">
					<div class="kakaoFinish">
						<p class="result"><strong>카카오톡<br /> 맞춤정보 서비스 신청이 완료되었습니다.</strong></p>
						<p class="cr6aa7cc fs11 lsM1 tPad13">이제 카카오톡으로 텐바이텐의 다양한 서비스를 만나보세요.</p>
						<div class="btnArea ct tMar20">
							<button type="button" onclick="doComplete()" class="btn btnS1 btnRed btnW100 fs12">확인</button>
						</div>
					</div>
				</div>
				<!-- //content -->
			</div>
		</div>
		<!-- #include virtual="/lib/inc/incPopupFooter.asp" -->
	</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->