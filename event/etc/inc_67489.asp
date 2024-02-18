<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 크리스마스 이벤트 참여2탄(코멘트)
' History : 2015-12-04 유태욱 생성
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
if date() >= "2015-12-14" then
	Response.Redirect "/event/eventmain.asp?eventid=67490"
end if

dim oItem
dim currenttime
	currenttime =  now()
	'currenttime = #10/07/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  65969
Else
	eCode   =  67489
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, ecc
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	ecc	= requestCheckVar(request("ecc"),10)

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
/* 공통 */
img {vertical-align:top;}
.christmasCont {position:relative; width:1140px; margin:0 auto;}
.christmasHead {position:relative; height:488px; background:#d7d9db url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_head.png) no-repeat 50% 0;}
.christmasHead .date {position:absolute; right:23px; top:22px;}
.christmasHead h2 {position:absolute; left:50%; top:211px; width:662px; height:141px; margin-left:-319px;}
.christmasHead h2 span {display:inline-block; position:absolute; z-index:50;}
.christmasHead h2 span.t01 {left:0;}
.christmasHead h2 span.t02 {left:55px;}
.christmasHead h2 span.t03 {left:134px;}
.christmasHead h2 span.t04 {left:208px;}
.christmasHead h2 span.t05 {left:251px;}
.christmasHead h2 span.t06 {left:319px;}
.christmasHead h2 span.t07 {left:363px;}
.christmasHead h2 span.t08 {left:486px;}
.christmasHead h2 span.t09 {left:561px;}
.christmasHead h2 span.deco {position:absolute; left:16px; top:-2px; width:600px; height:60px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_txt_snow.png) no-repeat 0 0;}
.christmasHead p {position:absolute;}
.christmasHead p.gold {left:50%; top:88px; margin-left:-155px; z-index:40;}
.christmasHead p.year {left:50%; top:180px; margin-left:-88px;}
.christmasHead p.copy {left:50%; top:355px; margin-left:-153px;}
.christmasHead p.laurel {left:50%; top:62px;  z-index:35; width:333px; height:246px; margin-left:-166px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_laurel.png) no-repeat 0 0;}
.christmasHead .snow {position:absolute; left:50%; top:0; z-index:20; width:2000px; height:488px; margin-left:-1000px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_snow.png) repeat-y 0 0;}
.christmasHead .navigator {position:absolute; left:50%; bottom:-77px; z-index:50; width:1218px; height:112px; margin-left:-609px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_tab.png) no-repeat 0 0;}
.christmasHead .navigator ul {padding:6px 0 0 27px;}
.christmasHead .navigator ul:after {content:' '; display:block; clear:both;}
.christmasHead .navigator li {position:relative; float:left; width:282px; height:57px;}
.christmasHead .navigator li a {display:block; width:100%; height:100%; background-position:0 0; background-repeat:no-repeat; text-indent:-9999px;}
.christmasHead .navigator li.styling a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_styling.png);}
.christmasHead .navigator li.party a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_party.png);}
.christmasHead .navigator li.present a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_present.png);}
.christmasHead .navigator li.enjoy a {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/tab_enjoy.png);}
.christmasHead .navigator li.enjoy em {display:block; position:absolute; left:115px; top:-17px; width:62px; height:47px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/ico_apply.png) no-repeat 0 0; z-index:40;}
.christmasHead .navigator li.enjoy em.v2 {left:102px; width:92px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/ico_apply_v2.png);}
.christmasHead .navigator li.enjoy a:hover em {background-position:100% 0;}
.christmasHead .navigator ul li a:hover {background-position:0 -57px;}
.christmasHead .navigator ul li.current a {background-position:0 -114px;}
.christmasHead .navigator ul li.current a:after,
.christmasHead .navigator ul li a:hover:after {content:''; display:inline-block; position:absolute; left:0; top:-59px; width:282px; height:53px; }
.christmasHead .navigator ul li.current a:after  {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_tab_deco.png) !important;}
.christmasHead .navigator ul li a:hover:after {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67495/bg_tab_deco_over.png);}
.christmasHead .navigator ul li.current.styling a:after,.christmasHead .navigator ul li.styling a:hover:after {height:71px; top:-77px; background-position:0 0;}
.christmasHead .navigator ul li.current.party a:after,.christmasHead .navigator ul li.party a:hover:after {background-position:0 -71px;}
.christmasHead .navigator ul li.current.present a:after,.christmasHead .navigator ul li.present a:hover:after {background-position:0 -124px;}
.christmasHead .navigator ul li.current.enjoy a:after,.christmasHead .navigator ul li.enjoy a:hover:after {background-position:0 -176px;}

