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
	eCode   =  66117
Else
	eCode   =  70577
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
.groundWrap {width:100%; background:#aef1f7;}
.groundCont {position:relative; padding-bottom:0; background-color:#fff;}
.groundCont .grArea {width:100%;}
.groundCont .tagView {width:1100px; margin-top:30px; padding:28px 20px 60px;}
img {vertical-align:top;}
.festivalCont {position:relative; width:1140px; margin:0 auto; text-align:center;}
.intro {background:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_sky.png) repeat-x 0 0;}
.intro .introCont {height:1020px; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_intro.png) no-repeat 50% 0;}
.intro .introCont h2 {padding-top:165px;}
.proposal {height:616px; background:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_land.png) repeat-x 0 0;}
.proposal p {padding-top:105px;}
.always {position:relative; height:770px; background:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_dark.png) repeat-x 0 0;}
.always p {padding-top:80px;}
.always .arrow {position:absolute; left:50%; bottom:-31px; z-index:30; margin-left:-22px;}
.festivalWrite {height:558px; background:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_blue.png) repeat-x 0 0;}
.festivalWrite .myFestivalIs {position:relative;}
.festivalWrite .myFestivalIs input {display:block; position:absolute; left:380px; top:73px; width:303px; height:65px; font-size:27px; color:#898989; text-align:center; border:1px solid #d6d6d6;}
.festivalWrite .btnSubmit {display:block; position:absolute; right:104px; top:341px; vertical-align:top; background:transparent;}
.festivalList ul {overflow:hidden; padding:30px 10px 50px;}
.festivalList li {position:relative; float:left; width:240px; height:186px; font-size:11px; color:#d3ecff; text-align:left; font-weight:bold; margin:42px 20px 0; background:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_fold.png) no-repeat 0 0;}
.festivalList li div {padding:0 22px;}
.festivalList li .num {border-top:1px solid #fff; padding-top:12px; margin-top:16px;}
.festivalList li .txt {font-size:18px; line-height:30px; color:#fff;}
.festivalList li .txt strong {color:#fef503;}
.festivalList li .writer {padding:33px 0 13px;}
.festivalList li .btnDel {display:block; position:absolute; right:20px; top:20px; padding-left:0; background:none;}
.festivalList .pageMove {display:none;}

.sosoLife {overflow:hidden;}
.sosoLife .swiper-container {width:100%;}
.sosoLife .swiper-slide {overflow:hidden; position:relative; float:left; width:100%; height:952px; background-position:50% 0; background-repeat:no-repeat;}
.sosoLife .swiper-slide.walk01 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_slide_01.png); background-color:#fff7df;}
.sosoLife .swiper-slide.walk02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_slide_02.png); background-color:#fbffdf;}
.sosoLife .swiper-slide.walk03 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_slide_03.png); background-color:#f3ffdb;}
.sosoLife .swiper-slide.walk04 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_slide_04.png); background-color:#ebffeb;}
.sosoLife .swiper-slide.walk05 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_slide_05.png); background-color:#e7ffff;}
.sosoLife .swiper-slide.walk06 {background-image:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_slide_06.png); background-color:#e7f7ff;}
.sosoLife .swiper-slide .bg {position:absolute; left:50%; top:0; margin-left:960px; width:50%; height:100%;}
.sosoLife .swiper-slide.walk01 .bg {background:#ffffdf;}
.sosoLife .swiper-slide.walk02 .bg {background:#f3ffdb;}
.sosoLife .swiper-slide.walk03 .bg {background:#ebffeb;}
.sosoLife .swiper-slide.walk04 .bg {background:#e7fffd;}
.sosoLife .swiper-slide.walk05 .bg {background:#e7f7ff;}
.sosoLife .swiper-slide.walk06 .bg {background:#e7f7ff;}
.sosoLife .swiper-slide .grass {position:absolute; bottom:0; width:50%; height:240px; background:url(http://webimage.10x10.co.kr/play/ground/20160509/bg_grass.png) 0 0 repeat-x;}
.sosoLife .swiper-slide .grass.left {left:0; margin-left:-960px;}
.sosoLife .swiper-slide .grass.right {left:50%; margin-left:960px;}
.sosoLife .swiper-slide .txt {position:absolute; left:50%; top:8.2%; width:450px; margin-left:-225px;}
.sosoLife button {display:block; position:absolute; top:50%; left:50%; z-index:500; width:30px; height:55px; margin-top:-28px; background:transparent;}
.sosoLife .btnPrev {margin-left:-550px;}
.sosoLife .btnNext {margin-left:520px;}
.sosoLife .pagination {display:block; position:absolute; left:50%; bottom:58px; z-index:50; width:1140px; height:10px; margin-left:-570px; text-align:center;}
.sosoLife .pagination span {display:inline-block; width:10px; height:10px; margin:0 5px; text-indent:-999em; cursor:pointer; vertical-align:top; z-index:50; background:url(http://webimage.10x10.co.kr/play/ground/20160509/btn_pagination.png) no-repeat 0 0;}
.sosoLife .pagination .swiper-active-switch {width:28px; background-position:100% 0;}
</style>
<script type="text/javascript">
$(function(){
	var evtSwiper = new Swiper('.sosoLife .swiper-container',{
		loop:false,
		calculateHeight:true,
		speed:1400,
		autoplay:false,
		resizeReInit:true,
		resizeFix:true,
		pagination:'.sosoLife .pagination',
		paginationClickable:true,
		nextButton:'.sosoLife .btnNext',
		prevButton:'.sosoLife .btnPrev'
	})
	$('.sosoLife .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	})
	$('.sosoLife .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});
});
</script>
<script type="text/javascript">
<!--

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#vote").offset().top}, 0);
}

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
		alert("여러분의 소소한 축제는 어떤 축제인가요?");
		document.frmcom.txtcomm.value="";
		frm.txtcomm.focus();
		return false;
	}

	if (GetByteLength(frm.txtcomm.value) > 11){
		alert("제한길이를 초과하였습니다. 5자 까지 작성 가능합니다.");
		frm.txtcomm.focus();
		return;
	}

	frm.action = "/play/groundsub/doEventSubscript70577.asp";
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
		if(document.frmcom.txtcomm.value =="5자 이내로 적어주세요."){
			document.frmcom.txtcomm.value="";
		}
		return true;
	} else {
		jsChklogin('<%=IsUserLoginOK%>');
	}

	return false;
}

function fnOverNumberCut(){
	var t = $("#txtcomm").val();
	if($("#txtcomm").val().length >= 5){
		$("#txtcomm").val(t.substr(0, 5));
	}
}
//-->
</script>
<div class="groundCont">
	<div class="grArea">
		<div class="playGr20160509">
			<div class="intro">
				<div class="introCont">
					<h2><img src="http://webimage.10x10.co.kr/play/ground/20160509/tit_soso_festival.png" alt="소소한 축제" /></h2>
				</div>
			</div>
			<div class="proposal">
				<div class="festivalCont">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160509/txt_proposal.png" alt="바쁘게만 살다 지쳐 일상의 소소한 축제들을 모르고 지나쳤을지도 몰라요  일상에 지친 당신에게 매일을 축제처럼 보내는 방법을 제안합니다!" /></p>
				</div>
			</div>
			<div class="sosoLife">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide walk01">
							<div class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160509/txt_slide_01.png" alt="천천히가기" /></div>
							<div class="bg"></div>
							<div class="grass left"></div>
							<div class="grass right"></div>
						</div>
						<div class="swiper-slide walk02">
							<div class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160509/txt_slide_02.png" alt="뭐든지 먹기" /></div>
							<div class="bg"></div>
							<div class="grass left"></div>
							<div class="grass right"></div>
						</div>
						<div class="swiper-slide walk03">
							<div class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160509/txt_slide_03.png" alt="실컷 부르기" /></div>
							<div class="bg"></div>
							<div class="grass left"></div>
							<div class="grass right"></div>
						</div>
						<div class="swiper-slide walk04">
							<div class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160509/txt_slide_04.png" alt="불꽃 피우기" /></div>
							<div class="bg"></div>
							<div class="grass left"></div>
							<div class="grass right"></div>
						</div>
						<div class="swiper-slide walk05">
							<div class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160509/txt_slide_05.png" alt="깨끗이 씻기" /></div>
							<div class="bg"></div>
							<div class="grass left"></div>
							<div class="grass right"></div>
						</div>
						<div class="swiper-slide walk06">
							<div class="txt"><img src="http://webimage.10x10.co.kr/play/ground/20160509/txt_slide_06_v2.png" alt="꽁꽁 덮기" /></div>
							<div class="bg"></div>
							<div class="grass left"></div>
							<div class="grass right"></div>
						</div>
					</div>
					<div class="pagination"></div>
					<button class="btnPrev"><img src="http://webimage.10x10.co.kr/play/ground/20160509/btn_prev.png" alt="이전" /></button>
					<button class="btnNext"><img src="http://webimage.10x10.co.kr/play/ground/20160509/btn_next.png" alt="다음" /></button>
				</div>
			</div>
			<div class="always">
				<div class="festivalCont">
					<p><img src="http://webimage.10x10.co.kr/play/ground/20160509/txt_always.png" alt="쏘쏘하기만 했던 일상 그 일상 속에서 우리는 소소한 축제들을 만납니다   오늘 하루 쏘쏘했다면 내일은 일상에서 벗어나 소소한 일탈을 해보면 어떨까요? 축제는 일상속에서 언제나 있습니다" /></p>
				</div>
				<span class="arrow"><img src="http://webimage.10x10.co.kr/play/ground/20160509/bg_arrow.png" alt="" /></span>
			</div>
			<!-- 코멘트 작성 -->
			<form name="frmcom" method="post" onSubmit="return;" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>"/>
			<input type="hidden" name="bidx" value="<%=bidx%>"/>
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
			<input type="hidden" name="iCTot" value=""/>
			<input type="hidden" name="mode" value="add"/>
			<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>"/>
			<input type="hidden" name="eCC" value="1">
			<input type="hidden" name="pagereload" value="ON">
			<div class="festivalWrite">
				<div class="festivalCont">
					<h3><img src="http://webimage.10x10.co.kr/play/ground/20160509/tit_your_festival.png" alt="여러분이 생각하는 소소한 축제는 어떤 건가요? 코멘트를 남겨주신 분들 중 추첨을 통해 5분께 기프트카드 5만원권을 드립니다." /></h3>
					<div class="myFestivalIs">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20160509/my_festival_is.png" alt="나의 소소한 축제는" /></p>
						<input type="text" id="txtcomm" placeholder="5자 이내" name="txtcomm" onkeyup="fnOverNumberCut();" onClick="jsChklogin22('<%=IsUserLoginOK%>');" maxlength="5" />
					</div>
					<button type="button" class="btnSubmit" onclick="jsSubmitComment(document.frmcom);"><img src="http://webimage.10x10.co.kr/play/ground/20160509/btn_enroll.png" alt="등록하기" /></button>
				</div>
			</div>
			<!--// 코멘트 작성 -->
			</form>
			<form name="frmdelcom" method="post" action="/play/groundsub/doEventSubscript70132.asp" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="Cidx" value="">
			<input type="hidden" name="mode" value="del">
			<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>">
			<input type="hidden" name="pagereload" value="ON">
			</form>
			<!-- 코멘트 목록 (코멘트는 8개씩 노출) -->
			<% IF isArray(arrCList) THEN %>
			<div class="festivalList" id="commentlist">
				<div class="festivalCont">
					<ul>
						<% For intCLoop = 0 To UBound(arrCList,2) %>
						<li>
							<div>
								<p class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
								<p class="txt">나의 소소한 축제는<br /><strong><%=arrCList(1,intCLoop)%></strong>다.</p>
								<p class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
								<% if ((GetEncLoginUserID = arrCList(2,intCLoop)) or (GetEncLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
								<a href="#" class="btnDel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;"><span><img src="http://webimage.10x10.co.kr/play/ground/20160509/btn_delete.png" alt="삭제하기" /></span></a>
								<% End If %>
							</div>
						</li>
						<% Next %>
					</ul>
					<div class="pageWrapV15 tMar20">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				</div>
			</div>
			<% End If %>
			<!--// 코멘트 목록 -->
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->