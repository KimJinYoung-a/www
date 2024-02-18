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
' Description : PLAYing 연말정산
' History : 2017-12-21 정태훈 생성
'####################################################
%>
<%
dim oItem
dim currenttime
	currenttime =  now()
'	currenttime = #11/09/2016 09:00:00#

Dim eCode , userid , pagereload , vDIdx
IF application("Svr_Info") = "Dev" THEN
	eCode   =  68520
Else
	eCode   =  87142
End If

userid = GetEncLoginUserID()

dim commentcount, i

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

iCPerCnt = 10		'보여지는 페이지 간격
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
<style>
.thingVol042 {text-align:center;}
.topic {height:854px; background:#4c576d url(http://webimage.10x10.co.kr/playing/thing/vol042/bg_topic.jpg) 50% 0 no-repeat;}
.topic .label {padding:160px 0 38px;}
.topic h2 {position:relative;}
.topic .subcopy {position:relative; padding:33px 0 77px;}
.topic .survey {position:relative; width:424px; margin:0 auto; padding-left:138px;}
.topic .survey .tit {position:absolute; left:0; top:0;}
.topic .survey .answer {position:relative;}
.topic .survey .answer:after {content:''; position:absolute; left:1px; top:0; height:109px; background:url(http://webimage.10x10.co.kr/playing/thing/vol042/bg_fill.jpg?v=1) 0 0 no-repeat; animation:fill 2.5s .8s forwards;}
.question {position:relative; padding:120px 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol042/bg_question.jpg) 0 0 repeat;}
.question:after {content:''; position:absolute; left:50%; bottom:0;  z-index:5; width:960px; height:582px; background:url(http://webimage.10x10.co.kr/playing/thing/vol042/bg_question_2.jpg) 0 0 no-repeat;}
.question div {position:relative; z-index:10;}
.question h3 {padding-bottom:104px;}
.conclusion {padding:78px 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol042/bg_conclusion.jpg) 0 0 repeat;}
.conclusion a {display:inline-block; margin:40px 0 20px; animation:bounce 1s 100;}
.comment {padding:100px 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol042/bg_comment.jpg) 0 0 repeat;}
.comment button {background-color:transparent; outline:none;}
.comment-write {overflow:hidden; position:relative; width:550px; height:90px; margin:43px auto 48px; padding-right:200px; background:#fff; border-radius:42px;}
.comment-write input {width:480px; height:90px; color:#666; font:400 30px/1.1 'Noto Sans KR'; text-align:center;}
.comment-write input::-webkit-input-placeholder {color:#d6d6d6;}
.comment-write input::-moz-placeholder {color:#d6d6d6;}
.comment-write input:-ms-input-placeholder {color:#d6d6d6;}
.comment-write input:-moz-placeholder {color:#d6d6d6;}
.comment-write .btn-recommend {position:absolute; right:0; top:0;}
.comment-list ul {overflow:hidden; width:916px; margin:0 auto; padding-bottom:60px;}
.comment-list li {position:relative; float:left; width:387px; height:81px; font:bold 15px/81px 'Noto Sans KR'; letter-spacing:-0.02em; color:#000; margin:30px 15px 0; padding:0 20px; text-align:left; background:#d2e4fe;}
.comment-list li .btn-delete {position:absolute; right:-8px; top:-8px;}
.comment-list li p {display:inline-block; float:left;}
.comment-list li .num {width:72px;}
.comment-list li .txt {font-size:19px;}
.comment-list li .writer {float:right; color:#2157a6; font-size:14px; font-weight:normal;}
.comment-list .paging {height:29px;}
.comment-list .paging a {width:42px; height:29px; line-height:29px; border:0; background-color:transparent;}
.comment-list .paging a span {display:block; height:29px; font-size:15px; font-family:'Roboto'; color:#555; padding:0; letter-spacing:0;}
.comment-list .paging a.arrow {background-color:transparent;}
.comment-list .paging a.arrow span {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol042/paging_arrow.png); width:42px;}
.comment-list .paging a.current {background-color:#333; border:0;}
.comment-list .paging a.current span {color:#f7dd2e;}
.comment-list .paging a.current:hover {background-color:#333;}
.comment-list .paging a.prev span {background-position:0 0;}
.comment-list .paging a.next span {background-position:100% 0;}
.comment-list .paging a:hover {background-color:transparent;}
.comment-list .paging a.first,.comment-list .paging a.end,.comment-list .pageMove {display:none;}
@keyframes bounce {
	from, to {transform:translateY(-3px); animation-timing-function:ease-out;}
	50% {transform:translateY(3px); animation-timing-function:ease-in;}
}
@keyframes fill {
	from {width:0;}
	to {width:345px;}
}
</style>
<script type="text/javascript">
$(function(){
	titleAnimation();
	$(".topic h2").css({"top":"5px","opacity":"0"});
	$(".topic .subcopy").css({"top":"5px","opacity":"0"});
	function titleAnimation() {
		$(".topic h2").delay(100).animate({"top":"0","opacity":"1"},600);
		$(".topic .subcopy").delay(300).animate({"top":"0","opacity":"1"},600);
	}
});
</script>
<script style="text/javascript">
$(function(){
	$(".topic").addClass("animation");

});
$(function(){
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#comment").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if commentcount>4 then %>
			alert("이벤트는 5회까지 참여 가능 합니다.");
			return false;
		<% else %>
			if (frm.txtcomm.value==""){
				alert("다음 주제를 입력해주세요.");
				frm.txtcomm.focus();
				return false;
			}
			if (GetByteLength(frm.txtcomm.value) > 20){
				alert("제한길이를 초과하였습니다.10자 까지 작성 가능합니다.");
				frm.txtcomm.focus();
				return false;
			}

			frm.action = "/event/lib/comment_process.asp";
			frm.submit();
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
			return;
		}
		return false;
	<% End IF %>
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
			return;
		}
		return false;
	}
}
</script>
						<!-- Vol.042 장바구니 탐구생활_우산편 -->
						<div class="thingVol042">
							<div class="topic">
								<div class="inner">
									<p class="label"><img src="http://webimage.10x10.co.kr/playing/thing/vol042/txt_label.png" alt="장바구니 탐구생활_우산편" /></p>
									<h2><img src="http://webimage.10x10.co.kr/playing/thing/vol042/tit_why.png" alt="도대체 왜 매번 우산을 잃어버리는 걸까?" /></h2>
									<p class="subcopy"><img src="http://webimage.10x10.co.kr/playing/thing/vol042/txt_subcopy.png" alt="몇 개째 우산을 산 건지 기억도 나지 않는 분들! 그리고 큰맘 먹고 예쁜 우산을 샀는데, 얼마 가지 않아 잃어버린 경험 다들 한 번씩은 있지 않나요?" /></p>
									<div class="survey">
										<p class="tit"><img src="http://webimage.10x10.co.kr/playing/thing/vol042/tit_survey.png" alt="우산, 몇 개까지 사봤다" /></p>
										<p class="answer"><img src="http://webimage.10x10.co.kr/playing/thing/vol042/img_graph.png?v=1" alt="" /></p>
									</div>
								</div>
							</div>
							<div class="question">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol042/tit_question.png" alt="어떻게 해야 우산을 잃어 버리지 않을까?" /></h3>
								<div><img src="http://webimage.10x10.co.kr/playing/thing/vol042/txt_question.png?v=1" alt="튀는 색상의 우산을 쓰자!/컴팩트한 우산을 가방속에!/손잡이나 스트랩을 이용하자!/우산대신 우비를 입자!" /></div>
							</div>
							<div class="conclusion">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol042/tit_conclusion.png" alt="우산 잃어버리지 않는 방법으로 이번 장마에는 예쁜 우산 사고 잃어비리지 말아요!" /></h3>
								<a href="/event/eventmain.asp?eventid=87142" target="_blank"><img src="http://webimage.10x10.co.kr/playing/thing/vol042/btn_go.png" alt="우산 관련 소품 보러 가기" /></a>
								<p><img src="http://webimage.10x10.co.kr/playing/thing/vol042/txt_contents.png" alt="asscr**고객님이 주신 주제를 토대로 이번 컨텐츠가 제작되었습니다" /></p>
							</div>
							<!-- COMMENT -->
							<div class="comment">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol042/tit_comment.png" alt="다음 주제는 무엇이 궁금하나요?" /></h3>
								<!-- 코멘트 작성 -->
								<div class="comment-write">
									<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
									<input type="hidden" name="eventid" value="<%=eCode%>">
									<input type="hidden" name="com_egC" value="<%=com_egCode%>">
									<input type="hidden" name="bidx" value="<%=bidx%>">
									<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
									<input type="hidden" name="iCTot" value="">
									<input type="hidden" name="mode" value="add">
									<input type="hidden" name="spoint">
									<input type="hidden" name="isMC" value="<%=isMyComm%>">
									<input type="hidden" name="pagereload" value="ON">
									<input type="hidden" name="gubunval">
									<input type="text" id="txtcomm" name="txtcomm" maxlength="10" onClick="jsCheckLimit();" placeholder="10자 이내로 입력" />
									<button type="button" class="btn-recommend" onclick="jsSubmitComment(document.frmcom);return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol042/btn_recommend.png" alt="추천" /></button>
									</form>
									<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
										<input type="hidden" name="eventid" value="<%=eCode%>">
										<input type="hidden" name="com_egC" value="<%=com_egCode%>">
										<input type="hidden" name="bidx" value="<%=bidx%>">
										<input type="hidden" name="Cidx" value="">
										<input type="hidden" name="mode" value="del">
										<input type="hidden" name="pagereload" value="ON">
									</form>
								</div>
								<!-- 코멘트 목록(8개씩 노출) -->
								<div class="comment-list" id="comment">
									<% If isArray(arrCList) Then %>
									<ul>
										<% For intCLoop = 0 To UBound(arrCList,2) %>
										<li>
											<p class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
											<p class="txt"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
											<p class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%> 님</p>
											<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
											<button type="button" class="btn-delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol042/btn_delete.png" alt="코멘트 삭제" /></button>
											<% End If %>
										</li>
										<% Next %>
									</ul>
									<% End If %>
									<div class="pageWrapV15">
										<%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
									</div>
								</div>
							</div>
							<!--// COMMENT -->
						</div>
						<!-- //THING. html 코딩 영역 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->