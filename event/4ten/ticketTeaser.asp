<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  [2016 정기세일] 티켓이 터진다 티져
' History : 2016.04.14 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
Dim evt_code, userid, nowdate
dim subscriptcounttotalcnt, usersubscriptcount

usersubscriptcount=0
subscriptcounttotalcnt=0
userid = GetEncLoginUserID()

nowdate = now()
'	nowdate = #04/18/2016 10:05:00#

IF application("Svr_Info") = "Dev" THEN
	evt_code   =  66104
Else
	evt_code   =  70031
End If

subscriptcounttotalcnt = getevent_subscripttotalcount(evt_code, "Y", "", "")

'//본인 참여 여부
if userid<>"" then
	usersubscriptcount = getevent_subscriptexistscount(evt_code, userid, "Y", "", "")
end if
%>
<style type="text/css">
/* 4ten common */
img {vertical-align:top;}
#contentWrap {padding:0;}
.gnbWrapV15 {height:38px;}

div.navigator {border-bottom:10px solid #a9e5d6;}

.fourtenTicket button {background-color:transparent;}

.topic {position:relative; min-height:1570px; background:#caf5e2 url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/bg_sky.jpg) no-repeat 50% 0;}
.topic .hill {position:absolute; bottom:280px; left:0; width:100%; height:280px; background-color:#c7e55f;}
.topic .hill .inner {position:absolute; bottom:0; left:0; width:100%; height:876px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_hill.png) no-repeat 50% 0;}
.topic .sea {position:absolute; bottom:0; left:0; width:100%; height:292px; padding-top:38px; background:#c3f2fa url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/bg_wave.png) repeat-x 0 0;}
.topic .sea .inner {height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/bg_sea_v1.png) no-repeat 50% 100%;}
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
.topic .hgroup .airplane {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

.ticket {position:relative; z-index:5; width:994px; height:1157px; margin:0 auto; padding-top:70px;}
.ticket .special {position:absolute; top:0; left:22px;}
.ticket h3 {position:relative; z-index:5;}
.ticket .open {position:absolute; top:150px; right:106px; z-index:10;}
.ticket .open {animation:flash infinite 1s;}
@keyframes flash {
	0% {opacity:0;}
	100% {opacity:1;}
}
.ticket .slidewrap {width:994px; height:500px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/bg_box_slide.png) no-repeat 50% 0;}
.ticket .slide {width:800px; height:500px; margin:0 auto; background-color:#fff;}
.ticket .slide .slidesjs-slide {overflow:hidden;width:800px; height:500px; position:relative; transition:background-color 0.5s;}
.ticket .slide .slidesjs-slide-01 {background-color:#c6d800;}
.ticket .slide .slidesjs-slide-01 strong {position:absolute; top:158px; left:240px;}
.ticket .slide .slidesjs-slide-01 .cloud {position:absolute; top:158px; left:220px;}
.ticket .slide .slidesjs-slide-01 .cloud {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1.2s;}
.ticket .slide .slidesjs-slide-01 .airplane2 {position:absolute; top:298px; left:340px;}
.ticket .slide .slidesjs-slide-01 .airplane2 {animation-name:move; animation-iteration-count:1; animation-duration:1.7s; animation-delay:3s;}
@keyframes move {
	from {left:340px; animation-timing-function:linear;}
	to {left:800px; animation-timing-function:linear;}
}
.ticket .slide .slidesjs-slide-02 {background-color:#26b1d1;}
.ticket .slide .slidesjs-slide-03 {background-color:#9a4d9a;}
.ticket .slide .slidesjs-slide-04 {background-color:#00a469;}
.ticket .slide .slidesjs-slide-05 {background-color:#e83f22;}
.ticket .slide .slidesjs-slide-06 {background-color:#003350;}
.ticket .slide .slidesjs-slide-07 {background-color:#26b1d1;}
.ticket .slide .slidesjs-slide-08 {background-color:#ffef00;}
.ticket .slide .slidesjs-slide-09 {background-color:#fce7f0;}
.ticket .slide .slidesjs-slide-10 {background-color:#c6d800;}
.ticket .slide .slidesjs-slide-10 .collabo {position:absolute; top:178px; left:204px;}
.ticket .slide .slidesjs-slide-10 .butterfly {position:absolute; top:296px; left:425px;}

.ticket .slide .date {position:absolute; top:216px; left:503px; z-index:10;}
.ticket .slide .city {position:absolute; top:389px; left:0; z-index:5; width:100%; text-align:center;}

.ticket .like {position:relative;}
.ticket .like .heart {overflow:hidden; position:absolute; top:30px; left:107px;}
.ticket .like .heart button, .ticket .like .heart strong, .ticket .like .heart span {float:left; margin-left:20px;}
.ticket .like .heart button {width:60px; height:52px; margin-left:10px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/ico_heart.png) no-repeat 50% 0; text-indent:-9999em;}
.ticket .like .heart button.on {background-position:50% 100%;}
.ticket .like .heart .count {color:#666; font-family:'Verdana'; font-size:26px; line-height:52px;}

.fourtenSns {position:relative; background-color:#84edc9;}
.fourtenSns button {overflow:hidden; position:absolute; top:40px; left:50%; width:225px; height:70px;}
.fourtenSns .ktShare {margin-left:90px;}
.fourtenSns .fbShare {margin-left:325px;}
</style>
<script type="text/javascript">
$(function(){
	ticketAnimation();
	$("#animation .hgroup h2, #animation .hgroup p").css({"margin-top":"7px", "opacity":"0"});
	$("#animation .airplane").css({"opacity":"0"});
	$("#animation .special").css({"top":"50px", "opacity":"0"});
	function ticketAnimation () {
		$("#animation .hgroup h2").delay(300).animate({"margin-top":"0", "opacity":"1"},500);
		$("#animation .hgroup p").delay(500).animate({"margin-top":"0", "opacity":"1"},500);
		$("#animation .airplane").delay(3000).animate({"opacity":"1"},1000);
		$("#animation .special").delay(1500).animate({"top":"0", "opacity":"1"},1000);
	}

	/* slide js */
	$("#slide").slidesjs({
		width:"800",
		height:"500",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:4000, effect:"fade", auto:true},
		effect:{fade: {speed:100, crossfade:true}},
		callback: {
			start: function() {
				$("#slide .slidesjs-slide-01 strong").css({"margin-top":"5px", "opacity":"0"});

				$("#slide .slidesjs-slide .city").css({"margin-top":"5px", "opacity":"0"});
				$("#slide .slidesjs-slide .date").css({"left":"0"});

				$("#slide .slidesjs-slide-10 .collabo").css({"margin-top":"5px", "opacity":"0"});
				$("#slide .slidesjs-slide-10 .butterfly").css({"width":"50px", "opacity":"0"});

				if ($("#slide .slidesjs-pagination li.no1 a").hasClass("active")) {
					$("#slide .slidesjs-slide-01 strong").delay(100).animate({"margin-top":"0","opacity":"1"},600);
				}

				if ($("#slide .slidesjs-pagination li a").hasClass("active")) {
					$("#slide .slidesjs-slide .date").delay(0).animate({"left":"600px","opacity":"1"},3500);
					$("#slide .slidesjs-slide .city").delay(100).animate({"margin-top":"0","opacity":"1"},600);
				}
				if ($("#slide .slidesjs-pagination li.no10 a").hasClass("active")) {
					$("#slide .slidesjs-slide-10 .collabo").delay(0).animate({"margin-top":"0","opacity":"1"},600);
						$("#slide .slidesjs-slide-10 .butterfly").delay(100).animate({"width":"184px","opacity":"1"},1000);
				}
			},
			complete: function(number) {
				var pluginInstance = $('#slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("no1");
	$(".slidesjs-pagination li:nth-child(10)").addClass("no10");
});

function jssubmit(){
	<% If IsUserLoginOK() Then %>
		<% If not( left(nowdate,10)>="2016-04-18" and left(nowdate,10)<"2016-04-28" ) Then %>
			alert("이벤트 기간이 아닙니다.");
			return;
		<% else %>
			var str = $.ajax({
				type: "POST",
				url: "/event/4ten/doeventsubscript/doEventSubscriptticketteaser.asp",
				data: "mode=addok",
				dataType: "text",
				async: false
			}).responseText;
			var str1 = str.split("||")

			if (str1[0] == "11"){
				$("#btheart").addClass("on");
				$("#btheartcnt").text(str1[1]);
				$("#btheart").text("솔로티켓 좋아요 선택됨");
			}else if (str1[0] == "12"){
				$("#btheart").removeClass("on");
				$("#btheartcnt").text(str1[1]);
				$("#btheart").text("솔로티켓 좋아요 해제됨");
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
					<div class="contF contW">

						<%'' 수작업 영역 %>
						<%'' [W] 70031 티켓이 터진다 - 티저편 %>
						<div class="fourten fourtenTicket">
							<!-- #include virtual="/event/4ten/nav.asp" -->
							<div id="animation" class="topic">
								<div class="hill"><div class="inner"></div></div>
								<div class="sea"><div class="inner"></div></div>
								<div class="frame"></div>

								<div class="hgroup">
									<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/tit_ticket.png" alt="티켓이 터진다" /></h2>
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_collabo_v1.png" alt="텐바이텐과 진에어가 함께하는 특급 콜라보레이션 4월 20일을 기대하세요!" /></p>
									<span class="airplane"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_airplane.png" alt="" /></span>
								</div>

								<div class="ticket">
									<p class="special"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_special_ticket.png" alt="스페셜 티켓 텐바이텐과 진에어" /></p>
									<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/tit_solo_ticket_v2.png" alt="솔로티켓" /></h3>
									<p class="open"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_ticket_open.png" alt="4월 20일 티켓 판매 오픈!" /></p>

									<div class="slidewrap">
										<div id="slide" class="slide">
											<div class="slidesjs-slide-01">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_slide_00.png" alt="" />
												<strong><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_solo_ticket.png" alt="솔로티켓" /></strong>
												<span class="cloud"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_cloud.png" alt="" /></span>
												<span class="airplane2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_airplane_white.png" alt="" /></span>
											</div>
											<div class="slidesjs-slide-02">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_slide_01.png" alt="세부" />
												<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_date_0420.png" alt="4월 20일 오픈" /></p>
												<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_incheon_to_cebu_v1.png" alt="인천 to 세부 214,500원 부터" /></p>
											</div>
											<div class="slidesjs-slide-03">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_slide_02.png" alt="홍콩" />
												<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_date_0421.png" alt="4월 21일 오픈" /></p>
												<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_incheon_to_hongkong_v1.png" alt="인천 to 홍콩 229,500원 부터" /></p>
											</div>
											<div class="slidesjs-slide-04">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_slide_03.png" alt="타이페이" />
												<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_date_0422.png" alt="4월 22일 오픈" /></p>
												<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_incheon_to_taipei_v1.png" alt="인천 to 타이페이 252,500원 부터" /></p>
											</div>
											<div class="slidesjs-slide-05">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_slide_04.png" alt="오사카" />
												<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_date_0423_01.png" alt="4월 23일 오픈" /></p>
												<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_busan_to_osaka_v1.png" alt="부산 to 오사카 161,100원 부터" /></p>
											</div>
											<div class="slidesjs-slide-06">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_slide_05.png" alt="다낭" />
												<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_date_0423_02.png" alt="4월 23일 오픈" /></p>
												<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_busan_to_danang_v1.png" alt="부산 to 다낭 270,100원 부터" /></p>
											</div>
											<div class="slidesjs-slide-07">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_slide_06.png" alt="세부" />
												<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_date_0423_03.png" alt="4월 23일 오픈" /></p>
												<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_busan_to_cebu_v3.png" alt="부산 to 세부 229,500원 부터" /></p>
											</div>
											<div class="slidesjs-slide-08">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_slide_07.png" alt="괌" />
												<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_date_0423_04.png" alt="4월 23일 오픈" /></p>
												<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_busan_to_guam_v1.png" alt="부산 to 괌 297,400원 부터" /></p>
											</div>
											<div class="slidesjs-slide-09">
												<img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_slide_08.png" alt="호노룰루" />
												<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_date_0424.png" alt="4월 24일 오픈" /></p>
												<p class="city"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_incheon_to_honolulu_v1.png" alt="인천 to 호노룰루517,600원 부터" /></p>
											</div>
											<div class="slidesjs-slide-10">
												<p class="collabo"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_tenbyten_jinair.png" alt="#텐바이텐과 함께 #재미있게 진에어" /></p>
												<span class="butterfly"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/img_butterfly.png" alt="" /></span>
											</div>
										</div>
									</div>

									<div class="like">
										<%'' for dev msg : 좋아요 카운트 %>
										<div id="heart" class="heart">
											<button type="button" id="btheart" onclick="jssubmit(); return false;" <% if usersubscriptcount > 0 then %>class="btnHeart on"<% else %>class="btnHeart"<% end if %>>솔로티켓 좋아요 해제됨</button>
											<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_like_solo_ticket.png" alt="" /></span>
											<strong class="count" id="btheartcnt" ><%= subscriptcounttotalcnt %></strong>
										</div>
										<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_msg_v3.png" alt="#04월20일 #오픈 #한정수량 #왕복티켓 #텐바이텐과 함께 #재미있게 진에어 #스페셜티켓시리즈 #1 #나혼자떠나는즐거움 #혼자서도당당하게 #솔로티켓 #최저가 #4/20 인천 출발 세부 214,500원부터 #4/21 인천 출발 홍콩 229,500원부터 #4/22 인천 출발 타이베이 52,500원부터 #4/23 부산 출발 오사카 다낭 세부 괌 161,100원부터 #4/24 인천 출발 하와이 517,600원부터" /></p>
									</div>

									<p><a href="https://www.instagram.com/your10x10/" target="_blank" title="텐바이텐 인스타그램 새창 열림"><img src="http://webimage.10x10.co.kr/eventIMG/2016/fourten/70031/txt_instagram.png" alt="#재미있게진에어 #텐바이텐과함께 인스타그램에 솔로티켓 패키지 인증샷을 올려주세요" /></a></p>
								</div>
							</div>

							<!-- #include virtual="/event/4ten/sns.asp" -->
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