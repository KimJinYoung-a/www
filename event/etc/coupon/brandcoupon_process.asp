﻿<%@codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet = "UTF-8"
'####################################################
' Description : 쿠폰 발급 처리 페이지
' History : 2019-12-23 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
	dim mysubsctiptcnt, totalsubsctiptcnt, currenttime, refer, subscriptcount, couponIdxs
	Dim eCode, LoginUserid, mode, sqlStr, device, cnt, videoLink, urlCnt
    Dim i, rvalue, oldrvalue, arridx, couponType
    dim eventEndDate, currentDate, eventStartDate
    dim evtinfo

	eCode			= request("eCode")    
	currenttime 	= date()
	LoginUserid		= getencLoginUserid()			
	couponIdxs 		= request("couponIdxs")

	device = "W"

    evtinfo = getEventDate(eCode)
    '변수 초기화
    eventStartDate = cdate(evtinfo(0,0))
    eventEndDate = cdate(evtinfo(1,0))
    currentDate = date()    

	If Not(IsUserLoginOK) Then
        Response.Write "LGN|/login/loginpage.asp?backpath="&Server.URLencode("/event/eventmain.asp?eventid="&eCode)
		response.End
	End If

    If Trim(couponIdxs) = "" Then
		Response.Write "Err|정상적인 경로로 접근해 주세요."
		response.End
	End If

    '// 이벤트 코드 유효성 체크
    if not isArray(evtinfo) then
		Response.Write "Err|정상적인 경로로 접근해 주세요."
		response.End
    end if

    '// 이벤트 기간 확인
	if not (currentDate >= eventStartDate and currentDate <= eventEndDate) then
		Response.Write "Err|이벤트 참여기간이 아닙니다."
		response.End
    end if

	'//본인 참여 여부
	if LoginUserid<>"" then
		subscriptcount = getevent_subscriptexistscount(eCode, LoginUserid, "", "", couponIdxs)
	end if

	if subscriptcount > 0 then
		Response.write "Err|이미 발급된 쿠폰입니다. 구매 페이지에서 적용 가능합니다."
		dbget.close()	:	response.End
	Else
        arridx = split(couponIdxs,",")
        '// 쿠폰 발급
		For i = 0 To UBound(arridx)
		    rvalue = fnSetSelectCouponDown(LoginUserid,arridx(i))
			if rvalue = 0 then 	'문제 발생시 롤백처리
				exit for
			elseif rvalue = 1 then	'정상처리
                oldrvalue = 1
			elseif (rvalue = 2 or  rvalue = 3) then	'유효하지 않은 쿠폰또는 이미받은 쿠폰 제외하고 다른 쿠폰 다운처리
				if oldrvalue = 1 then 	rvalue = 1
			end if            
        Next
		SELECT CASE  rvalue
			CASE 0
				Response.Write "Err|정상적인 경로가 아닙니다."
				dbget.close() : Response.End
			CASE 1
                Call fncheckcoupondownlog(eCode, device, couponIdxs, LoginUserid)
				Response.Write "OK|OK"
				dbget.close() : Response.End
			CASE 2
				Response.Write "Err|기간이 종료되었거나 유효하지 않은 쿠폰입니다."
				dbget.close() : Response.End
			CASE 3
				Response.Write "Err|이미 쿠폰을 받으셨습니다."
				dbget.close() : Response.End
		END SELECT
	    dbget.close()	:	response.End
	End IF

	Function fnSetSelectCouponDown(ByVal LoginUserid, ByVal idx)
		dim sqlStr
		Dim objCmd
		Set objCmd = Server.CreateObject("ADODB.COMMAND")
		With objCmd
			.ActiveConnection = dbget
			.CommandType = adCmdText
			.CommandText = "{?= call [db_user].[dbo].sp_Ten_eventcoupon_down_selected("&idx&",'"&LoginUserid&"')}"
			.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
			.Execute, , adExecuteNoRecords
			End With
		    fnSetSelectCouponDown = objCmd(0).Value
		Set objCmd = Nothing
	END Function

	Function fncheckcoupondownlog(ByVal evt_code, ByVal device, ByVal couponIdxs, ByVal LoginUserid)
		dim sqlStr
		sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt3, device)" + vbcrlf
		sqlstr = sqlstr & " VALUES("& evt_code &",'" & LoginUserid & "','"&couponIdxs&"','"& device &"')" + vbcrlf
		dbget.execute sqlstr
	End Function    
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->