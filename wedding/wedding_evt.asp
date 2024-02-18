<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/wedding2018.css?v=1.0" />
<!-- <base href="http://www.10x10.co.kr/"> -->
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
<script type="text/javascript">
$(function(){
	// 웨딩기획전롤링
	if ($('.wed-evt-list .swiper-slide').length > 3) {
		var evtSwiper = new Swiper('.wed-evt-list .swiper-container',{
			speed:800,
			slidesPerView:3,
			//slidesPerGroup:3, 3개씩 슬라이드
			pagination:false,
			onSlideChangeStart: function (evtSwiper) {
				$('.wed-evt-list .btn-prev').css({'opacity':'1'});
				$('.wed-evt-list .btn-next').css({'opacity':'1'});
				if ($('.swiper-wrapper div:nth-child(1)').hasClass('swiper-slide-visible')) {
					$('.wed-evt-list .btn-prev').css({'opacity':'.2'});
				}
				if ($('.swiper-wrapper div:nth-child(4)').hasClass('swiper-slide-visible')) {
					$('.wed-evt-list .btn-next').css({'opacity':'.2'});
				}
			}
		});
		$('.wed-evt-list .btn-prev').on('click', function(e){
			e.preventDefault()
			evtSwiper.swipePrev()
		})
		$('.wed-evt-list .btn-next').on('click', function(e){
			e.preventDefault()
			evtSwiper.swipeNext()
		});
		$('.wed-evt-list button').show();
	}
	if ($('.swiper-wrapper div:nth-child(1)').hasClass('swiper-slide-visible')) {
		$('.wed-evt-list .btn-prev').css({'opacity':'.2'});
	}
	if ($('.swiper-wrapper div:nth-child(4)').hasClass('swiper-slide-visible')) {
		$('.wed-evt-list .btn-next').css({'opacity':'.2'});
	}
});
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container wedding2018">
		<!-- 웨딩기획전 -->
		<div id="contentWrap" class="special-event">
			<!-- #include virtual="/wedding/head.asp" -->
			<!-- 웨딩기획전목록 -->
			<% server.Execute("/wedding/lib/plan_event.asp") %>
			<!--// 웨딩기획전목록 -->
			<!-- 엠디픽 -->
			<% server.Execute("/wedding/lib/md_pick.asp") %>
			<!--// 엠디픽 -->
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->