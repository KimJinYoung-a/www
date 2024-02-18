<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : tab2 : [참여이벤트] 도리를 찾아서
' History : 2016.06.09 김진영 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim eCode, vUserID, irdsite20, winItemChk, winItemStr
Dim tab1eCode, tab2eCode, tab3eCode
Dim vSQL
irdsite20	= requestCheckVar(request("rdsite"), 32)
vUserID		= GetLoginUserID

If application("Svr_Info") = "Dev" Then
	eCode			= "66148"
	tab1eCode		= "66147"
	tab2eCode		= "66148"
	tab3eCode		= "66149"

Else
	eCode			= "71111"
	tab1eCode		= "71110"
	tab2eCode		= "71111"
	tab3eCode		= "71112"
End If

vSQL = ""
vSQL = vSQL & " SELECT TOP 1 sub_opt2 FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code="& eCode &" and userid = '"&vUserID&"' and sub_opt2 in ('11111', '22222', '33333') "
rsget.Open vSQL, dbget, 1
If Not(rsget.bof Or rsget.Eof) Then
	winItemChk = rsget("sub_opt2")
Else
	winItemChk = ""
End IF
rsget.close
%>
<style type="text/css">
img {vertical-align:top;}

#contentWrap {padding-bottom:0;}

.findingDori {margin-bottom:50px !important; background:#20bbd4 url(http://webimage.10x10.co.kr/eventIMG/2016/71111/bg_sea_v1.jpg) no-repeat 50% 0;}
.findingDori button {background-color:transparent;}

.bubble {position:absolute; top:90px; left:50%; z-index:5; width:1749px; height:326px; margin-left:-905px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/img_bubble.png) no-repeat 50% 0;}
.bubble {animation-name:bubble; animation-duration:5s; animation-timing-function:ease-in-out; animation-delay:-1s; animation-iteration-count:infinite; animation-direction:alternate; animation-play-state:running;}
@keyframes bubble {
	0%{margin-top:-40px; background-size:96% 96%;}
	100%{margin-top:40px; background-size:100% 100%;}
}

.topic {position:relative; height:515px;}
.topic h2 {position:absolute; top:98px; left:50%; width:703px; height:176px; margin-left:-351px;}
.topic h2 span {position:absolute;}
.topic h2 .letter1 {top:0; left:50%; margin-left:-130px;}
.topic h2 .letter2 {top:18px; left:0;}
.topic h2 .letter3 {top:111px; left:369px;}
.topic .come {position:absolute; top:305px; left:50%; margin-left:-178px;}
.topic .date {position:absolute; top:30px; left:50%; margin-left:430px;}

