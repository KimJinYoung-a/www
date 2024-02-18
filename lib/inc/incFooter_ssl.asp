<hr />
<div class="footer-wrap">
	<div class="foot-nav">
		<ul>
			<li><a href="http://company.10x10.co.kr/" target="_blank">회사소개</a></li>
			<li><a href="http://company.10x10.co.kr/Recruit/List/" target="_blank"><span class="icoV18 ico-new2">채용정보</span></a></li>
			<li><a href="/common/join.asp"><strong>이용약관</strong></a></li>
			<li><a href="/common/private.asp"><strong>개인정보 처리방침</strong></a></li>
			<li><a href="/common/youth.asp"><strong>청소년 보호정책</strong></a></li>
			<li><a href="" onclick="fnPopAlliance('a'); return false;">제휴/광고</a></li>
			<li><a href="" onclick="fnPopAlliance('s'); return false;">입점문의</a></li>
			<li><a href="http://www.10x10.co.kr/offshop/index.asp" target="_blank">매장안내</a></li>
			<!-- 다스배너 -->
			<!--<li class="diary notice"><a href="/diarystory2021/index.asp"><span>NOTICE</span>2021 다이어리 스토리</a></li>-->
		</ul>
	</div>
	<div class="footerV18">
		<span class="logo">10X10</span>
		<div class="foot-cont company">
			<em>㈜텐바이텐</em>
			<p>대표이사 : 최은희 / 서울시 종로구 대학로 57 홍익대학교 대학로캠퍼스 교육동 14층</p>
			<p>사업자등록번호 : 211-87-00620 / 통신판매업 신고 : 제 01-1968호 <a href="" onclick="window.open('http://www.ftc.go.kr/bizCommPop.do?wrkr_no=2118700620', 'bizCommPop', 'width=750, height=700;');return false;" class="btn-linkV18 link2 lMar05">사업자 정보확인 <span></span></a></p>
			<p>개인정보보호책임자 : 이문재 / 소비자피해보상보험 SGI 서울보증 <a href="javascript:usafe(2118700620);" class="btn-linkV18 link2 lMar05">서비스 가입 사실 확인 <span></span></a></p>
			<p class="tPad15">호스팅서비스:㈜텐바이텐</p>
			<p class="copyright">COPYRIGHT &copy; TENBYTEN ALL RIGHTS RESERVED.</p>
		</div>
		<div class="foot-cont cs">
			<div class="foot-cscenter">
                <a href="/cscenter/">
                    <p class="tit">고객센터 바로가기</p>
                    <div class="open-time"><span>운영시간</span> <span class="time">오전 10시 ~ 오후 5시 (주말, 공휴일 휴무)</span></div>
                    <div class="open-time lunch"><span>점심시간</span> <span class="time">오후 12시 30분 ~ 오후 1시 30분</span></div>
                </a>
            </div>
		</div>
        <div class="foot-sns">
            <a href="https://instagram.com/your10x10/"><img src="http://fiximage.10x10.co.kr/web2021/cscenter/icon_sns_instagram.png" alt="insta"></a>
            <a href="https://www.facebook.com/your10x10"><img src="http://fiximage.10x10.co.kr/web2021/cscenter/icon_sns_facebook.png" alt="facebook"></a>
            <a href="https://www.youtube.com/user/10x10x2010/"><img src="http://fiximage.10x10.co.kr/web2021/cscenter/icon_sns_you.png" alt="yotube"></a>
        </div>
		<p class="goTopV18"><span class="icoV18"></span>TOP</p>
	</div>
