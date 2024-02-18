<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [2016 정기세일] 가격이 터진다
' History : 2016.04.12 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->

<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim evt_code, userid, nowdate, subscriptcount1, subscriptcount2, itemnum, beforenum, beforedonationCost

userid = GetEncLoginUserID()

nowdate = now()
'	nowdate = #04/26/2016 10:05:00#


if left(nowdate,10) < "2016-04-20" then
	itemnum = 1
	donationCost = 15000
elseif left(nowdate,10) >= "2016-04-20" and left(nowdate,10) < "2016-04-22" then
	itemnum = 2
	donationCost = 10000
elseif left(nowdate,10) >= "2016-04-22" and left(nowdate,10) < "2016-04-24" then
	itemnum = 3
	donationCost = 10000
elseif left(nowdate,10) >= "2016-04-24" and left(nowdate,10) < "2016-04-26" then
	itemnum = 4
	donationCost = 10000
elseif left(nowdate,10) >= "2016-04-26" then
	itemnum = 5
	donationCost = 10000
end if

if left(nowdate,10) = "2016-04-20" then
	beforenum = 1
	beforedonationCost = 15000
elseif left(nowdate,10) = "2016-04-22" then
	beforenum = 2
	beforedonationCost = 10000
elseif left(nowdate,10) = "2016-04-24" then
	beforenum = 3
	beforedonationCost = 10000
elseif left(nowdate,10) = "2016-04-26" then
	beforenum = 4
	beforedonationCost = 10000
elseif left(nowdate,10) >= "2016-04-28" then
	beforenum = 5
	beforedonationCost = 10000
end if

IF application("Svr_Info") = "Dev" THEN
	evt_code   =  66102
Else
	evt_code   =  70030
End If

Dim sqlStr, pNum, graph, donationCost, beforepNum, beforegraph

if userid<>"" then
	subscriptcount1 = getevent_subscriptexistscount(evt_code, userid, "", itemnum, "")
	subscriptcount2 = getevent_subscriptexistscount(evt_code, userid, "", beforenum, "")
end if

'if left(nowdate,10) = "2016-04-23" then
	if userid="greenteenz" or userid="cogusdk" or userid="helele223" then
		subscriptcount1 = 0
	end if
'end if


sqlStr = "SELECT COUNT(*) from db_event.dbo.tbl_event_subscript where evt_code='" & evt_code & "' and sub_opt2='" & beforenum & "' "
rsget.Open sqlStr,dbget,1
IF Not rsget.Eof Then
	beforepNum = rsget(0)
End IF
rsget.close

sqlStr = "SELECT COUNT(*) from db_event.dbo.tbl_event_subscript where evt_code='" & evt_code & "' and sub_opt2='" & itemnum & "' "
rsget.Open sqlStr,dbget,1
IF Not rsget.Eof Then
	pNum = rsget(0)
End IF
rsget.close

graph = 0
beforegraph = 0
IF pNum="" then pNum=0
IF beforepNum="" then beforepNum=0
IF isNull(donationCost)  then donationCost=0
IF isNull(beforedonationCost)  then beforedonationCost=0
	
graph = Int( pNum / donationCost * 100  )	'게이지바 % 계산
if left(nowdate,10) = "2016-04-20" or left(nowdate,10) = "2016-04-22" or left(nowdate,10) = "2016-04-24" or left(nowdate,10) = "2016-04-26" or left(nowdate,10) = "2016-04-28" then
	beforegraph = Int( beforepNum / beforedonationCost * 100  )	'게이지바 % 계산
end if

if graph > 100 then graph = 100
if beforegraph > 100 then beforegraph = 100

strPageTitle	= "[텐바이텐] 포텐이 터진다!"
strPageUrl		= "http://www.10x10.co.kr/event/4ten/index.asp"
strPageImage = "http://webimage.10x10.co.kr/eventIMG/2016/70030/banMoList20160415174224.JPEG"

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
/* 4ten common */
img {vertical-align:top;}
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}

.fourtenPrice button {background-color:transparent;}
.fourtenPrice button:active {background-color:transparent;}

.topic {position:relative; height:460px; background:#fffdd0 url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/bg_pattern_dot_v1.png) repeat 0 0;}
.topic .inner {height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/bg_flame.png) no-repeat 50% 0;}
.topic .inner h2 {position:absolute; top:70px; left:50%; margin-left:-305px; width:610px; height:149px;}
.topic .inner h2 span {position:absolute;}
.topic .inner h2 .letter1,
.topic .inner h2 .letter2 {width:231px; height:149px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/tit_price_v2.png) no-repeat 0 0; text-indent:-999em;}
.topic .inner h2 .letter1 {top:0; left:0;}
.topic .inner h2 .letter2 {right:0; bottom:0; width:373px; background-position:100% 0;}
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(1.1);}
	100% {transform:scale(1);}
}
.pulse {animation-duration:3s; animation-fill-mode:both; animation-iteration-count:infinite; animation-name:pulse;}


.topic .inner .challenge {position:absolute; top:240px; left:50%; margin-left:-116px;}
.topic .inner .down {position:absolute; top:32px; left:50%; margin-left:-368px;}
.topic .inner .down1 {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-5px; animation-timing-function:ease-in;}
}

.topic .inner .down2 {top:31px; margin-left:-905px;}

