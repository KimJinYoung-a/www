<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2022 맛있는 텐텐세일
' History : 2022.03.23 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/sale2020/sale2020Cls.asp" -->
<%
dim eCode, LoginUserid, evtDate
dim eventStartDate, eventEndDate, currentDate, mktTest
LoginUserid = GetEncLoginUserID()

IF application("Svr_Info") = "Dev" THEN
    eCode = "109507"
    mktTest = True
ElseIf application("Svr_Info")="staging" Then
    eCode = "117614"
    mktTest = True
Else
    eCode = "117614"
    mktTest = False
End If
eventStartDate  = cdate("2022-03-28")		'이벤트 시작일
eventEndDate 	= cdate("2022-04-25")		'이벤트 종료일

if mktTest then
    currentDate = CDate("2022-04-13"&" "&Right("0"&hour(time),2) &":"& Right("0"&minute(time),2) &":"& Right("0"&second(time),2))
else
    currentDate = CDate(Date()&" "&Right("0"&hour(time),2) &":"& Right("0"&minute(time),2) &":"& Right("0"&second(time),2))
end if

If currentDate < #2022-03-29 15:00:00# Then
    evtDate = DateAdd("h",15,Cdate("2022-03-29"))
elseIf currentDate >= #2022-03-29 15:00:00# and currentDate < #2022-03-31 15:00:00# Then
    evtDate = DateAdd("h",15,Cdate("2022-03-31"))
elseIf currentDate >= #2022-03-31 15:00:00# and currentDate < #2022-04-05 15:00:00# Then
    evtDate = DateAdd("h",15,Cdate("2022-04-05"))
elseIf currentDate >= #2022-04-05 15:00:00# and currentDate < #2022-04-07 15:00:00# Then
    evtDate = DateAdd("h",15,Cdate("2022-04-07"))
elseIf currentDate >= #2022-04-07 15:00:00# and currentDate < #2022-04-12 15:00:00# Then
    evtDate = DateAdd("h",15,Cdate("2022-04-12"))
elseIf currentDate >= #2022-04-12 15:00:00# and currentDate < #2022-04-14 15:00:00# Then
    evtDate = DateAdd("h",15,Cdate("2022-04-14"))
elseIf currentDate >= #2022-04-14 15:00:00# and currentDate < #2022-04-19 15:00:00# Then
    evtDate = DateAdd("h",15,Cdate("2022-04-19"))
elseIf currentDate >= #2022-04-19 15:00:00# and currentDate < #2022-04-21 15:00:00# Then
    evtDate = DateAdd("h",15,Cdate("2022-04-21"))
else
    evtDate = DateAdd("h",15,Cdate("2022-03-29"))
end if

dim oJustSold, itemsJustSold, i
dim totalPrice , salePercentString , couponPercentString , totalSalePercent
set oJustSold = new sale2020Cls
    itemsJustSold = oJustSold.getItemsJustSoldLists2022("" , 1 , 100)
set oJustSold = nothing 
%>
<link rel="stylesheet" href="/event/sale2020/sale2020.css">
<style>
@import url('https://fonts.googleapis.com/css2?family=Fredoka:wght@500&display=swap');
/* common */
.evt117614 .cont .noti{width:313px; height:45px; position:absolute; left:50%; margin-left:-156.5px; bottom:0;}
.evt117614 .section05 .cont .noti{width:313px; height:45px; position:absolute; left:50%; margin-left:-156.5px; bottom:24px;}
.evt117614 .cont .noti img{width:26px; position:absolute; left:50%; margin-left:110px; top:12px;}
.evt117614 .cont .noti.on img{transform:rotate(180deg);}

