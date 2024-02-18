<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description : [컬쳐] 도서만찬
' History : 2016-11-08 원승현 생성
'####################################################
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
dim sqlstr
dim currenttime
	currenttime =  now()
	'currenttime = #10/07/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  66229
Else
	eCode   =  74104
End If

dim userid, commentcount, i
	userid = GetEncLoginUserID()


	sqlstr = "select count(*) as cnt"
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_comment c"
	sqlstr = sqlstr & " where c.userid='"& userid &"' and c.evt_code="& eCode &" And convert(varchar(10), c.evtcom_regdate, 120) = '"&Left(Now(), 10)&"' "

	'response.write sqlstr & "<Br>"
	rsget.Open sqlstr,dbget
	IF not rsget.EOF THEN
		commentcount = rsget("cnt")
	END IF
	rsget.close

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
img {vertical-align:top;}

.evt74104 {position:relative; width:1140px; background-color:#115a4f;}

.main {position:relative;}
.rolling {position:absolute; top:318px; left:120px;}
.slidewrapper {position:relative; width:906px;}
.slide .slidesjs-navigation {display:block; position:absolute; top:45.91%; z-index:20; width:56px; height:56px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/btn_nav.png) no-repeat 0 0; text-indent:-999em;}
.slide .slidesjs-previous {left:-70px;}
.slide .slidesjs-next {right:-70px; background-position:100% 100%;}
.slide .slidesjs-pagination {overflow:hidden; position:absolute; bottom:-60px; left:0; z-index:50; width:100%; height:17px; text-align:center;}
.slide .slidesjs-pagination li {display:inline-block; margin:0 5px;}
.slide .slidesjs-pagination li a {display:block; width:8px; height:8px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/btn_pagination.png) no-repeat 100% 100%; text-indent:-999em;}
.slide .slidesjs-pagination li a.active {width:8px; height:8px; background-position:0 0;}

.commtEvnt {position:relative;}
.commtEvnt .noti {padding:40px 0 25px 0;}
.commtEvnt .form .choice {overflow:hidden; width:810px; margin:0 auto;}
.commtEvnt .form .choice li {float:left; width:130px; height:133px; padding:0 16px;}
.commtEvnt .form .choice li.ico1 button {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre01_no.png) no-repeat 50% 50%; font-size:11px; text-indent:-999em;}
.commtEvnt .form .choice li.ico1 button:hover{background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre01_over.png) no-repeat 0 0;}
.commtEvnt .form .choice li.ico1 button.on {background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre01_over.png) no-repeat 0 0;}
.commtEvnt .form .choice li.ico2 button {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre02_no.png) no-repeat 50% 50%; font-size:11px; text-indent:-999em;}
.commtEvnt .form .choice li.ico2 button:hover{background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre02_over.png) no-repeat 0 0;}
.commtEvnt .form .choice li.ico2 button.on {background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre02_over.png) no-repeat 0 0;}
.commtEvnt .form .choice li.ico3 button {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre03_no.png) no-repeat 50% 50%; font-size:11px; text-indent:-999em;}
.commtEvnt .form .choice li.ico3 button:hover{background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre03_over.png) no-repeat 0 0;}
.commtEvnt .form .choice li.ico3 button.on {background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre03_over.png) no-repeat 0 0;}
.commtEvnt .form .choice li.ico4 button {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre04_no.png) no-repeat 50% 50%; font-size:11px; text-indent:-999em;}
.commtEvnt .form .choice li.ico4 button:hover{background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre04_over.png) no-repeat 0 0;}
.commtEvnt .form .choice li.ico4 button.on {background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre04_over.png) no-repeat 0 0;}
.commtEvnt .form .choice li.ico5 button {display:block; width:100%; height:100%; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre05_no.png) no-repeat 50% 50%; font-size:11px; text-indent:-999em;}
.commtEvnt .form .choice li.ico5 button:hover{background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre05_over.png) no-repeat 0 0;}
.commtEvnt .form .choice li.ico5 button.on {background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre05_over.png) no-repeat 0 0;}

.commtEvnt textarea {display:block; width:695px; height:70px; padding:20px; margin:45px 0 66px 120px; border-radius:6px; font-size:16px;}
.commtEvnt .btnOrder {position:absolute; top:255px; right:127px; width:120px; height:120px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/btn_buy.png) no-repeat 0 0; cursor:pointer; text-indent:-999em;}

