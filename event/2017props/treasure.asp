<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
'####################################################
' Description : 숨은 보물 찾기
' History : 2017-03-30 유태욱
'####################################################
dim currenttime , i, myevtcnt, userid, eCode, sqlstr, myevtdaycnt
	currenttime = date()
'																			currenttime="2017-04-17"

	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=77062" & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			REsponse.End
		end if
	end if
end if

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66294
	Else
		eCode   =  77062
	End If

	userid = GetEncLoginUserID()
	myevtcnt = 0
	myevtdaycnt = 0

if userid <> "" then
	myevtcnt = getevent_subscriptexistscount(eCode,userid,"","","")

	sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& eCode &" and userid='"& userid &"' and datediff(day,regdate,getdate()) = 0 "
	rsget.Open sqlstr, dbget, 1
		myevtdaycnt = rsget(0)
	rsget.close
end if
%>
<!-- #include virtual="/event/2017props/sns.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- <base href="http://www.10x10.co.kr/"> -->
<style type="text/css">
.treasure button {background-color:transparent;}
.treasure .article {position:relative; height:1010px; background:#87cee5 url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/bg_sea.png) 50% 0 repeat;}
.treasure .article h2 {position:relative; z-index:5; padding-top:110px;}
.treasure .article h2 + p {margin-top:39px;}
.treasure .day {position:absolute; top:61px; left:50%; margin-left:-261px;}

.btnGuide {position:absolute; top:676px; left:50%; z-index:20; margin-left:203px;}

.hint {position:relative; z-index:10; height:563px; margin-top:54px;}
.hint .nav {position:absolute; bottom:0; left:50%; overflow:hidden; width:1148px; height:75px; margin-left:-574px; padding-top:20px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/bg_nav.png) no-repeat 5px 30px;}
.hint .nav li {float:left; width:56px; height:75px; margin:0 11px;}
.hint .nav li.date01 {margin-left:0;}
.hint .nav li.date15 {margin-right:0;}
.hint .nav li a {display:block; position:relative; width:100%; height:100%; color:#000; font-size:12px; line-height:75px; text-align:center; cursor:pointer;}
.hint .nav li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_nav.png) no-repeat 0 0;}
.hint .nav li a.on span {background-position:0 100%;}
.hint .nav li a i {display:none; position:absolute; top:-20px; left:50%; margin-left:-23px;}
.hint .nav li a i {animation:bouncing 2s cubic-bezier(0.19, 1, 0.22, 1) forwards infinite;}
@keyframes bouncing {
	0% {transform:translateY(5px);}
	100% {transform:translateY(0);}
}

.hint .nav li a.today i {display:block;}
.hint .nav li.date02 a span {background-position:-78px 0;}
.hint .nav li.date02 a.on span {background-position:-78px 100%;}
.hint .nav li.date03 a span {background-position:-156px 0;}
.hint .nav li.date03 a.on span {background-position:-156px 100%;}
.hint .nav li.date04 a span {background-position:-233px 0;}
.hint .nav li.date04 a.on span {background-position:-233px 100%;}
.hint .nav li.date05 a span {background-position:-311px 0;}
.hint .nav li.date05 a.on span {background-position:-311px 100%;}
.hint .nav li.date06 a span {background-position:-389px 0;}
.hint .nav li.date06 a.on span {background-position:-389px 100%;}
.hint .nav li.date07 a span {background-position:-467px 0;}
.hint .nav li.date07 a.on span {background-position:-467px 100%;}
.hint .nav li.date08 a span {background-position:-545px 0;}
.hint .nav li.date08 a.on span {background-position:-545px 100%;}
.hint .nav li.date09 a span {background-position:-622px 0;}
.hint .nav li.date09 a.on span {background-position:-622px 100%;}
.hint .nav li.date10 a span {background-position:-700px 0;}
.hint .nav li.date10 a.on span {background-position:-700px 100%;}
.hint .nav li.date11 a span {background-position:-778px 0;}
.hint .nav li.date11 a.on span {background-position:-778px 100%;}
.hint .nav li.date12 a span {background-position:-856px 0;}
.hint .nav li.date12 a.on span {background-position:-856px 100%;}
.hint .nav li.date13 a span {background-position:-933px 0;}
.hint .nav li.date13 a.on span {background-position:-933px 100%;}
.hint .nav li.date14 a span {background-position:-1011px 0;}
.hint .nav li.date14 a.on span {background-position:-1011px 100%;}
.hint .nav li.date15 a span {background-position:100% 0;}
.hint .nav li.date15 a.on span {background-position:100% 100%;}

