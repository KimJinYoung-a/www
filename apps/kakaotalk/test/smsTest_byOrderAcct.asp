<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<%
	dim osms
    set osms = new CSMSClass

	call osms.SendJumunOkMsg("010-6324-9110", "12071661111")

	set osms = Nothing

	response.Write now
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->