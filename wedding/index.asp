<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/wedding2018.css?v=2.12" />
<script type="text/javascript">
$(function(){
	// rolling
	var swiper1 = new Swiper('.rolling1 .swiper-container',{
		loop: true,
		speed:800,
		autoplay:2000,
		mousewheelControl:true,
		pagination: '.rolling1 .pagination',
		paginationClickable: true
	});
	var swiper2 = new Swiper('.rolling2 .swiper-container',{
		loop: false,
		speed:800,
		autoplay:2000,
		mode: 'vertical',
		mousewheelControl:true,
		paginationClickable: true,
		pagination: '.rolling2 .pagination',
		nextButton:'.rolling2 .btnNext',
		prevButton:'.rolling2 .btnPrev'
	});
	$('.rolling2 .btn-prev').on('click', function(e){
		e.preventDefault();
		swiper2.swipePrev();
	})
	$('.rolling2 .btn-next').on('click', function(e){
		e.preventDefault();
		swiper2.swipeNext();
	});
	var swiper3 = new Swiper('.rolling3 .swiper-container',{
		loop: true,
		speed:800,
		autoplay:2000,
		mousewheelControl:true,
		pagination: '.rolling3 .pagination',
		paginationClickable: true
	});

	// 이미지사이즈조정
/*	$.each($('.info img'), function (index, value) {
		$(this).height($(value).outerHeight()/2);
	});
	$.each($('.kit img'), function (index, value) {
		$(this).height($(value).outerHeight()/2);
	});*/

	// 효과
	$('.dwn-chck-list').addClass("slideUp");
	var wdcheck = $(".wed-nav").offset().top+100;
	$(window).scroll(function() {
		var y = $(window).scrollTop();
		if ( y < wdcheck ) {
			$('.dwn-chck-list').addClass("slideUp");
		}
		else {
			$('.dwn-chck-list').removeClass("slideUp");
		}
	});
	$('.shp-list .section .d-day').css({"opacity":"0","z-index":"100"});
	$('.shp-list .section1 .d-day').children('i').addClass('slideDown');
	$('.shp-list .section1 .d-day').addClass('slideLeft');
	$('.shp-list .section1 .d-day').children('span').addClass('slideLeft');
	$(window).scroll(function() {
		var y = $(window).scrollTop();
		$('.shp-list .section .d-day i').css({"opacity":"0"});
		$('.shp-list .section .d-day i').removeClass('slideDown');
		if ((y < 700)) {
			$('.shp-list .section1 .d-day i').addClass('slideDown');
		}
		if ((y > 800) && (y < 2200)) {
			$('.shp-list .section2 .d-day i').addClass('slideDown');
		}
		if ((y > 3000) && (y < 4000)) {
			$('.shp-list .section3 .d-day i').addClass('slideDown');
		}
		if ((y > 3900) && (y < 5300)) {
			$('.shp-list .section4 .d-day i').addClass('slideDown');
		}
		if ((y > 5300) && (y < 6100)) {
			$('.shp-list .section5 .d-day i').addClass('slideDown');
		}
		$('.d-day').each(function(){
			var h = $(window).height();
			var y = $(window).scrollTop();
			var rosePositon = $(this).offset().top - 700;
			if (rosePositon < y){
				$(this).addClass('slideLeft');
				$(this).children('span').addClass('slideLeft');
			}
		});
	});
	fnEvtItemList(85159,240256,'tab2','boxes');
});

function fnEvtItemList(ecode, gcode, menuid, tabid){
	$.ajax({
		url: "act_evt_itemlist.asp?eventid="+ecode+"&eGC="+gcode,
		cache: false,
		success: function(message) {
			if(message!="") {
				//alert(message);
				$("#tab1").removeClass("on");
				$("#tab2").removeClass("on");
				$("#tab3").removeClass("on");
				$("#tab4").removeClass("on");
				$("#tab5").removeClass("on");
				$("#"+menuid).addClass("on");
				$("#evtPdtListWrapV15").empty().append(message);
				if(tabid != "")
				{
					setTimeout("fnSearchBar('"+tabid+"')",1000);
				}
				else
				{
					window.scrollTo(0,$(".wed-nav-more").offset().top - 50);
				}
				vScrl=true;
			} else {
			}
		}
		,error: function(err) {
			alert(err.responseText);
			$(window).unbind("scroll");
		}
	});
}

