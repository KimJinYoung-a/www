<%@codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet = "UTF-8"
'####################################################
' Description : 매일리지 알림
' History : 2022.11.30 정태훈 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp"-->
<%
	Response.ContentType = "application/json"
	response.charset = "utf-8"
	dim currentDate, eventStartDate, eventEndDate, i, refer, resultCode
	Dim eCode, LoginUserid, mode, sqlStr, device, snsType, returntext, eventobj, idx, vQuery
	dim result, oJson, mktTest, rvalue, couponCode, cnt, phoneNumber
    refer 		= request.ServerVariables("HTTP_REFERER") '// 레퍼러
	Set oJson = jsObject()
	mode = request("mode")
	phoneNumber = requestCheckVar(request("phoneNumber"),100)
    LoginUserid		= getencLoginUserid()

	IF application("Svr_Info") = "Dev" THEN
	else
		If InStr(refer, "10x10.co.kr") < 1 Then
			oJson("response") = "err"
			oJson("message") = "잘못된 접속입니다."
			oJson.flush
			Set oJson = Nothing
			dbget.close() : Response.End
		End If
	End If

	mktTest = False

    IF application("Svr_Info") = "Dev" THEN
        eCode = "119233"
        mktTest = True
    ElseIf application("Svr_Info")="staging" Then
        eCode = "121349"
        mktTest = True
    Else
        eCode = "121349"
        mktTest = False
    End If

    device = "W"

if mode="alarm" then

    sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE userid= '"&LoginUserid&"' and evt_code="& eCode & " and sub_opt3='alarm'"
    rsget.Open sqlstr, dbget, 1
        cnt = rsget("cnt")
    rsget.close

    If cnt < 1 Then
        sqlStr = ""
        sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code , userid , device, sub_opt3)" & vbCrlf
        sqlstr = sqlstr & " VALUES ("& eCode &", '"& LoginUserid &"', '" & device & "','alarm')"
        dbget.execute sqlstr

        oJson("response") = "ok"
        oJson("message") = "알림 받기가 신청되었습니다."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    Else
        oJson("response") = "retry"
        oJson("message") = "이미 알림 받기를 신청하셨습니다."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    End If
elseif mode="delalarm" then
        sqlStr = ""
        sqlstr = "Delete from [db_event].[dbo].[tbl_event_subscript]" & vbCrlf
		sqlstr = sqlstr & " where evt_code=" & Cstr(eCode) & vbCrlf
		sqlstr = sqlstr & " and userid='" & LoginUserid & "'" & vbCrlf
        sqlstr = sqlstr & " and sub_opt3='alarm'"
        dbget.execute sqlstr

        oJson("response") = "ok"
        oJson("message") = "알림 신청이 취소되었습니다."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->