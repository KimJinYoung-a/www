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
' Description : PLAYing 백문이 불여일수
' History : 2017-02-10 이종화 생성
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
	eCode   =  76172
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

iCPerCnt = 8		'보여지는 페이지 간격
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
.signs {text-align:center;}
.signs button {background-color:transparent;}
.signs textarea::-webkit-input-placeholder {color:#fff;}
.signs textarea::-moz-placeholder {color:#fff;} /* firefox 19+ */
.signs textarea:-ms-input-placeholder {color:#fff;} /* ie */
.signs textarea:-moz-placeholder {color:#fff;}

.signs .topic {position:relative; height:859px; background:#eae6db url(http://webimage.10x10.co.kr/playing/thing/vol008/img_hand_animation.gif) 50% 0 no-repeat;}
.signs .topic h2 {position:absolute; top:231px; left:50%; width:385px; height:215px; margin-left:-216px;}
.signs .topic h2 span {display:block;}
.signs .topic h2 .letter2 {margin-top:27px; text-align:left;}
.signs .topic h2 .letter3 {position:absolute; top:98px; right:0;}

.signs .topic h2 .letter1 {animation:slideUp 1.2s 1; animation-fill-mode:both; }
.signs .topic h2 .letter2 {animation:slideUp 1.2s 1; animation-fill-mode:both; animation-delay:0.3s;}
@keyframes slideUp {
	0% {transform:translateY(10px); opacity:0;}
	100% {transform:translateY(0); opacity:1;}
}
.signs .topic h2 .letter3 {animation:rotate 2s; -webkit-animation:rotate 2s;}
@keyframes rotate {
	0% {transform:rotateZ(-180deg) scale(0.2); opacity:0;}
	100% {transform:rotateZ(0) scale(1); opacity:1;}
}
.signs .topic p {padding-top:470px;}

.signs .story {padding:110px 0 128px; background-color:#27333f;}
.signs .story .inner {overflow:hidden; width:1371px; margin:78px auto 0;}
.signs .story .scene {overflow:hidden; float:left; position:relative; width:369px; margin:0 44px; text-align:center;}
.signs .story .scene .off p {position:relative;}
.signs .story .scene .off .ani {overflow:hidden; position:absolute; top:54px; left:5px; height:455px;}
.signs .story .scene02 .off .ani {left:8px;}
.signs .story .scene03 .off .ani {top:55px; left:7px;}
.signs .story .scene .on {position:absolute; top:53px;}
.signs .story .scene01 .on {right:7px;}
.signs .story .scene02 .on {left:7px;}
.signs .story .scene03 .on {left:7px;}

.signs .story .scene > div {position:relative;}
.signs .story .scene .btnSign,
.signs .story .scene .btnBack {position:absolute; top:0; left:0; width:359px; height:570px;}
.signs .story .scene .btnSign {top:53px;}
.signs .story .scene .btnSign img,
.signs .story .scene .btnBack img {position:absolute; bottom:40px; left:50%; margin-left:-26px;}
.signs .story .scene .btnSign:focus,
.signs .story .scene .btnSign:hover {animation:twinkle infinite 0.7s;}
.signs .story .scene .btnSign img {margin-left:-43px;}
@keyframes twinkle {
	0% {opacity:0.1;}
	50% {opacity:1;}
	100% {opacity:0.1;}
}

.bounce {animation:bounce 5 0.7s; animation-delay:0.5s;}
@keyframes bounce {
	from, to{margin-bottom:0; animation-timing-function:ease-out;}
	50% {margin-bottom:5px; animation-timing-function:ease-in;}
}

.signs .goods {position:relative; background:#ece9de url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_goods.jpg) 50% 0 no-repeat;}
.signs .goods h3 {position:absolute; top:187px; left:50%; margin-left:-510px;}

.signs .wideSwipe .swiper-container,
.signs .wideSwipe .swiper-slide img {height:610px;}
.signs .wideSwipe .swiper-slide {width:1134px;}
.signs .wideSwipe .pagination span {transition:all 0.5s;}
.wideSwipe .mask {background-color:#3a5062; opacity:0.9; filter:alpha(opacity=90);}
.wideSwipe .mask.left {margin-left:-567px;}
.wideSwipe .mask.right {margin-left:567px;}

.signs .comment {padding:146px 0 106px; background:#eae6db url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_chinese_character.png) 50% 0 no-repeat;}
.signs .comment .form .field {overflow:hidden; position:relative; width:982px; height:583px; margin:50px auto 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_comment_box.png) no-repeat 50% 0;}
.signs .comment .form .field ul {overflow:hidden; float:left; width:511px; padding:46px 0 0 57px;}
.signs .comment .form .field ul li {float:left; margin:0 11px 23px 0;}
.signs .comment .form .field ul li.card01 {padding-left:75px;}
.signs .comment .form .field ul li label {display:block; margin-bottom:6px;}
.signs .comment .form .field ul li.card04 {clear:left; padding-left:21px;}
.signs .comment .form .field ul li.card08 {clear:left;}
.signs .comment .form .field ul li input {vertical-align:top;}
.signs .comment .form .textarea {float:left; width:414px;}
.signs .comment .form .btnSubmit,
.signs .comment .form .btnDone {position:absolute; right:63px; bottom:60px;}
.signs .comment .form .btnDone {right:64px; bottom:72px;}

.signs .comment .textarea p {height:210px; background:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_01.png) no-repeat 50% 0; transition:background 0.5s;}
.signs .comment .textarea .bg01 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_01.png);}
.signs .comment .textarea .bg02 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_02.png);}
.signs .comment .textarea .bg03 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_03.png);}
.signs .comment .textarea .bg04 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_04.png);}
.signs .comment .textarea .bg05 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_05.png);}
.signs .comment .textarea .bg06 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_06.png);}
.signs .comment .textarea .bg07 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_07.png);}
.signs .comment .textarea .bg08 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_08.png);}
.signs .comment .textarea .bg09 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_09.png);}
.signs .comment .textarea .bg10 {background-image:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_10.png);}