/* 참여#2 */
.enjoyV2 {margin-bottom:-117px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/bg_wrap.png) 0 0 repeat-x;}
.enjoyV2 .christmasCont {width:100%; height:2134px; padding-top:43px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/bg_present.jpg) 50% 0 no-repeat;}
.myXmasPlan {width:1074px; height:629px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/bg_box.png) 0 0 no-repeat;}
.myXmasPlan h3 {padding:127px 0 40px;}
.myXmasPlan .write {overflow:hidden; width:704px; margin:0 auto;}
.myXmasPlan .write textarea {float:left; width:522px; height:73px; padding:10px; color:#909090; font-weight:bold; border:1px solid #f3ede5; background:#f7f4f0;}
.myXmasPlan .write .btnWrite {float:right;}
.planList {width:992px; height:1005px; margin:0 auto;}
.planList ul {overflow:hidden; padding-bottom:55px;}
.planList li {float:left; width:240px; height:408px; padding:0 39px; margin:0 6px 14px; font-size:11px; background-position:0 0; background-repeat:no-repeat;}
.planList li.topPad {position:relative; top:50px;}
.planList li.plan01 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/bg_cmt_01.png);}
.planList li.plan02 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/bg_cmt_02.png);}
.planList li.plan03 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/bg_cmt_03.png);}
.planList li.plan04 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/bg_cmt_04.png);}
.planList li.plan05 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/bg_cmt_05.png);}
.planList li .overHidden {padding:220px 0 12px; margin-bottom:12px; line-height:12px; border-bottom:2px solid #e9e2dd;}
.planList li .btnDelete {margin-left:3px;}
.planList li .writer {float:left; color:#b58d5b; font-weight:bold;}
.planList li .num {float:right; color:#888;}
.planList .pageMove {display:none;}
.planList .pageWrapV15 {display:inline-block; height:41px; padding-right:20px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/bg_pagination_rt.png) 100% 0 no-repeat;}
.planList .paging {display:inline-block; width:auto; height:35px; padding:6px 0 0 20px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/bg_pagination.png) 0 0 no-repeat;}
.planList .paging a {width:28px; height:28px; line-height:27px; border:0; background:none;}
.planList .paging a.first {margin-left:-10px;}
.planList .paging a.end {margin-right:-10px;}
.planList .paging a span {color:#b58d5a;}
.planList .paging a.current span {color:#000;}
.planList .paging a.arrow span {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/btn_pagination.png); width:28px; height:28px; padding:0;}
.planList .paging a.first span {background-position:0 0;}
.planList .paging a.prev span {background-position:-28px 0;}
.planList .paging a.next span {background-position:-56px 0;}
.planList .paging a.end span {background-position:100% 0;}
.itemLink {position: relative; width:1000px; height:450px; margin:0 auto;}
.itemLink a {display:block; position:absolute; background:url(http://webimage.10x10.co.kr/eventIMG/2015/67489/bg_blank.png) 0 0 repeat; text-indent:-9999px;}
.itemLink a.item01 {left:80px; top:0; width:90px; height:190px;}
.itemLink a.item02 {left:115px; top:193px; width:180px; height:190px;}
.itemLink a.item03 {left:315px; top:300px; width:80px; height:90px;}
.itemLink a.item04 {left:628px; top:148px; width:90px; height:85px;}
.itemLink a.item05 {left:515px; top:300px; width:180px; height:90px;}
/* tiny scrollbar */
.scrollbarwrap {width:240px; margin:0 auto;}
.scrollbarwrap .viewport {overflow:hidden; position:relative; width:225px; height:88px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%; text-align:left; color:#333; line-height:18px;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:2px; background-color:#e7e7e7;}
.scrollbarwrap .track {position: relative; width:2px; height:100%; background-color:#e7e7e7;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:2px; height:24px; background-color:#3f3f3f; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script>
	
<% if Request("iCC") <> "" or request("ecc") <> "" then %>
	$(function(){
		var val = $('#commentlist').offset();
	    $('html,body').animate({scrollTop:val.top},100);
//		window.$('html,body').animate({scrollTop:$(".commentlist").offset().top-100}, 10);
	});
<% end if %>

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
});
$(function(){
	// titleAnimation
	$('.christmasHead p.laurel').css({"opacity":"0"});
	$('.christmasHead p.gold').css({"margin-top":"10px","opacity":"0"});
	$('.christmasHead p.year').css({"margin-top":"3px","opacity":"0"});
	$('.christmasHead h2 span').css({"opacity":"0"});
	$('.christmasHead h2 span.deco').css({"margin-top":"-3px","opacity":"0"});
	$('.christmasHead p.copy').css({"margin-top":"5px","opacity":"0"});
	function titleAnimation() {
		$('.christmasHead p.laurel').animate({"opacity":"1"},800);
		$('.christmasHead p.gold').delay(300).animate({"margin-top":"0","opacity":"1"},800);
		$('.christmasHead p.year').delay(800).animate({"margin-top":"0","opacity":"1"},800);
		$('.christmasHead h2 span.t01').delay(1500).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t02').delay(1800).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t03').delay(2100).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t04').delay(1900).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t05').delay(2300).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t06').delay(1600).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t07').delay(1700).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t08').delay(2000).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.t09').delay(2200).animate({"opacity":"1"},800);
		$('.christmasHead h2 span.deco').delay(2500).animate({"margin-top":"0","opacity":"1"},1500);
		$('.christmasHead p.copy').delay(3200).animate({"margin-top":"-4px","opacity":"1"},500).animate({"margin-top":"0"},500);
	}
	titleAnimation();
	function moveIcon () {
		$(".enjoy em").animate({"margin-top":"0"},500).animate({"margin-top":"3px"},500, moveIcon);
	}
	moveIcon();
	$('.planList li:nth-child(2)').addClass('topPad');
	$('.planList li:nth-child(5)').addClass('topPad');
});
/* snow */
var scrollSpeed =40;
var current = 0;
var direction = 'h';
function bgscroll(){
	current -= -1;
	$('.snow').css("backgroundPosition", (direction == 'h') ? "0 " + current+"px" : current+"px 0");
}
setInterval("bgscroll()", scrollSpeed);

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2015-12-07" and left(currenttime,10)<"2015-12-14" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>0 then %>
				alert("이미 작성하셨습니다.");
				return false;
			<% else %>
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 400){
					alert("코멘트를 남겨주세요.\n최대 한글 200자 까지 작성 가능합니다.");
					frm.txtcomm1.focus();
					return false;
				}
				frm.txtcomm.value = frm.txtcomm1.value
				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
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
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}
}

