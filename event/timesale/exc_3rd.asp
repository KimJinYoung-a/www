<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 이건 기회야! 릴레이 타임세일 3차
' History : 2019-11-19 이종화 생성 - eventid = 98760
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/event/timesale/timesaleCls.asp" -->
<%
response.redirect "/" ' 종료
dim currentDate : currentDate = "2019-12-06" '// 이벤트일
dim isTeaser , isAdmin : isAdmin = false
dim currentType , currentTime
dim LoginUserid : LoginUserid = GetEncLoginUserID()
dim addParam , eCode , loopInt

dim totalPrice , salePercentString , couponPercentString , totalSalePercent

dim oTimeSale
set oTimeSale = new TimeSaleCls
    oTimeSale.Fepisode = 3
    oTimeSale.getTimeSaleItemLists


IF application("Svr_Info") = "Dev" THEN
	eCode = "90417"	
Else
	eCode = "98760"
End If

'// 티져 여부
if date() = Cdate(currentDate) then 
    isTeaser = false 
else 
    isTeaser = true 
end If 

'// TEST
if LoginUserid="ley330" or LoginUserid="greenteenz" or LoginUserid="rnldusgpfla" or LoginUserid="cjw0515" or LoginUserid="thensi7" or LoginUserid = "motions" or LoginUserid = "jj999a" or LoginUserid = "phsman1" or LoginUserid = "jjia94" or LoginUserid = "seojb1983" or LoginUserid = "kny9480" or LoginUserid = "bestksy0527" or LoginUserid = "mame234" then
    if date() < Cdate(currentDate) then 
        isTeaser = chkiif(requestCheckVar(request("isTeaser"),1) = "1" or requestCheckVar(request("isTeaser"),1) = "" , true , false) '// true 티져 / false 본 이벤트
        currentType = requestCheckVar(request("currentType"),1) '// 1.am9 , 2.pm1 , 3.pm4 , 4.pm20
        isAdmin = true
        addParam = "&isAdmin=1"
    end if
end if

'// setTimer
if isTeaser then 
    currentTime = DateAdd("d",1,Date()) '// 내일기준시간
else
    currentTime = fnGetCurrentTime(fnGetCurrentType(isAdmin,currentType))
end if 

' response.write isTeaser &"<br/>"
' response.write fnGetCurrentType(isAdmin,currentType) &"<br/>"
' response.write fnGetSendCountToKakaoMassage(fnGetCurrentType(isAdmin,currentType)) &"<br/>"

function fnGetItemName(roundNumber , sortNumber)
    dim itemNameGroups1 , itemNameGroups2 , itemNameGroups3 , itemNameGroups4
        itemNameGroups1 = Array("라인프렌즈 프로젝터", "세상 예쁜 모슈 단독 최저가", "공복을 위한 아침 특가", "겨울철 사무실 필수템", "아이패드&sol;노트북 파우치", "딱 4시간! JMW 특가", "잘 빠진 문구, 툴스투리브바이", "철가루 방지 스티커 특가")
        itemNameGroups2 = Array("갤럭시 버즈 화이트", "크리스마스 단독 최저가" , "겨울맞이 베베데코 특가" , "EUP 무선청소기", "수납 끝판왕 추천 특가", "변하지 않는 가치의 향" , "선물주기 딱 좋은! 귀걸이 세트", "키드크래프트 5종 특가")
        itemNameGroups3 = Array("내셔널지오그래픽 롱패딩 (95)" , "묻고 디즈니특가로 가!" , "2020 다이어리&sol;달력", "뜨개질 DIY 키트 특가" , "청소는 미리빨,7종 특가" , "화제의 지누스 매트리스" , "락피쉬 신상품 단 4시간 타임특가!" , "강아지 건강관리 특가")
        itemNameGroups4 = Array("에어팟 프로" , "신상 명품 가방&sol;지갑 타임특가" , "크리스마스 무드등 특가" , "스누피 와플메이커" , "묻고 디즈니특가로 가!" , "11월 산타 울리 특가" , "곤약젤리 최저가 무배" , "&lsqb;무배&rsqb; 리버시블 곰깔깔이 양털후리스")

        SELECT CASE roundNumber
            CASE 1
                fnGetItemName = itemNameGroups1(sortNumber-1)
            CASE 2
                fnGetItemName = itemNameGroups2(sortNumber-1)
            CASE 3
                fnGetItemName = itemNameGroups3(sortNumber-1)
            CASE 4
                fnGetItemName = itemNameGroups4(sortNumber-1)
            CASE ELSE
                fnGetItemName = ""
        END SELECT
