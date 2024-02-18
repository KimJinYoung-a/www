<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'#######################################################
'	History	:  2009.03.26 한용민 2008년 프론트 이벤트 이동/수정
'              2010.08.06 허진원 블로그URL 첨부기능 추가
'              2013.09.21 허진원 2013리뉴얼
'	Description : 공용 이벤트 코맨트
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/inc/head.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<%
dim cEComment ,eCode ,blnFull, cdl, com_egCode, bidx, blnBlogURL, strBlogURL
dim iCTotCnt, arrCList,intCLoop, epdate
dim iCPageSize, iCCurrpage, isMyComm
dim iCStartPage, iCEndPage, iCTotalPage, iCx,iCPerCnt

	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호
	eCode		= requestCheckVar(Request("eventid"),10) '이벤트 코드번호
	cdl			= requestCheckVar(Request("cdl"),3)
	blnFull		= requestCheckVar(Request("blnF"),10)
	blnBlogURL	= requestCheckVar(Request("blnB"),10)
	isMyComm	= requestCheckVar(request("isMC"),1)
	epdate		= requestCheckVar(Request("epdate"),20)

	IF blnFull = "" THEN blnFull = True
	IF blnBlogURL = "" THEN blnBlogURL = False

	IF iCCurrpage = "" THEN
		iCCurrpage = 1
	END IF
	IF iCTotCnt = "" THEN
		iCTotCnt = -1
	END IF

	if eCode="" then
		response.end
	end if

	iCPerCnt = 10		'보여지는 페이지 간격
	'한 페이지의 보여지는 열의 수
	if blnFull then
		iCPageSize = 15		'풀단이면 15개
	else
		iCPageSize = 10		'메뉴가 있으면 10개
	end if

	'2017웨딩 이벤트 코멘트 통합 171010 유태욱
	if eCode = "80615" or eCode = "80616" or eCode = "80617" then
		eCode = "80833"
	end if

	'데이터 가져오기
	set cEComment = new ClsEvtComment

	cEComment.FECode 		= eCode
	cEComment.FComGroupCode	= com_egCode
	cEComment.FEBidx    	= bidx
	cEComment.FCPage 		= iCCurrpage	'현재페이지
	cEComment.FPSize 		= iCPageSize	'페이지 사이즈
	if isMyComm="Y" then cEComment.FUserID = GetLoginUserID
	cEComment.FTotCnt 		= iCTotCnt  '전체 레코드 수

	arrCList = cEComment.fnGetComment		'리스트 가져오기
	iCTotCnt = cEComment.FTotCnt '리스트 총 갯수
	set cEComment = nothing

	iCTotalPage 	=  Int(iCTotCnt/iCPageSize)	'전체 페이지 수
	IF (iCTotCnt MOD iCPageSize) > 0 THEN	iCTotalPage = iCTotalPage + 1
%>
<script type="text/javascript">
function jsGoComPage(iP){
	document.frmcom.iCC.value = iP;
	document.frmcom.iCTot.value = "<%=iCTotCnt%>";
	document.frmcom.submit();
}

