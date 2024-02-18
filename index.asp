<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 메인페이지
' History : 2018-03-05 생성
'###########################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_chkExpireLogin.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'///// 모바일 접속시 모바일 페이지도 이동 /////

if Request("mfg")="pc" or session("mfg")="pc" then
	session("mfg") = "pc"
else
	if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
		Response.Redirect "http://m.10x10.co.kr"
		REsponse.End
	end if
end if

''//2018/08/14 SSL redirect
if (FALSE) then ''다시검토
	If Request.ServerVariables("HTTPS") = "off" Then
		if (Request.ServerVariables("QUERY_STRING")<>"") then
			Response.Redirect "https://" & Request.ServerVariables("HTTP_HOST") & "/?" & Request.ServerVariables("QUERY_STRING")
		else
			if (Request.ServerVariables("URL")<>"/index.asp") then
				Response.Redirect "https://" & Request.ServerVariables("HTTP_HOST") & Request.ServerVariables("URL")
			else
				Response.Redirect "https://" & Request.ServerVariables("HTTP_HOST")
			end if
		end if
		response.end
	end if
end if

if (application("Svr_Info")="Dev") then
	response.write session("ssnuserbizconfirm") & "/"
	response.write "it is Dev"
elseif (application("Svr_Info")="staging") then
	response.write "it is Staging"
end if
	dim parentsPage : parentsPage = "today"
	Dim amplitudeOnlyBrand

	'// 구글 ADS 스크립트 관련(2018.09.21 신규버전 추가)
	googleADSCRIPT = "<script> "
	googleADSCRIPT = googleADSCRIPT & "	gtag('event', 'page_view', { "
	googleADSCRIPT = googleADSCRIPT & "		'send_to': 'AW-851282978', "
	googleADSCRIPT = googleADSCRIPT & "		'ecomm_pagetype': 'home', "
	googleADSCRIPT = googleADSCRIPT & "		'ecomm_prodid': '', "
	googleADSCRIPT = googleADSCRIPT & "		'ecomm_totalvalue': '' "
	googleADSCRIPT = googleADSCRIPT & "	}); "
	googleADSCRIPT = googleADSCRIPT & "</script> "

	'//크리테오에 보낼 md5 유저 이메일값
	If Trim(session("ssnuseremail")) <> "" Then
		CriteoUserMailMD5 = MD5(Trim(session("ssnuseremail")))
	Else
		CriteoUserMailMD5 = ""
	End If

%>
<link rel="stylesheet" type="text/css" href="/lib/css/mainV18.css?v=1.61">
<script type="text/javascript" src="/lib/js/jquery.kxbdmarquee.js"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.easypiechart.min.js"></script>

<script type="text/javascript" src="https://unpkg.com/instafeed.js@2.0.0/dist/instafeed.js"></script>
<script>
function getInternetExplorerVersionChk() {
	var rv = -1; // Return value assumes failure.
	if (navigator.appName == 'Microsoft Internet Explorer') {
		var ua = navigator.userAgent;
		var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
		if (re.exec(ua) != null)
			rv = parseFloat(RegExp.$1);
		}
	return rv;
}

