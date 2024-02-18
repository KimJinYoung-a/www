<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'########################################################
' PLAY #19 세상에 하나뿐인 스티커
' 2015-04-24 유태욱 작성
'########################################################
Dim eCode, userid, vQuery
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "62772"
Else
	eCode   =  "62783"
End If

userid = getloginuserid()

Dim strSql, enterCnt, sakuraCnt, overseasCnt

	vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		enterCnt = rsget(0)
	End IF
	rsget.close

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
/* iframe */
img {vertical-align:top;}
.playGr20150525 .inner {width:1140px; margin:0 auto;}
.topic {height:680px; background:#fff url(http://webimage.10x10.co.kr/play/ground/20150525/bg_pattern_01.png) no-repeat 50% 0;}
.topic .inner {position:relative;}
.topic h1 {position:absolute; top:110px; left:50%; margin-left:-240px; width:480px; height:480px; background:url(http://webimage.10x10.co.kr/play/ground/20150525/bg_box.png) no-repeat 0 0;}
.topic h1 .letter1, .topic h1 .letter2, .topic h1 .letter3, .topic h1 .letter4, .topic h1 .letter5, .topic h1 .letter6 {top:18px; position:absolute; z-index:5; height:84px; background:url(http://webimage.10x10.co.kr/play/ground/20150525/bg_topic_01.png) no-repeat 0 0; text-indent:-999em;}
.topic h1 .letter1 {left:57px; width:76px;}
.topic h1 .letter2 {left:133px; width:70px; background-position:-76px 0;}
.topic h1 .letter3 {left:202px; width:73px; background-position:-145px 0;}
.topic h1 .letter4 {left:275px; width:76px; background-position:-218px 0;}
.topic h1 .letter5 {left:351px; width:34px; background-position:-294px 0;}
.topic h1 .letter6 {left:385px; width:92px; background-position:100% 0;}
.topic h1 .letter7 {position:absolute; top:112px; left:25px; width:412px; height:5px; background-color:#f9a59c;}
.topic h1 .letter8, .topic h1 .letter9, .topic h1 .letter10, .topic h1 .letter11, .topic h1 .letter12 {position:absolute; background:url(http://webimage.10x10.co.kr/play/ground/20150525/bg_topic_02.png) no-repeat 0 0; text-indent:-999em;}
.topic h1 .letter8 {top:156px; left:45px; width:146px; height:159px;}
.topic h1 .letter9 {top:326px; left:209px; width:101px; height:95px; background-position:-164px 100%;}
.topic h1 .letter10 {top:326px; left:320px; width:101px; height:96px; background-position:100% 100%;}
.topic h1 .letter11 {top:202px; left:203px; width:149px; height:115px; background-position:-158px -47px;}
.topic h1 .letter12 {top:367px; left:126px; width:65px; height:11px; background-position:-81px -212px;}
.topic h1 .letter13 {position:absolute; top:28px; left:153px;}
.welcome {height:370px; background:#fff url(http://webimage.10x10.co.kr/play/ground/20150525/bg_pattern_02.png) repeat-x 50% 0;}
.welcome .inner {position:relative; height:100%;}
.welcome h2 {position:absolute; top:120px; left:13px;}
.welcome h2 span {position:absolute; top:0; left:13px; height:122px; background:url(http://webimage.10x10.co.kr/play/ground/20150525/tit_flower_tea.png) no-repeat 0 0; text-indent:-999em;}
.welcome h2 .letter1 {width:123px;}
.welcome h2 .letter2 {left:159px; width:80px; background-position:100% 0;}
.welcome .letter3, .welcome .letter4 {position:absolute; top:100px;}
.welcome .letter3 {left:359px;}
.welcome .letter4 {left:679px;}
.welcome .letter3 span, .welcome .letter4 span {display:block; width:260px; height:2px; margin-bottom:37px; background-color:#b4473b;}
.welcome .letter4 span {width:440px; background-color:#fff;}
.welcome strong {position:absolute; right:30px; bottom:64px;}

.menupan {height:670px; background:#f6f6f6 url(http://webimage.10x10.co.kr/play/ground/20150525/bg_pattern_03.png) repeat-x 50% 0;}
.menupan h2 {padding-top:82px; text-align:center;}
.menupan ul {position:relative; margin-top:88px; height:368px; padding-top:5px; padding-left:19px;}
.menupan ul li {position:absolute; top:0; left:0; width:250px; text-align:center;}
.menupan ul li.tea1 {left:19px;}
.menupan ul li.tea2 {left:301px;}
.menupan ul li.tea3 {left:587px;}
.menupan ul li.tea4 {left:869px;}
.menupan ul li strong {display:block; height:38px; margin:0 auto 15px;}
.menupan ul li strong:after {content:' '; display:block; clear:both;}
.menupan ul li strong span, .menupan ul li strong em {float:left; height:38px; background:url(http://webimage.10x10.co.kr/play/ground/20150525/txt_tea_name.png) no-repeat 0 0; text-indent:-999em;}
.menupan ul li strong em {width:38px; background-position:-60px 0;}
.menupan ul li a:hover em {-webkit-animation-name:bounce; -webkit-animation-iteration-count:infinite; -webkit-animation-duration:0.5s; -moz-animation-name:bounce; -moz-animation-iteration-count:infinite; -moz-animation-duration:0.5s; -ms-animation-name:bounce; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:-5px; -webkit-animation-timing-function:ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-5px; animation-timing-function:ease-in;}
}
.menupan ul li.tea1 strong {width:98px;}
.menupan ul li.tea1 strong span {width:60px;}
.menupan ul li.tea2 strong {width:99px;}
.menupan ul li.tea2 strong span {width:61px; background-position:-98px 0;}
.menupan ul li.tea2 strong em {background-position:-159px 0;}
.menupan ul li.tea3 strong {width:68px;}
.menupan ul li.tea3 strong span {width:30px; background-position:-197px 0;}
.menupan ul li.tea3 strong em {background-position:-227px 0;}
.menupan ul li.tea4 strong {width:66px;}
.menupan ul li.tea4 strong span {width:28px; background-position:-265px 0;}
.menupan ul li.tea4 strong em {background-position:100% 0;}
/* swiper */
.rolling {padding:140px 0 170px; background-color:#fff;}
.rolling .inner {*overflow:hidden; position:relative; width:1140px; margin:0 auto;}
.swiper {overflow:hidden; width:1140px; height:700px;}
.swiper .swiper-container {overflow:hidden; width:1140px; height:700px;}
.swiper .swiper-wrapper {overflow:hidden; position:relative; width:1140px; height:700px;}
.swiper .swiper-slide {float:left; position:relative; width:1000px; text-align:center;}
.swiper .swiper-slide img {vertical-align:top;}
.swiper .swiper-slide .link {overflow:hidden; position:absolute; top:50px; right:50px;}
.swiper .swiper-slide .link a {float:left; margin-left:30px;}
.btn-nav {display:block; position:absolute; bottom:-58px; z-index:500; width:25px; height:25px; background-color:transparent; background-image:url(http://webimage.10x10.co.kr/play/ground/20150525/btn_nav.png); background-repeat:no-repeat; text-indent:-999em;}
.arrow-left {left:465px; background-position:0 50%;}
.arrow-right {right:465px; background-position:100% 50%;}
.swiper .pagination {overflow:hidden; position:absolute; bottom:-50px; left:50%; width:120px; margin-left:-60px;}
.swiper .pagination span {float:left; display:block; width:10px; height:10px; margin:0 10px; background-image:url(http://webimage.10x10.co.kr/play/ground/20150525/btn_paging.png); background-repeat:no-repeat; background-position:0 0; cursor:pointer;}
.swiper .pagination .swiper-active-switch {background-position:100% 0;}

.tea .article {overflow:hidden; height:840px; background:#f2f2f1 url(http://webimage.10x10.co.kr/play/ground/20150525/bg_tea_01.jpg) no-repeat 50% 0;}
.tea #cont2 {background-color:#eeecec; background-image:url(http://webimage.10x10.co.kr/play/ground/20150525/bg_tea_02.jpg);}
.tea #cont3 {background-color:#fcfbfb; background-image:url(http://webimage.10x10.co.kr/play/ground/20150525/bg_tea_03.jpg);}
.tea #cont4 {background-color:#fafaf9; background-image:url(http://webimage.10x10.co.kr/play/ground/20150525/bg_tea_04.jpg);}
.tea .article .hgroup {position:relative; width:1140px; height:660px; margin:0 auto;}
.tea .article .desc {overflow:hidden; position:relative; width:100%; height:180px; background-color:#f5e1b0;}
.tea .article .desc p {position:absolute; top:0; left:50%; margin-left:-960px;}
.tea #cont2 .desc {background-color:#d3cee6;}
.tea #cont3 .desc {background-color:#d3efe4;}
.tea #cont4 .desc {background-color:#f4d9ce;}
.tea #cont1 .hgroup p {position:absolute; top:239px; left:18px;}
.tea #cont1 .hgroup h2 {position:absolute; top:238px; left:36px; z-index:5;}
.tea #cont1 .hgroup span {position:absolute; top:154px; left:248px;}
.tea #cont2 .hgroup p {position:absolute; top:329px; right:176px;}
.tea #cont2 .hgroup h2 {position:absolute; top:329px; right:36px; z-index:5;}
.tea #cont2 .hgroup span {position:absolute; top:316px; right:25px;}
.tea #cont3 .hgroup p {position:absolute; top:313px; left:-60px;}
.tea #cont3 .hgroup h2 {position:absolute; top:313px; left:270px; z-index:5;}
.tea #cont3 .hgroup span {position:absolute; top:229px; left:370px;}
.tea #cont4 .hgroup p {position:absolute; top:274px; left:274px;}
.tea #cont4 .hgroup h2 {position:absolute; top:274px; left:440px; z-index:5;}
.tea #cont4 .hgroup span {position:absolute; top:243px; left:656px;}

.myorder {height:895px; border-top:4px solid #86434b; background:url(http://webimage.10x10.co.kr/play/ground/20150525/bg_pattern_04.png) repeat 50% 0;}
.myorder .gift {position:relative; width:1140px; height:440px; margin:0 auto;}
.myorder .gift p {position:absolute; top:90px; left:50%; margin-left:-578px;}
.myorder .gift .btnorder {position:absolute; top:140px; right:60px; width:180px; height:180px; background:transparent url(http://webimage.10x10.co.kr/play/ground/20150525/btn_order.png) repeat 50% 0; text-indent:-999em;}
.myorder .gift .btnorder img {position:absolute; top:134px; left:80px;}
.myorder .gift .btnorder:hover img {-webkit-animation-name:updown; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.5s; -moz-animation-name:updown; -moz-animation-iteration-count:infinite; -moz-animation-duration:0.5s; -ms-animation-name:updown; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes updown {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:-5px; -webkit-animation-timing-function:ease-in;}
}
@keyframes updown {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-5px; animation-timing-function:ease-in;}
}
.myorder .counting {text-align:center;}
.myorder .counting strong {padding:0 6px 0 12px; color:#000; font-family:'Verdana', 'Dotum', '돋움' ; font-size:32px; font-weight:normal; line-height:25px;}
.myorder .brand {margin-top:110px; text-align:center;}
.myorder .brand a {display:block; padding:45px 0;}

.animated {-webkit-animation-duration:5s; animation-duration:5s; -webkit-animation-fill-mode:both; animation-fill-mode:both; -webkit-animation-iteration-count:infinite;animation-iteration-count:infinite;}
/* flash animation */
@-webkit-keyframes flash {
	0% {opacity:0.3;}
	100% {opacity:1;}
}
@keyframes flash {
	0% {opacity:0.3;}
	100% {opacity:1;}
}
.flash {-webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-name:flash; animation-name:flash; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}

/* FadeIn animation */
@-webkit-keyframes fadeIn {
	0% {opacity:0;}
	30% {opacity:0.3;}
	50% {opacity:0.7;}
	100% {opacity:1;}
}
@keyframes fadeIn {
	0% {opacity:0;}
	30% {opacity:0.3;}
	50% {opacity:0.7;}
	100% {opacity:1;}
}
.fadeIn {-webkit-animation-name:fadeIn; animation-name: fadeIn; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite; -webkit-animation-duration:3s; animation-duration:3s;}
</style>
<script type="text/javascript" src="/lib/js/swiper-2.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".menupan ul li a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},1000);
	});

	/* swipe */
	var similarSwiper = new Swiper('.swiper-container',{
		slidesPerView:1,
		loop: true,
		speed:1500,
		autoplay:5000,
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

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 100){
			animation1();
		}
		if (scrollTop > 1150){
			animation2();
		}
		if (scrollTop > 1400){
			animation3();
		}
		if (scrollTop > 3200){
			animation4();
		}
		if (scrollTop > 4000){
			animation5();
		}
		if (scrollTop > 5000){
			animation6();
		}
		if (scrollTop > 5800){
			animation7();
		}
	});

	$(".topic h1 span").css({"opacity":"0"});
	$(".topic h1 .letter1, .topic h1 .letter2, .topic h1 .letter3, .topic h1 .letter4, .topic h1 .letter5, .topic h1 .letter7").css({"opacity":"0", "margin-top":"5px"});
	$(".topic h1 .letter8").css({"opacity":"0", "width":"0", "left":"0"});
	$(".topic h1 .letter9, .topic h1 .letter10").css({"margin-top":"7px"});
	function animation1 () {
		$(".topic h1 .letter1").delay(200).animate({"opacity":"1", "margin-top":"0"},300);
		$(".topic h1 .letter2").delay(300).animate({"opacity":"1", "margin-top":"0"},300);
		$(".topic h1 .letter3").delay(500).animate({"opacity":"1", "margin-top":"0"},300);
		$(".topic h1 .letter4").delay(700).animate({"opacity":"1", "margin-top":"0"},300);
		$(".topic h1 .letter5").delay(900).animate({"opacity":"1", "margin-top":"0"},500);
		$(".topic h1 .letter6").delay(1200).animate({"opacity":"1"},300);
		$(".topic h1 .letter7").delay(100).animate({"opacity":"1", "margin-top":"0"},300);
		$(".topic h1 .letter8").delay(1500).animate({"opacity":"1", "width":"146px", "left":"45px"},1000);
		$(".topic h1 .letter9").delay(1900).animate({"opacity":"1", "width":"101px", "margin-top":"0"},1000);
		$(".topic h1 .letter10").delay(2200).animate({"opacity":"1", "width":"101px", "margin-top":"0"},1000);
		$(".topic h1 .letter11").delay(3000).animate({"opacity":"1"},500);
		$(".topic h1 .letter12").delay(2500).animate({"opacity":"1"},300);
		$(".topic h1 .letter13").delay(100).animate({"opacity":"1", "margin-top":"0"},1500);
	}

	$(".welcome h2 span").css({"opacity":"0"});
	function animation2 () {
		$(".welcome h2 .letter1").delay(100).animate({"opacity":"1"},300);
		$(".welcome h2 .letter2").delay(500).animate({"opacity":"1"},300);
	}

	$(".menupan ul li").css({"opacity":"0", "margin-top":"5px"});
	function animation3 () {
		$(".menupan ul li.tea1").delay(100).animate({"opacity":"1", "margin-top":"0"},600);
		$(".menupan ul li.tea2").delay(600).animate({"opacity":"1", "margin-top":"0"},600);
		$(".menupan ul li.tea3").delay(1200).animate({"opacity":"1", "margin-top":"0"},600);
		$(".menupan ul li.tea4").delay(1700).animate({"opacity":"1", "margin-top":"0"},600);
	}

	$("#cont1 .hgroup p").css({"opacity":"0", "left":"0"});
	$("#cont1 .hgroup h2").css({"opacity":"0", "margin-top":"7px"});
	function animation4 () {
		$("#cont1 .hgroup p").delay(100).animate({"opacity":"1", "left":"18px"},600);
		$("#cont1 .hgroup h2").delay(600).animate({"opacity":"1", "margin-top":"0"},600);
	}

	$("#cont2 .hgroup p").css({"opacity":"0", "right":"116px"});
	$("#cont2 .hgroup h2").css({"opacity":"0", "margin-top":"7px"});
	function animation5 () {
		$("#cont2 .hgroup p").delay(100).animate({"opacity":"1", "right":"176px"},1000);
		$("#cont2 .hgroup h2").delay(600).animate({"opacity":"1", "margin-top":"0"},600);
	}

	$("#cont3 .hgroup p").css({"opacity":"0", "left":"-26px"});
	$("#cont3 .hgroup h2").css({"opacity":"0", "margin-top":"7px"});
	function animation6 () {
		$("#cont3 .hgroup p").delay(100).animate({"opacity":"1", "left":"-60px"},600);
		$("#cont3 .hgroup h2").delay(600).animate({"opacity":"1", "margin-top":"0"},600);
	}

	$("#cont4 .hgroup p").css({"opacity":"0", "left":"224px"});
	$("#cont4 .hgroup h2").css({"opacity":"0", "margin-top":"7px"});
	function animation7 () {
		$("#cont4 .hgroup p").delay(100).animate({"opacity":"1", "left":"274px"},600);
		$("#cont4 .hgroup h2").delay(600).animate({"opacity":"1", "margin-top":"0"},600);
	}
});

function jsSubmit11(){
	<% if Not(IsUserLoginOK) then %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
	document.frmcom.submit();
}


function jsSubmit(){
	<% if Not(IsUserLoginOK) then %>
	    jsChklogin('<%=IsUserLoginOK%>');
	    return false;
	<% end if %>
	var rstStr = $.ajax({
		type: "POST",
		url: "/play/groundsub/doEventSubscript62783.asp",
//		data: "",
		dataType: "text",
		async: false
	}).responseText;
	if (rstStr.substring(0,2) == "01"){
		var enterCnt;
		enterCnt = rstStr.substring(5,10);
		//$("#entercnt").html("<strong class='animated flash'>"+enterCnt+"</strong>");
		$("#entercnt").empty().append("<strong class='animated flash'>"+enterCnt+"</strong>");
		alert('응모 완료!');
		return false;

	}else if (rstStr == "02"){
		alert('5회 까지만 참여 가능 합니다.');
		return false;
	}else{
		alert('관리자에게 문의');
		return false;
	}
}
</script>
</head>
<body>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20150525">
			<div class="topic">
				<div class="inner">
					<h1>
						<span class="letter1">으</span>
						<span class="letter2">라</span>
						<span class="letter3">차</span>
						<span class="letter4">차</span>
						<span class="letter5">!</span>
						<span class="letter6">茶</span>
						<span class="letter7"></span>
						<span class="letter8">꽃</span>
						<span class="letter9">다</span>
						<span class="letter10">방</span>
						<span class="letter11"></span>
						<span class="letter12"></span>
						<span class="letter13"><img src="http://webimage.10x10.co.kr/play/ground/20150525/img_flame.png" alt="" /></span>
					</h1>
				</div>
			</div>

			<div class="welcome">
				<div class="inner">
					<h2>
						<span class="letter1">꽃</span>
						<span class="letter2">茶</span>
					</h2>
					<p class="letter3">
						<span></span>
						<img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_welcome_01.png" alt="으랏차차! 꽃다방에 오신 것을 환영합니다." />
					</p>
					<p class="letter4">
						<span></span>
						<img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_welcome_02.png" alt="저희 다방에는 당신을 위한 여러 가지 꽃차가 준비되어 있습니다. 당신에게 필요한 차가 우러나는 시간 동안 따뜻한 대화를 나눠보기도 하고, 풍미를 맡기도 하며 차분한 마음을 가져보세요. 말하는 대로 이루어지게 해 줄 꽃차! 자 이제부터 우리 꽃다방 대표 꽃차들을 소개합니다." />
					</p>
					<strong class="animated flash"><img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_from.png" alt="주인백" /></strong>
				</div>
			</div>

			<div class="menupan">
				<div class="inner">
					<h2><img src="http://webimage.10x10.co.kr/play/ground/20150525/tit_menu.png" alt="메뉴" /></h2>
					<ul>
						<li class="tea1">
							<a href="#cont1">
								<strong><span>기운</span><em>차</em></strong>
								<img src="http://webimage.10x10.co.kr/play/ground/20150525/img_menu_01.png" alt="맛보기" />
							</a>
						</li>
						<li class="tea2">
							<a href="#cont2">
								<strong><span>그만</span><em>차</em></strong>
								<img src="http://webimage.10x10.co.kr/play/ground/20150525/img_menu_02.png" alt="맛보기" />
							</a>
						</li>
						<li class="tea3">
							<a href="#cont3">
								<strong><span>장</span><em>차</em></strong>
								<img src="http://webimage.10x10.co.kr/play/ground/20150525/img_menu_03.png" alt="맛보기" />
							</a>
						</li>
						<li class="tea4">
							<a href="#cont4">
								<strong><span>미</span><em>차</em></strong>
								<img src="http://webimage.10x10.co.kr/play/ground/20150525/img_menu_04.png" alt="맛보기" />
							</a>
						</li>
					</ul>
				</div>
			</div>

			<div class="rolling">
				<div class="inner">
					<div class="swiper">
						<div class="swiper-container">
							<div class="swiper-wrapper">
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150525/img_slide_01.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150525/img_slide_02.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150525/img_slide_03.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150525/img_slide_04.jpg" alt="" /></div>
							</div>
						</div>
						<button type="button" class="btn-nav arrow-left">Previous</button>
						<button type="button" class="btn-nav arrow-right">Next</button>
						<div class="pagination"></div>
					</div>
				</div>
			</div>

			<!-- tea -->
			<div class="tea">
				<div id="cont1" class="article">
					<div class="hgroup">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_tea_01.png" alt="원기회복을 도와주는" /></p>
						<h2><img src="http://webimage.10x10.co.kr/play/ground/20150525/tit_tea_01.png" alt="기운차" /></h2>
						<span class="animated fadeIn"><img src="http://webimage.10x10.co.kr/play/ground/20150525/img_deco_01.png" alt="" /></span>
					</div>
					<div class="desc">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_tea_jasmine.jpg" alt="자스민 꽃은 심신 안정에 효과적입니다. 기운차는 자스민꽃을 베이스로 만들어진 차입니다. 따뜻한 차로 몸을 다스리고, 기운차게 다시 일어나보세요! 아자 아자!" /></p>
					</div>
				</div>

				<div id="cont2" class="article">
					<div class="hgroup">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_tea_02.png" alt="화가 많은 당신에게" /></p>
						<h2><img src="http://webimage.10x10.co.kr/play/ground/20150525/tit_tea_02.png" alt="그만차" /></h2>
						<span class="animated fadeIn"><img src="http://webimage.10x10.co.kr/play/ground/20150525/img_deco_02.png" alt="" /></span>
					</div>
					<div class="desc">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_tea_oolong.jpg" alt="우롱차는 몸속의 독소를 해독하는 데 효과적입니다. 그만차는 우롱차를 베이스로 만들어진 차입니다. 차를 우리고 호호 불어 마시는 시간 동안만이라도 그만 걷어차고, 화를 다스려보세요!" /></p>
					</div>
				</div>

				<div id="cont3" class="article">
					<div class="hgroup">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_tea_03.png" alt="취업이 걱정인 당신에게" /></p>
						<h2><img src="http://webimage.10x10.co.kr/play/ground/20150525/tit_tea_03.png" alt="장차" /></h2>
						<span class="animated fadeIn"><img src="http://webimage.10x10.co.kr/play/ground/20150525/img_deco_03.png" alt="" /></span>
					</div>
					<div class="desc">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_tea_lavender.jpg" alt="라벤더차는 불안감과 두통을 없애는 데 효과적입니다. 장차는 라벤더꽃을 베이스로 만들어진 차입니다. 취업에 실패한다고 자신을 탓하지 마세요. 왜냐하면, 당신은 장차 큰 인물이 될테니까요." /></p>
					</div>
				</div>

				<div id="cont4" class="article">
					<div class="hgroup">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_tea_04.png" alt="예뻐지고 싶은 당신에게" /></p>
						<h2><img src="http://webimage.10x10.co.kr/play/ground/20150525/tit_tea_04.png" alt="미차" /></h2>
						<span class="animated fadeIn"><img src="http://webimage.10x10.co.kr/play/ground/20150525/img_deco_04.png" alt="" /></span>
					</div>
					<div class="desc">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_tea_hibiscus.jpg" alt="히비스커스차는 피부노화방지에 효과적입니다. 미차는 히비스커스꽃을 베이스로 만들어진 차입니다. 고혹적인 꽃향기를 맡으며 우아하게 차를 마시고, 미모를 되찾아보세요!" /></p>
					</div>
				</div>
			</div>

			<!-- order -->
			<div class="myorder">
				<div class="gift">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_order.png" alt="당신을 위해 준비된 꽃차를 주문하시겠습니까? 추첨을 통해 총 10분에게 으랏차차 꽃다방세트를 선물로 드립니다! 이벤트 기간은 2015년 5월 25일부터 6월 3일까지며, 당첨자 발표는 2015년 6월 4일입니다. 당첨되신 분께 개인정보 제공을 요청할 수 있으며, 사은품 정보 입력 목적 외에는 사용하지 않습니다." /></p>
					<!-- for dev msg : 꽃차 주문하기 .버튼 -->
					<button type="button" class="btnorder" onclick="jsSubmit();">꽃차 주문하기 <img src="http://webimage.10x10.co.kr/play/ground/20150525/ico_arrow.png" alt="" /></button>
				</div>
				<!-- for dev msg : 꽃차 주문 카운팅 -->
				<p class="counting">
					<img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_count_01.png" alt="지금까지" />
					<span id="entercnt"><strong class="animated flash"><%= enterCnt %></strong></span>
					<img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_count_02.png" alt="명이 꽃차를 주문하셨습니다." />
				</p>
				<p class="brand"><a href="/street/street_brand_sub06.asp?makerid=teagarden" target="_blank" title="브랜드 바로 가기 새창"><img src="http://webimage.10x10.co.kr/play/ground/20150525/txt_brand.png" alt="꽃다방의 모든 꽃차는 브랜드 ROYAL ORCHARD / Revolution 제품으로 안전하게 유통 판매되고 있는 식품입니다." /></a></p>
			</div>
			<form name="frmcom" method="post" action="doEventSubscript62783.asp" style="margin:0px;">
				<input type="hidden" name="votetour">
			</form>
		</div>
	</div>
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->