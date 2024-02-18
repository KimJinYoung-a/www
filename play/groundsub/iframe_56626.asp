<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'########################################################
' PLAY #14 Audio_HELLO RHYTHM BOX
' 2014-11-14 이종화 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21362
Else
	eCode   =  56626
End If

dim com_egCode, bidx
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 15		'한 페이지의 보여지는 열의 수
	iCPerCnt = 10		'보여지는 페이지 간격

	'선택범위 리플개수 접수
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iSelTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	'코멘트 데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
img {vertical-align:top;}
.section {overflow:hidden;}

.rhythm-box .section1 {background:#f4f4f2 url(http://webimage.10x10.co.kr/play/ground/20141117/bg_hand.jpg) no-repeat 50% 0;}
.section1 .group {overflow:hidden; width:1140px; margin:0 auto;}
.section1 .group .hand, .section1 .group h1 {float:left;}
.section1 .group .hand {width:662px;}
.section1 .group h1 {width:478px; padding-top:210px;}
.section2 .group {overflow:hidden; position:relative; z-index:5; width:1140px; height:250px; margin:240px auto;}
.section2 .group .bg {position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/play/ground/20141117/bg_txt_stress_solution.gif) 0 0 no-repeat;}

.section3 .figure img {min-width:1140px; width:100%;}
.section3 .group {border-top:1px solid #fff; background-color:#fea32d;}
.section3 .group .part {width:1140px; margin:0 auto; padding:80px 0 78px; text-align:center;}
.section3 .group .part p {margin-top:50px;}

.section4 {width:1140px; margin:0 auto; padding:150px 0;}

/* slide */
.slide-wrap {margin-top:37px;}
.slide {position:relative;}
.slide .slidesjs-navigation {display:block; position:absolute; top:50%; z-index:500; width:25px; height:51px; margin-top:-25px; background-color:transparent; background-repeat:no-repeat; background-image:url(http://webimage.10x10.co.kr/play/ground/20141117/btn_nav.png); text-indent:-999em;}
.slide .slidesjs-previous {left:30px; background-position:0 0;}
.slide .slidesjs-next {right:30px; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; width:100%; height:23px; padding-top:45px; text-align:center;}
.slidesjs-pagination li {display:inline; height:23px;}
.slidesjs-pagination li a {display:inline-block; zoom:1; *display:inline; width:20px; height:23px; margin:0 15px;background-image:url(http://webimage.10x10.co.kr/play/ground/20141117/btn_paging.png); background-repeat:no-repeat; *font-size:0px; text-indent:-999em; *text-indent:0; }
.slidesjs-pagination li.num01 a {background-position:0 0;}
.slidesjs-pagination li.num01 a.active {background-position:0 100%;}
.slidesjs-pagination li.num02 a {background-position:-20px 0;}
.slidesjs-pagination li.num02 a.active {background-position:-20px 100%;}
.slidesjs-pagination li.num03 a {background-position:-40px 0;}
.slidesjs-pagination li.num03 a.active {background-position:-40px 100%;}
.slidesjs-pagination li.num04 a {background-position:-60px 0;}
.slidesjs-pagination li.num04 a.active {background-position:-60px 100%;}
.slidesjs-pagination li.num05 a {background-position:-80px 0;}
.slidesjs-pagination li.num05 a.active {background-position:-80px 100%;}
.slidesjs-pagination li.num06 a {background-position:-100px 0;}
.slidesjs-pagination li.num06 a.active {background-position:-100px 100%;}
.slidesjs-pagination li.num07 a {background-position:-120px 0;}
.slidesjs-pagination li.num07 a.active {background-position:-120px 100%;}
.slidesjs-pagination li.num08 a {background-position:-140px 0;}
.slidesjs-pagination li.num08 a.active {background-position:-140px 100%;}

.section4 + .section5 {margin-top:0;}
.section5, .section6, .section7 {position:relative; height:1200px; margin-top:60px; background-color:#ededed;}
.section5 .figure, .section6 .figure, .section7 .figure {position:absolute; top:0; left:50%; margin-left:-960px;}
.section5 p, .section6 p, .section7 p {position:relative; width:1140px; margin:0 auto;}
.section5 p img, .section6 p img, .section7 p img {position:absolute;}
.section5 p img {top:630px; left:128px;}
.section6 p img {top:670px; right:140px;}
.section7 p img {top:672px; left:20px;}

.section8 {background-color:#fe9334;}
.section8 .present {position:relative; width:1140px; margin:0 auto; padding:55px 0;}
.section8 .present h2 + p {margin-top:33px;}
.section8 .present button {overflow:hidden; display:block; position:absolute; top:83px; right:0; width:324px; height:85px; font-size:11px; line-height:85px; text-align:center;}
.section8 .present button span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background-image:url(http://webimage.10x10.co.kr/play/ground/20141117/btn_entry.gif); background-repeat:no-repeat;}
.section8 .present .count {position:absolute; top:194px; right:0; text-align:right;}
.section8 .present .count strong {padding-left:22px; color:#fff; font-size:50px; font-family:'Courier New'; font-weight:normal; line-height:0.625em;}
.section9 {width:1140px; margin:0 auto; padding:97px 0 50px;}
.section9 ul {width:1176px; margin:0 -18px;}
.section9 ul li {float:left; width:260px; height:360px; padding:33px 17px 0;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	/* slide */
	$(".slide").slidesjs({
		width:"1140",
		height:"720",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:5000, effect:"fade", auto:true},
		effect:{fade: {speed:1500, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.slide').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$(".slidesjs-pagination li:nth-child(1)").addClass("num01");
	$(".slidesjs-pagination li:nth-child(2)").addClass("num02");
	$(".slidesjs-pagination li:nth-child(3)").addClass("num03");
	$(".slidesjs-pagination li:nth-child(4)").addClass("num04");
	$(".slidesjs-pagination li:nth-child(5)").addClass("num05");
	$(".slidesjs-pagination li:nth-child(6)").addClass("num06");
	$(".slidesjs-pagination li:nth-child(7)").addClass("num07");
	$(".slidesjs-pagination li:nth-child(8)").addClass("num08");

	/* animation */
	$(".section5 p img").css({"opacity":"0"});
	$(".section6 p img").css("right", "40px");
	$(".section7 p img").css("top", "600px");

	function showText01() {
		$(".section5 p img").delay(500).animate({"opacity":"1"},300);
	}
	function showText02() {
		$('.section6 p img').animate({'margin-right':'100px'},4000, showText02);
	}

	function showText03() {
		$('.section7 p img').animate({'margin-top':'136px'},6000, showText03);
	}

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 4300){
			showText01()
		}
		if (scrollTop > 5000){
			showText02()
		}
		if (scrollTop > 5500){
			showText03()
		}
	});
});
</script>
<script type="text/javascript">
<!--
 	function jsSubmitComment(){
	   <% If IsUserLoginOK() Then %>
			<% If Now() > #12/09/2014 23:59:59# Then %>
				alert("이벤트가 종료되었습니다.");
				return;
			<% Else %>
				var frm = document.frmcom;
				frm.action = "doEventSubscript56626.asp";
				frm.submit();
				return true;
			<% End If %>
		<% Else %>
			 jsChklogin('<%=IsUserLoginOK%>');
		     return false;
		<% End IF %>
	}
//-->
</script>
<div class="playGr20141117">
	<div class="rhythm-box">
		<div class="section section1">
			<div class="group">
				<span class="hand"><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_ani_hello.gif" alt="" /></span>
				<h1><img src="http://webimage.10x10.co.kr/play/ground/20141117/tit_rhythm_box.png" alt="헬로 리듬 박스" /></h1>
			</div>
		</div>

		<div class="section section2">
			<div class="group">
				<div class="bg"></div>
				<h2>여러분은 스트레스 받을 때 어떻게 해소하시나요?</h2>
				<p>실제로 많은 사람들이 좋아하는 음악을 들으면서 마음의 짐이나, 스트레스를 치유하는 데 많은 도움을 받는다고 합니다. 텐바이텐 PLAY는 음악이 흐르는 것처럼 스트레스를 흘려보낼 수 있기를 바라는 마음에서 RHYTHM BOX를 만들었습니다. 소리가 어떻게 전해지는지 기본적인 원리를 알 수 있고, 듣는 즐거움이 어떻게 생겨나는지 이해할 수 있도록 직접 만들어 볼 수 있는 종이컵 스피커 KIT, 스트레스를 말끔히 없애 주기는 어렵지만 조금이라도 도움이 되길 바라는 마음에서 쓰레기봉투, 면봉, 이태리타월을 담았습니다.</p>
				<p><strong>인생 속, 리듬을 맞추고 좋아하는 음악 속, 리듬을 맞춰 가면서 즐거운 인생 만들어 가시길 바랍니다 : )</strong></p>
			</div>
		</div>

		<div class="section section3">
			<div class="figure"><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_the_rhythm_box.jpg" alt="리듬 박스" /></div>
			<div class="group">
				<div class="part">
					<h2><img src="http://webimage.10x10.co.kr/play/ground/20141117/tit_rhythm_box_item.gif" alt="리듬 박스 아이템" /></h2>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/txt_rhythm_box_item.gif" alt="리듬 박스는 종이컵 스피커 만들기 키트와 키드 매뉴얼 북, 쓰레기 봉투, 면봉, 이태리 타월로 구성되어있습니다." /></p>
				</div>
			</div>
		</div>

		<div class="section section4">
			<h2><img src="http://webimage.10x10.co.kr/play/ground/20141117/tit_make_papercup_speaker.gif" alt="리듬맨과 함께 종이컵 스피커 만들기" /></h2>
			<div class="slide-wrap">
				<div class="slide">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_slide_01.jpg" alt="리듬 박스는 종이컵, 네오디뮴자석, 에나멜선, 
					이어폰 잭, 필름 통, 사포, 양면테이프, 투명테이프로 구성되어 있습니다. 종이컵 스피커는 스피커의 원리를 확인하기 위한 KIT로 종이컵을 귀에 댔을 때 음악이나 말소리가 또렷이 들리는 정도의 크기 입니다. 우리가 주로 사용하는 일반적인 스피커는 전원이 연결된 증폭장치가 있어 매우 크게 들리며, 실험에서 만들어지는 종이컵 스피커는 이어폰에 가깝습니다. :)" /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_slide_02.jpg" alt="에나멜선의 양 끝을 사포로 문질러 표면을 벗겨주세요." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_slide_03.jpg" alt="에나멜선을 필름 통에 약 20회 정도 감고, 투명테이프로 필름 통 입구부분에 고정시켜주세요." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_slide_04.jpg" alt="종이컵의 바깥쪽 바닥 중앙에 네오디뮴자석을 양면테이프를 이용해서 붙여주세요." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_slide_05.jpg" alt="애나멜선이 감긴 필름 통을 종이컵 바닥에 투명테이프를 이용하여 고정시켜주세요." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_slide_06.jpg" alt="이어폰 잭의 전선 두 가작의 피복을 제거해주세요." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_slide_07.jpg" alt="준비된 이어폰 잭의 전선을 에나멜선 양 끝에 각각 연결하고, 투명 테이프로 고정시켜주세요." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_slide_08.jpg" alt="이어폰 잭을 라디오나 핸드폰에 꽂아 볼륨을 최대로 한 다음 소리를 들어보세요." /></p>
				</div>
			</div>
		</div>

		<div class="section section5">
			<div class="figure"><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_cotton_swab.jpg" alt="" /></div>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/txt_cotton_swab.png" alt="나쁜 소리들은 면봉으로 제거하고 그 자리 좋은 곡들을 차곡차곡담으세요." /></p>
		</div>

		<div class="section section6">
			<div class="figure"><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_towel.jpg" alt="" /></div>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/txt_towel.png" alt="이태리 타월로 피로와 스트레스는 싸악 밀어내고, 깨끗이 씻어 내세요." /></p>
		</div>

		<div class="section section7">
			<div class="figure"><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_trash_bag.jpg" alt="" /></div>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/txt_trash_bag.png" alt="쓰레기 봉투에 나쁜 것들은 꽁꽁 싸매서 버리세요. 버리면 좋은 것들은 더 많이 채워져요." /></p>
		</div>

		

		<!-- for dev msg : -리듬 박스 응모 -->
		<form name="frmcom" method="post" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>"/>
		<input type="hidden" name="bidx" value="<%=bidx%>"/>
		<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
		<input type="hidden" name="iCTot" value=""/>
		<input type="hidden" name="mode" value="add"/>
		<input type="hidden" name="spoint" value="1">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
		<div class="section section8">
			<div class="present">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20141117/tit_present.gif" alt="" /></h2>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20141117/txt_date.gif" alt="" /></p>
				<button type="button" onclick="jsSubmitComment();return false;">리듬박스 신청하기<span></span></button>
				<p class="count">
					<img src="http://webimage.10x10.co.kr/play/ground/20141117/txt_total.gif" alt="총" />
					<strong><%=iCTotCnt%></strong>
					<img src="http://webimage.10x10.co.kr/play/ground/20141117/txt_want.gif" alt="명이 리듬 박스를 원합니다." />
				</p>
			</div>
		</div>
		</form>

		<div class="section section9">
			<ul>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_01.jpg" alt="종이컵" /></li>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_02.jpg" alt="이어폰 잭" /></li>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_03.jpg" alt="이태리 타월" /></li>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_04.gif" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_05.jpg" alt="네오디뮴자석" /></li>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_06.jpg" alt="투명테이프" /></li>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_07.jpg" alt="양면테이프" /></li>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_08.jpg" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_09.gif" alt="" /></li>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_10.jpg" alt="쓰레기 봉투" /></li>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_11.jpg" alt="에나멜선" /></li>
				<li><img src="http://webimage.10x10.co.kr/play/ground/20141117/img_kit_12.jpg" alt="면봉" /></li>
			</ul>
		</div>

	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->