function jsSubmitComment(frm){
	if(frm.txtcomm.value =="로그인 후 글을 남길 수 있습니다."){
	jsChklogin('<%=IsUserLoginOK%>');
	return false;
	}

   <% if trim(epdate)<>"" then %>
	   <% if left(epdate, 10) <= left(now(), 10) then %>
		alert("당첨자 발표일이 지난 이벤트 입니다.");
		return false;
	   <% end if %>
   <% end if %>

   if(!frm.txtcomm.value){
    alert("코멘트를 입력해주세요");
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

function jsCheckLimit() {
   <% if trim(epdate)<>"" then %>
	   <% if left(epdate, 10) <= left(now(), 10) then %>
		alert("당첨자 발표일이 지난 이벤트 입니다.");
		document.frmcom.txtcomm.readOnly = true;
		return false;
	   <% else %>
		if ("<%=IsUserLoginOK%>"=="False") {
			jsChklogin('<%=IsUserLoginOK%>');
		}
	   <% end if %>
   <% else %>
	if ("<%=IsUserLoginOK%>"=="False") {
		jsChklogin('<%=IsUserLoginOK%>');
	}
   <% end if %>
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
<div class="basicCmt" style="padding-top:1px; min-height:450px;">
	<div class="basicCmtWrite">
	<form name="frmcom" method="post" onSubmit="return jsSubmitComment(this);" style="margin:0px;">
	<input type="hidden" name="eventid" value="<%=eCode%>">
	<input type="hidden" name="com_egC" value="<%=com_egCode%>">
	<input type="hidden" name="bidx" value="<%=bidx%>">
	<input type="hidden" name="iCC" value="<%=iCCurrpage%>">
	<input type="hidden" name="iCTot" value="">
	<input type="hidden" name="mode" value="add">
	<input type="hidden" name="spoint" value="0">
	<input type="hidden" name="isMC" value="<%=isMyComm%>">
		<% If blnBlogURL Then %>
			<div class="bPad05 overHidden"><strong class="fs11 cr000 ftLt tPad03">블로그 주소</strong> <p class="cmtInpWrap ftRt" style="width:88%; height:20px;"><input name="txtcommURL" type="text" /></p></div>
		<% end if %>
		<p class="cmtInpWrap" style="height:98px;">
			<textarea name="txtcomm" onClick="jsCheckLimit();" onKeyUp="jsCheckLimit();" <%IF NOT(IsUserLoginOK) THEN%>readonly<%END IF%>><%IF NOT IsUserLoginOK THEN%>로그인 후 글을 남길 수 있습니다.<%END IF%></textarea>
		</p>
		<div class="note01 overHidden tPad10">
			<ul class="list01 ftLt">
				<li>입력하신 블로그 주소는 개인정보 유출로 인한 피해를 막고자 비공개로 텐바이텐에 접수됩니다.</li>
				<li>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글 또는 도용한 글은 관리자에 의해 사전 통보 없이 삭제될 수 있으며,<br />이벤트 참여에 제한을 받을 수 있습니다.</li>
			</ul>
			<input type="submit" class="ftRt btn btnW130 btnS1 btnRed" value="코멘트 남기기" />
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
			<colgroup>
				<col width="60px" /><col width="*" /><col width="60px" /><col width="115px" /><col width="10px" />
			</colgroup>
			<tbody>
			<%
				IF isArray(arrCList) THEN
					dim arrUserid, bdgUid, bdgBno
					'사용자 아이디 모음 생성(for Badge)
					for intCLoop = 0 to UBound(arrCList,2)
						arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(arrCList(2,intCLoop)) & "''"
					next

					'뱃지 목록 접수(순서 랜덤)
					Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")

					For intCLoop = 0 To UBound(arrCList,2)
			%>
			<tr>
				<td class="colNo">
					<p><strong><%=iCTotCnt-intCLoop-(iCPageSize*(iCCurrpage-1))%></strong></p>
					<% If arrCList(8,intCLoop) <> "W" Then %><p class="tPad05"><img src="http://fiximage.10x10.co.kr/web2013/event/ico_mobile.png" alt="모바일" /></p><% end if %>
				</td>
				<td class="colCont">
					<div>
					<%=ReplaceBracket(db2html(arrCList(1,intCLoop)))%>
					<%
						'URL이 존재하고 본인 또는 STAFF가 접속해있다면 링크 표시
						strBlogURL = ReplaceBracket(db2html(arrCList(7,intCLoop)))
						if trim(strBlogURL)<>"" and (GetLoginUserLevel=7 or arrCList(2,intCLoop)=GetLoginUserID) then
							Response.Write "<br /><strong>URL: </strong><a href='" & ChkIIF(left(trim(strBlogURL),4)="http","","http://") & strBlogURL & "' target='_blank'>" & strBlogURL & "</a>"
						end if
					%>
					</div>
				</td>
				<td class="colDate"><%=FormatDate(arrCList(4,intCLoop),"0000.00.00")%></td>
				<td class="colWriter">
					<p><strong><%=printUserId(arrCList(2,intCLoop),2,"*")%></strong></p>
					<p class="badgeView tPad05"><%=getUserBadgeIcon(arrCList(2,intCLoop),bdgUid,bdgBno,3)%></p>
				</td>
				<td class="colDel">
					<% if ((GetLoginUserID = arrCList(2,intCLoop)) or (GetLoginUserID = "10x10")) and ( arrCList(2,intCLoop)<>"") then %>
					<a href="" onclick="jsDelComment('<% = arrCList(0,intCLoop) %>');return false;"><img src="http://fiximage.10x10.co.kr/web2013/event/btn_cmt_close.gif" alt="코멘트 삭제" /></a>
					<% end if %>
				</td>
			</tr>
			<%
					Next
				Else
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
		<%= fnDisplayPaging_New(iCCurrpage,iCTotCnt,iCPageSize,iCPerCnt,"jsGoComPage") %>
		</div>
	</div>
</div>
<form name="frmdelcom" method="post" action = "/event/lib/comment_process.asp" style="margin:0px;">
<input type="hidden" name="eventid" value="<%=eCode%>">
<input type="hidden" name="com_egC" value="<%=com_egCode%>">
<input type="hidden" name="bidx" value="<%=bidx%>">
<input type="hidden" name="Cidx" value="">
<input type="hidden" name="mode" value="del">
<input type="hidden" name="userid" value="<%=GetLoginUserID%>">
</form>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->