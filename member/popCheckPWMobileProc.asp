<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<%
    Response.CacheControl = "no-cache"
    Response.AddHeader "Pragma","no-cache"
    Response.Expires = 0
    Response.Buffer = True

    ' rec_cert 데이터 변수 선언 ---------------------------------------------------------------
    Dim rec_cert         ' 결과수신DATA
	Dim certNum          ' 요청번호
    Dim date             ' 요청일시
	Dim CI               ' 연계정보(CI)
	Dim DI               ' 중복가입확인정보(DI)
    Dim phoneNo			 ' 휴대폰번호
	Dim phoneCorp		 ' 이동통신사
	Dim birthDay		 ' 생년월일
	Dim gender			 ' 성별
	Dim nation			 ' 내국인
	Dim name			 ' 성명
	Dim M_name			 ' 미성년자 성명
	Dim M_birthDay		 ' 미성년자 생년월일
	Dim M_Gender		 ' 미성년자 성별
	Dim M_nation		 ' 미성년자 내외국인
    Dim result           ' 결과값
    Dim certMet          ' 인증방법
    Dim ip               ' ip주소
	Dim plusInfo
    ' End - rec_cert 데이터 변수 선언 -------------------------------------------------------------

	'복호화 변수 선언
    Dim k_certNum
	Dim decStr_Split	' 복호화 데이터 배열
	Dim dec				' 복호화 변수
	Dim hash            ' 위변조 변수
	Dim hashStr
	Dim encPara			' rec_cert 1차 암호화데이터
	Dim encMsg			' 위변조 검증값
	Dim msgChk			' 위변조 검증 결과
	Dim iv				' 복호화 키값

	' Parameter 수신
	rec_cert  = request("rec_cert")
	k_certNum = request("certNum") 
    iv = k_certNum                 ' certNum값을 복호화키에 세팅

	On Error Resume Next

		'01.1차 복호화
		Set dec = Server.CreateObject("ICERTSecurity.SEED")
			If(Err.Number <> 0) Then
				Response.Write "Error 01 :: ("& Err.Number &") " & Err.Description & vbCrlf & "<br><br>"
			End IF

		    rec_cert = dec.IcertSeedDecript(rec_cert, iv)

			If(Err.Number <> 0) Then
				Response.Write "Error 02 :: ("& Err.Number &") " & Err.Description & vbCrlf & "<br><br>"
			End If

		Set dec = Nothing

        '02. 1차 파싱
        decStr_Split   = Split(rec_cert,"/")
		encPara        = decStr_Split(0)	' rec_cert 1차 암호화데이터
		encMsg         = decStr_Split(1)	' 위변조 검증값

        '03. 위변조 검증
		Set hash = Server.CreateObject("ICERTSecurity.AES")
			If(Err.Number <> 0) Then
				Response.Write "Error 03 :: ("& Err.Number &") " & Err.Description & vbCrlf & "<br><br>"
			End IF

		    hashStr = hash.IcertHMacEncript(encPara)

			If(Err.Number <> 0) Then
				Response.Write "Error 04 :: ("& Err.Number &") " & Err.Description & vbCrlf & "<br><br>"
			End If

		Set hash = Nothing

		msgChk = "N"
		If(hashStr = encMsg) Then
			msgChk = "Y"
		End If

		If(msgChk = "N") Then
			Call Alert_Close("비정상적인 접근입니다.!!")
			dbget.close(): response.End
		End If

        '04. 2차 복호화
		Set dec = Server.CreateObject("ICERTSecurity.SEED")
				If(Err.Number <> 0) Then
					Response.Write "Error 05 :: ("& Err.Number &") " & Err.Description & vbCrlf & "<br><br>"
				End IF

				rec_cert = dec.IcertSeedDecript(encPara, iv)

				If(Err.Number <> 0) Then
					Response.Write "Error 06 :: ("& Err.Number &") " & Err.Description & vbCrlf & "<br><br>"
				End If

		Set dec = Nothing

        '05. 2차 파싱
		decStr_Split		= Split(rec_cert,"/")

		certNum		= decStr_Split(0)
		date		= decStr_Split(1)
		CI       	= decStr_Split(2)
		phoneNo		= decStr_Split(3)
		phoneCorp	= decStr_Split(4)
		birthDay	= decStr_Split(5)
		gender		= decStr_Split(6)
		nation		= decStr_Split(7)
		name		= decStr_Split(8)
		result		= decStr_Split(9)
		certMet		= decStr_Split(10)
		ip			= decStr_Split(11)
		M_name		= decStr_Split(12)
		M_birthDay	= decStr_Split(13)
		M_Gender	= decStr_Split(14)
		M_nation	= decStr_Split(15)
		plusInfo	= decStr_Split(16)
		DI      	= decStr_Split(17)

        '06. CI, DI 복호화
		Set dec = Server.CreateObject("ICERTSecurity.SEED")
				If(Err.Number <> 0) Then
					Response.Write "Error 07 :: ("& Err.Number &") " & Err.Description & vbCrlf & "<br><br>"
				End IF

				CI = dec.IcertSeedDecript(CI, iv)
				DI = dec.IcertSeedDecript(DI, iv)

				If(Err.Number <> 0) Then
					Response.Write "Error 08 :: ("& Err.Number &") " & Err.Description & vbCrlf & "<br><br>"
				End If

		Set dec = Nothing

