<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [2016 정기세일] 티켓이 터진다 구매편
' History : 2016.04.19 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim evt_code, nowdate
Dim itemcodeguam, itemcodesebuIC, itemcodesebuBS, itemcodedanang, itemcodeosaka, itemcodehonol, itemcodehk, itemcodetai
nowdate = now()
'	nowdate = #04/21/2016 10:05:00#

IF application("Svr_Info") = "Dev" THEN
	evt_code   =  66106
	itemcodeguam		= "1239240"
	itemcodesebuIC	= "1239234"
	itemcodesebuBS	= "1239241"
	itemcodedanang	= "1239239"
	itemcodeosaka		= "1239238"
	itemcodehonol		= "1239237"
	itemcodehk			= "1239235"
	itemcodetai		= "1239236"
Else
	evt_code   =  70034
	if left(nowdate,10) < "2016-04-20" then
		itemcodeguam		= "1306357"
		itemcodesebuIC	= "1306357"
		itemcodesebuBS	= "1306357"
		itemcodedanang	= "1306357"
		itemcodeosaka		= "1306357"
		itemcodehonol		= "1306357"
		itemcodehk		= "1306357"
		itemcodetai		= "1306357"
	else
		itemcodeguam		= "1474931"
		itemcodesebuIC	= "1474923"
		itemcodesebuBS	= "1474929"
		itemcodedanang	= "1474928"
		itemcodeosaka		= "1474927"
		itemcodehonol		= "1474926"
		itemcodehk		= "1474925"
		itemcodetai		= "1474924"
	end if
End If

%>
<style type="text/css">
/* 4ten common */
img {vertical-align:top;}
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}

.fourtenTicket button {background-color:transparent;}

.topic {position:relative; padding-bottom:120px; background:#caf5e2 url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/bg_sky.jpg) no-repeat 50% 0;}
.topic .hill {position:absolute; bottom:430px; left:0; width:100%; height:280px; background-color:#c7e55f;}
.topic .hill .inner {position:absolute; bottom:0; left:0; width:100%; height:876px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_hill.png) no-repeat 50% 0;}
.topic .sea {position:absolute; bottom:0; left:0; width:100%; height:392px; padding-top:38px; background:#c3f2fa url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/bg_wave.png) repeat-x 0 0;}
.topic .sea .inner {height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/bg_sea.png) no-repeat 50% 0;}
.topic .frame {position:absolute; top:0; left:0; width:100%; height:520px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_flame.png) no-repeat 50% 0;}
.topic .frame {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:2.5s; animation-fill-mode:both;}
@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}

.topic .hgroup {position:relative; height:270px;}
.topic .hgroup h2 {position:absolute; top:46px; left:50%; margin-left:-297px;}
.topic .hgroup p {position:absolute; top:183px; left:50%; margin-left:-145px;}
.topic .hgroup .airplane {position:absolute; top:98px; left:50%; margin-left:285px;}
.topic .hgroup .airplane {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1s; transition:transform .7s ease;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.ticket {position:relative; z-index:5; width:994px; margin:0 auto; padding-top:70px;}
.ticket .special {position:absolute; top:0; left:22px;}
.ticket .tabTicket {position:relative; z-index:5; height:190px; padding-top:40px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/bg_box_top.png) no-repeat 0 0;}
.ticket .tabTicket .line {position:absolute; top:149px; left:50%; width:710px; height:2px; margin-left:-355px; background-color:#eee;}
.ticket .tabTicket ul {overflow:hidden; width:800px; margin:0 auto;}
.ticket .tabTicket ul li {float:left; width:64px; height:145px; margin-right:36px;}
.ticket .tabTicket ul li a,
.ticket .tabTicket ul li .coming {overflow:hidden; display:block; position:relative; height:145px; color:#fff; font-size:11px; line-height:11px; text-align:center;}
.ticket .tabTicket ul li a span,
.ticket .tabTicket ul li .coming span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_tab_v1.png); background-repeat:none;}
.ticket .tabTicket ul li .coming span {background-position:0 0;}
.ticket .tabTicket ul li a span {background-position:0 -146px;}
.ticket .tabTicket ul li .on {position:relative;}
.ticket .tabTicket ul li .on span {background-position:0 -292px;}
.ticket .tabTicket ul li .on i {position:absolute; top:0; left:50%; width:64px; height:88px; margin-left:-32px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_city.png) no-repeat 0 0;}
.ticket .tabTicket ul li .on i {animation-name:updown; animation-iteration-count:infinite; animation-duration:0.7s;}
@keyframes updown {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:3px;}
}
.ticket .tabTicket ul li .soldout {cursor:default;}
.ticket .tabTicket ul li .soldout span {background-position:0 100%;}
.ticket .tabTicket ul li .soldout i {display:none;}

