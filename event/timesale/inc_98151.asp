<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 이건 기회야! 릴레이 타임세일
' History : 2019-10-24 이종화 생성 - eventid = 98151
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim currentDate : currentDate = "2019-10-28" '// 이벤트일
dim isTeaser , isAdmin : isAdmin = false
dim currentType , currentTime
dim LoginUserid : LoginUserid = GetEncLoginUserID()
dim addParam , eCode

Call Alert_Return("이벤트가 종료 되었습니다.")
dbget.close()	:	response.End

IF application("Svr_Info") = "Dev" THEN
	eCode = "90417"	
Else
	eCode = "98151"
End If

'// 티져 여부
if date() = Cdate(currentDate) then 
    isTeaser = false 
else 
    isTeaser = true 
end If 

'// TEST
if LoginUserid="ley330" or LoginUserid="greenteenz" or LoginUserid="rnldusgpfla" or LoginUserid="cjw0515" or LoginUserid="thensi7" or LoginUserid = "motions" or LoginUserid = "jj999a" or LoginUserid = "phsman1" or LoginUserid = "jjia94" then
    if date() < Cdate(currentDate) then 
        isTeaser = chkiif(requestCheckVar(request("isTeaser"),1) = "1" or requestCheckVar(request("isTeaser"),1) = "" , true , false) '// true 티져 / false 본 이벤트
        currentType = requestCheckVar(request("currentType"),1) '// 1.am8 , 2.pm12 , 3.pm4 , 4.pm12
        isAdmin = true
        addParam = "&isAdmin=1"
    end if
end if

'// 시간별 타입 구분
function fnGetCurrentType(isAdmin , currentType)
    if isAdmin and currentType <> "" then 
        fnGetCurrentType = currentType
        Exit function
    elseif isAdmin and currentType = "" then 
        fnGetCurrentType = "0"
        Exit function
    end if

    '// 시간별 타입
    if hour(now) < 8 then 
        fnGetCurrentType = "0" 
    elseif hour(now) >= 8 and hour(now) < 12 then '// am 8 
        fnGetCurrentType = "1"
    elseif hour(now) >= 12 and hour(now) < 16 then '// pm 12  
        fnGetCurrentType = "2"
    elseif hour(now) >= 16 and hour(now) < 20 then  '// pm 4 
        fnGetCurrentType = "3"
    elseif hour(now) >= 20 then '// pm 8 
        fnGetCurrentType = "4"
    end if 
end function

'// 회차별 시간
function fnGetCurrentTime(currentType)
    select case currentType 
        case "0" 
            fnGetCurrentTime = DateAdd("h",8,Date())
        case "1"
            fnGetCurrentTime = DateAdd("h",12,Date())
        case "2"
            fnGetCurrentTime = DateAdd("h",16,Date())
        case "3"
            fnGetCurrentTime = DateAdd("h",20,Date())
        case "4"
            fnGetCurrentTime = DateAdd("h",24,Date())
        case else
            fnGetCurrentTime = DateAdd("d",1,Date())
    end select 
end function

'// 카카오 메시지 보낼 카운트
function fnGetSendCountToKakaoMassage(currentType)
    dim pushCount

    select case currentType
        case "0" 
            pushCount = 4
        case "1"
            pushCount = 3
        case "2"
            pushCount = 2
        case "3"
            pushCount = 1
        case "4"
            pushCount = 0
        case else
            pushCount = 0
    end select

    '// 10분전 까지 마감 이후 회차 줄어듬
    if currentType <> "0" and currentType <> "4" then 
        fnGetSendCountToKakaoMassage = chkiif(DateDiff("n",DateAdd("n",-10,fnGetCurrentTime(currentType)),now()) < 0 , pushCount , pushCount-1 )
    else
        fnGetSendCountToKakaoMassage = pushCount
    end if 
end function

