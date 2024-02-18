<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  play 반짝반짝 빛나라 2015
' History : 2014.12.26 한용민 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/play/groundsub/event58121Cls.asp" -->
<%
dim eCode
	eCode   =  getevt_code()

dim commentexistscount, userid, i
commentexistscount=0
userid = getloginuserid()

if userid<>"" then
	commentexistscount=getcommentexistscount(userid, eCode, "", "", "", "Y")
end if

dim com_egCode, bidx, isMyComm
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	
	isMyComm	= requestCheckVar(request("isMC"),1)
	
	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 15		'한 페이지의 보여지는 열의 수
	iCPerCnt = 10		'보여지는 페이지 간격

	'코멘트 데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	if isMyComm="Y" then cEComment.FUserID = GetLoginUserID

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

%>

<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
.section1 {background-color:#9a9a98;}
.section1 .hgroup {overflow:hidden; position:relative; width:100%; height:987px;}
.section1 .hgroup h1 {position:absolute; top:0; left:50%; margin-left:-960px;}
.section1 .topic {width:100%; height:480px; background:#0a0606 url(http://webimage.10x10.co.kr/play/ground/20141229/bg_lights.jpg) no-repeat 50% 0; text-align:center;}
.section1 .topic p {padding-top:90px;}
.section2 {padding:110px 0 165px; background-color:#ececec;}
.section2 .tab-nav {position:relative; width:1140px; margin:0 auto 20px;}
.section2 .tab-nav ul {overflow:hidden; position:absolute; top:30px; right:0;}
.section2 .tab-nav ul li {float:left; height:24px; padding-left:38px;}
.section2 .tab-nav ul li.collabo {width:144px;}
.section2 .tab-nav ul li.brand {width:121px;}
.section2 .tab-nav ul li a {display:block; position:relative; width:100%; height:100%; text-align:center;}
.section2 .tab-nav ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background-image:url(http://webimage.10x10.co.kr/play/ground/20141229/bg_tab_nav.gif); background-repeat:no-repeat;}
.section2 .tab-nav ul li.collabo a span {background-position:0 0;}
.section2 .tab-nav ul li.collabo a:hover span, .section2 .tab-nav ul li.collabo a.on span {background-position:0 100%;}
.section2 .tab-nav ul li.brand a span {background-position:100% 0;}
.section2 .tab-nav ul li.brand a:hover span, .section2 .tab-nav ul li.brand a.on span {background-position:100% 100%;}
.section2 .tab-con {width:1140px; height:700px; margin:0 auto; background-color:#fff;}
.section2 .tab-con .article {width:1100px; margin:0 auto; padding-top:70px; text-align:center;}
.section2 .tab-con .article h2 {visibility:hidden; width:0; height:0; overflow:hidden; position:absolute; top:-1000%; line-height:0;}

/* swiper */
.brand-swiper {*overflow:hidden; position:relative; width:1100px; margin:0 auto;}
.swiper {overflow:hidden; width:1100px; height:560px;}
.swiper .swiper-container {overflow:hidden; width:1100px; height:560px;}
.swiper .swiper-wrapper {overflow:hidden; position:relative; width:1100px; height:560px;}
.swiper .swiper-slide {float:left; position:relative; width:1000px; text-align:center;}
.swiper .swiper-slide img {vertical-align:top;}
.swiper .swiper-slide .link {overflow:hidden; position:absolute; top:50px; right:50px;}
.swiper .swiper-slide .link a {float:left; margin-left:30px;}
.btn-nav {display:block; position:absolute; bottom:-102px; z-index:500; width:9px; height:14px; background-color:transparent; background-repeat:no-repeat; background-image:url(http://webimage.10x10.co.kr/play/ground/20141229/btn_nav.gif); text-indent:-999em;}
.arrow-left {left:481px; background-position:0 50%;}
.arrow-right {right:485px; background-position:100% 50%;}
.swiper .pagination {overflow:hidden; position:absolute; bottom:-100px; left:50%; width:95px; margin-left:-47px;}
.swiper .pagination span {float:left; display:block; width:8px; height:8px; margin:0 5px; background-image:url(http://webimage.10x10.co.kr/play/ground/20141229/btn_paging_01.gif); background-repeat:no-repeat; background-position:0 0; cursor:pointer;}
.swiper .pagination .swiper-active-switch {background-position:100% 0;}

.section3 {width:100%; height:620px; background:#0e0a09 url(http://webimage.10x10.co.kr/play/ground/20141229/bg_filament.jpg) no-repeat 50% 0; text-align:center;}
.section3 p {width:1140px; margin:0 auto; padding-top:260px; padding-left:70px; text-align:left;}

.section4 {padding-top:180px; padding-bottom:165px; background-color:#fff;}
.section4 .package {width:1140px; margin:0 auto; text-align:center;}
.package .big {overflow:hidden; position:relative; height:816px; margin:50px 0 120px;}
.package .big img {position:absolute; top:0; left:50%; margin-left:-710px;}

/*slide*/
.section5 {position:relative; height:877px;}
.slide {position:absolute; top:0; left:50%; width:1920px; height:877px; margin-left:-960px;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:40px; left:50%; z-index:50; width:96px; margin-left:-48px;}
.slidesjs-pagination li {float:left; padding:0 8px;}
.slidesjs-pagination li a {display:block; width:8px; height:8px; background-image:url(http://webimage.10x10.co.kr/play/ground/20141229/btn_paging_02.png); background-repeat:no-repeat; background-position:0 0; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:100% 0;}

.section6 {padding:320px 0; background-color:#f6f6f6; text-align:center;}
.rolling {position:relative; width:1140px; margin:0 auto;}
.scroll-text {overflow:hidden; position:absolute; top:-75px; left:450px; width:164px; height:106px; text-align:center;}
.scroll-text ul {overflow:hidden; width:164px; height:530px; margin:0;}
.scroll-text ul li {height:106px;}

.section7 .message {padding:70px 0; background-color:#feed5d; text-align:center;}
.fieldwrap {padding:80px 0; background-color:#f6f6f6;}
.fieldwrap .field {position:relative; width:1140px; height:326px; margin:0 auto; background:url(http://webimage.10x10.co.kr/play/ground/20141229/bg_light_illust.gif) no-repeat 50% 0;}
.fieldwrap .field ul {overflow:hidden; padding-top:10px; padding-left:330px;}
.fieldwrap .field ul li {float:left; padding-right:32px; text-align:center;}
.fieldwrap .field ul li label {display:block; margin-bottom:10px;}
.fieldwrap .field textarea {width:568px; height:60px; margin-top:40px; margin-left:330px; padding:20px; border:1px solid #e5e5e5; color:#555; font-size:12px; line-height:1.313em;}
.fieldwrap .field .submit {position:absolute; top:171px; right:83px;}

.section8 {padding-bottom:100px; background-color:#fff;}
.commentwrap {width:1140px; margin:0 auto;}
.commentwrap .commentlist {overflow:hidden; width:1035px; padding:0 53px 0 52px; background:url(http://webimage.10x10.co.kr/play/ground/20141229/bg_line.gif) repeat-y 50% 100%;}
.msgbox {float:left; position:relative; width:167px; height:211px; margin:50px 20px 0; padding-top:87px; padding-bottom:60px; background-repeat:no-repeat; background-position:50% 0;}
.bg1 {background-image:url(http://webimage.10x10.co.kr/play/ground/20141229/bg_comment_light_01.gif);}
.bg2 {background-image:url(http://webimage.10x10.co.kr/play/ground/20141229/bg_comment_light_02.gif);}
.bg3 {background-image:url(http://webimage.10x10.co.kr/play/ground/20141229/bg_comment_light_03.gif);}
.bg4 {background-image:url(http://webimage.10x10.co.kr/play/ground/20141229/bg_comment_light_04.gif);}
.bg5 {background-image:url(http://webimage.10x10.co.kr/play/ground/20141229/bg_comment_light_05.gif);}
.msgbox p, .msgbox .no, .msgbox .id {display:block; font-size:11px; font-family:'Dotum', 'Verdana'; line-height:1.75em; text-align:center;}
.msgbox p {width:84px; height:165px; margin:0 auto; color:#000;}
.msgbox .no {color:#bbb;}
.msgbox .id {margin-top:10px; color:#aaa;}
.msgbox .btndel {position:absolute; top:3px; right:3px; width:20px; height:20px; background:url(http://webimage.10x10.co.kr/play/ground/20141229/btn_del.gif) no-repeat 50% 0; text-indent:-999em;}
.paging {margin-top:30px;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
 /*global jQuery */
/*!
 * jQuery Scrollbox
 * (c) 2009-2013 Hunter Wu <hunter.wu@gmail.com>
 * MIT Licensed.
 *
 * http://github.com/wmh/jquery-scrollbox
 */

(function($) {

$.fn.scrollbox = function(config) {
	//default config
	var defConfig = {
		linear: false, // Scroll method
		startDelay: 2, // Start delay (in seconds)
		delay: 3, // Delay after each scroll event (in seconds)
		step: 5, // Distance of each single step (in pixels)
		speed: 32, // Delay after each single step (in milliseconds)
		switchItems: 1, // Items to switch after each scroll event
		direction: 'vertical',
		distance: 'auto',
		autoPlay: true,
		onMouseOverPause: true,
		paused: false,
		queue: null,
		listElement: 'ul',
		listItemElement:'li'
	};
	config = $.extend(defConfig, config);
	config.scrollOffset = config.direction === 'vertical' ? 'scrollTop' : 'scrollLeft';
		if (config.queue) {
		config.queue = $('#' + config.queue);
	}

	return this.each(function() {
	var container = $(this),
		containerUL,
		scrollingId = null,
		nextScrollId = null,
		paused = false,
		backward,
		forward,
		resetClock,
		scrollForward,
		scrollBackward,
		forwardHover,
		pauseHover;

	if (config.onMouseOverPause) {
		container.bind('mouseover', function() { paused = true; });
		container.bind('mouseout', function() { paused = false; });
	}
	containerUL = container.children(config.listElement + ':first-child');

	scrollForward = function() {
		if (paused) {
			return;
		}
		var curLi,
		i,
		newScrollOffset,
		scrollDistance,
		theStep;

		curLi = containerUL.children(config.listItemElement + ':first-child');

		scrollDistance = config.distance !== 'auto' ? config.distance :
		config.direction === 'vertical' ? curLi.outerHeight(true) : curLi.outerWidth(true);

		// offset
		if (!config.linear) {
			theStep = Math.max(3, parseInt((scrollDistance - container[0][config.scrollOffset]) * 0.3, 10));
			newScrollOffset = Math.min(container[0][config.scrollOffset] + theStep, scrollDistance);
		} else {
			newScrollOffset = Math.min(container[0][config.scrollOffset] + config.step, scrollDistance);
		}
		container[0][config.scrollOffset] = newScrollOffset;

		if (newScrollOffset >= scrollDistance) {
			for (i = 0; i < config.switchItems; i++) {
			if (config.queue && config.queue.find(config.listItemElement).length > 0) {
				containerUL.append(config.queue.find(config.listItemElement)[0]);
				containerUL.children(config.listItemElement + ':first-child').remove();
			} else {
				containerUL.append(containerUL.children(config.listItemElement + ':first-child'));
			}
		}
		container[0][config.scrollOffset] = 0;
		clearInterval(scrollingId);
		if (config.autoPlay) {
			nextScrollId = setTimeout(forward, config.delay * 1000);
		}
	}
	};

	// Backward
	// 1. If forwarding, then reverse
	// 2. If stoping, then backward once
	scrollBackward = function() {
	if (paused) {
		return;
	}
	var curLi,
	i,
	liLen,
	newScrollOffset,
	scrollDistance,
	theStep;

	// init
	if (container[0][config.scrollOffset] === 0) {
	liLen = containerUL.children(config.listItemElement).length;
	for (i = 0; i < config.switchItems; i++) {
		containerUL.children(config.listItemElement + ':last-child').insertBefore(containerUL.children(config.listItemElement+':first-child'));
	}

	curLi = containerUL.children(config.listItemElement + ':first-child');
	scrollDistance = config.distance !== 'auto' ?
		config.distance :
		config.direction === 'vertical' ? curLi.height() : curLi.width();
	container[0][config.scrollOffset] = scrollDistance;
	}

	// new offset
	if (!config.linear) {
		theStep = Math.max(3, parseInt(container[0][config.scrollOffset] * 0.3, 10));
		newScrollOffset = Math.max(container[0][config.scrollOffset] - theStep, 0);
	} else {
		newScrollOffset = Math.max(container[0][config.scrollOffset] - config.step, 0);
	}
	container[0][config.scrollOffset] = newScrollOffset;

	if (newScrollOffset === 0) {
		clearInterval(scrollingId);
		if (config.autoPlay) {
			nextScrollId = setTimeout(forward, config.delay * 1000);
		}
		}
	};

	forward = function() {
		clearInterval(scrollingId);
		scrollingId = setInterval(scrollForward, config.speed);
	};

	// Implements mouseover function.
	forwardHover = function() {
		config.autoPlay = true;
		paused = false;
		clearInterval(scrollingId);
		scrollingId = setInterval(scrollForward, config.speed);
	};
	pauseHover = function() {
		paused = true;
	};

	backward = function() {
		clearInterval(scrollingId);
		scrollingId = setInterval(scrollBackward, config.speed);
	};

	resetClock = function(delay) {
		config.delay = delay || config.delay;
		clearTimeout(nextScrollId);
		if (config.autoPlay) {
			nextScrollId = setTimeout(forward, config.delay * 1000);
		}
	};

	if (config.autoPlay) {
		nextScrollId = setTimeout(forward, config.startDelay * 1000);
	}

	// bind events for container
	container.bind('resetClock', function(delay) { resetClock(delay); });
	container.bind('forward', function() { clearTimeout(nextScrollId); forward(); });
	container.bind('pauseHover', function() { pauseHover(); });
	container.bind('forwardHover', function() { forwardHover(); });
	container.bind('backward', function() { clearTimeout(nextScrollId); backward(); });
	container.bind('speedUp', function(speed) {
		if (typeof speed === 'undefined') {
			speed = Math.max(1, parseInt(config.speed / 2, 10));
		}
		config.speed = speed;
	});

	container.bind('speedDown', function(speed) {
		if (typeof speed === 'undefined') {
		speed = config.speed * 2;
	}
		config.speed = speed;
	});

	container.bind('updateConfig', function (event,options) {
		config = $.extend(config, options);
	});

	});
};

}(jQuery));

$(function(){
	$('#demo1').scrollbox();

	/* tab */
	$(".tab-nav li a:first").addClass("on");
	$(".tab-con").find(".article").hide();
	$(".tab-con").find(".article:first").show();
	
	$(".tab-nav li a").click(function(){
		$(".tab-nav li a").removeClass("on");
		$(this).addClass("on");
		var thisCont = $(this).attr("href");
		$(".tab-con").find(".article").hide();
		$(".tab-con").find(thisCont).show();
		return false;
	});

	
	/* swipe */
	var similarSwiper = new Swiper('.swiper-container',{
		slidesPerView:1,
		loop: true,
		speed:1500,
		autoplay:false,
		simulateTouch:false,
		pagination: '.pagination',
		paginationClickable: true
	})
	$('.arrow-left').on('click', function(e){
		e.preventDefault()
		similarSwiper.swipePrev()
	})
	$('.arrow-right').on('click', function(e){
		e.preventDefault()
		similarSwiper.swipeNext()
	});

	/* slide */
	$(".slide").slidesjs({
		width:"1920",
		height:"877",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:5000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $(".slide").data("plugin_slidesjs");
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
});

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	if(frmcom.txtcomm.value =="코멘트 입력 (50자 이내)"){
		frmcom.txtcomm.value ="";
	}
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}
											
function jsSubmitComment(){
	<% If IsUserLoginOK() Then %>
		<% If not( getnowdate>="2014-12-29" and getnowdate<"2015-01-08") Then %>
			alert('이벤트 응모 기간이 아닙니다.');
			return;
		<% end if %>
		<% if commentexistscount>=5 then %>
			alert('한아이디당 5회 까지만 참여가 가능 합니다.');
			return;
		<% end if %>

		var tmpgubun='';
		for (var i=0; i < frmcom.gubun.length ; i++){
			if (frmcom.gubun[i].checked){
				tmpgubun=frmcom.gubun[i].value;
			}
		} 
		if (tmpgubun==''){
			alert('빛을 선택해 주세요.');
			return;
		}
		if(frmcom.txtcomm.value =="코멘트 입력 (50자 이내)"){
			frmcom.txtcomm.value ="";
		}
		if(!frmcom.txtcomm.value){
			alert("코멘트를 입력해주세요");
			frmcom.txtcomm.focus();
			return false;
		}
		if (GetByteLength(frmcom.txtcomm.value) > 50){
			alert("코맨트가 제한길이를 초과하였습니다. 50자 까지 작성 가능합니다.");
			frmcom.txtcomm.focus();
			return;
		}

		frmcom.action='/play/groundsub/doEventSubscript58121.asp';
		frmcom.submit();
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

function jsDelComment(cidx)	{
	<% If IsUserLoginOK() Then %>
		if (cidx==""){
			alert('정상적인 경로가 아닙니다');
			return;
		}
		
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
			document.frmdelcom.action='/play/groundsub/doEventSubscript58121.asp';
	   		document.frmdelcom.submit();
		}
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

</script>
</head>
<body>

<div class="playGr20141229">
	<div class="twinkle">
		<div class="section section1">
			<div class="hgroup">
				<h1><img src="http://webimage.10x10.co.kr/play/ground/20141229/tit_twinkle_2015.gif" alt="반짝 반짝 빛나라 2015" /></h1>
			</div>
			<div class="topic">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_topic.png" alt="열심히 달려온 2014년, 이제 우리는 새해를 맞이합니다. 텐바이텐과 일광전구는 2015년, 여러분이 간절히 원하는 모든 것들이 이루어지기를 바라는 마음으로 특별한 의미를 지닌 전구를 준비했습니다. 전구의 빛들이 환하게 밝혀지는 만큼, 여러분의 새해도 밝게 빛나기 바랍니다! " /></p>
			</div>
		</div>

		<div class="section section2">
			<div class="tab-nav">
				<strong><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_logo.gif" alt="일광전구" /></strong>
				<ul>
					<li class="collabo"><a href="#collabo"><span></span>COLLABORATION</a></li>
					<li class="brand"><a href="#brand"><span></span>BRAND STORY</a></li>
				</ul>
			</div>
			<div class="tab-con">
				<div id="collabo" class="article">
					<h2>COLLABORATION</h2>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_collaboration.gif" alt="제품이 가진 따뜻한 감성과 스토리를 중요하게 생각하고, 디자인으로서 새로운 가치를 창출해내고자 하는 두 브랜드가 만나 의미 있는 빛을 만들어내고자 합니다. 일광전구의 장인정신과 따뜻함이 담긴 클래식 전구를, 텐바이텐만의 감성과 디자인을 담아낸 패키지로 만나보세요." /></p>
				</div>

				<div id="brand" class="article">
					<h2>BRAND STORY</h2>
					<div class="brand-swiper">
						<div class="swiper">
							<div class="swiper-container">
								<div class="swiper-wrapper">
									<div class="swiper-slide">
										<p><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_slide_01.jpg" alt="We make light." /></p>
									</div>
									<div class="swiper-slide">
										<p><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_slide_02.jpg" alt="일광전구는 1962년 창립 이래 50여년동안 조명용 백열 전구를 생산해 온 전문 생산 업체입니다. 앞으로의 50년을 위해 일광전구가 인테리어 전구 전문 브랜드로 다시 태어납니다." /></p>
									</div>
									<div class="swiper-slide">
										<p><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_slide_03.jpg" alt="빛을 만들어 세상을 밝히고 따뜻하게 만들자 기업의 가치관을 대표 개인의 생각이 아닌 직원 모두의 의견을 다듬어 만든 것입니다. 오너의 가슴만 벅차서 될 일이 아니라 직원들도 자신들의 일로 설레야 합니다. 정해진 규칙으로 서로를 얽매이다 보면 서로의 꿈이 달라질 수 있는데 규칙만을 강조하는 것이 아닌 자율을 강조함으로써 오너와 직원 모두가 하나의 비전을 바라보는 것이 중요합니다. 작은 화분을 가꾸는 일도 스스로 애정을 갖지 않으면 꽃이 피지 않듯이 제품 생산도 마찬가지입니다." /></p>
									</div>
									<div class="swiper-slide">
										<p><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_slide_04.jpg" alt="건강한 체력과 마음가짐으로 모든 일에 활력을 가지고 임하며 늘 새로운 아이디어를 통해 새로운 광원을 찾기 위해 노력하고 있습니다. 더불어 청결한 생산관리로 생산업에서 최고의 효율을 얻기 위해 힘쓰고 있습니다. 임직원 모두가 이러한 기본기를 가지고 품질을 관리하는 것이 제조기술 개발의 좋은 여건이 됩니다." /></p>
									</div>
									<div class="swiper-slide">
										<p><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_slide_05.jpg" alt="시대가 변하면서 가장 원시적인 것이 가장 값진 물건이 되듯이 백열전구는 가장 고급스러운 전구가 될 것이라 생각합니다. 대량생산이 아닌 수작업 방식을 선택하고 디자인 가치를 넣으려 합니다. 일광전구의 가장 큰 자산인 수많은 장인들이 만들어내는 역사적 가치와 노하우를 기업의 근간으로 계속 성장하고자 합니다. 지금까지의 전구가 산업용 또는 생활 필수품 정도였다면, 이제는 디자인/인테리어 제품으로서 새로운 가치를 부여한 전구 브랜드로 다시 태어납니다." /></p>
										<div class="link">
											<a href="http://www.iklamp.co.kr" target="_blank" title="일광전구 홈페이지 새창"><img src="http://webimage.10x10.co.kr/play/ground/20141229/btn_homepage.gif" alt="홈페이지 가기" /></a>
											<a href="http://www.facebook.com/iklamp" target="_blank" title="일광전구 페이스북 새창"><img src="http://webimage.10x10.co.kr/play/ground/20141229/btn_facebook.gif" alt="페이스북 가기" /></a>
										</div>
									</div>

								</div>
							</div>
							<button type="button" class="btn-nav arrow-left">Previous</button>
							<button type="button" class="btn-nav arrow-right">Next</button>
							<div class="pagination"></div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="section section3">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_classic.png" alt="일광전구 CLassic Series는 20세기 초 제작된 전구의 아름다운 유리구, 다양한 형상의 필라멘트 디자인을 재현한 빈티지하고 고풍스러운 분위기를 연출하는 프리미엄 전구입니다. 실내외 등기구와, 천장기구, 샹들리에 등 다양한 기구에 사용하여 당신의 공간을 더욱 따뜻하고 아름답게 밝혀 줄 것입니다." /></p>
		</div>

		<div class="section section4">
			<div class="package">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20141229/tit_package.gif" alt="패키지" /></h2>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_package_01.jpg" alt="" /></div>
				<div class="big"><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_package_02.jpg" alt="" /></div>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_package_composition.jpg" alt="패키지는 클래식 시리즈 ST64 220볼트 40와트짜리 전구와 소켓으로 구성되어 있습니다. 전구와 소켓은 비매품입니다." /></p>
			</div>
		</div>

		<div class="section section5">
			<div class="slide">
				<div><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_slide_full_01.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_slide_full_02.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_slide_full_03.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20141229/img_slide_full_04.jpg" alt="" /></div>
			</div>
		</div>

		<div class="section section6">
			<div class="rolling">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_brighten.gif" alt="당신의 2015년, 빛을 밝혀 보세요" /></p>
				<div id="demo1" class="scroll-text">
					<ul>
						<li><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_rolling_01.png" alt="열정" /></li>
						<li><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_rolling_02.png" alt="사랑" /></li>
						<li><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_rolling_03.png" alt="변화" /></li>
						<li><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_rolling_04.png" alt="희망" /></li>
						<li><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_rolling_05.png" alt="건강" /></li>
					</ul>
				</div>
			</div>
		</div>

		<!-- comment event -->
		<div class="section section7">
			<div class="message">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_message.gif" alt="2015년, 가장 원하는 빛을 선택하고 간단한 응원의 메시지를 남겨보세요! 추첨을 통해 50분에게 텐바이텐x일광전구 스페셜 패키지 상품을 선물로 드립니다! 이벤트 기간은 2014년 12월 29일부터 2015년 1월 7일까지며, 당첨자 발표는 2015년 1월 9일까지입니다." /></p>
			</div>

			<div class="fieldwrap">
				<div class="field">					
					<form name="frmcom" method="post" style="margin:0px;">
					<input type="hidden" name="eventid" value="<%=eCode%>">
					<input type="hidden" name="bidx" value="<%=bidx%>">
					<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
					<input type="hidden" name="iCTot" value="">
					<input type="hidden" name="mode" value="add">
					<input type="hidden" name="spoint" value="0">
					<input type="hidden" name="isMC" value="<%=isMyComm%>">
						<fieldset>
						<legend>응원 메시지 남기기</legend>
							<ul>
								<li>
									<label for="light01"><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_label_01.gif" alt="열정" /></label>
									<input type="radio" value="1" name="gubun" id="light01" />
								</li>
								<li>
									<label for="light02"><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_label_02.gif" alt="사랑" /></label>
									<input type="radio" value="2" name="gubun" id="light02" />
								</li>
								<li>
									<label for="light03"><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_label_03.gif" alt="변화" /></label>
									<input type="radio" value="3" name="gubun" id="light03" />
								</li>
								<li>
									<label for="light04"><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_label_04.gif" alt="희망" /></label>
									<input type="radio" value="4" name="gubun" id="light04" />
								</li>
								<li>
									<label for="light05"><img src="http://webimage.10x10.co.kr/play/ground/20141229/txt_label_05.gif" alt="건강" /></label>
									<input type="radio" value="5" name="gubun" id="light05" />
								</li>
							</ul>
							<textarea name="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> cols="60" rows="5" title="응원 메시지 입력"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>코멘트 입력 (50자 이내)<%END IF%></textarea>
							<div class="submit"><input type="image" onclick="jsSubmitComment(); return false;" src="http://webimage.10x10.co.kr/play/ground/20141229/btn_submit.gif" alt="전구 밝히기" /></div>
						</fieldset>
					</form>
					<form name="frmdelcom" method="post" style="margin:0px;">
					<input type="hidden" name="eventid" value="<%=eCode%>">
					<input type="hidden" name="bidx" value="<%=bidx%>">
					<input type="hidden" name="Cidx" value="">
					<input type="hidden" name="mode" value="del">
					</form>					
				</div>
			</div>
		</div>

		<!-- comment list -->
		<% IF isArray(arrCList) THEN %>
			<div class="section section8">
				<div class="commentwrap">
					<div class="commentlist">
						<% ' for dev msg : <div class="msgbox">...</div 한 묶음입니다. 한줄에 5개씩 한페이지당 3줄씩 보여주세요 인풋 라디오 선택에 따라 bg1~bg5 클래스명 넣어주세요 %>
						<%
						dim tmpcomment, tmpcommentgubun , tmpcommenttext
						For i = 0 To UBound(arrCList,2)
						
						tmpcomment = ReplaceBracket(db2html(arrCList(1,i)))
						tmpcomment = split(tmpcomment,"!@#")
						if isarray(tmpcomment) then
							tmpcommentgubun=tmpcomment(0)
							tmpcommenttext=tmpcomment(1)
						end if
						%>
						<div class="msgbox bg<%= tmpcommentgubun %>">
							<p><%= tmpcommenttext %></p>
							<span class="no">no.<%=iCTotCnt-i-(iCPageSize*(iCCurrpage-1))%></span>
							<span class="id">
								<% If arrCList(8,i) <> "W" Then %>
									<img src="http://webimage.10x10.co.kr/play/ground/20141229/ico_mobile.gif" alt="모바일에서 작성" />
								<% end if %>

								<strong><%=printUserId(arrCList(2,i),2,"*")%>님</strong>의 전구
							</span>

							<% if ((GetLoginUserID = arrCList(2,i)) or (GetLoginUserID = "10x10")) and ( arrCList(2,i)<>"") then %>
								<button type="button" onclick="jsDelComment('<% = arrCList(0,i) %>');return false;" class="btndel">삭제</button>
							<% end if %>							
						</div>
						<% next %>
					</div>

					<!-- paging -->
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				</div>
			</div>
		<% end if %>
	</div>
</div>
<!-- 수작업 영역 끝 -->

</body>
</html>

<!-- #include virtual="/lib/db/dbclose.asp" -->