<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
'####################################################
' Description : #즐겨찾길_서촌 03 텐바이텐X미술관옆작업실
' History : 2021.02.05 정태훈 생성
'####################################################
dim currentDate, mktTest
dim eCode, LoginUserid

IF application("Svr_Info") = "Dev" THEN
	eCode   =  104313
    mktTest = True
ElseIf application("Svr_Info")="staging" Then
    eCode   =  108730
    mktTest = True
Else
	eCode   =  108730
    mktTest = False
End If

dim eventStartDate, eventEndDate
LoginUserid		= GetEncLoginUserID()
eventStartDate  = cdate("2021-03-05")		'이벤트 시작일
eventEndDate 	= cdate("2021-03-18")		'이벤트 종료일

if mktTest then
    currentDate = cdate("2021-03-05")
else
    currentDate = date()
end if

'// SNS 공유용
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpImg, appfblink

snpTitle	= Server.URLEncode("#즐겨찾길 03 텐바이텐X미술관옆작업실")
snpLink		= Server.URLEncode("http://m.10x10.co.kr/event/eventmain.asp?eventid="& eCode)
snpPre		= Server.URLEncode("10x10 이벤트")
snpImg		= Server.URLEncode("http://webimage.10x10.co.kr/fixevent/event/2021/108730/m/img_kakao.jpg")
appfblink	= "http://m.10x10.co.kr/event/eventmain.asp?eventid="& eCode 

