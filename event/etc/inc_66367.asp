<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#########################################################
' Description :  2015 텐바이텐X 그랜드 민트 페스티벌 2015
' History : 2015.09.22 원승현 생성
'#########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->

<%
dim currenttime
	currenttime =  now()
	'currenttime = #04/22/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64895
Else
	eCode   =  66367
End If

dim userid, commentcount, i
	userid = getEncloginuserid()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm, ename, emimg, blnitempriceyn, ecc
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	ecc	= requestCheckVar(Request("ecc"),10)	

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
end If

'// 이벤트 정보 가져옴

dim cEvent
	set cEvent = new ClsEvtCont
	cEvent.FECode = eCode
	cEvent.fnGetEvent
	
	eCode		= cEvent.FECode	
	ename		= cEvent.FEName
	emimg		= cEvent.FEMimg
	blnitempriceyn = cEvent.FItempriceYN	


	set cEvent = Nothing


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
img {vertical-align:top;}
.contF {background:#97f2e6;}
#contentWrap {padding-bottom:0;}
.evt66367 {padding-bottom:110px; background:#97f2e6 url(http://webimage.10x10.co.kr/eventIMG/2015/66367/bg_pattern.png) repeat-y 50% 0; text-align:center;}
.evt66367 .topic {position:relative; height:539px; background:#97f2e6 url(http://webimage.10x10.co.kr/eventIMG/2015/66367/bg_mount.png) no-repeat 50% 0;}
.evt66367 .topic .option {position:absolute; top:25px; left:50%; margin-left:370px; text-align:right;}
.evt66367 .topic h2 {position:absolute; top:95px; left:50%; z-index:10; width:657px; height:360px; margin-left:-328px;}
.evt66367 .topic .deco {position:absolute; top:55px; left:50%; margin-left:-403px;}
.evt66367 .topic .bear1 {position:absolute; bottom:0; left:50%; margin-left:-702px;}
.evt66367 .topic .bear2 {position:absolute; bottom:0; left:50%; margin-left:380px;}

.bounce {-webkit-animation-name:bounce; -webkit-animation-iteration-count:3; -webkit-animation-duration:1s; -moz-animation-name:bounce; -moz-animation-iteration-count:3; -moz-animation-duration:1s; -ms-animation-name:bounce; -ms-animation-iteration-count:5; -ms-animation-duration:1s;}
@-webkit-keyframes bounce {
	from, to{margin-bottom:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-bottom:-7px; -webkit-animation-timing-function:ease-in;}
}
@keyframes bounce {
	from, to{margin-bottom:0; animation-timing-function:ease-out;}
	50% {margin-bottom:-7px; animation-timing-function:ease-in;}
}

@-webkit-keyframes shake {
	0%, 100% {-webkit-transform:translateX(0);}
	10%, 30%, 50%, 70% {-webkit-transform:translateX(-10px);}
	20%, 40%, 60%, 80% {-webkit-transform:translateX(10px);}
}
@keyframes shake {
	0%, 100% {transform:translateX(0);}
	10%, 30%, 50%, 70% {transform:translateX(-10px);}
	20%, 40%, 60%, 80% {transform:translateX(10px);}
}
.shake {-webkit-animation-name:shake; animation-name:shake; -webkit-animation-duration:5s; animation-duration:5s; -webkit-animation-fill-mode:both; animation-fill-mode:both; -webkit-animation-iteration-count:2; animation-iteration-count:2;}

.rollingwrap {overflow:hidden; position:relative;}
.rolling {position:relative; width:1140px; height:655px; margin:0 auto;}
.rolling .swiper {position:absolute; top:0; left:50%; width:7980px; margin-left:-3990px; height:620px;}
.rolling .swiper .swiper-container {overflow:hidden; width:100%; height:713px;}
.rolling .swiper .swiper-wrapper {position:relative; width:100%; height:713px;}
.rolling .swiper .swiper-slide {float:left; width:100%;}
.rolling .swiper .swiper-slide img { vertical-align:top;}
.rolling .pagination {overflow:hidden; position:absolute; bottom:0; left:0; z-index:50; width:100%; text-align:center;}
.rolling .swiper-pagination-switch {display:inline-block; width:10px; height:9px; margin:0 7px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66367/btn_pagination.png) no-repeat -23px 0; cursor:pointer; transition:width 0.5s;}
.rolling .swiper-active-switch {width:56px; background-position:50% 100%;}
.rolling .btn-nav {display:block; position:absolute; top:50%; z-index:50; width:35px; height:64px; margin-top:-32px; background:transparent url(http://webimage.10x10.co.kr/eventIMG/2015/66367/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.rolling .btn-prev {left:28px;}
.rolling .btn-next {right:28px; background-position:100% 0;}
.rolling .story {position:absolute; top:107px; z-index:100; text-align:center;}
.rolling .storyleft {left:102px;}
.rolling .storyright {right:99px;}
.swipemask {position:absolute; top:0; width:1140px; height:620px; z-index:100; background-color:#000; opacity:0.5; filter:alpha(opacity=50);}
.mask-left {left:0; margin-left:-1140px;}
.mask-right {right:0; margin-right:-1140px;}

.itemwrap {position:relative; width:1040px; margin:0 auto; padding:70px 0 90px;}
.itemwrap .item {position:relative;}
.itemwrap .item ul {overflow:hidden; position:absolute; top:10px; left:0; width:1044px;}
.itemwrap .item ul li {float:left; width:251px; height:293px; margin:0 10px 30px 0;}
.itemwrap .item ul li a {display:block; width:100%; height:100%; background-color:#000; opacity:0; text-indent:-999em;}
.itemwrap .noti {margin-top:30px; text-align:left;}

.about {height:599px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66367/bg_green.png) repeat-x 50% 0;}
.about .inner {position:relative; width:368px; margin:0 auto; height:516px; padding-top:83px; padding-left:662px;}
.about .inner .video {position:absolute; top:93px; left:0;}
.about .inner .btnwrap {margin-top:35px;}
.about .inner .btnwrap a:first-child {margin-right:15px;}

.commentevt {height:866px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66367/bg_btm.png) no-repeat 50% 0;}
.commentevt .form {position:relative; padding-top:80px;}
.commentevt .form .cloud {position:absolute; top:84px; left:50%; margin-left:-596px;}
.commentevt .form .field {width:1140px; margin:0 auto;}
.commentevt .form .field ul {overflow:hidden; width:470px; margin:38px auto 0;}
.commentevt .form .field ul li {float:left; padding:0 50px; text-align:center;}
.commentevt .form .field ul li label {display:block; margin-bottom:6px;}
.commentevt .form .field textarea {width:717px; height:49px; margin-top:35px; padding:20px; border:0; background:url(http://webimage.10x10.co.kr/eventIMG/2015/66367/bg_textarea.png) no-repeat 50% 0; font-size:12px; color:#0039a1; text-align:left;}
.commentevt .form .field .btnsubmit {margin-top:35px;}

.commentevt .form .desc {width:1017px; margin:20px auto 0; text-align:center;}
.commentevt .form .desc ul {margin-top:25px; text-align:left;}

.noti li {margin-top:3px; color:#757575; font-size:11px;}

.commentlist {overflow:hidden; width:1044px; margin:70px auto 0;}
.commentlist .col {float:left; width:241px; height:211px; margin:0 10px 30px; padding-top:30px; background-repeat:no-repeat; background-position:50% 0; font-size:11px;}
.commentlist .col .no {display:block; width:104px; height:31px; margin:0 auto 24px; font-size:12px; line-height:31px; text-align:center;}
.commentlist .col .id, .commentlist .col .date {display:block; font-size:11px; font-weight:bold;}
.commentlist .col .id {margin-top:15px; color:#004b15; text-decoration:underline;}
.commentlist .col .msg {padding:0 24px; color:#000; font-size:11px; line-height:1.8em;}
.commentlist .col button {width:37px; height:16px; background-color:transparent;}
.commentlist .col1 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66367/bg_commnet_01.png);}
.commentlist .col1 .no {color:#fff;}
.commentlist .col1 .date {color:#0567a6;}
.commentlist .col2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/66367/bg_commnet_02.png);}
.commentlist .col2 .no {color:#a3f44d;}
.commentlist .col2 .date {color:#007f24;}

.bubble {-webkit-animation-name:bubble; -webkit-animation-duration:5s; -webkit-animation-timing-function:ease-in-out; -webkit-animation-delay:-1s;-webkit-animation-iteration-count:infinite; -webkit-animation-direction:alternate; -webkit-animation-play-state:running; animation-name:bubble; animation-duration:5s; animation-timing-function:ease-in-out; animation-delay:-1s; animation-iteration-count:infinite; animation-direction:alternate; animation-play-state:running}
@-webkit-keyframes bubble {
	0% {margin-top:-40px}
	100%{margin-top:40px}
}
@keyframes bubble{
	0%{margin-top:-40px}
	100%{margin-top:40px}
}

/* tiny scrollbar */
.scrollbarwrap {width:180px; margin:0 auto;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:177px; height:75px; padding-bottom:3px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:3px; background-color:#f1f1f1;}
.scrollbarwrap.track {position: relative; width:3px; height:100%; background-color:#f1f1f1;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#3f3f3f; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
.noSelect {user-select:none; -o-user-select:none; -moz-user-select:none; -khtml-user-select:none; -webkit-user-select:none;}

.col1 .scrollbarwrap .scrollbar, .col1 .scrollbarwrap.track {background-color:#0e79bd;}
.col1 .scrollbarwrap .thumb {background-color:#61dfff;}
.col2 .scrollbarwrap .scrollbar, .col1 .scrollbarwrap.track {background-color:#007120;}
.col2 .scrollbarwrap .thumb {background-color:#8be347;}

.pageWrapV15 {margin-top:40px;}
.pageWrapV15 .pageMove {display:none;}
.paging a.arrow, .paging a, .paging a.current {background-color:transparent;}
</style>
<script type="text/javascript">
<% if Request("iCC") <> "" or request("ecc") <> "" then %>
	$(function(){
		var val = $('.commentlistwrap').offset();
		window.$('html,body').animate({scrollTop:$(".commentlistwrap").offset().top-100}, 10);
	});
<% end if %>

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}


function jsSubmitComment(frm){      //코멘트 입력
	<% If IsUserLoginOK() Then %>
		<% If Now() > #10/07/2015 23:59:59# Then %>
			alert("이벤트가 종료되었습니다.");
			return;
		<% Else %>
			<% If left(now(), 10)>="2015-09-22" and left(now(), 10) < "2015-10-08" Then %>
				<% if commentcount >= 5 then %>
					alert("이벤트는 총 5회까지만 응모하실 수 있습니다.\n10월 8일(목) 당첨자 발표를 기다려 주세요!");
					return;				
				<% else %>
					var tmpdateval='';
					for (var i=0; i < frm.dateval.length; i++){
						if (frm.dateval[i].checked){
							tmpdateval = frm.dateval[i].value;
						}
					}
					if (tmpdateval==''){
						alert('원하시는 관람날짜를 선택해 주세요.');
						return false;
					}
					if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 600 || frm.txtcomm1.value == '가장 기대되는 아티스트와 페스티벌에 대한 기대평을 남겨주세요.'){
						alert("가장 기대되는 아티스트와 페스티벌에 대한\n기대평을 남겨주세요. 600자 까지 작성 가능합니다.");
						frm.txtcomm1.focus();
						return false;
					}
				   frm.txtcomm.value = tmpdateval + "|!/" +frm.txtcomm1.value
				   frm.action = "/event/lib/comment_process.asp";
				   frm.submit();
				<% end if %>
			<% else %>
				alert("이벤트 응모 기간이 아닙니다.");
				return;
			<% end if %>				
		<% End If %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return;
		}
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
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	}

	if (frmcom.txtcomm1.value == '가장 기대되는 아티스트와 페스티벌에 대한 기대평을 남겨주세요.'){
		frmcom.txtcomm1.value = '';
	}
}


//내코멘트 보기
function fnMyComment() {
	document.frmcom.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
	document.frmcom.iCC.value=1;
	document.frmcom.submit();
}

<%
	dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
	snpTitle = Server.URLEncode(ename)
	snpLink = Server.URLEncode("http://www.10x10.co.kr/event/" & ecode)
	snpPre = Server.URLEncode("텐바이텐 이벤트")
	snpTag = Server.URLEncode("텐바이텐 " & Replace(ename," ",""))
	snpTag2 = Server.URLEncode("#10x10")
%>

// sns카운팅
function getsnscnt(snsno) {
	var str = $.ajax({
		type: "GET",
		url: "/event/etc/doEventSubscript66367.asp",
		data: "mode=snscnt&snsno="+snsno,
		dataType: "text",
		async: false
	}).responseText;
	if(str=="tw") {
		popSNSPost('tw','<%=snpTitle%>','<%=snpLink%>','<%=snpPre%>','<%=snpTag2%>');
	}else if(str=="fb"){
		popSNSPost('fb','<%=snpTitle%>','<%=snpLink%>','','');
	}else{
		alert('오류가 발생했습니다.');
		return false;
	}
}

</script>


<!-- GMF -->
<div class="evt66367">
	<div class="topic">
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/tit_gmf.png" alt="가을날 음악 피크닉, 반가운 우리들의 만남!" /></h2>
		<div id="option" class="option">
			<a href="#commentevt"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/btn_commnet.png" alt="코멘트 남기러 가기" /></a>
			<strong><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/ico_only.png" alt="오직 텐바이텐에서만" /></strong>
		</div>
		<div class="deco bubble"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_deco.png" alt="" /></div>
		<div class="bear1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_bear_01.png" alt="" /></div>
		<div class="bear2"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_bear_02.png" alt="" /></div>
	</div>

	<%' rolling %>
	<div class="rollingwrap">
		<div class="rolling">
			<div class="swiper">
				<div class="swiper-container swiper1">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_slide_01.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_slide_02.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_slide_03.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_slide_04.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_slide_05.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_slide_06.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_slide_07.jpg" alt="" /></div>
					</div>
				</div>
			</div>
			<div class="pagination"></div>
			<button type="button" class="btn-nav btn-prev">Previous</button>
			<button type="button" class="btn-nav btn-next">Next</button>
			<div class="swipemask mask-left"></div>
			<div class="swipemask mask-right"></div>
		</div>
	</div>

	<%' item %>
	<div class="itemwrap">
		<div class="item">
			<ul>
				<li><a href="/shopping/category_prd.asp?itemid=1339100">반팔 티셔츠</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1339101">피크닉 매트</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1339102">에코백</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1339103">미니 사이드 백</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1339107">핀버튼</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1339106">타투 스티커</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1339105">패브릭 팔찌</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1339104">투명 텀블러</a></li>
			</ul>
			<img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_item_v2.png" alt="" />
		</div>
		<ul class="noti">
			<li>* 공식 굿즈는 한정수량이므로 조기소진될 수 있습니다.</li>
			<li>* 온라인에서 판매가 중단되더라도 페스티벌 현장에서 소량 판매가 됩니다.</li>
			<li>* 판매가격은 각 상품별 1개에 해당하는 금액입니다. (옵션 선택)</li>
		</ul>
	</div>

	<div class="about">
		<div class="inner">
			<div class="video">
				<iframe src="https://www.youtube.com/embed/ia_5Y2OWTAI" width="609" height="442" frameborder="0" title="grand mint festival 2015" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
			</div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/txt_about.png" alt="올해로 아홉 번째 해를 맞는 그랜드 민트 페스티벌! GMF2015의 키워드는 익숙함과 새로움 사이의 도전과 확장입니다. 도시적인 세련됨과 청량함의 여유, 가을에 만나는 음악 피크닉, 환경과 사람 사이의 조화, 아티스트에 대한 존중, 비슷한 주파수의 취향들, 그리고 민트 페이퍼의 1년 결산이자 대잔치 계절의 남은 온기와 색깔까지 배경이 되는 이틀간의 현상, 그랜드 민트 페스티벌 2015" /></p>
			<div class="btnwrap">
				<a href="https://www.mintpaper.co.kr/2015/09/hotline-gmf2015-lineup-final/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/btn_line_up.png" alt="GMF2015 라인업 보기" /></a>
				<a href="https://www.mintpaper.co.kr/festival_gmf/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/btn_homepage.png" alt=" GMF2015 공식 홈페이지 가기" /></a>
			</div>
		</div>
	</div>

	<%' form %>
	<div id="commentevt" class="commentevt">
		<div class="form">
			<div class="cloud"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/img_cloud.png" alt="" /></div>
			<%' for dev msg : 폼 %>
			<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
			<input type="hidden" name="eventid" value="<%=eCode%>">
			<input type="hidden" name="com_egC" value="<%=com_egCode%>">
			<input type="hidden" name="bidx" value="<%=bidx%>">
			<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
			<input type="hidden" name="iCTot" value="">
			<input type="hidden" name="mode" value="add">
			<input type="hidden" name="spoint" value="0">
			<input type="hidden" name="isMC" value="<%=isMyComm%>">
			<input type="hidden" name="txtcomm">
			<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
			<% Else %>
				<input type="hidden" name="hookcode" value="&ecc=1">
			<% End If %>
				<div class="field">
					<fieldset>
					<legend>그랜드 민트 페스티벌 기대평 남기고 티켓 응모하기</legend>
						<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/txt_comment.png" alt="텐바이텐의 오랜 친구, 그랜드 민트 페스티벌! 이번 GMF2015에서 가장 기대되는 아티스트와 페스티벌에 대한 기대평을 남겨주세요. 정성껏 코멘트를 남겨주신 20분을 추첨을 통해 페스티벌 1일권 티켓 1인 1매를 선물로 드립니다." /></p>
						<ul>
							<li>
								<label for="date01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/txt_label_date_01.png" alt="2015년 10월 17일 토요일" /></label>
								<input type="radio" id="date01" name="dateval" value="1" />
							</li>
							<li>
								<label for="date02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/txt_label_date_02.png" alt="2015년 10월 18일 일요일" /></label>
								<input type="radio" id="date02" name="dateval" value="2" />
							</li>
						</ul>
						<textarea title="가장 기대되는 아티스트와 페스티벌에 대한 기대평을 남겨주세요." cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>가장 기대되는 아티스트와 페스티벌에 대한 기대평을 남겨주세요.<%END IF%></textarea>
						<input type="image" src="http://webimage.10x10.co.kr/eventIMG/2015/66367/btn_submit.png" alt="응모하기" class="btnsubmit" onclick="jsSubmitComment(frmcom); return false;" />
					</fieldset>
				</div>
			</form>

			<div class="desc">
				<p>
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/txt_sns.png" alt="친구에게도 텐바이텐과 GMF2015의 만남을 알려주세요! 당첨 확률이 UP! UP!" usemap="#snslink" />
					<!-- for dev msg : sns -->
					<map name="snslink" id="snslink">
						<area shape="circle" coords="744,26,15" href="" onclick="getsnscnt('fb'); return false;" alt="페이스북" />
						<area shape="circle" coords="780,26,16" href="" onclick="getsnscnt('tw'); return false;" alt="트위터" />
					</map>
				</p>
				<ul class="noti">
					<li>* 코멘트 이벤트는 2015년 10월 7일 수요일에 종료, 10월 8일 목요일에 당첨자를 발표합니다.</li>
					<li>* 비방성 댓글 및 타인의 댓글을 그대로 옮겨쓴 댓글은 통보없이 자동삭제 됩니다.</li>
					<li>* 당첨자 1명에게는 1매의 티켓이 제공되며, 발표 후 개인정보를 요청하게 될 수 있습니다.</li>
					<li>* 초대권의 양도 및 재판매는 불가하며, 확인 시 취소조치됩니다.</li>
				</ul>
			</div>
		</div>
	</div>

	<%' comment list %>
	<% IF isArray(arrCList) THEN %>
		<div class="commentlistwrap">
			<div class="commentlist">
				<%' for dev msg : <div class="col">...</div>이 한 묶음입니다. 토요일, 일요일 선택에 따라 배경 넣어주세요 col1 ~ col2 %>
				<%' for dev msg : 한페이지당 8개 %>
				<%
					dim rndNo : rndNo = 1
					
					For intCLoop = 0 To UBound(arrCList,2)

					
					if isarray(split(arrCList(1,intCLoop),"|!/")) Then
						if ubound(split(arrCList(1,intCLoop),"|!/")) > 0 then
							rndNo = ReplaceBracket(db2html( split(arrCList(1,intCLoop),"|!/")(0) ))
						End If
					End If

				%>
					<div class="col col<%=rndNo%>">
						<strong class="no"><%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%>번째 설렘</strong>
						<div class="scrollbarwrap">
							<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
							<div class="viewport">
								<div class="overview">
									<%' for dev msg : 기대평 부분 요기에 넣어주세요 %>
									<p class="msg">
										<% if isarray(split(arrCList(1,intCLoop),"|!/")) then %>
											<% if ubound(split(arrCList(1,intCLoop),"|!/")) > 0 then %>
												<%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"|!/")(1) ))%>
											<% end if %>
										<% end if %>
									</p>
								</div>
							</div>
						</div>
						<span class="id">
							<%=printUserId(arrCList(2,intCLoop),2,"*")%>
						</span>
						<span class="date"><%=Mid(arrCList(4,intCLoop), 6, 2)&"."&Mid(arrCList(4,intCLoop), 9, 2)%></span>
						<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
							<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/66367/btn_del.png" alt="삭제" /></button>
						<% End If %>
					</div>
				<% next %>				
			</div>

			<!-- paging -->
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
		</div>
	<% end if %>

</div>
<!-- //GMF -->
<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="com_egC" value="<%=com_egCode%>">
	<input type="hidden" name="bidx" value="<%=bidx%>">
	<input type="hidden" name="Cidx" value="">
	<input type="hidden" name="mode" value="del">
	<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>">
	<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
	<% Else %>
		<input type="hidden" name="hookcode" value="&ecc=1">
	<% End If %>
</form>

<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
});

$(function(){
	/* swipe */
	var mySwiper = new Swiper('.swiper1',{
		centeredSlides:true,
		slidesPerView:7,
		//initialSlide:0,
		loop: true,
		speed:2000,
		autoplay:5000,
		simulateTouch:false,
		pagination:'.pagination',
		paginationClickable:true
	})
	$('.btn-prev').on('click', function(e){
		e.preventDefault()
		mySwiper.swipePrev()
	})
	$('.btn-next').on('click', function(e){
		e.preventDefault()
		mySwiper.swipeNext()
	});

	$("#option a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top},1500);
	});

	// Label Select
	$(".field ul li label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});

	animation();
	$(".topic .bear2").css({"opacity":"0"});
	$(".topic .deco").css({"opacity":"0"});
	function animation () {
		$(".topic .bear1").delay(100).addClass("bounce");
		$(".topic .bear2").delay(1000).addClass("shake").animate({"opacity":"1"},1000);
		$(".topic .deco").delay(1900).addClass("bubble").animate({"opacity":"1"},1000);
	}
});
</script>
<iframe id="evtFrmProc" name="evtFrmProc" src="about:blank" frameborder="0" width=0 height=0></iframe>
<!-- #include virtual="/lib/db/dbclose.asp" -->