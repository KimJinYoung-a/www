<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2021 타임세일 티저
' History : 2021-06-01 정태훈 생성
' History : 2021-06-18 정태훈 수정
'####################################################
%>
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim currentTime '// 현재 시간
dim mktTest '// 테스트 여부
dim LoginUserid : LoginUserid = GetEncLoginUserID()
dim eCode, evtCode
dim currentDate
dim currentType
dim evtDate, ingdate

mktTest = false

IF application("Svr_Info") = "Dev" THEN
	eCode = "107360"
    evtCode = "107361"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
	eCode = "111786"
    evtCode = "111787"
    mktTest = true    
Else
	eCode = "111786"
    evtCode = "111787"
    mktTest = false
End If

if mktTest then
    '// 테스트용
    if request("setting_time")<>"" then
        currentDate = CDate(request("setting_time"))
    else
        currentDate = CDate("2021-06-20 01:00:00")
    end if
    currentTime = Cdate("01:00:00")
else
    currentDate = CDate(Date()&" "&Right("0"&hour(time),2) &":"& Right("0"&minute(time),2) &":"& Right("0"&second(time),2))
    currentTime = time()    
end if

Dim gaparamChkVal
gaparamChkVal = requestCheckVar(request("gaparam"),30)

'// 2021년 06월 06일 이후엔 해당 페이지로 접근 하면 실제 이벤트 페이지로 자동으로 redirect 시켜줌
If Left(currentDate,10) >= "2021-06-21" and Left(currentDate,10) < "2021-06-24" Then
    response.redirect "/event/eventmain.asp?eventid=" & evtCode
    response.end
End If

evtDate = DateAdd("h",9,Cdate("2021-06-21"))
%>
<style>
.evt111786 {max-width:1920px; margin:0 auto; background:#fff;}
.evt111786 button {background-color:transparent;}
.evt111786 .topic {position:relative; width:100%; height:649px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111786/img_teaser_main.jpg) no-repeat 50% 0;}
.evt111786 .topic .teaser-main {position:relative; width:1140px; height:649px; margin:0 auto;}
.evt111786 .topic .teaser-main .btn-more {display:block; width:100%; background-color:rgba(0,0,10,0.5);}
.evt111786 .topic .teaser-main .list-wrap a {position:relative; display:inline-block; width:100%; height:100%;}
.evt111786 .topic .teaser-main .item-area {position:absolute; right:12%; top:21%; opacity:0.8;}
.evt111786 .topic .teaser-main .item-area .thumb .item1,
.evt111786 .topic .teaser-main .item-area .thumb .item2,
.evt111786 .topic .teaser-main .item-area .thumb .item3,
.evt111786 .topic .teaser-main .item-area .thumb .item4 {transition: .5s ease-in;}

