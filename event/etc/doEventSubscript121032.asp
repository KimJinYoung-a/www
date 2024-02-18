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
' Description :  디지털 스티커 무료 배포 3탄
' History : 2022.11.09 정태훈 생성
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
	dim result, oJson, mktTest, vQuery, downloadidx
	dim diaryidx, sticker1

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
		eCode = "119226"
		mktTest = True
		diaryidx=5240
		sticker1=5218
	ElseIf application("Svr_Info")="staging" Then
		eCode = "121032"
		mktTest = True
		diaryidx=5278
		sticker1=5277
	Else
		eCode = "121032"
		mktTest = False
		diaryidx=5278
		sticker1=5277
	End If


	downloadidx = request("downloadidx")
	eventStartDate  = cdate("2022-11-14")       '이벤트 시작일
	eventEndDate 	= cdate("2024-01-01")       '이벤트 종료일+1

	LoginUserid		= getencLoginUserid()

	if mktTest then
		currentDate = cdate("2022-11-14")
	else
		currentDate = date()
	end if

	device = "W"

if not (currentDate >= eventStartDate and currentDate <eventEndDate) then
    oJson("response") = "err"
    oJson("message") = "이벤트 참여기간이 아닙니다."
    oJson.flush
    Set oJson = Nothing
    dbget.close() : Response.End
End If

if mode = "down" Then
	if Not(IsUserLoginOK) Then
		oJson("response") = "err"
		oJson("message") = "로그인 후 이용 가능한 이벤트입니다."
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
	end if

	if getevent_subscriptexistscount(eCode, LoginUserid, downloadidx, "", "down") < 1 then
		'// 이벤트 응모내역을 남긴다.
		vQuery = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt3, device)"
		vQuery = vQuery & " VALUES('" & eCode & "', '" & LoginUserid & "', 'down', '" & device & "')"
		dbget.Execute vQuery
	end if

    oJson("response") = "ok"
    oJson.flush
    Set oJson = Nothing
    dbget.close() : Response.End
end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->