<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'####################################################
' Description : 나른 디즈니
' History : 2021-04-16 김진욱
'####################################################
Dim currentDate, evtStartDate, evtEndDate, eCode, userid, mktTest
Dim eventCoupons, isCouponShow, vQuery
mktTest = false

currentDate = now()
evtStartDate = Cdate("2021-04-18")
evtEndDate = Cdate("2021-04-18")

'test
'currentDate = Cdate("2021-04-16")

IF application("Svr_Info") = "Dev" THEN
	eCode = "104334"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
	eCode = "105348"
    mktTest = true    
Else
	eCode = "109527"
    mktTest = false
End If
%>
<style>
.evt109527 {max-width:1920px; margin:0 auto; background:#fff;}
.evt109527 .txt-hidden {text-indent:-9999px; font-size:0;}
.evt109527 .topic {position:relative; width:100%; height:1524px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109527/img_main.jpg) no-repeat 50% 0;}
.evt109527 .topic h2.txt01 {position:absolute; left:50%; top:150px; margin-left:-206px; transform:translateY(10%); opacity:0; transition:all 1s;}
.evt109527 .topic h2.txt02 {position:absolute; left:50%; top:217px; margin-left:-295px; transform:translateY(10%); opacity:0; transition:all 1s .6s;}
.evt109527 .topic h2.txt01.on,
.evt109527 .topic h2.txt02.on {opacity:1; transform:translateY(0);}
.evt109527 .animate {opacity:0; transform:translateY(10%); transition:all 1s;}
.evt109527 .animate.on {opacity:1; transform:translateY(0);}

.evt109527 .swiper-wrapper {display:flex; height:100%!important;}
.evt109527 .swiper-container {height:100%;}
.evt109527 .swiper-container .swiper-slide {height:100% !important;}
.evt109527 .swiper-pagination {position:absolute; left:50%; bottom:0; transform:translate(-240%,0); z-index:10;}
.evt109527 .swiper-pagination-switch {display:inline-block; width:13px; height:13px; margin:0 10px; border-radius:100px; background:#f34500;}
.evt109527 .swiper-pagination-switch.swiper-active-switch {background:#ffd9c4;}

.evt109527 .swiper-pagination01 {position:absolute; left:50%; bottom:0; transform:translate(-50%,0); z-index:10;}

.evt109527 .section-01 {padding:160px 0 140px; background:#ff7930;}
.evt109527 .section-01 .slide-area {position:relative; padding:70px 0 0 264px;}
.evt109527 .section-01 .swiper-slide {position:relative;}
.evt109527 .section-01 .swiper-slide .line {position:absolute; left:0; bottom:12px; display:inline-block; width:304px; height:2px; background:#ffba00;}
.evt109527 .section-01 .swiper-container {padding-bottom:63px;}
.evt109527 .section-01 .swiper-button-next {position:absolute; left:50%; top:50%; transform: translate(3800%,-317%); width:16px; height:29px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109527/icon_arrow.png) no-repeat 50% 0; background-size:100%; cursor: pointer;}

.evt109527 .section-02 {position:relative; width:100%; height:1009px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub01.jpg) no-repeat 50% 0;}
.evt109527 .section-03 {position:relative; width:100%; height:1059px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub02.jpg) no-repeat 50% 0;}
.evt109527 .section-04 {position:relative; width:100%; height:1059px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub03.jpg) no-repeat 50% 0;}
.evt109527 .section-05 {padding-bottom:182px; background:#7dd1cd;}
.evt109527 .section-06 {position:relative; width:100%; height:2177px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub04.jpg) no-repeat 50% 0;}
.evt109527 .section-07 {position:relative; width:100%; height:1252px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub05.jpg) no-repeat 50% 0;}