.ticket .tabTicket ul li.ticket1 {margin-left:18px;}
.ticket .tabTicket ul li.ticket2 .coming span {background-position:-100px 0;}
.ticket .tabTicket ul li.ticket2 .on span {background-position:-100px -292px;}
.ticket .tabTicket ul li.ticket2 .on i {background-position:-100px 0;}
.ticket .tabTicket ul li.ticket2 a span {background-position:-100px -146px;}
.ticket .tabTicket ul li.ticket2 .soldout span {background-position:-100px 100%;}

.ticket .tabTicket ul li.ticket3 .coming span {background-position:-200px 0;}
.ticket .tabTicket ul li.ticket3 a span {background-position:-200px -146px;}
.ticket .tabTicket ul li.ticket3 .on span {background-position:-200px -292px;}
.ticket .tabTicket ul li.ticket3 .on i {background-position:-200px 0;}
.ticket .tabTicket ul li.ticket3 .soldout span {background-position:-200px 100%;}

.ticket .tabTicket ul li.ticket4 {width:74px;}
.ticket .tabTicket ul li.ticket4 .coming span {background-position:-295px 0;}
.ticket .tabTicket ul li.ticket4 a span {background-position:-295px -146px;}
.ticket .tabTicket ul li.ticket4 .on span {background-position:-295px -292px;}
.ticket .tabTicket ul li.ticket4 .on i {background-position:-300px 0;}
.ticket .tabTicket ul li.ticket4 .soldout span {background-position:-295px 100%;}

.ticket .tabTicket ul li.ticket5 .coming span {background-position:-400px 0;}
.ticket .tabTicket ul li.ticket5 a span {background-position:-400px -146px;}
.ticket .tabTicket ul li.ticket5 .on span {background-position:-400px -292px;}
.ticket .tabTicket ul li.ticket5 .on i {background-position:-400px 0;}
.ticket .tabTicket ul li.ticket5 .soldout span {background-position:-400px 100%;}

.ticket .tabTicket ul li.ticket6 .coming span {background-position:-500px 0;}
.ticket .tabTicket ul li.ticket6 a span {background-position:-500px -146px;}
.ticket .tabTicket ul li.ticket6 .on span {background-position:-500px -292px;}
.ticket .tabTicket ul li.ticket6 .on i {background-position:-500px 0;}
.ticket .tabTicket ul li.ticket6 .soldout span {background-position:-500px 100%;}

.ticket .tabTicket ul li.ticket7 .coming span {background-position:-600px 0;}
.ticket .tabTicket ul li.ticket7 a span {background-position:-600px -146px;}
.ticket .tabTicket ul li.ticket7 .on span {background-position:-600px -292px;}
.ticket .tabTicket ul li.ticket7 .on i {background-position:-600px 0;}
.ticket .tabTicket ul li.ticket7 .soldout span {background-position:-600px 100%;}

.ticket .tabTicket ul li.ticket8 {margin-right:0;}
.ticket .tabTicket ul li.ticket8 .coming span {background-position:-700px 0;}
.ticket .tabTicket ul li.ticket8 a span {background-position:-700px -146px;}
.ticket .tabTicket ul li.ticket8 .on span {background-position:-700px -292px;}
.ticket .tabTicket ul li.ticket8 .on i {background-position:-700px 0;}
.ticket .tabTicket ul li.ticket8 .soldout span {background-position:-700px 100%;}

.ticket .item {min-height:580px; padding-bottom:59px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/bg_box_mid.png) repeat-y 0 0;}

