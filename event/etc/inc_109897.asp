<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 서촌도감04 - 텐바이텐X핀란드프로젝트
' History : 2021.03.31 정태훈 생성
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
	eCode = "104341"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
	eCode = "109897"
    mktTest = true    
Else
	eCode = "109897"
    mktTest = false
End If

if mktTest then
    currentDate = #04/02/2021 09:00:00#
else
    currentDate = date()
end if

eventStartDate = cdate("2021-04-02")		'이벤트 시작일
eventEndDate = cdate("2021-04-16")		'이벤트 종료일

userid = GetEncLoginUserID()

if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(eCode, userid, left(currentDate,10), 2, "")
end if
%>
<style type="text/css">
    .evt109897 {max-width:1920px; margin:0 auto; background:#fff;}
    .evt109897 .txt-hidden {text-indent: -9999px; font-size:0;}
    .evt109897 .animate-txt {opacity:0; transform:translateY(10%); transition:all 1s;}
    .evt109897 .animate-txt.on {opacity:1; transform:translateY(0);}

    .evt109897 .topic {position:relative; width:100%; height:1313px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/img_tit.jpg) no-repeat 50% 0;}
    .evt109897 .topic .iocn-arrow {position:absolute; left:50%; bottom:280px; transform:translate(-50%,0); animation: updown .7s ease-in-out alternate infinite;}
    .evt109897 .flex {display:flex;}
    .evt109897 .section-01 {position:relative; width:100%; height:720px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub01.jpg) no-repeat 50% 0;}
    .evt109897 .section-01 .animate-txt {padding:120px 0 0 760px;}
    .evt109897 .section-02 .animate-txt {padding:325px 90px 0 0; text-align:right;}
    .evt109897 .section-02 .animate-txt.half {width:40%}
    .evt109897 .section-02 .half {width:60%}
    .evt109897 .section-03 .animate-txt.half {width:45%; padding:270px 0 0 80px; text-align:left;}
    .evt109897 .section-03 .half-img {width:55%; height:686px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub03.jpg) no-repeat 50% 0;}
    .evt109897 .section-04 {width:100%; height:678px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub04.jpg) no-repeat 50% 0;}
    .evt109897 .section-05 .half {width:50%;}
    .evt109897 .section-05 .animate-txt {padding:315px 95px 0 0; text-align:right;}
    .evt109897 .section-06 {position:relative; width:100%; height:2031px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub06.jpg) no-repeat 50% 0;}
    .evt109897 .section-07 {position:relative; width:100%; height:1549px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub07.jpg) no-repeat 50% 0;}
    .evt109897 .section-07 .btn-coupon {width:285px; height:100px; position:absolute; left:50%; top:770px; transform: translate(-50%,0); background:transparent;}
    .evt109897 .section-08 {position:relative; background:#f9bfa0;}
    .evt109897 .section-08 .tit {position:relative; width:100%; height:623px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub08.jpg?v=2) no-repeat 50% 0;}
    .evt109897 .section-08 .tit .btn-benefit {position:absolute; left:50%; top:350px; transform:translate(-50%,0); width:600px; height:120px; background:transparent;}
    .evt109897 .section-08 .btn-grp {position:absolute; left:50%; top:845px; transform:translate(-50%,0); display:flex; flex-wrap:wrap; width:1140px;}
    .evt109897 .section-08 .btn-grp button {position:relative; display:inline-block; width:50%; height:170px; background:transparent;}
    .evt109897 .section-08 .btn-grp button::before {content:""; display:inline-block; position:absolute; left:86px; top:0; width:61px; height:59px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/icon_check.png) no-repeat 50% 0; opacity:0;}
    .evt109897 .section-08 .btn-grp button:nth-child(2):before {left:41px;}
    .evt109897 .section-08 .btn-grp button:nth-child(3):before {left:86px; top:15px;}
    .evt109897 .section-08 .btn-grp button:nth-child(4):before {left:41px; top:15px;}
    .evt109897 .section-08 .btn-grp button.on::before {opacity:1;}
    .evt109897 .section-08 .btn-apply {position:absolute; left:50%; bottom:180px; transform:translate(-50%,0); width:470px; height:130px; background:transparent;}
    .evt109897 .section-09 {width:100%; height:869px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub10.jpg) no-repeat 50% 0;}
    .evt109897 .section-10 {width:100%; height:217px; margin-top:-1px; display:flex; align-items:center; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/img_insta.jpg) no-repeat 50% 0;}
    .evt109897 .section-10 a {display:inline-block; width:100%; height:100%;}
    .evt109897 .section-11 {width:100%; height:926px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/img_noti.jpg?v=2) no-repeat 50% 0;} 

    .evt109897 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
    .evt109897 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
    .evt109897 .pop-container .pop-inner a {display:inline-block;}
    .evt109897 .pop-container .pop-inner .btn-close {position:absolute; right:28px; top:28px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109897/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
    .evt109897 .pop-container.detail .contents-inner,
    .evt109897 .pop-container.win .contents-inner,
    .evt109897 .pop-container.fail .contents-inner {position:relative; width:846px; margin:0 auto;}
    .evt109897 .pop-container.benefit .contents-inner {position:relative; width:1138px; margin:0 auto;}

    @keyframes updown {
        0% {bottom:270px;}
        100% {bottom:290px;}
    }

</style>
<script>
    $(function() {
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
        /* event 버튼 선택 */
        $('.btn-grp button').on("click",function(){
            $(this).toggleClass("on").siblings().removeClass("on");
        });
        /* 쿠폰 사용 방법 팝업 */
        $('.evt109897 .btn-coupon').click(function(){
            $('.pop-container.detail').fadeIn();
        })
        /* 이벤트혜택 안내 팝업 */
        $('.evt109897 .btn-benefit').click(function(){
            $('.pop-container.benefit').fadeIn();
        })
        /* 팝업 닫기 */
        $('.evt109897 .btn-close').click(function(){
            $(".pop-container").fadeOut();
        })
    });
function fnSelectSign(sn){
    $("#signNum").val(sn);
}
var numOfTry="<%=subscriptcount%>";
function doAction() {
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
            url:"/event/etc/doeventsubscript/doEventSubScript109897.asp",
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
<style type="text/css">
.hobby iframe {display:block; width:100%;}
</style>
<div class="hobby">
    <iframe id="" src="/event/etc/group/iframe_favorites.asp?eventid=109897" width="300" height="120" frameborder="0" scrolling="no" title="서촌도감"></iframe>
</div>
                <div class="evt109897">
                    <div class="topic">
                        <p class="txt-hidden">텐바이텐 X 핀란드프로젝트</p>
                        <span class="iocn-arrow"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_arrow_down.png" alt="arrow"></span>
                    </div>
                    <div class="section-01">
                        <div class="animate-txt">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub_txt01.png" alt="서촌의 조용한 주택가를 걷다 보면 의외의 장소에서 만나게 되는 '핀란드프로젝트'">
                        </div>
                    </div>
                    <div class="section-02 flex">
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub_txt02.png" alt="멋스러운 개조 주택의 외관과 '핀란드프로젝트'만의 공간 연출로 이색적인 분위기를 풍기는 공간으로 만들어졌답니다.">
                        </div>
                        <div class="half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub02.jpg" alt="img">
                        </div>
                    </div>
                    <div class="section-03 flex">
                        <div class="half-img"></div>
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub_txt03.png" alt="특이하게도 어느 위치에 앉는지에 따라 분위기가 바뀌어 새로움을 느낄 수 있는 곳이죠.">
                        </div>
                    </div>
                    <div class="section-04 flex"></div>
                    <div class="section-05 flex">
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub_txt04.png" alt="'판린드프로젝트' 직원이 직접 개발한 음식들은 와인과 아주 잘 어울리기도 하죠!">
                        </div>
                        <div class="half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub05.jpg" alt="img">
                        </div>
                    </div>
                    <div class="section-06"><p class="txt-hidden">핀란드프로젝트에 대해 더 알아보기</p></div>
                    <div class="section-07">
                        <p class="txt-hidden">텐바이텐과 핀란드프로젝트가 준비하 혜택</p>
                        <!-- 쿠폰사용 방법 -->
                        <button type="button" class="btn-coupon"></button>
                    </div>
                    <div class="section-08">
                        <div class="tit">
                            <button type="button" class="btn-benefit"></button>
                        </div>
                        <!-- 이벤트 영역 -->
                        <div class="contents">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109897/img_sub09.jpg" alt="다음 중 핀란드프로젝트의 '진짜' 간판은 무엇일까요?">
                            <!-- 선택시 class on 추가 -->
                            <div class="btn-grp">
                                <button type="button" onclick="fnSelectSign(1);"></button>
                                <button type="button" onclick="fnSelectSign(2);"></button>
                                <button type="button" onclick="fnSelectSign(3);"></button>
                                <button type="button" onclick="fnSelectSign(4);"></button>
                                <input type="hidden" id="signNum">
                            </div>
                            <!-- 정답 제출하기 버튼 -->
                            <button type="button" class="btn-apply" onclick="doAction();"></button>
                        </div>
                    </div>
                    <div class="section-09"><p class="txt-hidden">sns 이벤트 핀란드프로젝트에서 인증샷을 찍은 후 인스타그램에 업로드해주세요.</p></div>
                    <div class="section-10">
                        <!-- 인스타그램으로 이동 -->
                        <a href="https://www.instagram.com/finland_project" onclick="fnAmplitudeEventMultiPropertiesAction('landing_instagram','evtcode','<%=eCode%>');" target="_blank"><span class="txt-hidden">핀란드프로젝트 구경하러 가기</span></a>
                        <!-- 즐겨찾길 메인으로 이동 -->
                        <a href="https://tenten.app.link/Cl6bQPapxdb" onclick="fnAmplitudeEventMultiPropertiesAction('landing_bookmark_seochon','evtcode','<%=eCode%>');" target="_blank"><span class="txt-hidden">텐바이텐 x 서촌 # 즐겨찾길 구경하러 가기</span></a>
                    </div>
                    <div class="section-11"></div>
                    <!-- 팝업 - 쿠폰 사용 방법 보기 -->
                    <div class="pop-container detail">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109897/pop_coupon.png?v=2" alt="쿠폰 사용 방법">
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
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109897/pop_win.png" alt="축하합니다!">
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
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109897/pop_fail.png" alt="아쉽지만 오답!">
                                    <button type="button" class="btn-close">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 팝업 - 이벤트혜택 안내 -->
                    <div class="pop-container benefit">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109897/pop_benefit.png" alt="혜택안내">
                                    <button type="button" class="btn-close">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
<!-- #include virtual="/lib/db/dbclose.asp" -->