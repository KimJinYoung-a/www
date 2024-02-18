<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'########################################################
' PLAY #19 Holiday Sticker
' 2015-04-17 원승현 작성
'########################################################
Dim eCode, userid, vQuery
IF application("Svr_Info") = "Dev" THEN
	eCode   =  61756
Else
	eCode   =  61577
End If

userid = getloginuserid()

Dim strSql, seaCnt, sakuraCnt, overseasCnt

	vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' And sub_opt3='sea' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		seaCnt = rsget(0)
	End IF
	rsget.close

	vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' And sub_opt3='sakura' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		sakuraCnt = rsget(0)
	End IF
	rsget.close

	vQuery = " Select count(userid) From [db_event].dbo.tbl_event_subscript Where evt_code='"&eCode&"' And sub_opt3='overseas' "
	rsget.Open vQuery,dbget,1
	IF Not rsget.Eof Then
		overseasCnt = rsget(0)
	End IF
	rsget.close

%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundHeadWrap {width:100%; background:#fbfbfb !important;}
.groundCont {background:#fff1d4 !important;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:95px 20px 50px; background:#fff1d4 !important;}
.playGr20150420 {position:relative; overflow:hidden; background:#fff1d4;}
.playGr20150420 img {vertical-align:top;}
.holidayCont {position:relative; width:1140px; margin:0 auto;}
.intro {padding-top:120px; text-align:center; background:#fbfbfb;}
.intro .copy {width:1100px; margin:0 auto;}
.intro .copy .play {padding-bottom:40px; margin-bottom:8px; background:url(http://webimage.10x10.co.kr/play/ground/20150420/bg_wave01.png) center bottom no-repeat;}
.intro .copy h2 {overflow:hidden; position:relative; height:129px; margin-bottom:42px;}
.intro .copy h2 span {display:block; position:absolute;}
.intro .copy h2 span.tit01 {width:374px; left:187px; top:130px;}
.intro .copy h2 span.tit02 {width:344px; left:572px; top:130px;}
.intro .copy h2 span.line {bottom:0; width:0; height:2px; background:#000;}
.intro .copy h2 span.left {left:50%;}
.intro .copy h2 span.right {right:50%;}
.intro .copy .forYou {height:14px;}
.intro .copy .forYou img {display:none;}
.intro .pic {margin-left:-300px;}
.goTravel {position:relative; padding-top:332px; background:#efefef;}
.goTravel .arrow {display:inline-block; position:absolute; left:50%; top:-2px; width:53px; height:41px; margin-left:-26px; background:url(http://webimage.10x10.co.kr/play/ground/20150420/bg_arrow.gif) center top no-repeat; vertical-align:top;}
.goTravel .slideTab {overflow:visible !important;}
.goTravel .slideTab .slidesjs-pagination {overflow:hidden; position:absolute; left:50%; top:-180px; width:635px; margin-left:-318px; z-index:40;}
.goTravel .slideTab .slidesjs-pagination li {float:left; width:163px; height:163px; padding:0 24px;}
.goTravel .slideTab .slidesjs-pagination li a {display:block; width:163px; height:163px; background-position:left top; background-repeat:no-repeat; text-indent:-9999px;}
.goTravel .slideTab .slidesjs-pagination li a.active {background-position:left -163px;}
.goTravel .slideTab .slidesjs-pagination li.p01 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20150420/tab01.png)}
.goTravel .slideTab .slidesjs-pagination li.p02 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20150420/tab02.png)}
.goTravel .slideTab .slidesjs-pagination li.p03 a {background-image:url(http://webimage.10x10.co.kr/play/ground/20150420/tab03.png)}

.sampleImage {text-align:center; padding:135px 0 112px; background:#fff;}
.sampleImage .picView {overflow:hidden; width:1142px; margin:0 auto; padding:98px 0 96px;}
.sampleImage .picView div {overflow:hidden; position:relative; float:left; width:360px; padding:0 10px;}
.sampleImage .picView div img {display:inline-block; width:100%; margin-left:-150%;}
.holidayStickerWrap {background:url(http://webimage.10x10.co.kr/play/ground/20150420/bg_line02.gif) left 493px no-repeat #d8f1f9;}
.holidaySticker {padding:144px 0 198px; background:url(http://webimage.10x10.co.kr/play/ground/20150420/bg_line01.gif) center 493px no-repeat;}
.holidaySticker .txt {overflow:hidden; width:965px; margin:0 auto; padding-bottom:84px;}
.holidaySticker .txt h3 {float:left;}
.holidaySticker .txt p {float:right; padding-top:11px;}
.holidaySticker .pic {overflow:hidden; width:1118px; margin:0 auto; padding-bottom:20px;}
.holidaySticker .pic li {float:left; padding:0 2px 20px;}
.holidaySticker .withHH {text-align:right; padding-right:28px;}
.holidaySticker .withHH p {padding-bottom:5px;}
.readyWrap {border-bottom:2px solid #c0e6f2; background:url(http://webimage.10x10.co.kr/play/ground/20150420/bg_pattern03.gif) center top no-repeat #d8f1f9;}
.areYouReady {background:url(http://webimage.10x10.co.kr/play/ground/20150420/bg_line05.gif) center top no-repeat;}
.areYouReady .pic {position:relative; height:270px;}
.areYouReady .pic span {display:inline-block; position:absolute; }
.areYouReady .wave {left:0; bottom:-2px; width:100%; height:14px; z-index:30; background:url(http://webimage.10x10.co.kr/play/ground/20150420/bg_wave02.png) left top repeat-x;}
.areYouReady .airplane {left:50%; top:84px; width:174px; height:107px; margin-left:-87px; z-index:35;}
.areYouReady .airplane img {display:inline-block; position:absolute; left:0; top:0;}
.areYouReady .cloud {left:50%; top:62px; width:1078px; height:139px; margin-left:-455px; z-index:30; background:url(http://webimage.10x10.co.kr/play/ground/20150420/bg_cloud.png) left top no-repeat;}
.areYouReady .txt {text-align:center; width:619px; height:120px; margin:0 auto; padding-top:90px; background:url(http://webimage.10x10.co.kr/play/ground/20150420/txt_ready.png) center 50px no-repeat;}
.areYouReady .txt img {display:none;}
.applyEvent {padding:88px 0 135px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20150420/bg_pattern01.gif) left top repeat-x;}
.applyEvent ul {overflow:hidden; padding:55px 0 60px;}
.applyEvent li {float:left; width:355px; height:488px; padding:15px; background:url(http://webimage.10x10.co.kr/play/ground/20150420/bg_box.png) left top no-repeat;}
.applyEvent li.type02 {margin:0 -15px;}
.applyEvent li div {position:relative; width:353px; height:486px;}
.applyEvent li div label {display:inline-block; margin-top:47px;}
.applyEvent li.type01 div {border:1px solid #bde5eb;}
.applyEvent li.type02 div {border:1px solid #f1d6e2;}
.applyEvent li.type03 div {border:1px solid #ddecba;}
.applyEvent li .count {position:absolute; left:0; bottom:42px; width:100%; line-height:14px; font-weight:bold; color:#000;}
.applyEvent li .count strong {padding-right:2px;}
.applyEvent li.type01 .count strong {color:#1487c8;}
.applyEvent li.type02 .count strong {color:#eb57a0;}
.applyEvent li.type03 .count strong {color:#73a301;}
.applyEvent li input {display:inline-block; position:absolute; left:50%; bottom:120px; margin-left:-6px; z-index:40;}
.slide {position:relative;}
.slide .slidesjs-navigation {position:absolute; top:50%; width:87px; height:87px; margin-top:-44px; z-index:30; background-position:left top; background-repeat:no-repeat; text-indent:-9999px;}
.slide .slidesjs-previous {left:18px; background-image:url(http://webimage.10x10.co.kr/play/ground/20150420/btn_prev.png);}
.slide .slidesjs-next {right:18px; background-image:url(http://webimage.10x10.co.kr/play/ground/20150420/btn_next.png);}
.slide .slidesjs-pagination {overflow:hidden; position:absolute; left:50%; bottom:50px; width:164px; margin-left:-81px; z-index:30;}
.slide .slidesjs-pagination li {float:left; width:34px; height:6px; padding:0 10px;}
.slide .slidesjs-pagination li a {display:block; width:34px; height:6px; background:url(http://webimage.10x10.co.kr/play/ground/20150420/bg_pagination.png) left top no-repeat; text-indent:-9999px;}
.slide .slidesjs-pagination li a.active {background-position:-33px top;}
@media all and (min-width:1400px) {
	.sampleImage .picView {width:1400px;}
	.sampleImage .picView div {width:445px;}
}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".slideTab").slidesjs({
		width:"1140", 
		height:"760",
		navigation:false,
		pagination:{effect:"fade"},
		play: {interval:4500, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slideTab').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
	$('.slideTab .slidesjs-pagination li:nth-child(1)').addClass('p01');
	$('.slideTab .slidesjs-pagination li:nth-child(2)').addClass('p02');
	$('.slideTab .slidesjs-pagination li:nth-child(3)').addClass('p03');
	$(".slide").slidesjs({
		width:"1740", 
		height:"1011",
		navigation:{effect:"fade"},
		pagination:{effect:"fade"},
		play: {interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:800, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$('.intro .copy h2 span.line').delay(400).animate({"width":"50%"}, 1000);
	$('.intro .copy h2 span.tit01').delay(1200).animate({"top":"0"}, 800);
	$('.intro .copy h2 span.tit02').delay(2000).animate({"top":"0"}, 800);
	$('.intro .copy .forYou img').delay(3000).fadeIn(1200);

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 2500){
			$('.areYouReady .txt img').delay(500).fadeIn(1000);
		}
		if (scrollTop > 4100){
			$('.sampleImage .picView .p01 img').animate({"margin-left":"0"}, 800);
			$('.sampleImage .picView .p02 img').delay(500).animate({"margin-left":"0"}, 800);
			$('.sampleImage .picView .p03 img').delay(800).animate({"margin-left":"0"}, 800);
		}
	});

	// move animation
	function moveItem () {
		$(".areYouReady .airplane .move").animate({"margin-top":"0"},700).animate({"margin-top":"5px"},1200, moveItem);
		$(".areYouReady .cloud").animate({"margin-top":"0"},2000).animate({"margin-top":"5px"},800, moveItem);
	}
	moveItem();

});
var scrollSpeed =30;
var current = 0;
var direction = 'h';
function bgscroll(){
	current -= 1;
	$('.areYouReady .wave').css("backgroundPosition", (direction == 'h') ? current+"px 0" : "0 " + current+"px");
}
setInterval("bgscroll()", scrollSpeed);
</script>
<script type="text/javascript">
<!--

	function jsSubmit(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

		if($(':radio[name="votet"]:checked').length < 1){
			alert('가고 싶은 그 곳을 선택해주세요!');						
			return false;
		}

	   document.frmcom.votetour.value = $(':radio[name="votet"]:checked').val();
	   document.frmcom.submit();
	}

//-->
</script>

<div class="playGr20150420">

	<div class="intro">
		<div class="holidayCont">
			<div class="copy">
				<p class="play"><img src="http://webimage.10x10.co.kr/play/ground/20150420/txt_play.png" alt="TENBYTEN PLAY" /></p>
				<h2>
					<span class="tit01"><img src="http://webimage.10x10.co.kr/play/ground/20150420/tit_holiday.png" alt="Holiday" /></span>
					<span class="tit02"><img src="http://webimage.10x10.co.kr/play/ground/20150420/tit_sticker.png" alt="Sticker" /></span>
					<span class="line left"></span>
					<span class="line right"></span>
				</h2>
				<p class="forYou"><img src="http://webimage.10x10.co.kr/play/ground/20150420/txt_for_you.png" alt="휴가가 필요한 당신에게!" /></p>
			</div>
			<div class="pic"><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_main_pic.jpg" alt="" /></div>
		</div>
	</div>
	<div class="holidayStickerWrap">
		<div class="holidaySticker">
			<div class="holidayCont">
				<div class="txt">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20150420/tit_holiday_sticker.gif" alt="Holiday Sticker" /></h3>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150420/txt_holiday_sticker.gif" alt="업무는 쌓이고, 주말로는 피로가 회복되지 않는다… 나를 위한 시간은 점점 줄어들고, 남을 위한 시간만 남을 때! 어디론가 훌쩍 떠나서 모든 걸 잊고 쉬고 싶지 않나요? 당장은 떠날 수 없는 이유들이 많지만, 내 방 혹은 사무실 한편에 휴가지를 옮겨 둔다면 어떨까요. 그래도 조금은 위안을 얻고, 희망을 품고 일할 수 있지 않을까요! 텐바이텐 플레이에서는 지친 직장인들에게 작은 위로가 되는 휴가 스티커를 준비했습니다! 여러분께 힘이 되는 스티커가 되길 바랍니다!" /></p>
				</div>
				<ul class="pic">
					<li><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_sticker01.png" alt="스티커 이미지" /></li>
					<li><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_sticker02.png" alt="스티커 이미지" /></li>
					<li><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_sticker03.png" alt="스티커 이미지" /></li>
					<li><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_sticker04.png" alt="스티커 이미지" /></li>
					<li><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_sticker05.png" alt="스티커 이미지" /></li>
					<li><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_sticker06.png" alt="스티커 이미지" /></li>
				</ul>
				<div class="withHH">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20150420/txt_sticker_info.gif" alt="홀리데이 스티커는 텐바이텐 감성매거진 히치하이커의 사진으로 만들어졌습니다." /></p>
					<a href="/hitchhiker/" target="_blank"><img src="http://webimage.10x10.co.kr/play/ground/20150420/btn_hitchhiker.gif" alt="히치하이커 보러가기" /></a>
				</div>
			</div>
		</div>
	</div>
	<div class="readyWrap">
		<div class="areYouReady">
			<div class="pic">
				<span class="wave"></span>
				<span class="airplane">
					<img src="http://webimage.10x10.co.kr/play/ground/20150420/img_airplane.png" alt="비행기" class="move" />
					<img src="http://webimage.10x10.co.kr/play/ground/20150420/img_airplane02.gif" alt="비행기" />
				</span>
				<span class="cloud"></span>
			</div>
			<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20150420/txt_ready02.png" alt="떠날준비 되셨나요?" /></p>
		</div>
	</div>
	<div class="goTravel">
		<span class="arrow"></span>
		<div class="holidayCont">
			<div class="slideTab">
				<img src="http://webimage.10x10.co.kr/play/ground/20150420/img_move01.gif" alt="" />
				<img src="http://webimage.10x10.co.kr/play/ground/20150420/img_move02.gif" alt="" />
				<img src="http://webimage.10x10.co.kr/play/ground/20150420/img_move03_.gif" alt="" />
			</div>
		</div>
	</div>
	<div class="sampleImage">
		<p><img src="http://webimage.10x10.co.kr/play/ground/20150420/txt_view_picture.gif" alt="푸른 바다로 출발!" /></p>
		<div class="picView">
			<div class="p01"><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_sample01.jpg" alt="" /></div>
			<div class="p02"><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_sample02.jpg" alt="" /></div>
			<div class="p03"><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_sample03.jpg" alt="" /></div>
		</div>
		<p class="info"><img src="http://webimage.10x10.co.kr/play/ground/20150420/txt_sticker_type.gif" alt="푸른 바다로 출발!" /></p>
	</div>
	<!-- 이벤트 참여 -->
	<div class="applyEvent">
		<div class="holidayCont">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150420/tit_event.png" alt="EVENT - 어디론가 훌쩍 떠나고 싶은 이 순간, 가고 싶은 그 곳을 선택해보세요!" /></h3>
			<ul>
				<li class="type01">
					<div>
						<label for="select01"><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_select01.jpg" alt="푸른 바다로 출발!" /></label>
						<input type="radio" id="select01" name="votet" value="sea" />
						<p class="count">총 <strong><%=FormatNumber(seaCnt, 0)%></strong>명이 여행 중입니다.</p>
					</div>
				</li>
				<li class="type02">
					<div>
						<label for="select02"><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_select02.jpg" alt="화사한 벚꽃길로 출발!" /></label>
						<input type="radio" id="select02" name="votet" value="sakura" />
						<p class="count">총 <strong><%=FormatNumber(sakuraCnt, 0)%></strong>명이 여행 중입니다.</p>
					</div>
				</li>
				<li class="type03">
					<div>
						<label for="select03"><img src="http://webimage.10x10.co.kr/play/ground/20150420/img_select03.jpg" alt="새로운 해외로 출발!" /></label>
						<input type="radio" id="select03" name="votet" value="overseas" />
						<p class="count">총 <strong><%=FormatNumber(overseasCnt, 0)%></strong>명이 여행 중입니다.</p>
					</div>
				</li>
			</ul>
			<p><a href="" onclick="jsSubmit();return false;"><img src="http://webimage.10x10.co.kr/play/ground/20150420/btn_apply.gif" alt="응모하기" /></a></p>
		</div>
	</div>
	<form name="frmcom" method="post" action="doEventSubscript61577.asp" style="margin:0px;">
		<input type="hidden" name="votetour">
	</form>
	<!--// 이벤트 참여 -->
	<div class="slide">
		<img src="http://webimage.10x10.co.kr/play/ground/20150420/img_slide01.jpg" alt="" />
		<img src="http://webimage.10x10.co.kr/play/ground/20150420/img_slide02.jpg" alt="" />
		<img src="http://webimage.10x10.co.kr/play/ground/20150420/img_slide03.jpg" alt="" />
	</div>
</div>




<!-- #include virtual="/lib/db/dbclose.asp" -->