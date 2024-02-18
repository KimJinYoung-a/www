<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
'########################################################
' 그랜드 민트 페스티벌 2016 공식MDx텐바이텐 사전판매
' 2016-10-04 원승현 작성
'########################################################

dim currenttime
	currenttime =  now()
	'currenttime = #04/22/2015 09:00:00#

Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66211
Else
	eCode   =  73230
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
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
img {vertical-align:top;}
#contentWrap {padding-bottom:0;}
.evt73230 {padding-bottom:110px; background:#ffd545; text-align:center;}
.evt73230 .topic {overflow:hidden; position:relative; height:556px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73230/bg_title.png) no-repeat 50% 0;}
.evt73230 .topic .option {position:absolute; top:-50px; left:50%; margin-left:427px; text-align:right;}
.evt73230 .topic .ribbon {position:absolute; left:50%; top:97px; width:100%; margin-left:-50%;}
.evt73230 .topic .ribbon p {position:relative; z-index:1;}
.evt73230 .topic .ribbon span {display:block; position:absolute; left:50%; top:0; width:55px; height:39px; background-repeat:no-repeat; z-index:0;}
.evt73230 .topic .ribbon span.rbLt {margin-left:-215px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73230/tit_gmf_ribbon_lt.png); background-position:0 0; animation:increase 1.1s 0.8s 1; transform-origin:100% 50%; -webkit-animation:increase 1.1s 0.8s 1; -webkit-transform-origin:100% 50%;}
.evt73230 .topic .ribbon span.rbRt {margin-left:159px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73230/tit_gmf_ribbon_rt.png); background-position:100% 0; animation:increase 1.1s 0.8s 1; transform-origin:0 50%; -webkit-animation:increase 1.1s 0.8s 1; -webkit-transform-origin:0 50%;}
.evt73230 .topic h2 {position:absolute; top:195px; left:50%; z-index:10; width:865px; height:378px; margin-left:-432px;}
.evt73230 .topic .deco1 {position:absolute; top:254px; left:50%; margin-left:-533px;}
.evt73230 .topic .deco2 {position:absolute; top:160px; left:50%; margin-left:490px;}
.evt73230 .topic .leaf1 {position:absolute; top:267px; left:50%; margin-left:-460px; z-index:11; animation:leaf 5s ease-in-out 0s 7; transform-origin:100% 40%; -webkit-animation:leaf 5s ease-in-out 0s 7; -webkit-transform-origin:100% 40%;}
.evt73230 .topic .leaf2 {position:absolute; top:325px; left:50%; margin-left:20px; z-index:11; animation:leaf 4s ease-in-out 0s 7; transform-origin:0 100%; -webkit-animation:leaf 4s ease-in-out 0s 7; -webkit-transform-origin:0% 100%;}
.evt73230 .topic .leaf3 {position:absolute; top:270px; left:50%; margin-left:320px; z-index:11; animation:leaf 3s ease-in-out 0s 7; transform-origin:0 0; -webkit-animation:leaf 3s ease-in-out 0s 7; -webkit-transform-origin:0 0;}
.evt73230 .topic .wheel1 {position:absolute; top:208px; left:50%; margin-left:-437px; animation:rotatation 3s ease-in-out 0s infinite; -webkit-animation:rotatation 3s ease-in-out 0s infinite;}
.evt73230 .topic .wheel2 {position:absolute; top:173px; left:50%; margin-left:321px; animation:rotatation 4s ease-in-out 0s infinite; -webkit-animation:rotatation 4s ease-in-out 0s infinite;}

