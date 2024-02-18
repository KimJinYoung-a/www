<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  디지털 스티커 무료 배포 3탄
' History : 2022.11.09 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, vUserID
dim eventStartDate, eventEndDate, currentDate, mktTest
dim diaryStartDate, stickerEndDate
dim diaryidx, sticker1, sticker2

vUserID = GetEncLoginUserID()
'vUserID = "10x10yellow"

IF application("Svr_Info") = "Dev" THEN
    eCode = "119226"
    mktTest = True
    diaryidx=5240
    sticker1=5218
    sticker2=5288
ElseIf application("Svr_Info")="staging" Then
    eCode = "121032"
    mktTest = True
    diaryidx=5278
    sticker1=5277
    sticker2=5288
Else
    eCode = "121032"
    mktTest = False
    diaryidx=5278
    sticker1=5277
    sticker2=5288
End If

eventStartDate  = cdate("2022-11-14")		'이벤트 시작일
eventEndDate 	= cdate("2023-12-31")		'이벤트 종료일
diaryStartDate  = cdate("2022-11-14")		'이벤트 시작일
stickerEndDate 	= cdate("2023-11-14")		'이벤트 종료일
if mktTest then
currentDate = cdate("2022-11-14")
else
currentDate = date()
end if
%>
<link rel="stylesheet"href="https://unpkg.com/swiper@8/swiper-bundle.min.css"/>
<style>
.evt121032 {max-width:1920px; margin:0 auto; background:#fff;}
.evt121032 .topic {height:632px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/121032/main.jpg) no-repeat 50% 0;}
.evt121032 .txt-hidden {font-size:0; text-indent:-9999px;}
.evt121032 .relative {position:relative;}
.evt121032 .w1140 {width:1140px; margin:0 auto;}
.evt121032 .fix-tab.fixed {position:fixed; left:0; top:0;}
.evt121032 .fix-tab.fixed.hide {display:none;}
.evt121032 .fix-tab {display:flex; justify-content:center; width:100%; z-index:10; background:#111;}
.evt121032 .fix-tab .tabs {position:relative; width:570px; height:75px; display:flex; align-items:center; justify-content:center; text-align:center; font-size:23px; color:#a2a2a2; background:#111;}
.evt121032 .fix-tab .tabs.active {color:#ff4244; font-weight:700;}
.evt121032 .fix-tab .tabs.active::before {content:""; position:absolute; left:0; bottom:0; width:100%; height:6px; background:#ff4244;}
.evt121032 .fix-tab .new {position:absolute; top:-14px; right:-49px; font-size:21px; color:#ffde45; font-family:var(--rg);}
.evt121032 .fix-tab .tit {position:relative;}
.evt121032 .fix-tab.hide {display:none;}
.evt121032 .info-list {position:relative; display:flex; flex-wrap:wrap; align-content:flex-start; justify-content:center; width:760px; margin:0 auto; background:#f9f9f9;}
.evt121032 .info-list li {display:inline; width:auto; height:47px; padding:0 20px; margin:0 4px 18px; line-height:47px; color:#fff; font-size:26px; background:#111; border-radius:25px;}
.evt121032 .info-list li.select {background:#ff4244; border:0;}
.evt121032 .tab-diary {background:#f9f9f9;}
.evt121032 .page {position:relative; height:1339px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/121032/sub03.jpg) no-repeat 50% 0;}
.evt121032 .page .btn-down {position:absolute; left:50%; bottom:105px; width:400px; height:100px; margin-left:-200px; background:transparent;}

.evt121032 .mySwiper {background:#fff;}
.evt121032 .mySwiper .list {display:flex; align-items:center; justify-content:center; flex-direction:column; width:169px; height:169px; background:#ffebaf; border-radius:100%;}
.evt121032 .mySwiper .list.new{border:7px solid #ff4244;width:155px;height:155px;}
.evt121032 .mySwiper .list .month {margin-bottom:16px; font-size:27px; font-weight:600; color:#a39057; line-height:1;}
.evt121032 .mySwiper .list .name {font-size:33px; font-weight:700; color:#111; line-height:1;}
.evt121032 .mySwiper .list.december {background:#ffdbe8;}
.evt121032 .mySwiper .list.december .month {color:#ed88ac;}
.evt121032 .mySwiper .list.december .name {font-size:28px;}
.evt121032 .mySwiper .swiper-slide {width:183px;}
.evt121032 .mySwiper .list.coming {background:#eeeeee; border:0;}
.evt121032 .mySwiper .list.coming .month {color:#b4b4b4; font-weight:700;}
.evt121032 .mySwiper .list.coming .name {color:#b4b4b4; font-weight:700;}
.evt121032 .mySwiper .new {position:absolute; left:-11px; top:0;}
.evt121032 .mySwiper .bg-white {position:absolute; right:26px; top:0; width:140px; height:280px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/121032/m/bg_white.png) no-repeat 0 0; z-index:5;}
.evt121032 .mySwiper .bg-white.left {position:absolute; left:0; top:0; width:140px; height:280px; transform:rotate(180deg); background:url(//webimage.10x10.co.kr/fixevent/event/2022/121032/m/bg_white.png) no-repeat 0 0; z-index:5;}
.evt121032 .swiper-button-prev {left:5vw; color:#9a9a9a;}
.evt121032 .swiper-button-next {right:5vw; color:#9a9a9a;}

.evt121032 .show-sticker {padding-bottom:80px; margin-top:60px; background:#fff;}
.evt121032 .show-sticker .btn-down {position:absolute; left:50%; top:462px; width:400px; height:120px; margin-left:-200px; background:transparent;}
.evt121032 .show-sticker .link01 {position:absolute; right:76px; bottom:267px; width:200px; height:90px;}
.evt121032 .show-sticker .page-nation {display:flex; align-items:center; justify-content:center; margin:46px;}
.evt121032 .show-sticker .page-nation li {margin:0 26px;}
.evt121032 .show-sticker .page-nation button {width:34px; height:34px; font-size:23px; color:#b1b1b1; background:transparent;}
.evt121032 .show-sticker .page-nation button.active {color:#fff; background:#ff4244; border-radius:100%;}
.evt121032 .show-sticker .page-nation .left {width:13px; height:25px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/121032/m/arrow.png) no-repeat 0 0; background-size:100%; font-size:0; text-indent:-9999px;}
.evt121032 .show-sticker .page-nation .right {width:13px; height:25px; transform:rotate(180deg); background:url(//webimage.10x10.co.kr/fixevent/event/2022/121032/m/arrow.png) no-repeat 0 0; background-size:100%; font-size:0; text-indent:-9999px;}
.evt121032 .show-sticker .txt01 {font-size:21px; color:#b1b1b1;}
.evt121032 .noti {height:1367px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/121032/sub06.jpg) no-repeat 50% 0;}
div.fullEvt #contentWrap .eventWrapV15 {
    width: unset;
    left: unset;
    transform: unset;
}
</style>
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<script>
$(function(){
    $('.fix-tab div').on('click',function(){
        $('.fix-tab div').removeClass('active');
        $(this).addClass('active');
    });
    $('.diary').on('click',function(){
        $('.tab-diary').show();
        $('.tab-sticker').hide();
    });
    $('.sticker').on('click',function(){
        $('.tab-sticker').show();
        $('.tab-diary').hide();
    });
    var fun = function() {
        $('.info-list>li').removeClass('select');
        $('.info-list>li:nth-child('+no+')').addClass('select');
        no=no+1;
        if(no>8)no=1;
    }
    var no=1;
    tid0 = setInterval(fun,1000);
    var swiper = new Swiper(".mySwiper", {
        slidesPerView:'auto',
        autoplay:false,
        loop:false,
        speed:500,
        centeredSlides:true,
        spaceBetween:50,
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        initialSlide: 1,
        on: {
            activeIndexChange: function () {
                if(this.realIndex<2){
                    $("#stickerdiv0").hide();
                    $("#stickerdiv1").hide();
                }
                $("#stickerdiv"+this.realIndex).show();
            }
        },
    });
    var didScroll;  
    $(window).scroll(function(event){ 
        didScroll = true;
    }); 
    setInterval(function() { 
        if (didScroll) 
        { hasScrolled(); didScroll = false; }
    }, 250);
    
    function hasScrolled() {
        var lastScrollTop = 0;
        var fixStart = $('.fix-start').offset().top;
        var downEnd = $('.dead-line').offset().top;

        var st = $(this).scrollTop();
        if(st > fixStart) {
            $('.fix-tab').addClass('fixed');
        } else {
            $('.fix-tab').removeClass('fixed'); 
        }

        if(st > downEnd) {
            $('.fix-tab').addClass('hide');
        } else {
            $('.fix-tab').removeClass('hide'); 
        }
    }
});
function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}
function fnDownloadFile(idx){
	<% If Not(IsUserLoginOK) Then %>
        jsSubmitlogin();
		return false;
	<% else %>
        $.ajax({
            type: "POST",
            url:"/event/etc/doEventSubscript121032.asp",
            data: {
                mode: 'down',
                downloadidx: idx
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('goodnote_event_download','evtcode','<%=eCode%>');
                    fileDownload(idx);
                }else if(data.response == "err"){
                    alert(data.message);
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
    <% end if %>
}
function fnMoveBrand(){
    top.location.href="/street/street_brand_sub06.asp?makerid=misstop88";
	return false;
}
</script>
						<div class="evt121032">
							<div class="topic">
                                <h2 class="txt-hidden">굿노트 다이어리 2023</h2>
                            </div>
                            <section class="section01">
                                <div class="fix-start"></div>
                                <!-- 상단 고정 탭 -->
                                <div class="fix-tab">
                                    <div class="tabs diary active">
                                        <!-- new 글자 오픈 15일후 사라짐 -->
                                        <span class="tit">다이어리 다운받기<% if datediff("d",diaryStartDate,currentDate) < 16 then %> <span class="new">new</span><% end if %></span>
                                    </div>
                                    <div class="tabs sticker">
                                        <span class="tit">스티커 다운받기<% if datediff("d",stickerEndDate,currentDate) < 16 then %> <span class="new">new</span><% end if %></span>
                                    </div>
                                </div>
                                <!-- 다이어리 영역 -->
                                <div class="tab-diary">
                                    <div class="w1140">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/121032/sub01.jpg" alt="다이어리 템플릿 구성 한눈에 보기">
                                        <ul class="info-list">
                                            <li class="list1">Cover</li>
                                            <li class="list2">Yearly</li>
                                            <li class="list3">Monthly</li>
                                            <li class="list4">Weekly&To do list</li>
                                            <li class="list5">4 type note</li>
                                            <li class="list6">Bucket list</li>
                                            <li class="list7">Wish list</li>
                                            <li class="list8">Habit tracker</li>
                                        </ul>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/121032/sub02.jpg" alt="모두가 갓생사는 사회">
                                    </div>
                                    <div class="page">
                                        <button type="button" class="btn-down txt-hidden" onclick="fnDownloadFile(<%=diaryidx%>);">다운로드 받기</button>
                                    </div>
                                </div>
                                <div class="tab-sticker" style="display:none;">
                                    <div class="w1140">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/121032/sub04.jpg" alt="세상에서 제일 귀여운 스티커 구경하기">
                                        <div class="swiper mySwiper">
                                            <div class="swiper-wrapper">
                                                <div class="swiper-slide">
                                                    <div class="list">
                                                        <span class="month">11월</span>
                                                        <span class="name">룸룸</span>
                                                    </div>
                                                </div>
                                                <div class="swiper-slide">
                                                    <div class="list new december">
                                                        <% if datediff("d",stickerEndDate,currentDate) < 16 then %><span class="new"><img src="//webimage.10x10.co.kr/fixevent/event/2022/121032/new.png" alt="new"></span><% end if %>
                                                        <span class="month">12월</span>
                                                        <span class="name">라고미네집</span>
                                                    </div>
                                                </div>
                                                <div class="swiper-slide">
                                                    <div class="list coming">
                                                        <span class="month">Coming</span>
                                                        <span class="name">Soon</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="swiper-button-prev"></div>
                                            <div class="swiper-button-next"></div>
                                            <div class="bg-white"></div>
                                            <div class="bg-white left"></div>
                                        </div>
                                        <div class="show-sticker">
                                            <div class="relative" id="stickerdiv0" style="display:none">
                                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/121032/sub05.jpg" alt="스티커1">
                                                <button type="button" class="btn-down txt-hidden" onclick="fnDownloadFile(<%=sticker1%>);">다운로드 받기</button>
                                                <a href="/street/street_brand_sub06.asp?makerid=roomx2" class="link01 txt-hidden">브랜드 구경하기</a>
                                            </div>
                                            <div class="relative" id="stickerdiv1">
                                                <img src="//webimage.10x10.co.kr/fixevent/event/2022/121032/sub05_01.jpg" alt="스티커2">
                                                <button type="button" class="btn-down txt-hidden" onclick="fnDownloadFile(<%=sticker2%>);">다운로드 받기</button>
                                                <a href="/street/street_brand_sub06.asp?makerid=homelagomi" class="link01 txt-hidden">브랜드 구경하기</a>
                                            </div>
                                            <!-- <ul class="page-nation">
                                                <li><button type="button" class="left">left</button></li>
                                                <li><button type="button" class="active">1</button></li>
                                                <li><button type="button" class="right">right</button></li>
                                            </ul> -->
                                            <div class="txt01">* 아이패드,갤럭시 탭 등 태블릿 PC에서 자유롭게 활용할 수 있으며, 상업적인 용도로는 사용 불가합니다.</div>
                                        </div>
                                    </div>
                                    <div class="noti txt-hidden">다이어리 및 스티커 사용방법</div>
                                </div>
                            </section>
                            <div class="dead-line"></div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->