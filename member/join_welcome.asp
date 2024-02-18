<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
'#######################################################
'	Description : 회원가입 완료페이지
'	History	:  2013.02.06 허진원 : 신규 회원가입 로직 생성
'              2013.07.29 허진원 : 2013리뉴얼
'              2017.05.23 유태욱 : 2017리뉴얼
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 회원가입을 환영합니다!"		'페이지 타이틀 (필수)

	dim txUserId, evtFlag, useqValue
	evtFlag = requestCheckVar(Request("eFlg"),1)
	txUserId = session("sUserid")

	'// Biz 회원가입 여부(SNS회원가입에서는 비활성화)
	Dim isBiz : isBiz = ChkIIF(request("biz")="Y","Y","N")

	'RecoPick 스크립트 incFooter.asp에서 출력; 2014.10.17 원승현 추가
	RecoPickSCRIPT = "	recoPick('page', 'member');"

	'// appBoy CustomEvent
	appBoyCustomEvent = "appboy.logCustomEvent('userJoin');"

	'// Kakao Analytics
	kakaoAnal_AddScript = "kakaoPixel('6348634682977072419').completeRegistration();"

	Dim strsql, routeSite
	
	If txUserId <> "" Then
		'// 해당 유저가 어디를 통해서 가입했는지 확인
		strsql = "Select top 1 snsgubun, tenbytenid From [db_user].[dbo].tbl_user_sns Where tenbytenid='"&txUserId&"' "
		rsget.Open strsql,dbget,1
		IF Not rsget.Eof Then
			Select Case Trim(rsget("snsgubun"))
				Case "nv"
					routeSite = "naver"
				Case "ka"
					routeSite = "kakao"
				Case "fb"
					routeSite = "facebook"
				Case "gl"
					routeSite = "google"
				Case Else
					routeSite = ""
			End Select
		Else
			routeSite = "normal"
		End IF
		rsget.close

		'// 해당 유저의 useq 값을 가져옴
		strsql = "Select top 1 useq*3 From [db_user].[dbo].tbl_logindata WITH(NOLOCK) Where userid='"&txUserId&"' "
		rsget.Open strsql,dbget,1
		IF Not rsget.Eof Then
			useqValue = rsget(0)
		Else
			useqValue = ""
		End If
		rsget.close
	End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script>
	<% 	If txUserId <> "" Then %>
		<%' amplitude 이벤트 로깅 %>
			fnAmplitudeEventMultiPropertiesAction('complete_signup','route','<%=routeSite%>');
		<%'// amplitude 이벤트 로깅 %>

		/*
        * Appier Event Logging
        * */
        if(typeof qg !== "undefined"){
            let now = new Date();
            let month = now.getMonth()+1;
            if(month < 10){
                month = "0" + month;
            }
            qg("event", "registration_completed", {"register_date" : now.getFullYear() + "-" + month + "-" + now.getDate(), "register_type" : "<%=routeSite%>"});
        }
		<%' Branch Event Logging %>
			<%'// Branch Init %>
			<% if application("Svr_Info")="staging" Then %>
				branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
			<% elseIf application("Svr_Info")="Dev" Then %>
				branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
			<% else %>
				branch.init('key_live_hpOucoij2aQek0GdzW9xFddbvukaW6le');
			<% end if %>
			branch.logEvent(
				"complete_signup",
				function(err) { console.log(err); }
			);
		<%'// Branch Event Logging %>
	<% end if %>
</script>
<!-- Twitter universal website tag code -->
<script>
	!function(e,t,n,s,u,a){e.twq||(s=e.twq=function(){s.exe?s.exe.apply(s,arguments):s.queue.push(arguments);
	},s.version='1.1',s.queue=[],u=t.createElement(n),u.async=!0,u.src='//static.ads-twitter.com/uwt.js',
	a=t.getElementsByTagName(n)[0],a.parentNode.insertBefore(u,a))}(window,document,'script');

	twq('init','o99y0');
	twq('track','SignUp');
