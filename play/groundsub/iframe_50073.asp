<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
'#### 2014-03-07 이종화 작성 play_sub ###################
Dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21107
Else
	eCode   =  50073
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
img {vertical-align:top;}
.groundHeadWrap {background-color:#ede7d5;}
.groundCont {position:relative; padding-top:21px; min-width:1140px;}
.groundCont .grArea {width:100%; margin-top:-42px;  background:#ebecf0;}
.groundCont .tagView {width:1100px; padding:60px 20px;}
.playGr20140310 {width:100%;}
.playGr20140310 img {vertical-align:top;}
.playGr20140310 .memo02Head {height:540px; padding-top:90px; text-align:center; background:#efefef;}
.playGr20140310 .memo02Head p {width:1140px; margin:0 auto;}
.playGr20140310 .memoSection {overflow:hidden; width:100%; background:#fff;}
.playGr20140310 .memoSection .ftLt {width:50%; height:680px; text-align:right; overflow:hidden;}
.playGr20140310 .memoSection .ftLt .fir {padding-right:130px;}
.playGr20140310 .memoSection .ftRt {width:50%; height:680px; text-align:left; overflow:hidden;}
.playGr20140310 .memoSection .ftRt .fir {padding-left:130px;}
.playGr20140310 .memoSection p.fir {padding-top:198px; padding-bottom:44px;}
.playGr20140310 .memoSection .goMemo {cursor:pointer; padding:0 130px;}
.playGr20140310 .part01 .ftLt {width:46%; height:760px; background:url(http://webimage.10x10.co.kr/play/ground/20140310/part01_bg_left.gif) right top repeat;}
.playGr20140310 .part01 .ftRt {width:54%; height:760px; background:url(http://webimage.10x10.co.kr/play/ground/20140310/part01_bg_right.gif) left top repeat;}
.playGr20140310 .part02 .ftLt {background:#fdea49;}
.playGr20140310 .part02 .ftRt img {float:left;}
.playGr20140310 .part02 .ftRt {background:url(http://webimage.10x10.co.kr/play/ground/20140310/part02_bg_right.gif) left top repeat-x;}
.playGr20140310 .part03 .ftLt img {float:right;}
.playGr20140310 .part03 .ftRt {background:#fb805f;}
.playGr20140310 .part04 .ftLt {background:#91e1e8;}
.playGr20140310 .part04 .ftRt img {float:left;}
.playGr20140310 .part05 .ftLt img {float:right;}
.playGr20140310 .part05 .ftRt {background:#c09cdb;}
.playGr20140310 .part06 .ftLt {background:#c6f060;}
.playGr20140310 .part06 .ftRt img {float:left;}
.playGr20140310 .writeMemo {border-top:4px solid #252525; background:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_grid.gif) left top repeat;}
.playGr20140310 .applyEvent {width:1140px; margin:0 auto; padding-bottom:30px;}
.playGr20140310 .evtInfo {padding:70px 0;}
.playGr20140310 .selectType {float:left; width:558px; padding-left:74px;}
.playGr20140310 .selectType ul {overflow:hidden;}
.playGr20140310 .selectType li {float:left; width:150px; padding:0 0 25px 35px; text-align:center;}
.playGr20140310 .selectType li.innerPad {padding-left:120px;}
.playGr20140310 .selectType li label {display:block; padding-bottom:15px;}
.playGr20140310 .typing {position:relative; float:left; width:408px; height:450px; background:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_paper.png) left top no-repeat;}
.playGr20140310 .typing .textBox {position:absolute; left:125px; top:115px;}
.playGr20140310 .typing .textBox textarea {overflow:hidden; width:190px; height:150px; font-size:16px; color:#222; line-height:3.1em; border:0; text-align:center; background:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_text_line.gif) left top no-repeat #fdea49;}
.playGr20140310 .typing .textBox .write {background:url(http://webimage.10x10.co.kr/play/ground/20140310/txt_write.gif) left top no-repeat #fdea49;}
.playGr20140310 .typing .enroll {position:absolute; left:156px; bottom:0px; cursor:pointer;}
.playGr20140310 .memoListWrap {border-top:4px solid #252525; background:#ebecf0;}
.playGr20140310 .memoList {width:1140px; margin:0 auto;}
.playGr20140310 .memoList ul {overflow:hidden; margin-right:-18px; padding-top:65px;}
.playGr20140310 .memoList li {position:relative; float:left; margin:0 18px 60px 0; width:270px; height:392px; background-position:left top; background-repeat:no-repeat;}
.playGr20140310 .memoList li.type01 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/img_list_type01.png)}
.playGr20140310 .memoList li.type02 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/img_list_type02.png)}
.playGr20140310 .memoList li.type03 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/img_list_type03.png)}
.playGr20140310 .memoList li.type04 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/img_list_type04.png)}
.playGr20140310 .memoList li.type05 {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/img_list_type05.png)}
.playGr20140310 .memoList li .delete {position:absolute; right:17px; top:17px; width:9px; height:9px; text-indent:-9999px; cursor:pointer; background:url(http://webimage.10x10.co.kr/play/ground/20140310/btn_delete02.gif) left top no-repeat;}
.playGr20140310 .memoList li.type01 .delete {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/btn_delete.gif)}
.playGr20140310 .memoList li .num {padding:18px 0 0 17px; font-size:11px;  line-height:12px;  color:#888; }
.playGr20140310 .memoList li .txt {position:absolute; left:57px; top:120px;  width:114px; height:152px; padding:0 20px;}
.playGr20140310 .memoList li .txt span {display:table-cell; vertical-align:middle; text-align:center; font-weight:bold; line-height:25px; color:#151515; width:114px; height:152px; }
.playGr20140310 .memoList li .writer {position:absolute; left:0; bottom:0; width:100%; height:20px; text-align:center;}
.playGr20140310 .memoList li .writer span {display:inline-block; height:20px; padding-right:10px; background-position:right top; background-repeat:no-repeat;}
.playGr20140310 .memoList li .writer em {display:inline-block; height:20px; line-height:20px; color:#fff; font-size:11px; padding-left:10px; min-width:112px; background-position:left top; background-repeat:no-repeat;}
.playGr20140310 .memoList li.type01 .writer span {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_id_type01_right.gif);}
.playGr20140310 .memoList li.type01 .writer em {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_id_type01_left.gif); background-color:#feb941;}
.playGr20140310 .memoList li.type02 .writer span {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_id_type02_right.gif);}
.playGr20140310 .memoList li.type02 .writer em {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_id_type02_left.gif); background-color:#fb805f;}
.playGr20140310 .memoList li.type03 .writer span {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_id_type03_right.gif);}
.playGr20140310 .memoList li.type03 .writer em {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_id_type03_left.gif); background-color:#86dfe7;}
.playGr20140310 .memoList li.type04 .writer span {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_id_type04_right.gif);}
.playGr20140310 .memoList li.type04 .writer em {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_id_type04_left.gif); background-color:#c09cdb;}
.playGr20140310 .memoList li.type05 .writer span {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_id_type05_right.gif);}
.playGr20140310 .memoList li.type05 .writer em {background-image:url(http://webimage.10x10.co.kr/play/ground/20140310/bg_id_type05_left.gif); background-color:#b5e441;}
*:first-child+html .memoList li .txt span {display:block; padding-top:30px; height:122px;}
*:first-child+html .memoList li.type01 .delete {text-indent:0; font-size:0;}
</style>
<script type="text/javascript">
$(function(){
	$(".goMemo a").click(function(event){
		event.preventDefault();
		window.parent.$('html,body').animate({scrollTop:5179}, 500);
	});

	$("label img").on("click", function() {
		$("#" + $(this).parents("label").attr("for")).click();
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

	   
	   if(!(frm.spoint[0].checked||frm.spoint[1].checked||frm.spoint[2].checked||frm.spoint[3].checked||frm.spoint[4].checked)){
	    alert("메모지를 선택해주세요");
	    return false;
	   }

	    if(!frm.txtcomm.value){
	    alert("이 곳에다 당신의 상상력으로 메모를 채워 보세요!");
		document.frmcom.txtcomm.value="";
		$("#writearea").removeClass("write");
	    frm.txtcomm.focus();
	    return false;
	   }

	   	if(GetByteLength(frm.txtcomm.value)>50){
			alert('25자 까지 가능합니다.');
	    frm.txtcomm.focus();
	    return false;
		}

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
			if($("#writearea").attr("class") == "write" ){
				document.frmcom.txtcomm.value="";
				$("#writearea").removeClass("write");
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
			$("#writearea").addClass("write");
		}
	}

	function Limit(obj)
	{
	   var maxLength = parseInt(obj.getAttribute("maxlength"));
	   if ( obj.value.length > maxLength ) {
		alert("글자수는 25자 이내로 제한됩니다.");
		obj.value = obj.value.substring(0,maxLength); //200자 이하 튕기기
		}
	}

//-->
</script>
<div class="playGr20140310">
	<div class="memo02Head"><p><img src="http://webimage.10x10.co.kr/play/ground/20140310/img_memo_head.gif" alt="" /></p></div>
	<div class="memoSection part01">
		<div class="ftLt"><p><img src="http://webimage.10x10.co.kr/play/ground/20140310/part01_img_memo.gif" alt="" /></p></div>
		<div class="ftRt"><p><img src="http://webimage.10x10.co.kr/play/ground/20140310/part01_img_pencil.jpg" alt="네모난 노란 종이, 이 종이는 어떤 글을 적느냐에 따라 다양하고 많은 이야기를 담을 수 있어요. 여러가지 상황 속에 있는 메모 당신의 상상으로 메모를 채워주세요!" /></p></div>
	</div>
	<div class="memoSection part02">
		<div class="ftLt">
			<p class="fir"><img src="http://webimage.10x10.co.kr/play/ground/20140310/part02_msg.gif" alt="" /></p>
			<p class="goMemo"><a href="#writeMemo"><img src="http://webimage.10x10.co.kr/play/ground/20140310/part02_btn_go_memo.gif" alt="상상한 메모 남기러 가기" /></a></p>
		</div>
		<div class="ftRt">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140310/part02_img_memo.gif" alt="" /></p>
		</div>
	</div>
	<div class="memoSection part03">
		<div class="ftLt">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140310/part03_img_memo.gif" alt="" /></p>
		</div>
		<div class="ftRt">
			<p class="fir"><img src="http://webimage.10x10.co.kr/play/ground/20140310/part03_msg.gif" alt="" /></p>
			<p class="goMemo"><a href="#writeMemo"><img src="http://webimage.10x10.co.kr/play/ground/20140310/part03_btn_go_memo.gif" alt="상상한 메모 남기러 가기" /></a></p>
		</div>
	</div>
	<div class="memoSection part04">
		<div class="ftLt">
			<p class="fir"><img src="http://webimage.10x10.co.kr/play/ground/20140310/part04_msg.gif" alt="" /></p>
			<p class="goMemo"><a href="#writeMemo"><img src="http://webimage.10x10.co.kr/play/ground/20140310/part04_btn_go_memo.gif" alt="상상한 메모 남기러 가기" /></a></p>
		</div>
		<div class="ftRt">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140310/part04_img_memo.gif" alt="" /></p>
		</div>
	</div>
	<div class="memoSection part05">
		<div class="ftLt">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140310/part05_img_memo.gif" alt="" /></p>
		</div>
		<div class="ftRt">
			<p class="fir"><img src="http://webimage.10x10.co.kr/play/ground/20140310/part05_msg.gif" alt="" /></p>
			<p class="goMemo"><a href="#writeMemo"><img src="http://webimage.10x10.co.kr/play/ground/20140310/part05_btn_go_memo.gif" alt="상상한 메모 남기러 가기" /></a></p>
		</div>
	</div>
	<div class="memoSection part06">
		<div class="ftLt">
			<p class="fir"><img src="http://webimage.10x10.co.kr/play/ground/20140310/part06_msg.gif" alt="" /></p>
			<p class="goMemo"><a href="#writeMemo"><img src="http://webimage.10x10.co.kr/play/ground/20140310/part06_btn_go_memo.gif" alt="상상한 메모 남기러 가기" /></a></p>
		</div>
		<div class="ftRt">
			<p><img src="http://webimage.10x10.co.kr/play/ground/20140310/part06_img_memo.gif" alt="" /></p>
		</div>
	</div>

	<div class="writeMemo" id="writeMemo">
		<div class="applyEvent">
			<p class="evtInfo"><img src="http://webimage.10x10.co.kr/play/ground/20140310/txt_event_info.png" alt="COMMENT EVENT" /></p>
			<div class="overHidden">
				<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
				<input type="hidden" name="iCTot" value="">
				<input type="hidden" name="mode" value="add">
				<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
				<fieldset>
				<legend>메모등록</legend>
				<div class="selectType">
					<ul>
						<li>
							<label for="type01"><img src="http://webimage.10x10.co.kr/play/ground/20140310/img_memo_type01.png" alt="돌려받은 결재판 위의 메모" title="돌려받은 결재판 위의 메모"/></label>
							<input type="radio" id="type01" name="spoint" value="1"/>
						</li>
						<li>
							<label for="type02"><img src="http://webimage.10x10.co.kr/play/ground/20140310/img_memo_type02.png" alt="부재중 전화 위의 메모" title="부재중 전화 위의 메모"/></label>
							<input type="radio" id="type02" name="spoint" value="2"/>
						</li>
						<li>
							<label for="type03"><img src="http://webimage.10x10.co.kr/play/ground/20140310/img_memo_type03.png" alt="남자의 등 위의 메모" title="남자의 등 위의 메모"/></label>
							<input type="radio" id="type03" name="spoint" value="3"/>
						</li>
						<li class="innerPad">
							<label for="type04"><img src="http://webimage.10x10.co.kr/play/ground/20140310/img_memo_type04.png" alt="따뜻한 커피 위의 메모" title="따뜻한 커피 위의 메모"/></label>
							<input type="radio" id="type04" name="spoint" value="4"/>
						</li>
						<li>
							<label for="type05"><img src="http://webimage.10x10.co.kr/play/ground/20140310/img_memo_type05.png" alt="건네받은 봉투 위의 메모" title="건네받은 봉투 위의 메모"/></label>
							<input type="radio" id="type05" name="spoint" value="5"/>
						</li>
					</ul>
				</div>
				<div class="typing">
					<p class="textBox">
						<textarea cols="50" rows="6" class="write" id="writearea" name="txtcomm" onClick="jsChklogin11('<%=IsUserLoginOK%>');" onblur="jsChkUnblur()" onKeyUp="jsChklogin11('<%=IsUserLoginOK%>');return Limit(this);" <%IF NOT IsUserLoginOK THEN%>readonly<%END IF%> autocomplete="off" maxlength="25"></textarea>
					</p>
					<p class="enroll"><span><input type="image"  src="http://webimage.10x10.co.kr/play/ground/20140310/btn_enroll.png" alt="등록하기" /></span></p>
				</div>
				</fieldset>
				</form>
				<form name="frmdelcom" method="post" action="doEventSubscript48871.asp" style="margin:0px;">
				<input type="hidden" name="eventid" value="<%=eCode%>">
				<input type="hidden" name="bidx" value="<%=bidx%>">
				<input type="hidden" name="Cidx" value="">
				<input type="hidden" name="mode" value="del">
				<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
				</form>
			</div>
		</div>
		<% IF isArray(arrCList) THEN %>
		<div class="memoListWrap">
			<div class="memoList">
				<ul>
					<% For intCLoop = 0 To UBound(arrCList,2) %>
					<li class="type0<%=arrCList(3,intCLoop)%>">
						<p class="num">no. <%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1)) %></p>
						<p class="txt"><span><%=nl2br(arrCList(1,intCLoop))%></span></p>
						<p class="writer"><span><em><%=printUserId(arrCList(2,intCLoop),2,"*")%>님의 메모</em></span></p>
						<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
						<p class="delete" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>')">삭제</p>
						<% end if %>
					</li>
					<% Next %>
				</ul>
				<div class="pageWrapV15">
					<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
				</div>
			</div>
		</div>
		<% End If %>
	</div>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->