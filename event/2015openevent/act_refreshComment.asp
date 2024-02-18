<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description :  2015오픈이벤트 새로고침 - 코멘트 리스트 AJAX
' History : 2015.04.13 허진원 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
	Dim iCPerCnt, iCPageSize, iCCurrpage
	iCCurrpage	= requestCheckVar(Request("iCC"),10)	'현재 페이지 번호

	dim evt_code, i, renloop
	dim userid: userid = getloginuserid()
	
	IF application("Svr_Info") = "Dev" THEN
		evt_code   =  60742
	Else
		evt_code   =  60835
	End If

	IF iCCurrpage = "" THEN iCCurrpage = 1
	iCPageSize = 12
	iCPerCnt = 10		'보여지는 페이지 간격

	dim ccomment
	set ccomment = new Cevent_etc_common_list
		ccomment.FPageSize		= iCPageSize
		ccomment.FCurrpage		= iCCurrpage
		ccomment.FScrollCount	= iCPerCnt
		ccomment.frectordertype	= "new"
		ccomment.frectevt_code	= evt_code
		ccomment.frectsub_opt1	= evt_code
		ccomment.event_subscript_paging
%>
<% IF ccomment.ftotalcount>0 THEN %>
	<ul>
	<%
	for i = 0 to ccomment.fresultcount - 1
		randomize
		renloop=int(Rnd*5)+1
	%>
		<li class="type0<%= renloop %>">
			<p class="num">NO.<%=ccomment.FTotalCount-i-(ccomment.FPageSize*(ccomment.FCurrPage-1))%></p>
			<p class="msg"><%=ReplaceBracket(ccomment.FItemList(i).fsub_opt3)%></p>
			<p class="writer">
				<span><%=printUserId(ccomment.FItemList(i).fuserid,2,"*")%></span>
				<span class="date"><%=FormatDate(ccomment.FItemList(i).fregdate,"0000-00-00")%></span>
			</p>
			<% if ((userid = ccomment.FItemList(i).fuserid) or (userid = "10x10")) and ( ccomment.FItemList(i).fuserid<>"") then %>
				<p class="del"><a href="" onclick="jsDelComment('<%= ccomment.FItemList(i).fsub_idx %>'); return false;"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60835/btn_delete.gif" alt="삭제" /></a></p>
			<% end if %>
		</li>
	<% next %>
	</ul>
<% end if %>
	<div class="pageWrapV15 tMar20">
		<%= fnDisplayPaging_New(ccomment.FCurrpage, ccomment.ftotalcount, ccomment.FPageSize, ccomment.FScrollCount,"jsGoComPage") %>
	</div>
<% set ccomment = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->