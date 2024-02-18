<%
	'Dim WinnerBody
	isMyComm	= requestCheckVar(request("isMC"),1)
%>
<script language="JavaScript">
<!--
//코멘트 수정
function jsGoCommUpdate(v){
	iframeDB.location.href = "/play/lib/iframe_designfingers_comment.asp?commentGubun=V&iDFS=<%=iDFSeq%>&id="+v;
}

//코멘트 페이지 이동
function jsGoCommPage(iP){

	iframeDB.location.href = "/play/lib/iframe_designfingers_comment.asp?iDFS=<%=iDFSeq%>&iCC="+iP;
}

function uploadcoment(){

	var frm = document.upcomment;
	if(frm.tx_comment.value =="로그인 후 글을 남길 수 있습니다."){
		jsChklogin('<%=IsUserLoginOK%>');
		return false;
	}

	if (!jsChkNull("text",frm.tx_comment,"내용을 입력 해주세요")){
		frm.tx_comment.focus();
		return false;
	}
	frm.submit();
}

function DelComments(v){
	if (confirm('삭제 하시겠습니까?')){
		document.frmact.sM.value= "D";
		document.frmact.id.value = v;
		document.frmact.submit();
	}
}

function UpdateComments(v){

	if (!jsChkNull("text",document.upcomment.tx_comment,"내용을 입력 해주세요")){
		document.upcomment.tx_comment.focus();
		return false;
	}

	document.frmact.sM.value= "U";
	document.frmact.id.value = v;
	document.frmact.tx_comment.value = document.upcomment.tx_comment.value;
	document.frmact.tx_commentURL.value = document.upcomment.tx_commentURL.value;
	document.frmact.submit();
}

function jsCheckLimit() {

	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}
}

//내코멘트 보기
function fnMyComment(ip) {

	iframeDB.location.href = "/play/lib/iframe_designfingers_comment.asp?iDFS=<%=iDFSeq%>&iCC=1&isMC="+ip;

}

//-->
</script>

<div class="basicCmt">

		<%
			'// 2010.6월 이벤트 기간동안의 디자인핑거스에 URL입력창 표시
			if iDFSeq>=740 and iDFSeq<=761 then
		%>

			<form method="post" action="/play/lib/dozfcomment.asp" name="upcomment" target="iframeDB" style="margin:0px;">
			<input type="hidden" name="userid" value="<%= GetLoginUserID %>">
			<input type="hidden" name="masterid" value="<%= iDFSeq %>">
			<input type="hidden" name="gubuncd" value="7">
			<input type="hidden" name="sitename" value="10x10">
			<input type="hidden" name="sM" value="I">
			<div id="setDFCommTxt" class="basicCmtWrite">
				<div class="bPad05 overHidden"><strong class="fs11 cr000 ftLt tPad03">블로그 주소</strong> <p class="cmtInpWrap ftRt" style="width:88%; height:20px;"><input type="text" name="tx_commentURL" id="tx_commentURL" /></p></div>
				<p class="cmtInpWrap" style="height:98px;"><textarea name="tx_comment" id="tx_comment" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF  NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<%END IF%></textarea></p>
				<div class="note01 overHidden tPad10">
					<ul class="list01 ftLt">
						<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
						<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br />이벤트 참여에 제한을 받을 수 있습니다.</li>
					</ul>
					<a href="JavaScript:uploadcoment()" class="ftRt btn btnW130 btnS1 btnRed">코멘트 남기기</a>
				</div>
			</div>
			</form>

		<% else %>

			<form method="post" action="/play/lib/dozfcomment.asp" name="upcomment" target="iframeDB" style="margin:0px;">
			<input type="hidden" name="userid" value="<%= GetLoginUserID %>">
			<input type="hidden" name="masterid" value="<%= iDFSeq %>">
			<input type="hidden" name="gubuncd" value="7">
			<input type="hidden" name="sitename" value="10x10">
			<input type="hidden" name="sM" value="I">
			<div id="setDFCommTxt" class="basicCmtWrite">
				<p class="cmtInpWrap" style="height:98px;"><textarea name="tx_comment" id="tx_comment" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF  NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<%END IF%></textarea></p>
				<div class="note01 overHidden tPad10">
					<ul class="list01 ftLt">
						<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br />이벤트 참여에 제한을 받을 수 있습니다.</li>
					</ul>
					<a href="" onclick="uploadcoment();return false;" class="ftRt btn btnW130 btnS1 btnRed">코멘트 남기기</a>
				</div>
				<input name="tx_commentURL" id="tx_commentURL" type="hidden">
			</div>
			</form>

		<% end if %>


<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">

<tr>
	<td style="padding:0 0px 0 0px;">
		<div id="setDFComm" class="basicCmtList tMar40">
		<%
			set clsDFComm = new CDesignFingersComment
			clsDFComm.FRectFingerID = iDFSeq
			clsDFComm.FCurrPage		= iComCurrentPage
			if isMyComm="Y" then clsDFComm.FRectUserID = GetLoginUserID
			clsDFComm.sbGetCommentDisplay
			set clsDFComm = nothing
		%>
		</div>
	</td>
</tr>
</table>
<form name="frmact" method="post" action="/play/lib/dozfcomment.asp" target="iframeDB">
<input type="hidden" name="sM" value="D">
<input type="hidden" name="userid" value="<%= GetLoginUserID %>">
<input type="hidden" name="masterid" value="<%= iDFSeq %>">
<input type="hidden" name="id" value="">
<input type="hidden" name="uid" value="">
<input type="hidden" name="iCC" value="<%=iComCurrentPage%>">
<input type="hidden" name="tx_comment" value="">
<input type="hidden" name="tx_commentURL" value="">
</form>
<form name="frm1" method="get" action="<%=CurrURL()%>" style="margin:0px;">
<input type="hidden" name="page" value="">
<input type="hidden" name="isMC" value="<%=isMyComm%>">
<input type="hidden" name="userid" value="<%= GetLoginUserID %>">
<input type="hidden" name="fingerid" value="<%= iDFSeq %>">
</form>

</div>