$(function() {
	//ie8 버전 이하 알림
	$('.version-noti .btn-close').click(function(){
		$(".version-noti").slideUp();
	});

	AmplitudeEventSend('MainLanding', '', 'event');

	<%'// Branch Init %>
	<% if application("Svr_Info")="staging" Then %>
		branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
	<% elseIf application("Svr_Info")="Dev" Then %>
		branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
	<% else %>
		branch.init('key_live_hpOucoij2aQek0GdzW9xFddbvukaW6le');
	<% end if %>
	branch.logEvent("view_main");

	// main banner
	if ($('.main-banner .rolling .rolling-item').length > 1) {
		$('.main-banner .rolling').slidesjs({
			height:600,
			navigation:{active:true, effect:"fade"},
			pagination:{active:true, effect:"fade"},
			play:{active:false, interval:4500, effect:"fade", auto:true, pauseOnHover:true},
			effect:{fade:{speed:600, crossfade:true}},
			callback:{
				loaded: function(number) {
					$('.mainV18 .main-banner .rolling-item:first-child .desc').animate({"margin-left":"0","opacity":"1"},100);
				},
				start: function(number) {
					$('.mainV18 .main-banner .rolling-item .desc').animate({"margin-left":"5px","opacity":"0"},100);
				},
				complete: function(number) {
					$('.mainV18 .main-banner .rolling-item .desc').animate({"margin-left":"0","opacity":"1"},100);
				}
			}
		});
	}

	// tab
	$(".tab-cont").hide();
	$(".tabV18").find("li:first a").addClass("current");
	$(".tab-container").find(".tab-cont:first").show();
	$(".tabV18 li").hover(function() {
		$(this).siblings("li").removeClass("current");
		$(this).addClass("current");
		$(this).closest(".tabV18").nextAll(".tab-container:first").find(".tab-cont").hide();
		var activeTab = $(this).find("a").attr("href");
		$(activeTab).show();
		return false;
	});
	$(".tabV18 li").click(function() {
		return false;
	});

	// just 1 day
	if ($('.time-sale .rolling img').length > 1) {
		$('.time-sale .rolling').slidesjs({
			width:240,
			height:240,
			navigation:{active:true, effect:"fade"},
			play:{interval:3000, effect:"fade", auto:true},
			effect:{fade:{speed:600, crossfade:true}}
		});
	}
	/*
	if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (navigator.userAgent.toLowerCase().indexOf("msie") != -1) ) {

		if (!(navigator.userAgent.toLowerCase().indexOf("msie 7.0") > 0 || navigator.userAgent.toLowerCase().indexOf("msie 8.0") > 0 )) {
			$('.timeline').easyPieChart({
				animate:4000,
				barColor: '#ff3131',
				trackColor: '#ddd',
				scaleColor:false,
				size:262,
				lineWidth:3,
				trackWidth:1
			});
		}
	}
	else {
		$('.timeline').easyPieChart({
			animate:4000,
			barColor: '#ff3131',
			trackColor: '#ddd',
			scaleColor:false,
			size:262,
			lineWidth:3,
			trackWidth:1
		});
	}
	*/


	// 인기검색어
	var randomcnt = Math.floor(Math.random() * $('.hot-keyword .ranking li').length) + 1;
	$('.hot-keyword .ranking li').eq(parseInt(randomcnt-1)).addClass('current');
	$('.hot-keyword .items').eq(parseInt(randomcnt-1)).show();
	$('.hot-keyword .ranking li').mouseover(function(){
		$('.hot-keyword .ranking li').removeClass('current');
		$(this).addClass('current');
		var kidx = $(this).index();
		$('.hot-keyword .items').hide();
		$('.hot-keyword .items').eq(kidx).show();
	});


	// 자동추천영역
	/*
	$('img').load(function(){
		$('.auto-rec .rec-list').masonry({
			itemSelector:'.unit'
		});
	});
	$('.auto-rec .rec-list').masonry({
		itemSelector:'.unit'
	});

	//
	$('.auto-rec .btn-wish').click(function(){
		$(this).children('.icoV18').toggleClass('on')
	});
	*/

	// look
	$('img').load(function(){
		$('.look-list li').each(function(){
			var imgW = $(this).find('img').outerWidth();
			$(this).css('width', imgW+'px');
		});
	});
	$('.look-list li').each(function(){
		var imgW = $(this).find('img').outerWidth();
		$(this).css('width', imgW+'px');
	});
	$("#slider").kxbdMarquee({
		loop:20,
		isEqual:false,
		scrollDelay:8
	});
	fnAmplitudeEventMultiPropertiesAction("view_main","","","");

});

function PopupNewsSel(v) {
	if (v=="")
	{
		var popwin = window.open('/common/news_list.asp','popupnews', 'width=580,height=750,left=300,top=100,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no');
		popwin.focus();
	}
	else
	{
		if($('.mainListWrap .slidesjs-pagination .active').attr("data-slidesjs-item")=="1") {
			var popwin = window.open('/common/news_popup.asp?type=E&idx='+v,'popupnews', 'width=580,height=750,left=300,top=100,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no');
			popwin.focus();
		} else {
			var popwin = window.open('/common/news_popup.asp?type=A&idx='+v,'popupnews', 'width=580,height=750,left=300,top=100,location=no,menubar=no,resizable=no,scrollbars=yes,status=no,toolbar=no');
			popwin.focus();
		}
	}
}

