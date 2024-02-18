<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : tab3 : [런칭이벤트] 도리를 내 품에
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
	eCode			= "66149"
	tab1eCode		= "66147"
	tab2eCode		= "66148"
	tab3eCode		= "66149"

Else
	eCode			= "71112"
	tab1eCode		= "71110"
	tab2eCode		= "71111"
	tab3eCode		= "71112"
End If

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2

If application("Svr_Info") = "Dev" Then
	snpTitle	= Server.URLEncode("영화 <도리를 찾아서>의 귀여운 친구들이 트럼프카드, 휴대폰케이스에 쏙! 이 놀라운 상품들은 오직 텐바이텐에서!")
	snpLink		= Server.URLEncode("http://bit.ly/dori10x10_3")
	snpPre		= Server.URLEncode("텐바이텐/디즈니")
	snpTag		= Server.URLEncode("텐바이텐")
	snpTag2		= Server.URLEncode("#텐바이텐 #도리를찾아서")
Else
	snpTitle	= Server.URLEncode("영화 <도리를 찾아서>의 귀여운 친구들이 트럼프카드, 휴대폰케이스에 쏙! 이 놀라운 상품들은 오직 텐바이텐에서!")
	snpLink		= Server.URLEncode("http://bit.ly/dori10x10_3")
	snpPre		= Server.URLEncode("텐바이텐/디즈니")
	snpTag		= Server.URLEncode("텐바이텐")
	snpTag2		= Server.URLEncode("#텐바이텐 #도리를찾아서")
End If
%>
<style type="text/css">
.evtEndWrapV15 {display:none;}
img {vertical-align:top;}

/* Finding Dory common */
.findingDori {margin-bottom:50px !important; background:#20bbd4 url(http://webimage.10x10.co.kr/eventIMG/2016/71112/bg_sea.jpg) no-repeat 50% 0;}
.findingDori button {background-color:transparent;}

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
.navigator ul li.nav2 a span {background-position:-297px 100%;}
.navigator ul li.nav2 a:hover span, .navigator ul li.nav2 a.on span {background-position:-297px -110px;}
.navigator ul li.nav3 {width:296px;}
.navigator ul li.nav3 a span {background-position:-592px 0;}
.navigator ul li.nav3 a:hover span, .navigator ul li.nav3 a.on span {background-position:-592px 100%;}
.navigator ul li i {display:none; position:absolute; top:-37px; left:25px;}
.navigator ul li.nav2 i {top:-28px; left:215px;}
.navigator ul li.nav3 i {top:-28px; left:220px;}
.navigator ul li a.on i {display:block;}
.navigator ul li.nav1 a.on i img {animation-name:bounce1; animation-duration:1.5s; animation-iteration-count:3; animation-fill-mode:both; animation-delay:2s;}
@keyframes bounce1 {
	0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
	40% {transform: translateY(-7px);}
	60% {transform: translateY(-3px);}
}
.navigator ul li.nav2 a.on i {animation-name:move; animation-duration:2.5s; animation-iteration-count:3; animation-fill-mode:both; animation-delay:2s; animation-direction:alternate; animation-play-state:running;}
@keyframes move {
	0% {top:-28px; left:215px; animation-timing-function:linear;}
	100% {top:-20px; left:200px; animation-timing-function:linear;}
}
.navigator ul li.nav3 a.on i {animation-name:bounce1; animation-duration:1.5s; animation-iteration-count:3; animation-fill-mode:both; animation-delay:2s;}
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

.intro {height:538px; background-color:#128eb4;}
.intro .inner {position:relative; width:1140px; margin:0 auto; padding-top:88px; text-align:left;}
.intro .rolling {position:relative; width:598px; margin-left:36px;}
.intro .rolling .swiper {position:relative; padding-bottom:32px;}
.intro .rolling .swiper .swiper-container {position:relative; overflow:hidden; height:344px;}
.intro .rolling .swiper .swiper-wrapper {position:relative;}
.intro .rolling .swiper .swiper-slide {float:left; width:100%;}
.intro .rolling .swiper .pagination {position:absolute; bottom:0; left:50%; z-index:20; width:120px; margin-left:-60px;}
.intro .rolling .swiper .pagination span {float:left; width:10px; height:10px; margin:0 7px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/btn_pagination_dot.png) no-repeat 0 0; cursor:pointer; transition:all 0.5s ease;}
.intro .rolling .swiper .pagination .swiper-active-switch {background-position:0 100%;}
.intro .rolling .btn-nav {display:block; position:absolute; top:142px; z-index:20; width:59px; height:59px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2016/71110/btn_nav_white.png) no-repeat 0 0; text-indent:-999em}
.intro .rolling .btn-prev {left:0;}
.intro .rolling .btn-next {right:0; background-position:100% 0;}
.intro p {position:absolute; top:87px; right:0;}

