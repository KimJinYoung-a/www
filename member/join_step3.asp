<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'#######################################################
'	Description : 회원가입 Step3
'	History	:  2013.02.06 허진원 : 신규 회원가입 로직 생성
'              2013.07.29 허진원 : 2013리뉴얼
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 회원가입 STEP.03"		'페이지 타이틀 (필수)

	'## 로그인 여부 확인
	if IsUserLoginOK then
		Call Alert_Return("이미 회원가입이 되어있습니다.")
		dbget.close(): response.End
	end if

	'==============================================================================
	'세션에 저장된 아이디 확인
	dim txUserId, txUsermail, txUserCell, chkStat, sqlStr
	txUserId = session("sUserid")
	if txUserId="" then
	    call Alert_Return("잘못된 접근입니다.")
	    dbget.close(): response.end
	end if

	sqlStr = "Select usermail, usercell, userStat From db_user.dbo.tbl_user_n Where userid='" & txUserid & "' "
	rsget.Open sqlStr,dbget,1
	if Not(rsget.EOF or rsget.BOF) then
		txUsermail = rsget("usermail")
		txUserCell = rsget("usercell")
		chkStat = rsget("userStat")
	end if
	rsget.close

	if txUsermail="" then
	    call Alert_Return("회원 정보가 존재하지 않습니다.")
	    dbget.close(): response.end
	end if
	if isNull(chkStat) or chkStat="Y" then
	    call Alert_Move("감사합니다.\n이미 본인인증을 받으셨습니다.\n\n메인으로 이동합니다.","/")
	    dbget.close(): response.end
	end if

	'// 팝업창(레이어) 내용
	strPopupCont = "<div id='phoneLyr' class='window certLyr'></div>"

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript">
<!--
	// 본인인증 이메일 재발송
	function resendEmail() {
		var rstStr = $.ajax({
			type: "POST",
			url: "ajaxSendConfirmEmail.asp",
			data: "id=<%=txUserId%>",
			dataType: "text",
			async: false
		}).responseText;

		if (rstStr == "1"){
			alert("가입 승인 메일이 재발송 되었습니다.\n메일을 확인해주세요.");
		}else if (rstStr == "2"){
			alert("가입 승인 메일이 발송 되었습니다.\n메일을 확인해주세요.");
		}else if(rstStr == "3"){
			alert("회원 정보가 존재하지 않습니다.");
			history.back();
		}else if(rstStr == "4"){
			alert("감사합니다.\n이미 본인인증을 받으셨습니다.\n\n메인으로 이동합니다.");
			location.href="<%=wwwUrl%>/";
		}else{
			alert("발송 중 오류가 발생했습니다."+rstStr);
		}
	}

	// 본인인증 휴대폰SMS 발송
	function sendSMS() {
		var rstStr = $.ajax({
			type: "POST",
			url: "ajaxSendConfirmSMS.asp",
			data: "id=<%=txUserId%>",
			dataType: "text",
			async: false
		}).responseText;

		$("#phoneLyr").empty();
		$("#phoneLyr").html(rstStr);
	}
//-->
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="memPage">
				<h2><img src="http://fiximage.10x10.co.kr/web2013/member/tit_join.gif" alt="회원가입" /></h2>
				<p class="tPad10 bPad20"><img src="http://fiximage.10x10.co.kr/web2013/member/txt_join.gif" alt="디자인 감성채널 텐바이텐에 오신 것을 환영합니다." /></p>
				<ol class="joinStep">
					<li><img src="http://fiximage.10x10.co.kr/web2013/member/txt_join_step01_off.gif" alt="01.약관동의" /></li>
					<li><img src="http://fiximage.10x10.co.kr/web2013/member/txt_join_step02_off.gif" alt="02.정보입력" /></li>
					<li><img src="http://fiximage.10x10.co.kr/web2013/member/txt_join_step03_on.gif" alt="03.본인인증" /></li>
					<li><img src="http://fiximage.10x10.co.kr/web2013/member/txt_join_step04_off.gif" alt="04.가입완료" /></li>
				</ol>

				<div class="confirmMail box1 tBdr1">
					<p>
						<span class="crRed fs18"><%=txUsermail%></span> <img src="http://fiximage.10x10.co.kr/web2013/member/txt_mail01.gif" alt="으로" /><br />
						<img src="http://fiximage.10x10.co.kr/web2013/member/txt_mail02.gif" alt="회원가입 인증메일이 발송되었습니다." class="tPad05" />
					</p>
					<p class="tPad20"><img src="http://fiximage.10x10.co.kr/web2013/member/txt_mail03.gif" alt="12시간 안에 꼭 메일을 확인해 주세요. 가입승인기간 내에 승인을 하지 않으시면 회원가입이 취소됩니다." /></p>
				</div>
				<dl class="noArrival box2 tBdr2">
					<dt><img src="http://fiximage.10x10.co.kr/web2013/member/txt_mail04.gif" alt="인증메일이 도착하지 않았나요?" /></dt>
					<dd>
						<div class="mail">
							<p>인증메일이 도착하지 않았을 경우 ‘이메일 재발송’ 버튼을<br />클릭하시면 다시 메일을 받으실 수 있습니다.</p>
							<p class="tPad10"><span class="btn btnS1 btnGry btnW100" onclick="resendEmail()">이메일 재발송</span></p>
						</div>
						<div class="phone">
							<p>스팸으로 분류되어있어 확인 또는 가입승인이 불가능한 경우<br />'휴대폰 인증' 버튼을 클릭하시면 휴대폰으로 인증이 가능합니다.</p>
							<p class="tPad10"><a href="#phoneLyr" name="lyrPopup" class="btn btnS1 btnGry btnW100" onclick="sendSMS()">휴대폰 인증</a></p>
						</div>
					</dd>
				</dl>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->