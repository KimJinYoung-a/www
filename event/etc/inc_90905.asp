<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  호로요이 이벤트 90905
' History : 2018-11-23 최종원 
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode, refer, resultParam, alertMsg, sqlstr, cnt, alarmRegCnt, LoginUserid, chasu
dim chasu1BtnType, chasu2BtnType
dim chasu2StartDate, eventEndDate, currentDate, eventStartDate 
dim chasu1Participants, chasu2Participants
dim alarmBtnImg

eventStartDate = cdate("2018-12-10")
chasu2StartDate = cdate("2018-12-25")
eventEndDate = cdate("2018-12-19")
currentDate = date()
LoginUserid		= getencLoginUserid()

'1차, 2차 이벤트 구분
if currentDate < chasu2StartDate then
	chasu = 1
Else
	chasu = 2	
end if		

'테스트 날짜 
'eventStartDate = cdate("2018-12-10")
'eventEndDate = cdate("2018-12-05")
'chasu=2

IF application("Svr_Info") = "Dev" THEN
	eCode = "90200"	
Else
	eCode = "90905"	
End If

sqlstr = " SELECT isnull(sum(case when sub_opt3 = '1' then 1 else 0 end),0) as chasu1 "
sqlstr = sqlstr & " , isnull(sum(case when sub_opt3 = '2' then 2 else 0 end),0) as chasu2 "  
sqlstr = sqlstr & " FROM [db_event].[dbo].[tbl_event_subscript]  WHERE evt_code="& eCode  

rsget.Open sqlstr, dbget, 1
	chasu1Participants = rsget("chasu1")
	chasu2Participants = rsget("chasu2")
rsget.close	

if LoginUserid <> "" then
	'이벤트 응모
	sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE userid= '"&LoginUserid&"' and evt_code="& eCode &" and sub_opt3 = '"& chasu &"'"
	rsget.Open sqlstr, dbget, 1
		cnt = rsget("cnt")
	rsget.close

	'알람 응모
	sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE userid= '"&LoginUserid&"' and evt_code="& eCode &" and sub_opt2 = '1' "
	rsget.Open sqlstr, dbget, 1
		alarmRegCnt = rsget("cnt")
	rsget.close	
end if

resultParam = request("resultParam")
refer = request.ServerVariables("HTTP_REFERER")			

'1차수 버튼 이미지
if chasu = 2 then	
	chasu1BtnType = "btn_sel_winner_check.png"
Else
	if cnt > 0 then
		chasu1BtnType = "btn_sel_winner_off.png"
	Else
		chasu1BtnType = "btn_sel_winner_on.png"
	end if	
end if

'2차수 버튼 이미지
if currentDate > eventEndDate then
	chasu2BtnType = "btn_sel_winner_check.png"
Else
	if cnt > 0 then
		chasu2BtnType = "btn_sel_winner_off.png"
	Else
		chasu2BtnType = "btn_sel_winner_on.png"
	end if	
end if

'알람버튼 이미지
if alarmRegCnt > 0 then
	alarmBtnImg = "btn_sel_1st_alarm_off.png" 
else
	alarmBtnImg = "btn_sel_1st_alarm_on.png" 
end if

if InStr(refer, "doEventSubscript90905") > 0 and (resultParam <> "" and resultParam <> "0") then	
	Select Case resultParam		
		Case "1"
			alertMsg = "잘못된 경로로 접속하셨습니다."
		Case "2"
			alertMsg = "잘못된 경로로 접속하셨습니다."
		Case "3"
			alertMsg = "이벤트 참여기간이 아닙니다." 				
		Case "4"
			alertMsg = "로그인을 하셔야합니다." 				
		Case "5"
			alertMsg = "이미 응모하셨습니다. 당첨일을 기대해주세요!"
	end Select
	response.write "<script>alert('"&alertMsg&"');</script>"	
end if	
%>
<style type="text/css">
.evt90905 {text-align: center;}
.evt90905 div {margin: auto;}
.evt90905 button{border:0 none;border-radius:0;background-color:transparent;cursor:pointer}
.evt90905 button:focus {
    outline: none;
    border: none;}
