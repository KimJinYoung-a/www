<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'#### 2014-05-09 이종화 작성 play_sub ###################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21168
Else
	eCode   =  51791
End If

dim com_egCode, bidx
	Dim cEComment
	Dim iCTotCnt, arrCList,intCLoop, iSelTotCnt
	Dim iCPageSize, iCCurrpage
	Dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt
	Dim timeTern, totComCnt

	'파라미터값 받기 & 기본 변수 값 세팅
	iCCurrpage = requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	com_egCode = requestCheckVar(Request("eGC"),1)	

	IF iCCurrpage = "" THEN iCCurrpage = 1
	IF iCTotCnt = "" THEN iCTotCnt = -1

	'// 그룹번호 랜덤으로 지정

	iCPageSize = 8		'한 페이지의 보여지는 열의 수
	iCPerCnt = 10		'보여지는 페이지 간격

	'선택범위 리플개수 접수
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iSelTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	'코멘트 데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	'cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1

%>
<link rel="stylesheet" type="text/css" href="/lib/css/section.css" />
<style type="text/css">
.playGr20140512 {border-top:6px solid #ffb787; width:100%;}
.talkLove .row {overflow:hidden; position:relative;}
.talkLove .row .section {width:1140px; margin:0 auto;}
.talkLove .row .photo {position:absolute; left:50%; top:0; margin-left:-960px;}
@media all and (min-width:1921px) {
	.talkLove .row .photo {left:0; width:100%; min-width:1140px; margin-left:0;}
	.talkLove .row .photo img {width:100%;}
}
.talkLove .row1 {overflow:visible; position:relative; z-index:20; background-color:#ffffee;}
.talkLove .row1 .section {position:relative; z-index:20;}
.talkLove .row1 .section .rt {position:absolute; top:0; right:0;}
.talkLove .row1 .section .group {height:1055px; background:url(http://webimage.10x10.co.kr/play/ground/20140512/bg_letter.jpg) left bottom no-repeat;}
.talkLove .row1 .section .group p {padding-left:190px;}
.talkLove .row1 .section .album {position:absolute; right:-130px; bottom:-45px; z-index:20;}
.talkLove .row2 {height:810px; background:url(http://webimage.10x10.co.kr/play/ground/20140512/bg_memo_02.jpg) left top no-repeat; background-size:1920px 960px;}
@media all and (min-width:1920px) {
	.talkLove .row2 {background:url(http://webimage.10x10.co.kr/play/ground/20140512/bg_memo.jpg) left top no-repeat; background-size:100% 810px;}
}
.talkLove .row2 .section {padding-top:72px;}
.talkLove .row2 .btnLeave {padding-top:72px; text-align:center;}
.talkLove .row3 {height:980px;}
.talkLove .row3 .section {position:absolute; right:13%; bottom:70px; z-index:10; width:auto; margin:0;}
.talkLove .row4 {height:1060px;}
.talkLove .row4 .section {position:absolute; top:462px; left:50%; z-index:10; width:auto; margin:0 0 0 -414px;}
.talkLove .row5 {height:1040px;}
.talkLove .row5 .section {position:absolute; top:447px; left:14%; z-index:10; width:auto; margin:0;}
.talkLove .row6 {height:1000px;}
.talkLove .row6 .section {position:absolute; top:78px; right:12%; z-index:10; width:auto; margin:0;}
.talkLove .row7 {height:920px;}
.talkLove .row7 .section {position:absolute; top:500px; left:16%; z-index:10; width:auto; margin:0;}
@media all and (min-width:1921px) {
	.talkLove .row3 .photo img {height:980px;}
	.talkLove .row4 .photo img {height:1060px;}
	.talkLove .row5 .photo img {height:1040px;}
	.talkLove .row6 .photo img {height:1000px;}
	.talkLove .row7 .photo img {height:920px;}
}
.talkLove .row8 {background-color:#f6f3e7;}
.talkLove .row8 .section {padding:15px 0 50px;}
.talkLove .row8 .helpFilming {padding-right:15px; color:#b3b0a4; text-align:right;}
.talkLove .row8 .helpFilming span {padding-left:10px; background:url(http://webimage.10x10.co.kr/play/ground/20140512/blt_square_lightgrey.gif) left 5px no-repeat;}
.talkLove .row8 .section .leaveMsg {position:relative; width:940px; height:232px; margin:20px auto 0; padding:70px 100px 45px; border-bottom:1px solid #eae8dc; background:url(http://webimage.10x10.co.kr/play/ground/20140512/bg_box_02.png) 50% top no-repeat;}
.talkLove .row8 .section .leaveMsg textarea {width:680px; height:66px; margin:25px 0 0 10px; padding:15px; border:1px solid #e1e1e1; color:#999; font-size:12px;}
.talkLove .row8 .section .leaveMsg input {position:absolute; top:95px; right:100px;}
.talkLove .row8 .section .leaveMsg ul {overflow:hidden; margin-top:10px;}
.talkLove .row8 .section .leaveMsg ul li {float:left; padding:2px 10px 2px 15px; background:url(http://webimage.10x10.co.kr/play/ground/20140512/blt_square_grey.gif) 10px 10px no-repeat; color:#78756d;}
.talkLove .row2 .section .leaveMsg ul li:first-child {margin-right:-10px}
.talkLove .row8 .group {overflow:hidden; width:1176px; margin-top:0; margin-right:-36px;}
.talkLove .row8 .group .part {float:left; position:relative; margin:40px 20px 0 0; width:224px; height:232px; padding:125px 25px 0; background:url(http://webimage.10x10.co.kr/play/ground/20140512/bg_comment_msg.png) left top no-repeat;}
.talkLove .row8 .group .part .info {overflow:hidden; color:#999; font-size:11px;}
.talkLove .row8 .group .part .info span {float:left; width:50%;}
.talkLove .row8 .group .part .info .number {text-align:right;}
.talkLove .row8 .group .part .msg {padding:25px 0 15px 5px;}
.talkLove .row8 .group .part .msg p {overflow:auto; height:120px; padding-right:5px; color:#333;}
.talkLove .row8 .group .part .id {margin-top:5px; color:#777; text-align:right;}
.talkLove .row8 .group .part .btnDelete {position:absolute; bottom:35px; left:30px; width:26px; height:16px; background:url(http://webimage.10x10.co.kr/play/ground/20140512/btn_del.gif) left top no-repeat; text-indent:-999em;}
.talkLove .row8 .section .paging {margin-top:50px;}
.talkLove .row8 .section .paging a {background-color:transparent;}
</style>
<script type="text/javascript">
$(function(){
	/* Move */
	$(".btnLeave a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
	});
});
</script>
<script type="text/javascript">
<!--
 	function jsGoComPage(iP){
		document.frmcom.iCC.value = iP;
		document.frmcom.iCTot.value = "<%=iCTotCnt%>";
		document.frmcom.submit();
	}

	function jsSubmitComment(frm){
		<% if Not(IsUserLoginOK) then %>
		    jsChklogin('<%=IsUserLoginOK%>');
		    return false;
		<% end if %>

	   if(!frm.txtcomm.value||frm.txtcomm.value == "소중한 가족들에게 사랑의 메세지를 남겨보세요."){
	    alert("소중한 가족들에게 사랑의 메세지를 남겨보세요.");
		document.frmcom.txtcomm.value="";
	    frm.txtcomm.focus();
	    return false;
	   }

//	   	if(GetByteLength(frm.txtcomm.value)>100){
//			alert('100자 까지 가능합니다.');
//	    frm.txtcomm.focus();
//	    return false;
//		}

	   frm.action = "/event/lib/comment_process.asp";
	   return true;
	}

	function jsDelComment(cidx)	{
		if(confirm("삭제하시겠습니까?")){
			document.frmdelcom.Cidx.value = cidx;
	   		document.frmdelcom.submit();
		}
	}

	function jsChklogin11(blnLogin)
	{
		if (blnLogin == "True"){
			if(document.frmcom.txtcomm.value == "소중한 가족들에게 사랑의 메세지를 남겨보세요." ){
				document.frmcom.txtcomm.value="";
			}
			return true;
		} else {
			jsChklogin('<%=IsUserLoginOK%>');
		}

		return false;
	}

	function jsChkUnblur()
	{
		if(document.frmcom.txtcomm.value ==""){
			document.frmcom.txtcomm.value = "소중한 가족들에게 사랑의 메세지를 남겨보세요."
		}
	}

	function Limit(obj)
	{
	   var maxLength = parseInt(obj.getAttribute("maxlength"));
	   if ( obj.value.length > maxLength ) {
		alert("글자수는 200자 이내로 제한됩니다.");
		obj.value = obj.value.substring(0,maxLength); //100자 이하 튕기기
		}
	}

//-->
</script>
<div class="playGr20140512">
	<div class="talkLove">
		<div class="row row1">
			<div class="section">
				<div class="rt"><img src="http://webimage.10x10.co.kr/play/ground/20140512/img_tag_talk_love.gif" alt="TALK LOVE 캠페인" /></div>
				<h3 class="ct"><img src="http://webimage.10x10.co.kr/play/ground/20140512/tit_talk_love.png" alt="TALK LOVE CAMPAIGN" /></h3>
				<div class="group">
					<h4><img src="http://webimage.10x10.co.kr/play/ground/20140512/tit_talk_love_letter.gif" alt="&quot;지금 사랑한다고 말해주세요&quot;" /></h4>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_talk_love_letter_01.gif" alt="가정의 달 5월, PLAY에서는 가족과 함께하는 일상의 점심 LUNCH에서 이야기를 시작하고자 합니다. 늘 가까이에 있지만 서로에게 무관심한 가족. 같이 밥 한끼 먹으며 이야기를 나눌 시간 조차 없는 우리의 모습을 보면 일상의 소중함을 잊고 사는 듯 합니다. 가장 쉬운 일인 것 같지만 그래서 더 소홀했던 가족과의 시간을 위해 텐바이텐이 TALK LOVE 캠페인을 준비했습니다." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_talk_love_letter_02.gif" alt="가족과 함께 먹는 따뜻한 점심식사를 나눠보세요! 그리고 그 동안 서로에게 무관심 했던 가족의 소중함을 돌아보고 사랑한다고, 고맙다고 말해주세요. 텐바이텐 TALK LOVE 캠페인이 가족의 따뜻한 사랑을 응원합니다." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_talk_love_letter_03.gif" alt="이제 사랑한다는 말을 내일로 미루지 마세요. 오늘 함께 밥을 먹으며 서로 따뜻한 이야기를 나눠보세요. 가까이에 있어 미쳐 알지 못했던 가족의 소중함을 깨닫게 될 거에요." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_talk_love_letter_04.gif" alt="인생은 모두가 함께하는 여행이라고 하죠. 매일매일 사는 동안 우리가 할 수 있는 건 최선을 다해 이 멋진 여행을 만끽하고 서로에게 아낌없이 표현하는 것입니다. 일상의 소중함을 느끼고 서로에 대한 사랑을 나누는 인생이 되기를 바랍니다." /></p>
					<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_talk_love_letter_05.gif" alt="오늘 가족들에게 꼭 이야기하세요. 아무리 바쁘고 팍팍한 일상이라도 우리 사랑한다는 말을 나누며 살아요!" /></p>
				</div>
				<div class="album"><img src="http://webimage.10x10.co.kr/play/ground/20140512/img_photo_album.png" alt="" /></div>
			</div>
		</div>

		<div class="row row2">
			<div class="section">
				<h4><img src="http://webimage.10x10.co.kr/play/ground/20140512/tit_talk_love_box.png" alt="TALK LOVE BOX" /></h4>
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_talk_love_box_01.png" alt="텐바이텐이 준비한 TALK LOVE BOX에는 가족과 함께 소중한 시간을 보내고 기록할 수 있는 아이템들이 들어있습니다. 함께 맛있는 저녁을 먹으며 이야기를 나누고 행복을 담아보세요." /></p>
				<div class="gift"><img src="http://webimage.10x10.co.kr/play/ground/20140512/img_talk_love_box_gift.png" alt="CJ 외식상품권 10만원권, 미니7 + 미니필름, Mini Photo Album, Greeting card Set, 오! 해피데이 Tea Set" /></div>
				<div class="btnLeave"><a href="#leaveMsg"><img src="http://webimage.10x10.co.kr/play/ground/20140512/btn_leave_msg.png" alt="가족들에게 메세지 남기고 선물 받기" /></a></div>
			</div>
		</div>

		<div class="row row3">
			<div class="section">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_write_card.png" alt="오늘은 가족들에게 사랑의 메시지를 담은 카드를 써보세요" /></p>
			</div>
			<div class="photo"><img src="http://webimage.10x10.co.kr/play/ground/20140512/img_photo_write_card.jpg" alt="" /></div>
		</div>

		<div class="row row4">
			<div class="section">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_have_lunch.png" alt="주말 하루 함께 이야기하며 즐거운 식사를 나눠보세요." /></p>
			</div>
			<div class="photo"><img src="http://webimage.10x10.co.kr/play/ground/20140512/img_photo_have_lunch.jpg" alt="" /></div>
		</div>

		<div class="row row5">
			<div class="section">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_take_photo.png" alt="함께 사진을 찍어 행복한 오늘을 남겨보세요." /></p>
			</div>
			<div class="photo"><img src="http://webimage.10x10.co.kr/play/ground/20140512/img_photo_take.jpg" alt="" /></div>
		</div>

		<div class="row row6">
			<div class="section">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_tea_time.png" alt="사진을 앨범에 넣고, 도란도란 이야기를 나누며 티타임을 즐겨보세요." /></p>
			</div>
			<div class="photo"><img src="http://webimage.10x10.co.kr/play/ground/20140512/img_photo_tea_time.jpg" alt="" /></div>
		</div>

		<div class="row row7">
			<div class="section">
				<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_say_love.png" alt="서로에게 사랑한다는 말을 아낌없이 나눠주세요." /></p>
			</div>
			<div class="photo"><img src="http://webimage.10x10.co.kr/play/ground/20140512/img_photo_say_love.jpg" alt="" /></div>
		</div>

		<!-- comment -->
		<% IF isArray(arrCList) THEN %>
		<div class="row row8">
			<div class="section">
				<p class="helpFilming"><span>촬영 협조 : 128PAN</span></p>
				<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
				<input type="hidden" name="iCTot" value="">
				<input type="hidden" name="mode" value="add">
				<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
					<fieldset>
					<legend>가족들에게 사랑의 메시지를 남기기</legend>
					<div class="leaveMsg">
						<p><img src="http://webimage.10x10.co.kr/play/ground/20140512/txt_talk_love_box_02.png" alt="가족들에게 사랑의 메시지를 남겨주세요. 따뜻한 메시지를 남겨주신 5분을 추첨하여 TALK LOVE BOX를 보내드립니다." /></p>
						<textarea id="leaveMsg" title="소중한 가족들에게 사랑의 메시지 작성하기" cols="60" rows="5" id="writearea" name="txtcomm" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onblur="jsChkUnblur()" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');return" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%> autocomplete="off">소중한 가족들에게 사랑의 메세지를 남겨보세요.</textarea>
						<input type="image" src="http://webimage.10x10.co.kr/play/ground/20140512/btn_talk_love.png" alt="TALK LOVE" />
						<ul>
							<li><em>기간 : 2014.05.12 - 05.21 (10일간)</em></li>
							<li><em>당첨자발표 : 2014.05.22</em></li>
						</ul>
					</div>
					</fieldset>
				</form>
				<form name="frmdelcom" method="post" action="/event/lib/comment_process.asp" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="Cidx" value="">
				<input type="hidden" name="mode" value="del">
				<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
				</form>

				<div class="group">
					<% For intCLoop = 0 To UBound(arrCList,2) %>
					<div class="part">
						<div class="info">
							
							<span class="date"><% If arrCList(8,intCLoop) = "M"  then%><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성" /><% End If %> <%=formatdate(arrCList(4,intCLoop),"0000.00.00")%></span>
							<span class="number">no.<%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></span>
						</div>
						<div class="msg">
							<p><%=nl2br(arrCList(1,intCLoop))%></p>
						</div>
						<div class="id"><strong>from.</strong> <span><%=printUserId(arrCList(2,intCLoop),2,"*")%></span></div>
						<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
						<button type="button" class="btnDelete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>')"><span>삭제</span></button>
						<% end if %>
					</div>
					<% Next %>
				</div>
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
			</div>
		</div>
		<% End If %>
		<!-- //comment -->
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->