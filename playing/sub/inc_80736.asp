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
'##################################################################
' Description : Playing Thing Vol.24 장바구니 탐구생활-매니큐어편
' History : 2017-09-21 정태훈 생성
'##################################################################
Dim eCode , userid, vDIdx, commentcount, pagereload
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66433
Else
	eCode   =  80736
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
	iCPageSize = 6		'풀단이면 15개			'/수기이벤트 둘다 강제 12고정
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
.thingVol024 {text-align:center;}
.thingVol024 .inner {position:relative; width:1140px; margin:0 auto;}
.topic {height:835px; background:#ebecee url(http://webimage.10x10.co.kr/playing/thing/vol024/bg_topic.jpg) 50% 0 no-repeat;}
.topic .label {overflow:hidden; position:absolute; left:80px; top:113px;}
.topic .label img {margin-left:-188px; transition:all 1s .2s;}
.topic h2 span {display:inline-block; position:absolute; left:80px; z-index:20;}
.topic h2 .t1 {top:193px; margin-left:-20px; opacity:0; transition:all 1s .6s;}
.topic h2 .t2 {top:284px; margin-left:20px; opacity:0; transition:all 1s .6s;}
.topic h2 .t3 {top:383px; margin-left:-20px; opacity:0; transition:all 1s .6s;}
.topic .secreat {position:absolute; left:80px; top:488px; opacity:0; transition:all 1s .6s;}
.topic h2 .deco {width:101px; height:87px; left:150px; opacity:0; top:202px; z-index:10; background: url(http://webimage.10x10.co.kr/playing/thing/vol024/deco_color.png) 0 0 no-repeat; transition:all 1.2s .8s;}
.topic .what {position:absolute; left:80px; top:567px; margin-top:8px; opacity:0; transition:all 1.5s 1.3s;}
.topic .rank {position:absolute; left:80px; top:617px;}
.topic .rank li {position:relative; left:15px; padding-bottom:14px; opacity:0; transition:all .8s 1.6s;}
.topic .rank li + li {transition-delay:1.8s;}
.topic .rank li + li + li {transition-delay:2s;}
.topic.animation .label img {margin-left:0;}
.topic.animation h2 .t1 {margin-left:0; opacity:1;}
.topic.animation h2 .t2 {margin-left:0; opacity:1;}
.topic.animation h2 .t3 {margin-left:0; opacity:1;}
.topic.animation h2 .deco {left:485px; opacity:1;}
.topic.animation .secreat {margin-top:0; opacity:1;}
.topic.animation .what {margin-top:0; opacity:1;}
.topic.animation .rank li {left:0; opacity:1;}
.section1 {text-align:center; background:url(http://webimage.10x10.co.kr/playing/thing/vol024/bg_why.png) 50% 0 repeat-x;}
.section1 .group1 {padding:54px 0 69px;}
.section1 .group1 p {display:inline-block; margin-top:18px; height:32px; background:url(http://webimage.10x10.co.kr/playing/thing/vol024/txt_why.png) 0 0 no-repeat; text-indent:-999em;}
.section1.animation p {display:inline-block;}
.section1 .group2 {width:1140px; margin:0 auto; padding:75px 0; text-align:center;}
.section1 .group2 p {margin-top:67px;}
.section2 {padding:105px 0 80px; background:url(http://webimage.10x10.co.kr/playing/thing/vol024/bg_conclusion.jpg) 50% 0 repeat-x;}
.section2 > div {width:1140px; height:615px; margin:0 auto; padding-top:75px; background-color:#fff;}
.section2 h3 {padding-bottom:60px;}
.section2 ul {overflow:hidden; width:984px; margin:0 auto;}
.section2 li {position:relative; left:-10px; float:left; opacity:0; transition:all .5s .1s; transition-timing-function:ease-in-out;}
.section2 li + li{transition-delay:.3s;}
.section2 li + li + li {transition-delay:.4s;}
.section2 li + li + li + li {transition-delay:.5s;}
.section2.animation li {left:0; opacity:1;}
.section2 .conclusion {margin-top:70px;}
.section2 a {display:inline-block; margin-top:50px;}
.section3 {padding:75px 0 80px; background:#fce2db;}
.section3 h3 {padding-bottom:75px;}
.section3 .cmtWrite {position:relative; overflow:hidden; width:1050px; height:147px; padding:0 45px; margin:0 auto; text-align:left;}
.section3 .cmtWrite .submit {position:absolute; right:45px; top:0;}
.section3 .cmtWrite .answer {position:absolute; left:297px; top:0; width:490px; height:73px; padding:37px; border:0; background:#fff;}
.section3 .cmtWrite .answer textarea {width:465px; height:60px; text-align:left; font:600 18px/1 'malgun gothic', '맑은고딕', dotum, sans-serif; color:#878787; border:0;}
.section3 .cmtList ul {overflow:hidden; width:1095px; margin:0 auto; padding-left:45px; padding-top:55px;}
.section3 .cmtList li {float:left; overflow:hidden; position:relative; width:320px; height:260px; margin-right:45px; margin-bottom:45px; background:#efc3b7; font:normal 24px/30px 'malgun gothic', '맑은고딕', dotum, sans-serif;}
.section3 .cmtList li .num {padding:35px 0 0 35px; font-size:15px; font-weight:600; line-height:23px; color:#000; text-align:left;}
.section3 .cmtList li .txt {width:250px; padding:15px 35px; font-size:24px; line-height:36px; text-align:left; padding-left:30px; color:#000;}
.section3 .cmtList li .writer {position:absolute; left:35px; bottom:35px; text-align:left; color:#a9624f; font-size:13px; font-weight:600; white-space:nowrap;}
.section3 .cmtList li .delete {position:absolute; right:0; top:0; height:22px; background:transparent;}
.pageWrapV15 {margin-top:10px;}
.pageWrapV15 .pageMove,.paging .first, .paging .end {display:none;}
.paging {height:29px;}
.paging a {width:44px; height:29px; margin:0; border:0;}
.paging a span {height:29px; padding:0; color:#000; font:bold 14px/29px verdana;}
.paging a.current span {color:#000; background:#efc3b7; border-radius:15px;}
.paging a:hover, .paging a.arrow, .paging a, .paging a.current, .paging a.current:hover {border:0; background-color:transparent;}
.paging a.arrow {margin:0 10px;}
.paging a.arrow span {width:44px; background:none;}
.paging .prev, .paging .next {background:url(http://webimage.10x10.co.kr/playing/thing/vol024/btn_pagination.png) 0 0 no-repeat;}
.paging .next {background-position:100% 0;}
.volume {padding:100px 0; background:url(http://webimage.10x10.co.kr/playing/thing/vol024/bg_vol.png) 0 0 repeat;}
.typing {width:157px; animation:typing .6s steps(5, end);}
@keyframes typing {
	from {width:0;}
	to {width:157px;}
}
</style>
<script style="text/javascript">
$(function(){
	$(".topic").addClass("animation");
	$(window.parent).scroll(function(){
		var scrollTop = $(window.parent).scrollTop();
		if (scrollTop > 520 ) {
			$(".section1 p").addClass("typing");
		}
		if (scrollTop > 2000 ) {
			$(".section2").addClass("animation");
		}
	});
});

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% if date() >="2017-09-21" and date() < "2017-10-10" then %>
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

				if (GetByteLength(frm.txtcomm.value) > 60){
					alert("제한길이를 초과하였습니다. 30자 까지 작성 가능합니다.");
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
<% If iCCurrpage>1 Then %>
location.href="#cmtfrm";
<% End If %>
</script>
						<!-- THING. html 코딩 영역 : 클래스명은 thing+볼륨 예) thingVol001 / 이미지폴더는 볼륨을 따라 vol001 -->
						<!-- Vol.024 장바구니 탐구생활_매니큐어편 -->
						<div class="thingVol024">
							<div class="topic">
								<div class="inner">
									<p class="label"><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_label.png" alt="장바구니 탐구생활_매니큐어편" /></p>
									<h2>
										<span class="t1"><img src="http://webimage.10x10.co.kr/playing/thing/vol024/tit_manicure1.png" alt="왜 그녀는" /></span>
										<span class="t2"><img src="http://webimage.10x10.co.kr/playing/thing/vol024/tit_manicure2.png" alt="빨간 매니큐어를" /></span>
										<span class="t3"><img src="http://webimage.10x10.co.kr/playing/thing/vol024/tit_manicure3.png" alt="발랐을까?" /></span>
										<span class="deco"></span>
									</h2>
									<p class="secreat"><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_secreat.png" alt="매니큐어 색으로 알아보는 숨은 심리!" /></p>
									<p class="what"><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_what.png" alt="사람들이 가장 많이 바른 색깔은 뭘까?" /></p>
									<ol class="rank">
										<li><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_rank_1.png" alt="1위 캔들홀더/디퓨저" /></li>
										<li><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_rank_2.png" alt="2위 포장지/꽃" /></li>
										<li><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_rank_3.png" alt="3위 책" /></li>
									</ol>
								</div>
							</div>
							<div class="section section1">
								<div class="group1">
									<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol024/tit_why.png" alt="예상했던 결과지만, 왜 이 색깔들을 많이 바를까?" /></h3>
									<p>도대체 왜?</p>
								</div>
								<div class="group2">
									<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol024/tit_question.png" alt="이 매니큐어를 바르는 사람들은 어떤 심리였을까?" /></h3>
									<p><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_talk.png" alt="" /></p>
								</div>
							</div>
							<div class="section section2">
								<div>
									<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_conclusion1.png" alt="각각의 색을 바르는 사람들에게 자문을 들어본 결과, 장소와 상황에 따라 주로 바르는 색이 달라진다는 점을 찾을 수 있었습니다." /></h3>
									<ul>
										<li><img src="http://webimage.10x10.co.kr/playing/thing/vol024/img_conclusion1.png" alt="RED - 나 자신을 돋보이게 하고 싶을 때" /></li>
										<li><img src="http://webimage.10x10.co.kr/playing/thing/vol024/img_conclusion2.png" alt="PINK - 누군가에게 사랑받고 싶을 때" /></li>
										<li><img src="http://webimage.10x10.co.kr/playing/thing/vol024/img_conclusion3.png" alt="BLUE - 어딘가 떠나고 싶고 스트레스 해소가 필요할 때" /></li>
										<li><img src="http://webimage.10x10.co.kr/playing/thing/vol024/img_conclusion4.png" alt="BLACK - 부족한 점을 들키고 싶지 않을 때" /></li>
									</ul>
									<p class="conclusion"><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_conclusion2.png" alt="그래서 내린 결론! 주변 사람들의 네일 색깔을 잘 참고하면 그 사람들의 심리를 꿰뚫을 수 있다!" /></p>
								</div>
								<a href="/event/eventmain.asp?eventid=80736" target="_blank"><img src="http://webimage.10x10.co.kr/playing/thing/vol024/btn_recommend.png" alt="매니큐어 색에 따른 추천 아이템 보기" /></a>
							</div>

							<!-- COMMENT -->
							<div class="section section3" id="cmtfrm">
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
								<h3><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_comment.png" alt="나만의 매니큐어 활용 Tip 을 들려주세요!" /></h3>
								<div class="cmtWrite">
									<p><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_use.png" alt="저는 매니큐어를 이렇게 활용해요!" /></p>
									<p class="answer"><textarea id="txtcomm" name="txtcomm" placeholder="30자이내로 입력해주세요." onclick="maxLengthCheck(this); return false" maxlength="30"></textarea></p>
									<button class="submit" onclick="jsSubmitComment(document.frmcom);return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol024/btn_submit.png" alt="응모하기" /></button>
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
								
								<div class="cmtList">
									<ul>
										<% IF isArray(arrCList) THEN %>
										<% For intCLoop = 0 To UBound(arrCList,2) %>
										<li>
											<p class="num">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
											<p class="txt">
												<em><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></em>
											</p>
											<p class="writer"><%=printUserId(arrCList(2,intCLoop),4,"*")%>님</p>
											<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
											<button class="delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;"><img src="http://webimage.10x10.co.kr/playing/thing/vol024/btn_delete.png" alt="삭제" /></button>
											<% End If %>
										</li>
										<% next %>
										<% end if %>
									</ul>
									<div class="pageWrapV15">
										<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
									</div>
								</div>
							</div>
							
							<!--// COMMENT -->
							<!-- volume -->
							<div class="volume">
								<p><img src="http://webimage.10x10.co.kr/playing/thing/vol024/txt_vol_024.png" alt="매니큐어를 바르는 특이한 이유가 있으신 분들은 플레잉 인스타그램[@10x10playing]으로 답해 주세요. (지난번에 보내주신 다양한 가정들이 많은 참고가 되었습니다. 이번에도 많은 의견 부탁드립니다!)" /></p>
							</div>
						</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->