.drop {-webkit-animation-name:drop; -webkit-animation-duration:0.7s; -webkit-animation-timing-function:ease-in-out; -webkit-animation-delay:0;-webkit-animation-iteration-count:1; animation-name:drop; animation-duration:0.7s; animation-timing-function:ease-in-out; animation-delay:0; animation-iteration-count:1;}
@-webkit-keyframes drop {
	0% {margin-top:-110px; opacity:0;}
	100%{margin-top:0; opacity:1;}
}
@keyframes drop {
	0%{margin-top:-110px; opacity:0;}
	100%{margin-top:0; opacity:1;}
}
@-webkit-keyframes increase {
	0%, 100% {transform:scaleX(1); animation-timing-function:ease-out;}
	30% {transform:scaleX(1.2); animation-timing-function:ease-in;}
	70% {transform:scaleX(0.9); animation-timing-function:ease-out;}
	85% {transform:scaleX(1.1); animation-timing-function:ease-in;}
}
@keyframes increase{
	0%, 100% {transform:scaleX(1); animation-timing-function:ease-out;}
	30% {transform:scaleX(1.2); animation-timing-function:ease-in;}
	70% {transform:scaleX(0.9); animation-timing-function:ease-out;}
	85% {transform:scaleX(1.1); animation-timing-function:ease-in;}
}

.bounce {animation:bounce 1.5s 10; -webkit-animation:bounce 1.5s 10;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:5px; -webkit-animation-timing-function:ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:5px; animation-timing-function:ease-in;}
}

@-webkit-keyframes leaf {
	0% {-webkit-transform:rotate(0);}
	50% {-webkit-transform:rotate(-6deg);}
	100% {-webkit-transform:rotate(0);}
}
@keyframes leaf {
	0% {transform:rotate(0);}
	50% {transform:rotate(-6deg);}
	100% {transform:rotate(0);}
}
@-webkit-keyframes rotatation {
	0% {-webkit-transform:rotate(0);}
	50% {-webkit-transform:rotate(-200deg);}
	100% {-webkit-transform:rotate(0);}
}
@keyframes rotatation {
	0% {transform:rotate(0);}
	50% {transform:rotate(-200deg);}
	100% {transform:rotate(0);}
}

