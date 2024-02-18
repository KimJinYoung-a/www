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
' Description : PLAY [ 텐바이텐 X BML2016 ] 함께, 봄 
' History : 2016-04-29 유태욱 생성
'####################################################
Dim eCode , userid , strSql , totcnt , pagereload , totcntall
Dim hotsing, hotsing1, hotsing2, hotsing3
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66115
Else
	eCode   =  70531
End If

	pagereload	= requestCheckVar(request("pagereload"),2)
	userid = GetEncLoginUserID()

	'// 투표 top3
	strSql = "select top 3 sub_opt1"
	strSql = strSql & " from db_event.dbo.tbl_event_subscript"
	strSql = strSql & "	where evt_code = '"& eCode &"' " 
	strSql = strSql & "	group by sub_opt1 " 
	strSql = strSql & "	order by count(sub_opt1) desc "
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		hotsing  = rsget.getRows()
	End IF
	rsget.close()

	hotsing1 =  hotsing( 0 , 0 )
	hotsing2 =  hotsing( 0 , 1 )
	hotsing3 =  hotsing( 0 , 2 )

If IsUserLoginOK Then 
	'// 이벤트 진행 여부
	strSql = "select "
	strSql = strSql & " count(*) "
	strSql = strSql & " from db_event.dbo.tbl_event_subscript"
	strSql = strSql & "	where userid = '"& userid &"' and evt_code = '"& eCode &"' " 
	rsget.Open strSql,dbget,1
	IF Not rsget.Eof Then
		totcnt = rsget(0)
	End IF
	rsget.close()
End If

Dim snpTitle, snpLink, snpPre, snpTag, snpTag2
	snpTitle = Server.URLEncode("BML2016과 함께 하는 '함께, 봄' 프로젝트에 초대합니다♩ 봄날의 페스티벌을 텐바이텐에서 느껴보세요!")
	snpLink = Server.URLEncode("http://bit.ly/1NEZZgJ")
	snpPre = Server.URLEncode("텐바이텐")
	snpTag = Server.URLEncode("텐바이텐 " & Replace("#30 서른 번째 이야기 FESTIVAL"," ",""))
	snpTag2 = Server.URLEncode("#텐바이텐 #10x10 #뷰티풀민트라이프")
	
	
	
'if userid="baboytw" then
'	totcnt=0
'end if
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background-color:#ffe0af;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}

img {vertical-align:top;}

.playGr20160502 {}

.hidden {visibility:hidden; width:0; height:0;}