''	Response.WRite "-plusInfo : " & plusInfo &"<br>"
''	Response.WRite "-name : " & name &"<br>"
''	Response.WRite "-phoneNo : " & phoneNo &"<br>"
''	Response.WRite "-CI : " & CI &"<br>"
''	Response.WRite "-DI : " & DI &"<br>"
''	Response.End

	'#######################################################################
	' 사용자 정보 체크
	'#######################################################################
	Dim usermail, sql

	''조회로그저장.
	sql = "insert into [db_log].[dbo].tbl_user_search_log"
	sql = sql + " (searchname,searchuid,searchuno,refip)"
	sql = sql + " values("
	sql = sql + " '" + LEFT(name,1) + "**'"
	sql = sql + " ,'" + plusInfo + "'"
	sql = sql + " ,'" + DI + "'"
	sql = sql + " ,'" + ip + "'"
	sql = sql + " )"
	dbget.Execute sql
	
	''배치조회막기.(최근 15분동안 검색수; 2009.05.21.허진원)
	dim recentqcount
	recentqcount=0
	sql = "select count(idx) as cnt "
	sql = sql + " from [db_log].[dbo].tbl_user_search_log "
	sql = sql + " where refip='" + ip + "' "
	sql = sql + " and datediff(n,regdate,getdate())<=15"
	
	rsget.Open sql, dbget, 1
		recentqcount = rsget("cnt")
	rsget.Close
	
	if (recentqcount>11) then
	    Call Alert_Close("같은 아이피로 단시간 내에 연속으로 여러번 접속하였습니다.\n잠시 후 다시 시도해주세요.")
	    response.end
	end if

	'// 회원 조회 및 처리
	sql = "EXEC [db_user_Hold].[dbo].[usp_WWW_FindUsermailCI_Get] '" & plusInfo & "', '" & connInfo & "'"
	rsget.CursorLocation = adUseClient
	rsget.Open sql, dbget, adOpenForwardOnly, adLockReadOnly

	if  not rsget.EOF  then
		usermail = rsget("usermail")
	end if
	rsget.Close

	'' email 일부 *** 처리.
	dim dispUserMail,GolPos
	''Left of @
	GolPos = InStr(usermail,"@")
	
	if (GolPos>0) then
	    dispUserMail = Left(usermail,GolPos-1)
	    
	    if (Len(dispUserMail)>2) then
	        dispUserMail = Left(dispUserMail,Len(dispUserMail)-2) + "**"
	    else
	        dispUserMail = "**"
	    end if
	    
	    dispUserMail = dispUserMail & Mid(usermail,GolPos,255)
	end if
	
	
	if (usermail = "") then
			Call Alert_Close("검색결과가 존재하지 않습니다.")
			response.end
	else
			dim strRdm
			strRdm = RandomStr()
			call setTempPassword(plusInfo,strRdm)
		    call sendmailsearchpass(usermail,name,strRdm)

			Call Alert_Close("가입 당시 이메일로 임시 비밀번호를 보내드렸습니다.\n확인하시기 바랍니다. " + dispUserMail)
			response.end
	end if

'---------------------------------------------------------------------
'//임시번호 생성
function RandomStr()
    dim str, strlen
    dim rannum, ix
    
    str = "abcdefghijklmnopqrstuvwxyz0123456789"
    strlen = 6
    
    Randomize
    
    For ix = 1 to strlen
    	 rannum = Int((36 - 1 + 1) * Rnd + 1)
    	 RandomStr = RandomStr + Mid(str,rannum,1)
    Next
end Function

'//회원비번 수정
sub setTempPassword(userid,strRdm)
    dim sqlStr
    dim Enc_userpass, Enc_userpass64
    
    Enc_userpass = MD5(CStr(strRdm))
    Enc_userpass64 = SHA256(MD5(CStr(strRdm)))
    
    
    '##########################################################
    '임시비밀번호로 변경
    sqlStr = " update [db_user].[dbo].[tbl_logindata]" + vbCrlf
    sqlStr = sqlStr + " set userpass=''" + vbCrlf
    sqlStr = sqlStr + " ,Enc_userpass='" + Enc_userpass + "'" + vbCrlf
    sqlStr = sqlStr + " ,Enc_userpass64='" + Enc_userpass64 + "'" + vbCrlf
    sqlStr = sqlStr + " where userid='" + userid + "'"
    rsget.Open sqlStr,dbget,1
    
    '##########################################################
end sub
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->