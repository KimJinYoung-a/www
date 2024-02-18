<%@ codepage="65001" language="VBScript" %>
<% option Explicit 
'#######################################################
'	History	: 2021.06.15 이전도 생성
'	Description : Biz회원 ajax 휴대폰 인증 전송
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<%
    Response.AddHeader "Cache-Control","no-cache"
    Response.AddHeader "Expires","0"
    Response.AddHeader "Pragma","no-cache"
    Response.ContentType = "application/json"
    Response.charset = "utf-8"

    Dim oJson, userId, cell, cell1, cell2, cell3
    Dim onError, sqlStr, sRndKey

    userId = GetLoginUserID
    cell1 = requestCheckVar(Request("cell1"), 3)
    cell2 = requestCheckVar(Request("cell2"), 4)
    cell3 = requestCheckVar(Request("cell3"), 4)
    cell = cell1 & "-" & cell2 & "-" & cell3

    onError = False

    Set oJson = jsObject()

    '// 휴대폰 번호 검증
    If Not validCell(cell) Then
        onError = True
        oJson("response") = "9001"
        oJson("faildesc") = "잘못된 휴대폰 번호입니다."
    End If

    '// 2. 회원 정보 검증
    If Not onError Then
        sqlStr = " SELECT regdate FROM db_user.dbo.tbl_user_c "
        sqlStr = sqlStr + " WHERE userid='" + userId + "' AND isusing = 'Y'"
        rsget.Open sqlStr,dbget,1
        
        If rsget.EOF Then
            onError = True
            oJson("response") = "9002"
            oJson("faildesc") = "회원 정보가 존재하지 않습니다."
        Else
            '// 3. 회원 유효기간
            ' regDate = rsget("regdate")
            ' If DateDiff("h", regDate, now()) > 12 Then
            '     onError = True
            '     oJson("response") = "9003"
            '     oJson("faildesc") = "유효기간이 종료 되었습니다."
            ' End If
        End If
        rsget.close
    End If

    '// 4. 연속발송 제한 검증
    If Not onError Then
        sqlStr = "SELECT COUNT(*) FROM db_log.dbo.tbl_userConfirm "
        sqlStr = sqlStr + " WHERE userid='" + userId + "' AND DATEDIFF(hh, regdate, GETDATE()) < 6"
        rsget.Open sqlStr,dbget,1

        If rsget(0) > 5 Then
            onError = True
            oJson("response") = "9004"
            oJson("faildesc") = "단기간에 많은 인증요청으로 더 이상 인증 할 수 없습니다.\n잠시 후 다시 시도 해 주세요."
        End If
        rsget.close
    End If

    If Not onError Then
        sqlStr = " SELECT TOP 1 smsCD FROM db_log.dbo.tbl_userConfirm "
        sqlStr = sqlStr + " WHERE userid='" + userId + "' AND confDiv='S' "
        sqlStr = sqlStr + " AND isConfirm='N' AND DATEDIFF(s,regdate,GETDATE())<120 "
        sqlStr = sqlStr + " ORDER BY idx DESC "
        rsget.Open sqlStr,dbget,1

        If Not(rsget.EOF or rsget.BOF) Then
            sRndKey = rsget("smsCD")
        End If
        rsget.close

        '// 유효 인증 대기값이 없을 때만 전송
        '// 2분 이내에는 재발송 없음(SPAM 등에 걸리지 않는 이상 거의 대부분 늦게라도 전송됨)
        If sRndKey = "" Then
            randomize(time())
		    sRndKey=Num2Str(left(round(rnd*(1000000)),6),6,"0","R")

            '// 인증 로그에 저장
            sqlStr = "INSERT INTO db_log.dbo.tbl_userConfirm (userid, confDiv, usercell, smsCD, pFlag, evtFlag) VALUES ("
            sqlStr = sqlStr + " '" & userId & "'"
            sqlStr = sqlStr + " ,'S'"
            sqlStr = sqlStr + " ,'" & cell & "'"
            sqlStr = sqlStr + " ,'" & sRndKey & "'"
            sqlStr = sqlStr + " ,'T','N'"
            sqlStr = sqlStr + " )"
            dbget.execute(sqlStr)

            '// 카카오 알림톡으로 전송
            Call SendKakaoMsg_LINK(cell,"1644-6030","S0001","[텐바이텐] 고객님의 인증번호는 [" & sRndKey & "]입니다.","SMS","","인증번호 [" & sRndKey & "]"& vbCrLf & "입력창에 넣으시면 진행이 완료됩니다. -텐바이텐","")

        End If
    End If

    If Not onError Then
        oJson("response") = "0000"
        oJson("cell") = cell
    End If


    oJson.flush 'Json 출력(JSON)
    Set oJson = Nothing


    '// 휴대폰번호 검증
    Function validCell(cell)
        Dim isValidC
        Dim regEx

        isValidC = True
        set regEx = New RegExp

        regEx.IgnoreCase = False

        regEx.Pattern = "^[0-9]{3}[-]+[0-9]{4}[-]+[0-9]{4}$"
        isValidC = regEx.Test(cell)

        validCell= isValidC
    End Function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->