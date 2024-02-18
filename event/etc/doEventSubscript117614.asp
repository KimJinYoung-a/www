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
' Description : 2022 맛있는 텐텐세일
' History : 2022.03.23 정태훈 생성
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
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<%
	Response.ContentType = "application/json"
	response.charset = "utf-8"
	dim currentDate, eventStartDate, eventEndDate, i, refer, currentDay, mileageValue
	Dim eCode, LoginUserid, mode, sqlStr, device, snsType, returntext, eventobj
	dim result, oJson, mktTest, idx, vQuery, rvalue, couponCode, cnt, phoneNumber
    refer 		= request.ServerVariables("HTTP_REFERER") '// 레퍼러
	Set oJson = jsObject()
	mode = request("mode")
	phoneNumber = requestCheckVar(request("phoneNumber"),100)
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
        eCode = 109507
        mktTest = True
    ElseIf application("Svr_Info")="staging" Then
        eCode = 117614
        mktTest = True
    Else
        eCode = 117614
        mktTest = False
    End If

	eventStartDate  = cdate("2022-03-28")		'이벤트 시작일
	eventEndDate 	= cdate("2022-04-26")		'이벤트 종료일 + 1

	LoginUserid		= getencLoginUserid()

	if mktTest then
		currentDate = CDate("2022-03-28"&" "&Right("0"&hour(time),2) &":"& Right("0"&minute(time),2) &":"& Right("0"&second(time),2))
		currentDay = cdate("2022-03-28")
	else
		currentDate = CDate(Date()&" "&Right("0"&hour(time),2) &":"& Right("0"&minute(time),2) &":"& Right("0"&second(time),2))
		currentDay = date()
	end if

	device = "W"

if mode = "couponDown" then
	if Not(IsUserLoginOK) Then
		oJson("response") = "err"
		oJson("faildesc") = "로그인 후 참여하실 수 있습니다."
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
	end if

	If currentDate < #2022-03-29 15:00:00# Then
		oJson("response") = "err"
		oJson("message") = "이벤트 참여기간이 아닙니다."
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
	elseIf currentDate >= #2022-03-29 15:00:00# and currentDate < #2022-03-29 15:10:00# Then
	'elseIf currentDate >= #2022-03-29 14:00:00# and currentDate < #2022-03-29 16:10:00# Then
		couponCode = 2069
	elseIf currentDate >= #2022-03-31 15:00:00# and currentDate < #2022-03-31 15:10:00# Then
		couponCode = 2070
	elseIf currentDate >= #2022-04-05 15:00:00# and currentDate < #2022-04-05 15:10:00# Then
		couponCode = 2071
	elseIf currentDate >= #2022-04-07 15:00:00# and currentDate < #2022-04-07 15:10:00# Then
		couponCode = 2072
	elseIf currentDate >= #2022-04-12 15:00:00# and currentDate < #2022-04-12 15:10:00# Then
		couponCode = 2073
	elseIf currentDate >= #2022-04-14 15:00:00# and currentDate < #2022-04-14 15:10:00# Then
		couponCode = 2074
	elseIf currentDate >= #2022-04-19 15:00:00# and currentDate < #2022-04-19 15:10:00# Then
		couponCode = 2075
	elseIf currentDate >= #2022-04-21 15:00:00# and currentDate < #2022-04-21 15:10:00# Then
		couponCode = 2076
	else
		oJson("response") = "err"
		oJson("message") = "쿠폰이 모두 소진 되었습니다."
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
	end if
	rvalue = fnSetSelectCouponDown(couponCode, eCode, 15, LoginUserid)
	SELECT CASE  rvalue
		CASE 0
			oJson("response") = "err"
			oJson("message") = "정상적인 경로가 아닙니다."
			oJson.flush
			Set oJson = Nothing
			dbget.close() : Response.End
		CASE 2
			oJson("response") = "err"
			oJson("message") = "기간이 종료되었거나 유효하지 않은 쿠폰입니다."
			oJson.flush
			Set oJson = Nothing
			dbget.close() : Response.End
		CASE 3
			oJson("response") = "err"
			oJson("message") = "이미 지급 받으셨습니다."
			oJson.flush
			Set oJson = Nothing
			dbget.close() : Response.End
		CASE 4
			oJson("response") = "err"
			oJson("message") = "쿠폰이 모두 소진 되었습니다."
			oJson.flush
			Set oJson = Nothing
			dbget.close() : Response.End
	END SELECT

	oJson("response") = "ok"
	oJson("message") = "쿠폰 다운이 완료되었습니다. 기간 내 꼭 사용하세요!"
	oJson.flush
	Set oJson = Nothing
	dbget.close() : Response.End