.evt109527 .section-02 h2 {position:absolute; left:50%; top:322px; margin-left:-213px;}
.evt109527 .section-03 h2 {position:absolute; left:50%; top:345px; margin-left:-214px;}
.evt109527 .section-04 h2 {position:absolute; left:50%; top:345px; margin-left:-214px;}
.evt109527 .section-02-sub {position:relative; height:4258px; background:#ffcc41;}
.evt109527 .section-03-sub {position:relative; padding:125px 0 160px; background:#ffaaba;}
.evt109527 .section-04-sub {position:relative; padding:125px 0 196px; background:#ff8455;}
.evt109527 .section-02-sub div:nth-child(1) {position:absolute; right:135px; top:127px;}
.evt109527 .section-02-sub div:nth-child(2) {position:absolute; left:24px; top:1918px;}
.evt109527 .section-03-sub div:nth-child(1) {text-align:center; padding-bottom:215px;}
.evt109527 .section-03-sub div:nth-child(2) {text-align:left; padding-left:24px;}
.evt109527 .section-04-sub div:nth-child(1) {text-align:center; padding-bottom:215px;}
.evt109527 .section-04-sub div:nth-child(2) {text-align:center;}
.evt109527 .section-05 h2 {padding:150px 0 72px;}
.evt109527 .section-05 .slide-area {padding-left:390px;}
.evt109527 .section-05 .swiper-slide {padding:0 15px;}
.evt109527 .section-07 .vod {width:1390px; height:782px; position:absolute; left:50%; top:166px; transform: translate(-50%,0);}
.evt109527 .section-07 .vod iframe {width:100%; height:782px;}
.evt109527 .slide-wrap {position:relative; padding-left:390px;}
.evt109527 .slide-wrap .slick-list {height:806px; margin:0 -15px;}
.evt109527 .slide-wrap .slick-slide {/* width:600px!important;  */margin:0 15px;}
.evt109527 .progress {display: block; width: 100%; height: 7px; margin-top:76px; border-radius: 10px; overflow: hidden; background-color: #fff9e6; background-image: linear-gradient(to right, #1aa8a1, #1aa8a1); background-repeat: no-repeat; background-size: 0 100%; transition: background-size .4s ease-in-out;}
.evt109527 .pop-container .link-show01 {position:absolute; left:0; top:352px; width:100%; height:70px;}
.evt109527 .pop-container .link-show02 {position:absolute; left:0; top:427px; width:100%; height:70px;}
.evt109527 .pop-container {position:fixed; left:0; top:0; width:100vw; height:100vh; background-color: rgba(255, 255, 255,0.902); z-index:150;}
.evt109527 .pop-container .pop-inner {position:relative; width:100%; height:100%; padding-top:98px;}
.evt109527 .pop-container .pop-inner a {display:inline-block; width:100%; height:100%;}
.evt109527 .pop-container .pop-inner .btn-close {position:absolute; right:17px; top:9px; width:31px; height:31px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/107214/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
.evt109527 .pop-container .pop-contents {position:relative; width:410px; margin:0 auto;}
@media (min-width:1200px) and (max-width:1500px) {
    .evt109527 .section-01 .slide-area {padding-left:0;}
    .evt109527 .swiper-pagination {transform:translate(-50%,0);}
    .evt109527 .slide-wrap {padding-left:0;}
}
</style>
<script>
$(function(){
    $(".topic > h2").addClass("on");
    $(window).scroll(function(){
        $('.animate').each(function(){
        var y = $(window).scrollTop() + $(window).height() * 1;
        var imgTop = $(this).offset().top;
        if(y > imgTop) {
            $(this).addClass('on');
        }
        });
    });

    var mySwiper = new Swiper(".section-01 .slide-area .swiper-container", {
        autoplay: 1,
        speed: 2500,
        slidesPerView:"auto",
        centeredSlides:true, 
        loop:true,
        pagination:".swiper-pagination"
    });
    $('.swiper-button-next').on('click', function(e){ //오른쪽 네비게이션 버튼 클릭
        e.preventDefault() 
        mySwiper.swipeNext()
    });

    /* slick slider */
    var $slider = $('.story-slider');
    var $progressBar = $('.progress');
    var $progressBarLabel = $( '.slider__label' );
    
    $slider.on('beforeChange', function(event, slick, currentSlide, nextSlide) {   
        var calc = ( (nextSlide) / (slick.slideCount-1) ) * 100;
        
        $progressBar
        .css('background-size', calc + '% 100%')
        .attr('aria-valuenow', calc );
        
        $progressBarLabel.text( calc + '% completed' );
    });
    $slider.slick({
        autoplay : true, // 자동 스크롤 사용 여부
		autoplaySpeed : 2000,
        infinite: true,
        slidesToShow: 2.5,
        slidesToScroll: 1,
        pauseOnHover : false,
        speed:500,
        fade:false,
        cssEase:'linear'
/*         cssEase: 'linear',
        lazyLoad: 'ondemand',
        lazyLoadBuffer: 0, */
    });
    // 팝업 닫기
	$(".evt109527 .btn-close").on("click", function(){
		$(".pop-container").fadeOut();
	});  
});
</script>
<div class="evt109527">
    <div class="topic">
        <h2 class="txt01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_tit01.png" alt="행복을 기다리는 우리에게"></h2>
        <h2 class="txt02"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_tit02.png" alt="디즈니 x 텐바이텐"></h2>
    </div>
    <div class="section-01">
        <h2 class="animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub_txt01.png" alt="텐바이텐 단독 디즈니 맨살트렁크"></h2>
        <!-- 롤링 영역 -->
        <div class="slide-area">
            <div class="swiper-container">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_slide01_01.jpg" alt="slide01">
                        <span class="line"></span>
                    </div>
                    <div class="swiper-slide">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_slide01_02.jpg" alt="slide02">
                        <span class="line"></span>
                    </div>
                    <div class="swiper-slide">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_slide01_03.jpg" alt="slide03">
                        <span class="line"></span>
                    </div>
                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination"></div>
                <!-- Add Arrows -->
                <div class="swiper-button-next"></div>
            </div>
        </div>
    </div>
    <div class="section-02">
        <h2 class="animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub_txt02.png" alt="디즈니x텐바이텐 pooh"></h2>
    </div>
    <div class="section-02-sub">
        <div class="animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub01_txt01.png" alt=""></div>
        <div class="animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub01_txt02.png" alt=""></div>
    </div>
    <div class="section-03">
        <h2 class="animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub_txt03.png" alt="디즈니x텐바이텐 piglet"></h2>
    </div>
    <div class="section-03-sub">
        <div class="animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub02_txt01.png" alt=""></div>
        <div class="animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub02_txt02.png" alt=""></div>
    </div>
    <div class="section-04">
        <h2 class="animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub_txt04.png" alt="디즈니x텐바이텐 tigger"></h2>
    </div>
    <div class="section-04-sub">
        <div class="animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub03_txt01.png" alt=""></div>
        <div class="animate"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub03_txt02.png" alt=""></div>
    </div>
    <div class="section-05">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_sub_txt05.png" alt="디즈니 맨살트렁크 with 나른 이렇게 달라요!"></h2>
        <!-- 롤링 영역 -->
        <div class="slide-wrap">
            <div class="story-slider">
                <div class="slide-item">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_slide02_01.png" alt="slide 01">
                </div>
                <div class="slide-item">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_slide02_02.png" alt="slide 02">
                    </div>
                <div class="slide-item">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_slide02_03.png" alt="slide 03">
                </div>
                <div class="slide-item">
                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/img_slide02_04.png" alt="slide 03">
                </div>
            </div>
            <div class="progress" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                <span class="slider__label sr-only" style="display:none;"></span>
            </div>
        </div>
    </div>
    <div class="section-06"></div>
    <div class="section-07">
        <div class="vod">
            <div class="">
                <iframe src="https://www.youtube.com/embed/cKOy53kKtdk?;playlist=cKOy53kKtdk&amp;loop=1" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>
            </div>
        </div>
    </div>
    <!-- 팝업 - 라이브안내 -->
    <% If currentDate >= #04/18/2021 18:00:00# and currentDate < #04/19/2021 00:00:00# Then %>
    <div class="pop-container">
        <div class="pop-inner">
            <div class="pop-contents">
                <img src="//webimage.10x10.co.kr/fixevent/event/2021/109527/pop_live.jpg" alt="라이브 쇼핑 안내">
                <!-- 깜짝 선물 미리보기 -->
                <div class="link-show01">
                    <a href="https://shoppinglive.naver.com/livebridge/111439" target="_blank"></a>
                </div>
                <!-- 바로 보러가기 -->
                <div class="link-show02">
                    <a href="https://view.shoppinglive.naver.com/lives/111439" target="_blank"></a>
                </div>
                <button type="button" class="btn-close">닫기</button>
            </div>
        </div>
    </div>
    <% end if %>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->