.pageWrapV15 {background:#fff;}
.commtEvnt .pageMove {display:none;}
.commtEvnt .tenCmtList {background:#fff;}
.commtEvnt .tenCmtList ul {overflow:hidden; width:1080px; margin:0 auto; padding:50px 0 23px 0;}
.commtEvnt .tenCmtList li {position:relative; position:relative; float:left; width:240px; height:230px; margin:0 15px 40px; font-size:11px; text-align:left; border-radius:8px;}
.commtEvnt .tenCmtList li.genre01 {background:#33a0ac;}
.commtEvnt .tenCmtList li.genre02 {background:#dc6f49;}
.commtEvnt .tenCmtList li.genre03 {background:#d5b32a;}
.commtEvnt .tenCmtList li.genre04 {background:#4977c2;}
.commtEvnt .tenCmtList li.genre05 {background:#ed6f80;}
.commtEvnt .tenCmtList li .num {display:inline-block; color:#ffffff; font-weight:bold; padding:18px 0 70px 18px; }
.commtEvnt .tenCmtList li.genre01 .genre {position:absolute; top:13px; left:60px; width:119px; height:96px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre01.png) no-repeat 0 0;}
.commtEvnt .tenCmtList li.genre02 .genre {position:absolute; top:13px; left:60px; width:119px; height:96px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre02.png) no-repeat 0 0;}
.commtEvnt .tenCmtList li.genre03 .genre {position:absolute; top:13px; left:60px; width:119px; height:96px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre03.png) no-repeat 0 0;}
.commtEvnt .tenCmtList li.genre04 .genre {position:absolute; top:13px; left:60px; width:119px; height:96px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre04.png) no-repeat 0 0;}
.commtEvnt .tenCmtList li.genre05 .genre {position:absolute; top:13px; left:60px; width:119px; height:96px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/ico_genre05.png) no-repeat 0 0;}
.commtEvnt .tenCmtList li .writer {width:100%; text-align:center; margin-top:10px; color:#feffff;}
.commtEvnt .tenCmtList li .btnDelete {display:inline-block; position:absolute; right:10px; top:13px; width:23px; height:23px; background:url(http://webimage.10x10.co.kr/eventIMG/2016/74104/btn_delete.png) 0 0 no-repeat; text-indent:-999em;}
.scrollbarwrap {width:175px; margin:5px 0 0 43px;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:155px; height:72px;}
.scrollbarwrap .overview {color:#feffff; line-height:20px; margin-top:-3px}
.scrollbarwrap .scrollbar {float:right; position:relative; width:3px; background-color:#eceded;}
.scrollbarwrap.track {position: relative; width:3px; height:100%; background-color:#ddd;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#393939; cursor:pointer; border-radius:3px;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
.tMar20 {margin:0;}
</style>
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type='text/javascript'>

$(function(){
	<% if pagereload<>"" then %>
		//pagedown();
		setTimeout("pagedown()",500);
	<% end if %>

	$("#slide").slidesjs({
		width:"906",
		height:"453",
		pagination:{effect:"fade"},
		navigation:{effect:"fade"},
		play:{interval:2200, effect:"fade", auto:true},
		effect:{fade: {speed:1000, crossfade:true}}
	});
	$(".slide .slidesjs-pagination li:nth-child(1)").addClass("p01");
	$(".slide .slidesjs-pagination li:nth-child(2)").addClass("p02");
	$(".slide .slidesjs-pagination li:nth-child(3)").addClass("p03");
	$(".slide .slidesjs-pagination li:nth-child(4)").addClass("p04");
	$(".slide .slidesjs-pagination li:nth-child(5)").addClass("p05");
	$(".choice li.ico1").click(function(){
		frmcom.gubunval.value = '1';
		$(".slidesjs-pagination .p01 a").click();
	});
	$(".choice li.ico2").click(function(){
		frmcom.gubunval.value = '2';
		$(".slidesjs-pagination .p02 a").click();
	});
	$(".choice li.ico3").click(function(){
		frmcom.gubunval.value = '3';
		$(".slidesjs-pagination .p03 a").click();
	});
	$(".choice li.ico4").click(function(){
		frmcom.gubunval.value = '4';
		$(".slidesjs-pagination .p04 a").click();
	});
	$(".choice li.ico5").click(function(){
		frmcom.gubunval.value = '5';
		$(".slidesjs-pagination .p05 a").click();
	});
	$(".choice li button").click(function(){
		$(".choice li button").removeClass("on");
		$(this).addClass("on");
	});
	$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
	});
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
		<% If not( left(currenttime,10)>="2016-11-08" and left(currenttime,10)<"2016-11-18" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>4 then %>
				alert("최대로 응모하셨습니다. 11월 18일 당첨자\n발표를 기대해주세요!");
				return false;
			<% else %>
				if (frm.gubunval.value == ''){
					alert('원하는 메뉴를 선택해 주세요.');
					return false;
				}
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 1600){
					alert("이 메뉴가 땡기는 이유를 작성해주세요.\n한글 800자 까지 작성 가능합니다.");
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

function jsCheckLimit() {
	if ("<%=IsUserLoginOK%>"=="False") {
		if(confirm("로그인을 하셔야 참여가 가능 합니다. 로그인 하시겠습니까?")){
			location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/event/eventmain.asp?eventid="&eCode)%>';
			return;
		}
		return false;
	}

	//if (frmcom.txtcomm.value == ''){
	//	frmcom.txtcomm.value = '';
	//}	
}

//내코멘트 보기
function fnMyComment() {
	document.frmcom.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
	document.frmcom.iCC.value=1;
	document.frmcom.submit();
}
</script>


<div class="eventContV15 tMar15">
	<div class="contF">
		<div class="evt74104">
			<%' 메인상단 %>
			<div class="main">
				<h2>
					<img src="http://webimage.10x10.co.kr/eventIMG/2016/74104/tit_book.jpg" alt="텐바이텐 도서 풀코스 도서 만찬 원하는 메뉴를 선택하고 주문하면 250명에게 도서 선물을 드려요! 당첨자 발표 : 2016년 11월 18일" usemap="#map01"/>
				</h2>
				<map name="map01">
					<area shape="rect" coords="938,1,1093,139" href="http://www.10x10.co.kr/culturestation/">
				</map>
				<%' 롤링 %>
				<div class="rolling">
					<div class="slidewrapper">
						<div id="slide" class="slide">
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/74104/img_slide01.png" alt="인문" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/74104/img_slide02.png" alt="에세이" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/74104/img_slide03.png" alt="취미" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/74104/img_slide04.png" alt="여행" />
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/74104/img_slide05.png" alt="소설" />
						</div>
					</div>
				</div>
			</div>
			<%' 이벤트 참여 코멘트 %>
			<div class="commtEvnt" id="commentlist">
				<div class="tenCmtWrite">
					<p class="noti"><img src="http://webimage.10x10.co.kr/eventIMG/2016/74104/txt_cmt_write.png" alt="※ 이벤트 당첨시 해당 장르의 다른 도서가 랜덤 발송 될 수 있습니다" /></p>
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
									<li class="ico1"><button type="button" value="1">#인문</button></li>
									<li class="ico2"><button type="button" value="2">#에세이</button></li>
									<li class="ico3"><button type="button" value="3">#취미</button></li>
									<li class="ico4"><button type="button" value="4">#여행</button></li>
									<li class="ico5"><button type="button" value="5">#소설</button></li>
								</ul>
								<textarea title="코멘트 작성" placeholder="이 메뉴가 땡기는 이유는?" name="txtcomm1" id="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %><%END IF%></textarea>
								<input type="submit" class="btnOrder" value="주문하기" onclick="jsSubmitComment(document.frmcom); return false;">
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
				</div>
				<div class="tenCmtList">
				<% IF isArray(arrCList) THEN %>
					<ul>
						<%' for dev msg : li 8개씩 노출 %>
						<% For intCLoop = 0 To UBound(arrCList,2) %>
							<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
								<li class="genre0<%= split(arrCList(1,intCLoop),"!@#")(0) %>">
									<span class="num">No. <%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></span>
									<div class="genre"></div>
									<div class="scrollbarwrap">
										<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
										<div class="viewport">
											<div class="overview">
												<% if isarray(split(arrCList(1,intCLoop),"!@#")) then %>
													<% if ubound(split(arrCList(1,intCLoop),"!@#")) > 0 then %>
														<%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"!@#")(1) ))%>
													<% end if %>
												<% end if %>
											</div>
										</div>
									</div>
									<div class="writer"><%=printUserId(arrCList(2,intCLoop),2,"*")%></div>
									<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
										<a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>'); return false;" class="btnDelete">삭제</a>
									<% End If %>
								</li>
							<% End If %>	
						<% Next %>						
					</ul>
					<div class="pageWrapV15 tMar20">
						<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
					</div>
				<% End If %>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->