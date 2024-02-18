<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : PLAYing 감나와라
' History : 2016-11-10 유태욱 생성
'####################################################
Dim eCode , LoginUserid, myresultCnt, vQuery, myKitCnt, lovecnt, workcnt, myKitgubun
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66233
Else
	eCode   =  74346
End If

lovecnt = 0
workcnt = 0
myKitCnt = 0
myresultCnt = 0
myKitgubun = 0
LoginUserid		= getencLoginUserid()

If IsUserLoginOK() Then
	vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' and userid = '" & LoginUserid & "' AND sub_opt1 <> 'result' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		myresultCnt = rsget(0)
	End IF
	rsget.close
Else
	myresultCnt = 0
End If

if IsUserLoginOK() Then
	vQuery = ""
	vQuery = "SELECT count(*) as cnt , sub_opt2 FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' and userid = '" & LoginUserid & "' AND sub_opt1 = 'result' group by sub_opt2"
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		myKitCnt = rsget("cnt")
		myKitgubun = rsget("sub_opt2")
	End IF
	rsget.close
end if

vQuery = ""
vQuery = "SELECT count(case when sub_opt2 = 1 then sub_opt2 end) as lovecnt, count(case when sub_opt2 = 2 then sub_opt2 end) as workcnt   FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "'  AND sub_opt1 = 'result'  "
rsget.CursorLocation = adUseClient
rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.Eof Then
	lovecnt = rsget("lovecnt")
	workcnt = rsget("workcnt")
End IF
rsget.close

