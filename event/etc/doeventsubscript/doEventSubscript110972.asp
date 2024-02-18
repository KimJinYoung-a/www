<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'####################################################
' Description : 귀여움 저장소 이벤트
' History : 2021.04.29 정태훈 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp"-->
<%
dim currentDate, refer, cnt
Dim eCode, LoginUserid, mode, sqlStr, device
dim oJson, mktTest, teaTimeNum, eventStartDate, eventEndDate
'object 초기화
Set oJson = jsObject()

IF application("Svr_Info") = "Dev" THEN
    eCode = "105352"
    mktTest = true
ElseIf application("Svr_Info")="staging" Then
    eCode = "110972"
    mktTest = true    
Else
    eCode = "110972"
    mktTest = false
End If

mode = request("mode")

if mktTest then
    currentDate = #05/03/2021 09:00:00#
else
    currentDate = date()
end if

eventStartDate = cdate("2021-05-03")		'이벤트 시작일
eventEndDate = cdate("2021-05-16")		'이벤트 종료일

LoginUserid = getencLoginUserid()
refer = request.ServerVariables("HTTP_REFERER")

device = "W"

if application("Svr_Info") <> "Dev" then 
    If InStr(refer, "10x10.co.kr") < 1 or eCode = "" Then
        oJson("response") = "err"
        oJson("message") = "잘못된 접속입니다."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    End If
end if

if mode = "add" Then

    if Not(IsUserLoginOK) Then
        oJson("response") = "err"
        oJson("message") = "로그인을 해주세요."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    end if

    sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE userid= '"&LoginUserid&"' and evt_code="& eCode
    rsget.Open sqlstr, dbget, 1
        cnt = rsget("cnt")
    rsget.close

    If cnt < 1 Then
        sqlStr = ""
        sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code , userid , device, sub_opt1)" & vbCrlf
        sqlstr = sqlstr & " VALUES ("& eCode &", '"& LoginUserid &"', '"&device&"', '" & left(currentDate,10) & "')"
        dbget.execute sqlstr

        oJson("response") = "ok"
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    Else
        oJson("response") = "retry"
        oJson("message") = "이미 신청하셨습니다."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    End If
end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->