.evt111786 .teaser-timer {width:100%; height:440px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111786/img_left_time.jpg) no-repeat 50% 0;}
.evt111786 .teaser-timer .timer-inner {position:relative; width:1140px; height:440px; margin:0 auto;}
.evt111786 .teaser-timer .sale-timer {position:absolute; bottom:16%; left:5.5%; color:#fff; font-size:75px; font-weight:700;}
.evt111786 .teaser-timer .btn-push {width:21.74rem; height:6.08rem; position:absolute; right:0; bottom:18%; background:transparent;}

.evt111786 .product-list {width:1020px; margin:0 auto 176px; padding-top:107px; background:#fff;}
.evt111786 .product-list .list {display:flex; justify-content:space-between; flex-wrap:wrap;}
.evt111786 .product-list .list li {margin-top:100px;}
.evt111786 .product-list .list li:first-child {margin-top:0!important;}
.evt111786 .product-list .list li:nth-child(odd) {margin-top:0;}
.evt111786 .product-list .product-inner {position:relative;}
.evt111786 .product-list .product-inner .num-limite {position:absolute; top:-14px; right:0; z-index:10; width:158px; height:42px; font-size:21px; font-weight:700; color:#fff; text-align:center; line-height:42px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111786/img_limit_sold.png) no-repeat 0 0; background-size:100%; content:'';}
.evt111786 .product-list .product-inner .num-limite em {padding-left:10px; font-size:25px;}

.evt111786 .product-list .desc .name {position:absolute; left:1.73rem; top:19.5rem; width:90%; overflow:hidden; font-size:23px; line-height:1.2; color:#111; font-weight:500; white-space:nowrap; text-overflow:ellipsis; text-align:left;}
.evt111786 .product-list .desc .price {display:flex; align-items:baseline; position:absolute; left:1.73rem; top:24rem; font-size:33px; font-weight:700; color:#111;}
.evt111786 .product-list .desc .price s {position:absolute; left:0; top:-1.5rem; font-size:23px; font-weight:400; color:#888;}
.evt111786 .product-list .desc .price span {display:inline-block; margin-left:1.1rem; color:#ff0943; font-size:40px;}
.evt111786 .product-list .desc .price .p-won {font-size:21px; color:#111; margin:0 0 7px 1px;}

.evt111786 .pop-container .input-box {position:absolute; left:105px; top:70%; display:flex; justify-content:space-between; align-items:center; width:54%;}
.evt111786 .pop-container .input-box input {width:100%; height:51px; padding:0; background-color:transparent; border:0; border-bottom:solid 3px #acfe25; border-radius:0; color:#fff; font-size:27px; text-align:left;}
.evt111786 .pop-container .input-box .btn-submit {width:65px; height:54px; margin-left:-1px; color:#acfe25; border-bottom:solid 3px #acfe25; font-size:21px; background:transparent;}
.evt111786 .pop-container .input-box input::placeholder {font-size:21px; color:#b7b7b7; text-align:left;}
.evt111786 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
.evt111786 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
.evt111786 .pop-container .pop-inner a {display:inline-block;}
.evt111786 .pop-container .pop-inner .btn-close {position:absolute; right:66px; top:55px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111786/icon_close.png?v=4) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
.evt111786 .pop-container.push .contents-inner {position:relative; width:663px; height:765px; margin:0 auto;}

.evt111786 .wish-list .thumbnail {width:230px;}
.evt111786 .wish-list .thumbnail img {width:100%;}
.evt111786 .wish-list .desc {padding-left:5px;}
.evt111786 .wish-list .name {height:40px; margin-top:10px; font-size:14px; line-height:1.46;}
.evt111786 .wish-list .price {margin-top:13px; color:#222; font-size:16px; font-weight:bold;}
.evt111786 .wish-list .sale {color:#fe3f3f; font-size:12px;}

.noti-area {max-width:1920px; margin:0 auto; background:#262626;}
.noti-area .noti-header .btn-noti {position:relative; width:1140px; margin:0 auto;}
.noti-area .noti-header .btn-noti span {display:inline-block; position:absolute; left:50%; top:80px; transform:translate(610%,0);}
.noti-area .noti-header .btn-noti.on span img {transform:rotate(180deg);}
.noti-area .noti-info {display:none; width:1140px; margin:0 auto;}
.noti-area .noti-info.on {display:block;}
</style>
<script type="text/javascript" src="/event/lib/countdown24.js?v=1.0"></script>
<script>
countDownTimer("<%=Year(evtDate)%>"
                , "<%=TwoNumber(Month(evtDate))%>"
                , "<%=TwoNumber(Day(evtDate))%>"
                , "<%=TwoNumber(hour(evtDate))%>"
                , "<%=TwoNumber(minute(evtDate))%>"
                , "<%=TwoNumber(Second(evtDate))%>"
                , new Date(<%=Year(currentDate)%>, <%=Month(currentDate)-1%>, <%=Day(currentDate)%>, <%=Hour(currentDate)%>, <%=Minute(currentDate)%>, <%=Second(currentDate)%>)
                );
$(function(){
    // 시간 롤링
    changingImg();
	function changingImg(){
		var i=1;
		var repeat = setInterval(function(){
			i++;
			if(i>10){i=1;}
            $('.teaser-main .item-area .thumb img').attr('src','//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_item0'+ i +'.png').attr('class','item' + i);
            /* if(i == 5) {
                clearInterval(repeat);
            } */
        },1000);
    }
    //팝업
    /* 응모완료 팝업 */
    $('.evt111786 .btn-push').click(function(){
        $('.pop-container.push').fadeIn();
    })
    /* 팝업 닫기 */
    $('.evt111786 .btn-close').click(function(){
        $(".pop-container").fadeOut();
    })
    //유의사항 버튼
    $('.btn-noti').on("click",function(){
        $('.noti-info').toggleClass("on");
        $(this).toggleClass("on");
    });
});
//maxlength validation in input type number
function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
        object.value = object.value.slice(0, object.maxLength);
    }
}

function fnSendToKakaoMessage() {
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
        type:"GET",
        url:"/event/etc/doeventSubscript111786.asp",
        data: "mode=kamsg&phoneNumber="+btoa(phoneNumber),
        <% if mktTest then %>
        testdate: "<%=currentDate%>",
        <% end if %>
        dataType: "text",
        async:false,
        cache:true,
        success : function(Data, textStatus, jqXHR){
            if (jqXHR.readyState == 4) {
                if (jqXHR.status == 200) {
                    if(Data!="") {
                        var str;
                        for(var i in Data)
                        {
                                if(Data.hasOwnProperty(i))
                            {
                                str += Data[i];
                            }
                        }
                        str = str.replace("undefined","");
                        res = str.split("|");
                        if (res[0]=="OK") {
                            alert('신청이 완료되었습니다.');
                            $("#phone").val('')
                            $(".pop-container").fadeOut();
                            return false;
                        }else{
                            errorMsg = res[1].replace(">?n", "\n");
                            alert(errorMsg );
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
</script>
						<div class="evt111786">
							<div class="topic">
                                <!-- 티저 main -->
                                <div class="teaser-main">
                                    <div>
                                        <!-- 이미지아이콘 영역 -->
                                        <div class="item-area">
                                            <div class="thumb item1"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/time_1.png" alt="item" class="item1"></div>
                                        </div>
                                        <!-- // -->
                                    </div>
                                </div>
                            </div>
                            
                            <!-- 티저 상품 -->
                            <div class="product-list">
                                <ul id="list1" class="list list1">
                                    <% If currentDate >= #06/20/2021 00:00:00# and currentDate < #06/21/2021 00:00:00# Then %>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/time_header_01.png" alt="오전 9시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/eventIMG/deal_tzImage/202106/deal_tzImage20210617152648.jpg" alt="소니 WH-1000XM4 노이즈 캔슬링 헤드폰 실버">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/time_header_02.png?v=2" alt="오후 12시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/eventIMG/deal_tzImage/202106/deal_tzImage20210617175313.jpg" alt="스누피 리유저블 콜드컵 5개세트 4,900원 특가!">
                                            <span class="num-limite"><em>50</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/time_header_03.png?v=2" alt="오후 3시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/eventIMG/deal_tzImage/202106/deal_tzImage20210617175507.jpg" alt="[클레어] 무선선풍기">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/time_header_04.png?v=2" alt="오후 6시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/eventIMG/deal_tzImage/202106/deal_tzImage20210617175750.jpg" alt="헤이릴렉스캄다운 코퍼비치 캔버스 릴렉스체어 (Beige)">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <% end if %>
                                </ul>
                            </div>

                            <!-- 유의사항 -->
                            <div class="noti-area">
                                <div class="noti-header">
                                    <button type="button" class="btn-noti"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/tit_noti.jpg?v=2" alt="유의사항 확인하기"><span><img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/icon_noti_arrow.png" alt=""></span></button>
                                </div>
                                <div class="noti-info">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/img_noti_info.jpg?v=2" alt="유의사항 내용">
                                </div>
                            </div>

                            <!-- 티저 시작전 알림받기 -->
                            <div class="teaser-timer">
                                <div class="timer-inner">
                                    <div class="sale-timer">
                                        <div><span>-</span><span id="countdown">00:00:00</span></div>
                                    </div>
                                    <button type="button" class="btn-push"></button>
                                </div>
                            </div>

                            <div class="pop-container push">
                                <div class="pop-inner">
                                    <div class="pop-contents">
                                        <div class="contents-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/pop_push.png?v=3" alt="기회를 놓치지 않는 가장 확실한 방법">
						                    <div class="input-box"><input type="number" id="phone" maxlength="11" oninput="maxLengthCheck(this)" placeholder="휴대폰 번호를 입력해주세요"><button type="button" class="btn-submit" onclick="fnSendToKakaoMessage()">확인</button></div>
                                            <button type="button" class="btn-close">닫기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->