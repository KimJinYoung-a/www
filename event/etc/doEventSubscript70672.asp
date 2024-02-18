<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description :  ## 텐바이텐 X 앵그리버드 : 행운을 날리새오
' History : 2016-05-09 김진영 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/event/appdown/appdownCls.asp" -->
<%
Dim eCode, userid, mode, sqlstr, refer, isEventPeriod
Dim smssubscriptcount

isEventPeriod		= "N"
IF application("Svr_Info") = "Dev" THEN
	eCode = 66120
	If Now() >= #05/09/2016 00:00:00# And now() < #05/18/2016 23:59:59# Then
		isEventPeriod = "Y"
	End If
Else
	eCode = 70672
	If Now() >= #05/11/2016 00:00:00# And now() < #05/18/2016 23:59:59# Then
		isEventPeriod = "Y"
	End If
End If

smssubscriptcount	= 0
userid				= getloginuserid()
mode				= requestcheckvar(request("mode"),32)
refer				= request.ServerVariables("HTTP_REFERER")

If InStr(refer,"10x10.co.kr") < 1 Then
	Response.Write "잘못된 접속입니다."
	dbget.close() : Response.End
End If

If userid = "" Then
	Response.Write "<script type='text/javascript'>alert('로그인을 해주세요'); top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
	dbget.close() : Response.End
End IF
If isEventPeriod = "N" Then
	Response.Write "<script type='text/javascript'>alert('이벤트 응모 기간이 아닙니다.'); top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
	dbget.close() : Response.End
End IF

If mode = "addsms" Then
	smssubscriptcount = getevent_subscriptexistscount(eCode, userid, "SMS_W", "", "")

	If smssubscriptcount >= 3 Then
		Response.Write "<script type='text/javascript'>alert('메세지는 3회까지 발송 가능 합니다.'); top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
		dbget.close() : Response.End
	End If

	sqlstr = "INSERT INTO [SMSDB].[db_infoSMS].dbo.em_smt_tran (recipient_num, callback, msg_status, date_client_req, content, service_type) " & vbcrlf
	sqlstr = sqlstr & " 	select top 1 n.usercell, '1644-6030', '1', getdate(), '텐바이텐에서 앵그리버드를 만나고 싶다면? 텐바이텐 APP을 받아주새오! http://bit.ly/hi10x10','0'" & vbcrlf
	sqlstr = sqlstr & " 	from db_user.dbo.tbl_user_n n" & vbcrlf
	sqlstr = sqlstr & " 	where userid='"& userid &"'"
	dbget.execute sqlstr
			
	sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, sub_opt2, sub_opt3)" + vbcrlf
	sqlstr = sqlstr & " VALUES("& eCode &", '" & userid & "', 'SMS_W', 0, '')" + vbcrlf
	'response.write sqlstr & "<Br>"
	dbget.execute sqlstr

	Response.Write "<script type='text/javascript'>alert('메세지가 발송 되었습니다.'); top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
	dbget.close() : Response.End	
Else
	Response.Write "<script type='text/javascript'>alert('정상적인 경로가 아닙니다.'); top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
	dbget.close() : Response.End
End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->