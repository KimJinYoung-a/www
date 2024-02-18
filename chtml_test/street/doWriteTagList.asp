<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.charset = "UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
	If GetLoginUserLevel() <> "7" Then
		Response.Write "<script language='javascript'>alert('텐바이텐 로그인을 하세요.');window.close();</script>"
		Response.End
	End If
	
	dim savePath, FileName, fso, tFile, vTag
	vTag = requestCheckVar(Request("tag"),100)
	
	savePath = server.mappath("/chtml/") + "\street\"
	FileName = "taglist.txt"

	Set fso = Server.CreateObject("ADODB.Stream")
		fso.Open
		fso.Type = 2
		fso.Charset = "UTF-8"
		fso.WriteText (vTag)
		fso.SaveToFile savePath & FileName, 2
	Set fso = nothing
%>
<script language="javascript">
<!--	
	document.domain ="10x10.co.kr";	
		
	self.location.href = "<%= wwwUrl %>/chtml/street/taglist.asp";
//-->
</script>