.navigator {position:absolute; bottom:34px; left:50%; z-index:5; width:887px; margin-left:-443px;}
.navigator ul {width:887px; height:110px;}
.navigator ul li {float:left; width:297px; height:110px;}
.navigator ul li a {display:block; position:relative; width:100%; height:100%; color:#000; font-size:12px; line-height:64px; text-align:center;}
.navigator ul li a span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/img_navigator.png) no-repeat 0 -110px;}
.navigator ul li a.on {color:#e88057; font-weight:bold;}
.navigator ul li a:hover span,
.navigator ul li a.on span {background-position:0 0;}
.navigator ul li.nav2 {width:294px;}
.navigator ul li.nav2 a span {background-position:-297px 0;}
.navigator ul li.nav2 a:hover span, .navigator ul li.nav2 a.on span {background-position:-297px -110px;}
.navigator ul li.nav3 {width:296px;}
.navigator ul li.nav3 a span {background-position:-592px 0;}
.navigator ul li.nav3 a:hover span, .navigator ul li.nav3 a.on span {background-position:-592px 100%;}
.navigator ul li i {display:none; position:absolute; top:-37px; left:25px;}
.navigator ul li.nav2 i {top:-28px; left:215px;}
.navigator ul li a.on i {display:block;}
.navigator ul li.nav1 a.on i img {animation-name:bounce1; animation-duration:1.5s; animation-iteration-count:3; animation-fill-mode:both; animation-delay:2s;}
@keyframes bounce1 {
	0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
	40% {transform: translateY(-7px);}
	60% {transform: translateY(-3px);}
}
.navigator ul li.nav2 a.on i {animation-name:move; animation-duration:2.5s; animation-iteration-count:3; animation-fill-mode:both; animation-delay:2s; animation-direction:alternate; animation-play-state:running;}
@keyframes move {
	0% {top:-28px; left:215px; animation-timing-function:linear;}
	100% {top:-20px; left:200px; animation-timing-function:linear;}
}

@keyframes flip {
	0% {transform:rotateY(0deg); animation-timing-function:ease-out;}
	100% {transform:rotateY(360deg); animation-timing-function:ease-in;}
}
.flip {animation-name:flip; animation-duration:1.2s; animation-iteration-count:1; backface-visibility:visible;}

.noti {margin-top:-11px; padding-top:11px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/bg_wave.png) repeat-x 0 0;}
.noti .bg {padding:49px 0 44px; background-color:#0f1f36;}
.noti .inner {position:relative; width:1140px; margin:0 auto; text-align:left;}
.noti ul {overflow:hidden; margin-top:20px;}
.noti ul li {float:left; width:50%; min-height:26px; color:#f8f7f7; font-family:'굴림', 'Gulim', 'Arial'; font-size:12px; line-height:1.5em;}
.noti ul li:first-child {margin-top:0;}
.noti ul li strong {color:#ffef68; font-weight:normal;}
.noti ul li img {vertical-align:middle;}

.intro {height:538px; background-color:#128eb4;}
.intro .inner {position:relative; width:1140px; margin:0 auto; padding-top:88px; text-align:left;}
.rolling {position:relative; width:598px; margin-left:36px;}
.rolling .swiper {position:relative; padding-bottom:32px;}
.rolling .swiper .swiper-container {position:relative; overflow:hidden; height:344px;}
.rolling .swiper .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {float:left; width:100%;}
.rolling .swiper .pagination {position:absolute; bottom:0; left:50%; z-index:20; width:120px; margin-left:-60px;}
.rolling .swiper .pagination span {float:left; width:10px; height:10px; margin:0 7px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71110/btn_pagination_dot.png) no-repeat 0 0; cursor:pointer; transition:all 0.5s ease;}
.rolling .swiper .pagination .swiper-active-switch {background-position:0 100%;}
.rolling .btn-nav {display:block; position:absolute; top:142px; z-index:100; width:59px; height:59px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2016/71110/btn_nav_white.png) no-repeat 0 0; text-indent:-999em}
.rolling .btn-prev {left:0;}
.rolling .btn-next {right:0; background-position:100% 0;}
.intro p {position:absolute; top:87px; right:0;}

.shareSns {position:relative; height:159px; background-color:#005f7c;}
.shareSns ul {width:162px; position:absolute; top:50px; left:50%; margin-left:278px;}
.shareSns ul li {float:left; margin-right:16px;}
.shareSns ul li a:hover img {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.5s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.find {overflow:hidden; position:relative; min-width:1140px; height:1313px;}
.find ul li {position:absolute; top:0;}
.find ul li {animation-iteration-count:infinite; animation-fill-mode:both; animation-direction:alternate; animation-play-state:running;}
.find ul li:hover {animation-play-state:paused;}
.find ul li.clownfish {top:210px; left:50%; margin-left:-820px;}
.find ul li.seaturtle {top:0; left:50%; margin-left:-1110px;}
.find ul li.seaturtleKid {top:0; left:50%; margin-left:657px;}
.find ul li.dory {top:171px; left:50%; margin-left:-478px;}
.find ul li.whale {top:253px; left:50%; margin-left:-407px;}
.find ul li.shark {top:344px; left:50%; margin-left:10px;}
.find ul li.bluetang {top:535px; left:50%; margin-left:-182px;}
.find ul li.stingray {top:193px; left:50%; margin-left:143px;}
.find ul li.octopus {top:697px; left:50%; margin-left:150px;}
.find ul li.otter {top:553px; left:50%; margin-left:-710px;}
.find ul li.seal {top:490px; left:50%;; margin-left:467px;}

.position1 ul li.dory {animation-name:moveDory; animation-duration:1.5s;}
@keyframes moveDory {
	0% {top:171px; margin-left:-478px; animation-timing-function:linear;}
	100% {top:200px; margin-left:-458px; animation-timing-function:linear;}
}
.position1 ul li.seaturtle {animation-name:moveSeaturtle; animation-duration:4s;}
@keyframes moveSeaturtle {
	0% {margin-left:-1110px; animation-timing-function:linear;}
	100% {margin-left:-1000px; animation-timing-function:linear;}
}
.position1 ul li.seaturtleKid {animation-name:moveSeaturtleKid; animation-duration:2s;}
@keyframes moveSeaturtleKid {
	0% {top:0; animation-timing-function:ease-out;}
	100% {top:50px; animation-timing-function:ease-out;}
}
.position1 ul li.whale {animation-name:moveWhale; animation-duration:2.5s;}
@keyframes moveWhale {
	0% {top:253px; margin-left:-407px; animation-timing-function:linear;}
	100% {top:243px; margin-left:-360px; animation-timing-function:linear;}
}
.position1 ul li.shark {animation-name:moveShark; animation-duration:3.5s;}
@keyframes moveShark {
	0% {top:344px; margin-left:10px; animation-timing-function:linear;}
	100% {top:304px; margin-left:-60px; animation-timing-function:linear;}
}
.position1 ul li.stingray {animation-name:moveStingray; animation-duration:3s;}
@keyframes moveStingray {
	0% {top:193px; animation-timing-function:ease;}
	100% {top:100px; animation-timing-function:ease-out;}
}
.position1 ul li.octopus {animation-name:moveOctopus; animation-duration:2.5s;}
@keyframes moveOctopus {
	0% {left:50%; animation-timing-function:linear;}
	100% {left:48%; animation-timing-function:linear;}
}

.position2 ul li.dory {top:550px; left:50%; margin-left:-100px;}
.position2 ul li.clownfish {top:470px; left:50%; margin-left:50px;}
.position2 ul li.seaturtle {top:0; margin-left:-1000px;}
.position2 ul li.seaturtleKid {top:200px; left:50%; margin-left:657px;}
.position2 ul li.bluetang {top:50px; left:70%; margin-left:0;}
.position2 ul li.whale {top:140px; left:27%; margin-left:0;}
.position2 ul li.shark {top:344px; left:50%; margin-left:288px;}
.position2 ul li.stingray {top:250px; left:50%; margin-left:-100px;}
.position2 ul li.octopus {top:697px; left:50%; margin-left:-500px;}
.position2 ul li.seal {top:470px; left:50%; margin-left:-710px;}
.position2 ul li.otter {top:564px; left:50%; margin-left:467px;}
.position2 ul li.dory {animation-name:moveDory2; animation-duration:1s;}
@keyframes moveDory2 {
	0% {top:550px; animation-timing-function:linear;}
	100% {top:530px; animation-timing-function:linear;}
}
.position2 ul li.clownfish {animation-name:moveClownfish2; animation-duration:3s; animation-delay:1s;}
@keyframes moveClownfish2 {
	0% {top:470px; margin-left:50px; animation-timing-function:ease-out;}
	100% {top:500px; margin-left:100px;; animation-timing-function:ease-out;}
}
.position2 ul li.octopus {animation-name:moveOctopus2; animation-duration:2.5s;}
@keyframes moveOctopus2 {
	0% {margin-left:-500px; animation-timing-function:linear;}
	100% {margin-left:-550px; animation-timing-function:linear;}
}
.position2 ul li.seaturtle {animation-name:moveSeaturtle2; animation-duration:7s;}
@keyframes moveSeaturtle2 {
	0% {margin-left:-1000px; animation-timing-function:linear;}
	100% {margin-left:-600px; animation-timing-function:linear;}
}
.position2 ul li.seaturtleKid {animation-name:moveSeaturtleKid2; animation-duration:3s; animation-delay:1.5s;}
@keyframes moveSeaturtleKid2 {
	0% {top:200px; margin-left:657px; animation-timing-function:ease-out;}
	100% {top:100px; margin-left:550px; animation-timing-function:ease-out;}
}
.position2 ul li.stingray {animation-name:moveStingray2; animation-duration:3s;}
@keyframes moveStingray2 {
	0% {top:250px; animation-timing-function:ease;}
	100% {top:150px; animation-timing-function:ease-out;}
}

.position3 ul li.dory {top:553px; left:50%; margin-left:300px;}
.position3 ul li.clownfish {top:300px;}
.position3 ul li.bluetang {top:580px;}
.position3 ul li.otter {top:553px; left:50%; margin-left:-610px;}
.position3 ul li.whale {top:100px; left:50%; margin-left:-407px;}
.position3 ul li.dory {animation-name:moveDory3; animation-duration:0.8s;}
@keyframes moveDory3 {
	0% {top:553px; animation-timing-function:linear;}
	100% {top:533px; animation-timing-function:linear;}
}
.position3 ul li.clownfish {animation-name:moveClownfish3; animation-duration:2.5s;}
@keyframes moveClownfish3 {
	0% {top:350px; margin-left:-820px; animation-timing-function:linear;}
	100% {top:300px; margin-left:-780px; animation-timing-function:linear;}
}
.position3 ul li.shark {animation-name:moveShark3; animation-duration:4s;}

.position3 ul li.whale {animation-name:moveWhale3; animation-duration:2s;}
@keyframes moveWhale3 {
	0% {margin-left:-407px; animation-timing-function:linear;}
	100% {margin-left:-357px; animation-timing-function:linear;}
}
.position3 ul li.shark {animation-name:moveShark3; animation-duration:4s;}
@keyframes moveShark3 {
	0% {margin-left:10px; animation-timing-function:linear;}
	100% {margin-left:-100px; animation-timing-function:linear;}
}
.position3 ul li.stingray {animation-name:moveStingray3; animation-duration:3s;}
@keyframes moveStingray3 {
	0% {top:250px; margin-left:143px; animation-timing-function:ease;}
	100% {top:150px; margin-left:100px; animation-timing-function:ease-out;}
}
.position3 ul li.seaturtleKid {animation-name:moveSeaturtleKid; animation-duration:2s;}

.position4 ul li.clownfish {top:100px; left:50%; margin-left:-520px;}
.position4 ul li.seaturtleKid {top:150px; left:50%; margin-left:350px;}
.position4 ul li.whale {top:160px;}
.position4 ul li.stingray {top:0; left:50%; margin-left:657px;}
.position4 ul li.dory {top:171px; left:50%; margin-left:50px;}
.position4 ul li.otter {top:560px; left:50%; margin-left:442px;}
.position4 ul li.seal {top:470px; left:50%; margin-left:-710px;}

.position4 ul li.clownfish {animation-name:moveClownfish4; animation-duration:2s;}
@keyframes moveClownfish4 {
	0% {top:100px; margin-left:-520px; animation-timing-function:linear;}
	100% {top:80px; margin-left:-500px; animation-timing-function:linear;}
}
.position4 ul li.dory {animation-name:moveDory4; animation-duration:1.2s;}
@keyframes moveDory4 {
	0% {margin-left:50px;animation-timing-function:ease;}
	100% {margin-left:80px; animation-timing-function:ease-out;}
}
.position4 ul li.seaturtle {animation-name:moveSeaturtle; animation-duration:3s;}
.position4 ul li.seaturtleKid {animation-name:moveSeaturtleKid4; animation-duration:3s;}
@keyframes moveSeaturtleKid4 {
	0% {top:150px; animation-timing-function:ease;}
	100% {top:50px; animation-timing-function:ease-out;}
}
.position4 ul li.whale {animation-name:moveWhale4; animation-duration:2s;}
@keyframes moveWhale4 {
	0% {top:160px; margin-left:-407px; animation-timing-function:linear;}
	100% {top:150px; margin-left:-360px; animation-timing-function:linear;}
}
.position4 ul li.shark {animation-name:moveShark; animation-duration:3.5s;}

.position5 ul li.clownfish {top:310px; left:50%; margin-left:420px;}
.position5 ul li.dory {top:500px; left:50%; margin-left:-278px;}
.position5 ul li.bluetang {top:100px; left:50%; margin-left:-450px;}
.position5 ul li.octopus {top:697px; left:50%; margin-left:-550px;}
.position5 ul li.seaturtle {top:250px; left:50%; margin-left:-450px;}
.position5 ul li.seaturtleKid {top:100px; left:50%; margin-left:0;}
.position5 ul li.whale {top:100px; left:50%; margin-left:-807px;}
.position5 ul li.shark {top:50px; left:50%; margin-left:510px;}
.position5 ul li.stingray {top:550px; left:50%; margin-left:100px;}

.position5 ul li.dory {animation-name:moveDory5; animation-duration:1.5s;}
@keyframes moveDory5 {
	0% {margin-left:-278px;animation-timing-function:ease;}
	100% {margin-left:-208px; animation-timing-function:ease-out;}
}
.position5 ul li.seaturtle {animation-name:moveSeaturtle5; animation-duration:2s;}
@keyframes moveSeaturtle5 {
	0% {top:250px; margin-left:-450px; animation-timing-function:linear;}
	100% {top:240px; margin-left:-360px; animation-timing-function:linear;}
}
.position5 ul li.seaturtleKid {animation-name:moveSeaturtleKid5; animation-duration:3s;}
@keyframes moveSeaturtleKid5 {
	0% {top:100px; margin-left:0; animation-timing-function:linear;}
	100% {top:80px; margin-left:60px; animation-timing-function:linear;}
}
.position5 ul li.whale {animation-name:moveWhale5; animation-duration:2s; animation-delay:1s;}
@keyframes moveWhale5 {
	0% {top:100px; margin-left:-807px; animation-timing-function:linear;}
	100% {top:80px; margin-left:-707px; animation-timing-function:linear;}
}
.position5 ul li.shark {animation-name:moveShark5; animation-duration:2.5s;}
@keyframes moveShark5 {
	0% {top:50px; margin-left:510px; animation-timing-function:ease;}
	100% {top:100px;  margin-left:480px; animation-timing-function:ease-out;}
}
.position5 ul li.octopus {animation-name:moveOctopus5; animation-duration:2.5s;}
@keyframes moveOctopus5 {
	0% {margin-left:-550px; animation-timing-function:linear;}
	100% {margin-left:-500px; animation-timing-function:linear;}
}

.find .gift {position:absolute; bottom:80px; left:50%; margin-left:-450px;}

.find .win {position:absolute; bottom:438px; left:50%; width:281px; height:216px; margin-left:-140px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71111/bg_sign.png) no-repeat 50% 0;}
.find .win p {padding:24px 20px 0; color:#2d2d2d; font-family:'Gulim', '굴림', 'Arial'; font-weight:bold; line-height:2.1em; letter-spacing:-0.05em;}
.find .win p span {color:#0b27b5;}

.lyWin {display:none; position:fixed; top:50%; left:50%; z-index:105; width:401px; height:486px; margin-top:-243px; margin-left:-200px;}
.lyWin .btnClose {position:absolute; top:3px; right:10px; background-color:transparent;}
#dimmed {display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background:url(http://webimage.10x10.co.kr/eventIMG/2016/71111/bg_mask.png);}
</style>
<script type="text/javascript">
function btnClose(){
	$("#lyWin").hide();
	$("#dimmed").fadeOut();
}
function NotFindDory(){
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
	<% Else %>
		alert('앗! 저는 도리가 아니에요!');	
	<% End If %>
}

function checkform(){
	var wrapHeight = $(document).height();
	<% If vUserID = "" Then %>
		if ("<%=IsUserLoginOK%>"=="False") {
			if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
				var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
				winLogin.focus();
				return;
			}
		}
	<% End If %>
	<% If vUserID <> "" Then %>
		// 오픈시 바꿔야됨
		<% If Now() >= #06/10/2016 10:00:00# And now() < #06/22/2016 23:59:59# Then %>
			$.ajax({
				type:"GET",
				url:"/event/etc/doEventSubscript71111.asp",
				dataType: "text",
				async:false,
				cache:false,
				success : function(Data, textStatus, jqXHR){
					if (jqXHR.readyState == 4) {
						if (jqXHR.status == 200) {
							if(Data!="") {
								var str;
								for(var i in Data){
									 if(Data.hasOwnProperty(i)){
										str += Data[i];
									}
								}
								str = str.replace("undefined","");
								res = str.split("|");
								if (res[0]=="OK"){
									$("#lyWin").empty().html(res[1]);
									$("#lyWin").show();
									$("#dimmed").show();
									$("#dimmed").css("height",wrapHeight);
								} else {
									errorMsg = res[1].replace(">?n", "\n");
									alert(errorMsg);
									document.location.reload();
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
					//var str;
					//for(var i in jqXHR)
					//{
					//	 if(jqXHR.hasOwnProperty(i))
					//	{
					//		str += jqXHR[i];
					//	}
					//}
					//alert(str);
					document.location.reload();
					return false;
				}
			});
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return;				
		<% End If %>
	<% End If %>
}


$(function(){
	/* title animation */
	animation();
	$("#animation span").css({"opacity":"0"});
	$("#animation .letter2").css({"margin-top":"5px"});
	$("#animation .letter3").css({"left":"400px"});
	function animation() {
		$("#animation .letter1").delay(100).animate({"opacity":"1"},100);
		$("#animation .letter1 img").addClass("flip");
		$("#animation .letter2").delay(700).animate({"margin-top":"0", "opacity":"1"},600);
		$("#animation .letter3").delay(900).animate({"left":"369px", "opacity":"1"},1000);
	}

	/* swipe js */
	var mySwiper = new Swiper("#rolling .swiper-container",{
		loop:true,
		resizeReInit:true,
		calculateHeight:true,
		pagination:'#rolling .pagination',
		paginationClickable:true,
		speed:1200,
		autoplay:false,
		autoplayDisableOnInteraction:false,
		simulateTouch:false
	})

	$("#rolling .btn-prev").on("click", function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});

	$("#rolling .btn-next").on("click", function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});

	$("#lyWin .btnClose, #dimmed").click(function(){
		$("#lyWin").hide();
		$("#dimmed").fadeOut();
	});

	/* find random position */
	var classes = ["position1", "position2", "position3", "position4", "position5"];
	$("#find").each(function(){
		$(this).addClass(classes[~~(Math.random()*classes.length)]);
	});
});
</script>
<div class="contF contW">
	<div class="evt71111 findingDori">
		<div class="topic">
			<div class="bubble"></div>
			<div class="hgroup">
				<h2 id="animation">
					<span class="letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/tit_collabo.png" alt="텐바이텐과 도리를 찾아서" /></span>
					<span class="letter2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/tit_tenbyten_adventure_v1.png" alt="텐바이텐 어드벤처" /></span>
					<span class="letter3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_fish.png" alt="" /></span>
				</h2>
				<p class="come"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/txt_come.png" alt="무엇을 기억하든 그 이상을 까먹는 도리가 텐바이텐에 왔다!" /></p>
				<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/txt_date.png" alt="이벤트 기간은 2016년 6월 13일부터 22일까지 진행합니다." /></p>
			</div>

			<div class="navigator">
				<ul>
					<li class="nav1"><a href="/event/eventmain.asp?eventid=<%=tab1eCode%>"><span></span>Gift 선물은 비치볼<i><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_navigator_ball.png" alt="" /></i></a></li>
					<li class="nav2"><a href="/event/eventmain.asp?eventid=<%=tab2eCode%>" class="on"><span></span>Event 도리를 찾아서<i><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/img_navigator_dori.png" alt="" /></i></a></li>
					<li class="nav3"><a href="/event/eventmain.asp?eventid=<%=tab3eCode%>"><span></span>New item 도리를 내 품에</a></li>
				</ul>
			</div>
		</div>

		<%' for dev msg : 도리 찾기 %>
		<div id="find" class="find">
			<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/tit_find.png" alt="매일매일 터지는 도리의 선물! 숨은 도리를 찾아서 Click해주세요!" /></h3>
			<ul>
				<li class="clownfish"><button type="button" onclick="NotFindDory();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/img_find_clown_fish.png" alt="니모 부자" /></button></li>
				<li class="seaturtle"><button type="button" onclick="NotFindDory();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/img_find_sea_turtle.png" alt="바다거북" /></button></li>
				<li class="seaturtleKid"><button type="button" onclick="NotFindDory();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/img_find_sea_turtle_kid.png" alt="아기 바다 거북" /></button></li>
				<li class="shark"><button type="button" onclick="NotFindDory();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/img_find_shark.png" alt="상어" /></button></li>
				<li class="whale"><button type="button" onclick="NotFindDory();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/img_find_whale.png" alt="고래" /></button></li>
				<li class="stingray"><button type="button" onclick="NotFindDory();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/img_find_stingray.png" alt="가오리" /></button></li>
				<li class="bluetang"><button type="button" onclick="NotFindDory();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/img_find_blue_tang.png" alt="불루탱" /></button></li>
				<li class="dory"><button type="button" onclick="checkform();return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/img_find_dory.png" alt="도리" /></button></li>
				<li class="otter"><button type="button" onclick="NotFindDory();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/img_find_otter.png" alt="수달" /></button></li>
				<li class="octopus"><button type="button" onclick="NotFindDory();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/img_find_octopus.png" alt="문어" /></button></li>
				<li class="seal"><button type="button" onclick="NotFindDory();"><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/img_find_seal.png" alt="물개" /></button></li>
			</ul>
			<% If winItemChk <> "" Then %>
			<%
				Select Case winItemChk
					Case "11111"		winItemStr = "시사회 초대권"
					Case "22222"		winItemStr = "트럼프 카드"
					Case "33333"		winItemStr = "아이폰6 케이스"
				End Select
			%>
			<div class="win">
				<p>
					<span><%= vUserID %></span>님은 <span><%= winItemStr %></span>에<br /> 당첨되셨습니다. (당첨일: <span>6</span>월 <span>15</span>일) <br />※ 무료배송쿠폰은 마이텐바이텐에서 확인
				</p>
			</div>
			<% End If %>
			<div class="gift">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/71111/txt_gift.png" alt="숨은 도리를 찾아서 이벤트에 참여해주신 분께 텐바이텐 전용관 시사외 초대권 2매를 150분께, 도리를 찾아서 트럼프 카드 1개를 30분께, 도리를 찾아서 아이폰 케이스 1개를 30분께 컬러는 랜덤이며, 참여자 전원께 텐바이텐 무료배송 쿠폰을 드립니다." usemap="#itemlink" /></p>
				<map name="itemlink" id="itemlink">
					<area shape="rect" coords="220,2,435,275" href="/shopping/category_prd.asp?itemid=1507612&amp;pEtr=71111" alt="Finding Dory Playing cards" />
					<area shape="rect" coords="460,2,668,275" href="/event/eventmain.asp?eventid=71112" alt="도리를 찾아서 MD 상품 런칭 이벤트 보러 가기" />
					<area shape="rect" coords="686,-2,898,274" href="/my10x10/couponbook.asp" alt="텐텐 배송을 찾아서" />
				</map>
			</div>
		</div>
		<%' for dev msg : 레이어 팝업 %>
		<div id="lyWin" class="lyWin" style="display:none"></div>
		<div class="noti">
			<div class="bg">
				<div class="inner">
					<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/71110/tit_noti_v1.png" alt="이벤트 유의사항" /></h3>
					<ul>
						<li>- 오직 텐바이텐 회원님을 위한 이벤트 입니다. (로그인 후 참여가능, 비회원 참여 불가)</li>
						<li>- 한 ID당 하루에 한 번만 참여할 수 있습니다.</li>
						<li>- 당첨자 안내는 2016년 6월 24일 홈페이지에서 공지됩니다.</li>
						<li>- 이벤트 경품은 내부 사정에 의해 변경될 수 있습니다.</li>
						<li>- 당첨자와 수령자는 동일해야 하며, 양도는 불가합니다.</li>
						<li>- 정확한 발표를 위해 마이텐바이텐의 개인정보를 업데이트 해주세요.</li>
						<li>- 이벤트 종료 후 당첨된 경품의 교환 및 변경은 불가 합니다.</li>
						<li>- <b>시사회 일정은 2016년 7월 2일 (토) 3시 이며, 롯데시네마 월드타워점에서 진행됩니다.</b></li>

					</ul>
				</div>
			</div>
		</div>
		<!-- #include virtual="/event/etc/inc_DORI_Footer.asp" -->
		<div id="dimmed"></div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->