.hint .tabcont {position:relative; width:730px; margin:0 auto;}

.check {position:absolute; top:115px; left:130px; z-index:5;}
#tabcont02 .check {left:139px;}
#tabcont03 .check,
#tabcont04 .check {left:120px;}
#tabcont05 .check {left:125px;}
#tabcont06 .check {left:119px;}
#tabcont07 .check {left:139px;}
#tabcont08 .check {left:139px;}
#tabcont09 .check {left:134px;}
#tabcont10 .check {left:94px;}
#tabcont11 .check {left:119px;}
#tabcont12 .check {left:126px;}
#tabcont13 .check {left:131px;}
#tabcont14 .check {left:109px;}
#tabcont15 .check {left:139px;}
.check span {display:block; margin-top:42px; opacity:0; filter:alpha(opacity=100);}
.check span:first-child {margin-top:0;}
.check span:nth-child(2) {animation-delay:0.8s; -webkit-animation-delay:0.8s;}
.check span:nth-child(3) {animation-delay:1.6s; -webkit-animation-delay:1.6s;}
.slideUp {
	animation:slideUp 1.6s cubic-bezier(0.19, 1, 0.22, 1) forwards;
	-webkit-animation:slideUp 1.6s cubic-bezier(0.19, 1, 0.22, 1) forwards;
}
@keyframes slideUp {
	0% {transform:translateY(-20px); opacity:0;}
	100% {transform:translateY(0); opacity:1;}
}

