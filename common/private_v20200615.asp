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
					<div class="nav-tab">
						<ul>
							<li style="width:50%;"><a href="/common/private.asp" style="padding:20px 0;" class="on"><strong>개인정보처리방침</strong></a></li>
							<li style="width:50%;"><a href="/common/youth.asp" style="padding:20px 0;" ><strong>청소년보호정책</strong></a></li>
						</ul>
					</div>
					<div class="anchorNav">
						<ul class="tPad30">
							<li><a href="#individual1">- 제 1조 총칙</a></li>
							<li><a href="#individual2">- 제 2조 수집하는 개인정보 항목 및 수집방법</a></li>
							<li><a href="#individual3">- 제 3조 개인정보의 공유 및 제공</a></li>
							<li><a href="#individual4">- 제 4조 수집한 개인정보 처리 위탁</a></li>
							<li><a href="#individual5">- 제 5조 개인정보의 보유, 이용기간</a></li>
							<li><a href="#individual6">- 제 6조 개인정보의 파기 절차</a></li>
							<li><a href="#individual7">- 제 7조 개인정보 처리를 위한 기술적, 관리적 대책</a></li>
							<li><a href="#individual8">- 제 8조 링크사이트</a></li>
						</ul>
						<ul class="wide tPad40">
							<li><a href="#individual9">- 제 9조 게시물</a></li>
							<li><a href="#individual10">- 제 10조 이용자의 권리와 의무</a></li>
							<li><a href="#individual11">- 제 11조 이용자 및 법정 대리인의 권리와 그 행사방법</a></li>
							<li><a href="#individual12">- 제 12조 개인정보 자동 수집 장치의 설치, 운영 및 그 거부에 관한 사항</a></li>
							<li><a href="#individual13">- 제 13조 개인정보 보호문의처</a></li>
							<li><a href="#individual14">- 제 14조 개인정보 보호 책임자 및 담당자</a></li>
							<li><a href="#individual15">- 제 15조 광고성 정보 전송</a></li>
							<li><a href="#individual16">- 제 16조 고지의 의무</a></li>
						</ul>
					</div>

					<div class="articleSection">
						<!-- #include virtual="/common/privateCont_v20200615.asp" -->
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
