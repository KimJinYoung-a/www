<%@codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.AddHeader "Access-Control-Allow-Origin","*"
Response.AddHeader "Access-Control-Allow-Methods","POST"
Response.AddHeader "Access-Control-Allow-Headers","X-Requested-With"
Response.CharSet = "UTF-8"
Response.ContentType = "application/json"
%>
<%
'####################################################
' Description : 통합자동알림
' History : 2022.12.13 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp"-->
<%
' 첫번째 notiType : EVENT(이벤트) , EXHIBITION(기획전)
' 두번째 sendType : KAKAO(카카오알림톡) , PUSH(푸시) / 지정이 없는경우 자동 www/m : 알림톡 , a : 푸시
' 세번째 linkCode : 이벤트나 기획전의 실제 idx 번호값

dim refer, oJson, i, mode, refip, notiType, sendType, linkCode, LoginUserid, sqlstr, notiCnt, device
dim smsok, pushYN
refer 		= request.ServerVariables("HTTP_REFERER") '// 레퍼러
refip = request.ServerVariables("REMOTE_ADDR")
Set oJson = jsObject()
mode = requestcheckvar(trim(request("mode")),32)
notiType = requestcheckvar(trim(request("eventType")),32)
sendType = requestcheckvar(trim(request("alarmType")),16)
linkCode = requestcheckvar(trim(request("linkIdx")),10)

smsok="N"
pushYN="N"
notiCnt=0
device = "W"

' 발송구분이 지정이 없는경우 www/m : 알림톡 , a : 푸시
if sendType="" or isnull(sendType) then sendType="KAKAO"

IF application("Svr_Info") = "Dev" THEN
ElseIf application("Svr_Info")="staging" Then
else
    If InStr(refer, "10x10.co.kr") < 1 Then
        oJson("response") = "998"
        oJson("message") = "잘못된 경로로 접속 하셨습니다."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    End If
End If

notiType = ucase(notiType)
sendType = ucase(sendType)
linkCode = ucase(linkCode)

if not(notiType="EVENT" or notiType="EXHIBITION") Then
    oJson("response") = "001"
    oJson("message") = "구분값이 없거나 잘못되었습니다."
    oJson.flush
    Set oJson = Nothing
    dbget.close() : Response.End
end if
if not(sendType="KAKAO" or sendType="PUSH") Then
    oJson("response") = "002"
    oJson("message") = "발송구분이 없거나 잘못되었습니다."
    oJson.flush
    Set oJson = Nothing
    dbget.close() : Response.End
end if
if sendType="KAKAO" then sendType="KAKAOALRIM"
if linkCode="" or isnull(linkCode) Then
    oJson("response") = "003"
    oJson("failmessagedesc") = "관련코드값이 없거나 잘못되었습니다."
    oJson.flush
    Set oJson = Nothing
    dbget.close() : Response.End
end if

LoginUserid		= getencLoginUserid()
if Not(IsUserLoginOK) Then
    oJson("response") = "990"
    oJson("message") = "로그인 후 참여하실 수 있습니다."
    oJson.flush
    Set oJson = Nothing
    dbget.close() : Response.End
end if