end function
%>
<style>
.not-scroll{position:fixed; overflow:hidden; width:100%; height:auto;}

.time-sale {background-color:#fff;font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif;}
.time-sale .inner {position:relative; width:1140px; height:100%; margin:0 auto;}
.time-sale button {background-color:transparent;}

.time-top {height:600px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/bg_top.jpg); background-repeat:repeat-x; background-position:50% 50%; background-size:cover;}
.time-top {position:relative;}
.time-top h2, .time-top p {position:absolute; top:110px; left:40px;}
.time-top h2:after {display:inline-block; position:absolute; top:55px; right:-30px; width:15px; height:15px; background-color:#ff6600; border-radius:50%; content:''; animation:blink .8s infinite;}
.time-top p {top:364px}
.time-sale .sale-timer {position:absolute; top:380px; left:40px; color:#fff; font-size:90px; font-weight:bold; text-align:left; font-family:'roboto';}

.time-nav {display:flex; justify-content:space-between; position:absolute; top:240px; right:20px; width:485px;}
.time-nav .time {width:110px; height:113px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/img_time1_1.png?v=1.02); background-repeat:no-repeat; background-position:0 0; text-indent:-999em;}
.time-nav .time2 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/img_time1_2.png);}
.time-nav .time3 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/img_time1_3.png);}
.time-nav .time4 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/img_time1_4.png);}
.time-nav .time.on {background-position:0 -147px;}
.time-nav .time.end {background-position:0 100%; cursor:pointer;}