.evt90905 .top-area {position: relative; padding-bottom: 60px; background: url(http://webimage.10x10.co.kr/fixevent/event/2018/90905/bg_top.png) 0 50%;}
.evt90905 .top-area dl dt,
.evt90905 .top-area dl dd {position: absolute; left: 50%; animation:slowDown 2s ease both; opacity: 1;}
.evt90905 .top-area dl dt {margin-left: -87px; top: 157px; }
.evt90905 .top-area dl dd {margin-left: 3px; top: 266px; animation-delay: .7s;}
.evt90905 .wideSwipe {position: relative;}
.evt90905 .wideSwipe > p {position: absolute; left: 50%; top:35px ; margin-left: 425px; z-index: 999;}
.evt90905 .wideSwipe .swiper-container {height:720px;}
.evt90905 .wideSwipe .swiper-slide img {height:720px;}
.evt90905 .wideSwipe .mask {background-image:none; background-color:rgba(0,0,0,0.77); }
.evt90905 .wideSwipe .pagination {bottom:17px;}
.evt90905 .wideSwipe .pagination span {background:url(http://webimage.10x10.co.kr/eventIMG/2017/83094/btn_slide_pagination.png) no-repeat 100% 0;}
.evt90905 .wideSwipe .pagination .swiper-active-switch {background-position:0 0;}
.evt90905 .wideSwipe .slideNav {top:inherit; top:50%; left: 50%; margin-top:-45px; height:47px; width:24px; background:url(http://webimage.10x10.co.kr/fixevent/event/2018/90905/btn_arrow.png) no-repeat 0 0; outline:0;}
.evt90905 .wideSwipe .slideNav.btnNext,
.evt90905 .wideSwipe .slideNav.btnNext:hover {background-position: 0 -100px;}
.evt90905 .wideSwipe .btnPrev:hover {background-position:0 0;}
.evt90905 .wideSwipe .pagination span {background-image: unset; width: 9px; height: 9px; border-radius:50%; margin: 0  10px; background-color: #c9bebe;}
.evt90905 .wideSwipe .pagination .swiper-active-switch {background-color: #241f35 ;}
.evt90905 .sel-area {position: relative; background: url(http://webimage.10x10.co.kr/fixevent/event/2018/90905/bg_sel.png) 0 50%;}
.evt90905 .sel-area > div {width: 1040px; margin: auto; padding-bottom: 58px;}
.evt90905 .sel-area > div ol,
.evt90905 .sel-area > div ul {*zoom:1}
.evt90905 .sel-area > div ol:after,
.evt90905 .sel-area > div ul:after {clear:both;display:block;content:'';}
.evt90905 .sel-area > div li {float: left;}
.evt90905 .sel-area > div ol li a {display: block; width: 520px; height: 100px; background-position: 0 100%; text-indent: -9999px;}
.evt90905 .sel-area > div ol li.sel-1st a {background-image: url(http://webimage.10x10.co.kr/fixevent/event/2018/90905/btn_sel_1st.png); }
.evt90905 .sel-area > div ol li.sel-2nd a {background-image: url(http://webimage.10x10.co.kr/fixevent/event/2018/90905/btn_sel_2nd.png); }
.evt90905 .sel-area > div ol li.on a {background-position: 0 0;}
.evt90905 .sel-area > div ul li {display: none;}
.evt90905 .sel-area > div ul li.on {display: block; width: 1040px; height: 308px;  box-sizing: border-box; padding-top: 30px;}
.evt90905 .sel-area > div ul li.sel-1st {background-image: url(http://webimage.10x10.co.kr/fixevent/event/2018/90905/bg_sel_1st_btnwrap.png);}
.evt90905 .sel-area > div ul li.sel-2nd {background-image: url(http://webimage.10x10.co.kr/fixevent/event/2018/90905/bg_sel_2nd_btnwrap.png);}
.evt90905 .vod-area {position: relative; background: url(http://webimage.10x10.co.kr/fixevent/event/2018/90905/bg_vod.png) 0 50%;}
.evt90905 .vod-area div {padding: 37px 0 94px;}
.evt90905 .noti {background-color: #111115;}
.evt90905 .ml-28 {margin-left: -28px;}
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
	// chasu1Popup();
	<% 	if InStr(refer, "doEventSubscript90905") > 0 and resultParam = "0" then %>
		<%	if chasu = 1 then %>
		chasu1Popup();
		<%	else %>
		chasu2Popup();
		<%	end if %>
	<% else %>	
		$('#lyrSch3').show();	
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
    // 1차응모 2차응모 선택
    $('.sel-area ol li a').click(function(e){
		var i = $(this).parent().index();
		<% if chasu = 1 then %>		
		if(i == 1){
			alert("2차 응모기간이 아닙니다.");
		}else{
			$('.sel-area ol li').eq(i).addClass('on').siblings().removeClass('on')
			$('.sel-area ul li').eq(i).addClass('on').siblings().removeClass('on')		
		}		
		<% else %>
			$('.sel-area ol li').eq(i).addClass('on').siblings().removeClass('on')
			$('.sel-area ul li').eq(i).addClass('on').siblings().removeClass('on')				
		<% end if %>
        // e.preventDefault()
	})			
    $('.layer-popup .layer').css({'top':150})
	$('.layer-popup .mask').click(function(){
		$('.layer-popup').fadeOut();
	});

	function chasu1Popup(){		
		var scrollY = $('.sel-area').offset().top+200
		$('.layer-popup .layer').css({'top':scrollY})		
		$('#lyrSch').fadeIn();
		window.parent.$('html,body').animate({scrollTop:scrollY}, 800);	
	}
	function chasu2Popup(){    
		var scrollY = $('.sel-area').offset().top+200
		$('.layer-popup .layer').css({'top':scrollY})		
		$('#lyrSch2').fadeIn();
		window.parent.$('html,body').animate({scrollTop:scrollY}, 800);
	}	
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
	<% if (eventStartDate > currentDate or eventEndDate < currentDate) and GetLoginUserLevel <> "7" then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% else %>		
		<% if cnt > 0 then %>
			alert("이미 응모 하셨습니다.");
		<% else %>
			confirmAdultAuthCst("성인인증이 필요한 콘텐츠입니다. 성인인증을 하시겠습니까?", "/event/etc/doeventsubscript/doEventSubscript90905.asp");	
		<% end if %>	
	<% end if %>
}
function closePopup(e){
	$('.layer-popup').fadeOut();	
}
function registAlram() {
	<% if (eventStartDate > currentDate or eventEndDate < currentDate) and GetLoginUserLevel <> "7" then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>		
	<% If LoginUserid = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 참여할 수 있습니다.")){
				top.location.href="/login/loginpage.asp?vType=G";
				return false;
			}
		}
	<% End If %>
	<% If LoginUserid <> "" Then %>
		var str = $.ajax({
			type: "GET",
			url:"/event/etc/doeventsubscript/doEventSubscript90905.asp",
			data: "mode=regAlram",
			dataType: "text",
			async: false
		}).responseText;	
		if(str == "OK"){
			$("#chasu2AlertbtnImg").attr("src", "http://webimage.10x10.co.kr/fixevent/event/2018/90905/btn_sel_1st_alarm_off.png")
			alert("2차 응모 알림이 신청되었습니다.");
		}else if(str == "ERR"){
			alert("이미 신청하셨습니다.");
		}else{
			alert("시스템 에러입니다.");
		}
	<% End If %>
}
function linkToNotice(){
	location.href="/my10x10/myeventmaster.asp";
}
</script>
                        <!-- 90905 호로요이 혼쉼을 부탁해  -->
                        <div class="evt90905">
						<% if GetLoginUserLevel = "7" then %>
						<div style="color:red">*스태프만 노출</div>
						<div>1차 응모자 수: <%=chasu1Participants%></div>
						<div>2차 응모자 수: <%=chasu2Participants%></div>
						<% end if %>
                            <div class="top-area">
                                <img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_top.png?v=1.01" alt="텐바이텐x호로요이">
                                <dl>
                                    <dt><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/txt_tit_01.png" alt="혼쉼을"></dt>
                                    <dd><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/txt_tit_02.png" alt="부탁해"></dd>
                                </dl>
                            </div>
                            <div class="wideSwipe">
                                <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/ico_winner.png" alt="총 당첨자 500명"></p>
                                <div class="swiper-container">
                                    <div class="swiper-wrapper">
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_slide_01.png" alt="호로요이 혼술을 부탁해" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_slide_02.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_slide_03.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_slide_04.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_slide_05.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_slide_06.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_slide_07.png" alt="" /></div>
                                        <div class="swiper-slide"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_slide_08.png" alt="" /></div>
                                    </div>
                                    <div class="pagination"></div>
                                    <button class="slideNav btnPrev">이전</button>
                                    <button class="slideNav btnNext">다음</button>
                                    <div class="mask left"></div>
                                    <div class="mask right"></div>
                                </div>
                            </div>
                            <div class="sel-area" id="selArea">
                                <img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/txt_sel.png" alt="텐바이텐x호로요이">
                                <div>
                                    <ol>
                                        <li class="sel-1st <%=chkIIF(chasu=1, " on", "")%>"><a href="javascript:void(0)">1차 응모</a></li>
                                        <li class="sel-2nd <%=chkIIF(chasu=2, " on", "")%>"><a href="javascript:void(0)">2차 응모</a></li>
                                    </ol>
                                    <ul>
                                        <li class="sel-1st <%=chkIIF(chasu=1, " on", "")%>">
                                            <button id="layerPopupBtn" type="button" onclick="<%=chkIIF(chasu=2,"linkToNotice()","adultCert()")%>()"><img class="evt-entrybtn-img" src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/<%=chasu1BtnType%>" alt="응모하기"></button>
											<% if chasu = 1 then %>
                                            <a href="javascript:registAlram();" class="ml-28"><img id="chasu2AlertbtnImg" src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/<%=alarmBtnImg%>" alt="2차 응모 알림 신청하기"></a>
											<% end if %>
                                            <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/btn_sel_1st_txt.png" alt="1차 당첨자는 2018년 12월 25일 텐바이텐 공지사항에 발표 예정"></p>
                                        </li>
                                        <li class="sel-2nd <%=chkIIF(chasu=2, " on", "")%>">
                                            <button id="layerPopupBtn2" type="button" onclick="adultCert()"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/<%=chasu2BtnType%>" alt="응모하기"></button>
                                            <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/btn_sel_2nd_txt.png" alt="1차 당첨자는 2018년 12월 25일 텐바이텐 공지사항에 발표 예정"></p>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="vod-area">
                                <img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/txt_vod.png" alt="오늘 하루는 나를 위한 순간을 만들어보세요. 호로요이 메리해피 혼쉼 패키지와 함께 "오늘은 쉽니다" ">
                                <div>
                                    <iframe width="1040" height="568" src="https://www.youtube.com/embed/AJnwxGE55bo?list=PLnzLQZtG-AkhO-XRdiuxTwIwsOLXHARU6" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen=""></iframe>
                                </div>
                            </div>
                            <div class="noti">
                                <img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/txt_noti.png" alt="이벤트 유의사항" />
                            </div>
                        </div>
                        <!-- 1차 응모완료 -->
                        <div class="layer-popup" id="lyrSch"> 
                            <div class="layer "> 
                                <div>
                                    <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_layer_on.png" alt="1차 응모완료!" /></p> 									
                                    <button type="button" onclick="registAlram();"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/btn_layer_alarm.png" alt="2차 응모 알림 신청하기" /></button>									
                                    <a href="/event/eventmain.asp?eventid=90907"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/bnr_layer_evt.png" alt="1일 1술 프로혼술러"></a>
                                </div>
                                <a href="javascript:void(0)" type="button" onclick="closePopup();" class="btn-close"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/btn_layler_close.png" alt="닫기"></a>
                            </div> 
                            <div class="mask"></div> 
                        </div>
                         <!-- 2차 응모완료 -->
                         <div class="layer-popup" id="lyrSch2"> 
                            <div class="layer "> 
                                <div>
                                    <p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_layer_off.png" alt="2차 응모완료!" /></p> 
                                    <a href="/event/eventmain.asp?eventid=90907"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/bnr_layer_evt.png" alt="1일 1술 프로혼술러"></a>
                                </div>
                                <a href="javascript:void(0)" type="button" onclick="closePopup();" class="btn-close"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/btn_layler_close.png" alt="닫기"></a>
                            </div> 
                            <div class="mask"></div> 							
                        </div> 
						<!-- 181218 종료 -->
						<div class="layer-popup" id="lyrSch3"> 
							<div class="layer "> 
								<div>
									<p><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/img_layer_closing.png?v=1.03" alt="이벤트 안내 안녕하세요. 텐바이텐입니다. 한국건강증진개발원에서 해당 이벤트에 대한 시정요청으로 2018년 12월 19일 이벤" /></p> 
									<button onclick="window.location.href='/common/news_popup.asp?idx=18129&type=&page=1'"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/btn_layer_closing.png" alt="텐바이텐 공지사항 >" /></button>
								</div>
								<a href="javascript:void(0)" onclick="closePopup();" class="btn-close"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/90905/btn_layler_close.png" alt="닫기"></a>
							</div> 
							<div class="mask"></div> 
						</div> 						
                        <!-- // 90905 호로요이 혼쉼을 부탁해  -->

<!-- #include virtual="/lib/db/dbclose.asp" -->