' 통합자동알림(수신여부N 일경우 신청안됨)
if mode="alarm" then
    if sendType="KAKAOALRIM" then
        smsok="N"
        sqlstr = "SELECT isnull(smsok,'N') as smsok FROM db_user.dbo.tbl_user_n with (nolock) where userid= '" & LoginUserid & "'"

        'response.write sqlstr & "<br>"
        rsget.CursorLocation = adUseClient
        rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
            smsok = rsget("smsok")
        rsget.close

        if smsok="Y" then
            notiCnt=0
            sqlstr = "SELECT COUNT(nIdx) as cnt"
            sqlstr = sqlstr & " FROM db_contents.dbo.tbl_IntegrateNotification as n with (nolock)"
            sqlstr = sqlstr & " WHERE isusing='Y'"
            sqlstr = sqlstr & " and userid= '"& LoginUserid &"'"
            sqlstr = sqlstr & " and notiType='"& notiType & "'"
            sqlstr = sqlstr & " and sendType='"& sendType & "'"
            sqlstr = sqlstr & " and linkCode="& linkCode & ""

            'response.write sqlstr & "<br>"
            rsget.CursorLocation = adUseClient
            rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
                notiCnt = rsget("cnt")
            rsget.close

            If notiCnt < 1 Then
                sqlStr = "INSERT INTO db_contents.dbo.tbl_IntegrateNotification (" & vbCrlf
                sqlstr = sqlstr & " notiType, linkCode, sendType, userId, device, regDate, lastUpdate, replaceItemId, replaceMileage, isusing)" & vbCrlf
                sqlstr = sqlstr & " VALUES ('"& notiType &"', "& linkCode &", '"& sendType &"', '"& LoginUserid &"', '" & device & "'"
                sqlstr = sqlstr & " , getdate(), getdate(), NULL, NULL, 'Y')"

                'response.write sqlstr & "<br>"
                dbget.execute sqlstr

                oJson("response") = "007"
                oJson("message") = "알림이 신청되었어요!!@n#카카오 알림톡으로 알려드릴게요."
                oJson.flush
                Set oJson = Nothing
                dbget.close() : Response.End
            Else
                oJson("response") = "004"
                if sendType="KAKAOALRIM" then
                    oJson("message") = "이미 알림 신청이 완료되었어요!!@n#카카오 알림톡으로 알려드릴께요."
                else
                    oJson("message") = "이미 알림 신청이 완료되었어요!!@n#APP PUSH로 알려드릴께요."
                end if
                oJson.flush
                Set oJson = Nothing
                dbget.close() : Response.End
            End If
        else
            oJson("response") = "006"
            oJson("message") = "알림을 받으려면!@n#마케팅 수신 동의가 필요해요!"
            oJson.flush
            Set oJson = Nothing
            dbget.close() : Response.End
        end if
    else
        ' 이부분 단말기아이디 받아서 해당 디바이스만 체크하는걸로 수정필요함.
        pushYN="N"
        sqlstr = "SELECT isnull(pushyn,'N') as pushyn FROM db_contents.dbo.tbl_app_regInfo as r with (nolock)"
        sqlstr = sqlstr & " where userid= '" & LoginUserid & "'"
        sqlstr = sqlstr & " and isusing='Y'"
        sqlstr = sqlstr & " and ((R.appkey=6 and R.appVer>='36') or (R.appkey=5 and R.appVer>='1'))"

        'response.write sqlstr & "<br>"
        rsget.CursorLocation = adUseClient
        rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
            pushYN = rsget("pushyn")
        rsget.close

        if pushYN="Y" then
            notiCnt=0
            sqlstr = "SELECT COUNT(nIdx) as cnt"
            sqlstr = sqlstr & " FROM db_contents.dbo.tbl_IntegrateNotification as n with (nolock)"
            sqlstr = sqlstr & " WHERE isusing='Y'"
            sqlstr = sqlstr & " and userid= '"& LoginUserid &"'"
            sqlstr = sqlstr & " and notiType='"& notiType & "'"
            sqlstr = sqlstr & " and sendType='"& sendType & "'"
            sqlstr = sqlstr & " and linkCode="& linkCode & ""

            'response.write sqlstr & "<br>"
            rsget.CursorLocation = adUseClient
            rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
                notiCnt = rsget("cnt")
            rsget.close

            If notiCnt < 1 Then
                sqlStr = "INSERT INTO db_contents.dbo.tbl_IntegrateNotification (" & vbCrlf
                sqlstr = sqlstr & " notiType, linkCode, sendType, userId, device, regDate, lastUpdate, replaceItemId, replaceMileage, isusing)" & vbCrlf
                sqlstr = sqlstr & " VALUES ('"& notiType &"', "& linkCode &", '"& sendType &"', '"& LoginUserid &"', '" & device & "'"
                sqlstr = sqlstr & " , getdate(), getdate(), NULL, NULL, 'Y')"

                'response.write sqlstr & "<br>"
                dbget.execute sqlstr

                oJson("response") = "007"
                oJson("message") = "알림이 신청되었어요!!@n#APP PUSH로 알려드릴게요."
                oJson.flush
                Set oJson = Nothing
                dbget.close() : Response.End
            Else
                oJson("response") = "004"
                if sendType="KAKAOALRIM" then
                    oJson("message") = "이미 알림 신청이 완료되었어요!!@n#카카오 알림톡으로 알려드릴께요."
                else
                    oJson("message") = "이미 알림 신청이 완료되었어요!!@n#APP PUSH로 알려드릴께요."
                end if
                oJson.flush
                Set oJson = Nothing
                dbget.close() : Response.End
            End If
        else
            oJson("response") = "006"
            oJson("message") = "알림을 받으려면!@n#마케팅 수신 동의가 필요해요!"
            oJson.flush
            Set oJson = Nothing
            dbget.close() : Response.End
        end if
    end if

