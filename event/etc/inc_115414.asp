<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2022 페이퍼즈
' History : 2021.11.19 정태훈
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eventStartDate, eventEndDate, currentDate, LoginUserid, eCode
dim mktTest, sliderNem, testDate, sqlstr, mileageReqCNT, currentDate2

mktTest = False

IF application("Svr_Info") = "Dev" THEN
	eCode = "109421"
    mktTest = True
ElseIf application("Svr_Info")="staging" Then
	eCode = "115414"
    mktTest = True
Else
	eCode = "115414"
    mktTest = False
End If

eventStartDate  = cdate("2021-11-22")		'이벤트 시작일
eventEndDate 	= cdate("2021-12-19")		'이벤트 종료일
testDate = request("testDate")
if testDate="" then testDate="2021-11-22"
LoginUserid		= getencLoginUserid()

if mktTest then
    currentDate = CDate(testDate)
    currentDate2 = now()
else
    currentDate = date()
    currentDate2 = now()
end if

'반값상품 슬라이더 시작위치 지정
if currentDate2>=#11/22/2021 00:00:00# and currentDate2<#11/24/2021 00:00:00# then
    sliderNem=0
elseif currentDate2>=#11/24/2021 00:00:00# and currentDate2<#11/29/2021 00:00:00# then
    sliderNem=1
elseif currentDate2>=#11/29/2021 00:00:00# and currentDate2<#12/01/2021 00:00:00# then
    sliderNem=2
elseif currentDate2>=#12/01/2021 00:00:00# and currentDate2<#12/06/2021 00:00:00# then
    sliderNem=3
elseif currentDate2>=#12/06/2021 00:00:00# and currentDate2<#12/08/2021 00:00:00# then
    sliderNem=4
elseif currentDate2>=#12/08/2021 00:00:00# and currentDate2<#12/13/2021 00:00:00# then
    sliderNem=5
elseif currentDate2>=#12/13/2021 00:00:00# and currentDate2<#12/15/2021 00:00:00# then
    sliderNem=6
elseif currentDate2>=#12/15/2021 00:00:00# then
    sliderNem=7
end if

sqlstr = "select count(sub_opt1)"
sqlstr = sqlstr & " from [db_event].[dbo].[tbl_event_subscript]"
sqlstr = sqlstr & " where evt_code="& eCode
sqlstr = sqlstr & " and sub_opt3='try'"
rsget.Open sqlstr,dbget
IF not rsget.EOF THEN
    mileageReqCNT = rsget(0)