'// Navi Html
function fnGettimeNavHtml(currentType)
    dim naviHtml , i
    dim timestamp(4) , addClassName(4)

    for i = 1 to 4
        timestamp(i) = i

        if timestamp(i) = Cint(currentType) then 
            addClassName(i) = "on"
        elseif timestamp(i) < Cint(currentType) then 
            addClassName(i) = "end"
        elseif timestamp(i) > Cint(currentType) then 
            addClassName(i) = ""
        end if 
    next

    naviHtml = naviHtml & "<ul class=""time-nav"">"
    naviHtml = naviHtml & "    <li class=""time time1 "& addClassName(1) &""">am8</li>"
    naviHtml = naviHtml & "    <li class=""time time2 "& addClassName(2) &""">pm12</li>"
    naviHtml = naviHtml & "    <li class=""time time3 "& addClassName(3) &""">pm4</li>"
    naviHtml = naviHtml & "    <li class=""time time4 "& addClassName(4) &""">pm8</li>"
    naviHtml = naviHtml & "</ul>"

    response.write naviHtml
end function

'// 다음 타임 display 체크
function fnNextDisplayCheck(currentType)
    dim checkFlag(4) , isDisplay(4) 
    dim i
    for i = 1 to 4
        checkFlag(i) = i

        if checkFlag(i) <= Cint(currentType) then 
            isDisplay(i) = "style=""display:none"""
        elseif checkFlag(i) > Cint(currentType) then 
            isDisplay(i) = "style=""display:block"""
        end if 
    next

    fnNextDisplayCheck = isDisplay
end function

'// setTimer
if isTeaser then 
    currentTime = DateAdd("d",1,Date()) '// 내일기준시간
else
    currentTime = fnGetCurrentTime(fnGetCurrentType(isAdmin,currentType))
end if 

' response.write isTeaser &"<br/>"
' response.write fnGetCurrentType(isAdmin,currentType) &"<br/>"
' response.write fnGetSendCountToKakaoMassage(fnGetCurrentType(isAdmin,currentType)) &"<br/>"

%>
<style>
.time-sale {background-color:#fff;font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif;}
.time-sale .inner {position:relative; width:1140px; height:100%; margin:0 auto;}
.time-sale button {background-color:transparent;}
.time-sale .sale-timer {position:absolute; top:357px; left:40px; color:#fff; font-size:90px; font-weight:bold; text-align:left; font-family:'roboto';}

.time-top {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/bg_top1.jpg); background-repeat:repeat-x; background-position:50% 50%; background-color:#3b0ce8;}
.time-top {position:relative;}
.time-top h2, .time-top p {position:absolute; top:80px; left:40px;}
.time-top h2:after {display:inline-block; position:absolute; top:55px; right:-30px; width:15px; height:15px; background-color:#00ff8a; border-radius:50%; content:''; animation:blink .8s infinite;}
.time-top p {top:335px}

.time-nav {display:flex; justify-content:space-between; position:absolute; top:210px; right:20px; width:485px;}
.time-nav .time {width:110px; height:113px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_time1_1.png?v=1.02); background-repeat:no-repeat; background-position:0 0; text-indent:-999em;}
.time-nav .time2 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_time1_2.png);}
.time-nav .time3 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_time1_3.png);}
.time-nav .time4 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_time1_4.png);}
.time-nav .time.on {background-position:0 -139px;}
.time-nav .time.end {margin:0 10px; background-position:0 100%; cursor:pointer;}

