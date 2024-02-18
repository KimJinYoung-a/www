<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#################################################################
' Description : 진심을 꺼내세요.
' History : 2017.11.10 정태훈
'#################################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, vUserID, myevt, vDIdx, myselect
dim arrList, sqlStr

IF application("Svr_Info") = "Dev" THEN
	eCode = "67457"
Else
	eCode = "81508"
End If

vDIdx = request("didx")
vUserID = getEncLoginUserID
myselect = 0

'참여했는지 체크
myevt = getevent_subscriptexistscount(eCode, vUserID,"","","")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL, pagereload
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

iCPerCnt = 5		'보여지는 페이지 간격
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
	
	arrCList = cEComment.fnGetSubScriptComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
set cEComment = nothing

iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>
<link rel="stylesheet" type="text/css" href="/lib/css/sectionV15.css" />
<style type="text/css">
.thingvol027 {position:relative; background-color:#00759b; text-align:center;}
.tit h2 {position:relative; width:554px; height:71px; margin:0 auto; padding:110px 0 27px;}
.tit h2 span {position:absolute; top:110px; opacity:0;}
.tit h2 .t1 {left:0; z-index:15;}
.tit h2 .t2 {top:92px; left:188px; z-index:10; animation-delay:0.3s;}
.tit h2 .t3 {right:0; animation-delay:0.5s;}
.tit > span {position:absolute; top:30px; left:50%;}
.tit .date {margin-left:415px; top:32px;}
.tit .sub1 {margin-left:-550px;}
.tit .sub2 {margin-bottom:93px; animation-delay:0.7s; opacity:0;}
.slideX {animation:slideX 0.4s ease-in forwards;}
@keyframes slideX {
	0% {transform:translateX(-30px); opacity:0;}
	100% {transform:translateX(0); opacity:1;}
}
.slideY {animation:slideY 0.4s ease-in forwards;}
@keyframes slideY {
	0% {transform:translateY(-30px); opacity:0;}
	100% {transform:translateY(0); opacity:1;}
}

.webtoon {position:relative; background:url(http://webimage.10x10.co.kr/playing/thing/vol027/bg_blue_4.jpg)no-repeat 50% 96.7%;}
.webtoon .conts {position:relative; z-index:10; display:inline-block; padding:0 244px 0 245px; background-color:#fff; border-radius:20px;}
.webtoon .bg {position:absolute; left:50%;}
.webtoon .bg1 {top:415px; margin-left:443px;}
.webtoon .bg2 {top:1399px; margin-left:-733px;}
.webtoon .bg3 {top:2572px; margin-left:590px;}
.webtoon .conts .bg {position:absolute; left:0;}
.webtoon .conts .edge1 {top:0;}
.webtoon .conts .edge2 {bottom:0;}
.webtoon .btn-go-evt {position:fixed; top:55%; left:50%; z-index:20; margin-left:434px; opacity:0; transition:all .6s;}
.webtoon .btn-go-evt.fixed { top:50%;  opacity:1;}
.intro {padding:205px 0 85px; margin-top:-121px; background-color:#003e5e;}

.word1 {background-color:#fbded0;}
.word2 {background-color:#ffe575;}
.word3 {background-color:#ff926f;}

.campaign {padding-top:110px; background-color:#f97754;}
.campaign .subcopy {margin:27px;}
.campaign .fullSlide {position:relative; height:587px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/vol027/bg_slide.png) no-repeat 50% 0;}
.campaign .fullSlide .swiper-container {margin-top:6px;}
.campaign .slideTemplateV15 .slidesjs-navigation {width:49px; height:76px; margin-top:-38px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol027/btn_prev.png);}
.campaign .slideTemplateV15 .slidesjs-navigation:hover {background-position:50% 0;}
.campaign .slideTemplateV15 .slidesjs-prev {left:20px;}
.campaign .slideTemplateV15 .slidesjs-next {right:20px; background:url(http://webimage.10x10.co.kr/playing/thing/vol027/btn_next.png) 0 0;}
.slideTemplateV15 .slidesjs-pagination li a {width:32px; height:32px; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol027/btn_pagination.png);}

.cmt-evt {width:1140px; margin:90px auto 0;}
.cmt-evt .date {margin:40px 0 80px;}
.cmt-evt .form {background-color:#fff; padding:70px 137px 60px;}
.cmt-evt .form p {margin-bottom:36px; text-align:left;}
.cmt-evt .select-word {overflow:hidden; margin-bottom:55px; padding-bottom:30px;}
.cmt-evt .select-word li {position:relative; float:left; width:264px; margin-left:36px;}
.cmt-evt .select-word li:first-child {margin-left:0;}
.cmt-evt .select-word input[type='radio'] {position:relative; display:none;}
.cmt-evt .select-word input[type='radio'] + span {display:inline-block; position:absolute; bottom:-30px; left:50%; width:20px; height:20px; margin-left:-10px; background:url(http://webimage.10x10.co.kr/playing/thing/vol027/blt_radio.png) no-repeat 100% 100%;}
.cmt-evt .select-word input[type='radio']:checked + span {background-position:0 0;}
.cmt-evt .select-word label {display:block; width:100%; height:100%; padding:36px 0 35px; cursor:pointer;}
.cmt-evt .form .textarea {margin-top:15px;}

.reason-box {position:relative; width:360px; height:143px; margin:0 auto; padding:40px; text-align:left; font-size:14px; color:#a08d84;}
.reason-box span {display:inline-block; position:relative; width:120px; height:18px; margin-right:10px; padding-bottom:4px; border-bottom:3px solid #007da8; color:#007da8; font-size:18px; line-height:1; font-weight:900;}
.reason-box input {position:absolute; top:0; right:0; width:75px; height:18px; background-color:transparent; text-align:left; font-size:15px; font-weight:500; letter-spacing:.6px;}
.reason-box .phone {width:216px; margin:0;}
.reason-box .phone input{width:133px;}
.reason-box input::-input-placeholder {font-size:16px;}
.reason-box input::-webkit-input-placeholder {font-size:16px;}
.reason-box input::-moz-placeholder {font-size:16px;} /* firefox 19+ */
.reason-box input:-ms-input-placeholder {font-size:16px;} /* ie */

.reason-box textarea {width:350px; height: 110px; margin-top:25px; padding:0; background-color:transparent; border:none; font-size:14px; font-weight:600; letter-spacing:.5px;}
.reason-box textarea::-input-placeholder {font-weight:600;}
.reason-box textarea::-webkit-input-placeholder {font-weight:600;}
.reason-box textarea::-moz-placeholder {font-weight:600;} /* firefox 19+ */
.reason-box textarea:-ms-input-placeholder font-weight:600;} /* ie */

.reason-box.word1 span{border-bottom:3px solid #007da8; color:#007da8;}
.reason-box.word1 input, .reason-box.word1 textarea  {color:#a08d84;}
.reason-box.word1 input::-input-placeholder, .reason-box.word1 textarea::-input-placeholder {color:#a08d84;}
.reason-box.word1 input::-webkit-input-placeholder, .reason-box.word1 textarea::-webkit-input-placeholder {color:#a08d84;}
.reason-box.word1 input::-moz-placeholder, .reason-box.word1 textarea::-moz-placeholder {color:#a08d84;}
.reason-box.word1 input:-ms-input-placeholder, .reason-box.word1 textarea:-ms-input-placeholder {color:#a08d84;}

.reason-box.word2 span{border-bottom:3px solid #079083; color:#079083;}
.reason-box.word2 input, .reason-box.word2 textarea  {color:#a39148;}
.reason-box.word2 input::-input-placeholder, .reason-box.word2 textarea::-input-placeholder {color:#a39148;}
.reason-box.word2 input::-webkit-input-placeholder, .reason-box.word2 textarea::-webkit-input-placeholder {color:#a39148;}
.reason-box.word2 input::-moz-placeholder, .reason-box.word2 textarea::-moz-placeholder {color:#a39148;}
.reason-box.word2 input:-ms-input-placeholder, .reason-box.word2 textarea:-ms-input-placeholder {color:#a39148;}

.reason-box.word3 span{border-bottom:3px solid #203252; color:#203252;}
.reason-box.word3 input, .reason-box.word3 textarea  {color:#a35b44;}
.reason-box.word3 input::-input-placeholder, .reason-box.word3 textarea::-input-placeholder {color:#a35b44;}
.reason-box.word3 input::-webkit-input-placeholder, .reason-box.word3 textarea::-webkit-input-placeholder {color:#a35b44;}
.reason-box.word3 input::-moz-placeholder, .reason-box.word3 textarea::-moz-placeholder {color:#a35b44;}
.reason-box.word3 input:-ms-input-placeholder, .reason-box.word3 textarea:-ms-input-placeholder {color:#a35b44;}

.cmt-list {width:1140px; height:617px; margin-top:70px;}
.cmt-list ul {overflow:visible; width:100%; height:100%; margin:0 auto;}
.cmt-list li {float:left; position:relative; width:291px; height:211px; margin:0 0 37px 37px; padding:28px 27px 51px 37px; font-size:12px; text-align:left;}
.cmt-list li:first-child,
.cmt-list li:first-child + li + li + li{margin-left:0;}
.cmt-list li .writer {position:relative; color:#3b3b3b;}
.cmt-list .mob .writer .id{padding-left:16px;}
.cmt-list .mob .writer .id:after{content:' '; display:inline-block; position:absolute; top:50%; left:0; width:10px; height:13px; margin-top:-6.5px; background:url(http://webimage.10x10.co.kr/playing/thing/vol027/ico_mobile.png) no-repeat 0 0;}
.cmt-list li .writer .no {position:absolute; top:0; right:0;}
.cmt-list li p {margin:30px 0 12px;}
.cmt-list li .conts {overflow:hidden; height:135px; margin-right:15px; font-size:14px; line-height:26px; color:#333; letter-spacing:.1px;}
.cmt-list .btn-del {position:absolute; top:-6px; right:-6px; z-index:30; background-color:transparent; cursor:pointer;}
.cmt-list .btn-del img {transition:transform .7s ease;}
.cmt-list .btn-del:hover img {transform:rotate(-180deg);}
.cmt-list .word3{background-color:#ffab6d;}

.cmt-pagination .paging {height:30px; margin-top:60px; padding:5px 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol027/bg_round_orange.png) no-repeat 50% 0;}
.cmt-pagination .paging a{width:29px; height:30px; background-color:transparent; border:none;}
.cmt-pagination .paging a.current:hover {background-color:transparent; }
.cmt-pagination .paging a span {width:100%; height:100%; color:#fff; padding:4px 0 0;}
.cmt-pagination .paging a.current span {color:#2d4c72;}
.cmt-pagination .paging a.arrow {width:30px;}
.cmt-pagination .paging a.arrow span {width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/79272/img_arrow.png) no-repeat 0 0;}
.cmt-pagination .paging a.prev span {background-position:-33px 0;}
.cmt-pagination .paging a.next {margin-left:5px;}
.cmt-pagination .paging a.next span {background-position:-400px 0;}
.cmt-pagination .paging a.end span {background-position:100% 0;}

.how-to {margin-top:212px; padding:60px 0; background:#00759b url(http://webimage.10x10.co.kr/playing/thing/vol027/bg_how_to.jpg) 50% 0 no-repeat;}
.how-to .inner {position:relative; width:1140px; margin:0 auto;}
.how-to h4 {position:absolute; top:50%; left:206px; margin-top:-28px;}
.how-to p {padding-left:430px;}
</style>
<script style="text/javascript">
$(function(){
	$('.fullSlide .swiper-wrapper').slidesjs({
		width:930,
		height:575,
		pagination:{effect:'fade'},
		navigation:{effect:'fade'},
		play:{interval:3000, effect:'fade', auto:true},
		effect:{fade: {speed:1200, crossfade:true}
		},
		callback: {
			complete: function(number) {
				var pluginInstance = $('.fullSlide .swiper-wrapper').data('plugin_slidesjs');
				setTimeout(function() {
					pluginInstance.play(true);
				}, pluginInstance.options.play.interval);
			}
		}
	});

	$('.cmt-evt .select-word li').click(function(){
		$(this).find('input').attr("checked","checked");
		$('.reason-box').removeClass("word1");
		$('.reason-box').removeClass("word2");
		$('.reason-box').removeClass("word3");
		if ($(this).hasClass("word1")) {
			$('.reason-box').addClass("word1");
		}
		if ($(this).hasClass("word2")) {
			 $('.reason-box').addClass("word2");
		}
		if ($(this).hasClass("word3")) {
			 $('.reason-box').addClass("word3");
		}
	});

	$('.btn-go-evt').click(function(){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(".intro").offset().top+125},500);
	});

	$(".tit h2 span").addClass("slideX");
	$(".tit .sub2").addClass("slideY");
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		//console.log(scrollTop);
		if (scrollTop > 2000) {
			$(".btn-go-evt").addClass("fixed");
		}
		if (scrollTop < 500) {
			$(".btn-go-evt").removeClass("fixed");
		}
		if (scrollTop > 4500) {
			$(".btn-go-evt").removeClass("fixed");
		}
	});
});

function jsGoComPage(iP){
	location.replace('/playing/view.asp?didx=<%=vDIdx%>&iCC=' + iP + '#card_list');
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if date() >="2017-11-10" and date() < "2017-11-28" then %>
			<% if myevt>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if(frm.username.value==""){
					alert("모든 내용을 입력해야 응모가 완료됩니다");
					frm.username.focus();
					return false;
				}
				if(frm.hp.value==""){
					alert("모든 내용을 입력해야 응모가 완료됩니다.");
					frm.hp.focus();
					return false;
				}
				if(frm.txtcomm.value==""){
					alert("내용을 적어주세요!");
					document.frmcom.txtcomm.value="";
					frm.txtcomm.focus();
					return false;
				}

				if (GetByteLength(frm.txtcomm.value) > 200){
					alert("제한길이를 초과하였습니다. 100자 까지 작성 가능합니다.");
					frm.txtcomm.focus();
					return false;
				}

				frm.action = "/playing/sub/doEventSubscriptvol027.asp";
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

function maxLengthCheck(object){
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?!")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx)%>';
			return;
		}
		return false;
	}
	if (object.value.length > object.maxLength)
	  object.value = object.value.slice(0, object.maxLength)
}
</script>
						<div class="thingvol027">
							<!-- 상단 -->
							<div class="tit">
								<h2>
									<span class="t1"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/tit_1.png" alt="진심을" /></span>
									<span class="t2"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/tit_2.png" alt="" /></span>
									<span class="t3"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/tit_3.png" alt="꺼내요" /></span>
								</h2>
								<span class="date"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_date.png" alt="2017.11.13 - 11.27 " /></span>
								<span class="sub1"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_sub1.png" alt="빈말대신, 진말 건네기 캠페인 " /></span>
								<p class="sub2"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_sub_2.png" alt="TAKE YOUR TRUTH CARD " /></p>
							</div>

							<!-- 웹툰 -->
							<div class="webtoon">
								<div class="conts">
									<img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_webtoon.jpg" alt="" />
									<div class="bg edge1"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/bg_edge2.jpg" alt="" /></div>
									<div class="bg edge2"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/bg_edge1.jpg" alt="" /></div>
								</div>
								<a href="#intro" class="btn-go-evt"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/btn_go_campaign.png" alt="진말 건네기 캠페인 보러가기" /></a>
								<div class="bg bg1"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/bg_blue_1.jpg" alt="" /></div>
								<div class="bg bg2"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/bg_blue_2.jpg" alt="" /></div>
								<div class="bg bg3"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/bg_blue_3.jpg" alt="" /></div>
							</div>
							<div class="intro" id="intro"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_intro.png" alt="빈말대신, 진말 건네기 캠페인 “언제 한번 밥먹자”, “언제 얼굴 한번 보자” 인사치레로 뱉던 말들, 누군가는 그 말을 곧이 곧 대로 믿어 버리곤 하죠. 이제는 그 말에 기대조차 하지 않는 우리.이번 연말엔 인사치레가 아닌 진심을 건네보는 건 어떨까요?" /></div>

							<!-- 캠페인 -->
							<div class="campaign">
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_lets_campaign.png" alt="로 캠페인에 동참하세요! " /></h3>
								<p class="subcopy"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_subcopy.png" alt="여러분의 이름이 담긴 명함을 만들어 드립니다. 평소 가슴속에 지니고 다니면서 오랜만에 만난 친구에게 건네보세요. 여러분의 이름이 담긴 만큼 더 진중하게, 진심을 전할 수 있을 거에요." /></p>
								<div class="slideTemplateV15 fullSlide">
									<div class="swiper-container">
										<div class="swiper-wrapper">
											<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/img_slide_1.jpg" alt="" /></div>
											<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/img_slide_2.jpg" alt="" /></div>
											<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/img_slide_3.jpg" alt="" /></div>
											<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/img_slide_4.jpg" alt="" /></div>
											<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/img_slide_5.jpg" alt="" /></div>
										</div>
										<div class="pagination"></div>
										<button class="slideNav btnPrev">이전</button>
										<button class="slideNav btnNext">다음</button>
									</div>
								</div>

								<!-- 코멘트 이벤트 -->
								<div class="cmt-evt" id="cmt-evt">
									<h4><img src="http://webimage.10x10.co.kr/playing/thing/vol027/tit_cmt_evt.png" alt="여러분이 가장 많이 하는 빈말과 함께 진심 명함 카드가 필요한 이유를 적어주세요! " /></h4>
									<p class="date"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_date2.png" alt="이벤트 기간  2017.11.13 - 11.27" /></p>
									<div class="form">
										<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
										<input type="hidden" name="eventid" value="<%=eCode%>">
										<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
										<input type="hidden" name="iCTot" value="">
										<input type="hidden" name="mode" value="add">
											<fieldset>
												<legend>가장 많이 하는 빈말과 함께 진심 명함 카드가 필요한 이유 작성하기</legend>
												<div class="field">
													<p class="ques1"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_cmt_evt.png" alt="1. 가장 많이 하는 빈말을 선택해주세요. " /></p>
													<ul id="select-word" class="select-word">
														<li class="word1">
															<label for="word1"><input type="radio" id="word1" name="word" value="1" checked /><span></span><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_word1_v3.png" alt="누구야 밥 한번 먹자!" /></label>
														</li>
														<li class="word2">
															<label for="word2"><input type="radio" id="word2" name="word" value="2" /><span></span><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_word2_v3.png" alt="누구야 술 한잔 하자!" /></label>
														</li>
														<li class="word3">
															<label for="word3"><input type="radio" id="word3"name="word" value="3" /><span></span><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_word3_v3.png" alt="누구야 커피 마시자!" /></label>
														</li>
													</ul>
													<div class="textarea">
														<p class="ques2"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_cmt_evt2.png" alt="2. 이름과 번호, 명함이 필요한 이유를 적어주세요. " /></p>
														<div class="reason-box word1">
															<span class="name">이름<input type="text" placeholder="김누구" name="username" onclick="maxLengthCheck(this); return false" maxlength="16" /></span>
															<span class="phone">전화번호<input type="text" placeholder="010-0000-0000" name="hp" onclick="maxLengthCheck(this); return false" maxlength="16" /></span>
															<textarea cols="30" rows="10" title="이름과 번호, 명함이 필요한 이유 작성" name="txtcomm" placeholder="100자 이내로 입력해주세요." onclick="maxLengthCheck(this); return false" maxlength="100"></textarea>
														</div>
													</div>
													<button class="btn-submit tMar20" onclick="jsSubmitComment(document.frmcom);return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/btn_submit.png" alt="응모하기" /></button>
												</div>
											</fieldset>
										</form>
										<form name="frmdelcom" method="post" action = "/playing/sub/doEventSubscriptvol027.asp" style="margin:0px;">
											<input type="hidden" name="eventid" value="<%=eCode%>">
											<input type="hidden" name="mode" value="del">
											<input type="hidden" name="Cidx" value="">
											<input type="hidden" name="pagereload" value="ON">
										</form>
									</div>
									<div class="position" id="card_list"></div>
									<% If isArray(arrCList) Then %>
									<div class="cmt-list">
										<ul>
											<% For intCLoop = 0 To UBound(arrCList,2) %>
											<li class="word<%=arrCList(3,intCLoop)%><% If arrCList(6,intCLoop)<>"W" Then Response.write " mob" %>">
												<div class="writer">
													<span class="id"><%=printUserId(arrCList(1,intCLoop),4,"*")%></span>
													<span class="no">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
												</div>
												<p><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_cmt_<%=arrCList(3,intCLoop)%>.png" /></p>
												<div class="conts"><%=ReplaceBracket(db2html(arrCList(4,intCLoop)))%></div>
												<% if ((GetLoginUserID = arrCList(1,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(1,intCLoop)<>"") then %>
												<button type="button" class="btn-del" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol027/btn_delet.png" alt="내 글 삭제하기" /></button>
												<% End If %>
											</li>
											<% Next %>
										</ul>
										<div class="pageWrapV15 cmt-pagination">
											<%= fnDisplayPaging_New_nottextboxdirect(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
										</div>
									</div>
									<% End If %>
								</div>
								<div class="how-to">
									<div class="inner">
										<h4><img src="http://webimage.10x10.co.kr/playing/thing/vol027/tit_how_to.png" alt="진심 명함 카드 이용방법 " /></h4>
										<p><img src="http://webimage.10x10.co.kr/playing/thing/vol027/txt_how_to.png" alt="1. 반가운 지인들에게 명함에 날짜를 적어 건넵니다. (직접 만든 명함 카드도 괜찮아요!) 2. 약속한 날짜에 지인과 즐거운 시간을 보냅니다. 3. 여러분의 즐거운 시간을 인증해주세요!" /></p>
									</div>
								</div>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->