/* section01 */
<% if now()<#04/11/2022 00:00:00# then %>
.evt117614 .section01{position:relative; width:100%; height:1147px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section01_1.jpg) no-repeat 50% 0;}
<% else %>
.evt117614 .section01{position:relative; width:100%; height:1148px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section01_02.jpg) no-repeat 50% 0;}
<% end if %>
.evt117614 .section01 .soldout{position:absolute;bottom:125px;left:50%;margin-left:-245px;}
.evt117614 .section01 .title1{width:153px; position:absolute; left:50%; margin-left:-78.5px; top:244px; opacity:0; transform:translateY(-10%); transition:all 1s;}
.evt117614 .section01 .title2{width:559px; position:absolute; left:50%; margin-left:-279.5px; top:304px; opacity:0; transform:translateY(-10%); transition:all 1s .3s;}
.evt117614 .section01 .donut1{width:266px; position:absolute; left:50%; margin-left:-587px; top:161px; animation: move01 ease alternate;-webkit-animation: move01 alternate 1s infinite;}
.evt117614 .section01 .donut2{width:261px; position:absolute; left:50%; margin-left:390px; top:497px; animation: move02 ease alternate;-webkit-animation: move02 alternate 1s infinite;}
.evt117614 .section01 .donut3{width:204px; position:absolute; left:50%; margin-left:-625px; top:637px; animation: move03 ease alternate;-webkit-animation: move03 alternate 1s infinite;}
.evt117614 .section01 .donut4{width:183px; position:absolute; left:50%; margin-left:308px; top:896px; animation: move04 ease alternate;-webkit-animation: move04 alternate 1s infinite;}
.evt117614 .section01 .deco1{width:392px; position:absolute; left:50%; margin-left:-207px; top:531px; animation: twinkle ease-in-out alternate;-webkit-animation: twinkle alternate .8s infinite;}
.evt117614 .section01 .deco2{width:576px; position:absolute; left:50%; margin-left:-264px; top:295px; animation: twinkle ease-in-out alternate;-webkit-animation: twinkle alternate .8s .3s infinite;}
.evt117614 .section01 .deco3{width:429px; position:absolute; left:50%; margin-left:-191px; top:359px; animation: twinkle ease-in-out alternate;-webkit-animation: twinkle alternate .8s .5s infinite;}
.evt117614 .section01 .deco4{width:471px; position:absolute; left:50%; margin-left:-207px; top:331px; animation: twinkle ease-in-out alternate;-webkit-animation: twinkle alternate .8s .4s infinite;}
.evt117614 .section01 .title.on img{opacity:1; transform:translateY(0);}

@keyframes twinkle {
	0%{opacity: 0;}
	100%{opacity: 1;}
}

@keyframes move01 {
    0% {transform: rotate(-30deg);}
    100% {transform: rotate(15deg);}
}
@keyframes move02 {
    0% {transform: rotate(15deg);}
    100% {transform: rotate(-15deg);}
}
@keyframes move03 {
    0% {transform: rotate(0);}
    100% {transform: rotate(45deg);}
}
@keyframes move04 {
    0% {transform: rotate(30deg);}
    100% {transform: rotate(-45deg);}
}

