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
' Description : PLAY 28 W
' History : 2016-03-25 김진영 생성
'####################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66082
Else
	eCode   =  69930
End If

Dim com_egCode, bidx  , commentcount
Dim cEComment
Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
Dim iCPageSize, iCCurrpage
Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
Dim timeTern, totComCnt, eCC

'파라미터값 받기 & 기본 변수 값 세팅
iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
com_egCode = requestCheckVar(Request("eGC"),1)	
eCC = requestCheckVar(Request("eCC"), 1) 

IF iCCurrpage = "" THEN iCCurrpage = 1
IF iCTotCnt = "" THEN iCTotCnt = -1

'// 그룹번호 랜덤으로 지정
iCPageSize = 10		'한 페이지의 보여지는 열의 수
iCPerCnt = 10		'보여지는 페이지 간격

'선택범위 리플개수 접수
Set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iSelTotCnt = cEComment.FTotCnt '리스트 총 갯수
Set cEComment = nothing

'코멘트 데이터 가져오기
Set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
Set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

commentcount = getcommentexistscount(GetEncLoginUserID, eCode, "", "", "", "Y")
%>
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.groundWrap {width:100%; background-color:#b4e5e3;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}

img {vertical-align:top;}

.pageMove {display:none;}

.showerCont .innerWrap {position:relative; width:1140px; margin:0 auto; -webkit-box-sizing:border-box; -moz-box-sizing:border-box; box-sizing:border-box;}
.showerCont button {position:absolute; background-color:rgba(256,256,256,0); z-index:50; outline:none;}
.showerCont .clickTooltip {position:absolute; z-index:10; animation:1s balloon ease-in-out infinite alternate;}
@keyframes balloon {
	0% {margin-top:0;}
	50% {margin-top:-7px;}
	100% {margin-top:0;}
}

.topic1 {background-color:#dff7f6;}
.topic1 .innerWrap {height:740px; padding:162px 0 0 81px;}
.topic1 .tit {text-align:center; width:354px;}
.topic1 h2 {position:relative; height:74px; margin-top:17px; background:url(http://webimage.10x10.co.kr/play/ground/20160328/tit_bg.png) 50% 50% no-repeat;}
.topic1 h2 i {position:absolute; top:50%; margin-top:-37px;}
.topic1 h2 i.titTxt1 {left:39px;}
.topic1 h2 i.titTxt2 {left:104px;}
.topic1 h2 i.titTxt3 {left:186px;}
.topic1 h2 i.titTxt4 {left:263px;}
.topic1 em {display:block; margin-top:33px;}
.story01 {position:absolute; right:156px; bottom:127px; width:435px; height:336px;}
.story01 div {position:absolute; left:0; top:0; padding:0 52px 0 85px;}
.story01 button {right:0; top:85px; width:70%; height:50%;}
.story01 i {right:0; top:95px;}
.story01 span {position:absolute; left:0; bottom:-7px;}

.topic2 {height:705px; background-color:#ededed; text-align:center;}
.topic2 .innerWrap {position:relative; height:460px; padding:91px 0 80px 0;}
.topic2 .innerWrap div {position:absolute;}
.story02 {left:0; top:97px; z-index:10;}
.story03 {left:391px; top:93px; width:337px; height:289px; z-index:9;}
.story03 p, .story03 span {position:absolute;}
.story03 span {left:50%; top:59px; margin-left:-135px;}
.story03 span.shadow {animation-name:flicker; animation-iteration-count:1; animation-duration:2s; animation-timing-function:cubic-bezier(.45,.18,.76,.25); animation-fill-mode:both; -webkit-animation-name:flicker; -webkit-animation-iteration-count:1; -webkit-animation-duration:2s; -webkit-animation-timing-function:cubic-bezier(.45,.18,.76,.25); -webkit-animation-fill-mode:both;}
@keyframes flicker {
	0% {opacity:0.5;}
	50% {opacity:0;}
	100% {opacity:1;}
}
.story03 p {left:89px; top:64px;}
.story04 {right:0; top:93px; z-index:9;}
.story04 span, .story04 i, .story04 em {position:absolute;}
.story04 span {left:136px; top:80px;}
.story04 i {left:128px; top:190px;}
.story04 em {left:77px; top:106px;}

.topic3 {height:1250px; background-color:#f6f5f5;}
.story05 {position:relative; padding-top:300px; text-align:center;}
.story05 span, .story05 i {position:absolute;}
.story05 .obj1 {left:234px; top:165px;}
.story05 .obj2 {left:775px; top:211px;}
.story05 .obj3 {left:518px; top:124px;}
.story05 .obj4 {left:442px; top:284px;}
.story05 .obj5 {left:617px; top:225px;}
.story05 .deco1 {left:398px; top:225px;}
.story05 .deco2 {left:527px; top:195px;}
.story05 .deco3 {left:706px; top:314px;}
.story05 .deco4 {left:593px; top:314px;}
.story06 {position:relative; height:640px; text-align:center;}
.story06 p {position:absolute; left:50%; top:199px; margin-left:-452px;}
.story06 button {position:absolute; left:30%; top:0px; width:40%; height:100%;}

.topic4 {height:485px; background-color:#eae1db;}
.story07 p {position:absolute; left:50%; top:95px; margin-left:-405px; padding-top:40px;}
.story07 i {position:absolute; left:645px; top:0;}
.story07 button {position:absolute; left:545px; top:0; width:200px; height:200px;}
.story07 span {position:absolute; right:100px; top:75px;}
.story07 em {position:absolute;}
.story07 em.deco1 {left:800px; top:125px;}
.story07 em.deco2 {left:903px; top:234px; z-index:10;}

.topic5 {height:1540px; background:#e9f1f2 url(http://webimage.10x10.co.kr/play/ground/20160328/topic5.jpg) 50% 0 repeat-x;}
.topic5 .innerWrap {padding-top:1020px;}
.story08 {position:absolute; right:0; top:93px;}
.story09 {position:absolute; left:0; top:356px;}
.story10 {position:absolute; right:0; top:677px;}
.story11 {position:relative; height:518px; background:url(http://webimage.10x10.co.kr/play/ground/20160328/story11_bg.png) 50% 50% no-repeat;}
.story11 p {position:absolute; left:255px; top:159px;}
.story11 i {position:absolute; left:-70px; top:-70px;}
.story11 button {position:absolute; left:-70px; top:-70px; width:300px; height:300px;}
.story11 em {position:absolute; left:320px; top:160px; width:145px; height:200px; z-index:10;}

.topic6 {height:490px; background:#f3ece9;}
.story12 {height:490px; background:url(http://webimage.10x10.co.kr/play/ground/20160328/story12_bg.png) 50% 50% no-repeat;}
.story12 p {position:absolute; left:640px; top:90px;}

.topic7 {height:745px; background:#5d556a;}
.story13 {position:relative; height:745px;}
.story13 div {position:absolute; left:0; top:0; width:100%; height:100%;}
.story13 .sean1 {background:url(http://webimage.10x10.co.kr/play/ground/20160328/story13_img1.png) 50% 50% no-repeat;}
.story13 .sean2 {background:url(http://webimage.10x10.co.kr/play/ground/20160328/story13_img2.png) 50% 45% no-repeat;}
.story13 span, .story13 p {position:absolute; left:50%;}
.story13 .txt1 {top:235px; margin-left:-78px;}
.story13 .txt2 {bottom:196px; margin-left:-105px;}
.story13 p {bottom:240px; margin-left:-185px;}

.topic8 {background-color:#e6e1dc;}

.commentWrite {width:100%; background-color:#ace4e3;}
.commentWrite div {position:relative; width:1140px; margin:0 auto;}
.commentWrite div:after {position:absolute; top:100%; left:50%; width:19px; height:14px; margin-left:-9px; content:''; background:url(http://webimage.10x10.co.kr/play/ground/20160328/cmt_deco_pointer.png) 50% 0 no-repeat;}
.commentWrite div .cmtInpt {position:absolute; left:55.7%; top:42.3%; width:345px;}
.commentWrite div .cmtInpt input {font-size:26px; font-family:dotum, '돋움', sans-serif; color:#cdcdcd; background-color:transparent; font-weight:bold; letter-spacing:32px;}
.commentWrite div button {position:absolute; left:796px; top:271px; background-color:transparent;}

.commentlist {width:100%; margin:0 auto; padding:65px 0; text-align:center; background-color:#f8f8f8;}
.commentlist .total {display:inline-block; padding-bottom:3px; border-bottom:2px solid #4cbab7; font-family:verdana, tahoma, sans-serif; font-size:18px; line-height:1.4; color:#38b5b2;}
.commentlist .total img {vertical-align:top; margin-top:5px;}
.commentlist ul {overflow:hidden; width:1015px; margin:0 auto; padding:34px 0;}
.commentlist ul li {float:left; width:191px; padding:6px;}
.commentlist ul li div {position:relative; width:100%;}
.commentlist ul li .msg, .commentlist ul li .id, .commentlist ul li .btndel {position:absolute;}
.commentlist ul li .msg {left:22px; top:28px; line-height:1.3; color:#000; font-size:18px; font-weight:600; font-family:helveticaNeue, helvetica, sans-serif !important; text-align:left;}
.commentlist ul li .msg img {height:20px; width:auto; vertical-align:middle;}
.commentlist ul li .id {left:15px; bottom:17px; right:15px; border-top:1px solid #fff; padding:2px 5px; color:#fff; font-size:12px; text-align:left;}
.commentlist ul li .id img {width:7px; height:11px; margin:3px 2px;}
.commentlist ul li .btndel {position:absolute; right:0; top:0; width:40px; height:40px; background-color:transparent; text-align:center; border:none; z-index:20;}
.commentlist ul li .btndel img {width:20px; height:20px;}
.commentlist ul li:nth-child(2n) div {background-color:#52cfe1;}
.commentlist ul li:nth-child(2n+1) div {background-color:#58c0e7;}
.commentlist ul li:nth-child(4n) div {background-color:#78b2e4;}
.commentlist ul li:nth-child(4n+1) div {background-color:#5acecc;}
.commentlist ul li:first-child div {background-color:#5acecc;}
</style>
<script>
$(function(){
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 740.0) {
			story3()
		}
		if (scrollTop > 1500.0) {
			story5()
		}
		if (scrollTop > 4900.0) {
			story12()
		}
		if (scrollTop > 5500.0) {
			story13()
		}
	});

	$(".tit span, .tit h2, .tit em").css({"opacity":"0"});
	$(".tit h2 i").css({"margin-top":"10px"});
	function titAnimation() {
		$(".tit h2").delay(100).animate({"top":"20.6%", "opacity":"1"},1200);
		$(".tit h2 .titTxt1").delay(100).animate({"margin-top":"-37px"},1000);
		$(".tit h2 .titTxt2").delay(200).animate({"margin-top":"-37px"},1000);
		$(".tit h2 .titTxt3").delay(300).animate({"margin-top":"-37px"},1000);
		$(".tit h2 .titTxt4").delay(400).animate({"margin-top":"-37px"},1000);
		$(".tit span").delay(50).animate({"opacity":"1"},1500);
		$(".tit em").delay(400).animate({"opacity":"1"},1500);
	}
	titAnimation();

	$(".story01 .sean2, .story01 .deco2").css({"opacity":"0"});
	$('.story01 button').click(function(){
		$(".topic1").delay(200).animate({"background-color":"#a9dfdd"},1400);
		$(".story01 .sean1").delay(200).animate({"opacity":"0"},200);
		$(".story01 .sean2").delay(200).animate({"opacity":"1"},200, function(){
			$('.story01 .deco1').delay(1000).animate({"opacity":"0"},150);
			$('.story01 .deco2').delay(1000).animate({"opacity":"1"},150);
		});
	});

	$(".story03 p").css({"left":"-89px", "opacity":"0"});
	$(".story03 span").css({"opacity":"0"});
	$(".story04 span").css({"height":"0", "opacity":"0"});
	$(".story04 i").css({"opacity":"0"});
	$(".story04 em").css({"opacity":"0"});
	function story3() {
		$(".story03 p").delay(100).animate({"left":"89px", "opacity":"1"},1900, function(){
			$(".story03 span").addClass("shadow");
			$(".story04 span").delay(800).animate({"height":"58px", "opacity":"1"},500);
			$(".story04 i").delay(1100).animate({"opacity":"1"},400);
			$(".story04 em").delay(1200).animate({"opacity":"1"},700);
		});
	}

	$(".story05 i, .story05 span").css({"opacity":"0"});
	$(".story05 .obj1").css({"left":"300px", "top":"200px"});
	$(".story05 .obj2").css({"left":"650px", "top":"311px"});
	$(".story05 .obj3").css({"top":"200px"});
	$(".story05 .obj4").css({"left":"500px", "top":"350px"});
	$(".story05 .obj5").css({"left":"550px", "top":"350px"});
	function story5() {
		$(".story05 .obj1").delay(100).animate({"left":"234px", "top":"165px", "opacity":"1"},700);
		$(".story05 .obj2").delay(200).animate({"left":"775px", "top":"211px", "opacity":"1"},500);
		$(".story05 .obj3").delay(400).animate({"top":"124px", "opacity":"1"},500);
		$(".story05 .obj4").delay(700).animate({"left":"442px", "top":"284px", "opacity":"1"},500);
		$(".story05 .obj5").delay(900).animate({"left":"617px", "top":"225px", "opacity":"1"},500);
		$(".story05 .deco1").delay(100).animate({"opacity":"1"},500);
		$(".story05 .deco2").delay(600).animate({"opacity":"1"},500);
		$(".story05 .deco3").delay(900).animate({"opacity":"1"},1000);
		$(".story05 .deco4").delay(1000).animate({"opacity":"1"},700);
	}

	$(".story06 .sean2").css({"opacity":"0"});
	$('.story06 button').click(function(){
		$(".story06 .sean1").delay(100).animate({"opacity":"0"},1200);
		$(".story06 .sean2").delay(100).animate({"opacity":"1"},1200);
	});

	$(".story07 .sean2").hide();
	$(".story07 span").css({"opacity":"0"});
	$(".story07 em").css({"opacity":"0"});
	$('.story07 button').click(function(){
		$(".story07 span").animate({"right":"179px", "top":"120", "opacity":"1"}, 650, function(){
			$(".story07 .sean1").hide();
			$(".story07 .sean2").show();
			$(".story07 .deco1").delay(400).animate({"opacity":"1"},500);
			$(".story07 .deco2").delay(500).animate({"opacity":"1"},500);
		});
	});

	$(".story11 .sean2").css({"opacity":"0"});
	$(".story11 em").css({"height":"0", "opacity":"0"});
	$('.story11 button').click(function(){
		$(".story11 em").animate({"height":"200px", "opacity":"1"}, 900, function(){
			$(".story11 .sean2").animate({"opacity":"1"},500);
			$(".story11 .sean1").animate({"opacity":"0"},700);
		});
	});

	$(".story12 p").css({"left":"1000px", "opacity":"0.5"});
	function story12() {
		$(".story12 p").delay(100).animate({"left":"640px", "opacity":"1"},3000);
	}

	$(".story13 .sean2").css({"opacity":"0"});
	$(".story13 .sean1 .txt1").css({"top":"170px", "opacity":"0"});
	$(".story13 .sean1 p").css({"bottom":"140px", "opacity":"0"});
	$(".story13 .sean2 .txt2").css({"bottom":"100px", "opacity":"0"});
	function story13() {
		$(".topic7").delay(4000).animate({"background-color":"#e6e1dc"},2000);
		$(".story13 .sean1 .txt1").delay(100).animate({"top":"235px", "opacity":"1"},1500);
		$(".story13 .sean1 p").delay(100).animate({"bottom":"240px", "opacity":"1"},3000);
		$(".story13 .sean1").delay(4000).animate({"opacity":"0"},2000);
		$(".story13 .sean2").delay(4000).animate({"opacity":"1"},2000);
		$(".story13 .sean2 .txt2").delay(4100).animate({"bottom":"196px", "opacity":"1"},2000);
	}
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
<% If Not(IsUserLoginOK) Then %>
	jsChklogin('<%=IsUserLoginOK%>');
	return false;
<% End If %>

	if(!frm.txtcomm.value){
		alert("빈칸을 입력해주세요");
		document.frmcom.txtcomm.value="";
		frm.txtcomm.focus();
		return false;
	}
	
	if (GetByteLength(frm.txtcomm.value) > 10){
		alert("제한길이를 초과하였습니다. 5자 이내로 적어주세요.");
		frm.txtcomm.focus();
		return false;
	}
	frm.action = "/play/groundsub/doEventSubscript69930.asp";
	return true;
}

function chkHangul(v){
	var han_check = /([^가-힣ㄱ-ㅎㅏ-ㅣ\x20])/i; 
	if (han_check.test(v)){
		alert("한글만 입력할 수 있습니다.");
		document.frmcom.txtcomm.value = "";
		document.frmcom.txtcomm.focus();
		return false;
	}
}

function jsDelComment(cidx)	{
	if(confirm("삭제하시겠습니까?")){
		document.frmdelcom.Cidx.value = cidx;
   		document.frmdelcom.submit();
	}
}

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}
}
//-->
</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20160328">
			<div class="showerCont">
				<div class="topic1">
					<div class="innerWrap">
						<div class="tit">
							<span><img src="http://webimage.10x10.co.kr/play/ground/20160328/tit_txt_collabo.png" alt="텐바이텐 x 김그래" /></span>
							<h2>
								<i class="titTxt1"><img src="http://webimage.10x10.co.kr/play/ground/20160328/tit_txt_1.png" alt="공" /></i>
								<i class="titTxt2"><img src="http://webimage.10x10.co.kr/play/ground/20160328/tit_txt_2.png" alt="감" /></i>
								<i class="titTxt3"><img src="http://webimage.10x10.co.kr/play/ground/20160328/tit_txt_3.png" alt="샤" /></i>
								<i class="titTxt4"><img src="http://webimage.10x10.co.kr/play/ground/20160328/tit_txt_4.png" alt="워" /></i>
							</h2>
							<em><img src="http://webimage.10x10.co.kr/play/ground/20160328/tit_txt_daily_wash.png" alt="하루를 씻어요" /></em>
						</div>
						<div class="story01">
							<span class="deco1"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story1_basket1.png" alt="" /></span>
							<span class="deco2"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story1_basket2.png" alt="" /></span>
							<div class="sean1">
								<button></button>
								<i class="clickTooltip"><img src="http://webimage.10x10.co.kr/play/ground/20160328/img_click_btn.png" alt="CLICK" /></i>
								<img src="http://webimage.10x10.co.kr/play/ground/20160328/story1_img1.png" alt="샤워하러가기" />
							</div>
							<div class="sean2">
								<img src="http://webimage.10x10.co.kr/play/ground/20160328/story1_img2.png" alt="" />
							</div>
						</div>
					</div>
				</div>
				<div class="topic2">
					<div class="innerWrap">
						<div class="story02"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story2.png" alt="다녀왔습니다" /></div>
						<div class="story03">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160328/story3_char.png" alt="으 피곤..." /></p>
							<span><img src="http://webimage.10x10.co.kr/play/ground/20160328/story3_bg.png" alt="" /></span>
						</div>
						<div class="story04">
							<span><img src="http://webimage.10x10.co.kr/play/ground/20160328/story4_light.png" alt="" /></span>
							<i><img src="http://webimage.10x10.co.kr/play/ground/20160328/story4_sigh.png" alt="" /></i>
							<em><img src="http://webimage.10x10.co.kr/play/ground/20160328/story4_txt.png" alt="" /></em>
							<img src="http://webimage.10x10.co.kr/play/ground/20160328/story4_img.png" alt="하아" />
						</div>
					</div>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160328/topic2_txt.png" alt="누구나 매일 거치는 샤워의 즐거움, 살짝 들여다보세요!" /></p>
				</div>
				<div class="topic3">
					<div class="innerWrap">
						<div class="story05">
							<span class="obj1"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story5_obj1.png" alt="" /></span>
							<span class="obj2"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story5_obj2.png" alt="" /></span>
							<span class="obj3"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story5_obj3.png" alt="" /></span>
							<span class="obj4"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story5_obj4.png" alt="" /></span>
							<span class="obj5"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story5_obj5.png" alt="" /></span>
							<i class="deco1"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story5_deco1.png" alt="" /></i>
							<i class="deco2"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story5_deco2.png" alt="" /></i>
							<i class="deco3"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story5_deco3.png" alt="" /></i>
							<i class="deco4"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story5_deco4.png" alt="" /></i>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160328/story5_img.png" alt="먼저, 옷을 훌훌 벗어버립니다" /></p>
						</div>
						<div class="story06">
							<p class="sean1">
								<button></button>
								<img src="http://webimage.10x10.co.kr/play/ground/20160328/story6_img1.png" alt="잠시 잊었던 살과 인사를 합니다" />
							</p>
							<p class="sean2"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story6_img2.png" alt="아이구야" /></p>
						</div>
					</div>
				</div>
				<div class="topic4">
					<div class="story07 innerWrap">
						<div class="">
							<p class="sean1">
								<button></button>
								<i class="clickTooltip"><img src="http://webimage.10x10.co.kr/play/ground/20160328/img_click_btn2.png" alt="CLICK" /></i>
								<img src="http://webimage.10x10.co.kr/play/ground/20160328/story7_img1.png" alt="그리고, 오늘의 샤워음악을 켭니다" />
							</p>
							<span><img src="http://webimage.10x10.co.kr/play/ground/20160328/story7_hand.png" alt="hand" /></span>
							<em class="deco1"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story7_txt.png" alt="달칵" /></em>
							<em class="deco2"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story7_deco.png" alt="" /></em>
							<p class="sean2"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story7_img2.png" alt="그리고, 오늘의 샤워음악을 켭니다" /></p>
						</div>
					</div>
				</div>
				<div class="topic5">
					<div class="innerWrap">
						<p class="story08"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story8.gif" alt="본격적으로 샤워하기 전, 물 온도를 세심히 체크하고" /></p>
						<p class="story09"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story9.gif" alt="따순물로 깨끗이 씻습니다" /></p>
						<p class="story10"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story10.gif" alt="우우우 벱베에~" /></p>
						<div class="story11">
							<p class="sean1">
								<button></button>
								<i class="clickTooltip"><img src="http://webimage.10x10.co.kr/play/ground/20160328/img_click_btn3.png" alt="CLICK" /></i>
								<img src="http://webimage.10x10.co.kr/play/ground/20160328/story11_char1.png" alt="" />
							</p>
							<em><img src="http://webimage.10x10.co.kr/play/ground/20160328/story11_water.png" alt="" /></em>
							<p class="sean2"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story11_char2.png" alt="" /></p>
						</div>
					</div>
				</div>
				<div class="topic6">
					<div class="story12 innerWrap">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160328/story12_char.gif" alt="샤워가 모두 끝났습니다" /></p>
					</div>
				</div>
				<div class="topic7">
					<div class="story13 innerWrap">
						<div class="sean1">
							<span class="txt1"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story13_txt1.png" alt="오늘 하루도" /></span>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160328/story13_bd.png" alt="" /></p>
						</div>
						<div class="sean2">
							<span class="txt2"><img src="http://webimage.10x10.co.kr/play/ground/20160328/story13_txt2.png" alt="수고 많았어요" /></span>
						</div>
					</div>
				</div>
				<div class="topic8">
					<div class="innerWrap"><img src="http://webimage.10x10.co.kr/play/ground/20160328/topic8.jpg" alt="김그래 - 일상의 이야기들을 그리고 씁니다" usemap="#greWriterMap" /></div>
					<map name="greWriterMap" id="greWriterMap">
						<area shape="rect" coords="697,50,783,147" href="http://blog.naver.com/gimgre" target="_blank" alt="Blog" />
						<area shape="rect" coords="783,50,869,147" href="https://www.instagram.com/gimgre/" target="_blank" alt="Insta" />
					</map>
				</div>
			</div>

			<div class="commentWrite">
				<div class="">
					<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
					<input type="hidden" name="eventid" value="<%=eCode%>"/>
					<input type="hidden" name="bidx" value="<%=bidx%>"/>
					<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
					<input type="hidden" name="iCTot" value=""/>
					<input type="hidden" name="mode" value="add"/>
					<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>"/>
					<input type="hidden" name="eCC" value="1">
					<p class="cmtInpt"><input type="text" maxlength="5" style="width:100%;" name="txtcomm" onkeyup="chkHangul(this.value);" onClick="jsCheckLimit();" /></p>
					<button><img src="http://webimage.10x10.co.kr/play/ground/20160328/cmt_btn.png" alt="입력" /></button>
					<img src="http://webimage.10x10.co.kr/play/ground/20160328/cmt_img.jpg" alt="즐거운 샤워 시간 되셨나요? 여러분의 샤워 이야기를 5글자 이내로 남겨주세요!" />
					</form>
				</div>
			</div>
			<form name="frmdelcom" method="post" action="/play/groundsub/doEventSubscript69930.asp" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="Cidx" value="">
			<input type="hidden" name="mode" value="del">
			<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>">
			</form>
			<% IF isArray(arrCList) THEN %>
			<div class="commentlist" id="commentlist">
				<p class="total"><img src="http://webimage.10x10.co.kr/play/ground/20160328/cmt_txt_total1.png" alt="현재" /> <strong><%=FormatNumber(iCTotCnt,0)%></strong><img src="http://webimage.10x10.co.kr/play/ground/20160328/cmt_txt_total2.png" alt="명 샤워중!" /></p>
				<ul>
					<%	For intCLoop = 0 To UBound(arrCList,2)	%>
					<li>
						<div>
							<img src="http://webimage.10x10.co.kr/play/ground/20160328/cmt_box.png" alt="" />
							<p class="msg"><img src="http://webimage.10x10.co.kr/play/ground/20160328/cmt_txt1.png" alt="나의 샤워는" /><br /><%=arrCList(1,intCLoop)%> <img src="http://webimage.10x10.co.kr/play/ground/20160328/cmt_txt2.png" alt="다" /></p>
							<p class="id"><% If arrCList(8,intCLoop) = "M" Then %><img src="http://webimage.10x10.co.kr/play/ground/20160328/ico_mobile.png" alt="모바일에서 작성된 글" /><% End If %> <%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
							<% if ((GetEncLoginUserID = arrCList(2,intCLoop)) or (GetEncLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
							<button type="button" class="btndel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');"><img src="http://webimage.10x10.co.kr/play/ground/20160328/cmt_btn_del.png" alt="삭제" /></button>
							<% End If %>
						</div>
					</li>
					<% Next %>
				</ul>
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
			</div>
			<% End If %>
		</div>
		<!-- #include virtual="/lib/db/dbclose.asp" -->
<script type="text/javascript">
<% if eCC = "1" or iCCurrpage >= 2 then %>
	window.$('html,body').animate({scrollTop:$("#commentlist").offset().top}, 0);
<% end if %>
</script>