.tabDate {position:absolute; bottom:0; left:50%; width:1020px; height:140px; margin-left:-510px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/bg_line_dot.png) no-repeat 50% 137px;}
.tabDate ul {width:950px; height:115px; margin:0 auto;}
.tabDate ul li {float:left; position:relative; width:160px; height:95px; margin:0 15px; padding-top:20px;}
.tabDate ul li span {overflow:hidden; display:block; position:relative; height:95px; color:#000; font-size:11px; line-height:110px; text-align:center;}
.tabDate ul li span i {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/bg_tab_date.png) no-repeat 0 100%;}
.tabDate ul li span.on i {background-position:0 -95px;}
.tabDate ul li.date2 span i {background-position:-190px 100%;}
.tabDate ul li.date2 span.coming i {background-position:-190px 0;}
.tabDate ul li.date2 span.on i {background-position:-190px -95px;}
.tabDate ul li.date3 span i {background-position:-380px 100%;}
.tabDate ul li.date3 span.coming i {background-position:-380px 0;}
.tabDate ul li.date3 span.on i {background-position:-380px -95px;}
.tabDate ul li.date4 span i {background-position:-570px 100%;}
.tabDate ul li.date4 span.coming i {background-position:-570px 0;}
.tabDate ul li.date4 span.on i {background-position:-570px -95px;}
.tabDate ul li.date5 span i {background-position:100% 100%;}
.tabDate ul li.date5 span.coming i {background-position:100% 0;}
.tabDate ul li.date5 span.on i {background-position:100% -95px;}
.tabDate ul li a {display:block; position:absolute; top:20px; left:0; width:160px; height:80px; cursor:pointer;}
.tabDate ul li .win {display:block; position:absolute; top:-0; left:0; width:160px; height:80px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/bg_win_box.png) no-repeat 0 0;}
.tabDate ul li .win i {position:absolute; left:0; width:100%; animation-name:twinkle; animation-iteration-count:infinite; animation-duration:1.2s; animation-fill-mode:both; text-align:center;}
@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}
.tabDate ul li .win .hand {position:absolute; top:58px; left:105px; animation:0.5s hand2 ease-in-out infinite alternate;}
@keyframes hand2 {
	0% {margin-left:0;}
	100% {margin-left:-3px; transform:rotate(-3deg);}
}
.tabDate ul li .soldout {background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/bg_tab_date_soldout.png) no-repeat 0 0; cursor:default;}
.tabDate ul li .soldout .win {display:none;}
.tabDate ul li.date2 .soldout {background-position:-190px 0;}
.tabDate ul li.date3 .soldout {background-position:-380px 0;}
.tabDate ul li.date4 .soldout {background-position:-570px 0;}
.tabDate ul li.date5 .soldout {background-position:100% 0;}

.item {padding:70px 0; background:#ffdb60 url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/bg_pattern_zigzag.png) repeat-y 50% 0;}

.thumbnail {position:relative; width:1000px; margin:0 auto; padding-bottom:25px;}
.thumbnail .label {position:absolute; top:-42px; right:0; width:148px; height:148px;}
.thumbnail .label .sun {position:absolute; top:50%; left:50%; margin-top:-60px; margin-left:-60px;}
.spin {animation:spin 10s linear infinite;}
@keyframes spin {100% { transform:rotate(360deg);}}
.thumbnail .label .no {position:absolute; top:50%; left:50%; margin-top:-60px; margin-left:-60px;}

.step {width:920px; margin:0 auto; padding-top:48px;}
.step .hand {position:absolute; top:66px; right:2px; animation:0.5s hand ease-in-out infinite alternate;}
@keyframes hand {
	0% {margin-top:0;}
	100% {margin-top:-5px;}
}

.step1 .btnGroup button, .step1 .btnGroup a {margin:0 8px;}
.step1 {background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/bg_line_dashed.png) no-repeat 50% 0;}
.step1 .btnGroup button {position:relative;}