function AmpEventOnlyBrand(jsonval)
{
	AmplitudeEventSend('MainOnlyBrand', jsonval, 'eventProperties');
}
</script>
</head>
<body>
<div class="wrap mainV18" id="mainWrapV18">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<!-- # include virtual="/chtml/main/loader/2018loader/main_popup.asp" -->
	<%'!-- 메인 레이어 팝업 배너 --%>
	<% server.Execute("/chtml/main/loader/2018loader/main_popup.asp") %>

	<%'!-- 우측 하단 플로팅 배너 --%>
	<% server.Execute("/chtml/main/loader/2018loader/main_floating_banner.asp") %>
	<div class="container">
		<div id="contentWrap">
			<%'!-- 메인 배너 --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_rolling_banner.asp") %>

			<%'!-- 저스트원데이(주말특가:weekend/기획전:event/연휴특가:holiday 클래스 붙여주세요) --%>
			<% 'If Date() >= "2018-12-04" then %>
				<% server.Execute("/chtml/main/loader/2018loader/main_just1day_banner_2018_new.asp") %>
			<% 'else %>
				<% server.Execute("/chtml/main/loader/2018loader/main_just1day_banner_2018.asp") %>
			<% 'end if %>
			<% server.Execute("/chtml/main/loader/2018loader/main_top_event_banner.asp") %>

			<%'<!-- 메인빅이벤트배너 --> %>
			<% server.Execute("/chtml/main/loader/2018loader/main_bigevent_banner.asp") %>


			<%'!-- MD's Pick --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_mdpick.asp") %>

			<%'!-- 기획전 --%>
			<% Response.Cookies("pcmain")("mevt") = "1" %>
			<% server.Execute("/chtml/main/loader/2018loader/main_multievent_banner.asp") %>

			<%'!-- LOOK BOOK --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_look_banner.asp") %>

			<%'!-- 지금장바구니 추천 / 다른고객들 이상품 보고 있음 추천--%>
			<% server.Execute("/chtml/main/loader/2018loader/main_customer_recommended.asp") %>

			<% Response.Cookies("pcmain")("mevt") = "2" %>
			<% server.Execute("/chtml/main/loader/2018loader/main_multievent_banner.asp") %>

			<%'!-- 메인 컨텐츠 상단 배너 --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_content_banner_up.asp") %>

			<%'!-- 개인화영역 --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_foryou.asp") %>

			<%'!-- 메인 컨텐츠 하단 배너 --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_content_banner_down.asp") %>

			<%'!-- ONLY BRAND --%>
			<div class="section only-brand">
				<div class="inner-cont">
					<% server.Execute("/chtml/main/loader/2018loader/main_onlybrand_banner.asp") %>
					<div class="ftRt">
						<% If WeekDay(CDate(now())) >= 2 And WeekDay(CDate(now())) < 4 Then %>
							<%'videobanner%>
							<% server.Execute("/chtml/main/loader/2018loader/main_video_banner.asp") %>
						<% Else %>
							<%'gifbanner%>
							<% server.Execute("/chtml/main/loader/2018loader/main_gif_banner.asp") %>
						<% End If %>
					</div>
				</div>
			</div>

			<%'!-- 컬러기획전 --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_enjoyevent.asp") %>

			<%'!-- WISH BEST --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_wishbest_banner.asp") %>

			<%'!-- 기획전 --%>
			<% Response.Cookies("pcmain")("mevt") = "3" %>
			<% server.Execute("/chtml/main/loader/2018loader/main_multievent_banner.asp") %>

			<%'!-- 브랜드 소개 --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_brandbig_banner.asp") %>

			<%'!-- 뉴브랜드 --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_new_brand.asp") %>

			<%'!-- 텐텐클래스 --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_tenclass_banner.asp") %>

			<%'!-- 기획전 --%>
			<% Response.Cookies("pcmain")("mevt") = "4" %>
			<% server.Execute("/chtml/main/loader/2018loader/main_multievent_banner.asp") %>

			<% If Not(IsUserLoginOK) Then %>
			<div class="section custom-rec-logout">
				<% If Date="2018-03-28" Then %>
				<p><img src="http://fiximage.10x10.co.kr/web2018/main/txt_login_now_20180328.png" alt="지금 텐바이텐 로그인하고 PC리뉴얼 기념 단 하루 200마일리지 받으세요!" /></p>
				<% Else %>
 				<!-- <p><img src="http://fiximage.10x10.co.kr/web2018/main/txt_login_now.png" alt="지금 바로 로그인하고 텐바이텐만의 다양한 혜택을 받으세요!" /></p> -->
					<p><img src="//fiximage.10x10.co.kr/web2019/common/txt_login_now.png" alt="지금 회원가입하고 2,000원 할인쿠폰 받아가세요!" /></p>
				<% End If %>
				<div class="btn-group">
					<a href="/member/join.asp"><img src="http://fiximage.10x10.co.kr/web2018/main/btn_join_v2.png" alt="회원가입" /></a>
					<a href="/login/loginpage.asp?vType=G"><img src="http://fiximage.10x10.co.kr/web2018/main/btn_login_v2.png" alt="로그인" /></a>
				</div>
			</div>
			<% End If %>

			<!-- 플레잉 노출 중단 (20181114)-->
			<%' server.Execute("/chtml/main/loader/2018loader/main_playing_banner.asp") %>

			<%'!-- 컬쳐 스테이션 --%>
			<% server.Execute("/chtml/main/loader/2018loader/main_culturestation_banner.asp") %>

			<%'!-- 히치하이커/기프트카드 --%>
			<div class="section tenten-service">
				<div class="inner-cont">
					<div class="ftLt">
						<% server.Execute("/chtml/main/loader/2018loader/main_hitchhiker_banner.asp") %>
					</div>
					<div class="ftRt">
						<% server.Execute("/chtml/main/loader/2018loader/main_giftcard_banner.asp") %>
					</div>
				</div>
			</div>

			<!-- 선물포장, 기프트, 바로배송 띠배너 -->
			<% If Now() > #07/31/2019 12:00:00# Then %>
			<div class="section line-bnr2" style="display:none">
				<div class="ftLt"><a href="/shoppingtoday/gift_recommend.asp?gaparam=main_menu_packaging"><img src="http://fiximage.10x10.co.kr/web2018/main/bnr_wrapping.jpg" alt="텐바이텐 선물포장 서비스"></a></div>
				<div class="ftRt"><a href="/gift/talk/?gaparam=main_menu_gift"><img src="http://fiximage.10x10.co.kr/web2018/main/bnr_talk.jpg" alt="GIFT TALK 선물의 참견"></a></div>
			</div>
			<% else %>
			<div class="section line-bnr">
				<ul>
					<li class="bnr-wrapping"><a href="/shoppingtoday/gift_recommend.asp?gaparam=main_menu_packaging"><img src="http://fiximage.10x10.co.kr/web2018/main/bnr_wrapping_v2.jpg" alt="텐바이텐 선물포장 서비스"></a></li>
					<li class="bnr-talk"><a href="/gift/talk/?gaparam=main_menu_gift"><img src="http://fiximage.10x10.co.kr/web2018/main/bnr_talk_v2.jpg" alt="GIFT TALK 선물의 참견"></a></li>
					<li class="bnr-baro"><a href="/shoppingtoday/barodelivery.asp?gaparam=main_menu_baro"><img src="http://fiximage.10x10.co.kr/web2018/main/bnr_baro.png" alt="텐바이텐 바로배송"></a></li>
				</ul>
			</div>
			<% end if %>

			<%'!-- 인스타그램 피드 --%>
			<div id="instaFeed"></div>

			<!-- 기타정보 -->
			<% server.Execute("/chtml/main/loader/2018loader/main_etc_info.asp") %>
		</div>
	</div>

	<div class="favoriteKeyword" style="display:none;">
	<!-- #include virtual="/search/inc_favKwdLink.asp" -->
	</div>
	<div itemscope itemtype="https://schema.org/WebSite" style="display:none;">
		<meta itemprop="url" content="http://www.10x10.co.kr/">
		<form itemprop="potentialAction" itemscope itemtype="https://schema.org/SearchAction">
			<meta itemprop="target" content="http://www.10x10.co.kr/search/search_result.asp?rect={search_term}&amp;gaparam=sitelinks_searchbox"/>
			<input itemprop="query-input" type="text" name="search_term" required/>
			<input type="submit"/>
		</form>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>

