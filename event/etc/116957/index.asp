<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<%
'####################################################
' Description :
' History :
'####################################################
%>
<style>
.evt116957 {max-width:1920px; margin:0 auto; background:#fff;}
.evt116957 .txt-hidden {font-size:0; text-indent:-9999px;}
.evt116957 .conts {position:relative; width:1140px; height:100%; margin:0 auto;}
.evt116957 .conts .section {position:relative;}
.evt116957 .topic {width:100%; height:904px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/116957/bg_main.jpg?v=2)no-repeat 50% 0; overflow:hidden;}
.evt116957 .topic h2 {position:absolute; left:50px; top:215px; opacity:0; transform: translateY(-1.5rem); transition:1s .3s;}
.evt116957 .topic .tit {position:absolute; right:-50px; top:-7px; opacity:0; transform: translateY(-1.5rem); transition:1s;}
.evt116957 .topic .tag {position:absolute; right:430px; top:200px; animation:updown linear 0.8s 1.1s infinite alternate; z-index:5;}
.evt116957 .topic h2.on {opacity:1; transform: translateY(0);}
.evt116957 .topic .tit.on {opacity:1; transform: translateY(0);}
.evt116957 .tab-list {position:relative; width:1140px; margin:0 auto; display:flex; background:#fff; z-index:10;}
.evt116957 .tab-list div {position:relative; width:33.3%; text-align:center;}
.evt116957 .tab-list a {display:inline-block; width:100%; padding:23px 0; font-size:23px; color:#acacac; font-weight:700; text-decoration:none;}
.evt116957 .tab-list a.on,
.evt116957 .tab-list a.first_on {color:#e2508e;}
.evt116957 .tab-list .on::before,
.evt116957 .tab-list .first_on::before {content:""; width:100%; height:4px; background:#e2508e; position:absolute; left:0; bottom:0;}
.evt116957 .tab-list.fixed {position:fixed; left:50%; top:0; margin-left:-570px;}
.evt116957 .tab-list.hides {display:none;}
.evt116957 .tab-list::before {content:''; position:absolute; left:-390px; top:0; width:390px; height:82.8px; background:#fff;}
.evt116957 .tab-list::after {content:''; position:absolute; right:-390px; top:0; width:390px; height:82.8px; background:#fff;}
.evt116957 .benefit-area .bg-01 {width:100%; height:100%; background:url(//webimage.10x10.co.kr/fixevent/event/2021/116957/bg_sub01.jpg) no-repeat 50% 0;}
.evt116957 .benefit-area .bg-02 {width:100%; height:100%; background:url(//webimage.10x10.co.kr/fixevent/event/2021/116957/bg_sub02.jpg) no-repeat 50% 0;}
.evt116957 .benefit-area .btn-cupon {position:absolute; left:50%; bottom:32%; margin-left:67px; width:426px; height:100px; background:#f2428d; color:#fff; font-size:28px; font-weight:700; border-radius:3rem;}
.evt116957 .benefit-area .btn-cupon.disabled {color:#fff; background:#797979; cursor:auto; pointer-events:none;}
.evt116957 .benefit-area .btn-pick {position:absolute; left:58px; top:421px; width:423px; height:100px; background:transparent;}
.evt116957 .benefit-area .btn-point {position:absolute; left:117px; top:535px; width:436px; height:93px; font-size:28px; color:#fff; background:#16aaef; font-weight:700;}
.evt116957 .benefit-area .btn-point.wish {left:587px; top:535px;}
.evt116957 .benefit-area .btn-point.disabled {background:#797979; cursor:auto; pointer-events:none;}
.evt116957 .benefit-area .btn-pop {position:absolute; right:117px; top:305px; width:4rem; height:4rem; background:transparent;}
.evt116957 .pick .item01 {position:absolute; right:330px; top:190px; animation:updown linear 1s 1.1s infinite alternate;}
.evt116957 .pick .item02 {position:absolute; right:63px; top:255px; animation:updown linear 1s infinite alternate;}
.evt116957 .pick .item03 {position:absolute; right:409px; top:423px; animation:updown linear 1s 1.3s infinite alternate;}
.evt116957 .pick .item04 {position:absolute; right:120px; top:470px; animation:updown linear 1s 1.2s infinite alternate;}
.evt116957 .brand-area {position:relative; width:100%; height:2401px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/116957/brand_list.jpg?v=2.2) no-repeat 50% 0;}
.evt116957 .brand-area .b-list {position:absolute; left:50%; top:350px; width:1140px; transform: translate(-50%,0);}
.evt116957 .brand-area .b-list ul {display:flex; align-items:flex-start; justify-content:center; flex-wrap:wrap;}
.evt116957 .brand-area .b-list li {width:530px; height:223px; margin-bottom:18px;}
.evt116957 .brand-area .b-list li a {display:inline-block; width:100%; height:100%;}
.evt116957 .pop {position:fixed; left:50%; top:50%; width:916px; height:auto; transform:translate(-50%,-50%); z-index:110;}
.evt116957 .pop .btn-close {width:3rem; height:3rem; position:absolute; right:26px; top:22px; background:transparent;}
.evt116957 .pop .link-best {width:100%; height:15rem; position:absolute; left:0; bottom:0;}
.evt116957 .dim {position:fixed; left:0; top:0; width:100vw; height:100vh; background-color: rgb(0, 0, 0, 0.502); z-index:109;}
/* 2022-02-24 추가 */
.evt116957 .topic .ch-day {width:146px; height:159px; position:absolute; right:430px; top:200px; animation:updown linear 0.8s 1.1s infinite alternate; z-index:5;}
.evt116957 .topic .ch-day .count {position:absolute; right:31px; top:58px; font-size:47px; color:#fff772; font-weight:700;}
/* // */
@keyframes updown {
    0% {transform: translateY(0rem);}
    100% {transform: translateY(1rem);}
}
</style>
<script>
    let isUserLoginOK = false;
    <% IF IsUserLoginOK THEN %>
        isUserLoginOK = true;
    <% END IF %>
$(function() {
	$('.topic h2,.topic .tit').addClass('on');
    var doScroll;
    // 스크롤시에 사용자가 스크롤했다는 것을 알림
    $(window).scroll(function(event){
        doScroll = true;
    }); // hasScrolled()를 실행하고 doScroll 상태를 재설정
    setInterval(function() {
        if (doScroll)
        { hasScrolled(); doScroll = false; }
    }, 250);

    function hasScrolled() { // 동작을 구현
        var lastScrollTop = 0;
        var tabBenefitStart = $('.tab-start').offset().top - 53; // 동작의 구현이 시작되는 위치
        var tabBenefitEnd = $('.tab-end').offset().top; // 동작의 구현이 끝나는 위치
        var tabRemove = $('#tab01').offset().top;
        var tabRemoveFirst = $('#tab02').offset().top;
        var header = $('#header').height(); // 영향을 받을 요소를 선택

        // 접근하기 쉽게 현재 스크롤의 위치를 저장한다.
        var st = $(this).scrollTop();

        if (st > tabBenefitStart){
            $('.tab-list').addClass('fixed').css('top',header);
            $('.tab-list .tab1 a').removeClass('first_on');
        } else {
            $('.tab-list').removeClass('fixed');
            $('.tab-list .tab1 a').addClass('first_on');
        }

        if (st <= tabRemove) {
            $('.tab-list .tab1 a').addClass('first_on');
        }

        if (st >= tabRemoveFirst) {
            $('.tab-list .tab1 a').removeClass('first_on');
        }

        if(st > tabBenefitEnd){
            $('.tab-list').addClass('hides');
        }else {
            $('.tab-list').removeClass('hides');
        }

        //스크롤시 특정위치서 탭 활성화
        var scrollPos = $(document).scrollTop();
        $('.tab-list a').each(function () {
            var currLink = $(this);
            var refElement = $(currLink.attr("href"));
            if (refElement.position().top <= scrollPos && refElement.position().top + refElement.height() >= scrollPos) {
                $('.tab-list a').removeClass("on");

                currLink.addClass("on");
            }
            else{
                currLink.removeClass("on");
            }
        });

    }
    // 탭 클릭시 활성화
    $('.tab-list a').on('click',function(){
        if($(this).hasClass('on')) {
            $('.tab-list a').removeClass('on')
        } else {
            $('.tab-list a').removeClass('on')
            $(this).addClass('on')
        }
    });
});
</script>
<div id="app"></div>

<script type="text/javascript" src="/lib/js/jquery-1.7.1.min.js" ></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/7.10.4/polyfill.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/es6-promise@4/dist/es6-promise.auto.min.js"></script>

<% IF application("Svr_Info") = "Dev" THEN %>
    <script src="/vue/vue_dev.js"></script>
<% Else %>
    <script src="/vue/2.5/vue.min.js"></script>
<% End If %>
<script src="/vue/vue.lazyimg.min.js"></script>
<script src="/vue/vuex.min.js"></script>

<!-- Common Component -->
<script src="/vue/components/common/functions/common.js?v=1.00"></script>
<!-- //Common Component -->

<!--<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>-->
<!--<script type="text/javascript" src="/event/lib/countdown.js"></script>-->

<script src="/vue/event/etc/116957/index.js?v=1.1"></script>