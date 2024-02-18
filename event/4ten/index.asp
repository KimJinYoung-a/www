<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->

<%
'####################################################
' Description : 2016 포텐이 터진다. index
' History : 2016-04-15 유태욱
'####################################################
dim nowdate
nowdate = now()
'	nowdate = #04/18/2016 10:05:00#

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

.fourtenIntro button {background-color:transparent;}

.fourtenIntro {background:#bbf4ff url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/bg_sky_v1.png) no-repeat 50% 0;}
.fourtenIntro .article {overflow:hidden;}
.fourtenIntro .frame {position:absolute; top:47px; left:50%; width:1945px; height:1306px; margin-left:-979px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_flame.png) no-repeat 50% 0;}
.fourtenIntro .frame {animation-name:twinkle; animation-duration:4s;}

.article {position:relative; height:1896px}
.article .topic {position:relative; height:390px;}
.article .topic .moving {position:absolute; top:67px; left:50%; margin-left:-316px; animation-name:moving; animation-duration:2s;}
.article .topic .dDay {position:absolute; top:177px; left:50%; margin-left:226px;}
.article .topic .dDay {animation-name:flash2; animation-iteration-count:infinite; animation-duration:0.9s; animation-fill-mode:both;}
@keyframes flash2 {
	0% {opacity:0;}
	100% {opacity:1;}
}

.article .topic h2 {position:absolute; top:205px; left:50%; width:502px; height:166px; margin-left:-248px;}
.article .topic h2 span {position:absolute; top:0; left:0;}
.article .topic h2 .letter2 {width:502px; height:166px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/tit_4ten.png) no-repeat 50% 0; animation-duration:0.5s;}

.article .topic .date {position:absolute; top:373px; left:50%; margin-left:-102px;}
.article .topic .airballoon {position:absolute; top:148px; left:50%; margin-left:342px;}
.article .topic .airballoon {animation-name:updown3; animation-duration:1s; animation-delay:0.5s;}

.article .event4ten {position:relative; height:1081px;}
.article .event4ten .cloud {position:absolute; top:51px; left:50%; z-index:5; width:1849px; height:1026px; margin-left:-895px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_cloud_01.png) no-repeat 50% 0;}
.article .event4ten .cloud2 {position:absolute; top:275px; left:50%; z-index:20; margin-left:125px;}
.article .event4ten ul {position:relative; *z-index:15; height:1081px;}
.article .event4ten ul li {position:absolute; left:50%;}
.article .event4ten ul li a {display:block; position:absolute; top:0; left:0; width:100%; height:100%; z-index:15; cursor:pointer;}
.article .event4ten ul li.event1 {top:50px; margin-left:-530px;}
.article .event4ten ul li.event1 a {overflow:hidden; left:5px; width:300px;}
.article .event4ten ul li.event2 {top:120px; margin-left:-155px;}
.article .event4ten ul li.event3 {top:553px; margin-left:-530px;}
.article .event4ten ul li.event4 {top:623px; margin-left:-155px;}
.article .event4ten ul li.event5 {top:555px; margin-left:220px;}
.article .event4ten ul li.event6 {top:0; z-index:25; margin-left:210px;}
.article .event4ten ul li.event6 {animation-name:bounce; animation-duration:2.5s;}

.article .event4ten ul li a .ani {position:absolute; top:28px; left:0; opacity:0; filter:alpha(opacity=0);}
.article .event4ten ul li a:hover .ani {opacity:1; filter:alpha(opacity=100);}

.article .event4ten ul li.event1 .airplane {position:absolute; top:123px; left:172px; animation-name:moveairplane; animation-duration:7s;}
.article .event4ten ul li.event1 .bus {position:absolute; top:250px; left:85px; animation-name:movebus; animation-duration:15s;}
.article .event4ten ul li.event1 .ani {position:absolute; top:28px; left:0;}
@keyframes movebus {
	0% {left:320px; animation-timing-function:linear;}
	100% {left:-50px; animation-timing-function:linear;}
}
@keyframes moveairplane {
	0% {top:123px; left:300px; animation-timing-function:linear;}
	100% {top:0px; left:-50px; animation-timing-function:linear;}
}