</div>
<% IF application("Svr_Info") <> "Dev1" THEN %>
	<%' Kakao Analytics 추가 (2018.05.09 원승현) %>
	<script type="text/javascript" charset="UTF-8" src="//t1.daumcdn.net/adfit/static/kp.js"></script>
	<script type="text/javascript">
		kakaoPixel('6348634682977072419').pageView();
		<%
			if trim(kakaoAnal_AddScript)<>"" then
				response.write kakaoAnal_AddScript
			end if
		%>
	</script>

	<%' Google NewAnalytics 추가 (2015.04.27 원승현) %>
	<script>
		(function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
		(i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
		m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
		})(window,document,'script','//www.google-analytics.com/analytics.js','ga');

		ga('create', 'UA-16971867-1', 'auto');
		ga('require','displayfeatures');
		ga('require', 'linkid', 'linkid.js');
		<%
		   if (googleANAL_PRESCRIPT<>"") then
				Response.Write googleANAL_PRESCRIPT
		   end if

		   if (googleANAL_EXTSCRIPT<>"") then
				Response.Write googleANAL_EXTSCRIPT
		   end if
		%>

		<% if session("appboySession")<>"" then %>
			ga('set', 'userId', '<%=session("appboySession")%>');
		<% end if %>

		ga('send', 'pageview');
	</script>

	<%' Google ADS %>
	<!-- Global site tag (gtag.js) - AdWords: 1013881501 -->
	<script async src="https://www.googletagmanager.com/gtag/js?id=AW-851282978"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());
		gtag('config', 'AW-851282978');
	</script>
	<% Response.Write googleADSCRIPT '기본 스크립트 %>

	<%' Firebase %>
	<script type="module">
	// Import the functions you need from the SDKs you need
	import { initializeApp } from "https://www.gstatic.com/firebasejs/9.10.0/firebase-app.js";
	import { getAnalytics } from "https://www.gstatic.com/firebasejs/9.10.0/firebase-analytics.js";
	// TODO: Add SDKs for Firebase products that you want to use
	// https://firebase.google.com/docs/web/setup#available-libraries

	// Your web app's Firebase configuration
	// For Firebase JS SDK v7.20.0 and later, measurementId is optional
	const firebaseConfig = {
		apiKey: "AIzaSyCWqZqP-w_OixKc8XJNKfL-Io3WISK_vuQ",
		authDomain: "tenbyten-1010.firebaseapp.com",
		projectId: "tenbyten-1010",
		storageBucket: "tenbyten-1010.appspot.com",
		messagingSenderId: "909756477465",
		appId: "1:909756477465:web:80f833860c847238b6ba88",
		measurementId: "G-4SK926ZKSP"
	};

	// Initialize Firebase
	const app = initializeApp(firebaseConfig);
	const analytics = getAnalytics(app);
	</script>

	<%' Facebook %>
	<% If (facebookSCRIPT<>"") Then %>
		<% Response.Write facebookSCRIPT %>
	<% Else %>
		<%' //기본 스크립트 %>
		<script>
			!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;
			n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;
			t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,document,'script','//connect.facebook.net/en_US/fbevents.js');
			fbq('init', '260149955247995');
			fbq('init', '889484974415237');
			if (Array.from){
				fbq('track', "PageView");
			}
		</script>
		<noscript><img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=260149955247995&ev=PageView&noscript=1" /></noscript>
		<noscript><img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=889484974415237&ev=PageView&noscript=1" /></noscript>		
	<% End If %>

	<%' Naver %>
	<script type="text/javascript" src="//wcs.naver.net/wcslog.js"></script>
	<% If (NaverSCRIPT<>"") Then %>
		<% Response.Write NaverSCRIPT %>
	<% End If %>	
	<script type="text/javascript">
		if (!wcs_add) var wcs_add={};
		wcs_add["wa"] = "s_1167df6db7ef";
		if (!_nasa) var _nasa={};
		wcs.inflow("10x10.co.kr");
		wcs_do(_nasa);
	</script>
	<%' Daum %>
	<% If (DaumSCRIPT<>"") Then %>
		<% Response.Write DaumSCRIPT %>
	<% End If %>

	<%' PC는 AMPLITUDE 값만 전송 %>
	<script type="text/javascript">
		<% '// AMPLITUDE 유저seq값 전송 %>
		<% If IsUserLoginOK Then %>
			<% If Trim(session("appboySession")) <> "" Then %>
				<% '// Amplitude 유저 아이디값 전송 %>
				//amplitude.getInstance().init('31e6741da66c20e94f5807bb844e129f', '<%=Trim(session("appboySession"))%>');
				<% '// Amplitude 성별 전송 %>
				<% if trim(session("appboyGender"))="M" then %>
					//var amplitudeIdentify = new amplitude.Identify().set('gender', 'male');
					//amplitude.getInstance().identify(amplitudeIdentify);
				<% elseif trim(session("appboyGender"))="F" then %>
					//var amplitudeIdentify = new amplitude.Identify().set('gender', 'female');
					//amplitude.getInstance().identify(amplitudeIdentify);
				<% end if %>
				<% '// Amplitude 나이 전송 %>
				<% if Trim(session("appboyDob"))<>"" then %>
					//var amplitudeIdentify = new amplitude.Identify().set('age', <%=( left(now(), 4) - left(Trim( session("appboyDob") ),4) )+1%> );
					//amplitude.getInstance().identify(amplitudeIdentify);
				<% end if %>
				<% '// Amplitude 회원등급 전송 %>
				//var amplitudeIdentify = new amplitude.Identify().set('userlevel', '<%=request.Cookies("appboy")("userlevel")%>');
				//amplitude.getInstance().identify(amplitudeIdentify);
				<% '// Amplitude 첫번째로그인일자 전송 %>
				//var amplitudeIdentify = new amplitude.Identify().setOnce('firstlogindate', '<%=left(request.Cookies("appboy")("firstLoginDate"),10)%>');
				//amplitude.getInstance().identify(amplitudeIdentify);
				<% '// Amplitude 최종로그인일자 전송 %>
				//var amplitudeIdentify = new amplitude.Identify().set('lastlogindate', '<%=left(request.Cookies("appboy")("lastLoginDate"),10)%>');
				//amplitude.getInstance().identify(amplitudeIdentify);
				<% '// Amplitude 보유쿠폰갯수 전송 %>
				//var amplitudeIdentify = new amplitude.Identify().set('couponcount', <%=request.cookies("etc")("couponCnt")%>);
				//amplitude.getInstance().identify(amplitudeIdentify);
				<% '// Amplitude 보유마일리지 전송 %>
				//var amplitudeIdentify = new amplitude.Identify().set('tenmileage', <%=request.cookies("etc")("currentmile")%>);
				//amplitude.getInstance().identify(amplitudeIdentify);
				<% '// Amplitude 현재장바구니상품갯수 전송 %>
				//var amplitudeIdentify = new amplitude.Identify().set('basketcount', <%=request.cookies("etc")("cartCnt")%>);
				//amplitude.getInstance().identify(amplitudeIdentify);
				<% '// Amplitude 최근3주 주문갯수 전송 %>
				//var amplitudeIdentify = new amplitude.Identify().set('ordercount3week', <%=request.cookies("etc")("ordCnt")%>);
				//amplitude.getInstance().identify(amplitudeIdentify);
				<% '// Amplitude 회원 전체 로그인 카운트 전송 %>
				//var amplitudeIdentify = new amplitude.Identify().set('logincount', <%=request.cookies("appboy")("loginCounter")%>);
				//amplitude.getInstance().identify(amplitudeIdentify);

				<% '// BranchIdentity값 전송 %>
				<%'// Branch Init %>
				<% if application("Svr_Info")="staging" Then %>
					//branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
				<% elseIf application("Svr_Info")="Dev" Then %>
					//branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
				<% else %>
					//branch.init('key_live_hpOucoij2aQek0GdzW9xFddbvukaW6le');
				<% end if %>
				//branch.setIdentity('<%=Trim(session("appboySession"))%>');

                if(typeof qg !== "undefined"){
                    qg("event", "login");

                    //let api_url = "http://localhost:8080/api/web/v1";
                    let api_url = "//fapi.10x10.co.kr/api/web/v1";
                    $.ajax({
                        type : "PUT"
                        , url : api_url + "/appier/userProfiles"
                        , crossDomain: true
                        , xhrFields: {
                            withCredentials: true
                        }
                        , data : {}
                        , success: function(message) {
                            qg("identify", {"user_id" : "<%=session("appboyUseq")%>"});
                        }
                    });
                }

				<%
					session.Contents.Remove("appboySession")
					session.Contents.Remove("appboyDob")
					session.Contents.Remove("appboyGender")
				%>
			<% End If %>
		<% End If %>
	</script>