/* tab */
.evt117614 .tab{z-index:10; position:relative; width:100%; height:107px; min-width:1160px; background:#000; display:flex; justify-content:center;}
.evt117614 .tab.fixed {position:fixed; left:0%; top:0;}
.evt117614 .tab .tab_list .tab1{width:140px; height:100%; position:absolute; left:50%; margin-left:-352px; background:#000 url(//webimage.10x10.co.kr/fixevent/event/2022/sale/tab1_off.png) no-repeat; background-size:contain; background-position:center;}
.evt117614 .tab .tab_list .tab1.on{background:#000 url(//webimage.10x10.co.kr/fixevent/event/2022/sale/tab1_on.png) no-repeat; background-size:contain; background-position:center;}
.evt117614 .tab .tab_list .tab2{width:78px; height:100%; position:absolute; left:50%; margin-left:-111px; background:#000 url(//webimage.10x10.co.kr/fixevent/event/2022/sale/tab2_off.png) no-repeat; background-size:contain; background-position:center;}
.evt117614 .tab .tab_list .tab2.on{background:#000 url(//webimage.10x10.co.kr/fixevent/event/2022/sale/tab2_on.png) no-repeat; background-size:contain; background-position:center;}
.evt117614 .tab .tab_list .tab3{width:114px; height:100%; position:absolute; left:50%; margin-left:56px; background:#000 url(//webimage.10x10.co.kr/fixevent/event/2022/sale/tab3_off.png) no-repeat; background-size:contain; background-position:center;}
.evt117614 .tab .tab_list .tab3.on{background:#000 url(//webimage.10x10.co.kr/fixevent/event/2022/sale/tab3_on.png) no-repeat; background-size:contain; background-position:center;}
.evt117614 .tab .tab_list .tab4{width:112px; height:100%; position:absolute; left:50%; margin-left:260px; background:#000 url(//webimage.10x10.co.kr/fixevent/event/2022/sale/tab4_off.png) no-repeat; background-size:contain; background-position:center;}
.evt117614 .tab .tab_list .tab4.on{background:#000 url(//webimage.10x10.co.kr/fixevent/event/2022/sale/tab4_on.png) no-repeat; background-size:contain; background-position:center;}
.evt117614 .tab .tab_list div.on::after{width:calc(100% + 38px); height:6px; position:absolute; bottom:0; left:-19px; background:#fff; content:'';}
.evt117614 .tab .tab_list .tab1 a{width:100%; height:100%;}

/* section02 */
<% if now()<#04/11/2022 00:00:00# then %>
.evt117614 .section02{position:relative; width:100%; height:1023px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section02.jpg) no-repeat 50% 0;}
<% else %>
.evt117614 .section02{position:relative; width:100%; height:1023px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section02_02.jpg?v=1.01) no-repeat 50% 0;}
<% end if %>
.evt117614 .section02 .cookie1{width:194px; position:absolute; left:50%; margin-left:341px; top:633px; animation: cookie  alternate;-webkit-animation: cookie alternate 1s infinite;}
.evt117614 .section02 .cookie2{width:220px; position:absolute; left:50%; margin-left:-402px; top:628px; animation: cookie  alternate;-webkit-animation: cookie alternate 1s .3s infinite;}
.evt117614 .section02 .cookie3{width:279px; position:absolute; left:50%; margin-left:-405px; top:394px; animation: cookie  alternate;-webkit-animation: cookie alternate 1s .4s infinite;}
.evt117614 .section02 .cookie4{width:182px; position:absolute; left:50%; margin-left:-67px; top:429px; animation: cookie  alternate;-webkit-animation: cookie alternate 1s infinite;}
.evt117614 .section02 .cookie5{width:272px; position:absolute; left:50%; margin-left:167px; top:427px; animation: cookie  alternate;-webkit-animation: cookie alternate 1s .3s infinite;}
.evt117614 .section02 .cookie6{width:288px; position:absolute; left:50%; margin-left:-145px; top:578px; animation: cookie  alternate;-webkit-animation: cookie alternate 1s .4s infinite;}

@keyframes cookie {
	0% {transform:rotate(0);}
	50% {transform:translate(3px,3px) rotate(5deg);}
	100% {transform:rotate(0);}
}

/* section03 */
<% if now()<#04/11/2022 00:00:00# then %>
.evt117614 .section03 .cont{position:relative; width:100%; height:1094px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section03.jpg?v=1.03) no-repeat 50% 0;}
<% else %>
.evt117614 .section03{position:relative; width:100%; height:1208px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section03_02.jpg) no-repeat 50% 0;} 
<% end if %>
.evt117614 .section03 .eye1{width:66px; position:absolute; left:50%; margin-left:-59px; top:430px;}
.evt117614 .section03 .eye2{width:67px; position:absolute; left:50%; margin-left:-59px; top:458px;}
.evt117614 .section03 .mileage p{position:absolute; left:50%; margin-left:-173px; top:550px; font-size:55px; color:#944800; text-align:center; width:306px; font-weight:bold; font-family: 'Fredoka', sans-serif;}
.evt117614 .section03 .mileage p span{font-size:80px;}
.evt117614 .section03 .benefit{width:460px;height:100px;display:block;position:absolute;top:864px;left:50%;transform:translateX(-50%);}
.evt117614 .section03 .link{width:464px; height:106px; position:absolute; left:50%; margin-left:-232px; top:860px;}
.evt117614 .section03 .detail{position:relative; width:100%; height:154px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/detail1.jpg) no-repeat 50% 0; display:none;}
<% if now()<#04/11/2022 00:00:00# then %>
.evt117614 .section03 .detail.on{display: block;}
<% else %>
.evt117614 .section03 .detail.on{display: none;}
.evt117614 .section03 .go1000{width:446px;height:103px;display:block;position:absolute;bottom:120px;left:50%;margin-left:-223px;}
<% end if %>
/* section04 */
<% if now()<#04/11/2022 00:00:00# then %>
.evt117614 .section04 .cont{position:relative; width:100%; height:1499px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section04.jpg) no-repeat 50% 0;}
<% else %>
.evt117614 .section04 .cont{position:relative; width:100%; height:1409px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section04_02.jpg) no-repeat 50% 0;}
<% end if %>
.evt117614 .section04 .coupon img{position:absolute; width:616px; left:50%; top:534px; margin-left:-308px;}
.evt117614 .section04 .coupon2{display:none;}
.evt117614 .section04 .alert{position:absolute; width:354px; left:50%; top:1229px; margin-left:-177px; height:70px;}
.evt117614 .section04 .countdown{position:absolute; width:354px; left:50%; top:1069px; margin-left:-177px; height:70px; font-size:75px; color:#fff; font-family: 'Fredoka', sans-serif;}
.evt117614 .section04 .countdown p{position:absolute; left:50%; transform:translateX(-50%); top:7px;}
.evt117614 .section04 .detail{position:relative; width:100%; height:248px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/detail2.jpg) no-repeat 50% 0; display:none;}
.evt117614 .section04 .detail.on{display: block;}
/* section05 */
<% if currentDate<#04/13/2022 00:00:00# then %>
.evt117614 .section05 .cont{position:relative; width:100%; height:1183px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section05_1.jpg?v=1.01) no-repeat 50% 0;}
.evt117614 .section05 .detail{position:relative; width:100%; height:320px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/detail3_1.jpg) no-repeat 50% 0; display:none;}
<% else %>
.evt117614 .section05 .cont{position:relative; width:100%; height:1382px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section05_3.jpg?v=1.2) no-repeat 50% 0;}
.evt117614 .section05 .detail{position:relative; width:100%; height:253px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/detail3_2.jpg?v=1.1) no-repeat 50% 0; display:none;}
.evt117614 .section05 .btn_sect05{width:446px;height:103px;display:block;position:absolute;bottom:250px;left:50%;margin-left:-223px;}
/* 20220411 특별사은품 */
.evt117614 .popup02{display:none;}
.evt117614 .popup02 .bg_dim{position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.6);z-index:9;}
.evt117614 .popup02 .pop01{position:fixed;top:50%;left:50%;margin-left:-306px;z-index:10; transform:translateY(-50%); width:612px;}
.evt117614 .popup02 .pop02{position:fixed;top:50%;left:50%;margin-left:-306px;z-index:10; transform:translateY(-50%); width:612px;}
.evt117614 .popup02 .btn_close{width:70px;height:70px;display:block;position:absolute;top:0;right:0;}
/* //20220411 특별사은품 */
<% end if %>
.evt117614 .section05 .detail.on{display: block;}

