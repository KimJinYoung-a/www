<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : tab1 : [사은이벤트] 선물은 비치볼
' History : 2016.06.09 김진영 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim eCode
Dim tab1eCode, tab2eCode, tab3eCode
If application("Svr_Info") = "Dev" Then
	eCode			= "66147"
	tab1eCode		= "66147"
	tab2eCode		= "66148"
	tab3eCode		= "66149"

Else
	eCode			= "71110"
	tab1eCode		= "71110"
	tab2eCode		= "71111"
	tab3eCode		= "71112"
End If
%>
<style type="text/css">
img {vertical-align:top;}

.findingDori {margin-bottom:50px !important; background:#20bbd4 url(http://webimage.10x10.co.kr/eventIMG/2016/71110/bg_sea.jpg) no-repeat 50% 0;}

.bubble {position:absolute; top:90px; left:50%; width:1749px; height:326px; margin-left:-905px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/img_bubble.png) no-repeat 50% 0;}
.bubble {animation-name:bubble; animation-duration:5s; animation-timing-function:ease-in-out; animation-delay:-1s; animation-iteration-count:infinite; animation-direction:alternate; animation-play-state:running;}
@keyframes bubble {
	0%{margin-top:-40px; background-size:96% 96%;}
	100%{margin-top:40px; background-size:100% 100%;}
}

.topic {position:relative; height:515px;}
.topic h2 {position:absolute; top:98px; left:50%; width:703px; height:176px; margin-left:-351px;}
.topic h2 span {position:absolute;}
.topic h2 .letter1 {top:0; left:50%; margin-left:-130px;}
.topic h2 .letter2 {top:18px; left:0;}
.topic h2 .letter3 {top:111px; left:369px;}
.topic .come {position:absolute; top:305px; left:50%; margin-left:-178px;}
.topic .date {position:absolute; top:30px; left:50%; margin-left:430px;}

