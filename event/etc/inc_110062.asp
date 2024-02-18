<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2021 정기세일 타임세일 티저
' History : 2021-03-23 정태훈 생성
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
dim eCode
dim currentDate
dim currentType
dim evtDate, ingdate

mktTest = false

IF application("Svr_Info") = "Dev" THEN
	eCode = "104334"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
	eCode = "110062"
    mktTest = true    
Else
	eCode = "110062"
    mktTest = false
End If

if mktTest then
    '// 테스트용
    if request("testCheckDate")<>"" then
        currentDate = CDate(request("testCheckDate"))
    else
        currentDate = CDate("2021-03-28 01:00:00")
    end if
    currentTime = Cdate("01:00:00")
    '// 테스트 끝나면 사고 방지 차원에서 서버 시간으로 변경
    'currentDate = CDate(Date()&" "&Right("0"&hour(time),2) &":"& Right("0"&minute(time),2) &":"& Right("0"&second(time),2))
    'currentTime = time()
else
    currentDate = CDate(Date()&" "&Right("0"&hour(time),2) &":"& Right("0"&minute(time),2) &":"& Right("0"&second(time),2))
    currentTime = time()    
end if

Dim gaparamChkVal
gaparamChkVal = requestCheckVar(request("gaparam"),30)

'// 2021년 03월 29일 이후엔 해당 페이지로 접근 하면 실제 이벤트 페이지로 자동으로 redirect 시켜줌
If Left(currentDate,10) >= "2021-03-29" and Left(currentDate,10) < "2021-03-30" Then
    response.redirect "/event/eventmain.asp?eventid=110063"
    response.end
elseif Left(currentDate,10) >= "2021-03-31" and Left(currentDate,10) < "2021-04-01" Then
    response.redirect "/event/eventmain.asp?eventid=110063"
    response.end
elseif Left(currentDate,10) >= "2021-04-05" and Left(currentDate,10) < "2021-04-06" Then
    response.redirect "/event/eventmain.asp?eventid=110063"
    response.end
elseif Left(currentDate,10) >= "2021-04-07" and Left(currentDate,10) < "2021-04-08" Then
    response.redirect "/event/eventmain.asp?eventid=110063"
    response.end
elseif Left(currentDate,10) >= "2021-04-12" and Left(currentDate,10) < "2021-04-13" Then
    response.redirect "/event/eventmain.asp?eventid=110063"
    response.end
elseif Left(currentDate,10) >= "2021-04-14" and Left(currentDate,10) < "2021-04-15" Then
    response.redirect "/event/eventmain.asp?eventid=110063"
    response.end
End If

evtDate = DateAdd("h",9,DateAdd("d",1,left(currentDate, 10)))

'// 각 일자별 타임세일 날짜 셋팅
If currentDate >= #03/28/2021 00:00:00# and currentDate < #03/29/2021 00:00:00# Then
    ingdate=29
elseIf currentDate >= #03/30/2021 00:00:00# and currentDate < #03/31/2021 00:00:00# Then
    ingdate=31
elseIf currentDate >= #04/01/2021 00:00:00# and currentDate < #04/05/2021 00:00:00# Then
    ingdate=5
    evtDate = DateAdd("h",9,Cdate("2021-04-05"))
elseIf currentDate >= #04/06/2021 00:00:00# and currentDate < #04/07/2021 00:00:00# Then
    ingdate=7
elseIf currentDate >= #04/08/2021 00:00:00# and currentDate < #04/12/2021 00:00:00# Then
    ingdate=12
    evtDate = DateAdd("h",9,Cdate("2021-04-12"))
elseIf currentDate >= #04/13/2021 00:00:00# and currentDate < #04/14/2021 00:00:00# Then
    ingdate=14
else
    ingdate=14
