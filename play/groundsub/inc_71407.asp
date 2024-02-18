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
' Description : PLAY #31-3
' History : 2016-06-17 김진영 생성
'####################################################
Dim eCode, userid, sqlstr, totcnt, pagereload, todayCnt
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66155
Else
	eCode   =  71407
End If

pagereload	= requestCheckVar(request("pagereload"),2)
userid		= GetEncLoginUserID()

sqlstr = ""
sqlstr = sqlstr & " SELECT count(*) as CNT "
sqlstr = sqlstr & " FROM [db_event].[dbo].[tbl_event_subscript]"
sqlstr = sqlstr & " WHERE evt_code="& eCode &""
sqlstr = sqlstr & " and userid='"& userid &"' and datediff(day,regdate,getdate()) = 0 and sub_opt1 = 1 "
rsget.Open sqlstr, dbget, 1
If Not(rsget.bof Or rsget.Eof) Then
	todayCnt = rsget("CNT")
End If
rsget.Close

sqlstr = ""
sqlstr = sqlstr & " SELECT count(*) as CNT "
sqlstr = sqlstr & " FROM [db_event].[dbo].[tbl_event_subscript]"
sqlstr = sqlstr & " WHERE evt_code="& eCode &""
rsget.Open sqlstr, dbget, 1
If Not(rsget.bof Or rsget.Eof) Then
	totcnt = rsget("CNT")
End If
rsget.Close

'// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
Dim vTitle, vLink, vPre, vImg
Dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
snpTitle	= Server.URLEncode("물마신 횟수를 체크할 수 있는 수다타임 코스터로 수다타임을 갖자!")
snpLink		= Server.URLEncode("http://www.10x10.co.kr/play/playGround.asp?gidx=31&gcidx=128")
snpPre		= Server.URLEncode("텐바이텐")
snpTag		= Server.URLEncode("텐바이텐")
snpTag2		= Server.URLEncode("#10x10")
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background-color:#ace0f4;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}

.waterTime {position:relative;}

.waterTime .topic {position:relative; height:700px; background-color:#ace0f4;}
.waterTime .topic h3 {position:absolute; top:225px; left:50%; width:248px; height:272px; margin-left:-390px;}
.waterTime .topic h3 span {position:absolute; width:71px; height:78px; background:url(http://webimage.10x10.co.kr/play/ground/20160620/tit_water_time.png) no-repeat 0 0; text-indent:-9999em;}
.waterTime .topic h3 .letter1 {top:0; left:0;}
.waterTime .topic h3 .letter2 {top:0; right:0; width:70px; height:81px; background-position:100% 0;}
.waterTime .topic h3 .letter3 {top:121px; left:0; width:68px; height:82px; background-position:0 -121px;}
.waterTime .topic h3 .letter4 {top:121px; right:0; width:61px; background-position:-181px -121px;}
.waterTime .topic h3 .letter5 {bottom:0; left:0; width:248px; height:23px; background-position:100% 100%;}
.waterTime .topic .cup {position:absolute; top:190px; left:50%; margin-left:233px;}
.waterTime .topic .cup {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.8s;}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:3px; animation-timing-function:ease-in;}
}

.waterTime .topic .desc {position:absolute; top:264px; left:50%; margin-left:85px;}

.waterTime .facebook {position:absolute; top:60px; left:50%; z-index:50; margin-left:510px;}
.waterTime .facebook a:hover img {animation-name:pulse; animation-duration:1s; -webkit-animation-name:pulse; -webkit-animation-duration:1s;}
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(1.1);}
	100% {transform:scale(1);}
}

