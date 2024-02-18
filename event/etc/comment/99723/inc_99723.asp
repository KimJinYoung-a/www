<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 오뚜기
' History : 2019-12-30
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim evtStartDate, evtEndDate, currentDate 
dim debugMode
debugMode = request("debugMode")

dim eCode
'test
'currentDate = Cdate("2019-12-31")

IF application("Svr_Info") = "Dev" THEN
	eCode   =  90453
Else
	eCode   =  99723
End If
%>
<style>
.evt99723 {background-color:#fff;}
.prj {background-color:#fff100;}
.top {height:876px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/99723/bg_top.jpg) 50% 0;}
.top h2 {position:absolute; top:505px; left:50%; width:600px; height:215px; margin-left:-570px; text-align:left;}
.top h2 .t {display:inline-block; animation:fadeInX both .7s .3s 1;}
.top h2 .t2 {margin:30px 0 20px; animation-delay:.5s;}
.top h2 .t3 {animation-delay:.7s;}
@keyframes fadeInX {
    0% {transform:translateX(-50px); opacity:0;}
    100% {transform:translateX(0); opacity:1;}
}
.section {position:relative; width:1140px; margin:0 auto;}
.sc1 {height:640px; padding-top:55px; text-align:left;}
.sc1:before {display:inline-block; position:absolute; top:85px; left:50%; width:27px; height:392px; margin-left:-895px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/99723/bg_sc1.png) no-repeat 50% 50%; content:'';}
.sc1 p {margin-top:55px;}
.sc2 {padding-top:140px; text-align:left;}
.sc2:before {position:absolute; top:0; left:50%; width:1920px; height:380px; margin-left:-960px; background-color:#fff100; content:'';}
.sc2 h3 {position:absolute; top:62px; left:50%; z-index:10; margin-left:220px;}
.sc2 .vod {position:relative; z-index:5;}
.sc2 .composition {position:relative; height:950px; margin-top:130px; padding-bottom:95px;}
.sc2 .composition .limited {position:absolute; top:330px; left:185px; z-index:10; animation:bounce .8s 500 both;}
@keyframes bounce {
    from, to {transform:translateY(0rem); animation-timing-function:ease-in;}
    50% {transform:translateY(0.8rem); animation-timing-function:ease-out;}
}
.sc2 .composition ul {position:relative; z-index:10; width:194px; margin-top:36px; margin-bottom:40px;}
.sc2 .composition ul li {width:194px; height:25px; margin-bottom:20px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/99723/txt_comp.png); background-position:0 0; text-indent:-999em;}
.sc2 .composition ul li:nth-child(2) {background-position-y:-44px; transition-delay:.3s;}
.sc2 .composition ul li:nth-child(3) {background-position-y:-88px; transition-delay:.5s;}
.sc2 .composition ul li:nth-child(4) {background-position-y:-132px;  transition-delay:.7s;}
.sc2 .composition ul li:nth-child(5) {background-position-y:100%;  transition-delay:.9s;}
.sc2 .composition:before {position:absolute; top:25px; left:50%; width:1920px; height:968px; margin-left:-960px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/99723/bg_sc2_v2.png) no-repeat 50% 50%; content:'';}
/*.sc2 .composition:after {position:absolute; bottom:0; left:50%; width:1631px; height:4px; margin-left:-678px; background-color:#f22728; content:'';}*/
.sc2 .composition img {position:relative; z-index:5;}
.sc2 .composition a {display:inline-block; position:relative;}
.sc2 .composition a:after, .sc4 a:after {display:inline-block; position:absolute; top:50%; right:46px; z-index:10; width:10px; height:18px; margin-top:-9px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/99723/ico_get.png); background-size:100%; content:''; animation:moveX .8s 500 ease-in-out;}
@keyframes moveX {
    from, to {transform:translateX(0);}
    50%{transform:translateX(5px);}
}
.sc3 h3 {position:absolute; top:100px; left:0;}
.sc3 > p {position:relative; padding-left:380px;}
.sc3 > p:after {position:absolute; top:245px; left:772px; width:404px; height:103px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/99723/img_gift.png) no-repeat 0 0; content:'';}
.sc3 .gallery {position:relative; height:640px;}
.sc3 .gallery .txt {position:absolute; top:85px; left:50%; z-index:5; margin-left:-570px;}
.sc3 .gallery .thumb {position:absolute; top:0; left:50%; width:1920px; height:640px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/99723/img_gallery.jpg); background-position:0 0; margin-left:-960px; animation:slide 45s 10;}
@keyframes slide {
0% {background-position:0 0;}
100% {background-position:-3400px 0;}
}
.sc4 {height:634px; margin-top:120px; margin-bottom:110px; text-align:left;}
.sc4 h3 {margin-top:45px;}
.sc4 .slider {position:absolute; top:0; left:50%; width:1140px; height:634px; margin-left:-570px; text-align:right;}
.sc4 .slider .txt {position:absolute; top:340px; left:0;}
.sc4 .slider .thumb {display:inline-block; width:613px; height:634px;}
.sc4 a {position:absolute; top:490px; left:0;}
.sc4 .slider .slick-arrow {top:50%; width:60px; height:60px; margin-top:-30px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/99723/btn_prev1.png);}
.sc4 .slider .slick-prev {left:532px;}
.sc4 .slider .slick-next {right:0; transform:rotate(180deg);}
.sc4 .slider .slick-dots {position:absolute; top:293px; left:0; width:auto;}
.sc4 .slider .slick-dots li {display:none; position:relative; color:#f22728; font-size:16px; font-weight:bold;}
.sc4 .slider .slick-dots li.slick-active {display:block;}
.sc4 .slider .slick-dots li b {display:inline-block; padding-left:16px;}
.sc4 .slider .slick-dots li:after {content:' '; display:inline-block; position:absolute; top:6px; left:48%; width:2px; height:13px; background-color:#f22728; transform:rotate(30deg);}
.slider2 {width:1920px; margin:0 auto 153px;}
.slider2 .slick-arrow {top:0; width:390px; height:680px; background:rgba(0,0,0,0.5);}
.slider2 .slick-prev {left:0;}
.slider2 .slick-next {right:0;}
.slider2 .slick-dots {position:absolute; bottom:-32px; height:12px;}
.slider2 .slick-dots li {width:8px; height:8px; margin:0 7px; border-radius:50%; border:solid 2px #f22728; cursor:pointer;}
.slider2 .slick-dots li.slick-active {background-color:#f22728;}
.sc5 {width:auto; height:1000px; background:#f22728 url(//webimage.10x10.co.kr/fixevent/event/2019/99723/bg_sc5.jpg) no-repeat 50% 100%;}
.sc5 h3 {padding-top:62px;}
.cmt-section {position:relative; width:1140px; margin:0 auto; padding:70px 0 45px; color:#000;}
.cmt-section .tit {position:absolute; top:105px; left:50%; margin-left:-570px;}
.cmt-section .cmt-box {position:relative; width:650px; padding-left:490px;}
.cmt-section .preview {position:absolute; top:36px; left:228px; width:233px; height:360px; padding:0 30px 0 40px; background-color:#fff100; font-size:28px; font-weight:bold; line-height:1; text-align:right;}
.cmt-section .preview .writer {display:block; margin-top:70px; font-size:18px; text-align:left;}
.cmt-section .preview .word {display:inline-block; width:180px; margin-top:150px; border-bottom:solid 4px #000; line-height:1.3;}
.cmt-section .preview p {margin-top:15px;}
.cmt-section .select-group {padding-bottom:60px; border:solid 4px #fff100;}
.cmt-section .select-list {display:flex; justify-content:space-between; flex-wrap:wrap; height:240px; margin:65px 120px 0;}
.cmt-section .select-list li {height:30px; flex-basis:33.33%; text-align:left; font-size:20px; font-weight:bold;}
.cmt-section .select-list li:nth-child(10) {flex-basis:100%;}
.cmt-section .select-list li input[type="radio"] {display:none;}
.cmt-section .select-list li input + label {display:inline-block; height:100%; padding-left:40px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/99723/ico_select.png); background-position:0 0; background-size:30px; background-repeat:no-repeat;}
.cmt-section .select-list li input:checked + label {background-position:0 100%;}
.cmt-section .select-list #own-word {position:relative; top:-6px; height:30px; margin-left:16px; border-bottom:solid 2px #000; font-size:16px; background-color:transparent;}
.cmt-section .select-list #own-word::-webkit-input-placeholder {color:#777; font-weight:bold;}
.cmt-section .select-list #own-word:focus::-webkit-input-placeholder {opacity:0;}
.cmt-section .select-list #own-word::-ms-clear {display:none;}
.cmt-section .select-group .btn-submit {display:inline-block; margin-left:50px; animation:moveX .8s 500 ease-in-out;}
.cmt-list-wrap {position:relative; margin-top:60px;}
.cmt-list-wrap .ranking {position:absolute; top:0; left:50%; width:1300px; height:160px; margin-left:-650px; background-color:#f22728;}
.cmt-list-wrap .ranking p {position:absolute; top:40px; left:80px;}
.cmt-list-wrap .ranking ul {display:flex; justify-content:space-between; position:absolute; top:38px; left:370px; width:750px; color:#fff; font-size:20px; font-weight:bold;}
.cmt-list-wrap .cmt-list {position:relative; z-index:10; display:flex; flex-wrap:wrap; width:1200px; margin:0 -15px; padding-top:112px;}
.cmt-list-wrap .cmt-list li {position:relative; flex-basis:190px; padding:0 30px 42px; margin:0 15px 20px; background-color:#fff100; font-size:24px; font-weight:bold; text-align:left; line-height:1;}
.cmt-list-wrap .cmt-list .num {display:block; color:#f22728; font-size:19px; margin-top:32px;}
.cmt-list-wrap .cmt-list .writer {display:inline-block; margin:21px 0 63px; font-size:20px;}
.cmt-list-wrap .cmt-list .word {display:inline-block; margin-bottom:13px;}
.cmt-list-wrap .cmt-list .btn-delete {position:absolute; top:25px; right:30px; background-color:transparent; color:#f22728; font-size:16px; font-weight:500;}
.cmt-section .paging {height:40px; margin-top:40px;}
.cmt-section .paging a {width:40px; height:40px; margin:0 12px; font-weight:bold; font-size:14px; line-height:40px; border:0; background-color:transparent;}
.cmt-section .paging a span {width:40px; height:40px; padding:0; color:#000;}
.cmt-section .paging .arrow {background-color:transparent;}
.cmt-section .paging .arrow span {width:40px;height:40px; padding:0; text-indent:-999em; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/btn_prev.png); background-position:0 0;}
.cmt-section .paging .next span {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/97971/btn_next.png);}
.cmt-section .paging a.current {background-color:#fff100; border:0; border-radius:50%; color:#000; font-weight:bold;}
.cmt-section .paging a.current span {color:#000;}
.cmt-section .paging a.current:hover {background-color:#fff100;}
.cmt-section .paging a.arrow.first,
.cmt-section .paging a.arrow.end {display:none;}
.cmt-section .paging a:hover {background-color:transparent;}
.noti {position:relative; padding:58px 0; background-color:#000; color:#fff;}
.noti h4 {position:absolute; top:60px; left:50%; margin-left:-570px; color:#fff; font-size:24px;}
.noti  ul {width:1140px; margin:0 auto; padding-left:165px; text-align:left; box-sizing:border-box;}
.noti  ul li {font-size:17px; line-height:1.6;}
.evt99723 .fr-left {transform:translateX(-80%);}
.evt99723 .fr-right {transform:translateX(80%);}
.evt99723 .fr-bottom {transform:translateY(80%);}
.evt99723 .animove {opacity:0; transition-duration:1s;}
.evt99723 .animove.on {transform:translate(0,0); opacity:1;}
</style>
<script>
$(function(){
	$('.evt99723 h3').addClass('animove');
	$('.evt99723 .composition li').addClass('animove fr-bottom');
	$(window).scroll(function() {
        var st=$(this).scrollTop();
        var winH=window.innerHeight;
        $('.animove').each(function(){
            var innerH=$(this).innerHeight()
            var ofs=$(this).offset().top;
            if(st > ofs - winH && ofs + winH > st){$(this).addClass('on')}	// ofs + innerH 또는 ofs + winH
            else{$(this).removeClass('on')}
        })
    })

	$('.slider').slick({
		autoplay: true,
		fade:true,
		dots: true,
		customPaging:function(slider, i) {
			return (i+1) + '<b>' + slider.slideCount + '</b>';
		}
	});

	$('.slider2').slick({
		autoplay: true,
		autoplaySpeed: 2500,
		speed: 1500,
        dots:true,
		centerMode: true,
		centerPadding: '0px',
		variableWidth: true
	});
});
</script>
<script type="text/javascript">
	var eventCode = '<%=eCode%>'
</script>
        <div class="evt99723">
            <div class="prj"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/tit_prj.png" alt="Happy Together Project"></div>
            <div class="top">
                <h2>
                    <span class="t t1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/tit_1.png" alt="텐바이텐 X 오뚜기"></span>
                    <span class="t t2"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/tit_2.png" alt="주인공은 나니까"></span>
                    <span class="t t3"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/tit_3.png" alt="화끈하게 살자구요"></span>
                </h2>
            </div>
            <div class="section sc1">
                <h3 class="fr-left"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/tit_sc1.png" alt="01 우리의 이야기"></h3>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/txt_sc1.png" alt="화끈하게 사세요! 주인공은 당신이니까요 : )"></p>
            </div>
            <div class="section sc2">
                <h3 class="fr-right"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/tit_sc2.png" alt="02 화끈팩 구성이 궁금하다면"></h3>
                <div class="vod">
                    <iframe width="988" height="556" src="https://www.youtube.com/embed/bsBGSGl7ywo" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen=""></iframe>
                </div>
                <div class="composition">
                	<h4><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/tit_comp.png" alt="화끈팩 구성"></h4>
                    <ul>
                        <li>화끈팩 박스</li>
                        <li>열라면 5봉</li>
                        <li>열라면 핫팩 5개</li>
                        <li>화끈 스티커팩(6매)</li>
                        <li>화끈 포스터</li>
                    </ul>
                    <a href="/shopping/category_prd.asp?itemid=2605091&pEtr=99723"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/btn_get.png" alt="구매하기"></a>
                    <span class="limited"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/txt_limited.png" alt="한정수량"></span>
                </div>
            </div>
            <div class="section sc3">
                <!--<h3 class="fr-left"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/tit_sc3.png" alt="03 런칭 이벤트"></h3>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/txt_sc3.png" alt="sale 화끈팩 런칭 기념 할인 gift 오뚜기 젓가락 300개"></p>-->
                <div class="gallery">
                    <p class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/txt_gallery.png" alt="깨알같은 디테일"></p>
                    <div class="thumb"></div>
                </div>
            </div>
            <div class="section sc4">
                <h3 class="fr-left"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/tit_sc4.png" alt="화끈팩을 나눠보세요"></h3>
                <div class="slider">
                    <div>
                        <div class="thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/img_slide1_1.jpg" alt=""></div>
                        <span class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/txt_slide1_1.png" alt="살이 찔까봐 먹을까? 말까?"></span>
                    </div>
                    <div>
                        <div class="thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/img_slide1_2.jpg" alt=""></div>
                        <span class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/txt_slide1_2.png" alt="거절 당할 생각에  고백할까? 말까?"></span>
                    </div>
                    <div>
                        <div class="thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/img_slide1_3.jpg" alt=""></div>
                        <span class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/txt_slide1_3.png" alt="카드값 걱정에 살까? 말까?"></span>
                    </div>
                    <div>
                        <div class="thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/img_slide1_4.jpg" alt=""></div>
                        <span class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/txt_slide1_4.png" alt="수 많은 걱정으로 할까? 말까?"></span>
                    </div>
                    <div>
                        <div class="thumb"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/img_slide1_5.jpg" alt=""></div>
                        <span class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/txt_slide1_5.png" alt="화끈팩을 나눠보세요"></span>
                    </div>
                </div>
                <a href="/shopping/category_prd.asp?itemid=2605091&pEtr=99723"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/btn_get2.png" alt="선물하기"></a>
            </div>
            <div class="slider2">
                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/img_slide2_4.jpg" alt=""></div>
                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/img_slide2_2.jpg" alt=""></div>
                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/img_slide2_3.jpg" alt=""></div>
                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/img_slide2_1.jpg" alt=""></div>
                <div><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/img_slide2_5.jpg" alt=""></div>
            </div>
            <div class="section sc5">
                <h3 class="fr-bottom"><img src="//webimage.10x10.co.kr/fixevent/event/2019/99723/tit_sc5.png" alt="화끈다짐하고 100만원 받자"></h3>
            </div>
            <div id="app"></div>
            <div class="noti">
                <h4>유의사항</h4>
                <ul>
                    <li>- 텐바이텐X오뚜기 화끈팩은 로그인 후 구매 가능합니다.</li>
                    <li>- 텐바이텐X오뚜기 화끈팩은 한정 수량 판매로, 조기 품절이 될 수 있습니다.</li>
                    <li>- 오뚜기 젓가랏 사은품은 선착순 구매 완료 300명에게 제공되는 사은품입니다.</li>
                    <li>- 화끈 다짐 응모 이벤트는 당첨 상품은 추첨을 통해 당첨됩니다.</li>
                    <li>- 텐바이텐X오뚜기 화끈팩은 개봉 후 환불이 어려움을 알려드립니다.</li>
                </ul>
            </div>
        </div>
<script src="https://unpkg.com/lodash@4.13.1/lodash.min.js"></script>
<% IF application("Svr_Info") = "Dev" THEN %>
    <script src="/vue/vue_dev.js"></script>
<% Else %>
    <script src="/vue/2.5/vue.min.js"></script>
<% End If %>
<script src="/vue/event/comment/list/comment-paging.js"></script>
<script src="/vue/event/comment/list/comment-container.js"></script>
<script src="/event/etc/comment/99723/index-99723.js"></script>