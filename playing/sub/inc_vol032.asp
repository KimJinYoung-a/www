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
' Description : PLAYing 남자들은 왜 그럴까?
' History : 2018-01-12 이종화 생성
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
	eCode   =  83552
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
	iCPageSize = 5		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
else
	iCPageSize = 5		'메뉴가 있으면 10개			'/수기이벤트 둘다 강제 12고정
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
.thingVol032 {text-align:center;}
.thingVol032 .inner {position:relative; width:1140px; margin:0 auto;}
.topic {height:919px; background:#e1eef6 url(http://webimage.10x10.co.kr/playing/thing/vol032/bg_topic.jpg) 50% 0 no-repeat;}
.topic .label {overflow:hidden; position:absolute; left:85px; top:150px;}
.topic .label img {margin-left:-249px; transition:all 1s .2s;}
.topic h2 span {display:inline-block; position:absolute; left:77px; z-index:20;}
.topic h2 .t1 {top:210px; margin-left:-20px; opacity:0; transition:all 1s .6s;}
.topic h2 .t2 {top:300px; margin-left:20px; opacity:0; transition:all 1s .6s;}
.topic h2 .deco {width:0; height:80px; left:52px; top:202px; z-index:10; background:url(http://webimage.10x10.co.kr/playing/thing/vol032/bg_brush.png) 0 0 no-repeat; transition:width .8s .8s;}
.topic .what {position:absolute; left:80px; top:425px; margin-top:8px; opacity:0; transition:all 1.5s 1.3s;}
.topic .viewTag {position:absolute; left:85px; top:515px; margin-top:5px; opacity:0; transition:all 1s 1.8s;}
.topic .rank {position:absolute; left:85px; top:570px; width:433px; height:193px; opacity:0; background:url(http://webimage.10x10.co.kr/playing/thing/vol032/img_graph.png) 0 0 no-repeat; transition:all 1s 2.3s;}
.topic .rank p {position:absolute; left:45px; top:0; z-index:15;}
.topic .rank ul {position:relative; width:100%; height:100%;}
.topic .rank li {position:absolute; left:67px; top:5px; width:0; height:28px; transition:all .8s 1.6s; background-position:0 0; background-repeat:no-repeat; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol032/img_progress1.png); text-indent:-999em;}
.topic .rank li + li {top:58px; transition-delay:1.8s; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol032/img_progress2.png)}
.topic .rank li + li + li {top:111px; transition-delay:2s; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol032/img_progress3.png)}
.topic .rank li + li + li + li {top:165px; transition-delay:2.5s; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol032/img_progress4.png)}
.topic .rank .deco {display:block; position:absolute; left:-13px; top:43px; width:460px; height:56px; background:url(http://webimage.10x10.co.kr/playing/thing/vol032/line_dot.png) 0 0 no-repeat;}
.topic.animation .label img {margin-left:0;}
.topic.animation h2 .t1 {margin-left:0; opacity:1;}
.topic.animation h2 .t2 {margin-left:0; opacity:1;}
.topic.animation h2 .deco {width:233px;}
.topic.animation .what {margin-top:0; opacity:1;}
.topic.animation .viewTag {margin-top:0; opacity:1;}
.topic.animation .rank {opacity:1;}
.topic.animation .rank li {width:64px; transition-delay:2s;}
.topic.animation .rank li + li {width:194px; transition-delay:2.5s;}
.topic.animation .rank li + li + li {width:110px; transition-delay:3s;}
.topic.animation .rank li + li + li + li {width:95px; transition-delay:3.5s;}
.section1 {padding:87px 0 100px; background-color:#ff5f2e;}
.section1 h3 {padding-bottom:39px;}
.section1 p {left:0; opacity:1; display:inline-block; height:35px; background:url(http://webimage.10x10.co.kr/playing/thing/vol032/txt_what_question.png) 0 0 no-repeat; text-indent:-999em;}
.section2 {padding:87px 0 90px; text-align:center;}
.section2 h3 {padding-bottom:71px;}
.section3 {padding:99px 0; background:#fbd06f url(http://webimage.10x10.co.kr/playing/thing/vol032/bg_conclusion.jpg) 50% 0 no-repeat;}
.section3 h3 {padding-bottom:50px;}
.section3 .btnShake:hover {animation:shake 2s 50; animation-fill-mode:both;}
.section4 {padding:80px 0 90px; background:#fff9df;}
.section4 h3 {padding-bottom:85px;}
.section4 .cmtWrite {position:relative; overflow:hidden; width:1140px; margin:0 auto; text-align:left; background:#fff;}
.section4 .cmtWrite .submit {position:absolute; right:0; top:0;}
.section4 .cmtWrite  .answer1 {position:absolute; left:160px; top:47px; width:137px; height:35px; color:#000; text-align:center; font:normal 21px/1 'malgun gothic', '맑은고딕', dotum, sans-serif; border:0; z-index:10;}
.section4 .cmtWrite  .answer2 {position:absolute; left:420px; top:105px; width:190px; height:35px; color:#000; text-align:center; font:normal 21px/1 'malgun gothic', '맑은고딕', dotum, sans-serif; border:0; z-index:10; letter-spacing:-0.1em;}
.section4 .cmtList ul {width:1000px; margin:0 auto; padding-top:60px;}
.section4 .cmtList li {overflow:hidden; position:relative; height:115px; margin-bottom:27px; background:#ece5c8; font:normal 13px/85px 'malgun gothic', '맑은고딕', dotum, sans-serif;}
.section4 .cmtList li .num {float:left; width:165px; height:60px; margin-top:31px; font-size:18px; font-weight:500; line-height:60px; border-right:2px solid #fff; color:#000;}
.section4 .cmtList li .txt {float:left; width:605px; height:60px; margin-top:31px; font-size:20px; line-height:23px; text-align:left; padding-left:30px; white-space:nowrap; vertical-align:top;}
.section4 .cmtList li .txt p {overflow:hidden;}
.section4 .cmtList li .txt p + p {padding-top:15px;}
.section4 .cmtList li .txt img {float:left;}
.section4 .cmtList li .txt em {float:left; padding:0 2px 0 7px; color:#000; letter-spacing:-1px; margin-top:-2px; font-weight:600; vertical-align:top;}
.section4 .cmtList li .txt p:first-child em {padding-right:6px;}
.section4 .cmtList li .writer {float:right; width:120px; height:60px; margin-top:31px; padding-right:40px; line-height:60px; text-align:right; color:#000; font-weight:600; white-space:nowrap;}
.section4 .cmtList li .delete {position:absolute; right:0; top:0; height:22px; background:transparent;}
.pageWrapV15 {margin-top:60px;}
.pageWrapV15 .pageMove,.paging .first, .paging .end {display:none;}
.paging {height:29px;}
.paging a {width:44px; height:29px; margin:0; border:0;}
.paging a span {height:29px; padding:0; color:#000; font:bold 14px/29px verdana;}
.paging a.current span {color:#fff; background:#000;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging a.arrow {margin:0 10px;}
.paging a.arrow span {width:44px; background:none;}
.paging .prev, .paging .next {background:url(http://webimage.10x10.co.kr/playing/thing/vol032/btn_pagination.png) 0 0 no-repeat;}
.paging .next {background-position:100% 0;}
.volume {padding:60px 0; background-color:#003b48; text-align:center;}
.blink {animation:blink 1.7s 50 3.8s; animation-fill-mode:both;}
@keyframes  blink {
	0%, 100% {opacity:0;}
	10%, 30%, 50%, 70%, 90% {opacity:1;}
	20%, 40%, 60%, 80% {opacity:0;}
}
.typing {width:632px; animation:typing .6s steps(5, end);}
@keyframes typing {
	from {width:0;}
	to {width: 632px;}
}
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
		if (scrollTop > 920 ) {
			$(".section1 p").addClass("typing");
		}
	});
});
</script>
<script type="text/javascript">
$(function(){
	$(".topic").addClass("animation");
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 920 ) {
			$(".section1 p").addClass("typing");
		}
	});
});

$(function(){
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$(".section4").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if date() >="2018-01-15" and date() <= "2018-01-28" then %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if(!frm.txtcommURL.value){
					alert("기간을 입력 해주세요.");
					document.frmcom.txtcomm.value="";
					frm.txtcommURL.focus();
					return false;
				}

				if(!frm.txtcomm.value){
					alert("여러분은 남자친구에게 무엇을 선물하시겠어요?");
					document.frmcom.txtcomm.value="";
					frm.txtcomm.focus();
					return false;
				}

				if (GetByteLength(frm.txtcomm.value) > 20){
					alert("제한길이를 초과하였습니다. 10자 까지 작성 가능합니다.");
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
<div class="thingVol032">
	<div class="topic">
		<div class="inner">
			<p class="label"><img src="http://webimage.10x10.co.kr/playing/thing/vol032/txt_label.png" alt="장바구니 탐구생활_남자친구 선물편" /></p>
			<h2>
				<span class="t1"><img src="http://webimage.10x10.co.kr/playing/thing/vol032/tit_gift_1.png" alt="남자들은" /></span>
				<span class="t2"><img src="http://webimage.10x10.co.kr/playing/thing/vol032/tit_gift_2.png" alt="왜 그럴까?" /></span>
			</h2>
			<p class="what"><img src="http://webimage.10x10.co.kr/playing/thing/vol032/tit_gift_3.png" alt="선물을 마주하는 남자들의 숨은 속마음" /></p>
			<p class="viewTag"><img src="http://webimage.10x10.co.kr/playing/thing/vol032/txt_view.png" alt="여자들이 느끼는 선물 받은 남자들의 반응" /></p>
			<div class="rank">
				<p><img src="http://webimage.10x10.co.kr/playing/thing/vol032/img_face.png" alt="" /></p>
				<ol>
					<li>미소 10%</li>
					<li>무표정 57%</li>
					<li>기쁨 27%</li>
					<li>화남 6%</li>
				</ol>
				<span class="deco blink"></span>
			</div>
		</div>
	</div>
	<div class="section section1">
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol032/txt_what.png" alt="발렌타인데이 한달전부터 고심해서 선물을 샀는데 반응이 무심한 그. 뭘까?" /></h3>
		<p>도대체 뭘 사줘야 어떻게 해야 그가 좋아할까?</p>
	</div>
	<div class="section section2">
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol032/tit_question.png" alt="왜 57%의 남자들은 선물을 받아도 크게 기뻐하지 않았을까?" /></h3>
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol032/txt_talk.png" alt="" /></p>
	</div>
	<div class="section section3">
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol032/tit_conclusion.png" alt="혹시 그동안 너무 앞서가거나 너무 마음을 몰랐던건 아닐까요?" /></h3>
		<a href="/event/eventmain.asp?eventid=83552&eGC=232876" target="_blank"><img src="http://webimage.10x10.co.kr/playing/thing/vol032/btn_item.png" alt="기간별 추천 선물 보기"  class="btnShake" /></a>
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
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol032/txt_comment.png" alt="여러분은 남자친구에게 무엇을 선물하시겠어요?" /></h3>
		<div class="cmtWrite">
			<p><img src="http://webimage.10x10.co.kr/playing/thing/vol032/txt_gift_v2.png" alt="이번 기념일엔 남자친구에게~" /></p>
			<input type="text" class="answer1" id="txtcommURL" name="txtcommURL" onClick="jsCheckLimit();" placeholder="1000일 / 1년" maxlength="5"/>
			<input type="text" class="answer2" id="txtcomm" name="txtcomm" onClick="jsCheckLimit();" placeholder="10자이내로 입력" maxlength="10" />
			<button class="submit" onclick="jsSubmitComment(document.frmcom);return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol032/btn_submit.png" alt="공유하기" /></button>
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
		<div class="cmtList">
			<ul>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
				<li>
					<p class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
					<div class="txt">
						<p>
							<img src="http://webimage.10x10.co.kr/playing/thing/vol032/txt_cmt_1.png" alt="저희는" />
							<em><%=arrCList(7,intCLoop)%></em>
							<img src="http://webimage.10x10.co.kr/playing/thing/vol032/txt_cmt_2_v2.png" alt="되었어요." />
						</p>
						<p>
							<img src="http://webimage.10x10.co.kr/playing/thing/vol032/txt_cmt_3.png" alt="이번 기념일엔 남자친구에게" />
							<em><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></em>
							<img src="http://webimage.10x10.co.kr/playing/thing/vol032/txt_cmt_4.png" alt="을(를) 선물할래요." />
						</p>
					</div>
					<p class="writer"><%=printUserId(arrCList(2,intCLoop),4,"*")%>님</p>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<button class="delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol021/btn_delete.png" alt="삭제" /></button>
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
	<div class="volume">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol032/txt_vol_032.png" alt="앞으로도 많은 분들에게 더 평등하고 많은 기회를 주도록 노력하겠습니다! 여러분 새해 복 많이 받으세요!" /></p>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->