.rolling .swiper {position:relative; height:895px;}
.rolling .swiper .label {position:absolute; top:0; left:50%; z-index:50; width:423px; height:215px; margin-left:-211px; background:url(http://webimage.10x10.co.kr/play/ground/20160620/ico_water_v2.png);}
.rolling .swiper .label span {display:block; position:absolute; top:116px; left:50%; width:56px; height:64px; margin-left:-28px; background:url(http://webimage.10x10.co.kr/play/ground/20160620/img_no_01.png) no-repeat 0 0;}
.rolling .swiper .swiper-container {overflow:hidden; height:895px;}
.rolling .swiper .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {overflow:hidden; float:left; position:relative; width:100%; height:895px; background:#f4f4f4 url(http://webimage.10x10.co.kr/play/ground/20160620/img_slide_01.jpg) no-repeat 50% 0;}
.rolling .swiper .swiper-slide-02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160620/img_slide_02.jpg);}
.rolling .swiper .swiper-slide-03 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160620/img_slide_03.jpg);}
.rolling .swiper .swiper-slide-04 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160620/img_slide_04.jpg);}
.rolling .swiper .swiper-slide-05 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160620/img_slide_05.jpg);}
.rolling .swiper .swiper-slide-06 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160620/img_slide_06.jpg);}
.rolling .swiper .swiper-slide-07 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160620/img_slide_07.jpg);}
.rolling .swiper .swiper-slide-08 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160620/img_slide_08.jpg);}
.rolling .swiper .swiper-slide-09 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160620/img_slide_09.jpg);}
.rolling .swiper .swiper-slide .story {position:absolute; top:333px;z-index:20; left:50%; margin-left:127px;}
.rolling .swiper .pagination {overflow:hidden; position:absolute; bottom:185px; z-index:20; left:50%; width:224px; margin-left:130px;}
.rolling .swiper .pagination span {float:left; width:10px; height:10px; margin-right:10px; border-radius:50%; background-color:#dedede; cursor:pointer; transition:all 0.3s;}
.rolling .swiper .pagination .swiper-active-switch {width:28px; border-radius:14px; background-color:#00a2de;}
.rolling .btn-nav {position:absolute; top:19px; left:50%; z-index:50; width:80px; height:101px; background:url(http://webimage.10x10.co.kr/play/ground/20160620/btn_nav.png); text-indent:-9999em;}
.rolling .btn-prev {margin-left:-154px;}
.rolling .btn-prev:hover {background-position:0 100%;}
.rolling .btn-next {margin-left:76px; background-position:100% 0;}
.rolling .btn-next:hover {background-position:100% 100%;}

.item {background-color:#90c1d3; text-align:center;}

.waterTime .event {position:relative; height:387px; padding-top:413px; background:#eeeeec url(http://webimage.10x10.co.kr/play/ground/20160620/img_visual.jpg) 50% 0 no-repeat; text-align:center;}
.waterTime .event .btnEnter,
.waterTime .event .done {position:absolute; top:564px; left:50%; margin-left:-151px;}
.waterTime .event .count {margin-top:160px;}
.waterTime .event .count b {margin:0 6px 0 2px; color:#94c24b; font-size:30px; font-style:italic; line-height:28px;}
</style>
<script type="text/javascript">
$(function(){
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 300) {
			animation();
		}
	});
	/* title animation */
	$("#animation span").css({"margin-top":"5px", "opacity":"0"});
	$("#animation .letter5").css({"margin-top":"0", "margin-bottom":"5px", "opacity":"0"});
	function animation () {
		$("#animation .letter1").delay(100).animate({"margin-top":"0", "opacity":"1"},500);
		$("#animation .letter2").delay(300).animate({"margin-top":"0", "opacity":"1"},500);
		$("#animation .letter3").delay(500).animate({"margin-top":"0", "opacity":"1"},500);
		$("#animation .letter4").delay(800).animate({"margin-top":"0", "opacity":"1"},500);
		$("#animation .letter5").delay(1200).animate({"margin-bottom":"0", "opacity":"1"},600);
	}

	var $win = $(window);
	var top = $(window).scrollTop(); // 현재 스크롤바의 위치값

	/*사용자 설정 값 시작*/
	var speed = 'normal'; // 따라다닐 속도 : "slow", "normal", or "fast" or numeric(단위:msec)
	var easing = 'linear'; // 따라다니는 방법 기본 두가지 linear, swing
	var $layer = $("#btnFacebook"); // 레이어 셀렉팅
	var layerTopOffset = 0; // 레이어 높이 상한선, 단위:px
	$layer.css('position', 'absolute');
	/*사용자 설정 값 끝*/

	// 스크롤 바를 내린 상태에서 리프레시 했을 경우를 위해
	if (top > 0 )
		$win.scrollTop(layerTopOffset+top);
	else
		$win.scrollTop(0);

	//스크롤이벤트가 발생하면
	$(window).scroll(function(){
		yPosition = $win.scrollTop() - 200;
		if (yPosition < 0) {
			yPosition = 0;
		}
		$layer.animate({"top":yPosition }, {duration:1000, easing:easing, queue:false});
	});

	/* swiper js */
	var mySwiper = new Swiper("#rolling .swiper-container",{
		mode:'vertical',
		loop:true,
		resizeReInit:true,
		calculateHeight:true,
		pagination:"#rolling .pagination",
		paginationClickable:true,
		speed:1500,
		autoplay:2000,
		onSlideChangeStart: function (swiper1) {
			if ($(".swiper-slide-active").is(".swiper-slide-01")) {
				$(".rolling .swiper .label span").css("background","url(http://webimage.10x10.co.kr/play/ground/20160620/img_no_01.png) no-repeat 0 0");
			}
			if ($(".swiper-slide-active").is(".swiper-slide-02")) {
				$(".rolling .swiper .label span").css("background","url(http://webimage.10x10.co.kr/play/ground/20160620/img_no_02.gif) no-repeat 0 0");
			}
			if ($(".swiper-slide-active").is(".swiper-slide-03")) {
				$(".rolling .swiper .label span").css("background","url(http://webimage.10x10.co.kr/play/ground/20160620/img_no_03.gif) no-repeat 0 0");
			}
			if ($(".swiper-slide-active").is(".swiper-slide-04")) {
				$(".rolling .swiper .label span").css("background","url(http://webimage.10x10.co.kr/play/ground/20160620/img_no_04.gif) no-repeat 0 0");
			}
			if ($(".swiper-slide-active").is(".swiper-slide-05")) {
				$(".rolling .swiper .label span").css("background","url(http://webimage.10x10.co.kr/play/ground/20160620/img_no_05.gif) no-repeat 0 0");
			}
			if ($(".swiper-slide-active").is(".swiper-slide-06")) {
				$(".rolling .swiper .label span").css("background","url(http://webimage.10x10.co.kr/play/ground/20160620/img_no_06.gif) no-repeat 0 0");
			}
			if ($(".swiper-slide-active").is(".swiper-slide-07")) {
				$(".rolling .swiper .label span").css("background","url(http://webimage.10x10.co.kr/play/ground/20160620/img_no_07.gif) no-repeat 0 0");
			}
			if ($(".swiper-slide-active").is(".swiper-slide-08")) {
				$(".rolling .swiper .label span").css("background","url(http://webimage.10x10.co.kr/play/ground/20160620/img_no_08.gif) no-repeat 0 0");
			}
		}
	});

	$("#rolling .btn-prev").on("click", function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});

	$("#rolling .btn-next").on("click", function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});
});
</script>
<script type="text/javascript">
<!--

function vote_play(){
	var frm = document.frmvote;

	<% If Not(IsUserLoginOK) Then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% End If %>

	<% If not(left(now(),10)>="2016-06-17" and left(now(),10)<"2016-06-27" ) Then %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% Else %>
		<% If todayCnt > 0 Then %>
			alert("하루에 한 번만 응모가 가능 합니다.");
			return;
		<% Else %>
			frm.action = "/play/groundsub/doEventSubscript71407.asp";
			frm.target="frmproc";
			frm.submit();
			return;
		<% End If %>
	<% End If %>
}
//-->
</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20160613 waterTime">
		<form name="frmvote" method="post">
		<input type="hidden" name="mode" value="add"/>
		<input type="hidden" name="pagereload" value="ON"/>
		</form>
			<div class="topic">
				<h3 id="animation">
					<span class="letter1">수</span>
					<span class="letter2">다</span>
					<span class="letter3">타</span>
					<span class="letter4">임</span>
					<span class="letter5">물 마시는 시간</span>
				</h3>
				<span class="cup"><img src="http://webimage.10x10.co.kr/play/ground/20160620/img_cup.png" alt="" /></span>
				<p class="desc"><img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_desc_v1.png" alt="오늘 하루, 물 몇 잔 마셨나요? 물을 많이 마시면 좋다는 이야기는 많이 들었지만, 생각보다 실천이 잘 안되셨죠? 텐바이텐 Play에서 물 마신 횟수를 체크할 수 있는 수다 타임 코스터&amp;컵 세트를 준비했습니다. 나만의 수다 타임을 정해놓고 수다 타임 세트를 이용해 하루 물 8잔을 채워 보세요!" /></p>
			</div>

			<div id="btnFacebook" class="facebook">
				<a href="" onclick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160620/ico_facebook.png" alt="페이스북에 수다타임 공유하기" /></a>
			</div>

			<div id="rolling" class="rolling">
				<div class="swiper">
					<div class="label"><span></span></div>
					<div class="swiper-container swiper1">
						<div class="swiper-wrapper">
							<div class="swiper-slide swiper-slide-01">
								<p class="story"><img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_story_01.png" alt="am7 아침에 일어나 물 한 잔으로 하루 시작! 아침에 일어나 마시는 물은 우리 몸에 보약! 밤 사이 축적된 노폐물을 배출시켜, 몸 속 신진대사를 촉진시키고, 혈액순환을 도와줍니다." /></p>
							</div>
							<div class="swiper-slide swiper-slide-02">
								<p class="story"><img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_story_02.png" alt="am9 아침 먹기 30분 전에 물 한잔! 식사 30분 전에 물을 마시면 잠들었던 체내의 기관들이 일어납니다. 식사를 거르더라도 물은 마셔주세요!" /></p>
							</div>
							<div class="swiper-slide swiper-slide-03">
								<p class="story"><img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_story_03.png" alt="am11 오전 일과 중, 가볍게 물 한 잔을 바쁜 업무로 집중력이 흐려질 때쯤 가볍게 물 한 잔 마셔 보세요 정신이 맑아지고 신체기능을 높여 업무 효율 UP!" /></p>
							</div>
							<div class="swiper-slide swiper-slide-04">
								<p class="story"><img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_story_04.png" alt="pm12 기다리던 점심시간 30분 전, 물 한 잔! 점심 먹기 30분 전에 물 한 잔 마셔보세요 포만감 때문에 과식도 방지하고 소화를 촉진시켜 다이어트 효과가 있어요" /></p>
							</div>
							<div class="swiper-slide swiper-slide-05">
								<p class="story"><img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_story_05.png" alt="pm16 오후 일과 중, 시원한 물 한잔! 지칠 때쯤 과일을 넣어 마셔보세요! 수분이 채워지면 피로가 풀리고 심장의 혈액 공급을 활발하게 해주어 업무 효율을 높여줘요" /></p>
							</div>
							<div class="swiper-slide swiper-slide-06"> 
								<p class="story"><img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_story_06.png" alt="pm18 퇴근 전, 물 한잔 마시고 집으로 떠나요! 퇴근 5분 전 물 한 잔으로 마무리하세요 저녁 과식을 방지해줘 성인병을 예방하는데 도움을 줘요!" /></p>
							</div>
							<div class="swiper-slide swiper-slide-07">
								<p class="story"><img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_story_07.png" alt="pm18 느릿느릿 산책 후 시원하게 물 한잔! 운동 후 마시는 물은 몸에 수분을 채워줘 활력을 준다고 해요 짧은 산책에도 꼭 물 한잔 마셔 보세요!" /></p>
							</div>
							<div class="swiper-slide swiper-slide-08">
								<p class="story"><img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_story_08.png" alt="pm21 자기 전, 물 한 잔으로 하루를 마무리! 잠자기 전에 물을 마셔주면 자는 동안 신진대사를 원활하게 하고 혈액 정화, 피로회복에 도움이 돼요!" /></p>
							</div>
						</div>
					</div>
					<div class="pagination"></div>
					<button type="button" class="btn-nav btn-prev">Previous</button>
					<button type="button" class="btn-nav btn-next">Next</button>
				</div>
			</div>

			<div class="item">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160620/img_item.jpg" alt="수다 타임 세트는 하루 물 8잔 마시기를 도와 줄 물컵과 횟수 체크 기능을 더한 코스터로 구성되어 있습니다 8 water coaster, water glass cup 300미리 수다 타임 세트는 한정수량으로 제작되어 판매가 되지 않습니다" /></p>
			</div>

			<div class="event" id="votes">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_event.png" alt="하루 물 8잔 마시기 도전! 추첨을 통해 총 10분에게 드립니다. 신청기간은 6월 20일부터 26일까지며, 당첨자 발표는 6월 28일 입니다." /></p>
			<% If todayCnt > 0 Then %>
				<p class="done"><img src="http://webimage.10x10.co.kr/play/ground/20160620/btn_done.png" alt="신청 완료" /></p>
			<% Else %>
				<button type="button" class="btnEnter" onclick="vote_play(); return false;" ><img src="http://webimage.10x10.co.kr/play/ground/20160620/btn_enter.png" alt="수다 타임 세트 신청하기" /></button>
			<% End If %>
				<p class="count">
					<img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_count_01.png" alt="총" />
					<b><%=FormatNumber(totcnt,0)%></b>
					<img src="http://webimage.10x10.co.kr/play/ground/20160620/txt_count_02.png" alt="명이 신청하셨습니다" />
				</p>
			</div>
		</div>
		<!-- 수작업 영역 끝 -->
<iframe id="frmproc" name="frmproc" frameborder="0" width=0 height=0></iframe>
<script>
$(function(){
<% if pagereload<>"" then %>
	setTimeout("pagedown()",500);
<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#votes").offset().top}, 0);
}
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->