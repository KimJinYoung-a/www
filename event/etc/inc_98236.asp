<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 독도프렌즈 이벤트
' History : 2019-10-23
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim eCode, event1DayDate, event2DayDate, event3DayDate, currentDate, docdoItem
If application("Svr_Info") = "Dev" then
	eCode = "90418"  
    docdoItem = "145983"
    event1DayDate = cdate("2019-10-22")	'티저페이지 노출
    event2DayDate = cdate("2019-10-23")	'이벤트일 - 스티커 할인판매
    event3DayDate = cdate("2019-10-24")	'스티커 정상구매 노출
Else
	eCode = "98236"
    docdoItem = "2547347"
    event1DayDate = cdate("2019-10-24")	'티저페이지 노출
    event2DayDate = cdate("2019-10-25")	'이벤트일 - 스티커 할인판매
    event3DayDate = cdate("2019-10-26")	'스티커 정상구매 노출
End If
currentDate = date()
%>
<style>
.evt98236 {position: relative; background-color: #f2cb56;}
.evt98236 > div {position: relative;}
.evt98236 .pos {position: absolute; left: 50%; transform: translateX(-50%);}
.evt98236 h2 .pos {top: 80px; animation:bling 1.4s  steps(1) 40;}
.evt98236 .topic {height: 637px; padding-bottom: 20px; background: url(//webimage.10x10.co.kr/fixevent/event/2019/98236/bg.jpg?v=1.01) #56a7d2 repeat-x center top;}
.evt98236 .topic .pos {bottom: 0;}
.evt98236 .topic:after {content: ''; position: absolute; bottom: 0; display: block; width: 100%; height: 20px; background-image: url(//webimage.10x10.co.kr/fixevent/event/2019/98236/wave.png); animation:waves 150s linear infinite;}
.evt98236 .prd-area {padding-bottom: 50px; background-color: #fff;}
.evt98236 .noti {background-color: #3c3c3c;}
@keyframes bling{15%,45% {opacity:0;}30%,60% {opacity: 1;}}
@keyframes waves {from {background-position: 0 50%}	to {background-position: -1000rem 50% }}
</style>

<script type="text/javascript">
$(function () {
    // wide swipe
	var evtSwiper = new Swiper('.wideSwipe .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:3500,
		simulateTouch:false,
		pagination:'.wideSwipe .pagination',
		paginationClickable:true,
		nextButton:'.wideSwipe .btnNext',
		prevButton:'.wideSwipe .btnPrev'
	})
	$('.wideSwipe .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.wideSwipe .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
});

function jsEventLogin(){
	location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
	return;
}

<% If currentDate=event2DayDate then %>
    function goDirOrdItem(){
        <% If Not(IsUserLoginOK) then %>
            jsEventLogin();
        <% Else %>		
            fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>')
            document.directOrd.submit();        
        <% End IF %>
    }
<% End IF %>
</script>       

<% If currentDate=event2DayDate then %>
	<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
		<input type="hidden" name="itemid" value="<%=docdoItem%>">
		<input type="hidden" name="itemoption" value="0000">
		<input type="hidden" name="itemea" value="1">
		<input type="hidden" name="mode" value="DO1">
	</form>
<% End if %>	

<!-- 98236 독도프렌즈 -->
<div class="evt98236">
	<div class="tit-area">
		<% If currentDate<=event1DayDate then %>
			<!-- 날짜별 1024 -->
			<h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/tit.png" alt="독도 프렌즈">
				<span class="pos"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/txt_ani.png" alt="내일 단 하루!"></span>
			</h2>
		<% Elseif currentDate=event2DayDate then %>
			<!-- 날짜별 1025 -->
			<h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/tit.png" alt="독도 프렌즈">
				<span class="pos"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/txt_ani_1025.png" alt="오늘 단 하루!"></span>
			</h2>
		<% Elseif currentDate>=event3DayDate then %>
			<!-- 날짜별 1026 -->
			<h2><img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/tit_1026.png" alt="독도 프렌즈">
			</h2>
		<% End if %>
	</div>
	<div class="topic">
		<% If currentDate<=event2DayDate then %>
			<!-- 날짜별 1024, 1025 -->
			<span class="pos"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/txt.png" alt="10월 25일은 독도의 날이에요!"></span>
		<% Elseif currentDate>=event3DayDate then %>
			<!-- 날짜별 1026 -->
			<span class="pos"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/txt_1026.png" alt="독도는 우리 땅!"></span>
		<% End if %>
	</div>
	<div class="prd-area">
		<span><img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/img_prd.jpg?v=1.02" alt="독도 프렌즈 소개!"></span>
		<div class="btn-area">
			<% If currentDate<=event1DayDate then %>
				<!-- 날짜별 1024 -->
				<img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/btn_1024.jpg" alt="10월 25일에 만나요!">
			<% Elseif currentDate=event2DayDate then %>
				<!-- 날짜별 1025 -->
				<a href="javascript:goDirOrdItem();"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/btn_1025.jpg" alt="구매하러 가기"></a>
			<% Elseif currentDate>=event3DayDate then %>
				<!-- 날짜별 1026 -->
				<a href="/shopping/category_prd.asp?itemid=<%=docdoItem%>&pEtr=<%=eCode%>"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/btn_1026.jpg" alt="구매하러 가기"></a>
			<% End if %>
		</div>
	</div>
	<div class="slideTemplateV15  wideSwipe">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2019/98047/slideimg20191015142947.JPEG" alt=""></div>
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2019/98047/slideimg20191015143828.JPEG" alt=""></div>
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2019/98047/slideimg20191015143625.PNG" alt=""></div>
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2019/98047/slideimg20191015143821.JPEG" alt=""></div>
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2019/98047/slideimg20191015143651.PNG" alt=""></div>
			</div>
			<div class="pagination"></div>
			<button class="slideNav btnPrev">이전</button>
			<button class="slideNav btnNext">다음</button>
			<div class="mask left"></div>
			<div class="mask right"></div>
		</div>
	</div>
	<div class="noti">
		<% If currentDate<=event2DayDate then %>
			<!--날짜별 1024,1025-->
			<span><img src="//webimage.10x10.co.kr/fixevent/event/2019/98236/txt_noti.jpg" alt="유의사항"></span>
		<% End if %>
	</div>
</div>
<!--// 98236 독도프렌즈 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->