.line {position:absolute; top:142px; left:173px; z-index:5; width:98px; text-align:left;}
#tabcont02 .line {left:182px;}
#tabcont03 .line,
#tabcont04 .line {left:163px;}
#tabcont05 .line {left:167px;}
#tabcont06 .line {left:162px;}
#tabcont07 .line {left:182px;}
#tabcont08 .line {left:182px;}
#tabcont09 .line {left:177px;}
#tabcont10 .line {left:137px;}
#tabcont11 .line {left:162px;}
#tabcont12 .line {left:169px;}
#tabcont13 .line {left:174px;}
#tabcont14 .line {left:152px;}
#tabcont15 .line {left:182px;}
.line span {display:block; width:100%; height:3px; margin-top:62px; background-color:#ff9f42; transform-origin:0 0; opacity:0; filter:alpha(opacity=100);}
.line span:first-child {margin-top:0;}
.line .line2, .line .line3 {width:70px;}
.line .line3 {margin-top:57px;}
#tabcont02 .line span,
#tabcont07 .line span,
#tabcont12 .line span {background-color:#bb68cc;}
#tabcont02 .line .line1 {width:46px;}
#tabcont03 .line span,
#tabcont08 .line span,
#tabcont13 .line span {background-color:#f8536a;}
#tabcont03 .line .line1 {width:120px;}
#tabcont04 .line span,
#tabcont09 .line span,
#tabcont14 .line span {background-color:#3280d0;}
#tabcont04 .line .line1 {width:121px;}
#tabcont04 .line .line2 {width:101px;}
#tabcont05 .line span,
#tabcont10 .line span,
#tabcont15 .line span {background-color:#54a915;}
#tabcont05 .line .line1 {width:110px;}
#tabcont06 .line .line1 {width:120px;}
#tabcont07 .line .line1 {width:48px;}
#tabcont07 .line .line2 {width:116px;}
#tabcont08 .line .line1 {width:48px;}
#tabcont09 .line .line1 {width:88px;}
#tabcont09 .line .line2 {width:90px;}
#tabcont10 .line .line1 {width:173px;}
#tabcont11 .line .line1 {width:120px;}
#tabcont11 .line .line2 {width:90px;}
#tabcont12 .line .line1 {width:108px;}
#tabcont12 .line .line2 {width:136px;}
#tabcont14 .line .line1 {width:142px;}
#tabcont14 .line .line2 {width:110px;}
#tabcont15 .line .line1,
#tabcont15 .line .line2 {width:48px;}

.line span:nth-child(2) {animation-delay:1s;}
.line span:nth-child(3) {animation-delay:2s;}
.scaleX {animation:scaleX 1.2s cubic-bezier(0.19, 1, 0.22, 1) forwards;}

.btnGo {position:absolute; bottom:47px; left:105px; z-index:5; width:300px; height:60px;}
.btnGo span {position:absolute; top:50%; right:73px; margin-top:-6px;}

.count {position:absolute; top:86px; left:50%; width:108px; margin-left:201px;}
.count span:first-child {display:block;}
.count .no {height:42px; margin-top:52px;}
.count b {margin-right:8px; color:#fffe83; font-family:'Helvetica Neue', Helvetica, Arial, sans-serif; font-size:50px; line-height:38px;}

.object {position:absolute; left:50%;}
.whale {top:395px; margin-left:-728px;}
.cloud1 {top:226px; margin-left:-800px;}
.cloud2 {top:517px; margin-left:-736px; animation:moveX 1.5s infinite alternate; animation-delay:0.5s;}
.gull1 {top:204px; margin-left:-880px;}
.gull2 {top:197px; margin-left:722px; animation:moveY 1.5s infinite alternate; animation-delay:0.5s;}
.present1 {top:211px; margin-left:-585px;}
.present2 {top:47px; margin-left:622px;}

.evtNoti {background:#88d0e8 url(http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/bg_pattern_zigzag.png) 50% 0 repeat;}

.lyContent {display:block; position:fixed; *position:absolute; top:50%; left:50%; z-index:105; width:990px; height:480px; margin:-240px 0 0 -495px;}
.lyContent .btnClose {position:absolute; top:0; right:0; padding:30px;}
.lyContent .btnClose img {transition:transform .7s ease;}
.lyContent .btnClose:active img {transform:rotate(-180deg);}
#dimmed {display:block; *display:none !important; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background-color:#000; opacity:0.6; filter:alpha(opacity=60);}

/* css3 animation */
.swing {animation:swing 5s infinite;  animation-fill-mode:both; transform-origin:0 50%;}
@keyframes swing {
	0% {transform:rotateZ(0deg);}
	30% {transform:rotateZ(3deg);}
	60% {transform:rotateZ(3deg);}
	100% {transform:rotateZ(0deg);}
}
@keyframes scaleX {
	0% {transform:scaleX(0); opacity:0;}
	100% {transform:scaleX(1); opacity:1;}
}
.down1 {animation:down1 8s alternate; animation-fill-mode:both;}
@keyframes down1 {
	0% {top:0; margin-left:-658px; animation-timing-function:linear;}
	100% {top:211px; animation-timing-function:linear;}
}
.down2 {animation:down2 3s alternate; animation-fill-mode:both;}
@keyframes down2 {
	0% {top:-10px; margin-left:700px; animation-timing-function:linear;}
	100% {top:47px; margin-left:622px; animation-timing-function:linear;}
}
</style>
<script type="text/javascript">
$(function(){
	/* layer */
	var wrapHeight = $(document).height();
	$(".btnGuide a").click(function(){
		$("#lyGuide").show();
		$("#dimmed").show();
		$("#dimmed").css("height",wrapHeight);
	});

	$("#lyGuide .btnClose, #dimmed").click(function(){
		$("#lyGuide").hide();
		$("#dimmed").fadeOut();
		$(".hint .check span").addClass("slideUp");
		$(".hint .line span").addClass("scaleX");
		$(".btnGo span").addClass("move");
	});

	$(".hint .tabcontainer").find(".tabcont").hide();
	$(".hint").each(function(){
		var checkItem = $(this).children(".nav").children("li").length;
		if (checkItem == 1) {
			$(".hint .tabcontainer .tabcont:nth-child(1)").show();
		}
		if (checkItem == 2) {
			$(".hint .tabcontainer .tabcont:nth-child(2)").show();
		}
		if (checkItem == 3) {
			$(".hint .tabcontainer .tabcont:nth-child(3)").show();
		}
		if (checkItem == 4) {
			$(".hint .tabcontainer .tabcont:nth-child(4)").show();
		}
		if (checkItem == 5) {
			$(".hint .tabcontainer .tabcont:nth-child(5)").show();
		}
		if (checkItem == 6) {
			$(".hint .tabcontainer .tabcont:nth-child(6)").show();
		}
		if (checkItem == 7) {
			$(".hint .tabcontainer .tabcont:nth-child(7)").show();
		}
		if (checkItem == 8) {
			$(".hint .tabcontainer .tabcont:nth-child(8)").show();
		}
		if (checkItem == 9) {
			$(".hint .tabcontainer .tabcont:nth-child(9)").show();
		}
		if (checkItem == 10) {
			$(".hint .tabcontainer .tabcont:nth-child(10)").show();
		}
		if (checkItem == 11) {
			$(".hint .tabcontainer .tabcont:nth-child(11)").show();
		}
		if (checkItem == 12) {
			$(".hint .tabcontainer .tabcont:nth-child(12)").show();
		}
		if (checkItem == 13) {
			$(".hint .tabcontainer .tabcont:nth-child(13)").show();
		}
		if (checkItem == 14) {
			$(".hint .tabcontainer .tabcont:nth-child(14)").show();
		}
		if (checkItem == 15) {
			$(".hint .tabcontainer .tabcont:nth-child(15)").show();
		}
	});
	
	$(".hint .nav li a").on("click",function(){
		$(".hint .nav li a").removeClass("on");
		$(this).addClass("on");
		var thisCont = $(this).attr("href");
		$(".hint .tabcontainer").find(".tabcont").hide();
		$(".hint .tabcontainer").find(thisCont).show();

		$(".hint .check span").addClass("slideUp");
		$(".hint .line span").addClass("scaleX");
		$(".btnGo span").addClass("move");
		return false;
	});

	<% if myevtdaycnt > 0 then '데일리로 변경 요함 %>
		$("#lyGuide").hide();
		$("#dimmed").fadeOut();
		$(".hint .check span").addClass("slideUp");
		$(".hint .line span").addClass("scaleX");
		$(".btnGo span").addClass("move");
	<% end if %>

});
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
						<div class="sopum treasure">
							<!-- #include virtual="/event/2017props/head.asp" -->
							<div class="article">
								<div id="lyGuide" class="lyContent">
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/txt_guide.png" alt="보물찾으러 GO 버튼을 눌러 이동 후 상품 리스트에서 보물을 찾는다. 보물을 선택한 후 팝업창에서 응모하면 완료!" /></p>
									<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_close.png" alt="닫기" /></button>
								</div>

								<p class="day swing"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/txt_15_days.png" alt="하루에 하나씩 15일 동안" /></p>
								<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/tit_treasure.png" alt="숨은 보물 찾기" /></h2>
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/txt_subcopy.png" alt="일별로 주어진 힌트를 보고 텐바이텐에 숨겨진 보물을 찾으세요! 당첨자 총 100명, 발표 4월 20일" /></p>

								<div class="btnGuide">
									<a href="#lyGuide"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_guide.png" alt="보물 찾는 방법" /></a>
								</div>

								<span class="object whale"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_whale.gif" alt="" /></span>
								<span class="object cloud cloud1 moveX"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_cloud_01.png" alt="" /></span>
								<span class="object cloud cloud2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_cloud_02.png" alt="" /></span>
								<span class="object gull gull1 moveY"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_gull_01.png" alt="" /></span>
								<span class="object gull gull2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_gull_02.png" alt="" /></span>
								<span class="object present present1 down1"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_present_01.png" alt="" /></span>
								<span class="object present present2 down2"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_present_02.png" alt="" /></span>

								<div class="hint">
									<ul class="nav">
									<%
									dim currentDate2, ii
									for ii = 0 to 14
										currentDate2 = DateAdd("d", (ii), "2017-04-03")
										If datediff("d", currenttime, currentDate2) <= 0 Then
									%>
											<li class="date<%=chkiif((ii+1)<10,"0"&(ii+1),(ii+1))%>"><a href="#tabcont<%=chkiif((ii+1)<10,"0"&(ii+1),(ii+1))%>" <%=chkIIF(trim(currenttime)=trim(currentDate2),"class='today on'","")%>><span></span>4월 <%=ii+3%>일<i><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_open.png" alt="open" /></i></a></li>
									<%
										end If
									next
									%>

									</ul>

									<div class="tabcontainer">
										<% if left(currenttime,10) >= "2017-04-03" then %>
											<div id="tabcont01" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0403.png" alt="4월 3일 힌트 가구/조명 카테고리에서 무드등 상품 중 주황색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=121101109&gaparam=furniture_subcate_121101109" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-04" then %>
											<div id="tabcont02" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0404.png" alt="4월 4일 힌트 피규어/프라모델 카테고리 상품 중 보라색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=104101&gaparam=toy_subcate_104101" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-05" then %>
											<div id="tabcont03" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0405.png" alt="4월 5일 데코/플라워 카테고리에서 디퓨져 상품 중 핑크색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=122106&gaparam=deco_subcate_122106" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-06" then %>
											<div id="tabcont04" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0406.png" alt="4월 6일 캠핑/트래블 카테고리에서 텐트/타프 상품 중 파랑색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=103107101" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-07" then %>
											<div id="tabcont05" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0407.png" alt="4월 7일 디자인문구 카테고리에서 필기구 상품 중 초록색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=101104101" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-08" then %>
											<div id="tabcont06" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0408.png" alt="4월 8일 패브릭/수납 카테고리에서 수납장 상품 중 주황색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=120109104101" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-09" then %>
											<div id="tabcont07" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0409.png" alt="4월 9일 키친 카테고리에서 피크닉매트 상품 중 보라색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=112108107" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-10" then %>
											<div id="tabcont08" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0410.png" alt="4월 10일 힌트 푸드 카테고리에서 견과류 상품 중 핑크색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=119104101" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-11" then %>
											<div id="tabcont09" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0411.png" alt="4월 11일 패션의류 카테고리에서 생활한복 상품 중 파랑색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=117102109" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-12" then %>
											<div id="tabcont10" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0412.png" alt="4월 12일 힌트 가방/슈즈/주얼리 카테고리에서 에코백 상품 중 초록색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=116101101" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-13" then %>
											<div id="tabcont11" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0413.png" alt="4월 13일 힌트 베이비/키즈 카테고리에서 봉제인형 상품 중 주황색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=115107106" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-14" then %>
											<div id="tabcont12" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0414.png" alt="4월 14일 힌트 Cat&amp;Dog 카테고리에서 플레이장난감 상품 중 보라색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=110112103" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-15" then %>
											<div id="tabcont13" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0415.png" alt="4월 15일 힌트 가구/조명 카테고리에서 타공판 상품 중 핑크색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=121113109" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-16" then %>
											<div id="tabcont14" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0416.png" alt="4월 16일 힌트 디지털/핸드폰 카테고리에서 usb선풍기 상품 중 파랑색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=102110103101" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>

										<% if left(currenttime,10) >= "2017-04-17" then %>
											<div id="tabcont15" class="tabcont">
												<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/img_hint_0417.png" alt="4월 17일 힌트 키친 카테고리에서 티팟 상품 중 초록색박스를 찾아라!" /></p>
												<div class="check">
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
													<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/ico_check.png" alt="" /></span>
												</div>
												<div class="line"><span class="line1"></span><span class="line2"></span><span class="line3"></span></div>
												<a href="/shopping/category_list.asp?disp=112101102" class="btnGo"><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go.png" alt="보물찾으러 Go" /><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/btn_go_arrow.png" alt="" /></span></a>
											</div>
										<% end if %>
									</div>

									<!-- count -->
									<div class="count">
										<span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/txt_score_01.png" alt="보물찾기 SCORE" /></span>
										<div class="no"><b><%=myevtcnt%></b><span><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77062/txt_score_02.png" alt="개" /></span></div>
									</div>
								</div>
							</div>

							<div class="evtNoti">
								<div class="inner">
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/sopum/77061/tit_noti.png" alt="유의사항" /></h3>
									<ul>
										<li>본 이벤트는 ID당 하루에 한 번 응모 가능합니다.</li>
										<li>당첨자는 이벤트 기간 동안 총 100명으로, 4월 20일 공지사항을 통해 발표합니다.</li>
										<li>보물힌트는 하루에 하나씩 공개됩니다.</li>
									</ul>
								</div>
							</div>

							<%'!-- sns --%>
							<div class="sns"><%=snsHtml%></div>
							<%'!-- sns --%>

							<div id="dimmed"></div>
						</div>
						<!--// 소품전 -->

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