.ticket .slide {position:relative; width:800px; height:537px; margin:0 auto; background-color:#fff;}
.ticket .slide .slidesjs-slide {overflow:hidden; position:relative; width:800px; height:500px; background-color:#bebebe;}
.slide .slidesjs-navigation {position:absolute; bottom:0; left:50%; z-index:15; width:17px; height:17px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_nav.png); text-indent:-999em;}
.slide .slidesjs-previous {margin-left:-76px;}
.slide .slidesjs-next {margin-left:60px; background-position:100% 0;}
.slide .slidesjs-pagination {overflow:hidden; position:absolute; bottom:7px; left:0; z-index:10; width:100%; height:3px; text-align:center;}
.slide .slidesjs-pagination li {display:inline-block; *display:inline; *zoom:1; padding:0 5px;}
.slide .slidesjs-pagination li a {display:block; width:20px; height:3px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_pagination_blue.png) no-repeat 50% 0; transition:background 0.2s ease; text-indent:-999em;}
.slide .slidesjs-pagination li a.active {background-position:50% 100%;}

#item2 .slide .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_pagination_purple.png);}
#item3 .slide .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_pagination_green.png);}
#item4 .slide .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_pagination_red.png);}
#item5 .slide .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_pagination_sky.png);}
#item7 .slide .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_pagination_orange.png);}
#item8 .slide .slidesjs-pagination li a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_pagination_pink.png);}

.ticket .slide .date {position:absolute; top:216px; left:503px; z-index:10;}
.ticket .slide .city {position:absolute; top:389px; left:0; z-index:5; width:100%; text-align:center;}

.ticket .item .like {position:relative; margin-top:43px;}
.ticket .item .like .heart {position:absolute; top:0; left:105px;}
.pulse {animation-name:pulse; animation-duration:2s; animation-fill-mode:both; animation-iteration-count:infinite; transition:all 1s;}
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(0.8);}
	100% {transform:scale(1);}
}

.ticket .item .like .btnGet {position:absolute; top:7px; right:112px;}