elseif mode="mileage" then
	If currentDate < #2022-03-28 00:00:00# Then
		oJson("response") = "err"
		oJson("message") = "이벤트 참여기간이 아닙니다."
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
	end if

    sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE userid= '"&LoginUserid&"' and evt_code="& eCode & " and sub_opt3='mileage' And regdate>='" & currentDay & "' and regdate<'" & dateadd("d", 1, currentDay) & "'"
    rsget.Open sqlstr, dbget, 1
        cnt = rsget("cnt")
    rsget.close

    If cnt < 1 Then
        '랜덤 마일리지
        sqlstr = "SELECT top 1 idx, mileage FROM [db_temp].[dbo].[tbl_event_117614]  WHERE isusing='N' order by newid()"
        rsget.Open sqlstr, dbget, 1
        IF Not rsget.Eof Then
            idx = rsget("idx")
            mileageValue = rsget("mileage")
        else
            mileageValue = 50
        end if
        rsget.close

		'// 이벤트 테이블에 내역을 남긴다.
		if mktTest then
		vQuery = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt2, sub_opt3, device, regdate) VALUES('" & eCode & "', '" & LoginUserid & "', '"&mileageValue&"', 'mileage', '"&device&"','" & currentDay & "')"
		else
		vQuery = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt2, sub_opt3, device) VALUES('" & eCode & "', '" & LoginUserid & "', '"&mileageValue&"', 'mileage', '"&device&"')"
		end if
		dbget.Execute vQuery

		'// 마일리지 로그 테이블에 넣는다.
		vQuery = " insert into db_user.dbo.tbl_mileagelog(userid , mileage , jukyocd , jukyo , deleteyn) values ('"&LoginUserid&"', '+"&mileageValue&"','"&eCode&"', '오늘 혜택 쿠키 마일리지 " & FormatNumber(mileageValue,0) & "p (22.04.14까지 사용 가능)','N') "
		dbget.Execute vQuery

		'// 마일리지 테이블에 넣는다.
		vQuery = " update [db_user].[dbo].[tbl_user_current_mileage] set bonusmileage = bonusmileage + " & mileageValue & ", lastupdate=getdate() Where userid='"&LoginUserid&"' "
		dbget.Execute vQuery

		if idx <> "" then
			sqlStr = "update [db_temp].[dbo].[tbl_event_117614] set isusing='Y' where idx=" & Cstr(idx)
			dbget.Execute(sqlStr)
		end if

		oJson("response") = "ok"
		oJson("message") = "오늘의 랜덤혜택 " & FormatNumber(mileageValue,0) & "p가 지급되었습니다"
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
    Else
        oJson("response") = "retry"
        oJson("message") = "이미 지급 받으셨습니다. 내일 다시 도전하세요!"
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    End If
elseif mode="freebiesmileage" then
	If currentDate < #2022-03-28 00:00:00# Then
		oJson("response") = "err"
		oJson("message") = "이벤트 참여기간이 아닙니다."
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
	end if

	dim vEvtOrderCnt, vEvtOrderSumPrice
	'// 이벤트 기간 구매 내역 체킹
	if mktTest then
	sqlStr = " EXEC [db_order].[dbo].[sp_Ten_MyOrderList_SUM_19THEVENT] '" & LoginUserid & "', '', '', '2021-12-01', '2022-04-26', '10x10', '', 'issue'"
	else
	sqlStr = " EXEC [db_order].[dbo].[sp_Ten_MyOrderList_SUM_19THEVENT] '" & LoginUserid & "', '', '', '2022-03-28', '2022-04-26', '10x10', '', 'issue'"
	end if
	rsget.CursorLocation = adUseClient
	rsget.CursorType = adOpenStatic
	rsget.LockType = adLockOptimistic
	rsget.Open sqlStr,dbget,adOpenForwardOnly,adLockReadOnly
		vEvtOrderCnt = rsget("cnt")
		vEvtOrderSumPrice   = CHKIIF(isNull(rsget("tsum")),0,rsget("tsum"))
	rsget.Close

    sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE userid= '"&LoginUserid&"' and evt_code="& eCode & " and sub_opt3='freebiesmileage'"
    rsget.Open sqlstr, dbget, 1
        cnt = rsget("cnt")
    rsget.close

    If cnt < 1 Then
		If vEvtOrderCnt >= 3 And vEvtOrderSumPrice >= 150000 Then
			'// 이벤트 테이블에 내역을 남긴다.
			vQuery = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt3, device) VALUES('" & eCode & "', '" & LoginUserid & "', 'freebiesmileage', '"&device&"')"
			dbget.Execute vQuery

			oJson("response") = "ok"
			oJson("message") = "신청이 완료 되었습니다.>?n마일리지는 5월 9일에 지급 될 예정입니다."
			oJson.flush
			Set oJson = Nothing
			dbget.close() : Response.End
		Else
			oJson("response") = "fail"
			oJson("message") = "신청조건에 맞지 않습니다."
			oJson.flush
			Set oJson = Nothing
			dbget.close() : Response.End
		End If
    Else
        oJson("response") = "err"
        oJson("message") = "이미 신청 하셨습니다."
        oJson.flush
        Set oJson = Nothing
        dbget.close() : Response.End
    End If