.article .event4ten ul li.event2 .ani {position:absolute; left:5px; opacity:1; filter:alpha(opacity=100);}
.article .event4ten ul li.event2 .over {opacity:0; filter:alpha(opacity=0);}
.article .event4ten ul li.event2 .line {position:absolute; top:54px; left:52px; width:217px; height:0; transition:height 0.5s; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_line.png) no-repeat 0 0;}
.article .event4ten ul li.event2 .flash {position:absolute; top:33px; left:29px; opacity:0; filter:alpha(opacity=0);}
.article .event4ten ul li.event2 a:hover .over {opacity:1; filter:alpha(opacity=100);}
.article .event4ten ul li.event2 a:hover .line {height:221px;}
.article .event4ten ul li.event2 a:hover .flash {opacity:1; filter:alpha(opacity=100); animation-name:flash; animation-duration:1.5s; animation-delay:1s;}

.article .event4ten ul li.event3 .ani {left:5px; opacity:1; filter:alpha(opacity=100);}
.article .event4ten ul li.event3 .heart {position:absolute; top:121px; left:75px;}
.article .event4ten ul li.event3 .heart2 {top:86px; left:166px;}
.article .event4ten ul li.event3 a:hover .heart {animation-name:bounce; animation-duration:1.2s;}
.article .event4ten ul li.event3 a:hover .heart2 {animation-delay:0.5s;}

.article .event4ten ul li.event4 a {overflow:hidden; left:5px; width:300px;}
.article .event4ten ul li.event4 span {position:absolute;}
.article .event4ten ul li.event4 .clock {top:172px; left:45px; z-index:10; animation-name:shake; animation-duration:2s;}
.article .event4ten ul li.event4 .arrow {top:49px; left:170px; animation-name:bounce; animation-duration:0.8s;}
.article .event4ten ul li.event4 .coin {top:162px; left:99px; z-index:5; animation-iteration-count:1;}
.article .event4ten ul li.event4 a:hover .coin {animation-name:rollIn; animation-duration:1.5s;}

.article .event4ten ul li.event5 .ani {left:5px; opacity:1; filter:alpha(opacity=100);}
.article .event4ten ul li.event5 .over {opacity:0; filter:alpha(opacity=0);}
.article .event4ten ul li.event5 a:hover .over {opacity:1; filter:alpha(opacity=100);}

.lyCoupon {display:none; position:fixed; top:50%; left:50%; z-index:105; width:437px; height:729px; margin-top:-364px; margin-left:-218px;}
.lyCoupon .balloon {position:absolute; top:0; left:50%; margin-left:-113px;}
.lyCoupon .balloon {animation-name:updown; animation-duration:1.5s;}

.lyCoupon p {position:relative; z-index:50; padding-top:230px;}
.lyCoupon .btnClose {position:absolute; top:230px; right:21px; z-index:160; width:50px; height:50px;}
.lyCoupon .btnCoupon {position:absolute; z-index:50; bottom:90px; left:50%; margin-left:-102px;}

#dimmed {display:none; position:fixed; top:0; left:0; width:100%; height:100%; z-index:100; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/bg_mask.png);}

.fourtenIntro .tentenTown {position:absolute; bottom:0; left:0; width:100%; height:253px; background-color:#fff2bc;}
.fourtenIntro .tentenTown .inner {position:absolute; bottom:0; left:0; width:100%; height:495px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/bg_town_v6.png) no-repeat 50% 0;}

