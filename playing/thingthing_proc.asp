<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<%
	Dim vQuery, vIsMine, vAction, vDidx, vIdx, vEntryValue, vUserID, vWriteCnt, vDevice
	vWriteCnt = 0
	vUserID 		= getEncLoginUserID()
	vAction		= RequestCheckVar(request("action"),6)
	vIdx			= RequestCheckVar(request("idx"),10)
	vDidx			= RequestCheckVar(request("didx"),10)
	vEntryValue	= RequestCheckVar(request("entryvalue"),100)
	
	If vUserID = "" Then
		dbget.close
		Response.End
	End If

	vDevice = "W"

	If vAction = "delete" Then
		vQuery = "IF EXISTS(select idx from [db_giftplus].[dbo].[tbl_play_thingthing_entry] where userid = '"&vUserID&"' and didx = '"&vDidx&"' and idx = '"&vIdx&"') "
		vQuery = vQuery & "BEGIN "
		vQuery = vQuery & "	DELETE [db_giftplus].[dbo].[tbl_play_thingthing_entry] where userid = '"&vUserID&"' and didx = '"&vDidx&"' and idx = '"&vIdx&"' "
		vQuery = vQuery & "END "
		dbget.Execute vQuery
		
		Response.Write "<script>location.href='view.asp?didx="&vDidx&"&ismine="&vIsMine&"&iscomm=o';</script>"
		dbget.close
		Response.End
	Else
		vQuery = "SELECT count(idx) From [db_giftplus].[dbo].[tbl_play_thingthing_entry] Where userid = '"&vUserID&"' and didx = '"&vDidx&"'"
		rsget.CursorLocation = adUseClient
		rsget.Open vQuery,dbget,adOpenForwardOnly,adLockReadOnly
		If Not rsget.eof Then
			vWriteCnt = rsget(0)
		End If
		rsget.close
		
		If vWriteCnt > 4 Then	'### 5개까지만 저장 가능.
			Response.Write "<script>alert('5개까지 작성이 가능합니다.'); location.href='view.asp?didx="&vDidx&"&iscomm=o';</script>"
			dbget.close
			Response.End
		Else
			vQuery = "INSERT INTO [db_giftplus].[dbo].[tbl_play_thingthing_entry](didx, userid, entryvalue, device, regdate) "
			vQuery = vQuery & "VALUES('" & vDidx & "', '" & vUserID & "', '" & vEntryValue & "', '" & vDevice & "', getdate()) "
			dbget.Execute vQuery
			
			Response.Write "<script>location.href='view.asp?didx="&vDidx&"&iscomm=o';</script>"
			dbget.close
			Response.End
		End If
	End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->