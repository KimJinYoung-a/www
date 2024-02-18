<%@ codepage="65001" language="VBScript" %>
<%
    option Explicit
    response.Charset="UTF-8"
    Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"
    Response.AddHeader "Cache-Control","no-cache"
    Response.AddHeader "Expires","0"
    Response.AddHeader "Pragma","no-cache"

    '#######################################################
    '	Description : Biz 회원가입
    '	History	:  2021.06.08 이전도 : 신규 Biz회원가입 로직 생성
    '#######################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/inc/incNaverOpenDate.asp" -->
<!-- #include virtual="/lib/inc/incDaumOpenDate.asp" -->
<!-- #include virtual="/lib/util/myalarmlib.asp" -->
<!-- #include virtual="/lib/util/base64_u.asp" -->
<%
    '// 사업자 번호 검증 Function
    Function checkSocnum(socnum)
        Dim keyArr, key, number, socnoChk, i, j
        Dim numberArr(10)
        keyArr = Array(1, 3, 7, 1, 3, 7, 1, 3, 5)
        number = Replace(socnum, "-", "")
        socnoChk = 0

        If( Len(number) <> 10 ) Then
            checkSocnum = "N"
            Exit Function
        End If

        For i = 1 To Len(number)
            numberArr(i-1) = CInt(Mid(number, i, 1))
        Next
        For j = 0 To UBound(keyArr)
            socnoChk = socnoChk + ( keyArr(j) * numberArr(j) )
        Next
        socnoChk = socnoChk + Fix((keyArr(8) * numberArr(8))/10)

        checkSocnum = ChkIIF(numberArr(9) = ((10 - (socnoChk mod 10)) mod 10), "Y", "N")
    End Function

    '외부 URL 체크
    Dim backurl
    backurl = request.ServerVariables("HTTP_REFERER")
    if InStr(LCase(backurl),"10x10.co.kr") < 1 then
        if (Len(backurl)>0) then
            response.redirect backurl
            response.end
        else
            response.write "<script>alert('유효한 접근이 아닙니다.');history.back();</script>"
            response.end
        end if
    end if

    Dim userid, pass, email, name, cell1, cell2, cell3, soccell, crtfyNo, birthday
    Dim socno, socname, refip, email_10x10, smsok
    Dim Enc_userpass, Enc_userpass64

    userid      = requestCheckVar(request.form("txuserid"),32)
    pass        = requestCheckVar(request.form("txpass1"),32)
    name		= requestCheckVar(html2db(trim(request.form("txName"))),32)
    email       = requestCheckVar(html2db(request.form("usermail")),128)
    email       = LeftB(email,128)

    email_10x10     = requestCheckVar(request.form("email_10x10"),9)
    smsok           = requestCheckVar(request.form("smsok"),9)

    cell1		= requestCheckVar(html2db(request.form("txCell1")),4)
    cell2		= requestCheckVar(html2db(request.form("txCell2")),4)
    cell3		= requestCheckVar(html2db(request.form("txCell3")),4)
    soccell      = cell1 + "-" + cell2 + "-" + cell3

    crtfyNo 	= requestCheckVar(Request.form("crtfyNo"),6)		' 휴대폰에 전송된 인증키

    socno = requestCheckVar(request.form("socno"),12)
	If checkSocnum(socno) <> "Y" Then
		Response.Write "<script>alert('잘못된 사업자번호입니다.');history.back();</script>"
		Response.End
	End If
	socname = requestCheckVar(request.form("socname"),32)

    birthday = "1900-01-01"

    refip = Left(request.ServerVariables("REMOTE_ADDR"),32)


    dim chk

    chk = IsSpecialCharExist(db2html(userid))
    if (chk = true) then
        response.write "<script>alert('아이디에는 특수문자를 사용할수 없습니다.(알파벳과 숫자 사용가능)')</script>"
        response.write "<script>history.back()</script>"
        response.end
    end if

    chk = IsUseridExist(userid)
    if (chk = true) then
        response.write "<script>alert('이미 사용중이거나, 사용 할 수 없는 아이디입니다.')</script>"
        response.write "<script>history.back()</script>"
        response.end
    end if

    chk = chkSimplePwdComplex(userid,pass)
    if (chk<>"") then
        response.write "<script>alert('" & chk & "')</script>"
        response.write "<script>history.back()</script>"
        response.end
    end if

