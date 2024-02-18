<%
	Dim cCa3Co, i3, vCa3page, vCa3pagesize, vCa3ComCnt
	vCa3page	= getNumeric(requestCheckVar(Request("page"),10))
	vIsMine	= requestCheckVar(Request("ismine"),1)
	If vCa3page = "" Then
		vCa3page = "1"
	End If
	vCa3pagesize = 6
	
	Set cCa3Co = New CPlay
	cCa3Co.FRectDIdx = vDIdx
	cCa3Co.FCurrPage = vCa3page
	cCa3Co.FPageSize = vCa3pagesize
	cCa3Co.FRectTop	= vCa3page*vCa3pagesize
	cCa3Co.FRectIsMine = vIsMine
	cCa3Co.sbPlayAzitComment
	
	vCa3ComCnt = cCa3Co.FTotalCount
%>
<script>
function chkfrm3(f){
<% If IsUserLoginOK() Then %>
	if(f.comment1.value == ""){
		alert("추천 아지트를 입력해주세요!(20자 이내)");
		f.comment1.focus();
		return false;
	}
	if(f.comment2.value == ""){
		alert("추천 이유를 입력해주세요!(200자 이내)");
		f.comment2.focus();
		return false;
	}
	return true;
<% Else %>
	if(confirm("로그인 하시겠습니까?")){
		location.href='/login/loginpage.asp?backpath=<%=Server.URLencode("/playing/view.asp?didx="&vDIdx&"")%>';
		return false;
	}
	return false;
<% End If %>
}
</script>
<div class="form">
	<div class="field">
		<form name="frm3" method="post" action="azit_proc.asp" onSubmit="return chkfrm3(this);">
		<input type="hidden" name="didx" value="<%=vDidx%>">
			<fieldset>
			<legend class="hidden">추천 아지트 작성 폼</legend>
				<div class="desc">
					<h3>공유하고 싶은 아지트를 추천해 주세요!</h3>
					<p><%=vCate3EntryCont%></p>
					<p class="date">응모기간 : <%=vCate3EntrySDate%> ~ <%=vCate3EntryEDate%>  |  발표 : <%=vCate3AnnounDate%></p>
				</div>

				<div class="texarea">
					<input type="text" title="추천 아지트 입력" name="comment1" value="" maxlength="20" placeholder="추천 아지트 (20자 이내)" <%=CHKIIF(IsUserLoginOK(),"","onclick='chkfrm3(this)'")%> />
					<textarea cols="60" rows="5" title="추천 이유 입력" name="comment2" value="" maxlength="200" placeholder="추천 이유 (200자 이내)" <%=CHKIIF(IsUserLoginOK(),"","onclick='chkfrm3(this)'")%>></textarea>
					<div class="btnSubmit"><button type="submit">추천<br />하기</button></div>
				</div>
			</fieldset>
		</form>
	</div>
</div>

<div class="summary">
	<div class="noti">
		<ul>
			<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
			<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br /> 이벤트 참여에 제한을 받을 수 있습니다.</li>
		</ul>
	</div>
</div>

<!-- comment list -->
<script src="/lib/js/jquery.tinyscrollbar.js"></script>
<script type="text/javascript">
	$(function(){
		$(".scrollbarwrap").tinyscrollbar();
	});
</script>
<div class="listComment" id="licmt3">
	<h3 class="hidden">코멘트 목록</h3>
	<div class="option">
		<div class="total"><span>Total</span> (<%=vCa3ComCnt%>)</div>
		<% If IsUserLoginOK() Then %>
			<% If vIsMine = "o" Then %>
				<a href="view.asp?didx=<%=vDIdx%>&iscomm=o">전체 코멘트 보기</a>
			<% Else %>
				<a href="view.asp?didx=<%=vDIdx%>&ismine=o&iscomm=o">내 코멘트 보기</a>
			<% End If %>
		<% End If %>
	</div>
	<%
	If (cCa3Co.FResultCount < 1) Then
		Response.Write "<p class=""noData"">작성된 코멘트가 없습니다.</p>"
	Else
	%>
	<ul>
		<% For i3 = 0 To cCa3Co.FResultCount-1 %>
		<li>
			<div class="writer">
				<span class="id"><%=printUserId(cCa3Co.FItemList(i3).FCa3ComUserID,2,"*")%></span>
				<% If cCa3Co.FItemList(i3).FCa3ComUserID = getEncLoginUserID() Then %>
				&nbsp;<button type="button" class="btnDel" onClick="jsCa3ComDel('<%=cCa3Co.FItemList(i3).FCa3Idx%>');">삭제</button>
				<% End If %>
				<span class="date"><%=FormatDate(cCa3Co.FItemList(i3).FCa3ComRegdate,"0000.00.00")%></span>
			</div>
			<div class="scrollbarwrap">
				<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>
				<div class="viewport">
					<div class="overview">
						<div class="textarea">
							<div><b><%=cCa3Co.FItemList(i3).Fcomment1%></b></div>
							<p><%=cCa3Co.FItemList(i3).Fcomment2%></p>
						</div>
					</div>
				</div>
			</div>
		</li>
		<% Next %>
	</ul>
	<%	End If	%>
	<!-- pagination -->
	<div class="pageWrapV15">
		<%= fnDisplayPaging_New(vCa3page,vCa3ComCnt,vCa3pagesize,10,"jsCa3Page") %>
	</div>
</div>
<form name="frm3com" method="get" action="">
<input type="hidden" name="didx" value="<%=vDidx%>">
<input type="hidden" name="page" value="">
<input type="hidden" name="iscomm" value="o">
</form>
<form name="frm3comdel" method="post" action="azit_proc.asp">
<input type="hidden" name="action" value="delete">
<input type="hidden" name="didx" value="<%=vDidx%>">
<input type="hidden" name="idx" value="">
<input type="hidden" name="ismine" value="<%=vIsMine%>">
</form>