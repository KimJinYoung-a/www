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
' Description : PLAYing 장바구니 탐구생활_이별편
' History : 2017-11-23 이종화 생성
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
	eCode   =  82164
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
	iCPageSize = 6		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 6		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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
.section {text-align:center; background-repeat:repeat; background-position:0 0;}
.topic {height:765px; padding-top:173px; background:#f9f9f8 url(http://webimage.10x10.co.kr/playing/thing/vol028/bg_topic.jpg) 50% 0 no-repeat;}
.topic p {width:587px; margin:0 auto; background:url(http://webimage.10x10.co.kr/playing/thing/vol028/txt_farewell.png?v=1) 0 0 no-repeat; text-indent:-999em; opacity:0; animation:move 1s forwards;}
.topic .label {height:81px;}
.topic .title {height:182px; background-position:0 -81px; animation-delay:.3s;}
.topic .txt {height:322px; background-position:0 -263px; animation-delay:.5s;}
.story {padding:125px 0 155px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol028/bg_noise_1.jpg);}
.story ul {width:920px; margin:0 auto;}
.story li {height:302px; padding-bottom:98px; background:url(http://webimage.10x10.co.kr/playing/thing/vol028/img_story_2.jpg) 100% 0 no-repeat;}
.story li p {position:relative; left:-10px; opacity:0;}
.story li.story1 {padding-left:402px; background:url(http://webimage.10x10.co.kr/playing/thing/vol028/img_story_1.jpg) 0 0 no-repeat;}
.story li.story3 {padding-left:402px; background:url(http://webimage.10x10.co.kr/playing/thing/vol028/img_story_3.jpg) 0 0 no-repeat;}
.story li.story4 {padding-bottom:0; background:url(http://webimage.10x10.co.kr/playing/thing/vol028/img_story_4.jpg) 100% 0 no-repeat;}
.conclusion {padding:87px 0 100px; text-align:center; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol028/bg_noise_2.jpg);}
.conclusion ul {overflow:hidden; width:1176px; margin:0 auto; padding:78px 0;}
.conclusion li {position:relative; float:left; width:258px; height:205px;  margin:0 18px; text-align:left; background:url(http://webimage.10x10.co.kr/playing/thing/vol028/img_item_1.jpg) 50% 50% no-repeat; background-size:100%; transition:all .4s;}
.conclusion li:hover {background-size:120%;}
.conclusion li.item2 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol028/img_item_2.jpg);}
.conclusion li.item3 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol028/img_item_3.jpg);}
.conclusion li.item4 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol028/img_item_4.jpg);}
.conclusion li span {display:inline-block; padding:20px 0 0 20px;}
.comment {padding:100px 0; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol028/bg_noise_3.jpg);}
.comment-write {overflow:hidden; width:1022px; margin:65px auto 0; background-color:#fff;}
.comment-write textarea {overflow:auto; float:left; width:730px; height:125px; padding:35px 30px; border:0; color:#888; font:900 16px/1.4 "malgun Gothic","맑은고딕";}
.comment-write .btn-share {float:right;}
.comment-list ul {overflow:hidden; width:1200px; margin:0 auto; padding-top:78px; font-family:"malgun Gothic","맑은고딕";}
.comment-list li {position:relative; float:left; width:290px; height:290px; margin:0 30px 55px; padding:25px; color:#767368; font-size:14px;  line-height:1; text-align:left; background-color:#fffbee;}
.comment-list li .writer {padding-bottom:25px; color:#ff6529; font-weight:bold;}
.comment-list li .writer .num {padding-right:10px; color:#111;}
.comment-list li .date {position:absolute; right:25px; bottom:20px;}
.comment-list li .delete {position:absolute; right:0; top:0;}
.comment-list .scrollbarwrap {width:100%;}
.comment-list .scrollbarwrap .scrollbar {width:11px;}
.comment-list .scrollbarwrap .viewport {width:260px; height:215px; margin:0 auto; padding:0 10px 0 0; font-size:13px; line-height:1.5;}
.comment-list .scrollbarwrap .track {width:11px; background-color:#e0dbc9;}
.comment-list .scrollbarwrap .thumb {width:11px; background-color:#aea995;}
.comment-list .paging {height:29px;}
.comment-list .paging a {height:29px; line-height:29px; border:0; font-weight:bold; background-color:transparent;}
.comment-list .paging a span {width:42px; height:29px; font-size:14px; color:#111; padding:0;}
.comment-list .paging a.arrow {margin:0 8px; background-color:transparent;}
.comment-list .paging a.arrow span {width:42px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol028/btn_nav.png);}
.comment-list .paging a.current {background-color:#111; border:0; color:#ece0b2;}
.comment-list .paging a.current span {color:#ece0b2;}
.comment-list .paging a.current:hover {background-color:#111;}
.comment-list .paging a.prev span {background-position:0 0;}
.comment-list .paging a.next span {background-position:100% 0;}
.comment-list .paging a:hover {background-color:transparent;}
.epilogue {padding:68px 0; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol028/bg_noise_4.jpg);}
.pageMove, .paging .first, .paging .end {display:none;}
@keyframes move {
	from {transform:translateY(10px); opacity:0;}
	to {transform:translateY(0); opacity:1;}
}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(function(){
	$('.thingVol028 .scrollbarwrap').tinyscrollbar();
});

$(window.parent).scroll(function(){
	var scrollTop = $(window.parent).scrollTop();
	if (scrollTop > 700) {$(".story li.story1 p").animate({"left":"0","opacity":"1"},500);}
	if (scrollTop > 1050) {$(".story li.story2 p").animate({"left":"0","opacity":"1"},500);}
	if (scrollTop > 1400) {$(".story li.story3 p").animate({"left":"0","opacity":"1"},500);}
	if (scrollTop > 1750) {$(".story li.story4 p").animate({"left":"0","opacity":"1"},500);}
});

$(function(){
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$(".comment").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if date() >="2017-11-23" and date() <= "2017-12-04" then %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if(!frm.txtcomm.value){
					alert("여러분의 이별 극복 아이템을 공유해주세요!");
					document.frmcom.txtcomm.value="";
					frm.txtcomm.focus();
					return false;
				}

				if (GetByteLength(frm.txtcomm.value) > 1000){
					alert("제한길이를 초과하였습니다. 500자 까지 작성 가능합니다.");
					frm.txtcomm.focus();
					return false;
				}

				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% else %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
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
<div class="thingVol028 farewell">
	<div class="topic">
		<p class="label">장바구니 탐구생활 _ 이별편</p>
		<p class="title">얼마 전 이별했다는 A씨 앞으로 계속해서 택배가 왔다.</p>
		<p class="txt">계속 배송되는 A씨의 택배. 알고 보니 그녀의 쇼핑 전리품. 이별의 상처를 쇼핑으로 극복하는 걸까? A씨의  택배상자 속 물건들을 몰래 훔쳐보았다. 상자를 열어보니 이런 물건들이 있었다. 요가매트, 트레이닝복, 줄넘기.. 등등 운동으로 이별을 극복한다는 A씨의 이유를 듣고 모두 자신의 이별 극복 아이템을 꺼내놓았다.</p>
	</div>
	<div class="story">
		<ul>
			<li class="story1"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol028/txt_story_1.png" alt="운동으로 이별을 극복한 A씨" /></p></li>
			<li class="story2"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol028/txt_story_2.png" alt="문화생활로 이별을 극복한 N씨" /></p></li>
			<li class="story3"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol028/txt_story_3.png" alt="청소, 정리로 이별을 극복한 B씨" /></p></li>
			<li class="story4"><p><img src="http://webimage.10x10.co.kr/playing/thing/vol028/txt_story_4.png" alt="일기로 이별을 극복하는 H씨" /></p></li>
		</ul>
	</div>
	<div class="conclusion">
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol028/txt_conclusion.png" alt="Conclusion 힘들었던 이별을 극복한 사람들의 경험담, 이별한 지 얼마 되지 않아 마음 아파하고 있다면 이별 극복 아이템으로 마음을 추스러 보는 건 어떨까?" /></h3>
		<ul>
			<li class="item1">
				<span><img src="http://webimage.10x10.co.kr/playing/thing/vol028/txt_item_1.png" alt="A씨 요가매트" /></span>
			</li>
			<li class="item2">
				<span><img src="http://webimage.10x10.co.kr/playing/thing/vol028/txt_item_2.png" alt="H씨 빔프로젝터" /></span>
			</li>
			<li class="item3">
				<span><img src="http://webimage.10x10.co.kr/playing/thing/vol028/txt_item_3.png" alt="B씨 수납함" /></span>
			</li>
			<li class="item4">
				<span><img src="http://webimage.10x10.co.kr/playing/thing/vol028/txt_item_4.png" alt="k씨 일기장/노트" /></span>
			</li>
		</ul>
		<a href="/event/eventmain.asp?eventid=82164"><img src="http://webimage.10x10.co.kr/playing/thing/vol028/btn_more.png" alt="더 많은 이별 극복 아이템 보러 가기" /></a>
	</div>

	<div class="section comment">
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
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol028/txt_comment.png" alt="여러분의 이별 극복 아이템을 공유해주세요! 극복 사례를 공유해주신 분들 중 추첨을 통해 10명에게 이별극복아이템(랜덤)을 드립니다" /></h3>
		<div class="comment-write">
			<textarea cols="30" rows="5" id="txtcomm" name="txtcomm" onClick="jsCheckLimit();" placeholder="500자 이내로 입력(1인 5회)"></textarea>
			<button class="btn-share" onclick="jsSubmitComment(document.frmcom);return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol028/btn_share.png" alt="공유하기" /></button>
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
		<div class="comment-list">
			<ul>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
				<li>
					<p class="writer"><span class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span><%=printUserId(arrCList(2,intCLoop),4,"*")%>님</p>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<a href="" class="delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol028/btn_delete.png" alt="삭제" /></a>
					<% End If %>
					<div class="scrollbarwrap">
						<div class="scrollbar"><div class="track"><div class="thumb"></div></div></div>
						<div class="viewport">
							<div class="overview">
								<%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%>
							</div>
						</div>
					</div>
					<p class="date"><%=formatdate(arrCList(4,intCLoop),"0000.00.00")%></p>
				</li>
				<% Next %>
			</ul>
			<div class="pageWrapV15 tMar20">
				<%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
		</div>
		<% End If %>
	</div>

	<div class="section epilogue">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol028/txt_epilogue.png?v=1" alt="텐바이텐 플레잉 계정[10x10playing]을 팔로우해주세요! 같이 이야기 하고 싶은 주제나 하고 싶은 이야기가 있다면 언제든 메시지 주세요. 우리 함께 소통해요!" /></p>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->