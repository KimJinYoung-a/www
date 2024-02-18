<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<% Response.Buffer = True %>
<%
'#############################################
'T-episode ajax - 김진영
' 2013-10-01 
'#############################################
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/play/playCls.asp" -->
<%
Dim idx : idx = getNumeric(requestCheckVar(request("idx"),8))
Dim oPhotopick, i
Dim playcode : playcode = 7
Dim viewtitle, subtitle, PPimg, regdate

Set oPhotopick = new CPlayContents
	oPhotopick.FRectIdx = idx
	oPhotopick.sbGetPhotoPickOneItem()

	viewtitle	= oPhotopick.FOneItem.FViewtitle
	subtitle	= oPhotopick.FOneItem.FSubtitle
	PPimg		= oPhotopick.FOneItem.FPPimg
	regdate		= oPhotopick.FOneItem.FRegdate
Set oPhotopick = nothing
%>
<div class="thumbnail">
	<img src="<%=PPimg%>" height="566" alt="<%= html2db(viewtitle) %>" />
</div>
<div class="view">
	<div class="title">
	<% If DateDiff("d", Date(), regdate) >= -7 Then %>
		<em class="ico"><img src="http://fiximage.10x10.co.kr/web2013/play/ico_new.gif" alt="NEW" /></em>
	<% End If %>
		<strong><%= html2db(viewtitle) %></strong>
	</div>
	<div class="viewAdd">
		<p><%=nl2br(html2db(subtitle))%></p>
	</div>
<%
Set oPhotopick = new CPlayContents
	oPhotopick.FRectIdx = idx
	oPhotopick.Fplaycode = playcode
	oPhotopick.GetRowTagContent()
	If oPhotopick.FTotalCount > 0 Then
%>
	<% If oPhotopick.FTotalCount > 0 Then %>
	<div class="tagView">
		<strong>Tag</strong>
	<% For i = 0 To oPhotopick.FTotalCount -1 %>
		<a href="<%=chkiif(oPhotopick.FItemList(i).Ftagurl="","/search/search_result.asp?rect="&oPhotopick.FItemList(i).Ftagname&"",oPhotopick.FItemList(i).Ftagurl)%>"><%=oPhotopick.FItemList(i).Ftagname%></a>
	<% Next %>
	</div>
	<% End If %>
<%
	End If
Set oPhotopick = nothing
%>
</div>
<!-- #include virtual="/lib/db/dbclose.asp" -->