.alarm {padding:65px 0; text-align:left;}
.alarm .inner {display:flex; justify-content:space-between; align-items:flex-end; width:1060px; padding:0 40px;}
.alarm .btn-alarm {display:inline-block; background-repeat:no-repeat; background-position:50% 50%; text-indent:-999em;}
.alarm .btn-alarm1 {width:327px; height:98px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/btn_alarm1.png);}
.alarm .btn-alarm2 {width:451px; height:144px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/btn_alarm2.png);}
.alarm .btn-alarm3 {width:578px; height:198px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/btn_alarm3.png?v=1.02);}
.alarm .time-nav {position:relative; top:0; right:0; width:355px; margin-top:34px; margin-left:-15px;}
.alarm .time-nav .time {width:72px; height:79px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/img_time2_1.png?v=1.01);}
.alarm .time-nav .time2 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/img_time2_2.png);}
.alarm .time-nav .time3 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/img_time2_3.png);}
.alarm .time-nav .time4 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/img_time2_4.png);}
.alarm .time-nav .time.on {background-position:0 -114px;}
.alarm .sale-timer {position:relative; top:0; left:0; bottom:-15px; font-size:68px; line-height:1; margin-top:20px; color:#000;}

.time-sale .desc {padding-left:5px; margin-top:12px; color:#000; }
.time-sale .name {font-size:20px; font-weight:bold; letter-spacing:-.3px;}
.time-sale .price {display:flex; align-items:flex-end; font-size:19px; line-height:1.3; margin-top:13px;}
.time-sale .price p {display:flex; flex-direction:column;}
.time-sale .price p b {display:inline-block; width:100%; color:#888; font-weight:normal; text-decoration:line-through;}
.time-sale .price em {font-weight:bold; font-size:27px;}
.time-sale .price em span {display:inline-block; margin-left:2px; font-size:16px; font-weight:normal;}
.time-sale .price .sale {display:inline-block; margin-left:16px; color:#ff3823; font-size:27px; font-weight:bold; font-style:normal;}

.time-items ul {display:flex; justify-content:space-between; flex-wrap:wrap; height:816px; margin-top:30px; margin-bottom:35px;}
.time-items li {position:relative; width:250px;}
.time-items li .thumbnail {position:relative; width:100%; height:250px; background-color:#ccc;}
.time-items li .thumbnail img {width:100%; height:100%;}
.time-items li .label-box {display:flex; position:absolute; bottom:-5px; left:5px; z-index:10;}
.time-items li .label {display:flex; justify-content:center; align-items:center; padding:0 16px; color:#fff; font-size:16px; border-radius:12px; background-color:#222;}
.time-items li .cp {margin-left:5px; background-color:#00a436;}
.time-items li.special-item .thumbnail .label {background-color:#ff3823;}

.time-teaser .time-top {height:600px;}
.time-teaser .time-top h2 {position:relative; top:0; left:0;}
.time-teaser .time-top h2:after {display:none;}
.time-teaser .slideshow {position:absolute; top:195px; right:106px; width:147px; height:139px;}
.time-teaser #slideshow div {position:absolute; top:0; left:0; z-index:8; width:100%; opacity:0.0;}
.time-teaser #slideshow div.active {z-index:10; opacity:1.0;}
.time-teaser #slideshow div.last-active {z-index:9;}
.time-teaser .teaser-item {background-color:#fff;}
.time-teaser .alarm {background-color:#f1efef;}

.time-soon .alarm {padding:90px 0;}

.coming-section {position:relative; background-color:#eaeaea; text-align:left;}
.coming-section:before {display:block; position:absolute; top:0; left:0; z-index:15; width:100%; height:100%; background-color:rgba(234, 234, 234,.55); content:' ';}
.coming-section .inner {width:1060px; padding-bottom:25px;}
.coming-section .alarm {padding:90px 0 55px;}
.coming-section .alarm,
.coming-section .txt-time {position:relative; z-index:20;}

.time-ing .time-items-on ul {width:1069px; margin:-105px auto 80px;}
.time-ing .time-items-on ul li {margin-top:45px; text-align:left; cursor:pointer;}
.time-ing .time-items-on ul li a {text-decoration:none;}
.time-ing .time-items-on li.special-item .thumbnail:before,
.time-ing .time-items-on li.special-item .thumbnail:after {display:inline-block; position:absolute; top:0; left:0; z-index:20; width:100%; height:366px; background-color:rgba(255,255,255,.55); opacity:0; transition:all .3s; content:'';}
.time-ing .time-items-on li.special-item .thumbnail:after {top:70px; left:50%; width:110px; height:110px; margin-left:-55px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/btn_buy.png);}
.time-ing .time-items-on li.special-item:hover .thumbnail:before,
.time-ing .time-items-on li.special-item:hover .thumbnail:after {opacity:1;}
.time-ing .time-items-on li.special-item.sold-out:hover .thumbnail:before,
.time-ing .time-items-on li.special-item.sold-out:hover .thumbnail:after {opacity:0;}
.time-ing .time-items-on .sold-out {position:relative;}
.time-ing .time-items-on .sold-out:after,
.time-ing .time-items-on .sold-out:before {display:inline-block; position:absolute; top:0; left:0; z-index:50; width:100%; height:100%; background-color:rgba(255,255,255,.55); content:'';}
.time-ing .time-items-on .sold-out:before {width:110px; height:110px; top:70px; left:50%; z-index:55; margin-left:-55px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/txt_sold_out.png)no-repeat 50% 50% / 100% 100%;}
.time-ing .time-items-on .sold-out .btn-get {display:none;}

.lyr {overflow-y:scroll; position:fixed; top:0; left:50%; z-index:250; width:100%; height:100vh; scrollbar-width:none; -ms-overflow-style:none;}
.lyr::-webkit-scrollbar {display:none;}
.lyr .btn-close {position:absolute; top:100px; right:36px; width:32px; height:32px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/btn_close.png) 50% 50%/100%;}

.lyr-fair {width:595px; margin-left:-298px;}
.lyr-fair .inner {width:100%;}
.lyr-fair p {margin-top:57px;}
.lyr-fair .input-box1,
.lyr-fair .input-box2,
.lyr-fair .input-box3,
.lyr-fair .input-box4,
.lyr-fair .btn-get,
.lyr-fair .btn-get2,
.lyr-fair .btn-get3,
.lyr-fair .btn-get4 {position:absolute; top:437px; left:80px;}

.lyr-fair #notRobot1,
.lyr-fair #notRobot2,
.lyr-fair #notRobot3,
.lyr-fair #notRobot4 {display:none;}
.lyr-fair #notRobot1 + label,
.lyr-fair #notRobot2 + label,
.lyr-fair #notRobot3 + label,
.lyr-fair #notRobot4 + label {display:inline-block; width:250px; height:33px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/txt_chck.png?v=1.01); text-indent:-999em; cursor:pointer;}
.lyr-fair #notRobot:checked + label,
.lyr-fair #notRobot2:checked + label,
.lyr-fair #notRobot3:checked + label,
.lyr-fair #notRobot4:checked + label {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/txt_chck_on.png?v=1.01);}

.lyr-fair .btn-get {top:506px;}
.lyr-fair .btn-close {top:40px;}

.lyr-alarm {width:595px; margin-left:-298px;}
.lyr-alarm .inner {width:100%;}
.lyr-alarm p {padding-top:57px;}
.lyr-alarm .input-box {position:absolute; top:570px; left:75px; display:flex; justify-content:space-between; align-items:center; width:283px; color:#ff6600; font-weight:bold;}
.lyr-alarm .input-box input {width:33%; height:45px; padding:0; margin:0 5px; background-color:transparent; border:0; border-bottom:solid 3px #ff9023; border-radius:0; color:#cbcbcb; font-size:22px; line-height:1; font-weight:bold; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; text-align:center;}
.lyr-alarm .input-box input:first-child {margin-left:0;}
.lyr-alarm .input-box .btn-submit {width:80px; margin-left:10px; color:#ff9023; font-size:22px; font-weight:bold;}
.lyr-alarm .btn-close {top:95px; right:40px;}

.lyr-end {width:100%; top:0; margin-left:-50%; text-align:left;}
.lyr-end .txt-time {padding-top:185px;}
.lyr-end .time-items ul {margin-top:45px;}
.lyr-end .time-items li, .lyr-end .time-items .thumbnail {position:relative;}
.lyr-end .time-items li:before {display:inline-block; position:absolute; top:100px; left:50%; z-index:20; width:80px; height:auto; margin-left:-40px; color:#fff; font-size:18px; line-height:1.5; font-family:'AvenirNext-Medium', 'AppleSDGothicNeo-Medium'; content:'순식간에 판매완료'; text-align:center;}
.lyr-end .time-items .thumbnail:after {display:inline-block; position:absolute; top:0; left:0; z-index:5;width:100%; height:100%; background-color:rgba(0,0,0,.55); content:'';}
.lyr-end .time-items li .label-box {display:none;}
.lyr-end .time-items .name {font-weight:normal;}
.lyr-end .time-items .name, .lyr-end .time-items .price {color:#c2c2c2}

.related-evt {background:url(//webimage.10x10.co.kr/fixevent/event/2019/98760/bg_related_v2.jpg) repeat-x 50% 50%;}
#mask-time {display:none; position:fixed; top:0; left:0; z-index:200; width:100%; height:100%; background:rgba(0,0,0,.9);}
@keyframes blink {from, to {opacity:0;} 50% {opacity:1;}}
</style>
<script type="text/javascript" src="/event/lib/countdown.js"></script>
<script>
    countDownTimer("<%=Year(currentTime)%>"
                    , "<%=TwoNumber(Month(currentTime))%>"
                    , "<%=TwoNumber(Day(currentTime))%>"
                    , "<%=TwoNumber(hour(currentTime))%>"
                    , "<%=TwoNumber(minute(currentTime))%>"
                    , "<%=TwoNumber(Second(currentTime))%>"
                    , new Date(<%=Year(now)%>, <%=Month(now)-1%>, <%=Day(now)%>, <%=Hour(now)%>, <%=Minute(now)%>, <%=Second(now)%>));

    function fnSendToKakaoMessage() {
        if ($("#phone1").val() == '') {
            alert('알림 받으실 전화번호를 정확히 입력해 주세요.');
            $("#phone1").focus();
            return;
        }

        if ($("#phone2").val() == '') {
            alert('알림 받으실 전화번호를 정확히 입력해 주세요.');
            $("#phone2").focus();
            return;
        }

        if ($("#phone3").val() == '') {
            alert('알림 받으실 전화번호를 정확히 입력해 주세요.');
            $("#phone3").focus();
            return;
        }

        var phoneNumber = $("#phone1").val()+ "-" +$("#phone2").val()+ "-" +$("#phone3").val();

        $.ajax({
            type:"GET",
            url:"/event/timesale/timesale_proc.asp",
            data: "mode=kamsg&phoneNumber="+btoa(phoneNumber)+"&sendCount=<%=fnGetSendCountToKakaoMassage(fnGetCurrentType(isAdmin,currentType))%><%=addParam%>",
            dataType: "text",
            async:false,
            cache:true,
            success : function(Data, textStatus, jqXHR){
                if (jqXHR.readyState == 4) {
                    if (jqXHR.status == 200) {
                        if(Data!="") {
                            var result = JSON.parse(Data);
                            if(result.response == "ok"){
                                alert('알림 신청이 완료되었습니다.');
                                $("#phone1").val('')
                                $("#phone2").val('')
                                $("#phone3").val('')
                                $('html,body').removeClass('not-scroll');
                                $('html,body').animate({scrollTop:posY}, 10);
                                $(".time-sale .lyr").fadeOut();
                                $("#mask-time").fadeOut();
                                return false;
                            }else{
                                alert(result.faildesc);
                                return false;
                            }
                        } else {
                            alert("잘못된 접근 입니다.");
                            document.location.reload();
                            return false;
                        }
                    }
                }
            },
            error:function(jqXHR, textStatus, errorThrown){
                alert("잘못된 접근 입니다.");					
                return false;
            }
        });
    }

    //maxlength validation in input type number
    function maxLengthCheck(object){
        if (object.value.length > object.maxLength){
            object.value = object.value.slice(0, object.maxLength);
        }
    }

    var isStopped = false;
    function slideSwitch() {
        if (!isStopped) {
            var $active = $("#slideshow div.active");
            if ($active.length == 0) $active = $("#slideshow div:last");
            var $next = $active.next().length ? $active.next() : $("#slideshow div:first");

            $active.addClass("last-active");

            $next.css({
            }).addClass("active").animate({
                }, 0, function() {
                $active.removeClass("active last-active");
            });
        }
    }
    
    function catchPos() {
        posY = $(window).scrollTop();
        $('html, body').addClass('not-scroll');
        var Y = $('.time-sale').offset().top;
        $('html,body').animate({scrollTop:Y}, 10);
    }

    $(function() {
        setInterval(function() {
            slideSwitch();
        }, 800);

        $("#slideshow").hover(function() {
            isStopped = true;
        }, function() {
            isStopped = false;
        });

        //미끼상품
        $('.time-items ul li:first-child').addClass('special-item');
        $('.time-items-on ul li:first-child').addClass('special-item');

        // 레이어 mask
        $("#mask-time").click(function(){
            $('html,body').removeClass('not-scroll');
            $('html,body').animate({scrollTop:posY}, 10);
            $(".time-sale .lyr").fadeOut();
            $("#mask-time").fadeOut();
        });

        //  페어플레이 레이어
        $('.time-items-on .special-item').click(function (e) {
            if ($(this).hasClass("sold-out")) {
                return false;
            }
            
            var str = $.ajax({
                type: "GET",
                url: "/event/timesale/timesale_proc.asp",
                data: "mode=fair&sendCount=<%=fnGetCurrentType(isAdmin,currentType)%><%=addParam%>",
                dataType: "text",
                async:false,
                cache:true,
            }).responseText;

            if(str!="") {
                $("#fairplay").empty().html(str);
                $('#mask-time').css({'background-color':'rgba(255,255,255,.9);'});
                $("#mask-time").show();
                $('.lyr-fair').fadeIn();
                catchPos();
            }
        });

        // 알림받기 레이어
        $('.btn-alarm').click(function (e) {
            if(!$(this).hasClass('btn-alarm3')){
                $('#mask-time').css({'background-color':'rgba(255,255,255,.9);'});
                $("#mask-time").show();
                $('.lyr-alarm').fadeIn();
                $("#phone1").focus();
                catchPos();
            }
        });

        // 종료된 타임세일 상품 보기
        $('.time-nav .end').click(function (e) {
            var index = $(this).index();

            $('#mask-time').css({'background-color':'rgba(0,0,0,.9);'});
            $("#mask-time").fadeIn();
            $('.lyr-end').fadeIn();
            $('.lyr-end').find('.time-items').eq(index).fadeIn();
            catchPos();
        });

        // 레이어 닫기
        $('.btn-close').click(function (e) {
            $("#mask-time").fadeOut();
            $('.lyr').fadeOut();
            $(this).find('.time-items').fadeOut();
            $('.lyr-end').find('.time-items').fadeOut();
            $('html,body').removeClass('not-scroll');
            $('html,body').animate({scrollTop:posY}, 10);
        });

        $("#mask-time").click(function(){
            $(".lyr").fadeOut();
            $(this).find('.time-items').fadeOut();
            $('.lyr-end').find('.time-items').fadeOut();
            $("#mask-time").fadeOut();
            $('html,body').removeClass('not-scroll');
            $('html,body').animate({scrollTop:posY}, 10);
        });
    });

    function fnBtnClose(e) {
        $("#mask-time").fadeOut();
        $('.lyr').fadeOut();
        $(this).find('.time-items').fadeOut();
        $('.lyr-end').find('.time-items').fadeOut();
        $('html,body').removeClass('not-scroll');
        $('html,body').animate({scrollTop:posY}, 10);
    }

    function goDirOrdItem() {
        <% If Not(IsUserLoginOK) Then %>
            jsEventLogin();
        <% else %>
            if (!document.getElementById("notRobot4").checked) {
                alert("'나는 BOT이 아닙니다.'를 체크해주세요.");
                return false;
            }

            $.ajax({
                type:"GET",
                url:"/event/timesale/timesale_proc.asp",
                data: "mode=order&sendCount=<%=fnGetCurrentType(isAdmin,currentType)%><%=addParam%>",
                dataType: "text",
                async:false,
                cache:true,
                success : function(Data, textStatus, jqXHR){
                    if (jqXHR.readyState == 4) {
                        if (jqXHR.status == 200) {
                            if(Data!="") {
                                var result = JSON.parse(Data);
                                if(result.response == "ok"){
                                    $("#itemid").val(result.message);
                                    setTimeout(function() {
                                        document.directOrd.submit();
                                    },300);
                                    return false;
                                }else{
                                    console.log(result.faildesc);
                                    return false;
                                }
                            } else {
                                alert("잘못된 접근 입니다.1");
                                document.location.reload();
                                return false;
                            }
                        }
                    }
                },
                error:function(jqXHR, textStatus, errorThrown){
                    console.log("접근 실패!");
                    return false;
                }
            });    
        <% End IF %>
    }

    function jsEventLogin(){
        if(confirm("로그인후 구매 하실 수 있습니다.")){
            location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
            return;
        }
    }
</script>
<div class="evt98760 time-sale">
<% if isTeaser then %>
    <!-- #include virtual="/event/timesale/teaser.asp" -->
<% else %>
    <% if fnGetCurrentType(isAdmin,currentType) = "0" then '// 시작 직전 %>
        <!-- #include virtual="/event/timesale/itemsoon.asp" -->
    <% else %>
        <!-- #include virtual="/event/timesale/itemlist.asp" -->
    <% end if %>
<% end if %>
    <%'!-- 페어플레이 레이어 --%>
    <div class="lyr lyr-fair" id="fairplay" style="display:none;"></div>
    <%'!-- 타임세일 종료 --%>
    <div class="lyr lyr-end" style="display:none;">
        <div class="inner">
            <%'!-- 첫번째 타임세일(종료) --%>
            <%
                FOR loopInt = 0 TO oTimeSale.FResultCount - 1
                    call oTimeSale.FitemList(loopInt).fnItemLimitedState(isSoldOut,RemainCount)
                    call oTimeSale.FitemList(loopInt).fnItemPriceInfos(totalPrice , salePercentString , couponPercentString , totalSalePercent)

                    IF oTimeSale.FitemList(loopInt).Fsortnumber = 1 THEN
            %>
            <div class="time-items" style="display:none;">
                <p class="txt-time"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98760/tit_time2_<%=oTimeSale.FitemList(loopInt).Fround%>.png" alt="<%=oTimeSale.FitemList(loopInt).Fround%>회 세일"></p>
                <ul>
            <%
                    END IF
            %>
                    <li>
                        <div class="thumbnail">
                            <img src="<%=oTimeSale.FitemList(loopInt).FprdImage%>" alt= "">
                            <div class="label-box">
                                <span class="label"><%=chkiif(RemainCount > 0 and RemainCount < 100 ,RemainCount&"개 한정" , "한정판매")%></span>
                            </div>
                        </div>
                        <div class="desc">
                            <div class="name"><%=fnGetItemName(oTimeSale.FitemList(loopInt).Fround,oTimeSale.FitemList(loopInt).Fsortnumber)%></div>
                            <div class="price">
                                <p>
                                <% IF oTimeSale.FitemList(loopInt).Fitemdiv <> "21" THEN %>
                                    <b><%=formatnumber(oTimeSale.FitemList(loopInt).Forgprice,0)%></b>
                                <% END IF %>
                                <em><%=chkiif(oTimeSale.FitemList(loopInt).Fitemdiv = "21",formatnumber(oTimeSale.FitemList(loopInt).FmasterSellCash,0)&"~",totalPrice)%><span>원</span></em></p>
                                <% IF oTimeSale.FitemList(loopInt).Fitemdiv = "21" THEN %>
                                    <% IF oTimeSale.FitemList(loopInt).FmasterDiscountRate > 0 THEN %><i class="sale">~<%=oTimeSale.FitemList(loopInt).FmasterDiscountRate%>%</i><% end if %>
                                <% ELSE %>
                                    <% if totalSalePercent <> "0" then %><i class="sale"><%=totalSalePercent%></i><% end if %>
                                <% END IF %>
                            </div>
                        </div>
                    </li>
            <%
                    IF oTimeSale.FitemList(loopInt).Fsortnumber = 8 THEN
            %>
                </ul>
            </div>
            <%
                    END IF
                NEXT
            %>
            <button class="btn-close"></button>
        </div>
    </div>

    <%'!-- 알람받기 레이어 --%>
    <div class="lyr lyr-alarm" style="display:none;">
        <div class="inner">
            <p><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/txt_push.png" alt="기회를 놓치지 않는 가장 확실한 방법"></p>
            <div class="input-box"><input type="number" id="phone1" placeholder="000" maxlength="3" oninput="maxLengthCheck(this)">-<input type="number" id="phone2" placeholder="0000" maxlength="4" oninput="maxLengthCheck(this)">-<input type="number" id="phone3" placeholder="0000" maxlength="4" oninput="maxLengthCheck(this)"><button class="btn-submit" onclick="fnSendToKakaoMessage()">확인</button></div>
            <button class="btn-close"></button>
        </div>
    </div>

    <div id="mask-time"></div>

    <%'!-- 추가 연관 이벤트 --%>
    <div class="related-evt">
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/98760/img_related_evt_v2.jpg" alt="잠깐 찬스, 하나더 아니, 세개 더" usemap="#evt-map">
        <map name="evt-map">
            <area target="_blank" alt="지금부터 준비하세요! 크리스마스 소품의 모든 것" title="지금부터 준비하세요! 크리스마스 소품의 모든 것" href="/christmas/" coords="347,87,677,352" shape="rect" onfocus="this.blur();">
            <area target="_blank" alt="지금 텐바이텐에서  가장 인기 많은 BEST 20" title="지금 텐바이텐에서  가장 인기 많은 BEST 20" href="/event/eventmain.asp?eventid=98620" coords="718,85,1050,354" shape="rect" onfocus="this.blur();">
            <area target="_blank" alt="텐바이텐이 처음이세요? 그럼 이 상품 꼭! 추천합니다" title="텐바이텐이 처음이세요? 그럼 이 상품 꼭! 추천합니다" href="/event/eventmain.asp?eventid=97607" coords="348,393,677,663" shape="rect" onfocus="this.blur();">
            <area target="_blank" alt="오마이걸" title="오마이걸" href="/event/eventmain.asp?eventid=98339" coords="718,395,1048,662" shape="rect" onfocus="this.blur();">
        </map>
    </div>
</div>

<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
    <input type="hidden" name="itemid" id="itemid" value="">
    <input type="hidden" name="itemoption" value="0000">
    <input type="hidden" name="itemea" value="1">
    <input type="hidden" name="mode" value="DO1">
</form>
<%
    set oTimeSale = nothing    
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->