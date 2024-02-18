<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
'####################################################
' Description : Playing Thing Vol.20 튜브 향초
' History : 2017-07-20 유태욱 생성
'####################################################
Dim eCode , userid, vDIdx, commentcount, pagereload
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66400
Else
	eCode   =  79429
End If

vDIdx = request("didx")
userid	= getencLoginUserid()

If userid <> "" then
	commentcount = getcommentexistscount(userid, eCode, "", "", "", "Y")
Else
	commentcount = 0
End If 

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

iCPerCnt = 10		'보여지는 페이지 간격
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
.thingVol020 {overflow:hidden; text-align:center;}

.tubeMain {height:1284px; position:relative; background-color:#fefc5a;}
.tubeMain h2 {position:relative; padding:172px 0 48px;}
.tubeMain h2 .t1 {margin-bottom:20px;}
.tubeMain h2 .t1> img{position:relative; z-index:10;}
.tubeMain h2 .t1 span {position:absolute; top:202px; left:50%; z-index:0; margin-left:-205px;}
.tubeMain span {display:block;}
.tubeMain .subcp1 {position:absolute; top:108px; left:50%; margin-left:-84px;}
.tubeMain ol {position:absolute; top:503px; left:50%; z-index:30; width:767px; height:777px; margin-left:-320px; background:url(http://webimage.10x10.co.kr/playing/thing/vol020/img_tube.png) no-repeat 0 0;}
.tubeMain ol li {position:absolute; top:19px; left:384px; width:273px; height:452px; background:url(http://webimage.10x10.co.kr/playing/thing/vol020/img_ranking_1.png) no-repeat; opacity:0;}
.tubeMain ol li:first-child + li {top:381px; left:169px; width:446px; height:248px; background:url(http://webimage.10x10.co.kr/playing/thing/vol020/img_ranking_2.png) no-repeat;}
.tubeMain ol li:first-child + li + li {top:262px; left:22px; width:245px; height:317px; background:url(http://webimage.10x10.co.kr/playing/thing/vol020/img_ranking_3.png) no-repeat;}
.tubeMain ol li:first-child + li + li + li {top:48px; left:27px; width:241px; height:246px; background:url(http://webimage.10x10.co.kr/playing/thing/vol020/img_ranking_4.png) no-repeat;}
.tubeMain ol li:first-child + li + li + li + li {top:1px; left:172px; width:164px; height:200px; background:url(http://webimage.10x10.co.kr/playing/thing/vol020/img_ranking_5.png) no-repeat;}
.tubeMain ol li:first-child + li + li + li + li + li {top:0; left:308px; width:164px; height:200px; background:none;}
.tubeMain ol li span {position:absolute; top:50%; left:133px; z-index:50; margin-top:-30px; opacity:0;}
.tubeMain ol li:first-child + li span {left:133px; margin-top:-0px;}
.tubeMain ol li:first-child + li + li span {top:68%; left:-150px;}
.tubeMain ol li:first-child + li + li + li span {left:80px; margin-top:0;}
.tubeMain ol li:first-child + li + li + li + li span {left:69px; margin-top:-25px;}
.tubeMain ol li:first-child + li + li + li + li + li span {left:40px; margin-top:-30px;}
.tubeMain ol li:first-child + li + li .deco {overflow:hidden; display:inline-block; position:absolute; top:45%; left:-50px; z-index:70;}
.tubeMain ol li:first-child + li + li .deco2 {width:0; top:24px; left:-15px;}
.tubeMain ol li:first-child + li + li .deco3 {height:0; top:179px; left:131px;}
.tubeMain .rankingList {position:absolute; top:858px; left:50%; z-index:90; margin-left:366px;}
.tubeMain .bg div {position:absolute; top:0; left:0; z-index:0; width:100%; height:1284px; background:url(http://webimage.10x10.co.kr/playing/thing/vol020/bg_wave_1.png) no-repeat 50% 100%;}
.tubeMain .bg .wave2 {top:0; left:0; background-image:url(http://webimage.10x10.co.kr/playing/thing/vol020/bg_wave_2.png);}

.introTube {background-color:#373737; padding:109px 0; background:#343434 url(http://webimage.10x10.co.kr/playing/thing/vol020/bg_black.jpg) no-repeat 0 0;}
.introTube p.t1 {padding-bottom:32px;}
.introTube .t2 { width: 531px; margin:0 auto; overflow: hidden; border-right: .1em solid black;}

.whyCandle {background-color:#fff; padding:100px 0 105px;}
.whyCandle h3 {margin-bottom:85px;}
.whyCandle .conclusion {margin:115px 0 35px;}

.whatOrder {padding:42px 0 123px; background-color:#f0f0f0;}
.whatOrder h3 {margin-bottom:40px;}
.whatOrder h3 img {margin-left:140px;}
.whatOrder .cmtEvt .enter {position:relative; width:1139px; margin:0 auto;}
.whatOrder .cmtEvt .enter input {position:absolute; top:54px; left:286px; width:245px;height:89px; padding:0 45px; line-height:89px; font-size:30px; font-weight:bold; color:#000; background-color:transparent; text-align:center;}
.whatOrder .cmtEvt .enter input::-input-placeholder {font-size:17px; color:#a7a7a7;}
.whatOrder .cmtEvt .enter input::-webkit-input-placeholder {font-size:17px; color:#a7a7a7;}
.whatOrder .cmtEvt .enter input::-moz-placeholder {font-size:17px; color:#a7a7a7;}
.whatOrder .cmtEvt .enter input:-ms-input-placeholder {font-size:17px; color:#a7a7a7;}
.whatOrder .cmtEvt  .enter input:-moz-placeholder {font-size:17px; color:#a7a7a7;}
.whatOrder .cmtEvt .enter button {position:absolute; top:0; right:0;}
.whatOrder .cmtEvt ul {width:966px; margin:80px auto 0;}
.whatOrder .cmtEvt ul li {display:table; position:relative;  width:966px; height:83px; margin-bottom:26px; background-color:#feea4d; font-family:dotum, dotumche, '돋움', '돋움체', verdana, tahoma, sans-serif; color:#6b6112;}
.whatOrder .cmtEvt ul li span {display:table-cell; vertical-align:middle; color:#000; font-weight:bold;}
.whatOrder .cmtEvt ul li .num {width:172px; font-size:12px;}
.whatOrder .cmtEvt ul li .conts {position:relative; width:612px; padding-left:45px; font-size:24px; line-height:24px; text-align:left;}
.whatOrder .cmtEvt ul li .conts:before {display:inline-block; position:absolute; top:30px; left:0; content:' '; width:2px; height:24px; background-color:#fff;}
.whatOrder .cmtEvt ul li .conts strong {overflow:hidden; display:inline-block; max-width:250px; max-height:24px;}
.whatOrder .cmtEvt ul li .userId {text-align:left; color:#625b20;}
.whatOrder .cmtEvt ul li .close {position:absolute; top:0; right:0;}
.whatOrder .cmtEvt .pageWrapV15 {height:29px; margin-top:55px;}
.whatOrder .cmtEvt .pageWrapV15 .pageMove {display:none;}
.whatOrder .cmtEvt .paging {height:100%; background-position:}
.whatOrder .cmtEvt .paging a {width:44px; height:29px; background-color:transparent; border-radius:13px; border:none; font-weight:bold;}
.whatOrder .cmtEvt .paging a.current span {background-color:#fff; }
.whatOrder .cmtEvt .paging a span {height:29px; line-height:29px; color:#000;}
.whatOrder .cmtEvt .paging a.arrow span {line-height:29px; background:transparent url(http://webimage.10x10.co.kr/playing/thing/vol020/btn_pagination.gif) no-repeat 0 0;}
.whatOrder .cmtEvt .paging a.next span {margin-left:20px; background-position:100% 100%;}

.moveLeft {animation:moveLeft .7s 6;}
@keyframes moveLeft{
	from,to {transform:translateX(0);}
	50% {transform:translateX(5px);}
}
.bounce{animation:bounce 1.2s 20;}
@keyframes bounce{
	from,to {transform:translateY(0);}
	50% {transform:translateY(10px);}
}
.typing {animation: typing .8s steps(14, end), blink-caret2 1s step-end 50; animation: typing 2.5s steps(14, end), blink-caret2 1s step-end 50;}
@keyframes typing {
	from {width: 0}
	to {width: 531px}
}
@keyframes blink-caret {
	from, to {border-color: transparent}
	50% {border-color: black}
}

input[type=text]::-ms-clear {
display:none;
}
</style>
<script style="text/javascript">
$(function(){
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		var chart = $(".tubeMain ol").offset().top - 700;
		var intro = $(".introTube").offset().top - 500;
		if (scrollTop > chart) {
			tubeAni();
		}
		if (scrollTop > intro) {
			typing();
		}
	});

	titleAnimation();
	$("h2 .t1").css({"margin-left":"-20px","opacity":"0"});
	$("h2 .t1 span").css({"width":"0","opacity":"0"});

	$("h2 .t2").css({"margin-left":"20px","opacity":"0"});
	function titleAnimation() {
		$("h2 .t1").delay(100).animate({"margin-left":"5px","opacity":"1"},600);
		$("h2 .t1 span").delay(500).animate({"width":"215px","opacity":"1"},600);
		$("h2 .t2").delay(350).animate({"margin-left":"-5px","opacity":"1"},600);
	}
	
	$(".tubeMain ol li").css({"opacity":"0"});
	$(".tubeMain ol li span").css({"opacity":"0"});
	$(".tubeMain ol li .deco2").css({"width":"0"});
	$(".tubeMain ol li .deco3").css({"height":"0"});
	function tubeAni() {
		$(".tubeMain ol li:nth-child(1)").animate({"opacity":"1"},200);
		$(".tubeMain ol li:nth-child(2)").delay(100).animate({"opacity":"1"},200);
		$(".tubeMain ol li:nth-child(3)").delay(400).animate({"opacity":"1"},200);
		$(".tubeMain ol li:nth-child(4)").delay(700).animate({"opacity":"1"},200);
		$(".tubeMain ol li:nth-child(5)").delay(900).animate({"opacity":"1"},200);
		$(".tubeMain ol li:nth-child(6)").delay(1200).animate({"opacity":"1"},200);

		$(".tubeMain ol li:nth-child(1) span").delay(1200).animate({"opacity":"1"},200);
		$(".tubeMain ol li:nth-child(2) span").delay(1500).animate({"opacity":"1"},200);
		$(".tubeMain ol li:nth-child(3) .txt").delay(3300).addClass("bounce").animate({"opacity":"1"},200);
		$(".tubeMain ol li:nth-child(4) span").delay(1800).animate({"opacity":"1"},200);
		$(".tubeMain ol li:nth-child(5) span").delay(2000).animate({"opacity":"1"},200);
		$(".tubeMain ol li:nth-child(6) span").delay(2200).animate({"opacity":"1"},200);

		$(".tubeMain ol li .deco1").delay(3200).addClass("moveLeft").animate({"opacity":"1"},200);
		$(".tubeMain ol li .deco2").delay(2600).animate({"width":"223px","opacity":"1"},600);
		$(".tubeMain ol li .deco3").delay(2600).animate({"height":"190px","opacity":"1"},600);
	}

	$(".tubeMain ol li .deco3").css({"height":"0"});
	function tubeAni() {
		$(".tubeMain ol li:nth-child(1)").animate({"opacity":"1"},300);
		$(".tubeMain ol li:nth-child(2)").delay(200).animate({"opacity":"1"},300);
		$(".tubeMain ol li:nth-child(3)").delay(500).animate({"opacity":"1"},300);
		$(".tubeMain ol li:nth-child(4)").delay(800).animate({"opacity":"1"},300);
		$(".tubeMain ol li:nth-child(5)").delay(1000).animate({"opacity":"1"},300);
		$(".tubeMain ol li:nth-child(6)").delay(1300).animate({"opacity":"1"},300);

		$(".tubeMain ol li:nth-child(1) span").delay(1300).animate({"opacity":"1"},300);
		$(".tubeMain ol li:nth-child(2) span").delay(1600).animate({"opacity":"1"},300);
		$(".tubeMain ol li:nth-child(3) .txt").delay(3400).addClass("bounce").animate({"opacity":"1"},300);
		$(".tubeMain ol li:nth-child(4) span").delay(1900).animate({"opacity":"1"},300);
		$(".tubeMain ol li:nth-child(5) span").delay(2100).animate({"opacity":"1"},300);
		$(".tubeMain ol li:nth-child(6) span").delay(2300).animate({"opacity":"1"},300);

		$(".tubeMain ol li .deco1").delay(3200).addClass("moveLeft").animate({"opacity":"1"},300);
		$(".tubeMain ol li .deco2").delay(2600).animate({"width":"223px","opacity":"1"},600);
		$(".tubeMain ol li .deco3").delay(2600).animate({"height":"190px","opacity":"1"},600);
	}

	$(".introTube .t2").css({"opacity":"0"});
	function typing() {
		$(".introTube .t2").animate({"opacity":"1"}).addClass("typing");
	}

	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>
});

function pagedown(){
	window.$('html,body').animate({scrollTop:$("#commentList").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if date() >="2017-07-20" and date() < "2017-08-07" then %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if(!frm.txtcomm.value){
					alert("내용을 적어주세요!");
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
	<!-- Vol.020 튜브를 사는 사람들은 왜 그럴까? -->
	<div class="thingVol020 whyTube">
		<div class="section tubeMain">
			<h2>
				<span class="t1">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol020/tit_tube_1.png" alt="튜브를 사는" /><span>
					<img src="http://webimage.10x10.co.kr/playing/thing/vol020/img_deco.png" alt="사람들은 왜 그럴까?" /></span>
				</span>
				<span class="t2"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/tit_tube_2.png" alt="" /></span>
			</h2>
			<p class="subcp1"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_subcp_1.png" alt="장바구니 궁금증 _ 튜브편" /></p>
			<p class="subcp2"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_subcp_2.png" alt="튜브를 샀던 사람들의 장바구니에 가장 많이 담겨있던 물건은 뭘까?" /></p>
			<ol>
				<li><span><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_ranking_1.png" alt="1위 에어펌프" /></span></li>
				<li><span><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_ranking_2.png" alt="2위 비치타올" /></span></li>
				<li>
					<span class="txt"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_ranking_3.png" alt="3위 향초" /></span>
					<span class="deco deco1"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/img_arrow.png" alt="" /></span>
					<span class="deco deco2"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/img_line_1.png" alt="" /></span>
					<span class="deco deco3"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/img_line_2.png" alt="" /></span>
				</li>
				<li><span><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_ranking_4.png" alt="4위 방수팩" /></span></li>
				<li><span><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_ranking_5.png" alt="5위 물놀이용 파우치" /></span></li>
				<li><span><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_ranking_7.png" alt="6위 기타" /></span></li>
			</ol>
			<div class="rankingList"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_ranking.png" alt="1위 에어펌프 2위 비치타올 3위 향초 4위 방수팩 5위 물놀이용 파우치 6위 기타" /> </div>
			<div class="bg">
				<div class="wave1"></div>
				<div class="wave2"></div>
			</div>
		</div>

		<div class="section introTube">
			<p class="t1"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_intro_1.png" alt="어라? 에어펌프, 비치타올, 방수팩, 물놀이용 파우치! 다 함께 주문할 것 같은 아이템들인데" /></p>
			<p class="t2"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_intro_2.png" alt="그 중 하나 3위에 속한, 향초는 왜?" /></p>
		</div>

		<div class="section whyCandle">
			<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol020/tit_why_candle.png" alt="왜 튜브를 산 사람들이 향초를 함께 주문했을까?" /></h3>
			<div><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_why_candle.png" alt="SNS를 좋아해서 여행 갔을 때, 낮엔 튜브와 함께 찍고 저녁엔 분위기 있게 향초를 피우려고 인증샷을 남기려는 건 아닐까요? 습한 곳으로 여행 가는 사람들이 튜브와 함께 사지 않았을까요? 튜브로 열심히 수영하고, 지친 몸을 팩과 함께 향초를 피우며 힐링 하려고 함께 사지 않았을까요? 그렇다면 물놀이 여행 가는 많은 사람들이 튜브와 향초를 애용한다는 것 아닐까요? " /></div>
			<div class="conclusion"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_conclusion.png" alt="의견을 모아본 결과, 습한 여행지에서 함께 주문할 것이라는 의견이 많았습니다 튜브와 향초를 함께 주문하는 그들의 의외지만 현명한 선택, 물놀이 여행에서 함께 주문해보자!" /></div>
			<a href="/event/eventmain.asp?eventid=79429"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/btn_rcm_item.png" alt="향초&튜브 추천 아이템 보기" /></a>
		</div> 

		<div class="section whatOrder">
			<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol020/tit_cmt_evt.png" alt="튜브는 향초와 함께, 그렇다면 향초는 무엇과 함께 주문하시나요? 응모기간은  2017년 07월 24일 부터 2017년 08월 06일 까지 입니다.사은품은 튜브컵 홀더 증정합니다. 추첨인원수는 20명입니다." /></h3>
			<div class="cmtEvt">
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
				<div class="enter"  id="commentList">
					<img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_cmt_box.png" alt="나는 향초 살 때, *** 과(와) 함께 사요!" />
					<input type="text" class="inpTeam" id="txtcomm" name="txtcomm" placeholder="10자이내로 입력해주세요." onclick="maxLengthCheck(this); return false" maxlength="10"/>
					<button class="btnEnter" onclick="jsSubmitComment(document.frmcom);return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/btn_enter.jpg" alt="응모하기" /></button>
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

			<% IF isArray(arrCList) THEN %>
				<ul>
					<% For intCLoop = 0 To UBound(arrCList,2) %>
						<li>
							<span class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
							<span class="conts">
								<img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_cmt_t1.png" alt="" />
								<strong><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></strong>
								<img src="http://webimage.10x10.co.kr/playing/thing/vol020/txt_cmt_t2.png" alt="" />
							</span>
							<span class="userId"><em><%=printUserId(arrCList(2,intCLoop),4,"*")%></em>님</span>
							<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
								<button class="close" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" onfocus="this.blur();"><img src="http://webimage.10x10.co.kr/playing/thing/vol020/btn_close.png" alt="" /></button>
							<% End If %>
						</li>
					<% Next %>
				</ul>
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
			<% end if %>
			</div>
		</div>
	</div>
<script style="text/javascript">
$(function(){
	$('.paging .first span').remove();
	$('.paging .end span').remove();
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->