<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : PLAYing 1월의 Thing 함께해요 윷마블
' History : 2017-01-13 원승현 생성
'####################################################
%>
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
dim oItem
dim currenttime
	currenttime =  now()
'	currenttime = #11/09/2016 09:00:00#

dim eCode, jnum
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66265
Else
	eCode   =  75729
End If

dim userid, commentcount, i, vDIdx
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")
vDIdx = request("didx")
jnum = 1


dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, pagereload
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
<style type="text/css">
.yutmarble {text-align:center;}

.yutmarble .topic {padding:208px 0 184px; background:#65b892 url(http://webimage.10x10.co.kr/playing/thing/vol006/bg_yut.png) 50% 0 no-repeat;}
.yutmarble .topic h2 {position:relative; width:285px; height:269px; margin:0 auto;}
.yutmarble .topic h2 span {display:block; position:absolute; left:0; width:85px; height:90px; background:url(http://webimage.10x10.co.kr/playing/thing/vol006/tit_yut_marble.png) 0 0 no-repeat; color:#65b892;}
.yutmarble .topic h2 .letter1 {top:0;}
.yutmarble .topic h2 .letter2 {top:0; left:85px; width:72px; background-position:-85px 0;}
.yutmarble .topic h2 .letter3 {top:0; left:157px; width:56px; background-position:-157px 0;}
.yutmarble .topic h2 .letter4 {top:0; left:213px; width:72px; background-position:100% 0;}
.yutmarble .topic h2 .letter5 {bottom:0; width:285px; height:182px; background-position:50% 100%;}
.yutmarble .topic {animation:snowing 7s linear infinite;}
@keyframes snowing {
	0% {background-position:50% -30px;}
	50% {background-position:50% 0;}
	100%{background-position:50% -30px;}
}
.yutmarble .topic p {margin-top:47px;}

.yutmarble .when {background-color:#c98854;}
.yutmarble .when .family {position:relative; width:1140px; margin:0 auto;}
.yutmarble .when .family .check {position:absolute; top:129px; left:520px; width:22px;}
.yutmarble .when .family .check span {display:block; opacity:0;}
.yutmarble .when .family .check span:nth-child(2) {animation-delay:0.3s;}
.yutmarble .when .family .check span:nth-child(3) {animation-delay:0.6s;}
.yutmarble .when .family .check span:nth-child(4) {animation-delay:0.9s;}

.slideUp {animation:slideUp 2s cubic-bezier(0.19, 1, 0.22, 1) forwards;}
@keyframes slideUp {
	0% {margin-top:-50%; opacity:0;}
	100% {margin-top:0; opacity:1;}
}

.yutmarble .intro {background:#90614a url(http://webimage.10x10.co.kr/playing/thing/vol006/bg_tree.png) 50% 0 no-repeat;}

.yutmarble .letsPlay {overflow:hidden; position:relative; height:788px; background-color:#cfe5ce;}
.yutmarble .letsPlay p {position:absolute; top:0; left:50%; margin-left:-960px;}
.yutmarble .comment {overflow:hidden; position:relative; padding:50px 0 88px; background-color:#e56b44;}
.yutmarble .comment .line {position:absolute; top:557px; left:50%; width:1514px; height:1px; margin-left:-757px; background-color:#ea8969;}
.yutmarble .comment .form {position:relative;}
.yutmarble .comment .form .kids {position:absolute; top:161px; left:50%; margin-left:-380px;}
.yutmarble .comment .form .kids1 {z-index:20;}
.yutmarble .comment .form .kids2 {top:170px; margin-left:-300px;}
.yutmarble .comment .textarea {position:relative; width:977px; height:255px; margin:19px auto 0; padding-top:60px; background:url(http://webimage.10x10.co.kr/playing/thing/vol006/bg_box_textarea_v2.png) 50% 0 no-repeat; background-attachment:scroll; text-align:left;}
.yutmarble .comment .textarea textarea {width:395px; height:180px; margin-left:218px; padding:10px 15px; border:0; color:#727272; font-family:Dotum, '돋움', Verdana; font-size:14px; line-height:22px; text-align:left; background-color:#f8f8f8;}
.yutmarble .comment .textarea .btnSubmit,
.yutmarble .comment .textarea .btnDone {position:absolute; top:82px; right:96px;}
.yutmarble .commentList {margin-top:36px;}
.yutmarble .commentList ul {overflow:hidden; width:1155px; margin:0 auto;}
.yutmarble .commentList ul li {float:left; position:relative; width:371px; height:126px; margin:0 7px; padding:50px 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol006/bg_box_comment.png) 50% 0 no-repeat; font-size:12px; text-align:left;}
.yutmarble .commentList ul li .writer {position:relative; margin:0 48px;}
.yutmarble .commentList ul li .writer .id {color:#663624;}
.yutmarble .commentList ul li .writer .id span {font-weight:bold;}
.yutmarble .commentList ul li .writer .no {position:absolute; top:0; right:0; color:#94a693;}
.yutmarble .commentList ul li .btndel {position:absolute; top:22px; right:23px; background-color:transparent;}
.yutmarble .commentList ul li .btndel img {transition:transform .7s ease;}
.yutmarble .commentList ul li .btndel:hover img {transform:rotate(-180deg);}
.yutmarble .commentList ul li .overview p {padding-right:15px; color:#6f6d6d; font-size:14px; line-height:24px;}

/* tiny scrollbar */
.scrollbarwrap {width:290px; margin-top:22px; margin-left:48px;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:280px; height:87px; padding-bottom:3px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:8px; background-color:#ffeedb;}
.scrollbarwrap .track {position: relative; width:8px; height:100%;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:8px; height:0; border-radius:10px; background-color:#9dc39b; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:8px; height:5px; background-color:#9dc39b;}
.scrollbarwrap .disable {display:none;}
.noSelect {user-select:none; -o-user-select:none; -moz-user-select:none; -khtml-user-select:none; -webkit-user-select:none;}

.pageWrapV15 {margin-top:29px;}
.pageWrapV15 .pageMove {display:none;}
.paging a {width:44px; height:34px; margin:0; border:0;}
.paging a span {height:34px; padding:0; color:#ffeedb; font-family:Dotum, '돋움', Verdana; font-size:14px; line-height:34px;}
.paging a.current span {background:url(http://webimage.10x10.co.kr/playing/thing/vol006/btn_pagination.png) 50% 0 no-repeat;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging .first, .paging .end {display:none;}
.paging a.arrow span {background:none;}
.paging a.current span {color:#ffeedb; font-weight:normal;}
.paging .prev, 
.paging .next {background:url(http://webimage.10x10.co.kr/playing/thing/vol006/btn_pagination.png) 50% -34px no-repeat;}
.paging .next {background-position:50% 100%;}

.yutmarble .volume {background-color:#4bb88a;}

/* css3 animation */
.shake {animation:shake 1.5s infinite;}
@keyframes shake {
	0% {transform: rotate(-1deg);}
	50% {transform: rotate(2deg);}
	100% {transform: rotate(-1deg);}
}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">

$(function(){
	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>
});

$(function(){
	$(".scrollbarwrap").tinyscrollbar();

	/* ttle animation */
	titleAnimation();
	$("#topic h2 span").css({"margin-top":"7px","opacity":"0"});
	$("#topic h2 .letter5").css({"margin-bottom":"-10px","opacity":"0"});
	function titleAnimation() {
		$("#topic h2 .letter1").delay(200).animate({"margin-top":"-5px", "opacity":"1"},400).animate({"margin-top":"0"},300);
		$("#topic h2 .letter2").delay(500).animate({"margin-top":"-5px", "opacity":"1"},400).animate({"margin-top":"0"},300);
		$("#topic h2 .letter3").delay(800).animate({"margin-top":"-5px", "opacity":"1"},400).animate({"margin-top":"0"},300);
		$("#topic h2 .letter4").delay(1100).animate({"margin-top":"-5px", "opacity":"1"},400).animate({"margin-top":"0"},300);
		$("#topic h2 .letter5").delay(1500).animate({"margin-bottom":"0", "opacity":"1"},400).animate({"margin-bottom":"-10px", "opacity":"1"},300).animate({"margin-bottom":"0"},300);
	}

	function checkAnimation() {
		var window_top = $(window).scrollTop();
		var div_top = $("#when").offset().top/2;
		if (window_top > div_top){
				$("#check span").addClass("slideUp");
		} else {
				$("#check span").removeClass("slideUp");
		}
	}

	$(function() {
		$(window).scroll(checkAnimation);
		checkAnimation();
	});
});


function pagedown(){
	//document.getElementById('commentlist').scrollIntoView();
	window.$('html,body').animate({scrollTop:$(".comment").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if commentcount>0 then %>
			alert("이벤트는 한번만 참여 가능 합니다.");
			return false;
		<% else %>
			if(!frm.txtcomm.value){
				alert("윷마블이 필요한 사연을 적어주세요.");
				document.frmcom.txtcomm.value="";
				frm.txtcomm.focus();
				return false;
			}

			if (GetByteLength(frm.txtcomm.value) > 300){
				alert("제한길이를 초과하였습니다. 150자 까지 작성 가능합니다.");
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

	<% if commentcount>0 then %>
		alert("이미 신청완료 되었습니다.");
		document.getElementById("txtcomm").disabled=true;
		return false;
	<% end if %>

	if (GetByteLength(document.frmcom.txtcomm.value) > 300){
		alert("제한길이를 초과하였습니다. 150자 까지 작성 가능합니다.");
		document.frmcom.txtcomm.focus();
		return false;
	}

	//if (frmcom.txtcomm.value == ''){
	//	frmcom.txtcomm.value = '';
	//}	
}

//내코멘트 보기
function fnMyComment() {
	document.frmcom.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
	document.frmcom.iCC.value=1;
	document.frmcom.submit();
}
</script>
<div class="thingVol006 yutmarble">
	<div id="topic" class="section topic">
		<h2>
			<span class="letter1">함</span>
			<span class="letter2">께</span>
			<span class="letter3">해</span>
			<span class="letter4">요</span>
			<span class="letter5">윳마블</span>
		</h2>
		<p class="desc"><img src="http://webimage.10x10.co.kr/playing/thing/vol006/txt_yut_marble.png" alt="새해 첫 달 1월, 가족들과의 시간 가지셨나요? 텐바이텐 PLAYing에서 다가오는 명절에 온 가족이 함께 즐길 수 있는 놀이를 만들었습니다. 윷마블로 가족들과 함께하세요!" /></p>
	</div>

	<div id="when" class="section when">
		<div class="family">
			<div id="check" class="check">
				<span><img src="http://webimage.10x10.co.kr/playing/thing/vol006/ico_check.png" alt="" /></span>
				<span><img src="http://webimage.10x10.co.kr/playing/thing/vol006/ico_check.png" alt="" /></span>
				<span><img src="http://webimage.10x10.co.kr/playing/thing/vol006/ico_check.png" alt="" /></span>
				<span><img src="http://webimage.10x10.co.kr/playing/thing/vol006/ico_check.png" alt="" /></span>
			</div>
			<p><img src="http://webimage.10x10.co.kr/playing/thing/vol006//txt_my_family.gif" alt="우리 가족 이럴 때 있다면 함께 있어도 따로 노는 가족, 핸드폰 게임만 하는 아이들, 식사 시간에 딱히 할 이야기가 없어 조용한 가족,세대차이 때문에 대화에 공감하지 못할 때" /></p>
		</div>
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol006/txt_start.gif" alt="윷마블을 펼치세요!" /></p>
	</div>

	<div class="section intro">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol006/txt_intro_01.jpg" alt="윷마블이란 전통게임 윷놀이와 카드게임의 융합! 어른과 아이 모두 함께 즐길 수 있는 보드게임으로 말판, 카드 24장, 말 10개, 윷 4개로 구성되어 있어요" /></p>
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol006/txt_intro_02.gif" width="1140" height="589" alt="놀이 방법 및 규칙은요! 함께 모여 팀을 만들고, 윷을 던져 말을 이동하세요! 함께 모여 팀을 만들고, 윷을 던져 말을 이동하세요! 출발점으로 모든 말이 먼저 돌아오면 승리!" /></p>
	</div>

	<div class="section letsPlay">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol006/txt_lets_play_animation.gif" alt="Let&#39;s Play 윷마블은 PLAYing LIMITED EDITION으로 50개 한정으로 제작한 상품입니다! 이 상품은 PLAYing에서만 만날 수 있습니다." /></p>
	</div>

	<div class="section comment">
		<!-- form -->
		<div class="form">
			<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="com_egC" value="<%=com_egCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
			<input type="hidden" name="iCTot" value="">
			<input type="hidden" name="mode" value="add">
			<input type="hidden" name="spoint" value="0">
			<input type="hidden" name="isMC" value="<%=isMyComm%>">
			<input type="hidden" name="pagereload" value="ON">
			<input type="hidden" name="gubunval">
				<fieldset>
				<legend>윷마블이 필요한 우리 가족을 소개 글 쓰기</legend>
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol006/txt_comment_v1.gif" alt="윷마블이 필요한 우리 가족을 소개해주세요! 재미있는 사연 중 추첨을 통해 50분께 윷마블을 드립니다. 이벤트기간은 1월 16일부터 1월 22일까지며, 당첨자 발표는 1월 23일입니다. 설 전 배송 예정 기본 배송지로 발송 예정. 기본 배송지를 미리 확인해주세요!" /></p>
					<span class="kids kids1"><img src="http://webimage.10x10.co.kr/playing/thing/vol006/img_kids_01_v3.png" alt="우리 가족은요" /></span>
					<span class="kids kids2 shake"><img src="http://webimage.10x10.co.kr/playing/thing/vol006/img_kids_02.png" alt="" /></span>
					<div class="textarea">
						<textarea cols="50" rows="6" title="윷마블이 필요한 우리 가족을 소개 글 작성" placeholder="150자 이내로 입력해주세요" id="txtcomm" name="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();"></textarea>
						<% if commentcount>0 then %>
							<div class="btnDone"><img src="http://webimage.10x10.co.kr/playing/thing/vol006/btn_done.png" alt="윷마블 신청완료" /></div>
						<% Else %>
							<div class="btnSubmit"><input type="image" src="http://webimage.10x10.co.kr/playing/thing/vol006/btn_submit.png" alt="윷마블 신청하기" onclick="jsSubmitComment(document.frmcom);return false;"/></div>
						<% End If %>
					</div>
				</fieldset>
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

		<!-- comment list -->
		<% IF isArray(arrCList) THEN %>
		<div class="commentList">
			<ul>
				<%' for dev msg : 한페이지당 6개씩 보여주세요 %>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
				<li>
					<div class="writer">
						<span class="id">
							<% If arrCList(8,intCLoop) <> "W" Then %><img src="http://webimage.10x10.co.kr/playing/thing/vol006/ico_mobile.png" alt="모바일에서 작성된 글" /> <% End If %><%=chrbyte(printUserId(arrCList(2,intCLoop),2,"*"),10,"Y")%><span>님의 가족은요!</span>
						</span>
						<span class="no">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
					</div>
					<div class="scrollbarwrap">
						<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
						<div class="viewport">
							<div class="overview">
								<%' for dev msg : 기대평 부분 요기에 넣어주세요 %>
								<p>
									<%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%>								
								</p>
							</div>
						</div>
					</div>
					<% If ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") Then %>
						<button type="button" class="btndel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol006/btn_delete.png" alt="내 글 삭제하기" /></button>
					<% End If %>
				</li>
				<%
					If jnum >=4 Then
						jnum = 1
					Else
						jnum = jnum + 1
					End If
				%>
				<% Next %>


			</ul>
			
			<!-- pagination -->
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
		</div>
		<% End If %>
	</div>

	<!-- volume -->
	<div class="seciton volume">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol006/txt_vol006.png" alt="Volume 6 Thing의 사물에 대한 생각 가족들과 함께 즐길 수 있는 놀이, 윷마블" /></p>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->