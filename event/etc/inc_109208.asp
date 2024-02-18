<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : 서촌도감01 - 오프투얼론
' History : 2021.02.10 정태훈 생성
'###########################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
dim oItem
dim currentDate, eventStartDate, eventEndDate
	currentDate =  now()
'	currenttime = #11/10/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  104316
Else
	eCode   =  109208
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if userId="ley330" or userId="greenteenz" or userId="rnldusgpfla" or userId="cjw0515" or userId="thensi7" or userId = "motions" or userId = "jj999a" or userId = "phsman1" or userId = "jjia94" or userId = "seojb1983" or userId = "kny9480" or userId = "bestksy0527" or userId = "mame234" or userid = "corpse2" then
	currentDate = #02/15/2021 09:00:00#
end if

eventStartDate  = cdate("2021-02-15")		'이벤트 시작일
eventEndDate 	= cdate("2021-02-28")		'이벤트 종료일
%>
<style type="text/css">
    .evt109208 {background:#fff;}
    .evt109208 .txt-hidden {text-indent: -9999px; font-size:0;}
    .evt109208 .topic {position:relative; width:100%; height:1313px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/img_tit.jpg) no-repeat 50% 0;}
    .evt109208 .topic .iocn-arrow {position:absolute; left:50%; bottom:280px; transform:translate(-50%,0); animation: updown .7s ease-in-out alternate infinite;}
    .evt109208 .section-01 .swiper-wrapper,
    .evt109208 .section-03 .swiper-wrapper,
    .evt109208 .section-08 .swiper-wrapper {display:flex; align-items:center; height: 100% !important;}
    .evt109208 .swiper-container {height:100%;}
    .evt109208 .swiper-container .swiper-slide {height:100% !important;}
    .evt109208 .section-01 .slide-area,
    .evt109208 .section-03 .slide-area {width:50%; position:relative;}
    .evt109208 .section-08 .slide-area {width:580px; position:relative;}
    .evt109208 .section-03 .detail-pop {position:relative;}
    .evt109208 .section-03 .detail-pop button {position:absolute; left:50%; top:360px; transform: translate(-90%,0); width:490px; height:100px; background:transparent;}
    .evt109208 .section-01 .half,
    .evt109208 .section-02 .half,
    .evt109208 .section-03 .half,
    .evt109208 .section-04 .half {width:50%;} 
    .evt109208 .section-02 .animate-txt {text-align:right; padding:117px 50px 0 0;}
    .evt109208 .section-04 .animate-txt {text-align:right; padding:210px 50px 0 0;}

    .evt109208 .section-06 {position:relative; width:100%; height:1549px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/img_benefit_02.jpg) no-repeat 50% 0;}
    .evt109208 .section-07 {background:#e79a48; padding-bottom:25px;}
    .evt109208 .section-07 .tit {position:relative;}
    .evt109208 .section-07 .tit .btn-gift {position:absolute; left:50%; top:373px; width:450px; height:95px; transform:translate(-35%, 0); background:transparent;}
    .evt109208 .event-dot-area {position:relative; padding-bottom:60px;}
    .evt109208 .event-dot-area button {position:relative; display:inline-block; width:1.31rem; height:1.31rem; background:rgba(255,255,255,0.3); border-radius:100%; animation:wide 1s alternate infinite;}
    .evt109208 .event-dot-area button span {position:absolute; left:50%; top:50%; transform:translate(-50%,-50%); display:inline-block; width:0.60rem; height:0.60rem; background:#fff; border-radius:100%;} 
    .evt109208 .event-dot-area .dot {position:absolute; left:50%; top:0; transform:translate(-50%,0); display:flex; align-items:center; justify-content:center; width:100px; height:100px; cursor:pointer;}
    .evt109208 .event-dot-area .item-01 {top:113px; transform:translate(-113%,0);}
    .evt109208 .event-dot-area .item-01:hover::before {content:""; width:481px; height:249px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/img_intro01.png) no-repeat 0 0; background-size:100%; position:absolute; left:50%; top:33px; transform:translate(-10%,0);}
    .evt109208 .event-dot-area .item-02 {top:230px; transform:translate(-168%,0);}
    .evt109208 .event-dot-area .item-02:hover::before {content:""; width:481px; height:295px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/img_intro02.png) no-repeat 0 0; background-size:100%; position:absolute; left:50%; top:33px; transform:translate(-90%,0);}
    .evt109208 .event-dot-area .item-03 {top:223px; transform:translate(54%,0);}
    .evt109208 .event-dot-area .item-03:hover::before {content:""; width:481px; height:272px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/img_intro03.png) no-repeat 0 0; background-size:100%; position:absolute; left:50%; top:33px; transform:translate(-10%,0);}
    .evt109208 .event-dot-area .item-04 {top:343px; transform:translate(-198%,0);}
    .evt109208 .event-dot-area .item-04:hover::before {content:""; width:480px; height:273px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/img_intro04.png) no-repeat 0 0; background-size:100%; position:absolute; left:50%; top:33px; transform:translate(-90%,0);}
    .evt109208 .event-dot-area .item-05 {top:355px; transform:translate(42%,0);}
    .evt109208 .event-dot-area .item-05:hover::before {content:""; width:480px; height:296px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/img_intro05.png) no-repeat 0 0; background-size:100%; position:absolute; left:50%; top:33px; transform:translate(-10%,0);}
    .evt109208 .event-dot-area .item-06 {top:610px; transform:translate(-158%,0);}
    .evt109208 .event-dot-area .item-06:hover::before {content:""; width:481px; height:272px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/img_intro06.png) no-repeat 0 0; background-size:100%; position:absolute; left:50%; top:33px; transform:translate(-90%,0);}
    .evt109208 .event-check-book {position:relative;}
    .evt109208 .event-check-book .item-books {display:flex; align-items:flex-start; justify-content:center; position:absolute; left:50%; top:52px; transform:translate(-50%,0);}
    .evt109208 .event-check-book .item-books li {height:200px; margin-right:10px;}
    .evt109208 .event-check-book .item-books li:nth-child(1) {width:110px; margin-right:15px;}
    .evt109208 .event-check-book .item-books li:nth-child(2) {width:100px;}
    .evt109208 .event-check-book .item-books li:nth-child(3) {width:105px; margin-right:15px;}
    .evt109208 .event-check-book .item-books li:nth-child(4) {width:100px;}
    .evt109208 .event-check-book .item-books li:nth-child(5) {width:110px;}
    .evt109208 .event-check-book .item-books li:nth-child(6) {width:130px; margin-right:0;}
    .evt109208 .event-check-book .item-books li button {width:100%; height:100%; background:transparent;}
    .evt109208 .event-check-book .item-books li button:before {content:""; display:inline-block; width:28px; height:23px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/icon_check.png) no-repeat 0 0; background-size:100%; opacity:0;}
    .evt109208 .event-check-book .item-books li .btn-checks.on:before {opacity:1;}
    .evt109208 .event-check-book .item-books li:nth-child(1) button:before {position:absolute; left:27px; top:10px;}
    .evt109208 .event-check-book .item-books li:nth-child(2) button:before {position:absolute; left:153px; top:10px;}
    .evt109208 .event-check-book .item-books li:nth-child(3) button:before {position:absolute; left:270px; top:10px;}
    .evt109208 .event-check-book .item-books li:nth-child(4) button:before {position:absolute; left:380px; top:10px;}
    .evt109208 .event-check-book .item-books li:nth-child(5) button:before {position:absolute; left:505px; top:10px;}
    .evt109208 .event-check-book .item-books li:nth-child(6) button:before {position:absolute; left:650px; top:10px;}
    .evt109208 .event-comment-book {position:relative; display:flex; align-items:flex-start; justify-content:center; padding-bottom:120px;}
    .evt109208 .event-comment-book .top {width:314px; height:227px; padding-top:28px; background:#ffd3ae; border-radius:20px 0 0 20px;}
    .evt109208 .event-comment-book .content {width:660px; height:255px; background:#fff; text-align:left; display:flex; align-items:center; justify-content:center; border-radius:0 20px 20px 0;}
    .evt109208 .event-comment-book .content textarea {width:570px; height:155px; resize:none; border:0; font-size:20px; color:#333; line-height:1.3;}
    .evt109208 .event-comment-book .content textarea::placeholder {font-size:20px; color:#999;}
    .evt109208 .event-comment-book .btn-apply {position:absolute; left:50%; bottom:0; transform:translate(-50%,0); background:transparent;}
    .evt109208 .comment-list-wrap {display:flex; align-items:flex-start; justify-content:center; flex-wrap:wrap; width:1140px; margin:0 auto;}
    /* 2021-02-10 수정 */
    .evt109208 .event-comment-area {position:relative; width:310px; height:405px; padding:20px; margin:0 7.5px 15px; background:#906230; border-radius:10px;}
    .evt109208 .event-comment-area .num {font-size:15px; color:#e79a48; text-align:left;}
    .evt109208 .event-comment-area .id {padding-top:1rem; font-size:15px; color:#ffc484; text-align:left;}
    .evt109208 .event-comment-area .txt {height:196px; padding-top:10px; font-size:17px; color:#fff; line-height:1.3; overflow:hidden; text-align:left;}
    .evt109208 .event-comment-area .img {text-align:center;}
    .evt109208 .event-comment-area .comment-close {background:transparent; position:absolute; right:20px; top:20px; width:25px; height:25px;}
    .evt109208 .event-comment-area .comment-close img {width:100%;}
    /* // */
    .evt109208 .pagination-wrap {display:flex; align-items:center; justify-content:center; margin-top:15px;}
    .evt109208 .pagination-wrap li a {display:inline-block; padding:25px; font-size:24px; color:#5c2b01;}
    .evt109208 .pagination-wrap li a img {width:11px; height:19px; padding-bottom:4px; vertical-align:middle;}

    .evt109208 .section-09 {width:100%; height:216px; display:flex; align-items:center; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/img_link.jpg) no-repeat 50% 0;}
    .evt109208 .section-09 a {display:inline-block; width:100%; height:100%;}
    .evt109208 .section-08 {position:relative; width:100%; height:869px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/img_sns.jpg) no-repeat 50% 0;}
    .evt109208 .section-08 button {width:500px; height:100px; position:absolute; left:50%; top:490px; transform:translate(0%,0); background:transparent;}
    .evt109208 .section-05 .tit {width:100%; height:2702px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/img_qa.jpg) no-repeat 50% 0;}
    .evt109208 .section-05 .btn-apply {margin-top:24px; background:transparent;}
    .evt109208 .animate-txt {opacity:0; transform:translateY(10%); transition:all 1s;}
    .evt109208 .animate-txt.on {opacity:1; transform:translateY(0);}
    
    .evt109208 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
    .evt109208 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
    .evt109208 .pop-container .pop-inner a {display:inline-block;}
    .evt109208 .pop-container .pop-inner .btn-close {position:absolute; right:28px; top:28px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
    .evt109208 .pop-container .pop-inner .btn-close02 {position:absolute; right:28px; top:28px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/109208/icon_close02.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
    .evt109208 .pagination {position:absolute; right:2rem; bottom:6%; z-index:100;}
    .evt109208 .pagination .swiper-pagination-switch.swiper-active-switch {background-color:#ec4a18;}
    .evt109208 .pagination .swiper-pagination-switch {display:inline-block; width:12px; height:12px; margin:0 0.5rem; background-color:#ededed; border-radius:100%;}
    .evt109208 .flex {display:flex;}

    .evt109208 .pop-container.set .contents-inner,
    .evt109208 .pop-container.detail .contents-inner {width:790px; margin:0 auto; position:relative;}
    .evt109208 .pop-container.apply .contents-inner {width:670px; margin:0 auto; position:relative;}
    .evt109208 .pop-container.gift .contents-inner {width:1160px; margin:0 auto; position:relative;}
    @keyframes updown {
        0% {bottom:270px;}
        100% {bottom:290px;}
    }
    @keyframes wide {
        0% { transform: scale(0) }
        100% { transform: scale(1) }
    }
</style>
<script>
$(function() {
    /* '리소 인쇄물과 진 설명보기' 팝업 */
    $('.evt109208 .btn-detail').click(function(){
        $('.pop-container.detail').fadeIn();
    })
    /* 선물보기 팝업 */
    $('.evt109208 .btn-set').click(function(){
        $('.pop-container.set').fadeIn();
    })
    /* 책 선물보기 팝업 */
    $('.evt109208 .btn-gift').click(function(){
        $('.pop-container.gift').fadeIn();
    })
    /* 팝업 닫기 */
    $('.evt109208 .btn-close').click(function(){
        $(".pop-container").fadeOut();
    })
    $('.evt109208 .btn-close02').click(function(){
        $(".pop-container").fadeOut();
    })
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
    /* hover 일때 버튼 숨김 */
        $(".event-dot-area .dot").on("mouseover",function(){
            $(".event-dot-area .dot > button").css("display","none");
        });
        $(".event-dot-area .dot").on("mouseleave",function(){
            $(".event-dot-area .dot > button").css("display","block");
        });
    /* event check */
    $(".item-books li").on("click",function(){
        $(this).children(".btn-checks").toggleClass("on");
        $(this).siblings().find(".btn-checks").removeClass("on");    
    });
    jsGoComPage(1);
});

function fnSelectBook(booknum){
    $(".item-book-01").empty().append("<img src='//webimage.10x10.co.kr/fixevent/event/2021/109208/item_book0" + booknum + ".png' alt='books title'>");
    $("#booknum").val(booknum);
}

function eventTry(){
    <% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
        alert("이벤트 참여기간이 아닙니다.");
        return false;
    <% end if %>
    <% If Not(IsUserLoginOK) Then %>
        calllogin();
        return false;
    <% else %>
            if(!$("#booknum").val()){
                alert("읽고 싶은 도서를 선택해주세요!");
                return false;
            }

            if(!$("#txtComm").val()){
                alert("도서를 읽고 싶은 이유를 적어주세요!");
                return false;
            }

            if (GetByteLength($("#txtComm").val()) > 400){
                alert("띄어쓰기 포함 200자 이내로 작성해주세요!");
                return false;
            }
            var makehtml="";
            var returnCode, itemid, data
            var data={
                mode: "add",
                booknum: $("#booknum").val(),
                txtcomm: $("#txtComm").val()
            }
            $.ajax({
                type:"POST",
                url:"/event/etc/doeventsubscript/doEventSubscript109208.asp",
                data: data,
                dataType: "JSON",
                success : function(res){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode|option1','<%=eCode%>|' + $("#booknum").val());
                        if(res!="") {
                            // console.log(res)
                            if(res.response == "ok"){
                                $('.pop-container.apply').fadeIn();
                                $('#txtComm').val("");
								jsGoComPage(1);
                                return false;
                            }else{
                                alert(res.faildesc);
                                return false;
                            }
                        } else {
                            alert("잘못된 접근 입니다.1");
                            document.location.reload();
                            return false;
                        }
                },
                error:function(err){
                    console.log(err)
                    alert("잘못된 접근 입니다2.");
                    return false;
                }
            });
    <% End If %>
}

function fndelComment(idx){
    <% If Not(IsUserLoginOK) Then %>
        calllogin();
        return false;
    <% else %>
        if (confirm("삭제 하시겠습니까?")){

        }
        else{
            return false;
        }
        var makehtml="";
        var returnCode, itemid, data
        var data={
            mode: "del",
            Cidx: idx
        }
        $.ajax({
            type:"POST",
            url:"/event/etc/doeventsubscript/doEventSubscript109208.asp",
            data: data,
            dataType: "JSON",
            success : function(res){
                    if(res!="") {
                        // console.log(res)
                        if(res.response == "ok"){
                            jsGoComPage(1);
                            return false;
                        }else{
                            alert(res.faildesc);
                            return false;
                        }
                    } else {
                        alert("잘못된 접근 입니다.1");
                        document.location.reload();
                        return false;
                    }
            },
            error:function(err){
                console.log(err)
                alert("잘못된 접근 입니다2.");
                return false;
            }
        });
    <% End If %>
}

function jsGoComPage(vpage){
    $.ajax({
        type: "POST",
        url: "/event/etc/list_109208.asp",
        data: {
            iCC: vpage
        },
        success: function(Data){
            $("#diarylist").html(Data);
        },
        error: function(e){
            console.log('데이터를 받아오는데 실패하였습니다.')
            //$("#listContainer").empty();
        }
    })
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	}
}
</script>
<style type="text/css">
.hobby iframe {display:block; width:100%;}
</style>
<div class="hobby">
    <iframe id="" src="/event/etc/group/iframe_favorites.asp?eventid=109208" width="300" height="120" frameborder="0" scrolling="no" title="서촌도감"></iframe>
</div>
                <div class="evt109208">
                    <div class="topic">
                        <p class="txt-hidden">텐바이텐 X 즐겨찾길_서촌01</p>
                        <span class="iocn-arrow"><img src="//webimage.10x10.co.kr/fixevent/event/2020/108094/icon_arrow_down.png" alt="arrow"></span>
                    </div>
                    <div class="section-01 flex">
                        <!-- 롤링 영역 -->
                        <div class="slide-area">
                            <div class="swiper-container">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_slide1_01.png" alt="slide01">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_slide1_02.png" alt="slide02">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_slide1_03.png" alt="slide03">
                                    </div>
                                </div>
                                <!-- If we need pagination -->
                                <div class="pagination"></div>
                            </div>
                        </div>
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_sub01.jpg" alt="서촌 통인시장을 걷다 입구에서 왼쪽 두 번째 골목에서 골목 속 숨겨진 ‘off to ALONE(오프투얼론)’을 만나볼 수 있어요. ‘오프투얼론’의 외관은 한옥을 개조해 서촌 골목에 운치를 더해주고, 이 골목에서 6년동안 자리를 지키고 있답니다.">
                        </div>
                    </div>
                    <div class="section-02 flex">
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_sub02_01.png" alt="실내에는 한옥의 요소들과 감각적인 일러스트레이션 오브제가 조화를 이뤄 색다른 공간을 연출하고 있어요.  거기에 노란 조명과 원목 아이템들로 ‘오프투얼론’의 공간을 더욱 따뜻하게 만들어 준답니다.">
                        </div>
                        <div class="half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_thum01.jpg" alt="img">
                        </div>
                    </div>
                    <div class="section-03 flex">
                        <!-- 롤링 영역 -->
                        <div class="slide-area">
                            <div class="swiper-container">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_slide2_01.png" alt="slide01">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_slide2_02.png" alt="slide02">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_slide2_03.png" alt="slide03">
                                    </div>
                                </div>
                                <!-- If we need pagination -->
                                <div class="pagination"></div>
                            </div>
                        </div>
                        <div class="animate-txt detail-pop half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_sub03.jpg" alt="디자인과 일러스트레이션 중심의 독립 출판물부터 리소 인쇄물과 진(zine), 포스터, 엽서 그리고 귀여운 굿즈까지 이 작은 공간에 가득 담겨있어요.">
                            <button type="button" class="btn-detail"></button>
                            <!-- 상세설명 보기 버튼 -->
                        </div>
                    </div>
                    <div class="section-04 flex">
                        <div class="animate-txt half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_sub04_01.png" alt="여러분도 ‘오프투얼론’을 직접 방문하고 책방지기의 취향을 경험해보세요!">
                        </div>
                        <div class="half">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_thum02.jpg" alt="img">
                        </div>
                    </div>
                    <div class="section-05">
                        <div class="tit txt-hidden">off to alone에 대해 더 알아보기</div>
                    </div>
                    <div class="section-06">
                        <div class="txt-hidden">텐바이텐과 오프투얼론이 준비한 혜택</div>
                    </div>
                    <div class="section-07">
                        <!-- 이벤트 영역 -->
                        <div class="tit">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_tit_event.jpg" alt="텐바이텐에서 만나보는 우프투얼론의 책장!">
                            <!-- 선물 자세히 보기 버튼 -->
                            <button type="button" class="btn-gift"></button>
                        </div>
                        <div class="event-dot-area">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_event_intro.jpg" alt="event">
                            <div class="item-01 dot">
                                <button type="button"><span></span></button>
                            </div>
                            <div class="item-02 dot">
                                <button type="button"><span></span></button>
                            </div>
                            <div class="item-03 dot">
                                <button type="button"><span></span></button>
                            </div>
                            <div class="item-04 dot">
                                <button type="button"><span></span></button>
                            </div>
                            <div class="item-05 dot">
                                <button type="button"><span></span></button>
                            </div>
                            <div class="item-06 dot">
                                <button type="button"><span></span></button>
                            </div>
                        </div>
                        <!-- 읽고싶은 책 선택 영역 -->
                        <div class="event-check-book">
                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_event_check.jpg" alt="event">
                            <ul class="item-books">
                                <li class="item-checks-01"><button type="button" class="btn-checks" onclick="fnSelectBook(1);"></button></li>
                                <li class="item-checks-02"><button type="button" class="btn-checks" onclick="fnSelectBook(2);"></button></li>
                                <li class="item-checks-03"><button type="button" class="btn-checks" onclick="fnSelectBook(3);"></button></li>
                                <li class="item-checks-04"><button type="button" class="btn-checks" onclick="fnSelectBook(4);"></button></li>
                                <li class="item-checks-05"><button type="button" class="btn-checks" onclick="fnSelectBook(5);"></button></li>
                                <li class="item-checks-06"><button type="button" class="btn-checks" onclick="fnSelectBook(6);"></button></li>
                            </ul>
                        </div>
                        <!-- 선택이유 작성 영역 -->
                        <div class="event-comment-book">
                            <div class="top">
                                <div class="item-book-01"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/item_book01.png" alt="books title"></div><input type="hidden" id="booknum">
                            </div>
                            <div class="content">
                                <textarea placeholder="띄어쓰기 포함 200자 이내 작성 가능합니다." name="txtComm" id="txtComm" maxlength="200" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>></textarea>
                            </div>
                            <!-- 작성평 등록하기 버튼 -->
                            <button type="button" class="btn-apply" onclick="eventTry(); return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/btn_apply.png" alt="등록하기"></button>
                        </div>
                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/img_tit02.jpg" alt="텐바이텐 고객님이 고른 오프투얼론의 도서 list">
                        <div id="diarylist"></div>
                    </div>
                    <div class="section-08">
                        <div class="txt-hidden">sns 이벤트 알림 : 오프투얼론 포토존에서 인증샷을 찍고 태그 후 인스타그램에 업로드해주세요.</div>
                        <button type="button" class="btn-set"></button>
                    </div>
                    <div class="section-09">
                        <!-- 인스타그램으로 이동 -->
                        <a href="https://tenten.app.link/ShZEjXRmpdb" onclick="fnAmplitudeEventMultiPropertiesAction('landing_instagram','evtcode|option1','<%=eCode%>|');" target="_blank"><span class="txt-hidden">off to alone 구경하러 가기</span></a>
                        <!-- 즐겨찾길 메인으로 이동 -->
                        <a href="https://tenten.app.link/Cl6bQPapxdb" onclick="fnAmplitudeEventMultiPropertiesAction('landing_bookmark_seochon','evtcode|option1','<%=eCode%>|');" target="_blank"><span class="txt-hidden">텐바이텐 x 서촌 # 즐겨찾길 구경하러 가기</span></a>
                    </div>
                    <!-- 팝업 - 선물보기 -->
                    <div class="pop-container set">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/pop_set.png" alt="텐바이텐 x 오프투얼론 엽서 set">
                                    <button type="button" class="btn-close">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 팝업 - 책 선물보기 -->
                    <div class="pop-container gift">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/pop_gift.png" alt="추첨을 통해 선물을 드립니다.">
                                    <button type="button" class="btn-close">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 팝업 - 이벤트 등록 후 -->
                    <div class="pop-container apply">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/pop_done.png" alt="이벤트에 참여해주셔서 감사드리며 당첨자 발표일을 기다려주세요!">
                                    <button type="button" class="btn-close02">닫기</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- 팝업 - '리소 인쇄물과 진' 자세히 보기 -->
                    <div class="pop-container detail">
                        <div class="pop-inner">
                            <div class="pop-contents">
                                <div class="contents-inner">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/109208/pop_detail.png" alt="리소 인쇄물과 진">
                                    <button type="button" class="btn-close">닫기</button>
                                    <!-- 링크 공유하고 한 번 더 풀기 버튼 -->
                                    <button type="button" class="btn-review"></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
<!-- #include virtual="/lib/db/dbclose.asp" -->