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
' Description : PLAY 29 W
' History : 2016-04-08 이종화 생성
'####################################################
Dim eCode , pagereload
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66100
Else
	eCode   =  70132
End If

dim com_egCode, bidx , commentcount
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt, eCC

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)
	eCC = requestCheckVar(Request("eCC"), 1) 
	pagereload	= requestCheckVar(request("pagereload"),2)

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 8		'한 페이지의 보여지는 열의 수
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
.groundWrap {width:100%; background:#facdd4;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}
img {vertical-align:top;}
/* book block css */
.bb-bookblock {width:400px;height: 300px;margin: 0 auto;position: relative;z-index: 100;-webkit-perspective: 1300px;perspective: 1300px;-webkit-backface-visibility: hidden;backface-visibility: hidden;}
.bb-page {position: absolute;-webkit-transform-style: preserve-3d;transform-style: preserve-3d;-webkit-transition-property: -webkit-transform;transition-property: transform;}
.bb-vertical .bb-page {width: 50%;height: 100%;left: 50%;-webkit-transform-origin: left center;transform-origin: left center;}
.bb-horizontal .bb-page {width: 100%;height: 50%;top: 50%;-webkit-transform-origin: center top;transform-origin: center top;}
.bb-page > div,.bb-outer,.bb-content,.bb-inner {position: absolute;height: 100%;width: 100%;top: 0;left: 0;-webkit-backface-visibility: hidden;backface-visibility: hidden;}
.bb-vertical .bb-content {width: 200%;}
.bb-horizontal .bb-content {height: 200%;}
.bb-page > div {width: 100%;-webkit-transform-style: preserve-3d;transform-style: preserve-3d;}
.bb-vertical .bb-back {-webkit-transform: rotateY(-180deg);transform: rotateY(-180deg);}
.bb-horizontal .bb-back {-webkit-transform: rotateX(-180deg);transform: rotateX(-180deg);}
.bb-outer {width: 100%;overflow: hidden;z-index: 999;}
.bb-overlay,.bb-flipoverlay {background-color: rgba(0, 0, 0, 0.7);position: absolute;top: 0px;left: 0px;width: 100%;height: 100%;opacity: 0;}
.bb-flipoverlay {background-color: rgba(0, 0, 0, 0.2);}
.bb-bookblock.bb-vertical > div.bb-page:first-child,
.bb-bookblock.bb-vertical > div.bb-page:first-child .bb-back {-webkit-transform: rotateY(180deg);transform: rotateY(180deg);}
.bb-vertical .bb-front .bb-content {left: -100%;}
.bb-horizontal .bb-front .bb-content {top: -100%;}
.bb-vertical .bb-flip-next,.bb-vertical .bb-flip-initial {-webkit-transform: rotateY(-180deg);transform: rotateY(-180deg);}
.bb-vertical .bb-flip-prev {-webkit-transform: rotateY(0deg);transform: rotateY(0deg);}
.bb-horizontal .bb-flip-next,.bb-horizontal .bb-flip-initial {-webkit-transform: rotateX(180deg);transform: rotateX(180deg);}
.bb-horizontal .bb-flip-prev {-webkit-transform: rotateX(0deg);transform: rotateX(0deg);}
.bb-vertical .bb-flip-next-end {-webkit-transform: rotateY(-15deg);transform: rotateY(-15deg);}
.bb-vertical .bb-flip-prev-end {-webkit-transform: rotateY(-165deg);transform: rotateY(-165deg);}
.bb-horizontal .bb-flip-next-end {-webkit-transform: rotateX(15deg);transform: rotateX(15deg);}
.bb-horizontal .bb-flip-prev-end {-webkit-transform: rotateX(165deg);transform: rotateX(165deg);}
.bb-item {width: 100%;height: 100%;position: absolute;top: 0;left: 0;display: none;background: #fff;}

.intro {height:685px; padding-top:140px; background:#f9dadf;}
.intro .introCont {position:relative; width:1044px; margin:0 auto;}
.title {position:absolute; left:80px; top:0; width:280px; height:344px;}
.title span {display:block; position:absolute; left:0;}
.title .t01 {top:0;}
.title .t02 {top:93px;}
.title .blank {top:178px; height:80px;}
.title .t03 {top:280px;}
.title .blank {width:280px; height:80px;}
.title .blank em {display:block; position:absolute; width:0; height:0; background-color:#3a3aa8;}
.title .blank .left {left:0; top:0; width:4px;}
.title .blank .top {left:0; top:0; height:4px;}
.title .blank .right {right:0; top:0; width:4px;}
.title .blank .bottom {right:0; bottom:0; height:4px;}
.intro .purpose {position:absolute; left:84px; top:437px;}
.intro .deco {position:absolute; right:0; top:132px;}
.bookInfo {overflow:hidden; background:#f9f9f9; text-align:center;}
.viewBook {height:954px; background-image:url(http://webimage.10x10.co.kr/play/ground/20160411/bg_tree.png),url(http://webimage.10x10.co.kr/play/ground/20160411/bg_girl.png); background-repeat:no-repeat, no-repeat; background-position:0 340px,100% 455px; background-color:#f9dadf;}
.viewBook .bookCont {position:relative; width:1164px; height:835px; margin:0 auto;}
.viewBook .todayIs {position:absolute; left:110px; top:105px; z-index:110;}
.viewBook .bb-bookblock {text-align:left;width:1164px; height:835px;}
.viewBook .story {position:absolute; left:646px;}
.viewBook .scene01 .story {top:104px;}
.viewBook .scene02 .story {top:407px;}
.viewBook .scene03 .story {left:752px; top:135px;}
.viewBook .scene04 .story {top:125px;}
.viewBook button {position:absolute; bottom:90px; background:transparent; z-index:100;}
.viewBook #bb-nav-prev {left:478px;}
.viewBook #bb-nav-next {right:478px;}

/* comment */
.commentWrite {padding:85px 0 64px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20160411/bg_stripe.png) repeat 0 0;}
.commentWrite h3 {padding-bottom:55px;}
.commentWrite .myToday {position:relative; width:930px; height:315px; padding:75px 50px 0; margin:0 auto; background:#fff;}
.commentWrite .myToday .write {overflow:hidden; width:100%;}
.commentWrite .myToday .write p {float:left;}
.commentWrite .myToday .write p input {display:inline-block; width:282px; border:4px solid #000; height:56px; color:#000; text-align:center; font-size:28px; line-height:56px; vertical-align:top;}
.commentWrite .myToday .write p input::-webkit-input-placeholder {color:#898989;}
.commentWrite .myToday .write p input::-moz-placeholder {color:#898989;}
.commentWrite .myToday .write p input:-ms-input-placeholder {color:#898989;}
.commentWrite .myToday .write p input:-moz-placeholder {color:#898989;}
.commentWrite .myToday .btnSubmit {position:absolute; right:55px; top:55px;}
.commentWrite .selectGift {overflow:hidden; width:842px; height:110px; padding:20px 45px; margin:58px auto 0; background:#f8f8f8 url(http://webimage.10x10.co.kr/play/ground/20160411/bg_line.png) no-repeat 485px 50%;}
.commentWrite .selectGift p {float:left; width:493px; text-align:left;}
.commentWrite .selectGift input {vertical-align:middle; }
.commentWrite .selectGift img {vertical-align:middle; padding-left:20px;}
.commentList {position:relative;}
.commentList ul {overflow:hidden; width:1120px; padding-top:85px; margin:0 auto;}
.commentList li {float:left; width:240px;margin:0 20px 40px;}
.commentList li div {position:relative; width:200px; height:155px; padding:32px 20px 0; background:#fcebee url(http://webimage.10x10.co.kr/play/ground/20160411/bg_cmt_01.png) no-repeat 100% 100%;}
.commentList li:nth-child(even) div {background:#e1eafa url(http://webimage.10x10.co.kr/play/ground/20160411/bg_cmt_02.png) no-repeat 100% 100%;}
.commentList li .writer {color:#e75f77; font-size:11px; line-height:17px; font-weight:bold;}
.commentList li:nth-child(even) .writer {color:#3a3aa8;}
.commentList li .writer .mob {display:inline-block; width:10px; height:16px; font-size:0; line-height:0; color:transparent; background:url(http://webimage.10x10.co.kr/play/ground/20160411/ico_mob_01.png) 0 0 no-repeat; vertical-align:top; margin-right:6px;}
.commentList li:nth-child(even) .writer .mob {background-image:url(http://webimage.10x10.co.kr/play/ground/20160411/ico_mob_02.png);}
.commentList li .txt {font-size:19px; line-height:21px; padding:17px 0 20px; color:#000; white-space:nowrap;}
.commentList li .txt span {display:block; padding-bottom:10px;}
.commentList li .num {font-size:11px; text-align:left; padding-top:15px; border-top:1px solid #fff; font-weight:bold; color:#d3919e;}
.commentList li:nth-child(even) .num {color:#7885bf;}
.commentList li .btnDel {display:block; position:absolute; right:20px; top:20px; width:24px; height:24px; padding-left:0; background:url(http://webimage.10x10.co.kr/play/ground/20160411/btn_delete.png) 0 0 no-repeat; text-indent:-999em;}
.commentList .pageWrapV15 .pageMove {display:none;}
.commentList .deco {position:absolute; right:124px; bottom:75px;}
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
		alert("여러분의 오늘은 어떤 일을 하기 전날인가요?");
		document.frmcom.txtcomm.value="";
		frm.txtcomm.focus();
		return false;
	}

	if (GetByteLength(frm.txtcomm.value) > 20){
		alert("제한길이를 초과하였습니다. 10자 까지 작성 가능합니다.");
		frm.txtcomm.focus();
		return;
	}

	frm.action = "/play/groundsub/doEventSubscript70132.asp";
	frm.submit();
	return true;
}

function jsDelComment(cidx)	{
	if(confirm("삭제하시겠습니까?")){
		document.frmdelcom.Cidx.value = cidx;
		document.frmdelcom.submit();
	}
}

function jsChklogin22(blnLogin)
{
	if (blnLogin == "True"){
		if(document.frmcom.txtcomm.value =="10자 이내로 적어주세요."){
			document.frmcom.txtcomm.value="";
		}
		return true;
	} else {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	return false;
}

$(function(){
	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	//document.getElementById('commentlist').scrollIntoView();
	window.$('html,body').animate({scrollTop:$("#commentlist").offset().top}, 0);
}
//-->
</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20160411 theDayBefore">
			<div class="intro">
				<div class="introCont">
					<div class="title">
						<span class="t01"><img src="http://webimage.10x10.co.kr/play/ground/20160411/tit_my.png" alt="" /></span>
						<span class="t02"><img src="http://webimage.10x10.co.kr/play/ground/20160411/tit_today.png" alt="" /></span>
						<span class="blank">
							<em class="left"></em><em class="top"></em><em class="right"></em><em class="bottom"></em>
						</span>
						<span class="t03"><img src="http://webimage.10x10.co.kr/play/ground/20160411/tit_before_day.png" alt="" /></span>
					</div>
					<p class="purpose"><img src="http://webimage.10x10.co.kr/play/ground/20160411/txt_purpose.png" alt="텐바이텐 PLAY 4월 주제는 시간  입니다. 여행 전날, 소풍 전날, 첫 출근 전날, 첫 데이트 전날. 참 이상한 일이지만, 무엇이든 하기 전이 가장 설레는 것 같아요. 텐바이텐 PLAY는 누구나 한 번 쯤은 겪었던 설레는 순간들에 대해서 이야기해보고자 합니다. 여러분들은 어떤 설레는 시간을 보내고 있나요? 텐바이텐이 이야기하는 에피소드와 함께, 어려분의 이야기를 들려주세요." /></p>
					<div class="deco"><img src="http://webimage.10x10.co.kr/play/ground/20160411/img_deco_title.gif" alt="" /></div>
				</div>
			</div>
			<div class="viewBook">
				<div class="bookCont">
					<p class="todayIs"><img src="http://webimage.10x10.co.kr/play/ground/20160411/txt_today_is.png" alt="나의 오늘은()전날" /></p>
					<div id="bb-bookblock" class="bb-bookblock">
						<div class="bb-item scene01" id="scene01"><img src="http://webimage.10x10.co.kr/play/ground/20160411/img_scene_01.gif" alt="" /></div>
						<div class="bb-item scene02" id="scene02"><img src="http://webimage.10x10.co.kr/play/ground/20160411/img_scene_02.gif" alt="" /></div>
						<div class="bb-item scene03" id="scene03"><img src="http://webimage.10x10.co.kr/play/ground/20160411/img_scene_03.gif" alt="" /></div>
						<div class="bb-item scene04" id="scene04"><img src="http://webimage.10x10.co.kr/play/ground/20160411/img_scene_04.gif" alt="" /></div>
					</div>
					<button id="bb-nav-prev"><img src="http://webimage.10x10.co.kr/play/ground/20160411/btn_prev.png" alt="이전" /></button>
					<button id="bb-nav-next"><img src="http://webimage.10x10.co.kr/play/ground/20160411/btn_next.png" alt="다음" /></button>
				</div>
			</div>
			<div class="bookInfo">
				<div><img src="http://webimage.10x10.co.kr/play/ground/20160411/img_book_info.jpg" alt="떠나기 전 D-100, 기다림이 설렘으로 바뀌어가는 작지만 충분한 하루" /></div>
			</div>
			<div class="commentEvent">
				<form name="frmcom" method="post" onSubmit="return;" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>"/>
				<input type="hidden" name="bidx" value="<%=bidx%>"/>
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
				<input type="hidden" name="iCTot" value=""/>
				<input type="hidden" name="mode" value="add"/>
				<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>"/>
				<input type="hidden" name="eCC" value="1">
				<input type="hidden" name="pagereload" value="ON">
				<div class="commentWrite">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20160411/tit_comment.png" alt="무엇이든 하기 전이 가장 설레어요! 여러분의 오늘은 어떤 일을 하기 전날인가요?" /></h3>
					<div class="myToday">
						<div class="write">
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160411/txt_today.png" alt="나의 오늘은" /></p>
							<p><input type="text" id="txtcomm" placeholder="10자 이내" name="txtcomm" onClick="jsChklogin22('<%=IsUserLoginOK%>');" maxlength="10"/></p>
							<p><img src="http://webimage.10x10.co.kr/play/ground/20160411/txt_before.png" alt="전날" /></p>
						</div>
						<div class="selectGift">
							<p><input type="radio" id="gift01" name="spoint" value="1" checked><label for="gift01"><img src="http://webimage.10x10.co.kr/play/ground/20160411/txt_select_book.png" alt="도서받기" /></label></p>
							<p style="width:325px;"><input type="radio" id="gift02" name="spoint" value="2"><label for="gift02"><img src="http://webimage.10x10.co.kr/play/ground/20160411/txt_select_invite.png" alt="초대받기" /></label></p>
						</div>
						<button type="button" class="btnSubmit" onclick="jsSubmitComment(document.frmcom);return false;"><img src="http://webimage.10x10.co.kr/play/ground/20160411/btn_enroll.png" alt="등록하기"/></button>
					</div>
				</div>
				</form>
				<form name="frmdelcom" method="post" action="/play/groundsub/doEventSubscript70132.asp" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="Cidx" value="">
				<input type="hidden" name="mode" value="del">
				<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>">
				<input type="hidden" name="pagereload" value="ON">
				</form>
				<% IF isArray(arrCList) THEN %>
				<div class="commentList" id="commentlist">
					<ul>
						<%	For intCLoop = 0 To UBound(arrCList,2)	%>
						<li>
							<div>
								<p class="writer"><% If arrCList(8,intCLoop) = "M"  then%><span class="mob">모바일에서 작성</span><% End If %><%=printUserId(arrCList(2,intCLoop),2,"*")%>님의 설레는 <% if ((GetEncLoginUserID = arrCList(2,intCLoop)) or (GetEncLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %><span><a href="" class="btnDel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;">삭제</a></span><% End If %></p>
								<p class="txt">
									<span><%=arrCList(1,intCLoop)%></span>
									<strong>전날</strong>
								</p>
								<p class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
							</div>
						</li>
						<% Next %>
					</ul>
					<div class="pageWrapV15 tMar20">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				</div>
				<% End If %>
			</div>
		</div>
<script type="text/javascript" src="/lib/js/modernizr.custom.js"></script>
<script type="text/javascript" src="/lib/js/jquery.bookblock.js"></script>
<script type="text/javascript">
$(function(){
	/* animation effect */
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 200 ) {
			titleAnimation();
		}
		if (scrollTop > 1900 ) {
			$(".bookInfo").animate({"height":"495px"},1000);
		}
	});
	$(".bookInfo").css({"height":"0"});
	$(".title .t01").css({"margin-left":"10px", "opacity":"0"});
	$(".title .t02").css({"margin-left":"10px", "opacity":"0"});
	$(".title .t03").css({"margin-left":"10px", "opacity":"0"});
	$(".intro .purpose").css({"margin-top":"5px", "opacity":"0"});
	function titleAnimation() {
		$(".title .t01").delay(300).animate({"margin-left":"0", "opacity":"1"},700);
		$(".title .t02").delay(700).animate({"margin-left":"0", "opacity":"1"},700);
		$(".title .blank .left,.title .blank .right").delay(1200).animate({"height":"80px"},1200);
		$(".title .blank .top,.title .blank .bottom").delay(1200).animate({"width":"280px"},1200);
		$(".title .t03").delay(2200).animate({"margin-left":"0", "opacity":"1"},700);
		$(".intro .purpose").delay(3000).animate({"margin-top":"0", "opacity":"1"},600);
	}
});
var Page = (function() {
	var config={
		$bookBlock:$('#bb-bookblock'),
		$navNext:$('#bb-nav-next'),
		$navPrev:$('#bb-nav-prev')
	},
	init = function(){
		config.$bookBlock.bookblock( {
			speed:800,
			shadowSides :0.8,
			shadowFlip :0.7
		});
		initEvents();
	},
	initEvents=function() {
		$('#bb-nav-prev').hide();
		var $slides = config.$bookBlock.children();
		var scen = $('.bb-item:visible').attr("id");
		// add navigation events
		config.$navNext.on('click touchstart', function(){
			var scen = $('.bb-item:visible').next().attr("id");
			config.$bookBlock.bookblock('next');
			if(scen=="scene04"){
				$('#bb-nav-next').hide();
			} else {
				$('#bb-nav-prev').show();
				$('#bb-nav-next').show();
			}
			return false;
		});
		config.$navPrev.on('click touchstart', function(){
			var scen = $('.bb-item:visible').prev().attr("id");
			config.$bookBlock.bookblock('prev');
			if(scen=="scene01"){
				$('#bb-nav-prev').hide();
			} else {
				$('#bb-nav-prev').show();
					$('#bb-nav-next').show();
			}
			return false;
		});

		// add swipe events
		$slides.on( {
			'swipeleft' : function(event){
				config.$bookBlock.bookblock('next');
				return false;
			},
			'swiperight' : function(event) {
				config.$bookBlock.bookblock('prev');
				return false;
			}
		} );
		// add keyboard events
		$(document).keydown(function(e){
		var keyCode = e.keyCode || e.which,
			arrow={
				left : 37,
				up : 38,
				right : 39,
				down : 40
			};
			switch (keyCode){
				case arrow.left:
				config.$bookBlock.bookblock('prev');
				break;
				case arrow.right:
				config.$bookBlock.bookblock('next');
				break;
			}
		});
	};
	return {init:init};
})();
Page.init();
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->