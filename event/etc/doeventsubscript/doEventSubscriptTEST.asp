<%@codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet = "UTF-8"
'###########################################################
' Description : 서촌도감01 - 오프투얼론
' History : 2021.02.10 정태훈 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp"-->
<!-- #include virtual="/event/timesale/timesaleCls.asp" -->
<%
	Response.ContentType = "application/json"
	response.charset = "utf-8"
	dim currentDate, refer, refip, eventStartDate, eventEndDate
	Dim eCode, LoginUserid, mode, sqlStr, device, cnt, chasu, oJson, itmeID
	dim vIsApp, mktTest, Cidx, txtcomm, booknum, txtcommURL, returnValue

    IF application("Svr_Info") = "Dev" THEN
        eCode = "104316"
    Else
        eCode = "109208"
    End If
    LoginUserid		= getencLoginUserid()
    mode = request("mode")
    eCode = request("evt_code")
    itmeID = request("itemid")
    Set oJson = jsObject()

    if mode="add" then
        '알림 응모 여부 체크 
        sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE userid= '"&LoginUserid&"' and evt_code="& eCode &" and sub_opt1 = '0' and sub_opt3="& itmeID
        rsget.Open sqlstr, dbget, 1
            cnt = rsget("cnt")
        rsget.close
        If cnt < 1 Then
            sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code , userid , device, sub_opt1, sub_opt3)" & vbCrlf
            sqlstr = sqlstr & " VALUES ("& eCode &", '"& LoginUserid &"', 'W', '0','" & itmeID &"')"
            dbget.execute sqlstr
        end if
        oJson("response") = "ok"
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->