<% IF application("Svr_Info") = "Dev" THEN %>
<script src="/vue/vue_dev.js"></script>
<% Else %>
<script src="/vue/vue.min.js"></script>
<% End If %>
<script src="/vue/vuex.min.js"></script>
<script src="/vue/vue.lazyimg.min.js"></script>
<script src="/vue/components/common/functions/common.js?v=1.0"></script>
<script src="/vue/common/common.js?v=1.0"></script>
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<link rel="stylesheet"href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue-awesome-swiper@4.1.1/dist/vue-awesome-swiper.min.js"></script>

<script src="/vue/components/main/menu_component.js?v=1.00"></script>
<script src="/vue/components/main/insta_feed.js?v=1.00"></script> 

<%' 크리테오 스크립트 설치 %>
<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
<script type="text/javascript">
window.criteo_q = window.criteo_q || [];
var deviceType = /iPad/.test(navigator.userAgent) ? "t" : /Mobile|iP(hone|od)|Android|BlackBerry|IEMobile|Silk/.test(navigator.userAgent) ? "m" : "d";
window.criteo_q.push(
	{ event: "setAccount", account: 8262},
	{ event: "setEmail", email: "<%=CriteoUserMailMD5%>" },
	{ event: "setSiteType", type: deviceType},
	{ event: "viewHome"}
);
</script>
<%'// 크리테오 스크립트 설치 %>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