/* section06 */
.evt117614 .section06{position:relative; width:100%; height:1038px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section06.jpg) no-repeat 50% 0;}
.evt117614 .section06 .coupon{position:absolute; width:616px; left:50%; top:524px; margin-left:-308px; height:395px;}

/* section07 */
<% if now()<#04/01/2022 00:00:00# then %>
.evt117614 .section07{position:relative; width:100%; height:526px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section07.jpg?v=1.01) no-repeat 50% 0;}
<% else %>
.evt117614 .section07{position:relative; width:100%; height:526px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/section07_02.jpg) no-repeat 50% 0;}
<% end if %>
.evt117614 .section07 .link01{position:absolute; width:560px; left:50%; bottom:118px; margin-left:-560px; height:156px;}
.evt117614 .section07 .link02{position:absolute; width:560px; left:50%; bottom:118px; margin-left:0; height:156px;}

/* section08 */
.evt117614 .section08{position:relative; width:100%; height:1039px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/sub2.jpg) no-repeat 50% 0;}
.evt117614 .section08 .banner{width:1142px; height:480px; position:absolute; left:50%; margin-left:-571px; top:360px;}
.evt117614 .section08 .banner a{width:50%; height:50%; float:left;}

/* section09 */
.evt117614 .section09{position:relative; width:100%; height:1039px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/sub3.jpg) no-repeat 50% 0;}
.evt117614 .section09 .banner{width:1142px; height:480px; position:absolute; left:50%; margin-left:-571px; top:360px;}
.evt117614 .section09 .banner a{width:50%; height:50%; float:left;}

