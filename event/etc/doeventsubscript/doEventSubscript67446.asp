<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
'########################################################
' #사은품스타그램
' 2015-11-13 이종화 작성
'########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, userid , refer
Dim vQuery, vTotalCount , sub_opt2

	sub_opt2 = requestCheckVar(Request("opt"),1)
	userid = GetEncLoginUserID()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  65949
	Else
		eCode   =  67446
	End If

	If userid = "" Then
		response.write "<script>alert('잘못된 접근입니다.'); location.href='/event/eventmain.asp?eventid="& eCode &"';</script>"
		dbget.close() : Response.End
	End If
	
	vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid = '" & userid & "' AND evt_code = '" & eCode & "' and sub_opt2 = '"& sub_opt2 &"' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly

	IF Not rsget.Eof Then
		vTotalCount = rsget(0)
	End IF
	rsget.close

	If vTotalCount > 0 Then
		vQuery = "delete from [db_event].[dbo].[tbl_event_subscript]  WHERE userid = '" & userid & "' AND evt_code = '" & eCode & "' and sub_opt2 = '"& sub_opt2 &"' "
		dbget.Execute vQuery

		response.write "<script>location.href='/event/eventmain.asp?eventid="& eCode &"';</script>"
		dbget.close()
		response.end
	Else
		vQuery = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code, userid , sub_opt2 , device) VALUES('" & eCode & "', '" & userid & "' ,'"& sub_opt2 &"' , 'W')"
		dbget.Execute vQuery
		
		response.write "<script>location.href='/event/eventmain.asp?eventid="& eCode &"';</script>"
		dbget.close()
		response.end
	End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->