.step2 {position:relative; padding-top:20px;}
.step2 .goal {position:relative;}
.step2 .count {display:block; position:absolute; top:142px; left:370px; text-align:left;}
.step2 .count strong {margin-left:15px; color:#683e16; font-family:'Verdana'; font-size:28px; font-weight:bold; line-height:27px;}
.step2 .gage {position:absolute; top:210px; left:370px; width:400px;}
.step2 .gage span {overflow:hidden; display:block; height:10px; border-radius:6px; background-color:#ff6c4f;}
.step2 .btnPreview {position:absolute; right:33px; bottom:20px;}
.step2 .check {position:relative;}
.step2 .check span {position:absolute; top:59px; left:244px; width:180px; height:2px; background-color:#6f4528;}
.step2 .check span {animation-name:underline; animation-iteration-count:infinite; animation-duration:2s; animation-fill-mode:both;}
@keyframes underline {
	0% {transform:scaleX(0);}
	100% {transform:scaleX(1);}
}

.step3 {background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/bg_line_dashed.png) no-repeat 50% 0;}
.step3 .btnGroup a {display:block; position:relative; width:400px; margin:0 auto;}

.lyPreview {display:none; position:fixed; top:50%; left:50%; z-index:105; width:920px; height:750px; margin-top:-375px; margin-left:-460px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/bg_pattern_dot_yellow.png) repeat 0 0;}
.lyPreview p {padding-top:60px;}
.lyPreview .btnClose {position:absolute; top:0; right:0; width:87px; height:87px;}

#dimmed {display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background:url(http://webimage.10x10.co.kr/eventIMG/2015/68354/bg_mask.png);}

.noti {background-color:#ffca29; text-align:left;}
.noti .inner {position:relative; width:1140px; margin:0 auto; padding:40px 0;}
.noti .inner h3 {position:absolute; top:50%; left:160px; margin-top:-12px;}
.noti .inner ul {padding-left:340px; color:#5a4846;}
.noti .inner ul li {margin-bottom:2px; padding-left:14px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/blt_dot.png) no-repeat 0 6px; color:#493612; font-family:'Dotum', 'Verdana'; font-size:12px; line-height:1.5em;}

.fourtenSns {position:relative; background-color:#84edc9;}
.fourtenSns button {overflow:hidden; position:absolute; top:40px; left:50%; width:225px; height:70px;}
.fourtenSns .ktShare {margin-left:90px;}
.fourtenSns .fbShare {margin-left:325px;}
</style>
<script type="text/javascript">
$(function(){
	<% if left(nowdate,10) < "2016-04-20" then %>
		$("#item1").show();
	<% elseif left(nowdate,10) >= "2016-04-20" and left(nowdate,10) < "2016-04-22" then %>
		$("#item2").show();
	<% elseif left(nowdate,10) >= "2016-04-22" and left(nowdate,10) < "2016-04-24" then %>
		$("#item3").show();
	<% elseif left(nowdate,10) >= "2016-04-24" and left(nowdate,10) < "2016-04-26" then %>
		$("#item4").show();
	<% elseif left(nowdate,10) >= "2016-04-26" and left(nowdate,10) < "2016-04-29" then %>
		$("#item5").show();
	<% end if %>
	/* layer */
	var wrapHeight = $(document).height();
	$(".btnPreview").click(function(){
		var layershow = $(this).attr("href");
		$(".item").find(layershow).show();
		$("#dimmed").show();
		$("#dimmed").css("height",wrapHeight);
	});

	$(".lyPreview .btnClose, #dimmed").click(function(){
		$(".lyPreview").hide();
		$("#dimmed").fadeOut();
	});

	animation();
	$("#animation .letter1").css({"top":"-10px", "opacity":"0"});
	$("#animation .letter2").css({"bottom":"-10px", "opacity":"0"});
	$("#animation .down1").css({"opacity":"0"});
	function animation () {
		$("#animation .letter1").delay(100).animate({"top":"0", "opacity":"1"},500);
		$("#animation .letter2").delay(100).animate({"bottom":"0", "opacity":"1"},500);

		$("#animation .down1").delay(800).animate({"opacity":"1"},500);
	}
});

function jssubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(nowdate,10)>="2016-04-18" and left(nowdate,10)<"2016-04-28" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/4ten/doeventsubscript/doEventSubscriptprice.asp",
				data: "mode=addok",
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				alert('응모가 완료되었습니다.');
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
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}

function jsgetitem(iid){
	<% If IsUserLoginOK() Then %>
		<% If not( left(nowdate,10)>="2016-04-18" and left(nowdate,10)<"2016-04-29" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/4ten/doeventsubscript/doEventSubscriptprice.asp",
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
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	<% End IF %>
}

function jsshow(numb){
	if(numb=="1"){
		$("#item1").show();
		$("#item2").hide();
		$("#item3").hide();
		$("#item4").hide();
		$("#item5").hide();
	}else if(numb=="2"){
		$("#item1").hide();
		$("#item2").show();
		$("#item3").hide();
		$("#item4").hide();
		$("#item5").hide();
	}else if(numb=="3"){
		$("#item1").hide();
		$("#item2").hide();
		$("#item3").show();
		$("#item4").hide();
		$("#item5").hide();
	}else if(numb=="4"){
		$("#item1").hide();
		$("#item2").hide();
		$("#item3").hide();
		$("#item4").show();
		$("#item5").hide();
	}else if(numb=="5"){
		$("#item1").hide();
		$("#item2").hide();
		$("#item3").hide();
		$("#item4").hide();
		$("#item5").show();
	}else{
		$("#item1").hide();
		$("#item2").hide();
		$("#item3").hide();
		$("#item4").hide();
		$("#item5").hide();		
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

						<%' 수작업 영역 %>
						<!-- [W] 70030 가격이 터진다 -->
						<div class="fourten fourtenPrice">
							<% if date < "2016-04-28" then %>
								<!-- #include virtual="/event/4ten/nav.asp" -->
							<% end if %>
							<div id="animation" class="topic">
								<div class="inner">
									<h2>
										<span class="letter1">가격</span>
										<span class="letter2">이 터진다</span>
									</h2>
									<span class="down down1 bounce"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_arrow_down_01_v1.png" alt="" /></span>
									<span class="down down2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_arrow_down_02_v2.png" alt="" /></span>
									<p class="challenge"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_challenge_v1.png" alt="목표인원을 채우면 가격이 터져요 지금 할인에 도전하세요!" /></p>

									<%''  for dev msg : 날짜 tab %>
									<div class="tabDate">
										<ul>
											<li class="date1">
												<%'' for dev msg : "coming" 오픈하면 클래스명 제거해주세요 / 해당 일자에 class="on" 붙여주세요 %>
												<span <% if left(nowdate,10) < "2016-04-18" then %>class="coming"<% elseif left(nowdate,10) = "2016-04-18" or left(nowdate,10) = "2016-04-19" then %>class="on"<% else %><% end if %>><i></i>1회차 4월 18~19일</span>
												<% if left(nowdate,10) = "2016-04-20" then %>
													<% if getitemlimitcnt(1472247) < 1 then %>
														<a href="javascript:;" class="soldout">
													<% else %>
														<a href="" onclick="jsgetitem('1472247'); return false;">
													<% end if %>
														<% if subscriptcount2 > 0 then %>
															<% If nowdate > #04/20/2016 10:00:00# Then %>
																<strong class="win"><i><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_win_get_01.png" alt="1회차 구매하러 가기" /></i><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></strong>
															<% end if %>
														<% end if %>
													</a>
												<% else %>
													<a href="javascript:;" class="soldout"></a>
												<% end if %>
											</li>
											<li class="date2">
												<span <% if left(nowdate,10) < "2016-04-20" then %>class="coming"<% elseif left(nowdate,10) = "2016-04-20" or left(nowdate,10) = "2016-04-21" then %>class="on"<% else %><% end if %>><i></i>2회차 4월 20~21일</span>
												<% if left(nowdate,10) >= "2016-04-20" and left(nowdate,10) < "2016-04-23" then %>
														<% if left(nowdate,10) = "2016-04-22" then %>
															<% If nowdate > #04/22/2016 10:00:00# Then %>
																<% if subscriptcount2 > 0 then %>
																	<% if getitemlimitcnt(1472248) < 1 then %>
																		<a href="javascript:;" class="soldout">
																	<% else %>
																		<a href="" onclick="jsgetitem('1472248'); return false;">
																	<% end if %>
																	<strong class="win"><i><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_win_get_02.png" alt="2회차 구매하러 가기" /></i><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></strong>
																<% else %>
																	<% if getitemlimitcnt(1472248) < 1 then %>
																		<a href="javascript:;" class="soldout">
																	<% else %>
																		<a href="" onclick="jsshow('2'); return false;">
																	<% end if %>
																<% end if %>
															<% else %>
																<% if getitemlimitcnt(1472248) < 1 then %>
																	<a href="javascript:;" class="soldout">
																<% else %>
																	<a href="" onclick="jsshow('2'); return false;">
																<% end if %>
															<% end if %>
														<% else %>
															<a href="" onclick="jsshow('2'); return false;">
														<% end if %>
													</a>
												<% elseif left(nowdate,10) > "2016-04-22" then %>
													<a href="javascript:;" class="soldout"></a>
												<% end if %>
											</li>
											<li class="date3">
												<span <% if left(nowdate,10) < "2016-04-22" then %>class="coming"<% elseif left(nowdate,10) = "2016-04-22" or left(nowdate,10) = "2016-04-23" then %>class="on"<% else %><% end if %>><i></i>3회차 4월 22~23일</span>
												<% if left(nowdate,10) >= "2016-04-22" and left(nowdate,10) < "2016-04-25" then %>
														<% if left(nowdate,10) = "2016-04-24" then %>
															<% If nowdate > #04/24/2016 10:00:00# Then %>
																<% if subscriptcount2 > 0 then %>
																	<% if getitemlimitcnt(1472249) < 1 then %>
																		<a href="javascript:;" class="soldout">
																	<% else %>
																		<a href="" onclick="jsgetitem('1472249'); return false;">
																	<% end if %>
																	<strong class="win"><i><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_win_get_03.png" alt="3회차 구매하러 가기" /></i><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></strong>
																<% else %>
																	<% if getitemlimitcnt(1472249) < 1 then %>
																		<a href="javascript:;" class="soldout">
																	<% else %>
																		<a href="" onclick="jsshow('3'); return false;">
																	<% end if %>
																<% end if %>
															<% else %>
																<% if getitemlimitcnt(1472249) < 1 then %>
																	<a href="javascript:;" class="soldout">
																<% else %>
																	<a href="" onclick="jsshow('3'); return false;">
																<% end if %>
															<% end if %>
														<% else %>
															<a href="" onclick="jsshow('3'); return false;">
														<% end if %>
													</a>
												<% elseif left(nowdate,10) > "2016-04-24" then %>
													<a href="javascript:;" class="soldout"></a>
												<% end if %>
											</li>
											<li class="date4">
												<span <% if left(nowdate,10) < "2016-04-24" then %>class="coming"<% elseif left(nowdate,10) = "2016-04-24" or left(nowdate,10) = "2016-04-25" then %>class="on"<% else %><% end if %>><i></i>4회차 4월 24~25일</span>
												<% if left(nowdate,10) >= "2016-04-24" and left(nowdate,10) < "2016-04-27" then %>
														<% if left(nowdate,10) = "2016-04-26" then %>
															<% if subscriptcount2 > 0 then %>
																<% If nowdate > #04/26/2016 10:00:00# Then %>
																	<% if getitemlimitcnt(1472250) < 1 then %>
																		<a href="javascript:;" class="soldout">
																	<% else %>
																		<a href="" onclick="jsgetitem('1472250'); return false;">
																	<% end if %>
																	<strong class="win"><i><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_win_get_04.png" alt="4회차 구매하러 가기" /></i><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></strong>
																<% else %>
																	<% if getitemlimitcnt(1472250) < 1 then %>
																		<a href="javascript:;" class="soldout">
																	<% else %>
																		<a href="" onclick="jsshow('4'); return false;">
																	<% end if %>
																<% end if %>
															<% else %>
																<% if getitemlimitcnt(1472250) < 1 then %>
																	<a href="javascript:;" class="soldout">
																<% else %>
																	<a href="" onclick="jsshow('4'); return false;">
																<% end if %>
															<% end if %>
														<% else %>
															<a href="" onclick="jsshow('4'); return false;">
														<% end if %>
													</a>
												<% elseif left(nowdate,10) > "2016-04-26" then %>
													<a href="javascript:;" class="soldout"></a>													
												<% end if %>
											</li>
											<li class="date5">
												<span <% if left(nowdate,10) < "2016-04-26" then %>class="coming"<% else %>class="on"<% end if %>><i></i>5회차 4월 26~27일</span>
												<% if left(nowdate,10) >= "2016-04-26" and left(nowdate,10) < "2016-04-29" then %>
													<a href="" onclick="jsshow('5'); return false;">
														<% if left(nowdate,10) = "2016-04-28" then %>
															<% if subscriptcount2 > 0 then %>
																<% If nowdate > #04/28/2016 10:00:00# Then %>
																	<% if getitemlimitcnt(1472251) < 1 then %>
																		<a href="javascript:;" class="soldout">
																	<% else %>
																		<a href="" onclick="jsgetitem('1472251'); return false;">
																	<% end if %>
																	<strong class="win"><i><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_win_get_05.png" alt="5회차 구매하러 가기" /></i><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></strong>
																<% else %>
																	<% if getitemlimitcnt(1472251) < 1 then %>
																		<a href="javascript:;" class="soldout">
																	<% else %>
																		<a href="" onclick="jsshow('5'); return false;">
																	<% end if %>
																<% end if %>
															<% else %>
																<% if getitemlimitcnt(1472251) < 1 then %>
																	<a href="javascript:;" class="soldout">
																<% else %>
																	<a href="" onclick="jsshow('5'); return false;">
																<% end if %>
															<% end if %>
														<% else %>
															<a href="" onclick="jsshow('5'); return false;">
														<% end if %>
													</a>
												<% elseif left(nowdate,10) > "2016-04-28" then %>
													<a href="javascript:;" class="soldout"></a>
												<% end if %>
											</li>
										</ul>
									</div>
								</div>
							</div>

							<% if left(nowdate,10) =< "2016-04-21" then %>
								<%'' 상품1 %>
								<div id="item1" class="item" style="display:none">
									<p class="thumbnail">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_item_01.png" alt="라미 네온 라임 만년필 54,000원에서 5,000원으로" />
										<strong class="label">
											<span class="ribon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_ribon.png" alt="" /></span>
											<span class="sun spin"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_sun.png" alt="" /></span>
											<% if left(nowdate,10) = "2016-04-20" then %>
												<strong class="no"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_num_30.png" alt="선착순 30명" /></strong>
											<% else %>
												<strong class="no"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_num_limited.png" alt="선착순 한정수량" /></strong>
											<% end if %>
										</strong>
									</p>

									<% if subscriptcount1 < 1 then %>
										<% if left(nowdate,10) >= "2016-04-18" and left(nowdate,10) < "2016-04-20" then %>	
											<%'' for dev msg : 참여하기 %>
											<div class="step step1">
												<div class="btnGroup">
													<button type="button" onclick="jssubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_challenge.png" alt="할인에 도전하기" /><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></button>
													<a href="#lyPreview1" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview.png" alt="다음 상품 미리보기" /></a>
												</div>
											</div>
										<% elseif left(nowdate,10) = "2016-04-20" then %>
											<% If nowdate < #04/20/2016 10:00:00# Then %>
												<% if subscriptcount2 < 1 then %>
												<% else %>
													<%'' for dev msg : 참여 후 %>
													<div class="step step2">
														<div class="goal">
															<p>
																<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
																<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_15000_v1.png" alt="오늘의 목표 15000명 가격이 터지기까지" />
															</p>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="현재까지 응모자" /></span>
																<strong><%= beforepNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="명" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= beforegraph %>%;"></span>
															</div>
														</div>
														<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_01.png" alt="목표인원이 달성되면 4월 20일 오전 10시 할인의 문이 열립니다! 단 선착순입니다." /><span class="line"></span></p>
														<a href="#lyPreview1" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
													</div>
												<% end if %>
											<% end if %>
										<% end if %>
									<% else %>
										<% if left(nowdate,10) >= "2016-04-18" and left(nowdate,10) < "2016-04-20" then %>	
											<%'' for dev msg : 참여 후 %>
											<div class="step step2">
												<div class="goal">
													<p>
														<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
														<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_15000_v1.png" alt="오늘의 목표 15000명 가격이 터지기까지" />
													</p>
													<% if left(nowdate,10) = "2016-04-20" then %>
														<p class="count">
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="현재까지 응모자" /></span>
															<strong><%= beforepNum %></strong>
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="명" /></span>
														</p>
														<div class="gage">
															<span style="width:<%= beforegraph %>%;"></span>
														</div>
													<% else %>
														<p class="count">
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="현재까지 응모자" /></span>
															<strong><%= pNum %></strong>
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="명" /></span>
														</p>
														<div class="gage">
															<span style="width:<%= graph %>%;"></span>
														</div>
													<% end if %>
												</div>
												<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_01.png" alt="4월 20일 오전 10시 가격이 터졌는지 확인하세요! 할인에 도전하신 분께 구매의 기회가 열립니다. 단 선착순입니다." /><span class="line"></span></p>
												<a href="#lyPreview1" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
											</div>
										<% elseif left(nowdate,10) = "2016-04-20" then %>
											<% if subscriptcount2 < 1 then %>
											<% else %>
												<%'' for dev msg : 참여 후 %>
												<div class="step step2">
													<div class="goal">
														<p>
															<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
															<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_15000_v1.png" alt="오늘의 목표 15000명 가격이 터지기까지" />
														</p>
														<% if left(nowdate,10) = "2016-04-20" then %>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="현재까지 응모자" /></span>
																<strong><%= beforepNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="명" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= beforegraph %>%;"></span>
															</div>
														<% else %>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="현재까지 응모자" /></span>
																<strong><%= pNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="명" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= graph %>%;"></span>
															</div>
														<% end if %>
													</div>
													<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_01.png" alt="4월 20일 오전 10시 가격이 터졌는지 확인하세요! 할인에 도전하신 분께 구매의 기회가 열립니다. 단 선착순입니다." /><span class="line"></span></p>
													<a href="#lyPreview1" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
												</div>
											<% end if %>
										<% end if %>
									<% end if %>

									<%'' 내일의 할인 상품 %>
									<div id="lyPreview1" class="lyPreview">
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_item_tomorrow_01_v1.png" alt="SUPER 뿔테 명품 선글라스" /></p>
										<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_close.png" alt="내일의 할인 상품 레이어팝업 닫기" /></button>
									</div>
									<% if left(nowdate,10) = "2016-04-20" then %>
										<% If nowdate > #04/20/2016 10:00:00# Then %>
											<% if subscriptcount2 < 1 then %>
											<% else %>
												<%'' for dev msg : 당첨 후 %>
												<div class="step step3">
													<div class="btnGroup">
														<a href="" onclick="jsgetitem('1472247'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_get.png" alt="라미 네온 라임 만년필 쿠폰 받고 구매하러 가기" /><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></a>
													</div>
												</div>
											<% end if %>
										<% end if %>
									<% end if %>
								</div>
							<% end if %>

							<% if left(nowdate,10) =< "2016-04-23" then %>
								<%'' 상품2 %>
								<div id="item2" class="item" style="display:none">
									<p class="thumbnail">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_item_02.png" alt="SUPER 뿔테 명품 선글라스 299,000원에서 30,000원으로" />
										<strong class="label">
											<span class="ribon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_ribon.png" alt="" /></span>
											<span class="sun spin"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_sun.png" alt="" /></span>
											<% if left(nowdate,10) = "2016-04-22" then %>
												<strong class="no"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_num_50.png" alt="선착순 50명" /></strong>
											<% else %>
												<strong class="no"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_num_limited.png" alt="선착순 한정수량" /></strong>
											<% end if %>
										</strong>
									</p>
									<% if subscriptcount1 < 1 then %>
										<% if left(nowdate,10) >= "2016-04-20" and left(nowdate,10) < "2016-04-22" then %>	
											<%'' for dev msg : 참여하기 %>
											<div class="step step1">
												<div class="btnGroup">
													<button type="button" onclick="jssubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_challenge.png" alt="할인에 도전하기" /><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></button>
													<a href="#lyPreview2" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview.png" alt="다음 상품 미리보기" /></a>
												</div>
											</div>
										<% elseif left(nowdate,10) = "2016-04-22"  then %>
											<% If nowdate < #04/22/2016 10:00:00# Then %>
												<% if subscriptcount2 < 1 then %>
												<% else %>
													<%'' for dev msg : 참여 후 %>
													<div class="step step2">
															<p>
																<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
																<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 10000명 가격이 터지기까지" />
															</p>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= beforepNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= beforegraph %>%;"></span>
															</div>
														</div>
														<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_02.png" alt="목표인원이 달성되면 4월 22일 오전 10시 할인의 문이 열립니다! 단 선착순입니다." /><span class="line"></span></p>
														<a href="#lyPreview2" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
													</div>
												<% end if %>
											<% end if %>
										<% end if %>
									<% else %>
										<% if left(nowdate,10) >= "2016-04-20" and left(nowdate,10) < "2016-04-22" then %>	
											<%'' for dev msg : 참여 후 %>
											<div class="step step2">
												<div class="goal">
													<p>
														<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
														<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 10000명 가격이 터지기까지" />
													</p>
													<% if left(nowdate,10) = "2016-04-22" then %>
														<p class="count">
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
															<strong><%= beforepNum %></strong>
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
														</p>
														<div class="gage">
															<span style="width:<%= beforegraph %>%;"></span>
														</div>
													<% else %>
														<p class="count">
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
															<strong><%= pNum %></strong>
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
														</p>
														<div class="gage">
															<span style="width:<%= graph %>%;"></span>
														</div>
													<% end if %>
												</div>
												<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_02.png" alt="목표인원이 달성되면 4월 22일 오전 10시 할인의 문이 열립니다! 단 선착순입니다." /><span class="line"></span></p>
												<a href="#lyPreview2" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
											</div>
										<% elseif left(nowdate,10) = "2016-04-22" then %>
											<% if subscriptcount2 < 1 then %>
											<% else %>
												<%'' for dev msg : 참여 후 %>
												<div class="step step2">
													<div class="goal">
														<p>
															<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
															<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 10000명 가격이 터지기까지" />
														</p>
														<% if left(nowdate,10) = "2016-04-22" then %>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= beforepNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= beforegraph %>%;"></span>
															</div>
														<% else %>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= pNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= graph %>%;"></span>
															</div>
														<% end if %>
													</div>
													<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_02.png" alt="목표인원이 달성되면 4월 22일 오전 10시 할인의 문이 열립니다! 단 선착순입니다." /><span class="line"></span></p>
													<a href="#lyPreview2" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
												</div>
											<% end if %>
										<% end if %>
									<% end if %>
	
									<%'' 내일의 할인 상품 %>
									<div id="lyPreview2" class="lyPreview">
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_item_tomorrow_02_v1.png" alt="폴라로이드 디지털 즉석카메라 snap" /></p>
										<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_close.png" alt="내일의 할인 상품 레이어팝업 닫기" /></button>
									</div>

									<% if left(nowdate,10) = "2016-04-22" then %>
										<% If nowdate > #04/22/2016 10:00:00# Then %>
											<% if subscriptcount2 < 1 then %>
											<% else %>
												<%'' for dev msg : 당첨 후 %>
												<div class="step step3">
													<div class="btnGroup">
														<a href="" onclick="jsgetitem('1472248'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_get.png" alt="SUPER 뿔테 명품 선글라스 쿠폰 받고 구매하러 가기" /><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></a>
													</div>
												</div>
											<% end if %>
										<% end if %>
									<% end if %>
								</div>
							<% end if %>

							<% if left(nowdate,10) =< "2016-04-25" then %>
								<%'' 상품3 %>
								<div id="item3" class="item" style="display:none">
									<p class="thumbnail">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_item_03.png" alt="폴라로이드 디지털 즉석카메라 snap 209,000원에서 50,000원으로" />
										<strong class="label">
											<span class="ribon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_ribon.png" alt="" /></span>
											<span class="sun spin"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_sun.png" alt="" /></span>
											<% if left(nowdate,10) = "2016-04-24" then %>
												<strong class="no"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_num_30.png" alt="선착순 30명" /></strong>
											<% else %>
												<strong class="no"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_num_limited.png" alt="선착순 한정수량" /></strong>
											<% end if %>
										</strong>
									</p>

									<% if subscriptcount1 < 1 then %>
										<% if left(nowdate,10) >= "2016-04-22" and left(nowdate,10) < "2016-04-24" then %>	
											<%'' for dev msg : 참여하기 %>
											<div class="step step1">
												<div class="btnGroup">
													<button type="button" onclick="jssubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_challenge.png" alt="할인에 도전하기" /><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></button>
													<a href="#lyPreview3" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview.png" alt="다음 상품 미리보기" /></a>
												</div>
											</div>
										<% elseif left(nowdate,10) = "2016-04-24"  then %>	
											<% If nowdate < #04/24/2016 10:00:00# Then %>
												<% if subscriptcount2 < 1 then %>
												<% else %>
													<%'' for dev msg : 참여 후 %>
													<div class="step step2">
														<div class="goal">
															<p>
																<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
																<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 20000명 가격이 터지기까지" />
															</p>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= beforepNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= beforegraph %>%;"></span>
															</div>
														</div>
														<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_03.png" alt="목표인원이 달성되면 4월 24일 오전 10시 할인의 문이 열립니다! 단 선착순입니다." /><span class="line"></span></p>
														<a href="#lyPreview3" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
													</div>
												<% end if %>
											<% end if %>
										<% end if %>
									<% else %>
										<% if left(nowdate,10) >= "2016-04-22" and left(nowdate,10) < "2016-04-24" then %>	
											<%'' for dev msg : 참여 후 %>
											<div class="step step2">
												<div class="goal">
													<p>
														<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
														<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 10000명 가격이 터지기까지" />
													</p>
													<% if left(nowdate,10) = "2016-04-24" then %>
														<p class="count">
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
															<strong><%= beforepNum %></strong>
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
														</p>
														<div class="gage">
															<span style="width:<%= beforegraph %>%;"></span>
														</div>
													<% else %>
														<p class="count">
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
															<strong><%= pNum %></strong>
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
														</p>
														<div class="gage">
															<span style="width:<%= graph %>%;"></span>
														</div>
													<% end if %>
												</div>
												<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_03.png" alt="목표인원이 달성되면 4월 24일 오전 10시 할인의 문이 열립니다! 단 선착순입니다." /><span class="line"></span></p>
												<a href="#lyPreview3" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
											</div>
										<% elseif left(nowdate,10) = "2016-04-24" then %>
											<% if subscriptcount2 < 1 then %>
											<% else %>
												<%'' for dev msg : 참여 후 %>
												<div class="step step2">
													<div class="goal">
														<p>
															<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
															<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 10000명 가격이 터지기까지" />
														</p>
														<% if left(nowdate,10) = "2016-04-24" then %>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= beforepNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= beforegraph %>%;"></span>
															</div>
														<% else %>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= pNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= graph %>%;"></span>
															</div>
														<% end if %>
													</div>
													<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_03.png" alt="목표인원이 달성되면 4월 24일 오전 10시 할인의 문이 열립니다! 단 선착순입니다." /><span class="line"></span></p>
													<a href="#lyPreview3" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
												</div>
											<% end if %>
										<% end if %>
									<% end if %>
	
									<%'' 내일의 할인 상품 %>
									<div id="lyPreview3" class="lyPreview">
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_item_tomorrow_03_v1.png" alt="독일 보만 커피메이커와 오븐" /></p>
										<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_close.png" alt="내일의 할인 상품 레이어팝업 닫기" /></button>
									</div>

									<% if left(nowdate,10) = "2016-04-24" then %>
										<% If nowdate > #04/24/2016 10:00:00# Then %>
											<% if subscriptcount2 < 1 then %>
											<% else %>
												<%'' for dev msg : 당첨 후 %>
												<div class="step step3">
													<div class="btnGroup">
														<a href="" onclick="jsgetitem('1472249'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_get.png" alt="폴라로이드 디지털 즉석카메라 snap 쿠폰 받고 구매하러 가기" /><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></a>
													</div>
												</div>
											<% end if %>
										<% end if %>
									<% end if %>
								</div>
							<% end if %>

							<% if left(nowdate,10) =< "2016-04-27" then %>
								<%'' 상품4 %>
								<div id="item4" class="item" style="display:none">
									<p class="thumbnail">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_item_04.png" alt="독일 보만 커피메이커와 오븐 89,000원에서 20,000원으로" />
										<strong class="label">
											<span class="ribon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_ribon.png" alt="" /></span>
											<span class="sun spin"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_sun.png" alt="" /></span>
											<% if left(nowdate,10) = "2016-04-26" then %>
												<strong class="no"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_num_50.png" alt="선착순 50명" /></strong>
											<% else %>
												<strong class="no"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_num_limited.png" alt="선착순 한정수량" /></strong>
											<% end if %>
										</strong>
									</p>

									<% if subscriptcount1 < 1 then %>
										<% if left(nowdate,10) >= "2016-04-24" and left(nowdate,10) < "2016-04-26" then %>	
											<%'' for dev msg : 참여하기 %>
											<div class="step step1">
												<div class="btnGroup">
													<button type="button" onclick="jssubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_challenge.png" alt="할인에 도전하기" /><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></button>
													<a href="#lyPreview4" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview.png" alt="다음 상품 미리보기" /></a>
												</div>
											</div>
										<% elseif left(nowdate,10) = "2016-04-26" then %>
											<% If nowdate < #04/26/2016 10:00:00# Then %>
												<% if subscriptcount2 < 1 then %>
												<% else %>											
													<%'' for dev msg : 참여 후 %>
													<div class="step step2">
														<div class="goal">
															<p>
																<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
																<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 10000명 가격이 터지기까지" />
															</p>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= beforepNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= beforegraph %>%;"></span>
															</div>
														</div>
														<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_04.png" alt="목표인원이 달성되면 4월 26일 오전 10시 할인의 문이 열립니다! 단 선착순입니다." /><span class="line"></span></p>
														<a href="#lyPreview4" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
													</div>
												<% end if %>
											<% end if %>
										<% end if %>
									<% else %>
										<% if left(nowdate,10) >= "2016-04-24" and left(nowdate,10) < "2016-04-26" then %>	
											<%'' for dev msg : 참여 후 %>
											<div class="step step2">
												<div class="goal">
													<p>
														<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
														<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 10000명 가격이 터지기까지" />
													</p>
													<% if left(nowdate,10) = "2016-04-26" then %>
														<p class="count">
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
															<strong><%= beforepNum %></strong>
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
														</p>
														<div class="gage">
															<span style="width:<%= beforegraph %>%;"></span>
														</div>
													<% else %>
														<p class="count">
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
															<strong><%= pNum %></strong>
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
														</p>
														<div class="gage">
															<span style="width:<%= graph %>%;"></span>
														</div>
													<% end if %>
												</div>
												<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_check_04.png" alt="4월 26일 오전 10시 가격이 터졌는지 확인하세요! 할인에 도전하신 분께 구매의 기회가 열립니다. 단 선착순입니다." /><span class="line"></span></p>
												<a href="#lyPreview4" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
											</div>
										<% elseif left(nowdate,10) = "2016-04-26" then %>
											<% if subscriptcount2 < 1 then %>
											<% else %>
												<%'' for dev msg : 참여 후 %>
												<div class="step step2">
													<div class="goal">
														<p>
															<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
															<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 10000명 가격이 터지기까지" />
														</p>
														<% if left(nowdate,10) = "2016-04-26" then %>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= beforepNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= beforegraph %>%;"></span>
															</div>
														<% else %>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= pNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= graph %>%;"></span>
															</div>
														<% end if %>
													</div>
													<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_check_04.png" alt="4월 26일 오전 10시 가격이 터졌는지 확인하세요! 할인에 도전하신 분께 구매의 기회가 열립니다. 단 선착순입니다." /><span class="line"></span></p>
													<a href="#lyPreview4" class="btnPreview"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_preview_small.png" alt="다음 상품 미리보기" /></a>
												</div>
											<% end if %>
										<% end if %>
									<% end if %>
	
									<%'' 내일의 할인 상품 %>
									<div id="lyPreview4" class="lyPreview">
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_item_tomorrow_04_v1.png" alt="마이뷰티다이어리 히알루론산 마스크팩 10pcs" /></p>
										<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_close.png" alt="내일의 할인 상품 레이어팝업 닫기" /></button>
									</div>

									<% if left(nowdate,10) = "2016-04-26" then %>
										<% If nowdate > #04/26/2016 10:00:00# Then %>
											<% if subscriptcount2 < 1 then %>
											<% else %>
												<%'' for dev msg : 당첨 후 %>
												<div class="step step3">
													<div class="btnGroup">
														<a href="" onclick="jsgetitem('1472250'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_get.png" alt="독일 보만 커피메이커와 오븐 쿠폰 받고 구매하러 가기" /><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></a>
													</div>
												</div>
											<% end if %>
										<% end if %>
									<% end if %>
								</div>
							<% end if %>

							<% if left(nowdate,10) =< "2016-04-29" then %>
								<%'' 상품5 %>
								<div id="item5" class="item" style="display:none">
									<p class="thumbnail">
										<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_item_05.png" alt="마이뷰티다이어리 히알루론산 마스크팩 10pcs 20,000원에서 5,000원으로" />
										<strong class="label">
											<span class="ribon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_ribon.png" alt="" /></span>
											<span class="sun spin"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_sun.png" alt="" /></span>
											<% if left(nowdate,10) = "2016-04-28" then %>
												<strong class="no"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_num_300.png" alt="선착순 300명" /></strong>
											<% else %>
												<strong class="no"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_num_limited.png" alt="선착순 한정수량" /></strong>
											<% end if %>
										</strong>
									</p>

									<% if subscriptcount1 < 1 then %>
										<% if left(nowdate,10) >= "2016-04-26" and left(nowdate,10) < "2016-04-28" then %>
											<%'' for dev msg : 참여하기 %>
											<div class="step step1">
												<div class="btnGroup">
													<button type="button" onclick="jssubmit(); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_challenge.png" alt="할인에 도전하기" /><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></button>
												</div>
											</div>
										<% elseif left(nowdate,10) = "2016-04-28" then %>
											<% If nowdate < #04/28/2016 10:00:00# Then %>
												<% if subscriptcount2 < 1 then %>
												<% else %>
													<%'' for dev msg : 참여 후 %>
													<div class="step step2">
														<div class="goal">
															<p>
																<%''for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
																<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 10000명 가격이 터지기까지" />
															</p>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= beforepNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= beforegraph %>%;"></span>
															</div>
														</div>
														<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_05.png" alt="목표인원이 달성되면 4월 28일 오전 10시 할인의 문이 열립니다! 단 선착순입니다." /><span class="line"></span></p>
													</div>
												<% end if %>
											<% end if %>
										<% end if %>
									<% else %>
										<% if left(nowdate,10) >= "2016-04-26" and left(nowdate,10) < "2016-04-28" then %>
											<%'' for dev msg : 참여 후 %>
											<div class="step step2">
												<div class="goal">
													<p>
														<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
														<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 10000명 가격이 터지기까지" />
													</p>
													<% if left(nowdate,10) = "2016-04-28" then %>
														<p class="count">
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
															<strong><%= beforepNum %></strong>
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
														</p>
														<div class="gage">
															<span style="width:<%= beforegraph %>%;"></span>
														</div>
													<% else %>
														<p class="count">
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
															<strong><%= pNum %></strong>
															<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
														</p>
														<div class="gage">
															<span style="width:<%= graph %>%;"></span>
														</div>
													<% end if %>
												</div>
												<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_05.png" alt="목표인원이 달성되면 4월 28일 오전 10시 할인의 문이 열립니다! 단 선착순입니다." /><span class="line"></span></p>
											</div>
										<% elseif left(nowdate,10) = "2016-04-28" then %>
											<% if subscriptcount2 < 1 then %>
											<% else %>
												<%'' for dev msg : 참여 후 %>
												<div class="step step2">
													<div class="goal">
														<p>
															<%'' for dev msg : 목표인원수는 상황에 따라 변동할수 있습니다. txt_goal_no_15000, txt_goal_no_20000 %>
															<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_goal_no_10000.png" alt="오늘의 목표 10000명 가격이 터지기까지" />
														</p>
														<% if left(nowdate,10) = "2016-04-28" then %>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= beforepNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= beforegraph %>%;"></span>
															</div>
														<% else %>
															<p class="count">
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_01.png" alt="" /></span>
																<strong><%= pNum %></strong>
																<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_count_02.png" alt="" /></span>
															</p>
															<div class="gage">
																<span style="width:<%= graph %>%;"></span>
															</div>
														<% end if %>
													</div>
													<p class="check"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/txt_date_05.png" alt="목표인원이 달성되면 4월 28일 오전 10시 할인의 문이 열립니다! 단 선착순입니다." /><span class="line"></span></p>
												</div>
											<% end if %>
										<% end if %>
									<% end if %>

									<% if left(nowdate,10) = "2016-04-28" then %>
										<% If nowdate > #04/28/2016 10:00:00# Then %>
											<% if subscriptcount2 < 1 then %>
											<% else %>
												<%'' for dev msg : 당첨 후 %>
												<div class="step step3">
													<div class="btnGroup">
														<a href="" onclick="jsgetitem('1472251'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/btn_get.png" alt="마이뷰티다이어리 히알루론산 마스크팩 쿠폰 받고 구매하러 가기" /><span class="hand"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/img_hand.png" alt="" /></span></a>
													</div>
												</div>
											<% end if %>
										<% end if %>
									<% end if %>
								</div>
							<% end if %>

							<div class="noti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70030/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>본 이벤트는 각 회차 당 할인에 도전한 사람에게만 해당 상품을 구매할 수 있는 기회가 주어집니다.</li>
										<li>구매는 목표인원이 달성된 후 다음 회차가 오픈되는 오전10시 이벤트 페이지 상단 날짜 탭에서 확인할 수 있습니다.</li>
										<li>각 상품은 한정수량이며 선착순으로 구매할 수 있습니다.</li>
										<li>구매자에게는 상품에 따라 세무신고에 필요한 개인정보를 요청할 수 있습니다. 제세공과금은 텐바이텐 부담입니다.</li>
										<li>본 이벤트의 상품은 즉시결제로만 구매가 가능하며, 배송 후 반품/교환/구매취소가 불가능합니다.</li>
									</ul>
								</div>
							</div>

							<!-- #include virtual="/event/4ten/sns.asp" -->

							<div id="dimmed"></div>
						</div>

					</div>
					<%'' //event area(이미지만 등록될때 / 수작업일때) %>
				</div>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->