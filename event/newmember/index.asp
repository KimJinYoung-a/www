<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  텐바이텐 APP 다운로드
' History : 2018-12-14 이종화 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.memberGuide {background-color: #4deece; padding: 95px 0 54px;}
.memberGuide .topic {margin-bottom: 85px;}
.memberGuide .benefit {position: relative; margin-bottom: 16px;}
.memberGuide .benefit a {position: absolute; bottom: 100px; left: 0; width: 100%; outline: none; background: none; animation:shake 1s linear 15;}
@keyframes shake { 0%{transform:translateX(20px);} 50%{transform:translateX(0);} 100%{transform:translateX(20px);} }
</style>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="eventContV15">
				<div class="contF">
					
					<div class="memberGuide">
						<div class="inner">
							<p class="topic"><img src="http://webimage.10x10.co.kr/fixevent/event/2019/newmember/tit_newmember.png" alt="텐바이텐 신규 회원을 위한 혜택 가이드!"></p>
							<div class="benefit">
								<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/memberGuide/newmember/img_01_v2.png?v=1.01" alt="신규회원 가입하고, 쿠폰 받기! "></p>
								<a href="https://tenten.app.link/getQqS6CSX" onclick="fnAmplitudeEventAction('click_newmember_button','action','join');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/memberGuide/newmember/btn_join.png" alt="회원가입 하러 가기"></a>
							</div>
							<p class="benefit"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/memberGuide/newmember/img_02_v2.png" alt="APP설치하고, 쿠폰 받기!"></p>
							<p class="benefit"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/memberGuide/newmember/img_03_v2.png" alt="무료배송 및 마일리지 혜택 확인하기 !"></p>
						</div>
					</div>
					

				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->