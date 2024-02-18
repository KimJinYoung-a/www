<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/etc/instagrameventCls.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : 플레이띵 Vol.14 fly,play
' History : 2017-05-02 원승현
'####################################################
Dim eCode, userid, pagereload, i
dim iCCurrpage, iCTotCnt, eCC, iCPageSize, iCTotalPage
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66324
Else
	eCode   =  77710
End If

iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	
IF iCCurrpage = "" THEN iCCurrpage = 1
IF iCTotCnt = "" THEN iCTotCnt = -1

eCC = requestCheckVar(Request("eCC"), 1)
pagereload	= requestCheckVar(request("pagereload"),2)
userid		= GetEncLoginUserID()

iCPageSize = 8		'한 페이지의 보여지는 열의 수

dim oinstagramevent
set oinstagramevent = new Cinstagrameventlist
	oinstagramevent.FPageSize	= iCPageSize
	oinstagramevent.FCurrPage	= iCCurrpage
	oinstagramevent.FTotalCount		= iCTotCnt  '전체 레코드 수
	oinstagramevent.FrectIsusing = "Y"
	oinstagramevent.FrectEcode = eCode
	oinstagramevent.fnGetinstagrameventList

	iCTotCnt = oinstagramevent.FTotalCount '리스트 총 갯수
	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.thingVol014 {text-align:center;}