' 통합자동알림(수신여부Y로 변경)
elseif mode="alarmWithReqYN" then
    if sendType="KAKAOALRIM" then
        sqlStr = "UPDATE [db_user].[dbo].[tbl_user_n] SET email_10x10='Y', email_way2way='Y', smsok='Y', smsok_fingers='Y' WHERE userid='"& LoginUserid &"'" & vbCrlf

        'response.write sqlstr & "<br>"
        dbget.execute sqlstr

        notiCnt=0
        sqlstr = "SELECT COUNT(nIdx) as cnt"
        sqlstr = sqlstr & " FROM db_contents.dbo.tbl_IntegrateNotification as n with (nolock)"
        sqlstr = sqlstr & " WHERE isusing='Y'"
        sqlstr = sqlstr & " and userid= '"& LoginUserid &"'"
        sqlstr = sqlstr & " and notiType='"& notiType & "'"
        sqlstr = sqlstr & " and sendType='"& sendType & "'"
        sqlstr = sqlstr & " and linkCode="& linkCode & ""

        'response.write sqlstr & "<br>"
        rsget.CursorLocation = adUseClient
        rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
            notiCnt = rsget("cnt")
        rsget.close

        If notiCnt < 1 Then
            sqlStr = "INSERT INTO db_contents.dbo.tbl_IntegrateNotification (" & vbCrlf
            sqlstr = sqlstr & " notiType, linkCode, sendType, userId, device, regDate, lastUpdate, replaceItemId, replaceMileage, isusing)" & vbCrlf
            sqlstr = sqlstr & " VALUES ('"& notiType &"', "& linkCode &", '"& sendType &"', '"& LoginUserid &"', '" & device & "'"
            sqlstr = sqlstr & " , getdate(), getdate(), NULL, NULL, 'Y')"

            'response.write sqlstr & "<br>"
            dbget.execute sqlstr

            oJson("response") = "007"
            oJson("message") = "알림이 신청되었어요!!@n#카카오 알림톡으로 알려드릴게요."
            oJson.flush
            Set oJson = Nothing
            dbget.close() : Response.End
        Else
            sqlStr = "update db_contents.dbo.tbl_IntegrateNotification" & vbCrlf
            sqlstr = sqlstr & " set lastUpdate=getdate()" & vbCrlf
            sqlstr = sqlstr & " WHERE isusing='Y'"
            sqlstr = sqlstr & " and userid= '"& LoginUserid &"'"
            sqlstr = sqlstr & " and notiType='"& notiType & "'"
            sqlstr = sqlstr & " and sendType='"& sendType & "'"
            sqlstr = sqlstr & " and linkCode="& linkCode & ""

            'response.write sqlstr & "<br>"
            dbget.execute sqlstr

            oJson("response") = "007"
            oJson("message") = "알림이 신청되었어요!!@n#카카오 알림톡으로 알려드릴게요."
            oJson.flush
            Set oJson = Nothing
            dbget.close() : Response.End
        End If
    else
        ' 이부분 단말기아이디 받아서 해당 디바이스만 엎어치는걸로 수정필요함.
        sqlStr = "UPDATE db_contents.dbo.tbl_app_regInfo SET pushyn='Y' WHERE userid='"& LoginUserid &"' and isusing='Y' and ((appkey=6 and appVer>='36') or (appkey=5 and appVer>='1')) and pushyn<>'Y'"

        'response.write sqlstr & "<br>"
        dbget.execute sqlstr

        notiCnt=0
        sqlstr = "SELECT COUNT(nIdx) as cnt"
        sqlstr = sqlstr & " FROM db_contents.dbo.tbl_IntegrateNotification as n with (nolock)"
        sqlstr = sqlstr & " WHERE isusing='Y'"
        sqlstr = sqlstr & " and userid= '"& LoginUserid &"'"
        sqlstr = sqlstr & " and notiType='"& notiType & "'"
        sqlstr = sqlstr & " and sendType='"& sendType & "'"
        sqlstr = sqlstr & " and linkCode="& linkCode & ""

        'response.write sqlstr & "<br>"
        rsget.CursorLocation = adUseClient
        rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
            notiCnt = rsget("cnt")
        rsget.close

        If notiCnt < 1 Then
            sqlStr = "INSERT INTO db_contents.dbo.tbl_IntegrateNotification (" & vbCrlf
            sqlstr = sqlstr & " notiType, linkCode, sendType, userId, device, regDate, lastUpdate, replaceItemId, replaceMileage, isusing)" & vbCrlf
            sqlstr = sqlstr & " VALUES ('"& notiType &"', "& linkCode &", '"& sendType &"', '"& LoginUserid &"', '" & device & "'"
            sqlstr = sqlstr & " , getdate(), getdate(), NULL, NULL, 'Y')"

            'response.write sqlstr & "<br>"
            dbget.execute sqlstr

            oJson("response") = "007"
            oJson("message") = "알림이 신청되었어요!!@n#APP PUSH로 알려드릴게요."
            oJson.flush
            Set oJson = Nothing
            dbget.close() : Response.End
        Else
            sqlStr = "update db_contents.dbo.tbl_IntegrateNotification" & vbCrlf
            sqlstr = sqlstr & " set lastUpdate=getdate()" & vbCrlf
            sqlstr = sqlstr & " WHERE isusing='Y'"
            sqlstr = sqlstr & " and userid= '"& LoginUserid &"'"
            sqlstr = sqlstr & " and notiType='"& notiType & "'"
            sqlstr = sqlstr & " and sendType='"& sendType & "'"
            sqlstr = sqlstr & " and linkCode="& linkCode & ""

            'response.write sqlstr & "<br>"
            dbget.execute sqlstr

            oJson("response") = "007"
            oJson("message") = "알림이 신청되었어요!!@n#카카오 알림톡으로 알려드릴게요."
            oJson.flush
            Set oJson = Nothing
            dbget.close() : Response.End
        End If
    end if

