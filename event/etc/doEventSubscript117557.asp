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
' Description :  선착순 마일리지
' History : 2022.03.14 정태훈 생성
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
	Response.ContentType = "application/json"
	response.charset = "utf-8"
	dim currentDate, eventStartDate, eventEndDate, i, refer, giveMileage, jukyo, resultCode
	Dim eCode, LoginUserid, mode, sqlStr, device, snsType, returntext, eventobj
	dim result, oJson, mktTest
    refer 		= request.ServerVariables("HTTP_REFERER") '// 레퍼러
	Set oJson = jsObject()
	mode = request("mode")
	IF application("Svr_Info") = "Dev" THEN
	else
		If InStr(refer, "10x10.co.kr") < 1 Then
			oJson("response") = "err"
			oJson("faildesc") = "잘못된 접속입니다."
			oJson.flush
			Set oJson = Nothing
			dbget.close() : Response.End
		End If
	End If

	mktTest = False

    IF application("Svr_Info") = "Dev" THEN
        eCode = "109501"
        mktTest = True
    ElseIf application("Svr_Info")="staging" Then
        eCode = "117557"
        mktTest = True
    Else
        eCode = "117557"
        mktTest = False
    End If
	giveMileage = 2000
	jukyo = "선착순 마일리지 (22.03.16 까지 사용 가능)"

	eventStartDate  = cdate("2022-03-15")		'이벤트 시작일
	eventEndDate 	= cdate("2022-03-17")		'이벤트 종료일 + 1

	LoginUserid		= getencLoginUserid()

	if mktTest then
		currentDate = cdate("2022-03-15")
	else
		currentDate = date()
	end if

	device = "W"

if mode = "add" then
	if Not(IsUserLoginOK) Then
		oJson("response") = "err"
		oJson("faildesc") = "로그인 후 참여하실 수 있습니다."
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
	end if
	if Not(currentDate >= eventStartDate And currentDate < eventEndDate) then	'이벤트 참여기간
		oJson("response") = "err"
		oJson("faildesc") = "이벤트 참여기간이 아닙니다."
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
	end if

	sqlStr = "EXEC [db_event].[dbo].[usp_WWW_Event_FirstComeMileage_Set] '" & LoginUserid & "'," & eCode & "," & giveMileage & ",'" & jukyo & "'"
	rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,1
		If not rsget.EOF Then
			resultCode = rsget(0)
		End If
	rsget.Close

	if resultCode="0" then
		oJson("response") = "ok"
		oJson("message") = "마일리지 지급 완료"
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
	elseif resultCode="1" then
		oJson("response") = "err"
		oJson("message") = "이미 신청하셨습니다."
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
	else
		oJson("response") = "err"
		oJson("message") = "아쉽게도 선착순 마일리지가 모두 지급되었습니다."
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
	end if
end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->