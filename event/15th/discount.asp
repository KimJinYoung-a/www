<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [15주년] 비정상 할인
' History : 2016.10.04 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim evt_code, userid, userlevel, nowdate, subscriptcount1, subscriptcount2, itemnum, beforenum, beforedonationCost
dim item1id, item2id, item3id, item4id, item5id, item6id, item7id, item8id, item9id, item10id
IF application("Svr_Info") = "Dev" THEN
	evt_code   =  66212
	item1id		=	282197
	item2id		=	1163356
	item3id		=	1163067
	item4id		=	1137708
	item5id		=	1147288
	item6id		=	1148209
	item7id		=	1155374
	item8id		=	1131262
	item9id		=	1180634
	item10id		=	1183273
Else
	evt_code   =  73064
	item1id		=	1573039
	item2id		=	1574615
	item3id		=	1574633
	item4id		=	1574640
	item5id		=	1574700
	item6id		=	1574701
	item7id		=	1574702
	item8id		=	1574711
	item9id		=	1574721
	item10id		=	1574725
End If

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & evt_code & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

userid = GetEncLoginUserID()
userlevel = GetLoginUserlevel()
nowdate = now()
'	nowdate = #10/07/2016 00:00:01#

if left(nowdate,10) < "2016-10-11" then
	itemnum = 1
elseif left(nowdate,10) = "2016-10-11" then
	itemnum = 2
elseif left(nowdate,10) = "2016-10-12" then
	itemnum = 3
elseif left(nowdate,10) = "2016-10-13" then
	itemnum = 4
elseif left(nowdate,10) >= "2016-10-14" and left(nowdate,10) < "2016-10-17" then
	itemnum = 5
elseif left(nowdate,10) = "2016-10-17" then
	itemnum = 6
elseif left(nowdate,10) = "2016-10-18" then
	itemnum = 7
elseif left(nowdate,10) = "2016-10-19" then
	itemnum = 8
elseif left(nowdate,10) = "2016-10-20" then
	itemnum = 9
elseif left(nowdate,10) >= "2016-10-21" then
	itemnum = 10
end if

if left(nowdate,10) = "2016-10-11" then
	beforenum = 1
elseif left(nowdate,10) = "2016-10-12" then
	beforenum = 2
elseif left(nowdate,10) = "2016-10-13" then
	beforenum = 3
elseif left(nowdate,10) = "2016-10-14" then
	beforenum = 4
elseif left(nowdate,10) >= "2016-10-15" and left(nowdate,10) < "2016-10-18" then
	beforenum = 5
elseif left(nowdate,10) = "2016-10-18" then
	beforenum = 6
elseif left(nowdate,10) = "2016-10-19" then
	beforenum = 7
elseif left(nowdate,10) = "2016-10-20" then
	beforenum = 8
elseif left(nowdate,10) = "2016-10-21" then
	beforenum = 9
elseif left(nowdate,10) >= "2016-10-22" then
	beforenum = 10
end if

Dim sqlStr, pNum, graph, donationCost, beforepNum, beforegraph

if userid<>"" then
	subscriptcount1 = getevent_subscriptexistscount(evt_code, userid, "", itemnum, "")
	subscriptcount2 = getevent_subscriptexistscount(evt_code, userid, "", beforenum, "")
end if


'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("[텐바이텐 15th] 비정상 할인")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/event/15th/discount.asp")
snpPre		= Server.URLEncode("10x10")

'// Facebook 오픈그래프 메타태그 작성
strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐 15th] 비정상 할인"" />" & vbCrLf &_
					"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
					"<meta property=""og:url"" content=""http://www.10x10.co.kr/event/15th/discount.asp"" />" & vbCrLf

strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:image"" content=""http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/m/img_kakao.jpg"" />" & vbCrLf &_
											"<link rel=""image_src"" href=""http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/m/img_kakao.jpg"" />" & vbCrLf

strPageTitle	= "[텐바이텐 15th] 비정상 할인"
strPageUrl		= "http://www.10x10.co.kr/event/15th/discount.asp"
strPageImage	= "http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/m/img_kakao.jpg"

