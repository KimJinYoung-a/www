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
' Description : PLAYing 유용한 여행 팁
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
	eCode   =  68519
Else
	eCode   =  86803
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
.thingvol041 {position:relative; text-align:center;}
.topic {position:relative; height:864px; background:#fbff66 url(http://webimage.10x10.co.kr/playing/thing/vol041/bg_topic.jpg) 50% 0 no-repeat;}
.topic .label {overflow:hidden; position:absolute; left:50%; top:240px; margin-left:-570px;}
.topic .label img {margin-left:-218px; transition:all 1s .2s;}
.topic h2 span {display:inline-block; position:absolute; left:50%; z-index:20; margin-left:-550px;}
.topic h2 .t1 {top:335px; margin-left:-870px; opacity:0; transition:all 1s .6s;}
.topic h2 .t2 {top:570px; margin-left:-970px; opacity:0; transition:all 1s 1s;}
.topic.animation .label img {margin-left:0;}
.topic.animation h2 .t1 {margin-left:-570px; opacity:1;}
.topic.animation h2 .t2 {margin-left:-570px; opacity:1;}
.section1 {position:relative; padding:170px 0 155px; background:#437dff url(http://webimage.10x10.co.kr/playing/thing/vol041/bg_content_v2.png) 50% 836px no-repeat; text-align:center;}
.section1 ul {overflow:hidden; width:1140px; margin:88px auto 0 auto;}
.section1 .deco {position:absolute; left:50%; top:614px; width:190px; height:292px; margin-left:-686px; background:url(http://webimage.10x10.co.kr/playing/thing/vol041/img_deco.png) 50% 0 no-repeat; z-index:3;}
.section2 {position:relative; padding:177px 0 155px; background:#39cd74 url(http://webimage.10x10.co.kr/playing/thing/vol041/bg_cmt.png) 50% 0 no-repeat; text-align:center;}
.search-input {position:relative; width:1104px; height:156px; margin:92px auto 0 auto; background-color:#fff; text-align:left;}
.search-input textarea {width:823px; height:136px; padding:10px; font-size:19px; border:none; font-family:'malgun gothic', sans-serif; color:#000;}
.search-input textarea::placeholder {color:#818181;}
.search-input button {position:absolute; right:0; top:0; width:260px; height:156px; background-color:#ff80aa; color:#fff; font-size:27px; font-weight:bold;}
.cmt {width:1150px; margin:0 auto; padding-top:77px;}
.cmt ul {overflow:hidden;}
.cmt li {position:relative; float:left; padding:15px 23px;}
.cmt li .inner {position:relative; width:459px; padding:35px; background-color:#299856; color:#fff; font-family:'malgun gothic', sans-serif;}
.cmt li .inner p {overflow:hidden; padding:5px 0; border-bottom:1px solid #39cd74;}
.cmt li .inner span.writer {float:left; font-size:18px; text-align:left;}
.cmt li .inner span.num {float:right; font-size:18px; text-align:right;}
.cmt li .inner .question {overflow-y:auto; height:95px; margin-top:15px; font-size:16px; text-align:left;}
.cmt li button {position:absolute; right:12px; top:5px; background-color:transparent;}
.pageWrapV15 {margin-top:60px;}
.pageWrapV15 .pageMove,.paging .first, .paging .end {display:none;}
.paging {height:29px;}
.paging a {width:44px; height:29px; margin:0; border:0;}
.paging a span {height:29px; padding:0; color:#111; font:bold 14px/29px verdana;}
.paging a.current span {color:#ece0b2; background:#111;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging a.arrow {margin:0 10px;}
.paging a.arrow span {width:44px; background:none;}
.paging .prev, .paging .next {background:url(http://webimage.10x10.co.kr/playing/thing/vol041/btn_pagination.png) 0 0 no-repeat;}
.paging .next {background-position:100% 0;}
</style>
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
		<% if date() >="2018-05-25" and date() <= "2018-06-05" then %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.txtcomm.value==""){
					alert("여행 꿀템을 입력해주세요.");
					frm.txtcomm.focus();
					return false;
				}
				if (GetByteLength(frm.txtcomm.value) > 160){
					alert("제한길이를 초과하였습니다.80자 까지 작성 가능합니다.");
					frm.txtcomm.focus();
					return false;
				}

				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% Else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% End IF %>
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
						<!-- Vol.041 장바구니 탐구생활_유용한 여행 팁편 -->
						<div class="thingVol041">
							<div class="topic">
								<p class="label"><img src="http://webimage.10x10.co.kr/playing/thing/vol041/txt_label.png" alt="장바구니 탐구생활_유용한 여행 팁편" /></p>
								<h2>
									<span class="t1"><img src="http://webimage.10x10.co.kr/playing/thing/vol041/tit_travel.png" alt="떠나고 나니 깨닫게 되는 것." /></span>
									<span class="t2"><img src="http://webimage.10x10.co.kr/playing/thing/vol041/tit_travel_feat.png" alt="Feat.여행꿀템" /></span>
								</h2>
							</div>
							<div class="section section1">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol041/txt_question.png" alt="여러분은 어떤 여행을 계획하고 있나요?" /></h3>
								<ul>
									<li><img src="http://webimage.10x10.co.kr/playing/thing/vol041/txt_content1.png" alt="천천히 즐길래 - #뚜벅이 여행" /></li>
									<li><img src="http://webimage.10x10.co.kr/playing/thing/vol041/txt_content2.png" alt="먹고, 놀고, 자고 - #휴양 여행" /></li>
									<li><img src="http://webimage.10x10.co.kr/playing/thing/vol041/txt_content3.png" alt="질러보자! - #해외여행" /></li>
									<li><img src="http://webimage.10x10.co.kr/playing/thing/vol041/txt_content4.png" alt="멀리는 못가도 - #당일여행" /></li>
								</ul>
								<p><img src="http://webimage.10x10.co.kr/playing/thing/vol041/txt_content_fin.png" alt="cgp** 고객님이 주신 주제를 토대로 이번 컨텐츠가 제작되었습니다." /></p>
								<p style="margin:123px auto 47px auto"><img src="http://webimage.10x10.co.kr/playing/thing/vol041/txt_go_evt.png" alt="이번 계획하고 있는 여행, 완벽하게 준비하고 떠나세요!" /></p>
								<p><a href="/event/eventmain.asp?eventid=86803"><img src="http://webimage.10x10.co.kr/playing/thing/vol041/btn_shopping.png" alt="여행별 소품 보러가기" /></a></p>
								<span class="deco"></span>
							</div>
							<div class="section section2">
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
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol041/txt_cmt.png" alt="여러분의 여행 꿀템은 무엇인가요?" /></h3>
								<div class="search-input">
									<span><textarea id="txtcomm" name="txtcomm" onClick="jsCheckLimit();" placeholder="80자 이내로 입력"></textarea></span>
									<span><button type="button" onclick="jsSubmitComment(document.frmcom);return false;">추천하기</button></span>
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
											<div class="inner">
												<p>
													<span class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%> 님</span>
													<span class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
												</p>
												<div class="question"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></div>
											</div>
											<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
											<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol041/btn_delete.png" alt="삭제" /></button>
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
						<!-- //THING. html 코딩 영역 -->
<!-- #include virtual="/lib/db/dbclose.asp" -->