/* section10 */
.evt117614 .section10 .banner{position:relative; width:100%; height:481px; background:url(//webimage.10x10.co.kr/fixevent/event/2022/sale/sub4.jpg) no-repeat 50% 0;margin-bottom:40px;}


/* popup */
.evt117614 .popup{display:none;}
.evt117614 .popup .bg_dim{position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.6);z-index:9;}
.evt117614 .popup .pop{position:fixed;top:50%;left:50%;margin-left:-306px;z-index:10; transform:translateY(-50%); width:612px;}
.evt117614 .popup .pop .btn_close{width:70px;height:70px;display:block;position:absolute;top:0;right:0;}
.evt117614 .popup .pop .btn_confirm{width:70px;height:58px;display:block;position:absolute; top:424px; left:50%; margin-left:83px;}
.evt117614 .popup .pop .input{width:295px;height:50px;position:absolute;top:424px; left:50%; margin-left:-212px;}
.evt117614 .popup .pop .input input{width:100%; height:100%; background:transparent; font-size:24px; color:#fff;}
.evt117614 .popup .pop .input input::placeholder{color:#fff;}
</style>
<script type="text/javascript" src="/event/lib/countdown24.js"></script>
<script src="https://unpkg.com/swiper@8/swiper-bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.2/jquery-ui.min.js"></script>
<script>
$(function() {
    $('.evt117614 .section01 .title').addClass('on');

    $('.evt117614 .tab .tab_list div').click(function(){
        $(this).addClass('on');
        $(this).parent().siblings('a').children('div').removeClass('on');
    });
    
    $('.tab1').click(function() {
        $('html, body').animate({
            scrollTop: $("div#tab01").offset().top-107
        }, 1000)
    }),
    $('.tab2').click(function() {
        $('html, body').animate({
            scrollTop: $("div#tab02").offset().top-107
        }, 1000)
    }),
    $('.tab3').click(function() {
        $('html, body').animate({
            scrollTop: $("div#tab03").offset().top-107
        }, 1000)
    }),
    $('.tab4').click(function() {
        $('html, body').animate({
            scrollTop: $("div#tab04").offset().top-107
        }, 1000)
    }),
    $('.cookie1 > a').click(function() {
        $('html, body').animate({
            scrollTop: $("div#section07").offset().top-107
        }, 1000)
    }),
    $('.cookie5 > a').click(function() {
        $('html, body').animate({
            scrollTop: $("div#section05").offset().top-107
        }, 1000)
    }),
    $('.cookie2 > a').click(function() {
        $('html, body').animate({
            scrollTop: $("div#section06").offset().top-107
        }, 1000)
    }),
    $('.cookie4 > a').click(function() {
        $('html, body').animate({
            scrollTop: $("div#section07").offset().top-107
        }, 1000)
    }),
    $('.cookie6 > a').click(function() {
        $('html, body').animate({
            scrollTop: $("div#section04").offset().top-107
        }, 1000)
    }),
    $('.cookie3 > a').click(function() {
        $('html, body').animate({
            scrollTop: $("div#section03").offset().top-107
        }, 1000)
    });

    /* 글자,이미지 스르륵 모션 */
    $(window).scroll(function(){
        $('.title').each(function(){
        var y = $(window).scrollTop() + $(window).height() * 1;
        var imgTop = $(this).offset().top;
        if(y > imgTop) {
            $(this).addClass('on');
        }
        });
    });

    $(window).bind('scroll', function() {
		var navHeight = $('.section01').height();
		if ($(window).scrollTop() > navHeight) {
			$('.tab').addClass('fixed');
		 }
		else {
			$('.tab').removeClass('fixed');
		 }
	});

    Number.prototype.format = function(n) {
        var r = new RegExp('\\d(?=(\\d{3})+' + (n > 0 ? '\\.' : '$') + ')', 'g');
        return this.toFixed(Math.max(0, Math.floor(n))).replace(r, '$&,');
    };

    $('.count').each(function () {
        $(this).prop('counter', 0).animate({
            counter: $(this).text()
        }, {
            duration: 10000,
            easing: 'easeOutExpo',
            step: function (step) {
                $(this).text('' + step.format());
            }
        });
    });


    // detail
        $('.noti').click(function (e) {
            e.preventDefault();
        if ($(this).hasClass('on')) {
            $(this).removeClass('on');
            $(this).parents('.cont').siblings('.detail').removeClass('on');
           } else {
            $(this).addClass('on');
            $(this).parents('.cont').siblings('.detail').addClass('on');
        }
    });

	// eye 이미지 변경
	var i=1;
	setInterval(function(){
		i++;
		if(i>2){i=1;}
		$('.section03 .eye img').attr({src:"//webimage.10x10.co.kr/fixevent/event/2022/sale/eye"+i+".png", class:"eye"+i});
	},1000);

    // 팝업
    $('.section04 .alert').click(function(){
        $('.evt117614 .popup').show();
        return false;
    });

    $('.evt117614 .btn_close').click(function(){
        $('.evt117614 .popup').hide()
        return false;
    });

    $('.evt117614 .popup02 .btn_close').click(function(){
        $('.evt117614 .popup02').hide()
        return false;
    });

});

countDownTimer("<%=Year(evtDate)%>"
                , "<%=TwoNumber(Month(evtDate))%>"
                , "<%=TwoNumber(Day(evtDate))%>"
                , "<%=TwoNumber(hour(evtDate))%>"
                , "<%=TwoNumber(minute(evtDate))%>"
                , "<%=TwoNumber(Second(evtDate))%>"
                , new Date(<%=Year(currentDate)%>, <%=Month(currentDate)-1%>, <%=Day(currentDate)%>, <%=Hour(currentDate)%>, <%=Minute(currentDate)%>, <%=Second(currentDate)%>)
                );

function doDownCoupon() {
    <% If IsUserLoginOK() Then %>
        $.ajax({
            type: "POST",
            url:"/event/etc/doEventSubscript117614.asp",
            data: {
                mode: 'couponDown'
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply_coupon','evtcode','<%=eCode%>');
                }else{
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

function doRandomMileage() {
    <% If IsUserLoginOK() Then %>
        $.ajax({
            type: "POST",
            url:"/event/etc/doEventSubscript117614.asp",
            data: {
                mode: 'mileage'
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply_mileage','evtcode','<%=eCode%>');
                    alert(data.message);
                }else{
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

function fnSendToKakaoMessage() {
    <% If IsUserLoginOK() Then %>
        if ($("#phone").val() == '') {
            alert('알림 받으실 전화번호를 정확히 입력해 주세요.');
            $("#phone").focus();
            return;
        }
        var phoneNumber;
        if ($("#phone").val().length > 10) {
            phoneNumber = $("#phone").val().substring(0,3)+ "-" +$("#phone").val().substring(3,7)+ "-" +$("#phone").val().substring(7,11);
        } else {
            phoneNumber = $("#phone").val().substring(0,3)+ "-" +$("#phone").val().substring(3,6)+ "-" +$("#phone").val().substring(6,10);
        }

        $.ajax({
            type:"POST",
            url:"/event/etc/doEventSubscript117614.asp",
            data: {
                mode: 'kamsg',
                phoneNumber: btoa(phoneNumber)
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    alert(data.message);
                    $("#phone").val('');
                    $('.popup').hide(150);
                    return false;
                }else{
                    alert(data.message);
                }
            },
            error: function(data){
                alert('시스템 오류입니다.');
            }
        });
    <% else %>
        jsSubmitlogin();
		return false;
    <% end if %>
}

function jsSubmitlogin(){
	top.location.href="/login/loginpage.asp?vType=G";
	return false;
}

function fnFreebiesMileage() {
    <% If IsUserLoginOK() Then %>
        $.ajax({
            type: "POST",
            url:"/event/etc/doEventSubscript117614.asp",
            data: {
                mode: 'freebiesmileage'
            },
            dataType: "JSON",
            success: function(data){
                if(data.response == "ok"){
                    fnAmplitudeEventMultiPropertiesAction('click_event_apply_freebiesmileage','evtcode','<%=eCode%>');
                    $('.pop01').hide();
                    $('.pop02').show();
                    $('.popup02').show(150);
                }else if(data.response == "fail"){
                    $('.pop01').show();
                    $('.pop02').hide();
                    $('.popup02').show(150);
                }else{
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
</script>
						<div class="evt117614">
							<div class="section01">
                                <% if now()<#04/11/2022 00:00:00# then %>
                                <div class="title">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/title1.png" alt="" class="title1">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/title2.png" alt="" class="title2">
                                </div>
                                <% else %>
                                <div class="title"><!-- 04/11 -->
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/title1_02.png" alt="" class="title1">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/title2_02.png" alt="" class="title2">
                                </div>
                                <% end if %>
                                <div class="deco">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/top_deco1.png?v=1.1" alt="" class="deco1">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/top_deco2.png?v=1.1" alt="" class="deco2">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/top_deco3.png?v=1.1" alt="" class="deco3">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/top_deco4.png?v=1.1" alt="" class="deco4">
                                </div>
                                <% if now()<#04/11/2022 00:00:00# then %>
                                <div class="donut">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/donut1.png" alt="" class="donut1">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/donut2.png" alt="" class="donut2">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/donut3.png" alt="" class="donut3">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/donut4.png" alt="" class="donut4">
                                </div>
                                <% else %>
                                <div class="donut"><!-- 04/11 -->
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/donut1_02.png" alt="" class="donut1">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/donut2_02.png" alt="" class="donut2">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/donut3_02.png" alt="" class="donut3">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/donut4_02.png" alt="" class="donut4">
                                </div>
                                <% end if %>
                                <% if now()<#04/04/2022 00:00:00# then %>
                                <p class="soldout"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/soldout.png" alt=""></p>
                                <% else %>
                                <p class="soldout" style="display:none;"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/soldout.png" alt=""></p>
                                <% end if %>
                            </div>
                            <div class="tab_start"></div>
                            <div class="tab">
                                <div class="tab_list">
                                    <a href="#tab01">
                                        <div class="tab1 on">
                                        </div>
                                    </a>
                                    <a href="#tab02">
                                        <div class="tab2">
                                        </div>
                                    </a>
                                    <a href="#tab03">
                                        <div class="tab3">
                                        </div>
                                    </a>
                                    <a href="#tab04">
                                        <div class="tab4">
                                        </div>
                                    </a>
                                </div>
                            </div>
                            <!-- 혜택레시피 -->
                            <div id="tab01">
                                <div class="section02">
                                    <% if now()<#04/11/2022 00:00:00# then %>
                                    <div class="cookie">
                                        <a href="#section07" class="cookie4"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie4.png" alt=""></a>
                                        <a href="#section07" class="cookie1"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie1.png?v=1.1" alt=""></a>
                                        <a href="#section06" class="cookie2"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie2.png?v=1.1" alt=""></a>
                                        <a href="#section03" class="cookie3"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie3.png" alt=""></a>
                                        <a href="#section05" class="cookie5"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie07.png" alt=""></a>
                                        <a href="#section04" class="cookie6"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie6.png" alt=""></a>
                                    </div>
                                    <% else %>
                                     <div class="cookie"><!-- 04/11 -->
                                        <a href="" class="cookie4"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie4_02.png" alt=""></a>
                                        <a href="" class="cookie1"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie1.png?v=1.1" alt=""></a>
                                        <a href="" class="cookie2"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie2.png?v=1.1" alt=""></a>
                                        <a href="" class="cookie3"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie3_02.png" alt=""></a>
                                        <a href="" class="cookie5"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie07.png" alt=""></a>
                                        <a href="" class="cookie6"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/cookie6.png" alt=""></a>
                                    </div>
                                    <% end if %>
                                </div>
                                
                                <div id="section03" class="section03">
                                    <% If currentDate < #2022-04-11 00:00:00# Then %>
                                    <div class="cont">
                                        <div class="eye">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/eye1.png" alt="" class="eye1">
                                        </div>
                                        <div class="mileage">
                                            <p class="m1"><span class="count">10000</span>p</p>
                                        </div>
                                        <a href="" class="benefit" onclick="doRandomMileage();return false;"></a>
                                        <a href=""><div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/arrow_p.png" alt=""></div></a>
                                    </div>
                                    <div class="detail"></div>
                                    <% end if %>
                                    <a href="/event/eventmain.asp?eventid=117613" class="go1000"></a>
                                </div>
                               
                                <div id="section04" class="section04">
                                    <div class="cont">
                                        <div class="coupon">
                                            <!-- 반값쿠폰 -->
                                            <a href="" onclick="doDownCoupon();return false;"><img class="coupon1" src="//webimage.10x10.co.kr/fixevent/event/2022/sale/coupon.png" alt=""></a>
                                            <!-- 솔드아웃 -->
                                            <img class="coupon2" src="//webimage.10x10.co.kr/fixevent/event/2022/sale/coupon_soldout.png" alt="">
                                        </div>
                                        <a href=""><div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/arrow_pink.png" alt=""></div></a>
                                        <a href="" class="alert"></a>
                                        <div class="countdown">
                                            <p><span id="countdown">00:00</span></p>
                                        </div>
                                    </div>
                                    <div class="detail"></div>
                                </div>
                                <% if currentDate<#04/13/2022 00:00:00# then %>
                                <div id="section05" class="section05">
                                    <div class="cont">
                                        <a href=""><div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/arrow_o.png" alt=""></div></a>
                                    </div>
                                    <div class="detail"></div>
                                </div>
                                <% else %>
                                <div id="section05" class="section05">
                                    <div class="cont">
                                        <a href=""><div class="noti"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/arrow_o.png" alt=""></div></a>
                                        <a href="" onclick="fnFreebiesMileage();return false;" class="btn_sect05"></a>
                                    </div>
                                    <div class="detail"></div>
                                </div>
                                <div class="popup02">
                                    <div class="bg_dim"></div>
                                    <div class="pop01">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/popup02.png" alt="">
                                        <a href="" class="btn_close"></a>
                                    </div>
                                    <div class="pop02"  style="display:none;">
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/popup03.png" alt="">
                                        <a href="" class="btn_close"></a>
                                    </div>
                                </div>
                                <% end if %>
                                <div id="section06" class="section06">
                                    <a href="https://www.10x10.co.kr/my10x10/couponbook.asp"><div class="coupon"></div></a>
                                </div>
                                <div id="section07" class="section07">
                                    <% if now()<#04/11/2022 00:00:00# then %>
                                    <a href="/event/eventmain.asp?eventid=117622" class="link01">
                                    <% else %>
                                    <a href="/event/eventmain.asp?eventid=117623" class="link01">
                                    <% end if %>
                                    <a href="https://www.10x10.co.kr/event/appdown/" class="link02"></a>
                                </div>
                            </div>

                            <!-- 이벤트 -->
							<div id="tab02">
                                <div class="section08">
                                    <div class="banner">
                                        <% if now()<#04/01/2022 00:00:00# then %>
                                        <a href="/event/eventmain.asp?eventid=117461"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner01.png?v=1.01" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=117611"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner04_1.png" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=117806"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner02.png" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=117910"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner11.png" alt=""></a>
                                        <% else %>
                                        <a href="/event/eventmain.asp?eventid=117615"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner10.png" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=117683"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner02.png" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=117511"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner09.png" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=117611"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner04_1.png" alt=""></a>
                                        <% end if %>
                                    </div>
                                </div>
                            </div>
                            <!-- 특가상품 -->
							<div id="tab03">
                                <div class="section09">
                                    <div class="banner">
                                        <% if now()<#04/01/2022 00:00:00# then %>
                                        <a href="/event/eventmain.asp?eventid=117475"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner05.png" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=117460"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner06.png" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=116656"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner07.png" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=117690"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner08.png" alt=""></a>
                                        <% else %>
                                         <a href="/event/eventmain.asp?eventid=117475"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner05.png" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=117460"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner06.png" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=117454"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner12.png" alt=""></a>
                                        <a href="/event/eventmain.asp?eventid=117546"><img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/banner13.png" alt=""></a>
                                        <% end if %>
                                    </div>
                                </div>
                            </div>
                            <!-- 방금팔린 -->
							<div id="tab04">
                                <div class="section10">
                                    <div class="banner"></div>
                                    <div class="sale2020">
                                        <ul class="item-list" id="dataList">
                                            <%
                                            IF isArray(itemsJustSold) THEN
                                                FOR i = 0 TO Ubound(itemsJustSold) - 1 
                                                CALL itemsJustSold(i).fnItemPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent)
                                            %> 
                                            <li> 
                                                <a href="/shopping/category_prd.asp?itemid=<%=itemsJustSold(i).FItemID%>">
                                                    <div class="thumbnail">
                                                        <img src="<%=itemsJustSold(i).FPrdImage%>" alt="" />
                                                        <div class="badge badge-time"><%=Gettimeset(DateDiff("s",itemsJustSold(i).FSellDate, now()))%></div>
                                                        <% IF itemsJustSold(i).IsFreeBeasong THEN %>
                                                        <div class="badge-group">
                                                            <div class="badge-item badge-delivery">무료배송</div>
                                                        </div>
                                                        <% END IF %>
                                                        <% IF itemsJustSold(i).FsellYn = "N" THEN %>
                                                        <span class="soldout"><span class="ico-soldout">일시품절</span></span>
                                                        <% END IF %>
                                                    </div>
                                                    <div class="desc">
                                                        <div class="price-area"><span class="price"><%=totalPrice%></span>
                                                            <% IF salePercentString > "0"  THEN %><b class="discount sale"><%=salePercentString%></b><% END IF %>
                                                            <% IF couponPercentString > "0" THEN %><b class="discount coupon"><%=couponPercentString%></b><% END IF %>
                                                        </div>
                                                        <p class="name"><%=itemsJustSold(i).Fitemname%></p>
                                                    </div>
                                                </a>
                                            </li>
                                            <% 
                                                NEXT 
                                            END IF
                                            %>
                                        </ul>
                                    </div>

                                </div>
                            </div>
                            <div class="tab_end"></div>
                            <div class="popup">
								<div class="bg_dim"></div>
								<div class="pop">
									<img src="//webimage.10x10.co.kr/fixevent/event/2022/sale/popup.png" alt="">
									<div class="input">
										<input type="number" id="phone" maxlength="11" oninput="maxLengthCheck(this)" placeholder="휴대폰 번호를 입력해주세요">
									</div>
                                    <a href="" class="btn_confirm" onclick="fnSendToKakaoMessage();return false;"></a>
									<a href="" class="btn_close"></a>
								</div>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->