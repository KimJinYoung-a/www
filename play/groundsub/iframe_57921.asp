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
' PLAY #15 어둠 속의 대화
' 2014-12-18 이종화 작성
'########################################################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21411
Else
	eCode   =  57921
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
/* layout css */
.dialogue-in-the-dark {position:relative; text-align:center;}
/* iframe style */
.exhibition {padding:180px 0 140px;}
.exhibition .event {margin-top:60px;}
.exhibition .desc {height:435px; margin-top:92px; background:url(http://webimage.10x10.co.kr/play/ground/20141222/bg_envelope.gif) no-repeat 50% 0;}
.exhibition .want {width:159px; height:159px; margin-top:170px; background-color:transparent; background-image:url(http://webimage.10x10.co.kr/play/ground/20141222/btn_apply.png); background-repeat:no-repeat; background-position:50% 0; text-indent:-999em; *text-indent:0;}
.exhibition .want span {text-indent:-999em;}
.exhibition .desc .count {margin-top:35px;}
.exhibition .desc .count strong {margin:0 12px 0 13px; color:#000; font-size:32px; font-family:'Verdana'; font-weight:normal; font-style:italic; line-height:32px;}
</style>
<script type="text/javascript">
<!--
 	function jsSubmitComment(){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

	   var frm = document.frmcom;
	   frm.action = "doEventSubscript57921.asp";
	   frm.submit();
	   return true;
	}
//-->
</script>
<div class="playGr20141222">
	<div class="dialogue-in-the-dark">
		<!-- EXHIBITION -->
		<form name="frmcom" method="post" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>"/>
		<input type="hidden" name="bidx" value="<%=bidx%>"/>
		<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
		<input type="hidden" name="iCTot" value=""/>
		<input type="hidden" name="mode" value="add"/>
		<input type="hidden" name="spoint" value="1">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>"/>
		<!-- for dev msg : iframe -->
		<div class="exhibition">
			<h4><img src="http://webimage.10x10.co.kr/play/ground/20141222/tit_exhibition.gif" alt="EXHIBITION" /></h4>
			<p class="event"><img src="http://webimage.10x10.co.kr/play/ground/20141222/txt_event.gif" alt="" /></p>

			<div class="desc">
				<button type="button" class="want" onclick="jsSubmitComment();return false;"><span>전시, 어둠속의 대화 신청하기</span></button>
				<p class="count">
					<img src="http://webimage.10x10.co.kr/play/ground/20141222/txt_total.gif" alt="총" />
					<strong><%=iCTotCnt%></strong>
					<img src="http://webimage.10x10.co.kr/play/ground/20141222/txt_want.gif" alt="명이 신청하셨습니다." />
				</p>
			</div>
		</div>
		<!--// iframe -->
		</form>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->