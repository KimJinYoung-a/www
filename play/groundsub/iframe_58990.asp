<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  play 동방불펜
' History : 2015.01.23 한용민 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/play/groundsub/event58990Cls.asp" -->
<%
dim eCode
	eCode   =  getevt_code()

dim commentexistscount, userid, i
commentexistscount=0
userid = getloginuserid()

if userid<>"" then
	commentexistscount=getcommentexistscount(userid, eCode, "", "", "", "Y")
end if

dim com_egCode, bidx, isMyComm
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	
	isMyComm	= requestCheckVar(request("isMC"),1)
	
	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 15		'한 페이지의 보여지는 열의 수
	iCPerCnt = 10		'보여지는 페이지 간격

	'코멘트 데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수
	if isMyComm="Y" then cEComment.FUserID = GetLoginUserID

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

%>

<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">

.playGr20150126 {}
.playGr20150126 .dbContent {width:1140px; margin:0 auto;}
.playGr20150126 .msg {position:absolute;  height:210px;}
.playGr20150126 .msg .line {display:inline-block; position:absolute; left:0; bottom:0; width:100%; height:4px; background:#e0e0e1;}
.playGr20150126 .paging a {background:none !important;}

.intro {height:689px; background:url(http://webimage.10x10.co.kr/play/ground/20150126/intro_bg_body.gif) repeat-x left top;}
.intro div.dbContent {position:relative; width:1078px;}
.intro h2 {padding-top:214px;}
.intro .letter span {display:inline-block; position:absolute; top:125px; opacity:0;}
.intro .letter span.t01 {left:163px;}
.intro .letter span.t02 {left:396px;}
.intro .letter span.t03 {left:635px;}
.intro .letter span.t04 {left:876px;}
.section01 {position:relative; height:507px; text-align:center; padding-top:90px; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section01_bg_body.gif) repeat-x left top;}
.section01 .dbContent {padding-top:118px; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section01_bg_sun.png) no-repeat center top;}
.section01 .dbContent .meaning {padding-top:50px;}
.section01 .dbContent .meaning p {position:relative; height:34px;}
.section01 .dbContent .meaning p span {display:inline-block; position:absolute; left:0; top:15px; width:100%; opacity:0;}
.section02 {position:relative; height:850px; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section02_bg_body.jpg) no-repeat center top;}
.section02 .msg {position:absolute; right:0; top:412px; width:855px;}
.section02 .msg p {position:absolute; left:15px; top:0; opacity:0;}
.section03 {position:relative; height:850px; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section03_bg_body.jpg) no-repeat center top;}
.section03 .msg {left:0; top:430px; width:980px; }
.section03 .msg p {position:absolute; right:40px; top:0; opacity:0;}
.section03 .msg .line {background:#e6e5e5;}
.section04 {height:550px; padding-top:350px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section04_bg_body.gif) repeat-x left top;}
.section04 .typing {color:#fff; font-size:35px; line-height:35px; font-family:'batang','바탕';}
.section04 .typing .copy {padding-bottom:24px;}
.section04 .dbContent {position:relative;}
.section04 .line {position:absolute; left:50%; top:200px; width:4px; height:350px; margin-left:-2px; z-index:40; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section04_img_bar.gif) left top no-repeat;}
.section04 .line .mask {display:inline-block; width:4px; height:350px; position:absolute; left:0; bottom:0; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section04_img_mask.gif) left top repeat;}
.section05 {height:1017px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section05_bg_body.gif) repeat-x left top;}
.section05 div.dbContent {position:relative; width:1344px; padding-top:418px; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section05_bg_dongbang.gif) no-repeat left top;}
.section05 .pic {margin-left:-288px; padding-top:75px;}
.section05 .feature span {display:inline-block; position:absolute; z-index:40;}
.section05 .feature span.f01 {left:106px; top:513px;}
.section05 .feature span.f02 {left:255px; top:365px;}
.section05 .feature span.f03 {left:1025px; top:423px;}
.section05 .line {position:absolute; left:50%; top:0; width:12px; height:390px; margin-left:-6px; z-index:40; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section05_img_bar.gif) left top no-repeat;}
.section05 .line .mask {display:inline-block; width:12px; height:390px; position:absolute; left:0; bottom:0; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section05_img_mask.gif) left top no-repeat;}
.section06 {height:930px; padding-top:140px; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section06_bg_body.gif) repeat-x left top;}
.section07 {position:relative; width:100%; height:830px; background:#222;}
.section07 .slideWrap {position:absolute; left:50%; top:0; width:1642px; height:830px; margin-left:-821px;}
.section07 .slide {position:relative; width:1642px; height:830px;}
.section07 .slide .slidesjs-pagination {overflow:hidden; width:265px; position:absolute; bottom:30px; left:50%; margin-left:-132px; z-index:50;}
.section07 .slide .slidesjs-pagination li {float:left; padding:0 5px;}
.section07 .slide .slidesjs-pagination li a {display:block; width:56px; height:2px; background-color:#fff; text-indent:-999em;}
.section07 .slide .slidesjs-pagination li a.active {background-color:#a93232;}
.section08 {padding-bottom:92px;}
.section08 .group01 {height:609px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section08_bg_body01.gif) repeat-x left top;}
.section08 .group01 h3 {padding:122px 0 24px;}
.section08 .group01 p {padding-bottom:44px;}
.section08 .group02 {height:190px; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section08_bg_body02.gif) repeat-x left top;}
.section08 .group02 .dbContent {width:1033px; padding:51px 70px 0 37px;}
.section08 .group02 p {float:left; width:501px; height:54px; padding-left:109px; margin-top:17px; background:url(http://webimage.10x10.co.kr/play/ground/20150126/section08_txt_lose.gif) no-repeat left top;}
.section08 .group02 p span {display:none;}
.section08 .group02 p .inpLetter {display:inline-block; width:46px; height:46px; line-height:48px; border:4px solid #7e2222; margin:0 2px; text-align:center; font-weight:bold; font-size:26px; color:#333;}
.section08 .group02 .apply {float:right;}
.section08 .group03 .dbCmtList {overflow:hidden; width:1140px;}
.section08 .group03 .dbCmtList ul {overflow:hidden; width:1170px; padding-top:100px; margin-bottom:40px; border-bottom:1px solid #973838;}
.section08 .group03 .dbCmtList li {float:left; width:204px; margin:0 30px 30px 0;}
.section08 .group03 .dbCmtList li .info {overflow:hidden; font-size:11px; line-height:12px; padding-bottom:5px; color:#973838;}
.section08 .group03 .dbCmtList li .info .num {float:left;}
.section08 .group03 .dbCmtList li .info .num img {vertical-align:top;}
.section08 .group03 .dbCmtList li .info .writer {float:right; font-weight:bold;}
.section08 .group03 .dbCmtList li .word {position:relative; width:204px; height:330px; background-repeat:no-repeat; background-position:left top;}
.section08 .group03 .dbCmtList li.c01 .word {background-image:url(http://webimage.10x10.co.kr/play/ground/20150126/section08_bg_cmt01.gif)}
.section08 .group03 .dbCmtList li.c02 .word {background-image:url(http://webimage.10x10.co.kr/play/ground/20150126/section08_bg_cmt02.gif)}
.section08 .group03 .dbCmtList li.c03 .word {background-image:url(http://webimage.10x10.co.kr/play/ground/20150126/section08_bg_cmt03.gif)}
.section08 .group03 .dbCmtList li .word span {display:table; position:absolute; left:88px; top:54px; width:32px; height:220px; font-size:29px; font-weight:bold; font-family:'gungsuh','궁서'; line-height:42px; color:#111;}
.section08 .group03 .dbCmtList li .word span em {display:table-cell; width:100%; height:100%; vertical-align:middle;}
@media all and (min-width:1920px) {
	.section02, .section03 {background-size:100% 100%;}
}
</style>
<script type="text/javascript" src="/lib/js/jquery.slides.min.js"></script>
<script type="text/javascript">
$(function(){
	//intro
	$('.intro .letter span.t01').delay(300).animate({top:'140px',opacity:'1'}, {duration:700, easing: 'easeOutElastic'});
	$('.intro .letter span.t02').delay(600).animate({top:'140px',opacity:'1'}, {duration:700, easing: 'easeOutElastic'});
	$('.intro .letter span.t03').delay(900).animate({top:'140px',opacity:'1'}, {duration:700, easing: 'easeOutElastic'});
	$('.intro .letter span.t04').delay(1200).animate({top:'140px',opacity:'1'}, {duration:700, easing: 'easeOutElastic'});

	//section01
	function playSection01() {
		$('.section01 .meaning .m01 span').delay(100).animate({top:'0',opacity:'1'},900);
		$('.section01 .meaning .m02 span').delay(300).animate({top:'0',opacity:'1'},900);
		$('.section01 .meaning .m03 span').delay(600).animate({top:'0',opacity:'1'},900);
		$('.section01 .meaning .m04 span').delay(900).animate({top:'0',opacity:'1'},900);
		$('.section01 .meaning .m05 span').delay(1200).animate({top:'0',opacity:'1'},1000);
	}
	//section02
	function playSection02() {
		$('.section02 .msg p').animate({left:'0',opacity:'1'},1400);
	}
	//section03
	function playSection03() {
		$('.section03 .msg p').animate({right:'25px',opacity:'1'},1400);
	}

	//section07
	$(".slide").slidesjs({
		width:"1642",
		height:"830",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:3500, effect:"fade", auto:true},
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

	var conChk = 0;
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 500){
			playSection01();
		}
		if (scrollTop > 1400){
			playSection02();
		}
		if (scrollTop > 2050){
			playSection03();
		}
		if (scrollTop > 3100){
			if (conChk==0){ 
				playSection04();
			}
		}
	});
	
	//section04
	function changeText(cont1,cont2,speed){
		var Otext=cont1.text();
		var Ocontent=Otext.split("");
		var i=0;
		function show(){
			if(i<Ocontent.length){
				cont2.append(Ocontent[i]);
				i=i+1;
			};
		};
		var typing=setInterval(show,speed);
	};
	function playSection04() {
		conChk = 1;
		$(".section04 .line .mask").delay(5000).animate({height:"0"}, 2000);
		$(".section05 .line .mask").delay(6900).animate({height:"0"}, 2000);
		changeText($(".t01 p"),$(".t01 .copy"),110);
		setTimeout(function(){
			changeText($(".t02 p"),$(".t02 .copy"),100);
		},1900);
		clearInterval(typing);
		return false;
	}

});

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	//if(frmcom.txtcomm.value =="코멘트 입력 (50자 이내)"){
	//	frmcom.txtcomm.value ="";
	//}
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}
											
function jsSubmitComment(){
	<% If IsUserLoginOK() Then %>
		<% If not( getnowdate>="2015-01-26" and getnowdate<"2015-02-04") Then %>
			alert('이벤트 응모 기간이 아닙니다.');
			return;
		<% end if %>
		<% if commentexistscount>=5 then %>
			alert('한아이디당 5회 까지만 참여가 가능 합니다.');
			return;
		<% end if %>

		//if(frmcom.txtcomm.value =="코멘트 입력 (50자 이내)"){
		//	frmcom.txtcomm.value ="";
		//}
		if(!frmcom.txtcomm1.value){
			alert("코멘트를 입력해주세요");
			frmcom.txtcomm1.focus();
			return false;
		}
		if(frmcom.txtcomm3.value!=''){
			if(!frmcom.txtcomm2.value){
				alert("코멘트를 정확히 입력해주세요");
				return false;
			}
		}
		if(frmcom.txtcomm4.value!=''){
			if(!frmcom.txtcomm2.value || !frmcom.txtcomm3.value){
				alert("코멘트를 정확히 입력해주세요");
				return false;
			}
		}
		if(frmcom.txtcomm5.value!=''){
			if(!frmcom.txtcomm2.value || !frmcom.txtcomm3.value || !frmcom.txtcomm4.value){
				alert("코멘트를 정확히 입력해주세요");
				return false;
			}
		}
		frmcom.txtcomm.value = frmcom.txtcomm1.value+frmcom.txtcomm2.value+frmcom.txtcomm3.value+frmcom.txtcomm4.value+frmcom.txtcomm5.value

		//if (GetByteLength(frmcom.txtcomm.value) > 50){
		//	alert("코맨트가 제한길이를 초과하였습니다. 50자 까지 작성 가능합니다.");
		//	frmcom.txtcomm.focus();
		//	return;
		//}

		frmcom.action='/play/groundsub/doEventSubscript58990.asp';
		frmcom.submit();
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

function jsDelComment(cidx)	{
	<% If IsUserLoginOK() Then %>
		if (cidx==""){
			alert('정상적인 경로가 아닙니다');
			return;
		}
		
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
			document.frmdelcom.action='/play/groundsub/doEventSubscript58990.asp';
	   		document.frmdelcom.submit();
		}
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
	<% End IF %>
}

</script>
</head>
<body>

<div class="playGr20150126">
	<div class="intro">
		<div class="dbContent">
			<h2><img src="http://webimage.10x10.co.kr/play/ground/20150126/intro_tit_dongbang.png" alt="東方不筆" /></h2>
			<div class="letter">
				<span class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20150126/intro_txt_dong.png" alt="동" /></span>
				<span class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20150126/intro_txt_bang.png" alt="방" /></span>
				<span class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20150126/intro_txt_bul.png" alt="불" /></span>
				<span class="t04"><img src="http://webimage.10x10.co.kr/play/ground/20150126/intro_txt_pen.png" alt="펜" /></span>
			</div>
		</div>
	</div>
	<div class="section01">
		<div class="dbContent">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150126/section01_tit_meaning.gif" alt="동쪽에서 해가 뜨는 한 절대 지지 않는다!" /></p>
			<div class="meaning">
				<p class="m01"><span><img src="http://webimage.10x10.co.kr/play/ground/20150126/section01_txt_meaning01.gif" alt="영화 동방불패의 뜻풀이입니다." /></span></p>
				<p class="m02"><span><img src="http://webimage.10x10.co.kr/play/ground/20150126/section01_txt_meaning02.gif" alt="평범한 펜처럼 보이지만 그 안에 나만의 비기나 부적을 순겨둔다면 어떨까요?" /></span></p>
				<p class="m03" style="height:56px;"><span><img src="http://webimage.10x10.co.kr/play/ground/20150126/section01_txt_meaning03.gif" alt="어려운 시험문제를 풀 때, 가슴 떨리는 고백편지를 쓸 때, 심사숙고하며 연봉계약서에 서명을 할 때, 일필휘지로 이 펜을 자신있게 사용해보세요!" /></span></p>
				<p class="m04" style="height:66px;"><span><img src="http://webimage.10x10.co.kr/play/ground/20150126/section01_txt_meaning04.gif" alt="절대 지지 않는 동방불펜으로 자신감 넘치는 새해를 보내시기 바랍니다!" /></span></p>
				<p class="m05"><span><img src="http://webimage.10x10.co.kr/play/ground/20150126/section01_txt_meaning05.gif" alt="주의:진다고 해서 좌절하지 말 것!" /></span></p>
			</div>
		</div>
	</div>
	<div class="section02">
		<div class="dbContent">
			<div class="msg">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150126/section02_txt01.png" alt="동방불펜" /></p>
				<span class="line"></span>
			</div>
		</div>
	</div>
	<div class="section03">
		<div class="dbContent">
			<div class="msg">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150126/section03_txt01.png" alt="동방불펜" /></p>
				<span class="line"></span>
			</div>
		</div>
	</div>
	<div class="section04">
		<div class="dbContent">
			<div class="typing t01">
				<p style="display:none;">당신에게 소.소.한 재미와</p>
				<p class="copy"></p>
			</div>
			<div class="typing t02">
				<p style="display:none;">당.당.한 자신감을 불어 넣어 줄 단 하나의 펜!</p>
				<p class="copy"></p>
			</div>
			<p class="line"><span class="mask"></span></p>
		</div>
	</div>
	<div class="section05">
		<div class="dbContent">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150126/section05_tit_dongbang.gif" alt="동방불펜" /></p>
			<p class="line"><span class="mask"></span></p>
			<div class="penInfo">
				<div class="pic"><img src="http://webimage.10x10.co.kr/play/ground/20150126/section05_move_pen.gif" alt="동방불펜" /></div>
				<p class="feature">
					<span class="f01"><img src="http://webimage.10x10.co.kr/play/ground/20150126/section05_txt_pen_feature01.png" alt="모든일을 매끄럽게 해결해 나갈 수 있을 것만 같은 부드러운 필기감" /></span>
					<span class="f02"><img src="http://webimage.10x10.co.kr/play/ground/20150126/section05_txt_pen_feature02.png" alt="동방볼펜의 시그니처이자, 지향점인 심볼" /></span>
					<span class="f03"><img src="http://webimage.10x10.co.kr/play/ground/20150126/section05_txt_pen_feature03.png" alt="천년만년 눌러도 경쾌한 소리와 함께 흔쾌히 촉을 내어주는 노크" /></span>
				</p>
				<p class="tPad25"><img src="http://webimage.10x10.co.kr/play/ground/20150126/section05_txt_pen_feature04.gif" alt="손에 알맞게 들어와 쥐락펴락 할 수 있는 안락한 블랙무광터치마이바디" /></p>
			</div>
		</div>
	</div>
	<div class="section06">
		<div class="dbContent">
			<p>
				<img src="http://webimage.10x10.co.kr/play/ground/20150126/section06_img_buy_pen.jpg" alt="" usemap="#goBuy"onfocus="this.blur();" />
				<map name="goBuy" id="goBuy">
					<area shape="rect" coords="393,680,743,767" href="/shopping/category_prd.asp?itemid=1204400" target="_top" alt="동방불펜 구매하러 가기" />
				</map>
			</p>
		</div>
	</div>
	<div class="section07">
		<div class="slideWrap">
			<div class="slide">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150126/section07_img_slide01.jpg" alt="동방불펜 슬라이드 이미지1" /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150126/section07_img_slide02.jpg" alt="동방불펜 슬라이드 이미지2" /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150126/section07_img_slide03.jpg" alt="동방불펜 슬라이드 이미지3" /></p>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20150126/section07_img_slide04.jpg" alt="동방불펜 슬라이드 이미지4" /></p>
			</div>
		</div>
	</div>

	<!-- 코멘트 이벤트-->
	<div class="section08 dbCmt">
		<div class="group01">
			<h3><img src="http://webimage.10x10.co.kr/play/ground/20150126/section08_tit_comment.gif" alt="동방불펜 출시 기념 이벤트 -  나 살면서 이런 부분에서만큼은 지고 싶지 않다 하는 순간이 있으신가요?" /></h3>
			<p><img src="http://webimage.10x10.co.kr/play/ground/20150126/section08_img_gift_v1.png" alt="나의 용기를 불러일으켜 도전하게 만드는 그 순간을 다섯자로 남겨주세요! 추첨을 통해 10분에게 동방불펜과 불패엽서 4종세트를 선물로 드립니다. 응모가 종료되었습니다." /></p>
		</div>

		<form name="frmcom" method="post" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
		<input type="hidden" name="iCTot" value="">
		<input type="hidden" name="mode" value="add">
		<input type="hidden" name="spoint" value="0">
		<input type="hidden" name="isMC" value="<%=isMyComm%>">
		<input type="hidden" name="txtcomm">
		<!-- 다섯자 작성 -->
		<div class="group02">
			<div class="dbContent">
				<p>
					<span>나는</span>
					<input type="text" name="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> maxlength=1 class="inpLetter" /><% 'IF NOT IsUserLoginOK THEN%><!--로그인 후 글을 남길 수 있습니다.--><% ' else %><!--코멘트 입력 (50자 이내)--><% 'END IF%>
					<input type="text" name="txtcomm2" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> maxlength=1 class="inpLetter" />
					<input type="text" name="txtcomm3" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> maxlength=1 class="inpLetter" />
					<input type="text" name="txtcomm4" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> maxlength=1 class="inpLetter" />
					<input type="text" name="txtcomm5" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> maxlength=1 class="inpLetter" />
					<span>지지않는다.</span>
				</p>
				<input type="image" onclick="jsSubmitComment(); return false;" src="http://webimage.10x10.co.kr/play/ground/20150126/section08_btn_apply.gif" alt="응모하기" class="apply" />
			</div>
		</div>
		<!--// 다섯자 작성 -->
		</form>
		<form name="frmdelcom" method="post" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="Cidx" value="">
		<input type="hidden" name="mode" value="del">
		</form>
		
		<% IF isArray(arrCList) THEN %>
			<!-- 코멘트 리스트 -->
			<div class="group03">
				<div class="dbContent">
					<div class="dbCmtList">
						<ul>
							<% ' <!-- for dev msg : li에 랜덤으로 클래스 c01~03 넣어주세요 / 리스트는 15개씩 노출됩니다 --> %>
							<%
							dim rndNo
								rndNo=1
							randomize
							rndNo = Int((3 * Rnd) + 1)
							
							For i = 0 To UBound(arrCList,2)
							%>
							<li class="c0<%= rndNo %>">
								<div class="info">
									<p class="num">
										<% If arrCList(8,i) <> "W" Then %>
											<img src="http://webimage.10x10.co.kr/play/ground/20150126/ico_mobile.gif" alt="모바일에서 작성" class="rPad05" />
										<% end if %>

										no.<%=iCTotCnt-i-(iCPageSize*(iCCurrpage-1))%>
									</p>
									<p class="writer">
										<%=printUserId(arrCList(2,i),2,"*")%>
										
										<% if ((GetLoginUserID = arrCList(2,i)) or (GetLoginUserID = "10x10")) and ( arrCList(2,i)<>"") then %>
											<a href="" onclick="jsDelComment('<% = arrCList(0,i) %>'); return false;" class="lMar05"><img src="http://webimage.10x10.co.kr/play/ground/20150126/btn_delete.gif" alt="삭제" /></a>
										<% end if %>
									</p>
								</div>
								<p class="word"><span><em><%= ReplaceBracket(db2html(arrCList(1,i))) %></em></span></p>
							</li>

							<% next %>
						</ul>
	
						<!-- paging -->
						<div class="pageWrapV15">
							<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
						</div>
					</div>
				</div>
			</div>
			<!--// 코멘트 리스트 -->
		<% end if %>
	</div>
	<!--// 코멘트 이벤트 -->
</div>

</body>
</html>