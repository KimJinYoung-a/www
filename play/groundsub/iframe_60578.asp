<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
'########################################################
' PLAY #18 PLATE
' 2015-03-17 이종화 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21506
Else
	eCode   =  60578
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

	iCPageSize = 6		'한 페이지의 보여지는 열의 수
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
.groundHeadWrap {width:100%; background:#f6f6f6 url(http://webimage.10x10.co.kr/play/ground/20150323/bg_top.jpg) no-repeat 50% 0;}
.groundCont {}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; padding:116px 20px 0;}

.topic {position:relative; height:940px; background-color:#ffbb29; text-align:center;}
.topic h1 {padding-top:280px;}
.topic h1 span {display:inline-block; height:48px; background-image:url(http://webimage.10x10.co.kr/play/ground/20150323/tit_good_morning.png); background-repeat:no-repeat; text-indent:-999em;}
.topic h1 .word1 {width:120px; background-position:0 0;}
.topic h1 .word2 {width:150px; background-position:-120px 0;}
.topic h1 .word3 {width:142px; background-position:-269px 0;}
.topic h1 strong {display:block; margin-top:45px;}
.topic .main {width:100%; position:absolute; top:0; left:0; height:940px; background:#eeeeeb url(http://webimage.10x10.co.kr/play/ground/20150323/img_plate.jpg) no-repeat 50% 0;}
.topic .main a {display:block; width:100%; height:100%;}
.hello {overflow:hidden; position:relative; z-index:5; height:271px; }
.hello .bg {position:absolute; left:0; top:0; width:100%; height:100%; background:#d5d2d3 url(http://webimage.10x10.co.kr/play/ground/20150323/bg_good_morning_v1.jpg) no-repeat 50% 0;}
.breakfast {height:1040px; background:#f1f3ec url(http://webimage.10x10.co.kr/play/ground/20150323/bg_table.jpg) no-repeat 50% 0;}
.breakfast p {width:1140px; margin:0 auto; padding-top:227px;}
.breakfast p img {padding-left:431px;}
.breakfast p strong {font-weight:normal;}
.important {position:relative; padding-top:600px; padding-bottom:165px; background:url(http://webimage.10x10.co.kr/play/ground/20150323/bg_cup.jpg) no-repeat 80% 0;}
.important h2 {position:absolute; top:20%; left:12%;}
.important ul {overflow:hidden; padding:0 8%;}
.important ul li {float:left; position:relative; width:20%; text-align:center;}
.important ul li span {position:absolute; top:46px; left:50%; width:190px; margin-left:-95px; border-bottom:1px solid #bcbcbc;}
.intro {height:997px; background:#f0efed url(http://webimage.10x10.co.kr/play/ground/20150323/bg_kit.jpg) no-repeat 50% 0;}
.intro .inner {width:1140px; margin:0 auto; padding-top:180px; text-align:right;}
.intro .inner p {margin-top:57px;}
.intro .inner .btnwrap {margin-top:75px;}
.intro .inner .btnwrap a {display:inline-block; *display:inline; zoom:1; margin-top:16px;}
.kit {overflow:hidden; position:relative; height:1030px;}
.kit span {display:block; position:relative;}
.kit .plate {position:absolute; top:20%; left:0;}
.kit .plate p {position:absolute; top:53%; left:85%; z-index:10;}
.kit .cup {position:absolute; top:7%; left:55%;}
.kit .cup p {position:absolute; top:30%; left:90%;}
.kit .tray {position:absolute; bottom:20%; right:0;}
.kit .tray p {position:absolute; top:45%; left:0%;}
.slide-wrap {min-width:1140px; width:100%;}
.slide-wrap .slide {position:relative; width:100%;}
.slide-wrap .slide img {width:100%;}
.slidesjs-pagination {overflow:hidden; position:absolute; bottom:10%; left:50%; z-index:50; width:460px; margin-left:-230px;}
.slidesjs-pagination li {float:left; padding:0 4px;}
.slidesjs-pagination li a {display:block; width:107px; height:5px; background-color:#fff; text-indent:-999em;}
.slidesjs-pagination li a.active {background-color:#db2424;}
.animation {position:relative; width:1140px; margin:0 auto; padding-top:387px; padding-bottom:160px;}
.animation .gif {position:absolute; top:148px; left:0;}
.commentevt .commentwrite {height:939px; background:#faf8f6 url(http://webimage.10x10.co.kr/play/ground/20150323/bg_delivery.jpg) no-repeat 50% 0;}
.commentevt .commentwrite .hgroup {padding-top:135px; text-align:center;}
.commentevt .commentwrite .hgroup p {margin-top:36px;}
.field {position:relative; width:924px; margin:60px auto 0; padding:50px 45px 45px; background-color:#fff;}
.field .area1 {overflow:hidden;}
.field .area1 .who, .field .area1 .person {float:left;}
.field .area1 .who {width:510px;}
.field .area1 .person {width:414px;}
.field .who input, .field .person input {margin-top:-4px; margin-left:27px; height:20px; padding-top:2px; padding-bottom:3px; border-bottom:1px solid #525252; color:#474747; font-size:12px; font-family:'Dotum', '돋움', 'Verdana'; line-height:1.25em; text-align:center; vertical-align:middle;}
.field .who input {width:186px; padding:2px 24px 3px;}
.field .person input {width:74px;}
.field .area2 {position:relative; margin-top:42px; padding-left:215px;}
.field .area2 .reason {position:absolute; top:0; left:0;}
.field textarea {width:470px; height:97px; padding:15px 20px; border:1px solid #525252; color:#474747; font-size:12px; font-family:'Dotum', '돋움', 'Verdana';}
.field .btnsubmit {position:absolute; bottom:45px; right:45px;}
.commentlistWrap {width:1140px; margin:0 auto;}
.commentlist {overflow:hidden; width:1167px; margin-right:-27px; padding-top:40px;}
.commentlist .box {float:left; position:relative; width:222px; height:191px; margin-top:45px; margin-right:27px; padding-top:93px; padding-left:140px; background:url(http://webimage.10x10.co.kr/play/ground/20150323/bg_comment.png) no-repeat 50% 0; font-family:'Dotum', '돋움', 'Verdana';}
.commentlist .box .no {position:absolute; top:22px; left:19px; width:48px; height:51px; padding-top:25px; padding-left:30px; color:#2d2d2d; line-height:1.25em; letter-spacing:-1px;}
.commentlist .box .with {overflow:hidden; position:absolute; top:107px; left:19px; width:67px; height:71px; padding:17px 5px 0 9px; color:#7f4f2e;}
.commentlist .box .word {width:187px;}
.commentlist .box .id {position:relative;}
.commentlist .box .id em {color:#c28842;}
.commentlist .box .id em img {margin-left:4px; vertical-align:middle;}
.commentlist .box .id span {position:absolute; top:0; right:0; color:#a0a0a0;}
.commentlist .box .word p {overflow:auto; height:115px; margin-top:7px; padding:5px 5px 5px 0; color:#474747; line-height:1.688em;}
.commentlist .box .btndel {position:absolute; top:0; right:0; width:21px; height:21px; background:transparent url(http://webimage.10x10.co.kr/play/ground/20150323/btn_del.png) no-repeat 50% 0; text-indent:-999em;}
.paging {margin-top:80px;}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	$(".slide").slidesjs({
		width:"1920",
		height:"997",
		pagination:{effect:"fade"},
		navigation:false,
		play:{interval:6000, effect:"fade", auto:true},
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

	/* animation effect */
	setInterval(function(){
		animation1();
	},500);

	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 1700 ) {
			animation2();
		}
		if (scrollTop > 3700 ) {
			setInterval(function(){
				animation3();
			},1000);
			setInterval(function(){
				animation4();
			},3000);
			setInterval(function(){
				animation5();
			},4000);
		}
	});

	$(".topic h1 span").css({"opacity":"0"});
	$(".topic h1 strong").css({"opacity":"0"});
	$(".topic .main").animate({"height":"0"},100);
	function animation1 () {
		$(".topic h1 .word1").delay(100).animate({"opacity":"1"},500);
		$(".topic h1 .word2").delay(800).animate({"opacity":"1"},500);
		$(".topic h1 .word3").delay(1200).animate({"opacity":"1"},500);
		$(".topic h1 strong").delay(1800).animate({"opacity":"1"},500);
		$(".topic .main").delay(2800).animate({"height":"940px"},1000);
	}

	$(".important ul li").css({"opacity":"0"});
	function animation2 () {
		$(".important ul .word1").delay(100).animate({"opacity":"1"},500);
		$(".important ul .word2").delay(800).animate({"opacity":"1"},500);
		$(".important ul .word3").delay(1200).animate({"opacity":"1"},500);
		$(".important ul .word4").delay(1800).animate({"opacity":"1"},500);
		$(".important ul .word5").delay(2800).animate({"opacity":"1"},500);
	}

	$(".kit .cup span").css("top", "-300px");
	function animation3() {
		$(".kit .cup span").animate({'margin-top':"300px"},2000, animation3);
	}

	$(".kit .plate").css("left", "-100px");
	function animation4() {
		$(".kit .plate").animate({'margin-left':"100px"},2500, animation4);
	}

	$(".kit .tray span").css("right", "-300px");
	function animation5() {
		$(".kit .tray span").animate({'margin-right':"300px"},3000, animation5);
	}

	/* move to comment */
	$(".move").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop :7500},800);
	});
});
</script>
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

	   if(!frm.qtext1.value){
			alert("아침을 함께 하고픈 사람을 적어주세요");
			document.frmcom.qtext1.value="";
			frm.qtext1.focus();
			return false;
	   }
	   
	   if(!frm.qtext2.value){
			alert("인원을 적어주세요");
			document.frmcom.qtext2.value="";
			frm.qtext2.focus();
			return false;
	   }

		if(!frm.qtext3.value || frm.qtext3.value == "150자 이내로 적어주세요"){
			alert("내용을 입력해주세요");
			document.frmcom.qtext3.value="";
			frm.qtext3.focus();
			return false;
		}

		if (GetByteLength(frm.qtext3.value) > 151){
			alert("제한길이를 초과하였습니다. 150자 까지 작성 가능합니다.");
			frm.qtext3.focus();
			return false;
		}

	   frm.action = "/play/groundsub/doEventSubscript60578.asp";
	   return true;
	}

	//'글자수 제한
	function checkLength(comment) {
		if (comment.value.length > 151 ) {
			comment.blur();
			comment.value = comment.value.substring(0, 150);
			alert('150자 이내로 입력');
			comment.focus();
			return false;
		}
	}

	function jsDelComment(cidx)	{
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
	   		document.frmdelcom.submit();
		}
	}

	function jsChklogin11(blnLogin)
	{
		if (blnLogin == "True"){
			document.frmcom.qtext1.value="";
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChklogin22(blnLogin)
	{
		if (blnLogin == "True"){
			document.frmcom.qtext2.value="";
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChklogin33(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.qtext3.value =="150자 이내로 적어주세요"){
				document.frmcom.qtext3.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

//-->
</script>
<div class="playGr20150323">
	<div class="section topic">
		<h1>
			<span class="word1">행복한</span>
			<span class="word2">아침을</span>
			<span class="word3">열어줄!</span>
			<strong><img src="http://webimage.10x10.co.kr/play/ground/20150323/img_logo.png" alt="GOOD MORNING PLATE" /></strong>
		</h1>
		<div class="main"><a href="/shopping/category_prd.asp?itemid=1238040" target="_top"></a></div>
	</div>

	<div class="section hello">
		<div class="bg"></div>
		<p>GOOD MORNING</p>
	</div>

	<div class="section breakfast">
		<p><img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_have_breakfast.gif" alt="아침, 드셨어요?" /></p>
	</div>

	<div class="section important">
		<h2><img src="http://webimage.10x10.co.kr/play/ground/20150323/tit_important.png" alt="아침 먹는 것은 중요합니다." /></h2>
		<ul>
			<li class="word1">
				<img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_important_01.png" alt="아침은 뇌에 영양소를 공급하기 때문에 뇌의 활성화에 도움을 주어 집중력과 학습력이 향상됩니다. " />
				<span></span>
			</li>
			<li class="word2">
				<img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_important_02.png" alt="아침으로 필요한 영양소를 제대로 섭취 하지 않으면 우리의 몸은 당과 지방흡수 를 늘리고 살이 찌게 됩니다." />
				<span></span>
			</li>
			<li class="word3">
				<img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_important_03.png" alt="아침을 먹으면 신체적 정신적으로 스트레스를 덜 받게 되고 각종 질병에 대한 면역력이 강해집니다." />
				<span></span>
			</li>
			<li class="word4">
				<img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_important_04.png" alt="공복에 따른 폭식을 방지할 수 있고, 제 시간에 식사를 함으로써 규칙적인 생활을 유지할 수 있습니다." />
				<span></span>
			</li>
			<li class="word5">
				<img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_important_05.png" alt="아침에 영양소를 골고루 섭취하면 하루 종일 활기찬 힘을 가져다 주고 피로를 덜 느끼게 됩니다." />
				<span></span>
			</li>
		</ul>
	</div>

	<div class="section intro">
		<div class="inner">
			<h2><img src="http://webimage.10x10.co.kr/play/ground/20150323/tit_good_morning_plate.png" alt="GOOD MORNING PLATE" /></h2>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_good_morning_plate.png" alt="텐바이텐 PLAY는 당신의 아침이 더욱 소중해 지기를 바라는 마음에 굿모닝 플레이트 세트를 선보입니다. 든든한 아침을 접시 안에 담고, 건강에 좋은 음료를 유리잔에 담고 이 트레이에 담아 기분 좋은 아침을 시작하세요. * Good morning PLATE Set는 원형 접시, 유리컵, 그리고 트레이로 구성되어 있습니다" /></p>
			<div class="btnwrap">
				<a href="/shopping/category_prd.asp?itemid=1238040" target="_top"><img src="http://webimage.10x10.co.kr/play/ground/20150323/btn_get.png" alt="Good Morning PLATE 구매하러 가기" /></a><br />
				<a href="#commentevt" class="move"><img src="http://webimage.10x10.co.kr/play/ground/20150323/btn_want.png" alt="아침을 배달해드립니다 신청하러 가기" /></a>
			</div>
		</div>
	</div>

	<div class="section kit">
		<div class="plate">
			<span><img src="http://webimage.10x10.co.kr/play/ground/20150323/img_kit_plate.png" alt="" /></span>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_kit_plate.png" alt="17센치의 아담한 원형접시" /></p>
		</div>
		<div class="cup">
			<span><img src="http://webimage.10x10.co.kr/play/ground/20150323/img_kit_cup.png" alt="" /></span>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_kit_cup.png" alt="30ml의 투명한 유리컵" /></p>
		</div>
		<div class="tray">
			<span><img src="http://webimage.10x10.co.kr/play/ground/20150323/img_kit_tray.png" alt="" /></span>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_kit_tray.png" alt="가로 32센치 세로 24센치의 넉넉한 사이즈의 트레이" /></p>
		</div>
	</div>

	<div class="section rolling">
		<div class="slide-wrap">
			<div class="slide">
				<a href="/shopping/category_prd.asp?itemid=1238040" target="_top"><img src="http://webimage.10x10.co.kr/play/ground/20150323/img_slide_01.jpg" alt="" /></a>
				<a href="/shopping/category_prd.asp?itemid=1238040" target="_top"><img src="http://webimage.10x10.co.kr/play/ground/20150323/img_slide_02.jpg" alt="" /></a>
				<a href="/shopping/category_prd.asp?itemid=1238040" target="_top"><img src="http://webimage.10x10.co.kr/play/ground/20150323/img_slide_03.jpg" alt="" /></a>
				<a href="/shopping/category_prd.asp?itemid=1238040" target="_top"><img src="http://webimage.10x10.co.kr/play/ground/20150323/img_slide_04.jpg" alt="" /></a>
			</div>
		</div>
	</div>

	<div class="section animation">
		<a href="/shopping/category_prd.asp?itemid=1238040" target="_top">
			<span class="gif"><img src="http://webimage.10x10.co.kr/play/ground/20150323/img_animation.gif" alt="" /></span>
			<span style="margin-left:350px;"><img src="http://webimage.10x10.co.kr/play/ground/20150323/img_cups.jpg" alt="" /></span>
		</a>
	</div>

	<div id="commentevt" class="section commentevt">
		<!-- comment write -->
		<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;" action="#playcomment">
		<input type="hidden" name="eventid" value="<%=eCode%>"/>
		<input type="hidden" name="bidx" value="<%=bidx%>"/>
		<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
		<input type="hidden" name="iCTot" value=""/>
		<input type="hidden" name="mode" value="add"/>
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
		<div class="commentwrite" id="playcomment">
			<div class="hgroup">
				<h2><img src="http://webimage.10x10.co.kr/play/ground/20150323/tit_delivery.png" alt="GOOD MORNING PLATE 런칭 기념, 아침 산타 프로젝트! 텐바이텐이 아침을 배달해드립니다!" /></h2>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_delivery.png" alt="아침을 함께 하고픈 사람들을 적고 아침을 신청하세요! 응모해 주신 분들중 3팀을 추첨해 맛있는 아침식사와 Good morning PLATE Set(1인 1 set)를 함께 배달해드립니다. 신청기간은 2015년 3월 23일부터 4월 5일까지며, 당첨자 발표는 2015년 4월 7일입니다." /></p>
			</div>

			<div class="field">
				<fieldset>
				<legend>아침 식사 신청하기</legend>
					<div class="area1">
						<p class="who">
							<label for="labelwho"><img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_who.png" alt="아침을 함께 하고픈 사람(들)은?" /></label>
							<input type="text" id="labelwho" value="" name="qtext1" onClick="jsChklogin11('<%=IsUserLoginOK%>');" maxlength="30" />
						</p>
						<p class="person">
							<label for="labelperson"><img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_no.png" alt="인원 (최대 5명)" /></label>
							<input type="text" id="labelperson" value="" name="qtext2" onClick="jsChklogin22('<%=IsUserLoginOK%>');" maxlength="1"/>
							<img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_count.png" alt="명" />
						</p>
					</div>
					<div class="area2">
						<p class="reason"><label for="labelreason"><img src="http://webimage.10x10.co.kr/play/ground/20150323/txt_reason.png" alt="그 이유도 함께 들려주세요" /></label></p>
						<textarea id="labelreason" name="qtext3" onClick="jsChklogin33('<%=IsUserLoginOK%>');" onKeyUp="checkLength(this);">150자 이내로 적어주세요</textarea>
					</div>
					<div class="btnsubmit"><input type="image" src="http://webimage.10x10.co.kr/play/ground/20150323/btn_submit.png" alt="아침 신청하기" /></div>
				</fieldset>
			</div>
		</div>
		</form>
		<form name="frmdelcom" method="post" action="doEventSubscript60578.asp" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="Cidx" value="">
		<input type="hidden" name="mode" value="del">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
		</form>
		
		<% IF isArray(arrCList) THEN %>
		<!-- comment list -->
		<div class="commentlistWrap">
			<div class="commentlist">
				<!-- for dev msg : <div class="box">...</div> 1페이지당 6개 보여주세요 -->

				<% For intCLoop = 0 To UBound(arrCList,2) %>
				<% 
						Dim opt1 , opt2 , opt3
						If arrCList(1,intCLoop) <> "" then
							opt1 = SplitValue(arrCList(1,intCLoop),"//",0)
							opt2 = SplitValue(arrCList(1,intCLoop),"//",1)
							opt3 = SplitValue(arrCList(1,intCLoop),"//",2)
						End If 
				%>
				<div class="box">
					<span class="no">no.<br /> <%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
					<p class="with"><%=opt2%>명의 <%=opt1%></p>
					<div class="word">
						<div class="id">
							<em><%=printUserId(arrCList(2,intCLoop),2,"*")%> <% If arrCList(8,intCLoop) = "M"  then%><img src="http://webimage.10x10.co.kr/play/ground/20150323/ico_mobile.png" alt="모바일에서 작성" /><% End If %></em>
							<span><%=Left(arrCList(4,intCLoop),10)%></span>
						</div>
						<p><%=opt3%></p>
					</div>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<button type="button" class="btndel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;">삭제</button>
					<% end if %>
				</div>
				<% Next %>

			</div>

			<!-- paging -->
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
		</div>
		<% End If %>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->