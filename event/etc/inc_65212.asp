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
' 내 옆에 있는 사람 
' 2015-07-28 이종화 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64842
Else
	eCode   =  65212
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

	iCPageSize = 26		'한 페이지의 보여지는 열의 수
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
.evtEndWrapV15 {display:none;}
.evt65212 {background-color:#fff;}
.evt65212 .topic {position:relative; height:573px; background:#8f9eb6 url(http://webimage.10x10.co.kr/eventIMG/2015/65212/bg_leaf.jpg) no-repeat 50% 0;}
.evt65212 .topic p {padding-top:25px;}
.evt65212 .topic .hgroup {position:absolute; top:110px; left:50%; margin-left:-140px;}
.evt65212 .topic .hgroup .concert {width:281px; height:66px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65212/tit_book_concert_v1.png) no-repeat 50% 0; text-indent:-999em;}
.evt65212 .topic .hgroup h2 {width:281px; height:170px; margin-top:9px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65212/tit_book_concert_v1.png) no-repeat 50% -100px; text-indent:-999em;}
.evt65212 .topic .hgroup .invite {width:281px; height:38px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65212/tit_book_concert_v1.png) no-repeat 50% 100%; text-indent:-999em;}
.evt65212 .topic .circle {position:absolute; top:66px; left:50%; width:458px; height:458px; margin-left:-229px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65212/img_circle.png) no-repeat 50% 0;}

.twinkle {animation-name:twinkle; -webkit-animation-name:twinkle; animation-iteration-count:5; -webkit-animation-iteration-count:5; animation-duration:5s; -webkit-animation-duration:5s; animation-fill-mode:both;-webkit-animation-fill-mode:both;}
/* FadeIn animation */
@-webkit-keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}
@keyframes twinkle {
	0% {opacity:0;}
	100% {opacity:1;}
}

.story {padding:60px 0 60px 60px; background-color:#f2f2f1;}
.story ul {overflow:hidden; width:1050px; margin-top:35px;}
.story ul li {overflow:hidden; float:left; position:relative; height:250px; margin:15px 15px 0 0; cursor:pointer;}
.story ul .over {position:absolute; top:0; left:0; height:0; transition:opacity 0.8s ease-out; opacity:0; filter: alpha(opacity=0);}
.story ul .off {opacity:1; transition:0.8s;}
.story ul li:hover .over {opacity:1; filter: alpha(opacity=100); height:250px;}
.story ul li:hover .off {opacity:0.6;}
.book {padding-top:49px; padding-bottom:60px; background-color:#51698e;}
.book .desc {position:relative;}
.book .desc .btnmore {position:absolute; top:49px; right:209px;}
.book .desc .line {position:absolute; top:111px; left:349px; width:460px; height:2px; background-color:#fff;}
.slide-wrap {position:relative; width:956px; height:630px; margin:0 auto; padding:21px 31px 41px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65212/bg_box.png) no-repeat 50% 0;}
.slide {overflow:visible !important; position:relative; width:894px; height:630px; margin:0 auto;}
.slide .slidesjs-navigation {position:absolute; top:50%; z-index:10; width:24px; height:48px; margin-top:-24px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/65212/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:-54px; background-position:0 0;}
.slide .slidesjs-next {right:-54px; background-position:100% 0;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:-46px; left:0; z-index:50; width:100%; text-align:center;}
.slidesjs-pagination li {display:inline-block; padding:0 4px;}
.slidesjs-pagination li {zoom:1;*display:inline;}
.slidesjs-pagination li a {display:block; width:5px; height:5px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65212/btn_pagination.png) no-repeat 0 0; text-indent:-999em;}
.slidesjs-pagination li a.active {background-position:100% 0;}
.shadow {position:absolute; top:0; left:50%; z-index:50; width:36px; height:650px; margin-left:-18px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/65212/bg_shadow.png) no-repeat 50% 0;}

