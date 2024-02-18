﻿<%@codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet = "UTF-8"
'###########################################################
' Description : 텐바이텐X호로요이 응모 액션페이지
' History : 2018-12-05 최종원
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/drawevent/DrawEventCls.asp" -->
<%
	dim mysubsctiptcnt, totalsubsctiptcnt, currenttime, refer
	Dim eCode, LoginUserid, mode, sqlStr, device, cnt, chasu
	dim drawEvt

	IF application("Svr_Info") = "Dev" THEN
		eCode = "90201"
	Else
		eCode = "91395"
	End If

	mode 			= request("mode")
	currenttime 	= date()
	LoginUserid		= getencLoginUserid()
	refer 			= request.ServerVariables("HTTP_REFERER")
	device = "W"

	if InStr(refer, "10x10.co.kr") < 1 then		' 바로 접속시엔 오류 표시		
		Response.write dispScript2(eCode, "잘못된 경로로 접속하셨습니다.")
		response.end
	elseif InStr(refer, "/login/login_adult.asp") < 1 then		'성인 인증 경로로 들어오지 않았을 시		
		Response.write dispScript2(eCode, "잘못된 경로로 접속하셨습니다.")
		response.end
	elseif Not(currenttime >= "2018-12-19" And currenttime <= "2019-01-16") then	'이벤트 참여기간		
		Response.write dispScript2(eCode, "이벤트 참여기간이 아닙니다.")
		response.end
	elseIf Not(IsUserLoginOK) Then			 	
		Response.write dispScript2(eCode, "로그인을 하셔야합니다.")
		response.end
	end if		

	set drawEvt = new DrawEventCls
	drawEvt.evtCode = eCode
	drawEvt.winPercent = 12 '0.5%
	drawEvt.userid = LoginUserid
	drawEvt.device = device
	drawEvt.winnerLimit = 0
	drawEvt.testPopulation = 2000	
	'drawEvt.testMode = true	
	drawEvt.execDraw()
	'drawEvt.test()

	function dispScript(vEvtcode)	
		dispScript = "<script language='javascript'>location.href='/event/eventmain.asp?eventid="&vEvtcode&"';</script>"
	end function
	function dispScript2(vEvtcode, alertMsg)	
		dispScript2 = "<script language='javascript'>alert('"&alertMsg&"'); location.href='/event/eventmain.asp?eventid="&vEvtcode&"';</script>"		
	end function	

	If drawEvt.totalResult = 20 Then			 	
		Response.write dispScript2(eCode, "이미 응모하셨습니다. 잘못된 경로로 접속하셨습니다.")
		response.end
	end if

	'결과 세션 저장		
	'response.write drawEvt.totalResult
	'response.end

	if drawEvt.totalResult = 30 then
		session("evt91395") = "1"
	elseif drawEvt.totalResult = 40 or drawEvt.totalResult = 10 then
		session("evt91395") = "2"
	end if
	'결과반환
		Response.write dispScript(eCode)
		dbget.close()	:	response.End			
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->