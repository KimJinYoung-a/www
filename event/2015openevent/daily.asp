<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : 사월의 꿀 맛 - 일상다반사"	'페이지 타이틀 (필수)
	strPageDesc = "당신의 달콤한 쇼핑 라이프를 위해! 사월의 꿀 맛. 당신의 일상 속에 붙여 주세요. - 꿀맛 일상다반사"		'페이지 설명
	strPageImage = "http://webimage.10x10.co.kr/eventIMG/2015/60834/m/txt_daily.png"		'페이지 요약 이미지(SNS 퍼가기용)
	strPageUrl = "http://www.10x10.co.kr/event/2015openevent/daily.asp"			'페이지 URL(SNS 퍼가기용)
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* 2015 open event common style */
#eventDetailV15 .gnbWrapV15 {height:38px;}
#eventDetailV15 #contentWrap {padding-top:0; padding-bottom:75px;}
.eventContV15 .tMar15 {margin-top:0;}
.aprilHoney {background:#fffbee url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_sub_wave.png) repeat-x 50% 0;}
.honeyHead {position:relative; width:1140px; margin:0 auto; text-align:left;}
.honeyHead .hgroup {position:absolute; top:22px; left:0;}
.honeyHead .hgroup p {visibility:hidden; width:0; height:0;}
.honeyHead ul {overflow:hidden; width:656px; margin-left:484px;}
.honeyHead ul li {float:left; width:131px;}
.honeyHead ul li.nav5 {width:132px;}
.honeyHead ul li a {overflow:hidden; display:block; position:relative; height:191px; font-size:11px; line-height:191px; text-align:center;}
.honeyHead ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60829/bg_sub_nav_12pm.png) no-repeat 0 0;}
.honeyHead ul li.nav1 a:hover span {background-position:0 -191px;}
.honeyHead ul li.nav2 a span {background-position:-131px 0;}
.honeyHead ul li.nav2 a:hover span {background-position:-131px -191px;}
.honeyHead ul li.nav2 a.on span {background-position:-131px 100%;}
.honeyHead ul li.nav3 a span {background-position:-262px 0;}
.honeyHead ul li.nav3 a:hover span {background-position:-262px -191px;}
.honeyHead ul li.nav3 a.on span {background-position:-262px 100%;}
.honeyHead ul li.nav4 a span {background-position:-393px 0;}
.honeyHead ul li.nav4 a:hover span {background-position:-393px -191px;}
.honeyHead ul li.nav4 a.on span {background-position:-393px 100%;}
.honeyHead ul li.nav5 {position:relative;}
.honeyHead ul li.nav5 a span {background-position:100% 0;}
.honeyHead ul li.nav5 a:hover span {background-position:100% -191px;}
.honeyHead ul li.nav5 a.on span {background-position:100% 100%;}
.honeyHead ul li.nav5 .hTag {position:absolute; top:9px; left:77px;}
.honeyHead ul li.nav5:hover .hTag {-webkit-animation-name: bounce; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.5s; -moz-animation-name: bounce; -moz-animation-iteration-count: infinite; -moz-animation-duration:0.5s; -ms-animation-name: bounce; -ms-animation-iteration-count: infinite; -ms-animation-duration:0.5s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function: ease-out;}
	50% {margin-top:8px; -webkit-animation-timing-function: ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function: ease-out;}
	50% {margin-top:8px; animation-timing-function: ease-in;}
}

