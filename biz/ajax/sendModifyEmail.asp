<%@ codepage="65001" language="VBScript" %>
<% option Explicit 
'#######################################################
'	History	: 2021.06.15 이전도 생성
'	Description : Biz회원 ajax 이메일 인증처리
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
    Response.ContentType = "application/json"
    Response.charset = "utf-8"

    Dim oJson, email, preUserMail, userMailSite, sqlStr, onError
    Dim userId, regDate, confirmIdx, confirmDate, sRUrl, dExp

    userId = GetLoginUserID
    preUserMail = requestCheckVar(request("preUserMail"), 64)
    userMailSite = requestCheckVar(request("userMailSite"), 32)
    email = preUserMail & "@" & userMailSite

    onError = False

    Set oJson = jsObject()

    '/*
    ' * 검증 순서
    ' * 1. 이메일 검증 - 9001
    ' * 2. 회원 정보 - 9002
    ' * 3. 회원 유효기간 - 9003
    ' * 4. 연속발송 제한 - 9004
    ' */

    '// 1. 이메일 검증
    If Not validEmail(email) Then
        onError = True
        oJson("response") = "9001"
        oJson("faildesc") = "잘못된 이메일 형식입니다."
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
    
    '// 이메일 발송
    If Not onError Then
        sqlStr = " SELECT TOP 1 idx, regdate FROM db_log.dbo.tbl_userConfirm "
        sqlStr = sqlStr + " WHERE userid='" + userId + "' AND confDiv='E' "
        sqlStr = sqlStr + " AND isConfirm='N' AND DATEDIFF(hh,regdate,GETDATE())<12 "
        sqlStr = sqlStr + " ORDER BY idx DESC "
        rsget.Open sqlStr,dbget,1

        If Not(rsget.EOF or rsget.BOF) Then
            confirmIdx = rsget("idx")
            confirmDate = rsget("regdate")
        End If
        rsget.close

        '// 이미 발송기록이 있다면 재발송
        If confirmIdx <> "" Then
            '// 인증확인 URL
            sRUrl = wwwUrl & "/my10x10/userInfo/doEmailConfirm.asp?strkey=" & server.URLEncode(tenEnc(userId & "||" & confirmIdx))
            '// 인증 종료일
            dExp = cStr(dateadd("h",12,confirmDate))
            '// 인증 메일 발송
            Call SendMailReConfirm(email, userId, dExp, sRUrl)

        '// 없다면 신규 발송
        Else
            On Error Resume Next
            
            dbget.beginTrans

            sqlStr = "INSERT INTO db_log.dbo.tbl_userConfirm (userid, confDiv, usermail, pFlag, evtFlag) VALUES ("
            sqlStr = sqlStr + " '" & userId & "'"
            sqlStr = sqlStr + " ,'E'"
            sqlStr = sqlStr + " ,'" & email & "'"
            sqlStr = sqlStr + " ,'T','N'"
            sqlStr = sqlStr + " )"
            dbget.execute(sqlStr)

            sqlStr = "SELECT IDENT_CURRENT('db_log.dbo.tbl_userConfirm') as maxIdx "
            rsget.Open sqlStr,dbget,1
                confirmIdx = rsget("maxIdx")
            rsget.close

            If Err.Number = 0 Then
                dbget.CommitTrans '// 처리 완료

            Else
                dbget.RollBackTrans '//오류가 발생했으므로 롤백
                onError = True
                oJson("response") = getErrMsg("9999",sFDesc)
                oJson("faildesc") = "처리중 오류가 발생했습니다."
                dbget.close():
            End If

            on error Goto 0

            '// 인증확인 URL
            sRUrl = wwwUrl & "/my10x10/userInfo/doEmailConfirm.asp?strkey=" & server.URLEncode(tenEnc(userId & "||" & confirmIdx))
            '// 인증 종료일
            dExp = cStr(dateadd("h",12,now()))
            '// 인증 메일 발송
            Call SendMailReConfirm(email, userId, dExp, sRUrl)
        End If

    End If

    If Not onError Then
        oJson("response") = "0000"
        oJson("email") = email
    End If

	oJson.flush 'Json 출력(JSON)
    Set oJson = Nothing

    '// 이메일 검증
    Function validEmail(email)
        Dim isValidE
        Dim regEx

        isValidE = True
        set regEx = New RegExp

        regEx.IgnoreCase = False

        regEx.Pattern = "^[a-zA-Z\-\_][\w\.-]*[a-zA-Z0-9\-\_]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
        isValidE = regEx.Test(email)

        validEmail= isValidE
    End Function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->