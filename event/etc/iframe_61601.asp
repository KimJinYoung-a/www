<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
'####################################################
' Description :  BML 에서 만나요!
' History : 2015.04.21 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->

<%
dim currenttime
	currenttime =  now()
	'currenttime = #04/22/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  61758
Else
	eCode   =  61601
End If

dim userid, commentcount, i
	userid = getloginuserid()

commentcount = getcommentexistscount(userid, eCode, "", "", "", "")

dim cEComment ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)

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

<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
img {vertical-align:top;}
.evt61601 {background-color:#fff; text-align:center;}
.evt61601 .topic {position:relative; background-color:#fcf7e4;}
.evt61601 .topic p {visibility:hidden; width:0; height:0;}
.evt61601 .topic .flower1 {position:absolute; top:197px; left:145px;}
.evt61601 .topic .flower2 {position:absolute; top:200px; right:142px;}
.about {position:relative;}
.about .btngo {position:absolute; top:80px; right:43px;}
.about .btngo:hover img {-webkit-animation-name: bounce; -webkit-animation-iteration-count: infinite; -webkit-animation-duration:0.5s; animation-name: bounce; animation-iteration-count: infinite; animation-duration:0.5s;}
@-webkit-keyframes bounce {
	from, to{margin-top:0; -webkit-animation-timing-function:ease-out;}
	50% {margin-top:-7px; -webkit-animation-timing-function:ease-in;}
}
@keyframes bounce {
	from, to{margin-top:0; animation-timing-function:ease-out;}
	50% {margin-top:-7px; animation-timing-function:ease-in;}
}
.commentevt {position:relative; height:541px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61601/bg_paper.png) no-repeat 50% 0; text-align:left;}
.commentevt ul {overflow:hidden; padding-left:85px;}
.commentevt ul li {float:left; position:relative; padding:0 2px;}
.commentevt ul li input {position:absolute; left:50%; bottom:15px; width:13px; margin-left:-6px;}
.commentevt .texarea {width:836px; height:67px; margin-top:9px; padding:15px 15px 15px 102px; border:0; background:url(http://webimage.10x10.co.kr/eventIMG/2015/61601/bg_box.png) no-repeat 87px 0;}
.commentevt .texarea textarea {width:836px; height:67px; padding:0; border:0; text-align:left;}
.commentevt .btnsubmit {position:absolute; bottom:65px; right:87px;}

.commentlist {overflow:hidden; width:1135px; padding:8px 0 40px 5px;}
.commentlist .col {float:left; width:250px; height:283px; margin:15px 15px 0; background-repeat:no-repeat; background-position:50% 100%; font-size:11px; text-align:center;}
.commentlist .col .no {display:block; padding-top:81px; margin-bottom:14px;}
.commentlist .col .id {display:block; margin-top:12px;}
.commentlist .col1 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/61601/bg_comment_box_01.png); color:#4da788;}
.commentlist .col2 {background-image:url(http://webimage.10x10.co.kr/eventIMG/2015/61601/bg_comment_box_02.png); color:#ed7f63;}
.btndel {width:15px; height:15px; margin-top:13px; background:url(http://webimage.10x10.co.kr/eventIMG/2015/60280/btn_del.png) no-repeat 50% 0; text-indent:-999em;}

/* tiny scrollbar */
.scrollbarwrap {width:190px; margin:0 auto;}
.scrollbarwrap .viewport {overflow:hidden; position: relative; width:180px; height:80px; padding-bottom:3px;}
.scrollbarwrap .overview {position: absolute; top:0; left:0; width:100%;}
.scrollbarwrap .scrollbar {float:right; position:relative; width:3px; background-color:#f1f1f1;}
.scrollbarwrap.track {position: relative; width:3px; height:100%; background-color:#f1f1f1;}
.scrollbarwrap .thumb {overflow:hidden; position:absolute; top: 0; left:0; width:3px; height:24px; background-color:#3f3f3f; cursor:pointer;}
.scrollbarwrap .thumb .end {overflow:hidden; width:3px; height:5px;}
.scrollbarwrap .disable {display:none;}
.noSelect {user-select:none; -o-user-select:none; -moz-user-select:none; -khtml-user-select:none; -webkit-user-select:none;}
</style>
<script type="text/javascript">

function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	<% If IsUserLoginOK() Then %>
		<% If not( left(currenttime,10)>="2015-04-22" and left(currenttime,10)<"2015-04-28" ) Then %>
			alert("이벤트 응모 기간이 아닙니다.");
			return false;
		<% else %>
			<% if commentcount>0 then %>
				alert("이벤트는 1회만 응모하실수 있습니다.\n4월30일(목) 당첨자 발표를 기다려 주세요!");
				return false;
			<% else %>
				var tmpdateval='';
				for (var i=0; i < frm.dateval.length; i++){
					if (frm.dateval[i].checked){
						tmpdateval = frm.dateval[i].value;
					}
				}
				if (tmpdateval==''){
					alert('관람을원하는 날짜를 선택해 주세요.');
					return false;
				}
				if (frm.txtcomm1.value == '' || GetByteLength(frm.txtcomm1.value) > 600 || frm.txtcomm1.value == '600자 이내로 입력해주세요'){
					alert("BML2015에 대한 기대평을 남겨주세요.\n600자 까지 작성 가능합니다.");
					frm.txtcomm1.focus();
					return false;
				}

			   frm.txtcomm.value = tmpdateval + "|!/" +frm.txtcomm1.value
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
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	}

	if (frmcom.txtcomm1.value == '600자 이내로 입력해주세요'){
		frmcom.txtcomm1.value = '';
	}
}

//내코멘트 보기
function fnMyComment() {
	document.frmcom.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
	document.frmcom.iCC.value=1;
	document.frmcom.submit();
}

</script>
</head>
<body>
<!-- iframe -->
<div class="evt61601">
	<div class="topic">
		<h1><img src="http://webimage.10x10.co.kr/eventIMG/2015/61601/tit_bml.png" alt="BML 2015 공식 MD 텐바이텐 BML에서 만나요!" /></h1>
		<p>예약판매 기간은 4월 22일부터 4월 27일까지며, 사전 예약판매  10%  상품배송은 2015년 4월 28일(월)부터 결제완료 기준으로 순차 배송됩니다.</p>
		<span class="flower1"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61601/img_flower_01.png" alt="" /></span>
		<span class="flower2"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61601/img_flower_02.png" alt="" /></span>
	</div>

	<div class="item1">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61601/img_item_01.jpg" alt="BML 2015 상품으로 20,000원 이상 구매하신 고객님에게는 GMF2014 기타피크 세트를 선물로 드립니다. 100개 한정이며 선착순으로 증정합니다." usemap="#link1" /></p>
		<map name="link1" id="link1">
			<area shape="rect" coords="89,2,407,392" href="/shopping/category_prd.asp?itemid=1255572" target="_top" alt="자수 티셔츠" />
			<area shape="rect" coords="411,2,730,392" href="/shopping/category_prd.asp?itemid=1255573" target="_top" alt="기타피크 세트" />
			<area shape="rect" coords="733,2,1050,391" href="/shopping/category_prd.asp?itemid=1255574" target="_top" alt="핀 버튼" />
			</map>
	</div>
	<div class="item2">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61601/img_item_02_v2.jpg" alt="럭키 텐바이텐 백" usemap="#link2" /></p>
		<map name="link2" id="link2">
			<area shape="rect" coords="112,137,1028,370" href="/shopping/category_prd.asp?itemid=1255576" target="_top" alt="2만원의 행복 에코백 + 마나퍄투 + 손수건 + 핀버튼" />
			<area shape="rect" coords="112,427,1028,660" href="/shopping/category_prd.asp?itemid=1255575" target="_top" alt="1만원의 기쁨 파우치 + 기타피크 세트 + 미니거울" />
		</map>
	</div>

	<div class="about">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61601/txt_bml_2015.png" alt="BML 2015 뷰티풀 민트 라이프는 민트페이퍼가 개최하는 봄날의 음악 페스티벌입니다. 봄에는 뷰티풀 민트 라이프, 가을에는 그랜드 민트 페스티벌이 열리고 있습니다. 다양한 아티스트들과 팬들이 만나 음악을 나누고, 소통하는 페스티벌로 거듭나고 있습니다." /></p>
		<a href="http://www.mintpaper.co.kr/" target="_blank" title="새창" class="btngo"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61601/btn_go.png" alt="BML 2015 홈페이지 놀러가기" /></a>
	</div>

	<form name="frmcom" method="post" onSubmit="return false;" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="com_egC" value="<%=com_egCode%>">
	<input type="hidden" name="bidx" value="<%=bidx%>">
	<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
	<input type="hidden" name="iCTot" value="">
	<input type="hidden" name="mode" value="add">
	<input type="hidden" name="spoint" value="0">
	<input type="hidden" name="isMC" value="<%=isMyComm%>">
	<input type="hidden" name="txtcomm">
	<!-- comment write -->
	<div class="commentevt">
		<p><img src="http://webimage.10x10.co.kr/eventIMG/2015/61601/txt_comment_event.png" alt="봄날의 축제 BML2015! 가고 싶은 날짜와 함께 기대평을 남겨주세요. 추첨을 통해 2분에게는 원하는 날짜의 BML2015티켓 1일권 2매를 선물로 드립니다. 코멘트 작성기간은 2015년 4월 22일부터 27일까지며 당첨자 발표는 4월 27일 화요일 입니다." /></p>
		<ul>
			<li>
				<label for="selectDate01"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61601/txt_label_date_01.png" alt="2015년 5월 2일 토요일" /></label>
				<input type="radio" name="dateval" value="1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" id="selectDate01" />
			</li>
			<li>
				<label for="selectDate02"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61601/txt_label_date_02.png" alt="2015년 5월 3일 일요일" /></label>
				<input type="radio" name="dateval" value="2" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" id="selectDate02" />
			</li>
		</ul>
		<div class="texarea">
			<textarea name="txtcomm1" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%> cols="60" rows="5" title="BML2015 가장 기대되는 아티스트와 함께 기대평 쓰기"><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<% else %>600자 이내로 입력해주세요<%END IF%></textarea>
		</div>
		<div class="btnsubmit"><img src="http://webimage.10x10.co.kr/eventIMG/2015/61601/btn_submit.png" onclick="jsSubmitComment(frmcom); return false;" alt="기대평 남기기" /></div>
	</div>
	</form>

	<!-- comment list -->
	<div class="commentlist">
		<%
		IF isArray(arrCList) THEN
			dim rndNo : rndNo = 1
			
			For intCLoop = 0 To UBound(arrCList,2)
			
			randomize
			rndNo = Int((2 * Rnd) + 1)
		%>
		<% '<!-- for dev msg : <div class="col">...</div>이 한 묶음입니다. col1 ~ col2 랜덤으로 클래스명 뿌려주세요 --> %>
		<% '<!-- for dev msg : 한페이지당 8개 --> %>
		<div class="col col<%=rndNo%>">
			<strong class="no">No.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></strong>
			<div class="scrollbarwrap">
				<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
				<div class="viewport">
					<div class="overview">
						<% '<!-- for dev msg : 기대평 부분 요기에 넣어주세요 --> %>
						<p class="msg">
							<% if isarray(split(arrCList(1,intCLoop),"|!/")) then %>
								<% if ubound(split(arrCList(1,intCLoop),"|!/")) > 0 then %>
									<%=ReplaceBracket(db2html( split(arrCList(1,intCLoop),"|!/")(1) ))%>
								<% end if %>
							<% end if %>
						</p>
					</div>
				</div>
			</div>
			<span class="id">
				<% If arrCList(8,i) <> "W" Then %>
					<img src="http://webimage.10x10.co.kr/eventIMG/2015/60280/ico_mobile.png" alt="모바일에서 작성" /> 
				<% end if %>

				<%=printUserId(arrCList(2,intCLoop),2,"*")%>
			</span>
			
			<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
				<button type="button" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;" class="btndel">삭제</button>
			<% end if %>
		</div>
		<%
			Next
		end if
		%>		
	</div>
	
	<% IF isArray(arrCList) THEN %>
		<div class="pageWrapV15">
			<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
	<% end if %>

	<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
		<input type="hidden" name="eventid" value="<%=eCode%>">
		<input type="hidden" name="com_egC" value="<%=com_egCode%>">
		<input type="hidden" name="bidx" value="<%=bidx%>">
		<input type="hidden" name="Cidx" value="">
		<input type="hidden" name="mode" value="del">
		<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
	</form>
</div>

<!-- for dev msg : 스크립트 꼭 넣어주세요! -->
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('.scrollbarwrap').tinyscrollbar();
});

$(function(){
	/* Label Select */
	$(".commentevt ul li label").click(function(){
		labelID = $(this).attr("for");
		$('#'+labelID).trigger("click");
	});

	function moveFlower () {
		$(".topic .flower1").animate({"margin-top":"0"},1100).animate({"margin-top":"7px"},1100, moveFlower);
		$(".topic .flower2").animate({"margin-top":"5px"},1500).animate({"margin-top":"0"},1500, moveFlower);
	}
	moveFlower();
});
</script>
</body>
</html>

<!-- #include virtual="/lib/poptailer.asp" -->
<!-- #include virtual="/lib/db/dbclose.asp" -->