END IF
rsget.close
%>
<style>
.evt115414 {max-width:1920px; margin:0 auto; background:#fff;}
.evt115414 .txt-hidden {text-indent:-9999px; font-size:0;}
.evt115414 .topic {position:relative; width:100%; height:1380px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_main.png) no-repeat 50% 0;}
.evt115414 .topic h2 {position:absolute; left:50%; top:621px; margin-left:-415px; opacity:0; transform: translateY(20%); transition:all 1s .5s;}
.evt115414 .topic .sub {position:absolute; left:50%; top:1000px; margin-left:-453px; opacity:0; transform: translateY(20%); transition:all 1s .7s;}
.evt115414 .topic h2.on,
.evt115414 .topic .sub.on {opacity:1; transform: translateY(0);}
.evt115414 .btn-float {position:fixed; left:50%; top:460px; margin-left:-564.5px; z-index:10;}
.evt115414 .btn-float a {display:inline-block;}
.evt115414 .btn-float button {width:50px; height:50px; position:absolute; right:0; top:0; background:transparent;}
.evt115414 .section-01 {padding-bottom:137px; background:#008af1;}
.evt115414 .milige-area {position:relative; width:1140px; height:258px; margin:0 auto;}
.evt115414 .milige-area .point {position:absolute; left:0; bottom:0; width:100%; height:136px; line-height:136px; font-size:66.4px; color:#13110f; font-weight:600;}
.evt115414 .btn-group {position:relative; width:1140px; height:208px; margin:0 auto;}
.evt115414 .btn-group .btn-01 {width:400px; height:100px; position:absolute; left:150px; top:55px;}
.evt115414 .btn-group .btn-02 {width:400px; height:100px; position:absolute; right:150px; top:55px;}
.evt115414 .noti-area {width:1140px; margin:0 auto;}
.evt115414 .noti-area button {position:relative; }
.evt115414 .noti-area button .icon {display:inline-block; width:17px; height:10px; position:absolute; left:50%; top:42px; margin-left:35.5px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/115414/icon_arrow.png) no-repeat 0 0; background-size:100%;}
.evt115414 .noti-area button .icon.icon-02 {top:104px;}
.evt115414 .noti-area button.on .icon {transform:rotate(180deg);}
.evt115414 .noti-area button + .info {display:none;}
.evt115414 .noti-area button.on + .info {display:block;}
.evt115414 .tit-benefit {position:relative; width:1140px; margin:0 auto;}
.evt115414 .tit-benefit button {position:absolute; right:30px; top:140px; width:130px; height:120px; background:transparent;}
.evt115414 .section-02 {padding-bottom:150px; background:#ce91f8;}
.evt115414 .section-02 .slide-area {position:relative; background:#ce91f8;}
.evt115414 .swiper-wrapper {display:flex; height:auto!important;}
.evt115414 .section-02 .slide-area .swiper-container {position:static;}
.evt115414 .section-02 .slide-area .swiper-button-prev {position:absolute; left:50%; top:50%; width:35px; height:78px; margin-left:-397px; transform:translateY(-50%); cursor: pointer;}
.evt115414 .section-02 .slide-area .swiper-button-next {position:absolute; left:50%; top:50%; width:35px; height:78px; margin-left:313px; transform:translateY(-50%); cursor: pointer;}
.evt115414 .section-02 .swiper-slide {position:relative; padding:0 55px;}
.evt115414 .section-02 .swiper-slide.sold-out .bg-soldout {position:absolute; right:55px; top:0; z-index:5;}
.evt115414 .section-02 .swiper-slide .insta {width:166px; height:58px; position:absolute; left:62px; top:38px; z-index:2;}
.evt115414 .section-03,
.evt115414 .section-04 {padding-bottom:120px; background:#0f0d0b;}
.evt115414 .section-05 {background:#0f0d0b;}
.evt115414 .section-03 .content {position:relative; width:100%; height:1263px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_item01.png?v=2) no-repeat 50% 0;}
.evt115414 .section-04 .content {position:relative; width:100%; height:1063px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_item02.png) no-repeat 50% 0;}
.evt115414 .section-05 .content {position:relative; width:100%; height:1129px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_item03.png) no-repeat 50% 0;}
.evt115414 .swiper-slide .dims {position:absolute; left:55px; top:-1px; width:653px; height:590px; background: url(//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_slide.png) no-repeat 0 0; background-size:100%; z-index:15;}
.evt115414 .swiper-slide.swiper-slide-active .dims {display:none;}
.evt115414 .item-list01 {width:1430px; margin:0 auto; padding-top:333px;}
.evt115414 .item-list02 {width:1430px; margin:0 auto; padding-top:215px;}
.evt115414 .item-list03 {width:1430px; margin:0 auto; padding-top:215px;}
.evt115414 .go-papaers {position:relative; width:100%; height:557px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/115414/btn_papers.png) no-repeat 50% 0;}
.evt115414 .go-papaers a {display:inline-block; width:660px; height:208px; position:absolute; left:50%; top:115px; transform:translateX(-50%);}
.evt115414 .section-03 .slide,
.evt115414 .section-04 .slide,
.evt115414 .section-05 .slide {width:528px; margin-right:10px;}
.evt115414 .slick-dots {padding-top:25px;}
.evt115414 .slick-dots li {width:0.51rem; height:0.51rem; margin:0 0.3rem; border-radius:100%; background:#d5d5d5;}
.evt115414 .slick-dots li.slick-active {background:#0087eb;}

.evt115414 .prd-list {position:relative; width:1430px; margin:-305px auto 0; background:#fff; overflow:hidden;}
.evt115414 .section-04 .prd-list {margin:-215px auto 0;}
.evt115414 .section-05 .prd-list {margin:-295px auto 0;}
.evt115414 .prd-list ul {display:flex; justify-content:flex-start; flex-wrap:wrap; width:calc(100% - 124px); margin:0 auto; padding-bottom:210px; background:#fff; border-radius:0 0 1rem 1rem;}
.evt115414 .prd-list ul li {width:285px; margin-right:54px;}
.evt115414 .prd-list ul li:nth-child(4),
.evt115414 .prd-list ul li:nth-child(8) {margin-right:0;}
.evt115414 .prd-list ul li .thumbnail {width:285px; height:285px; overflow:hidden; background:#ddd;}
.evt115414 .prd-list ul li .thumbnail img {width:100%;}
.evt115414 .prd-list ul li a {display:inline-block; width:100%; height:100%; text-decoration:none;}
.evt115414 .prd-list .desc {padding:20px 0; }
.evt115414 .prd-list .price {padding-top:21px; font-size:23px; letter-spacing: -0.025em; line-height:1.2; color:#111; font-weight:500;}
.evt115414 .prd-list .price span {padding-left:0.3rem; font-size:18px; color:#ff3131;}
.evt115414 .prd-list .price s {font-size:18px; color:#a5a5a5;}
.evt115414 .prd-list .desc .name {padding-top:21px; color:#141414; font-size:18px; font-weight:500; line-height:1.2; overflow: hidden; text-overflow: ellipsis; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical;}
.evt115414 .prd-list .desc .brand {padding-top:0.65rem; line-height:1.2; color:#a5a5a5; font-size:18px; font-weight:500; overflow: hidden; text-overflow: ellipsis; white-space:nowrap;}
.evt115414 .prd-list .btn-more {position:absolute; left:50%; bottom:70px; transform:translateX(-50%); display: flex;align-items: center;justify-content: center; width:400px; height:80px; margin: 0 auto; font-weight:500; font-size:24px ;text-align: center;color:#6d6e71; border-radius:50px; background:#eaeaea;}
.evt115414 .prd-list .hide-item {display:none;}
.evt115414 .prd-list .hide-item.on {display:block;}

.evt115414 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(19, 17, 15,0.502); z-index:150;}
.evt115414 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
.evt115414 .pop-container .pop-inner a {display:inline-block;}
.evt115414 .pop-container .pop-inner .btn-close {position:absolute; left:50%; top:195px; width:41px; height:41px; margin-left:230.5px; background:transparent; text-indent:-9999px;} 
html.dont_scroll,
body.dont_scroll {overflow:hidden;}
.section-04 .progress {top:730px;}
.section-05 .progress {top:730px;}
.progress {
    position:absolute;
    left:50%;
    top:850px;
    display: block;
    width:1396px;
    height: 3px;
    margin-left:-698px;
    border-radius: 0;
    overflow: hidden;
    background-color: rgba(255,255,255,0.4);
    background-image: linear-gradient(to right, white, white);
    background-repeat: no-repeat;
    background-size: 0 100%;
    transition: background-size .4s ease-in-out;
}
.sr-only {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0,0,0,0);
    border: 0;
}
</style>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo_115414.js?v=1.02"></script>
<script>
$(function(){
    /* 글자,이미지 스르륵 모션 */
    $(".topic h2,.topic .sub").addClass("on");
    $('.noti-area button').on('click',function(){
        $(this).toggleClass('on');
    });
    var mySwiper = new Swiper(".section-02 .swiper-container", {
        speed: 1500,
        initialSlide: <%=sliderNem%>,
        slidesPerView:"auto",
        centeredSlides:true
    });
    $('.swiper-button-next').on('click', function(e){ //왼쪽 네비게이션 버튼 클릭
        e.preventDefault()
        mySwiper.swipeNext()
    });
    $('.swiper-button-prev').on('click', function(e){ //오른쪽 네비게이션 버튼 클릭
        e.preventDefault() 
        mySwiper.swipePrev()
    });
    /* slide */
    var $slider = $('.section-03 .slider');
    var $progressBar = $('.progress');
    var $progressBarLabel = $( '.slider__label' );
    $slider.on('beforeChange', function(event, slick, currentSlide, nextSlide) {   
        var calc = ( (nextSlide) / (slick.slideCount-1) ) * 100;
        
        $progressBar
        .css('background-size', calc + '% 100%')
        .attr('aria-valuenow', calc );
        
        $progressBarLabel.text( calc + '% completed' );
    });
    $('.section-03 .slider').slick({
        slidesToShow:3,
        slidesToScroll:1,
        autoplay: true,
        autoplaySpeed: 1700,
        speed:800,
        /* dots: true, */
        variableWidth:true,
        pauseOnFocus: false,
        pauseOnHover:false
    });
    var $slider = $('.section-04 .slider');
    var $progressBar = $('.progress');
    var $progressBarLabel = $( '.slider__label' );
    $slider.on('beforeChange', function(event, slick, currentSlide, nextSlide) {   
        var calc = ( (nextSlide) / (slick.slideCount-1) ) * 100;
        
        $progressBar
        .css('background-size', calc + '% 100%')
        .attr('aria-valuenow', calc );
        
        $progressBarLabel.text( calc + '% completed' );
    });
    $('.section-04 .slider').slick({
        slidesToShow:3,
        slidesToScroll:1,
        autoplay: true,
        autoplaySpeed: 1700,
        speed:800,
        /* dots: true, */
        variableWidth:true,
        pauseOnFocus: false,
        pauseOnHover:false
    });
    var $slider = $('.section-05 .slider');
    var $progressBar = $('.progress');
    var $progressBarLabel = $( '.slider__label' );
    $slider.on('beforeChange', function(event, slick, currentSlide, nextSlide) {   
        var calc = ( (nextSlide) / (slick.slideCount-1) ) * 100;
        
        $progressBar
        .css('background-size', calc + '% 100%')
        .attr('aria-valuenow', calc );
        
        $progressBarLabel.text( calc + '% completed' );
    });
    $('.section-05 .slider').slick({
        slidesToShow:3,
        slidesToScroll:1,
        autoplay: true,
        autoplaySpeed: 1700,
        speed:800,
        /* dots: true, */
        variableWidth:true,
        pauseOnFocus: false,
        pauseOnHover:false
    });
    /* 상품 더보기 버튼 */
    $('.prd-list .btn-more').on('click',function(){
        $(this).parent().find('ul').children('.hide-item').addClass('on');
        $(this).hide();
        $(this).parent().find('ul').css('padding-bottom','1rem');
    });
    /* float 버튼 닫기 */
    $('.btn-float-close').on('click',function(){
        $('.btn-float img').css('width','0');
    });
    /* float 버튼 컨텐츠하단 도달시 숨기기 */
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
        var lastSection = $('.section-05').offset().top + $('.section-05').outerHeight() -500; // 동작의 구현이 끝나는 위치
        var st = $(this).scrollTop();

        if (st > lastSection){
            $('.btn-float').hide();
        } else {
            $('.btn-float').show();
        }
    }

    //팝업
    $('.evt115414 .btn-pop').click(function(){
        $('.pop-container').fadeIn();
        $("html, body").addClass("dont_scroll");
    })
    /* 팝업 닫기 */
    $('.evt115414 .btn-close').click(function(){
        $(".pop-container").fadeOut();
        $("html, body").removeClass("dont_scroll");
    })

    codeGrp = [4091999,4108484,4125694,4159944,4185276,3951839,3951838,4176250,4111673,4188377];
    var $rootEl = $("#itemlist01")
    var itemEle = tmpEl = ""
    var ix1 = 1;
    $rootEl.empty();

    codeGrp.forEach(function(item){
        if(ix1>4){
            tmpEl = '<li class="hide-item">\
                        <a href="" onclick="goProduct('+item+');return false;">\
                            <div class="thumbnail"><img src="" alt=""></div>\
                            <div class="desc">\
                                <p class="brand">brand name</p>\
                                <p class="name">상품명상품명상품명상품명상품명상품명</p>\
                                <div class="price"><s>정가</s> 할인가<span class="sale">할인율%</span></div>\
                            </div>\
                        </a>\
                    </li>\
                    '
        }else{
            tmpEl = '<li>\
                        <a href="" onclick="goProduct('+item+');return false;">\
                            <div class="thumbnail"><img src="" alt=""></div>\
                            <div class="desc">\
                                <p class="brand">brand name</p>\
                                <p class="name">상품명상품명상품명상품명상품명상품명</p>\
                                <div class="price"><s>정가</s> 할인가<span class="sale">할인율%</span></div>\
                            </div>\
                        </a>\
                    </li>\
                    '
        }
        itemEle += tmpEl;
        ++ix1;
    });
    
    $rootEl.append(itemEle)

    fnApplyItemInfoList({
        items:codeGrp,
        target:"itemlist01",
        fields:["image","name","price","sale","brand"],
        unit:"none",
        saleBracket:false
    });

    codeGrp2 = [4138489,4135133,4188376,4204691,4186243,4087801,4184828,4150750,4166706,4140460];
    var $rootEl2 = $("#itemlist02")
    var itemEle2 = tmpEl2 = ""
    var ix2 = 1;
    $rootEl2.empty();

    codeGrp2.forEach(function(item){
        if(ix2>4){
            tmpEl2 = '<li class="hide-item">\
                        <a href="" onclick="goProduct('+item+');return false;">\
                            <div class="prd-wrap">\
                                <div class="thumbnail"><img src="" alt=""></div>\
                                <div class="info">\
                                    <div class="desc">\
                                        <p class="brand">brand name</p>\
                                        <p class="name">상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명</p>\
                                        <p class="price"><s>정가</s> 할인가<span class="sale">할인율%</span></p>\
                                    </div>\
                                </div>\
                            </div>\
                        </a>\
                    </li>\
                    '
        }else{
            tmpEl2 = '<li>\
                        <a href="" onclick="goProduct('+item+');return false;">\
                            <div class="prd-wrap">\
                                <div class="thumbnail"><img src="" alt=""></div>\
                                <div class="info">\
                                    <div class="desc">\
                                        <p class="brand">brand name</p>\
                                        <p class="name">상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명</p>\
                                        <p class="price"><s>정가</s> 할인가<span class="sale">할인율%</span></p>\
                                    </div>\
                                </div>\
                            </div>\
                        </a>\
                    </li>\
                    '
        }
        itemEle2 += tmpEl2;
        ++ix2;
    });
    
    $rootEl2.append(itemEle2)

    fnApplyItemInfoList2({
        items:codeGrp2,
        target:"itemlist02",
        fields:["image","name","price","sale","brand"],
        unit:"none",
        saleBracket:false
    });

    codeGrp3 = [4188384,4175973,4146408,4166784,4166506,4188614,4091998,4188379,4169534,4177391];
    var $rootEl3 = $("#itemlist03")
    var itemEle3 = tmpEl3 = ""
    var ix3 = 1;
    $rootEl3.empty();

    codeGrp3.forEach(function(item){
        if(ix3>4){
            tmpEl3 = '<li class="hide-item">\
                        <a href="" onclick="goProduct('+item+');return false;">\
                            <div class="prd-wrap">\
                                <div class="thumbnail"><img src="" alt=""></div>\
                                <div class="info">\
                                    <div class="desc">\
                                        <p class="brand">brand name</p>\
                                        <p class="name">상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명</p>\
                                        <p class="price"><s>정가</s> 할인가<span class="sale">할인율%</span></p>\
                                    </div>\
                                </div>\
                            </div>\
                        </a>\
                    </li>\
                    '
        }else{
            tmpEl3 = '<li>\
                        <a href="" onclick="goProduct('+item+');return false;">\
                            <div class="prd-wrap">\
                                <div class="thumbnail"><img src="" alt=""></div>\
                                <div class="info">\
                                    <div class="desc">\
                                        <p class="brand">brand name</p>\
                                        <p class="name">상품명상품명상품명상품명상품명상품명상품명상품명상품명상품명</p>\
                                        <p class="price"><s>정가</s> 할인가<span class="sale">할인율%</span></p>\
                                    </div>\
                                </div>\
                            </div>\
                        </a>\
                    </li>\
                    '
        }
        itemEle3 += tmpEl3;
        ++ix3;
    });
    
    $rootEl3.append(itemEle3)

    fnApplyItemInfoList3({
        items:codeGrp3,
        target:"itemlist03",
        fields:["image","name","price","sale","brand"],
        unit:"none",
        saleBracket:false
    });

});

// 상품 링크 이동
function goProduct(itemid) {
    parent.location.href='/shopping/category_prd.asp?itemid='+itemid;
    return false;
}

function doAction() {
	<% if not ( currentDate >= eventStartDate and currentDate <= eventEndDate ) then %>	
		alert("이벤트 참여기간이 아닙니다.");
		return false;
	<% end if %>
    <% If IsUserLoginOK() Then %>
        $.ajax({
            type: "POST",
            url:"/event/etc/doeventsubscript/doEventSubscript115414.asp",
            data: {
                mode: 'add'
                <% if mktTest then %>,testDate: '<%=testDate%>'<% end if %>                
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode','<%=eCode%>');
                    alert(data.mpoint);
                    $("#mpoint").empty().html(data.mpoint);
                }else if(data.response == "err"){
                    alert(data.message);
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        })
    <% else %>
        jsSubmitlogin();
		return false;
    <% end if %>
}

function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}

function fnSearchPapers(){
    fnAmplitudeEventMultiPropertiesAction('click_event_papers','evtcode','<%=eCode%>');
    setTimeout(function(){
        top.location.href="https://www.10x10.co.kr/search/search_result.asp?rect=2022페이퍼즈";
    },1500);
    
}
</script>
						<div class="evt115414">
                            <div class="topic">
                                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/main_txt.png" alt="2022 papers"></h2>
                                <p class="sub"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/txt_sub.png" alt="선착순 반값 혜택과 5,000원 페이백 으로 만나보세요."></p>
                                <div class="btn-float">
                                    <a href="" onclick="fnSearchPapers();return false;">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_float.png" alt="2022 페이퍼즈 상품 보러가기">
                                    </a>
                                    <button type="button" class="btn-float-close txt-hidden">닫기</button>
                                </div>
                            </div>
                            <div class="section-01">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/tit_sub01.png" alt="총 5,000만 포인트 페이백!">
                                <% if mileageReqCNT>=10000 then %>
                                <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_milige_out.png" alt="마일리지가 소진되었습니다."></div>
                                <% else %>
                                <div class="milige-area">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_milige.png" alt="남은 마일리지">
                                    <p class="point" id="mpoint"><%=FormatNumber(50000000-mileageReqCNT*5000,0)%>p</p>
                                </div>
                                <% end if %>
                                <div class="btn-group">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/btn_group.png" alt="페이백 신청하기 / 디자인문구 카테고리 바로가기">
                                    <!-- 페이백 신청하기 -->
                                    <a href="" onclick="doAction();return false;" class="btn-01"></a>
                                    <!-- 디자인문구 카테고리 바로가기 -->
                                    <a href="/shopping/category_main.asp?disp=101" class="btn-02"></a>
                                </div>
                                <div class="noti-area">
                                    <button type="button"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/btn_noti.png" alt="유의사항"><span class="icon"></span></button>
                                    <div class="info"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_info.png" alt="유의사항 내용"></div>
                                </div>
                            </div>
							<div class="section-02">
                                <div class="tit-benefit">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/tit_sub02.png?v=2" alt="매주 월,수 10시 반값혜택">
                                    <button type="button" class="txt-hidden btn-pop">전체일정 보기</button>
                                </div>
                                <div class="slide-area">
                                    <div class="swiper-container">
                                        <div class="swiper-wrapper">
                                            <div class="swiper-slide<% If getitemlimitcnt(4214718) < 1 Then %> sold-out<% end if %>">
                                                <a href="" onclick="goProduct(4214718);return false;">
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_main_slide08.png" alt="11/22">
                                                    <% If getitemlimitcnt(4214718) < 1 Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soldout.png?v=3" alt="sold out" class="bg-soldout">
                                                    <% end if %>
                                                    <div class="insta"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/icon_insta.png" alt="인스타그램"></div>
                                                </a>
                                            </div>
                                            <div class="swiper-slide<% If getitemlimitcnt(4215322) < 1 or (currentDate2 < #11/24/2021 10:00:00#) Then %> sold-out<% end if %>">
                                                <a href="" onclick="goProduct(4215322);return false;">
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_main_slide01.png" alt="11/24">
                                                    <% If currentDate2 < #11/24/2021 10:00:00# Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soon.png?v=2" alt="comming soon" class="bg-soldout">
                                                    <% elseIf getitemlimitcnt(4215322) < 1 Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soldout.png" alt="sold out" class="bg-soldout">
                                                    <% end if %>
                                                    <div class="insta"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/icon_insta.png" alt="인스타그램"></div>
                                                </a>
                                            </div>
                                            <div class="swiper-slide<% If getitemlimitcnt(4214774) < 1 or (currentDate2 < #11/29/2021 10:00:00#) Then %> sold-out<% end if %>">
                                                <a href="" onclick="goProduct(4214774);return false;">
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_main_slide02.png" alt="11/29">
                                                    <% If currentDate2 < #11/29/2021 10:00:00# Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soon.png?v=2" alt="comming soon" class="bg-soldout">
                                                    <% elseIf getitemlimitcnt(4214774) < 1 Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soldout.png" alt="sold out" class="bg-soldout">
                                                    <% end if %>
                                                    <div class="insta"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/icon_insta.png" alt="인스타그램"></div>
                                                </a>
                                            </div>
                                            <div class="swiper-slide<% If getitemlimitcnt(4218291) < 1 or (currentDate2 < #12/01/2021 10:00:00#) Then %> sold-out<% end if %>">
                                                <a href="" onclick="goProduct(4218291);return false;">
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_main_slide03.png" alt="12/01">
                                                    <% If currentDate2 < #12/01/2021 10:00:00# Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soon.png?v=2" alt="comming soon" class="bg-soldout">
                                                    <% elseIf getitemlimitcnt(4218291) < 1 Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soldout.png" alt="sold out" class="bg-soldout">
                                                    <% end if %>
                                                    <div class="insta"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/icon_insta.png" alt="인스타그램"></div>
                                                </a>
                                            </div>
                                            <div class="swiper-slide<% If getitemlimitcnt(4214755) < 1 or (currentDate2 < #12/06/2021 10:00:00#) Then %> sold-out<% end if %>">
                                                <a href="" onclick="goProduct(4214755);return false;">
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_main_slide04.png" alt="12/06">
                                                    <% If currentDate2 < #12/06/2021 10:00:00# Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soon.png?v=2" alt="comming soon" class="bg-soldout">
                                                    <% elseIf getitemlimitcnt(4214755) < 1 Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soldout.png" alt="sold out" class="bg-soldout">
                                                    <% end if %>
                                                    <div class="insta"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/icon_insta.png" alt="인스타그램"></div>
                                                </a>
                                            </div>
                                            <div class="swiper-slide<% If getitemlimitcnt(4214726) < 1 or (currentDate2 < #12/08/2021 10:00:00#) Then %> sold-out<% end if %>">
                                                <a href="" onclick="goProduct(4214726);return false;">
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_main_slide05.png" alt="12/08">
                                                    <% If currentDate2 < #12/08/2021 10:00:00# Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soon.png?v=2" alt="comming soon" class="bg-soldout">
                                                    <% elseIf getitemlimitcnt(4214726) < 1 Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soldout.png" alt="sold out" class="bg-soldout">
                                                    <% end if %>
                                                    <div class="insta"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/icon_insta.png" alt="인스타그램"></div>
                                                </a>
                                            </div>
                                            <div class="swiper-slide<% If getitemlimitcnt(4215005) < 1 or (currentDate2 < #12/13/2021 10:00:00#) Then %> sold-out<% end if %>">
                                                <a href="" onclick="goProduct(4215005);return false;">
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_main_slide06.png" alt="12/13">
                                                    <% If currentDate2 < #12/13/2021 10:00:00# Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soon.png?v=2" alt="comming soon" class="bg-soldout">
                                                    <% elseIf getitemlimitcnt(4215005) < 1 Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soldout.png" alt="sold out" class="bg-soldout">
                                                    <% end if %>
                                                    <div class="insta"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/icon_insta.png" alt="인스타그램"></div>
                                                </a>
                                            </div>
                                            <div class="swiper-slide<% If getitemlimitcnt(4214861) < 1 or (currentDate2 < #12/15/2021 10:00:00#) Then %> sold-out<% end if %>">
                                                <a href="" onclick="goProduct(4214861);return false;">
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_main_slide07.png" alt="12/15">
                                                    <% If currentDate2 < #12/15/2021 10:00:00# Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soon.png?v=2" alt="comming soon" class="bg-soldout">
                                                    <% elseIf getitemlimitcnt(4214861) < 1 Then %>
                                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/bg_soldout.png" alt="sold out" class="bg-soldout">
                                                    <% end if %>
                                                    <div class="insta"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/icon_insta.png" alt="인스타그램"></div>
                                                </a>
                                            </div>
                                        </div>
                                        <div class="swiper-button-prev"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/icon_slide_left.png" alt="left"></div>
                                        <div class="swiper-button-next"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/icon_slide_right.png" alt="right"></div>
                                    </div>
                                </div>
                                <div class="noti-area">
                                    <button type="button"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/btn_noti02.png" alt="유의사항"><span class="icon icon-02"></span></button>
                                    <div class="info"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_info02.png" alt="유의사항 내용"></div>
                                </div>
                            </div>
                            <div class="section-03">
                                <div class="content">
                                    <div class="slider item-list01">
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide01_01.png" alt=""></div>
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide01_02.png" alt=""></div>
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide01_03.png" alt=""></div>
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide01_04.png" alt=""></div>
                                    </div>
                                    <div class="progress" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                        <span class="slider__label sr-only"></span>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="bottom item01">
                                        <!-- 상품 리스트 -->
                                        <div class="prd-list">
                                            <ul class="itemList itemlist01" id="itemlist01"></ul>
                                            <button type="button" class="btn-more">더보기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="section-04">
                                <div class="content">
                                    <div class="slider item-list02">
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide02_01.png" alt=""></div>
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide02_02.png" alt=""></div>
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide02_03.png" alt=""></div>
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide02_04.png" alt=""></div>
                                    </div>
                                    <div class="progress" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                        <span class="slider__label sr-only"></span>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="bottom item01">
                                        <!-- 상품 리스트 -->
                                        <div class="prd-list">
                                            <ul class="itemList itemlist02" id="itemlist02"></ul>
                                            <button type="button" class="btn-more">더보기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="section-05">
                                <div class="content">
                                    <div class="slider item-list03">
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide03_01.png" alt=""></div>
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide03_02.png" alt=""></div>
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide03_03.png" alt=""></div>
                                        <div class="slide"><img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/img_slide03_04.png" alt=""></div>
                                    </div>
                                    <div class="progress" role="progressbar" aria-valuemin="0" aria-valuemax="100">
                                        <span class="slider__label sr-only"></span>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="bottom item01">
                                        <!-- 상품 리스트 -->
                                        <div class="prd-list">
                                            <ul class="itemList itemlist03" id="itemlist03"></ul>
                                            <button type="button" class="btn-more">더보기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="go-papaers">
                                <a href="" onclick="fnSearchPapers();return false;" class="txt-hidden">2022 papers 상품 더 보러가기</a>
                            </div>
                            <!-- 팝업 -->
                            <div class="pop-container">
                                <div class="pop-inner">
                                    <div class="pop-contents">
                                        <div class="contents-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/115414/popup.png" alt="매주 월,수 총 4주간 8가지 상품이 50%">
                                            <button type="button" class="btn-close">닫기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->