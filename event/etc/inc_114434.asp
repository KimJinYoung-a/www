<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 2021 타임세일
' History : 2021-10-06 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim isAdmin : isAdmin = false '// 관리자 여부
dim currentType '// 1이면 실제 진행상황, 0이면 준비 단계
dim currentTime '// 현재 시간
dim mktTest '// 테스트 여부
dim LoginUserid : LoginUserid = GetEncLoginUserID()
dim addParam , eCode , loopInt, evtCode
dim isItem, currentDate
dim totalPrice , salePercentString , couponPercentString , totalSalePercent
dim oTimeSale , isSoldOut , RemainCount
dim episode '// 일자별 회차로 보면 될듯..
dim sqlStr, evtCountTimeDate, evtCountTimeText, mdItemRound, evtDate
Dim episode1Itemid, episode2Itemid, episode3Itemid, episode4Itemid, episode5Itemid
dim episode6Itemid, episode7Itemid, episode8Itemid, episode9Itemid, episode10Itemid
dim mdItemsArr

mktTest = false

IF application("Svr_Info") = "Dev" THEN
	eCode = "109398"
    evtCode = "109397"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
	eCode = "114434"
    evtCode = "114433"
    mktTest = true
Else
	eCode = "114434"
    evtCode = "114433"
    mktTest = false
End If

if mktTest then
    '// 테스트용
    if request("testCheckDate")<>"" then
        currentDate = CDate(request("testCheckDate"))
    else
        currentDate = CDate("2021-10-12 09:00:00")
    end if
    currentTime = Cdate(Format00(2,hour(currentDate))&":"&Format00(2,minute(currentDate))&":"&Format00(2,second(currentDate)))
else
    currentDate = CDate(Date()&" "&Right("0"&hour(time),2) &":"& Right("0"&minute(time),2) &":"& Right("0"&second(time),2))
    currentTime = Cdate(Format00(2,hour(currentDate))&":"&Format00(2,minute(currentDate))&":"&Format00(2,second(currentDate)))
end if

Dim gaparamChkVal
gaparamChkVal = requestCheckVar(request("gaparam"),30)

'// 타임세일 기간 이후엔 해당 페이지로 접근 하면 티저 페이지로 자동으로 redirect 시켜줌
If Left(currentDate,10) < "2021-10-12" Then
    response.redirect "/event/eventmain.asp?eventid=" & evtCode
    response.end
End If

'// 각 일자별 타임세일 진행여부를 episode로 정함
If currentTime >= #09:00:00# and currentTime < #12:00:00# Then
    '// 09시 진행
    episode=1
elseIf currentTime >= #12:00:00# and currentTime < #15:00:00# Then
    '// 12시 진행
    episode=2
elseIf currentTime >= #15:00:00# and currentTime < #18:00:00# Then
    '// 15시 진행
    episode=3
elseIf currentTime >= #18:00:00# Then
    '// 18시 진행
    episode=4
else
    episode=0
end if

'엠디 상품 오픈 차수
If currentDate >= #2021-10-12 09:00:00# and currentDate < #2021-10-13 00:00:00# Then
    mdItemRound = 1
    if episode = 2 then
        mdItemsArr = "4123821,4124110,4027991,4027347,4125972,4125448,4085637,4125853,4125946,4120905"
    elseif episode = 3 then
        mdItemsArr = "4027347,4125972,4125448,4085637,4125853,4125946,4120905,4123821,4124110,4027991"
    elseif episode = 4 then
        mdItemsArr = "4085637,4125853,4125946,4120905,4123821,4124110,4027991,4027347,4125972,4125448"
    else
        mdItemsArr = "4120905,4123821,4124110,4027991,4027347,4125972,4125448,4085637,4125853,4125946"
    end if
elseIf currentDate >= #2021-10-14 09:00:00# and currentDate < #2021-10-15 00:00:00# Then
    mdItemRound = 2
    if episode = 2 then
        mdItemsArr = "3896747,3531352,3894095,3812529,3900627,3893866,3900847,3896980,3900877,3900683"
    elseif episode = 3 then
        mdItemsArr = "3812529,3900627,3893866,3900847,3896980,3900877,3900683,3896747,3531352,3894095"
    elseif episode = 4 then
        mdItemsArr = "3900847,3896980,3900877,3900683,3896747,3531352,3894095,3812529,3900627,3893866"
    else
        mdItemsArr = "3896980,3900877,3900683,3896747,3531352,3894095,3812529,3900627,3893866,3900847"
    end if
end if

If currentTime < #09:00:00# Then
    evtDate = CDate(left(currentDate,10)&" 09:00:00")
    evtCountTimeText = "세일 오픈까지"
else
    if episode=1 then
        evtDate = CDate(left(currentDate,10)&" 12:00:00")
        evtCountTimeText = "다음 특가상품 까지"
    elseif episode=2 then
        evtDate = CDate(left(currentDate,10)&" 15:00:00")
        evtCountTimeText = "다음 특가상품 까지"
    elseif episode=3 then
        evtDate = CDate(left(currentDate,10)&" 18:00:00")
        evtCountTimeText = "다음 특가상품 까지"
    elseif episode=4 then
        evtDate = DateAdd("d",1,left(currentDate,10))
        evtCountTimeText = "세일 종료까지"
    end if