strPageKeyword = "[텐바이텐 15th] 비정상 할인"
strPageDesc = "[텐바이텐] 이벤트 - 15주년 기념, 비정상적인 할인 상품을 구입하세요!"
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}
.teN15th .tenHeader {position:relative; height:180px; text-align:left; background:#363c7b url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_head.gif) repeat 0 0; z-index:10;}
.teN15th .tenHeader .headCont {position:relative; width:1260px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_star.png) no-repeat 50% 0;}
.teN15th .tenHeader .headCont div {position:relative; width:1140px; height:180px; margin:0 auto;}
.teN15th .tenHeader h2 {padding:25px 0 0 27px;}
.teN15th .tenHeader .navigator {position:absolute; right:0; top:0; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_line.gif) no-repeat 100% 50%;}
.teN15th .tenHeader .navigator:after {content:" "; display:block; clear:both;}
.teN15th .tenHeader .navigator li {float:left; width:120px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_line.gif) no-repeat 0 50%;}
.teN15th .tenHeader .navigator li a {display:block; height:180px; background-position:0 0; background-repeat:no-repeat; text-indent:-999em;}
.teN15th .tenHeader .navigator li.nav1 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_01.png);}
.teN15th .tenHeader .navigator li.nav2 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_02.png);}
.teN15th .tenHeader .navigator li.nav3 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_03.png);}
.teN15th .tenHeader .navigator li.nav4 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_04.png);}
.teN15th .tenHeader .navigator li.nav5 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_05.png);}
.teN15th .tenHeader .navigator li.nav6 a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/nav_06.png);}
.teN15th .tenHeader .navigator li a:hover {background-position:0 -180px;}
.teN15th .tenHeader .navigator li.current a {height:192px; background-position:0 100%;}
.teN15th .noti {padding:68px 0; text-align:left; border-top:4px solid #d5d5d5; background-color:#eee;}
.teN15th .noti div {position:relative; width:1140px; margin:0 auto;}
.teN15th .noti h3 {position:absolute; left:92px; top:50%; margin-top:-37px;}
.teN15th .noti ul {padding:0 50px 0 310px;}
.teN15th .noti li {color:#666; text-indent:-10px; padding:5px 0 0 10px; line-height:18px;}
.teN15th .shareSns {height:160px; text-align:left; background:#363c7b url(http://webimage.10x10.co.kr/eventIMG/2016/15th/bg_share.png) repeat 0 0;}
.teN15th .shareSns div {position:relative; width:1140px; margin:0 auto;}
.teN15th .shareSns p {padding:70px 0 0 40px;}
.teN15th .shareSns ul {overflow:hidden; position:absolute; right:40px; top:50px;}
.teN15th .shareSns li {float:left; padding-left:40px;}
.discount {position:relative; background:#39cff0;}
.discount .discountCont {padding-bottom:55px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/bg_ground.png) no-repeat 50% 100%;}
.discount button {display:inline-block; background:transparent; outline:none; vertical-align:top;}
.discount .tenHead {position:relative; height:75px; padding-top:460px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/bg_money.png) no-repeat 50% 0;}
.discount .tenHead .title {position:absolute; left:50%; top:142px; width:680px; margin-left:-340px;}
.discount .tenHead .title span {display:inline-block; position:absolute; top:0; width:130px; height:208px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/bg_baytree.png) repeat 0 0;}
.discount .tenHead .title .deco1 {left:0;}
.discount .tenHead .title .deco2 {right:0; background-position:100% 0;}
.discount .tenHead .title p {position:absolute; left:50%;}
.discount .tenHead .title .border {top:-88px; margin-left:-190px;}
.discount .tenHead .title .challenge {top:212px; margin-left:-159px;}
.discount .tenHead .title h2 {position:absolute; left:50%; top:65px; width:468px; margin-left:-234px;}
.discount .tenHead .title h2 em {display:inline-block; position:absolute; top:0; height:109px; text-indent:-999em; background-position:0 0; background-repeat:no-repeat;}
.discount .tenHead .title h2 .letter1 {left:0; width:286px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tit_discount_01.png);}
.discount .tenHead .title h2 .letter2 {right:0; width:217px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tit_discount_02.png);}
.discount .todayItem {width:1130px; margin:-115px auto 0;}
.discount .todayItem .dateTab {position:relative; width:1032px; height:71px; margin:0 auto; padding:45px 40px 0;}
.discount .todayItem .dateTab button {position:absolute; top:45px;  background:#39cff0;}
.discount .todayItem .dateTab .prev {left:0;}
.discount .todayItem .dateTab .next {right:0;}
.discount .todayItem .dateTab li {position:relative; float:left; width:220px; height:71px; background-position:0 0; background-repeat:no-repeat;}
.discount .todayItem .dateTab li.date1010 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tab_1010.png);}
.discount .todayItem .dateTab li.date1011 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tab_1011.png);}
.discount .todayItem .dateTab li.date1012 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tab_1012.png);}
.discount .todayItem .dateTab li.date1013 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tab_1013.png);}
.discount .todayItem .dateTab li.date1014 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tab_1014.png);}
.discount .todayItem .dateTab li.date1015 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tab_1015.png);}
.discount .todayItem .dateTab li.date1018 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tab_1018.png);}
.discount .todayItem .dateTab li.date1019 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tab_1019.png);}
.discount .todayItem .dateTab li.date1020 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tab_1020.png);}
.discount .todayItem .dateTab li.date1021 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/tab_1021.png);}
.discount .todayItem .dateTab li span {display:block; height:71px; text-indent:-999em; cursor:pointer;}
.discount .todayItem .dateTab li span em {display:none; position:absolute; left:50%; top:-45px; z-index:40; width:100px; height:33px; margin-left:-50px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy.png) no-repeat 0 0;}
.discount .todayItem .dateTab li.open span em {display:block; animation: bounce 30 1s 1s;}
.discount .todayItem .dateTab li.soon {background-position:0 -162px;}
.discount .todayItem .dateTab li.soon.current {background-position:0 -81px;}
.discount .todayItem .dateTab li.open {background-position:0 -324px;}
.discount .todayItem .dateTab li.open.current {background-position:0 -243px;}
.discount .todayItem .dateTab li.today {background-position:0 -486px;}
.discount .todayItem .dateTab li.today.current {background-position:0 -405px;}
.discount .todayItem .dateTab li.finish {background-position:0 -567px !important;}
.discount .todayItem .box {position:relative; height:470px; margin-bottom:55px; padding:40px 9px 16px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/bg_box.png) no-repeat 0 0;}
.discount .todayItem .itemPic {position:absolute; left:49px; top:35px;}
.discount .todayItem .itemPic span {display:inline-block; position:absolute; left:14px; top:14px; z-index:40; width:116px; height:114px; background-position:0 0; background-repeat:no-repeat;}
.discount .todayItem .itemPic span.limit20 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_limit_20.png);}
.discount .todayItem .itemPic span.limit30 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_limit_30.png);}
.discount .todayItem .itemPic span.limit50 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_limit_50.png);}
.discount .todayItem .itemInfo {width:361px; text-align:center; margin-left:698px;}
.discount .todayItem .itemInfo .open10am {padding-bottom:30px;}
.discount .todayItem .case1 {padding-top:50px;}
.discount .todayItem .case1 .btnArea {padding:30px 0 45px;}
.discount .todayItem .case1 .btnArea button {padding:0 7px;}
.discount .todayItem .case2 {padding-top:75px;}
.discount .todayItem .case3 {padding-top:75px;}
.discount .todayItem .case4 {padding-top:35px;}
.previewCont {position:fixed; left:50% !important; width:1005px; height:620px; margin-left:-502px; z-index:99999;}
.previewCont div {position:relative;}
.previewCont .close {position:absolute; right:110px; top:35px; background:transparent;}
.discount .todayItem .case5 {padding-top:80px;}

@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-in;}
	50% {margin-top:4px; animation-timing-function:ease-out;}
}
</style>
<script type="text/javascript">
$(function(){

	<% if left(nowdate,10) < "2016-10-11" then %>
		$("#item1").show();
	<% elseif left(nowdate,10) = "2016-10-11" then %>
		$("#item2").show();
	<% elseif left(nowdate,10) = "2016-10-12" then %>
		$("#item3").show();
	<% elseif left(nowdate,10) = "2016-10-13" then %>
		$("#item4").show();
	<% elseif left(nowdate,10) >= "2016-10-14" and left(nowdate,10) < "2016-10-17" then %>
		$("#item5").show();
	<% elseif left(nowdate,10) = "2016-10-17" then %>
		$("#item6").show();
	<% elseif left(nowdate,10) = "2016-10-18" then %>
		$("#item7").show();
	<% elseif left(nowdate,10) = "2016-10-19" then %>
		$("#item8").show();
	<% elseif left(nowdate,10) = "2016-10-20" then %>
		$("#item9").show();
	<% elseif left(nowdate,10) >= "2016-10-21" then %>
		$("#item10").show();
	<% end if %>

	var dateSwiper = new Swiper('.todayItem .swiper-container',{
		loop:false,
		slidesPerView:'auto',
		<% if left(nowdate,10) > "2016-10-05" and left(nowdate,10) < "2016-10-13" then %>
			initialSlide:0,
		<% elseif left(nowdate,10) = "2016-10-13" then %>
			initialSlide:1,
		<% elseif left(nowdate,10) >= "2016-10-14" and left(nowdate,10) < "2016-10-17" then %>
			initialSlide:2,
		<% elseif left(nowdate,10) >= "2016-10-17" and left(nowdate,10) < "2016-10-18" then %>
			initialSlide:3, 
		<% elseif left(nowdate,10) = "2016-10-18" then %>
			initialSlide:4,
		<% elseif left(nowdate,10) >= "2016-10-19" then %>
			initialSlide:5, 
		<% else %>
			initialSlide:0,
		<% end if %>

		speed:600,
		autoplay:false,
		simulateTouch:true,
		pagination:false
	})
	$('.todayItem .prev').on('click', function(e){
		e.preventDefault();
		dateSwiper.swipePrev();
	})
	$('.todayItem .next').on('click', function(e){
		e.preventDefault();
		dateSwiper.swipeNext();
	});

	// title
	titleAnimation();
	$(".title .deco1").css({"margin-left":"20px","opacity":"0"});
	$(".title .deco2").css({"margin-right":"20px","opacity":"0"});
	$(".title .border").css({"margin-top":"10px","opacity":"0"});
	$(".title .challenge").css({"margin-top":"5px","opacity":"0"});
	$(".title .letter1").css({"margin-left":"30px","opacity":"0"});
	$(".title .letter2").css({"margin-right":"30px","opacity":"0"});
	function titleAnimation(){
		$(".title span").delay(100).animate({"margin-left":"0","margin-right":"0", "opacity":"1"},800);
		$(".title .border").delay(500).animate({"margin-top":"0", "opacity":"1"},800);
		$(".title .letter1").delay(900).animate({"margin-left":"-10px", "opacity":"1"},600).animate({"margin-left":"0"},400);
		$(".title .letter2").delay(900).animate({"margin-right":"-10px", "opacity":"1"},600).animate({"margin-right":"0"},400);
		$(".title .challenge").delay(1800).animate({"margin-top":"0", "opacity":"1"},500);
	}
});

function jssubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(nowdate,10)>="2016-10-10" and left(nowdate,10)<"2016-10-24" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if userlevel = 7 then %>
				alert("텐바이텐 스탭은 참여할 수 없습니다.");
				return;			
			<% else %>
				var str = $.ajax({
					type: "POST",
					url: "/event/15th/doeventsubscript/doEventSubscriptdiscount.asp",
					data: "mode=addok",
					dataType: "text",
					async: false
				}).responseText;
				var str1 = str.split("||")
				if (str1[0] == "11"){
					<% if left(nowdate,10) = "2016-10-14" or left(nowdate,10) = "2016-10-15" or left(nowdate,10) = "2016-10-21" or left(nowdate,10) = "2016-10-22" then %>
						alert('다음주 월요일 오전 10시\n비정상할인의 문이 열립니다!\n할인에 도전하세요!');
					<% else %>
						alert('내일 오전 10시\n비정상할인의 문이 열립니다!\n할인에 도전하세요!');
					<% end if %>
					parent.location.reload();
				}else if (str1[0] == "04"){
					alert('이미 참여 하셨습니다.');
					return false;
				}else if (str1[0] == "03"){
					alert('이벤트 응모 기간이 아닙니다.');
					return false;
				}else if (str1[0] == "02"){
					alert('로그인을 해주세요.');
					return false;
				}else if (str1[0] == "01"){
					alert('잘못된 접속입니다.');
					return false;
				}else if (str1[0] == "00"){
					alert('정상적인 경로가 아닙니다.');
					return false;
				}else{
					alert('오류가 발생했습니다.');
					return false;
				}
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}

function jssubmitx(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(nowdate,10)>="2016-10-10" and left(nowdate,10)<"2016-10-25" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			alert(" ㅜㅜ 찬성하신 분들께만\n구매버튼이 열립니다");
			return;
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}

function jsgetitem(iid){
	<% If IsUserLoginOK() Then %>
		<% If not( left(nowdate,10)>="2016-10-10" and left(nowdate,10)<"2016-10-25" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			<% if userlevel = 7 then %>
				alert("텐바이텐 스탭은 참여할 수 없습니다.");
				return;			
			<% else %>
				var str = $.ajax({
					type: "POST",
					url: "/event/15th/doeventsubscript/doEventSubscriptdiscount.asp",
					data: "mode=itget",
					dataType: "text",
					async: false
				}).responseText;
				var str1 = str.split("||")
				if (str1[0] == "11"){
					top.location.href="/shopping/category_prd.asp?itemid="+iid
				}else if (str1[0] == "03"){
					alert('이벤트 응모 기간이 아닙니다.');
					return false;
				}else if (str1[0] == "02"){
					alert('로그인을 해주세요.');
					return false;
				}else if (str1[0] == "01"){
					alert('잘못된 접속입니다.');
					return false;
				}else if (str1[0] == "00"){
					alert('정상적인 경로가 아닙니다.');
					return false;
				}else{
					alert('오류가 발생했습니다.');
					return false;
				}
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
		}
		return false;
	<% End IF %>
}

function jsshow(numb){
	if(numb=="1"){
		$("#item1").show();
		$("#etb1").addClass('current');
		for (i = 2; i < 11; i++){
			$("#item"+i).hide();
			$("#etb"+i).removeClass('current');
		}
	}else if(numb=="2"){
		$("#item2").show();
		$("#etb2").addClass('current');
		for (i = 1; i < 11; i++){
			if(i!=2){
				$("#item"+i).hide();
				$("#etb"+i).removeClass('current');
			}
		}
	}else if(numb=="3"){
		$("#item3").show();
		$("#etb3").addClass('current');
		for (i = 1; i < 11; i++){
			if(i!=3){
				$("#item"+i).hide();
				$("#etb"+i).removeClass('current');
			}
		}
	}else if(numb=="4"){
		$("#item4").show();
		$("#etb4").addClass('current');
		for (i = 1; i < 11; i++){
			if(i!=4){
				$("#item"+i).hide();
				$("#etb"+i).removeClass('current');
			}
		}
	}else if(numb=="5"){
		$("#item5").show();
		$("#etb5").addClass('current');
		for (i = 1; i < 11; i++){
			if(i!=5){
				$("#item"+i).hide();
				$("#etb"+i).removeClass('current');
			}
		}
	}else if(numb=="6"){
		$("#item6").show();
		$("#etb6").addClass('current');
		for (i = 1; i < 11; i++){
			if(i!=6){
				$("#item"+i).hide();
				$("#etb"+i).removeClass('current');
			}
		}
	}else if(numb=="7"){
		$("#item7").show();
		$("#etb7").addClass('current');
		for (i = 1; i < 11; i++){
			if(i!=7){
				$("#item"+i).hide();
				$("#etb"+i).removeClass('current');
			}
		}
	}else if(numb=="8"){
		$("#item8").show();
		$("#etb8").addClass('current');
		for (i = 1; i < 11; i++){
			if(i!=8){
				$("#item"+i).hide();
				$("#etb"+i).removeClass('current');
			}
		}
	}else if(numb=="9"){
		$("#item9").show();
		$("#etb9").addClass('current');
		for (i = 1; i < 11; i++){
			if(i!=9){
				$("#item"+i).hide();
				$("#etb"+i).removeClass('current');
			}
		}
	}else if(numb=="10"){
		$("#item10").show();
		$("#etb10").addClass('current');
		for (i = 1; i < 11; i++){
			if(i!=10){
				$("#item"+i).hide();
				$("#etb"+i).removeClass('current');
			}
		}
	}else{
		for (i = 1; i < 11; i++){
			$("#item"+i).hide();
			$("#etb"+i).removeClass('current');
		}
	}
}