</script>
<div class="contF contW">
	<div class="christmas2015">
		<div class="christmasHead">
			<div class="christmasCont">
				<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/txt_date.png" alt="2015.11.23~12.25" /></p>
				<p class="gold"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_gold_magic.png" alt="GOLD MAGIC" /></p>
				<p class="laurel"></p>
				<p class="year"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_2015.png" alt="2015" /></p>
				<h2>
						<a href="/event/eventmain.asp?eventid=67483">
						<span class="t01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_c.png" alt="C" /></span>
						<span class="t02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_h.png" alt="H" /></span>
						<span class="t03"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_r.png" alt="R" /></span>
						<span class="t04"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_i.png" alt="I" /></span>
						<span class="t05"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_s.png" alt="S" /></span>
						<span class="t06"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_t.png" alt="T" /></span>
						<span class="t07"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_m.png" alt="M" /></span>
						<span class="t08"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_a.png" alt="A" /></span>
						<span class="t09"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/tit_christmas_s.png" alt="S" /></span>
						<span class="deco"></span>
						</a>
				</h2>
				<p class="copy"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67495/txt_copy.png" alt="품격있는 컬러로 완성하는 크리스마스 데커레이션" /></p>
			</div>
			<div class="navigator">
				<ul>
					<li class="styling"><a href="/event/eventmain.asp?eventid=67483">CHRISTMAS STYLING</a></li>
					<li class="party"><a href="/event/eventmain.asp?eventid=67485">MAKE PARTY</a></li>
					<li class="present"><a href="/event/eventmain.asp?eventid=67487">SPECIAL PRESENT</a></li>
					<li class="enjoy current" onclick="return false;"><a href="">EVJOY TOGETHER<em class="v2">참여</em></a></li>
				</ul>
			</div>
			<div class="snow"></div>
		</div>
		<%''// 참여이벤트 #2 %>
		<div class="enjoyTogether">
			<div class="enjoyV2">
				<div class="christmasCont">
					<%''//  코멘트 쓰기 %>
					<div class="myXmasPlan">
					<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
					<input type="hidden" name="eventid" value="<%=eCode%>">
					<input type="hidden" name="com_egC" value="<%=com_egCode%>">
					<input type="hidden" name="bidx" value="<%=bidx%>">
					<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
					<input type="hidden" name="iCTot" value="">
					<input type="hidden" name="mode" value="add">
					<input type="hidden" name="spoint" value="0">
					<input type="hidden" name="isMC" value="<%=isMyComm%>">
					<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
					<% Else %>
						<input type="hidden" name="hookcode" value="&ecc=1">
					<% End If %>
					<input type="hidden" name="txtcomm">
						<h3><img src="http://webimage.10x10.co.kr/eventIMG/2015/67489/tit_comment_event.png" alt="텐바이텐과 함께하는 2015 크리스마스" /></h3>
						<div class="write">
							<textarea title="코멘트 쓰기" cols="50" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
							<input type="image" onclick="jsSubmitComment(document.frmcom); return false;" src="http://webimage.10x10.co.kr/eventIMG/2015/67489/btn_plan.png" alt="계획 남기기" class="btnWrite" />
						</div>
					</form>
					<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
						<input type="hidden" name="eventid" value="<%=eCode%>">
						<input type="hidden" name="com_egC" value="<%=com_egCode%>">
						<input type="hidden" name="bidx" value="<%=bidx%>">
						<input type="hidden" name="Cidx" value="">
						<input type="hidden" name="mode" value="del">
						<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
						<% Else %>
							<input type="hidden" name="hookcode" value="&ecc=1">
						<% End If %>
					</form>
					</div>
					<%''//  코멘트 쓰기 %>

					<%''// 코멘트 리스트 %>
					<% IF isArray(arrCList) THEN %>
						<div class="planList" id="commentlist">
							<ul>
							<% 
							Dim renloop
							For intCLoop = 0 To UBound(arrCList,2)
							randomize
							renloop=int(Rnd*5)+1
							%>
								<%''// 랜덤으로 클래스 plan01~05 붙여주세요/6개씩 노출 %>
								<li class="plan0<%= renloop %>">
									<div class="overHidden">
										<p class="writer">
											from.<%=printUserId(arrCList(2,intCLoop),2,"*")%>
											<% If arrCList(8,i) <> "W" Then %>
												<img src="http://webimage.10x10.co.kr/eventIMG/2015/67489/ico_m.png" alt="모바일에서 작성" class="mob" />
											<% end if %>
											<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
												<a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btnDelete"><img src="http://webimage.10x10.co.kr/eventIMG/2015/67489/btn_del.png" alt="삭제" /></a>
											<% end if %>
										</p>
										<p class="num">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></p>
									</div>
									<div class="scrollbarwrap">
										<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
										<div class="viewport">
											<div class="overview">
												<%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%>
											</div>
										</div>
									</div>
								</li>
							<% next %>
							</ul>
							<div class="pageWrapV15 tMar20">
								<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
							</div>
						</div>
						<%''// 코멘트 리스트 %>
	
						<div class="itemLink">
							<a href="/shopping/category_prd.asp?itemid=1164910&amp;pEtr=67489" class="item01">레드별 미니 트리</a>
							<a href="/shopping/category_prd.asp?itemid=1382922&amp;pEtr=67489" class="item02">포근 목화리스</a>
							<a href="/shopping/category_prd.asp?itemid=1383404&amp;pEtr=67489" class="item03">북유럽 패턴 오너먼트</a>
							<a href="/shopping/category_prd.asp?itemid=1391091&amp;pEtr=67489" class="item04">데코 솔방울</a>
							<a href="/shopping/category_prd.asp?itemid=1386175&amp;pEtr=67489" class="item05">세라믹 사슴뿔 오너먼트</a>
						</div>
					<% end if %>
				</div>
			</div>
		</div>
		<%''// 참여이벤트 #2 %>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->