.fourtenIntro .tentenTown .bnr li {position:absolute; left:50%;}
.fourtenIntro .tentenTown .bnr .bnr1 {top:359px; z-index:5; margin-left:-398px;}
.fourtenIntro .tentenTown .bnr .bnr2 {top:330px; margin-left:226px;}
.fourtenIntro .tentenTown .bnr .bnr2 {animation-name:move; animation-duration:10s;}
.fourtenIntro .tentenTown .bnr .bnr2:hover {animation-play-state:paused;}
@keyframes move {
	0% {margin-left:550px; animation-timing-function:linear;}
	50% {margin-left:226px; animation-timing-function:linear;}
	100% {margin-left:550px; animation-timing-function:linear;}
}
.fourtenIntro .tentenTown .tenten {position:absolute; top:151px; left:50%; margin-left:-70px;}
.fourtenIntro .tentenTown .windmill {position:absolute; top:105px; left:50%; margin-left:-848px;}
.fourtenIntro .tentenTown .ferriswheel {position:absolute; top:118px; left:50%; margin-left:441px;}
.fourtenIntro .tentenTown .duck {position:absolute; top:333px; left:50%; margin-left:-353px;}
.fourtenIntro .tentenTown .balloon {display:none; position:absolute; top:320px; left:50%; margin-left:60px;}
.fourtenIntro .tentenTown .rocket {position:absolute; top:334px; left:50%; margin-left:542px;}
.fourtenIntro .tentenTown .horse {position:absolute; top:284px; left:50%; margin-left:348px; animation-name:updown3; animation-duration:3s;}
.fourtenIntro .tentenTown .horse2 {margin-left:316px; animation-name:updown2; animation-delay:1s;}

.fourtenSns {position:relative; background-color:#84edc9;}
.fourtenSns button {overflow:hidden; position:absolute; top:40px; left:50%; width:225px; height:70px;}
.fourtenSns .ktShare {margin-left:90px;}
.fourtenSns .fbShare {margin-left:325px;}

/* css3 animaiton */
.animated {animation-iteration-count:infinite; animation-fill-mode:both;}

@keyframes rollIn {
	0% {transform:translateX(50%);}
	100% {transform:translateX(0px);}
}

@keyframes shake {
	0%, 100% {transform:translateX(0) translatey(0);}
	10%, 30%, 50%, 70%, 90% {transform:translateX(-3px);}
	20%, 40%, 60%, 80% {transform:translateX(3px);}
}

@keyframes flash {
	0%, 50%, 100% {opacity:1;}
	25%, 75% {opacity:0;}
}

@keyframes pulse {
	0% {transform:scale(1);}
	100% {transform:scale(1.2);}
}
.pulse {animation-name:pulse; animation-duration:1s;}

@keyframes updown {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-10px; animation-timing-function:ease-in;}
}
@keyframes updown2 {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-3px; animation-timing-function:ease-in;}
}
@keyframes updown3 {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:2px; animation-timing-function:ease-in;}
}

@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:8px; animation-timing-function:ease-in;}
}

@keyframes moving {
	from, to{ margin-left:-316px; animation-timing-function:ease-out;}
	50% {margin-left:-326px; animation-timing-function:ease-in;}
}

@keyframes twinkle {
	0% {opacity:0;}
	30% {opacity:0.5;}
	50% {opacity:1;}
	70% {opacity:0.5;}
	100% {opacity:0.8;}
}

@keyframes swing {
	20% {transform:rotate(2deg);}
	40% {transform:rotate(-2deg);}
	60% {transform:rotate(2deg);}
	80% {transform:rotate(-2deg);}
	100% {transform:rotate(0deg);}
}
.swing {animation-name:swing; animation-duration:5s; transform-origin:50% 50%;}

.spin {animation:spin 10s linear infinite;}
@keyframes spin {100% { -webkit-transform: rotate(360deg); transform:rotate(360deg);}}
</style>
<script type="text/javascript">
$(function(){
	/* layer */
	var wrapHeight = $(document).height();

	$("#lyCoupon .btnClose, #dimmed").click(function(){
		$("#lyCoupon").hide();
		$("#dimmed").fadeOut();
	});

/*
	animation();
	$("#animation .moving").css({"left":"51%", "opacity":"0"});
	$("#animation h2 span").css({"opacity":"0"});
	function animation () {
		$("#animation .moving").delay(600).animate({"left":"50%", "opacity":"1"},1000);
		$("#animation h2 .letter2").delay(100).animate({"opacity":"0.1"},100);
		$("#animation h2 .letter1").delay(600).animate({"opacity":"1"},500);
		$("#animation h2 .letter2").delay(600).animate({"opacity":"0"},300);
	}
*/
});