#eventDetailV15 #contentWrap {background-color:#fffce9;}
.honeySection {position:relative; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60834/bg_color_pattern.png) repeat-x 0 0;}
/* 일상다반사 */
.honeyDaily .topic {padding-bottom:21px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60834/bg_wave_beige.png) repeat-x 50% 100%;}
.honeyDaily .topic .bg {position:absolute; z-index:5; width:1873px; top:-15px; left:50%; height:682px; margin-left:-936px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60834/bg_illust.png) no-repeat 50% 0;}
.honeyDaily .topic .cloud {position:absolute; z-index:5; width:100%; top:670px; left:0; height:450px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60834/bg_cloud.png) repeat-x 50% 0;}
.honeyDaily .topic .inner {width:1140px; margin:0 auto;}
.honeyDaily .topic .hwrap {height:343px;}
.honeyDaily .topic .hwrap .sweet {position:absolute; top:20px; left:0; z-index:10; opacity:0;}
.honeyDaily .topic .hwrap .sun {position:absolute; top:20px; left:124px; z-index:5;}
.honeyDaily .topic .hwrap .cloud1 {position:absolute; top:48px; left:107px; z-index:6;}
.honeyDaily .topic .hwrap .cloud2 {position:absolute; top:105px; left:650px; z-index:6;}
.honeyDaily .topic .hwrap .area {position:relative; width:710px; min-height:211px; margin:0 0 15px 210px; text-align:right; background-color:transparent;}
.honeyDaily .topic .hwrap .area p {margin-bottom:15px; padding-top:80px; padding-right:30px;}
.honeyDaily .topic .hwrap .area h3 {width:525px; position:absolute; top:117px; right:0; z-index:10; text-align:left;}
.honeyDaily .topic .hwrap .area h3:after {content:' '; display:block; clear:both;}
.honeyDaily .topic .hwrap .area h3 span {float:left; height:110px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/60834/tit_daily.png) no-repeat 0 0; text-indent:-999em;}
.honeyDaily .topic .hwrap .area h3 .letter1 {width:104px;}
.honeyDaily .topic .hwrap .area h3 .letter2 {width:112px; background-position:-104px 0;}
.honeyDaily .topic .hwrap .area h3 .letter3 {width:109px; background-position:-216px 0;}
.honeyDaily .topic .hwrap .area h3 .letter4 {width:104px; background-position:-320px 0;}
.honeyDaily .topic .hwrap .area h3 .letter5 {width:96px; background-position:100% 0;}
.rolling {position:relative; z-index:10; width:1136px; height:871px; margin-bottom:-41px; margin-left:1px; padding-top:76px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60834/bg_box.png) no-repeat 50% 0;}
.slide-wrap {position:relative; width:1000px; margin:0 auto;}
.slide {height:560px;}
.slide img {height:560px;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:50%; width:19px; height:29px; margin-top:-14px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/60834/btn_nav.png); background-repeat:no-repeat; text-indent:-999em;}
.slide .slidesjs-previous {left:30px; background-position:0 0;}
.slide .slidesjs-next {right:30px; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:30px; left:50%; z-index:50; width:100px; margin-left:-50px;}
.slidesjs-pagination li {float:left; padding:0 6px;}
.slidesjs-pagination li a {display:block; width:8px; height:8px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60834/btn_pagination.png) no-repeat 0 0; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:100% 0;}
.btnmore {width:1000px; margin:10px auto 0; padding-top:67px; border-top:1px solid #eee;}
.btnmore a {display:block;}
.your {background:#fffdf8 url(http://webimage.10x10.co.kr/eventIMG/2015/60834/bg_pattern.png) repeat-x 0 0;}
.your .inner {width:1140px; margin:0 auto;}
.your .put {position:relative; padding-top:85px;}
.your .put h4 {margin-bottom:-10px;}
.your .put .instagram {position:absolute; top:50px; left:550px;}
.your .put p {margin-top:57px;}
.your .photo {padding-top:16px; padding-bottom:70px;}
.your .photo h4 {padding-bottom:40px; border-bottom:1px solid #f0e7e0;}
.photolist {padding-top:20px;}

.noti {padding-top:58px; border-top:5px solid #ffde9f; background-color:#fffce9;}
.noti .inner {width:1140px; margin:0 auto; text-align:left;}
.noti ul {overflow:hidden; padding-top:33px;}
.noti ul li {float:left; width:544px; margin-top:4px; padding-left:26px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60834/blt_circle_pink.png) no-repeat 0 6px; color:#555; font-size:11px; line-height:1.75em;}

/* css3 animation */
.animated {-webkit-animation-duration:1s; animation-duration:1s; -webkit-animation-fill-mode:both; animation-fill-mode:both;}
@-webkit-keyframes fadeIn {
	0% {opacity:0;}
	100% {opacity:1;}
}
@keyframes fadeIn {
	0% {opacity:0;}
	100% {opacity:1;}
}
.fadeIn {-webkit-animation-name:fadeIn; animation-name:fadeIn; -webkit-animation-iteration-count:infinite; animation-iteration-count:infinite;}
.spin {-webkit-animation:spin 5s linear infinite;
	-moz-animation:spin 5s linear infinite;
	animation:spin 5s linear infinite;
}
@-moz-keyframes spin {100% { -moz-transform: rotate(360deg);}}
@-webkit-keyframes spin {100% { -webkit-transform: rotate(360deg);}}
@keyframes spin {100% { -webkit-transform: rotate(360deg); transform:rotate(360deg);}}
</style>

</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW tMar15">
						<!-- 2015 RENEWAL 사월의 꿀 맛 -->
						<div class="aprilHoney">
							<!-- #include virtual="/event/2015openevent/inc_header.asp" -->
							<!-- 일상다반사 -->
							<div class="honeySection honeyDaily">
								<div class="topic">
									<div class="inner">
										<div class="hwrap">
											<div class="area">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/txt_put.png" alt="당신의 일상 속에 붙여 주세요!" /></p>
												<h3>
													<span class="letter1">일</span>
													<span class="letter2">상</span>
													<span class="letter3">다</span>
													<span class="letter4">반</span>
													<span class="letter5">사</span>
												</h3>
												<strong class="sweet"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/img_sweet.png" alt="꿀맛" /></strong>
												<span class="sun spin"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/img_sun.png" alt="" /></span>
												<span class="cloud1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/img_cloud_01.png" alt="" /></span>
												<span class="cloud2"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/img_cloud_02.png" alt="" /></span>
											</div>
											<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/txt_gift.png" alt="이벤트 기간 동안 텐바이텐를 받는 모두에게 꿀맛스티커를 선물로 드립니다 선착순, 소진 시 완료" /></p>
										</div>

										<div class="rolling">
											<div class="slide-wrap">
												<div id="slide1" class="slide">
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/img_slide_01.jpg" alt="" />
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/img_slide_02.jpg" alt="" />
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/img_slide_03.jpg" alt="" />
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/img_slide_04.jpg" alt="" />
													<img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/img_slide_05.jpg" alt="" />
												</div>
											</div>

											<div class="btnmore">
												<a href="/play/playGround.asp?gidx=19&amp;gcidx=79"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/btn_more.png" alt="PLAY GROUND에서 더 자세히 보세요" /></a>
												<span><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/btn_down.png" alt="" /></span>
											</div>
										</div>
									</div>
									<div class="bg"></div>
									<div class="cloud"></div>
								</div>

								<div class="your">
									<div class="inner">
										<div class="put">
											<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/tit_put.png" alt="꿀맛 스티커를 당신의 일상에 붙여주세요!" /></h4>
											<span class="instagram animated fadeIn"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/ico_instagram.png" alt="" /></span>
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/txt_instagram.png" alt="배송상자에 담긴 꿀맛 스티커를 인스타그램에 #텐바이텐꿀맛 해시태그와 함께 예쁜 인증샷으로 남겨주시면 총 50분을 추첨해  10,000원 GIFT카드 를 선물로 드립니다." /></p>
											<p>
												<img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/txt_account.png" alt="텐바이텐의 인스타그램 계정과 친구가 되어 주세요!" />
												<a href="https://instagram.com/your10x10/" target="_blank" title="새창" style="margin-left:8px;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/txt_10x10.png" alt="@your10x10" /></a>
											</p>
										</div>

										<div class="photo">
											<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/tit_photo_v1.png" alt="꿀맛 스티커 인증샷" /></h4>
											<div class="photolist">
												<div id="pixlee_container"></div><script type="text/javascript">window.PixleeAsyncInit = function() {Pixlee.init({apiKey:"fv6psNyfsxP24pP6d9WM"});Pixlee.addSimpleWidget({albumId:148534,recipeId:216,displayOptionsId:4996,type:"photowall",accountId:728});};</script><script src="//assets.pixlee.com/assets/pixlee_widget_1_0_0.js"></script>
											</div>
										</div>
									</div>
								</div>

								<div class="noti">
									<div class="inner">
										<h4><img src="http://webimage.10x10.co.kr/eventIMG/2015/60834/tit_noti.png" alt="이벤트 유의사항" /></h4>
										<ul>
											<li>본 이벤트는 인스타그램과 본 페이지를 통해서만 참여할 수 있습니다.</li>
											<li><strong>#텐바이텐</strong> 해시태그가 입력된 포스팅에 한해 별도의 동의없이 리스트에 보여집니다.</li>
											<li>SNS 포스팅 시에는 <strong>#텐바이텐꿀맛</strong>이라는 해시태그를 꼭 입력해주셔야 합니다.</li>
											<li>본 이벤트 페이지에서 보여지는 것과 당첨여부는 관계가 없을 수 있습니다.</li>
											<li>텐바이텐 계정 (@your10x10)이 올려주신 글에 '좋아요'를 눌러야만 최종 접수됩니다.<br /> 당첨자는 <strong>2015년 4월 28일 화요일에 발표</strong>합니다.</li>
											<li>계정과 응모한 포스팅은 공개로 설정해야 하며, 비공개 시 응모가 되지 않습니다.</li>
										</ul>
									</div>
								</div>
							</div>

						</div>
						<!--// 2015 RENEWAL 사월의 꿀 맛 -->
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<script type="text/javascript">
$(function(){
	$(".topic .area .sweet").animate({"margin-left":"-100px"});
	function animation(){
		$(".topic .area .sweet").delay(500).animate({"margin-left":"0", opacity:"1"},1000);
		$(".topic .area h3 .letter1").delay(100).animate({"margin-top":"20px"}).animate({'margin-top':'0'},2000);
		$(".topic .area h3 .letter2").delay(100).animate({"margin-top":"-20px"}).animate({'margin-top':'0'},1500);
		$(".topic .area h3 .letter3").delay(100).animate({"margin-top":"30px"}).animate({'margin-top':'0'},2000);
		$(".topic .area h3 .letter4").delay(100).animate({"margin-top":"-10px"}).animate({'margin-top':'0'},1000);
		$(".topic .area h3 .letter5").delay(100).animate({"margin-top":"20px"}).animate({'margin-top':'0'},1500);
	}
	animation();

	/* slide js */
	$('#slide1').slidesjs({
		width:"1000",
		height:"560",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3500, effect:"fade", auto:true},
		effect:{fade: {speed:1500, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('#slide1').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});
});
var scrollSpeed =22;
	var current = 0;
	var direction = 'h';
	function bgscroll(){
		current -= 1;
		$('.cloud').css("backgroundPosition", (direction == 'h') ? current+"px 0" : "0 " + current+"px");
	}
	setInterval("bgscroll()", scrollSpeed);
</script>
</body>
</html>