end if
%>
<style>
.evt110062 {max-width:1920px; margin:0 auto; background:#fff;}
.evt110062 button {background-color:transparent;}
.evt110062 .topic {position:relative; width:100%; height:649px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110064/img_teaser_main.jpg) no-repeat 50% 0;}
.evt110062 .topic .teaser-main {position:relative; width:1140px; height:649px; margin:0 auto;}
.evt110062 .topic .teaser-main .btn-more {display:block; width:100%; background-color:rgba(0,0,10,0.5);}
.evt110062 .topic .teaser-main .list-wrap a {position:relative; display:inline-block; width:100%; height:100%;}
.evt110062 .topic .teaser-main .show-days {position:absolute; left:5%; top:54.5%; display:flex; align-items:center; font-size:63px; font-weight:700; color:#1e211d;}
.evt110062 .topic .teaser-main .show-days span {font-size:51px;}
.evt110062 .topic .teaser-main .item-area {position:absolute; right:15.5%; top:20%; opacity:0.8;}
.evt110062 .topic .teaser-main .item-area .thumb .item1,
.evt110062 .topic .teaser-main .item-area .thumb .item2,
.evt110062 .topic .teaser-main .item-area .thumb .item3,
.evt110062 .topic .teaser-main .item-area .thumb .item4,
.evt110062 .topic .teaser-main .item-area .thumb .item5,
.evt110062 .topic .teaser-main .item-area .thumb .item6,
.evt110062 .topic .teaser-main .item-area .thumb .item7,
.evt110062 .topic .teaser-main .item-area .thumb .item8,
.evt110062 .topic .teaser-main .item-area .thumb .item9,
.evt110062 .topic .teaser-main .item-area .thumb .item10 {transition: .5s ease-in;}

.evt110062 .comming-md {width:100%; height:602px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110064/img_more_prd.jpg?v=1.1) no-repeat 50% 0;}
.evt110062 .teaser-timer {width:100%; height:440px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110064/img_left_time.jpg) no-repeat 50% 0;}
.evt110062 .teaser-timer .timer-inner {position:relative; width:1140px; height:440px; margin:0 auto;}
.evt110062 .teaser-timer .sale-timer {position:absolute; bottom:16%; left:5.5%; color:#fff; font-size:75px; font-weight:700;}
.evt110062 .teaser-timer .btn-push {width:21.74rem; height:6.08rem; position:absolute; right:0; bottom:18%; background:transparent;}

.evt110062 .product-list {width:1020px; margin:0 auto; padding-top:107px; background:#fff;}
.evt110062 .product-list .list {display:flex; justify-content:space-between; flex-wrap:wrap;}
.evt110062 .product-list .list li:nth-child(1) {margin-top:0!important;}
.evt110062 .product-list .list li:nth-child(odd) {margin-top:-100px;}
.evt110062 .product-list .product-inner {position:relative;}
.evt110062 .product-list .product-inner .num-limite {position:absolute; top:-14px; right:0; z-index:10; width:158px; height:42px; font-size:21px; font-weight:700; color:#fff; text-align:center; line-height:42px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110064/img_limit_sold.png) no-repeat 0 0; background-size:100%; content:'';}
.evt110062 .product-list .product-inner .num-limite em {padding-left:10px; font-size:25px;}

.evt110062 .product-list .desc .name {position:absolute; left:1.73rem; top:19.5rem; width:90%; overflow:hidden; font-size:23px; line-height:1.2; color:#111; font-weight:500; white-space:nowrap; text-overflow:ellipsis; text-align:left;}
.evt110062 .product-list .desc .price {display:flex; align-items:baseline; position:absolute; left:1.73rem; top:24rem; font-size:33px; font-weight:700; color:#111;}
.evt110062 .product-list .desc .price s {position:absolute; left:0; top:-1.5rem; font-size:23px; font-weight:400; color:#888;}
.evt110062 .product-list .desc .price span {display:inline-block; margin-left:1.1rem; color:#ff0943; font-size:40px;}
.evt110062 .product-list .desc .price .p-won {font-size:21px; color:#111; margin:0 0 7px 1px;}

.evt110062 .pop-container .input-box {position:absolute; left:105px; top:70%; display:flex; justify-content:space-between; align-items:center; width:54%;}
.evt110062 .pop-container .input-box input {width:100%; height:51px; padding:0; background-color:transparent; border:0; border-bottom:solid 3px #acfe25; border-radius:0; color:#fff; font-size:27px; text-align:left;}
.evt110062 .pop-container .input-box .btn-submit {width:65px; height:54px; margin-left:-1px; color:#acfe25; border-bottom:solid 3px #acfe25; font-size:21px; background:transparent;}
.evt110062 .pop-container .input-box input::placeholder {font-size:21px; color:#b7b7b7; text-align:left;}
.evt110062 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
.evt110062 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
.evt110062 .pop-container .pop-inner a {display:inline-block;}
.evt110062 .pop-container .pop-inner .btn-close {position:absolute; right:66px; top:55px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110064/icon_close.png) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
.evt110062 .pop-container.push .contents-inner {position:relative; width:663px; height:765px; margin:0 auto;}

.evt110062 .wish-list .thumbnail {width:230px;}
.evt110062 .wish-list .thumbnail img {width:100%;}
.evt110062 .wish-list .desc {padding-left:5px;}
.evt110062 .wish-list .name {height:40px; margin-top:10px; font-size:14px; line-height:1.46;}
.evt110062 .wish-list .price {margin-top:13px; color:#222; font-size:16px; font-weight:bold;}
.evt110062 .wish-list .sale {color:#fe3f3f; font-size:12px;}

.noti-area {max-width:1920px; margin:0 auto; background:#262626;}
.noti-area .noti-header .btn-noti {position:relative; width:1140px; margin:0 auto;}
.noti-area .noti-header .btn-noti span {display:inline-block; position:absolute; left:50%; top:80px; transform:translate(610%,0);}
.noti-area .noti-header .btn-noti.on span img {transform:rotate(180deg);}
.noti-area .noti-info {display:none; width:1140px; margin:0 auto;}
.noti-area .noti-info.on {display:block;}
</style>
<script type="text/javascript" src="/event/lib/countdown24.js?v=1.1"></script>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo.js"></script>
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
    $('.evt110062 .btn-push').click(function(){
        $('.pop-container.push').fadeIn();
    })
    /* 팝업 닫기 */
    $('.evt110062 .btn-close').click(function(){
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
        url:"/event/etc/doeventSubscript110062.asp",
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
						<div class="evt110062">
							<div class="topic">
                                <div class="teaser-main">
                                    <div>
                                        <div class="show-days"><%=ingdate%><span>일</span></div>
                                        <div class="item-area">
                                            <div class="thumb item1"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_item01.png" alt="item" class="item1"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="product-list">
                                <ul id="list1" class="list list1">
                                <% If currentDate >= #03/28/2021 00:00:00# and currentDate < #03/29/2021 00:00:00# Then %>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_01.png?v=2" alt="오전 9시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_01_01.jpg?v=2" alt="스누피 레트로 토스터기">
                                            <span class="num-limite"><em>20</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_02.png" alt="오전 10시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_01_02.jpg?v=2" alt="드롱기 네스프레소 이니시아 EN80 크림화이트">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_03.png" alt="오전 11시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_01_03.jpg?v=2" alt="모나미 플러스펜-60색 세트">
                                            <span class="num-limite"><em>300</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_04.png" alt="오후 12시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_01_04.jpg?v=2" alt="[다이슨] 에어랩 스타일러 볼륨앤쉐이프">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_05.png" alt="오후 1시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_01_05.jpg?v=2" alt="[티파니앤코] 리턴 투 티파니 목걸이">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_06.png" alt="오후 2시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_01_06.jpg?v=2" alt="21SS 메종키츠네 폭스헤드 패치 티셔츠 (남성/블랙)">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_07.png" alt="오후 3시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_01_07.jpg?v=2" alt="AU테크 레드윙 블랙 36V 10Ah 8인치 전동킥보드">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_08.png" alt="오후 4시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_01_08.jpg?v=2" alt="구찌 GG 마몬트 마틀라세 카드홀더 핑크">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_09.png" alt="오후 5시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_01_09.jpg?v=2" alt="정관장 에브리타임 밸런스(10ml*30포)">
                                            <span class="num-limite"><em>30</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_10.png?v=2" alt="오후 6시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_01_10.jpg?v=2" alt="애플 에어팟 프로">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                <% elseIf currentDate >= #03/30/2021 00:00:00# and currentDate < #03/31/2021 00:00:00# Then %>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_01.png?v=2" alt="오전 9시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_02_01.jpg?v=2" alt="[디즈니] 미녀와야수_Tea Pot set (티팟+찻잔2인조)">
                                            <span class="num-limite"><em>20</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_02.png" alt="오전 10시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_02_02.jpg?v=2.2" alt="[Peanuts] 스누피 샌드위치/와플메이커">
                                            <span class="num-limite"><em>20</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_03.png" alt="오전 11시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_02_03.jpg?v=2" alt="on the table 펜케이스 (new color)">
                                            <span class="num-limite"><em>200</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_04.png" alt="오후 12시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_02_04.jpg?v=2" alt="[다이슨] 싸이클론 V10 플러피 오리진 무선 청소기">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_05.png" alt="오후 1시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_02_05.jpg?v=2" alt="[구찌] TRADEMARK 실버 네크리스">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_06.png" alt="오후 2시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_02_06.jpg?v=2" alt="갤럭시 버즈 프로  바이올렛">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_07.png" alt="오후 3시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_02_07.jpg?v=2" alt="[딥디크] 롬보르 단 로 리미티드 EDT 100ml [BH] (선물포장가능)">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_08.png" alt="오후 4시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_02_08.jpg?v=2" alt="첨스 폴딩 웨건_love&peace">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_09.png" alt="오후 5시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_02_09.jpg?v=2" alt="프라다 사피아노 남성카드지갑 블랙 2MC223">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_10.png?v=2" alt="오후 6시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_02_10.jpg?v=2" alt="게이밍 의자 GC001 울프">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                <% elseIf currentDate >= #04/01/2021 00:00:00# and currentDate < #04/05/2021 00:00:00# Then %>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_01.png?v=2" alt="오전 9시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_03_01.jpg?v=2" alt="21SS 아미 스몰 하트로고 맨투맨 (블랙) BFHJ007 730 001">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_02.png" alt="오전 10시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_03_02.jpg?v=2.2" alt="[다이슨] 슈퍼소닉 헤어 드라이기 HD-03 (아이언핑크)">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_03.png" alt="오전 11시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_03_03.jpg?v=2" alt="[조말론] 잉글리쉬페어 앤 프리지아 코롱 100ml">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_04.png" alt="오후 12시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_03_04.jpg?v=2" alt="정기배송 1달 다이어트도시락 패키지 (총 24팩)">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_05.png" alt="오후 1시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_03_05.jpg?v=2" alt="닌텐도 스위치 동물의 숲 에디션 + 모여봐요 동물의 숲 세트">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_06.png" alt="오후 2시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_03_06.jpg?v=2" alt="정관장 에브리타임 밸런스(10ml*20포)">
                                            <span class="num-limite"><em>30</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_07.png" alt="오후 3시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_03_07.jpg?v=2" alt="[BRAUN] 브라운 전기면도기 시리즈6 (60-B4200CS+CC(세척스테이션)) ">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_08.png" alt="오후 4시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_03_08.jpg?v=2" alt="뱀부 원목 2단 수납장">
                                            <span class="num-limite"><em>15</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_09.png" alt="오후 5시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_03_09.jpg?v=2" alt="발렌시아가 21SS 로고 카드지갑 637130 1IZI1M 1090 ">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_10.png?v=2" alt="오후 6시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_03_10.jpg?v=2.1" alt="[Sanrio] 헬로키티 칼도마살균기">
                                            <span class="num-limite"><em>20</em>개 한정</span>
                                        </div>
                                    </li>
                                <% elseIf currentDate >= #04/06/2021 00:00:00# and currentDate < #04/07/2021 00:00:00# Then %>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_01.png?v=2" alt="오전 9시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_04_01.jpg?v=2" alt="버버리 8026608 호스페리 프린트 캔버스 크로스백">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_02.png" alt="오전 10시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_04_02.jpg?v=2.2" alt="[커블체어] 바른자세교정 서포트체어 와이더 (컬러랜덤)">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_03.png" alt="오전 11시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_04_03.jpg?v=2" alt="[라이브워크] 리틀띵스 타이포 스티커 세트 (10장)">
                                            <span class="num-limite"><em>200</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_04.png" alt="오후 12시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_04_04.jpg?v=2" alt="갤럭시탭S7 11.0 Wi-Fi 128GB 실버">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_05.png" alt="오후 1시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_04_05.jpg?v=2" alt="정기배송 1달 토핑샐러드 패키지(총 20팩)">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_06.png" alt="오후 2시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_04_06.jpg?v=2" alt="[행사] 로지텍 코리아 MK470 슬림 무선 키보드 마우스 Set 화이트">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_07.png" alt="오후 3시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_04_07.jpg?v=2" alt="[스와로브스키] DAZZLING SWAN 블루스완 목걸이">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_08.png" alt="오후 4시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_04_08.jpg?v=2" alt="[공식수입원] 발뮤다 더 퓨어 공기청정기 (A01B-WH)">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_09.png" alt="오후 5시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_04_09.jpg?v=2" alt="지누스 에센스 그린티 메모리폼 토퍼 (10.5cm/슈퍼싱글)">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_10.png?v=2" alt="오후 6시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_04_10.jpg?v=2.1" alt="[Peanuts] 스누피 터치 무드등">
                                            <span class="num-limite"><em>20</em>개 한정</span>
                                        </div>
                                    </li>
                                <% elseIf currentDate >= #04/08/2021 00:00:00# and currentDate < #04/12/2021 00:00:00# Then %>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_01.png?v=2" alt="오전 9시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_05_01.jpg?v=2" alt="베어브릭 라이너스 400%">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_02.png" alt="오전 10시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_05_02.jpg?v=2.2" alt="구찌 슈프림 웹 파우치 클러치백">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_03.png" alt="오전 11시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_05_03.jpg?v=2" alt="[타임특가] 라미 만년필 한정판 사파리 캔디-바이올렛 EF">
                                            <span class="num-limite"><em>100</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_04.png" alt="오후 12시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_05_04.jpg?v=2.1" alt="대폭할인! 990원에 디즈니 프린세스 찻잔세트 득템!">
                                            <span class="num-limite"><em>20</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_05.png" alt="오후 1시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_05_05.jpg?v=2" alt="지누스 그린티 플러스 메모리폼 매트리스 (20cm/슈퍼싱글)">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_06.png" alt="오후 2시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_05_06.jpg?v=2" alt="[드롱기] 토스터기 디스틴타(화이트)">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_07.png" alt="오후 3시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_05_07.jpg?v=2" alt="[판도라] 노티드 하트 실버 팔찌 (18호)">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_08.png" alt="오후 4시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_05_08.jpg?v=2" alt="(텐바이텐 단독오픈) 러브플라보 SET (씰스티커6종 - 씰스티커파일)">
                                            <span class="num-limite"><em>200</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_09.png" alt="오후 5시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_05_09.jpg?v=2" alt="리트 올인원 PC 27A 확장형 64GB + SSD 240">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_10.png?v=2" alt="오후 6시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_05_10.jpg?v=2.1" alt="스누피 테이블이 990원이라구?!">
                                            <span class="num-limite"><em>20</em>개 한정</span>
                                        </div>
                                    </li>
                                <% elseIf currentDate >= #04/13/2021 00:00:00# and currentDate < #04/14/2021 00:00:00# Then %>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_01.png?v=2" alt="오전 9시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_06_01.jpg?v=2.3" alt="수련 프라임 저주파 무릎 마사지기">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_02.png" alt="오전 10시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_06_02.jpg?v=2.2" alt="[타임특가] 아이코닉 샤이닝라인 투명 스티커 8종 세트">
                                            <span class="num-limite"><em>200</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_03.png" alt="오전 11시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_06_03.jpg?v=2" alt="[1WEEK/34봉] 채소습관 클렌즈주스 1달 단기관리프로그램">
                                            <span class="num-limite"><em>10</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_04.png" alt="오후 12시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_06_04.jpg?v=2" alt="신상! 곰돌이 푸 진공쌀통을 990원에 구매!">
                                            <span class="num-limite"><em>20</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_05.png" alt="오후 1시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_06_05.jpg?v=2" alt="테팔 데일리쿡 인덕션 프라이팬 4종">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_06.png" alt="오후 2시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_06_06.jpg?v=2" alt="꼼마꼼마 산뜻비말마스크 1장에 50원! (30매)">
                                            <span class="num-limite"><em>100</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_07.png" alt="오후 3시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_06_07.jpg?v=2" alt="톰브라운 삼선 카드지갑 화이트">
                                            <span class="num-limite"><em>3</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_08.png" alt="오후 4시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_06_08.jpg?v=2" alt="루미큐브 클래식 (정품 한글라이센스판)">
                                            <span class="num-limite"><em>30</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_09.png" alt="오후 5시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_06_09.jpg?v=2" alt="발뮤다 토스터기 화이트">
                                            <span class="num-limite"><em>5</em>개 한정</span>
                                        </div>
                                    </li>
                                    <li>
                                        <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/time_header_10.png?v=2" alt="오후 6시">
                                        <div class="product-inner">
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_pc_prd_06_10.jpg?v=2.1" alt="스누피 바디필로우(L)를 990원에 구매!">
                                            <span class="num-limite"><em>20</em>개 한정</span>
                                        </div>
                                    </li>
                                <% end if %>
                                </ul>
                            </div>

                            <div class="comming-md"></div>

                            <!-- 유의사항 -->
                            <div class="noti-area">
                                <div class="noti-header">
                                    <button type="button" class="btn-noti"><img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/tit_noti.jpg" alt="유의사항 확인하기"><span><img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/icon_noti_arrow.png" alt=""></span></button>
                                </div>
                                <div class="noti-info">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/img_noti_info.jpg?v=1" alt="유의사항 내용">
                                </div>
                            </div>

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
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/110064/pop_push.png" alt="기회를 놓치지 않는 가장 확실한 방법">
						                    <div class="input-box"><input type="number" id="phone" maxlength="11" oninput="maxLengthCheck(this)" placeholder="휴대폰 번호를 입력해주세요"><button type="button" class="btn-submit" onclick="fnSendToKakaoMessage()">확인</button></div>
                                            <button type="button" class="btn-close">닫기</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->