.noti {background-color:#e1c287; text-align:left;}
.noti .inner {position:relative; width:1140px; margin:0 auto; padding:40px 0;}
.noti .inner h3 {position:absolute; top:50%; left:160px; margin-top:-12px;}
.noti .inner ul {padding-left:340px; color:#5a4846;}
.noti .inner ul li {margin-bottom:2px; padding-left:14px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/blt_dot.png) no-repeat 0 6px; color:#493612; font-family:'Dotum', 'Verdana'; font-size:12px; line-height:1.5em;}

.fourtenSns {position:relative; background-color:#84edc9;}
.fourtenSns button {overflow:hidden; position:absolute; top:40px; left:50%; width:225px; height:70px; background-color:rgba(0,0,0,0); text-indent:-9999em;}
.fourtenSns .ktShare {margin-left:90px;}
.fourtenSns .fbShare {margin-left:325px;}
</style>
<script type="text/javascript">
$(function(){
	<% if left(nowdate,10) < "2016-04-21" then %>
		$("#item1").show();
	<% elseif left(nowdate,10) = "2016-04-21" then %>
		$("#item2").show();
	<% elseif left(nowdate,10) = "2016-04-22" then %>
		$("#item3").show();
	<% elseif left(nowdate,10) = "2016-04-23" then %>
		$("#item4").show();
	<% elseif left(nowdate,10) = "2016-04-24" then %>
		$("#item8").show();
	<% elseif left(nowdate,10) = "2016-04-25" then %>
		$("#item2").show();
	<% elseif left(nowdate,10) >= "2016-04-26" then %>
		$("#item3").show();
	<% end if %>

	ticketAnimation();
	$("#animation .hgroup h2, #animation .hgroup p").css({"margin-top":"7px", "opacity":"0"});
	$("#animation .airplane").css({"top":"150px", "opacity":"0"});
	$("#animation .special").css({"top":"50px", "opacity":"0"});
	function ticketAnimation () {
		$("#animation .hgroup h2").delay(300).animate({"margin-top":"0", "opacity":"1",},500);
		$("#animation .hgroup p").delay(500).animate({"margin-top":"0", "opacity":"1",},500);
		$("#animation .airplane").delay(3000).animate({"top":"98px", "opacity":"1",},1000);
		$("#animation .special").delay(1500).animate({"top":"0", "opacity":"1"},1000);
	}

	/* slide js */
	$("#slide1").slidesjs({
		width:"800",
		height:"500",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	$("#slide2").slidesjs({
		width:"800",
		height:"500",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	$("#slide3").slidesjs({
		width:"800",
		height:"500",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	$("#slide4").slidesjs({
		width:"800",
		height:"500",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	$("#slide5").slidesjs({
		width:"800",
		height:"500",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	$("#slide6").slidesjs({
		width:"800",
		height:"500",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	$("#slide7").slidesjs({
		width:"800",
		height:"500",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

	$("#slide8").slidesjs({
		width:"800",
		height:"500",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});

});

function jsshow(numb){
	if(numb=="1"){
		$("#item1").show();
		$("#item2").hide();
		$("#item3").hide();
		$("#item4").hide();
		$("#item5").hide();
		$("#item6").hide();
		$("#item7").hide();
		$("#item8").hide();
	}else if(numb=="2"){
		$("#item1").hide();
		$("#item2").show();
		$("#item3").hide();
		$("#item4").hide();
		$("#item5").hide();
		$("#item6").hide();
		$("#item7").hide();
		$("#item8").hide();		
	}else if(numb=="3"){
		$("#item1").hide();
		$("#item2").hide();
		$("#item3").show();
		$("#item4").hide();
		$("#item5").hide();
		$("#item6").hide();
		$("#item7").hide();
		$("#item8").hide();
	}else if(numb=="4"){
		$("#item1").hide();
		$("#item2").hide();
		$("#item3").hide();
		$("#item4").show();
		$("#item5").hide();
		$("#item6").hide();
		$("#item7").hide();
		$("#item8").hide();		
	}else if(numb=="5"){
		$("#item1").hide();
		$("#item2").hide();
		$("#item3").hide();
		$("#item4").hide();
		$("#item5").show();
		$("#item6").hide();
		$("#item7").hide();
		$("#item8").hide();
	}else if(numb=="6"){
		$("#item1").hide();
		$("#item2").hide();
		$("#item3").hide();
		$("#item4").hide();
		$("#item5").hide();
		$("#item6").show();
		$("#item7").hide();
		$("#item8").hide();		
	}else if(numb=="7"){
		$("#item1").hide();
		$("#item2").hide();
		$("#item3").hide();
		$("#item4").hide();
		$("#item5").hide();
		$("#item6").hide();
		$("#item7").show();
		$("#item8").hide();	
	}else if(numb=="8"){
		$("#item1").hide();
		$("#item2").hide();
		$("#item3").hide();
		$("#item4").hide();
		$("#item5").hide();
		$("#item6").hide();
		$("#item7").hide();
		$("#item8").show();	
	}else{
		$("#item1").hide();
		$("#item2").hide();
		$("#item3").hide();
		$("#item4").hide();
		$("#item5").hide();
		$("#item6").hide();
		$("#item7").hide();
		$("#item8").hide();	
	}
}

function jsitemgo(iid){
	top.location.href="/shopping/category_prd.asp?itemid="+iid
}

</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt"><!-- for dev msg : 왼쪽메뉴(카테고리명) 사용시 클래스 : partEvt / 왼쪽메뉴(카테고리명) 사용 안할때 클래스 : fullEvt -->
		<div id="contentWrap">
			<div class="eventWrapV15">
				
				<div class="eventContV15">
					<!-- event area(이미지만 등록될때 / 수작업일때) -->
					<div class="contF contW">

						<!-- [W] 70031 티켓이 터진다 - 티저편 -->
						<div class="fourten fourtenTicket">
							<!-- nav -->
							<!-- #include virtual="/event/4ten/nav.asp" -->

							<div id="animation" class="topic">
								<div class="hill"><div class="inner"></div></div>
								<div class="sea"><div class="inner"></div></div>
								<div class="frame"></div>

								<div class="hgroup">
									<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/tit_ticket.png" alt="티켓이 터진다" /></h2>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/txt_collabo.png" alt="텐바이텐과 진에어가 함께하는 캐미터지는 패키지를 직접 확인해보세요!" /></p>
									<span class="airplane"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_airplane.png" alt="" /></span>
								</div>

								<div class="ticket">
									<p class="special"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_special_ticket.png" alt="스페셜 티켓 텐바이텐과 진에어" /></p>
								
									<div class="tabTicket">
										<span class="line"></span>
										<% If left(nowdate,10)>="2016-04-19" then %>
											<ul>
												<li class="ticket1">
													<%'' for dev msg : 오픈 당일  class="on / 솔드아웃 class="soldout" %>
													<a href="" <% if left(nowdate,10)>="2016-04-19" then %><% if left(nowdate,10)>"2016-04-20" then %><% if getitemlimitcnt(itemcodesebuIC) > 0 then %>onclick="jsitemgo('<%= itemcodesebuIC %>'); return false;"<% end if %><% else %>onclick="jsshow('1'); return false;"<% end if %><% end if %> class="<% if left(nowdate,10)="2016-04-20" then %>on<% else %><% end if %> <% if getitemlimitcnt(itemcodesebuIC) < 1 then %> soldout<% end if %>"><span></span>세부<i></i></a>
												</li>
												<li class="ticket2">
													<% if left(nowdate,10)<"2016-04-21" then %>
														<span class="coming"><span></span>홍콩<i></i></span>
													<% else %>
														<a href="" <% if left(nowdate,10)>="2016-04-21" then %><% if left(nowdate,10)>"2016-04-21" then %><% if getitemlimitcnt(itemcodehk) > 0 then %>onclick="jsitemgo('<%= itemcodehk %>'); return false;"<% end if %><% else %>onclick="jsshow('2'); return false;"<% end if %><% end if %> class="<% if left(nowdate,10)="2016-04-21" then %>on<% else %><% end if %> <% if getitemlimitcnt(itemcodehk) < 1 then %> soldout<% end if %>"><span></span>홍콩<i></i></a>
													<% end if %>
												</li>
												<li class="ticket3">
													<% if left(nowdate,10)<"2016-04-22" then %>
														<span class="coming"><span></span>타이페이</span>
													<% else %>
														<a href="" <% if left(nowdate,10)>="2016-04-22" then %><% if left(nowdate,10)>"2016-04-22" then %><% if getitemlimitcnt(itemcodetai) > 0 then %>onclick="jsitemgo('<%= itemcodetai %>'); return false;"<% end if %><% else %>onclick="jsshow('3'); return false;"<% end if %><% end if %> class="<% if left(nowdate,10)="2016-04-22" then %>on<% else %><% end if %> <% if getitemlimitcnt(itemcodetai) < 1 then %> soldout<% end if %>"><span></span>타이페이<i></i></a>
													<% end if %>
												</li>
												<li class="ticket4">
													<% if left(nowdate,10)<"2016-04-23" then %>
														<span class="coming"><span></span>오사카 부산출발</span>
													<% else %>
														<a href="" <% if left(nowdate,10)>="2016-04-23" then %><% if left(nowdate,10)>"2016-04-23" then %><% if getitemlimitcnt(itemcodeosaka) > 0 then %>onclick="jsitemgo('<%= itemcodeosaka %>'); return false;"<% end if %><% else %>onclick="jsshow('4'); return false;"<% end if %><% end if %> class="<% if left(nowdate,10)="2016-04-23" then %>on<% else %><% end if %> <% if getitemlimitcnt(itemcodeosaka) < 1 then %> soldout<% end if %>"><span></span>오사카 부산출발<i></i></a>
													<% end if %>
												</li>
												<li class="ticket5">
													<% if left(nowdate,10)<"2016-04-23" then %>
														<span class="coming"><span></span>다낭 부산출발</span>
													<% else %>
														<a href="" <% if left(nowdate,10)>="2016-04-23" then %><% if left(nowdate,10)>"2016-04-23" then %><% if getitemlimitcnt(itemcodedanang) > 0 then %>onclick="jsitemgo('<%= itemcodedanang %>'); return false;"<% end if %><% else %>onclick="jsshow('5'); return false;"<% end if %><% end if %> class="<% if left(nowdate,10)="2016-04-23" then %>on<% else %><% end if %> <% if getitemlimitcnt(itemcodedanang) < 1 then %> soldout<% end if %>"><span></span>다낭 부산출발<i></i></a>
													<% end if %>
												</li>
												<li class="ticket6">
													<% if left(nowdate,10)<"2016-04-23" then %>
														<span class="coming"><span></span>세부 부산출발</span>
													<% else %>
														<a href="" <% if left(nowdate,10)>="2016-04-23" then %><% if left(nowdate,10)>"2016-04-23" then %><% if getitemlimitcnt(itemcodesebuBS) > 0 then %>onclick="jsitemgo('<%= itemcodesebuBS %>'); return false;"<% end if %><% else %>onclick="jsshow('6'); return false;"<% end if %><% end if %> class="<% if left(nowdate,10)="2016-04-23" then %>on<% else %><% end if %> <% if getitemlimitcnt(itemcodesebuBS) < 1 then %> soldout<% end if %>"><span></span>세부 부산출발<i></i></a>
													<% end if %>
												</li>
												<li class="ticket7">
													<% if left(nowdate,10)<"2016-04-23" then %>
														<span class="coming"><span></span>괌 부산출발</span>
													<% else %>
														<a href="" <% if left(nowdate,10)>="2016-04-23" then %><% if left(nowdate,10)>"2016-04-23" then %><% if getitemlimitcnt(itemcodeguam) > 0 then %>onclick="jsitemgo('<%= itemcodeguam %>'); return false;"<% end if %><% else %>onclick="jsshow('7'); return false;"<% end if %><% end if %> class="<% if left(nowdate,10)="2016-04-23" then %>on<% else %><% end if %> <% if getitemlimitcnt(itemcodeguam) < 1 then %> soldout<% end if %>"><span></span>괌 부산출발<i></i></a>
													<% end if %>
												</li>
												<li class="ticket8">
													<% if left(nowdate,10)<"2016-04-24" then %>
														<span class="coming"><span></span>호놀룰루</span>
													<% else %>
														<a href="" <% if left(nowdate,10)>="2016-04-24" then %><% if left(nowdate,10)>"2016-04-24" then %><% if getitemlimitcnt(itemcodehonol) > 0 then %>onclick="jsitemgo('<%= itemcodehonol %>'); return false;"<% end if %><% else %>onclick="jsshow('8'); return false;"<% end if %><% end if %> class="<% if left(nowdate,10)="2016-04-24" then %>on<% else %><% end if %> <% if getitemlimitcnt(itemcodehonol) < 1 then %> soldout<% end if %>"><span></span>호놀룰루<i></i></a>
													<% end if %>
												</li>
											</ul>
										<% end if %>
									</div>

									<% if left(nowdate,10)>="2016-04-19" then %>
										<%'' 세부 20 %>
										<div id="item1" class="item" style="display:none">
											<div id="slide1" class="slide">
												<div class="slidesjs-slide">
													<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_cebu_01.png" alt="세부" />
													<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_incheon_to_cebu_v1.png" alt="인천 to 세부 214,500원 부터" /></p>
												</div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_cebu_02.jpg" alt="상품 중 5종 이상 랜덤 구성" /></div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_cebu_03.jpg" alt="" /></div>
											</div>
											<div class="like">
												<span class="heart pulse"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/ico_heart.png" alt="" /></span>
												<a href="/shopping/category_prd.asp?itemid=<%= itemcodesebuIC %>" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_get.png" alt="구매하러 가기" /></a>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/txt_msg_cebu.png" alt="#인천 #세부 #214,500 #텐바이텐 #진에어 #왕복 #티켓 #한정수량  #60석 #스페셜티켓시리즈 #1 #나혼자떠나는즐거움 #혼자서도당당하게 #솔로티켓 #나혼자여행 #초특가 #여행은 #텐바이텐과 함께 #재미있게 진에어" /></p>
											</div>
										</div>
									<% end if %>

									<% if left(nowdate,10)>="2016-04-21" then %>
										<%'' 홍콩 21 %>
										<div id="item2" class="item" style="display:none">
											<div id="slide2" class="slide">
												<div class="slidesjs-slide">
													<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_hongkong_01.png" alt="홍콩" />
													<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_incheon_to_hongkong_v1.png" alt="인천 to 홍콩 229,500원 부터" /></p>
												</div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_hongkong_02.jpg" alt="상품 중 5종 이상 랜덤 구성" /></div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_hongkong_03.jpg" alt="" /></div>
											</div>
											<div class="like">
												<span class="heart pulse"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/ico_heart.png" alt="" /></span>
												<a href="/shopping/category_prd.asp?itemid=<%= itemcodehk %>" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_get.png" alt="구매하러 가기" /></a>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/txt_msg_hongkong.png" alt="#인천 #홍콩 #229,500 #텐바이텐 #진에어 #왕복 #티켓 #한정수량  #100석 #스페셜티켓시리즈  #1  #나혼자떠나는즐거움  #혼자서도당당하게 #솔로티켓 #나혼자여행 #초특가 #여행은 #텐바이텐과 함께 #재미있게 진에어" /></p>
											</div>
										</div>
									<% end if %>

									<% if left(nowdate,10)>="2016-04-22" then %>
										<%'' 타이페이 22 %>
										<div id="item3" class="item" style="display:none">
											<div id="slide3" class="slide">
												<div class="slidesjs-slide">
													<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_taipei_01.png" alt="타이페이" />
													<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_incheon_to_taipei_v1.png" alt="인천 to 타이페이 252,500원 부터" /></p>
												</div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_taipei_02.jpg" alt="상품 중 5종 이상 랜덤 구성" /></div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_taipei_03.jpg" alt="" /></div>
											</div>
											<div class="like">
												<span class="heart pulse"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/ico_heart.png" alt="" /></span>
												<a href="/shopping/category_prd.asp?itemid=<%= itemcodetai %>" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_get.png" alt="구매하러 가기" /></a>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/txt_msg_taipei.png" alt="#인천 #타이베이 #252,500 #텐바이텐 #진에어 #왕복 #티켓 #한정수량  #100석 #스페셜티켓시리즈 #1 #나혼자떠나는즐거움 #혼자서도당당하게 #솔로티켓 #나혼자여행 #초특가 #여행은  #텐바이텐과 함께 #재미있게 진에어" /></p>
											</div>
										</div>
									<% end if %>

									<% if left(nowdate,10)>="2016-04-23" then %>
										<%'' 부산 to 오사카 23 %>
										<div id="item4" class="item" style="display:none">
											<div id="slide4" class="slide">
												<div class="slidesjs-slide">
													<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_osaka_01.png" alt="오사카" />
													<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_busan_to_osaka_v1.png" alt="부산 to 오사카 161,100원 부터" /></p>
												</div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_osaka_02.jpg" alt="상품 중 5종 이상 랜덤 구성" /></div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_osaka_03.jpg" alt="" /></div>
											</div>
											<div class="like">
												<span class="heart pulse"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/ico_heart.png" alt="" /></span>
												<a href="/shopping/category_prd.asp?itemid=<%= itemcodeosaka %>" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_get.png" alt="구매하러 가기" /></a>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/txt_msg_osaka.png" alt="#부산 #오사카 #161,100 #텐바이텐 #진에어 #왕복 #티켓 #한정수량  #50석 #스페셜티켓시리즈 #1 #나혼자떠나는즐거움 #혼자서도당당하게 #솔로티켓 #나혼자여행 #초특가 #여행은 #텐바이텐과 함께 #재미있게 진에어" /></p>
											</div>
										</div>

										<%'' 부산 to 다낭 23 %>
										<div id="item5" class="item" style="display:none">
											<div id="slide5" class="slide">
												<div class="slidesjs-slide">
													<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_danang_01.png" alt="다낭" />
													<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_busan_to_danang_v1.png" alt="부산 to 다낭 270,100원 부터" /></p>
												</div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_danang_02.jpg" alt="상품 중 5종 이상 랜덤 구성" /></div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_danang_03.jpg" alt="" /></div>
											</div>
											<div class="like">
												<span class="heart pulse"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/ico_heart.png" alt="" /></span>
												<a href="/shopping/category_prd.asp?itemid=<%= itemcodedanang %>" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_get.png" alt="구매하러 가기" /></a>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/txt_msg_danang.png" alt="#부산 #다낭 #270,100 #텐바이텐 #진에어 #왕복 #티켓 #한정수량 #20석 #스페셜티켓시리즈 #1 #나혼자떠나는즐거움  #혼자서도당당하게 #솔로티켓 #나혼자여행 #초특가 #여행은  #텐바이텐과 함께  #재미있게 진에어" /></p>
											</div>
										</div>

										<%'' 부산 to 세부 23 %>
										<div id="item6" class="item" style="display:none">
											<div id="slide6" class="slide">
												<div class="slidesjs-slide">
													<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_cebu_01.png" alt="세부" />
													<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_busan_to_cebu_v3.png" alt="부산 to 세부 229,500원 부터" /></p>
												</div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_cebu_02.jpg" alt="상품 중 5종 이상 랜덤 구성" /></div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_cebu_03.jpg" alt="" /></div>
											</div>
											<div class="like">
												<span class="heart pulse"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/ico_heart.png" alt="" /></span>
												<a href="/shopping/category_prd.asp?itemid=<%= itemcodesebuBS %>" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_get.png" alt="구매하러 가기" /></a>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/txt_msg_cebu_busan.png" alt="#부산 #세부 #229,500 #텐바이텐 #진에어 #왕복 #티켓 #한정수량 #20석 #스페셜티켓시리즈 #1 #나혼자떠나는즐거움 #혼자서도당당하게 #솔로티켓 #나혼자여행 #초특가 #여행은 #텐바이텐과 함께 #재미있게 진에어" /></p>
											</div>
										</div>

										<%'' 부산 to 괌 23 %>
										<div id="item7" class="item" style="display:none">
											<div id="slide7" class="slide">
												<div class="slidesjs-slide">
													<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_guam_01.png" alt="괌" />
													<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_busan_to_guam_v1.png" alt="부산 to 괌 297,400원 부터" /></p>
												</div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_guam_02.jpg" alt="상품 중 5종 이상 랜덤 구성" /></div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_guam_03.jpg" alt="" /></div>
											</div>
											<div class="like">
												<span class="heart pulse"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/ico_heart.png" alt="" /></span>
												<a href="/shopping/category_prd.asp?itemid=<%= itemcodeguam %>" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_get.png" alt="구매하러 가기" /></a>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/txt_msg_guam.png" alt="#부산 #괌 #267,400 #텐바이텐 #진에어 #왕복 #티켓 #한정수량 #10석 #스페셜티켓시리즈 #1 #나혼자떠나는즐거움 #혼자서도당당하게 #솔로티켓 #나혼자여행 #초특가 #여행은 #텐바이텐과 함께 #재미있게 진에어" /></p>
											</div>
										</div>
									<% end if %>

									<% if left(nowdate,10)>="2016-04-24" then %>
										<%'' 호노룰루 24 %>
										<div id="item8" class="item" style="display:none">
											<div id="slide8" class="slide">
												<div class="slidesjs-slide">
													<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_honolulu_01.png" alt="호노룰루" />
													<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_incheon_to_honolulu_v1.png" alt="인천 to 호노룰루 517,600원 부터" /></p>
												</div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_honolulu_02.jpg" alt="상품 중 5종 이상 랜덤 구성" /></div>
												<div class="slidesjs-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/img_slide_honolulu_03.jpg" alt="" /></div>
											</div>
											<div class="like">
												<span class="heart pulse"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/ico_heart.png" alt="" /></span>
												<a href="/shopping/category_prd.asp?itemid=<%= itemcodehonol %>" class="btnGet"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/btn_get.png" alt="구매하러 가기" /></a>
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70034/txt_msg_honolulu.png" alt="#인천 #호놀룰루 #517,600 #텐바이텐 #진에어 #왕복 #티켓 #한정수량  #40석 #스페셜티켓시리즈 #1 #나혼자떠나는즐거움 #혼자서도당당하게 #솔로티켓 #나혼자여행 #초특가 #여행은 #텐바이텐과 함께 #재미있게 진에어" /></p>
											</div>
										</div>
									<% end if %>

									<p><a href="https://www.instagram.com/your10x10/" target="_blank" title="텐바이텐 인스타그램 새창 열림"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_instagram.png" alt="#재미있게진에어 #텐바이텐과함께 인스타그램에 솔로티켓 패키지 인증샷을 올려주세요" /></a></p>
								</div>
							</div>

							<!-- #include virtual="/event/4ten/sns.asp" -->
						</div>

					</div>
					<!-- //event area(이미지만 등록될때 / 수작업일때) -->
				</div>
			</div>
		</div>
	</div>

	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->