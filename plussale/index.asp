<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/offshop/inc/offshopCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/offshopcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<%
'##################################################
' PageName : 플러스 세일 안내
' History : 2022.10.06 정태훈
'##################################################
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.plusSale {width:1140px; margin:0 auto; padding:0;}
.plusSale .section01,
.plusSale .section02,
.plusSale .section03{position:relative;}
.plusSale .img-float01 {position:absolute; right:120px; top:230px; animation: updown 1s alternate infinite ease-in-out;}
.plusSale .link-sale {position:absolute; right:5px; top:30px; width:165px; height:148px;}
.plusSale .link-sale img {width:100%;}
.plusSale .vod {position:absolute; right:120px; top:160px; width:370px; height:660px;}
.plusSale .vod video {width:100%; height:100%;}
.plusSale .swiper {position:absolute; left:65px; top:0; width:409px; padding:0 60px; overflow: hidden;}
.plusSale .swiper::before {content:""; position:absolute; left:0; top:0; display:inline-block; width:60px; height:409px; background:#3d6af0; z-index:5;}
.plusSale .swiper::after {content:""; position:absolute; right:0; top:0; display:inline-block; width:60px; height:409px; background:#3d6af0; z-index:5;}
.plusSale .swiper .swiper-wrapper {display:flex;}
.plusSale .swiper-button-next {position:absolute; right:15px; top:158px; width:22px; height:50px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/plusSale/icon_arrow.png) no-repeat 0 0; z-index:10; cursor: pointer;}
.plusSale .swiper-button-prev {position:absolute; left:15px; top:158px; width:22px; height:50px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/plusSale/icon_arrow.png) no-repeat 0 0; transform:rotate(180deg); z-index:10; cursor: pointer;}
.plusSale .link-app {position:absolute; right:124px; top:319px; display:inline-block; width:350px; height:90px; text-indent:-9999px; font-size:0;}
@keyframes updown {
    0% {transform:translateY(-1rem);}
    100% {transform:translateY(1rem);}
}
@keyframes swing {
    0% {transform:translateX(-0.5rem);}
    100% {transform:translateX(0.5rem);}
}

</style>
<script src="https://unpkg.com/swiper@7/swiper-bundle.min.js"></script>
<script>
    $(function() {
        var swiper = new Swiper(".swiper", {
            autoplay:true,
            speed: 1000,
            loop: true,
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
        });
    });
</script>
</head>
<body>
    <!-- #include virtual="/lib/inc/incHeader.asp" -->
        <div class="eventContV15">
            <!-- event area(이미지만 등록될때 / 수작업일때) -->
            <div class="contF">
                <div class="plusSale">
                    <section class="section01">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/img_main.jpg" alt="플러스 세일">
                        <div class="img-float01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/img_limite02.png" alt="한정 수량"></div>
                        <% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
                        <a href="https://www.10x10.co.kr/event/21th/index.asp?tabType=benefit" class="link-sale"><img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/m/badge_year2023_red.png?v=1.3" alt="주년 엠블럼"></a>
                        <% end if %>
                    </section>
                        <section class="section02">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/img_sub01.jpg?v=1.1" alt="21주년 기념 텀블러">
                        <div class="vod">
                            <video preload="auto" autoplay="true" loop="loop" muted="muted" volume="0" width="100%" controls>
                                <source src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/cheerup_1007.mp4" type="video/mp4">
                            </video>
                        </div>
                    </section>
                    <section class="section03">
                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/img_sub02.jpg" alt="오직! 앱에서만 구매 가능한 텀블러에요!">
                        <div class="swiper">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/img_slide01.png" alt=""></div>
                                <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/img_slide02.png" alt=""></div>
                                <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/img_slide03.png" alt=""></div>
                                <div class="swiper-slide"><img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/img_slide04.png" alt=""></div>
                            </div>
                            <div class="swiper-button-prev"></div>
                            <div class="swiper-button-next"></div>
                        </div>
                        <a href="https://www.10x10.co.kr/event/appdown/" class="link-app">앱 설치하고 확인하기</a>
                    </section>
                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/plusSale/noti.jpg?v=1.2" alt="유의사항">
                </div>
            </div>
            <!-- //event area(이미지만 등록될때 / 수작업일때) -->
        </div>
    <!-- #include virtual="/lib/inc/incFooter.asp" -->
</body>
<!-- #include virtual="/lib/db/dbclose.asp" -->