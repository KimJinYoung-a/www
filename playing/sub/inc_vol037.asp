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
	eCode   =  67505
Else
	eCode   =  85276
End If

userid = GetEncLoginUserID()

Dim totalresultCnt, sqlStr, resultcnt

'2. 전체 참여자 카운트
sqlStr = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "'"
rsget.Open sqlStr,dbget,1
If not rsget.EOF Then
	totalresultCnt = rsget(0)
End If
rsget.close

sqlStr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript] WHERE  evt_code = '"& eCode &"' and userid= '"&Cstr(userid)&"'"
rsget.Open sqlStr, dbget, 1
	resultcnt = rsget("cnt")
rsget.close


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
<style type="text/css">
.thingVol037 {position:relative; text-align:center;}
.thingVol037 .inner {position:relative; width:1140px; margin:0 auto;}
.thingVol037 button {background-color:transparent;}
.topic {position:relative; background-color:#d2e4fe;}
.topic:after {content:''; position:absolute; left:50%; top:0; right:0; bottom:0; width:50%; height:847px; background-color:#f7dd2e; z-index:2;}
.topic .inner {width:100%; height:847px; background:url(http://webimage.10x10.co.kr/playing/thing/vol037/bg_topic.jpg) 50% 0 no-repeat; z-index:3;}
.topic .label {overflow:hidden; position:absolute; left:50%; top:120px; margin-left:-550px;}
.topic .label img {margin-left:-218px; transition:all 1s .2s;}
.topic h2 span {display:inline-block; position:absolute; left:50%; z-index:20; margin-left:-550px;}
.topic h2 .t1 {top:150px; margin-left:-550px; opacity:0; transition:all 1s .6s;}
.topic h2 .t2 {top:360px; margin-left:-550px; opacity:0; transition:all 1s 1.7s;}
.topic h2 .line {width:1px; height:8px; top:285px; background-color:#000; opacity:0; transition:all 1s .9s;}
.topic .sub-copy {position:absolute; left:50%; top:382px; margin-top:15px; margin-left:242px; opacity:0; transition:all 1.5s 1.5s;}
.topic.animation .label img {margin-left:0;}
.topic.animation h2 .t1 {margin-top:30px; opacity:1;}
.topic.animation h2 .t2 {margin-top:20px; opacity:1;}
.topic.animation h2 .line {height:80px; opacity:1;}
.topic.animation .sub-copy {margin-top:0; opacity:1;}
.section1 {position:relative; padding:120px 0; background-color:#fff;}
.section1 .sch-word {width:487px; height:66px; margin:40px auto 0 auto; padding-top:25px; background:url(http://webimage.10x10.co.kr/playing/thing/vol037/bg_searchbox.png) 50% 0 no-repeat;}
.section1 .sch-word p {margin-left:-100px;}
.section1 dl {overflow:hidden; width:860px; border-top:1px solid #e5e5e5; margin:40px auto; padding-top:35px;}
.section1 dl dt {float:left; width:150px; padding-top:10px; text-align:right; opacity:0;}
.section1 dl dd {float:left; width:650px; padding-left:30px;}
.section1 dl dd ul {overflow:hidden;}
.section1 dl dd ul li {float:left; padding:5px; opacity:0;}
.section2 {position:relative; padding:0 0 137px 0; background-color:#fa4352;}
.section2 ul {width:1020px; margin:80px auto 0 auto; padding:60px; background-color:#fff;}
.section2 li {height:302px; padding:80px 80px 0 80px; background:url(http://webimage.10x10.co.kr/playing/thing/vol037/img_story_2.jpg) 678px 40px no-repeat; border-bottom:1px solid #f0f0f0;}
.section2 li p {position:relative; left:-10px; opacity:0; text-align:left;}
.section2 li.story1 {padding-left:453px; background:url(http://webimage.10x10.co.kr/playing/thing/vol037/img_story_1.jpg) 80px 40px no-repeat;}
.section2 li.story3 {padding-left:453px; background:url(http://webimage.10x10.co.kr/playing/thing/vol037/img_story_3.jpg) 80px 40px no-repeat;}
.section2 li.story4 {background:url(http://webimage.10x10.co.kr/playing/thing/vol037/img_story_4.jpg) 678px 40px no-repeat;}
.section2 li.story5 {padding-left:453px; background:url(http://webimage.10x10.co.kr/playing/thing/vol037/img_story_5.jpg) 80px 40px no-repeat; border-bottom:none;}
.section2 span {display:block; position:absolute; left:50%;}
.section2 span.deco1 {top:-105px; width:296px; height:308px; margin-left:-804px; background:url(http://webimage.10x10.co.kr/playing/thing/vol037/deco_story1.png) 50% 0 no-repeat;}
.section2 span.deco2 {top:870px; width:445px; height:595px; margin-left:-960px; background:url(http://webimage.10x10.co.kr/playing/thing/vol037/deco_story2.png) 50% 0 no-repeat;}
.section2 span.deco3 {bottom:-175px; width:393px; height:611px; margin-left:560px; background:url(http://webimage.10x10.co.kr/playing/thing/vol037/deco_story3.png) 100% 0 no-repeat;}
.section3 {padding:100px 0; background-color:#e5e5e5;}
.section3 h3 {padding-bottom:40px;}
.section3 .btnShake:hover {animation:shake 2s 50; animation-fill-mode:both;}
.section4 {padding:100px 0; background-color:#5787cd;}
.section4 h3 {padding-bottom:60px;}
.search-input {position:relative; width:649px; height:60px; padding:15px 50px; margin:0 auto; background:url(http://webimage.10x10.co.kr/playing/thing/vol037/bg_input.png) no-repeat 50% 50%; text-align:left;}
.search-input input {width:470px; height:60px; font-size:30px;}
.search-input input::placeholder {color:#e0e0e0;}
.search-input button {position:absolute; right:0; top:0; width:200px; height:90px; background-color:transparent;}
.cmt {width:914px; margin:0 auto; padding-top:65px;}
.cmt ul {overflow:hidden;}
.cmt li {position:relative; float:left; padding:15px;}
.cmt li div {position:relative; display:table; width:427px; background-color:#d2e4fe; }
.cmt li div span {display:table-cell; padding:20px;}
.cmt li div span.num {width:50px; font-size:14px; color:#000; text-align:left;}
.cmt li div span.question {padding-left:0; font-size:18px; color:#000; text-align:left; font-weight:300; letter-spacing:-0.2px; font-family:'돋움', sans-serif;}
.cmt li div span.writer {padding-left:0; font-size:14px; color:#2157a6; text-align:right;}
.cmt li button {position:absolute; right:9px; top:9px;}
.pageWrapV15 {margin-top:60px;}
.pageWrapV15 .pageMove,.paging .first, .paging .end {display:none;}
.paging {height:29px;}
.paging a {width:44px; height:29px; margin:0; border:0;}
.paging a span {height:29px; padding:0; color:#fff; font:bold 14px/29px verdana;}
.paging a.current span {color:#fe79b7; background:#fff;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging a.arrow {margin:0 10px;}
.paging a.arrow span {width:44px; background:none;}
.paging .prev, .paging .next {background:url(http://webimage.10x10.co.kr/playing/thing/vol037/btn_pagination.png) 0 0 no-repeat;}
.paging .next {background-position:100% 0;}
@keyframes shake {
	0%, 100% {transform:translateX(0);}
	10%, 30%, 50%, 70%, 90% {transform:translateX(-5px);}
	20%, 40%, 60%, 80% {transform:translateX(5px);}
}
</style>
<script style="text/javascript">
$(function(){
	$(".topic").addClass("animation");
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 700 ) {
			$(".sch-word p").html("<img src='http://webimage.10x10.co.kr/playing/thing/vol037/txt_search_v2.gif' alt='옷정리' />");
			$(".section1 dl dt").delay(3300).animate({"opacity":"1"},500);
			$(".section1 dl dd ul li:nth-child(1)").delay(3500).animate({"opacity":"1"},500);
			$(".section1 dl dd ul li:nth-child(2)").delay(3700).animate({"opacity":"1"},500);
			$(".section1 dl dd ul li:nth-child(3)").delay(3900).animate({"opacity":"1"},500);
			$(".section1 dl dd ul li:nth-child(4)").delay(4100).animate({"opacity":"1"},500);
			$(".section1 dl dd ul li:nth-child(5)").delay(4300).animate({"opacity":"1"},500);
			$(".section1 dl dd ul li:nth-child(6)").delay(4500).animate({"opacity":"1"},500);
			$(".section1 dl dd ul li:nth-child(7)").delay(4700).animate({"opacity":"1"},500);
			$(".section1 dl dd ul li:nth-child(8)").delay(4900).animate({"opacity":"1"},500);
			$(".section1 dl dd ul li:nth-child(9)").delay(5100).animate({"opacity":"1"},500);
			$(".section1 dl dd ul li:nth-child(10)").delay(5300).animate({"opacity":"1"},500);
			$(".section1 dl dd ul li:nth-child(11)").delay(5500).animate({"opacity":"1"},500);
		}
		if (scrollTop > 960) {
			$(".section2 li.story1 p").animate({"left":"0","opacity":"1"},500);
		}
		if (scrollTop > 1360) {
			$(".section2 li.story2 p").animate({"left":"0","opacity":"1"},500);
		}
		if (scrollTop > 1760) {
			$(".section2 li.story3 p").animate({"left":"0","opacity":"1"},500);
		}
		if (scrollTop > 2160) {
			$(".section2 li.story4 p").animate({"left":"0","opacity":"1"},500);
		}
		if (scrollTop > 2560) {
			$(".section2 li.story5 p").animate({"left":"0","opacity":"1"},500);
		}
	});
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
				alert("탐구 주제를 입력해주세요.");
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
						<div class="thingVol037">
							<div class="topic">
								<div class="inner">
									<p class="label"><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_label.png" alt="장바구니 탐구생활_봄맞이 옷 정리편" /></p>
									<h2>
										<span class="t1"><img src="http://webimage.10x10.co.kr/playing/thing/vol037/tit_clothing1.png" alt="옷에" /></span>
										<span class="line"></span>
										<span class="t2"><img src="http://webimage.10x10.co.kr/playing/thing/vol037/tit_clothing2.png" alt="깔려 죽지 않는 방법" /></span>
									</h2>
									<p class="sub-copy"><img src="http://webimage.10x10.co.kr/playing/thing/vol037/tit_subcopy.png" alt="매번 입을 옷 업다고 하지만 정작 옷장에 옷이 가득한 당신." /></p>
								</div>
							</div>
							<div class="section section1">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_searching.png" alt="옷더미에서 살아남기 위해 '옷정리'를 검색했습니다." /></h3>
								<div class="sch-word"><p></p></div>
								<dl class="keyword">
									<dt><img src="http://webimage.10x10.co.kr/playing/thing/vol037/tit_keyword.png" alt="연관 키워드" /></dt>
									<dd>
										<ul>
											<li><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_keyword1.png" alt="#옷정리노하우" /></li>
											<li><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_keyword2.png" alt="#옷에깔려죽겠다" /></li>
											<li><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_keyword3.png" alt="#효율" /></li>
											<li><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_keyword4.png" alt="#못보던_옷발견" /></li>
											<li><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_keyword5.png" alt="#계절_옷보관" /></li>
											<li><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_keyword6.png" alt="#대청소" /></li>
											<li><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_keyword7.png" alt="#한숨부터_나오는_옷장" /></li>
											<li><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_keyword8.png" alt="#넘쳐나는옷" /></li>
											<li><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_keyword9.png" alt="#옷더미" /></li>
											<li><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_keyword10.png" alt="#마음정리" /></li>
											<li><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_keyword11.png" alt="#기분전환" /></li>
										</ul>
									</dd>
								</dl>
							</div>
							<div class="section section2">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol037/tit_story.png" alt="가장 많이 나온 연관 키워드를 바탕으로 프로 옷 정리 위원단이 #옷에 깔려 죽지 않는 방법에 대해 고민했습니다." /></h3>
								<ul>
									<li class="story1"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_story_1.png" alt="Tip1. 안 입는 옷은 과감히 Out!" /></p></li>
									<li class="story2"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_story_2.png" alt="Tip2. 옷장엔 옷 길이 별로!" /></p></li>
									<li class="story3"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_story_3.png" alt="Tip3. 이름 붙여주기" /></p></li>
									<li class="story4"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_story_4.png" alt="Tip4. 세로로 새롭게!" /></p></li>
									<li class="story5"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol037/txt_story_5.png" alt="Tip5. 옷장에게도 여유를" /></p></li>
								</ul>
								<span class="deco1"></span>
								<span class="deco2"></span>
								<span class="deco3"></span>
							</div>
							<div class="section section3">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol037/tit_conclusion.png" alt="봄맞이 옷 정리, 다들 하셨나요? 아직 안 하셨다면 이 옷정리 tip을 이용해서 정리해보면 어떨까요?" /></h3>
								<a href="/event/eventmain.asp?eventid=85276" target="_blank"><img src="http://webimage.10x10.co.kr/playing/thing/vol037/btn_item_view.png" alt="옷 정리 도와주는 아이템 보기"  class="btnShake" /></a>
							</div>
							<div class="section section4">
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
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol037/tit_cmt_v2.png" alt="여러분은 무엇이 궁금하시나요?" /></h3>
								<div class="search-input">
									<span><input type="text" id="txtcomm" name="txtcomm" onClick="jsCheckLimit();" placeholder="10자 이내로 입력" /></span>
									<span><button type="button" onclick="jsSubmitComment(document.frmcom);return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol037/btn_searching.png" alt="검색 요청" /></button></span>
								</div>
								</form>
								<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
									<input type="hidden" name="eventid" value="<%=eCode%>">
									<input type="hidden" name="com_egC" value="<%=com_egCode%>">
									<input type="hidden" name="bidx" value="<%=bidx%>">
									<input type="hidden" name="Cidx" value="">
									<input type="hidden" name="mode" value="del">
									<input type="hidden" name="pagereload" value="ON">
								</form>
								<% If isArray(arrCList) Then %>
								<div class="cmt" id="comment">
									<ul>
										<% For intCLoop = 0 To UBound(arrCList,2) %>
										<li>
											<div>
												<span class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
												<span class="question"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></span>
												<span class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%> 님</span>
											</div>
											<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
											<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol037/btn_delete.png" alt="삭제" /></button>
											<% End If %>
										</li>
										<% Next %>
									</ul>
									<div class="pageWrapV15">
										<%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
									</div>
								</div>
								<% End If %>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->