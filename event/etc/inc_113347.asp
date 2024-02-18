<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : #즐겨찾길_서촌 06 텐바이텐X더레퍼런스
' History : 2021.08.12 정태훈 생성
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
	eCode = "108387"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
	eCode = "113347"
    mktTest = true    
Else
	eCode = "113347"
    mktTest = false
End If

if mktTest then
    currentDate = #08/16/2021 09:00:00#
else
    currentDate = date()
end if

eventStartDate = cdate("2021-08-16")		'이벤트 시작일
eventEndDate = cdate("2021-08-29")		'이벤트 종료일

userid = GetEncLoginUserID()

if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, left(currentDate,10), 2, "")
end if
%>
<style type="text/css">
    .evt113347 {background:#fff;}
    .evt113347 .txt-hidden {text-indent: -9999px; font-size:0;}
    .evt113347 .topic {position:relative; width:100%; height:1219px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/bg_main.jpg) no-repeat 50% 0;}
    .evt113347 .topic .iocn-arrow {position:absolute; left:50%; bottom:110px; transform:translate(-50%,0); animation: updown .7s ease-in-out alternate infinite;}
    .evt113347 .pagination {position:absolute; right:390px; bottom:6%; z-index:100;}
    .evt113347 .pagination .swiper-pagination-switch.swiper-active-switch {background-color:#ec4a18;}
    .evt113347 .pagination .swiper-pagination-switch {display:inline-block; width:12px; height:12px; margin:0 0.5rem; background-color:#ededed; border-radius:100%;}
    .evt113347 .flex {display:flex;}
    .evt113347 .section-00 {height:233px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/bg_sub01.jpg) no-repeat 50% 0;}
    .evt113347 .section-01 .txt {padding:450px 30px 0 0; text-align:right;}
    .evt113347 .section-02 {height:676px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_thum02.jpg?v=3) no-repeat 50% 0;}
    .evt113347 .section-03 .txt {width:calc(50% - 80px); padding:250px 0 0 80px; text-align:left;}
    .evt113347 .section-03 .img {height:545px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_thum03.jpg) no-repeat 50% 0;}
    .evt113347 .section-04 .txt {padding:450px 75px 0 0; text-align:right;}
    .evt113347 .section-06 .txt {width:calc(50% - 70px); padding:235px 0 0 70px; text-align:left;}
    .evt113347 .section-06 .img {height:799px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_thum05.jpg) no-repeat 50% 0;}
    .evt113347 .section-07 .txt {width:calc(50% - 40px); padding:140px 0 0 40px; text-align:left;}
    .evt113347 .section-07 .img {height:429px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_thum06.jpg) no-repeat 50% 0;}
    .evt113347 .section-08 .txt {padding:135px 50px 0 0; text-align:right;}
    .evt113347 .section-09 {height:411px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_txt08.jpg) no-repeat 50% 0;}
    .evt113347 .section-10 .txt {width:calc(50% - 70px); padding:135px 0 0 70px; text-align:left;}
    .evt113347 .section-10 .img {height:545px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_thum09.jpg) no-repeat 50% 0;}
    .evt113347 .sec-qna {margin-top:-1px; height:2399px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_qna.jpg) no-repeat 50% 0;}
    .evt113347 .sec-benefit {height:995px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_benefit.jpg?v=2) no-repeat 50% 0;}
    .evt113347 .sec-event {height:707px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_event.jpg?v=2) no-repeat 50% 0;}
    .evt113347 .sec-event02 {position:relative; height:1183px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_event02.jpg?v=2) no-repeat 50% 0;}
    .evt113347 .sec-event02 .btn-area {width:1140px; position:absolute; left:50%; top:0; transform:translate(-50%,0); display:flex; flex-wrap:wrap;}
    .evt113347 .sec-event02 .btn-area button {position:relative; width:50%; height:460px; background:transparent;}
    .evt113347 .sec-event02 .btn-area button::before {content:""; display:inline-block; width:61px; height:59px; position:absolute; left:178px; top:33px;}
    .evt113347 .sec-event02 .btn-area button.on::before {content:""; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/icon_check.png) no-repeat 0 0; background-size:100%;}
    .evt113347 .sec-event02 .btn-area button:nth-child(3)::before,
    .evt113347 .sec-event02 .btn-area button:nth-child(4)::before {top:26px;}
    .evt113347 .sec-event02 .btn-apply {width:100%; height:180px; position:absolute; left:0; bottom:50px; background:transparent;}
    .evt113347 .sec-sns {height:889px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_sns.jpg) no-repeat 50% 0;}
    .evt113347 .sec-link {position:relative; height:216px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/img_link.jpg?v=2) no-repeat 50% 0;}
    .evt113347 .sec-link a:nth-child(1) {display:inline-block; width:50%; height:100%; position:absolute; left:0; top:0;}
    .evt113347 .sec-link a:nth-child(2) {display:inline-block; width:50%; height:100%; position:absolute; right:0; top:0;}

    .evt113347 .half {width:50%;} 
    .evt113347 .section-05 .swiper-wrapper {display:flex; align-items:center; height: 100% !important;}
    .evt113347 .swiper-container {height:100%;}
    .evt113347 .swiper-container .swiper-slide {height:100% !important;}

    .evt113347 .animate-txt {opacity:0; transform:translateY(15%); transition:all 1s;}
    .evt113347 .animate-txt.on {opacity:1; transform:translateY(0);}
    .evt113347 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
    .evt113347 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
    .evt113347 .pop-container .pop-inner a {display:inline-block;}
    .evt113347 .pop-container .pop-inner .btn-close {position:absolute; right:28px; top:28px; width:29px; height:29px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/113347/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
    .evt113347 .pop-container.done .contents-inner,
    .evt113347 .pop-container.win .contents-inner,
    .evt113347 .pop-container.fail .contents-inner {position:relative; width:850px; margin:0 auto;}
    
    @keyframes updown {
        0% {bottom:110px;}
        100% {bottom:130px;}
    }
    @keyframes swing {
        0% {left:7%;}
        100% {left:11%;}
    }
</style>
<script>

$(function() {
    /* 팝업 닫기 */
    $('.evt113347 .btn-close').click(function(){
        $(".pop-container").fadeOut();
    })
    /* slide */
    var swiper = new Swiper(".section-05 .swiper-container", {
        autoplay: 1,
        speed: 2500,
        slidesPerView:1,
        pagination:".section-05 .pagination",
        loop:true
    });
    /* 글자,이미지 스르륵 모션 */
    $(window).scroll(function(){
        $('.animate-txt').each(function(){
        var y = $(window).scrollTop() + $(window).height() * 1;
        var imgTop = $(this).offset().top;
        if(y > imgTop) {
            $(this).addClass('on');
        }
        });
    });
    /* event check */
    $(".btn-area button").on("click",function(){
        $(this).toggleClass("on").siblings().removeClass("on");
    });
});

function fnSelectPlace(sn){
    $("#placeNum").val(sn);
}

var numOfTry="<%=subscriptcount%>";
function doAction() {
    <% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
        alert("이벤트 참여기간이 아닙니다.");
        return false;
    <% end if %>
    <% If IsUserLoginOK() Then %>
        if(numOfTry == "1"){
			$('.pop-container.done').fadeIn();
			return false;
		};
        if($("#placeNum").val()==""){
			alert("정답을 선택해주세요.");
			return false;
		};
        $.ajax({
            type: "POST",
            url:"/event/etc/doeventsubscript/doEventSubScript113347.asp",
            data: {
                mode: 'add',
                placeNum: $("#placeNum").val()
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode|option','<%=eCode%>|'+$("#signNum").val())
                    $('.pop-container.win').fadeIn();
                }else if(data.response == "retry"){
                    $('.pop-container.done').fadeIn();
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
<style type="text/css">
.hobby iframe {display:block; width:100%;}
</style>
<div class="hobby">
    <iframe id="" src="/event/etc/group/iframe_favorites.asp?eventid=113347" width="300" height="120" frameborder="0" scrolling="no" title="서촌도감"></iframe>
</div>
                <div class="evt113347">
                    <div class="topic">
                        <p class="txt-hidden">텐바이텐X더레퍼런스</p>
                        <span class="iocn-arrow"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_arrow_down.png" alt="arrow"></span>
                    </div>
                    <div class="section-00"></div>
                    <div class="section-01 flex">
                        <div class="animate-txt half txt"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_txt01.jpg?v=3" alt=""></div>
                        <div class="half"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_thum01.jpg?v=3" alt=""></div>
                    </div>
                    <div class="section-02"></div>
                    <div class="section-03 flex">
                        <div class="half img"></div>
                        <div class="animate-txt half txt">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_txt02.jpg?v=3" alt="">
                        </div>
                    </div>
                    <div class="section-04 flex">
                        <div class="animate-txt half txt">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_txt03.jpg?v=2" alt="">
                        </div>
                        <div class="half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_thum04.jpg" alt="">
                        </div>
                    </div>

                    <!-- slide -->
                    <div class="section-05">
                        <div class="slide-area">
                            <div class="swiper-container">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_slide01.png" alt="slide01">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_slide02.png" alt="slide02">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_slide03.png" alt="slide03">
                                    </div>
                                </div>
                                <!-- If we need pagination -->
                                <div class="pagination"></div>
                            </div>
                        </div>
                    </div>
                    
                    <div class="section-06 flex">
                        <div class="half img"></div>
                        <div class="animate-txt half txt">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_txt04.jpg?v=3" alt="">
                        </div>
                    </div>
                    <div class="section-07 flex">
                        <div class="half img"></div>
                        <div class="animate-txt half txt">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_txt05.jpg?v=3" alt="">
                        </div>
                    </div>
                    <div class="section-08 flex">
                        <div class="animate-txt half txt">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_txt06.jpg?v=3" alt="">
                        </div>
                        <div class="half"><img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_thum07.jpg" alt=""></div>
                    </div>
                    <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_thum08.jpg" alt=""></div>
                    <div class="section-09 animate-txt"></div>
                    <div class="section-10 flex">
                        <div class="half img"></div>
                        <div class="animate-txt half txt">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/img_txt07.jpg?v=3" alt="">
                        </div>
                    </div>
                    <div class="sec-qna"></div>
                    <div class="sec-benefit"></div>
                    <div class="sec-event"></div>
                    <div class="sec-event02">
                        <!-- 정답 선택 버튼 -->
                        <div class="btn-area">
                            <button type="button" onclick="fnSelectPlace(1);"></button>
                            <button type="button" onclick="fnSelectPlace(2);"></button>
                            <button type="button" onclick="fnSelectPlace(3);"></button>
                            <button type="button" onclick="fnSelectPlace(4);"></button>
                            <input type="hidden" id="placeNum">
                        </div>
                        <!-- 정답 제출하기 버튼 -->
                        <button type="button" class="btn-apply" onclick="doAction();"></button>
                    </div>
                    <div class="sec-sns"></div>
                    <div class="sec-link">
                        <!-- 더 레퍼런스 이동 -->
                        <a href="https://bit.ly/3iElUbw" target="_blank"><span class="txt-hidden">더 레퍼런스 구경하러 가기</span></a>
                        <!-- 즐겨찾길 메인으로 이동 -->
                        <a href="https://tenten.app.link/Cl6bQPapxdb" onclick="fnAmplitudeEventMultiPropertiesAction('landing_bookmark_seochon','evtcode','<%=eCode%>');" target="_blank"><span class="txt-hidden">텐바이텐 x 서촌 # 즐겨찾길 구경하러 가기</span></a>
                    </div>

                    <!-- 팝업 - 참여완료 -->
                    <div class="pop-container done">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/pop_done.png" alt="오늘의 이벤트 참여는 완료되었습니다. 내일 또 참여해주세요!">
                                    <button type="button" class="btn-close">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 팝업 - 정답 -->
                    <div class="pop-container win">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/pop_win.png" alt="축하드립니다. 정답입니다.">
                                    <button type="button" class="btn-close">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 팝업 - 오답 -->
                    <div class="pop-container fail">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/113347/pop_fail.png" alt="아쉽게도 오답입니다.">
                                    <button type="button" class="btn-close">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
<!-- #include virtual="/lib/db/dbclose.asp" -->