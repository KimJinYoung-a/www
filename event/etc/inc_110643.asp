<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 서촌도감05 - 텐바이텐X커피한잔
' History : 2021.04.22 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim currentDate, eventStartDate, eventEndDate
dim eCode, userid, mktTest, subscriptcount

IF application("Svr_Info") = "Dev" THEN
	eCode = "105350"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
	eCode = "110643"
    mktTest = true    
Else
	eCode = "110643"
    mktTest = false
End If

if mktTest then
    currentDate = #04/23/2021 09:00:00#
else
    currentDate = date()
end if

eventStartDate = cdate("2021-04-23")		'이벤트 시작일
eventEndDate = cdate("2021-05-06")		'이벤트 종료일

userid = GetEncLoginUserID()

if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, left(currentDate,10), 2, "")
end if
%>
<style>
.evt110643 {position:relative; background:#fff;}
.evt110643 button {background:none;}
.evt110643 .topic {height:1383px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110643/bg_topic.jpg) no-repeat center top;}
.evt110643 .section, .evt110643 .lookbook > div {position:relative; background-repeat:no-repeat; background-position:center top;}
.evt110643 .lookbook .l1 {height:1151px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2021/110643/bg_lookbook_01.jpg);}
.evt110643 .lookbook .l2 {height:667px;}
.evt110643 .lookbook .l3 {height:1314px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2021/110643/bg_lookbook_03.jpg);}
.evt110643 .lookbook .l4 {height:664px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2021/110643/bg_lookbook_04.jpg);}
.evt110643 .lookbook .l5 {height:1093px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2021/110643/bg_lookbook_05.jpg);}
.evt110643 .lookbook .txt {position:absolute; left:50%; opacity:0; transform:translateY(20px); transition:1s;}
.evt110643 .lookbook .txt.on {opacity:1; transform:none;}
.evt110643 .lookbook .l1 .txt {top:365px; margin-left:-560px;}
.evt110643 .lookbook .l2 .txt {top:260px; margin-left:155px;}
.evt110643 .lookbook .l3 .txt {bottom:315px; margin-left:-560px;}
.evt110643 .lookbook .l4 .txt {top:305px; margin-left:115px;}
.evt110643 .lookbook .l5 .txt {top:175px; margin-left:-213px;}
.evt110643 .lookbook .slider {overflow:hidden; position:absolute; top:0; right:50%; width:960px; height:667px;}
.evt110643 .lookbook .slick-dots {position:absolute; bottom:30px; right:30px; width:auto;}
.evt110643 .slick-dots button {width:12px; height:12px; margin:0 10px; background:#d4d4d4; border-radius:6px;}
.evt110643 .slick-dots .slick-active button {background:#00c445;}
.evt110643 .interview {background-color:#1977a6;}
.evt110643 .gift {background-color:#00c445;}
.evt110643 .gift .btn-coupon {position:absolute; bottom:165px; left:50%; width:570px; height:100px; margin-left:-570px; font-size:0; color:transparent;}
.evt110643 .evt1 {padding-bottom:110px; background-color:#c8efd5;}
.evt110643 .evt1 .inner {overflow:hidden; position:relative; width:1140px; margin:0 auto; padding-bottom:95px; background:#fff; border-radius:20px;}
.evt110643 .evt1 .img {margin:0;}
.evt110643 .evt1 .answer {position:absolute; top:700px; left:0; width:100%; display:-webkit-box; display:-ms-flexbox; display:flex; -ms-flex-wrap:wrap; flex-wrap:wrap; -webkit-box-pack:center; -ms-flex-pack:center; justify-content:center;}
.evt110643 .evt1 .answer button {position:relative; width:340px; height:353px; font-size:0; color:transparent;}
.evt110643 .evt1 .answer button:nth-child(4),.evt110643 .evt1 .answer button:nth-child(5) {width:380px;}
.evt110643 .evt1 .answer button.on::after {position:absolute; top:0px; left:50%; width:60px; margin-left:-30px; content:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/icon_check.png);}
.evt110643 .evt1 .btn-submit {vertical-align:top;}
.evt110643 .evt2 {background-color:#ffdb6e;}
.evt110643 .bnr {display:block; height:216px; font-size:0; color:transparent; background:#ffaa45 url(//webimage.10x10.co.kr/fixevent/event/2021/110643/bnr_seochon.jpg) no-repeat center;}
.evt110643 .notice {background:#333;}
.evt110643 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
.evt110643 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 196px); padding:98px 0; overflow-y:scroll;}
.evt110643 .pop-container .pop-inner a {display:inline-block;}
.evt110643 .pop-container .pop-inner .btn-close {position:absolute; right:28px; top:28px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110643/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
.evt110643 .pop-container.detail .contents-inner,
.evt110643 .pop-container.win .contents-inner,
.evt110643 .pop-container.fail .contents-inner {position:relative; width:846px; margin:0 auto;}
.evt110643 .pop-container.benefit .contents-inner {position:relative; width:1138px; margin:0 auto;}
</style>
<script>
$(function(){
    /* 쿠폰 사용 방법 팝업 */
    $('.evt110643 .btn-coupon').click(function(){
        $('.pop-container.detail').fadeIn();
    })
    /* 팝업 닫기 */
    $('.evt110643 .btn-close').click(function(){
        $(".pop-container").fadeOut();
    })
});
// 선택시
function fnSelectItem(n) {
    $('.evt110643 .evt1 .answer button').removeClass('on');
    $('.evt110643 .evt1 .answer button').eq(n-1).addClass('on');
    $("#signNum").val(n);
}

$(function() {
    $('.evt110643 .lookbook .l2 .slider').slick({
        autoplay: true,
        speed: 700,
        arrows: false,
        dots: true
    });
    $(window).scroll(function() {
        $('.lookbook .txt').each(function() {
            var y = $(window).scrollTop() + $(window).height() * .7;
            var imgTop = $(this).offset().top;
            if(y > imgTop) {
                $(this).addClass('on');
            }
        });
    });
});
var numOfTry="<%=subscriptcount%>";
function eventTry() {
    <% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
        alert("이벤트 참여기간이 아닙니다.");
        return false;
    <% end if %>
    <% If IsUserLoginOK() Then %>
        if(numOfTry == "1"){
			alert("오늘의 이벤트 참여는 완료되었습니다. 내일 또 참여해주세요!");
			return false;
		};
        if($("#signNum").val()==""){
			alert("정답을 선택해주세요.");
			return false;
		};
        $.ajax({
            type: "POST",
            url:"/event/etc/doeventsubscript/doEventSubscript110643.asp",
            data: {
                mode: 'add',
                signNum: $("#signNum").val()
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode|option','<%=eCode%>|'+$("#signNum").val())
                    $('.pop-container.win').fadeIn();
                }else if(data.response == "retry"){
                    alert("오늘의 이벤트 참여는 완료되었습니다. 내일 또 참여해주세요! ");
                }else{
                    $('.pop-container.fail').fadeIn();
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
    <% else %>
        jsEventLogin();
        return false;
    <% end if %>
}
function jsEventLogin(){
    if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
        location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
        return;
    }
}
</script>
<link href="/lib/js/jquery.magnify/magnify.min.css" rel="stylesheet">
<script src="/lib/js/jquery.magnify/jquery.magnify.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
$('.bsImage').magnify({
    'timeout': 1,
    'limitBounds': false
});
});
</script>
<style type="text/css">
.magnify > .magnify-lens {
width: 260px;
height: 260px;
}
</style>
<style type="text/css">
.hobby iframe {display:block; width:100%;}
</style>
<div class="hobby">
    <iframe id="" src="/event/etc/group/iframe_favorites.asp?eventid=110643" width="300" height="120" frameborder="0" scrolling="no" title="서촌도감"></iframe>
</div>
						<div class="evt110643">
							<div class="topic"></div>
							<section class="section lookbook">
								<div class="l1">
									<p class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/txt_lookbook_01.png" alt="진짜 레트로를 한 가득 안고 있는 커피한잔"></p>
								</div>
								<div class="l2">
									<div class="slider">
										<div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/img_slide_01.jpg" alt=""></div>
										<div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/img_slide_02.jpg" alt=""></div>
										<div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/img_slide_03.jpg" alt=""></div>
									</div>
									<p class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/txt_lookbook_02.png" alt="서로 다 다른 소품들이 모여 따로 또 같이"></p>
								</div>
								<div class="l3">
									<p class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/txt_lookbook_03.png" alt="어린 시절의 보물찾기 놀이를 하는 것 같아 친숙한 즐거움"></p>
								</div>
								<div class="l4">
									<p class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/txt_lookbook_04.png" alt="여유를 찾을 수 있게 도와주는 묘약"></p>
								</div>
								<div class="l5">
									<p class="txt"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/txt_lookbook_05.png" alt="서촌의 커피한잔을 방문해보세요"></p>
								</div>
							</section>
							<section class="section interview"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/txt_interview.jpg" alt="커피한잔에 대해 더 알아보기"></section>
							<section class="section gift">
								<p><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/txt_gift.jpg" alt="텐바이텐과 커피한잔이 준비한 혜택"></p>
								<!-- 쿠폰 사용 방법 버튼 -->
                                <button class="btn-coupon">쿠폰 사용 방법</button>
							</section>
							<section class="section evt1">
								<img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/tit_evt_01.png" alt="'커피한잔' 속 찐 레트로 아이템을 찾아주세요">
								<div class="inner">
									<figure class="img"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/img_evt_01.jpg" data-magnify-src="//webimage.10x10.co.kr/fixevent/event/2021/110643/img_evt_focus.jpg?v=1.01" class="bsImage" alt=""></figure>
									<p><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/txt_question.png" alt="커피한잔 공간 속 레트로 아이템이 아닌 것은 무엇일까요?"></p>
									<div class="answer">
										<button onclick="fnSelectItem(1);" class="">연필깎이</button>
										<button onclick="fnSelectItem(2);" class="">오뚝이</button>
										<button onclick="fnSelectItem(3);" class="">핸드폰</button>
										<button onclick="fnSelectItem(4);" class="">아이맥</button>
										<button onclick="fnSelectItem(5);" class="">구슬동자</button>
                                        <input type="hidden" id="signNum">
									</div>
                                    <!-- 정답 제출하기 버튼 -->
									<button class="btn-submit" onclick="eventTry();"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/btn_submit.png" alt="정답 제출하기"></button>
								</div>
							</section>
							<section class="section evt2"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/txt_evt_02.jpg" alt="SNS 이벤트"></section>
							<a href="/event/eventmain.asp?eventid=108102" onclick="fnAmplitudeEventMultiPropertiesAction('landing_bookmark_seochon','evtcode','<%=eCode%>');" class="bnr">텐바이텐 X 서촌 #즐겨찾길 바로가기</a>
							<p class="notice"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/txt_notice.jpg" alt="유의사항 혜택1 사용 방법"></p>
                            <!-- 팝업 - 쿠폰 사용 방법 보기 -->
                            <div class="pop-container detail">
                                <div class="pop-inner">
                                    <div class="pop-contents">
                                        <div class="contents-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/pop_coupon.png" alt="쿠폰 사용 방법">
                                            <button type="button" class="btn-close">닫기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- 팝업 - 정답인 경우 -->
                            <div class="pop-container win">
                                <div class="pop-inner">
                                    <div class="pop-contents">
                                        <div class="contents-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/pop_win.png" alt="축하합니다!">
                                            <button type="button" class="btn-close">닫기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- 팝업 - 오답인 경우 -->
                            <div class="pop-container fail">
                                <div class="pop-inner">
                                    <div class="pop-contents">
                                        <div class="contents-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110643/pop_fail.png" alt="아쉽지만 오답!">
                                            <button type="button" class="btn-close">닫기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->