.signs .comment .textarea textarea {overflow:hidden; width:248px; height:200px; margin-top:-10px; padding:0 15px; border:0; background-color:transparent; color:#fff; font-size:16px; font-weight:bold; line-height:49px; text-align:center;}
.signs .comment .textarea .btnSubmit,
.signs .comment .textarea .btnDone {position:absolute; top:82px; right:96px;}

.signs .commentList {margin-top:71px;}
.signs .commentList ul {overflow:hidden; width:1347px; margin:0 auto;}
.signs .commentList ul li {float:left; position:relative; width:220px; height:158px; margin:16px 8px 0; padding:35px 33px 0 180px; background:url(http://webimage.10x10.co.kr/playing/thing/vol008/bg_card_comment.png) no-repeat 50% 0; font-size:12px; text-align:left;}
.signs .commentList ul li.bg01 {background-position:50% 0;}
.signs .commentList ul li.bg02 {background-position:50% -193px;}
.signs .commentList ul li.bg03 {background-position:50% -386px;}
.signs .commentList ul li.bg04 {background-position:50% -579px;}
.signs .commentList ul li.bg05 {background-position:50% -772px;}
.signs .commentList ul li.bg06 {background-position:50% -965px;}
.signs .commentList ul li.bg07 {background-position:50% -1158px;}
.signs .commentList ul li.bg08 {background-position:50% -1351px;}
.signs .commentList ul li.bg09 {background-position:50% -1544px;}
.signs .commentList ul li.bg10 {background-position:50% 100%;}

.signs .commentList ul li .writer {position:relative; margin-top:18px;}
.signs .commentList ul li .writer .id {color:#183651;}
.signs .commentList ul li .writer .id span {font-weight:bold;}
.signs .commentList ul li .writer .no {position:absolute; top:0; right:0; color:#c9ba91;}
.signs .commentList ul li .btndel {position:absolute; top:-11px; right:-11px;}
.signs .commentList ul li .btndel img {transition:transform .7s ease;}
.signs .commentList ul li .btndel:hover img {transform:rotate(-180deg);}
.signs .commentList ul li  p {height:90px; color:#6f6d6d; font-size:12px; line-height:20px;}

.pageWrapV15 {margin-top:42px;}
.pageWrapV15 .pageMove {display:none;}
.paging a {width:44px; height:34px; margin:0; border:0;}
.paging a span {height:34px; padding:0; color:#7a7a7a; font-family:Dotum, '돋움', Verdana; font-size:14px; line-height:34px;}
.paging a.current span {background:url(http://webimage.10x10.co.kr/playing/thing/vol008/btn_pagination.png) 50% 0 no-repeat;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging .first, .paging .end {display:none;}
.paging a.arrow span {background:none;}
.paging a.current span {color:#ffeedb; font-weight:normal;}
.paging .prev, 
.paging .next {background:url(http://webimage.10x10.co.kr/playing/thing/vol008/btn_pagination.png) 50% -34px no-repeat;}
.paging .next {background-position:50% 100%;}

.signs .volume {background-color:#2c3942;}
</style>
<script type="text/javascript">
$(function(){
$("#story .scene .on").hide();
	$("#story .scene02 .on, #story .scene03 .on").css({"margin-left":"-50%"});
	$("#story .scene01 .on").css({"margin-right":"-50%"});

	$("#story .scene .btnSign").on("click", function(e){
		$(".btnBack img").addClass("bounce");
		if ( $(this).parent().parent().hasClass("scene01")) {
			$(this).parent().next().show();
			$(this).parent().next().animate({"margin-right":"0"},500);
			$("#story .scene .line").hide();
			return false;
		} else {
			$(this).parent().next().show();
			$(this).parent().next().animate({"margin-left":"0"},400);
			$("#story .scene .line").hide();
			return false;
		}
	});

	$("#story .scene .btnBack").on("click", function(e){
		$(".btnBack img").removeClass("bounce");
		if ( $(this).parent().parent().hasClass("scene01")) {
			$(this).parent().animate({"margin-right":"-100%"},500);
			$("#story .scene .line").show();
			return false;
		} else {
			$(this).parent().animate({"margin-left":"-100%"},400);
			$("#story .scene .line").show();
			return false;
		}
	});

	// wide swipe
	var evtSwiper = new Swiper('#wideSwipe .swiper-container',{
		loop:true,
		slidesPerView:'auto',
		centeredSlides:true,
		speed:1400,
		autoplay:3500,
		simulateTouch:false,
		pagination:'#wideSwipe .pagination',
		paginationClickable:true,
		nextButton:'#wideSwipe .btnNext',
		prevButton:'#wideSwipe .btnPrev'
	})
	$('#wideSwipe .btnPrev').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipePrev();
	});
	$('#wideSwipe .btnNext').on('click', function(e){
		e.preventDefault();
		evtSwiper.swipeNext();
	});

	/* label select */
	$("#cardSelect label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});

	$("#cardSelect li label, #cardSelect li input").on("click", function(e){
		frmcom.spoint.value = $(this).attr("val");
		$(".comment .textarea p").removeClass();
		if ( $(this).parent().hasClass("card01")) {
			$(".comment .textarea p").addClass("bg01");
		}
		if ( $(this).parent().hasClass("card02")) {
			$(".comment .textarea p").addClass("bg02");
		}
		if ( $(this).parent().hasClass("card03")) {
			$(".comment .textarea p").addClass("bg03");
		}
		if ( $(this).parent().hasClass("card04")) {
			$(".comment .textarea p").addClass("bg04");
		}
		if ( $(this).parent().hasClass("card05")) {
			$(".comment .textarea p").addClass("bg05");
		}
		if ( $(this).parent().hasClass("card06")) {
			$(".comment .textarea p").addClass("bg06");
		}
		if ( $(this).parent().hasClass("card07")) {
			$(".comment .textarea p").addClass("bg07");
		}
		if ( $(this).parent().hasClass("card08")) {
			$(".comment .textarea p").addClass("bg08");
		}
		if ( $(this).parent().hasClass("card09")) {
			$(".comment .textarea p").addClass("bg09");
		}
		if ( $(this).parent().hasClass("card10")) {
			$(".comment .textarea p").addClass("bg10");
		}
	});
});

$(function(){
	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>
});


function pagedown(){
	window.$('html,body').animate({scrollTop:$(".commentList").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if date() >="2017-02-13" and date() <= "2017-02-22" then %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (!frm.spoint.value){
					alert('원하는 손 모양을 선택해 주세요.');
					return false;
				}
			
				if(!frm.txtcomm.value){
					alert("팁을 남겨주세요!");
					document.frmcom.txtcomm.value="";
					frm.txtcomm.focus();
					return false;
				}

				if (GetByteLength(frm.txtcomm.value) > 160){
					alert("제한길이를 초과하였습니다. 80자 까지 작성 가능합니다.");
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
<div class="thingVol008 signs">
	<div class="section topic">
		<h2>
			<span class="letter letter1"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/tit_signs_01.png" alt="백문이" /></span>
			<span class="letter letter2"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/tit_signs_02.png" alt="불여일" /></span>
			<span class="letter letter3"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/tit_signs_03.png" alt="수" /></span>
		</h2>
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_situation.png" alt="백 번 말하는 것 보다 한 번 손짓 하는 게 낫다 때로는 말 대신 손으로 표현해야할 때가 있죠. 말보다 손짓 카드로 필요한 상황에 센스있게 소통하세요! 이런 상황에 이렇게!" /></p>
	</div>

	<div id="story" class="section story">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_click.png" alt="카드를 클릭해 주세요!" /></p>
		<div class="inner">
			<div class="scene scene01">
				<div id="scene011" class="off">
					<p>
						<img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_story_01_01.png" alt="회사편 나신입, 날이 춥지? 오리가 얼면? 언덕! 팀장님의 아재개그" />
						<span class="ani"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_story_01_01_v1.gif" alt="" /></span>
					</p>
					<a href="#scene011" class="btnSign"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/btn_sign_01.png" alt="필요한 손짓?" /></a>
				</div>
				<div id="scene012" class="on">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_story_01_02.png" alt="팀장님..조..존..경합니다!!! (사실은 뒤집고 싶다)" /></p>
					<a href="#scene012" class="btnBack"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/btn_back.png" alt="Back" /></a>
				</div>
			</div>

			<div class="scene scene02">
				<div id="scene021" class="off">
					<p>
						<img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_story_02_01.png" alt="대학편 동기와의 몰래 접선" />
						<span class="ani"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_story_02_01.gif" alt="" /></span>
					</p>
					<a href="#scene021" class="btnSign"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/btn_sign_02.png" alt="필요한 손짓?" /></a>
				</div>
				<div id="scene022" class="on">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_story_02_02.png" alt="(말안해도 센스있게) 티안나게 나와주길" /></p>
					<a href="#scene022" class="btnBack"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/btn_back.png" alt="Back" /></a>
				</div>
			</div>

			<div class="scene scene03">
				<div id="scene031" class="off">
					<p>
						<img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_story_03_01.png" alt="연애편 질투나는 남친의 행동" />
						<span class="ani"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_story_03_01.gif" alt="" /></span>
					</p>
					<a href="#scene031" class="btnSign"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/btn_sign_03.png" alt="필요한 손짓?" /></a>
				</div>
				<div id="scene032" class="on">
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_story_03_02.png" alt="카드를 얼굴에 올리고 웃자 (쿨내 나는 나란 여자)" /></p>
					<a href="#scene032" class="btnBack"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/btn_back.png" alt="Back" /></a>
				</div>
			</div>
		</div>
	</div>

	<div class="section goods">
		<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol008/tit_goods.png" alt="여러분의 상황을 대신해줄 백문이불여일수 카드&amp;포스터를 만나보세요! " /></h3>
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol008/img_goods.jpg" alt="엽서카드 10종 100x148 mm, 포스터 3종 297x420 mm 포스터는 두번 접어 발송됩니다." /></p>

		<!-- swipe -->
		<div id="wideSwipe" class="slideTemplateV15 wideSwipe">
			<div class="swiper-container">
				<div class="swiper-wrapper">
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/img_slide_01.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/img_slide_02.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/img_slide_03.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/img_slide_04.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/img_slide_05.jpg" alt="" /></div>
					<div class="swiper-slide"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/img_slide_06.jpg" alt="" /></div>
				</div>
				<div class="pagination"></div>
				<button class="slideNav btnPrev">이전</button>
				<button class="slideNav btnNext">다음</button>
				<div class="mask left"></div>
				<div class="mask right"></div>
			</div>
		</div>
	</div>

	<div class="section comment">
		<div class="form">
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
				<fieldset>
				<legend>어떤 상황에서 백문이불여일수 어떤 카드를 쓸지 선택하고 팁 작성하기</legend>
					<p><img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_comment.png" alt="백문이불여일수 카드를 어떤 상황에 쓸지 팁을 남겨주세요! 센스있는 사용팁을 남긴 100분께 백문이불여일수 카드&amp;포스터 세트를 드립니다. 이벤트기간 2월 13일부터 2월 22일까지, 당첨자 발표 2월 23일" /></p>
					<div class="field">
						<ul id="cardSelect" class="cardSelect">
							<li class="card01">
								<label for="card01" val="1"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/img_card_01.png" alt="주먹" /></label>
								<input type="radio" id="card01" name="card" val="1" />
							</li>
							<li class="card02">
								<label for="card02" val="2"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/img_card_02.png" alt="검지" /></label>
								<input type="radio" id="card02" name="card" val="2" />
							</li>
							<li class="card03">
								<label for="card03" val="3"><img src="http://webimage.10x10.co.kr/playing/thing/vol008//img_card_03.png" alt="새끼 손가락" /></label>
								<input type="radio" id="card03" name="card" val="3" />
							</li>
							<li class="card04">
								<label for="card04" val="4"><img src="http://webimage.10x10.co.kr/playing/thing/vol008//img_card_04.png" alt="엄지척" /></label>
								<input type="radio" id="card04" name="card" val="4" />
							</li>
							<li class="card05">
								<label for="card05" val="5"><img src="http://webimage.10x10.co.kr/playing/thing/vol008//img_card_05.png" alt="오케이" /></label>
								<input type="radio" id="card05" name="card" val="5" />
							</li>
							<li class="card06">
								<label for="card06" val="6"><img src="http://webimage.10x10.co.kr/playing/thing/vol008//img_card_06.png" alt="" /></label>
								<input type="radio" id="card06" name="card" val="6" />
							</li>
							<li class="card07">
								<label for="card07" val="7"><img src="http://webimage.10x10.co.kr/playing/thing/vol008//img_card_07.png" alt="하트" /></label>
								<input type="radio" id="card07" name="card" val="7" />
							</li>
							<li class="card08 other">
								<label for="card08" val="8"><img src="http://webimage.10x10.co.kr/playing/thing/vol008//img_card_08.png" alt="" /></label>
								<input type="radio" id="card08" name="card" val="8" />
							</li>
							<li class="card09 other">
								<label for="card09" val="9"><img src="http://webimage.10x10.co.kr/playing/thing/vol008//img_card_09.png" alt="" /></label>
								<input type="radio" id="card09" name="card" val="9" />
							</li>
							<li class="card10 other">
								<label for="card10" val="10"><img src="http://webimage.10x10.co.kr/playing/thing/vol008//img_card_10.png" alt="" /></label>
								<input type="radio" id="card10" name="card" val="10" />
							</li>
						</ul>

						<div class="textarea">
							<p><img src="http://webimage.10x10.co.kr/playing/thing/vol008//txt_signs.png" alt="이럴때 이 손짓!" /></p>
							<textarea cols="50" rows="6" title="어떤 상황에서 백문이불여일수 카드를 쓸지 팁 작성" placeholder="80자 이내로 입력해주세요!" id="txtcomm" name="txtcomm" onClick="jsCheckLimit();"></textarea>
						</div>
						<% If commentcount < 5 Then %>
						<div class="btnSubmit"><input type="image" src="http://webimage.10x10.co.kr/playing/thing/vol008/btn_submit.png" alt="응모하기" onclick="jsSubmitComment(document.frmcom);return false;"/></div>
						<% Else %>
						<div class="btnDone"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/btn_done.png" alt="응모완료" onclick="jsSubmitComment(document.frmcom);return false;"/></div>
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
		
		<% IF isArray(arrCList) THEN %>
		<div class="commentList">
			<ul>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
				<li class="bg<%=chkiif(arrCList(3,intCLoop)<10,"0","")%><%=arrCList(3,intCLoop)%>">
					<p><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
					<div class="writer">
						<span class="id">
							<% If arrCList(8,intCLoop) <> "W" Then %><img src="http://webimage.10x10.co.kr/playing/thing/vol008/m/ico_mobile.png" alt="모바일에서 작성된 글" /> <% End If %><%=printUserId(arrCList(2,intCLoop),4,"*")%>
						</span>
						<span class="no">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
					</div>
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<button type="button" class="btndel" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol008/btn_delete.png" alt="내 글 삭제하기" /></button>
					<% End If %>
				</li>
				<% Next %>
			</ul>
			
			<div class="pageWrapV15">
				<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
			</div>
		</div>
		<% End If %>
	</div>

	<div class="seciton volume">
		<p><img src="http://webimage.10x10.co.kr/playing/thing/vol008/txt_vol008.png" alt="Volume 8 Thing의 사물에 대한 생각 때로는 말보다 손짓이 강하다" /></p>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->