<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim due
due = request("due")
If due = "later" Then
	response.Cookies("hitchVIP").domain = "10x10.co.kr"
	response.Cookies("hitchVIP")("mode") = "o"
	response.cookies("hitchVIP").Expires = Date - 1
ElseIf due = "one" Then
	response.Cookies("hitchVIP").domain = "10x10.co.kr"
	response.Cookies("hitchVIP")("mode") = "x"
	response.cookies("hitchVIP").Expires = Date + 1
ElseIf due = "seven" Then
	response.Cookies("hitchVIP").domain = "10x10.co.kr"
	response.Cookies("hitchVIP")("mode") = "x"
	response.cookies("hitchVIP").Expires = Date + 7
ElseIf due = "all" Then
	response.Cookies("hitchVIP").domain = "10x10.co.kr"
	response.Cookies("hitchVIP")("mode") = "x"
	response.cookies("hitchVIP").Expires = Date + 30
	'response.cookies("hitchVIP").Expires = DateAdd("s", 10, now)
End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->