elseIf mode="kamsg" Then
        phoneNumber = left(Base64decode(phoneNumber),13)
        if isnull(phoneNumber) or len(phoneNumber) > 13 Then
			oJson("response") = "err"
			oJson("message") = "전화 번호를 확인 해주세요."
			oJson.flush
			Set oJson = Nothing
			dbget.close() : Response.End
        end if
        dim fullText, failText, btnJson , requestDate , loopCnt
        dim eventCount , eventTime, episode2
        if mktTest then
            requestDate = formatdate(DateAdd("n",2,now()),"0000.00.00 00:00:00")
        else
            If currentDate >= #2022-03-28 00:00:00# and currentDate < #2022-03-29 00:00:00# Then
                requestDate = formatdate(DateAdd("n",-40,#03/29/2022 15:00:00#),"0000.00.00 00:00:00")
                episode2=1
            elseIf currentDate >= #2022-03-29 00:00:00# and currentDate < #2022-03-31 00:00:00# Then
                requestDate = formatdate(DateAdd("n",-40,#03/31/2022 15:00:00#),"0000.00.00 00:00:00")
                episode2=2
			elseIf currentDate >= #2022-03-31 00:00:00# and currentDate < #2022-04-05 00:00:00# Then
                requestDate = formatdate(DateAdd("n",-40,#04/05/2022 15:00:00#),"0000.00.00 00:00:00")
                episode2=3
			elseIf currentDate >= #2022-04-05 00:00:00# and currentDate < #2022-04-07 00:00:00# Then
                requestDate = formatdate(DateAdd("n",-40,#04/07/2022 15:00:00#),"0000.00.00 00:00:00")
                episode2=4
			elseIf currentDate >= #2022-04-07 00:00:00# and currentDate < #2022-04-12 00:00:00# Then
                requestDate = formatdate(DateAdd("n",-40,#04/12/2022 15:00:00#),"0000.00.00 00:00:00")
                episode2=5
			elseIf currentDate >= #2022-04-12 00:00:00# and currentDate < #2022-04-14 00:00:00# Then
                requestDate = formatdate(DateAdd("n",-40,#04/14/2022 15:00:00#),"0000.00.00 00:00:00")
                episode2=6
			elseIf currentDate >= #2022-04-14 00:00:00# and currentDate < #2022-04-19 00:00:00# Then
                requestDate = formatdate(DateAdd("n",-40,#04/19/2022 15:00:00#),"0000.00.00 00:00:00")
                episode2=7
			elseIf currentDate >= #2022-04-19 00:00:00# and currentDate < #2022-04-21 00:00:00# Then
                requestDate = formatdate(DateAdd("n",-40,#04/21/2022 15:00:00#),"0000.00.00 00:00:00")
                episode2=8
            end if
        end if

        '// db_temp.dbo.tbl_event_kakaoAlarm테이블에 실제 진행하는 episode 값을 넣어줌
        IF Not(fnIsSendKakaoAlarm(eCode,phoneNumber,episode2)) THEN
			oJson("response") = "err"
			oJson("message") = "이미 알림톡 서비스를 신청 하셨습니다."
			oJson.flush
			Set oJson = Nothing
			dbget.close() : Response.End
        END IF

        fullText = LoginUserid & "님, 신청하신 알림입니다. " & vbCrLf &_
        "알림신청하신 [선착순 반값쿠폰 이벤트] 가 곧 시작됩니다."
        failText = "[텐바이텐] 선착순 반값쿠폰 이벤트 알림입니다."
        btnJson = "{""button"":[{""name"":""참여하기"",""type"":""WL"",""url_mobile"":""https://tenten.app.link/AuGG3fQGpob""}]}"

        IF application("Svr_Info") = "Dev" THEN
            Call SendKakaoMsg_LINK(phoneNumber,"1644-6030","A-0056",fullText,"SMS","",failText,btnJson)
        Else
            Call SendKakaoMsg_LINKForMaketing(phoneNumber,requestDate,"1644-6030","A-0056",fullText,"SMS","",failText,btnJson)
        End If

		oJson("response") = "ok"
		oJson("message") = "신청이 완료되었습니다."
		oJson.flush
		Set oJson = Nothing
		dbget.close() : Response.End
end if

Function fnSetSelectCouponDown(ByVal idx, ByVal eCode, ByVal couponCNT, ByVal LoginUserid)
    dim sqlStr
    Dim objCmd
    Set objCmd = Server.CreateObject("ADODB.COMMAND")
    With objCmd
        .ActiveConnection = dbget
        .CommandType = adCmdText
        .CommandText = "{?= call [db_user].[dbo].[usp_WWW_Event_DeliciousTenTenSale_CouponDown_Set](" & idx & "," & eCode & "," & couponCNT & ",'" & LoginUserid & "')}"
        .Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
        .Execute, , adExecuteNoRecords
        End With
        fnSetSelectCouponDown = objCmd(0).Value
    Set objCmd = Nothing
END Function

Public Function fnIsSendKakaoAlarm(eventId,userCell,episode)

	if userCell = "" or eventId = "" then 
        fnIsSendKakaoAlarm = false
        exit function 
    END IF

	dim vQuery , vStatus

	vQuery = "IF EXISTS(SELECT usercell FROM db_temp.dbo.tbl_event_kakaoAlarm WITH(NOLOCK) WHERE eventid = '"& eventId &"' and usercell = '"& userCell &"' and episode='" & episode & "') " &vbCrLf
	vQuery = vQuery & "	BEGIN " &vbCrLf
	vQuery = vQuery & "		SELECT 'I' " &vbCrLf
	vQuery = vQuery & "	END " &vbCrLf
	vQuery = vQuery & "ELSE " &vbCrLf
	vQuery = vQuery & "	BEGIN " &vbCrLf
	vQuery = vQuery & "		SELECT 'U' " &vbCrLf
	vQuery = vQuery &"	END "

	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	IF Not (rsget.EOF OR rsget.BOF) THEN
		vStatus = rsget(0)
	End IF
	rsget.close

    IF vStatus = "U" THEN  
        vQuery = "INSERT INTO db_temp.dbo.tbl_event_kakaoAlarm (eventid , usercell, episode) values ('"& eventId &"' , '"& userCell &"','" & episode & "') "
        dbget.Execute vQuery
    END IF
	
	fnIsSendKakaoAlarm = chkiif(vStatus = "I", false , true)
End Function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->