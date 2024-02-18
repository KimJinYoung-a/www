<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 개인정보처리방침"		'페이지 타이틀 (필수)
strPageDesc = ""		'페이지 설명
strPageImage = ""		'페이지 요약 이미지(SNS 퍼가기용)
strPageUrl = ""			'페이지 URL(SNS 퍼가기용)

%>
<!-- #include virtual="/lib/inc/head.asp" -->

<script type="text/JavaScript">

function pop_private_partner_company(){
	var popwin = window.open('/common/private_partner_company.asp','private_partner_company','width=600,height=960,scrollbars=yes,resizable=yes');
	popwin.focus();
}

</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="csContent">
				<!-- #include virtual="/lib/inc/incCsLnb.asp" -->

				<!-- content -->
				<div class="content indivi-policy">
					<div class="articleSection" style="margin-top:0">
						<!-- #include virtual="/common/privateCont3.asp" -->
					</div>
				</div>
				<!-- //content -->

				<!-- #include virtual="/lib/inc/incCsQuickmenu.asp" -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
