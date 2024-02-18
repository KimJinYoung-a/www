<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 4월 정기세일 - 앗싸! 에어팟2 득템 게이트 페이지
' History : 2019-03-29 이종화
'####################################################
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<style type="text/css">
.relay {position:relative;}
.relay button { background:none; outline:none;}
.relay .inner {width:1140px; margin:auto;}
.relay .topic {position:relative; background-color:#4aeb9f; border-bottom:9px solid ##d73e2e; border-bottom:9px solid #d73e2e;}
.relay .topic:after {content:''; position:absolute; bottom:-9px;display:block; width:30000px; height:580px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/m/bg_top.png?v=1.01); background-size:auto 100%; animation:emoticon 140s infinite linear;}/**/
.relay .topic div {position:absolute; bottom:-110px; left:50%; width:480px; height:292px; padding-top:7px; margin-left:-240px; z-index:999;}
.relay .topic div button {position:absolute; top:10px; left:0; animation:bounce .7s infinite;}
.relay .topic div dl {position:absolute; top:0; left:0; transform:scale(0); transition:.2s; transform-origin:30px 30px; animation-timing-function:cubic-beziercubic-bezier(0.68, -0.55, 0.27, 1.55);}
.relay .topic div dl.on {transform:scale(1);}
.relay .topic div dl dt {position:absolute; top:0; right:0; width:70px; height:70px; text-indent:-9999px; cursor:pointer; }
.relay .conts {position:relative; background-color:#fefb8a;}
.relay .slide-area {position:absolute; top:370px; left:50%; width:370px; height:350px; margin-left:-455px;}
.relay .slick-slide {display:block; float:left; height:100%; outline:none;}
.relay .slide-area > button {position:absolute; top:43%;}
.relay .slide-area button.btn-prev {left:18px;}
.relay .slide-area button.btn-next {right:18px; transform:rotate(180deg)}
.relay .slick-dots {position:absolute; bottom:10px; width:100%; z-index:999;}
.relay .slick-dots li {display:inline-block;}
.relay .slick-dots li {width:8px; height:8px; margin:0 4px; border-radius:50%; background-color:#fff; text-indent:-9999px; opacity:.5;}
.relay .slick-dots li.slick-active {opacity:1;}
.relay .notice {padding:60px 0; background-color:#224567; color:#fff;  text-align:left;}
.relay .notice h3 {display:inline-block; vertical-align:80px;}
.relay .notice ul {display:inline-block;}
.relay .notice li {margin-bottom:8px; color:#fff; line-height:1.8; text-align:left; opacity:.9; }
.relay .notice li b {display:block; font-weight:normal; opacity:.6;}
.relay .notice li:before {content:'·';display:inline-block; width:8px; margin-left:-8px; font-weight:bold;}
@keyframes emoticon {
	from {transform:translateX(0);}
	to {transform:translateX(-50%);}
}
@keyframes bounce {
	from to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(-10px); animation-timing-function:ease-in;}
}
</style>
<script style="text/javascript">
$(function(){
    $('.topic .btn1').click(function(){
		$('.topic dl').toggleClass('on')
    })
	$('.slide1').slick({
		fade:true,
		dots:true,
		nextArrow:'.btn-next',
		prevArrow:'.btn-prev'
	});
})
</script>
<div class="evt93475 relay">
    <div class="topic">
        <h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/img_top.jpg" alt="앗싸~ 에어팟2 득템!"></h2>
        <div>
            <img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/img_prd.png" alt="에어팟2">
            <button class="btn1"><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/btn_airpot.png" alt="에어팟2?"></button>
            <dl>
                <dt class="btn1">close</dt>
                <dd><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/img_layer_airpot.png" alt="당첨되신 분들께 드릴 예정입니다."></dd>
            </dl>
        </div>
    </div>
    <div class="conts">
        <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/img_guide.jpg" alt="본 이벤트는 모바일/앱에서만 응모 가능합니다"></p>
        <div class="slide-area">
            <div class="slide1">
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/img_slide_01.jpg" alt=""></p>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/img_slide_02.jpg" alt=""></p>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/img_slide_03.jpg" alt=""></p>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/img_slide_04.jpg" alt=""></p>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/img_slide_05.jpg" alt=""></p>
                <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/img_slide_06.jpg" alt=""></p>
            </div>
            <button class="btn-prev">
                <svg  xmlns="http://www.w3.org/2000/svg"  xmlns:xlink="http://www.w3.org/1999/xlink"  width="20.5px" height="34.5px"> <path fill-rule="evenodd"  stroke="rgb(255, 255, 255)" stroke-width="3px" stroke-linecap="butt" stroke-linejoin="miter" fill="none"  d="M14.672,30.642 L3.358,19.328 C1.796,17.766 1.796,15.234 3.358,13.672 L14.672,2.358 "/> </svg>
            </button>
            <button class="btn-next">
                <svg  xmlns="http://www.w3.org/2000/svg"  xmlns:xlink="http://www.w3.org/1999/xlink"  width="20.5px" height="34.5px"> <path fill-rule="evenodd"  stroke="rgb(255, 255, 255)" stroke-width="3px" stroke-linecap="butt" stroke-linejoin="miter" fill="none"  d="M14.672,30.642 L3.358,19.328 C1.796,17.766 1.796,15.234 3.358,13.672 L14.672,2.358 "/> </svg>
            </button>
        </div>
    </div>
    <div class="notice">
        <div class="inner">
            <h3><img src="//webimage.10x10.co.kr/fixevent/event/2019/salabal/relay/tit_notice.jpg" alt="유의사항"></h3>
            <ul>
                <li>본 이벤트는 텐바이텐 회원만 참여할 수 있습니다.</li>
                <li>본 이벤트의 당첨자는 텐바이텐에서 캐릭터 이미지를 다운 받아서 SNS업로드한 고객 중에서 추첨할 예정입니다. <br>참여방법을 꼭 지켜주세요!</li>
                <li>당첨되신 50분께는 세무 신고에 필요한 개인 정보를 요청할 수 있습니다. <b>(제세공과금은 텐바이텐이 부담합니다.)</b></li>
                <li>당첨자는 4월 22일(월) 6PM에 이벤트 페이지 및 공지사항에 발표될 예정입니다.</li>
            </ul>
        </div>
    </div>
</div>