.navigator {position:absolute; bottom:34px; left:50%; z-index:5; width:887px; margin-left:-443px;}
.navigator ul {width:887px; height:110px;}
.navigator ul li {float:left; width:297px; height:110px;}
.navigator ul li a {display:block; position:relative; width:100%; height:100%; color:#000; font-size:12px; line-height:64px; text-align:center;}
.navigator ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/img_navigator.png) no-repeat 0 -110px;}
.navigator ul li a.on {color:#e88057; font-weight:bold;}
.navigator ul li a:hover span,
.navigator ul li a.on span {background-position:0 0;}
.navigator ul li.nav2 {width:294px;}
.navigator ul li.nav2 a span {background-position:-297px 0;}
.navigator ul li.nav2 a:hover span, .navigator ul li.nav2 a.on span {background-position:-297px -110px;}
.navigator ul li.nav3 {width:296px;}
.navigator ul li.nav3 a span {background-position:-592px 0;}
.navigator ul li.nav3 a:hover span, .navigator ul li.nav3 a.on span {background-position:-592px 100%;}
.navigator ul li i {display:none; position:absolute; top:-37px; left:25px;}
.navigator ul li.nav2 i {top:-28px; left:215px;}
.navigator ul li a.on i {display:block;}
.navigator ul li.nav1 a.on i img {animation-name:bounce1; animation-duration:2.5s; animation-iteration-count:3; animation-fill-mode:both; animation-delay:2s;}
@keyframes bounce1 {
	0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
	40% {transform: translateY(-7px);}
	60% {transform: translateY(-3px);}
}
@keyframes flip {
	0% {transform:rotateY(0deg); animation-timing-function:ease-out;}
	100% {transform:rotateY(360deg); animation-timing-function:ease-in;}
}
.flip {animation-name:flip; animation-duration:1.2s; animation-iteration-count:1; backface-visibility:visible;}

.noti {margin-top:-11px; padding-top:11px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/bg_wave.png) repeat-x 0 0;}
.noti .bg {padding:49px 0 44px; background-color:#0f1f36;}
.noti .inner {position:relative; width:1140px; margin:0 auto; text-align:left;}
.noti ul {overflow:hidden; margin-top:20px;}
.noti ul li {float:left; width:50%; min-height:26px; color:#f8f7f7; font-family:'굴림', 'Gulim', 'Arial'; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li strong {color:#ffef68; font-weight:normal;}
.noti ul li img {vertical-align:middle;}

.intro {height:538px; background-color:#128eb4;}
.intro .inner {position:relative; width:1140px; margin:0 auto; padding-top:88px; text-align:left;}
/* swiper */
.rolling {position:relative; width:598px; margin-left:36px;}
.rolling .swiper {position:relative; padding-bottom:32px;}
.rolling .swiper .swiper-container {position:relative; overflow:hidden; height:344px;}
.rolling .swiper .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {float:left; width:100%;}
.rolling .swiper .pagination {position:absolute; bottom:0; left:50%; z-index:20; width:120px; margin-left:-60px;}
.rolling .swiper .pagination span {float:left; width:10px; height:10px; margin:0 7px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/btn_pagination_dot.png) no-repeat 0 0; cursor:pointer; transition:all 0.5s ease;}
.rolling .swiper .pagination .swiper-active-switch {background-position:0 100%;}
.rolling .btn-nav {display:block; position:absolute; top:142px; z-index:20; width:59px; height:59px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2016/71110/btn_nav_white.png) no-repeat 0 0; text-indent:-999em}
.rolling .btn-prev {left:0;}
.rolling .btn-next {right:0; background-position:100% 0;}
.intro p {position:absolute; top:87px; right:0;}

.shareSns {position:relative; height:159px; background-color:#005f7c;}
.shareSns ul {width:162px; position:absolute; top:50px; left:50%; margin-left:278px;}
.shareSns ul li {float:left; margin-right:16px;}
.shareSns ul li a:hover img {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.5s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.gift {height:963px;}
.slidewrap {width:910px; margin:0 auto; position:relative;}
.slidewrap .soldout {display:block; position:absolute; top:24px; left:24px; z-index:20;}
.slide {overflow:visible !important; position:relative; width:860px; height:520px; margin:9px auto 0; padding:24px 25px 124px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/bg_box_gradation.png) no-repeat 50% 0;}
.slide .slidesjs-navigation {position:absolute; z-index:10; top:242px; width:51px; height:104px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/btn_nav_grey.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:-36px;}
.slide .slidesjs-next {right:-36px; background-position:100% 0;}
.slide .slidesjs-pagination {overflow:hidden; position:absolute; bottom:0; left:10px; z-index:20; width:890px;}
.slide .slidesjs-pagination li {float:left; width:168px; height:104px; margin:0 5px;}
.slide .slidesjs-pagination li a {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/btn_pagination_thumbnail.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-pagination li a:hover, .slidesjs-pagination li a.active {background-position:0 100%;}
.slide .slidesjs-pagination li.no2 a {background-position:-178px 0;}
.slide .slidesjs-pagination li.no2 a.active {background-position:-178px 100%;}
.slide .slidesjs-pagination li.no3 a {background-position:-356px 0;}
.slide .slidesjs-pagination li.no3 a.active {background-position:-356px 100%;}
.slide .slidesjs-pagination li.no4 a {background-position:-534px 0;}
.slide .slidesjs-pagination li.no4 a.active {background-position:-534px 100%;}
.slide .slidesjs-pagination li.no5 a {background-position:100% 0;}
.slide .slidesjs-pagination li.no5 a.active {background-position:100% 100%;}
</style>
<script type="text/javascript">
$(function(){
	/* title animation */
	animation();
	$("#animation span").css({"opacity":"0"});
	$("#animation .letter2").css({"margin-top":"5px"});
	$("#animation .letter3").css({"left":"400px"});
	function animation() {
		$("#animation .letter1").delay(100).animate({"opacity":"1"},100);
		$("#animation .letter1 img").addClass("flip");
		$("#animation .letter2").delay(700).animate({"margin-top":"0", "opacity":"1"},600);
		$("#animation .letter3").delay(900).animate({"left":"369px", "opacity":"1"},1000);
	}

	/* slide js */
	$("#slide").slidesjs({
		width:"860",
		height:"520",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:800}}
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("no1");
	$(".slidesjs-pagination li:nth-child(2)").addClass("no2");
	$(".slidesjs-pagination li:nth-child(3)").addClass("no3");
	$(".slidesjs-pagination li:nth-child(4)").addClass("no4");
	$(".slidesjs-pagination li:nth-child(5)").addClass("no5");

	/* swipe js */
	var mySwiper = new Swiper("#rolling .swiper-container",{
		loop:true,
		resizeReInit:true,
		calculateHeight:true,
		pagination:'#rolling .pagination',
		paginationClickable:true,
		speed:1200,
		autoplay:false,
		autoplayDisableOnInteraction:false,
		simulateTouch:false
	})

	$("#rolling .btn-prev").on("click", function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});

	$("#rolling .btn-next").on("click", function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});
});
</script>
<div class="contF contW">
	<div class="evt71110 findingDori">
		<div class="topic">
			<div class="bubble"></div>
			<div class="hgroup">
				<h2 id="animation">
					<span class="letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/tit_collabo.png" alt="텐바이텐과 도리를 찾아서" /></span>
					<span class="letter2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/tit_tenbyten_adventure_v1.png" alt="텐바이텐 어드벤처" /></span>
					<span class="letter3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_fish.png" alt="" /></span>
				</h2>
				<p class="come"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/txt_come.png" alt="무엇을 기억하든 그 이상을 까먹는 도리가 텐바이텐에 왔다!" /></p>
				<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/txt_date.png" alt="이벤트 기간은 2016년 6월 13일부터 22일까지 진행합니다." /></p>
			</div>

			<div class="navigator">
				<ul>
					<li class="nav1"><a href="/event/eventmain.asp?eventid=<%=tab1eCode%>" class="on"><span></span>Gift 선물은 비치볼<i><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_navigator_ball.png" alt="" /></i></a></li>
					<li class="nav2"><a href="/event/eventmain.asp?eventid=<%=tab2eCode%>"><span></span>Event 도리를 찾아서<i><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_navigator_dori.png" alt="" /></i></a></li>
					<li class="nav3"><a href="/event/eventmain.asp?eventid=<%=tab3eCode%>"><span></span>New item 도리를 내 품에</a></li>
				</ul>
			</div>
		</div>

		<div class="gift">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/tit_gift.png" alt="2만원 이상 구매 시 도리의 비치볼이 온다!" /></h3>
			<div class="slidewrap">
				<p class="soldout"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/txt_soldout.png" alt="준비된 비치볼이 모두 소진되었습니다. 함께 해주셔서 감사합니다." /></p>
				<div id="slide" class="slide">
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_gift_01.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_gift_02.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_gift_03.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_gift_04.jpg" alt="" /></div>
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_gift_05.jpg" alt="" /></div>
				</div>
			</div>
			<p class="tip" style="margin-top:44px;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/txt_tip.png" alt="팁 비치볼 안쪽의 그림판이 팽팽하게 펴질 때까지 공기를 주입해주세요!" /></p>
		</div>

		<div class="noti">
			<div class="bg">
				<div class="inner">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/tit_noti_v1.png" alt="이벤트 유의사항" /></h3>
					<ul>
						<li>- 구매사은 이벤트는 텐바이텐 회원님을 위한 혜택입니다. (비회원 구매 시 증정 불가)</li>
						<li>- 텐바이텐 기프트카드를 구매하신 경우는 사은품 증정이 되지 않습니다.</li>
						<li>- 텐바이텐 배송상품을 포함해야 사은품 선택이 가능합니다. <a href="/event/eventmain.asp?eventid=71237" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/btn_tenten_delivery.png" alt="텐바이텐 배송상품 보러가기" /></a></li>
						<li>- 사은품은 텐바이텐 배송 상품과 함께 배송됩니다.</li>
						<li>- 업체배송 상품으로만 구매시 사은품을 선택 할 수 없습니다.</li>
						<li>- 환불, 교환 시 최종 구매 가격이 사은품 수령 가능 금액 미만일 경우, 사은품과 함께 반품해야 합니다.</li>
						<li>- 상품쿠폰, 보너스쿠폰, 할인카드 등의 사용 후 구매 확정액이 2만원 이상 이어야 합니다.</li>
						<li>- 각 상품별 한정 수량으로, 조기 소진 될 수 있습니다.</li>
						<li>- 마일리지, 예치금, 기프트카드를 사용 한  경우는 사은품을 받을 수 있습니다.</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- #include virtual="/event/etc/inc_DORI_Footer.asp" -->
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->