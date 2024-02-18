<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
'####################################################
' Description : PLAYing 텐퀴즈
' History : 2018-05-03
'####################################################
%>
<%
dim oItem
dim currenttime
	currenttime =  now()
'	currenttime = #11/09/2016 09:00:00#

Dim eCode , userid , pagereload , vDIdx
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66277
Else
	eCode   =  85823
End If

dim commentcount, i
	userid = GetEncLoginUserID()

If userid <> "" then
	commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")
Else
	commentcount = 0
End If

vDIdx = request("didx")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	pagereload	= requestCheckVar(request("pagereload"),2)

IF blnFull = "" THEN blnFull = True
IF blnBlogURL = "" THEN blnBlogURL = False

IF iCCurrpage = "" THEN
	iCCurrpage = 1
END IF
IF iCTotCnt = "" THEN
	iCTotCnt = -1
END IF

iCPerCnt = 6		'보여지는 페이지 간격
'한 페이지의 보여지는 열의 수
if blnFull then
	iCPageSize = 8		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 8		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
end if

'데이터 가져오기
set cEComment = new ClsEvtComment
	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = userid
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.thingVol040 {position:relative; text-align:center; padding-bottom:118px; background-color:#ffc3dc;}
.topic {position:relative; height:758px; background:url(http://webimage.10x10.co.kr/playing/thing/vol040/bg_topic.png) no-repeat 50%0;}
.topic h2 {padding:120px 0 36px;}
.tab-day {width:885px; height:90px; margin:0 auto; padding-bottom:108px; background:url(http://webimage.10x10.co.kr/playing/thing/vol040/txt_day.png) no-repeat 0 0;}
.tab-day:after {content:" "; display:block; clear:both;}
.tab-day li {position:relative; float:left; width:295px; height:90px; text-indent:-999em;}
.tab-day li strong {position:absolute; left:50%; top:-33px; width:160px; height:183px; margin-left:-80px; background:url(http://webimage.10x10.co.kr/playing/thing/vol040/img_finish.png?v=3) no-repeat 0 0;}
.tab-day li.day2 strong {background-position:-170px 0;}
.tab-day li.day3 strong {background-position:100% 0;}
.btn-challenge {background:transparent; outline:none;}
.app-guide {position:fixed; left:50% !important; width:1160px; height:730px; margin-left:-580px; z-index:99999;}
.app-guide .btn-close {position:absolute; right:30px; top:57px; background:transparent;}
</style>
<div class="thingVol040">
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/playing/thing/vol040/txt_ten_quiz.png" alt="TEN QUIZ" /></h2>
		<p class="coin"><img src="http://webimage.10x10.co.kr/playing/thing/vol040/img_coin.png?v=1" alt="" /></p>
	</div>
	<ul class="tab-day">
		<li class="day1"><span>1DAY</span><strong>FINISH</strong></li>
		<li class="day2"><span>2DAY</span><strong>FINISH</strong></li>
		<li class="day3"><span>3DAY</span><strong>FINISH</strong></li>
	</ul>
	<button class="btn-challenge" onclick="viewPoupLayer('modal',$('#lyrGoapp').html());return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol040/btn_challenge.png" alt="도전하기" /></button>
	<p class="tPad30"><img src="http://webimage.10x10.co.kr/playing/thing/vol040/txt_finish.png" alt="오늘 단 한번 뿐인 도전이 시작됩니다." /></p>
	<!-- 앱으로 이동 팝업 -->
	<div id="lyrGoapp" style="display:none;">
		<div class="app-guide">
			<div><img src="http://webimage.10x10.co.kr/playing/thing/vol040/txt_go_app.png?v=1.1" alt="잠깐! 모바일에서만 텐퀴즈를 참여할 수 잇습니다. 텐바이텐 APP에 접속해주세요!" /></div>
			<button type="button" class="btn-close" onclick="ClosePopLayer()"><img src="http://webimage.10x10.co.kr/playing/thing/vol040/btn_close.png" alt="닫기" /></button>
		</div>
	</div>
	<!--// 앱으로 이동 팝업 -->
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->