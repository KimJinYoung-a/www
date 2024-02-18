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
' Description : PLAYing 인스타그램 / 감성사진 찍는 방법
' History : 2018-04-12 이종화 생성
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
.thingVol039 {position:relative; text-align:center;}
.thingVol039 .inner {position:relative; width:1140px; margin:0 auto;}
.thingVol039 button {background-color:transparent;}
.topic {position:relative; height:1193px; background:#cdb29e url(http://webimage.10x10.co.kr/playing/thing/vol039/bg_tit.jpg) no-repeat 50%0;}
.topic .inner {width:100%; height:847px; background:url(http://webimage.10x10.co.kr/playing/thing/vol039/bg_topic.jpg) 50% 0 no-repeat; z-index:3;}
.topic .label {overflow:hidden; position:absolute; left:50%; top:145px; margin-left:-114px;}
.topic .label img {margin-left:-218px; transition:all 1s .2s;}
.topic h2 {padding-top:250px; opacity:0; transition:all 1s .6s;}
.topic .sub-copy {margin-top:100px; opacity:0; transition:all 1.5s .8s;}
.topic.animation .label img {margin-left:0;}
.topic.animation h2 {padding-top:215px; opacity:1;}
.topic.animation .sub-copy {margin-top:47px; opacity:1;}
.insta-nav {background:#f8e9ce url(http://webimage.10x10.co.kr/playing/thing/vol039/bg_nav.jpg) no-repeat 50% 0;}
.insta-nav ul {overflow:hidden; width:1140px; padding:133px 0 165px; margin:0 auto; }
.insta-nav ul li {float:left; position:relative; margin:0 10px;}
.insta-nav ul li a > img {margin:49px 0 0 10px;}
.insta-nav ul li:first-child a > img {margin:46px 0 0 11px;}
.insta-nav ul li a span {display:none; position:absolute; top:0; left:0;}
.insta-nav ul li a:hover span {display:block;}
.section {padding:130px;}
.section {padding:130px 0; background:#e8ac99 url(http://webimage.10x10.co.kr/playing/thing/vol039/bg_section1.jpg) no-repeat 50% 0;}
.section2 {background-color:#f6dbad; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol039/bg_section2.jpg);}
.section3 {background-color:#aad4c1; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol039/bg_section3.jpg);}
.section4 {background-color:#a7d9e4; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol039/bg_section4.jpg);}
.section .more {display:inline-block; position:absolute; bottom:40px; width:185px; height:70px; text-indent:-999em;}
.section.typeA .more {right:30px;}
.section.typeA .insta-slide {left:30px;}
.section.typeB .more {left:40px;}
.section.typeB .insta-slide {right:30px;}
.section .inner {position:relative;}
.section .insta-slide {overflow:visible; position:absolute; top:65px; width:521px; height:520px;}
.section .insta-slide .swiper-wrapper,
.section .insta-slide .slidesjs-container,
.section .insta-slide .slidesjs-control,
.section .insta-slide .swiper-slide {width:521px !important; height:520px !important; padding-bottom:48px;}
.slideTemplateV15 .slidesjs-pagination {bottom:8px; height:11px;}
.slideTemplateV15 .slidesjs-pagination li a {width:10px; height:10px; margin:0 4px; background-color:#c1c1c1; background-image:none; border-radius:50%;}
.slideTemplateV15 .slidesjs-pagination li a.active {background-color:#3f85df;}
.more-item {padding:174px 0 140px; background:#f3eee9 url(http://webimage.10x10.co.kr/playing/thing/vol039/bg_section5.jpg)no-repeat 50% 0;}
.more-item p {margin-bottom:40px;}
.more-item a {display:inline-block; animation:shake 4s 50; animation-fill-mode:both;}
.cmt-evt {padding:100px 0; background-color:#d6cff3;}
.cmt-evt h3 {padding-bottom:60px;}
.search-input {position:relative; width:649px; height:60px; padding:14px 50px 16px; margin:0 auto; background:url(http://webimage.10x10.co.kr/playing/thing/vol039/bg_input.png) no-repeat 50% 50%; text-align:left;}
.search-input input {width:470px; height:62px; font-size:30px; text-align:center;}
.search-input input::placeholder {color:#e0e0e0;}
.search-input button {position:absolute; right:0; top:0; width:200px; height:90px; background-color:transparent;}
.cmt {width:914px; margin:0 auto; padding-top:65px;}
.cmt ul {overflow:hidden;}
.cmt li {position:relative; float:left; padding:15px;}
.cmt li div {position:relative; display:table; width:427px; height:82px; background-color:#f2f2f2;}
.cmt li div span {display:table-cell; vertical-align:middle;}
.cmt li div span.num {width:50px; padding-left:20px; padding-right:26px; font-size:14px; color:#000; text-align:left; font-weight:bold;}
.cmt li div span.question {padding-left:0; font-size:18px; color:#000; text-align:left; font-weight:300; letter-spacing:-0.2px; font-family:'돋움', sans-serif; font-weight:bold;}
.cmt li div span.writer {padding-right:20px; font-size:14px; color:#4e30e4; text-align:right;}
.cmt li button {position:absolute; right:9px; top:9px;}
.pageWrapV15 {margin-top:60px;}
.pageWrapV15 .pageMove,.paging .first, .paging .end {display:none;}
.paging {height:29px;}
.paging a {width:44px; height:29px; margin:0; border:0;}
.paging a span {height:29px; padding:0; color:#fff; font:bold 14px/29px verdana;}
.paging a.current span {color:#3511ed; background:#fff;}
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
<script type="text/javascript">
$(function(){
	$(".topic").addClass("animation");

	$('.section1 .swiper-wrapper').slidesjs({
		width:930,
		height:575,
		pagination:{effect:'fade'},
		navigation:false,
		play:{interval:2500, effect:'fade', auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		}
	});

	$('.section2 .swiper-wrapper').slidesjs({
		width:930,
		height:575,
		pagination:{effect:'fade'},
		navigation:false,
		play:{interval:3000, effect:'fade', auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		}
	});

	$('.section3 .swiper-wrapper').slidesjs({
		width:930,
		height:575,
		pagination:{effect:'fade'},
		navigation:false,
		play:{interval:3000, effect:'fade', auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		}
	});

	$('.section4 .swiper-wrapper').slidesjs({
		width:930,
		height:575,
		pagination:{effect:'fade'},
		navigation:false,
		play:{interval:3000, effect:'fade', auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		}
	});

});

$(function(){
	<% if pagereload<>"" then %>
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$(".cmt-evt").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if date() <= "2018-04-23" then %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if(!frm.txtcomm.value){
					alert("다음 주제, 무엇이 궁금하신가요?");
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
<div class="thingVol039">
	<div class="topic">
		<div class="inner">
			<h2><img src="http://webimage.10x10.co.kr/playing/thing/vol039/tit_stagram.png" alt="인스타그램그램 감성사진 찍는 방법" /></h2>
			<p class="label"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/txt_label.png" alt="장바구니 탐구생활" /></p>
			<p class="sub-copy"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/txt_intro.png" alt="같은 사물, 다른 느낌! 피드에 올라오는 사진들을 보면 그 사람의 감각을 볼 수 있곤 하죠. 여러분의 피드는 어떤가요? SNS에서 핫한 텐바이텐 직원들에게 감각있는 사진 꿀 팁을 알아보았습니다. " /></p>
		</div>
	</div>

	<div class="insta-nav">
		<ul>
			<li><a href="#insta1"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_nav_1.png" alt="#일상스타그램" /><span><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_nav_1_on.png" alt="" /></span></a></li>
			<li><a href="#insta2"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_nav_2.png" alt="#음식스타그램" /><span><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_nav_2_on.png" alt="" /></span></a></li>
			<li><a href="#insta3"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_nav_3.png" alt="#패션스타그램" /><span><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_nav_3_on.png" alt="" /></span></a></li>
			<li><a href="#insta4"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_nav_4.png" alt="#여행스타그램" /><span><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_nav_4_on.png" alt="" /></span></a></li>
		</ul>
	</div>

	<div class="section section1 typeA" id="insta1">
		<div class="inner">
			<img src="http://webimage.10x10.co.kr/playing/thing/vol039/txt_insta_1.png" alt="#일상스타그램" />
			<div class="slideTemplateV15 insta-slide">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide1_1.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide1_2.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide1_3.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide1_4.jpg" alt="" /></div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
			<a href="/event/eventmain.asp?eventid=85823.asp#groupBar1" class="more">추천소품 보러가기</a>
		</div>
	</div>

	<div class="section section2 typeB" id="insta2">
		<div class="inner">
			<img src="http://webimage.10x10.co.kr/playing/thing/vol039/txt_insta_2.png" alt="#음식스타그램" />
			<div class="slideTemplateV15 insta-slide">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide2_1.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide2_2.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide2_3.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide2_4.jpg" alt="" /></div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
			<a href="/event/eventmain.asp?eventid=85823.asp#groupBar2" class="more">추천소품 보러가기</a>
		</div>
	</div>

	<div class="section section3 typeA" id="insta3">
		<div class="inner">
			<img src="http://webimage.10x10.co.kr/playing/thing/vol039/txt_insta_3.png" alt="#패션스타그램" />
			<div class="slideTemplateV15 insta-slide">
				<div class="swiper-wrapper">
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide3_1.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide3_2.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide3_3.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide3_4.jpg" alt="" /></div>
				</div>
				<div class="pagination"></div>
			</div>
			<a href="/event/eventmain.asp?eventid=85823.asp#groupBar3" class="more">추천소품 보러가기</a>
		</div>
	</div>

	<div class="section section4 typeB" id="insta4">
		<div class="inner">
			<img src="http://webimage.10x10.co.kr/playing/thing/vol039/txt_insta_4.png" alt="#여행스타그램" />
			<div class="slideTemplateV15 insta-slide">
				<div class="swiper-container">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide4_1.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide4_2.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide4_3.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/img_slide4_4.jpg" alt="" /></div>
					</div>
					<div class="pagination"></div>
				</div>
			</div>
			<a href="/event/eventmain.asp?eventid=85823.asp#groupBar4" class="more">추천소품 보러가기</a>
		</div>
	</div>

	<div class="more-item">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol039/txt_more_item.png" alt="인스타그램 감성 사진 찍는 방법과 소품을 통해 여러분의 피드를 더 느낌 있게 꾸미세요!" /></p>
		<a href="/event/eventmain.asp?eventid=85823"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/btn_more_item.png" alt="감성스타그램을 꾸며줄 소품 보기" /></a>
	</div>

	<%'!-- 코멘트이벤트 --%>
	<div class="cmt-evt">
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
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol039/txt_event.png" alt="다음 주제, 무엇이 궁금하신가요?" /></h3>
		<div class="search-input">
			<span><input type="text" id="txtcomm" name="txtcomm" placeholder="10자 이내로 입력" onClick="jsCheckLimit();" maxlength="10"/></span>
			<span><button type="button" onclick="jsSubmitComment(document.frmcom);return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol039/btn_submit.png" alt="주제 요청" /></button></span>
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
		<div class="cmt">
			<ul>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
				<li>
					<div>
						<span class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
						<span class="question"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></span>
						<span class="writer"><%=printUserId(arrCList(2,intCLoop),4,"*")%>님</span>
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
	<%'!--// 코멘트이벤트 --%>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->