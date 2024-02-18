<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim due, gourl, sqlStr, AssignedRow, couponDownCnt, snsrdsite
due = request("due")
gourl = request("gourl")
snsrdsite = request("snsrdsite")

If due = "one" Then
	response.Cookies(snsrdsite).domain = "10x10.co.kr"
	response.cookies(snsrdsite)("mode") = "x"
	response.cookies(snsrdsite).Expires = Date + 365
	If gourl <> "" Then
		response.write "<script>top.location.href='"&gourl&"';</script>"
	End If
End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->