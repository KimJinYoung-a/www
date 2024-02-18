<%@ codepage="65001" language="VBScript" %>
<% option Explicit 
'#######################################################
'	History	: 2021.06.15 이전도 생성
'	Description : Biz회원 ajax 휴대폰 인증 처리
'#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<!-- #INCLUDE Virtual="/apps/kakaotalk/lib/kakaotalk_sendFunc.asp" -->
<%
    Response.AddHeader "Cache-Control","no-cache"
    Response.AddHeader "Expires","0"
    Response.AddHeader "Pragma","no-cache"
    Response.ContentType = "application/json"
    Response.charset = "utf-8"

    Dim oJson, key, userId, confirmIdx, confirmCell
    Dim sqlStr, onError

    userId = GetLoginUserID
    key = requestCheckVar(Request.form("key"),6)
    onError = False

    Set oJson = jsObject()

    '// 1. 인증번호 검사
    sqlStr = "SELECT TOP 1 idx, usercell FROM db_log.dbo.tbl_userConfirm"
    sqlStr = sqlStr + " WHERE userid='" + userId + "' AND smsCD='" + key + "' "
    sqlStr = sqlStr + " AND confDiv='S' AND isConfirm='N' AND DATEDIFF(s,regdate,GETDATE())<=120 "
    sqlStr = sqlStr + " ORDER BY idx DESC "
    rsget.Open sqlStr,dbget,1

    If Not(rsget.EOF or rsget.BOF) Then
        confirmIdx = rsget("idx")
        confirmCell = rsget("usercell")
    Else
        onError = True
        oJson("response") = "9001"
        oJson("faildesc") = "인증번호가 정확하지 않습니다."
    End If
	rsget.close

    '// 2. 회원상태 검사
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

    If Not onError Then
        On Error Resume Next
        dbget.beginTrans

        '// 인증기록 변경
        sqlStr = "UPDATE db_log.dbo.tbl_userConfirm SET isConfirm='Y', "
        sqlStr = sqlStr & "confDate=getdate() WHERE idx=" & confirmIdx
	    dbget.execute(sqlStr)

        '// 회원정보 변경
        sqlStr = "UPDATE db_user.dbo.tbl_user_c SET soccell = '" & confirmCell & "' WHERE userid='" & userId & "'"
		dbget.execute(sqlStr)
		sqlStr = "UPDATE db_user.dbo.tbl_user_c_addinfo SET isMobileChk = 'Y', isMobileChkdate = GETDATE() WHERE userid='" & userId & "'"
		dbget.execute(sqlStr)

        '카카오톡 휴대폰 변경 확인
	    Call fnKakaoChkModiClear(confirmCell)

        response.Cookies("etc").domain = "10x10.co.kr"
		response.Cookies("etc")("ConfirmUser") = "Y"


        If Err.Number = 0 Then
            '// 처리 완료
            dbget.CommitTrans

            '# 세션에 아이디 저장
            Session("sUserid") = userId

            '# 인증완료
            oJson("response") = "0000"
        Else
            '//오류가 발생했으므로 롤백
            dbget.RollBackTrans
            onError = True
            oJson("response") = "9004"
            oJson("faildesc") = "처리 중 에러가 발생했습니다."
        End If

        on error Goto 0
    End If


    oJson.flush 'Json 출력(JSON)
    Set oJson = Nothing


%>
<!-- #include virtual="/lib/db/dbclose.asp" -->