.thingVol014 .section {background-repeat:repeat; background-position:0 0;}
.thingVol014 .inner {position:relative; width:1140px; margin:0 auto;}
.thingVol014 .wideSwipe .swiper-container {height:610px;}
.thingVol014 .wideSwipe .swiper-slide {width:1134px;}
.thingVol014 .wideSwipe .swiper-slide img {height:610px;}
.thingVol014 .wideSwipe .slideNav {width:42px; height:63px; margin-top:-32px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/btn_nav.png);}
.thingVol014 .wideSwipe .btnPrev,.thingVol014 .wideSwipe .btnPrev:hover {margin-left:-527px; background-position:0 0;}
.thingVol014 .wideSwipe .btnNext,.thingVol014 .wideSwipe .btnNext:hover {margin-left:487px; background-position:100% 0;}
.thingVol014 .wideSwipe .mask.left {margin-left:-567px;}
.thingVol014 .wideSwipe .mask.right {margin-left:567px;}
.thingVol014 .intro {background:#fef299 url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_head.png) 50% 0 no-repeat;}
.intro .inner {height:788px; background:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_article.png) 50% 113px no-repeat;}
.intro h2 {position:absolute; left:50%; top:190px; width:530px; height:184px; margin-left:-242px;}
.intro h2 span {position:absolute;}
.intro h2 span.tit1 {left:0; top:0;}
.intro h2 span.tit2 {right:0; bottom:0;}
.intro .txt1 {padding:383px 0 62px;}
.intro .btnArrow {position:absolute; left:50%; bottom:108px; width:28px; height:35px; margin-left:-14px; background:url(http://webimage.10x10.co.kr/playing/thing/vol014/btn_arrow.gif) 0 0 no-repeat; cursor:pointer;}
.intro .airplane {position:absolute; left:640px; top:148px; width:80px; height:64px; background:url(http://webimage.10x10.co.kr/playing/thing/vol014/img_airplane.png) 0 0 no-repeat;}
.weplayIs {padding:103px 0 113px; text-align:left; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_noise_01.png);}
.weplayIs .inner {width:980px; padding:0 80px;}
.weplayIs .team {position:absolute; right:43px; top:-60px;}
.weplayIs .team span {position:absolute; left:54px; top:30px; animation:bounce 1s 50;}
.video {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_noise_02.png);}
.video .inner {width:1656px; height:855px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_video.png);}
.video h3 {padding:106px 0 25px;}
.video .videoCont {position:absolute; left:50%; top:300px; width:621px; height:430px; margin-left:-339px;}
.video .videoCont iframe {width:621px; height:430px; border-radius:20px;}
.story .inner {width:1461px; background-position:50% 0; background-repeat:no-repeat;}
.story .txt {width:366px; padding:135px 0 180px 284px;}
.story .txt h3 {padding-bottom:30px;}
.story .txt a {position:relative; display:block;}
.story .txt a span {display:inline-block; position:absolute; right:63px; top:50%; width:15px; height:9px; margin-top:-5px; background:url(http://webimage.10x10.co.kr/playing/thing/vol014/blt_arrow.png); transition:all .5s; -webkit-transform: rotate(-180deg); transform: rotate(-180deg);}
.story .txt a:hover span,.story.current .txt a span {-webkit-transform: rotate(0deg); transform: rotate(0deg);}
.story .airplane {position:absolute; left:50%; background-position:0 0; background-repeat:no-repeat; animation:bounce 1.2s 100;}
.story .process {display:none;}
.story .btnPrint {position:absolute; left:50%; animation:bounce 1.2s 100 .5s; cursor:pointer;}
.story1 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_noise_03.png);}
.story2 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_noise_04.png);}
.story3 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_pink.png);}
.story1 .inner {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_story_01.png);}
.story2 .inner {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_story_02.png);}
.story3 .inner {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_story_03.png);}
.story2 .txt {padding-left:797px;}
.story1 .airplane {top:218px; width:487px; height:367px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/img_story_airplane_01.png);}
.story2 .airplane {top:163px; width:487px; height:367px; margin-left:-530px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/img_story_airplane_02.png);}
.story3 .airplane {top:162px; width:487px; height:367px; margin-left:35px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/img_story_airplane_03.png);}
.story1 .btnPrint {top:425px; margin-left:427px;}
.story2 .btnPrint {top:402px; margin-left:-517px;}
.story3 .btnPrint {top:296px; margin-left:343px;}
.story.current .txt {padding-bottom:0;}
.story.current .process {display:block; padding:90px 0 100px;}
.story1.current .airplane {animation:move1 1.2s 1,bounce 1.2s 100;}
.story2.current .airplane {animation:move2 1.2s 1,bounce 1.2s 100;}
.story3.current .airplane {animation:move3 1.2s 1,bounce 1.2s 100;}
.applyEvent {padding-top:87px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_noise_05.png);}
.applyEvent .btnGo {display:inline-block; padding:40px 0 37px;}
.applyEvent .noti {height:157px; text-align:left; background-color:#e8e8e8;}
.applyEvent .noti h4 {position:absolute; left:172px; top:52px;}
.applyEvent .noti p {padding:42px 0 0 348px;}
.applyEvent .sharePlace {padding:74px 0 68px; background-color:#fff2ae;}
.applyEvent .sharePlace ul {overflow:hidden; width:1174px; margin:0 auto;}
.applyEvent .sharePlace li {float:left; width:293px; padding-bottom:50px;}
.applyEvent .sharePlace li .pic {width:250px; margin:0 auto; padding:5px; background-color:#fff; border-radius:4px;}
.applyEvent .sharePlace li p {padding-top:15px; font-weight:bold; font-size:13px; line-height:1; color:#999;}
.applyEvent .sharePlace li p span {color:#2491eb; font-family:arial;}
.applyEvent .sharePlace .pageWrapV15 {padding-top:12px;}
.applyEvent .sharePlace .pageMove {display:none;}
.applyEvent .sharePlace .paging {display:inline-block; width:auto; height:34px; padding:6px 42px 0; background-color:#fff; border-radius:18px;}
.applyEvent .sharePlace .paging a {width:29px; height:29px; border:0;}
.applyEvent .sharePlace .paging a span {width:29px; height:29px; padding:0; color:#c6c6c6; font:normal 13px/30px arial; }
.applyEvent .sharePlace .paging a.arrow {margin:0 8px;}
.applyEvent .sharePlace .paging a.arrow span {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/btn_pagination.png);}
.applyEvent .sharePlace .paging a.prev span {background-position:0 0;}
.applyEvent .sharePlace .paging a.next span {background-position:100% 0;}
.applyEvent .sharePlace .paging a.current span {font-weight:bold; color:#2491eb;}
.applyEvent .sharePlace .paging .first,.applyEvent .sharePlace .paging .end {display:none;}
.volume {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol014/bg_noise_06.png);}
@keyframes bounce {
	from, to {transform:translateY(0); animation-timing-function:ease-out;}
	50% {transform:translateY(8px); animation-timing-function:ease-in;}
}
@keyframes move1 {
	from {opacity:1;}
	to {opacity:0; margin-left:-200px; margin-top:-150px;}
}
@keyframes move2 {
	from {opacity:1;}
	to {opacity:0; margin-left:80px; margin-top:200px;}
}
@keyframes move3 {
	from {opacity:1;}
	to {opacity:0; margin-left:-200px; margin-top:150px;}
}
</style>
<script type="text/javascript">
$(function(){
	<% if Request("eCC")<>"" then %>
		window.$('html,body').animate({scrollTop:$("#instagramlist").offset().top}, 0);
//		setTimeout("pagedown()",100);
	<% end if %>
});

$(function(){
	// swipe
	var evtSwiper = new Swiper('.wideSwipe .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:3500,
		simulateTouch:false,
		pagination:'.wideSwipe .pagination',
		paginationClickable:true,
		nextButton:'.wideSwipe .btnNext',
		prevButton:'.wideSwipe .btnPrev'
	})
	$('.wideSwipe .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.wideSwipe .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
	$(".story .btnView").click(function(event){
		$(".story").removeClass("current");
		$(this).closest(".story").addClass("current");
	});

	$(".btnArrow").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(".weplayIs").offset().top},600);
	});
	titleAnimation();
	$(".intro h2 span.tit1").css({"margin-top":"-20px","opacity":"0"});
	$(".intro h2 span.tit2").css({"margin-bottom":"-20px","opacity":"0"});
	$(".intro .airplane").css({"margin-left":"-220px","margin-top":"220px","opacity":"0"});
	function titleAnimation() {
		$(".intro h2 span.tit1").delay(10).animate({"margin-top":"0","opacity":"1"},1000);
		$(".intro h2 span.tit2").delay(10).animate({"margin-bottom":"0","opacity":"1"},1000);
		$(".intro .airplane").delay(700).animate({"margin-left":"0","margin-top":"0","opacity":"1"},1500);
	}
});


//function pagedown(){
//	window.$('html,body').animate({scrollTop:$("#instagramlist").offset().top}, 0);
//}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}
</script>
</head>
<body>
<%' THING. html 코딩 영역 : 클래스명은 thing+볼륨 예) thingVol001 / 이미지폴더는 볼륨을 따라 vol001 %>
<%' Vol.014 Fly Play %>
<div class="thingVol014 flyPlay">
	<div class="section intro">
		<div class="inner">
			<h2>
				<span class="tit1"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/tit_fly.png" alt="Fly" /></span>
				<span class="tit2"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/tit_play.png" alt="Play" /></span>
			</h2>
			<p class="txt1"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/txt_intro_1.png" alt="어린 시절, 꿈을 담아 하늘에 날렸던 종이비행기 텐바이텐에서 종이비행기 국가대표님 WEPLAY와 함께 멀리, 오래, 멋지게 날릴 수 있는 종이비행기를 준비했습니다." /></p>
			<p class="txt2"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/txt_intro_2.png" alt="텐바이텐과 종이비행기 국가대표팀이 알려주는 비행기 접는 방법으로 하늘 높이 날려보세요!" /></p>
			<span class="btnArrow"></span>
			<div class="airplane"></div>
		</div>
	</div>
	<div id="weplayIs" class="section weplayIs">
		<div class="inner">
			<p class="bPad40"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/txt_weplay.png" alt="종이비행기 국가대표가 있다는 걸 아시나요?" /></p>
			<a href="http://www.redbullpaperwings.com//Countries/South_Korea/" target="_blank"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/btn_go.png" alt="사이트 바로가기" /></a>
			<p class="team"><a href="https://youtu.be/88C_9A9JAec" target="_blank"><span><img src="http://webimage.10x10.co.kr/playing/thing/vol014/txt_click.png" alt="CLICK" /></span><img src="http://webimage.10x10.co.kr/playing/thing/vol014/txt_weplay_is.png" alt="WEPLAY팀은? 오래날리기 국가대표 이정욱, 멀리 날리기 국가대표 김영준, 곡예 비행 국가대표 이승훈 3명으로 이루어져 있는 종이비행기 국가대표팀입니다." /></a></p>
		</div>
	</div>
	<div class="section video">
		<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol014/tit_video.png" alt="WEPLAY팀과 함께 종이비행기 접는 방법 영상으로 보기" /></h3>
			<p><img src="http://webimage.10x10.co.kr/playing/thing/vol014/txt_dream.png" alt="어릴적 꿈을 담아 날리던 기억들 동심으로 돌아가 종이비행기를 날려보는건 어떨까요?" /></p>
			<div class="videoCont">
				<iframe src="https://player.vimeo.com/video/215664263" title="WEPLAY팀과 함께하는 종이비행기 접는 방법" frameborder="0" allowfullscreen></iframe>
			</div>
		</div>
	</div>
	<%' #1 %>
	<div id="story1" class="section story story1">
		<div class="inner">
			<div class="txt">
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol014/tit_story_01.png" alt="가고 싶은 곳을 생각하며 날려보세요!" /></h3>
				<a href="#story1" id="btn1" class="btnView"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/btn_view_01.png" alt="멀리 날리기 접는 방법 보기" /><span></span></a>
			</div>
			<div class="airplane"></div>
			<div id="process1" class="process"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/img_process_01.png" alt="" /></div>
			<span onclick="javascript:fileDownload(4101);" class="btnPrint"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/btn_print_01.png" alt="패턴 인쇄하기" /></span>
		</div>
	</div>
	<%' #2 %>
	<div id="story2" class="section story story2">
		<div class="inner">
			<div class="txt">
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol014/tit_story_02.png" alt="추억을 담아 하늘 높이 힘껏 날려보세요!" /></h3>
				<a href="#story2" id="btn2" class="btnView"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/btn_view_02_v2.png" alt="높이 날리기 접는 방법 보기" /><span></span></a>
			</div>
			<div class="airplane"></div>
			<div id="process2" class="process"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/img_process_02.png" alt="" /></div>
			<span onclick="javascript:fileDownload(4102);" class="btnPrint"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/btn_print_02.png" alt="패턴 인쇄하기" /></span>
		</div>
	</div>
	<%' #3 %>
	<div id="story3" class="section story story3">
		<div class="inner">
			<div class="txt">
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol014/tit_story_03.png" alt="그려왔던 꿈을 담아 화려하게 날려보세요!" /></h3>
				<a href="#story3" id="btn3" class="btnView"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/btn_view_03.png" alt="곡예 날리기 접는 방법 보기" /><span></span></a>
			</div>
			<div class="airplane"></div>
			<div id="process3" class="process"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/img_process_03.png" alt="" /></div>
			<span onclick="javascript:fileDownload(4103);" class="btnPrint"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/btn_print_03.png" alt="패턴 인쇄하기" /></span>
		</div>
	</div>
	<div class="slideTemplateV15 wideSwipe">
		<div class="swiper-container">
			<div class="swiper-wrapper">
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/img_slide_01.jpg" alt="" /></div>
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/img_slide_02.jpg" alt="" /></div>
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/img_slide_03.jpg" alt="" /></div>
				<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/img_slide_04.jpg" alt="" /></div>
			</div>
			<div class="pagination"></div>
			<button class="slideNav btnPrev">이전</button>
			<button class="slideNav btnNext">다음</button>
			<div class="mask left"></div>
			<div class="mask right"></div>
		</div>
	</div>
	<%' 인스타 공유하기 %>
	<div class="section applyEvent">
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol014/txt_event.png" alt="종이비행기를 접어 가고 싶은 장소를 적은후 인증샷을 남겨주세요. 추첨을 통해 50명에게 텐바이텐 기프트카드 1만원 권을 드립니다." /></h3>
		<a href="https://www.instagram.com/explore/tags/%ED%85%90%EB%B0%94%EC%9D%B4%ED%85%90%EC%A2%85%EC%9D%B4%EB%B9%84%ED%96%89%EA%B8%B0/" target="_blank" class="btnGo"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/btn_instagram.png" alt="인스타그램에 공유하러 가기." /></a>
		<p class="bPad70"><img src="http://webimage.10x10.co.kr/playing/thing/vol014/txt_upload.png" alt="인스타그램에 #텐바이텐종이비행기 해시태그로 업로드해주세요." /></p>
		<div class="noti">
			<div class="inner">
				<h4><img src="http://webimage.10x10.co.kr/playing/thing/vol014/tit_noti.png" alt="NOTICE" /></h4>
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol014/txt_noti_v2.png" alt="인스타그램 계정이 비공개인 경우, 집계가 되지 않습니다./이벤트 기간 동안 #텐바이텐종이비행기 해시태그로 업로드 한 사진은 이벤트 참여를 의미하며 텐바이텐 플레이 페이지에 노출됨을 동의하는 것으로 간주합니다." usemap="#Map" /></p>
				<map name="Map" id="Map">
					<area shape="rect" coords="366,1,535,21" href="/event/eventmain.asp?eventid=65618" alt="텐바이텐 배송상품 보러가기" />
				</map>
			</div>
		</div>
		<%' 인스타 공유 목록 %>
		<% if oinstagramevent.fresultcount > 0 then %>
			<div class="sharePlace" id="instagramlist">
				<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
				<input type="hidden" name="iCTot" value=""/>
				<input type="hidden" name="eCC" value="1">
				</form>
					<ul>
						<%' 이미지 8개씩 노출 %>
						<% for i = 0 to oinstagramevent.fresultcount-1 %>
							<li>
								<div class="pic"><img src="<%= oinstagramevent.FItemList(i).Fimgurl %>" alt="" width="250" height="250" /></div>
								<p><span><%=printUserId(left(oinstagramevent.FItemList(i).Fuserid,10),2,"*")%></span> 님의 종이비행기</p>
							</li>
						<% next %>
					</ul>
				<%' pagination %>
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,10,"jsGoComPage") %>
				</div>
			</div>
		<% end if %>
		<%'// 인스타 공유 목록 %>
	</div>
	<%'// 인스타 공유하기 %>

	<%' volume %>
	<div class="seciton volume">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol014/txt_vol_014.png" alt="vol.014 THING의 사물에 대한 생각 종이비행기, 나의 이야기르르 담아 날려보세요" /></p>
	</div>
</div>
<%' //THING. html 코딩 영역 %>
<!-- #include virtual="/lib/db/dbclose.asp" -->