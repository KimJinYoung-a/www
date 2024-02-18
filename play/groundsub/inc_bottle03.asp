<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'########################################################
' PLAY #22 BOTTLE 3주차 
' 2015-07-17 이종화 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  "64833"
Else
	eCode   =  "65017"
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
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
img {vertical-align:top;}
.playGr20150720 {min-width:1140px;}
.visual {overflow:hidden; position:relative; height:716px; background-color:#fbf7f3;}
.visual p {position:absolute; top:0; left:50%; margin-left:-960px;}
.visual .blur {filter:blur(5px); -webkit-filter:blur(5px); -moz-filter: blur(5px); -o-filter:blur(5px); -ms-filter:blur(5px);}

.topic {overflow:hidden; position:relative; padding-bottom:247px; background:#65d0e7 url(http://webimage.10x10.co.kr/play/ground/20150720/bg_water.jpg) no-repeat 50% 100%;}
.topic .inner {padding:210px 0 187px; background-color:#fff; text-align:center;}
.topic h3 {position:absolute; top:258px; left:50%; margin-left:-370px;}

.letterDrop {opacity:0.8; transform: rotateX(-90deg); animation:letterDrop 2s ease 1 normal forwards;}
@keyframes letterDrop {
	10% {opacity:0.5;}
	20% {opacity:0.8; top:200px; transform:rotateX(-360deg);}
	100% {opacity:1; top:258px; transform:rotateX(360deg);}
}


.coolhelper {overflow:hidden; position:relative; background:#fff url(http://webimage.10x10.co.kr/play/ground/20150720/bg_leaf.png) no-repeat 100% 0;}
.coolhelper .inner {width:1140px; margin:0 auto; padding-top:212px;}
.coolhelper .inner h4 {position:relative; width:874px; height:228px; margin-left:60px;}
.coolhelper .inner h4 .line {display:block; padding-top:106px; border-top:1px solid #b7b7b7;}
.coolhelper .inner h4 em {display:block; background:url(http://webimage.10x10.co.kr/play/ground/20150720/tit_cool_helper.png) no-repeat 0 0; text-indent:-999em;}
.coolhelper .inner h4 .letter1 {height:18px;}
.coolhelper .inner h4 .letter2 {position:absolute; top:156px; left:0; width:37px; height:72px; background-position:0 -49px;}
.coolhelper .inner h4 .letter3 {position:absolute; top:156px; left:45px; width:38px; height:72px; background-position:-45px -49px;}
.coolhelper .inner h4 .letter4 {position:absolute; top:156px; left:93px; width:38px; height:72px; background-position:-93px -49px;}
.coolhelper .inner h4 .letter5 {position:absolute; top:156px; left:143px; width:30px; height:72px; background-position:-143px -49px;}
.coolhelper .inner h4 .letter6 {position:absolute; top:156px; left:202px; width:37px; height:72px; background-position:-202px -49px;}
.coolhelper .inner h4 .letter7 {position:absolute; top:156px; left:252px; width:30px; height:72px; background-position:-252px -49px;}
.coolhelper .inner h4 .letter8 {position:absolute; top:156px; left:292px; width:30px; height:72px; background-position:-292px -49px;}
.coolhelper .inner h4 .letter9 {position:absolute; top:156px; left:332px; width:37px; height:72px; background-position:-332px -49px;}
.coolhelper .inner h4 .letter10 {position:absolute; top:156px; left:379px; width:30px; height:72px; background-position:-379px -49px;}
.coolhelper .inner h4 .letter11 {position:absolute; top:156px; left:420px; width:39px; height:72px; background-position:-420px -49px;}
.coolhelper .inner h4 .letter12 {position:absolute; top:156px; left:472px; width:15px; height:72px; background-position:-472px -49px;}

.effect em {-webkit-animation-name:floater; -webkit-animation-timing-function:ease-in-out; -webkit-animation-iteration-count:infinite; -webkit-animation-duration:3s; -webkit-animation-direction:alternate; animation-name:floater; animation-timing-function:ease-in-out; animation-iteration-count:infinite; animation-duration:3s; animation-direction:alternate;}
.effect .letter2 {-webkit-animation-delay:.25s; animation-delay:.25s;}
.effect .letter3 {-webkit-animation-delay:.5s; animation-delay:.5s;}
.effect .letter4 {-webkit-animation-delay:.75s; animation-delay:.75s;}
.effect .letter5 {-webkit-animation-delay:.1s; animation-delay:.1s;}
.effect .letter6 {-webkit-animation-delay:1.25s; animation-delay:1.25s;}
.effect .letter7 {-webkit-animation-delay:1.5s; animation-delay:1.5s;}
.effect .letter8 {-webkit-animation-delay:1.75s; animation-delay:1.75s;}
.effect .letter9 {-webkit-animation-delay:.5s; animation-delay:5s;}
.effect .letter10 {-webkit-animation-delay:.75s; animation-delay:.75s;}
.effect .letter11 {-webkit-animation-delay:1s; animation-delay:1s;}

@-webkit-keyframes floater{0%{margin-top:0}50%{margin-top:-10px}100%{margin-top:0}}
@-moz-keyframes floater{0%{margin-top:0}50%{margin-top:-10px}100%{margin-top:0}}
@-ms-keyframes floater{0%{margin-top:0}50%{margin-top:-10px}100%{margin-top:0}}
@-o-keyframes floater{0%{margin-top:0}50%{margin-top:-10px}100%{margin-top:0}}
@keyframes floater{0%{margin-top:0}50%{margin-top:-10px}100%{margin-top:0}}

.coolhelper .btngroup {width:500px; position:relative; z-index:5; margin:116px 0 204px 40px;}
.coolhelper .btngroup:after {content:' '; display:block; clear:both;}
.coolhelper .btngroup a {float:left; display:block; width:150px; height:150px; margin-right:16px; background:url(http://webimage.10x10.co.kr/play/ground/20150720/bg_btn_01_v2.png) no-repeat 0 0; text-indent:-9999em; transition:0.2s cubic-bezier(.17,.67,.83,.67);}
.coolhelper .btngroup a:hover {background-position:0 100%;}
.coolhelper .btngroup .btnmove {background-position:100% 0;}
.coolhelper .btngroup .btnmove:hover {background-position:100% 100%;}

.coolhelper ul {position:relative; width:1060px; height:130px; margin-left:40px; padding-bottom:250px; }
.coolhelper ul li {position:absolute; top:0; left:0; z-index:5; width:180px; height:130px; background:url(http://webimage.10x10.co.kr/play/ground/20150720/txt_cool_helper_v1.png) no-repeat 0 0; text-indent:-999em;}
.coolhelper ul li.plus2 {left:220px; background-position:-220px 0;}
.coolhelper ul li.plus3 {left:439px; background-position:-439px 0;}
.coolhelper ul li.plus4 {left:660px; background-position:-660px 0;}
.coolhelper ul li.plus5 {left:879px; background-position:100% 0;}
.coolhelper .shot {position:relative; height:603px; background-color:#f6f7f7;}
.coolhelper .shot img {position:absolute; top:0; left:50%; margin-left:-960px;}
.coolhelper .withBear {position:absolute; top:129px; left:50%; margin-left:-400px;}

.tip {height:1275px;}
.tip .inner {width:1140px; margin:0 auto; padding-top:256px;}
.tip h4 {margin-left:37px;}
.tip ul {position:relative; margin-top:123px;}
.tip ul li.tip1 {position:absolute; top:0; left:19px;}
.tip ul li.tip2 {position:absolute; top:0; left:306px;}
.tip ul li.tip3 {position:absolute; top:0; left:593px;}
.tip ul li.tip4 {position:absolute; top:0; left:882px;}

#slide1 {height:825px;}
#slide2 {width:100%; height:594px;}
#slide2 .slide-img {width:351px; /*margin:0 -60px; padding:0 80px;*/ text-align:center;}
#slide1 .www_FlowSlider_com-branding {display:none !important;}
#slide2 .www_FlowSlider_com-branding {display:none !important;}

.use {padding:280px 0 175px;}
.use ul {overflow:hidden; position:relative; width:1140px; height:546px; margin:0 auto;}
.use ul li {overflow:hidden; position:absolute; width:380px; height:273px;}
.use ul li.use1 {top:0; left:0;}
.use ul li.use2 {top:0; left:380px;}
.use ul li.use3 {top:0; right:0;}
.use ul li.use4 {top:273px; left:0;}
.use ul li.use5 {top:273px; left:380px;}
.use ul li.use6 {top:273px; right:0;}
.use ul li strong, .use ul li span {position:absolute; top:50%; left:50%; z-index:5; width:183px; height:127px; margin-top:-63px; margin-left:-91px;}
.use ul li strong {z-index:7; background:transparent url(http://webimage.10x10.co.kr/play/ground/20150720/bg_use.png) no-repeat 0 0; color:#000; text-indent:-999px;}
.use ul li.use2 strong {background-position:-183px 0;}
.use ul li.use3 strong {background-position:100% 0;}
.use ul li.use4 strong {background-position:0 100%;}
.use ul li.use5 strong {background-position:-183px 100%;}
.use ul li.use6 strong {background-position:100% 100%;}
.use ul li span {background-color:#fff; opacity:0.9; filter:alpha(opacity=90);}
.use ul li:hover img {
	animation-name:rotater; 
	animation-duration:500ms; 
	animation-iteration-count:1; 
	animation-timing-function: ease-out;
}
@keyframes rotater {
0% {transform:rotate(0) scale(1) }
50% {transform:rotate(360deg) scale(2) }
100% {transform:rotate(720deg) scale(1) }
}

.playGr20150720 .need {height:425px; margin-top:112px; background:#46abdf url(http://webimage.10x10.co.kr/play/ground/20150720/bg_blue.jpg) no-repeat 50% 0;}
.need .inner {position:relative; width:1140px; margin:0 auto;}
.need p {padding-top:85px; padding-left:20px;}
.need button {overflow:hidden; position:absolute; top:61px; right:48px; width:247px; height:247px; background-color:transparent; font-size:11px; line-height:13px; text-align:center;}
.need button span {display:block; position:absolute; top:0; left:0; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/play/ground/20150720/bg_btn_02_v1.png) no-repeat 0 0;  transition:0.2s cubic-bezier(.17,.67,.83,.67);}
.need button:hover span {background-position:0 100%;}
.need .count {width:335px; position:absolute; top:330px; right:0; text-align:center;}
.need .count strong {margin:0 4px; color:#fff; font-family:'Verdana', 'Dotum'; font-size:18px; line-height:12px;}
</style>
<script type="text/javascript">
<!--
 	function jsSubmitComment(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

	   var frm = document.frmcom;
	   frm.action = "/play/groundsub/doEventSubscript65017.asp";
	   frm.submit();
	   return true;
	}
//-->
</script>
<div class="playGr20150720">
	<div class="visual">
		<p><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_visual.jpg" alt="Have a cool SUMMER" /></p>
	</div>

	<div class="topic">
		<div class="inner">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150720/tit_cool_summer.png" alt="COOL SUMMER COOL HELPER" /></h3>
			<span><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_cool_helper.gif" alt="" /></span>
		</div>
	</div>

	<!-- cool helper -->
	<div class="coolhelper">
		<div class="inner">
			<h4 class="effect">
				<span class="line"></span>
				<em class="letter1">보틀에게 입혀주는 시원한 옷</em>
				<em class="letter2">C</em>
				<em class="letter3">O</em>
				<em class="letter4">O</em>
				<em class="letter5">L</em>
				<em class="letter6">H</em>
				<em class="letter7">E</em>
				<em class="letter8">L</em>
				<em class="letter9">P</em>
				<em class="letter10">E</em>
				<em class="letter11">R</em>
				<em class="letter12">!</em>
			</h4>
			<div class="btngroup">
				<a href="/shopping/category_prd.asp?itemid=1320364" class="btnget">쿨헬퍼 구매하러 가기</a>
				<a href="#need" class="btnmove">쿨헬퍼 신청하러 가기</a>
			</div>
			<ul>
				<li class="plus1">RE - DESIGN 텐바이텐만의 스타일로 재탄생한 쿨헬퍼 스페셜 에디션</li>
				<li class="plus2">다용도 아이스홀더 음료, 생수, 주류를 끝까지 시원하게!</li>
				<li class="plus3">최적의 온도유지 음료를 가장 맛있게 마실 수 있는 온도 4-10도</li>
				<li class="plus4">장시간 시원함 유지 20도 실온 최대 8시간 30도 실온 최대 3시간</li>
				<li class="plus5">간단한 사용법 얼렸다가 재사용할 수 있고 끼우기만 하면 오케이!</li>
			</ul>
		</div>
		<div class="withBear"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_cool_helper_with_bear.png" alt="" /></div>
		<div class="shot"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_bear_shot.jpg" alt="" /></div>
	</div>

	<!-- tip -->
	<div class="tip">
		<div class="inner">
			<h4><img src="http://webimage.10x10.co.kr/play/ground/20150720/tit_tip.gif" alt="쿨헬퍼 사용 팁" /></h4>
			<ul>
				<li class="tip1"><img src="http://webimage.10x10.co.kr/play/ground/20150720/txt_tip_01.jpg" alt="내장되어 있는 특수 축냉제가 있어 얼리기만 하면 탁월한 보냉 효과 지속" /></li>
				<li class="tip2"><img src="http://webimage.10x10.co.kr/play/ground/20150720/txt_tip_02.jpg" alt="간편하게 탈 부착할 수 있는 벨크로" /></li>
				<li class="tip3"><img src="http://webimage.10x10.co.kr/play/ground/20150720/txt_tip_03.jpg" alt="병과 캔이 빠질 수 없도록 지지해주고 지열하는 받침 블록" /></li>
				<li class="tip4"><img src="http://webimage.10x10.co.kr/play/ground/20150720/txt_tip_04.jpg" alt="둘레가 큰 보틀은 실리콘 밴드로 고정" /></li>
			</ul>
		</div>
	</div>

	<div id="slide1" class="slider-horizontal">
		<div class="slide-img">
			<a href="/shopping/category_prd.asp?itemid=1320364"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_slide_01.jpg" alt="COOL HELPER" /></a>
		</div>
		<div class="slide-img">
			<a href="/shopping/category_prd.asp?itemid=1320364"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_slide_02.jpg" alt="COOL HELPER" /></a>
		</div>
		<div class="slide-img">
			<a href="/shopping/category_prd.asp?itemid=1320364"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_slide_03.jpg" alt="COOL HELPER" /></a>
		</div>
		<div class="slide-img">
			<a href="/shopping/category_prd.asp?itemid=1320364"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_slide_04.jpg" alt="COOL HELPER" /></a>
		</div>
		<div class="slide-img">
			<a href="/shopping/category_prd.asp?itemid=1320364"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_slide_05.jpg" alt="COOL HELPER" /></a>
		</div>
	</div>

	<div class="use">
		<ul>
			<li class="use1">
				<strong>TRAVEL</strong>
				<span></span>
				<img src="http://webimage.10x10.co.kr/play/ground/20150720/img_use_01.jpg" alt="" />
			</li>
			<li class="use2">
				<strong>CAMPING</strong>
				<span></span>
				<img src="http://webimage.10x10.co.kr/play/ground/20150720/img_use_02.jpg" alt="" />
			</li>
			<li class="use3">
				<strong>HIKING</strong>
				<span></span>
				<img src="http://webimage.10x10.co.kr/play/ground/20150720/img_use_03.jpg" alt="" />
			</li>
			<li class="use4">
				<strong>BASEBALL STADIUM</strong>
				<span></span>
				<img src="http://webimage.10x10.co.kr/play/ground/20150720/img_use_04.jpg" alt="" />
			</li>
			<li class="use5">
				<strong>SPORTS</strong>
				<span></span>
				<img src="http://webimage.10x10.co.kr/play/ground/20150720/img_use_05.jpg" alt="" />
			</li>
			<li class="use6">
				<strong>DAILY LIFE</strong>
				<span></span>
				<img src="http://webimage.10x10.co.kr/play/ground/20150720/img_use_06.jpg" alt="" />
			</li>
		</ul>
	</div>

	<div id="slide2" class="slider-horizontal">
		<div class="slide-img">
			<a href="/shopping/category_prd.asp?itemid=1320364"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_with_bottle_01.png" alt="COOL HELPER" /></a>
		</div>
		<div class="slide-img">
			<a href="/shopping/category_prd.asp?itemid=1320364"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_with_bottle_02.png" alt="COOL HELPER" /></a>
		</div>
		<div class="slide-img">
			<a href="/shopping/category_prd.asp?itemid=1320364"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_with_bottle_03.png" alt="COOL HELPER" /></a>
		</div>
		<div class="slide-img">
			<a href="/shopping/category_prd.asp?itemid=1320364"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_with_bottle_04.png" alt="COOL HELPER" /></a>
		</div>
		<div class="slide-img">
			<a href="/shopping/category_prd.asp?itemid=1320364"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_with_bottle_05.png" alt="COOL HELPER" /></a>
		</div>
		<div class="slide-img">
			<a href="/shopping/category_prd.asp?itemid=1320364"><img src="http://webimage.10x10.co.kr/play/ground/20150720/img_with_bottle_06.png" alt="COOL HELPER" /></a>
		</div>
	</div>

	<!-- for dev msg : 쿨 헬퍼 신청하기 -->
	<form name="frmcom" method="post" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>"/>
	<input type="hidden" name="bidx" value="<%=bidx%>"/>
	<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
	<input type="hidden" name="iCTot" value=""/>
	<input type="hidden" name="mode" value="add"/>
	<input type="hidden" name="spoint" value="1">
	<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
	<div id="need" class="need">
		<div class="inner">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150720/txt_need.png" alt="뜨거운 한 여름, 쿨헬퍼가 필요하세요? 추첨을 통해 20명에게 쿨헬퍼를 보내드립니다. 디자인 랜덤 신청기간은 2015년 7월 27일부터 8월 3일까지며, 당첨자 발표는 8월 4일입니다. ※ 쿨헬퍼는 제이엠아이디어에서 제작되었으며, 대한민국 특허 / 디자인 특허 등록 및 중국 특허 등록 제품입니다." /></p>
			<button type="button" class="btnNeed" onclick="jsSubmitComment();return false;"><span></span>쿨하세 신청하기</button>
			<div class="count">
				<img src="http://webimage.10x10.co.kr/play/ground/20150720/txt_count_01.png" alt="지금까지" />
				<strong><%=iCTotCnt%></strong>
				<img src="http://webimage.10x10.co.kr/play/ground/20150720/txt_count_02.png" alt="명이 쿨헬퍼를 신청하셨습니다." />
			</div>
		</div>
	</div>
	</form>
</div>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script type="text/javascript">
$(function(){
	$("#slide1").FlowSlider({
		marginStart:0,
		marginEnd:0,
		position:0.0,
		startPosition:0
	});

	$("#slide2").FlowSlider({
		startPosition: 0.0,
		position: 0.5,
		marginStart: 50,
		marginEnd: 100,
		controllerOptions: [{
			mouseStart: 0,
			mouseEnd: 100
		}]
	});

	/* animation effect */
	$(".visual").css({"height":"340px"});
	$(".visual p").addClass("blur");
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 200 ) {
			heightUp();
		}
		if (scrollTop > 450 ) {
			$(".visual p").removeClass("blur");
		}
		if (scrollTop > 1200 ) {
			letterDrop();
		}
		if (scrollTop > 2000 ) {
			coolHelper();
		}
		if (scrollTop > 4000 ) {
			stepSee();
		}
		if (scrollTop > 6000 ) {
			gallery();
		}
	});

	function heightUp() {
		$(".visual").delay(200).animate({"height":"716px"},2200);
	}

	$(".topic h3").css({"opacity":"0"});
	function letterDrop() {
		$(".topic h3").addClass("letterDrop");
	}

	$(".coolhelper .withBear").css({"top":"500px"});
	function coolHelper() {
		$(".coolhelper .withBear").delay(200).animate({"top":"192px"},2400);
	}

	$(".tip ul li").css({"opacity":"0", "top":"10px"});
	function stepSee() {
		$(".tip ul li.tip1").delay(200).animate({"opacity":"1", "top":"0"},600);
		$(".tip ul li.tip2").delay(600).animate({"opacity":"1", "top":"0"},600);
		$(".tip ul li.tip3").delay(1100).animate({"opacity":"1", "top":"0"},600);
		$(".tip ul li.tip4").delay(1600).animate({"opacity":"1", "top":"0"},600);
	}

	$(".use ul li").css({"opacity":"0"});
	$(".use ul li.use1, .use ul li.use2, .use ul li.use3").css({"top":"280px"});
	$(".use ul li.use4, .use ul li.use5, .use ul li.use6").css({"top":"290px"});
	function gallery() {
		$(".use ul li.use4, .use ul li.use5, .use ul li.use6").delay(100).animate({"opacity":"1", "top":"237px"},300);
		$(".use ul li.use1, .use ul li.use2, .use ul li.use3").delay(800).animate({"opacity":"1", "top":"0"},1200);
	}

	/* move */
	$(".btngroup .btnmove").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 1200);
	});

});
</script>
<!--[if lte IE 9]>
	<script type="text/javascript">
		$(function(){
			$(".topic h3").css({"opacity":"1"});
		});
	</script>
<![endif]-->
<!-- #include virtual="/lib/db/dbclose.asp" -->