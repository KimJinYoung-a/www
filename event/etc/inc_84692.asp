<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'###########################################################
' Description : hey, something project 시리즈 99
' 미키와 미니의 양말셋트
' History : 2017-12-12 정태훈 생성
'###########################################################
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
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<%
dim oItem
dim currenttime
	currenttime =  now()
'	currenttime = #11/10/2017 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  67510
Else
	eCode   =  84692
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

if userid = "greenteenz" or userid = "chaem35" or userid = "answjd248" or userid = "corpse2" or userid = "jinyeonmi" or userid = "jj999a" then
	currenttime = #02/26/2018 00:00:00#
end if

commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")

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
<style>
.eggplant .topic {position:relative; height:700px; background:#7c2698 url(http://webimage.10x10.co.kr/eventIMG/2018/84692/bg_topic.jpg) no-repeat 50% 0;}
.eggplant .topic .subcopy,
.eggplant .topic .date,
.eggplant .topic h2 {position:absolute; top:88px; left:50%; margin-left:-530px;}
.eggplant .topic h2 span {overflow:hidden; display:block; text-align:left;}
.eggplant .topic h2 span.t1 {position:relative; padding-bottom:44px;}
.eggplant .topic h2 .t1:after {content:' '; position:absolute; top:40px; left:0; width:22px; height:1px; background-color:#f6ff45;}
.eggplant .topic .date {top:42px; margin-left:488px; }
.eggplant .topic .subcopy {overflow:hidden; top:470px; margin-left:317px;}
.eggplant .topic .subcopy span {overflow:hidden; display:block; margin-top:18px; text-align:left; animation:bounce1 200 .8s;}
.eggplant .topic h2 span.t1 img{margin-left:-188px; transition:all 1s .2s;}
.eggplant .topic h2 span.t2 img{margin-left:-200px; transition:all 1s .4s;}
.eggplant .topic .subcopy > img{margin-left:-240px; transition:all .8s .8s;}
.eggplant .topic .subcopy span img{margin-top:-20px; transition:all .8s 1s;}
.eggplant .topic.animation h2 span.t1 img {margin-left:0;}
.eggplant .topic.animation h2 span.t2 img {margin-left:0;}
.eggplant .topic.animation .subcopy > img{margin-left:0;}
.eggplant .topic.animation .subcopy span img{margin-top:0;}

.about-brand {background-color:#f8f8f8;}
.about-brand h3{margin-top:118px;}

#slide-brand {position:relative; width:1140px; height:536px; margin:60px auto 0;}
#slide-brand .slidesjs-container {overflow:visible !important;}
#slide-brand .slidesjs-pagination {overflow:hidden; position:absolute; bottom:29px; left:50%; z-index:10; width:166px; margin-left:-83px;}
#slide-brand .slidesjs-pagination li {display:inline-block; margin:0 14px;}
#slide-brand .slidesjs-pagination li a {display:block; width:6px; height:6px; background-color:transparent; border:solid 2px #7c2698; text-indent:-9999em; transition:all 0.5s;}
#slide-brand .slidesjs-pagination li .active {width:20px; background-color:#7c2698;}
#slide-brand .slidesjs-navigation {display:block; position:absolute; top:50%; z-index:500; width:50px; height:50px; margin-top:-25px; background:url(http://webimage.10x10.co.kr/eventIMG/2018/84692/btn_prev.png) no-repeat 00; text-indent:-999em;}
#slide-brand .slidesjs-previous {left:0;}
#slide-brand .slidesjs-next {right:0; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84692/btn_next.png);}

.goodthings {padding:94px 0 90px; background-color:#fff;}
.goodthings ul {overflow:hidden; width:1052px; margin:53px auto 0;}
.goodthings ul li {position:relative; float:left; width:155px; left:-10px; margin:0 54px; opacity:0; transition:all .5s .1s; transition-timing-function:ease-in-out;}
.goodthings ul li + li{transition-delay:.3s;}
.goodthings ul li + li + li {transition-delay:.4s;}
.goodthings ul li + li + li + li {transition-delay:.5s;}
.goodthings.animation ul li {left:0; opacity:1;}

.ure-prd h4 {margin-top:115px;}
.ure-prd .slider {padding:93px 0 129px; text-align:left;}
.ure-prd .slider .slider-horizontal {width:100%; margin:0 auto;}
.ure-prd .slider .www_FlowSlider_com-branding {display:none !important;}
.ure-prd .slider .item {width:184px; height:219px; margin:0 28px;}

.cosmetic-evt {background-color:#dfe789;}
.cosmetic-evt .inner {width:1140px; margin:0 auto; padding:92px 99px;}
.cosmetic-evt .select-cosmetic {position:relative; height:186px; margin:53px 0 34px;}
.cosmetic-evt .select-cosmetic .evtSelect {width:188px; height:60px; padding:63px 50px 63px 50px; background-color:#7c2698;}
.cosmetic-evt .select-cosmetic .evtSelect dt {width:100%; height:100%; border:0;}
.cosmetic-evt .select-cosmetic .evtSelect dt span {position:relative; z-index:100; width:165px; height:60px; padding:2px 23px 0 0; background-color:transparent; color:#fff; font-size:18px; line-height:1.4; font-weight:500; text-align:center; font-family:'Roboto'; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84692/btn_arrow.png)}
.cosmetic-evt .select-cosmetic .evtSelect dt.over span {background-position:right top;}
.cosmetic-evt .select-cosmetic  .evtSelect dd {top:120px; left:50px; z-index:30; width:188px; padding:0 0 0 0; background-color:rgba(63, 0, 83, .85); border:0;}
.cosmetic-evt .select-cosmetic  .evtSelect dt.over:before {content:' '; position:absolute; top:60px; left:50px; width:188px; height:60px; background-color:rgba(63, 0, 83, .85);}

.cosmetic-evt .select-cosmetic  .evtSelect dd ul {padding:10px 23px 12.5px 0;}
.cosmetic-evt .select-cosmetic  .evtSelect dd ul li {padding:9px 0; font-size:14px; text-align:center !important; color:#d69de9; font-weight:500; letter-spacing:-.5px;}
.cosmetic-evt .select-cosmetic .reason-box {position:relative; width:770px; height:127px; padding:30px; background-color:#fff;}
.cosmetic-evt .select-cosmetic textarea {position:absolute; top:0; left:0; width:485px; height:127px; margin:30px; padding:0; border:0; color:#868686; font-size:15px; font-weight:bold;}
.cosmetic-evt .select-cosmetic textarea::-webkit-input-placeholder {color: #868686;}
.cosmetic-evt .select-cosmetic .submit {position:absolute; top:45px; right:47px; z-index:50; }
.cosmetic-evt .select-cosmetic .select-please {position:absolute; top:-76px; left:50%; z-index:150; margin-left:-600px; animation:flash 2.3s 200 forwards;}

.comment-list {margin-top:48px;}
.comment-list ul {overflow:hidden; width:1200px; margin:0 auto; font-family:"malgun Gothic","맑은고딕";}
.comment-list li {position:relative; float:left; width:280px; height:290px; margin:0 20px 44px 20px; padding:34px 30px 22px 30px; color:#fff; font-size:14px;  line-height:1; text-align:left; background-color:#b9c800;}
.comment-list li .num {padding-right:10px;padding-bottom:16px; color:#fffc00;}
.comment-list li .cosmetic{color:#7c2698; font-size:18px; line-height:1; font-weight:600;}
.comment-list li .writer {position:absolute; right:20px; bottom:20px; color:#505700; font-weight:600;}
.comment-list li .delete {position:absolute; right:0; top:0;}
.comment-list .viewport {width:100%; height:175px;}
.comment-list .viewport .conts {margin-top:20px; font-size:15px; line-height:1.8; break-word:keep-all;}
.comment-list .paging {height:34px;}
.comment-list .paging a {height:34px; margin:0 3px; line-height:34px; border:0; font-weight:bold; background-color:transparent;}
.comment-list .paging a span {width:34px; height:34px; font-size:13px; color:#7c2698; padding:0;}
.comment-list .paging a.current {background-color:#7c2698; border:0; color:#fff; border-radius:580%;}
.comment-list .paging a.current span {color:#fff;}
.comment-list .paging a.current:hover {background-color:#7c2698;}
.comment-list .paging a:hover {background-color:transparent;}
.comment-list .paging a.arrow {width:29px; height:34px; margin:0 8px; background-color:transparent;}
.comment-list .paging a.arrow span {width:29px; height:29px; margin-top:3px; background-image:url(http://webimage.10x10.co.kr/eventIMG/2018/84692/btn_nav.png);}
.comment-list .paging a.arrow.first,
.comment-list .paging a.arrow.end{display:none;}
.comment-list .paging a.prev span {background-position:0 0;}
.comment-list .paging a.next span {background-position:100% 0;}
.comment-list .pageMove {display:none;}
@keyframes bounce1{
	from,to {transform:translateY(0);}
	50% {transform:translateY(5px);}
}
@keyframes flash{
	from{opacity:1;}
	45% {opacity:1;}
	50% {opacity:0;}
	55% {opacity:1;}
	to {opacity:1;}
}
@keyframes swing {
	0%,100%{transform:rotate(8deg);}
	50% {transform:rotate(-8deg);}
}
</style>
<script type="text/javascript" src="/lib/js/jquery.flowslider.js"></script>
<script>
$(function() {
	document.frmcom.gubunval.value = '1';
	$(".topic").addClass("animation");
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		//console.log(scrollTop);
		if (scrollTop > 450 ) {
			$(".goodthings").addClass("animation");
		}
	});

	$("#slide-brand").slidesjs({
			width:"942",
			height:"536",
			pagination:{effect:"fade"},
			navigation:{effect:"fade"},
			play:{interval:2500, effect:"fade", auto:true},
			effect:{fade: {speed:700, crossfade:true}}
	});

	$(".slider").FlowSlider({
		marginStart:0,
		marginEnd:0,
		startPosition:0.55
	});

	$(".evtSelect dt").click(function(){
		if($(".evtSelect dd").is(":hidden")){
			$(this).parent().children('dd').show("slide", { direction: "up" }, 200);
			$(this).addClass("over");
		}else{
			$(this).parent().children('dd').hide("slide", { direction: "up" }, 200);
		};
	});
	$(".evtSelect dd li").click(function(){
		var evtName = $(this).text();
		$(".evtSelect dt").removeClass("over");
		$(".evtSelect dd li").removeClass("on");
		$(this).addClass("on");

		if ($(this).is("li:nth-child(1)")) {
			$("#cosmetics").empty().append("바이오셀 <br/ > 에센스 50m");
		}
		if ($(this).is("li:nth-child(2)")) {
			$("#cosmetics").empty().append("투명  클렌징 <br/ > 워터 300ml");
		}
		if ($(this).is("li:nth-child(3)")) {
			$("#cosmetics").empty().append("스킨케어 <br/ > 클리어 패드");
		}
		if ($(this).is("li:nth-child(4)")) {
			$("#cosmetics").empty().append("올인원 <br/ > 토너 180ml");
		}
		if ($(this).is("li:nth-child(5)")) {
			$("#cosmetics").empty().append("트리플 <br/ > 클렌저 필링젤");
		}
		if ($(this).is("li:nth-child(6)")) {
			$("#cosmetics").empty().append("립앤아이 <br/ > 리무버 12ml");
		}
		if ($(this).is("li:nth-child(7)")) {
			$("#cosmetics").empty().append("마스터 <br/ > 크림 50g");
		}
		if ($(this).is("li:nth-child(8)")) {
			$("#cosmetics").empty().append("몽글몽글 <br/ > 버블클렌저");
		}
		$(this).parent().parent().hide("slide", { direction: "up" }, 200);
		document.frmcom.gubunval.value = $(this).val();
	});
	$(".evtSelect dd").mouseleave(function(){
		$(this).hide();
		$(".evtSelect dt").removeClass("over");
	});
});

$(function(){
	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	//document.getElementById('commentlist').scrollIntoView();
	window.$('html,body').animate({scrollTop:$("#commentlist").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10) >= "2018-02-26" and left(currenttime,10) < "2018-03-05" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>0 then %>
				alert("본 이벤트는 ID당 1회만 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.gubunval.value == ''){
					alert('화장품을 골라보세요.');
					return false;
				}
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 300){
					alert("코멘트를 남겨주세요.\n한글 150자 까지 작성 가능합니다.");
					frm.txtcomm1.focus();
					return false;
				}
				frm.txtcomm.value = frm.gubunval.value + '!@#' + frm.txtcomm1.value
				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
//			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
//			winLogin.focus();
//			return false;
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
			top.location.href="/login/loginpage.asp?vType=G";
			return false;
//			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
//			winLogin.focus();
//			return false;
		}
		return false;
	}
}
</script>
						<div class="evt84692 eggplant">
							<div class="topic">
								<h2>
									<span class="t1"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/tit_object.png" alt="Object. 01" /></span>
									<span class="t2"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/tit_eggplant.png" alt="가지" /></span>
								</h2>
								<span class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/txt_date.png" alt="2018.02.26 ~ 03.04" /></span>
								<p class="subcopy">
									<img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/txt_intro.png" alt="보랏빛의 아름다운 색을 지닌 기다란 채소, 가지" />
									<span><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_arrow.png" alt="" /></span>
								</p>
							</div>
							<div class="goodthings">
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/tit_good_for_skin.png?v=1.0" alt="예쁜 색깔만큼 피부미용에도 좋다는 점 아시나요?" /></p>
								<ul>
									<li><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/txt_good_1.png" alt="여드름 완화" /></li>
									<li><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/txt_good_2.png" alt="피부진정, 잡티예방" /></li>
									<li><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/txt_good_3.png" alt="수분보충" /></li>
									<li><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/txt_good_4.png" alt="노화방지" /></li>
								</ul>
							</div>
							<div class="about-brand">
								<h3><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/tit_cosmetic.png?v=1.1" alt="다양한 효과가 가득한 가지성분 화장품" /></h3>
								<div id="slide-brand" class="slide-brand">
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_slide_1.jpg?v=1.1" alt="자연에서 주는 선물을 피부에 양보하다" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_slide_2.jpg?v=1.1" alt="90% 원료비용으로 트러블에 좋은 성분 가득!" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_slide_3.jpg?v=1.1" alt="자연 유래 성분이라 ‘비자극’피부자극지수 0.00" /></div>
									<div><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_slide_4.jpg?v=1.1" alt="자연유래 성분 화장품 유리스킨" /></div>
								</div>
							</div>
							<div class="ure-prd">
								<h4><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/tit_ure_skin.png" alt="ureskin" /></h4>
								<div class="slider">
									<div class="item"><a href="/shopping/category_prd.asp?itemid=1877479&pEtr=82700"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_item_1.png" alt="몽글몽글 버블클렌저" /></a></div>
									<div class="item"><a href="/shopping/category_prd.asp?itemid=1879755&pEtr=82700"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_item_2.png" alt="바이오셀 에센스 50ml" /></a></div>
									<div class="item"><a href="/shopping/category_prd.asp?itemid=1879754&pEtr=82700"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_item_3.png" alt="산뜻 클렌징 오일/클렌저" /></a></div>
									<div class="item"><a href="/shopping/category_prd.asp?itemid=1879753&pEtr=82700"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_item_4.png" alt="투명 클렌징 워터 300ml" /></a></div>
									<div class="item"><a href="/shopping/category_prd.asp?itemid=1879752&pEtr=82700"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_item_5.png" alt="스킨케어 클리어패드" /></a></div>
									<div class="item"><a href="/shopping/category_prd.asp?itemid=1879751&pEtr=82700"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_item_6.png" alt="올인원 토너 180ml" /></a></div>
									<div class="item"><a href="/shopping/category_prd.asp?itemid=1879750&pEtr=82700"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_item_7.png" alt="트리플 클렌저 필링젤" /></a></div>
									<div class="item"><a href="/shopping/category_prd.asp?itemid=1877481&pEtr=82700"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_item_8.png?v=1.0" alt="립앤아이 리무버 120ml" /></a></div>
									<div class="item"><a href="/shopping/category_prd.asp?itemid=1877480&pEtr=82700"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/img_item_9.png" alt="마스터 크림 50g" /></a></div>
							</div>

							<!-- 화장품 받기 이벤트-->
							<div class="cosmetic-evt">
								<div class="inner">
									<h5><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/txt_evt.png" alt="직접 사용해보지 않고선 몰라요! 원하는 화장품을 선택 후, 이유를 적어주신 900분을 추첨하여 <유리스킨> 화장품을 드립니다! " /></h5>
									<!-- 화장품 셀렉 박스 -->
									<div class="select-cosmetic">
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
									<input type="hidden" name="txtcomm">
									<input type="hidden" name="gubunval">
										<dl class="evtSelect ftLt">
											<dt><span id="cosmetics">바이오셀 <br/ >에센스 50ml</span></dt>
											<dd style="display: none;">
												<ul>
													<li value="1">바이오셀 에센스 50ml</li>
													<li value="2">투명 클렌징 워터 300ml</li>
													<li value="3">스킨케어 클리어 패드</li>
													<li value="4">올인원 토너 180ml</li>
													<li value="5">트리플 클렌저 필링젤</li>
													<li value="6">립앤아이 리무버 120ml</li>
													<li value="7">마스터 크림 50g</li>
													<li value="8">몽글몽글 버블클렌저</li>
												</ul>
											</dd>
										</dl>
										<div class="reason-box ftLt">
											<!-- 150자 이내 --> <textarea class="" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> placeholder="갖고 싶은 이유 150자 이내로 적어주세요!"></textarea>
											<!-- 코멘트 쓰기 버튼 --><button class="submit" onclick="jsSubmitComment(document.frmcom); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/btn_submit.png" alt="코멘트 쓰기" /></button>
										</div>
										<span class="select-please"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/txt_select.png" alt="화장품을 골라보세요!" /></span>
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
									<p><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/txt_noti.png" alt="* 통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며, 이벤트 참여에 제한을 받을 수 있습니다.* 한 ID 당 1번 참여 가능합니다. " /></p>
									<div class="comment-list" id="commentlist">
									<% IF isArray(arrCList) THEN %>
									<ul>
										<% For intCLoop = 0 To UBound(arrCList,2) %>
										<li>
											<!-- 글번호 --> <p class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
											<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
											<a href="" class="delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2018/84692/btn_delete.png" alt="삭제" /></a>
											<% end if %>
											<div class="viewport">
												<p class="cosmetic">
												<% If isarray(split(arrCList(1,intCLoop),"!@#")) Then %>
												<% if split(arrCList(1,intCLoop),"!@#")(0)="1" Then %>
												바이오셀 에센스 50ml
												<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="2" Then %>
												투명 클렌징 워터 300ml
												<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="3" Then %>
												스킨케어 클리어 패드
												<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="4" Then %>
												올인원 토너 180ml
												<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="5" Then %>
												트리플 클렌저 필링젤
												<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="6" Then %>
												립앤아이 리무버 120ml
												<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="7" Then %>
												마스터 크림 50g
												<% ElseIf split(arrCList(1,intCLoop),"!@#")(0)="8" Then %>
												몽글몽글 버블클렌저
												<% Else %>
												바이오셀 에센스 50ml
												<% End If %>
												<% end if %>
												</p>
												<div class="conts">
												<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
													<% if ubound(split(arrCList(1,intCLoop),"!@#")) > 0 then %>
														<%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"!@#")(1) ))%>
													<% end if %>
												<% end if %>
												</div>
											</div>
											<p class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></p>
										</li>
										<% next %>
									<% end if %>
									</ul>
									<div class="pageWrapV15 tMar30">
										<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
									</div>
								</div>
								</div>
							</div>
							<!--// 화장품 받기 이벤트-->
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->