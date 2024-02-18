<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'########################################################
' PLAY #23 summer 5주차 
' 2015-08-28 이종화 작성
'########################################################
Dim eCode , sqlStr , userid , totcnt , iCTotCnt
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "64878"
Else
	eCode   =  "66035"
End If

userid = GetEncLoginUserID

If GetEncLoginUserID <> "" then
	sqlStr = "select count(*) from db_event.dbo.tbl_event_subscript where userid = '"& userid &"' and evt_code = '"& ecode &"' " 
	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly 

	IF Not rsget.Eof Then
		totcnt = rsget(0)
	End IF
	rsget.close()
End If 

	sqlStr = "select count(*) from db_event.dbo.tbl_event_subscript where evt_code = '"& ecode &"' " 
	rsget.CursorLocation = adUseClient
	rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly 

	IF Not rsget.Eof Then
		iCTotCnt = rsget(0)
	End IF
	rsget.close()
%>
<style type="text/css">
img {vertical-align:top;}
.playGr20150907 button {background-color:transparent;}
.topic .hgroup {overflow:hidden; position:relative; width:100%; height:1004px; background:#797979 url(http://webimage.10x10.co.kr/play/ground/20150907/bg_studio_v1.jpg) no-repeat 50% 0;}
.topic .hgroup h3 {position:absolute; top:368px; left:50%; width:536px; height:295px; margin-left:-268px;}
.topic .hgroup .glow {position:absolute; top:-19px; left:-13px; width:525px; height:274px; background:url(http://webimage.10x10.co.kr/play/ground/20150907/bg_outglow.png) no-repeat 0 0;}
.topic .hgroup span {position:absolute; height:83px; background:url(http://webimage.10x10.co.kr/play/ground/20150907/tit_my_studio_v2.png) no-repeat 0 0; text-indent:-999em;}
.topic .hgroup h3 .letter1 {top:0; left:148px; width:120px; background-position:-148px 0;}
.topic .hgroup h3 .letter2 {bottom:212px; left:278px; width:83px; background-position:-278px 0;}
.topic .hgroup h3 .letter3 {bottom:58px; left:5px; width:64px; height:86px; background-position:-5px -151px;}
.topic .hgroup h3 .letter4 {top:151px; left:87px; width:75px; background-position:-87px -151px;}
.topic .hgroup h3 .letter5 {top:151px; left:176px; width:81px; height:85px; background-position:-176px -151px;}
.topic .hgroup h3 .letter6 {bottom:56px; left:251px; width:88px; height:88px; background:url(http://webimage.10x10.co.kr/play/ground/20150907/tit_d.png) no-repeat 0 0}
.topic .hgroup h3 .letter7 {top:151px; left:347px; width:55px; background-position:-347px -151px;}
.topic .hgroup h3 .letter8 {top:151px; left:409px; width:85px; height:85px; background-position:-409px -151px;}
.topic .hgroup h3 .letter9 {top:91px; right:286px; width:104px; height:20px; background-position:-146px -91px;}
.topic .hgroup h3 .letter10 {top:91px; left:250px; width:104px; height:20px; background-position:-146px -91px;}
.topic .hgroup h3 .letter11 {top:245px; right:286px; width:249px; height:13px; background-position:0 100%;}
.topic .hgroup h3 .letter12 {top:245px; left:250px; width:250px; height:13px; background-position:0 100%;}
.topic .hgroup .light {position:absolute; top:0; left:50%; width:1920px; margin-left:-960px;}

.topic .desc {height:664px; background:#f6e8e2 url(http://webimage.10x10.co.kr/play/ground/20150907/bg_pattern.png) no-repeat 50% 0;}
.topic .desc .inner {overflow:hidden; position:relative; width:520px; height:100%; margin:0 auto; padding-left:620px;}
.topic .desc p {height:278px; margin-top:140px;}
.topic .desc .btngo {margin-top:50px;-webkit-animation-name:updown; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.7s; -moz-animation-name:updown; -moz-animation-iteration-count:infinite; -moz-animation-duration:0.7s; -ms-animation-name:updown; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.7s;}
@-webkit-keyframes updown {
	from, to{margin-top:50px; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:55px; -webkit-animation-timing-function:ease-in;}
}
@keyframes updown {
	from, to{margin-top:50px; animation-timing-function:ease-out;}
	50% {margin-top:55px; animation-timing-function:ease-in;}
}
.topic .desc .hand {position:absolute; bottom:-3px; left:128px;}

.howtoTake .one, .howtoTake .two {overflow:hidden; position:relative; height:886px;;}
.howtoTake .one {background-color:#bdbdbd;}
.howtoTake .two {background-color:#e8cc4c;}
.howtoTake p {position:absolute; z-index:10; width:743px;}
.howtoTake p span {display:block; width:100%; height:2px; margin-bottom:14px; background-color:#fff;}
.howtoTake .one p {top:374px; right:0; text-align:left;}
.howtoTake .two p {top:272px; left:0; text-align:right;}
.howtoTake .two p span {opacity:0.8; filter: alpha(opacity=0.8);}
.howtoTake .photo {position:absolute; top:0; left:50%; z-index:5; margin-left:-960px;}

.prepare {position:relative; width:100%; height:1390px; background:#414443 url(http://webimage.10x10.co.kr/play/ground/20150907/bg_open_before_v2.jpg) no-repeat 50% 0; text-align:center;}
.prepare .line {position:absolute; top:294px; left:0; z-index:10; width:100%; height:1px; background-color:#797053;}
.prepare .open {position:relative; width:650px; margin:0 auto; padding-top:140px; text-align:left;}
.prepare .open .mine {padding-top:224px; padding-left:33px;}
.prepare .open .btnOpen {position:absolute; top:338px; right:0; cursor:pointer;}
.prepare .open .btnOpen:hover button {animation:effect 2s infinite;}
.prepare .open .btnOpen button:active, .prepare .open .btnOpen button:focus {outline:none;}
.prepare .open .btnOpen button {position:absolute; top:15px; left:15px; width:150px; height:150px; box-shadow:0 0 0 15px #434544, 0 0 0 20px rgba(250,223,92,0); border-radius:50%; text-indent:-9999em;}
.prepare .after {position:absolute; top:0; left:0; width:100%; height:0; background:#151510 url(http://webimage.10x10.co.kr/play/ground/20150907/bg_open_after.jpg) no-repeat 50% 0; transition:opacity 0.8s ease-out; opacity:0; filter: alpha(opacity=0);}
.prepare .after.show {opacity:1; filter: alpha(opacity=100); height:1390px;}
.prepare .after p {padding-top:230px;}

@keyframes effect {
	0% {box-shadow:0 0 0 0px transparent, 0 0 0 5px rgba(250,223,92,0.5);}
}

.howtoMake {position:relative; padding-top:255px; padding-bottom:200px; text-align:center;}
.howtoMake h4 {position:absolute; top:187px; left:50%; margin-left:-958px;}
.howtoMake .beforeAfter {margin-top:162px;}
.howtoMake .btnmore {position:absolute; top:175px; left:50%; margin-left:260px;}
.howtoMake .btnmore span {position:absolute; top:50%; right:37px; margin-top:-6px;}
.howtoMake .btnmore span img {transition:transform .4s ease-out;}
.howtoMake .btnmore a:hover span img {transform:rotate(180deg);}

.package {height:922px; padding-top:89px; background:#f2f2f2 url(http://webimage.10x10.co.kr/play/ground/20150907/bg_pattern_line.png) repeat-x 0 0; text-align:center;}
.package h4 {visibility:hidden; width:0; height:0;}
.packageBox {position:relative; width:1141px; margin:0 auto;}
.packageBox .square {position:absolute; top:0; left:0; width:1141px; height:832px;}
.packageBox .square span {position:absolute; background-color:#000;}
.packageBox .square {top:0; left:0;}
.packageBox .square .line1 {top:0; left:0; width:1141px; height:1px;}
.packageBox .square .line2 {bottom:0; left:0; width:1px; height:832px;}
.packageBox .square .line3 {bottom:0; left:0; width:1141px; height:1px;}
.packageBox .square .line4 {top:0; right:0; width:1px; height:832px;}

.rolling {width:100%;}
.rolling .swiper {overflow:hidden; position:relative;}
.rolling .swiper .swiper-container {overflow:hidden;}
.rolling .swiper .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {overflow:hidden; float:left; position:relative; width:100%; min-width:1140px; height:1020px; background-color:#fff; text-align:center;}
.rolling .swiper .pagination {position:absolute; bottom:55px; left:0; width:100%; text-align:center;}
.rolling .swiper .pagination span {display:inline-block; *display:inline; *zoom:1; width:97px; height:3px; margin:0 5px; background-color:#d5d5d5; cursor:pointer; transition:background-color 1s ease;}
.rolling .swiper .pagination .swiper-active-switch {background-color:#000;}

.mystudioEvt {position:relative; padding:135px 0; background:#404452 url(http://webimage.10x10.co.kr/play/ground/20150907/bg_pattern_stripe.png) repeat 0 0;}
.mystudioEvt .line {position:absolute; top:149px; left:0; z-index:5; width:100%; padding:1px 0;border-top:1px solid #a08b70; border-bottom:1px solid #a08b70;}
.mystudioEvt .inner {width:1140px; margin:0 auto;}
.mystudioEvt h4 {position:relative; z-index:10; width:656px; margin-left:-12px; padding-left:56px; background:#404452 url(http://webimage.10x10.co.kr/play/ground/20150907/bg_pattern_stripe.png) repeat 0 0;}
.mystudioEvt .desc {overflow:hidden; width:1140px; padding-top:93px;}
.mystudioEvt .namecard {float:left; width:722px; padding-left:42px;}
.mystudioEvt .name {position:relative;}
.mystudioEvt .name strong {position:absolute; top:181px; left:241px; width:292px; height:78px; color:#556aed; font-size:33px; font-family:'Verdana', 'Dotum'; font-weight:normal; line-height:78px; text-align:center;}
.mystudioEvt .name span {overflow:hidden; display:inline-block; width:292px; animation:keyframes 5s steps(500) infinite; white-space:nowrap;}
@keyframes keyframes{
	from {width:0px;}
}
.mystudioEvt .namecard .count {margin-top:19px;}
.mystudioEvt .namecard .count strong {margin:0 -10px; border-bottom:1px solid #b7f9ff; color:#b7f9ff; font-size:33px; font-family:'Verdana', 'Dotum'; line-height:66px;}
.mystudioEvt .desc .take {float:right; width:376px;}
.mystudioEvt .desc .take .btnTake {position:relative; width:404px; margin-top:55px;}
.mystudioEvt .desc .take .btnTake button {display:block; position:relative; z-index:10; width:230px; margin-left:57px;}
.mystudioEvt .desc .take .btnTake span {position:absolute; left:2px; top:50%; z-index:5; width:341px; height:1px; background-color:#000; opacity:0.3; filter: alpha(opacity=0.3); transition:background-color 1s;}
.mystudioEvt .desc .take .btnTake:hover span {background-color:#f5be6a; opacity:0.7; filter: alpha(opacity=0.7);}

.brand {overflow:hidden; position:relative; height:136px; background-color:#393c48;}
.brand p {position:absolute; top:0; left:50%; margin-left:-960px;}
.brand .btnBrand {overflow:hidden; position:absolute; top:46px; left:50%; margin-left:305px; width:175px; height:43px;}
.brand .btnBrand .square {position:absolute; top:-43px; left:0; width:175px; height:43px; box-shadow:inset 0 0 0 1px #fff; transition:color 1s;}
.brand .btnBrand:hover .square {top:0;}
</style>
<script type="text/javascript">
<!--
 	function jsSubmitComment(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>
	   
	   var frm = document.frmcom;
	   frm.action = "/play/groundsub/doeventsubscript66035.asp";
	   frm.submit();
	   return true;
	}


$(function(){
	var mySwiper = new Swiper('.swiper-container',{
		mode:'vertical',
		loop:true,
		resizeReInit:true,
		calculateHeight:true,
		pagination:'.pagination',
		paginationClickable:true,
		speed:1500,
		autoplay:3000,
		autoplayDisableOnInteraction:false,
		//mousewheelControl: true,
		simulateTouch:false
	});

	$("#btngo a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},1500);
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 400 ) {
			titleAnimation();
		}
		if (scrollTop > 1200 ) {
			planAnimation();
		}
		if (scrollTop > 2000 ) {
			howtoTakeAnimation1();
		}
		if (scrollTop > 3000 ) {
			howtoTakeAnimation2();
		}
		if (scrollTop > 7000 ) {
			boxAnimation();
		}
	});

	$(".hgroup h3 span").css({"opacity":"0"});
	$(".hgroup h3 .glow").css({"opacity":"0.6"});
	$(".hgroup h3 .letter1").css({"top":"8px"});
	$(".hgroup h3 .letter2").css({"bottom":"219px"});
	$(".hgroup h3 .letter3").css({"bottom":"67px"});
	$(".hgroup h3 .letter4").css({"top":"159px"});
	$(".hgroup h3 .letter6").css({"bottom":"65px"});
	$(".hgroup h3 .letter8").css({"top":"159px"});
	$(".hgroup h3 .letter9, .hgroup h3 .letter10, .hgroup h3 .letter11, .hgroup h3 .letter12").css({"width":"0", "opacity":"1"});
	$(".hgroup .light").css({"opacity":"0"});
	function titleAnimation() {
		$(".hgroup h3 .letter1").delay(200).animate({"top":"0px", "opacity":"1"},1000);
		$(".hgroup h3 .letter2").delay(500).animate({"bottom":"212px", "opacity":"1"},800);
		$(".hgroup h3 .letter3").delay(800).animate({"bottom":"58px", "opacity":"1"},800);
		$(".hgroup h3 .letter4").delay(600).animate({"top":"151px", "opacity":"1"},1900);
		$(".hgroup h3 .letter5").delay(500).animate({"opacity":"1"},1500);
		$(".hgroup h3 .letter6").delay(800).animate({"bottom":"56px", "opacity":"1"},1300);
		$(".hgroup h3 .letter7").delay(700).animate({"opacity":"1"},1900);
		$(".hgroup h3 .letter8").delay(1000).animate({"top":"151px", "opacity":"1"},1000);
		$(".hgroup .glow").delay(2000).animate({"opacity":"1"},1500);
		$(".hgroup h3 .letter9").delay(3000).animate({"width":"104px"},1500);
		$(".hgroup h3 .letter10").delay(3000).animate({"width":"104px"},1500);
		$(".hgroup h3 .letter11").delay(3000).animate({"width":"249px",},1500);
		$(".hgroup h3 .letter12").delay(3000).animate({"width":"250px"},1500);
		$(".hgroup .light").delay(4500).animate({"opacity":"1"},1500);
	}


	$(".topic .desc p").css({"height":"0", "opacity":"0"});
	$(".topic .btngo").css({"margin-top":"55px", "opacity":"0"});
	$(".topic .hand").css({"left":"108px", "opacity":"0"});
	function planAnimation() {
		$(".topic .desc p").delay(500).animate({"height":"278px", "opacity":"1"},2000);
		$(".topic .btngo").delay(3000).animate({"margin-top":"50px", "opacity":"1"},800);
		$(".topic .hand").delay(300).animate({"left":"128px", "opacity":"1"},600);
	}

	$(".howtoTake p").css({"opacity":"0"});
	$(".howtoTake p span").css({"width":"0"});
	$(".howtoTake .one p").css({"top":"380px"});
	function howtoTakeAnimation1() {
		$(".howtoTake .one p").delay(200).animate({"top":"374px", "opacity":"1"},800);
		$(".howtoTake .one span").delay(800).animate({"width":"100%"},2000);
	}

	$(".howtoTake .two p").css({"top":"282px"});
	function howtoTakeAnimation2() {
		$(".howtoTake .two p").delay(200).animate({"top":"272px", "opacity":"1"},800);
		$(".howtoTake .two span").delay(800).animate({"width":"100%"},2000);
	}

	$(".square .line1").css({"width":"0"});
	$(".square .line2").css({"height":"0"});
	$(".square .line3").css({"width":"0"});
	$(".square .line4").css({"height":"0"});
	function boxAnimation() {
		$(".square .line1").delay(200).animate({"width":"1141px"},1000);
		$(".square .line2").delay(200).animate({"height":"832px"},1000);
		$(".square .line3").delay(500).animate({"width":"1141px"},1000);
		$(".square .line4").delay(500).animate({"height":"832px"},1000);
	}

	$(".btnOpen").click(function(){
		$(".prepare .after").addClass("show");
	});
});
//-->
</script>
<div class="playGr20150907">
	<div class="topic">
		<div class="hgroup">
			<h3>
				<span class="letter1">M</span>
				<span class="letter2">Y</span>
				<span class="letter3">S</span>
				<span class="letter4">T</span>
				<span class="letter5">U</span>
				<span class="letter6">D</span>
				<span class="letter7">I</span>
				<span class="letter8">O</span>
				<span class="letter9"></span>
				<span class="letter10"></span>
				<span class="letter11"></span>
				<span class="letter12"></span>
				<span class="glow"></span>
			</h3>
			<div class="light"><img src="http://webimage.10x10.co.kr/play/ground/20150907/img_light_v1.png" alt="" /></div>
		</div>

		<div class="desc">
			<div class="inner">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150907/txt_plan.png" alt="카메라가 핸드폰으로 들어오게 되면서, 우리는 많은 순간을 편리하게 촬영할 수 있게 되었습니다. 누구나 사진 작가가 되어 본인만의 느낌으로 촬영하는 사진들. 하지만 가끔 지저분한 배경이나, 어두운 환경때문에 마음에 들지 않는 결과물을 볼 때도 있죠. 그래서 텐바이텐 플레이에서는 여러분을 포토그래퍼로 만들어 드리기로 했습니다. 핸드폰 카메라 뿐만 아니라 모든 카메라를 들고 이제 여러분의 스튜디오에서 깔끔하고 선명한 촬영을 해보세요! 여러분의 카메라 사용이 더욱 즐겁고 만족스러워지기를 바랍니다" /></p>
				<div id="btngo" class="btngo"><a href="#mystudioEvt"><img src="http://webimage.10x10.co.kr/play/ground/20150907/btn_go.png" alt="MY STUDIO 신청하기" /></a></div>
				<div class="hand"><img src="http://webimage.10x10.co.kr/play/ground/20150907/img_hand.png" alt="" /></div>
			</div>
		</div>
	</div>

	<div class="howtoTake">
		<div class="one">
			<p><span></span><img src="http://webimage.10x10.co.kr/play/ground/20150907/txt_how_to_take_01.png" alt="텐바이텐의 이런 깔끔한 사진! 어떻게 촬영했을까?" /></p>
			<div class="photo"><img src="http://webimage.10x10.co.kr/play/ground/20150907/img_photo_01.jpg" alt="" /></div>
		</div>
		<div class="two">
			<p><span></span><img src="http://webimage.10x10.co.kr/play/ground/20150907/txt_how_to_take_02.png" alt="인스타그램과 블로그에서 봤던 이런 인증 사진! 어떻게 찍어야 할까?" /></p>
			<div class="photo"><img src="http://webimage.10x10.co.kr/play/ground/20150907/img_photo_02.jpg" alt="" /></div>
		</div>
	</div>

	<div class="prepare">
		<div class="line"></div>
		<div class="open">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150907/txt_prepare.png" alt="그래서 준비했습니다!" /></p>
			<p class="mine"><img src="http://webimage.10x10.co.kr/play/ground/20150907/txt_open.png" alt="나만의 스튜디오를 오픈해 보세요!" /></p>
			<div class="btnOpen">
				<button type="button"><span></span>OPEN</button>
				<img src="http://webimage.10x10.co.kr/play/ground/20150907/btn_open.png" alt="" />
			</div>
		</div>
		<div class="after">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150907/txt_your.png" alt="YOUR OWN PHOTO STUIO" /></p>
		</div>
	</div>

	<div class="howtoMake">
		<h4><img src="http://webimage.10x10.co.kr/play/ground/20150907/tit_how_to_make.png" alt="HOW TO MAKE" /></h4>
		<div><img src="http://webimage.10x10.co.kr/play/ground/20150907/img_how_to_make.gif" alt="MY STUDIO 조립방법" /></div>
		<div class="beforeAfter"><img src="http://webimage.10x10.co.kr/play/ground/20150907/img_before_after.jpg" alt="MY STUDIO 사용하여 촬영 전 후" /></div>
		<div class="btnmore">
			<a href="/shopping/category_prd.asp?itemid=1078873" target="_blank" title="새창">
				<img src="http://webimage.10x10.co.kr/play/ground/20150907/btn_more_v1.png" alt="MY STUDIO 조립방법 자세히 보기" />
				<span><img src="http://webimage.10x10.co.kr/play/ground/20150907/ico_plus.png" alt="" /></span>
			</a>
		</div>
	</div>

	<div class="package">
		<h4>MY STUDIO PACKAGE</h4>
		<div class="packageBox">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150907/img_my_studio_package_v1.jpg" alt="마이 스튜디오 패키지는 휴대가능한 미니 스튜이오와 당신을 포토그래퍼로 만들어줄 명함으로 구성 되어있습니다. 패키지는 변경 가능성이 있습니다." /></p>
			<div class="square">
				<span class="line1"></span>
				<span class="line2"></span>
				<span class="line3"></span>
				<span class="line4"></span>
			</div>
		</div>
	</div>

	<!-- rolling -->
	<div class="rolling">
		<div class="swiper">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150907/img_slide_01.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150907/img_slide_02.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150907/img_slide_03.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150907/img_slide_04.jpg" alt="" /></div>
				</div>
				<div class="pagination"></div>
			</div>
		</div>
	</div>

	<!-- my studio event -->
	<div id="mystudioEvt" class="mystudioEvt">
		<div class="line"></div>
		<div class="inner">
			<h4><img src="http://webimage.10x10.co.kr/play/ground/20150907/tit_my_studio_event.png" alt="MY STUDIO EVENT" /></h4>
			<div class="desc">
				<div class="take">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150907/txt_take_v2.png" alt="당신의 스튜디오를 신청하세요! 신청하신 분들 중 추첨을 통해 6분에게 MY STUDIO PACKAGE를 보내드립니다! 이벤트 기간은 2015년 9월 7일부터 9월 20일까지며, 당첨자 발표는 2015년 9월 21일 입니다." /></p>
					<%' for dev msg : 신청하기 버튼 %>
					<div class="btnTake">
						<button type="button" onclick="jsSubmitComment();return false;"><img src="http://webimage.10x10.co.kr/play/ground/20150907/btn_take.png" alt="MY STUDIO 신청하기" /></button>
						<span></span>
					</div>
				</div>
				<div class="namecard">
					<div class="name">
						<img src="http://webimage.10x10.co.kr/play/ground/20150907/img_name_card.png" alt="MY STUDIO 포토그래퍼" />
						<%' for dev msg : 아이디 노출 %>
						<% if Not(IsUserLoginOK) then %>
							<strong><span></span></strong>
						<% Else %>
							<strong><span><%=userid%></span></strong>
						<% End If %>

					</div>

					<p class="count">
						<img src="http://webimage.10x10.co.kr/play/ground/20150907/txt_count_01.png" alt="총" />
						<%' for dev msg : 응모자수 카운트 %>
						<strong><%=FormatNumber(iCTotCnt, 0)%></strong>
						<img src="http://webimage.10x10.co.kr/play/ground/20150907/txt_count_02.png" alt="분의 스튜디오가 오픈 준비 중입니다!" />
					</p>
				</div>
			</div>
		</div>
	</div>

	<div class="brand">
		<p><img src="http://webimage.10x10.co.kr/play/ground/20150907/txt_brand.jpg" alt="휴대용 스튜디오는 세계 최초 스마트폰용 포터블 스튜디오 Foldio 제품입니다." /></p>
		<a href="/street/street_brand_sub06.asp?makerid=orangemonkie" class="btnBrand" target="_blank">
			<img src="http://webimage.10x10.co.kr/play/ground/20150907/btn_brand.gif" alt="브랜드 바로가기" />
			<span class="square"></span>
		</a>
	</div>
</div>
<form name="frmcom" method="post"></form>
<!-- #include virtual="/lib/db/dbclose.asp" -->