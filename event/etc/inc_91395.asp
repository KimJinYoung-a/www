<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  호로요이 이벤트 2차 91395
' History : 2018-11-23 최종원 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/drawevent/DrawEventCls.asp" -->
<%
dim eCode, resultParam, alertMsg, sqlstr, cnt, LoginUserid
dim eventEndDate, currentDate, eventStartDate 
dim alarmBtnImg
dim drawEvt, isParticipation
dim numOfParticipantsPerDay
dim i
dim evtItemCode

IF application("Svr_Info") = "Dev" THEN
	eCode = "90201"	
	evtItemCode = "1198132"
Else
	eCode = "91395"
	evtItemCode = "2191082"
End If

eventStartDate = cdate("2018-12-21")
eventEndDate = cdate("2019-01-16")
currentDate = date()
LoginUserid	= getencLoginUserid()

'테스트 날짜 
'eventStartDate = cdate("2018-12-10")
'eventEndDate = cdate("2018-12-05")

set drawEvt = new DrawEventCls
drawEvt.evtCode = eCode
drawEvt.userid = LoginUserid

isParticipation = drawEvt.isParticipationDayBase()
numOfParticipantsPerDay = drawEvt.getParticipantsPerDay()
%>
<style type="text/css">
.evt91395 {text-align: center;}
.evt91395 div {margin: auto;}
.evt91395 button{border:0 none;border-radius:0;background-color:transparent;cursor:pointer}
.evt91395 button:focus {
    outline: none;
    border: none;}
