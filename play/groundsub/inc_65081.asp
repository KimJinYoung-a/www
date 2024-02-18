<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbCTopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'########################################################
' PLAY #22 BOTTLE 4주차 
' 2015-07-24 원승현 작성
'########################################################
Dim eCode, eCodedisp
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64839
	eCodedisp = 64839
Else
	eCode   =  65081
	eCodedisp = 65081
End If


dim userid, i, vreload
	userid = getloginuserid()

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt, sqlstr
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호


IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 4		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 6	'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 6	'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if


'// sns데이터 총 카운팅 가져옴
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from [db_Appwish].[dbo].[tbl_snsSelectData]"
	rsCTget.Open sqlstr, dbCTget, adOpenForwardOnly, adLockReadOnly
		iCTotCnt = rsCTget(0)
	rsCTget.close


iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundHeadWrap {background-color:#f6f6f6;}
.groundCont {padding-bottom:80px; background:#e1f2f4 url(http://webimage.10x10.co.kr/play/ground/20150727/bg_comb_pattern_02_v1.png) repeat 0 0;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:76px 20px 40px;}

img {vertical-align:top;}
.playGr20150727 {min-width:1140px;}

.topic {overflow:hidden; position:relative; padding:142px 0 166px; background-color:#fff;}
.topic .inner {position:relative; width:1140px; margin:0 auto;}
.topic .inner .hgroup {min-height:768px; padding-left:670px;}
.topic .inner .hgroup .bottle {position:absolute; top:0; left:124px; width:506px;}
.topic .inner .hgroup .bottle h3 span {position:absolute; background:url(http://webimage.10x10.co.kr/play/ground/20150727/txt_title_v1.png) no-repeat 0 0; text-indent:-999em;}
.topic .inner .hgroup .bottle h3 .letter1 {top:206px; left:0; width:100px; height:174px;}
.topic .inner .hgroup .bottle h3 .letter2 {top:206px; left:315px; width:108px; height:120px; background-position:100% 0;}
.topic .inner .hgroup .bottle h3 .letter3 {top:373px; left:311px; width:110px; height:117px; background-position:100% -167px;}
.topic .inner .hgroup .bottle h3 .letter4 {top:537px; left:311px; width:109px; height:118px; background-position:100% 100%;}
.topic .inner .hgroup .bottle h3 .letter5 {top:536px; left:350px; width:155px; height:166px; background-position:0 100%;}
.topic .inner .hgroup .bottle div {position:absolute; top:0; left:86px;}
/*.topic .inner .hgroup .bottle div img {transition:1.8s ease; transform-origin:50% 0%; transform:rotateZ(180deg);}
.topic .inner .hgroup .bottle div .reRotate {transform:rotateZ(0deg);}*/

.topic .inner .hgroup .desc {padding-top:280px;}
.topic .inner .hgroup .desc span {margin-left:7px;}
.topic .inner .hgroup .desc p {width:422px; height:38px; background:url(http://webimage.10x10.co.kr/play/ground/20150727/txt_topic_v1.png) no-repeat 0 0; text-indent:-999em;}
.topic .inner .hgroup .desc .desc2 {height:113px; margin-top:30px; background-position:0 -68px;}
.topic .inner .hgroup .desc .desc3 {height:42px; margin-top:37px; background-position:0 100%;}
.topic .btngo {position:relative; z-index:5; margin-top:188px; text-align:center;}
.topic .young1 {position:absolute; top:113px; left:50%; margin-left:257px;}
.topic .young2 {position:absolute; bottom:152px; left:50%; margin-left:-960px;}
.topic .young3 {position:absolute; bottom:0; left:50%; margin-left:145px;}

.rolling1 {height:894px; background-color:#fafafa;}
.swiper {overflow:hidden; position:relative; width:100%; height:894px; text-align:center;}
.swiper .swiper-container {overflow:hidden; width:100%; height:894px;}
.swiper .swiper-wrapper {overflow:hidden; position:relative; width:100%;}
.swiper .swiper-slide {float:left; position:relative; width:100%; height:894px;}
.swiper .swiper-slide .article {position:absolute; top:269px; left:50%;  margin-left:-324px;}

.swiper .pagination {display:none;}
.swiper .btn-nav {display:block; position:absolute; top:50%; left:50%; z-index:500; width:35px; height:67px; margin-top:-33px; background:transparent url(http://webimage.10x10.co.kr/play/ground/20150727/btn_nav_01.png) no-repeat 0 0; text-indent:-999em}
.swiper .prev {margin-left:-540px;}
.swiper .next {margin-left:540px; background-position:100% 0;}

.sticker {position:relative; padding:448px 0 115px; text-align:center; background-color:#fff;}
.sticker h4 {position:absolute; top:112px; left:50%; width:884px; height:339px; margin-left:-442px;}
.sticker h4 span {display:block; position:absolute; background:url(http://webimage.10x10.co.kr/play/ground/20150727/tit_nine_sticker.png) no-repeat 0 0; text-indent:-9999em;}
.sticker h4 .letter1 {top:0; left:0; width:884px; height:75px;}
.sticker h4 .letter2 {top:112px; left:0; width:228px; height:225px; background-position:0 100%;}
.sticker h4 .letter3 {top:112px; left:332px; width:216px; height:225px; background-position:-332px 100%;}
.sticker h4 .letter4 {top:112px; right:0; width:218px; height:225px; background-position:100% 100%;}
.sticker .bottle {position:relative; z-index:5; width:798px; height:422px; margin:-50px auto 48px;}
.sticker .bottle span {position:absolute;}
.sticker .bottle .bottle1 {top:0; left:0;}
.sticker .bottle .bottle2 {top:0; left:332px;}
.sticker .bottle .bottle3 {top:0; right:0;}
.sticker p {clear:both;}

.instructions {height:1291px; background:#85e5f1 url(http://webimage.10x10.co.kr/play/ground/20150727/bg_pattern.png) repeat 0 0;}
.instructions .inner {width:1140px; margin:0 auto; padding-top:122px; background:url(http://webimage.10x10.co.kr/play/ground/20150727/bg_arrow_v1.png) no-repeat 50% 0;}
.instructions h4 {margin-left:205px;}
.instructions p {width:1088px; margin-top:50px; margin-left:27px; border-bottom:1px solid #d4f0fc; text-align:center;}
.instructions p span {display:block; width:100%; height:1px; margin-top:20px; background-color:#72d7e4;}
.instructions .instructions1 {margin-top:30px;}
.instructions .instructions2 span {margin-top:50px;}
.instructions .instructions3 {border-bottom:0;}

.consolation {padding-bottom:20px; background:#00b9eb url(http://webimage.10x10.co.kr/play/ground/20150727/bg_comb_pattern_01.png) repeat-x 0 100%; text-align:center;}
.consolation p {visibility:hidden; width:0; height:0;}

.rolling2 {background:#b3b3b3 url(http://webimage.10x10.co.kr/play/ground/20150727/bg_green.jpg) no-repeat 50% 0;}
.rolling2 .slide-wrap {overflow:hidden; position:relative; height:831px;}
.rolling2 .slide {position:absolute; top:0; left:50%; width:1490px; margin-left:-745px;}
.rolling2 .slide .slidesjs-navigation {position:absolute; bottom:83px; z-index:50; width:9px; height:14px; background:url(http://webimage.10x10.co.kr/play/ground/20150727/btn_nav_02.png) no-repeat 0 0; text-indent:-999em;}
.rolling2 .slide .slidesjs-previous {left:655px;}
.rolling2 .slide .slidesjs-next {right:655px; background-position:100% 0;}
.rolling2 .slidesjs-pagination {overflow:hidden; position:absolute; bottom:83px; left:50%; z-index:50; width:150px; margin-left:-75px;}
.rolling2 .slidesjs-pagination li {float:left; padding:0 8px;}
.rolling2 .slidesjs-pagination li a {display:block; width:14px; height:14px; background:url(http://webimage.10x10.co.kr/play/ground/20150727/btn_pagination.png) no-repeat 100% 0; text-indent:-999em;}
.rolling2 .slidesjs-pagination li a.active {background-position:0 0;}

.instagram {padding-top:53px; text-align:center;}
.instagramList {overflow:hidden; width:1125px; margin:20px auto 80px;}
.instagramList li {overflow:hidden; float:left; width:327px; height:327px; padding:14px; margin:20px 10px 0; background:url(http://webimage.10x10.co.kr/play/ground/20150727/bg_box.png) repeat 0 0;}
.instagramList li a {display:block; width:327px; height:327px;}
.instagramList li a img {transition:transform 1s ease-in-out;}
.instagramList li a:hover img {transform:scale(1.1);}

.pageWrapV15 .pageMove {display:none;}

/* css3 animation */
.pulse {animation-name:pulse; animation-duration:8s; animation-fill-mode:both; animation-iteration-count:infinite;}
@keyframes pulse {
	0% {transform:scale(1);}
	50% {transform:scale(0.7);}
	100% {transform:scale(1);}
}

.bounce {-webkit-animation-name:bounce; -webkit-animation-iteration-count:infinite; -webkit-animation-duration:1.5s; -moz-animation-name:bounce; -moz-animation-iteration-count:infinite; -moz-animation-duration:1.5s; -ms-animation-name:bounce; -ms-animation-iteration-count:infinite; -ms-animation-duration:1.5s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:40px; -webkit-animation-timing-function:ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:40px; animation-timing-function:ease-in;}
}
</style>
<script type="text/javascript">
<!--
 	function jsSubmitComment(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

	   var frm = document.frmcom;
	   frm.action = "/event/lib/comment_process.asp";
	   frm.submit();
	   return true;
	}
//-->
</script>
<div class="playGr20150727">
	<div class="topic">
		<div class="inner">
			<div class="hgroup">
				<div class="bottle">
					<h3>
						<span class="letter1">9</span>
						<span class="letter2">아</span>
						<span class="letter3">홉</span>
						<span class="letter4">수</span>
						<span class="letter5">水</span>
					</h3>
					<div><img src="http://webimage.10x10.co.kr/play/ground/20150727/img_bottle.png" alt="" /></div>
				</div>
				<div class="desc">
					<span><img src="http://webimage.10x10.co.kr/play/ground/20150727/img_water_drop_v2.gif" alt="" /></span>
					<p class="desc1"><strong>기획자는 스물아홉 &apos;아홉수&apos; 입니다.</strong></p>
					<p class="desc2">흔히들 아홉수는 운이 좋지 않은 시기라고들 합니다. 하지만, 굳이 부정적으로 생각할 필요가 있을까요? 곧 있으면 나이의 앞자리가 바뀌는 지금. 한 단계 더 올라서서 어른이 될 준비를 하는 시기라고 생각하고, 가볍게 웃어 넘겨보면 어떨까요.</p>
					<p class="desc3">여러분을 응원하기 위해 아홉(9)이 새겨진 아홉수(水) 보틀을 준비해 보았습니다. 소소한 재미를 이 보틀에 담아 마시며 여름을 시원하게 즐겨 보세요!</p>
				</div>
			</div>
			<div class="btngo">
				<a href="#instagram"><img src="http://webimage.10x10.co.kr/play/ground/20150727/btn_go.gif" alt="인스타그램 태그하고 보틀 받기!" /></a>
			</div>
		</div>
		<p class="young1"><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_we_are_young.png" alt="we are young" /></p>
		<p class="young2"><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_number_nine.png" alt="number nine" /></p>
		<p class="young3"><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_num.png" alt="9 19 29" /></p>
	</div>

	<div class="rolling1">
		<div class="swiper">
			<div class="swiper-container swiper1">
				<div class="swiper-wrapper">
					<div class="swiper-slide swiper-slide-1">
						<p class="article"><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_water_01.png" alt="원효대사님의 해골물 하는 일마다 잘 안 되는 것 같지만, 알고 보면 다 마음을 어떻게 먹느냐에 따라 다르다. 시원한 냉수 한잔 마시고 깨달음을 얻어보자!" /></p>
						</p>
						<img src="http://webimage.10x10.co.kr/play/ground/20150727/img_swiper_01.jpg" alt="원효대사 해골물 보틀" />
					</div>
					<div class="swiper-slide swiper-slide-2">
						<p class="article"><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_water_02.png" alt="봉이김선달의 대동강물 봉이 김선달이 대동강 물을 팔아낸 것 같은 두둑한 배짱과 용기로 가득 찬 하루를 위하여, 지화자!" /></p>
						<img src="http://webimage.10x10.co.kr/play/ground/20150727/img_swiper_02.jpg" alt="봉이김선달 대동강물 보틀" />
					</div>
					<div class="swiper-slide swiper-slide-3">
						<p class="article"><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_water_03.png" alt="깊은산속의 옹달샘물새벽에 눈 비비고 일어난 토끼와 같은 토끼띠 스물아홉! 성실함과 부지런함을 재충전해보자!" /></p>
						<img src="http://webimage.10x10.co.kr/play/ground/20150727/img_swiper_03.jpg" alt="깊은산속 옹달샘물 보틀" />
					</div>
				</div>
			</div>
			<div class="pagination"></div>
			<button type="button" class="btn-nav prev">이전</button>
			<button type="button" class="btn-nav next">다음</button>
		</div>
	</div>

	<div class="sticker">
		<h4>
			<span class="letter1">아홉수에 맛을 더하는 3종 스티커</span>
			<span class="letter2">아</span>
			<span class="letter3">홉</span>
			<span class="letter4">수</span>
		</h4>
		<div class="bottle">
			<span class="bottle1"><img src="http://webimage.10x10.co.kr/play/ground/20150727/img_bottle_width_nine_sticker.png" alt="" /></span>
			<span class="bottle2"><img src="http://webimage.10x10.co.kr/play/ground/20150727/img_bottle_width_nine_sticker.png" alt="" /></span>
			<span class="bottle3"><img src="http://webimage.10x10.co.kr/play/ground/20150727/img_bottle_width_nine_sticker.png" alt="" /></span>
		</div>
		<p><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_nine_sticker.png" alt="" /></p>
	</div>

	<div class="instructions">
		<div class="inner">
			<h4><img src="http://webimage.10x10.co.kr/play/ground/20150727/tit_instructions.png" alt="아홉수 사용법" /></h4>
			<p class="instructions1"><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_instructions_01.png" alt="아홉수를 받아 들고 주문을 외웁니다. 아무도 없는 곳에서 외워야만 효과적입니다. 주문이 들어간 부적은 별첨입니다." /><span></span></p>
			<p class="instructions2"><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_instructions_02.png" alt="주문을 외우면서 원하는 물 스티커를 부착합니다. 주문에 정성이 들어가야만 한번에 제대로 부착됩니다. 수전증이 있으신 분은 주변에 도움을 요청하세요." /><span></span></p>
			<p class="instructions3"><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_instructions_03.png" alt="물, 커피 또는 음료 등을 담아 아홉수의 여름을 시원하게 보냅니다." /></p>
		</div>
	</div>

	<div class="rolling2">
		<div class="slide-wrap">
			<div id="slide" class="slide">
				<div><img src="http://webimage.10x10.co.kr/play/ground/20150727/img_slide_01_v1.jpg" alt="YOU &amp; ME 아홉수 보틀 마주치는 순간, 우리는 동갑내기라는 걸 알아버렸다..." /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20150727/img_slide_02_v1.jpg" alt="힘내! 아직 우린 젊기에, 괜찮은 미래가 있기에" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20150727/img_slide_03.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20150727/img_slide_04.jpg" alt="" /></div>
				<div><img src="http://webimage.10x10.co.kr/play/ground/20150727/img_slide_05.jpg" alt="" /></div>
			</div>
		</div>
	</div>

	<div id="instagram" class="consolation">
		<h4><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_consolation.png" alt="아홉수 화이팅! 나에게 힘이 되어 주는 것들!" /></h4>
		<p>인스타그램에  #텐바이텐아홉수  해시태그와 함께 여러분에게 힘이 되는 것들을 업로드 해주세요. 총 30분에게 아홉수 보틀 &amp; 3종 스티커 세트를 선물로 드립니다! 신청기간은 7월 27일부터 8월 10일까지며 당첨자 발표는 8월 11일입니다.</p>
		<p>계정이 비공개인 경우, 집계가 되지 않습니다. 이벤트 기간 동안 &apos;#텐바이텐아홉수&apos; 해시태그로 업로드 한 사진은 이벤트 참여를 의미하며, 텐바이텐 플레이 페이지 노출에 동의하는 것으로 간주합니다.</p>
	</div>


	<%' instagram %>
	<div class="instagram">
		<p><img src="http://webimage.10x10.co.kr/play/ground/20150727/txt_instagram.png" alt="텐바이텐 인스타그램 계정 (@your10x10) 을 팔로우 하고 텐바이텐 계정을 해당 사진에 ‘함께한 친구로 태그’하면 당첨 확률이 높아집니다!" /></p>

		<%' for dev msg : 인스타그램 %>
		<ul class="instagramList">
		<%
			sqlstr = "Select * From "
			sqlstr = sqlstr & " ( "
			sqlstr = sqlstr & " Select row_Number() over (order by idx desc) as rownum, snsid, link, img_low, img_thum, img_stand, text, snsuserid, snsusername, regdate "
			sqlstr = sqlstr & " From db_AppWish.dbo.tbl_snsSelectData "
			sqlstr = sqlstr & " ) as T "
			sqlstr = sqlstr & " Where RowNum between "&(iCCurrpage*iCPageSize)-5&" And "&iCCurrpage*iCPageSize&" "
			rsCTget.Open sqlstr, dbCTget, adOpenForwardOnly, adLockReadOnly
			If Not(rsCTget.bof Or rsCTget.eof) Then
				Do Until rsCTget.eof
		%>
			<li><a href="<%=rsCTget("link")%>"  target="_blank"><img src="<%=rsCTget("img_stand")%>" width="327" height="327" alt="" /></a></li>
		<%
				rsCTget.movenext
				Loop
		%>
		</ul>

		<%' paging %>
		<div class="pageWrapV15">
			<div class="paging">
				<%=fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,4,"jsGoComPage")%>
			</div>
		</div>
		<%
			End If
			rsCTget.close
		%>
	</div>
	<%' //instagram %>
</div>

<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
	<input type="hidden" name="iCC" value="1">
	<input type="hidden" name="iCTot" value="<%= iCTotCnt %>">
	<input type="hidden" name="userid" value="<%= userid %>">
</form>
<script type="text/javascript">
$(function(){
	var mySwiper = new Swiper('.swiper-container',{
		//mode:'vertical',
		loop:true,
		resizeReInit:true,
		calculateHeight:true,
		pagination:'.pagination',
		paginationClickable:true,
		speed:3200,
		autoplay:8000,
		autoplayDisableOnInteraction:false,
		//mousewheelControl: true,
		simulateTouch:false,
		onSlideChangeStart: function(){
			$(".swiper-slide").find(".article").delay(500).animate({"top":"369px", "opacity":"0"},300);
			$(".swiper-slide-active").find(".article").delay(50).animate({"top":"269px", "opacity":"1"},1000);
		}
	});

	$('.prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	});
	$('.next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});
	//화면 회전시 리드로잉(지연 실행)
	$(window).on("orientationchange",function(){
		var oTm = setInterval(function () {
			mySwiper.reInit();
				clearInterval(oTm);
			}, 500);
	});
	
	$("#slide").slidesjs({
		width:"1490",
		height:"831",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:5000, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $("#slide").data("plugin_slidesjs");
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	/* move */
	$(".topic .btngo a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 1200);
	});

	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 200 ) {
			topicAnimation();
		}
		if (scrollTop > 2700 ) {
			stickerAnimation();
		}
	});

	$(".topic .bottle span").css({"left":"200px", "opacity":"0"});
	$(".topic .bottle .letter5").css({"left":"150px", "opacity":"0"});
	$(".topic .desc").css({"padding-top":"290px", "opacity":"0"});
	function topicAnimation() {
		$(".topic .bottle .letter2").delay(300).animate({"left":"315px", "opacity":"1"},800);
		$(".topic .bottle .letter3").delay(800).animate({"left":"315px", "opacity":"1"},800);
		$(".topic .bottle .letter4").delay(1300).animate({"left":"315px", "opacity":"1"},800);
		$(".topic .bottle .letter1").delay(1900).animate({"left":"0", "opacity":"1"},800);
		$(".topic .bottle .letter5").delay(2300).animate({"left":"350px", "opacity":"1"},800);
		$(".topic .bottle .letter5").delay(3000).addClass("pulse");
		$(".topic .desc").delay(3500).animate({"padding-top":"280px", "opacity":"1"},800);
	};

	$(".sticker h4 .letter2, .sticker h4 .letter3, .sticker h4 .letter4").css({"opacity":"0"});
	function stickerAnimation() {
		$(".sticker .letter2").delay(200).animate({"opacity":"1"},500);
		$(".sticker .letter3").delay(600).animate({"opacity":"1"},500);
		$(".sticker .letter4").delay(1200).animate({"opacity":"1"},500);
	}

	<% if Request("iCC")<>"" or Request("eCC")<>"" then %>
		window.parent.$('html,body').animate({scrollTop:$("#instagram").offset().top}, 0);
	<% end if %>
});

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<!-- #include virtual="/lib/db/dbCTclose.asp" -->