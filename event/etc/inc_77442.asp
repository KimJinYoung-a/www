<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : 가정의달 , 코멘트
' History : 2017-04-13 이종화 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<%
dim oItem
dim currenttime
	currenttime =  now()
	'currenttime = #10/07/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66308
Else
	eCode   =  77442
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()

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
<style type="text/css">
.familyMonth {background:#f5d7d4 url(http://webimage.10x10.co.kr/eventIMG/2017/77440/bg_pattern.png) 0 0 repeat;}
.familyMonth .thankyou {border-bottom:1px solid #f4f4f4;}
.familyMonth .thankyouHead {height:764px; margin:0 auto; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77440/bg_head.png) 50% 0 no-repeat;}
.familyMonth .thankyouHead .title {position:relative; width:580px; margin:0 auto; padding-top:113px;}
.familyMonth .thankyouHead .title h2 {position:absolute; left:0; top:193px;}
.familyMonth .thankyouHead .title .deco {position:absolute; left:50%; top:153px; z-index:30; width:455px; height:165px; margin-left:-107px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77440/img_flower.png) 0 0 no-repeat;}
.familyMonth .thankyouHead .title .subcopy {position:absolute; left:50%; top:341px; margin-left:-223px;}
.familyMonth .thankyouCont {background:url(http://webimage.10x10.co.kr/eventIMG/2017/77440/bg_flower.png) 50% 205px no-repeat;}
.familyMonth .inner {position:relative; width:1140px; margin:-260px auto 0; padding:125px 0 35px; background-color:#fff;}
.familyMonth .tab {position:absolute; left:50%; top:-52px; z-index:40; width:892px; height:104px; padding:0 16px; margin-left:-462px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77442/txt_tab.png) 0 0 no-repeat;}
.familyMonth .tab li {float:left; width:25%; height:102px;}
.familyMonth .tab li a {display:block; height:100%; text-indent:-999em;}
.familyMonth .myStory {overflow:hidden; width:890px; margin:0 auto; padding-top:32px;}
.familyMonth .myStory li {float:left; width:50%; text-align:left; padding-bottom:70px; }
.familyMonth .myStory li:first-child {width:100%;}

/* comment */
.commentWrap {background-color:#fff;}
.commentEvent {width:1050px; margin:0 auto; padding:60px 45px 100px; text-align:left;}
.commentEvent .form .choice {overflow:hidden; width:772px; margin:0 auto; padding:35px 0 18px;}
.commentEvent .form .choice li {float:left; width:120px; height:120px; padding:0 17px;}
.commentEvent .form .choice li button {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77442/ico_comment_v3.png) 0 0 no-repeat; text-indent:-999em; outline:none;}
.commentEvent .form .choice li.ico1 button.on {background-position:0 100%;}
.commentEvent .form .choice li.ico2 button {background-position:-155px 0;}
.commentEvent .form .choice li.ico2 button.on {background-position:-155px 100%;}
.commentEvent .form .choice li.ico3 button {background-position:-309px 0;}
.commentEvent .form .choice li.ico3 button.on {background-position:-309px 100%;}
.commentEvent .form .choice li.ico4 button {background-position:-464px 0;}
.commentEvent .form .choice li.ico4 button.on {background-position:-464px 100%;}
.commentEvent .form .choice li.ico5 button {background-position:100% 0;}
.commentEvent .form .choice li.ico5 button.on {background-position:100% 100%;}
.commentEvent textarea {width:1028px; height:78px; padding:10px; border:1px solid #ccc; background-color:#f5f5f5;}
.commentEvent .note01 {margin-top:6px;}
.commentEvent .note01 ul li {color:#888;}
.commentEvent .commentlist {margin-top:52px;}
.commentEvent .commentlist table {border-top:1px solid #ddd; text-align:center;}
.commentEvent .commentlist table thead {display:none;}
.commentEvent .commentlist table th {display:block; visibility:hidden; width:0; height:0;}
.commentEvent .commentlist table th, .commentlist table td {border-bottom:1px solid #ddd; color:#777; font-size:11px; line-height:1.5em;}
.commentEvent .commentlist table td {padding:25px 0;}
.commentEvent .commentlist table td.lt {padding-right:10px;}
.commentEvent .commentlist table td em {font-weight:bold;}
.commentEvent .commentlist table td strong {display:block; width:120px; height:120px; background:url(http://webimage.10x10.co.kr/eventIMG/2017/77442/ico_comment_v3.png) 0 0 no-repeat; text-indent:-999em;}
.commentEvent .commentlist table td .ico2 {background-position:-155px 0;}
.commentEvent .commentlist table td .ico3 {background-position:-309px 0;}
.commentEvent .commentlist table td .ico4 {background-position:-464px 0;}
.commentEvent .commentlist table td .ico5 {background-position:100% 0;}
.commentEvent .commentlist table td .btndel {margin-top:3px; background-color:transparent;}
.commentEvent .pageWrapV15 {margin-top:40px;}
</style>
<script type='text/javascript'>

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
		<% If not( left(currenttime,10)>="2017-04-19" and left(currenttime,10)<"2017-05-04" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("이벤트는 5회까지 참여 가능 합니다.");
				return false;
			<% else %>
				if (frm.gubunval.value == ''){
					alert('원하는 아이콘을 선택해 주세요.');
					return false;
				}
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 800){
					alert("코맨트를 남겨주세요.\n한글 400자 까지 작성 가능합니다.");
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
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
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
			var winLogin = window.open('/login/PopLoginPage.asp','popLogin','width=400,height=300');
			winLogin.focus();
			return false;
		}
		return false;
	}
}

//내코멘트 보기
function fnMyComment() {
	document.frmcom.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
	document.frmcom.iCC.value=1;
	document.frmcom.submit();
}

</script>
<!-- 가정의달 기획전3 : Thanks Bucket List -->
<div class="evt77442 familyMonth">
	<div class="thankyou">
		<div class="thankyouHead">
			<div class="title">
				<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/77440/tit_tenten_family.png" alt="텐바이텐, 그리고 가정의 달" /></p>
				<h2><img src="http://webimage.10x10.co.kr/eventIMG/2017/77440/tit_thankyou.png" alt="Thank You!" /></h2>
				<div class="deco"></div>
				<p class="subcopy"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77440/txt_subcopy.png" alt="고마운 기억, 고마운 사람... 작은 표현으로 꽃 피우는 5월. 고마운 기억을 준 사람에게 아름다운 기억을 선물 하는 것은 어떨까요?" /></p>
			</div>
		</div>
		<div class="thankyouCont">
			<div class="inner">
				<ul class="tab">
					<li><a href="eventmain.asp?eventid=77438">Thanks Blossom</a></li>
					<li><a href="eventmain.asp?eventid=77440">50 GIFTS for you</a></li>
					<li><a href="eventmain.asp?eventid=77442">Thanks Bucket List</a></li>
					<li><a href="eventmain.asp?eventid=77443">Thank You Message</a></li>
				</ul>
				<h3><img src="http://webimage.10x10.co.kr/eventIMG/2017/77442/txt_heart.png" alt="마음에 담아둔 고마움, 오늘 여기에 담아주세요!" /></h3>
				<ul class="myStory">
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/77442/img_story_01.jpg" alt="#1 언제나 못난 딸 엄마, 고마워요 사랑해요" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/77442/img_story_02_v2.jpg" alt="#2 우리가 함께했던 시간들" /></li>
					<li class="rt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77442/img_story_03_v2.jpg" alt="#3 내 손으로 만든 꽃 한 송이" /></li>
					<li><img src="http://webimage.10x10.co.kr/eventIMG/2017/77442/img_story_04.jpg" alt="#4 당신은 참, 내게 좋은 사람" /></li>
					<li class="rt"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77442/img_story_05.jpg" alt="#5 고맙습니다, 선생님" /></li>
				</ul>
			</div>
		</div>
	</div>
	<div class="commentWrap">
		<div class="commentEvent">
			<p class="ct"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77442/txt_comment_v2.png" alt="COMMENT EVNET - 당신의 버킷리스트는 무엇인가요?" /></p>
			<div class="form">
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
					<fieldset>
						<legend>코멘트 쓰기</legend>
						<ul class="choice">
							<li class="ico1"><button type="button" value="1">케이크 만들기</button></li>
							<li class="ico2"><button type="button" value="2">추억 남기기</button></li>
							<li class="ico3"><button type="button" value="3">꽃송이 만들기</button></li>
							<li class="ico4"><button type="button" value="4">여행가기</button></li>
							<li class="ico5"><button type="button" value="5">책 선물</button></li>
						</ul>
						<p class="ct bPad20"><img src="http://webimage.10x10.co.kr/eventIMG/2017/77442/txt_gift_v2.png" alt="(앙금플라워 케이크 클래스-1명 (2인참석) / 물나무사진관 촬영권-2명 / 슈가부토니에 클래스 - 1명 / 네스트호텔 디럭스 숙박권-2명 / [안녕 초지로] 도서-1명 증정)" /></p>
						<textarea title="코멘트 작성" cols="60" rows="5" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
						<div class="note01 overHidden">
							<ul class="list01 ftLt">
								<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
								<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br>이벤트 참여에 제한을 받을 수 있습니다.</li>
							</ul>
							<input type="submit" onclick="jsSubmitComment(document.frmcom); return false;" class="ftRt btn btnW130 btnS1 btnRed" value="코멘트 남기기">
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
			<% '' commentlist %>
			<div class="commentlist" id="commentlist">
				<% IF isArray(arrCList) THEN %>
				<table>
					<caption>코멘트 목록 - 코멘트 작성시 선택 항목, 내용, 작성일자, 아이디 정보를 제공하는 표</caption>
					<colgroup>
						<col style="width:150px;" />
						<col style="width:*;" />
						<col style="width:110px;" />
						<col style="width:120px;" />
					</colgroup>
					<thead>
					<tr>
						<th scope="col"></th>
						<th scope="col">내용</th>
						<th scope="col">작성일자</th>
						<th scope="col">아이디</th>
					</tr>
					</thead>
					<tbody>
						<% For intCLoop = 0 To UBound(arrCList,2) %>
						<tr>
							<td>
								<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
									<strong class="ico<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
										<% if split(arrCList(1,intCLoop),"!@#")(0)="1" then %>
											케이크 만들기
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="2" then %>
											추억 남기기
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="3" then %>
											꽃송이 만들기
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="4" then %>
											여행가기
										<% elseif split(arrCList(1,intCLoop),"!@#")(0)="5" then %>
											책 선물
										<% end if %>
									</strong>
								<% end if %>
							</td>
							<td class="lt">
								<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
									<% if ubound(split(arrCList(1,intCLoop),"!@#")) > 0 then %>
										<%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"!@#")(1) ))%>
									<% end if %>
								<% end if %>
							</td>
							<td><%= FormatDate(arrCList(4,intCLoop),"0000.00.00") %></td>
							<td>
								<em><%=printUserId(arrCList(2,intCLoop),2,"*")%></em>
								<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
									<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btndel"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제"></button>
								<% end if %>
								<% If arrCList(8,i) <> "W" Then %>
									<br /><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨">
								<% end if %>
							</td>
						</tr>
						<% Next %>
					</tbody>
				</table>
				<%'!-- paging --%>
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
				<% End If %>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	$(".choice li:first-child button").addClass("on");
	frmcom.gubunval.value = '1';
	$(".choice li button").click(function(){
		frmcom.gubunval.value = $(this).val()
		$(".choice li button").removeClass("on");
		if ( $(this).hasClass("on")) {
			$(this).removeClass("on");
		} else {
			$(this).addClass("on");
		}
	});

	animation();
	$(".title h2").css({"margin-top":"15px","opacity":"0"});
	$(".title .subcopy").css({"margin-top":"15px","opacity":"0"});
	$(".title .deco").css({"margin-left":"-90px","margin-top":"-20px","opacity":"0"});
	function animation() {
		$(".title h2").delay(300).animate({"margin-top":"0","opacity":"1"},900);
		$(".title .subcopy").delay(900).animate({"margin-top":"0","opacity":"1"},900);
		$(".title .deco").delay(800).animate({"margin-left":"-107px","margin-top":"0","opacity":"1"},900);
	}
});
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->