function fnSearchBar(tabid){
	var target=$("#"+tabid)
	$("html,body").animate({
		scrollTop:target.offset().top
	},1000);
}

function fnTabSelect(tabid){
	$("#stab1 li").removeClass("on");
	$("#"+tabid).addClass("on");
}
</script>
</head>
<body>
<div class="wrap fullEvt">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container wedding2018">
		<div id="contentWrap" class="wedding-main">
			<!-- #include virtual="/wedding/head.asp" -->
			<!-- 웨딩쇼핑리스트 -->
			<% server.Execute("/wedding/lib/shopping_list.asp") %>
			<!--// 웨딩쇼핑리스트 -->

			<!-- 최하단탭 -->
			<div class="wed-nav-more" id="wed-nav-more">
				<ul>
					<li onclick="fnEvtItemList(85159,240250,'tab1','');" id="tab1" class="on">
						<p>D-100</p>
						<ul id="stab1">
							<li class="on" id="d100-step2"><a href="#groupBar1">상견례 패션/선물</a></li>
							<li id="d100-step1"><a href="javascript:fnEvtItemList(85159,240250,'tab1','groupBar3');">결혼 계획 세우기</a></li>
							<li id="d100-step3"><a href="javascript:fnEvtItemList(85159,240250,'tab1','groupBar4');">프로포즈</a></li>
							<li id="d100-step4"><a href="javascript:fnEvtItemList(85159,240250,'tab1','groupBar5');">다이어트/뷰티</a></li>
						</ul>
					</li>
					<li onclick="fnEvtItemList(85159,240256,'tab2','');" id="tab2">
						<p>D-60</p>
						<ul id="stab2">
							<li id="d60-step3"><a href="javascript:fnEvtItemList(85159,240256,'tab2','groupBar1');">웨딩 촬영</a></li>
							<li id="d60-step1"><a href="javascript:fnEvtItemList(85159,240256,'tab2','groupBar2');">혼수 가구 준비</a></li>
							<li id="d60-step2"><a href="javascript:fnEvtItemList(85159,240256,'tab2','groupBar5');">혼수 가전 준비</a></li>
						</ul>
					</li>
					<li onclick="fnEvtItemList(85159,240262,'tab3','');" id="tab3">
						<p>D-30</p>
						<ul id="stab3">
							<li id="d30-step2"><a href="javascript:fnEvtItemList(85159,240262,'tab3','groupBar1');">리빙아이템 준비</a></li>
							<li id="d30-step1"><a href="javascript:fnEvtItemList(85159,240262,'tab3','groupBar5');">브라이덜샤워</a></li>
						</ul>
					</li>
					<li onclick="fnEvtItemList(85159,240268,'tab4','');" id="tab4">
						<p>D-15</p>
						<ul id="stab4">
							<li id="d15-step5"><a href="javascript:fnEvtItemList(85159,240268,'tab4','groupBar1');">신혼여행 짐싸기</a></li>
							<li id="d15-step4"><a href="javascript:fnEvtItemList(85159,240268,'tab4','groupBar5');">포토 테이블 장식</a></li>
							<li id="d15-step3"><a href="javascript:fnEvtItemList(85159,240268,'tab4','groupBar6');">웨딩카 꾸미기</a></li>
							<li id="d15-step2"><a href="javascript:fnEvtItemList(85159,240268,'tab4','groupBar7');">사례비/식권도장</a></li>
						</ul>
					</li>
					<li onclick="fnEvtItemList(85159,240276,'tab5','');" id="tab5">
						<p>D+10</p>
						<ul id="stab5">
							<li id="d10-step1"><a href="javascript:fnEvtItemList(85159,240276,'tab5','groupBar1');">감사인사 답례품</a></li>
							<li id="d10-step2"><a href="javascript:fnEvtItemList(85159,240276,'tab5','groupBar2');">집들이</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div id="evtPdtListWrapV15">
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->