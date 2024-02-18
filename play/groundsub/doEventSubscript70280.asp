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
<!-- #include virtual="/lib/util/md5.asp" -->
<%
dim eCode, userid, mode, vTotalCount , sub_opt1
Dim vQuery
Dim device , referer
Dim pagereload

referer = request.ServerVariables("HTTP_REFERER")

mode = requestcheckvar(request("mode"),32)
sub_opt1 = getNumeric(request("sub_opt1"))
pagereload = requestcheckvar(request("pagereload"),2)

If InStr(referer,"?pagereload=ON") >0 then
	referer = Replace(referer,"?pagereload=ON","")
End If 

userid = GetEncLoginUserID()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66108
	Else
		eCode   =  70280
	End If

	If userid = "" Then
		Response.Write "<script>alert('로그인후 이용 가능 합니다.');parent.top.location.href='"&referer&"?pagereload="&pagereload&"';</script>"
		dbget.close()
		response.end
	End If

'//하루 한번 응모
If mode = "add" Then 
'===================================================================================================================================================================================================
	Sub fnGetPrize() '응모
		'//이벤트 테이블에 등록
		vQuery = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code, userid, sub_opt1 , device) VALUES('" & eCode & "', '" & userid & "', "& sub_opt1 &" , 'W')"
		dbget.Execute vQuery
		Response.Write "<script>alert('투표가 완료 되었습니다.');parent.top.location.href='"&referer&"?pagereload="&pagereload&"';</script>"
		dbget.close()
		Response.end
	End Sub
'===================================================================================================================================================================================================
	'// 이벤트 내역 확인
	vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid = '" & userid & "' And evt_code='"&eCode&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly 
	IF Not rsget.Eof Then
		vTotalCount = rsget(0)
	End If
	rsget.close()
	
	'// 이미 응모 완료
	If vTotalCount > 4 Then
		Response.Write "<script>alert('ID당 5회까지 응모 하실 수 있습니다.');parent.top.location.href='"&referer&"?pagereload="&pagereload&"';</script>"
		dbget.close()
		response.End
	Else 	
		Call fnGetPrize() '//응모
	End If 
End If 
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->