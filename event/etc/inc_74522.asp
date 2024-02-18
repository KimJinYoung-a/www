<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : [컬쳐이벤트] 스텐딩 에그 컬쳐 콘서트
' History : 2016-11-30 원승현 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
	dim eCode, currenttime
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66246
	Else
		eCode   =  74522
	End If

	currenttime = Now()

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
		iCPageSize = 9
	else
		iCPageSize = 9
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


	'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
	if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
		if Not(Request("mfg")="pc" or session("mfg")="pc") then
			if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
				dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
				Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")	'### 모바일주소
				Response.End
			end if
		end if
	end If


%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.evt74522 {background:#fff;}
.evt74522 .inner {position:relative; width:1140px; margin:0 auto;}
.eggHead {height:765px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74522/bg_head.jpg) 50% 0 no-repeat; animation-name:pulse; animation-duration:4s; animation-iteration-count:1;}
.eggHead .date {position:absolute; left:36px; top:35px;}
.eggHead .only {position:absolute; right:42px; top:0;}
.eggHead .concert {position:relative; padding:90px 0 30px;}
.eggHead h2 {position:relative; padding:0 0 32px 35px;}
.eggHead .invite {position:relative; padding-bottom:45px;}
.eggHead .eggMail {position:absolute; left:50%; top:316px; margin-left:-333px; cursor:pointer;}
.eggHead .eggMail .ico {display:inline-block; position:absolute; left:187px; top:184px; width:23px; height:17px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74522/ico_mail.gif) 0 0 no-repeat;}
.eggHead .movie {overflow:hidden; width:626px; height:362px; margin:0 auto;}
.eggHead .movie iframe {display:none; width:626px; height:362px;}
.bookInfo {padding:40px 0; background:#767676;}
.bookInfo .inner {width:980px; text-align:left;}
.bookInfo .btnGroup {position:absolute; right:25px; top:13px; width:340px;}
.bookInfo .btnGroup a {display:inline-block; margin-bottom:15px; background:#f9f9f9;}
.bookInfo .btnGroup a.goApply {-webkit-animation:fadeBg 50 1.2s .8s;}
.preview {padding:30px 0 40px; background:#f9f9f9;}
.preview ul {position:relative; width:1140px; height:792px; margin:0 auto;}
.preview li {overflow:hidden; position:absolute;}
.preview li p {position:absolute; z-index:30;}
.preview li .pic {position:absolute; cursor:pointer;}
.preview li .pic div {display:none; position:absolute; left:0; top:0;}
.preview li.story01 {left:0; top:0; width:855px; height:230px;}
.preview li.story01 p {right:0; top:0;}
.preview li.story01 .pic {left:0; top:0;}
.preview li.story02 {right:0; top:0; width:285px; height:460px;}
.preview li.story02 p {left:0; bottom:0;}
.preview li.story02 .pic {left:0; top:0;}
.preview li.story03 {left:0; top:230px; width:285px; height:562px;}
.preview li.story03 p {left:0; top:0;}
.preview li.story03 .pic {left:0; bottom:0;}
.preview li.story04 {left:285px; top:230px; width:570px; height:562px;}
.preview li.story04 p {left:0; bottom:0;}
.preview li.story04 .pic {left:0; top:0;}
.preview li.story05 {right:0; bottom:0;}
.preview li.story05 .pic {position:static;}

.voiceWrite {height:450px; background:#f0ecde url(http://webimage.10x10.co.kr/eventIMG/2016/74522/bg_comment.jpg) 50% 0 no-repeat;}
.voiceWrite h3 {padding:56px 0 23px;}
.voiceWrite .inner {width:945px; text-align:left;}
.voiceWrite .inner li {position:relative; padding-left:175px;}
.voiceWrite .inner li span {position:absolute; left:0; top:50%; margin-top:-10px;}
.voiceWrite .inner li input,
.voiceWrite .inner li textarea {width:540px; color:#6d6d6d; padding:15px 20px; font-size:11px; font-family:dotum; border:1px solid #e3d6c0; color:#6d6d6d;}
.voiceWrite .inner .btnSubmit {position:absolute; right:10px; top:0; background:transparent;}
.voiceList ul {overflow:hidden; width:1020px; margin:0 auto; padding:62px 0 17px;}
.voiceList li {position:relative; float:left; width:300px; height:220px; margin:0 20px 40px; font-size:11px; color:#a8a8a8; text-align:center; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74522/bg_box.png) 0 0 no-repeat;}
.voiceList li .btnDelete {position:absolute; right:0; top:0; background:transparent;}
.voiceList li .num {display:block; padding:15px 17px 5px;  font-weight:bold; text-align:left;}
.voiceList li .song {padding-bottom:12px; font-size:16px; font-weight:bold; color:#5b5b5b;}
.voiceList li .writer {position:absolute; left:0; bottom:0; width:100%; height:48px; line-height:48px; color:#4383ce; font-weight:bold;}
.voiceList .pageMove {display:none;}
@-webkit-keyframes fadeBg {
	from, to{background:#f2e47d; animation-timing-function:ease-in;}
	50% {background:#f9f9f9; animation-timing-function:ease-out;}
}

@keyframes pulse {
	0% {background-size:2900px 965px;}
	100% {background-size:2700px 765px;}
}
/* tiny scrollbar */
.scrollbarwrap {width:215px; margin:0 auto;}
.scrollbarwrap .viewport {width:190px; height:70px; margin-left:12px;}
.scrollbarwrap .scrollbar {width:3px; background-color:#ededed;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#5b5b5b; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
});

$(function(){
	<% if Request("iCC") <> "" or request("ecc") <> "" then %>
		//pagedown();
		setTimeout("pagedown()",200);
	<% end if %>

	$('.preview li .pic').mouseover(function(){
		$(this).children('div').fadeIn();
	});
	$('.preview li .pic').mouseleave(function(){
		$(this).children('div').fadeOut();
	});
	$(".eggMail").click(function(){
		$(this).fadeOut(200);
		$(".eggHead .movie iframe").show();
	});
	$(".goApply").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 800);
	});
	animation();
	$(".eggHead .concert").css({"top":"15px", "opacity":"0"});
	$(".eggHead h2").css({"top":"15px", "opacity":"0"});
	$(".eggHead .invite").css({"top":"15px", "opacity":"0"});
	function animation () {
		$(".eggHead .concert").delay(300).animate({"top":"-5px", "opacity":"1"},600).animate({"top":"0"},500);
		$(".eggHead h2").delay(600).animate({"top":"-5px", "opacity":"1"},600).animate({"top":"0"},500);
		$(".eggHead .invite").delay(900).animate({"top":"-5px", "opacity":"1"},600).animate({"top":"0"},500);
	}
});


function pagedown(){
	//document.getElementById('commentlist').scrollIntoView();
	window.$('html,body').animate({scrollTop:$(".voiceList").offset().top}, 0);
}

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2016-11-30" and left(currenttime,10)<"2016-12-12" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("최대로 응모하셨습니다.\n12월 12일 당첨자 발표를 기대해주세요!");
				return false;
			<% else %>
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 30 || frm.txtcomm1.value == '신청곡을 적어주세요.'){
					alert("신청곡을 적어주세요");
					frm.txtcomm1.focus();
					return false;
				}
				if (frm.txtcomm2.value == '' || GetByteLength(frm.txtcomm2.value) > 800 || frm.txtcomm2.value == '400자 이내로 적어주세요.'){
					alert("띄어쓰기 포함\n최대 한글 400자 이내로 적어주세요.");
					frm.txtcomm2.focus();
					return false;
				}
				frm.txtcommURL.value = frm.txtcomm1.value
				frm.txtcomm.value = frm.txtcomm2.value
				frm.action = "/event/lib/comment_process.asp";
				frm.submit();
			<% end if %>
		<% end if %>
	<% Else %>
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
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

function jsCheckLimit(textgb) {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
		}
		return false;
	}

	if (textgb =='text1'){
		if (frmcom.txtcomm1.value == '신청곡을 적어주세요.'){
			frmcom.txtcomm1.value = '';
		}
	}else if(textgb =='text2'){
		if (frmcom.txtcomm2.value == '400자 이내로 적어주세요.'){
			frmcom.txtcomm2.value = '';
		}
	}else{
		alert('잠시 후 다시 시도해 주세요');
		return;
	}
}

//내코멘트 보기
function fnMyComment() {
	document.frmcom.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
	document.frmcom.iCC.value=1;
	document.frmcom.submit();
}
</script>

<%' voice mail %>
<div class="evt74522">
	<div class="eggHead">
		<div class="inner">
			<p class="date"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_date.png" alt="이벤트기간 : 2016.12.01 ~ 12.11" /></p>
			<p class="only"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_only.png" alt="10x10 Only" /></p>
			<p class="concert"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_concert.png" alt="Culture concert 12" /></p>
			<h2><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/tit_voice_mail.png" alt="VOICE Mail" /></h2>
			<p class="invite"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_together.png" alt="무료한 일상, 여러분에게 전송된 음성 메시지 이벤트에 참여하고 스탠딩에그 컬쳐콘서트에 함께하세요" /></p>
			<div class="eggMail">
				<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/img_msg.png" alt="메세지 확인하기" /></div>
				<span class="ico"></span>
			</div>
			<div class="movie">
				<div><iframe src="https://player.vimeo.com/video/193643633" frameborder="0" allowfullscreen></iframe></div>
			</div>
		</div>
	</div>
	<div class="bookInfo">
		<div class="inner">
			<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_book_info.jpg" alt="따뜻한 위로의 음악, 뮤지션 스탠딩에그의 VOICE [보이스]는 스탠딩에그에서 노래를 만들고 부르는 에그 2호의 일상과 음악, 여행과 관계에 대한 공감의 이야기를 담은 책이다. 직접 찍은 사진들과 글로 에그 2호의 감성을 느껴보자" /></p>
			<div class="btnGroup">
				<a href="#voiceWrite" class="goApply"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/btn_go_apply.png" alt="초대권 신청하기" /></a>
				<a href="eventmain.asp?eventid=74342" class="goBuy"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/btn_go_buy_v3.png" alt="도서 구매하기" /></a>
			</div>
		</div>
	</div>
	<div class="preview">
		<ul>
			<li class="story01">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_story_01.png" alt="사랑은 언제나 아무것도 모르는 상태에서 시작된다. 그 사람이 어떤 사람인지 자세히 알기도 전에 미소라든지 말투, 아니면 옷차림같이 아주 작은 부분만으로도 사랑에 빠지게 되는 것이다." /></p>
				<div class="pic">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/img_story01_01.jpg" alt="" />
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/img_story01_02.jpg" alt="" /></div>
				</div>
			</li>
			<li class="story02">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_story_03.png" alt="망고라면 분명히 우리가 매일매일 똑같다고 느끼는 팍팍한 일상마저도 ‘망고의 산책’ 처럼 신나게 살아낼 수 있으리라는 생각이 든다." /></p>
				<div class="pic">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/img_story02_01.jpg" alt="" />
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/img_story02_02.jpg" alt="" /></div>
				</div>
			</li>
			<li class="story03">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_story_02.png" alt="’살아가는 데 꼭 필요한 건 아니지만 그래도 분명 없을 때보다는 있을 때 기분 좋은 것들’ 대체로 이런 것들이 세상을 로맨틱하게 만든다. 음악이 그렇고, 꽃도 그렇다." /></p>
				<div class="pic">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/img_story04_01.jpg" alt="" />
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/img_story04_02.jpg" alt="" /></div>
				</div>
			</li>
			<li class="story04">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_story_04.png" alt="스물다섯이란 나이는 엉성한 배를 탄 채로 어쩌다 태평양 한복판에 이르러버린 듯한 나이다. 떠올릴 수 있는 올바른 행동지침이란 오직 하나. ‘일단 살아남아야 한다’ 말고는 아무 것도 없다." /></p>
				<div class="pic">
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/img_story03_01.jpg" alt="" />
					<div><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/img_story03_02.jpg" alt="" /></div>
				</div>
			</li>
			<li class="story05">
				<div class="pic"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/img_story05_01.jpg" alt="여행에서는 잃는 법이 없다. 무언가를 보지 못한다면 그 대신 다른 무언가를 보게 된다." /></div>
			</li>
		</ul>
	</div>
	<%' 코멘트 작성 %>
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
	<input type="hidden" name="txtcommURL">
	<div id="voiceWrite" class="voiceWrite">
		<h3><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_comment_v2.png" alt="COMMENT EVENT - 스탠딩에그 에그 2호의 보이스로 듣고 싶은 신청곡과, 건네고 싶은 질문을 코멘트로 남겨주세요" /></h3>
		<div class="inner">
			<ul>
				<li>
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_song.png" alt="신청곡" /></span>
					<input type="text" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit('text1');" onKeyUp="jsCheckLimit('text1');"  value="<%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>신청곡을 적어주세요.<%END IF%>" />
				</li>
				<li class="tMar15">
					<span><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/txt_question.png" alt="건네고 싶은 질문" /></span>
					<textarea style="height:60px;" cols="50" rows="5" name="txtcomm2" id="txtcomm2" onClick="jsCheckLimit('text2');" onKeyUp="jsCheckLimit('text2');"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>400자 이내로 적어주세요.<%END IF%></textarea>
				</li>
			</ul>
			<button type="submit" class="btnSubmit" onclick="jsSubmitComment(document.frmcom); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/btn_apply.png" alt="초대권 신청하기" /><button>
		</div>
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
	<%'// 코멘트 작성 %>


	<%' 코멘트 목록 %>
	<% IF isArray(arrCList) THEN %>
		<div class="voiceList">
			<ul>
				<% For intCLoop = 0 To UBound(arrCList,2) %>
					<li>
						<span class="num">NO.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></span>
						<p class="song"><%=ReplaceBracket(db2html(arrCList(7,intCLoop)))%></p>
						<div class="scrollbarwrap">
							<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
							<div class="viewport">
								<div class="overview">
									<p class="question"><%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%></p>
								</div>
							</div>
						</div>
						<p class="writer"><span><%=printUserId(arrCList(2,intCLoop),2,"*")%></span></p>
						<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
							<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btnDelete"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74522/btn_delete.png" alt="삭제" /></button>
						<% End If %>
					</li>
				<% Next %>
			</ul>
			<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
	<% End If %>
	<%'// 코멘트 목록 %>
</div>
<%'// voice mail %>
<!-- #include virtual="/lib/db/dbclose.asp" -->