%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.feeling {background:#f15132 url(http://webimage.10x10.co.kr/playing/thing/vol002/bg_parallax_01.png) no-repeat 50% 0; text-align:center;}
.feeling button {background-color:transparent;}

/* parallax css */
.parallax {position:relative; max-width:1920px; margin:0 auto; background-repeat:no-repeat; background-position:50% 0; background-attachment:fixed;}
.object {position:absolute; background-attachment:scroll;}

.feeling .intro {height:960px; background-color:#f15132 !important; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol002/bg_parallax_01.png);}
.feeling .intro .grouping {top:195px; left:50%; width:570px; height:570px; margin-left:-285px; background-color:#fff;}
.feeling .intro .grouping span {position:absolute; top:134px; left:50%; margin-left:-54px;}
.feeling .intro .grouping p {position:absolute; top:268px; left:50%; margin-left:-117px;}
.feeling .intro .ico {position:absolute; top:805px; left:50%; margin-left:-13px;}
.feeling .intro .ico img {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.7s;}

.feeling .topic {padding:200px 0 131px; background-color:#e44324; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol002/bg_parallax_02.png);}
.feeling .topic .hgroup {position:relative;}
.feeling .topic .hgroup h2 {position:relative; z-index:5; width:256px; height:366px; margin:0 auto;}
.feeling .topic .hgroup h2 span {display:block; position:absolute; top:0; left:0; width:256px; height:100px; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/tit_feeling.png) no-repeat 50% 0; text-indent:-999em;}
.feeling .topic .hgroup h2 .letter2 {top:132px; background-position:50% -132px;}
.feeling .topic .hgroup h2 .letter3 {top:265px; height:101px; background-position:50% 100%;}
.feeling .topic .hgroup .bubble {position:absolute; top:0; left:50%; width:63px; height:56px; padding:27px 0 0 21px; margin-left:-164px; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/bg_speech_bubble_01.png) no-repeat 50% 0; text-align:left;}
.feeling .topic .hgroup .bubble2 {top:253px; width:69px; height:55px; margin-left:94px; padding:34px 0 0 25px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol002/bg_speech_bubble_02.png);}
.feeling .topic .hgroup .persimmon {position:absolute; top:45px; left:50%; margin-left:-537px;}
.feeling .topic .hgroup .persimmon2 {margin-left:-202px;}
.feeling .topic .hgroup .persimmon3 {margin-left:132px;}
.feeling .topic .start {position:relative; width:1100px; margin:165px auto 0;}
.feeling .topic .start h3 {margin-top:63px;}
.feeling .topic .start .btnStart {overflow:hidden; height:99px; margin-top:30px;}
.feeling .topic .start .btnStart a:hover img {margin-top:-99px;}
.feeling .topic .btnResult {position:absolute; top:246px; right:0; overflow:hidden; height:50px;}
.feeling .topic .btnResult a:hover img {margin-top:-50px;}

.persimmon1 {animation-name:persimmon1; animation-iteration-count:infinite; animation-duration:2s;}
@keyframes persimmon1 {
	from, to{ margin-left:-537px; animation-timing-function:ease-out;}
	50% {margin-left:-512px; animation-timing-function:ease-in;}
}
.persimmon2 {animation-name:persimmon2; animation-iteration-count:infinite; animation-duration:2s;}
@keyframes persimmon2 {
	from, to{ margin-left:-192px; animation-timing-function:ease-out;}
	50% {margin-left:-212px; animation-timing-function:ease-in;}
}
.persimmon3 {animation-name:persimmon3; animation-iteration-count:infinite; animation-duration:2s;}
@keyframes persimmon3 {
	from, to{ margin-left:122px; animation-timing-function:ease-out;}
	50% {margin-left:132px; animation-timing-function:ease-in;}
}

.feeling .test {position:relative; height:900px;}
.feeling .test .title {overflow:hidden; position:absolute; top:70px; left:50%; width:314px; height:93px; margin-left:-157px;}
.feeling .test .title span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:#ffda2b url(http://webimage.10x10.co.kr/playing/thing/vol002/tit_test.png) no-repeat 50% 0;}

.feeling .test .question {height:679px; padding-top:221px; background-color:#ffda2b;}
.feeling .test .question2 .title span {background-color:#ffc6ca; background-position:50% -93px;}
.feeling .test .question2 {background-color:#ffc6ca;}
.feeling .test .question3 {background-color:#ddefcc;}
.feeling .test .question3 .title span {background-color:#ddefcc; background-position:50% -186px;}
.feeling .test .question4 {background-color:#cbe8fe;}
.feeling .test .question4 .title span {background-color:#cbe8fe; background-position:50% -279px;}
.feeling .test .question5 {background-color:#e7d2de;}
.feeling .test .question5 .title span {background-color:#e7d2de; background-position:50% 100%;}

.feeling .test .question p {position:relative; z-index:5;}
.feeling .test .question .btnGroup {width:900px; margin:-79px auto 0;}
.feeling .test .question .btnGroup button {float:left; position:relative; width:430px; margin:0 10px;}
.feeling .test .question .btnGroup button i {display:block; position:absolute; bottom:61px; left:50%; width:41px; height:38px; margin-left:-20px; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/txt_ab.png) no-repeat 0 0;}
.feeling .test .question .btnGroup .btnB i {background-position:0 100%;}
.feeling .test .question .btnGroup button i {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.7s;}
.feeling .test .question .btnGroup .btnB i {animation-delay:0.1s;}

.feeling .test .lyResult {position:absolute; top:400px; left:50%; z-index:15; width:820px; height:241px; margin-left:-410px; padding-top:129px; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/bg_red_92.png) repeat 0 0;}
.feeling .test .lyResult .btnView span {display:block; margin-top:22px;}

.feeling .result {position:relative;}
.feeling .result .id {position:absolute; top:70px; left:50%; z-index:5; width:446px; height:40px; padding:4px 0; margin-left:-223px; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/txt_id.png) no-repeat 50% 0;}
.feeling .result .id .word {display:inline-block; *display:inline; *zoom:1; position:relative; width:31px; height:40px; line-height:42px;}
.feeling .result .id .word span {position:absolute; top:0; left:0; width:100%; height:100%; background:#ffe2e1 url(http://webimage.10x10.co.kr/playing/thing/vol002/txt_id.png) no-repeat -53px -52px;}
.feeling .result .id .word2 {width:143px;}
.feeling .result .id .word2 span {background-position:-253px -52px;}
.feeling .result .id b {color:#ed5335; font-family:'Dotum', '돋움', 'Verdana'; font-size:17px;}
.feeling .blue .id {background-position:50% -96px;}
.feeling .blue .id .word span {background:#e6f8ff url(http://webimage.10x10.co.kr/playing/thing/vol002/txt_id.png) no-repeat -53px -148px;}
.feeling .blue .id .word2 span {background-position:-253px -148px;}
.feeling .blue .id b {color:#5992c7;}

.feeling .result .need {position:absolute; top:70px; left:50%; z-index:5; width:386px; height:40px; padding:4px 0; margin-left:-193px;}
.feeling .result .need span {position:absolute; top:0; left:0; width:100%; height:100%; background:#ffe2e1 url(http://webimage.10x10.co.kr/playing/thing/vol002/tit_result.png) no-repeat 50% 0;}
.feeling .blue .need span {background-color:#e6f8ff; background-position:50% 100%;}

.feeling .result .grouping {position:relative; padding:152px 0 95px; background-color:#ffe2e1;}
.feeling .result .result2 {background-color:#ffe2e1;}
.feeling .result .result3, .feeling .result .result4 {background-color:#e6f8ff;}
.feeling .result .btnMore {overflow:hidden; display:block; position:absolute; bottom:76px; left:50%; width:142px; height:50px; margin-left:382px;}
.feeling .result .btnMore span {position:absolute; display:block; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/btn_test_more.png) no-repeat 0 0;}
.feeling .result .btnMore:hover span {background-position:0 100%;}
.feeling .blue .btnMore span,
.feeling .blue .btnMore span {background-position:100% 0;}
.feeling .blue .btnMore:hover span,
.feeling .blue .btnMore:hover span {background-position:100% 100%;}
.feeling .blue .grouping {background-color:#e6f8ff;}

.feeling .kit {padding:110px 0 120px; background:#f15132 url(http://webimage.10x10.co.kr/playing/thing/vol002/bg_persimmon_02.png) no-repeat 50% 0;}
.feeling .kit .navigator {width:503px; margin:62px auto 0;}
.feeling .kit .navigator ul {overflow:hidden; width:503px;}
.feeling .kit .navigator ul li {float:left; width:221px; height:108px; margin:0 10px;}
.feeling .kit .navigator ul li a {overflow:hidden; display:block; position:relative; width:100%; height:100%; color:#fff; line-height:108px;}
.feeling .kit .navigator ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/img_navigator_v1.png) no-repeat 0 0; cursor:pointer;}
.feeling .kit .navigator ul li a:hover span {background-position:0 -108px;}
.feeling .kit .navigator ul li a.on span {background-position:0 100%;}
.feeling .kit .navigator ul li a i {position:absolute; top:46px; right:52px; width:15px; height:15px; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/blt_arrow_right_oragne_ani.gif) no-repeat 0 0;}
.feeling .kit .navigator ul li a:hover i,
.feeling .kit .navigator ul li a.on i {display:none;}
.feeling .kit .navigator ul li.nav2 a span {background-position:100% 0;}
.feeling .kit .navigator ul li.nav2 a:hover span {background-position:100% -108px;}
.feeling .kit .navigator ul li.nav2 .on span {background-position:100% 100%;}
.feeling .kit .navigator ul li .on {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.8s;}

.slide {position:relative; width:1100px; margin:-13px auto 0; background-color:#fff;}
.slide .slidesjs-slide {background-color:#fff;}
.slide .slidesjs-navigation {display:block; position:absolute; z-index:20; bottom:20px; width:30px; height:30px; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:431px;}
.slide .slidesjs-previous:hover {background-position:0 100%;}
.slide .slidesjs-next {right:430px; background-position:100% 0;}
.slide .slidesjs-next:hover {background-position:100% 100%;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:29px; left:0; z-index:10; width:100%; height:11px; text-align:center;}
.slidesjs-pagination li {display:inline-block; *display:inline; *zoom:1; padding:0 8px;}
.slidesjs-pagination li a {display:block; width:16px; height:11px; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/btn_pagination.png) no-repeat 0 0; transition:0.5s all; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:0 100%;}
#slide2 .slidesjs-previous {left:411px;}
#slide2 .slidesjs-next {right:414px;}

.feeling .kit .get {margin-top:98px;}
.feeling .kit .get .vote {position:relative; width:649px; height:444px; margin:62px auto 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/bg_box.png) no-repeat 50% 0;}
.feeling .kit .get .vote ul {overflow:hidden; width:488px; margin:0 auto; padding-top:40px;}
.feeling .kit .get .vote ul li {float:left; width:222px; margin:0 11px; text-align:center;}
.feeling .kit .get .vote ul li button {position:relative; width:100%; height:251px;}
.feeling .kit .get .vote ul li button span {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/btn_vote.png) no-repeat 0 0;}
.feeling .kit .get .vote ul li button:hover span {background-position:0 -251px;}
.feeling .kit .get .vote ul li button.on span {background-position:0 100%;}
.feeling .kit .get .vote ul li.vote2 button span {background-position:100% 0;}
.feeling .kit .get .vote ul li.vote2 button:hover span {background-position:100% -251px;}
.feeling .kit .get .vote ul li.vote2 button.on span {background-position:100% 100%;}
.feeling .kit .get .vote ul li p {margin-top:16px;}
.feeling .kit .get .vote ul li p b {color:#fff; font-size:14px; line-height:18px;}
.feeling .kit .get .vote ul li p img {margin-top:2px;}
.feeling .kit .get .vote .btnSubmit {position:absolute; bottom:-49px; left:50%; margin-left:-154px;}
.feeling .kit .get .vote .btnSubmit button {position:relative; width:308px; height:99px; }
.feeling .kit .get .vote .btnSubmit button span {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/btn_get.png) no-repeat 50% 0;}
.feeling .kit .get .vote .btnSubmit button i {position:absolute; top:36px; right:44px; width:18px; height:17px; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/blt_arrow_right_white_ani.png) no-repeat 0 0;}
.feeling .kit .get .vote .btnGroup {position:absolute; bottom:-32px; left:50%; margin-left:-146px;}
.feeling .kit .get .vote .btnGroup p {position:relative; width:292px; height:82px;}
.feeling .kit .get .vote .btnGroup p span {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/playing/thing/vol002/btn_done.png) no-repeat 50% 0;}
.feeling .kit .get .vote .btnGroup .done2 span {background-position:50% 100%;}

.feeling .kit .tip {position:relative; width:643px; margin:160px auto 0;}
.feeling .kit .tip .btnShare {overflow:hidden; position:absolute; top:101px; right:0; height:50px;}
.feeling .kit .tip .btnShare a:hover img {margin-top:-50px;}

.feeling .volume {padding-top:30px; background-color:#fff; text-align:center;}

/* css3 animaiton */
.feeling @keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.lightSpeedIn {
	animation-name:lightSpeedIn; animation-timing-function:ease-out; animation-duration:2s; animation-fill-mode:both; animation-iteration-count:1;
	-webkit-animation-name:lightSpeedIn; -webkit-animation-timing-function:ease-out; -webkit-animation-duration:2s; -webkit-animation-fill-mode:both; -webkit-animation-iteration-count:1;
}
@keyframes lightSpeedIn {
	0% {transform:translateY(-500%);}
	60% {transform:translateY(-100%);}
	80% {transform:translateY(50%);}
	100% {transform:translateY(0%);}
}

.flash {animation-name:flash; animation-duration:1.5s; animation-fill-mode:both; animation-iteration-count:infinite; animation-delay:3s;}

@keyframes flash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}
</style>
<script type="text/javascript">
$(function(){
	// Cache the Window object
	$window = $(window);
	$('.parallax[data-type="background"]').each(function(){
		var $bgobj = $(this); // assigning the object
		$(window).scroll(function() {
			// Scroll the background at var speed
			// the yPos is a negative value because we're scrolling it UP!
			var yPos = -($window.scrollTop() / $bgobj.data('speed'));
			
			// Put together our final background position
			var coords = '50%'+ yPos + 'px';

			// Move the background
			$bgobj.css({backgroundPosition:coords});
		}); // window scroll Ends
	});

	/* 더블클릭시 최상단으로 이동 이벤트 없애기 */
	$(document).unbind("dblclick").dblclick(function () {});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 950 ) {
			animation();
		}
	});

	$("#animation span").css({"opacity":"0"});
	$("#animation h2 span").css({"margin-top":"7px"});
	function animation () {
		$("#animation h2 .letter1").delay(10).animate({"margin-top":"0", "opacity":"1"},600);
		$("#animation h2 .letter2").delay(250).animate({"margin-top":"0", "opacity":"1"},600);
		$("#animation h2 .letter3").delay(550).animate({"margin-top":"0", "opacity":"1"},600);
		$("#animation h2 .letter3").delay(300).effect("shake", {direction:"up", times:15, distance:3}, 2000);
		$("#animation .persimmon").delay(1000).animate({"opacity":"1"},600);
		$("#animation .bubble1").delay(1500).animate({"opacity":"1"},100);
		$("#animation .bubble2").delay(1500).animate({"opacity":"1"},100);
	}

	/* skip to topic */
	$("#btnGo a").on("click", function(e){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},700);
	});

	/* test hide */
	$("#test").hide();

	/* skip to test */
//	$("#btnStart a").on("click", function(e){
//		$("#test").slideDown();
//		event.preventDefault();
//		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},700);
//	});

	/* test */
	$("#test .question").hide();
	$("#test .lyResult").hide();
	$("#test .question:first").show();

	/* tab on off */
	/* slide js */
	function rolling1() {
		$("#slide1").slidesjs({
			width:"1100",
			height:"660",
			pagination:{effect:"fade"},
			navigation:{effect:"fade"},
			play:{interval:2500, effect:"fade", auto:true},
			effect:{fade: {speed:1000, crossfade:true}}
		});
	}

	function rolling2() {
		$("#slide2").slidesjs({
			width:"1100",
			height:"660",
			start:1,
			pagination:{effect:"fade"},
			navigation:{effect:"fade"},
			play:{interval:2500, effect:"fade", auto:true},
			effect:{fade: {speed:1000, crossfade:true}}
		});
	}

	var firstview = Math.floor((Math.random()*2)+1);
	$("#rolling .navigator li a").each(function(){
		var thisCont = $(this).attr("href");
		if ( thisCont == "#tabcont"+firstview ){
			$("#rolling .navigator li a").removeClass("on");
			$(this).addClass("on");
			$("#rolling .tabcontainer").find(".tabcont").hide();
			$("#rolling .tabcontainer").find(thisCont).show();
			if(firstview==1) {
				rolling1();
			} else {
				rolling2();
			}
		}
	});

	$("#rolling .navigator li a").on("click",function(){
		$("#rolling .navigator li a").removeClass("on");
		$(this).addClass("on");
		var thisCont = $(this).attr("href");
		$("#rolling .tabcontainer").find(".tabcont").hide();
		$("#rolling .tabcontainer").find(thisCont).show();
		return false;
	});

	$("#rolling .navigator li.nav1 a").on("click",function(){
		rolling1();
		
	});
	$("#rolling .navigator li.nav2 a").on("click",function(){
		rolling2();
	});

	/* vote */
	$("#vote ul li:first-child button").addClass("on");
	$("#vote ul li button").click(function(){
		$("#vote ul li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});
});

///////////////////////////////////////////////////////////////////

function rolling1tab() {
	$("#slide1").slidesjs({
		width:"1100",
		height:"660",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});
}

function rolling2tab() {
	$("#slide2").slidesjs({
		width:"1100",
		height:"660",
		start:1,
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2500, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});
}
	
function restart(){
	$("#resultviewbtn").hide();
	$("#test").hide();
	$("#lyResult").hide();
	$("#result").empty();
	$("#result").hide();
	$("#question2").hide();
	$("#question3").hide();
	$("#question4").hide();
	$("#question5").hide();
	$("#question1").show();
	$("#test").show();
	window.parent.$('html,body').animate({scrollTop:$("#question1").offset().top},700);
}

function jsplayingthing(num,sel){
<% If IsUserLoginOK() Then %>
	$.ajax({
		type: "GET",
		url: "/playing/sub/doEventSubscript74346.asp",
		data: "mode=add&num="+num+"&sel="+sel,
		cache: false,
		success: function(str) {
			str = str.replace("undefined","");
			res = str.split("|");
			if (res[0]=="OK") {
				if(num==1){
					$("#test .question").hide();
					$("#question2").show();
				}else if(num==2){
					$("#test .question").hide();
					$("#question3").show();
				}else if(num==3){
					$("#test .question").hide();
					$("#question4").show();
				}else if(num==4){
					$("#test .question").hide();
					$("#question5").show();
				}else if(num==5){
					$("#test .question5").show();
					$("#test .lyResult").show();
					$("#resultviewbtn").show();
				}else{
					alert('잘못된 접속 입니다.1');
					parent.location.reload();
				}
			} else {
				errorMsg = res[1].replace(">?n", "\n");
				alert(errorMsg );
				return false;
			}
		}
		,error: function(err) {
			console.log(err.responseText);
			alert("통신중 오류가 발생했습니다. 잠시 후 다시 시도해주세요.");
		}
	});
<% else %>
	jsChklogin('<%=IsUserLoginOK%>');
	return false;
<% end if %>
}

function jsplayingthingresult(){
<% If IsUserLoginOK() Then %>
	$.ajax({
		type: "GET",
		url: "/playing/sub/doEventSubscript74346.asp",
		data: "mode=result",
		cache: false,
		success: function(str) {
			str = str.replace("undefined","");
			res = str.split("|");
			if (res[0]=="OK") {
				if (res[1]=="1") {
					$('#resultlink').val('http://www.10x10.co.kr/event/74347');
					$("#result").empty().html(res[2]);
					$("#result").show();
					$("#nav2tabid").removeClass("on");
					$("#nav1tabid").addClass("on");		
					$("#tabcont2").hide();
					$("#tabcont1").show();
					rolling1tab();
					$("#vote2btn").removeClass("on");
					$("#vote1btn").addClass("on");
					$('#kitresultnum').val(1);
					window.parent.$('html,body').animate({scrollTop:$("#result").offset().top},700);
				}else if(res[1]=="2") {
					$('#resultlink').val('http://www.10x10.co.kr/event/74348');
					$("#result").empty().html(res[2]);
					$("#result").show();
					$("#nav2tabid").removeClass("on");
					$("#nav1tabid").addClass("on");
					$("#tabcont2").hide();
					$("#tabcont1").show();
					rolling1tab();
					$("#vote2btn").removeClass("on");
					$("#vote1btn").addClass("on");
					$('#kitresultnum').val(1);
					window.parent.$('html,body').animate({scrollTop:$("#result").offset().top},700);
				}else if(res[1]=="3") {
					$('#resultlink').val('http://www.10x10.co.kr/event/74349');
					$("#result").empty().html(res[2]);
					$("#result").show();
					$("#nav1tabid").removeClass("on");
					$("#nav2tabid").addClass("on");
					$("#tabcont1").hide();
					$("#tabcont2").show();
					rolling2tab();
					$("#vote1btn").removeClass("on");
					$("#vote2btn").addClass("on");
					$('#kitresultnum').val(2);
					window.parent.$('html,body').animate({scrollTop:$("#result").offset().top},700);
				}else if(res[1]=="4") {
					$('#resultlink').val('http://www.10x10.co.kr/event/74350');
					$("#result").empty().html(res[2]);
					$("#result").show();
					$("#resultviewbtn").show();
					$("#nav1tabid").removeClass("on");
					$("#nav2tabid").addClass("on");		
					$("#tabcont1").hide();
					$("#tabcont2").show();
					rolling2tab();
					$("#vote1btn").removeClass("on");
					$("#vote2btn").addClass("on");
					$('#kitresultnum').val(2);
					window.parent.$('html,body').animate({scrollTop:$("#result").offset().top},700);
				}else{
					parent.location.reload();
				}
			} else {
				errorMsg = res[1].replace(">?n", "\n");
				alert(errorMsg );
				return false;
			}
		}
		,error: function(err) {
			console.log(err.responseText);
			alert("통신중 오류가 발생했습니다. 잠시 후 다시 시도해주세요..");
		}
	});
<% else %>
	jsChklogin('<%=IsUserLoginOK%>');
	return false;
<% end if %>
}

function fnkitneed(){
var kitnum = $('#kitresultnum').val();
<% If IsUserLoginOK() Then %>
	$.ajax({
		type: "GET",
		url: "/playing/sub/doEventSubscript74346.asp",
		data: "mode=kitresult&kitnum="+kitnum,
		cache: false,
		success: function(str) {
			str = str.replace("undefined","");
			res = str.split("|");
			if (res[0]=="OK") {
				$("#kitbfbtn").empty();
				$("#kitafterbtn").empty().html(res[2]);
				return;
			}else{
				errorMsg = res[1].replace(">?n", "\n");
				alert(errorMsg);
				if(errorMsg="테스트를 완료 하셔야 신청할 수 있습니다.."){
					window.$('html,body').animate({scrollTop:$("#start").offset().top}, 0);
				}
				return false;
			}
		}
		,error: function(err) {
			console.log(err.responseText);
			alert("통신중 오류가 발생했습니다. 잠시 후 다시 시도해주세요..");
		}
	});
<% else %>
	jsChklogin('<%=IsUserLoginOK%>');
	return false;
<% end if %>
}


function snschkresult(snsnum) {
<% If IsUserLoginOK() Then %>
	$.ajax({
		type: "GET",
		url: "/playing/sub/doEventSubscript74346.asp",
		data: "mode=snsresult",
		cache: false,
		success: function(str) {
			str = str.replace("undefined","");
			res = str.split("|");
			if (res[0]=="OK") {
				if (res[1]=="1") {
					$('#resultlink').val('http://www.10x10.co.kr/event/74347');
				}else if(res[1]=="2") {
					$('#resultlink').val('http://www.10x10.co.kr/event/74348');
				}else if(res[1]=="3") {
					$('#resultlink').val('http://www.10x10.co.kr/event/74349');
				}else if(res[1]=="4") {
					$('#resultlink').val('http://www.10x10.co.kr/event/74350');
				}else{
					parent.location.reload();
				}
				var snpTitleresult = $('#resulttext').val();
				var snpLinkresult = $('#resultlink').val();
				if(snsnum=="fb"){
					popSNSPost('fb',snpTitleresult, snpLinkresult,'','');
					return false;
				}
			} else {
				errorMsg = res[1].replace(">?n", "\n");
				alert(errorMsg );
				return false;
			}
		}
		,error: function(err) {
			console.log(err.responseText);
			alert("통신중 오류가 발생했습니다. 잠시 후 다시 시도해주세요..");
		}
	});
<% else %>
	jsChklogin('<%=IsUserLoginOK%>');
	return false;
<% end if %>
}

function fnkitvaluechg(kitval) {
	$('#kitresultnum').val(kitval);
}

function fnteststart() {
<% If IsUserLoginOK() Then %>
	$("#test").slideDown();
	event.preventDefault();
	window.parent.$('html,body').animate({scrollTop:$("#test").offset().top},700);
<% else %>
	jsChklogin('<%=IsUserLoginOK%>');
	return false;
<% end if %>
}
</script>
	<%' THING. html 코딩 영역 : 클래스명은 thing+볼륨 예) thingVol001 / 이미지폴더는 볼륨을 따라 vol001 %>
	<div class="thingVol002 feeling">
		<div class="section intro parallax">
			<div class="grouping object">
				<span class="lightSpeedIn"><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_persimmon.png" alt="" /></span>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_help_v1.png" alt="감 떨어지는 계절, 이 시기만 되면 감 떨어지시는 분들! 전처럼 일이 풀리지 않는 분들을 위해 텐바이텐 PLAYing가 당신의 떨어진 감을 잡아드립니다." /></p>
			</div>

			<div id="btnGo" class="ico"><a href="#topic"><img src="http://webimage.10x10.co.kr/playing/thing/vol002/ico_arrow_down.png" alt="감 나와라 뚝딱! 보러가기" /></a></div>
		</div>

		<div id="topic" class="section topic parallax" data-speed="0" data-type="background"">
			<div id="animation" class="hgroup">
				<h2>
					<span class="letter letter1">감</span>
					<span class="letter letter2">나와라</span>
					<span class="letter letter3">뚝딱</span>
				</h2>
				<span class="persimmon persimmon1"><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_persimmon_stroke.png" alt="" /></span>
				<span class="persimmon persimmon2"><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_persimmon_stroke.png" alt="" /></span>
				<span class="persimmon persimmon3"><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_persimmon_stroke.png" alt="" /></span>
				<span class="bubble bubble1"><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_heart.png" alt="" class="flash" /></span>
				<span class="bubble bubble2"><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_eyes.gif" alt="" /></span>
			</div>

			<div id="start" class="start">
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_check_point.png" alt="체크포인트 이런 사람 모여라! 연애가 뭔지 기억이 안 나는 분, 요즘 따라 팀장님한테 자꾸 불려가는 분, 이성 앞에만 다가가면 얼음이 되는 분, 열심히 하는데 생각보다 잘 안 풀리는 분, 소개팅과는 인연이 아닌 분, 했던 일 또 하고 했던 일 또 하고 했던 일 또... 그런 분" /></p>
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol002/tit_start.png" alt="나에게 필요한 감 찾으러 가기" /></h3>

				<div id="btnStart" class="btnStart"><a href="" onclick="fnteststart(); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_test_start_v1.gif" alt="테스트 스타트" /></a></div>
				<%' for dev msg : 테스트 전에는 숨겨주세요 %>
				<% if myresultCnt = 5 then %>
					<div class="btnResult" id="resultviewbtn" <% if myresultCnt <> 5 then %>style="display:none"<% end if %> ><a href="" onclick="jsplayingthingresult(); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_my_result.png" alt="내 결과 보기" /></a></div>
				<% end if %>
			</div>
		</div>

		<%' test %>
		<div id="test" class="section test">
			<input type="hidden" name="resulttext" id="resulttext" value="요즘 나에게 떨어진 감은?">
			<input type="hidden" name="resultlink" id="resultlink" value="http://10x10.co.kr/event/74346">
			<!-- question -->
			<div class="question question1" id="question1" style="display:none;">
				<h3 class="title"><span></span>재미로 보는 TEST 지금, 당신에게 가장 필요한 감은?</h3>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_test_question_01.png" alt="대화를 할 때 당신은?" /></p>
				<div class="btnGroup">
					<button type="button" onclick="jsplayingthing('1','A'); return false;" class="btnA"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_choice_01_a.png" alt="A 듣는 편이다" /></button>
					<button type="button" onclick="jsplayingthing('1','B'); return false;" class="btnB"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_choice_01_b.png" alt="B 말하는 편이다" /></button>
				</div>
			</div>

			<div class="question question2" id="question2" style="display:none;">
				<div class="title"><span></span></div>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_test_question_02.png" alt="사과는 이렇게 먹는 걸 좋아한다" /></p>
				<div class="btnGroup">
					<button type="button" onclick="jsplayingthing('2','A'); return false;" class="btnA"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_choice_02_a.png" alt="A 한 입에 와작" /></button>
					<button type="button" onclick="jsplayingthing('2','B'); return false;" class="btnB"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_choice_02_b.png" alt="B 조각으로 나눠서" /></button>
				</div>
			</div>

			<div class="question question3" id="question3" style="display:none;">
				<div class="title"><span></span></div>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_test_question_03.png" alt="더 끌리는 색 조합은?" /></p>
				<div class="btnGroup">
					<button type="button" onclick="jsplayingthing('3','A'); return false;" class="btnA"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_choice_03_a.png" alt="A 비슷한 색의 조화" /></button>
					<button type="button" onclick="jsplayingthing('3','B'); return false;" class="btnB"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_choice_03_b.png" alt="B 상반된 색의 조화" /></button>
				</div>
			</div>

			<div class="question question4" id="question4" style="display:none;">
				<div class="title"><span></span></div>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_test_question_04.png" alt="요즘! 가고 싶은 장소는?" /></p>
				<div class="btnGroup">
					
					<button type="button" onclick="jsplayingthing('4','A'); return false;" class="btnA"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_choice_04_a.png" alt="A 가슴뭉클한 영화관" /></button>
					<button type="button" onclick="jsplayingthing('4','B'); return false;" class="btnB"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_choice_04_b.png" alt="B 컬러풀한 미술관" /></button>
				</div>
			</div>

			<div class="question question5" id="question5" style="display:none;">
				<div class="title"><span></span></div>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_test_question_05.png" alt="내 방 액자에 걸고 싶은 그림은?" /></p>
				<div class="btnGroup">
					<button type="button" onclick="jsplayingthing('5','A'); return false;" class="btnA"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_choice_05_a.png" alt="A 노을 지는 바다" /></button>
					<button type="button" onclick="jsplayingthing('5','B'); return false;" class="btnB"><i></i><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_choice_05_b.png" alt="B 별빛 가득 바다" /></button>
				</div>
			</div>

			<div id="lyResult" class="lyResult" style="display:none;">
				<div class="btnView">
					<a href="" onclick="jsplayingthingresult(); return false;">
						<img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_result_view.png" alt="결과보기" />
						<span><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_result_view_arrow.png" alt="결과보기" /></span>
					</a>
				</div>
			</div>
		</div>

		<% If IsUserLoginOK() Then %>
		<div id="result">
		</div>
		<% end if %>

		<div class="section kit">
			<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol002/tit_kit.png" alt="당신을 위한 감 Kit를 준비했습니다." /></h3>

			<div id="rolling" class="rolling">
				<div class="navigator">
					<ul>
						<li class="nav1"><a href="#tabcont1" id="nav1tabid"><span></span>연애감 Kit<i></i></a></li>
						<li class="nav2"><a href="#tabcont2" id="nav2tabid"><span></span>업무감 Kit<i></i></a></li>
					</ul>
				</div>

				<div class="tabcontainer">
					<div id="tabcont1" class="tabcont">
						<div id="slide1" class="slide">
							<div><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_slide_01_01.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_slide_01_02.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_slide_01_03.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_slide_01_04.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_slide_01_05.jpg" alt="" /></div>
						</div>
					</div>

					<div id="tabcont2" class="tabcont">
						<div id="slide2" class="slide">
							<div><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_slide_02_01.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_slide_02_02.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_slide_02_03.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_slide_02_04.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_slide_02_05.jpg" alt="" /></div>
							<div><img src="http://webimage.10x10.co.kr/playing/thing/vol002/img_slide_02_06.jpg" alt="" /></div>
						</div>
					</div>
				</div>
			</div>

			<!-- get -->
			<div class="get">
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_get.png" alt="당신에게 필요한 감을 신청 해 주세요! 추첨을 통해 총 80분 Kit당 40분에게 해당, 감 떨어지지마 Kit를 드립니다. 한 ID당 1회 신청 가능하며, 응모 기간은 11월 21일부터 12월 5일이며, 당첨자 발표는 12월 6일 화요일입니다." /></p>

				<!--- for dev msg : Kit 신청 -->
				<div id="vote" class="vote">
				<input type="hidden" name="kitresultnum" id="kitresultnum" value="1">
					<fieldset>
						<ul>
							<li class="vote1">
								<button type="button" id="vote1btn" onclick="fnkitvaluechg('1'); return false;"><span></span>연애감 Kit</button>
								<p>
									<b><%= lovecnt %></b> <img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_count_01.png" alt="명이" /><br />
									<img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_count_02.png" alt="연애감을 필요로 합니다!" />
								</p>
							</li>
							<li class="vote2">
								<button type="button" id="vote2btn" onclick="fnkitvaluechg('2'); return false;"><span></span>업무감 Kit</button>
								<p>
									<b><%= workcnt %></b> <img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_count_01.png" alt="명이" /><br />
									<img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_count_03.png" alt="업무감을 필요로 합니다!" />
								</p>
							</li>
						</ul>

						<% if myKitCnt < 1 then %>
							<div class="btnSubmit" id="kitbfbtn">
								<button type="submit" onclick="fnkitneed(); return false;"><span></span>감 Kit 신청하기<i></i></button>
							</div>
						<% end if %>
						<div class="btnGroup" id="kitafterbtn">
							<% if myKitgubun = 1 then %>
								<p class='done1'><span></span>연애감 신청완료</p>
							<% elseif myKitgubun = 2 then %>
								<p class='done2'><span></span>업무감 신청완료</p>
							<% end if %>
						</div>
					</fieldset>
				</div>
			</div>

			<div class="tip">
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_tip.png" alt="당첨 확률 높이는 Tip 여러분! 감 챙기셔야죠. 내 결과 공유하면 당첨확률 UP! 근 텐바이텐에서 구매한 고객이라면 당첨확률 UP! 플레이 리뉴얼을 기다리셨던 고객이라면 당첨확률 UP!" /></p>
				<div class="btnShare"><a href="" onclick="snschkresult('fb'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol002/btn_share.png" alt="내 결과 공유하기" /></a></div>
			</div>
		</div>

		<!-- volume -->
		<div class="volume">
			<p><img src="http://webimage.10x10.co.kr/playing/thing/vol002/txt_vol002.png" alt="Volume 2 THING의 사물에 대한 생각 감으로 감을 잡자" /></p>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->