' 통합자동알림삭제
elseif mode="alarmDel" then
    notiCnt=0
    sqlstr = "SELECT COUNT(nIdx) as cnt"
    sqlstr = sqlstr & " FROM db_contents.dbo.tbl_IntegrateNotification as n with (nolock)"
    sqlstr = sqlstr & " WHERE isusing='Y'"
    sqlstr = sqlstr & " and userid= '"& LoginUserid &"'"
    sqlstr = sqlstr & " and notiType='"& notiType & "'"
    sqlstr = sqlstr & " and sendType='"& sendType & "'"
    sqlstr = sqlstr & " and linkCode="& linkCode & ""

    'response.write sqlstr & "<br>"
    rsget.CursorLocation = adUseClient
    rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
        notiCnt = rsget("cnt")
    rsget.close

    If notiCnt > 0 Then
        sqlStr = "UPDATE db_contents.dbo.tbl_IntegrateNotification SET isusing='N' WHERE" & vbcrlf
        sqlStr = sqlStr & " userid='"& LoginUserid &"' and notiType='"& notiType &"' and linkCode="& linkCode &" and sendType='"& sendType &"'" & vbCrlf

        'response.write sqlstr & "<br>"
        dbget.execute sqlstr
    
        oJson("response") = "011"
        oJson("message") = "알림이 해제되었어요.!@n#해당 이벤트의 알림을 다시 받고 싶다면!n@#알림 받기를 선택해주세요 :)"
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    Else
        oJson("response") = "010"
        oJson("message") = "아직 알림을 신청하지 않으셨어요!"
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    End If
else
    oJson("response") = "999"
    oJson("message") = "잘못된 접속 입니다."
    oJson.flush
    Set oJson = Nothing
end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->