.topic {position:relative; height:920px; background:#fff1db url(http://webimage.10x10.co.kr/play/ground/20160502/bg_flower.jpg) no-repeat 50% 0;}
.topic .hgroup {position:absolute; top:111px; left:50%; width:1140px; margin-left:-570px;}
.topic .hgroup h3 span {position:absolute; top:0; left:50%;}
.topic .hgroup h3 .letter1 {margin-left:-197px;}
.topic .hgroup h3 .letter2 {top:130px; margin-left:-233px;}
.topic .hgroup h3 .letter3 {top:131px; margin-left:271px;}
.topic .deco {position:absolute; top:432px; left:50%; margin-left:-440px;}
.bubble {animation-name:bubble; animation-duration:5s; animation-timing-function:ease-in-out; animation-delay:-1s; animation-iteration-count:infinite; animation-direction:alternate; animation-play-state:running}
@keyframes bubble{
	0%{margin-top:-10px}
	100%{margin-top:10px}
}

.topic .rolling {position:absolute; top:125px; left:50%; width:584px; height:169px; margin-left:-339px;}
.rolling .swiper {overflow:hidden; position:relative; height:169px;}
.rolling .swiper .swiper-container {overflow:hidden; height:169px;}
.rolling .swiper .swiper-wrapper {position:relative;}
.rolling .swiper .swiper-slide {height:169px;}

.plan {position:relative; height:896px; border-top:10px solid #ffe2b4; background:#ffcf9f url(http://webimage.10x10.co.kr/play/ground/20160502/bg_floral_leaf.jpg) no-repeat 50% 0;}
.plan .note {position:absolute; top:104px; left:50%; width:597px; height:663px; margin-left:-298px;}
.plan .note h4 {position:absolute; top:106px; left:149px;}
.plan .note p {position:absolute; bottom:105px; left:130px;}
.plan .note .box {position:absolute; top:0; left:0;width:597px; height:663px; background:url(http://webimage.10x10.co.kr/play/ground/20160502/bg_box_note.png) no-repeat 50% 0;}

.storyTelling {overflow:hidden;}
.storyTelling .story {overflow:hidden; position:relative; height:495px;}
.storyTelling .story .bg {position:absolute; top:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/play/ground/20160502/img_item_tshirt.jpg) no-repeat 50% 0;}
.storyTelling .story a {position:relative; z-index:5; display:block; width:100%; height:100%;}
.storyTelling .story p {position:absolute; top:143px; top:143px; left:50%; margin-left:126px;}
.storyTelling .story01 {background-color:#f9f9f7;}
.storyTelling .story01 .bg {left:0;}
.storyTelling .story02 {background-color:#f0ebe0;}
.storyTelling .story02 .bg {right:0; background-image:url(http://webimage.10x10.co.kr/play/ground/20160502/img_item_ecobag.jpg);}
.storyTelling .story02 p {top:133px; margin-left:-567px;}
.storyTelling .story03 {left:0; background-color:#ffe897;}
.storyTelling .story03 .bg {background-image:url(http://webimage.10x10.co.kr/play/ground/20160502/img_item_pouch_brooch.jpg);}
.storyTelling .story03 .brooch {position:absolute; top:60px; left:50%; z-index:15; margin-left:450px; width:300px; height:240px;}
.storyTelling .story03 p {top:149px; margin-left:147px;}
.storyTelling .story04 {background-color:#edece7;}
.storyTelling .story04 .bg {right:0; background-image:url(http://webimage.10x10.co.kr/play/ground/20160502/img_item_twilly_ribon.jpg);}
.storyTelling .story04 p {top:146px; margin-left:-454px;}

.letsgo {height:827px; padding-top:107px; background:#ffe9e4 url(http://webimage.10x10.co.kr/play/ground/20160502/bg_pattern_dot.png) repeat-x 0 0; text-align:center;}
.letsgo .photo {position:relative; width:944px; height:684px; margin:30px auto 0;}
.letsgo .photo p {position:absolute; bottom:65px; left:50%; width:844px; margin-left:-422px;}
.letsgo .photo p strong {color:#ff8b73; padding:0 32px 6px; border-bottom:2px solid #ff8a72; font-family:'Verdana', 'Dotum'; font-size:20px; font-weight:normal; line-height:20px;}

.bml {position:relative; height:230px; background:#ffd6bc url(http://webimage.10x10.co.kr/play/ground/20160502/bg_rose.jpg) no-repeat 50% 0;}
.bml h4 {position:absolute; top:67px; left:50%; margin-left:-526px;}
.bml h4 img {animation:1.2s swing ease-in-out infinite alternate;}
@keyframes swing {
	0% {margin-top:0; margin-left:0;}
	100% {margin-top:-2px; margin-left:-3px;}
}

.bml p {position:absolute; top:64px; left:50%; margin-left:-420px;}

.item {position:relative;  height:854px; padding-top:116px; background:#ffe9e4 url(http://webimage.10x10.co.kr/play/ground/20160502/img_item.jpg) no-repeat no-repeat 50% 0; text-align:center;}
.item ul {position:absolute; top:0; left:50%; width:1140px; height:100%; margin-left:-570px;}
.item ul li {position:absolute;}
.item ul li.item1 {top:272px; left:142px;}
.item ul li.item2 {top:527px; left:-105px;}
.item ul li.item3 {top:480px; left:327px;}
.item ul li.item4 {top:537px; left:733px;}
.item ul li.item5 {top:308px; right:-26px;}
.item ul li a {display:block;}
.item ul li a .off img {animation-name:bounce; animation-iteration-count:infinite; animation-duration:1s;}
.item ul li.item2 a .off img {animation-delay:0.2s;}
.item ul li.item3 a .off img {animation-delay:0.4s;}
.item ul li.item4 a .off img {animation-delay:0.6s;}
.item ul li.item5 a .off img {animation-delay:0.8s;}
.item ul li a .over {position:absolute; top:0; left:0; transition:opacity 0.5s ease-out; opacity:0; filter:alpha(opacity=0);}
.item ul li a .over img {transition:transform .7s ease;}
.item ul li a .label {display:none; position:absolute; top:7px; right:0;}
.item ul li.item2 a .label {top:83px; right:-137px;}
.item ul li.item3 a .label {top:98px; right:-83px;}
.item ul li.item4 a .label {top:77px; right:-166px;}
.item ul li a:hover {text-decoration:none;}
.item ul li a:hover .label {display:block;}
.item ul li a:hover .off img {opacity:0;}
.item ul li a:hover .over {opacity:1; filter:alpha(opacity=1);}
.item ul li a:hover .over img {transform:rotate(360deg);}

.giftEvt {height:722px; padding-top:74px; background:#fff6f3 url(http://webimage.10x10.co.kr/play/ground/20160502/bg_pattern_flower.png) no-repeat 50% 100%;}
.giftEvt .inner {position:relative; width:1140px; margin:0 auto;}

.giftEvt .choice {position:relative; z-index:5; width:703px; margin:0 auto;}
.giftEvt .choice img {position:relative; z-index:5;}
.giftEvt .choice span {position:absolute; top:107px; left:192px; width:339px; height:20px; background-color:#fff86f;}
.giftEvt .choice span {animation-name:underline; animation-iteration-count:infinite; animation-duration:2.4s; animation-fill-mode:both;}
@keyframes underline {
	0% {transform:scaleX(0);}
	100% {transform:scaleX(1);}
}

.giftEvt .form {overflow:hidden; height:365px; margin-top:57px; background:#fff url(http://webimage.10x10.co.kr/play/ground/20160502/bg_line_dot.png) no-repeat 50% 24px;}
.giftEvt .form .sat, .giftEvt .form .sun {float:left; width:525px; padding:37px 0 0 45px;}
.giftEvt .form h4 {overflow:hidden; position:relative; width:177px; height:28px; margin:0 auto;}
.giftEvt .form h4 span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/play/ground/20160502/bg_sprite_v1.png) no-repeat -227px -37px;}
.giftEvt .form .sun h4 span {background-position:-797px -37px;}
.giftEvt .form ul {overflow:hidden; margin-top:40px;}
.giftEvt .form ul li {position:relative; overflow:hidden; float:left; width:175px; height:15px; margin-bottom:15px; padding:1px 0;}
.giftEvt .form ul li input {float:left; margin-right:7px;}
.giftEvt .form ul li label {overflow:hidden; float:left; display:block; position:relative; width:62px; height:15px; margin-right:5px;}
.giftEvt .form ul li label span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/play/ground/20160502/bg_sprite_v1.png) no-repeat -95px -104px;}
.giftEvt .form ul li.singer02 label {width:37px;}
.giftEvt .form ul li.singer02 label span {background-position:-258px -104px;}
.giftEvt .form ul li.singer03 label {width:25px;}
.giftEvt .form ul li.singer03 label span {background-position:-422px -104px;}
.giftEvt .form ul li.singer04 label {width:37px;}
.giftEvt .form ul li.singer04 label span {background-position:-95px -136px;}
.giftEvt .form ul li.singer05 label {width:50px;}
.giftEvt .form ul li.singer05 label span {background-position:-258px -136px;}
.giftEvt .form ul li.singer06 label {width:50px;}
.giftEvt .form ul li.singer06 label span {background-position:-422px -136px;}
.giftEvt .form ul li.singer07 label {width:88px;}
.giftEvt .form ul li.singer07 label span {background-position:-95px -168px;}
.giftEvt .form ul li.singer08 label {width:76px;}
.giftEvt .form ul li.singer08 label span {background-position:-258px -168px;}
.giftEvt .form ul li.singer09 label {width:25px;}
.giftEvt .form ul li.singer09 label span {background-position:-422px -168px;}
.giftEvt .form ul li.singer10 label {width:75px;}
.giftEvt .form ul li.singer10 label span {background-position:-95px -200px;}
.giftEvt .form ul li.singer11 label {width:51px;}
.giftEvt .form ul li.singer11 label span {background-position:-258px -200px;}
.giftEvt .form ul li.singer12 label {width:64px;}
.giftEvt .form ul li.singer12 label span {background-position:-422px -200px;}
.giftEvt .form ul li.singer13 label {width:52px;}
.giftEvt .form ul li.singer13 label span {background-position:-95px -232px;}
.giftEvt .form ul li.singer14 label {width:37px;}
.giftEvt .form ul li.singer14 label span {background-position:-258px -232px;}
.giftEvt .form ul li.singer15 label {width:64px;}
.giftEvt .form ul li.singer15 label span {background-position:-422px -232px;}
.giftEvt .form ul li.singer16 label {width:52px;}
.giftEvt .form ul li.singer16 label span {background-position:-95px -264px;}
.giftEvt .form ul li.singer17 label {width:25px;}
.giftEvt .form ul li.singer17 label span {background-position:-258px -264px;}
.giftEvt .form ul li.singer18 label {width:25px;}
.giftEvt .form ul li.singer18 label span {background-position:-422px -264px;}
.giftEvt .form ul li.singer19 label {width:94px;}
.giftEvt .form ul li.singer19 label span {background-position:-95px -296px;}
.giftEvt .form ul li.singer20 label {width:51px;}
.giftEvt .form ul li.singer20 label span {background-position:-258px -296px;}
.giftEvt .form ul li.singer21 label {width:34px;}
.giftEvt .form ul li.singer21 label span {background-position:-665px -104px;}
.giftEvt .form ul li.singer22 label {width:38px;}
.giftEvt .form ul li.singer22 label span {background-position:-828px -104px;}
.giftEvt .form ul li.singer23 label {width:39px;}
.giftEvt .form ul li.singer23 label span {background-position:-992px -104px;}
.giftEvt .form ul li.singer24 label {width:50px;}
.giftEvt .form ul li.singer24 label span {background-position:-665px -136px;}
.giftEvt .form ul li.singer25 label {width:25px;}
.giftEvt .form ul li.singer25 label span {background-position:-828px -136px;}
.giftEvt .form ul li.singer26 label {width:94px;}
.giftEvt .form ul li.singer26 label span {background-position:-992px -136px;}
.giftEvt .form ul li.singer27 label {width:76px;}
.giftEvt .form ul li.singer27 label span {background-position:-665px -168px;}
.giftEvt .form ul li.singer28 label {width:25px;}
.giftEvt .form ul li.singer28 label span {background-position:-828px -168px;}
.giftEvt .form ul li.singer29 label {width:38px;}
.giftEvt .form ul li.singer29 label span {background-position:-992px -168px;}
.giftEvt .form ul li.singer30 label {width:26px;}
.giftEvt .form ul li.singer30 label span {background-position:-665px -200px;}
.giftEvt .form ul li.singer31 label {width:81px;}
.giftEvt .form ul li.singer31 label span {background-position:-828px -200px;}
.giftEvt .form ul li.singer32 label {width:39px;}
.giftEvt .form ul li.singer32 label span {background-position:-992px -200px;}
.giftEvt .form ul li.singer33 label {width:68px;}
.giftEvt .form ul li.singer33 label span {background-position:-665px -232px;}
.giftEvt .form ul li.singer34 label {width:38px;}
.giftEvt .form ul li.singer34 label span {background-position:-828px -232px;}
.giftEvt .form ul li.singer35 label {width:25px;}
.giftEvt .form ul li.singer35 label span {background-position:-992px -232px;}
.giftEvt .form ul li.singer36 label {width:93px;}
.giftEvt .form ul li.singer36 label span {background-position:-665px -264px;}
.giftEvt .form ul li.singer37 label {width:38px;}
.giftEvt .form ul li.singer37 label span {background-position:-828px -264px;}
.giftEvt .form ul li.singer38 label {width:107px;}
.giftEvt .form ul li.singer38 label span {background-position:-992px -264px;}
.giftEvt .form ul li.singer39 label {width:36px;}
.giftEvt .form ul li.singer39 label span {background-position:-665px -296px;}
.giftEvt .form ul li.singer40 label {width:38px;}
.giftEvt .form ul li.singer40 label span {background-position:-828px -296px;}
.giftEvt .form ul li i {float:left; margin-top:-1px;}
.giftEvt .form ul li i {animation-name:twinkle; animation-iteration-count:infinite; animation-duration:1.2s; animation-fill-mode:both;}
@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}

.giftEvt .form .btnsubmit {position:absolute; bottom:-102px; left:50%; margin-left:-114px;}

.shareSns {position:relative; background-color:#6bd9d5; height:159px;}
.shareSns .line {position:absolute; top:0; left:0; width:100%; height:5px; background-color:#3aa7a2;}
.shareSns .inner {border-top:5px solid #fff;}
.shareSns h4 {position:absolute; top:73px; left:50%; margin-left:-514px;}
.shareSns ul {overflow:hidden; position:absolute; top:50px; left:50%; margin-left:78px; padding-top:5px;}
.shareSns ul li {float:left; margin-right:2px;}
.shareSns ul li a:hover img {animation-name:bounce; animation-iteration-count:infinite; animation-duration:0.7s;}
@keyframes bounce {
	from, to{margin-top:-5px; animation-timing-function:ease-out;}
	50% {margin-top:0; animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
$(function(){
	/* swiper js */
	var mySwiper = new Swiper('.swiper-container',{
		mode: 'vertical',
		autoplay:1500,
		speed:1200,
		loop:true,
		simulateTouch:false,
		onSlideChangeStart: function(swiper){
			$(".rolling .swiper-slide").delay(0).animate({"opacity":"0.5"},50);
			$(".rolling .swiper-slide-active").delay(50).animate({"opacity":"1"},100);
		}
	});

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1400 ) {
			planAnimation();
		}
		if (scrollTop > 2000 ) {
			storyAnimation1();
		}
		if (scrollTop > 2400 ) {
			storyAnimation2();
		}
		if (scrollTop > 3000 ) {
			storyAnimation3();
		}
		if (scrollTop > 3600 ) {
			storyAnimation4();
		}
	});

	topicAnimation();
	$("#topicAnimation h3 .letter2, #topicAnimation h3 .letter3").css({"top":"140px", "opacity":"0"});
	$("#topicAnimation .rolling").css({"opacity":"0"});
	function topicAnimation () {
		$("#topicAnimation h3 .letter2").delay(600).animate({"top":"130px", "opacity":"1"},800);
		$("#topicAnimation h3 .letter3").delay(600).animate({"top":"131px", "opacity":"1"},800);
		$("#topicAnimation .rolling").delay(1500).animate({"opacity":"1"},800);
	}

	$("#planAnimation .note h4").css({"top":"126px", "opacity":"0"});
	$("#planAnimation .note p").css({"bottom":"125px", "opacity":"0"});
	function planAnimation () {
		$("#planAnimation .note h4").delay(100).animate({"top":"106px", "opacity":"1"},800);
		$("#planAnimation .note p").delay(100).animate({"bottom":"105px", "opacity":"1"},800);
	}

	$("#storyAnimation .story .bg").css({"opacity":"0"});
	$("#storyAnimation .story02 .bg").css({"right":"-1%"});
	$("#storyAnimation .story03 .bg").css({"left":"-1%"});
	function storyAnimation1 () {
		$("#storyAnimation .story01 .bg").delay(100).animate({"opacity":"1"},400);
	}
	function storyAnimation2 () {
		$("#storyAnimation .story02 .bg").delay(100).animate({"right":"0", "opacity":"1"},400);
	}
	function storyAnimation3 () {
		$("#storyAnimation .story03 .bg").delay(100).animate({"left":"0", "opacity":"1"},400);
	}
	function storyAnimation4 () {
		$("#storyAnimation .story04 .bg").delay(100).animate({"opacity":"1"},400);
	}
});
</script>
<script type="text/javascript">
<!--

function vote_play(){
	var st = $(":input:radio[name=singer]:checked").val();
	var frm = document.frmvote;

	<% if Not(IsUserLoginOK) then %>
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	<% end if %>

	<% If not(left(now(),10)>="2016-04-29" and left(now(),10)<"2016-05-09" ) Then %>
		alert("이벤트 응모 기간이 아닙니다.");
		return;
	<% else %>
		<% if totcnt > 0 then %>
			alert("한 개의 아이디당 1회까지 응모가 가능 합니다.");
			return;
		<% else %>
			if(st==null){
				alert('가장 만나보고 싶은\n아티스트를 선택해 주세요!');
				return;
			}
			alert("응모가 완료 되었습니다.");
			frm.action = "/play/groundsub/doEventSubscript70531.asp";
			frm.target="frmproc";
			frm.submit();
			return;
		<% end if %>
	<% end if %>
}
//-->
</script>

<!-- 수작업 영역 시작 -->
<div class="groundCont">
	<div class="grArea">

		<!-- FESTIVAL #1 -->
		<div class="playGr20160502 togetherBom">
			<div id="topicAnimation" class="topic">
				<div class="hgroup">
					<h3>
						<span class="letter1"><img src="http://webimage.10x10.co.kr/play/ground/20160502/tit_spring.png" alt="설레는 봄 햇살, 그리고 음악축제" /></span>
						<span class="letter2"><img src="http://webimage.10x10.co.kr/play/ground/20160502/tit_together.png" alt="함께," /></span>
						<span class="letter3"><img src="http://webimage.10x10.co.kr/play/ground/20160502/tit_bom.png" alt="봄" /></span>
					</h3>

					<!-- swipe -->
					<div class="rolling">
						<div class="swiper">
							<div class="swiper-container">
								<div class="swiper-wrapper">
									<div class="swiper-slide">
										<p><img src="http://webimage.10x10.co.kr/play/ground/20160502/img_slide_01_v1.png" alt="우리 기분이 좋은" /></p>
									</div>
									<div class="swiper-slide">
										<p><img src="http://webimage.10x10.co.kr/play/ground/20160502/img_slide_02_v1.png" alt="너와 꽃이 만발한" /></p>
									</div>
									<div class="swiper-slide">
										<p><img src="http://webimage.10x10.co.kr/play/ground/20160502/img_slide_03_v1.png" alt="꽃과 사랑스러운" /></p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="deco bubble"><img src="http://webimage.10x10.co.kr/play/ground/20160502/img_deco.png" alt="" /></div>
			</div>

			<div id="planAnimation" class="plan">
				<div class="note">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20160502/tit_make_together_bom.png" alt="참 좋은 봄날을 만들어 줄 함께, 봄" /></h4>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_make_plan.png" alt="기분 좋은 일상을 만드는 텐바이텐과 봄날의 페스티벌 Beautiful Mint Life 가 함께 꽃이 가득한 하루를 제안합니다. 흐드러지는 봄 내음과 만개하는 꽃나무 속에서 매일을 페스티벌인 것처럼 즐겨 보세요. 함께 하는 거에요, 이 좋은 봄날을!" /></p>
					<div class="box"></div>
				</div>
			</div>

			<div id="storyAnimation" class="storyTelling">
				<div class="story story01">
					<div class="bg"></div>
					<a href="/shopping/category_prd.asp?itemid=1466664&amp;pEtr=70531">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_item_story_01.png" alt="아침부터 부산스럽게 거울 앞에서 이 옷 저 옷을 대보고 무얼 입을까 고민하는 것도 마냥 즐거운, 오늘은 페스티벌 가는 날" /></p>
					</a>
				</div>
				<div class="story story02">
					<div class="bg"></div>
					<a href="/shopping/category_prd.asp?itemid=1466665&amp;pEtr=70531">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_item_story_02.png" alt="직접 만든 샌드위치, 깨끗한 플랫슈즈 추억을 찍어줄 카메라. 넉넉한 에코백 안에 설렘까지 가득 담아 볼래요" /></p>
					</a>
				</div>
				<div class="story story03">
					<div class="bg"></div>
					<a href="/shopping/category_prd.asp?itemid=1466666&amp;pEtr=70531">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_item_story_03.png" alt="아, 잊으면 안돼요! 페스티벌 티켓과 타임 테이블, 요긴하게 쓰일 손수건도 오늘을 기념할 브로치까지 꼭 챙겨 주세요. 예쁜 파우치 속에 쏙쏙!" /></p>
					</a>

					<a href="/shopping/category_prd.asp?itemid=1466668&amp;pEtr=70531" class="brooch"><img src="http://webimage.10x10.co.kr/play/ground/20160502/img_item_white.png" alt="브로치" /></a>
				</div>
				<div class="story story04">
					<div class="bg"></div>
					<a href="/shopping/category_prd.asp?itemid=1466667&amp;pEtr=70531">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_item_story_04.png" alt="마지막으로 예뻐지는 아이템 장착! 우리를 페스티벌 레이디로 만들어 줄 트윌리 리본을 머리에, 손목에 둘러 주세요. 오늘은 우리가 주인공!" /></p>
					</a>
				</div>
			</div>

			<div class="letsgo">
				<h4><img src="http://webimage.10x10.co.kr/play/ground/20160502/tit_lets_go.png" alt="자, 이제 출발 할까요? 페스티벌 즐기러!" /></h4>
				<div class="photo">
					<img src="http://webimage.10x10.co.kr/play/ground/20160502/img_photo.png" alt="" />
				<p><strong><% If IsUserLoginOK Then response.write userid else response.write "당신" end if %></strong> <img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_with.png" alt="과 함께 페스티벌을 봄" /></p>
				</div>
			</div>

			<div class="bml">
				<h4><img src="http://webimage.10x10.co.kr/play/ground/20160502/img_logo_bml.png" alt="BML 텐바이텐의 오랜 친구 Beautiful Mint Life" /></h4>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_bml.png" alt="뷰티풀 민트 라이프는 민트페이퍼가 개최하는 봄날의 음악 페스티벌입니다. 봄에는 뷰티풀 민트 라이프, 가을에는 그랜드 민트 페스티벌. 다양한 아티스트와 팬들이 만나 음악을 나누고 소통하는 대한민국 대표 페스티벌로 거듭나고 있습니다. 2016년 5월 14일 토요일부터 15일 일요일까지 서울시 올림픽공원 일대에서 열립니다." /></p>
			</div>

			<div class="item">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_item.png" alt="공식굿즈와 함께, 미리할인해 봄! 5월 2일 월요일부터 5월 8일 일요일까지만 런칭 기념 10% 할인을 선사합니다. 이 모든 상품은 뷰티풀 민트 라이프 2016 잔디마당 텐바이텐 부스에서도 만날 수 있어요!" /></p>
				<ul>
					<li class="item1">
						<a href="/shopping/category_prd.asp?itemid=1466665&amp;pEtr=70531">
							<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_plus.png" alt="에코백" /></span>
							<span class="over"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_plus.png" alt="" /></span>
							<span class="label"><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_item_ecobag.png" alt="" /></span>
						</a>
					</li>
					<li class="item2">
						<a href="/shopping/category_prd.asp?itemid=1466667&amp;pEtr=70531">
							<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_plus.png" alt="트윌리" /></span>
							<span class="over"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_plus.png" alt="" /></span>
							<span class="label"><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_item_twilly_ribon.png" alt="" /></span>
						</a>
					</li>
					<li class="item3">
						<a href="/shopping/category_prd.asp?itemid=1466666&amp;pEtr=70531">
							<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_plus.png" alt="파우치" /></span>
							<span class="over"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_plus.png" alt="" /></span>
							<span class="label"><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_item_pouch.png" alt="" /></span>
						</a>
					</li>
					<li class="item4">
						<a href="/shopping/category_prd.asp?itemid=1466668&amp;pEtr=70531">
							<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_plus.png" alt="브로치" /></span>
							<span class="over"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_plus.png" alt="" /></span>
							<span class="label"><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_item_brooch.png" alt="" /></span>
						</a>
					</li>
					<li class="item5">
						<a href="/shopping/category_prd.asp?itemid=1466664&amp;pEtr=70531">
							<span class="off"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_plus.png" alt="자수 티셔츠" /></span>
							<span class="over"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_plus.png" alt="" /></span>
							<span class="label"><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_item_tshirt.png" alt="" /></span>
						</a>
					</li>
				</ul>
			</div>
			
			<!-- gift event -->
			<div class="giftEvt">
				<div class="inner">
					<h4 class="hidden">gift event</h4>
					<p class="choice"  id="votes"><img src="http://webimage.10x10.co.kr/play/ground/20160502/txt_gift_event_v1.png" alt="가장 만나 보고 싶은 아티스트를 선택해 주세요! 추첨을 통해 총 10분께 원하는 팀이 출연하는 날짜의 BML 2016 티켓 1일권, 2매를 선물로 드립니다. 응모 기간은 5월 2일부터 8일까지며 당첨일은 5월 9일입니다." /><span></span></p>

					<div class="form">
						<form name="frmvote" method="post">
						<input type="hidden" name="mode" value="add"/>
						<input type="hidden" name="pagereload" value="ON"/>
							<!-- sat -->
							<div class="sat">
								<fieldset>
								<legend>5월 14일 토요일 가장 만나 보고 싶은 아티스트 선택</legend>
									<h4><span></span>5.14 sat</h4>
									<ul>
									<li class="singer01"><input type="radio" id="singer01" name="singer" value="1"/> <label for="singer01"><span></span>노리플라이</label><% if totcnt > 0 then %><% if hotsing1="1" or hotsing2="1" or hotsing3="1" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer02"><input type="radio" id="singer02" name="singer" value="2" /> <label for="singer02"><span></span>김사월</label><% if totcnt > 0 then %><% if hotsing1="2" or hotsing2="2" or hotsing3="2" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer03"><input type="radio" id="singer03" name="singer" value="3" /> <label for="singer03"><span></span>롱디</label><% if totcnt > 0 then %><% if hotsing1="3" or hotsing2="3" or hotsing3="3" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer04"><input type="radio" id="singer04" name="singer" value="4" /> <label for="singer04"><span></span>로이킴</label><% if totcnt > 0 then %><% if hotsing1="4" or hotsing2="4" or hotsing3="4" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer05"><input type="radio" id="singer05" name="singer" value="5" /> <label for="singer05"><span></span>랄라스윗</label><% if totcnt > 0 then %><% if hotsing1="5" or hotsing2="5" or hotsing3="5" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer06"><input type="radio" id="singer06" name="singer" value="6" /> <label for="singer06"><span></span>멜로망스</label><% if totcnt > 0 then %><% if hotsing1="6" or hotsing2="6" or hotsing3="6" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer07"><input type="radio" id="singer07" name="singer" value="7" /> <label for="singer07"><span></span>브로콜리너마저</label><% if totcnt > 0 then %><% if hotsing1="7" or hotsing2="7" or hotsing3="7" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer08"><input type="radio" id="singer08" name="singer" value="8" /> <label for="singer08"><span></span>안녕하신가영</label><% if totcnt > 0 then %><% if hotsing1="8" or hotsing2="8" or hotsing3="8" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer09"><input type="radio" id="singer09" name="singer" value="9" /> <label for="singer09"><span></span>수란</label><% if totcnt > 0 then %><% if hotsing1="9" or hotsing2="9" or hotsing3="9" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer10"><input type="radio" id="singer10" name="singer" value="10" /> <label for="singer10"><span></span>빌리어코스티</label><% if totcnt > 0 then %><% if hotsing1="10" or hotsing2="10" or hotsing3="10" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer11"><input type="radio" id="singer11" name="singer" value="11" /> <label for="singer11"><span></span>옥상달빛</label><% if totcnt > 0 then %><% if hotsing1="11" or hotsing2="11" or hotsing3="11" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer12"><input type="radio" id="singer12" name="singer" value="12" /> <label for="singer12"><span></span>위아더나잇</label><% if totcnt > 0 then %><% if hotsing1="12" or hotsing2="12" or hotsing3="12" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer13"><input type="radio" id="singer13" name="singer" value="13" /> <label for="singer13"><span></span>선우정아</label><% if totcnt > 0 then %><% if hotsing1="13" or hotsing2="13" or hotsing3="13" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer14"><input type="radio" id="singer14" name="singer" value="14" /> <label for="singer14"><span></span>임헌일</label><% if totcnt > 0 then %><% if hotsing1="14" or hotsing2="14" or hotsing3="14" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer15"><input type="radio" id="singer15" name="singer" value="15" /> <label for="singer15"><span></span>플레이모드</label><% if totcnt > 0 then %><% if hotsing1="15" or hotsing2="15" or hotsing3="15" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer16"><input type="radio" id="singer16" name="singer" value="16" /> <label for="singer16"><span></span>제이레빗</label><% if totcnt > 0 then %><% if hotsing1="16" or hotsing2="16" or hotsing3="16" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer17"><input type="radio" id="singer17" name="singer" value="17" /> <label for="singer17"><span></span>치즈</label><% if totcnt > 0 then %><% if hotsing1="17" or hotsing2="17" or hotsing3="17" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer18"><input type="radio" id="singer18" name="singer" value="18" /> <label for="singer18"><span></span>호소</label><% if totcnt > 0 then %><% if hotsing1="18" or hotsing2="18" or hotsing3="18" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer19"><input type="radio" id="singer19" name="singer" value="19" /> <label for="singer19"><span></span>피터팬 컴플렉스</label><% if totcnt > 0 then %><% if hotsing1="19" or hotsing2="19" or hotsing3="19" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer20"><input type="radio" id="singer20" name="singer" value="20" /> <label for="singer20"><span></span>페퍼톤스</label><% if totcnt > 0 then %><% if hotsing1="20" or hotsing2="20" or hotsing3="20" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
									</ul>
								</fieldset>
							</div>

							<!-- sun -->
							<div class="sun">
								<fieldset>
								<legend>5월 15일 일요일 가장 만나 보고 싶은 아티스트 선택</legend>
									<h4><span></span>5.15 sun</h4>
									<ul>
										<li class="singer21"><input type="radio" id="singer21" name="singer" value="21" /> <label for="singer21"><span></span>10cm</label><% if totcnt > 0 then %><% if hotsing1="21" or hotsing2="21" or hotsing3="21" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %>	</li>
										<li class="singer22"><input type="radio" id="singer22" name="singer" value="22" /> <label for="singer22"><span></span>마이큐</label><% if totcnt > 0 then %><% if hotsing1="22" or hotsing2="22" or hotsing3="22" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer23"><input type="radio" id="singer23" name="singer" value="23" /> <label for="singer23"><span></span>신세하</label><% if totcnt > 0 then %><% if hotsing1="23" or hotsing2="23" or hotsing3="23" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer24"><input type="radio" id="singer24" name="singer" value="24" /> <label for="singer24"><span></span>글렌체크</label><% if totcnt > 0 then %><% if hotsing1="24" or hotsing2="24" or hotsing3="24" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer25"><input type="radio" id="singer25" name="singer" value="25" /> <label for="singer25"><span></span>몽니</label><% if totcnt > 0 then %><% if hotsing1="25" or hotsing2="25" or hotsing3="25" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer26"><input type="radio" id="singer26" name="singer" value="26" /> <label for="singer26"><span></span>신현희와 김루트</label><% if totcnt > 0 then %><% if hotsing1="26" or hotsing2="26" or hotsing3="26" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer27"><input type="radio" id="singer27" name="singer" value="27" /> <label for="singer27"><span></span>데이브레이크</label><% if totcnt > 0 then %><% if hotsing1="27" or hotsing2="27" or hotsing3="27" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer28"><input type="radio" id="singer28" name="singer" value="28" /> <label for="singer28"><span></span>샘김</label><% if totcnt > 0 then %><% if hotsing1="28" or hotsing2="28" or hotsing3="28" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer29"><input type="radio" id="singer29" name="singer" value="29" /> <label for="singer29"><span></span>유근호</label><% if totcnt > 0 then %><% if hotsing1="29" or hotsing2="29" or hotsing3="29" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer30"><input type="radio" id="singer30" name="singer" value="30" /> <label for="singer30"><span></span>소란</label><% if totcnt > 0 then %><% if hotsing1="30" or hotsing2="30" or hotsing3="30" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer31"><input type="radio" id="singer31" name="singer" value="31" /> <label for="singer31"><span></span>소심한 오빠들</label><% if totcnt > 0 then %><% if hotsing1="31" or hotsing2="31" or hotsing3="31" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer32"><input type="radio" id="singer32" name="singer" value="32" /> <label for="singer32"><span></span>전자양</label><% if totcnt > 0 then %><% if hotsing1="32" or hotsing2="32" or hotsing3="32" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer33"><input type="radio" id="singer33" name="singer" value="33" /> <label for="singer33"><span></span>스탠딩 에그</label><% if totcnt > 0 then %><% if hotsing1="33" or hotsing2="33" or hotsing3="33" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer34"><input type="radio" id="singer34" name="singer" value="34" /> <label for="singer34"><span></span>쏜애플</label><% if totcnt > 0 then %><% if hotsing1="34" or hotsing2="34" or hotsing3="34" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer35"><input type="radio" id="singer35" name="singer" value="35" /> <label for="singer35"><span></span>타루</label><% if totcnt > 0 then %><% if hotsing1="35" or hotsing2="35" or hotsing3="35" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer36"><input type="radio" id="singer36" name="singer" value="36" /> <label for="singer36"><span></span>어쿠스틱 콜라보</label><% if totcnt > 0 then %><% if hotsing1="36" or hotsing2="36" or hotsing3="36" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer37"><input type="radio" id="singer37" name="singer" value="37" /> <label for="singer37"><span></span>정재원</label><% if totcnt > 0 then %><% if hotsing1="37" or hotsing2="37" or hotsing3="37" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer38"><input type="radio" id="singer38" name="singer" value="38" /> <label for="singer38"><span></span>페이퍼컷 프로젝트</label><% if totcnt > 0 then %><% if hotsing1="38" or hotsing2="38" or hotsing3="38" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer39"><input type="radio" id="singer39" name="singer" value="39" /> <label for="singer39"><span></span>이지형</label><% if totcnt > 0 then %><% if hotsing1="39" or hotsing2="39" or hotsing3="39" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
										<li class="singer40"><input type="radio" id="singer40" name="singer" value="40" /> <label for="singer40"><span></span>정준일</label><% if totcnt > 0 then %><% if hotsing1="40" or hotsing2="40" or hotsing3="40" then %> <i><img src="http://webimage.10x10.co.kr/play/ground/20160502/ico_hot.png" alt="hot" /></i><% end if %><% end if %></li>
									</ul>
								</fieldset>
							</div>

							<div class="btnsubmit" onclick="vote_play(); return false;"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20160502/btn_submit.png" alt="응모하기" /></div>
						</form>
					</div>
				</div>
			</div>

			<!-- sns -->
			<div class="shareSns">
				<div class="line"></div>
				<div class="inner">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20160502/tit_sns.png" alt="함께, 봄 당첨확률 높이기" /></h4>
					<ul>
						<li><a href="#" onClick="popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>',''); return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_twitter.png" alt="트위터에 공유하기" /></a></li>
						<li><a href="#" onClick="popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','',''); return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160502/btn_facebook.png" alt="페이스북에 공유하기" /></a></li>
						
					</ul>
				</div>
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