</script>
<!-- End Twitter universal website tag code -->
</head>
<body>
<div class="wrap fullEvt">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<% if isBiz = "Y" then %>
	<div class="container tenBiz">
		<div id="contentWrap">
			<div class="bizStepLast">
				<div class="stepCircle">
                    <div>
                        <p>회원가입</p>
                        <p>신청</p>
                    </div>
                    <div>
                        <p>회원가입</p>
                        <p>승인</p>
                    </div>
                    <div>
                        <p>회원가입</p>
                        <p>완료</p>
                    </div>
                </div>
                <p class="tit">BIZ <em>가입 신청이 완료</em>되었습니다</p>
                <p class="subTxt">회원가입 승인 후 텐바이텐 BIZ 상품을 구매하실 수 있어요!<br/>
                    가입 승인은 최대 24시간 내 이루어집니다.</p>
                <div class="btnArea">
                    <a href="/biz/" class="btnPage">첫 화면으로 이동하기</a>
                </div>
			</div>
		</div>
	</div>
	<% else %>
	<div class="container joinFinishV17">
		<div id="contentWrap">
			<div>
				<span><img src="http://fiximage.10x10.co.kr/web2020/common/img_congratulations.png" alt=""></span>
				<p class="welcome-txt">텐바이텐 <em>가입이 완료</em>되었습니다</p>
				<p class="user"><strong><%=txUserId%></strong><img src="http://fiximage.10x10.co.kr/web2017/member/txt_welcome2.png" alt="님 환영합니다!" /></p>
				<div class="welcome-coupon">
					<p>지금 신규 축하쿠폰이 발급되었으니, <em>24시간 이내</em> 꼭 사용해보세요!</p>
					<ul>
						<li>
							<div class="benefit">30,000<span>원</span></div>
							<p class="condition">30만원 이상 구매 시</p>
						</li>
						<li>
							<div class="benefit">10,000<span>원</span></div>
							<p class="condition">15만원 이상 구매 시</p>
						</li>
						<li>
							<div class="benefit">5,000<span>원</span></div>
							<p class="condition">7만원 이상 구매 시</p>
						</li>
					</ul>
					<div class="btnGroupV19">
						<a href="/" class="btn btn-white btn-line-red">첫 화면으로 가기</a>
						<% If request.cookies("sToMUP") <> "" Then %>
							<a href="<%=tenDec(request.cookies("sToMUP"))%>" class="btn btn-red">쇼핑 계속하기</a>
						<% End If %>
					</div>
				</div>
			</div>
		</div>
	</div>
	<% end if %>
	<%
		'페이스북 스크립트 incFooter.asp에서 출력; 2016.01.15 허진원 추가
		facebookSCRIPT = "<script>" & vbCrLf &_
						"!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;" & vbCrLf &_
						"n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;" & vbCrLf &_
						"t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,document,'script','//connect.facebook.net/en_US/fbevents.js');" & vbCrLf &_
						"fbq('init', '260149955247995');" & vbCrLf &_
						"fbq('init', '889484974415237');" & vbCrLf &_
						"fbq('track','PageView');" & vbCrLf &_
						"fbq('track', 'CompleteRegistration');</script>" & vbCrLf &_
						"<noscript><img height=""1"" width=""1"" style=""display:none"" src=""https://www.facebook.com/tr?id=260149955247995&ev=PageView&noscript=1"" /></noscript>" & vbCrLf &_
						"<noscript><img height=""1"" width=""1"" style=""display:none"" src=""https://www.facebook.com/tr?id=889484974415237&ev=PageView&noscript=1"" /></noscript>"												

		'다음 로그 스크립트 생성 incFooter.asp에서 출력; 2016.08.11 허진원 추가
		DaumSCRIPT = "<script type=""text/javascript"">" & vbCrLf &_
					" //<![CDATA[" & vbCrLf &_
					"var DaumConversionDctSv=""type=M,orderID=,amount="";" & vbCrLf &_
					"var DaumConversionAccountID=""7mD4DqS5ilDMtl4e6Sc7kg00"";" & vbCrLf &_
					"if(typeof DaumConversionScriptLoaded==""undefined""&&location.protocol!=""file:""){" & vbCrLf &_
					"	var DaumConversionScriptLoaded=true;" & vbCrLf &_
					"	document.write(unescape(""%3Cscript%20type%3D%22text/javas""+""cript%22%20src%3D%22""+(location.protocol==""https:""?""https"":""http"")+""%3A//t1.daumcdn.net/cssjs/common/cts/vr200/dcts.js%22%3E%3C/script%3E""));" & vbCrLf &_
					"}" & vbCrLf &_
					"//]]>" & vbCrLf &_
					"</script>"
	%>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<%' 크레센도 스크립트 추가 %>
<script type="text/javascript"> csf('event','2','',''); </script>
<%'// 크레센도 스크립트 추가 %>
<%' 네오 스크립트 전송 %>
<script type="text/javascript"> 
var NeoclickConversionDctSv="type=2,orderID=,amount=";
var NeoclickConversionAccountID="22505";
var NeoclickConversionInnAccountNum="895";
var NeoclickConversionInnAccountCode="6124a52c47e704b805000009";
</script>
<script type="text/javascript" src="//ck.ncclick.co.kr/NCDC_V2.js"></script>
<%'// 네오 스크립트 전송 %>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->