.guest h3, .commentevt h3 {visibility:hidden; width:0; height:0;}
.guest {position:relative;}
.guest iframe {position:absolute; top:40px; right:90px;}

.commentevt {height:430px; padding-top:65px; background:#d2dae4 url(http://webimage.10x10.co.kr/eventIMG/2015/65212/bg_grey.png) no-repeat 50% 0;}
.commentevt .who {width:876px; height:55px; margin:34px auto 20px; padding-top:31px; border:1px solid #c4d0e0; background-color:#fff; opacity:0.8;}
.commentevt .who input {width:167px; height:23px; margin:0 3px 0 6px; border-bottom:3px solid #444; color:#6b8ab9; font-family:'Dotum', 'Verdana'; font-size:12px; font-weight:bold; line-height:23px; text-align:center;}
.commentevt .who ::-webkit-input-placeholder {color:#6b8ab9;}
.commentevt .who ::-moz-placeholder {color:#6b8ab9;} /* firefox 19+ */
.commentevt .who :-ms-input-placeholder {color:#6b8ab9;} /* ie */
.commentevt .who input:-moz-placeholder {color:#6b8ab9;}

.count {margin-top:50px;}
.count strong {color:#6b8ab9; font-family:'Verdana', 'Arial'; font-size:22px; font-weight:normal; line-height:21px;}
.count div {margin-top:29px;}

.commentlist .listwrap {padding-bottom:40px; border-bottom:1px solid #dfdfdf;}
.commentlist ul {overflow:hidden; width:1080px; margin:12px auto 0;}
.commentlist ul li {display:inline-block; height:20px; padding:3px 6px 0; margin:8px 4px 0 0; border:1px solid #cdd5e1; border-radius:2px; background-color:#f6f6f6; color:#0e050a; font-family:'Dotum', 'Verdana'; line-height:1.5em;}
.commentlist ul li {zoom:1;*display:inline;}
.commentlist ul li.color1 {border-color:#cdd5e1;}
.commentlist ul li.color2 {border-color:#e2c9e7;}
.commentlist ul li.color3 {border-color:#b9dde4;}

.pageWrapV15 {margin-top:3px; padding-top:20px; border-top:2px solid #dfdfdf;}
.pageWrapV15 .pageMove {display:none;}
</style>
<script type="text/javascript">
<!--
 	function jsGoComPage(iP){
		document.frmcom.iCC.value = iP;
		document.frmcom.iCTot.value = "<%=iCTotCnt%>";
		document.frmcom.submit();
	}

function jsSubmitComment(frm){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

	   if(!frm.txtcomm.value){
	    alert("내 옆에 있는 사람을 입력 해주세요");
		document.frmcom.txtcomm.value="";
	    frm.txtcomm.focus();
	    return false;
	   }

	   frm.action = "/event/lib/comment_process.asp";
	   return true;
	}
//-->
</script>
<div class="evt65212">
	<div class="topic">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/txt_book_concert.png" alt="텐바이텐 컬쳐스테이션 아홉번째 만남" /></p>
		<div class="hgroup">
			<p class="concert">책과 노래가 함께 하는 북콘서트</p>
			<h2>내 옆에 있는 사람</h2>
			<p class="invite">소중한 사람과 함께 하면 더 좋을 이번 공연에 당신을 초대합니다.</p>
		</div>
		<div class="circle"></div>
	</div>

	<div class="story">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/tit_story.png" alt="아주 평범한 일상 같기도 하지만 또 전혀 예상치 못한 인연이 만들어 내는 굉장한 이야기" /></h3>
		<ul>
			<li>
				<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_01_off.jpg" alt="" /></span>
				<p class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_01_over.png" alt="사랑을 통해 성장하는 사람, 사랑을 통해 인간적인 완성을 이루는 사람은 다른 사람과 명백히 다를 수밖에 없다. 사랑은 사람의 색깔을 더욱 선명하고 강렬하게 만들어 사람의 결을 더욱 사람답게 한다. 사랑하는 사람은 무엇으로도 침묵하지 않는다 中" /></p>
			</li>
			<li>
				<p class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_02_off.png" alt="가능하면 사람 안에서, 사람 틈에서 살려고 합니다. 사람이 아니면 아무것도 아닐 것 같아서지요. 선뜻 사랑까지는 바라지 않지요. 매일 기적을 가르쳐주는 사람에게 中" /></p>
				<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_02_over.jpg" alt="" /></span>
			</li>
			<li>
				<p class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_03_off.jpg" alt="" /></p>
				<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_03_over.jpg" alt="" /></span>
			</li>
			<li>
				<p class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_04_off.jpg" alt="" /></p>
				<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_04_over.jpg" alt="" /></span>
			</li>
			<li>
				<p class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_05_off.png" alt="먼길을 떠나는 건 도달할 수 없는 아름다움을 보겠다는 작은 의지와 연결되어 있어. 일상에서는 절대로 만날 수 없는 아름다움이 저기 어느 한켠에 있을 거라고 믿거든. 여행은 인생에 있어 분명한 태도를 가지게 하지 中" /></p>
				<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_05_over.jpg" alt="" /></span>
			</li>
			<li>
				<p class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_06_off.jpg" alt="" /></p>
				<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_06_over.jpg" alt="" /></span>
			</li>
			<li>
				<p class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_07_off.jpg" alt="" /></p>
				<span class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_07_over.jpg" alt="" /></span>
			</li>
			<li>
				<span class="off"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_08_off.jpg" alt="" /></span>
				<p class="over"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_story_08_over.png" alt="단풍이 말이다, 계속해서 남쪽으로 남쪽으로 물들어가는 속도가 사람이 걷는 속도하고 똑같단다. 낮밤으로 사람이 걸어 도착하는 속도와 단풍이 남쪽으로 물들어 내려가는 속도가 일치한단다. 어떻고 어떤 계산법으로 헤아리는 수도 있다는데 도대체 이런 말은 누가 낳아가지고 이 가을, 집 바깥으로 나올 때마다 문득문득 나뭇가지들을 올려보게 한단 말인가. 말과 말 사이에 호흡이 배어 있는 것 같은 이 말은, 이 근거는 누구의 가슴에서 시작됐을까. 이 말들은 누구의 가슴에서 시작됐을까 中" /></p>
			</li>
		</ul>
	</div>

	<div class="book">
		<div class="desc">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/txt_book_v1.png" alt="이 한 권의 책을 집필하면서 마지막 여행산문집이기를 바랐다. by.이병률 내 옆에 있는 사람의 저자는 이병률, 발행일은 2015년 7월 1일이며, 이 책의 장르는 에세이 여행산문집입니다." /></p>
			<a href="/culturestation/culturestation_event.asp?evt_code=3030" target="_blank" title="새창" class="btnmore"><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/btn_more.gif" alt="내 옆에 있는 사람 도서 더 자세히 보러 가기" /></a>
			<div class="line"></div>
		</div>

		<div class="slide-wrap">
			<div id="slide" class="slide">
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_slide_01.jpg" alt="" />
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_slide_02.jpg" alt="" />
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_slide_03.jpg" alt="" />
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_slide_04.jpg" alt="" />
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_slide_05.jpg" alt="" />
				<img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/img_slide_06.jpg" alt="" />
			</div>
			<div class="shadow"></div>
		</div>
	</div>

	<div class="guest">
		<h3>스페셜 게스트</h3>
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/txt_guest.jpg" alt="제주에서 온 강아솔 강아솔의 노래는 솔직하게 다가가 듣는 이의 마음을 강하게 움직이는 힘을 가지고 있다. 또 그녀의 공연에서 관객들은 웃다가 울다가 짙은 여운을 안고 간다." /></p>
		<iframe src="https://www.youtube.com/embed/Pp-U23KGcNQ?list=PL-pnWgiZ4jYdLkfx2S_fYDe1RUVV567ia" width="198" height="132" title="강아솔 언제든 내게" frameborder="0" allowfullscreen></iframe>
	</div>

	<div class="commentevt">
		<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>"/>
		<input type="hidden" name="bidx" value="<%=bidx%>"/>
		<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
		<input type="hidden" name="iCTot" value=""/>
		<input type="hidden" name="mode" value="add"/>
		<input type="hidden" name="spoint" value="1">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
		<input type="hidden" name="hookcode" value="#need"/>
			<fieldset>
			<legend>함께 공연하고싶은 사람 입력</legend>
				<h3>코멘트 이벤트</h3>
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/txt_comment_event_v1.png" alt="텐바이텐이 함께 만드는 북콘서트 내 옆에 있는 사람에 누구와 함께 오고 싶으신가요? 사연을 남겨주시면 30쌍을 추첨해 북콘서트에 초대합니다." /></p>
				<div class="who">
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/txt_who_01.png" alt="나는 내 옆에 있는 사람," />
					<input type="text" title="함께 공연을 즐기고 싶은 사람 입력" placeholder="10자 이내로 입력하세요." name="txtcomm" maxlength="10"/>
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/txt_who_02.png" alt="와 함께 이 공연을 즐기고 싶어요!" />
				</div>
				<input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/65212/btn_submit.png" alt="응모하기" />
			</fieldset>
		</form>
		<form name="frmdelcom" method="post" action="/event/lib/comment_process.asp" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="Cidx" value="">
		<input type="hidden" name="mode" value="del">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
		</form>
	</div>

	<div class="count" id="need">
		<img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/txt_count_01.png" alt="내 옆에 있는 사람 신청자는 총" />
		<strong><%=FormatNumber(iCTotCnt,0)%></strong>
		<img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/txt_count_02.png" alt="명 입니다." />
		<div><img src="http://webimage.10x10.co.kr/eventIMG/2015/65212/ico_ampersand.png" alt="" /></div>
	</div>
	
	<% IF isArray(arrCList) THEN %>
	<div class="commentlist">
		<div class="listwrap">
			<ul>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
				<li><%=arrCList(1,intCLoop)%></li>
				<% Next %>
			</ul>
		</div>
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
	</div>
	<% End If %>
</div>
<script type="text/javascript">
$(function(){
	$("#slide").slidesjs({
		width:"894",
		height:"630",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:5000, effect:"fade", auto:false},
		effect:{fade: {speed:2000, crossfade:true}}
	});

	/* list border color randow */
	var classes = ["color1", "color2", "color3"];
	$(".commentlist ul li").each(function(){
		$(this).addClass(classes[~~(Math.random()*classes.length)]);
	});


	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1500 ) {
			width();
		}
	});

	titleAnimation();
	$(".topic .hgroup .concert, .topic .hgroup .invite").css({"margin-top":"7px", "opacity":"0"});
	$(".topic .hgroup h2").css({"margin-top":"15px", "opacity":"0"});
	$(".topic .circle").css({"opacity":"0"});
	function titleAnimation () {
		$(".topic .hgroup .concert").delay(200).animate({"margin-top":"0", "opacity":"1"},1000);
		$(".topic .hgroup h2").delay(800).animate({"margin-top":"9px", "opacity":"1"},1000);
		$(".topic .hgroup .invite").delay(1300).animate({"margin-top":"0", "opacity":"1"},1000);
		$(".topic .circle").delay(2000).animate({"opacity":"1"},1000);
		$(".topic .circle").delay(3000).addClass("twinkle");
	}

	$(".book .desc .line").css({"width":"0"});
	function width () {
		$(".book .desc .line").delay(500).animate({"width":"460px"},1200);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->