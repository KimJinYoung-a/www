<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  추석기획전
' History : 2018-09-04 최종원 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%

%>
<style type="text/css">
.thanksgiving {}
.thanksgiving .topic {overflow:hidden; position:relative; height:645px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/bg_head.jpg) repeat-x 50% 0;}
.thanksgiving .topic .title {position:relative; width:1140px; margin:0 auto;}
.thanksgiving .topic .title p {position:absolute;}
.thanksgiving .topic .chn {left:50%; top:65px; margin-left:-61px;}
.thanksgiving .topic h2 {position:absolute; left:50%; top:180px; width:66px; height:384px; margin-left:-33px;}
.thanksgiving .topic h2 span {display:block; position:absolute; left:0; width:66px; text-indent:-999em; opacity:0; background-repeat:no-repeat; background-position:50% 0;}
.thanksgiving .topic h2 span.t1 {top:0; height:60px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/tit_so.png); animation:tit 1.5s .2s forwards;}
.thanksgiving .topic h2 span.t2 {top:110px; height:66px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/tit_hwack.png); animation:tit 1.5s .5s forwards;}
.thanksgiving .topic h2 span.t3 {top:220px; height:64px; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/tit_sun.png); animation:tit 1.5s .8s forwards;}
.thanksgiving .topic .subcopy {left:50%; top:547px; margin-left:-131px;}
.thanksgiving .topic .deco1, .thanksgiving .topic .deco2, .thanksgiving .topic .deco3, .thanksgiving .topic .deco4 {position:absolute; left:50%; display:block; background-color:#947314;}
.thanksgiving .topic .deco1 {top:120px; width:82px; height:1px; margin-left:-41px; animation:lineX 1s ease both; transform-origin:0 0;}
.thanksgiving .topic .deco2 {top:160px; width:1px; height:326px; margin-left:71px; animation:lineY 1s .5s ease both; transform-origin:0 0;}
.thanksgiving .topic .deco3 {top:523px; width:82px; height:1px;  margin-left:-41px; animation:lineX 1s 1s ease both; transform-origin:100% 0;}
.thanksgiving .topic .deco4 {top:160px; width:1px; height:326px; margin-left:-75px; animation:lineY 1s 1.5s ease both; transform-origin:100% 100%;}
.thanksgiving .todayGift {position:absolute; left:50%; top:0; width:259px; height:400px; margin-left:308px; padding:128px 0 0 0; font-family:dotum; font-weight:bold; color:#000; text-align:center; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_today_present.png) no-repeat 50% 0; animation:bounce 1.6s infinite;}
.thanksgiving .todayGift h3 {display:none; visible:hidden; font-size:0; line-height:0;}
.thanksgiving .todayGift .time {display:inline-block; height:22px; font-size:15px; line-height:23px;}
.thanksgiving .todayGift .time em {display:inline-block; width:21px; height:22px; margin:0 9px; color:#000; font-family:verdana, sans-serif; font-weight:bold;}
.thanksgiving .todayGift a {color:#000; text-decoration:none;}
.thanksgiving .todayGift .thumbnail {width:145px; padding:5px; margin:0 auto;}
.thanksgiving .todayGift .thumbnail img {width:145px; height:145px;}
.thanksgiving .todayGift .name {overflow:hidden; width:150px; margin:0 auto; padding-top:7px; font-size:13px; text-overflow:ellipsis; white-space:nowrap;}
.thanksgiving .todayGift .price {font-size:11px; color:#ff0000;}
.thanksgiving .todayGift .price s {font-weight:normal; color:#323232;}

.thanksgiving .givingContainer {position:relative;}
.thanksgiving .wideSwipe .swiper-container {height:670px;}
.thanksgiving .wideSwipe .swiper-slide {position:relative; width:1050px;}
.thanksgiving .wideSwipe .item-more {overflow:hidden; position:absolute; display:block; text-indent:-999em;}
.thanksgiving .wideSwipe .item-more em {overflow:hidden; position:absolute; display:block; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/ico_plus.png) no-repeat 50% 50%; width:21px; height:21px; text-indent:-999em;}
.thanksgiving .wideSwipe .item-more:hover em {animation:bounce .8s infinite;}
.thanksgiving .wideSwipe .swiper-slide img {height:670px;}
.thanksgiving .wideSwipe .mask.right {margin-left:525px;}
.thanksgiving .wideSwipe .mask.left {margin-left:-525px;}
.thanksgiving .wideSwipe .btnPrev {margin-left:-580px;}
.thanksgiving .wideSwipe .btnNext {margin-left:530px;}
.thanksgiving .wideSwipe .pagination {width:1000px; margin-left:-500px; text-align:right;}
.section1 .item1-1 {left:0; top:200px; width:210px; height:370px;}
.section1 .item1-1 em {left:66px; top:80px;}
.section1 .item1-2 {left:210px; top:175px; width:148px; height:337px;}
.section1 .item1-2 em {left:57px; top:300px;}
.section1 .item1-3 {left:340px; top:0; width:190px; height:280px;}
.section1 .item1-3 em {left:50px; top:165px;}
.section1 .item1-4 {left:525px; top:0; width:200px; height:190px;}
.section1 .item1-4 em {left:160px; top:100px;}
.section1 .item1-5 {left:405px; top:323px; width:190px; height:280px;}
.section1 .item1-5 em {left:120px; top:30px;}
.section1 .item1-6 {left:625px; top:310px; width:205px; height:325px;}
.section1 .item1-6 em {left:132px; top:47px;}
.section1 .item1-7 {left:829px; top:310px; width:100px; height:325px;}
.section1 .item1-7 em {left:50px; top:130px;}
.section1 .item2-1 {left:148px; top:227px; width:371px; height:273px;}
.section1 .item2-1 em {left:248px; top:80px;}
.section1 .item2-2 {left:520px; top:65px; width:400px; height:340px;}
.section1 .item2-2 em {left:127px; top:155px;}
.section1 .item3-1 {left:0; top:65px; width:570px; height:560px;}
.section1 .item3-1 em {left:396px; top:232px;}
.section1 .item3-2 {left:575px; top:0; width:475px; height:495px;}
.section1 .item3-2 em {left:190px; top:237px;}
.section1 .item4-1 {left:0; top:155px; width:365px; height:270px;}
.section1 .item4-1 em {left:216px; top:24px;}
.section1 .item4-2 {left:370px; top:137px; width:183px; height:289px;}
.section1 .item4-2 em {left:162px; top:133px;}
.section1 .item4-3 {left:227px; top:428px; width:200px; height:170px;}
.section1 .item4-3 em {left:145px; top:8px;}
.section1 .item4-4 {left:427px; top:487px; width:140px; height:115px;}
.section1 .item4-4 em {left:35px; top:8px;}
.section1 .item4-5 {left:590px; top:356px; width:340px; height:250px;}
.section1 .item4-5 em {left:160px; top:8px;}
.section1 .item5-1 {left:0; top:0; width:1050px; height:670px;}
.section1 .item5-1 em {left:693px; top:254px;}
.section2 .item1-1 {left:100px; top:88px; width:255px; height:420px;}
.section2 .item1-1 em {left:232px; top:192px;}
.section2 .item1-2 {left:358px; top:325px; width:232px; height:225px;}
.section2 .item1-2 em {left:103px; top:9px;}
.section2 .item1-3 {left:600px; top:297px; width:390px; height:190px;}
.section2 .item1-3 em {left:144px; top:8px;}
/*
.section2 .item1-4 {left:227px; top:510px; width:130px; height:150px;}
.section2 .item1-4 em {left:75px; top:3px;}
.section2 .item1-5 {left:557px; top:543px; width:117px; height:109px;}
.section2 .item1-5 em {left:40px; top:0;}
.section2 .item1-6 {left:600px; top:488px; width:202px; height:55px;}
.section2 .item1-6 em {left:60px; top:5px;}
*/
.section2 .item2-1 {left:0; top:120px; width:445px; height:545px;}
.section2 .item2-1 em {left:267px; top:110px;}
.section2 .item2-2 {left:595px; top:65px; width:495px; height:365px;}
.section2 .item2-2 em {left:120px; top:133px;}
.section2 .item3-1 {left:0; top:0; width:1050px; height:670px;}
.section2 .item3-1 em {left:572px; top:198px;}
.section2 .item4-1 {left:0; top:200px; width:200px; height:470px;}
.section2 .item4-1 em {left:113px; top:287px;}
.section2 .item4-2 {left:200px; top:0; width:852px; height:590px;}
.section2 .item4-2 em {left:440px; top:247px;}
.section3 .item1-1 {left:55px; top:365px; width:155px; height:240px;}
.section3 .item1-1 em {left:72px; top:8px;}
.section3 .item1-2 {left:209px; top:450px; width:130px; height:175px;}
.section3 .item1-2 em {left:53px; top:8px;}
.section3 .item1-3 {left:288px; top:170px; width:325px; height:280px;}
.section3 .item1-3 em {left:152px; top:8px;}
.section3 .item1-4 {left:848px; top:128px; width:145px; height:293px;}
.section3 .item1-4 em {left:63px; top:8px;}
.section3 .item2-1 {left:0; top:0; width:1050px; height:670px;}
.section3 .item2-1 em {left:467px; top:192px;}
.section3 .item3-1 {left:103px; top:0; width:340px; height:140px;}
.section3 .item3-1 em {left:106px; top:117px;}
.section3 .item3-2 {left:0; top:140px; width:154px; height:328px;}
.section3 .item3-2 em {left:132px; top:22px;}
.section3 .item3-3 {left:154px; top:236px; width:188px; height:232px;}
.section3 .item3-3 em {left:144px; top:10px;}
.section3 .item3-4 {left:417px; top:0; width:432px; height:295px;}
.section3 .item3-4 em {left:102px; top:272px;}
.section3 .item3-5 {left:341px; top:314px; width:143px; height:153px;}
.section3 .item3-5 em {left:59px; top:54px;}
.section3 .item3-6 {left:222px; top:467px; width:162px; height:180px;}
.section3 .item3-6 em {left:114px; top:21px;}
.section3 .item3-7 {left:554px; top:511px; width:177px; height:159px;}
.section3 .item3-7 em {left:120px; top:24px;}
.section3 .item3-8 {left:731px; top:295px; width:320px; height:340px;}
.section3 .item3-8 em {left:161px; top:76px;}
.section3 .item4-1 {left:261px; top:110px; width:468px; height:504px;}
.section3 .item4-1 em {left:265px; top:239px;}
.section3 .item4-2 {left:728px; top:482px; width:210px; height:130px;}
.section3 .item4-2 em {left:120px; top:50px;}
.section4 .item1-1 {left:132px; top:162px; width:188px; height:285px;}
.section4 .item1-1 em {left:133px; top:38px;}
.section4 .item1-2 {left:24px; top:447px; width:296px; height:193px;}
.section4 .item1-2 em {left:179px; top:20px;}
.section4 .item1-3 {left:371px; top:208px; width:294px; height:195px;}
.section4 .item1-3 em {left:36px; top:30px;}
.section4 .item1-4 {left:371px; top:399px; width:280px; height:232px;}
.section4 .item1-4 em {left:101px; top:124px;}
.section4 .item1-5 {left:710px; top:311px; width:309px; height:88px;}
.section4 .item1-5 em {left:144px; top:25px;}
.section4 .item2-1 {left:148px; top:220px; width:265px; height:440px;}
.section4 .item2-1 em {left:133px; top:38px;}
.section4 .item2-2 {left:414px; top:84px; width:179px; height:468px;}
.section4 .item2-2 em {left:115px; top:175px;}
.section4 .item2-3 {left:593px; top:84px; width:253px; height:404px;}
.section4 .item2-3 em {left:181px; top:175px;}
.section4 .item3-1 {left:0; top:0; width:1050px; height:670px;}
.section4 .item3-1 em {left:555px; top:245px;}
.section4 .item4-1 {left:187px; top:103px; width:460px; height:245px;}
.section4 .item4-1 em {left:155px; top:95px;}
.section4 .item4-2 {left:655px; top:93px; width:240px; height:255px;}
.section4 .item4-2 em {left:112px; top:50px;}
.section4 .item4-3 {left:315px; top:360px; width:520px; height:165px;}
.section4 .item4-3 em {left:170px; top:15px;}
.section4 .item5-1 {left:0; top:0; width:1050px; height:670px;}
.section4 .item5-1 em {left:524px; top:350px;}
.item-section {position:relative;}
.item-section h3 {position:absolute; top:-33px; left:50%; width:1140px; margin-left:-570px; text-align:center;}
.section1 .item-section {height:670px; padding-top:224px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/bg_item1.png) repeat-x 50% 0;}
.section1 .item-section .item-list li .price span {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/bg_sale1.png);}
.section2 .item-section {height:672px; padding-top:224px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/bg_item2.png) repeat-x 50% 0;}
.section2 .item-section .item-list li .price span {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/bg_sale2.png);}
.section3 .item-section {height:674px; padding-top:224px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/bg_item3.png) repeat-x 50% 0;}
.section3 .item-section .item-list li .price span {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/bg_sale3.png);}
.section4 .item-section {height:666px; padding-top:224px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/bg_item4.png) repeat-x 50% 0;}
.section4 .item-section .item-list li .price span {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/bg_sale4.png);}
.item-list {overflow:hidden; position:absolute; left:50%; top:195px; width:1040px; margin-left:-520px;}
.item-list li {position:relative; float:left; width:204px; height:260px; margin:25px 28px;}
.item-list li a {display:block; width:100%; height:35px; padding-top:225px;}
.item-list li a:hover {text-decoration:none;}
.item-list li .name {overflow:hidden; width:100%; color:#333; font-size:15px; text-overflow:ellipsis; white-space:nowrap; font-family:"malgun Gothic","맑은고딕", Dotum, "돋움", sans-serif; font-weight:600;}
.item-list li .price {color:#d54f2c; font-size:13px; font-weight:600; font-family:"Roboto", sans-serif;}
.item-list li .price s {padding-right:7px; color:#333; font-weight: normal;}
.item-list li .price span {position:absolute; right:0; top:0; display:block; width:61px; height:61px; background-position:50% 50%; background-repeat:no-repeat; color:#fff; font-size:18px; font-family:verdana, sans-serif; text-align:center; line-height:60px; font-weight:600;}
.item-list li.btn-moreview {text-indent:-999em;}
.section2 .item-list li .price {color:#727630;}
.section3 .item-list li .price {color:#2a6972;}
.section4 .item-list li .price {color:#8e6b1f;}
.giving-banner {position:relative; height:320px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/bg_banner.png) repeat-x 50% 0;}
.giving-banner ul {position:absolute; left:50%; top:0; width:1144px; height:359px; margin-left:-572px;}
.giving-banner ul li {float:left; width:286px; height:359px;}
.giving-banner ul li a {overflow:hidden; display:block; width:100%; height:359px; margin-top:-19px; background-repeat:no-repeat; background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_banner_off.png); background-position:0 0; text-indent:-999em;}
.giving-banner ul li a:hover {background-image:url(http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_banner_over.png);}
.giving-banner ul li + li a {background-position:-286px 0;}
.giving-banner ul li + li + li a {background-position:-572px 0;}
.giving-banner ul li + li + li + li a {background-position:-858px 0;}
@keyframes bounce {
	from,to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-8px); animation-timing-function:ease-in;}
}
@keyframes tit {
	from {opacity:0; transform:scale(2);}
	to {opacity:1; transform:scale(1);}
}
@keyframes lineX {
	from {transform:scaleX(0)}
	to {transform:scaleX(1)}
}
@keyframes lineY {
	from {transform:scaleY(0)}
	to {transform:scaleY(1)}
}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function(){
	titleAnimation();
	$(".topic .chn").css({"margin-top":"-10px","opacity":"0"});
	$(".topic .subcopy").css({"margin-top":"10px","opacity":"0"});
	function titleAnimation() {
		$(".topic .chn").delay(100).animate({"margin-top":"0", "opacity":"1"},600);
		$(".topic .subcopy").delay(1000).animate({"margin-top":"-5px", "opacity":"1"},600).animate({"margin-top":"0"},600);
	}

	// 슬라이드
	var evtSwiper1 = new Swiper('.section1 .wideSwipe .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:1800,
		simulateTouch:false,
		pagination:'.section1 .wideSwipe .pagination',
		paginationClickable:true,
		nextButton:'.section1 .wideSwipe .btnNext',
		prevButton:'.section1 .wideSwipe .btnPrev'
	})
	$('.section1 .wideSwipe .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper1.swipePrev();
	})
	$('.section1 .wideSwipe .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper1.swipeNext();
	});
	var evtSwiper2 = new Swiper('.section2 .wideSwipe .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:1800,
		simulateTouch:false,
		pagination:'.section2 .wideSwipe .pagination',
		paginationClickable:true,
		nextButton:'.section2 .wideSwipe .btnNext',
		prevButton:'.section2 .wideSwipe .btnPrev'
	})
	$('.section2 .wideSwipe .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper2.swipePrev();
	})
	$('.section2 .wideSwipe .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper2.swipeNext();
	});
	var evtSwiper3 = new Swiper('.section3 .wideSwipe .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:1800,
		simulateTouch:false,
		pagination:'.section3 .wideSwipe .pagination',
		paginationClickable:true,
		nextButton:'.section3 .wideSwipe .btnNext',
		prevButton:'.section3 .wideSwipe .btnPrev'
	})
	$('.section3 .wideSwipe .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper3.swipePrev();
	})
	$('.section3 .wideSwipe .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper3.swipeNext();
	});
	var evtSwiper4 = new Swiper('.section4 .wideSwipe .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:1800,
		simulateTouch:false,
		pagination:'.section4 .wideSwipe .pagination',
		paginationClickable:true,
		nextButton:'.section4 .wideSwipe .btnNext',
		prevButton:'.section4 .wideSwipe .btnPrev'
	})
	$('.section4 .wideSwipe .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper4.swipePrev();
	})
	$('.section4 .wideSwipe .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper4.swipeNext();
	});			

	// 상품명, 상품가격 호출
    fnApplyItemInfoList({
        items:"123123,456456",
        target:"lyrItemList1",
        fields:["soldout","price","limit","sale"],
        unit:"hw",
        saleBracket:false 
	});
    fnApplyItemInfoList({
        items:"123123,456456",
        target:"lyrItemList2",
        fields:["soldout","price","limit","sale"],
        unit:"hw",
        saleBracket:false 
	});
    fnApplyItemInfoList({
        items:"123123,456456",
        target:"lyrItemList3",
        fields:["soldout","price","limit","sale"],
        unit:"hw",
        saleBracket:false
	});
    fnApplyItemInfoList({
        items:"123123,456456",
        target:"lyrItemList4",
        fields:["soldout","price","limit","sale"],
        unit:"hw",
        saleBracket:false 
    });		
});
</script>	
						<!-- 2018 추석기획전 -->						
						<div class="evt88771 thanksgiving">
							<div class="topic">
								<div class="title">
									<p class="chn"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/tit_small_present.png" alt="小確膳" /></p>
									<h2>
										<span class="t1">소</span>
										<span class="t2">확</span>
										<span class="t3">행</span>
									</h2>
									<p class="subcopy"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/tit_sub_small_present.png" alt="소소하지만 확실하게 기억될 추석 선물" /></p>
									<span class="deco1"></span><span class="deco2"></span><span class="deco3"></span><span class="deco4"></span>
								</div>
								<!-- 오늘의 특가 -->
								<div class="todayGift" id="lyrTodayGift">
									<h3>오늘의 특가 선물</h3>								
									<p class="time"><em>--</em><em>--</em><em>--</em></p>
									<a href="">
										<div class="thumbnail"><img src="http://fiximage.10x10.co.kr/m/2017/common/bg_img_loading.png" alt="오늘의 특가"></div>
										<p class="name"></p>
										<p class="price"></p>
									</a>
								</div>
								<!--// 오늘의 특가 -->								
								<script type="text/javascript" src="/event/etc/json/js_88771.js?v=120"></script>
							</div>
							<div class="givingContainer">
								<div class="section section1">
									<div class="slideTemplateV15 wideSwipe">
										<div class="swiper-container">
											<div class="swiper-wrapper">
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1781962&pEtr=88771" class="item-more item1-1"><em>+</em>달콤 고소 화과자</a>
													<a href="/shopping/category_prd.asp?itemid=1638559&pEtr=88771" class="item-more item1-2"><em>+</em>URBAN YAKGWA 어반약과 (찹쌀+블랙패키지)</a>
													<a href="/shopping/category_prd.asp?itemid=1751855&pEtr=88771" class="item-more item1-3"><em>+</em>수제한과 문볼 6종 - 찹쌀/쑥/호박/흑미/백년초/차조</a>
													<a href="/shopping/category_prd.asp?itemid=1544880&pEtr=88771" class="item-more item1-4"><em>+</em>현미 연강정&정과&편강 선물세트L 유자/비트/녹차</a>
													<a href="/shopping/category_prd.asp?itemid=1961587&pEtr=88771" class="item-more item1-5"><em>+</em>[꽃을담다] 아카시아 꽃차 티백</a>
													<a href="/shopping/category_prd.asp?itemid=2049907&pEtr=88771" class="item-more item1-6"><em>+</em>[알디프] 2018 알디프 트라이앵글 티백 샘플러 NO.4 뉴 클래식</a>
													<a href="/shopping/category_prd.asp?itemid=1616984&pEtr=88771" class="item-more item1-7"><em>+</em>[꽃을담다]Mini꽃차&티스틱세트</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide1_1.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1751855&pEtr=88771" class="item-more item2-1"><em>+</em>수제한과 문볼 6종 - 찹쌀/쑥/호박/흑미/백년초/차조</a>
													<a href="/shopping/category_prd.asp?itemid=1544880&pEtr=88771" class="item-more item2-2"><em>+</em>현미 연강정&정과&편강 선물세트L 유자/비트/녹차</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide1_2.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=2077246&pEtr=88771" class="item-more item3-1"><em>+</em>[청미당X텐바이텐] 꿀조합 화과자세트</a>
													<a href="/shopping/category_prd.asp?itemid=1638559&pEtr=88771" class="item-more item3-2"><em>+</em>URBAN YAKGWA 어반약과 (찹쌀+블랙패키지)</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide1_3.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1953679&pEtr=88771" class="item-more item4-1"><em>+</em>프릳츠 콜드브루와 유리잔</a>
													<a href="/shopping/category_prd.asp?itemid=1881035&pEtr=88771" class="item-more item4-2"><em>+</em>[어반약과X텐바이텐] 어반약과 핑크 에디션</a>
													<a href="/shopping/category_prd.asp?itemid=2049907&pEtr=88771" class="item-more item4-3"><em>+</em>[알디프] 2018 알디프 트라이앵글 티백 샘플러 NO.4 뉴 클래식</a>
													<a href="/shopping/category_prd.asp?itemid=1549037&pEtr=88771" class="item-more item4-4"><em>+</em>5가지맛 보석양갱</a>
													<a href="/shopping/category_prd.asp?itemid=2069160&pEtr=88771" class="item-more item4-5"><em>+</em>커스텀 케이크</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide1_4.jpg" alt="" />
												</div>												
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=2069160&pEtr=88771" class="item-more item5-1"><em>+</em>커스텀 케이크</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide1_5.jpg" alt="" />
												</div>												
											</div>
											<div class="pagination"></div>
											<button class="slideNav btnPrev">이전</button>
											<button class="slideNav btnNext">다음</button>
											<div class="mask left"></div>
											<div class="mask right"></div>
										</div>
									</div>
									<div class="item-section">
										<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/text_item1.png" alt="01 도란도란 모인 자리, 달달한 다과 한 상 : 온 가족이 모여 도란도란 이야기를 나누는 즐거운 시간 그 시간이 더욱 달달해지도록 소담스러운 다과상을 차려드리고 싶어요" /></h3>
										<ul class="item-list" id="lyrItemlist1">
											<li>
												<a href="/shopping/category_prd.asp?itemid=2069160&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1781962&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>5%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=2049907&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>15%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1544880&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1638559&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1616984&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>50%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1549037&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원</p>
													</div>
												</a>
											</li>
											<li class="btn-moreview">
												<a href="/event/eventmain.asp?eventid=88773">더 많은 상품 보기</a>
											</li>																																										
										</ul>
										<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_item1.png" alt="" /></p>
									</div>
								</div>
								<div class="section section2">
									<div class="slideTemplateV15 wideSwipe">
										<div class="swiper-container">
											<div class="swiper-wrapper">
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=2065379&pEtr=88771" class="item-more item1-1"><em>+</em>복순도가 손 막걸리 3병 선물세트</a>
													<a href="/shopping/category_prd.asp?itemid=2073519&pEtr=88771" class="item-more item1-2"><em>+</em>[살룻X텐바이텐] 추석 2구 선물 세트</a>
													<a href="/shopping/category_prd.asp?itemid=1515949&pEtr=88771" class="item-more item1-3"><em>+</em>정성세트</a>
													<!--
													<a href="" class="item-more item1-4"><em>+</em></a>
													<a href="" class="item-more item1-5"><em>+</em></a>
													<a href="" class="item-more item1-6"><em>+</em></a>
													-->
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide2_1.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1943802&pEtr=88771" class="item-more item2-1"><em>+</em>자꾸자꾸오란다</a>
													<a href="/shopping/category_prd.asp?itemid=2065379&pEtr=88771" class="item-more item2-2"><em>+</em>복순도가 손 막걸리 3병 선물세트</a>												
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide2_2.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1285004&pEtr=88771" class="item-more item3-1"><em>+</em>아몬드/캐슈넛/월넛/피칸/피스타치오 닥터넛츠 오리지널뉴(30개입)</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide2_3.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1789995&pEtr=88771" class="item-more item4-1"><em>+</em>은혜세트</a>
													<a href="/shopping/category_prd.asp?itemid=1515948&pEtr=88771" class="item-more item4-2"><em>+</em>감사세트</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide2_4.jpg" alt="" />
												</div>																							
											</div>
											<div class="pagination"></div>
											<button class="slideNav btnPrev">이전</button>
											<button class="slideNav btnNext">다음</button>
											<div class="mask left"></div>
											<div class="mask right"></div>
										</div>
									</div>								
									<div class="item-section">
										<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/text_item2.png" alt="02 오랜만에 모여 짠! 기분 좋은 한 잔! : 오랜만에 모두가 모인 자리, 이런 자리에 술이 빠질 수는 없죠 술과 함께 할 다양한 안주들을 곁들여 기분 좋은 흥을 안겨드리고 싶어요" /></h3>
										<ul class="item-list" id="lyrItemlist1">
											<li>
												<a href="/shopping/category_prd.asp?itemid=2073519&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1285004&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>5%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1943802&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>15%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1515948&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=2065379&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=2076005&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>50%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1959277&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원</p>
													</div>
												</a>
											</li>
											<li class="btn-moreview">
												<a href="/event/eventmain.asp?eventid=88774">더 많은 상품 보기</a>
											</li>																																										
										</ul>
										<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_item2.png" alt="" /></p>
									</div>
								</div>
								<div class="section section3">
									<div class="slideTemplateV15 wideSwipe">
										<div class="swiper-container">
											<div class="swiper-wrapper">
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1792350&pEtr=88771" class="item-more item1-1"><em>+</em>생강 5종 선물세트</a>
													<a href="/shopping/category_prd.asp?itemid=1549045&pEtr=88771" class="item-more item1-2"><em>+</em>꿀.건.달 [보자기묶음] 벌꿀 3종 미니 선물세트</a>
													<a href="/shopping/category_prd.asp?itemid=1468740&pEtr=88771" class="item-more item1-3"><em>+</em>당산나무 집벌꿀 답례품 中 세트</a>
													<a href="/shopping/category_prd.asp?itemid=2068534&pEtr=88771" class="item-more item1-4"><em>+</em>벌집꿀 + 건강수제청 선물세트</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide3_1.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1468740&pEtr=88771" class="item-more item2-1"><em>+</em>당산나무 집벌꿀 답례품 中 세트</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide3_2.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1468740&pEtr=88771" class="item-more item3-1"><em>+</em>당산나무 집벌꿀 답례품 中 세트</a>
													<a href="/shopping/category_prd.asp?itemid=2076011&pEtr=88771" class="item-more item3-2"><em>+</em>[예약판매] 산삼이 씹히는 건강한 소리, 산양산삼즙 '삼근삼근'</a>
													<a href="/shopping/category_prd.asp?itemid=1879148&pEtr=88771" class="item-more item3-3"><em>+</em>6년근 홍삼액 말랭이 아띠멜로 3가지 맛 세트</a>
													<a href="/shopping/category_prd.asp?itemid=1549045&pEtr=88771" class="item-more item3-4"><em>+</em>꿀.건.달 [보자기묶음] 벌꿀 3종 미니 선물세트</a>
													<a href="/shopping/category_prd.asp?itemid=1553228&pEtr=88771" class="item-more item3-5"><em>+</em>인시즌 생강 3종 선물세트</a>
													<a href="/shopping/category_prd.asp?itemid=1792350&pEtr=88771" class="item-more item3-6"><em>+</em>생강 5종 선물세트</a>
													<a href="/shopping/category_prd.asp?itemid=2063632&pEtr=88771" class="item-more item3-7"><em>+</em>[2018추석선물] 프리미엄 쌍화 2종세트</a>
													<a href="/shopping/category_prd.asp?itemid=2068534&pEtr=88771" class="item-more item3-8"><em>+</em>벌집꿀 + 건강수제청 선물세트</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide3_3.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=2063632&pEtr=88771" class="item-more item4-1"><em>+</em>[2018추석선물] 프리미엄 쌍화 2종세트</a>
													<a href="/shopping/category_prd.asp?itemid=2076010&pEtr=88771" class="item-more item4-2"><em>+</em>[예약판매] 직접 기른 5년근 산양산삼 5+1뿌리</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide3_4.jpg" alt="" />
												</div>
											</div>
											<div class="pagination"></div>
											<button class="slideNav btnPrev">이전</button>
											<button class="slideNav btnNext">다음</button>
											<div class="mask left"></div>
											<div class="mask right"></div>
										</div>
									</div>									
									<div class="item-section">
										<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/text_item3.png" alt="03 늘 괜찮다- 말하는 당신에게 정말 괜찮은 선물 하나 : 뭐니 뭐니 해도 건강이 최우선이죠 하지만 옆에서 매번 챙겨드릴 수 없어 늘 죄송한 당신께 건강을 선물하고 싶어요" /></h3>
										<ul class="item-list" id="lyrItemlist1">
											<li>
												<a href="/shopping/category_prd.asp?itemid=2076011&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1792350&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>5%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=2063632&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>15%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1549045&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1468740&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=2068534&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>50%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1879148&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원</p>
													</div>
												</a>
											</li>
											<li class="btn-moreview">
												<a href="/event/eventmain.asp?eventid=88775">더 많은 상품 보기</a>
											</li>																																									
										</ul>
										<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_item3.png" alt="" /></p>
									</div>
								</div>
								<div class="section section4">
									<div class="slideTemplateV15 wideSwipe">
										<div class="swiper-container">
											<div class="swiper-wrapper">
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=2071652&pEtr=88771" class="item-more item1-1"><em>+</em>부엉이곳간 간장2종 보자기 세트</a>
													<a href="/shopping/category_prd.asp?itemid=2032482&pEtr=88771" class="item-more item1-2"><em>+</em>프리미엄 잡곡 선물세트</a>
													<a href="/shopping/category_prd.asp?itemid=1780968&pEtr=88771" class="item-more item1-3"><em>+</em>간편한 아침 모닝죽 3주 선물패키지(130g*21개입)</a>
													<a href="/shopping/category_prd.asp?itemid=1199665&pEtr=88771" class="item-more item1-4"><em>+</em>인테이크 세상모든향신료(마스터SET)</a>
													<a href="/shopping/category_prd.asp?itemid=2066844&pEtr=88771" class="item-more item1-5"><em>+</em>2018 추석 존쿡 델리미트 패밀리 세트</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide4_1.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1780968&pEtr=88771" class="item-more item2-1"><em>+</em>간편한 아침 모닝죽 3주 선물패키지(130g*21개입)</a>
													<a href="/shopping/category_prd.asp?itemid=2071652&pEtr=88771" class="item-more item2-2"><em>+</em>부엉이곳간 간장2종 보자기 세트</a>
													<a href="/shopping/category_prd.asp?itemid=2032482&pEtr=88771" class="item-more item2-3"><em>+</em>프리미엄 잡곡 선물세트</a>												
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide4_2.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1780968&pEtr=88771" class="item-more item3-1"><em>+</em>간편한 아침 모닝죽 3주 선물패키지(130g*21개입)</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide4_3.jpg" alt="" />
												</div>
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=2066840&pEtr=88771" class="item-more item4-1"><em>+</em>2018 추석 존쿡 델리미트 시그니처 세트</a>
													<a href="/shopping/category_prd.asp?itemid=2066844&pEtr=88771" class="item-more item4-2"><em>+</em>2018 추석 존쿡 델리미트 패밀리 세트</a>
													<a href="/shopping/category_prd.asp?itemid=1199665&pEtr=88771" class="item-more item4-3"><em>+</em>인테이크 세상모든향신료(마스터SET)</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide4_4.jpg" alt="" />
												</div>												
												<div class="swiper-slide">
													<a href="/shopping/category_prd.asp?itemid=1212217&pEtr=88771" class="item-more item5-1"><em>+</em>인테이크 에센셜 조미료 6종(허브/향신료/천연조미료)</a>
													<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_slide4_5.jpg" alt="" />
												</div>												
											</div>
											<div class="pagination"></div>
											<button class="slideNav btnPrev">이전</button>
											<button class="slideNav btnNext">다음</button>
											<div class="mask left"></div>
											<div class="mask right"></div>
										</div>
									</div>
									<div class="item-section">
										<h3><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/text_item4.png" alt="04 보약 한 첩보다 든든한 밥 한 상 : 다같이 둘러 앉아 온 가족이 나눠먹는 밥상 맛있는 정성으로 꽉 찬 추석 한 상을 차려드리고 싶어요" /></h3>
										<ul class="item-list" id="lyrItemlist1">
											<li>
												<a href="/shopping/category_prd.asp?itemid=2032482&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=2071652&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>5%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=2066844&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>15%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1199665&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1421167&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price">24,900원</p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1926845&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원<span>50%</span></p>
													</div>
												</a>
											</li>
											<li>
												<a href="/shopping/category_prd.asp?itemid=1780968&pEtr=88771">
													<div class="desc">
														<p class="name">상품명</p>
														<p class="price"><s>33,500원</s>24,900원</p>
													</div>
												</a>
											</li>
											<li class="btn-moreview">
												<a href="/event/eventmain.asp?eventid=88776">더 많은 상품 보기</a>
											</li>
										</ul>
										<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88771/img_item4.png" alt="" /></p>
									</div>																																
								</div>
							</div>
							<div class="giving-banner">
								<ul>
									<li><a href="/event/eventmain.asp?eventid=88779">명절 요리가 쉬워지는 전지적 요리 시점</a></li>
									<li><a href="/event/eventmain.asp?eventid=88897">부모님도 춤추게 하는 용돈 봉투</a></li>
									<li><a href="/event/eventmain.asp?eventid=88849">양 손은 무겁지만 마음은 가벼운 추석 선물</a></li>
									<li><a href="/event/eventmain.asp?eventid=88835">온 가족이 모여 앉아 즐거운 놀이 한 판</a></li>
								</ul>
							</div>
						</div>
						<!--// 2018 추석기획전 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->