end if
%>
<style>
.evt111787 {max-width:1920px; margin:0 auto; background:#fff;}
.evt111787 button {background-color:transparent;}
.evt111787 .topic {position:relative; width:100%; height:649px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/img_main.jpg?v=2) no-repeat 50% 0;}
.evt111787 .topic .main-top {position:relative; width:1140px; height:649px; margin:0 auto;}
.evt111787 .topic .main-top .show-time-current {position:absolute; right:-52px; top:240px;}
.evt111787 .topic .main-top .show-time-current .time-current-wrap {display:flex;}
.evt111787 .topic .main-top .show-time-current .time-current-wrap div {margin:0 20px;}
.evt111787 .topic .main-top .sale-timer {position:absolute; bottom:125px; left:30px; color:#fff; font-size:99px; font-weight:700;}
.evt111787 .topic .main-top .tit-ready {position:absolute; left:30px; bottom:251px;}
.evt111787 .topic .main-top .tit-ready h2 {color:#fff; font-size:30px; font-weight:500;}

.evt111787 .special-list-wrap {width:100%; height:580px;}
.evt111787 .special-list-wrap .special-item {position:relative; width:1140px; height:580px; margin:0 auto;}
.evt111787 .special-list-wrap .special-item .list {position:absolute; left:105px; top:-40px;}
.evt111787 .special-list-wrap .special-item a {display:inline-block; text-decoration:none;}

.evt111787 .special-list-wrap .special-item li.sold-out .product-inner .thum {position:relative;}
.evt111787 .special-list-wrap .special-item li.sold-out .product-inner .thum:before {content:""; position:absolute; left:0; top:0; display:inline-block; width:100%; height:100%; background-color:rgb(243, 243, 243); opacity:0.6; z-index:10;}
.evt111787 .special-list-wrap .special-item li.sold-out .product-inner .thum:after {content:""; position:absolute; left:50%; top:160px; display:inline-block; width:149px; height:149px; transform:translate(-50%,0); z-index:20; background:url(//webimage.10x10.co.kr/fixevent/event/2021/110064/txt_sold_out.png)no-repeat; background-size:100%;}
.evt111787 .special-list-wrap .special-item li.sold-out .go-link a {cursor:not-allowed; pointer-events:none;}

.evt111787 .special-list-wrap .special-item li.not-open .product-inner .thum {position:relative;}
.evt111787 .special-list-wrap .special-item li.not-open .product-inner .thum:before {content:""; position:absolute; left:0; top:0; display:inline-block; width:100%; height:100%; background-color:rgb(243, 243, 243); opacity:0.6; z-index:10;}
.evt111787 .special-list-wrap .special-item li.not-open .product-inner .thum:after {content:""; position:absolute; left:50%; top:160px; display:inline-block; width:149px; height:149px; transform:translate(-50%,0); z-index:20; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/m/txt_not_open.png)no-repeat; background-size:100%;}
.evt111787 .special-list-wrap .special-item li.not-open .go-link a {cursor:not-allowed; pointer-events:none;}

.evt111787 .special-list-wrap .special-item .desc {position:relative; width:calc(100% - 750px); margin-left:30px; margin-top:170px;}
/* 2021-04-01 수정 */
.evt111787 .special-list-wrap .special-item .desc .name {width:100%; height:62px; overflow:hidden; font-size:27px; line-height:1.2; color:#111; font-weight:500; text-overflow:ellipsis; text-align:left;}
.evt111787 .special-list-wrap .special-item .desc .price {display:flex; align-items:baseline; position:absolute; left:0; top:95px; font-size:40px; font-weight:700; color:#111;}
/* // */
.evt111787 .special-list-wrap .special-item .desc .price s {position:absolute; left:0; top:-15px; font-size:25px; font-weight:400; color:#888;}
.evt111787 .special-list-wrap .special-item .desc .price span {display:inline-block; margin-left:20px; color:#ff0943; font-size:50px;}
.evt111787 .special-list-wrap .special-item .desc .price .p-won {margin-left:10px; font-size:25px; font-weight:500; color:#111;}
.evt111787 .special-list-wrap .special-item .product-inner {position:relative; display:flex; align-items:flex-start; width:1050px;}
.evt111787 .special-list-wrap .special-item .product-inner .num-limite {display:inline-block; position:absolute; top:-11px; left:-28px; z-index:11; width:166px; height:51px; line-height:51px; font-size:21px; font-weight:700; color:#fff; text-align:center; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/img_limit_sold.png?v=2.1) no-repeat 50% 50%/100%; }
.evt111787 .special-list-wrap .special-item .product-inner .num-limite em {font-size:25px;}
.evt111787 .special-list-wrap .special-item .go-link {position:absolute; right:215px; bottom:30px;}
.evt111787 .special-list-wrap .special-item .txt-noti {position:absolute; left:220px; bottom:90px; font-size:15px; color:#9c9c9c; font-weight:500;}

.evt111787 .md-list{background:#fafafa;padding:132px 0;}
.evt111787 .md-list-wrap {width:1140px; margin:0 auto;}
.evt111787 .md-list-wrap #itemList {display:flex; flex-wrap:wrap; justify-content:space-between;margin: 0 100px;width:calc(100% - 200px);}
.evt111787 .md-list-wrap #itemList li {width:calc(50% - 20px); }
.evt111787 .md-list-wrap #itemList li:nth-child(even){padding-left:20px;}
.evt111787 .md-list-wrap #itemList li a {text-decoration:none;}
.evt111787 .md-list-wrap .desc {position:relative; height:190px; margin-top:30px;margin-left:10px;} /* 03-26 수정 */
.evt111787 .md-list-wrap .thumbnail {position:relative; width:450px; height:450px; background-color:#f4f4f4;}
.evt111787 .md-list-wrap .thumbnail:before {content:''; position: absolute; top: 50%; left: 50%; width: 4.27rem; height: 4.27rem; margin: -2.22rem 0 0 -2.22rem; background: url(http://fiximage.10x10.co.kr/m/2017/common/bg_img_loading.png) 50% 0 no-repeat; background-size: 100% auto;}
.evt111787 .md-list-wrap .thumbnail img {position:relative; width:100%; z-index:2;}
.evt111787 .md-list-wrap .thumbnail .num-limite{display:inline-block; position:absolute; bottom:-15px; left:0; z-index:11; width:115px; height:38px; line-height:38px; font-size:20px; color:#fff; text-align:center; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/img_limit_num.png?v=4) no-repeat 50% 50%/100%;}
.evt111787 .md-list-wrap .thumbnail .num-limite em {font-size:20px;}
/* md상품 영역 수정 */
/* 1줄일 때 */
.evt111787 .md-list-wrap .desc.line_01 .name {height:40px; overflow:hidden; font-size:24px; line-height:1.3; color:#111; font-weight:500; text-align:left;} /* 03-26 수정 */
.evt111787 .md-list-wrap .desc.line_01 .price {position:absolute; left:0; top:65px; font-size:28px; font-weight:700; color:#111;} /* 03-26 수정 */
.evt111787 .md-list-wrap .desc.line_01 .price s {position:absolute; left:0; top:-20px; font-size:21px; color:#888; font-weight:400;}
.evt111787 .md-list-wrap .desc.line_01 .price span {display:inline-block; margin-left:1.1rem; font-size:33px; color:#ff0943; font-weight:700;}
/* 2줄일 때 */
.evt111787 .md-list-wrap .desc.line_02 .name {height:60px; overflow:hidden; font-size:24px; line-height:1.3; color:#111; font-weight:500; text-align:left;} /* 03-26 수정 */
.evt111787 .md-list-wrap .desc.line_02 .price {position:absolute; left:0; top:95px; font-size:28px; font-weight:700; color:#111;} /* 03-26 수정 */
.evt111787 .md-list-wrap .desc.line_02 .price s {position:absolute; left:0; top:-20px; font-size:21px; color:#888; font-weight:400;}
.evt111787 .md-list-wrap .desc.line_02 .price span {display:inline-block; margin-left:1.1rem; font-size:33px; color:#ff0943; font-weight:700;}
/* // md상품 영역 수정 */

.evt111787 .teaser-timer {width:100%; height:440px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/img_left_time02.jpg?v=2) no-repeat 50% 0;}
.evt111787 .teaser-timer .timer-inner {position:relative; width:1140px; height:440px; margin:0 auto;}
.evt111787 .teaser-timer .sale-timer {position:absolute; bottom:16%; left:5.5%; color:#fff; font-size:75px; font-weight:700;}
.evt111787 .teaser-timer .btn-push {width:21.74rem; height:6.08rem; position:absolute; right:0; bottom:18%; background:transparent;}

.evt111787 .product-list-wrap {background:#effffb;}
.evt111787 .product-list {width:1020px; margin:0 auto; background:#effffb;}
.evt111787 .product-list .list {display:flex; justify-content:space-between; flex-wrap:wrap; padding:0 0 160px;}
.evt111787 .product-list .list li:nth-child(even) {margin-top:100px;}
.evt111787 .product-list .product-inner {position:relative;}
.evt111787 .product-list .product-inner .num-limite {position:absolute; top:-14px; right:0; z-index:10; width:158px; height:42px; font-size:21px; font-weight:700; color:#fff; text-align:center; line-height:42px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/img_limit_sold.png) no-repeat 0 0; background-size:100%; content:'';}
.evt111787 .product-list .product-inner .num-limite em {padding-left:10px; font-size:25px;}

.evt111787 .product-list .desc .name {position:absolute; left:1.73rem; top:19.5rem; width:90%; overflow:hidden; font-size:23px; line-height:1.2; color:#111; font-weight:500; white-space:nowrap; text-overflow:ellipsis; text-align:left;}
.evt111787 .product-list .desc .price {display:flex; align-items:baseline; position:absolute; left:1.73rem; top:24rem; font-size:33px; font-weight:700; color:#111;}
.evt111787 .product-list .desc .price s {position:absolute; left:0; top:-1.5rem; font-size:23px; font-weight:400; color:#888;}
.evt111787 .product-list .desc .price span {display:inline-block; margin-left:1.1rem; color:#ff0943; font-size:40px;}
.evt111787 .product-list .desc .price .p-won {font-size:21px; color:#111; margin:0 0 7px 1px;}

/* 쿠폰영역 생성 */
.evt111787 .coupon-area{width:100%;height:795px;background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/coupon.jpg?v=3) no-repeat 50% 0; position: relative;}
.evt111787 .coupon-area a.go-coupon{width:327px;height:83px;display:block;position:absolute;top:627px;left:50%;margin-left:-163.5px;}
/* // 쿠폰영역 생성 */

.sold-out-wrap {position:relative; height:763px; background:#f4f4f4;}
.sold-out-wrap .sold-out-list {width:1504px; position:absolute; left:50%; top:258px; transform:translate(-37.5%, 0);}
.sold-out-wrap .sold-out-list .slide-area .list {display:flex;}
.sold-out-wrap .swiper-button-prev {position:absolute; left:-2px; top:0;width:62px; height:440px; background:#f4f4f4; cursor:pointer;}
.sold-out-wrap .swiper-button-prev:before {content:""; position:absolute; left:2px; top:117px; display:inline-block; width:22px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/icon_arrow.png) no-repeat 0 0; background-size:100%;}
.sold-out-wrap .sold-out-list .sold-prd {display:flex; width:270px; height:440px;}
.sold-out-wrap .sold-out-list .sold-prd .thum {position:relative; width:270px;}
.sold-out-wrap .sold-out-list .sold-prd .tit-prd {width:inherit;}
.sold-out-wrap .sold-out-list .desc {position:relative; width:270px; padding-bottom:75px; margin:0.5rem 0 0 0.5rem;}
.sold-out-wrap .sold-out-list .desc .name {overflow:hidden; font-size:23px; line-height:1.2; color:#636363; font-weight:400; white-space:nowrap; text-overflow:ellipsis; text-align:left;}
.sold-out-wrap .sold-out-list .desc .price {display:flex; align-items:flex-end; position:absolute; left:0; top:45px; display:flex; margin-top:12px; font-size:28px; color:#6a6a6a; font-weight:700; opacity:0;}
.sold-out-wrap .sold-out-list .desc .price s {position:absolute; left:0; top:-1.3rem; font-size:20px; color:#888; font-weight:400;}
.sold-out-wrap .sold-out-list .desc .price span {display:inline-block; margin-left:10px; color:#000; font-size:28px;}
.sold-out-wrap .sold-out-list .desc .price .p-won {font-size:20px; font-weight:500; color:#6a6a6a; margin:0 0 4px 1px;}
.sold-out-wrap .sold-out-list .sold-prd.sold-out .price {opacity:1;}
.sold-out-wrap .sold-out-list .sold-prd.sold-out .thum:before {content:""; position:absolute; left:0; top:0; display:inline-block; width:270px; height:284px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111787/img_dim_sold.png?v=3) no-repeat 0 0; background-size:100%;}
.sold-out-wrap .sold-out-list li.sold-out .thum:after {position:absolute; left:19px; top:245px; display:inline-block; font-size:23px; color:#fff; font-weight:500;}
.sold-out-wrap .sold-out-list li:nth-child(1).sold-out .thum:after {content:"오전 9시";}
.sold-out-wrap .sold-out-list li:nth-child(2).sold-out .thum:after {content:"오전 12시"; left:15px;}
.sold-out-wrap .sold-out-list li:nth-child(3).sold-out .thum:after {content:"오후 3시"; left:15px;}
.sold-out-wrap .sold-out-list li:nth-child(4).sold-out .thum:after {content:"오후 6시"; left:15px;}

.evt111787 .pop-container .input-box {position:absolute; left:105px; top:70%; display:flex; justify-content:space-between; align-items:center; width:54%;}
.evt111787 .pop-container .input-box input {width:100%; height:51px; padding:0; background-color:transparent; border:0; border-bottom:solid 3px #acfe25; border-radius:0; color:#fff; font-size:27px; text-align:left;}
.evt111787 .pop-container .input-box .btn-submit {width:65px; height:54px; margin-left:-1px; color:#acfe25; border-bottom:solid 3px #acfe25; font-size:21px; background:transparent;}
.evt111787 .pop-container .input-box input::placeholder {font-size:21px; color:#b7b7b7; text-align:left;}
.evt111787 .pop-container {display:none; position:fixed; left:0; top:0; width:100vw; height:100vh; background-color:rgba(255, 255, 255,0.902); z-index:150;}
.evt111787 .pop-container .pop-inner {position:relative; width:100%; height:calc(100% - 98px); padding-top:98px; overflow-y:scroll;}
.evt111787 .pop-container .pop-inner a {display:inline-block;}
.evt111787 .pop-container .pop-inner .btn-close {position:absolute; right:66px; top:55px; width:41px; height:41px; background:url(//webimage.10x10.co.kr/fixevent/event/2021/111786/icon_close.png?v=2) no-repeat 0 0; background-size:100%; text-indent:-9999px;} 
.evt111787 .pop-container.push .contents-inner {position:relative; width:663px; height:765px; margin:0 auto;}

.noti-area {max-width:1920px; margin:0 auto; background:#262626;}
.noti-area .noti-header .btn-noti {position:relative; width:1140px; margin:0 auto;}
.noti-area .noti-header .btn-noti span {display:inline-block; position:absolute; left:50%; top:80px; transform:translate(610%,0);}
.noti-area .noti-header .btn-noti.on span img {transform:rotate(180deg);}
.noti-area .noti-info {display:none; width:1140px; margin:0 auto;}
.noti-area .noti-info.on {display:block;}
</style>
<script type="text/javascript" src="/event/lib/countdown.js"></script>
<script type="text/javascript" src="/event/etc/json/js_applyItemInfo_110063.js?v=1.02"></script>
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
    <%'// MD상품 리스트%>
    <% If mdItemRound > 0 Then %>
        var itemlistIdx = <%=mdItemRound%>
    <% IF application("Svr_Info") = "Dev" THEN %>
        codeGrp = [3308296,3224816,3217277];
    <% Else %>
        codeGrp = [<%=mdItemsArr%>];
    <% End If %>
        var $rootEl = $("#itemList")
        var itemEle = tmpEl = ""
        $rootEl.empty();

        codeGrp.forEach(function(item){
            tmpEl = '<li>\
                        <a href="" onclick="goProduct('+item+');return false;">\
                            <div class="thumbnail"><img src="" alt=""></div>\
                            <div class="desc">\
                                <p class="name">상품명상품명상품명상품명상품명상품명</p>\
                                <div class="price"><s>정가</s> 할인가<span class="sale">할인율%</span></div>\
                            </div>\
                        </a>\
                    </li>\
                    '
            itemEle += tmpEl
        });
        $rootEl.append(itemEle)

        fnApplyItemInfoList({
            items:codeGrp,
            target:"itemList",
            fields:["image","name","price","sale"],
            unit:"none",
            saleBracket:false
        });
    <% End If %>
    //팝업
    /* 응모완료 팝업 */
    $('.evt111787 .btn-push').click(function(){
        $('.pop-container.push').fadeIn();
    })
    /* 팝업 닫기 */
    $('.evt111787 .btn-close').click(function(){
        $(".pop-container").fadeOut();
    })
    //유의사항 버튼
    $('.btn-noti').on("click",function(){
        $('.noti-info').toggleClass("on");
        $(this).toggleClass("on");
    });
    // 슬라이더
    var mySwiper = new Swiper(".sold-out-list .swiper-container", {
        speed: 500,
        slidesPerView:5,
        spaceBetween:20,
        loop:false
    });
    $('.swiper-button-prev').on('click', function(e){ //왼쪽 네비게이션 버튼 클릭
            e.preventDefault()
            mySwiper.swipeNext()
        });
});

// 상품 링크 이동
function goProduct(itemid) {
    parent.location.href='/shopping/category_prd.asp?itemid='+itemid;
    return false;
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
        url:"/event/etc/doeventSubscript114434.asp",
        data: "mode=kamsg&phoneNumber="+btoa(phoneNumber),
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
                            $('.lyr').hide();
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

function goDirOrdItem(){
    <% If Not(IsUserLoginOK) Then %>
		jsEventLogin();
        return false;
    <% else %>
        <% if GetLoginUserLevel=7 then %>
            alert("텐바이텐 스탭은 참여할 수 없습니다.");
            return false;
        <% end if %>
        $.ajax({
            type:"GET",
            url:"/event/etc/doeventSubscript114434.asp",
            <% if mktTest then %>
            data: "mode=order&testdate=<%=currentDate%>",
            <% else %>
            data: "mode=order",
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
                                fnAmplitudeEventMultiPropertiesAction('click_diaryBuy_item','itemid', res[1])
                                $("#itemid").val(res[1]);
                                setTimeout(function() {
                                    document.directOrd.submit();
                                },300);
                                return false;
                            }else{
								errorMsg = res[1].replace(">?n", "\n");
								alert(errorMsg);
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
                console.log("접근 실패!");
                return false;
            }
        });   
    <% End IF %>
}

function jsEventLogin(){
    if(confirm("로그인을 하셔야 이벤트에 참여하실 수 있습니다.")){
        location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
        return;
    }
}
</script>
						<div class="evt111787">
							<div class="topic">
                                <!-- main -->
                                <div class="main-top">
                                    <!-- 몇시타임 진행중인지 타임 노출 리스트 -->
                                    <div class="show-time-current">
                                        <% if episode=1 or episode=0 then%>
                                        <div class="time-current-wrap">
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/on1.png" alt="9시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/off2.png" alt="12시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/off3.png" alt="3시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/off4.png" alt="6시 노출"></div>
                                        </div>
                                        <% elseif episode=2 then%>
                                        <div class="time-current-wrap">                                            
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/on2.png" alt="12시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/off3.png" alt="3시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/off4.png" alt="6시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/end_1.png" alt="9시 노출"></div>
                                        </div>
                                        <% elseif episode=3 then%>
                                        <div class="time-current-wrap">                                            
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/on3.png" alt="3시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/off4.png" alt="6시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/end_1.png" alt="9시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/end_2.png" alt="12시 노출"></div>
                                        </div>
                                        <% elseif episode=4 then%>
                                        <div class="time-current-wrap">                                            
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/on4.png" alt="6시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/end_1.png" alt="9시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/end_2.png" alt="12시 노출"></div>
                                            <div><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/end_3.png" alt="3시 노출"></div>
                                        </div>
                                        <% end if %>
                                    </div>
                                    <div class="tit-ready"><h2><%=evtCountTimeText%></h2></div>
                                    <div class="sale-timer">
                                        <div><span>-</span><span id="countdown">00:00:00</span></div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="special-list-wrap">
                                <div class="special-item">
                                    <ul id="list1" class="list list1">
                                    <% If currentDate >= #10/12/2021 00:00:00# and currentDate < #10/13/2021 00:00:00# Then %>
                                        <% 
                                            episode1Itemid = "4122929"
                                            episode2Itemid = "4121544"
                                            episode3Itemid = "4115708"
                                            episode4Itemid = "3687839"
                                        %>
                                        <% if episode=1 or episode=0 then%>
                                        <li class="<% if episode=0 then %>not-open<% elseIf getitemlimitcnt(episode1Itemid) < 1 then %>sold-out<% End If %>">
                                            <div class="product-inner">
                                                <div class="thum">
                                                    <img src="//webimage.10x10.co.kr/eventIMG/deal_itemImage/202110/deal_itemImage20211005171743.jpg" alt="LG 올레드 OLED TV 55인치">
                                                    <span class="num-limite"><em>1</em>개 한정</span>
                                                </div>
                                                <div class="desc">
                                                    <p class="name">LG 올레드 OLED TV 55인치</p>
                                                    <div class="price"><s>1,553,480</s> 500,000 <span class="p-won">원</span><span class="sale">68%</span></div>
                                                </div>
                                                <% if episode=0 then%>
                                                <% elseif getitemlimitcnt(episode1Itemid) < 1 then%>
                                                <% else %>
                                                <div class="go-link">
                                                    <a href="" onclick="goDirOrdItem();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/btn_buy.png" alt="바로구매하기"></a>
                                                </div>
                                                <% end if %>
                                            </div>
                                        </li>
                                        <% elseif episode=2 then%>
                                        <li class="<% If getitemlimitcnt(episode2Itemid) < 1 then %>sold-out<% End If %>">
                                            <div class="product-inner">
                                                <div class="thum">
                                                    <img src="//webimage.10x10.co.kr/eventIMG/deal_itemImage/202110/deal_itemImage20211005171919.jpg" alt="[Peanuts] 스누피 샌드위치/와플메이커 TBT-0002">
                                                    <span class="num-limite"><em>30</em>개 한정</span>
                                                </div>
                                                <div class="desc">
                                                    <p class="name">[Peanuts] 스누피 샌드위치/와플메이커 TBT-0002</p>
                                                    <div class="price"><s>56,000</s> 9,900 <span class="p-won">원</span><span class="sale">82%</span></div>
                                                </div>
                                                <% if getitemlimitcnt(episode2Itemid) < 1 then%>
                                                <% else %>
                                                <div class="go-link">
                                                    <a href="" onclick="goDirOrdItem();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/btn_buy.png" alt="바로구매하기"></a>
                                                </div>
                                                <% end if %>
                                            </div>
                                        </li>
                                        <% elseif episode=3 then%>
                                        <li class="<% If getitemlimitcnt(episode3Itemid) < 1 then %>sold-out<% End If %>">
                                            <div class="product-inner">
                                                <div class="thum">
                                                    <img src="//webimage.10x10.co.kr/eventIMG/deal_itemImage/202110/deal_itemImage20211005172107.jpg" alt="삼성전자 갤럭시탭S7 FE 12.4 WIFI 128GB 블랙">
                                                    <span class="num-limite"><em>3</em>개 한정</span>
                                                </div>
                                                <div class="desc">
                                                    <p class="name">삼성전자 갤럭시탭S7 FE 12.4 WIFI 128GB 블랙</p>
                                                    <div class="price"><s>719,400</s> 399,900 <span class="p-won">원</span><span class="sale">44%</span></div>
                                                </div>
                                                <% if getitemlimitcnt(episode3Itemid) < 1 then%>
                                                <% else %>
                                                <div class="go-link">
                                                    <a href="" onclick="goDirOrdItem();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/btn_buy.png" alt="바로구매하기"></a>
                                                </div>
                                                <% end if %>
                                            </div>
                                        </li>
                                        <% elseif episode=4 then%>
                                        <li class="<% If getitemlimitcnt(episode4Itemid) < 1 then %>sold-out<% End If %>">
                                            <div class="product-inner">
                                                <div class="thum">
                                                    <img src="//webimage.10x10.co.kr/eventIMG/deal_itemImage/202110/deal_itemImage20211005172226.jpg" alt="PS5 플레이스테이션5 플스5 디스크에디션">
                                                    <span class="num-limite"><em>1</em>개 한정</span>
                                                </div>
                                                <div class="desc">
                                                    <p class="name">PS5 플레이스테이션5 플스5 디스크에디션</p>
                                                    <div class="price"><s>628,000</s> 100,000 <span class="p-won">원</span><span class="sale">84%</span></div>
                                                </div>
                                                <% if getitemlimitcnt(episode4Itemid) < 1 then%>
                                                <% else %>
                                                <div class="go-link">
                                                    <a href="" onclick="goDirOrdItem();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/btn_buy.png" alt="바로구매하기"></a>
                                                </div>
                                                <% end if %>
                                            </div>
                                        </li>
                                        <% end if %>
                                    <% elseIf currentDate >= #10/14/2021 00:00:00# and currentDate < #10/15/2021 00:00:00# Then %>
                                        <% 
                                            episode1Itemid = "3897254"
                                            episode2Itemid = "3896082"
                                            episode3Itemid = "3895119"
                                            episode4Itemid = "3894266"
                                        %>
                                        <% if episode=1 or episode=0 then%>
                                        <li class="<% if episode=0 then %>not-open<% elseIf getitemlimitcnt(episode1Itemid) < 1 then %>sold-out<% End If %>">
                                            <div class="product-inner">
                                                <div class="thum">
                                                    <img src="//webimage.10x10.co.kr/eventIMG/deal_itemImage/202106/deal_itemImage20210618164957.jpg" alt="모나미 플러스펜-60색 세트">
                                                    <span class="num-limite"><em>100</em>개 한정</span>
                                                </div>
                                                <div class="desc">
                                                    <p class="name">모나미 플러스펜-60색 세트</p>
                                                    <div class="price"><s>28,000</s> 3,000 <span class="p-won">원</span><span class="sale">89%</span></div>
                                                </div>
                                                <% if episode=0 then%>
                                                <% elseif getitemlimitcnt(episode1Itemid) < 1 then%>
                                                <% else %>
                                                <div class="go-link">
                                                    <a href="" onclick="goDirOrdItem();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/btn_buy.png" alt="바로구매하기"></a>
                                                </div>
                                                <% end if %>
                                            </div>
                                        </li>
                                        <% elseif episode=2 then%>
                                        <li class="<% If getitemlimitcnt(episode2Itemid) < 1 then %>sold-out<% End If %>">
                                            <div class="product-inner">
                                                <div class="thum">
                                                    <img src="//webimage.10x10.co.kr/eventIMG/deal_itemImage/202106/deal_itemImage20210618165845.jpg" alt="스누피 테이블 4,900원 특가!">
                                                    <span class="num-limite"><em>20</em>개 한정</span>
                                                </div>
                                                <div class="desc">
                                                    <p class="name">스누피 테이블 4,900원 특가!</p>
                                                    <div class="price"><s>24,000</s> 4,900 <span class="p-won">원</span><span class="sale">80%</span></div>
                                                </div>
                                                <% if getitemlimitcnt(episode2Itemid) < 1 then%>
                                                <% else %>
                                                <div class="go-link">
                                                    <a href="" onclick="goDirOrdItem();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/btn_buy.png" alt="바로구매하기"></a>
                                                </div>
                                                <% end if %>
                                            </div>
                                        </li>
                                        <% elseif episode=3 then%>
                                        <li class="<% If getitemlimitcnt(episode3Itemid) < 1 then %>sold-out<% End If %>">
                                            <div class="product-inner">
                                                <div class="thum">
                                                    <img src="//webimage.10x10.co.kr/eventIMG/deal_itemImage/202106/deal_itemImage20210618170414.jpg" alt="컨테이너블랙 모듈 테이블(핑크상판)">
                                                    <span class="num-limite"><em>10</em>개 한정</span>
                                                </div>
                                                <div class="desc">
                                                    <p class="name">컨테이너블랙 모듈 테이블(핑크상판)</p>
                                                    <div class="price"><s>160,000</s> 19,900 <span class="p-won">원</span><span class="sale">88%</span></div>
                                                </div>
                                                <% if getitemlimitcnt(episode3Itemid) < 1 then%>
                                                <% else %>
                                                <div class="go-link">
                                                    <a href="" onclick="goDirOrdItem();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/btn_buy.png" alt="바로구매하기"></a>
                                                </div>
                                                <% end if %>
                                            </div>
                                        </li>
                                        <% elseif episode=4 then%>
                                        <li class="<% If getitemlimitcnt(episode4Itemid) < 1 then %>sold-out<% End If %>">
                                            <div class="product-inner">
                                                <div class="thum">
                                                    <img src="//webimage.10x10.co.kr/eventIMG/deal_itemImage/202106/deal_itemImage20210618170747.jpg" alt="삼성 공식인증점 전자레인지 MS23T5018AW 20년형">
                                                    <span class="num-limite"><em>5</em>개 한정</span>
                                                </div>
                                                <div class="desc">
                                                    <p class="name">삼성 공식인증점 전자레인지 MS23T5018AW 20년형</p>
                                                    <div class="price"><s>139,000</s> 10,000 <span class="p-won">원</span><span class="sale">93%</span></div>
                                                </div>
                                                <% if getitemlimitcnt(episode4Itemid) < 1 then%>
                                                <% else %>
                                                <div class="go-link">
                                                    <a href="" onclick="goDirOrdItem();return false;"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/btn_buy.png" alt="바로구매하기"></a>
                                                </div>
                                                <% end if %>
                                            </div>
                                        </li>
                                        <% end if %>
                                    <% end if %>
                                    </ul>
                                    <p class="txt-noti">선착순 특가 상품 구매 시 하단의 '유의사항'을 참고 바랍니다.</p>
                                </div>
                            </div>
                            <% If mdItemRound > 0 Then %>
                            <div class="md-list">
                                <div class="md-list-wrap">
                                    <ul id="itemList"></ul>
                                </div>
                            </div>
                            <% end if %>
                            <% if episode <> 4 then %>
                            <div class="product-list-wrap">
                                <img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/tit_ready.png?v=2" alt="잠시 후 오픈합니다.">
                                <div class="product-list">
                                    <ul id="list2" class="list list2">
                                    <% If currentDate >= #10/12/2021 00:00:00# and currentDate < #10/13/2021 00:00:00# Then %>
                                        <% if episode < 2 then %>
                                        <li>
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/time_header_02.png" alt="오전 12시">
                                            <div class="product-inner">
                                                <img src="//webimage.10x10.co.kr/eventIMG/deal_tzImage/202110/deal_tzImage20211005171919.jpg" alt="[Peanuts] 스누피 샌드위치/와플메이커 TBT-0002">
                                                <span class="num-limite"><em>30</em>개 한정</span>
                                            </div>
                                        </li>
                                        <% end if %>
                                        <% if episode < 3 then %>
                                        <li>
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/time_header_03.png" alt="오후 15시">
                                            <div class="product-inner">
                                                <img src="//webimage.10x10.co.kr/eventIMG/deal_tzImage/202110/deal_tzImage20211005172107.jpg" alt="삼성전자 갤럭시탭S7 FE 12.4 WIFI 128GB 블랙">
                                                <span class="num-limite"><em>3</em>개 한정</span>
                                            </div>
                                        </li>
                                        <% end if %>
                                        <% if episode < 4 then %>
                                        <li>
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/time_header_04.png" alt="오후 18시">
                                            <div class="product-inner">
                                                <img src="//webimage.10x10.co.kr/eventIMG/deal_tzImage/202110/deal_tzImage20211005172226.jpg" alt="PS5 플레이스테이션5 플스5 디스크에디션">
                                                <span class="num-limite"><em>1</em>개 한정</span>
                                            </div>
                                        </li>
                                        <% end if %>
                                    <% elseIf currentDate >= #10/14/2021 00:00:00# and currentDate < #10/15/2021 00:00:00# Then %>
                                        <% if episode < 2 then %>
                                        <li>
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/time_header_02.png" alt="오전 12시">
                                            <div class="product-inner">
                                                <img src="//webimage.10x10.co.kr/eventIMG/deal_tzImage/202106/deal_tzImage20210618165845.jpg" alt="스누피 테이블 4,900원 특가!">
                                                <span class="num-limite"><em>20</em>개 한정</span>
                                            </div>
                                        </li>
                                        <% end if %>
                                        <% if episode < 3 then %>
                                        <li>
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/time_header_03.png" alt="오후 15시">
                                            <div class="product-inner">
                                                <img src="//webimage.10x10.co.kr/eventIMG/deal_tzImage/202106/deal_tzImage20210618170414.jpg" alt="컨테이너블랙 모듈 테이블(핑크상판)">
                                                <span class="num-limite"><em>10</em>개 한정</span>
                                            </div>
                                        </li>
                                        <% end if %>
                                        <% if episode < 4 then %>
                                        <li>
                                            <img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/time_header_04.png" alt="오후 18시">
                                            <div class="product-inner">
                                                <img src="//webimage.10x10.co.kr/eventIMG/deal_tzImage/202106/deal_tzImage20210618170747.jpg" alt="삼성 공식인증점 전자레인지 MS23T5018AW 20년형">
                                                <span class="num-limite"><em>5</em>개 한정</span>
                                            </div>
                                        </li>
                                        <% end if %>
                                    <% end if %>
                                    </ul>
                                </div>
                            </div>
                            <% end if %>
                            <div class="sold-out-wrap">
                                <h2><img src="//webimage.10x10.co.kr/fixevent/event/2021/111787/tit_sold.png?v=2" alt="오늘, 지난 시간 판매 완료된 대표 상품"></h2>
                                <div class="sold-out-list">
                                    <div class="slide-area">
                                        <div class="swiper-container">
                                            <ul id="list3" class="list list3 swiper-wrapper">
                                            <% If currentDate >= #10/12/2021 00:00:00# and currentDate < #10/13/2021 00:00:00# Then %>
                                                <li class="swiper-slide sold-prd<% If getitemlimitcnt(episode1Itemid) < 1 then %> sold-out<% End If %>">
                                                    <div class="tit-prd">
                                                        <div class="thum"><img src="//webimage.10x10.co.kr/eventIMG/deal_soldoutImage/202110/deal_soldoutImage20211005171743.png" alt="상품1"></div>
                                                        <div class="desc">
                                                            <p class="name">LG 올레드 OLED TV 55인치</p>
                                                            <div class="price"><s>1,553,480</s> 500,000 <span class="p-won">원</span><span class="sale">68%</span></div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="swiper-slide sold-prd<% If getitemlimitcnt(episode2Itemid) < 1 then %> sold-out<% End If %>">
                                                    <div class="tit-prd">
                                                        <div class="thum"><img src="//webimage.10x10.co.kr/eventIMG/deal_soldoutImage/202110/deal_soldoutImage20211005171919.png" alt="상품2"></div>
                                                        <div class="desc">
                                                            <p class="name">[Peanuts] 스누피 샌드위치/와플메이커 TBT-0002</p>
                                                            <div class="price"><s>56,000</s> 9,900 <span class="p-won">원</span><span class="sale">82%</span></div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="swiper-slide sold-prd<% If getitemlimitcnt(episode3Itemid) < 1 then %> sold-out<% End If %>">
                                                    <div class="tit-prd">
                                                        <div class="thum"><img src="//webimage.10x10.co.kr/eventIMG/deal_soldoutImage/202110/deal_soldoutImage20211005172107.png" alt="상품3"></div>
                                                        <div class="desc">
                                                            <p class="name">삼성전자 갤럭시탭S7 FE 12.4 WIFI 128GB 블랙</p>
                                                            <div class="price"><s>719,400</s> 399,900 <span class="p-won">원</span><span class="sale">85%</span></div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="swiper-slide sold-prd<% If getitemlimitcnt(episode4Itemid) < 1 then %> sold-out<% End If %>">
                                                    <div class="tit-prd">
                                                        <div class="thum"><img src="//webimage.10x10.co.kr/eventIMG/deal_soldoutImage/202110/deal_soldoutImage20211005172226.png" alt="상품4"></div>
                                                        <div class="desc">
                                                            <p class="name">PS5 플레이스테이션5 플스5 디스크에디션</p>
                                                            <div class="price"><s>628,000</s> 100,000 <span class="p-won">원</span><span class="sale">84%</span></div>
                                                        </div>
                                                    </div>
                                                </li>
                                            <% elseIf currentDate >= #10/14/2021 00:00:00# and currentDate < #10/15/2021 00:00:00# Then %>
                                                <li class="swiper-slide sold-prd<% If getitemlimitcnt(episode1Itemid) < 1 then %> sold-out<% End If %>">
                                                    <div class="tit-prd">
                                                        <div class="thum"><img src="//webimage.10x10.co.kr/eventIMG/deal_soldoutImage/202106/deal_soldoutImage20210618164957.png" alt="상품1"></div>
                                                        <div class="desc">
                                                            <p class="name">모나미 플러스펜-60색 세트</p>
                                                            <div class="price"><s>28,000</s> 3,000 <span class="p-won">원</span><span class="sale">89%</span></div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="swiper-slide sold-prd<% If getitemlimitcnt(episode2Itemid) < 1 then %> sold-out<% End If %>">
                                                    <div class="tit-prd">
                                                        <div class="thum"><img src="//webimage.10x10.co.kr/eventIMG/deal_soldoutImage/202106/deal_soldoutImage20210618165845.png" alt="상품2"></div>
                                                        <div class="desc">
                                                            <p class="name">스누피 테이블 4,900원 특가!</p>
                                                            <div class="price"><s>24,000</s> 4,900 <span class="p-won">원</span><span class="sale">80%</span></div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="swiper-slide sold-prd<% If getitemlimitcnt(episode3Itemid) < 1 then %> sold-out<% End If %>">
                                                    <div class="tit-prd">
                                                        <div class="thum"><img src="//webimage.10x10.co.kr/eventIMG/deal_soldoutImage/202106/deal_soldoutImage20210618170414.png" alt="상품3"></div>
                                                        <div class="desc">
                                                            <p class="name">컨테이너블랙 모듈 테이블(핑크상판)</p>
                                                            <div class="price"><s>160,000</s> 19,900 <span class="p-won">원</span><span class="sale">88%</span></div>
                                                        </div>
                                                    </div>
                                                </li>
                                                <li class="swiper-slide sold-prd<% If getitemlimitcnt(episode4Itemid) < 1 then %> sold-out<% End If %>">
                                                    <div class="tit-prd">
                                                        <div class="thum"><img src="//webimage.10x10.co.kr/eventIMG/deal_soldoutImage/202106/deal_soldoutImage20210618170747.png" alt="상품4"></div>
                                                        <div class="desc">
                                                            <p class="name">삼성 공식인증점 전자레인지 MS23T5018AW 20년형</p>
                                                            <div class="price"><s>139,000</s> 10,000 <span class="p-won">원</span><span class="sale">93%</span></div>
                                                        </div>
                                                    </div>
                                                </li>
                                            <% end if %>
                                            </ul>                      
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="noti-area">
                                <div class="noti-header">
                                    <button type="button" class="btn-noti"><img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/tit_noti.jpg?v=2" alt="유의사항 확인하기"><span><img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/icon_noti_arrow.png" alt=""></span></button>
                                </div>
                                <div class="noti-info">
                                    <img src="//webimage.10x10.co.kr/fixevent/event/2021/111786/img_noti_info.jpg?v=2" alt="유의사항 내용">
                                </div>
                            </div>

                            <% If currentDate >= #10/12/2021 00:00:00# and currentDate < #10/21/2021 00:00:00# Then %>
                            <div class="teaser-timer">
                                <div class="timer-inner">
                                    <button type="button" class="btn-push"></button>
                                </div>
                            </div>
                            <% end if %>

                            <div class="coupon-area">
                                <a class="go-coupon" href="/my10x10/couponbook.asp"></a>
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
<form method="post" name="directOrd" action="/inipay/shoppingbag_process.asp">
    <input type="hidden" name="itemid" id="itemid" value="">
    <input type="hidden" name="itemoption" value="0000">
    <input type="hidden" name="itemea" value="1">
    <input type="hidden" name="mode" value="DO1">
</form>
<!-- #include virtual="/lib/db/dbclose.asp" -->