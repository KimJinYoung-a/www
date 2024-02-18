<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : PLAY #31-2
' History : 2016-06-10 이종화 생성
'####################################################
Dim pagereload
	pagereload	= requestCheckVar(request("pagereload"),2)

Dim snpTitle, snpLink, snpPre, snpTag, snpTag2
	snpTitle = Server.URLEncode("물의 현재진행형을 담은 화보,Water-ing")
	snpLink = Server.URLEncode("http://www.10x10.co.kr/play/playGround.asp?gidx=31&gcidx=127")
	snpPre = Server.URLEncode("텐바이텐")
	snpTag = Server.URLEncode("텐바이텐 " & Replace("#31 서른 한 번째 이야기 WATER"," ",""))
	snpTag2 = Server.URLEncode("#10x10")
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background:#7ccaed url(http://webimage.10x10.co.kr/play/ground/20160613/bg_head.png) 50% 0 no-repeat; background-size:1920px 260px !important;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}

.swiper {position:relative; height:944px; padding-bottom:127px; background:#fff;}
.swiper .swiper-container {overflow:hidden; height:944px;}
.swiper .swiper-wrapper {position:relative;}
.swiper .swiper-slide {overflow:hidden; float:left; position:relative; width:100%; height:944px; background-position:50% 0; background-repeat:no-repeat; background-color:#fff;}
.swiper .swiper-slide .txt {position:absolute; left:50%; top:326px; z-index:30;}
.swiper .swiper-slide .bg {position:absolute; left:50%; top:0; z-index:20; width:1920px; height:944px; margin-left:-960px;}
.swiper .swiper-slide .bg img {display:inline-block; position:absolute; left:0; top:0;}
.swiper button {display:block; position:absolute; left:50%; z-index:30; width:50px; height:50px; margin-left:490px; text-indent:-9999px; border:0;}
.swiper .prev {top:676px; background:transparent url(http://webimage.10x10.co.kr/play/ground/20160613/btn_prev.png) 0 0 no-repeat;}
.swiper .next {top:742px; background:transparent url(http://webimage.10x10.co.kr/play/ground/20160613/btn_next.png) 0 0 no-repeat;}
.swiper button:hover {background-position:0 100%;}
.swiper .pagination {position:absolute; left:50%; bottom:0; width:1520px; margin-left:-760px;}
.swiper .pagination span {display:block; float:left; width:180px; height:95px; margin:0 5px; background-position:0 0; background-repeat:no-repeat; cursor:pointer;}
.swiper .pagination span.p01,
.swiper .pagination span.p08 {background:#fff;}
.swiper .pagination span.p02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160613/bg_pagination_01.jpg);}
.swiper .pagination span.p03 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160613/bg_pagination_02.jpg);}
.swiper .pagination span.p04 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160613/bg_pagination_03.jpg);}
.swiper .pagination span.p05 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160613/bg_pagination_04.jpg);}
.swiper .pagination span.p06 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160613/bg_pagination_05.jpg);}
.swiper .pagination span.p07 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160613/bg_pagination_06.jpg);}
.swiper .pagination span.swiper-active-switch,
.swiper .pagination span:hover {background-position:0 100%;}
.swiper .share {position:absolute; left:50%; top:808px; z-index:30; width:50px; height:50px; margin-left:490px;}
.swiper .goPlayTop {position:absolute; left:50%; top:861px; z-index:30; width:50px; height:50px; margin-left:490px; cursor:pointer;}
.intro {background-image:url(http://webimage.10x10.co.kr/play/ground/20160613/bg_slide_intro.jpg);}
.intro h2 {position:absolute; left:50%; top:156px; z-index:30; margin-left:-189px;}
.intro .bar {position:absolute; left:50%; top:298px; z-index:20; width:0; height:10px; margin-left:-120px; background:#ff92b8;}
.intro .purpose p {position:absolute; left:50%; z-index:30; width:360px; margin-left:-180px; text-align:center;}
.intro .purpose p.p01 {top:426px;}
.intro .purpose p.p02 {top:492px;}
.intro .purpose p.p03 {top:566px;}
.intro .purpose p.p04 {top:637px;}
.intro .btnPlay {display:block; position:absolute; left:50%; top:762px; z-index:30; width:220px; height:46px; margin-left:-110px; background:transparent url(http://webimage.10x10.co.kr/play/ground/20160613/btn_play.png) 0 0 no-repeat;}
.intro .btnPlay:hover {background-position:0 100%;}
.water01 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160613/bg_slide01.jpg);}
.water04 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160613/bg_slide04.jpg);}
.water05 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160613/bg_slide05.jpg);}
.water01 .txt {margin-left:-508px;}
.water02 .txt {margin-left:250px;}
.water03 .txt {margin-left:-515px;}
.water04 .txt {margin-left:250px;}
.water05 .txt {margin-left:-508px;}
.water06 .txt {margin-left:250px;}
.download {text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20160613/bg_slide_download.jpg) 50% 0 no-repeat;}
.download div {padding-top:205px;}
</style>
<script type="text/javascript">
$(function(){
	var mySwiper = new Swiper('.swiper-container',{
		mode:'vertical',
		loop:false,
		pagination:'.pagination',
		paginationClickable:true,
		speed:600,
		mousewheelControl: true,
		simulateTouch:false,
		onSlideChangeStart: function(){
			$(".swiper .pagination span:nth-child(1)").addClass("p01");
			$(".swiper .pagination span:nth-child(2)").addClass("p02");
			$(".swiper .pagination span:nth-child(3)").addClass("p03");
			$(".swiper .pagination span:nth-child(4)").addClass("p04");
			$(".swiper .pagination span:nth-child(5)").addClass("p05");
			$(".swiper .pagination span:nth-child(6)").addClass("p06");
			$(".swiper .pagination span:nth-child(7)").addClass("p07");
			$(".swiper .pagination span:nth-child(8)").addClass("p08");
			window.parent.$('html,body').animate({scrollTop:$(".swiper").offset().top}, 800);
		}
	});
	$('.swiper .prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});
	$('.swiper .next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});
	$(".btnPlay").click(function(){
		$(".swiper .pagination span:nth-child(2)").click();
	});
	$(".goPlayTop").click(function(){
		$('html, body').animate({scrollTop:0});
	});

	// title animation
	titleAnimation();
	$(".intro h2").css({"margin-top":"10px","opacity":"0"});
	$(".intro .bar").delay(500).animate({"width":"240px"},800);
	$(".intro .purpose p").css({"margin-top":"10px","opacity":"0"});
	function titleAnimation() {
		$(".intro h2").delay(100).animate({"margin-top":"0","opacity":"1"},600);
		$(".intro .purpose .p01").delay(1000).animate({"margin-top":"0",'opacity':'1'},500);
		$(".intro .purpose .p02").delay(1300).animate({"margin-top":"0",'opacity':'1'},500);
		$(".intro .purpose .p03").delay(1600).animate({"margin-top":"0",'opacity':'1'},500);
		$(".intro .purpose .p04").delay(1900).animate({"margin-top":"0",'opacity':'1'},500);
	}
	
	var $elements1 = $('.water02 .bg img').css('visibility','hidden');
	var $visible1 = $elements1.first().css('visibility','visible');
	var time1 = null;
	function loopWaterImg1(){
		time1=setInterval(function(){
			$visible1.css('visibility','hidden');
			var $next1 = $visible1.next('.water02 .bg img');
			if(!$next1.length)
				$next1 = $elements1.first();
			$visible1 = $next1.css('visibility','visible');
		},700);
	}
	var $elements2 = $('.water03 .bg img').css('visibility','hidden');
	var $visible2 = $elements2.first().css('visibility','visible');
	var time2 = null;
	function loopWaterImg2(){
		time2=setInterval(function(){
			$visible2.css('visibility','hidden');
			var $next2 = $visible2.next('.water03 .bg img');
			if(!$next2.length)
				$next2 = $elements2.first();
			$visible2 = $next2.css('visibility','visible');
		},900);
	}
	var $elements3 = $('.water06 .bg img').css('visibility','hidden');
	var $visible3 = $elements3.first().css('visibility','visible');
	var time3 = null;
	function loopWaterImg3(){
		time3=setInterval(function(){
			$visible3.css('visibility','hidden');
			var $next3 = $visible3.next('.water06 .bg img');
			if(!$next3.length)
				$next3 = $elements3.first();
			$visible3 = $next3.css('visibility','visible');
		},600);
	}
	loopWaterImg1();
	loopWaterImg2();
	loopWaterImg3();
});
</script>
<script type="text/javascript">
<!--
$(function(){
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#vote").offset().top}, 0);
}

//-->
</script>
<div class="playGr20160613">
	<div class="swiper">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide intro">
					<h2><img src="http://webimage.10x10.co.kr/play/ground/20160613/tit_watering.png" alt="WATERING" /></h2>
					<p class="bar"></p>
					<div class="purpose">
						<p class="p01"><img src="http://webimage.10x10.co.kr/play/ground/20160613/txt_purpose_01.png" alt="투명한 물이 다른 성격의 재료와 만났을 때 우리는 새로운 움직임을 확인할 수 있습니다" /></p>
						<p class="p02"><img src="http://webimage.10x10.co.kr/play/ground/20160613/txt_purpose_02.png" alt="스며들거나 퍼지거나 혹은 아예 분리가 되기도 하고 온도에 따라 연기가 되었다가 얼음이 되기도 합니다" /></p>
						<p class="p03"><img src="http://webimage.10x10.co.kr/play/ground/20160613/txt_purpose_03.png" alt="우리는 그런 물의 현재진행형을 화보로 담았고 이를 watering이라고 표현했습니다" /></p>
						<p class="p04"><img src="http://webimage.10x10.co.kr/play/ground/20160613/txt_purpose_04.png" alt="놀라운 잠재력을 담고 있는 물과 함께 당신의 일상 속에서 워터링을 즐겨 보세요" /></p>
					</div>
					<button type="button" class="btnPlay">PLAY</button>
				</div>
				<div class="swiper-slide water01">
					<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160613/txt_fruit.png" alt="" /></p>
				</div>
				<div class="swiper-slide water02">
						<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160613/txt_soap.png" alt="" /></p>
						<div class="bg">
							<img src="http://webimage.10x10.co.kr/play/ground/20160613/img_slide02_01.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/play/ground/20160613/img_slide02_02.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/play/ground/20160613/img_slide02_03.jpg" alt="" />
							<img src="http://webimage.10x10.co.kr/play/ground/20160613/img_slide02_04.jpg" alt="" />
						</div>
					</div>
				<div class="swiper-slide water03">
					<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160613/txt_ink.png" alt="" /></p>
					<div class="bg">
						<img src="http://webimage.10x10.co.kr/play/ground/20160613/img_slide03_01.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20160613/img_slide03_02.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20160613/img_slide03_03.jpg" alt="" />
					</div>
				</div>
				<div class="swiper-slide water04">
					<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160613/txt_light.png" alt="" /></p>
				</div>
				<div class="swiper-slide water05">
					<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160613/txt_oil.png" alt="" /></p>
				</div>
				<div class="swiper-slide water06">
					<p class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160613/txt_draw.png" alt="" /></p>
					<div class="bg">
						<img src="http://webimage.10x10.co.kr/play/ground/20160613/img_slide06_01.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20160613/img_slide06_02.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20160613/img_slide06_03.jpg" alt="" />
						<img src="http://webimage.10x10.co.kr/play/ground/20160613/img_slide06_04.jpg" alt="" />
					</div>
				</div>
				<div class="swiper-slide download">
					<div>
						<img src="http://webimage.10x10.co.kr/play/ground/20160613/txt_download.png" alt="무료한 일상을 화려하게 만들어줄 사진을 컴퓨터에 담아 일상을  watering 하세요!" usemap="#downloadMap" />
						<map name="downloadMap" id="downloadMap">
							<area shape="rect" coords="37,397,282,425" href="javascript:fileDownload(3790);" alt="1920X1200" />
							<area shape="rect" coords="36,429,283,457" href="javascript:fileDownload(3789);" alt="1920X1080" />
							<area shape="rect" coords="35,460,282,490" href="javascript:fileDownload(3788);" alt="1600X1200" />
							<area shape="rect" coords="37,494,284,514" href="javascript:fileDownload(3787);" alt="1280X960" />
							<area shape="rect" coords="477,396,727,423" href="javascript:fileDownload(3794);" alt="1920X1200" />
							<area shape="rect" coords="477,430,727,457" href="javascript:fileDownload(3793);" alt="1920X1080" />
							<area shape="rect" coords="477,464,729,489" href="javascript:fileDownload(3792);" alt="1600X1200" />
							<area shape="rect" coords="476,495,728,514" href="javascript:fileDownload(3791);" alt="1280X960" />
						</map>
					</div>
				</div>
			</div>
		</div>
		<div class="pagination"></div>
		<button type="button" class="prev">이전</button>
		<button type="button" class="next">다음</button>
		<p class="share"><a href="#" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160613/btn_facebook.png" alt="페이스북으로 공유하기" /></a></p>
		<p class="goPlayTop"><img src="http://webimage.10x10.co.kr/play/ground/20160613/btn_top.png" alt="TOP" /></p>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->