<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'########################################################
' PLAY #23 SUMMER ITEM _ BANGBANG GUN(뱅뱅건)
' 2015-08-07 원승현 작성
'########################################################
Dim eCode, userid, vQuery, vga
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64847
Else
	eCode   =  65349
End If

userid = getloginuserid()
vga			= requestCheckVar(Request("ga"),3)

Dim strSql, incruitCnt, jobCnt, albaCnt, loveCnt

	vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' And sub_opt3='incruit' "
	rsget.Open vQuery,dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		incruitCnt = rsget(0)
	End IF
	rsget.close

	vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' And sub_opt3='job' "
	rsget.Open vQuery,dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		jobCnt = rsget(0)
	End IF
	rsget.close

	vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' And sub_opt3='alba' "
	rsget.Open vQuery,dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		albaCnt = rsget(0)
	End IF
	rsget.close

	vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' And sub_opt3='love' "
	rsget.Open vQuery,dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		loveCnt = rsget(0)
	End IF
	rsget.close
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
img {vertical-align:top;}
.groundHeadWrap {width:100%; background:#05a2ef;}
.groundCont {padding-bottom:0; background:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:125px 20px 60px;}
.bangCont {position:relative; width:1140px; margin:0 auto;}
.playGr20150810 {overflow:hidden; text-align:center;}
.intro {height:777px; background:#05a2ef;}
.intro h2 span {display:block; overflow:hidden; position:absolute; width:370px; height:119px; z-index:30;}
.intro h2 span.t01 {left:395px; top:109px;}
.intro h2 span.t02 {left:395px; top:238px;}
.intro h2 span.t03 {left:438px; top:369px; width:285px;}
.intro h2 span img {display:block; position:absolute; left:0; top:-119px;}
.intro .copy {position:absolute; left:220px; top:528px;}
.intro .arm {position:absolute; left:800px; top:656px; width:1140px; height:327px; background:url(http://webimage.10x10.co.kr/play/ground/20150810/img_arm.png) 0 0 no-repeat;}
.intro .waterDrop {position:absolute; left:92px; top:28px; width:1044px; height:469px; margin-top:-15px; z-index:40; background:url(http://webimage.10x10.co.kr/play/ground/20150810/img_water_drop.png) 0 0 no-repeat; opacity:0;}
.purpose {height:565px;}
.purpose p {position:absolute; left:212px; z-index:40;}
.purpose p.t01 {top:134px;}
.purpose p.t02 {top:334px;}
.purpose p.target {left:92px; top:52px; z-index:30; width:234px; height:234px;}
.purpose p.target img {display:inline-block; position:absolute; left:50%; top:50%; width:204px; margin:-102px 0 0 -102px;}
.purpose .goShoot {display:block; position:absolute; left:619px; top:336px;}
.waterGun {padding:147px 0 100px; background:url(http://webimage.10x10.co.kr/play/ground/20150810/bg_grid02.gif) 0 0 repeat;}
.waterGun .swiper {position:relative; height:740px; margin:94px 0 64px;}
.waterGun .swiper .swiper-container {overflow:hidden; width:100%;}
.waterGun .swiper .swiper-slide {float:left;}
.waterGun .swiper .swiper-slide a {display:block; width:100%;}
.waterGun .swiper .swiper-slide img {width:100%; vertical-align:top;}
.waterGun .swiper button {border:0; background:none;}
.waterGun .swiper .btnNav {display:block; position:absolute; right:60px; z-index:10;}
.waterGun .swiper .prev {top:289px;}
.waterGun .swiper .next {top:437px;}
.waterGun .swiper .pagination {position:absolute; top:337px; right:68px; width:10px;}
.waterGun .swiper .pagination span {display:block; position:relative; width:10px; height:10px; margin-bottom:10px; border-radius:50%; background:#bfbfbf; cursor:pointer;}
.waterGun .swiper .pagination .swiper-active-switch {background:#fea5a0;}
.tipSlide {padding:150px 0 140px;}
.tipSlide h3 {padding-bottom:70px;}
.tipSlide .slide {position:relative; width:1140px; margin:0 auto;}
.tipSlide .slidesjs-pagination {overflow:hidden; position:absolute; bottom:45px; left:50%; width:136px; height:4px; margin-left:-67px; z-index:30;}
.tipSlide .slidesjs-pagination li {float:left; padding:0 9px;}
.tipSlide .slidesjs-pagination li a {display:inline-block; width:27px; height:4px; background:#fff; border-radius:2px; text-indent:-9999px;}
.tipSlide .slidesjs-pagination li a.active {background:#000;}
.applyGun {overflow:hidden; padding:124px 0; background:#2293ca url(http://webimage.10x10.co.kr/play/ground/20150810/bg_blue.gif) 0 50% repeat;}
.applyGun ul {overflow:hidden; margin-right:-15px; padding:78px 0 82px;}
.applyGun li {position:relative; float:left; padding-right:14px;}
.applyGun li input {display:inline-block; position:absolute; left:50%; top:340px; margin-left:-16px; z-index:30;}
.applyGun li .count {padding-top:20px;}
.applyGun li .count strong {color:#fff; font-size:35px; line-height:33px; padding-right:3px; font-family:verdana; font-weight:normal;}
.applyGun li .count span {display:block;}
.fullSlide {position:relative;}
.fullSlide .slide {width:100%;}
.fullSlide .slide img {width:100%;}
.fullSlide .slidesjs-pagination {overflow:hidden; position:absolute; bottom:75px; left:50%; width:192px; height:14px; margin-left:-95px; z-index:30;}
.fullSlide .slidesjs-pagination li {float:left; padding:0 12px;}
.fullSlide .slidesjs-pagination li a {display:inline-block; width:14px; height:14px; background:url(http://webimage.10x10.co.kr/play/ground/20150810/btn_pagination02.png); text-indent:-9999px;}
.fullSlide .slidesjs-pagination li a.active {background-position:100% 0;}
.noStress {text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20150810/bg_noise.gif) 0 0 repeat;}
.noStress p {padding:58px 0;}

/*animation */
.purpose p.target img {-webkit-animation-duration:5000ms; -webkit-animation-iteration-count: infinite; -webkit-animation-timing-function: linear; -moz-animation-duration:5000ms; -moz-animation-iteration-count: infinite; -moz-animation-timing-function: linear; -ms-animation-duration:5000ms; -ms-animation-iteration-count: infinite; -ms-animation-timing-function: linear; animation-duration:5000ms; animation-iteration-count: infinite; animation-timing-function: linear; animation-name:spin; -webkit-animation-name:spin; -moz-animation-name: spin; -ms-animation-name: spin;}
@-ms-keyframes spin {from {-ms-transform: rotate(0deg);} to {-ms-transform: rotate(360deg);}}
@-moz-keyframes spin {from { -moz-transform: rotate(0deg);} to { -moz-transform: rotate(360deg);}}
@-webkit-keyframes spin {from { -webkit-transform: rotate(0deg);} to { -webkit-transform: rotate(360deg);}}
@keyframes spin {from {transform:rotate(0deg);} to { transform:rotate(-360deg);}}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	//swipe
	showSwiper= new Swiper('.swiper1',{
		mode :'vertical',
		autoplay:4500,
		loop:true,
		resizeReInit:true,
		calculateHeight:true,
		pagination:'.pagination',
		paginationClickable:true,
		speed:600
	});
	$('.swiper .prev').on('click', function(e){
		e.preventDefault()
		showSwiper.swipePrev()
	});
	$('.swiper .next').on('click', function(e){
		e.preventDefault()
		showSwiper.swipeNext()
	});

	// slide
	$('.tipSlide .slide').slidesjs({
		width:"1140",
		height:"733",
		navigation:false,
		pagination:{effect:"slide"},
		play: {interval:4800, effect:"slide", auto:true},
		effect:{slide: {speed:1200}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.tipSlide .slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	$('.fullSlide .slide').slidesjs({
		width:"1920",
		height:"1140",
		navigation:false,
		pagination:{effect:"fade"},
		play: {interval:4500, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.fullSlide .slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	$(".goShoot").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:4840}, 800);
	});
	function moveTarget () {
		$(".purpose p.target img").animate({"width":"204","margin-top":"-102px","margin-left":"-102px"},1000).animate({"width":"234","margin-top":"-117px","margin-left":"-117px"},1000, moveTarget);
	}
	moveTarget();
	function intro () {
		$('.intro h2 span.t01 img').animate({top:'0'},{duration: 'slow', easing: 'easeOutElastic'}, 800);
		$('.intro h2 span.t02 img').delay(300).animate({top:'0'},{duration: 'slow', easing: 'easeOutElastic'}, 800);
		$('.intro h2 span.t03 img').delay(500).animate({top:'0'},{duration: 'slow', easing: 'easeOutElastic'}, 800);
		$('.waterDrop').animate({"opacity":"0.5"}, 1000).animate({"opacity":"1","margin-top":"0"}, 800);
		$('.copy').delay(2000).effect("pulsate", {times:2},300 );
	}
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 300 ) {
			intro();
		}
		if (scrollTop > 700 ) {
			$('.intro .arm').animate({"left":"488px"}, 700);
		}
	});

	<% if vga="1" then %>
		window.parent.$('html,body').animate({scrollTop:4840}, 10);
	<% end if %>
});
</script>
<script type="text/javascript">
<!--

	function jsSubmit(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

		if($(':radio[name="votet"]:checked').length < 1){
			alert('날려버리고 싶은 스트레스를 골라 주세요!');
			return false;
		}

	   document.frmcom.votetour.value = $(':radio[name="votet"]:checked').val();
	   document.frmcom.submit();
	}

//-->
</script>

<div class="playGr20150810">
	<div class="intro">
		<div class="bangCont">
			<h2>
				<span class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20150810/tit_bang.png" alt="BANG" /></span>
				<span class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20150810/tit_bang.png" alt="BANG" /></span>
				<span class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20150810/tit_gun.png" alt="GUN" /></span>
			</h2>
			<p class="copy"><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_copy.png" alt="더위만큼 짜증나는 스트레스를 향해 물총을 쏴라!" /></p>
			<div class="arm"></div>
			<div class="waterDrop"></div>
		</div>
	</div>
	<div class="purpose">
		<div class="bangCont">
			<p class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_purpose01.png" alt="더위와 함께 쌓인 스트레스를 한방에 날려버릴 시원한 일상 탈출 프로젝트!" /></p>
			<p class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_purpose02.png" alt="[스트레스를 향해 물총을 쏴라 뱅! 뱅!] 특집 여기 텐바이텐 플레이가 준비한 뱅뱅건이 준비되어 있습니다. 무더운 여름 나를 더욱 덥게 만드는 스트레스가 있으시다면, 뱅뱅건으로 시원하게 쏴서 날려버리세요!!" /></p>
			<p class="target"><img src="http://webimage.10x10.co.kr/play/ground/20150810/bg_target.png" alt="" /></p>
			<a href="#applyGun" class="goShoot"><img src="http://webimage.10x10.co.kr/play/ground/20150810/btn_shoot.gif" alt="SHOOT! 뱅뱅건 쏘러 가기" /></a>
		</div>
	</div>
	<div class="waterGun">
		<div class="bangCont">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150810/tit_water_gun.png" alt="BANG BANG WATER GUN" /></h3>
			<div class="swiper">
				<div class="swiper-container swiper1">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_type01.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_type02.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_type03.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_type04.jpg" alt="" /></div>
					</div>
					<div class="pagination"></div>
				</div>
				<button type="button" class="btnNav prev"><img src="http://webimage.10x10.co.kr/play/ground/20150810/btn_prev.png" alt="PREV" /></button>
				<button type="button" class="btnNav next"><img src="http://webimage.10x10.co.kr/play/ground/20150810/btn_next.png" alt="NEXT" /></button>
			</div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_composition.png" alt="뱅뱅건의 세트 구성" /></div>
		</div>
	</div>

	<div class="tipSlide">
		<h3><img src="http://webimage.10x10.co.kr/play/ground/20150810/tit_tip.gif" alt="BANG BANG WATER GUN" /></h3>
		<div class="slide">
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_tip01.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_tip02.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_tip03.jpg" alt="" /></div>
		</div>
	</div>
	<!-- 이벤트 응모 -->
	<div id="applyGun" class="applyGun">
		<div class="bangCont">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150810/tit_apply_bangbang.png" alt="BANG BANG GUN - 날려버리고 싶은 스트레스를 골라 뱅뱅건을 신청해주세요! 추첨을 통해 각각 10분에게 선택하신 뱅뱅건 SET를 드립니다!" /></h3>
			<ul>
				<li>
					<label for="gun01"><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_select01.png" alt="취업건" /></label>
					<input type="radio" id="gun01" name="votet" value="incruit"  />
					<p class="count">
						<strong><%=FormatNumber(incruitCnt, 0)%></strong><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_count01.png" alt="명이" />
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_count02.png" alt="조준 중입니다." /></span>
					</p>
				</li>
				<li>
					<label for="gun02"><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_select02.png" alt="직장건" /></label>
					<input type="radio" id="gun02" name="votet" value="job"  />
					<p class="count">
						<strong><%=FormatNumber(jobCnt, 0)%></strong><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_count01.png" alt="명이" />
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_count02.png" alt="조준 중입니다." /></span>
					</p>
				</li>
				<li>
					<label for="gun03"><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_select03.png" alt="알바건" /></label>
					<input type="radio" id="gun03" name="votet" value="alba"  />
					<p class="count">
						<strong><%=FormatNumber(albaCnt, 0)%></strong><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_count01.png" alt="명이" />
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_count02.png" alt="조준 중입니다." /></span>
					</p>
				</li>
				<li>
					<label for="gun04"><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_select04.png" alt="연애건" /></label>
					<input type="radio" id="gun04" name="votet" value="love"  />
					<p class="count">
						<strong><%=FormatNumber(loveCnt, 0)%></strong><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_count01.png" alt="명이" />
						<span><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_count02.png" alt="조준 중입니다." /></span>
					</p>
				</li>
			</ul>
			<p><input type="image" src="http://webimage.10x10.co.kr/play/ground/20150810/btn_apply.gif" alt="뱅뱅건 신청하기" onclick="jsSubmit();return false;" /></p>
		</div>
	</div>
	<form name="frmcom" method="get" action="/play/groundsub/doEventSubscript65349.asp" style="margin:0px;">
		<input type="hidden" name="votetour">
	</form>
	<!--// 이벤트 응모 -->
	<div class="fullSlide">
		<div class="slide">
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_full01.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_full02.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_full03.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_full04.jpg" alt="" /></div>
			<div><img src="http://webimage.10x10.co.kr/play/ground/20150810/img_slide_full05.jpg" alt="" /></div>
		</div>
	</div>
	<div class="noStress">
		<p><img src="http://webimage.10x10.co.kr/play/ground/20150810/txt_no_stress.png" alt="취업이건, 직장이건, 알바건, 연애건! 스트레스 없이 행복하게 하시기를 바랍니다 :-)" /></p>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->