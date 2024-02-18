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

	Dim fso, oFile, vTag
	Set fso = CreateObject("Scripting.FileSystemObject")
	If (fso.FileExists(server.mappath("/chtml/street/")&"\taglist.txt")) Then
		Set oFile = Server.CreateObject("ADODB.Stream")
			oFile.CharSet = "UTF-8"
			oFile.Open
			oFile.LoadFromFile(server.mappath("/chtml/street/")&"\taglist.txt")
			vTag = oFile.ReadText()
		Set oFile = nothing
	End If
	Set fso = nothing
%>

<script language="javascript">
document.domain ="10x10.co.kr";
</script>

<div style="padding: 0 5 5 5" style="font:9pt/135% "굴림";color:#000000"> ▶ <b>추천 검색어</b> (태그와 태그는 | 로 구분)</div>
<table width="100%" border="0" align="left" style="font:9pt/135% "굴림";color:#000000" cellpadding="3" cellspacing="1" bgcolor="#999999">
<form name="frmImg" method="post" action="<%= www1Url %>/chtml/street/doWriteTagList.asp">
<tr>
	<td bgcolor="#E6E6E6">BRAND TAG</td>
	<td bgcolor="#FFFFFF"><input type="text" name="tag" value="<%=vTag%>" size="35"></td>
</tr>
<tr>
	<td colspan="2" bgcolor="#FFFFFF" align="right">
		<input type="submit" value="저장">&nbsp;
		<input type="button" value="닫기" onclick="window.close();">
	</td>
</tr>
</form>
</table>