'    chk = IsUserMailExist(db2html(email))
'    if (chk = true) then
'        response.write "<script>alert('이미 사용중인 메일주소입니다.')</script>"
'        response.write "<script>history.back()</script>"
'        response.end
'    end if

    Enc_userpass = MD5(CStr(pass))
    Enc_userpass64 = SHA256(MD5(CStr(pass)))

    '========================== 휴대폰인증 인증번호 다시 검사 ====================================================
    dim sqlStr, errcode, vSmsCD
    '// 인증기록 검사
    sqlStr = "Select top 1 usercell From db_log.dbo.tbl_userConfirm Where userid='" & userid & "' and smsCD = '" & crtfyNo & "' and confDiv='S' and isConfirm='Y' order by idx desc "
    rsget.Open sqlStr,dbget,1
    if rsget.EOF or rsget.BOF then
        rsget.close
        response.write "<script>alert('인증번호가 맞지 않습니다.\n정보입력을 다시 해주세요.'); top.location.href='/member/join.asp';</script>"
        dbget.close()
        response.end
    else
        '// 인증받은 휴대폰번호인지 확인(2016.10.24; 허진원)
        if rsget("usercell")<> CStr(cell1)&"-"&CStr(cell2)&"-"&CStr(cell3) then
            rsget.close
            response.write "<script>alert('입력하신 휴대폰번호가 맞지 않습니다.\n정보입력을 다시 해주세요.'); top.location.href='/member/join.asp';</script>"
            dbget.close()
            response.end
        end if
        rsget.close
    end if

    On Error Resume Next
    dbget.beginTrans

    If Err.Number = 0 Then
        errcode = "001"
    end if

    sqlStr = "INSERT INTO [db_user].[dbo].[tbl_user_c] (userid, socno, socname, soccell, birthday, socmail, prcname, regdate, isb2b, userdiv, socname_kor, coname) " + vbCrlf
	sqlStr = sqlStr + "VALUES ('" + userid + "', '" + socno + "', '" + socname + "', '" + soccell + "', '" + CStr(birthday) + "', '" + email + "', '" + name + "', GETDATE(), 'Y', '09', '" + socname + "', '" + socname + "')"
    dbget.execute(sqlStr)

	If Err.Number = 0 Then
        errcode = "002"
	end if

	sqlStr = "INSERT INTO [db_user].[dbo].[tbl_logindata] (userid, userpass, userdiv, userlevel, lastlogin, counter, lastrefip, Enc_userpass, Enc_userpass64) " + vbCrlf
	sqlStr = sqlStr + " values('" + userid + "', '', '09', 9, getdate(), 0,'" + refip + "','','" + Enc_userpass64 + "')"
	dbget.execute(sqlStr)

	If Err.Number = 0 Then
        errcode = "003"
	End if

	sqlStr = "INSERT INTO [db_user].[dbo].[tbl_user_c_auth] (userid, socno, regdt, isconfirm, adminid) " + vbCrlf
	sqlStr = sqlStr + " values('" + userid + "', '" + socno + "',GETDATE(), 'S', 'system')"
	dbget.execute(sqlStr)

	If Err.Number = 0 Then
        errcode = "004"
	End if

	sqlStr = "INSERT INTO [db_user].[dbo].[tbl_user_c_addinfo] "
    sqlStr = sqlStr & " (userid, zipcode, useraddr, emailok, smsok, emaildate, smsokdate, isEmailChk, isMobileChk) "
    sqlStr = sqlStr & " VALUES ('" & userid & "', '', '', '" & smsok & "', '" & email_10x10 & "', GETDATE(), GETDATE(), 'N', 'N') "
    dbget.execute(sqlStr)

	If Err.Number = 0 Then
        errcode = "005"
	End if

    '# 로그인 회원 로그인 회원구분 변경
    If IsUserLoginOK Then
        response.Cookies("etc").domain = "10x10.co.kr"
        response.Cookies("etc")("ConfirmUser") = "Y"
    End if

    If Err.Number = 0 Then
        '// 처리 완료
        dbget.CommitTrans

        '# 세션에 아이디 저장
        Session("sUserid") = userid

        '#가입축하 메일 발송
        call SendMailNewUser(email,userid)

        Response.Redirect(wwwUrl & "/member/join_welcome.asp?biz=Y")

    Else
        '//오류가 발생했으므로 롤백
        dbget.RollBackTrans
        response.write "<script>alert('데이타를 저장하는 도중에 에러가 발생하였습니다.\r\n지속적으로 문제가 발생시에는 고객센타에 연락주시기 바랍니다.(에러코드 : " + CStr(errcode) + ")')</script>"
        response.write "<script>history.back()</script>"
        response.end
    End If
    on error Goto 0


    function IsUseridExist(userid)
        dim sqlStr

        sqlStr = " select top 1 userid from [db_user].[dbo].tbl_logindata where userid = '" + userid + "' "
        rsget.Open sqlStr,dbget,1
        IsUseridExist = (not rsget.EOF)
        rsget.close

        sqlStr = " select userid from [db_user].[dbo].tbl_deluser where userid = '" + userid + "' "
        rsget.Open sqlStr, dbget, 1
        IsUseridExist = IsUseridExist or (Not rsget.Eof)
        rsget.Close
    end function

    function IsUserMailExist(usermail)
        dim strSql, bIsExist

        '// 회원정보에서 인증기록이 있는 정보만 확인(userStat N:인증전, Y:인증완료, Null:기존고객)
        strSql = "select top 1 userid from [db_user].[dbo].tbl_user_n " &_
                " where usermail='" & usermail & "' " &_
                " and (userStat='Y' or (userStat='N' and datediff(hh,regdate,getdate())<12)) "
        rsget.Open strSql, dbget, 1

        '동일한 이메일 없음
        If rsget.EOF = True Then
            bIsExist = False
        '동일한 이메일 존재
        Else
            bIsExist = True
        End If
        rsget.Close
        IsUserMailExist = bIsExist
    end function

    function IsSpecialCharExist(s)
        dim buf, result, index

        index = 1
        do until index > len(s)
                buf = mid(s, index, cint(1))
                if (lcase(buf) >= "a" and lcase(buf) <= "z") then
                        result = false
                elseif (buf >= "0" and buf <= "9") then
                        result = false
                else
                        IsSpecialCharExist = true
                        exit function
                end if
                index = index + 1
        loop

        IsSpecialCharExist = false
    end function
%>