function snschk(snsnum) {
	if(snsnum == "tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(snsnum=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else if(snsnum=="ka"){
		alert('잘못된 접속 입니다.');
		return false;
	}
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">
				<div class="eventContV15">
					<div class="contF contW">
						<%'  15주년 이벤트 : 비정상할인  %>
						<div class="teN15th">
							<div class="tenHeader">
								<div class="headCont">
									<div>
										<h2><a href="/event/15th/"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/tit_ten_15th.png" alt="teN15th 텐바이텐의 다양한 이야기" /></a></h2>
										<ul class="navigator">
											<li class="nav1"><a href="/event/15th/">최대 40% 쿠폰 받기 [teN15th]</a></li>
											<li class="nav2"><a href="/event/15th/walkingman.asp">매일 매일 출석체크 [워킹맨]</a></li>
											<li class="nav3 current"><a href="/event/15th/discount.asp">할인에 도전하라 [비정상할인]</a></li>
											<li class="nav4"><a href="/event/15th/gift.asp">팡팡 터지는 구매사은품 [사은품을 부탁해]</a></li>
											<li class="nav5"><a href="/event/15th/sns.asp">영상을 공유하라 [전국 영상자랑]</a></li>
											<li class="nav6"><a href="/event/15th/tv.asp">일상을 담아라 [나의 리틀텔레비전]</a></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="discount">
								<div class="discountCont">
									<div class="tenHead">
										<div class="title">
											<p class="border"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_border.png" alt="할인에는 국경도 없는" /></p>
											<h2>
												<em class="letter1">비정상</em>
												<em class="letter2">할인</em>
											</h2>
											<p class="challenge"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_challenge.png" alt="할인가에 찬성하시고 비정상적인 할인에 도전하세요!" /></p>
											<span class="deco1"></span>
											<span class="deco2"></span>
										</div>
									</div>
									<div class="todayItem">
										<div class="dateTab swiper-container">
											<ul class="swiper-wrapper">
												<%'  for dev msg : 구매불가 오픈 - soon / 구매가능 오픈 - open / 오늘- today / 솔드아웃 finish  %>
												<li id="etb1" <% if left(nowdate,10)>="2016-10-10" then %> onclick="jsshow('1'); return false;"<% end if %> class="swiper-slide date1010 <% if left(nowdate,10)="2016-10-10" then %>today current<% elseif left(nowdate,10)="2016-10-11" and nowdate < #10/11/2016 10:00:00# then %>soon<% elseif left(nowdate,10)>="2016-10-11" and getitemlimitcnt(item1id) < 1 then %> finish<% elseif left(nowdate,10)="2016-10-11" and getitemlimitcnt(item1id) > 0 then  %>open<% end if %>"><span><em></em>1회차 10월 10일</span></li>
												<li id="etb2" <% if left(nowdate,10)>="2016-10-11" then %> onclick="jsshow('2'); return false;"<% end if %> class="swiper-slide date1011 <% if left(nowdate,10)="2016-10-11" then %>today current<% elseif left(nowdate,10)="2016-10-12" and nowdate < #10/12/2016 10:00:00# then %>soon<% elseif left(nowdate,10)>="2016-10-12" and getitemlimitcnt(item2id) < 1 then %> finish<% elseif left(nowdate,10)="2016-10-12" and getitemlimitcnt(item2id) > 0 then %>open<% end if %>"><span><em></em>2회차 10월 11일</span></li>
												<li id="etb3" <% if left(nowdate,10)>="2016-10-12" then %> onclick="jsshow('3'); return false;"<% end if %> class="swiper-slide date1012 <% if left(nowdate,10)="2016-10-12" then %>today current<% elseif left(nowdate,10)="2016-10-13" and nowdate < #10/13/2016 10:00:00# then %>soon<% elseif left(nowdate,10)>="2016-10-13" and getitemlimitcnt(item3id) < 1 then %> finish<% elseif left(nowdate,10)="2016-10-13" and getitemlimitcnt(item3id) > 0 then %>open<% end if %>"><span><em></em>3회차 10월 12일</span></li>
												<li id="etb4" <% if left(nowdate,10)>="2016-10-13" then %> onclick="jsshow('4'); return false;"<% end if %> class="swiper-slide date1013 finish"><span><em></em>4회차 10월 13일</span></li>
												<li id="etb5" <% if left(nowdate,10)>="2016-10-14" then %> onclick="jsshow('5'); return false;"<% end if %> class="swiper-slide date1014 <% if left(nowdate,10)>="2016-10-14" and left(nowdate,10)<"2016-10-17" then %>today current<% elseif left(nowdate,10)="2016-10-17" and nowdate < #10/17/2016 10:00:00# then %>soon<% elseif left(nowdate,10)>="2016-10-17" and getitemlimitcnt(item5id) < 1 then %> finish<% elseif left(nowdate,10)="2016-10-17" and getitemlimitcnt(item5id) > 0 then %>open<% end if %>"><span><em></em>5회차 10월 14일</span></li>
												<li id="etb6" <% if left(nowdate,10)>="2016-10-17" then %> onclick="jsshow('6'); return false;"<% end if %> class="swiper-slide date1015 <% if left(nowdate,10)="2016-10-17" then %>today current<% elseif left(nowdate,10)="2016-10-18" and nowdate < #10/18/2016 10:00:00# then %>soon<% elseif left(nowdate,10)>="2016-10-18" and getitemlimitcnt(item6id) < 1 then %> finish<% elseif left(nowdate,10)="2016-10-18" and getitemlimitcnt(item6id) > 0 then %>open<% end if %>"><span><em></em>6회차 10월 15일~17일</span></li>
												<li id="etb7" <% if left(nowdate,10)>="2016-10-18" then %> onclick="jsshow('7'); return false;"<% end if %> class="swiper-slide date1018 <% if left(nowdate,10)="2016-10-18" then %>today current<% elseif left(nowdate,10)="2016-10-19" and nowdate < #10/19/2016 10:00:00# then %>soon<% elseif left(nowdate,10)>="2016-10-19" and getitemlimitcnt(item7id) < 1 then %> finish<% elseif left(nowdate,10)="2016-10-19" and getitemlimitcnt(item7id) > 0 then %>open<% end if %>"><span><em></em>7회차 10월 18일</span></li>
												<li id="etb8" <% if left(nowdate,10)>="2016-10-19" then %> onclick="jsshow('8'); return false;"<% end if %> class="swiper-slide date1019 <% if left(nowdate,10)="2016-10-19" then %>today current<% elseif left(nowdate,10)="2016-10-20" and nowdate < #10/20/2016 10:00:00# then %>soon<% elseif left(nowdate,10)>="2016-10-20" and getitemlimitcnt(item8id) < 1 then %> finish<% elseif left(nowdate,10)="2016-10-20" and getitemlimitcnt(item8id) > 0 then %>open<% end if %>"><span><em></em>8회차 10월 19일</span></li>
												<li id="etb9" <% if left(nowdate,10)>="2016-10-20" then %> onclick="jsshow('9'); return false;"<% end if %> class="swiper-slide date1020 <% if left(nowdate,10)="2016-10-20" then %>today current<% elseif left(nowdate,10)="2016-10-21" and nowdate < #10/21/2016 10:00:00# then %>soon<% elseif left(nowdate,10)>="2016-10-21" and getitemlimitcnt(item9id) < 1 then %> finish<% elseif left(nowdate,10)="2016-10-21" and getitemlimitcnt(item9id) > 0 then %>open<% end if %>"><span><em></em>9회차 10월 20일</span></li>
												<li id="etb10" <% if left(nowdate,10)>="2016-10-21" then %> onclick="jsshow('10'); return false;"<% end if %> class="swiper-slide date1021 <% if left(nowdate,10)>="2016-10-21" and left(nowdate,10)<"2016-10-24" then %>today current<% elseif left(nowdate,10)="2016-10-24" and  nowdate < #10/24/2016 10:00:00# then %>soon<% elseif left(nowdate,10)>="2016-10-24" and  getitemlimitcnt(item10id) < 1 then %> finish<% elseif left(nowdate,10)="2016-10-24" and  getitemlimitcnt(item10id) > 0 then %>open<% end if %>"><span><em></em>10회차 10월 21일~23일</span></li>
											</ul>
											<button class="prev"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_prev.png" alt="이전" /></button>
											<button class="next"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_next.png" alt="다음" /></button>
										</div>


										<% if left(nowdate,10) >= "2016-10-10" then %>
											<%'  10월 10일  %>
											<div class="box" id="item1" style="display:none">
												<div class="itemPic">
													<a href="/shopping/category_prd.asp?itemid=1262196" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/img_item_1010.jpg" alt="다니엘웰링턴(클래식실버 여성용)" /></a>
													<% if left(nowdate,10) >= "2016-10-11" and nowdate >= #10/11/2016 10:00:00# then %>
														<span class="limit20"></span>
													<% end if %>
												</div>
												<div class="itemInfo">
													<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_item_1010.png" alt="" /></p>

													<% if left(nowdate,10) = "2016-10-10" then %>
														<% if subscriptcount1 < 1 then %>
															<%'  case1. 찬성/반대 투표하기  %>
															<div class="case1">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_agree.png" alt="위 할인가에 찬성하십니까?" /></p>
																<div class="btnArea">
																	<button type="button" onclick="jssubmit(); return false;" class="btnAgr agreeY"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_agree.png" alt="찬성" /></button>
																	<button class="btnAgr agreeN" onclick="jssubmitx();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_disagree.png" alt="반대" /></button>
																</div>
																<p class="lt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_tip.png" alt="찬성하시는 분께 다음날 오전 10시, 구매버튼이 열립니다!" /></p>
															</div>
														<% end if %>
													<% end if %>

													<% if (left(nowdate,10) = "2016-10-10" and subscriptcount1 > 0 ) or ( left(nowdate,10) = "2016-10-11" and nowdate < #10/11/2016 10:00:00# and subscriptcount2 > 0 ) then %>
														<%'  case2. 구매하기(비활성)  %>
														<div class="case2">
															<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1011.png" alt="오전 10시 구매버튼이 열립니다" /></p>
															<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_off.png" alt="구매하기" /></button>
														</div>
													<% elseif left(nowdate,10) >= "2016-10-11" and nowdate >= #10/11/2016 10:00:00# and subscriptcount2 > 0 then %>
														<% if getitemlimitcnt(item1id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case3. 구매하기(활성)  %>
															<div class="case3">
																<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1011.png" alt="오전 10시 구매버튼이 열립니다" /></p>
																<a href="" onclick="jsgetitem('<%=item1id%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_on.png" alt="지금 구매하기" /></a>
															</div>
														<% end if %>
													<% elseif left(nowdate,10) >= "2016-10-11" and subscriptcount2 < 1 then %>
														<% if getitemlimitcnt(item1id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case4. 미참여/반대고객  %>
															<div class="case4">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_sorry.png" alt="해당 기간 할인가에 천성해주신 고객분들께만 구매하기 버튼이 보입니다" /></p>
															</div>
														<% end if %>
													<% end if %>
												</div>
											</div>
											<%' // 10월 10일  %>
										<% end if %>

										<% if left(nowdate,10) >= "2016-10-11" then %>
											<%'  10월 11일  %>
											<div class="box" id="item2" style="display:none">
												<div class="itemPic">
													<a href="/shopping/category_prd.asp?itemid=1479124" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/img_item_1011.jpg" alt="EMIE 블루투스 스피커" /></a>
													<% if left(nowdate,10) >= "2016-10-12" and nowdate >= #10/12/2016 10:00:00# then %>
														<span class="limit30"></span>
													<% end if %>
												</div>
												<div class="itemInfo">
													<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_item_1011.png" alt="" /></p>
													
													<% if left(nowdate,10) = "2016-10-11" then %>
														<% if subscriptcount1 < 1 then %>
															<%'  case1. 찬성/반대 투표하기  %>
															<div class="case1">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_agree.png" alt="위 할인가에 찬성하십니까?" /></p>
																<div class="btnArea">
																	<button type="button" onclick="jssubmit(); return false;" class="btnAgr agreeY"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_agree.png" alt="찬성" /></button>
																	<button class="btnAgr agreeN" onclick="jssubmitx();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_disagree.png" alt="반대" /></button>
																</div>
																<p class="lt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_tip.png" alt="찬성하시는 분께 다음날 오전 10시, 구매버튼이 열립니다!" /></p>
															</div>
														<% end if %>
													<% end if %>

													<% if (left(nowdate,10) = "2016-10-11" and subscriptcount1 > 0 ) or ( left(nowdate,10) = "2016-10-12" and nowdate < #10/12/2016 10:00:00# and subscriptcount2 > 0 ) then %>
														<%'  case2. 구매하기(비활성)  %>
														<div class="case2">
															<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1012.png" alt="오전 10시 구매버튼이 열립니다" /></p>
															<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_off.png" alt="구매하기" /></button>
														</div>
													<% elseif left(nowdate,10) >= "2016-10-12" and nowdate >= #10/12/2016 10:00:00# and subscriptcount2 > 0 then %>
														<% if getitemlimitcnt(item2id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case3. 구매하기(활성)  %>
															<div class="case3">
																<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1012.png" alt="오전 10시 구매버튼이 열립니다" /></p>
																<a href="" onclick="jsgetitem('<%=item2id%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_on.png" alt="지금 구매하기" /></a>
															</div>
														<% end if %>
													<% elseif left(nowdate,10) >= "2016-10-12" and subscriptcount2 < 1 then %>
														<% if getitemlimitcnt(item2id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case4. 미참여/반대고객  %>
															<div class="case4">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_sorry.png" alt="해당 기간 할인가에 천성해주신 고객분들께만 구매하기 버튼이 보입니다" /></p>
															</div>
														<% end if %>
													<% end if %>
												</div>
											</div>
											<%' // 10월 11일  %>
										<% end if %>

										<% if left(nowdate,10) >= "2016-10-12" then %>
											<%'  10월 12일  %>
											<div class="box" id="item3" style="display:none">
												<div class="itemPic">
													<a href="/shopping/category_prd.asp?itemid=1313465" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/img_item_1012.jpg" alt="마이빈스 더치커피팩 세트" /></a>
													<% if left(nowdate,10) >= "2016-10-13" and nowdate >= #10/13/2016 10:00:00# then %>
														<span class="limit30"></span>
													<% end if %>
												</div>
												<div class="itemInfo">
													<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_item_1012.png" alt="" /></p>

													<% if left(nowdate,10) = "2016-10-12" then %>
														<% if subscriptcount1 < 1 then %>
															<%'  case1. 찬성/반대 투표하기  %>
															<div class="case1">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_agree.png" alt="위 할인가에 찬성하십니까?" /></p>
																<div class="btnArea">
																	<button type="button" onclick="jssubmit(); return false;" class="btnAgr agreeY"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_agree.png" alt="찬성" /></button>
																	<button class="btnAgr agreeN" onclick="jssubmitx();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_disagree.png" alt="반대" /></button>
																</div>
																<p class="lt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_tip.png" alt="찬성하시는 분께 다음날 오전 10시, 구매버튼이 열립니다!" /></p>
															</div>
														<% end if %>
													<% end if %>

													<% if (left(nowdate,10) = "2016-10-12" and subscriptcount1 > 0 ) or ( left(nowdate,10) = "2016-10-13" and nowdate < #10/13/2016 10:00:00# and subscriptcount2 > 0 ) then %>
														<%'  case2. 구매하기(비활성)  %>
														<div class="case2">
															<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1013.png" alt="오전 10시 구매버튼이 열립니다" /></p>
															<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_off.png" alt="구매하기" /></button>
														</div>
													<% elseif left(nowdate,10) >= "2016-10-13" and nowdate >= #10/13/2016 10:00:00# and subscriptcount2 > 0 then %>
														<% if getitemlimitcnt(item3id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case3. 구매하기(활성)  %>
															<div class="case3">
																<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1013.png" alt="오전 10시 구매버튼이 열립니다" /></p>
																<a href="" onclick="jsgetitem('<%=item3id%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_on.png" alt="지금 구매하기" /></a>
															</div>
														<% end if %>
													<% elseif left(nowdate,10) >= "2016-10-13" and subscriptcount2 < 1 then %>
														<% if getitemlimitcnt(item3id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case4. 미참여/반대고객  %>
															<div class="case4">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_sorry.png" alt="해당 기간 할인가에 천성해주신 고객분들께만 구매하기 버튼이 보입니다" /></p>
															</div>
														<% end if %>
													<% end if %>
												</div>
											</div>
											<%' // 10월 12일  %>
										<% end if %>


										<% if left(nowdate,10) >= "2016-10-13" then %>
											<%'  10월 13일  %>
											<div class="box" id="item4" style="display:none">
												<div class="itemPic">
													<a href="/shopping/category_prd.asp?itemid=1226544" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/img_item_1013.jpg" alt="에어비타 공기청정기" /></a>
													<% if left(nowdate,10) >= "2016-10-14" and nowdate >= #10/14/2016 10:00:00# then %>
														<span class="limit20"></span>
													<% end if %>
												</div>
												<div class="itemInfo">
													<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_item_1013.png" alt="" /></p>

													<% if left(nowdate,10) = "2016-10-13" then %>
														<% if subscriptcount1 < 1 then %>
															<%'  case1. 찬성/반대 투표하기  %>
															<div class="case1">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_agree.png" alt="위 할인가에 찬성하십니까?" /></p>
																<div class="btnArea">
																	<button type="button" onclick="jssubmit(); return false;" class="btnAgr agreeY"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_agree.png" alt="찬성" /></button>
																	<button class="btnAgr agreeN" onclick="jssubmitx();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_disagree.png" alt="반대" /></button>
																</div>
																<p class="lt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_tip.png" alt="찬성하시는 분께 다음날 오전 10시, 구매버튼이 열립니다!" /></p>
															</div>
														<% end if %>
													<% end if %>

													<% if (left(nowdate,10) = "2016-10-13" and subscriptcount1 > 0 ) or ( left(nowdate,10) = "2016-10-14" and nowdate < #10/14/2016 10:00:00# and subscriptcount2 > 0 ) then %>
														<%'  case2. 구매하기(비활성)  %>
														<div class="case2">
															<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1014.png" alt="오전 10시 구매버튼이 열립니다" /></p>
															<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_off.png" alt="구매하기" /></button>
														</div>
													<% elseif left(nowdate,10) >= "2016-10-14" and nowdate >= #10/14/2016 10:00:00# and subscriptcount2 > 0 then %>
														<% if getitemlimitcnt(item4id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case3. 구매하기(활성)  %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% end if %>
													<% elseif left(nowdate,10) >= "2016-10-14" and subscriptcount2 < 1 then %>
														<% if getitemlimitcnt(item4id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case4. 미참여/반대고객  %>
															<div class="case4">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_sorry.png" alt="해당 기간 할인가에 천성해주신 고객분들께만 구매하기 버튼이 보입니다" /></p>
															</div>
														<% end if %>
													<% end if %>
												</div>
											</div>
											<%' // 10월 13일  %>
										<% end if %>


										<% if left(nowdate,10) >= "2016-10-14" then %>
											<%'  10월 14,15,16일  %>
											<div class="box" id="item5" style="display:none">
												<div class="itemPic">
													<a href="/shopping/category_prd.asp?itemid=1260092" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/img_item_1014.jpg" alt="이소품 캔빌리지(화이트)" /></a>
													<% if left(nowdate,10) >= "2016-10-17" and nowdate >= #10/17/2016 10:00:00# then %>
														<span class="limit30"></span>
													<% end if %>
												</div>
												<div class="itemInfo">
													<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_item_1014.png" alt="" /></p>

													<% if  left(nowdate,10) >= "2016-10-14" and  left(nowdate,10) < "2016-10-17" then %>
														<% if subscriptcount1 < 1 then %>
															<%'  case1. 찬성/반대 투표하기  %>
															<div class="case1">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_agree.png" alt="위 할인가에 찬성하십니까?" /></p>
																<div class="btnArea">
																	<button type="button" onclick="jssubmit(); return false;" class="btnAgr agreeY"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_agree.png" alt="찬성" /></button>
																	<button class="btnAgr agreeN" onclick="jssubmitx();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_disagree.png" alt="반대" /></button>
																</div>
																<p class="lt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_tip_02.png" alt="찬성하시는 분께 다음주 월요일 오전 10시, 구매버튼이 열립니다!" /></p>
															</div>
														<% end if %>
													<% end if %>

													<% if (left(nowdate,10) >= "2016-10-14" and left(nowdate,10) < "2016-10-17" and subscriptcount1 > 0 ) or ( left(nowdate,10) = "2016-10-17" and nowdate < #10/17/2016 10:00:00# and subscriptcount2 > 0 ) then %>
														<%'  case2. 구매하기(비활성)  %>
														<div class="case2">
															<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1017.png" alt="오전 10시 구매버튼이 열립니다" /></p>
															<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_off.png" alt="구매하기" /></button>
														</div>
													<% elseif left(nowdate,10) >= "2016-10-17" and nowdate >= #10/17/2016 10:00:00# and subscriptcount2 > 0 then %>
														<% if getitemlimitcnt(item5id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>														
														<% else %>
															<%'  case3. 구매하기(활성)  %>
															<div class="case3">
																<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1017.png" alt="오전 10시 구매버튼이 열립니다" /></p>
																<a href="" onclick="jsgetitem('<%=item5id%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_on.png" alt="지금 구매하기" /></a>
															</div>
														<% end if %>
													<% elseif left(nowdate,10) >= "2016-10-17" and subscriptcount2 < 1 then %>
														<% if getitemlimitcnt(item5id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case4. 미참여/반대고객  %>
															<div class="case4">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_sorry.png" alt="해당 기간 할인가에 천성해주신 고객분들께만 구매하기 버튼이 보입니다" /></p>
															</div>
														<% end if %>
													<% end if %>
												</div>
											</div>
											<%' // 10월 14일  %>
										<% end if %>

										<% if left(nowdate,10) >= "2016-10-17" then %>
											<%'  10월 17일  %>
											<div class="box" id="item6" style="display:none">
												<div class="itemPic">
													<a href="/shopping/category_prd.asp?itemid=742608" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/img_item_1015.jpg" alt="플라워 프레그런스 디퓨져(오일향기 랜덤)" /></a>
													<% if left(nowdate,10) >= "2016-10-18" and nowdate >= #10/18/2016 10:00:00# then %>
														<span class="limit50"></span>
													<% end if %>
												</div>
												<div class="itemInfo">
													<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_item_1015.png" alt="" /></p>

													<% if left(nowdate,10) = "2016-10-17" then %>
														<% if subscriptcount1 < 1 then %>
															<%'  case1. 찬성/반대 투표하기  %>
															<div class="case1">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_agree.png" alt="위 할인가에 찬성하십니까?" /></p>
																<div class="btnArea">
																	<button type="button" onclick="jssubmit(); return false;" class="btnAgr agreeY"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_agree.png" alt="찬성" /></button>
																	<button class="btnAgr agreeN" onclick="jssubmitx();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_disagree.png" alt="반대" /></button>
																</div>
																<p class="lt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_tip.png" alt="찬성하시는 분께 다음날 오전 10시, 구매버튼이 열립니다!" /></p>
															</div>
														<% end if %>
													<% end if %>

													<% if (left(nowdate,10) = "2016-10-17" and subscriptcount1 > 0 ) or ( left(nowdate,10) = "2016-10-18" and nowdate < #10/18/2016 10:00:00# and subscriptcount2 > 0 ) then %>
														<%'  case2. 구매하기(비활성)  %>
														<div class="case2">
															<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1018.png" alt="오전 10시 구매버튼이 열립니다" /></p>
															<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_off.png" alt="구매하기" /></button>
														</div>
													<% elseif left(nowdate,10) >= "2016-10-18" and nowdate >= #10/18/2016 10:00:00# and subscriptcount2 > 0 then %>
														<% if getitemlimitcnt(item6id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case3. 구매하기(활성)  %>
															<div class="case3">
																<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1018.png" alt="오전 10시 구매버튼이 열립니다" /></p>
																<a href="" onclick="jsgetitem('<%=item6id%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_on.png" alt="지금 구매하기" /></a>
															</div>
														<% end if %>
													<% elseif left(nowdate,10) >= "2016-10-18" and subscriptcount2 < 1 then %>
														<% if getitemlimitcnt(item6id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>														
														<% else %>
															<%'  case4. 미참여/반대고객  %>
															<div class="case4">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_sorry.png" alt="해당 기간 할인가에 천성해주신 고객분들께만 구매하기 버튼이 보입니다" /></p>
															</div>
														<% end if %>
													<% end if %>
												</div>
											</div>
											<%' // 10월 17일  %>
										<% end if %>

										<% if left(nowdate,10) >= "2016-10-18"  then %>
											<%'  10월 18일  %>
											<div class="box" id="item7" style="display:none">
												<div class="itemPic">
													<a href="/shopping/category_prd.asp?itemid=841828" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/img_item_1018.jpg" alt="미니토끼 LED램프" /></a>
													<% if left(nowdate,10) >= "2016-10-19" and nowdate >= #10/19/2016 10:00:00# then %>
														<span class="limit50"></span>
													<% end if %>
												</div>
												<div class="itemInfo">
													<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_item_1018.png" alt="" /></p>

													<% if left(nowdate,10) = "2016-10-18" then %>
														<% if subscriptcount1 < 1 then %>
															<%'  case1. 찬성/반대 투표하기  %>
															<div class="case1">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_agree.png" alt="위 할인가에 찬성하십니까?" /></p>
																<div class="btnArea">
																	<button type="button" onclick="jssubmit(); return false;" class="btnAgr agreeY"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_agree.png" alt="찬성" /></button>
																	<button class="btnAgr agreeN" onclick="jssubmitx();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_disagree.png" alt="반대" /></button>
																</div>
																<p class="lt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_tip.png" alt="찬성하시는 분께 다음날 오전 10시, 구매버튼이 열립니다!" /></p>
															</div>
														<% end if %>
													<% end if %>

													<% if (left(nowdate,10) = "2016-10-18" and subscriptcount1 > 0 ) or ( left(nowdate,10) = "2016-10-19" and nowdate < #10/19/2016 10:00:00# and subscriptcount2 > 0 ) then %>
														<%'  case2. 구매하기(비활성)  %>
														<div class="case2">
															<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1019.png" alt="오전 10시 구매버튼이 열립니다" /></p>
															<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_off.png" alt="구매하기" /></button>
														</div>
													<% elseif left(nowdate,10) >= "2016-10-19" and nowdate >= #10/19/2016 10:00:00# and subscriptcount2 > 0 then %>
														<% if getitemlimitcnt(item7id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case3. 구매하기(활성)  %>
															<div class="case3">
																<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1019.png" alt="오전 10시 구매버튼이 열립니다" /></p>
																<a href="" onclick="jsgetitem('<%=item7id%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_on.png" alt="지금 구매하기" /></a>
															</div>
														<% end if %>
													<% elseif left(nowdate,10) >= "2016-10-19" and subscriptcount2 < 1 then %>
														<% if getitemlimitcnt(item7id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case4. 미참여/반대고객  %>
															<div class="case4">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_sorry.png" alt="해당 기간 할인가에 천성해주신 고객분들께만 구매하기 버튼이 보입니다" /></p>
															</div>
														<% end if %>
													<% end if %>
												</div>
											</div>
											<%' // 10월 18일  %>
										<% end if %>

										<% if left(nowdate,10) >= "2016-10-19"  then %>
											<%'  10월 19일  %>
											<div class="box" id="item8" style="display:none">
												<div class="itemPic">
													<a href="/shopping/category_prd.asp?itemid=1494253" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/img_item_1019.jpg" alt="오스터 볼 메이슨자 스무디 믹서기" /></a>
													<% if left(nowdate,10) >= "2016-10-20" and nowdate >= #10/20/2016 10:00:00# then %>
														<span class="limit30"></span>
													<% end if %>
												</div>
												<div class="itemInfo">
													<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_item_1019.png" alt="" /></p>

													<% if left(nowdate,10) = "2016-10-19" then %>
														<% if subscriptcount1 < 1 then %>
															<%'  case1. 찬성/반대 투표하기  %>
															<div class="case1">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_agree.png" alt="위 할인가에 찬성하십니까?" /></p>
																<div class="btnArea">
																	<button type="button" onclick="jssubmit(); return false;" class="btnAgr agreeY"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_agree.png" alt="찬성" /></button>
																	<button class="btnAgr agreeN" onclick="jssubmitx();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_disagree.png" alt="반대" /></button>
																</div>
																<p class="lt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_tip.png" alt="찬성하시는 분께 다음날 오전 10시, 구매버튼이 열립니다!" /></p>
															</div>
														<% end if %>
													<% end if %>

													<% if (left(nowdate,10) = "2016-10-19" and subscriptcount1 > 0 ) or ( left(nowdate,10) = "2016-10-20" and nowdate < #10/20/2016 10:00:00# and subscriptcount2 > 0 ) then %>
														<%'  case2. 구매하기(비활성)  %>
														<div class="case2">
															<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1020.png" alt="오전 10시 구매버튼이 열립니다" /></p>
															<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_off.png" alt="구매하기" /></button>
														</div>
													<% elseif left(nowdate,10) >= "2016-10-20" and nowdate >= #10/20/2016 10:00:00# and subscriptcount2 > 0 then %>
														<% if getitemlimitcnt(item8id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case3. 구매하기(활성)  %>
															<div class="case3">
																<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1020.png" alt="오전 10시 구매버튼이 열립니다" /></p>
																<a href="" onclick="jsgetitem('<%=item8id%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_on.png" alt="지금 구매하기" /></a>
															</div>
														<% end if %>
													<% elseif left(nowdate,10) >= "2016-10-20" and subscriptcount2 < 1 then %>
														<% if getitemlimitcnt(item8id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case4. 미참여/반대고객  %>
															<div class="case4">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_sorry.png" alt="해당 기간 할인가에 천성해주신 고객분들께만 구매하기 버튼이 보입니다" /></p>
															</div>
														<% end if %>
													<% end if %>
												</div>
											</div>
											<%' // 10월 19일  %>
										<% end if %>

										<% if left(nowdate,10) >= "2016-10-20"  then %>
											<%'  10월 20일  %>
											<div class="box" id="item9" style="display:none">
												<div class="itemPic">
													<a href="/shopping/category_prd.asp?itemid=1545082" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/img_item_1020.jpg" alt="디즈니 티타임 팩" /></a>
													<% if left(nowdate,10) >= "2016-10-21" and nowdate >= #10/21/2016 10:00:00# then %>
														<span class="limit30"></span>
													<% end if %>
												</div>
												<div class="itemInfo">
													<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_item_1020.png" alt="" /></p>

													<% if left(nowdate,10) = "2016-10-20" then %>
														<% if subscriptcount1 < 1 then %>
															<%'  case1. 찬성/반대 투표하기  %>
															<div class="case1">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_agree.png" alt="위 할인가에 찬성하십니까?" /></p>
																<div class="btnArea">
																	<button type="button" onclick="jssubmit(); return false;" class="btnAgr agreeY"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_agree.png" alt="찬성" /></button>
																	<button class="btnAgr agreeN" onclick="jssubmitx();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_disagree.png" alt="반대" /></button>
																</div>
																<p class="lt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_tip.png" alt="찬성하시는 분께 다음날 오전 10시, 구매버튼이 열립니다!" /></p>
															</div>
														<% end if %>
													<% end if %>

													<% if (left(nowdate,10) = "2016-10-20" and subscriptcount1 > 0 ) or ( left(nowdate,10) = "2016-10-21" and nowdate < #10/21/2016 10:00:00# and subscriptcount2 > 0 ) then %>
														<%'  case2. 구매하기(비활성)  %>
														<div class="case2">
															<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1024.png" alt="오전 10시 구매버튼이 열립니다" /></p>
															<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_off.png" alt="구매하기" /></button>
														</div>
													<% elseif left(nowdate,10) >= "2016-10-21" and nowdate >= #10/21/2016 10:00:00# and subscriptcount2 > 0 then %>
														<% if getitemlimitcnt(item9id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case3. 구매하기(활성)  %>
															<div class="case3">
																<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1021.png" alt="오전 10시 구매버튼이 열립니다" /></p>
																<a href="" onclick="jsgetitem('<%=item9id%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_on.png" alt="지금 구매하기" /></a>
															</div>
														<% end if %>
													<% elseif left(nowdate,10) >= "2016-10-21" and subscriptcount2 < 1 then %>
														<% if getitemlimitcnt(item9id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case4. 미참여/반대고객  %>
															<div class="case4">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_sorry.png" alt="해당 기간 할인가에 천성해주신 고객분들께만 구매하기 버튼이 보입니다" /></p>
															</div>
														<% end if %>
													<% end if %>
												</div>
											</div>
											<%' // 10월 20일  %>
										<% end if %>

										<% if left(nowdate,10) >= "2016-10-21" then %>
											<%'  10월 21일~23일  %>
											<div class="box" id="item10" style="display:none">
												<div class="itemPic">
													<a href="/shopping/category_prd.asp?itemid=255242" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/img_item_1021.jpg" alt="오토 플립 클락" /></a>
													<% if left(nowdate,10) >= "2016-10-24" and nowdate >= #10/24/2016 10:00:00# then %>
														<span class="limit50"></span>
													<% end if %>
												</div>
												<div class="itemInfo">
													<p class="name"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_item_1021.png" alt="" /></p>

													<% if left(nowdate,10) >= "2016-10-21" and left(nowdate,10) < "2016-10-24" then %>
														<% if subscriptcount1 < 1 then %>
															<%'  case1. 찬성/반대 투표하기  %>
															<div class="case1" >
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_agree.png" alt="위 할인가에 찬성하십니까?" /></p>
																<div class="btnArea">
																	<button type="button" onclick="jssubmit(); return false;" class="btnAgr agreeY"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_agree.png" alt="찬성" /></button>
																	<button class="btnAgr agreeN" onclick="jssubmitx();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_disagree.png" alt="반대" /></button>
																</div>
																<p class="lt"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_tip_02.png" alt="찬성하시는 분께 다음주 월요일 오전 10시, 구매버튼이 열립니다!" /></p>
															</div>
														<% end if %>
													<% end if %>

													<% if (left(nowdate,10) >= "2016-10-21" and left(nowdate,10) < "2016-10-24" and subscriptcount1 > 0 ) or ( left(nowdate,10) = "2016-10-24" and nowdate < #10/24/2016 10:00:00# and subscriptcount2 > 0 ) then %>
														<%'  case2. 구매하기(비활성)  %>
														<div class="case2" >
															<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1024.png" alt="오전 10시 구매버튼이 열립니다" /></p>
															<button type="button"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_off.png" alt="구매하기" /></button>
														</div>
													<% elseif left(nowdate,10) >= "2016-10-24" and nowdate >= #10/24/2016 10:00:00# and subscriptcount2 > 0 then %>
														<% if getitemlimitcnt(item10id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case3. 구매하기(활성)  %>
															<div class="case3">
																<p class="open10am"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_10am_1024.png" alt="오전 10시 구매버튼이 열립니다" /></p>
																<a href="" onclick="jsgetitem('<%=item10id%>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_buy_on.png" alt="지금 구매하기" /></a>
															</div>
														<% end if %>
													<% elseif left(nowdate,10) >= "2016-10-24" and subscriptcount2 < 1 then %>
														<% if getitemlimitcnt(item10id) < 1 then %>
															<div class="case5">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_soldout.png" alt="품절" /></p>
															</div>
														<% else %>
															<%'  case4. 미참여/반대고객  %>
															<div class="case4">
																<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/txt_sorry.png" alt="해당 기간 할인가에 천성해주신 고객분들께만 구매하기 버튼이 보입니다" /></p>
															</div>
														<% end if %>
													<% end if %>
												</div>
											</div>
											<%' // 10월 21일~23일  %>
										<% end if %>

										
										<button type="button" class="btnPreview" onclick="viewPoupLayer('modal',$('#lyrPreview').html());return false;"><span></span><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_preview.png" alt="다른 회차 미리보기" /></button>
										<%'  상품 미리보기 레이어  %>
										<div id="lyrPreview" style="display:none;">
											<div class="previewCont">
												<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/img_preview.png" alt="다음 상품 미리보기" /></div>
												<button type="button" class="close" onclick="ClosePopLayer()"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/73064/btn_close.png" alt="닫기" /></button>
											</div>
										</div>
										<%' // 상품 미리보기 레이어  %>
									</div>
								</div>
							</div>
							<%'  이벤트 유의사항  %>
							<div class="noti">
								<div>
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/tit_noti.png" alt="이벤트 유의사항" /></h3>
									<ul>
										<li>- 본 이벤트는 각 회차 당 할인가에 찬성한 사람에게만 해당 상품을 구매할 수 있는 기회가 주어집니다.</li>
										<li>- 구매버튼은 다음 회차가 오픈되는 오전10시에 클릭할 수 있습니다.</li>
										<li>- 각 상품은 한정수량이며 선착순으로 구매할 수 있습니다.</li>
										<li>- 구매자에게는 상품에 따라 세무신고에 필요한 개인정보를 요청할 수 있습니다. 제세공과금은 텐바이텐 부담입니다.</li>
										<li>- 본 이벤트의 상품은 즉시결제로만 구매가 가능하며, 배송 후 반품/교환/구매취소가 불가능합니다.</li>
									</ul>
								</div>
							</div>
							<%'  sns 공유  %>
							<div class="shareSns">
								<div>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/txt_share.png" alt="텐바이텐 15주년 이야기, 친구와 함께라면!" /></p>
									<ul>
										<li><a href="" onclick="snschk('fb');return false;" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_facebook.png" alt="텐바이텐 15주년 이야기 페이스북으로 공유" /></a></li>
										<li><a href="" onclick="snschk('tw');return false;" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/15th/btn_twitter.png" alt="텐바이텐 15주년 이야기 트위터로 공유" /></a></li>
									</ul>
								</div>
							</div>
						</div>
						<%'  15주년 이벤트 : 비정상할인  %>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->