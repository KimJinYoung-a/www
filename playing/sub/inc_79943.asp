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
' Description : Playing Thing Vol.21 튜브 향초
' History : 2017-08-17 유태욱 생성
'####################################################
Dim eCode , userid, vDIdx, commentcount, pagereload
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66412
Else
	eCode   =  79943
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
.thingVol021 {text-align:center;}
.thingVol021 .inner {position:relative; width:1140px; margin:0 auto;}
.topic {height:992px; background:#f4849d url(http://webimage.10x10.co.kr/playing/thing/vol021/bg_topic.jpg) 50% 0 no-repeat;}
.topic .label {overflow:hidden; position:absolute; left:80px; top:113px;}
.topic .label img {margin-left:-188px; transition:all 1s .2s;}
.topic h2 span {display:inline-block; position:absolute; left:80px; z-index:20;}
.topic h2 .t1 {top:187px; margin-left:-20px; opacity:0; transition:all 1s .6s;}
.topic h2 .t2 {top:315px; margin-left:20px; opacity:0; transition:all 1s .6s;}
.topic h2 .deco {width:0; height:80px; left:52px; top:202px; z-index:10; background: url(http://webimage.10x10.co.kr/playing/thing/vol021/bg_brush.png) 0 0 no-repeat; transition:width .8s .8s;}
.topic .what {position:absolute; left:80px; top:425px; margin-top:8px; opacity:0; transition:all 1.5s 1.3s;}
.topic .rank {position:absolute; left:80px; top:505px;}
.topic .rank li {position:relative; left:15px; padding-bottom:10px; opacity:0; transition:all .8s 1.6s;}
.topic .rank li + li {transition-delay:1.8s;}
.topic .rank li + li + li {transition-delay:2s;}
.topic.animation .label img {margin-left:0;}
.topic.animation h2 .t1 {margin-left:0; opacity:1;}
.topic.animation h2 .t2 {margin-left:0; opacity:1;}
.topic.animation h2 .deco {width:233px;}
.topic.animation .what {margin-top:0; opacity:1;}
.topic.animation .rank li {left:0; opacity:1;}
.section1 {padding:92px 0 150px; background:url(http://webimage.10x10.co.kr/playing/thing/vol021/bg_why.png) 0 0 repeat;}
.section1 h3 {padding-bottom:62px;}
.section1 ul {overflow:hidden; width:1142px; margin:0 auto;}
.section1 li {position:relative; left:-10px; float:left; opacity:0; transition:all .5s .1s; transition-timing-function:ease-in-out;}
.section1 li + li{transition-delay:.3s;}
.section1 li + li + li {transition-delay:.4s;}
.section1 li + li + li + li {transition-delay:.5s;}
.section1 li + li + li + li + li {transition-delay:.6s;}
.section1.animation li {left:0; opacity:1;}
.section2 {height:235px; padding-top:100px; background:url(http://webimage.10x10.co.kr/playing/thing/vol021/bg_pattern.png) 0 0 repeat-x;}
.section2 .t2 {padding:28px 0 20px;}
.section2 .t3 {display:inline-block; height:61px; background:url(http://webimage.10x10.co.kr/playing/thing/vol021/txt_manicure.png) 0 0 no-repeat; text-indent:-999em;}
.section2.animation .t3 span {display:inline-block;}
.section3 {padding:110px 0 145px; background:#fff;}
.section3 h3 {padding-bottom:65px;}
.section3 .conclusion {padding:98px 0 48px;}
.section4 {padding:115px 0 120px; background:#f8f3ec;}
.section4 h3 {padding-bottom:53px;}
.section4 .cmtWrite {position:relative; overflow:hidden; width:1140px; margin:0 auto; text-align:left; background:#fff;}
.section4 .cmtWrite .submit {position:absolute; right:0; top:0;}
.section4 .cmtWrite  .answer {position:absolute; left:350px; top:72px; width:252px; height:50px; color:#000; text-align:center; font:bold 21px/1 'malgun gothic', '맑은고딕', dotum, sans-serif; border:0;}
.section4 .cmtList ul {width:966px; margin:0 auto; padding-top:84px;}
.section4 .cmtList li {overflow:hidden; position:relative; height:83px; margin-bottom:27px; background:#ff97ae; font:normal 13px/85px 'malgun gothic', '맑은고딕', dotum, sans-serif;}
.section4 .cmtList li p {float:left;}
.section4 .cmtList li .num {width:165px; height:23px; margin-top:31px; font-size:15px; font-weight:600; line-height:23px; border-right:2px solid #fff; color:#000;}
.section4 .cmtList li .txt {width:605px; height:23px; margin-top:31px; font-size:23px; line-height:21px; text-align:left; padding-left:30px; white-space:nowrap;}
.section4 .cmtList li .txt img {float:left;}
.section4 .cmtList li .txt em {float:left; padding:0 2px 0 7px; line-height:21px; color:#000; letter-spacing:-2px; font-weight:600; vertical-align:middle;}
.section4 .cmtList li .writer {float:right; width:120px; padding-right:40px; text-align:right; color:#682f36; font-weight:600; white-space:nowrap;}
.section4 .cmtList li .delete {position:absolute; right:0; top:0; height:22px; background:transparent;}
.pageWrapV15 {margin-top:60px;}
.pageWrapV15 .pageMove,.paging .first, .paging .end {display:none;}
.paging {height:29px;}
.paging a {width:44px; height:29px; margin:0; border:0;}
.paging a span {height:29px; padding:0; color:#000; font:bold 14px/29px verdana;}
.paging a.current span {color:#000; background:#ffcfd5; border-radius:15px;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging a.arrow {margin:0 10px;}
.paging a.arrow span {width:44px; background:none;}
.paging .prev, .paging .next {background:url(http://webimage.10x10.co.kr/playing/thing/vol021/btn_pagination.png) 0 0 no-repeat;}
.paging .next {background-position:100% 0;}
.volume {padding:100px 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol021/bg_vol.png) 0 0 repeat;}
.typing {width: 235px; animation:typing 1s steps(5, end);}
@keyframes typing {
	from {width:0;}
	to {width: 235px;}
}
</style>
<script style="text/javascript">
$(function(){
	$(".topic").addClass("animation");
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 850 ) {
			$(".section1").addClass("animation");
		}
		if (scrollTop > 1500 ) {
			$(".section2 .t3").addClass("typing");
		}
	});

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
		<% if date() >="2017-08-17" and date() < "2017-08-29" then %>
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

	<!-- THING. html 코딩 영역 : 클래스명은 thing+볼륨 예) thingVol001 / 이미지폴더는 볼륨을 따라 vol001 -->
	<!-- Vol.021 장바구니 탐구생활_향초편 -->
	<div class="thingVol021">
		<div class="topic">
			<div class="inner">
				<p class="label"><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_label.png" alt="장바구니 탐구생활_향초편" /></p>
				<h2>
					<span class="t1"><img src="http://webimage.10x10.co.kr/playing/thing/vol021/tit_candle_1.png" alt="향초를 사는" /></span>
					<span class="t2"><img src="http://webimage.10x10.co.kr/playing/thing/vol021/tit_candle_2.png" alt="사람들의 숨겨진 진실!" /></span>
					<span class="deco"></span>
				</h2>
				<p class="what"><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_what.png" alt="향초를 산 사람들의 장바구니에 가장 많이 담겨있던 물건은 뭘까?" /></p>
				<ol class="rank">
					<li><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_rank_1.png" alt="1위 캔들홀더/디퓨저" /></li>
					<li><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_rank_2.png" alt="2위 포장지/꽃" /></li>
					<li><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_rank_3.png" alt="3위 책" /></li>
				</ol>
			</div>
		</div>
		<div class="section section1">
			<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol021/tit_why.gif" alt="예상했던 결과들과 달리, 이 물건들은 도대체 왜?" /></h3>
			<ul>
				<li><img src="http://webimage.10x10.co.kr/playing/thing/vol021/img_why_1.png" alt="매니큐어" /></li>
				<li><img src="http://webimage.10x10.co.kr/playing/thing/vol021/img_why_2.png" alt="악세사리" /></li>
				<li><img src="http://webimage.10x10.co.kr/playing/thing/vol021/img_why_3.png" alt="풍선" /></li>
				<li><img src="http://webimage.10x10.co.kr/playing/thing/vol021/img_why_4.png" alt="고기" /></li>
				<li><img src="http://webimage.10x10.co.kr/playing/thing/vol021/img_why_5.png" alt="반려동물 간식" /></li>
			</ul>
		</div>
		<div class="section section2">
			<p class="t1"><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_cart_1.png" alt="고기? 매니큐어? 반려동물 간식? 향초와 함께 담은 예상외의 장바구니 물건들!" /></p>
			<p class="t2"><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_cart_2.png" alt="가장 많이 담은 의외의 물건 매니큐어!" /></p>
			<p class="t3"></p>
		</div>
		<div class="section section3">
			<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol021/tit_question.gif" alt="예상했던 결과들과 달리, 이 물건들은 도대체 왜?" /></h3>
			<div><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_talk.png" alt="" /></div>
			<p class="conclusion"><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_conclusion.png" alt="의견을 모아본 결과, 매니큐어의 냄새를 잡으려고 함께 샀을 것이라는 의견이 가장 많았습니다" /></p>
			<a href="/event/eventmain.asp?eventid=79943" target="_blank"><img src="http://webimage.10x10.co.kr/playing/thing/vol021/btn_item.png" alt="매니큐어&amp;향초 추천 아이템 보기" /></a>
		</div>
		<!-- COMMENT -->
		<div class="section section4" >
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
				<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_comment.jpg" alt="향초는 매니큐어와 함께, 그렇다면 매니큐어는 무엇과 함께 주문하시나요? " /></h3>
				<div class="cmtWrite">
					<p id="commentList"><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_buy.png" alt="나는 매니큐어 살 때," /></p>
					<input type="text" class="answer" id="txtcomm" name="txtcomm" placeholder="10자이내로 입력해주세요." onclick="maxLengthCheck(this); return false" maxlength="10" />
					<button class="submit" onclick="jsSubmitComment(document.frmcom);return false;" ><img src="http://webimage.10x10.co.kr/playing/thing/vol021/btn_submit.png" alt="응모하기" /></button>
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
				<div class="cmtList">
					<ul>
						<% For intCLoop = 0 To UBound(arrCList,2) %>
							<li>
								<p class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
								<p class="txt">
									<img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_cmt_1.png" alt="나는 매니큐어 살 때," />
									<em><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></em>
									<img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_cmt_2.png" alt="과(와) 함께 사요" />
								</p>
								<p class="writer"><%=printUserId(arrCList(2,intCLoop),4,"*")%>님</p>
								<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
									<button class="delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol021/btn_delete.png" alt="삭제" /></button>
								<% End If %>
							</li>
						<% next %>
					</ul>
					<div class="pageWrapV15">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				</div>
			<% end if %>
		</div>
		<!--// COMMENT -->
		<!-- volume -->
		<div class="volume">
			<p><img src="http://webimage.10x10.co.kr/playing/thing/vol021/txt_vol_021.png" alt="강아지 간식과 삼겹살은 도대체 왜 같이 샀을까? 아무리 머리를 맞대고 고민해도 결론을 찾을 수 없었습니다. 혹시 이유를 아시는 분은 플레잉 인스타그램[@10x10playing]으로 메시지 주세요.(정말 궁금합니다! 추첨을 통해 소정의 선물을 드리겠습니다)" /></p>
		</div>
	</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->