/* 71112 */
.bubble2 {top:602px; left:50%; width:1794px; height:315px; margin-left:-906px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71112/img_bubble.png) no-repeat 50% 0; animation-delay:1.5s;}

.item {height:1238px;}
.item .list {margin-top:65px;}
.item .list .case {margin-top:58px;}

.rollingwrap {overflow:hidden; position:relative;}
.rollingwrap .rolling {position:relative;}
.rollingwrap .rolling .swiper {height:705px; width:100%;}
.rollingwrap .rolling .swiper .swiper-container {overflow:hidden; width:100%;}
.rollingwrap .rolling .swiper .swiper-wrapper {position:relative; width:100%;}
.rollingwrap .rolling .swiper .swiper-slide {float:left; width:1140px;}
.rollingwrap .rolling .pagination {overflow:hidden; position:absolute; bottom:7px; left:0; z-index:10; width:100%; text-align:center;}
.rollingwrap .rolling .swiper-pagination-switch {display:inline-block; *display:inline; zoom:1; width:24px; height:24px; background:url(http://fiximage.10x10.co.kr/web2015/event/btn_slide_pagination.png) no-repeat 0 0; cursor:pointer; transition:all 0.5s;}
.rollingwrap .rolling .swiper-active-switch {background-position:100% 0;}
.rollingwrap .rolling .btn-nav {display:block; position:absolute; top:50%; left:50%; z-index:10; width:50px; height:70px; margin-top:-35px; background:transparent url(http://fiximage.10x10.co.kr/web2015/event/btn_slide_nav.png) no-repeat 50% 0; text-indent:-999em;}
.rollingwrap .rolling .btn-prev {margin-left:-555px;}
.rollingwrap .rolling .btn-prev:hover {background-position:50% -100px;}
.rollingwrap .rolling .btn-next {margin-left:505px; background-position:50% -200px;}
.rollingwrap .rolling .btn-next:hover {background-position:50% -300px;}

.swipemask {position:absolute; top:0; left:50%; width:1140px; height:705px; z-index:50; background-color:#000; opacity:0.3; filter:alpha(opacity=30);}
.mask-left {margin-left:-1710px;}
.mask-right {margin-left:570px;}

.shareSns {position:relative; height:365px; padding-top:50px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71112/bg_pattern_mint_v3.png) repeat-x 50% 0;}
.shareSns .bg {position:absolute; bottom:0; left:0; width:100%; height:11px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71112/bg_wave.png) repeat-x 0 0;}
.shareSns ul {width:417px; margin:32px auto 0;}
.shareSns ul:after {content:' '; display:block; clear:both;}
.shareSns ul li {float:left; position:relative; margin:0 15px; cursor:pointer;}
.shareSns ul li:hover .animate {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.5s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}
.shareSns ul li.instagram .go {position:absolute; top:83px; left:-20px; opacity:0; filter:alpha(opacity=0);}
.shareSns ul li.instagram:hover .go {opacity:1; filter:alpha(opacity=100);}
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

	var mySwiper1 = new Swiper("#rolling1 .swiper1",{
		centeredSlides:true,
		slidesPerView:"auto",
		loop:true,
		speed:1500,
		autoplay:3000,
		simulateTouch:false,
		pagination:"#rolling1 .pagination",
		paginationClickable:true
	})
	$("#rolling1 .btn-prev").on("click", function(e){
		e.preventDefault()
		mySwiper1.swipePrev()
	})
	$("#rolling1 .btn-next").on("click", function(e){
		e.preventDefault()
		mySwiper1.swipeNext()
	});
});
</script>
<div class="contF contW">
	<div class="evt71111 findingDori">
		<div class="topic">
			<div class="bubble"></div>
			<div class="bubble bubble2"></div>
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
					<li class="nav1"><a href="/event/eventmain.asp?eventid=<%=tab1eCode%>"><span></span>Gift 선물은 비치볼<i><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_navigator_ball.png" alt="" /></i></a></li>
					<li class="nav2"><a href="/event/eventmain.asp?eventid=<%=tab2eCode%>"><span></span>Event 도리를 찾아서<i><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_navigator_dori.png" alt="" /></i></a></li>
					<li class="nav3"><a href="/event/eventmain.asp?eventid=<%=tab3eCode%>" class="on"><span></span>New item 도리를 내 품에<i><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_navigator_item.png" alt="" /></i></a></li>
				</ul>
			</div>
		</div>

		<div class="item">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/tit_item.png" alt="매일매일 터지는 도리의 선물! 숨은 도리를 찾아서 Click해주세요!" /></h3>
			<div class="list">
				<p class="card"><a href="/shopping/category_prd.asp?itemid=1507612&amp;pEtr=71111"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/img_item_card.png" alt="트럼프 카드 아름다운 바닷속을 모험하는  도리와 니모의 멋진 항해를 매력적인 일러스트로!" /></a></p>
				<p class="case">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/img_item_case.jpg" alt="아이폰 케이스 도리, 니모, 행크 개성있는 캐릭터들과 패턴의 만남! 판타스틱한 하드, 투명 케이스" usemap="#itemlink" />
				</p>
				<map name="itemlink" id="itemlink">
					<area shape="rect" coords="70,149,387,471" href="/shopping/category_prd.asp?itemid=1507610&amp;pEtr=71112" alt="네이비, 블루 도리" />
					<area shape="rect" coords="407,148,731,472" href="/shopping/category_prd.asp?itemid=1507606&amp;pEtr=71112" alt="도리와 니모, 도리와 행크" />
					<area shape="rect" coords="752,148,1076,472" href="/shopping/category_prd.asp?itemid=1507611&amp;pEtr=71112" alt="패턴 도리, 패턴 니모" />
				</map>
			</div>
		</div>

		<div class="rollingwrap">
			<div id="rolling1" class="rolling">
				<div class="swiper">
					<div class="swiper-container swiper1">
						<div class="swiper-wrapper">
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/img_slide_item_01.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/img_slide_item_02.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/img_slide_item_03.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/img_slide_item_04.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/img_slide_item_05.jpg" alt="" /></div>
							<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/img_slide_item_06.jpg" alt="" /></div>
						</div>
					</div>
				</div>
				<div class="pagination"></div>
				<button type="button" class="btn-nav btn-prev">Previous</button>
				<button type="button" class="btn-nav btn-next">Next</button>
				<div class="swipemask mask-left"></div>
				<div class="swipemask mask-right"></div>
			</div>
		</div>

		<div class="shareSns">
			<div class="bg"></div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/txt_event.png" alt="영화 도리를 찾아서 굿즈 런칭 소식을 SNS에 공유해주세요! 추첨을 통해 총 10분께 도리의 트럼프 카드를 선물로 드립니다. #텐바이텐 #도리를찾아서 해시태그를 꼭 넣어주셔야 정상적으로 응모됩니다. 이벤트 기간은 2016년 6월 13일부터 6월 22일까지며, 당첨자 발표는 6월 24일 입니다." /></p>
			<ul>
				<li class="instagram">
					<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/ico_instagram.png" alt="인스타그램에 공유하기" class="animate" /></button>
					<div class="go">
						<a href="https://www.instagram.com/your10x10/" title="텐바이텐 공식 인스타그램으로 이동" target="blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/btn_instagram.png" alt="본 페이지를 캡쳐해서 포스팅해주세요" /></a>
					</div>
				</li>
				<li><a href="" onclick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/ico_twitter.png" alt="트위터에 공유하기" class="animate" /></a></li>
				<li><a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71112/ico_facebook.png" alt="페이스북에 공유하기" class="animate" /></a></li>
			</ul>
		</div>

		<div class="intro">
			<div class="inner">
				<div id="rolling" class="rolling">
					<div class="swiper">
						<div class="swiper-container swiper1">
							<div class="swiper-wrapper">
								<div class="swiper-slide">
									<iframe src="http://serviceapi.rmcnmv.naver.com/flash/outKeyPlayer.nhn?vid=776B75C9F93DD7C13D1FE75DA69B38681D3C&outKey=V128342fa5823e4a2d0a3994d9e29bba102c37f54388cb6d2c188994d9e29bba102c3&controlBarMovable=true&jsCallable=true&isAutoPlay=false&skinName=tvcast_white" width="598" height="344" frameborder="0" title="도리를 찾아서 예고편" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
								</div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_movie_02.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_movie_03.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_movie_04.jpg" alt="" /></div>
								<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_slide_movie_05.jpg" alt="" /></div>
							</div>
						</div>
						<div class="pagination"></div>
						<button type="button" class="btn-nav btn-prev">Previous</button>
						<button type="button" class="btn-nav btn-next">Next</button>
					</div>
				</div>

				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/txt_intro_v1.png" alt="도리를 찾아서! 내가 누구라고? 도리? 도리! 무엇을 상상하든 그 이상을 까먹는 도리의 어드벤쳐가 시작된다! 니모를 함께 찾으면서 베스트 프렌드가 된 도리와 말린은 우여곡절 끝에 다시 고향으로 돌아가 평화로운 일상을 보내고 있다. 모태 건망증 도리가 기억이라는 것을 하기 전까지! 도리는 깊은 기억 속에 숨어 있던 가족의 존재를 떠올리고 니모와 말린과 함께 가족을 찾아 대책 없는 어드벤쳐를 떠나게 되는데… 깊은 바다도 막을 수 없는 스펙터클한 어드벤쳐가 펼쳐진다!" /></p>
			</div>
		</div>
	</div>

</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->