<% End If %>

<script type="text/javascript">
	$(function(){
		//'탑으로 가기
		$('.footer .right2').click(function(){
			$('html, body').animate({scrollTop:0}, 'slow');
		});
	});
	//제휴(a), 입점(s) 문의 팝업
	function fnPopAlliance(gb){
		if(gb=='a'){
			var Alliance = window.open('http://company.10x10.co.kr/Views/pop/PopAlliance.asp','PopAlliance','width=920,height=820,scrollbars=yes');
		}else if(gb=='s'){
			var Alliance = window.open('http://company.10x10.co.kr/Views/pop/PopAlliance2.asp','PopAlliance','width=920,height=820,scrollbars=yes');
		}else{
			alert('잘못된 접속 입니다.');
			parent.location.reload();
			return;
		}
		Alliance.focus();
		return;
	}
</script>
<% if IsUserLoginOK() then %>
	<% if Not MyBadge_IsExist_LoginDateCookie() or MyBadge_IsExist_NewBadgeCookie() then %>
		<script type="text/javascript">
			$(function() {
				$("#myBadgePrevBtn").click(function(){
					$(".myBadgeList ul li:last").prependTo(".myBadgeList ul");
					$(".myBadgeList ul li").hide().eq(0).show();
				});

				$("#myBadgeNextBtn").click(function(){
					$(".myBadgeList ul li:first").appendTo(".myBadgeList ul");
					$(".myBadgeList ul li").hide().eq(0).show();
				});
			});

			var MB_rStr = "";
			MB_rStr = $.ajax({
				type: "GET",
				url: "/my10x10/inc/acct_myBadgeInfo.asp?t=<%=DateDiff("s", "01/01/1970 00:00:00", now())%>",
				dataType: "text",
				async: false
			}).responseText;

			MB_rStr = MB_rStr.replace(/(^\s*)|(\s*$)/gi, "").replace(/\\n/gi,"\n");
			if (MB_rStr != "") {
				viewPoupLayer("modal", MB_rStr);
			}
		</script>
	<% end if %>