function jsDownCoupon4ten(stype,idx){
	<% If IsUserLoginOK() Then %>
		<% If not( left(nowdate,10)>="2016-04-18" and left(nowdate,10)<"2016-04-28" ) Then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/4ten/couponshop_process.asp",
				data: "mode=cpok&stype="+stype+"&idx="+idx,
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")
			if (str1[0] == "11"){
				var wrapHeight = $(document).height();
				$("#lyCoupon").show();
				$("#dimmed").show();
				$("#dimmed").css("height",wrapHeight);
			}else if (str1[0] == "12"){
				alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
				return false;
			}else if (str1[0] == "13"){
				alert('이미 다운로드 받으셨습니다.');
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
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container fullEvt">
		<div id="contentWrap">
			<div class="eventWrapV15">

				<div class="eventContV15">
					<%'' event area(이미지만 등록될때 / 수작업일때)  %>
					<div class="contF contW">

						<%'' [W] 70028 터져라 포텐 인트로 %>
						<div class="fourten fourtenIntro">
							<div class="article">
								<div class="frame animated"></div>

								<div id="animation" class="topic">
									<%' for dev msg : 20160422 4월 23일까지만 보여집니다. %>
									<% If nowdate < "2016-04-24" Then %>
										<p class="animated moving"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_april.png" alt="4월의 텐바이텐에 엄청난 일이 터진다!" /></p>
									<% Else %>
										<p class="animated moving"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_april_soon_closed.png" alt="텐바이텐 정기세일이 얼마 남지 않았습니다!" /></p>
										<% If nowdate >= "2016-04-24" And nowdate < "2016-04-25" Then %>
											<%' for dev msg :20160422 4월 24일부터 보여주세요 %>
											<p class="dDay">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_label_dday_03.png" alt="3일 남았습니다." />
											</p>
										<% ElseIf nowdate >= "2016-04-25" And nowdate < "2016-04-26" Then %>
											<p class="dDay">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_label_dday_02.png" alt="2일 남았습니다." />
											</p>
										<% ElseIf nowdate >= "2016-04-26" And nowdate < "2016-04-27" Then %>										
											<p class="dDay">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_label_dday_01.png" alt="1일 남았습니다." />
											</p>
										<% ElseIf nowdate >= "2016-04-27" And nowdate < "2016-04-28" Then %>	
											<p class="dDay">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_label_dday_00.png" alt="금일 종료됩니다." />
											</p>
										<% End If %>
									<% End If %>
									<h2>
										<span class="letter1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/tit_4ten.png" alt="터져라 포텐" /></span>
										<!--span class="letter2 pulse"></span-->
									</h2>
									<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_date.png" alt="2016년 4월 18일부터 4월 27일 열흘간 진행됩니다." /></p>
									<span class="airballoon animated bounce"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_hot_air_balloon.png" alt="" /></span>
								</div>

								<div id="event4ten" class="event4ten">
									<span class="cloud"></span>
									<span class="cloud2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_cloud_02.png" alt="" /></span>
									<ul>
										<li class="event1">
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_4ten_ticket.png" alt="티켓이 터진다 텐바이텐과 진에어가 함께하는 특급 콜라보레이션!" /></p>
											<% if left(nowdate,10) < "2016-04-20" then %>
												<a href="/event/4ten/ticketTeaser.asp">
											<% else %>
												<a href="/event/4ten/ticketGet.asp">
											<% end if %>
												<span class="ani"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_ani_ticket.gif" alt="" /></span>
												<span class="airplane animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_airplane.png" alt="" /></span>
												<span class="bus animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_bus.png" alt="" /></span>
											</a>
										</li>
										<li class="event2">
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_4ten_bingo.png" alt="빙고빙고 매일 출석하고 빙고를 완성하면 푸짐한 선물들이 쏟아진다!" /></p>
											<a href="/event/4ten/bingo.asp">
												<span class="ani"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_ani_bingo.gif" alt="" /></span>
												<span class="ani over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_ani_bingo_over.png" alt="" /></span>
												<span class="line"></span>
												<span class="flash animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_flash.png" alt="" /></span>
											</a>
										</li>
										<li class="event3">
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_4ten_gift.png" alt="신난다 팡팡 4월에 쇼핑하면 즐거운 사은품이 팡팡!" /></p>
											<a href="/event/4ten/gift.asp">
												<span class="ani"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_ani_gift.gif" alt="" /></span>
												<span class="heart heart1 animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_heart_green.png" alt="" /></span>
												<span class="heart heart2 animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_heart_red.png" alt="" /></span>
											</a>
										</li>
										<li class="event4">
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_4ten_price_v1.png" alt="가격이 터진다 할인에 도전하라 모일수록 가격이 떨어진다!" /></p>
											<a href="/event/4ten/price.asp">
												<span class="clock animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_clock.png" alt="" /></span>
												<span class="arrow animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_arrow_down_v1.png" alt="" /></span>
												<span class="coin animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_coin_v1.png" alt="" /></span>
												<span class="ani"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_ani_price_v2.gif" alt="" /></span>
											</a>
										</li>
										<li class="event5">
											<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_4ten_redpang.png" alt="레드팡 레드컬러를 인증하면 기프트 카드가 팡팡!" /></p>
											<a href="/event/4ten/color.asp">
												<span class="ani"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_ani_redpang_off.gif" alt="" /></span>
												<span class="ani over"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_ani_redpang.gif" alt="" /></span>
											</a>
										</li>
										<%'' for dev msg : 쿠폰 다운 받기  %>
										<li class="event6 animated">
											<a href="#lyCoupon" onclick="javascript:jsDownCoupon4ten('prd,prd,prd,prd,prd','11554,11555,11556,11557,11566');"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_4ten_coupon.png" alt="최대 30% 할인 쿠폰 모두 다운받기" /></a>
										</li>
									</ul>
								</div>

								<%'' for dev msg : 쿠폰 다운 레이어  %>
								<div id="lyCoupon" class="lyCoupon">
									<div class="balloon animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_balloon.png" alt="" /></div>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/txt_coupon_done.png" alt="쿠폰 발급 완료 최대 30% 발급받은 쿠폰은 쿠폰함에서 확인할 수 있습니다" /></p>
									<a href="/my10x10/couponbook.asp" class="btnCoupon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/btn_coupon.png" alt="쿠폰함 바로가기" /></a>
									<button type="button" class="btnClose"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/btn_close.png" alt="쿠폰다운 받기 레이어팝업 닫기" /></button>
								</div>

								<div class="tentenTown">
									<div class="inner">
										<ul class="bnr">
											<li class="bnr1"><a href="/award/awardlist.asp?gaparam=main_menu_best"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_bnr_best.png" alt="베스트상품" /></a></li>
											<li class="bnr2 animated"><a href="/event/eventmain.asp?eventid=70282"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_bnr_free.png" alt="무료배송" /></a></li>
										</ul>
										<span class="tenten swing animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_logo_tenten.png" alt="10X10" /></span>
										<span class="windmill spin"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_windmill_wing.png" alt="" /></span>
										<span class="ferriswheel"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_ani_ferris_wheel.gif" alt="" /></span>
										<span class="duck"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_ani_duck.gif" alt="" /></span>
										<span class="balloon"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_ani_balloon.gif" alt="" /></span>
										<span class="rocket"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_rocket.png" alt="" /></span>
										<span class="horse horse1 animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_horse_01.png" alt="" /></span>
										<span class="horse horse2 animated"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70028/img_horse_02.png" alt="" /></span>
									</div>
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