.rollingwrap {overflow:hidden; position:relative; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73230/bg_slide.png) repeat-x 100% 100%; z-index:10;}
.rolling {position:relative; width:1140px; height:681px; margin:0 auto;}
.rolling .swiper {position:absolute; top:0; left:50%; width:7980px; margin-left:-3990px; height:620px;}
.rolling .swiper .swiper-container {overflow:hidden; width:100%; height:713px;}
.rolling .swiper .swiper-wrapper {position:relative; width:100%; height:713px;}
.rolling .swiper .swiper-slide {float:left; width:100%;}
.rolling .swiper .swiper-slide img { vertical-align:top;}
.rolling .pagination {overflow:hidden; position:absolute; bottom:27px; left:0; z-index:50; width:100%; height:14px; text-align:center;}
.rolling .swiper-pagination-switch {display:inline-block; width:14px; height:14px; margin:0 8px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73230/btn_slide_paging.png) no-repeat 100% 0; cursor:pointer;}
.rolling .swiper-active-switch {background-position:0 0;}
.rolling .btn-nav {display:block; position:absolute; top:50%; z-index:50; width:59px; height:87px; margin-top:-43px; text-indent:-999em; background-color:transparent;}
.rolling .btn-prev {left:-1px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73230/btn_slide_prev.png);}
.rolling .btn-next {right:-1px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73230/btn_slide_next.png);}
.rolling .story {position:absolute; top:107px; z-index:100; text-align:center;}
.rolling .storyleft {left:102px;}
.rolling .storyright {right:99px;}
.swipemask {position:absolute; top:0; width:1140px; height:620px; z-index:100; background-color:#000; opacity:0.5; filter:alpha(opacity=50);}
.mask-left {left:0; margin-left:-1140px;}
.mask-right {right:0; margin-right:-1140px;}

.itemwrap {position:relative; width:1140px; margin:-18px auto 0 auto;}
.itemwrap .item {position:relative;}
.itemwrap .item ul {overflow:hidden; position:absolute; top:100px; left:50px; width:1044px;}
.itemwrap .item ul li {float:left; width:310px; height:380px; margin:0 10px 10px 0;}
.itemwrap .item ul li a {display:block; width:100%; height:100%; background-color:rgba(0,0,0,0); text-indent:-999em;}
.itemwrap .noti {position:absolute; right:10px; bottom:-70px;}
.itemwrap .leaf4 {position:absolute; top:-5px; left:-15px; animation:leaf 7s ease-in-out 0s 5; transform-origin:0 0; -webkit-animation:leaf 7s ease-in-out 0s 5; -webkit-transform-origin:0 0;}
.itemwrap .leaf5 {position:absolute; top:150px; left:-25px;}

.about {height:512px; background-color:#2ea05a;}
.about .inner {position:relative; width:478px; margin:0 auto; height:516px; padding-top:83px; padding-left:662px; text-align:left;}
.about .inner .video {position:absolute; top:93px; left:30px; padding:0 11px 11px 0; background:url(http://webimage.10x10.co.kr/eventIMG/2016/73230/bg_vod.png) no-repeat 0 0;}
.about .inner .btnwrap {position:absolute; left:957px; top:236px; width:154px;}
.about .inner .btnwrap a {display:block; margin-bottom:5px; animation:leaf 5s ease-in-out 0s infinite; transform-origin:0 70%; -webkit-animation:leaf 5s ease-in-out 0s infinite; -webkit-transform-origin:0 70%;}
.about .inner .btnwrap a:first-child {animation:leaf 7s ease-in-out 0s infinite; transform-origin:0 70%; -webkit-animation:leaf 7s ease-in-out 0s infinite; -webkit-transform-origin:0 70%;}

.cmtArea {position:relative; height:504px; padding-top:134px; background:#ffd545 url(http://webimage.10x10.co.kr/eventIMG/2016/73230/bg_cmt_tit.png) no-repeat 50% 0;}
.cmtArea .cmtInput {overflow:hidden; width:1020px; height:79px; margin:69px auto 40px auto;}
.cmtArea .cmtInput .inputBox {float:left; width:761px; height:79px; background:#fff url(http://webimage.10x10.co.kr/eventIMG/2016/73230/bg_cmt_input.png) no-repeat 0 50%; text-align:right;}
.cmtArea .cmtInput .inputBox textarea {width:720px; height:69px; padding:5px; font-size:12px; border:none;}
.cmtArea .cmtInput button {background-color:transparent; outline:none;}
.cmtArea ul {width:1020px; margin:0 auto;}
.cmtArea li {padding:2px; font-size:11px; color:#756220; text-align:left;}
.cmtArea span, .cmtArea i {display:block; position:absolute;}
.cmtArea .deco1 {left:50%; top:219px; margin-left:-471px;}
.cmtArea .deco2 {left:50%; top:149px; margin-left:301px;}
.cmtArea .deco3 {left:50%; top:295px; margin-left:-352px; animation:rotatation 2s ease-in-out 0s infinite; -webkit-animation:rotatation 2s ease-in-out 0s infinite;}
.cmtArea .deco4 {left:50%; top:192px; margin-left:491px; animation:rotatation 3s ease-in-out 0s infinite; -webkit-animation:rotatation 3s ease-in-out 0s infinite;}

.commentlist {overflow:hidden; width:1044px; margin:70px auto 0;}
.commentlist .col {float:left; width:241px; height:191px; margin:0 10px 30px; padding-top:50px; background-repeat:no-repeat; background-position:50% 0; font-size:11px;}
.commentlist .col .no {display:block; margin-bottom:20px; font-size:12px; line-height:1.4; text-align:center; color:#fff;}
.commentlist .col .id, .commentlist .col .date {display:block; font-size:11px; font-weight:bold;}
.commentlist .col .id {margin-top:15px; color:#000; text-decoration:underline;}
.commentlist .col .msg {padding:0 24px; color:#393939; font-size:11px; line-height:1.8em;}
.commentlist .col button {width:37px; height:16px; background-color:transparent;}
.commentlist .col1 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73230/bg_cmt1.png);}
.commentlist .col1 .date {color:#0e5328;}
.commentlist .col2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73230/bg_cmt2.png);}
.commentlist .col2 .date {color:#7b5e00;}
.commentlist .col3 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2016/73230/bg_cmt3.png);}
.commentlist .col3 .date {color:#893505;}

/* tiny scrollbar */
.scrollbarwrap {width:180px; margin:0 auto;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:176px; height:75px; padding-bottom:3px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:4px; background-color:#f1f1f1; border-radius:2px 2px; -webkit-border-radius:2px 2px;}
.scrollbarwrap .track {position: relative; width:4px; height:100%; border-radius:2px 2px; -webkit-border-radius:2px 2px;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:4px; height:24px; background-color:#3f3f3f; cursor:pointer; border-radius:2px 2px; -webkit-border-radius:2px 2px;}
.scrollbarwrap .thumb .end {overflow:hidden; width:4px; height:5px;}
.scrollbarwrap .disable {display:none;}
.noSelect {user-select:none; -o-user-select:none; -moz-user-select:none; -khtml-user-select:none; -webkit-user-select:none;}

.col1 .scrollbarwrap .scrollbar, .col1 .scrollbarwrap .track {background-color:#186234;}
.col1 .scrollbarwrap .thumb {background-color:#61e192;}
.col2 .scrollbarwrap .scrollbar, .col2 .scrollbarwrap .track {background-color:#8a6a00;}
.col2 .scrollbarwrap .thumb {background-color:#ffe386;}
.col3 .scrollbarwrap .scrollbar, .col3 .scrollbarwrap .track {background-color:#893a0d;}
.col3 .scrollbarwrap .thumb {background-color:#fdba94;}

.pageWrapV15 {margin-top:40px;}
.pageWrapV15 .pageMove {display:none;}
.paging a {border:1px solid #626262;}
.paging a span {color:#454545;}
.paging a.arrow, .paging a, .paging a.current {background-color:transparent;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
<!--
 	function jsGoComPage(iP){
		document.frmcom.iCC.value = iP;
		document.frmcom.iCTot.value = "<%=iCTotCnt%>";
		document.frmcom.submit();
	}

	function jsSubmitComment(frm){      //코멘트 입력
		<% If IsUserLoginOK() Then %>
			<% If Now() > #10/12/2016 23:59:59# Then %>
				alert("이벤트가 종료되었습니다.");
				return;
			<% Else %>
				<% If left(now(), 10)>="2016-10-04" and left(now(), 10) < "2016-10-13" Then %>
					<% if commentcount >= 5 then %>
						alert("이벤트는 총 5회까지만 응모하실 수 있습니다.\n10월 14일(금) 당첨자 발표를 기다려 주세요!");
						return;				
					<% else %>
						if (frm.txtcomm.value == '' || GetByteLength(frm.txtcomm.value) > 600 || frm.txtcomm.value == 'GMF2016의 열 번째 생일을 축하해주세요!'){
							alert("GMF2016의 열 번째 생일을 축하해주세요!\n600자 까지 작성 가능합니다.");
							jsCheckLimit();
							frm.txtcomm.focus();
							return false;
						}
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
				location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
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
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return false;
		}

		if (frmcom.txtcomm.value == 'GMF2016의 열 번째 생일을 축하해주세요!'){
			frmcom.txtcomm.value = '';
		}
	}

	//내코멘트 보기
	function fnMyComment() {
		document.frmcom.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
		document.frmcom.iCC.value=1;
		document.frmcom.submit();
	}

	$(function(){

		<% if Request("iCC") <> "" or request("ecc") <> "" then %>
			$(function(){
				var val = $('.commentlistwrap').offset();
				window.$('html,body').animate({scrollTop:$(".commentlistwrap").offset().top-100}, 10);
			});
		<% end if %>

		$('.scrollbarwrap').tinyscrollbar();

		var mySwiper = new Swiper('.swiper1',{
			centeredSlides:true,
			slidesPerView:7,
			//initialSlide:0,
			loop: true,
			speed:2000,
			autoplay:5000,
			simulateTouch:false,
			pagination:'.pagination',
			paginationClickable:true,
			prevButton:'.btn-prev',
			nextButton:'.btn-next'
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
	});
//-->
</script>


<%' GMF %>
<div class="evt73230">
	<div class="topic">
		<div class="ribbon drop">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/tit_gmf_ribbon.png" alt="텐바이텐 x 그랜드 민트 페스티벌 2016" /></p>
			<span class="rbLt"></span><span class="rbRt"></span>
		</div>
		<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/tit_gmf_v2.png" alt="빛나는 가을날 모두의 축제 GRAND MINT FESTIVAL" /></h2>
		<div id="option" class="option bounce">
			<a href="#cmtArea"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/btn_go_cmt.png" alt="코멘트 남기러 가기" /></a>
		</div>
		<div class="deco1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_music1.png" alt="" /></div>
		<div class="deco2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_music2.png" alt="" /></div>
		<div class="leaf1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_leaf1.png" alt="" /></div>
		<div class="leaf2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_leaf2.png" alt="" /></div>
		<div class="leaf3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_leaf3.png" alt="" /></div>
		<div class="wheel1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_wheel2.png" alt="" /></div>
		<div class="wheel2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_wheel2.png" alt="" /></div>
	</div>

	<div class="rollingwrap">
		<div class="rolling">
			<div class="swiper">
				<div class="swiper-container swiper1">
					<div class="swiper-wrapper">
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/img_slide1.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/img_slide2.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/img_slide3.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/img_slide4.jpg" alt="" /></div>
						<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/img_slide5.jpg" alt="" /></div>
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

	<div class="itemwrap">
		<div class="item">
			<ul>
				<li><a href="/shopping/category_prd.asp?itemid=1560449">공식 티셔츠</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1560450">공식 블랑켓+핀버튼</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1560448">공식 보틀+스티커</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1560447">공식 스티커</a></li>
				<li><a href="/shopping/category_prd.asp?itemid=1560451">공식 핀버튼</a></li>
			</ul>
			<img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/img_item.jpg" alt="" />
			<p class="noti"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_animal.png" alt="온라인에서는 판매가 중단되더라도 페스티벌 현장에서 정가로 판매될 예정입니다" /></p>
			<div class="leaf4"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_leaf4.png" alt="" /></div>
			<div class="leaf5"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_leaf5.png" alt="" /></div>
		</div>
	</div>

	<div class="about">
		<div class="inner">
			<div class="video">
				<iframe src="https://www.youtube.com/embed/Q7p1nV4B4dU" width="561" height="316" frameborder="0" title="grand mint festival 2016" webkitallowfullscreen="" mozallowfullscreen="" allowfullscreen=""></iframe>
			</div>
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/txt_gmf.png" alt="올해로 10회를 맞이하는 그랜드 민트 페스티벌! 열 살을 맞이한 GMF2016의 테마는 ‘감사’입니다. 민트페이퍼의 1년 결산이자 대잔치. 기분 좋은 증후군이자 추억을 불러오는 데자뷔. 그랜드 민트 페스티벌 시즌이 돌아왔습니다. 열 번째 생일을 만들어준 모두에게 감사함을 표합니다." /></p>
			<div class="btnwrap">
				<a href="https://www.mintpaper.co.kr/gmf2016/lineup" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/btn_lineup.png" alt="GMF2016 라인업 보기" /></a>
				<a href="https://www.mintpaper.co.kr/gmf2016/" target="_blank"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/btn_official.png" alt=" GMF2016 공식 홈페이지 가기" /></a>
			</div>
		</div>
	</div>

	<%' comment area %>
	<div id="cmtArea" class="cmtArea">
		<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>"/>
		<input type="hidden" name="bidx" value="<%=bidx%>"/>
		<input type="hidden" name="iCC" value="<%=iCCurrpage%>"/>
		<input type="hidden" name="iCTot" value=""/>
		<input type="hidden" name="mode" value="add"/>
		<input type="hidden" name="spoint" value="1">
		<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>"/>
		<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
		<% Else %>
			<input type="hidden" name="hookcode" value="&ecc=1">
		<% End If %>
		<img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/txt_cmt.png" alt="열 살을 맞이한 가을날의 축제 GMF 2016! 찬란한 가을날 축제 GMF2016의 열 번째 생일을 축하해주세요! 정성껏 코멘트를 남겨주신 5분을 추첨하여 10월 22일 토요일 티켓(1인 2매)을 선물로 드립니다!" />
		<span class="deco1"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/ico_animal1.png" alt="" /></span>
		<span class="deco2"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/ico_animal2.png" alt="" /></span>
		<i  class="deco3"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_wheel.png" alt="" /></i>
		<i  class="deco4"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/deco_wheel.png" alt="" /></i>
		<div class="cmtInput">
			<fieldset>
				<legend>그랜드 민트 페스티벌 기대평 남기고 티켓 응모하기</legend>
				<p class="inputBox"><textarea title="기대평 쓰기" name="txtcomm" id="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>GMF2016의 열 번째 생일을 축하해주세요!<%END IF%></textarea></p>
				<button type="button" onclick="jsSubmitComment(frmcom); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/btn_entry.png" alt="응모하기"  /></button>
			</fieldset>
		</div>
		</form>
		<form name="frmdelcom" method="post" action="/event/lib/comment_process.asp" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="Cidx" value="">
		<input type="hidden" name="mode" value="del">
		<input type="hidden" name="userid" value="<%=GetEncLoginUserID%>">
		<% If InStr(Request.ServerVariables("QUERY_STRING"), "&ecc=1") > 0 Then %>
		<% Else %>
			<input type="hidden" name="hookcode" value="&ecc=1">
		<% End If %>
		</form>
		<ul>
			<li>* 비방성 댓글 및 타인의 댓글을 그대로 옮겨 쓴 댓글은 통보없이 자동 삭제 됩니다.</li>
			<li>* 당첨자 1명에게는 2매의 티켓이 제공되며, 발표 후, 개인정보를 요청하게 될 수 있습니다.</li>
			<li>* 초대권의 양도 및 재판매는 불가하며, 확인 시 취소조치 됩니다.</li>
		</ul>
	</div>
	<% IF isArray(arrCList) THEN %>
	<div class="commentlistwrap">
		<div class="commentlist">
			<%' for dev msg : <div class="col">...</div>이 한 묶음입니다.  col1 ~ col3 차례로 노출해주세요 %>
			<%' for dev msg : 한페이지당 8개 %>
			<%
				dim rndNo : rndNo = 1
			
				For intCLoop = 0 To UBound(arrCList,2)

'				if isarray(split(arrCList(1,intCLoop),"|!/")) Then
'					if ubound(split(arrCList(1,intCLoop),"|!/")) > 0 then
'						rndNo = ReplaceBracket(db2html( split(arrCList(1,intCLoop),"|!/")(0) ))
'					End If
'				End If

			%>
			<div class="col col<%=rndNo%>">
				<strong class="no"><%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%>번째 축하</strong>
				<div class="scrollbarwrap">
					<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
					<div class="viewport">
						<div class="overview">
							<%' for dev msg : 기대평 부분 요기에 넣어주세요 %>
							<p class="msg">
								<%=db2html(arrCList(1,intCLoop))%>
							</p>
						</div>
					</div>
				</div>
				<span class="id"><%=printUserId(arrCList(2,intCLoop),2,"*")%></span>
				<span class="date"><%=Mid(arrCList(4,intCLoop), 6, 2)&"."&Mid(arrCList(4,intCLoop), 9, 2)%></span>
				<% if ((GetEncLoginUserID = arrCList(2,intCLoop)) or (GetEncLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/73230/btn_del.png" alt="삭제" /></button>
				<% End If %>				
			</div>
			<%
				If rndNo < 3 Then
					rndNo = rndNo + 1
				Else
					rndNo = 1
				End If
			%>
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
<!-- #include virtual="/lib/db/dbclose.asp" -->