.alarm {padding:65px 0; text-align:left;}
.alarm .inner {display:flex; justify-content:space-between; align-items:flex-end; width:1060px; padding:0 40px;}
.alarm .btn-alarm {display:inline-block; background-repeat:no-repeat; background-position:50% 50%; text-indent:-999em;}
.alarm .btn-alarm1 {width:327px; height:98px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/btn_alarm1.png);}
.alarm .btn-alarm2 {width:451px; height:144px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/btn_alarm2.png);}
.alarm .btn-alarm3 {width:564px; height:174px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/btn_alarm3.png);}
.alarm .time-nav {position:relative; top:0; right:0; width:355px; margin-top:34px; margin-left:-15px;}
.alarm .time-nav .time {width:72px; height:78px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/img_time2_1.png?v=1.01);}
.alarm .time-nav .time2 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/img_time2_2.png);}
.alarm .time-nav .time3 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/img_time2_3.png);}
.alarm .time-nav .time4 {background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/img_time2_4.png);}
.alarm .time-nav .time.on {background-position:0 -115px;}
.alarm .time-nav .time.end {margin:0 10px; background-position:0 100%;}
.alarm .sale-timer {position:relative; top:0; left:0; font-size:68px; color:#000;}

.time-sale .desc {padding-left:5px; margin-top:12px; color:#000; }
.time-sale .name {font-size:15px; font-weight:bold; letter-spacing:-.3px;}
.time-sale .price {display:flex; align-items:flex-end; font-size:13px; line-height:1.3;}
.time-sale .price p {display:flex; flex-direction:column;}
.time-sale .price p b {display:inline-block; width:100%; color:#888; font-weight:normal; text-decoration:line-through;}
.time-sale .price em {font-weight:bold; font-size:18px;}
.time-sale .price em span {display:inline-block; margin-left:2px; font-size:14px; font-weight:normal;}
.time-sale .price .sale {display:inline-block; margin-left:16px; color:#ff3823; font-size:22px; font-weight:bold; font-style:normal; line-height:1;}

.time-items ul {display:flex; justify-content:space-between; margin-top:40px; margin-bottom:60px;}
.time-items ul li {width:170px;}
.time-items .thumbnail {position:relative; width:100%; height:170px;}
.time-items .thumbnail img {width:100%; height:100%;}
.time-items .thumbnail .label {display:inline-block; position:absolute; bottom:-5px; left:5px; z-index:10; height:17px; padding:0 10px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/bg_badge_blck.png); background-repeat:no-repeat; background-position:50% 50%; background-size:100% 100%; color:#fff; font-size:12px; line-height:18px;}
.time-items .special-item .thumbnail {background-color:transparent;}
.time-items .special-item .thumbnail .label {left:0; width:60px; height:17px; padding:0; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_limited_badge.png); text-indent:-999em;}

.time-teaser .time-top {height:600px;}
.time-teaser .time-top h2 {position:relative; top:0; left:0;}
.time-teaser .time-top h2:after {display:none;}
.time-teaser .slideshow {position:absolute; top:165px; right:106px; width:147px; height:139px;}
.time-teaser #slideshow div {position:absolute; top:0; left:0; z-index:8; width:100%; opacity:0.0;}
.time-teaser #slideshow div.active {z-index:10; opacity:1.0;}
.time-teaser #slideshow div.last-active {z-index:9;}
.time-teaser .teaser-item {background-color:#fff;}
.time-teaser .alarm {background-color:#f1efef;}

.coming-section {background-color:#eaeaea; text-align:left;}
.coming-section .inner {width:1060px; padding:10px 40px 25px;}

.time-soon .time-top {height:530px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/bg_top2.jpg);}

.time-ing .time-top {height:587px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/bg_top3.jpg);}
.time-ing .time-items-on ul {display:flex; flex-wrap:wrap; justify-content:space-between; width:1069px; margin:-105px auto 80px;}
.time-ing .time-items-on ul li {position:relative; width:345px; margin-top:45px; text-align:left;}
.time-ing .time-items-on ul li a {text-decoration:none;}
.time-ing .time-items-on .thumbnail {position:relative; width:100%; height:250px;}
.time-ing .time-items-on .thumbnail img {width:100%; height:100%;}
.time-ing .time-items-on .thumbnail .label {position:absolute; bottom:-10px; right:0; z-index:10; height:32px; padding:0 15px 0 20px; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/bg_badge_blck2.png); background-repeat:no-repeat; background-size:100% 100%; background-position:0 50%; color:#fff; font-size:16px; line-height:34px;}
.time-ing .time-items-on .special-item .label {width:124px; height:31px; padding:0; background-image:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/img_limited_badge2.png); text-indent:-999em;}
.time-ing .time-items-on .name {font-size:20px;}
.time-ing .time-items-on .price {justify-content:flex-start;}
.time-ing .time-items-on .price p {display:flex; flex-direction:column;}
.time-ing .time-items-on .price b {margin-top:10px; font-size:19px;}
.time-ing .time-items-on .price em {font-size:27px;}
.time-ing .time-items-on .price em span {font-size:16px; font-weight:bold;}
.time-ing .time-items-on .price .sale {margin-right:0; margin-left:15px; font-size:30px;}
.time-ing .time-items-on .price .sale .cp-sale {font-size:28px; color:#06b820;}
.time-ing .time-items-on li .btn-get {position:absolute; top:0; left:0; z-index:10; width:100%; height:100%; background-color:rgba(255,255,255,.55); opacity:0; transition:all .3s;}
.time-ing .time-items-on li .btn-get:after {display:inline-block; position:absolute; top:70px; left:50%; width:110px; height:110px; margin-left:-55px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/btn_get.png); content:'';}
.time-ing .time-items-on li:hover .btn-get {opacity:1;}
.time-ing .time-items-on .sold-out {position:relative;}
.time-ing .time-items-on .sold-out:after,
.time-ing .time-items-on .sold-out:before {display:inline-block; position:absolute; top:0; left:0; z-index:10; width:100%; height:100%; background-color:rgba(255,255,255,.55); content:'';}
.time-ing .time-items-on .sold-out:before {width:110px; height:110px; top:70px; left:50%; z-index:20; margin-left:-55px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/txt_sold_out.png)no-repeat 50% 50% / 100% 100%;}

.lyr {position:fixed; top:0; left:50%; z-index:250; width:100%;}
.lyr .btn-close {position:absolute; top:100px; right:36px; width:32px; height:32px; background:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/btn_close.png) 50% 50%/100%;}
.lyr-alarm {width:595px; margin-left:-298px;}
.lyr-alarm .inner {width:100%;}
.lyr-alarm p {padding-top:57px;}
.lyr-alarm .input-box {position:absolute; top:570px; left:75px; display:flex; justify-content:space-between; align-items:center; width:350px; color:#fff; font-weight:bold;}
.lyr-alarm .input-box input {width:33%; height:45px; padding:0; margin:0 5px; background-color:transparent; border:0; border-bottom:solid 3px #00ff8a; border-radius:0; color:#cbcbcb; font-size:22px; line-height:1; font-weight:bold; font-family:'Roboto', 'Noto Sans KR', 'malgun Gothic', '맑은고딕', sans-serif; text-align:center;}
.lyr-alarm .input-box input:first-child {margin-left:0;}
.lyr-alarm .input-box .btn-submit {width:80px; margin-left:10px; color:#00ff8a; font-size:22px; font-weight:bold;}
.lyr-alarm .btn-close {top:95px; right:40px;}

.lyr-end {width:1140px; top:50px; margin-left:-570px; text-align:left;}
.lyr-end .txt-time {padding-top:185px;}
.lyr-end .time-items li, .lyr-end .time-items .thumbnail {position:relative;}
.lyr-end .time-items li:before {display:inline-block; position:absolute; top:65px; left:50%; z-index:20; width:80px; height:auto; margin-left:-40px; color:#fff; font-size:16px; line-height:1.3; font-family:'AvenirNext-Medium', 'AppleSDGothicNeo-Medium'; content:'순식간에 판매완료'; text-align:center;}
.lyr-end .time-items .thumbnail:after {display:inline-block; position:absolute; top:0; left:0; z-index:5;width:100%; height:100%; background-color:rgba(0,0,0,.55); content:'';}
.lyr-end .time-items .name {font-weight:normal;}
.lyr-end .time-items .name, .lyr-end .time-items .price {color:#c2c2c2}

.related-evt {background:url(//webimage.10x10.co.kr/fixevent/event/2019/98151/bg_related.jpg) repeat-x 50% 50%;}
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
            data: "mode=kamsg&phoneNumber="+phoneNumber+"&sendCount=<%=fnGetSendCountToKakaoMassage(fnGetCurrentType(isAdmin,currentType))%><%=addParam%>",
            dataType: "text",
            async:false,
            cache:true,
            success : function(Data, textStatus, jqXHR){
                if (jqXHR.readyState == 4) {
                    if (jqXHR.status == 200) {
                        if(Data!="") {
                            var result = JSON.parse(Data);
                            if(result.response == "ok"){
                                $("#phone1").val('')
                                $("#phone2").val('')
                                $("#phone3").val('')
                                $(".lyr").fadeOut();
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
    
    $(function() {
        setInterval(function() {
            slideSwitch();
        }, 800);

        $("#slideshow").hover(function() {
            isStopped = true;
        }, function() {
            isStopped = false;
        });

        // 알림받기 레이어
        $('.btn-alarm').click(function (e) {
            if(!$(this).hasClass('btn-alarm3')){
                $('#mask-time').css({'background-color':'rgba(255,255,255,.9);'});
                $("#mask-time").show();
                $('.lyr-alarm').fadeIn();
                $("#phone1").focus();
            }
        });

        // 종료된 타임세일 상품 보기
        $('.time-nav .end').click(function(e) {
            var index = $(this).index();

            $('#mask-time').css({'background-color':'rgba(0,0,0,.9);'});
            $("#mask-time").fadeIn();
            $('.lyr-end').fadeIn();
            $('.lyr-end').find('.time-items').eq(index).fadeIn();
        });

        // 레이어
        $('.btn-close').click(function (e) {
            $("#mask-time").fadeOut();
            $('.lyr').fadeOut();
            $(this).find('.time-items').fadeOut();
            $('.lyr-end').find('.time-items').fadeOut();
        });
        $("#mask-time").click(function(){
            $(".lyr").fadeOut();
            $(this).find('.time-items').fadeOut();
            $('.lyr-end').find('.time-items').fadeOut();
            $("#mask-time").fadeOut();
        });
    });

    function goDirOrdItem(itemid) {
        <% If Not(IsUserLoginOK) Then %>
            jsEventLogin();
        <% else %>
                $("#itemid").val(itemid);
                setTimeout(function() {
                    document.directOrd.submit();
                },300);        
        <% End IF %>
    }

    function jsEventLogin(){
        if(confirm("로그인후 구매 하실 수 있습니다.")){
            location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
            return;
        }
    }
</script>
<div class="evt98151 time-sale">
<% if isTeaser then %>
    <!-- #include virtual="/event/timesale/teaser.asp" -->
<% else %>
    <% if fnGetCurrentType(isAdmin,currentType) = "0" then '// 시작 직전 %>
        <!-- #include virtual="/event/timesale/itemsoon.asp" -->
    <% else %>
        <!-- #include virtual="/event/timesale/itemlist.asp" -->
    <% end if %>
    <div class="related-evt">
        <img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/img_related_evt.jpg?v=1.01" alt="잠깐 찬스, 하나더 아니, 세개 더" usemap="#evt-map">
        <map name="evt-map">
            <area target="blank_" alt="텐바이텐은 처음이지?" href="/event/eventmain.asp?eventid=97607" coords="327,84,548,392" shape="rect" onfocus="this.blur();">
            <area target="blank_" alt="믿고 사는 별 다섯개 후기" href="/event/eventmain.asp?eventid=97554" coords="591,85,814,386" shape="rect" onfocus="this.blur();">
            <area target="blank_" alt="귀찮은건 딱 질색, 바로 최저가" href="/event/eventmain.asp?eventid=97582" coords="856,86,1081,387" shape="rect" onfocus="this.blur();">
        </map>
    </div>
<% end if %>
    <%'!-- 타임세일 종료 --%>
    <div class="lyr lyr-end" style="display:none;">
        <div class="inner">
            <%'!-- 첫번째 타임세일(종료) --%>
            <div class="time-items" style="display:none;">
                <p class="txt-time"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/tit_time2_1.png" alt="아침 8시 - 낮 12시"></p>
                <ul>
                    <li class="special-item">
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item1_spc_v2.png" alt=""></div>
                        <div class="desc">
                            <div class="name">스메그 전기포트 크림</div>
                            <div class="price"><p><b>177,000</b><em>29,900<span>원</span></em></p><i class="sale">83%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item1_1.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">일리 화이트 캡슐머신</div>
                            <div class="price"><p><b>179,000</b><em>143,300<span>원</span></em></p><i class="sale">20%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item1_2.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">추운날 담요로 따뜻하게</div>
                            <div class="price"><p><b>9,900~</b><em>9,400~<span>원</span></em></p><i class="sale">~62%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item1_3.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">JMW 드라이기</div>
                            <div class="price"><p><b>59,000~</b><em>34,900~<span>원</span></em></p><i class="sale">54%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item1_4.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">아이띵소 코트 & 가방</div>
                            <div class="price"><p><b>52,000~</b><em>32,760~<span>원</span></em></p><i class="sale">70%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item1_5.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">마크모크 단독 최저가</div>
                            <div class="price"><p><b>79,000~</b><em>33,900~<span>원</span></em></p><i class="sale">~58%</i></div>
                        </div>
                    </li>
                </ul>
            </div>
            <%'!-- 두번째 타임세일(예고) --%>
            <div class="time-items" style="display:none;">
                <p class="txt-time"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/tit_time2_2.png" alt="낮 12시 - 오후 4시"></p>
                <ul>
                    <li class="special-item">
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item2_spc_v2.png" alt=""></div>
                        <div class="desc">
                            <div class="name">±0 에코 히터 그레이</div>
                            <div class="price"><p><b>169,000</b><em>9,900<span>원</span></em></p><i class="sale">94%</i></div>
                        </div>
                    </li>
                    <li class="sold-out">
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item2_1.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">디즈니 레터링 라인</div>
                            <div class="price"><p><b>8,500~</b><em>4,250~<span>원</span></em></p><i class="sale">50%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item2_2.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">에어프라이어는 보토</div>
                            <div class="price"><p><b>99,000</b><em>55,000<span>원</span></em></p><i class="sale">44%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item2_3.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">뷰랩 주얼리 기프트박스</div>
                            <div class="price"><p><b>9,900~</b><em>8,720~<span>원</span></em></p><i class="sale">~45%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item2_4.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">우리 아이 첫 의자!</div>
                            <div class="price"><p><b>179,000</b><em>104,310<span>원</span></em></p><i class="sale">35%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item2_5.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">가볍게 채우자!</div>
                            <div class="price"><p><b>800~</b><em>390~<span>원</span></em></p><i class="sale">~56%</i></div>
                        </div>
                    </li>
                </ul>
            </div>
            <%'!-- 세번째 타임세일(예고) --%>
            <div class="time-items" style="display:none;">
                <p class="txt-time"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/tit_time2_3.png" alt="오후 4시 - 저녁 8시"></p>
                <ul>
                    <li class="special-item">
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item3_spc_v2.png?v=1.02" alt=""></div>
                        <div class="desc">
                            <div class="name">갤럭시 버즈 블랙</div>
                            <div class="price"><p><b>159,500</b><em>59,900<span>원</span></em></p><i class="sale">62%</i></div>
                        </div>
                    </li>
                    <li class="sold-out">
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item3_1.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">디즈니 디지털 파우치</div>
                            <div class="price"><p><b>2,500~</b><em>1,750~<span>원</span></em></p><i class="sale">~50%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item3_2.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">국민브랜드 왕자행거</div>
                            <div class="price"><p><b>25,900~</b><em>20,900~<span>원</span></em></p><i class="sale">~48%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item3_3.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">비온뒤 스터디 모음</div>
                            <div class="price"><p><b>1,300~</b><em>650~<span>원</span></em></p><i class="sale">~50%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item3_4.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">비아리츠 겨울 양말</div>
                            <div class="price"><p><b>3000~</b><em>1,500~<span>원</span></em></p><i class="sale">~76%</i></div>
                        </div>
                    </li>
                    <li>
                        <div class="thumbnail"><img src="//webimage.10x10.co.kr/fixevent/event/2019/98151/m/img_item3_5.jpg" alt=""></div>
                        <div class="desc">
                            <div class="name">하비풀 취미키트</div>
                            <div class="price"><p><b>19,500~</b><em>13,650~<span>원</span></em></p><i class="sale">~30%</i></div>
                        </div>
                    </li>
                </ul>
            </div>
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
</div>

<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
    <input type="hidden" name="itemid" id="itemid" value="">
    <input type="hidden" name="itemoption" value="0000">
    <input type="hidden" name="itemea" value="1">
    <input type="hidden" name="mode" value="DO1">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->