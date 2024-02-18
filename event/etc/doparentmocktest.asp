<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
'####################################################
' Description : 부모님 모의고사
' History : 2019-04-29 원승현 생성
' 주의사항
'   - 이벤트 기간 : 2019-04-30 ~ 2019-05-08
'   - 오픈시간 : 24시간
'####################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->

<%

    Dim mode, referer, refip, userid, ecode, vQueryExec, vQuery, masterIdx, currenttime, vEventStartDate, vEventEndDate, apgubun, qnuserid, qnmasteridx, qn, marking
	referer = request.ServerVariables("HTTP_REFERER")
	refip = request.ServerVariables("REMOTE_ADDR")
    mode = request("mode")
    qnuserid = request("qnuserid")
    qnmasteridx = request("qnmasteridx")
    qn = request("qn")
    marking = request("marking")

    Dim userNm, parentNm, parentAge, sltvalue, sltyear, sltmonth, sltday, blood, clothsize, footsize, fafood, fadrama
    userNm = requestcheckvar(request("userNm"),500)
    parentNm = requestcheckvar(request("parentNm"),500)
    parentAge = requestcheckvar(request("parentAge"),50)
    sltvalue = requestcheckvar(request("sltvalue"),50)
    sltyear = requestcheckvar(request("sltyear"),50)
    sltmonth = requestcheckvar(request("sltmonth"),50)
    sltday = requestcheckvar(request("sltday"),50)
    blood = requestcheckvar(request("blood"),50)
    clothsize = requestcheckvar(request("clothsize"),50)
    footsize = requestcheckvar(request("footsize"),50)
    fafood = requestcheckvar(request("fafood"),50)
    fadrama = requestcheckvar(request("fadrama"),50)

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  90272
	Else
		eCode   =  91452
	End If

	'// 아이디
	userid = getEncLoginUserid()

	'// 현재시간
	currenttime = now()
	'currenttime = "2018-02-15 오전 10:03:35"

	'// 이벤트시작시간
	vEventStartDate = "2019-04-29"

	'// 이벤트종료시간
	vEventEndDate = "2019-05-15"

	apgubun = "pc"

	if InStr(referer,"10x10.co.kr")<1 Then
		'Response.Write "Err|잘못된 접속입니다."
		'Response.End
	end If

	If not(Left(Trim(currenttime),10) >= Trim(vEventStartDate) and Left(Trim(currenttime),10) < Trim(DateAdd("d", 1, Trim(vEventEndDate)))) Then
		Response.Write "Err|이벤트 기간이 아닙니다."
		Response.End
	End IF

    Select Case Trim(mode)
        Case "mocktest"
            '// 로그인시에만 응모가능
            If not(IsUserLoginOK()) Then
                Response.Write "Err|로그인을 해야>?n이벤트에 참여할 수 있습니다."
                Response.End
            End If

            '// 귀찮지만 생각하기 싫으므로 그냥 validation 처리하자......
            if trim(userNm) = "" Then
                Response.Write "Err|작성자 이름을 입력해주세요."
                response.End
            End If
            if trim(parentNm) = "" Then
                Response.Write "Err|부모님 성함을 입력해주세요."
                response.End
            End If
            if trim(parentAge) = "" Then
                Response.Write "Err|부모님 연세를 입력해주세요."
                response.End
            End If
            if trim(sltvalue) = "" Then
                Response.Write "Err|부모님 생년월일을 입력해주세요."
                response.End
            End If
            if trim(sltyear) = "" Then
                Response.Write "Err|부모님 생년월일을 입력해주세요."
                response.End
            End If
            if trim(sltmonth) = "" Then
                Response.Write "Err|부모님 생년월일을 입력해주세요."
                response.End
            End If
            if trim(sltday) = "" Then
                Response.Write "Err|부모님 생년월일을 입력해주세요."
                response.End
            End If
            if trim(blood) = "" Then
                Response.Write "Err|부모님 혈액형을 입력해주세요."
                response.End
            End If
            if trim(clothsize) = "" Then
                Response.Write "Err|부모님 옷 사이즈를 입력해주세요."
                response.End
            End If
            if trim(footsize) = "" Then
                Response.Write "Err|부모님 발 사이즈를 입력해주세요."
                response.End
            End If
            if trim(fafood) = "" Then
                Response.Write "Err|부모님이 가장 좋아하시는 음식을 입력해주세요."
                response.End
            End If
            if trim(fadrama) = "" Then
                Response.Write "Err|부모님이 요새 즐겨보시는 드라마명을 입력해주세요."
                response.End
            End If

            '// 해당 이벤트를 참여했는지 확인한다.
            vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_event_parentdayexam_master] WITH (NOLOCK) WHERE userid = '" & userid & "' "
            rsget.CursorLocation = adUseClient
	        rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
            If rsget(0) > 0 Then
                Response.Write "Err|이미 답변이 제출되었습니다."
                response.End
            End If
	        rsget.close

            vQueryExec = " Set Nocount On INSERT INTO [db_temp].[dbo].[tbl_event_parentdayexam_master] (userid, userName, parentName, regdate, platform) VALUES('" & userid & "', '" & userNm & "', '"&parentNm&"', getdate(), '"&apgubun&"') Select @@Identity"
            rsget.Open vQueryExec, dbget, adOpenForwardOnly, adLockReadOnly
            IF Not rsget.Eof Then
                masterIdx = rsget(0)
            End If
            rsget.Close

            vQueryExec = "INSERT INTO [db_temp].[dbo].[tbl_event_parentdayexam_detail] (masterIdx, userid, questionNumber, question, answer, regdate, lastupdate) VALUES "
            vQueryExec = vQueryExec & " ('"&masterIdx&"','"&userid&"','1', '연세','"&parentAge&"',getdate(), getdate()) "
            dbget.Execute vQueryExec

            vQueryExec = "INSERT INTO [db_temp].[dbo].[tbl_event_parentdayexam_detail] (masterIdx, userid, questionNumber, question, answer, regdate, lastupdate) VALUES "
            vQueryExec = vQueryExec & " ('"&masterIdx&"','"&userid&"','2', '생년월일','"&sltvalue&"-"&sltyear&"-"&sltmonth&"-"&sltday&"',getdate(), getdate()) "
            dbget.Execute vQueryExec	

            vQueryExec = "INSERT INTO [db_temp].[dbo].[tbl_event_parentdayexam_detail] (masterIdx, userid, questionNumber, question, answer, regdate, lastupdate) VALUES "
            vQueryExec = vQueryExec & " ('"&masterIdx&"','"&userid&"','3', '혈액형','"&blood&"',getdate(), getdate()) "
            dbget.Execute vQueryExec	

            vQueryExec = "INSERT INTO [db_temp].[dbo].[tbl_event_parentdayexam_detail] (masterIdx, userid, questionNumber, question, answer, regdate, lastupdate) VALUES "
            vQueryExec = vQueryExec & " ('"&masterIdx&"','"&userid&"','4', '옷사이즈','"&clothsize&"',getdate(), getdate()) "
            dbget.Execute vQueryExec	

            vQueryExec = "INSERT INTO [db_temp].[dbo].[tbl_event_parentdayexam_detail] (masterIdx, userid, questionNumber, question, answer, regdate, lastupdate) VALUES "
            vQueryExec = vQueryExec & " ('"&masterIdx&"','"&userid&"','5', '발사이즈','"&footsize&"',getdate(), getdate()) "
            dbget.Execute vQueryExec	

            vQueryExec = "INSERT INTO [db_temp].[dbo].[tbl_event_parentdayexam_detail] (masterIdx, userid, questionNumber, question, answer, regdate, lastupdate) VALUES "
            vQueryExec = vQueryExec & " ('"&masterIdx&"','"&userid&"','6', '가장좋아하시는음식','"&fafood&"',getdate(), getdate()) "
            dbget.Execute vQueryExec	

            vQueryExec = "INSERT INTO [db_temp].[dbo].[tbl_event_parentdayexam_detail] (masterIdx, userid, questionNumber, question, answer, regdate, lastupdate) VALUES "
            vQueryExec = vQueryExec & " ('"&masterIdx&"','"&userid&"','7', '요새즐겨보시는드라마','"&fadrama&"',getdate(), getdate()) "
            dbget.Execute vQueryExec
            
            Response.Write "OK|답변이 저장되었습니다.>?n부모님께 페이지를 공유하여 채점을 받아보세요."
            response.End
        Case "grade"
            If qnuserid = "" or qnmasteridx = "" or qn = "" Then
                Response.Write "Err|정상적인 경로로 접근해주세요."
                Response.End
            End If

            vQueryExec = "UPDATE [db_temp].[dbo].[tbl_event_parentdayexam_detail] SET marking='"&marking&"' WHERE userid='"&Server.URLEncode(tenDec(qnuserid))&"' AND questionNumber='"&qn&"' AND masterIdx='"&qnmasteridx&"' "
            dbget.Execute vQueryExec

            Response.Write "OK|채점완료"
            response.End

        Case "urlcopycheck"
            '// 로그인시에만 응모가능
            If not(IsUserLoginOK()) Then
                Response.Write "Err|로그인을 해야>?nURL 복사가 가능합니다."
                Response.End
            End If

            '// 해당 이벤트를 참여했는지 확인한다.
            vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_event_parentdayexam_master] WITH (NOLOCK) WHERE userid = '" & userid & "' "
            rsget.CursorLocation = adUseClient
	        rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
            If rsget(0) > 0 Then
                Response.Write "OK|참여확인"
                response.End
            Else
                Response.Write "Err|답변 저장 후 URL 복사가 가능합니다."
                response.End                
            End If
	        rsget.close

        case else
            Response.Write "Err|정상적인 경로로 접근해주세요."
            response.End
    End Select

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