'// 카카오링크 변수
Dim kakaotitle : kakaotitle = "#즐겨찾길 03 텐바이텐X미술관옆작업실"
Dim kakaodescription : kakaodescription = "지금 텐바이텐에서 '미술관옆작업실' 감성을 느껴보세요!"
Dim kakaooldver : kakaooldver = "지금 텐바이텐에서 '미술관옆작업실' 감성을 느껴보세요!"
Dim kakaoimage : kakaoimage = "http://webimage.10x10.co.kr/fixevent/event/2021/108730/m/img_kakao.jpg"
Dim kakaoAppLink, kakaoMobileLink, kakaoWebLink 
kakaoAppLink 	= "http://m.10x10.co.kr/apps/appcom/wish/web2014/event/eventmain.asp?eventid="& eCode
kakaoMobileLink = "http://m.10x10.co.kr/event/eventmain.asp?eventid="& eCode
kakaoWebLink = "http://www.10x10.co.kr/event/eventmain.asp?eventid="& eCode
%>
<style type="text/css">
    .evt108730 {background:#fff;}
    .evt108730 .txt-hidden {text-indent: -9999px; font-size:0;}
    
    .evt108730 .topic {position:relative; width:100%; height:1314px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/108730/img_tit.jpg?v=2) no-repeat 50% 0;}
    .evt108730 .topic .iocn-arrow {position:absolute; left:50%; bottom:280px; transform:translate(-50%,0); animation: updown .7s ease-in-out alternate infinite;}
    .evt108730 .pagination {position:absolute; right:2rem; bottom:6%; z-index:100;}
    .evt108730 .pagination .swiper-pagination-switch.swiper-active-switch {background-color:#ec4a18;}
    .evt108730 .pagination .swiper-pagination-switch {display:inline-block; width:12px; height:12px; margin:0 0.5rem; background-color:#ededed; border-radius:100%;}
    .evt108730 .flex {display:flex;}
    .evt108730 .section-01 .half,
    .evt108730 .section-02 .half,
    .evt108730 .section-03 .half,
    .evt108730 .section-04 .half {width:50%;}
    .evt108730 .section-02 .animate-txt {text-align:right; padding:170px 50px 0 0;}
    .evt108730 .section-04 .animate-txt {text-align:right; padding:210px 50px 0 0;}
    .evt108730 .section-01 .swiper-wrapper,
    .evt108730 .section-03 .swiper-wrapper,
    .evt108730 .section-08 .swiper-wrapper {display:flex; align-items:center; height: 100% !important;}
    .evt108730 .swiper-container {height:100%;}
    .evt108730 .swiper-container .swiper-slide {height:100% !important;}

    .evt108730 .section-01 .slide-area,
    .evt108730 .section-03 .slide-area {width:50%; position:relative;}
    .evt108730 .section-08 .slide-area {width:580px; position:relative;}
    .evt108730 .section-06 {position:relative; width:100%; height:979px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/108730/img_benefit.jpg) no-repeat 50% 0;}
    .evt108730 .section-06 .btn-detail {width:250px; height:100px; position:absolute; left:50%; top:770px; transform: translate(-163%,0); background:transparent;}
    .evt108730 .section-07 {background:#7080a5; padding-bottom:120px;}
    .evt108730 .section-07 .hint-area {position:relative;}
    .evt108730 .section-07 .hint-area .btn-hint {position:absolute; left:50%; top:0; transform:translate(-50%,0);}
    .evt108730 .section-07 .hint-area .btn-hint button {position:relative; background:transparent;}
    .evt108730 .section-07 .hint-area .btn-hint button::before {content:""; position:absolute; left:130px; top:24px; width:19px; height:12px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/108730/icon_arrow_down.png) no-repeat 0 0; background-size:100%;}
    .evt108730 .section-07 .hint-area .btn-hint button.show::before {content:""; position:absolute; left:130px; top:24px; width:19px; height:12px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/108730/icon_arrow_up.png) no-repeat 0 0; background-size:100%;}
    .evt108730 .section-07 .hint-area .hidden-area {display:none; padding-top:30px;}
    .evt108730 .section-07 .hint-area .hidden-area.show {display:block;}
    .evt108730 .section-07 .hint-area .icon-click {position:absolute; left:50%; top:0; animation:leftRight 1s ease-in-out alternate infinite; margin-left:-201px;}
    .evt108730 .section-07 .tit {position:relative;}
    .evt108730 .section-07 .tit .btn-detail {position:absolute; left:50%; top:410px; width:450px; height:95px; transform:translate(-60%, 0); background:transparent;}
    .evt108730 .section-07 .quiz-area {position:relative;}
    .evt108730 .section-07 .quiz-area .inputs {width:130px; height:34px; padding-bottom:5px; position:absolute; left:50%; top:17.5%; transform:translate(-200%,0); text-align:center; color:#222; font-weight:700; font-size:44px; border-bottom:5px solid #d3d3d4; border-top:0; border-left:0; border-right:0; border-radius:0;}
    .evt108730 .section-07 .quiz-area .inputs.input02 {top:34.5%; transform:translate(-228%,0);}
    .evt108730 .section-07 .quiz-area .inputs::placeholder {font-size:44px; color:#d3d3d4; font-weight:700;}
    .evt108730 .section-07 .quiz-area .btn-apply {width:500px; height:106px; position:absolute; left:50%; bottom:87px; transform:translate(-50%,0); cursor:pointer;}
    
    .evt108730 .section-09 {width:100%; height:217px; margin-top:-1px; display:flex; align-items:center; background:url(//webimage.10x10.co.kr/fixevent/event/2021/108730/img_insta.jpg) no-repeat 50% 0;}
    .evt108730 .section-09 a {display:inline-block; width:100%; height:100%;}
    
    .evt108730 .section-08 {width:100%; height:1208px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/108730/img_sns.jpg?v=2) no-repeat 50% 0;}
    .evt108730 .section-05 .tit {width:100%; height:2507px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/108730/img_qa.jpg) no-repeat 50% 0;}
    .evt108730 .section-05 .btn-apply {margin-top:24px; background:transparent;}
    .evt108730 .animate-txt {opacity:0; transform:translateY(10%); transition:all 1s;}
    .evt108730 .animate-txt.on {opacity:1; transform:translateY(0);}
    
    .evt108730 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
    .evt108730 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
    .evt108730 .pop-container .pop-inner a {display:inline-block;}
    .evt108730 .pop-container .pop-inner .btn-close {position:absolute; right:28px; top:28px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
    .evt108730 .pop-container.detail .contents-inner,
    .evt108730 .pop-container.win .contents-inner,
    .evt108730 .pop-container.fail .contents-inner {position:relative; width:670px; margin:0 auto;}
    .evt108730 .pop-container.fail .btn-review {width:670px; height:200px; position: absolute; left:0; bottom:0; background:transparent;}
    .evt108730 .pop-container.review {z-index:160;}
    .evt108730 .pop-container.review .contents-inner {position:relative; display:flex; align-items:center; justify-content:space-between; width:1140px; margin:0 auto;}
    .evt108730 .pop-container.review .contents-inner .quiz-review {position:relative;}
    .evt108730 .pop-container.review .contents-inner .quiz-review .view-list div {position:absolute; left:50%; top:30px; transform: translate(-50%,0);}
    .evt108730 .pop-container.review .contents-inner .quiz-review .win {position:absolute; left:50%; top:48px; transform: translate(-50%,0);}
    .evt108730 .pop-container.review .contents-inner .quiz-review .fail {position:absolute; left:50%; top:60px; transform: translate(-50%,0);}
    .evt108730 .pop-container.review .btn-share {margin-top:30px; background:transparent;}
    .evt108730 .pop-container.review .btn-close {top:-50px; right:0; background:url(//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_close02.png) no-repeat 0 0; background-size:100%;}
    @keyframes updown {
        0% {bottom:270px;}
        100% {bottom:290px;}
    }
    @keyframes leftRight {
        0% {transform: translateX(1rem);}
        100% {transform: translateX(0);}
    }
</style>
<script>
$(function() {
    /* 자세히보기 팝업 */
    $('.evt108730 .btn-detail').click(function(){
        $('.pop-container.detail').fadeIn();
    })
    /* 팝업 닫기 */
    $('.evt108730 .btn-close').click(function(){
        $(".pop-container").fadeOut();
    })
    /* slide */
    var mySwiper = new Swiper(".navi-wrap .swiper-container", {
        centeredSlides: true, //활성화된것이 중앙으로
        initialSlide:1, //활성화된 슬라이드
        slidesPerView:'auto',
    });
    $('.swiper-button-next').on('click', function(e){ //왼쪽 네비게이션 버튼 클릭
        e.preventDefault()
        mySwiper.swipePrev()
    });
    $('.swiper-button-prev').on('click', function(e){ //오른쪽 네비게이션 버튼 클릭
        e.preventDefault() 
        mySwiper.swipeNext()
    });
    var swiper = new Swiper(".section-01 .swiper-container", {
        autoplay: 1,
        speed: 2000,
        slidesPerView:1,
        pagination:".section-01 .pagination",
        loop:true
    });
    var swiper = new Swiper(".section-03 .swiper-container", {
        autoplay: 1,
        speed: 2000,
        slidesPerView:1,
        pagination:".section-03 .pagination",
        loop:true
    });
    var swiper = new Swiper(".section-08 .swiper-container", {
        autoplay: 1,
        speed: 2000,
        slidesPerView:1,
        pagination:".section-08 .pagination",
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
    /* 힌트 보기 */
    $(".btn-hint > button").click(function(){
        $(".hidden-area").toggleClass("show");
        $(this).toggleClass("show");
    })
    /* input 입력시 다음 인풋으로 이동 */
    $(function() {
        $(".quiz-area .inputs").keyup(function(e) {
            var charLimit = $(this).attr("maxlength");
            if (this.value.length >= charLimit) {
                $(this).next('.inputs').focus();
                return false;
            }
        });
    });
    $('.evt108730 .btn-apply').click(function(){
        eventTry();
    })
});
function eventTry(){
    <% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
        alert("이벤트 참여기간이 아닙니다.");
        return false;
    <% end if %>
	<% If Not(IsUserLoginOK) Then %>
			jsEventLogin();
			return false;
	<% else %>
		if($("#answer1").val() == ""){
            // 한번 시도
			alert("답을 입력해주세요.");            
			return false;
		}
		if($("#answer2").val() == ""){
			alert("답을 입력해주세요.");
			return false;
		}
		var returnCode, data
		var data={
			mode: "add",
            answer1: $("#answer1").val(),
            answer2: $("#answer2").val()
		}
		$.ajax({
			type:"POST",
			url:"/event/etc/doeventSubscript108730.asp",
			data: data,
			dataType: "JSON",
			success : function(res){
				fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode|option1','<%=eCode%>|')
					if(res!="") {
						// console.log(res)
						if(res.response == "ok"){
                            if(res.returnCode == "C01"){
                                $("#winpopup").show();
                            }
                            else{
                                $('#fail').show();
                            }
							return false;
						}else{
							alert(res.faildesc);
							return false;
						}
					} else {
						alert("잘못된 접근 입니다.");
						document.location.reload();
						return false;
					}
			},
			error:function(err){
				console.log(err)
				alert("잘못된 접근 입니다.");
				return false;
			}
		});
	<% End If %>
}
function jsEventLogin(){
    if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
        location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
        return;
    }
}
function snschk(snsnum) {
    if(snsnum == "tw") {
        popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag%>');
    }else if(snsnum=="fb"){
        popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
    }else if(snsnum=="pt"){
        pinit('<%=snpLink%>','<%=snpImg%>');
    }
    $("#answer1").val("");
    $("#answer2").val("");
    $(".pop-container").fadeOut();
}
</script>
<style type="text/css">
.hobby iframe {display:block; width:100%;}
</style>
<div class="hobby">
    <iframe id="" src="/event/etc/group/iframe_favorites.asp?eventid=108730" width="300" height="120" frameborder="0" scrolling="no" title="서촌도감"></iframe>
</div>
                <div class="evt108730">
                    
                    <div class="topic">
                        <p class="txt-hidden">텐바이텐 X 미술관옆작업실</p>
                        <span class="iocn-arrow"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_arrow_down.png" alt="arrow"></span>
                    </div>
                    <div class="section-01 flex">
                        <div class="slide-area">
                            <div class="swiper-container">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_slide1_01.png" alt="slide01">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_slide1_02.png" alt="slide02">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_slide1_03.png" alt="slide03">
                                    </div>
                                </div>
                                <!-- If we need pagination -->
                                <div class="pagination"></div>
                            </div>
                        </div>
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_sub01.jpg" alt="‘미술관옆작업실’은 디자이너 김소연 대표가 2013년부터 혼자 운영하고 있는 1인 디자인브랜드입니다. 김소연 대표는 잊혀가는 것, 아날로그적인 것들을 좋아하고, 느리지만 그녀만의 속도로 끊임없이 무언가를 디자인하고 만들고 있답니다.">
                        </div>
                    </div>
                    <div class="section-02 flex">
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_sub02.png" alt="독특하게도 ‘미술관옆작업실’은 ‘블랙앤화이트’ 컨셉으로만 디자인하여, 지극히 아날로그 느낌이 담긴 디자인의 문구제품들을 만날 수 있어요.">
                        </div>
                        <div class="half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_thum01.jpg" alt="img">
                        </div>
                    </div>
                    <div class="section-03 flex">
                        <div class="slide-area">
                            <div class="swiper-container">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_slide2_01.png" alt="slide01">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_slide2_02.png" alt="slide02">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_slide2_03.png" alt="slide03">
                                    </div>
                                </div>
                                <!-- If we need pagination -->
                                <div class="pagination"></div>
                            </div>
                        </div>
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_sub03.jpg" alt="원고지를 모티브로 하여 디자인한 메모지, 엽서, 편지지, 일기장, 노트는 물론이고 사각거림이 좋아 아직도 사용하고 있는 연필 등 아날로그 디자인 문방구답게 아날로그적인 문구 제품들이 있는 곳이랍니다.">
                        </div>
                    </div>
                    <div class="section-04 flex">
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_sub04.png" alt="여러분도 더욱 생생한 그 감성을 느끼기 위해 '미술관옆작업실' 을 방문해보세요!">
                        </div>
                        <div class="half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_thum02.jpg" alt="img">
                        </div>
                    </div>
                    <div class="section-05">
                        <div class="tit txt-hidden">미술관옆작업실에 대해 더 알아보기</div>
                    </div>
                    <div class="section-06">
                        <!-- 선물 자세히 보기 버튼 -->
                        <button type="button" class="btn-detail"></button>
                    </div>
                    <div class="section-07">
                        <!-- 퀴즈 영역 -->
                        <div class="tit">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_tit_quiz.jpg?v=2" alt="미술관옆작업실 초성 퀴즈">
                            <!-- 선물 자세히 보기 버튼 -->
                            <button type="button" class="btn-detail"></button>
                        </div>
                        <div class="quiz-area">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_apply_quiz.jpg" alt="디자이너 혼자 디자인하고 만드는 아날로그 문구브랜드 미술관옆작업실">
                            <!-- 정답 입력 input -->
                            <input type="text" class="input01 inputs" id="answer1" maxlength="3" value="" placeholder="ㅈㅇㄴ">
                            <input type="text" class="input02 inputs" id="answer2" maxlength="3" value="" placeholder="ㄴㄹㄱ">
                            <!-- 정답제출 버튼 -->
                            <div class="btn-apply">
                                <button type="button"></button>
                            </div>
                        </div>
                        <div class="hint-area">
                            <!-- 힌트 보기 버튼 -->
                            <div class="icon-click"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_click.png" alt="click"></div>
                            <div class="btn-hint"><button type="button"><img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/btn_off.png" alt="hint button"></button></div>
                            <div class="hidden-area"><img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/img_hint.jpg" alt="이벤트 상단, 장소 소개글의 굵은 글씨가 힌트!"></div>
                        </div>
                    </div>
                    <div class="section-08">
                        <div class="txt-hidden">sns 이벤트 알림 : 미술관옆작업실 앞 포토존에서 사진을 찍은 후 태그 후 인스타그램에 업로드해주세요</div>
                    </div>
                    <div class="section-09">
                        <!-- 인스타그램으로 이동 -->
                        <a href="https://tenten.app.link/JCGXoJNWdcb" onclick="fnAmplitudeEventMultiPropertiesAction('landing_instagram','evtcode|option1','<%=eCode%>|');" target="_blank"><span class="txt-hidden">미술관옆작업실 구경하러 가기</span></a>
                        <!-- 즐겨찾길 메인으로 이동 -->
                        <a href="https://tenten.app.link/Cl6bQPapxdb" onclick="fnAmplitudeEventMultiPropertiesAction('landing_bookmark_seochon','evtcode|option1','<%=eCode%>|');" target="_blank"><span class="txt-hidden">텐바이텐 x 서촌 # 즐겨찾길 구경하러 가기</span></a>
                    </div>
                    <!-- 팝업 - 자세히 보기 -->
                    <div class="pop-container detail">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/pop_detail.png" alt="집에서 느끼는 미술관옆작업실 감성 KIT">
                                    <button type="button" class="btn-close">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 팝업 - 정답인 경우 -->
                    <div class="pop-container win" id="winpopup">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/pop_win.png?v=2" alt="축하합니다! 본 이벤트에 응모가 완료되었습니다. 당첨자 발표는 3월 19일 텐바이텐 공지사항에서 확인 가능합니다!">
                                    <button type="button" class="btn-close">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 팝업 - 오답인 경우 -->
                    <div class="pop-container fail" id="fail">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/108730/pop_fail.png" alt="아쉽지만 오답! 링크 공유하고 한 번 더 풀기">
                                    <button type="button" class="btn-close">닫기</button>
                                    <button type="button" class="btn-review" onclick="snschk('fb');return false;"></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
<!-- #include virtual="/lib/db/dbclose.asp" -->