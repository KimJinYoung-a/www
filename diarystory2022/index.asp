<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 다이어리 스토리 2021 MAIN
' History : 2020-08-24 이종화
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/event/exhibitionCls.asp" -->
<!-- #include virtual="/diarystory2022/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/diarystory2022/lib/worker_only_view.asp" -->
<%
'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			Response.Redirect "//m.10x10.co.kr/diarystory2022/"
			REsponse.End
		end if
	end if
end if

dim tempPrice , saleStr , couponStr
Dim oExhibition
dim masterCode
dim i
dim giftCheck : giftCheck = False '사은품 표기 온오프

IF application("Svr_Info") = "Dev" THEN
    masterCode = "3"
else
    masterCode = "10"
end if

SET oExhibition = new ExhibitionCls
%>
<%
public function couponDisp(couponVal)
	if couponVal = "" or isnull(couponVal) then exit function
	couponDisp = chkIIF(couponVal > 100, couponVal, couponVal & "%")
end function
%>
<style>
.gift-popup .btn-close {position: fixed !important;top: 0;right: 0;}
</style>
<script>
$(function(){
	fnAmplitudeEventAction('view_diarystory_main','','');
});
</script>
</head>
<body>
<div class="wrap">
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container diary2021 new-type">
		<div id="contentWrap" class="dr-main">
			<%'다이어리 스토리 GNB %>
			<!-- #include virtual="/diarystory2022/inc/header.asp" -->

			<%' 메인 롤링 배너 %>
			<!-- #include virtual="/diarystory2022/inc/main/inc_main_rolling.asp" -->

			<%' Md`s Pick %>
			<!-- #include virtual="/diarystory2022/inc/main/inc_recommended_diary.asp" -->

			<%' 베스트 상품 %>
			<!-- #include virtual="/diarystory2022/inc/main/inc_bestlist.asp" -->

			<%' 기획전 %>
			<!-- #include virtual="/diarystory2022/inc/main/inc_exhibition.asp" -->

			<%' 방금 판매된 상품 %>
			<!-- #include virtual="/diarystory2022/inc/main/inc_now_sellitem.asp" -->

			<%' 이벤트 배너 %>
			<!-- #include virtual="/diarystory2022/inc/main/inc_eventBanner.asp" -->

			<!--  마케팅 배너 -->
			<div class="bnr-expand">
				<% If Date<="2020-10-04" Then %>
				<p><img src="//fiximage.10x10.co.kr/web2020/diary2021/bnr_mkt.gif" alt="다이어리이벤트"></p>
				<a href="/event/eventmain.asp?eventid=105778" title="다이어리이벤트"><img src="//fiximage.10x10.co.kr/web2020/diary2021/bnr_mkt_on.gif" alt=""></a>
				<% ElseIf Date>="2020-10-05" and Date<="2020-10-18" Then %>
				<p><img src="//fiximage.10x10.co.kr/web2020/diary2021/bnr_mkt_v2.png" alt="그림일기"></p>
				<a href="/event/eventmain.asp?eventid=106091" title="그림일기"><img src="//fiximage.10x10.co.kr/web2020/diary2021/bnr_mkt_on_v2.png" alt=""></a>
				<% End If %>
				<!-- <p><img src="//webimage.10x10.co.kr/fixevent/event/2020/107751/bnr_mkt.png" alt=""></p>
				<a href="/event/eventmain.asp?eventid=107751" title=""><img src="//webimage.10x10.co.kr/fixevent/event/2020/107751/bnr_mkt_on.png" alt=""></a> -->
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<script>
$(function(){
	// 메인 롤링
	var slider = $('.slider-main');
	var amt = slider.find('.dr-evt-item').length;
	var progress = $('.progressbar-fill');
	if (amt > 1) {
		slider.on('init', function(){
			var init = (1 / amt).toFixed(2);
			progress.css('transform', 'scaleX(' + init + ') scaleY(1)');
		});
		slider.on('beforeChange', function(event, slick, currentSlide, nextSlide){
			var calc = ( (nextSlide+1) / slick.slideCount ).toFixed(2);
			progress.css('transform', 'scaleX(' + calc + ') scaleY(1)');
		});
		slider.slick({
			variableWidth: true,
			autoplaySpeed: 1800,
			arrows: true,
			speed: 1000
		});

		// 슬라이드 애니메이션 버그 (마지막 슬라이드 >> 첫번째 슬라이드 / 첫번째 슬라이드 >> 마지막 슬라이드)
		var fisrtSlide = $('.slider-main .slick-slide[data-slick-index="0"]'),
			lastSlide = $('.slider-main .slick-slide[data-slick-index="' + amt + '"]'),
		    clonedLastSlide = $('.slider-main .slick-slide[data-slick-index="-1"]'),
			ClonedFirstSlide = $('.slider-main .slick-slide[data-slick-index="' + amt + '"]');
		slider.on('beforeChange', function(event, slick, currentSlide, nextSlide){
			if(lastSlide.hasClass('slick-current')) ClonedFirstSlide.css({"margin-top":"40px"});
			else ClonedFirstSlide.css({"margin-top":"0px"})
			if(fisrtSlide.hasClass('slick-current')) clonedLastSlide.css({"margin-top":"0px"});
			else clonedLastSlide.css({"margin-top":"40px"})
		});

	} else {
		$(this).find('.pagination-progressbar').hide();
	}

	// MD 추천
	$(".slider-prd").slick({
		variableWidth: true,
		draggable: false,
		arrows: true,
		slidesToShow: 3,
		slidesToScroll: 3,
		adaptiveHeight: true
	});

	// 마케팅 배너
	$(window).scroll(function(){
		var nowSt = $(this).scrollTop();
		var lastSt = $('.sect-bnf').offset().top*.33;
		if ( lastSt < nowSt ) {
			$(".bnr-expand").addClass("on");
		} else {
			$(".bnr-expand").removeClass("on");
		}
	})
	$(function() {
		$(".bnr-expand").mouseenter(function(e){
			$(this).find("a").addClass("active");
			$(this).find("p").delay(100).animate({"opacity":"0"},1)
		}).mouseleave(function(e){
			$(this).find("a").removeClass("active");
			$(this).find("p").stop().animate({"opacity":"1"},1)
		});
	});
});
</script>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->