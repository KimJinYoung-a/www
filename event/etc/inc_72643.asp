<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : the pen fair
' History : 2016-08-26 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" --> 
<style type="text/css">
img {vertical-align:top;}
.thePenFair {text-align:center; padding-bottom:115px; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2016/72643/bg_line.gif) repeat-x 0 100%;}
.penCont {position:relative; width:1140px; margin:0 auto;}

.thePenFair .penHead {padding:80px 0 70px;}
.thePenFair .penHead p {position:relative; padding-bottom:27px;}
.thePenFair .penHead h2 {overflow:hidden; position:relative; width:640px; height:65px; margin:0 auto;}
.thePenFair .penHead h2 span {display:block; position:absolute; top:0; width:228px; height:65px; text-indent:-999em; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72643/tit_pen_fair.png) 0 0 no-repeat;}
.thePenFair .penHead h2 span.t1 {left:0; width:163px; background-position:0 0;}
.thePenFair .penHead h2 span.t2 {left:206px; width:210px; background-position:-206px 0;}
.thePenFair .penHead h2 span.t3 {right:0; width:182px; background-position:-460px 0;}
.thePenFair .penNavWrap {width:1140px; height:103px; margin:0 auto 103px; border-top:1px solid #eee; border-bottom:1px solid #eee;}
.thePenFair .varietyPen {padding-bottom:200px;}
.thePenFair .penList {position:relative; margin-bottom:102px;}
.thePenFair .penList .swiper-content {width:100%; height:546px; margin-bottom:70px;}
.thePenFair .penList .swiper-content  .swiper-slide {position:relative; float:left; width:390px; height:546px; padding:0 90px;}
.thePenFair .penList .btnItem { display:block; position:absolute; left:50%; top:170px; z-index:40; background:transparent;}
.thePenFair .penList .btnItem.prev {margin-left:-305px;}
.thePenFair .penList .btnItem.next {margin-left:268px;}
.thePenFair .penList .swiper-content  button.btnNext {}
.thePenFair .penList .swiper-content .desc {display:none; position:absolute; left:100px; top:0;}
.thePenFair .penList .swiper-nav {height:30px; width:300px; margin:0 auto;}
.thePenFair .penList .swiper-nav .swiper-slide {float:left; width:30px; height:30px; font-size:12px; line-height:30px; color:#989898; cursor:pointer;}
.thePenFair .penList .swiper-nav .active-nav {font-weight:bold; color:#252525;}
.thePenFair .penList .btnNav {display:inline-block; position:absolute; left:50%; bottom:0; width:30px; height:30px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72643/btn_pagination.png) 0 0 no-repeat; text-indent:-999em; cursor:pointer;}
.thePenFair .penList .btnNav.prev {margin-left:-190px;  background-position:-33px 0;}
.thePenFair .penList .btnNav.next {margin-left:160px; background-position:-66px 0;}
.thePenFair .penList .pageWrap em {display:inline-block; position:absolute; top:0; width:30px; height:30px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/72643/btn_pagination.png) 0 0 no-repeat; text-indent:-999em; cursor:pointer;}
.thePenFair .penList .pageWrap .first {left:0; background-position:0 0;}
.thePenFair .penList .pageWrap .prev {left:34px; background-position:-33px 0;}
.thePenFair .penList .pageWrap .next {right:34px; background-position:-66px 0;}
.thePenFair .penList .pageWrap .end {right:0; background-position:100% 0;}

.thePenFair .penPlay {padding:60px 0 80px; background:#f7f7f7;}
.thePenFair .penPlay .penCont {width:990px;}
.thePenFair .penPlay .transcribe {overflow:hidden; padding:35px 0 15px;}
.thePenFair .penPlay .transcribe p {float:left; padding:15px;}
.thePenFair .penPlay .movie {width:960px; margin:0 auto;}
.thePenFair .penStory {padding-top:110px;}
.thePenFair .penStory .penCont {overflow:hidden; width:1020px;}
.thePenFair .penStory li {float:left; padding:0 30px;}
</style>
<script>
$(function(){
	titleAnimation()
	$(".thePenFair .penHead p").css({"top":"10px", "opacity":"0"});
	$(".thePenFair .penHead h2 span.t1").css({"margin-top":"-65px"});
	$(".thePenFair .penHead h2 span.t2").css({"margin-top":"65px"});
	$(".thePenFair .penHead h2 span.t3").css({"margin-top":"-65px"});
	function titleAnimation() {
		$(".thePenFair .penHead p").delay(100).animate({"top":"0", "opacity":"1"},900);
		$(".thePenFair .penHead h2 span").delay(500).animate({"margin-top":"0", "opacity":"1"},800);
	}

	//Swiper Content
	var contentSwiper = $('.swiper-content').swiper({
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		autoplay:2300,
		speed:800,
		onSlideChangeStart: function(){
			updateNavPosition()
		}
	})
	$('.penList .btnItem.prev').on('click', function(e){
		e.preventDefault();
		contentSwiper.swipePrev();
	})
	$('.penList .btnItem.next').on('click', function(e){
		e.preventDefault();
		contentSwiper.swipeNext();
	});
	//Nav
	var navSwiper = $('.swiper-nav').swiper({
		visibilityFullFit: true,
		slidesPerView:10,
		slidesPerGroup :5,
		onSlideClick: function(){
			contentSwiper.swipeTo( navSwiper.clickedSlideIndex )
		}
	});
	$('.penList .btnNav.prev').on('click', function(e){
		e.preventDefault();
		navSwiper.swipePrev();
	})
	$('.penList .btnNav.next').on('click', function(e){
		e.preventDefault();
		navSwiper.swipeNext();
	});

	//Update Nav Position
	function updateNavPosition(){
		$('.swiper-nav .active-nav').removeClass('active-nav')
		var activeNav = $('.swiper-nav .swiper-slide').eq(contentSwiper.activeIndex-1).addClass('active-nav')
		if (!activeNav.hasClass('swiper-slide-visible')) {
			if (activeNav.index()>navSwiper.activeIndex) {
				var thumbsPerNav = Math.floor(navSwiper.width/activeNav.width())-1
				navSwiper.swipeTo(activeNav.index()-thumbsPerNav)
			}
			else {
				navSwiper.swipeTo(activeNav.index())
			}
		}
	}
	$('.thePenFair .penList .swiper-content a').mouseover(function(){
		$(this).children('.desc').fadeIn(200);
	});
	$('.thePenFair .penList .swiper-content a').mouseleave(function(){
		$(this).children('.desc').fadeOut(200);
	});
});
</script>

	<div class="eventContV15 tMar15">
		<!-- event area(이미지만 등록될때 / 수작업일때) -->
		<div class="contF contW">
			<!-- THE PEN FAIR -->
			<div class="evt72643 thePenFair">
				<div class="penHead">
					<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_life.png" alt="펜과 함께 하는 삶" /></p>
					<h2>
						<span class="t1">THE</span>
						<span class="t2">PEN</span>
						<span class="t3">FAIR</span>
					</h2>
				</div>
				<div class="penNavWrap">
					<!-- iframe : 1140px * 103px -->
					<iframe id="iframe_72643" src="/event/etc/group/iframe_72643.asp?eventid=72643" width="1140" height="103" frameborder="0" scrolling="no" class="" title="the pen fair" allowtransparency="true"></iframe>
				</div>
				<!--// iframe -->
				<div class="penList">
					<div class="swiper-container swiper-content">
						<div class="swiper-wrapper">
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1489745&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_1.jpg" alt="모나미 FX-STYLE" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_1.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1489746&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_2.jpg" alt="153 스틱비비드" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_2.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1489755&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_3.jpg" alt="FX-ZETA 0.5㎜/0.7㎜/1.0㎜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_3.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1243691&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_4.jpg" alt="[Seltzer] Little Dipper 7년 볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_4.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1476204&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_5.jpg" alt="모나미 153 블랙앤화이트 메탈" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_5.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=978523&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_6.jpg" alt="KOKUYO 윌액틱 핏커브볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_6.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1188371&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_7.jpg" alt="MILAN Sway 볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_7.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1482046&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_8.jpg" alt="MILAN PL1-Look볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_8.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=951383&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_9.jpg" alt="펜텔 LineStyle 볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_9.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=654920&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_10.jpg" alt="동아 Cronix hybrid" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_10.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=814174&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_11.jpg" alt="유성 볼펜 (S5110)" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_11.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1522815&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_12.jpg" alt="신지 애터미 유성안료 유성펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_12.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1093936&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_13.jpg" alt="카웨코 알 스포츠 볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_13.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=348346&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_14.jpg" alt="BRASS PRODUCTS - Ballpoint Pen" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_14.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=750259&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_15.jpg" alt="제트스트림 101 볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_15.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1544022&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_16.jpg" alt="Lamy Pico Special Edition 피코 볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_16.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=816245&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_17.jpg" alt="파카 죠터 스텐레스 볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_17.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=815756&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_18.jpg" alt="오토 NEEDLE-POINT 볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_18.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1459011&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_19.jpg" alt="유니볼 제트스트림 Air micro-0.5볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_19.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=846720&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_20.jpg" alt="제트스트림 볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_20.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1467291&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_21.jpg" alt="우더 쇼티(shorty) 볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_21.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=583103&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_22.jpg" alt="톰보우 OnBook 클립 프렌들리볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_22.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=194986&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_23.jpg" alt="Zebra Mini Pen" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_23.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1489338&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_24.jpg" alt="아이코닉 패턴 노크펜 v.3" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_24.png" alt="" /></p>
								</a>
							</div>
							<div class="swiper-slide">
								<a href="/shopping/category_prd.asp?itemid=1065630&pEtr=72643">
									<div class="image"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/img_pen_25.jpg" alt="153id 볼펜" /></div>
									<p class="desc"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_pen_25.png" alt="" /></p>
								</a>
							</div>
						</div>
					</div>
					<button class="btnItem prev"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/btn_prev.png" alt="이전" /></button>
					<button class="btnItem next"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/btn_next.png" alt="다음" /></button>
					<div class="swiper-container swiper-nav">
						<div class="swiper-wrapper swiper-no-swiping">
							<div class="swiper-slide active-nav">1</div>
							<div class="swiper-slide">2</div>
							<div class="swiper-slide">3</div>
							<div class="swiper-slide">4</div>
							<div class="swiper-slide">5</div>
							<div class="swiper-slide">6</div>
							<div class="swiper-slide">7</div>
							<div class="swiper-slide">8</div>
							<div class="swiper-slide">9</div>
							<div class="swiper-slide">10</div>
							<div class="swiper-slide">11</div>
							<div class="swiper-slide">12</div>
							<div class="swiper-slide">13</div>
							<div class="swiper-slide">14</div>
							<div class="swiper-slide">15</div>
							<div class="swiper-slide">16</div>
							<div class="swiper-slide">17</div>
							<div class="swiper-slide">18</div>
							<div class="swiper-slide">19</div>
							<div class="swiper-slide">20</div>
							<div class="swiper-slide">21</div>
							<div class="swiper-slide">22</div>
							<div class="swiper-slide">23</div>
							<div class="swiper-slide">24</div>
							<div class="swiper-slide">25</div>
						</div>
					</div>
					<button class="btnNav prev">이전</button>
					<button class="btnNav next">다음</button>
				</div>
				<div class="penPlay">
					<div class="penCont">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/tit_pen_play.png" alt="PEN PLAY - 펜으로 할 수 있는 유희 그 첫 번째" /></h3>
						<div class="transcribe">
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_transcribe_1.png" alt="필사 : [명사]베끼어 씀" /></p>
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_transcribe_2.png" alt="필사는 왜 할까요? 1. 글쓰기 실력이 높아집니다./2. 적극적인 독서법입니다./3. 집중력을 높이는데 도움 됩니다./4. 글씨체가 예뻐집니다." /></p>
							<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_transcribe_3.png" alt="필사는 어떻게 하나요? 1. 여유로운 마음으로 책 한 권 선정/2. 바른 자세로 앉아 차분히 따라 쓰기" /></p>
							<p class="book"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/txt_transcribe_4.png" alt="필사에 좋은 책 추천 - 필사의 기초(조경국)/필사의 힘:윤동주의 하늘과 바람과 별과 시 따라쓰기/논어 철학노트 필사본" /></p>
						</div>
						<div class="movie">
							<iframe width="960" height="540" src="https://www.youtube.com/embed/vGr_jxbKplA" frameborder="0" allowfullscreen></iframe>
						</div>
					</div>
				</div>
				<div class="penStory">
					<ul class="penCont">
						<li><a href="/event/eventmain.asp?eventid=72654"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/bnr_themselves.jpg" alt="01. PEN Themselves" /></a></li>
						<li><a href="#"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/bnr_brand.jpg" alt="02. PEN Brand MAP" /></a></li>
						<li><a href="/event/eventmain.asp?eventid=72645"><img src="http://webimage.10x10.co.kr/eventIMG/2016/72643/bnr_type.jpg" alt="03. NIB Type12" /></a></li>
					</ul>
				</div>
			</div>
			<!--// THE PEN FAIR -->
		</div>
		<!-- //event area(이미지만 등록될때 / 수작업일때) -->
	</div>