<% end if %>

<%' 네오 스크립트 전송 %>
<script type="text/javascript">
var NeoclickConversionDctSv="type=1,orderID=,amount=";
var NeoclickConversionAccountID="22505";
var NeoclickConversionInnAccountNum="895";
var NeoclickConversionInnAccountCode="6124a52c47e704b805000009";
</script>
<script type="text/javascript" src="//ck.ncclick.co.kr/NCDC_V2.js"></script>
<%'// 네오 스크립트 전송 %>

<!-- Twitter universal website tag code -->
<script>
!function(e,t,n,s,u,a){e.twq||(s=e.twq=function(){s.exe?s.exe.apply(s,arguments):s.queue.push(arguments);
},s.version='1.1',s.queue=[],u=t.createElement(n),u.async=!0,u.src='//static.ads-twitter.com/uwt.js',
a=t.getElementsByTagName(n)[0],a.parentNode.insertBefore(u,a))}(window,document,'script');
// Insert Twitter Pixel ID and Standard Event data below
twq('init','o99y0');
twq('track','PageView');
</script>
<!-- End Twitter universal website tag code -->
<%
	'' 비회원 식별조회 2017/08/11
	Call fn_CheckNMakeGGsnCookie

	CALL fn_AddIISAppendToLOG_GGSN()
%>