<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	: 2010.04.08 한용민 생성
'           : 2013.09.16 허진원 ; 2013리뉴얼
'	Description : culturestation 코멘트 iframe
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/culturestation/culturestation_class.asp" -->
<%
dim evt_code , page ,i , idx_ix ,eventstats, isMyComm
dim arrUserid, bdgUid, bdgBno
	eventstats = requestCheckVar(request("eventstats"),10)
	page = getNumeric(requestCheckVar(request("page"),5))
	if page = "" then page = 1

	evt_code = getNumeric(requestCheckVar(request("evt_code"),5))
	isMyComm = requestCheckVar(request("isMC"),1)

	if evt_code = "" then
	response.write "<script>alert('이벤트코드가 없거나 승인된 페이지가 아닙니다.');</script>"
	dbget.close()	:	response.End
	end if

dim oip_comment
	set oip_comment = new cevent_list
	oip_comment.FPageSize = 10
	oip_comment.FCurrPage = page
	oip_comment.frectevt_code = evt_code
	if isMyComm="Y" then oip_comment.frectUserid = GetLoginUserID
	oip_comment.fevent_comment()
%>
<script type="text/javascript">
// 등록
	function reg(){
		if(document.frmcontents.comment.value =="로그인 후 글을 남길 수 있습니다."){
		jsChklogin('<%=IsUserLoginOK%>');
		return;
		}

		if (GetByteLength(document.frmcontents.comment.value) > 600){
			alert("내용이 제한길이를 초과하였습니다. 300자 까지 작성 가능합니다.");
			document.frmcontents.comment.focus();
		}else if(document.frmcontents.comment.value ==''){
			alert("글을 작성해 주세요.");
			document.frmcontents.comment.focus();
		}else{
		document.frmcontents.submit();
		}
	}

// 고객글 삭제하기
	function delete_comment(idx){
	var ret;
	ret = confirm('해당 글을 삭제 하시겠습니까?');

	if (ret){
		document.frmcontents.idx.value = +idx
		document.frmcontents.mode.value = "delete_comment";
		document.frmcontents.submit();
	}
	}

// 클릭 확인
	function jsCheckLimit() {
		if ("<%=IsUserLoginOK%>"=="False") {
			jsChklogin('<%=IsUserLoginOK%>');
		}
	}

	function jsGoPage(iP){
		document.pageFrm.page.value = iP;
		document.pageFrm.submit();
	}

//내코멘트 보기
function fnMyComment() {
	document.pageFrm.isMC.value="<%=chkIIF(isMyComm="Y","N","Y")%>";
	document.pageFrm.page.value=1;
	document.pageFrm.submit();
}

<% if page > 1 then %>
	var position=$(".basicCmtWrap",parent.document).offset();
	$('html, body', window.parent.document).animate({scrollTop:position.top}, 'slow');
<% end if %>
</script>
</head>
<body ondragstart="return false;" onselectstart="return false">
<div class="basicCmt" style="padding-top:1px; min-height:450px;">
	<div class="basicCmtWrite">
	<form name="frmcontents" method="post" action="/culturestation/culturestation_event_process.asp" style="margin:0px;">
	<input type="hidden" name="idx">
	<input type="hidden" name="mode">
	<input type="hidden" name="evt_code" value="<%= evt_code %>">
		<p class="cmtInpWrap" style="height:98px;"><textarea name="comment" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<%elseIF eventstats > "0" THEN %>종료된 이벤트 입니다<%END IF%></textarea></p>
		<div class="note01 overHidden tPad10">
			<ul class="list01 ftLt">
				<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
				<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 <br />삭제될 수 있으며, 이벤트 참여에 제한을 받을 수 있습니다.</li>
			</ul>
			<a href="" class="ftRt btn btnW130 btnS1 btnRed" onclick="<%=chkIIF(eventstats>"0","","reg();")%>return false;" >코멘트 남기기</a>
		</div>
	</form>
	</div>

	<div class="basicCmtList tMar40">
		<div class="rt">
			<span class="badgeInfo addInfo"><strong>10x10 BADGE</strong>
				<div class="contLyr" style="width:270px;">
					<div class="contLyrInner">
						<dl class="badgeDesp">
							<dt><strong>10X10 BADGE?</strong></dt>
							<dd>
								<p>고객님의 쇼핑패턴을 분석하여 자동으로 달아드리는 뱃지입니다. 후기작성 및 코멘트 이벤트 참여시 획득한 뱃지를 통해 타인에게 신뢰 및 어드바이스를 전달 해줄 수 있습니다.</p>
								<p class="tPad10">나의 뱃지는 <a href="/my10x10/" target="_top" class="cr000 txtL">마이텐바이텐</a>에서 확인하실 수 있습니다.</p>
							</dd>
						</dl>
					</div>
				</div>
			</span>
			<a href="" onclick="fnMyComment(); return false;" class="lMar10 btn btnS2 btnGrylight btnW130"><em class="fn gryArr01"><%=chkIIF(isMyComm="Y","전체 코멘트 보기","내가 쓴 코멘트 보기")%></em></a>
		</div>
		<table class="tMar10">
			<caption>코멘트 리스트</caption>
			<tbody>
			<%

				if oip_comment.FResultCount > 0 then
					'사용자 아이디 모음 생성(for Badge)
					for i = 0 to oip_comment.FResultCount -1
						arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(oip_comment.FItemList(i).fuserid) & "''"
					next

					'뱃지 목록 접수(순서 랜덤)
					Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")

					'// 코멘트 목록 시작
					for i = 0 to oip_comment.FResultCount -1
			%>
			<tr>
				<td class="colNo">
					<p><strong><%= (oip_comment.ftotalcount - (oip_comment.FPageCount * oip_comment.FPageSize)) -i %></strong></p>
					<% if oip_comment.FItemList(i).FDevice<>"W" then %><p class="tPad05"><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일에서 작성됨" /></p><% end if %>
				</td>
				<td class="colCont"><div><%= nl2br(oip_comment.FItemList(i).fcomment) %></div></td>
				<td class="colDate"><%= FormatDate(oip_comment.FItemList(i).fregdate,"0000.00.00") %></td>
				<td class="colWriter">
					<p style="margin-bottom:5px;"><strong><%= printUserId(oip_comment.FItemList(i).fuserid,2,"*") %></strong></p>
					<%=getUserBadgeIcon(oip_comment.FItemList(i).fuserid,bdgUid,bdgBno,3)%>
				</td>
				<td class="colDel">
				<% if cstr(GetLoginUserID) = cstr(oip_comment.FItemList(i).fuserid) then %>
					<a href="" onclick="delete_comment(<%=oip_comment.FItemList(i).fidx%>);return false;"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제" /></a>
				<% end if %>
				</td>
			</tr>
			<%
					Next
				else
			%>
			<tr>
				<td colspan="5">
					<p class="fb fs12 pad15 cr555">등록된 코멘트가 없습니다.</p>
				</td>
			</tr>
			<% end if %>
			</tbody>
		</table>
		<div class="pageWrapV15 tMar20">
		<%= fnDisplayPaging_New_nottextboxdirect(page,oip_comment.ftotalcount,10,10,"jsGoPage") %>
		</div>
	</div>
</div>
<form name="pageFrm" method="get" action="<%=CurrURL()%>" style="margin:0px;">
<input type="hidden" name="page" value="">
<input type="hidden" name="evt_code" value="<%=evt_code%>">
<input type="hidden" name="isMC" value="<%=isMyComm%>">
</form>
</body>
</html>
<% set oip_comment = nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->