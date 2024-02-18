<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	Dim iDFSeq
	iDFSeq = getNumeric(requestcheckvar(request("fingerid"),4))
	Response.Redirect "/play/playDesignFingers.asp?fingerid=" & iDFSeq
%>