.evt91395 .top-area {position: relative; padding-bottom: 60px; background: url(http://webimage.10x10.co.kr/fixevent/event/2018/91395/bg_top.png) 0 50%;}
.evt91395 .top-area dl dt,
.evt91395 .top-area dl dd {position: absolute; left: 50%; animation:slowDown 2s ease both; opacity: 1;}
.evt91395 .top-area dl dt {margin-left: -87px; top: 157px; }
.evt91395 .top-area dl dd {margin-left: 3px; top: 266px; animation-delay: .7s;}
.evt91395 .wideSwipe {position: relative;}
.evt91395 .wideSwipe > p {position: absolute; left: 50%; top:35px ; margin-left: 425px; z-index: 999;}
.evt91395 .wideSwipe .swiper-container {height:720px;}
.evt91395 .wideSwipe .swiper-slide img {height:720px;}
.evt91395 .wideSwipe .mask {background-image:none; background-color:rgba(0,0,0,0.77); }
.evt91395 .wideSwipe .pagination {bottom:17px;}
.evt91395 .wideSwipe .pagination span {background:url(http://webimage.10x10.co.kr/eventIMG/2017/83094/btn_slide_pagination.png) no-repeat 100% 0;}
.evt91395 .wideSwipe .pagination .swiper-active-switch {background-position:0 0;}
.evt91395 .wideSwipe .slideNav {top:inherit; top:50%; left: 50%; margin-top:-45px; height:47px; width:24px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/91395/btn_arrow.png) no-repeat 0 0; outline:0;}
.evt91395 .wideSwipe .slideNav.btnNext,
.evt91395 .wideSwipe .slideNav.btnNext:hover {background-position: 0 -100px;}
.evt91395 .wideSwipe .btnPrev:hover {background-position:0 0;}
.evt91395 .wideSwipe .pagination span {background-image: unset; width: 9px; height: 9px; border-radius:50%; margin: 0  10px; background-color: #c9bebe;}
.evt91395 .wideSwipe .pagination .swiper-active-switch {background-color: #241f35 ;}
.evt91395 .sel-area {position: relative; background: url(http://webimage.10x10.co.kr/fixevent/event/2018/91395/bg_sel.png) 0 50%;}
.evt91395 .sel-area > div {position: relative; width: 1039px; height: 664px; margin: auto; padding-bottom: 100px; background: url(http://webimage.10x10.co.kr/fixevent/event/2018/91395/txt_apply.png?v=1.01) no-repeat;}
.evt91395 .sel-area > div button {position: absolute; bottom: 200px; left: 50%; margin-left: -206px;}
.evt91395 .vod-area {position: relative; background: url(http://webimage.10x10.co.kr/fixevent/event/2018/91395/bg_vod.png) 0 50%;}
.evt91395 .vod-area div {padding: 37px 0 94px;}
.evt91395 .noti {background-color: #111115;}
.evt91395 .ml-28 {margin-left: -28px;}
.layer-popup {display:none; position:absolute; left:0; top:0; z-index:9997; width:100%; height:100%;}
.layer-popup .layer {position:absolute; top:155px; left: 50%; width:450px; margin-left : -225px;  min-height: 200px;  background-color: #fff; overflow:hidden; z-index:99999;} 
.layer-popup .layer > div {position: relative;}
.layer-popup .layer > div button {position: absolute; left: 50%; margin-left: -143px; bottom: 203px; outline: 0;}
#lyrSch3.layer-popup .layer > div button {bottom: 65px;}
.layer-popup .layer .btn-close{position: absolute; top:0; right: 0;} 
.layer-popup .mask {display:block; position:absolute; left:0; top:0; z-index:9998; width:100%; height:100%; background:rgba(0,0,0,.5);}
@keyframes slowDown{from{margin-top: -100px; opacity: 0;} }
</style>
<script type="text/javascript" src="/lib/js/tenbytencommon.js?v=1.0"></script>
<script type="text/javascript">
$(function(){
	fnAmplitudeEventMultiPropertiesAction('view_event_91395','','');
	var scrollY = $('.sel-area').offset().top+200
	<% if session("evt91395") <> "" and session("evt91395") <> "0" and isParticipation then %>	
	$('#lyrSch').fadeIn();
	window.parent.$('html,body').animate({scrollTop:scrollY}, 800);
	<% end if %>
        
	/* slide js */
	$("#slide").slidesjs({
		pagination: {active:true, effect:"fade"},
		navigation:false,
		play:{interval:2000, effect:"fade", auto:true},
		effect:{fade: {speed:1000}}
	});

    //wide swipe
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
	});
	$('.wideSwipe .btnPrev').on('click', function(e){
			e.preventDefault();
			evtSwiper.swipePrev();
	});
	$('.wideSwipe .btnNext').on('click', function(e){
			e.preventDefault();
			evtSwiper.swipeNext();
	});

    $('.layer-popup .layer').css({'top':scrollY})
    
	$('.layer-popup .btn-close').click(function(e){
		$('.layer-popup').fadeOut();
        e.preventDefault()
	});
	$('.layer-popup .mask').click(function(){
		$('.layer-popup').fadeOut();
	});

});
</script>
<script type="text/javascript">
function jsEventLogin(){
	if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
		return;
	}
}
function pagedown(){
	window.$('html,body').animate({scrollTop:$("#selArea").offset().top}, 0);
}
function adultCert(){
	<% if (eventStartDate > currentDate or eventEndDate < currentDate) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% else %>		
		<% if isParticipation then %>
			alert("이미 응모 하셨습니다.");
		<% else %>
			confirmAdultAuthCst("성인인증이 필요한 콘텐츠입니다. 성인인증을 하시겠습니까?", "/event/etc/doeventsubscript/doEventSubscript91395.asp");	
		<% end if %>	
	<% end if %>
}
function closePopup(e){
	$('.layer-popup').fadeOut();	
}
function linkToNotice(){
	location.href="/my10x10/myeventmaster.asp";
}
function goDirOrdItem(tm){
<% If IsUserLoginOK() Then %>
	<% If Now() >= #12/19/2018 23:59:59# And Now() < #01/16/2019 23:59:59# Then %>		
		document.directOrd.submit();
	<% else %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% end if %>
<% Else %>
	if(confirm("로그인을 하셔야 응모할 수 있습니다.")){
		top.location.href="/login/loginpage.asp?vType=G";
		return false;
	}
<% End IF %>
}
</script>
						<% if GetLoginUserLevel = "7" then %>
						<div style="color:red">*스태프만 노출</div>						
							<% if isArray(numOfParticipantsPerDay) then 
								 for i=0 to uBound(numOfParticipantsPerDay,2) 
									response.write "<div>"& numOfParticipantsPerDay(0,i) &" : " & numOfParticipantsPerDay(2,i) &" / "& numOfParticipantsPerDay(1,i) &"</div>"																		
								 next 
								end if 
							%>							
						<% end if %>
                        <!-- 91395 호로요이 2차 혼쉼을 부탁해  -->
                        <div class="evt91395">
                            <div class="top-area">
                                <img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/img_top.png?v=1.01" alt="텐바이텐x호로요이">
                                <dl>
                                    <dt><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/txt_tit_01.png" alt="혼쉼을"></dt>
                                    <dd><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/txt_tit_02.png" alt="부탁해"></dd>
                                </dl>
                            </div>
                            <div class="wideSwipe">
                                <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/ico_winner.png" alt="총 당첨자 500명"></p>
                                <div class="swiper-container">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/img_slide_01.png" alt="호로요이 혼술을 부탁해" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/img_slide_02.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/img_slide_03.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/img_slide_04.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/img_slide_05.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/img_slide_06.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/img_slide_07.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/img_slide_08.png" alt="" /></div>
                                    </div>
                                    <div class="pagination"></div>
                                    <button class="slideNav btnPrev">이전</button>
                                    <button class="slideNav btnNext">다음</button>
                                    <div class="mask left"></div>
                                    <div class="mask right"></div>
                                </div>
                            </div>
                            <div class="sel-area">
                                <img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/txt_sel.png" alt="텐바이텐x호로요이">
                                <div>
									<% if isParticipation then %>	
									<button onclick="alert('이미 응모하셨습니다. 내일 또 응모해주세요!');"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/btn_apply_end.png" alt="응모완료"></button>
									<% else %>
									<button id="layerPopupBtn" onclick="adultCert()"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/btn_apply.png" alt="응모하기"></button>									
									<% end if %>
                                </div>
                            </div>
                            <div class="vod-area">
                                <img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/txt_vod.png" alt="오늘 하루는 나를 위한 순간을 만들어보세요. 호로요이 메리해피 혼쉼 패키지와 함께 "오늘은 쉽니다" ">
                                <div>
                                    <iframe width="1040" height="568" src="https://www.youtube.com/embed/AJnwxGE55bo?list=PLnzLQZtG-AkhO-XRdiuxTwIwsOLXHARU6" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen=""></iframe>
                                </div>
                            </div>
                            <div class="noti">
                                <img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/txt_noti.png" alt="이벤트 유의사항" />
                            </div>
                            <!-- 레이어팝업 -->
                            <div class="layer-popup" id="lyrSch"> 
                                <div class="layer "> 
                                    <!-- 2차 이벤트 당첨자 팝업 -->
									<% if session("evt91395") = "1" and isParticipation then %>	
                                    <div>
                                        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/img_layer_win.png" alt="축하합니다 이벤트에 당첨되셨습니다! 지금 바로 1,000원으로 호로요이 메리해피 혼쉼 패키지를 만나보세요!" /></p> 
                                        <button onclick="goDirOrdItem()"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/btn_layer_buy.png" alt="바로 구매하기" /></button>
                                        <a href="/event/eventmain.asp?eventid=90907"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/bnr_layer_evt.png" alt="1일 1술 프로혼술러"></a>
                                    </div>									
									<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
										<input type="hidden" name="itemid" id="itemid" value="<%=evtItemCode%>">
										<input type="hidden" name="itemoption" value="0000">
										<input type="hidden" name="itemea" value="1">
										<input type="hidden" name="mode" value="DO1">
									</form>												
									<% elseif session("evt91395") = "2" and isParticipation then %>
                                    <div>
                                        <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/img_layer_fail.png" alt="아쉽게도 당첨되지 않았습니다" /></p> 
                                        <a href="/event/eventmain.asp?eventid=90907"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/bnr_layer_evt.png" alt="1일 1술 프로혼술러"></a>
                                    </div>									
									<% end if %>
                                    <a href="" class="btn-close"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/91395/btn_layler_close.png" alt="닫기"></a>
                                </div> 
                                <div class="mask"></div> 
                            </div>
                        </div>			
<%
	session("evt91395") = "0"
%>
                        <!-- // 91395 호로요이 2차 혼쉼을 부탁해  -->
<!-- #include virtual="/lib/db/dbclose.asp" -->