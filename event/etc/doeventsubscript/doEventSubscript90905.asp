<%@codepage="65001" language="VBScript" %>
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
<%
	dim mysubsctiptcnt, totalsubsctiptcnt, currenttime, refer
	Dim eCode, LoginUserid, mode, sqlStr, device, cnt, chasu

	function dispScript(vEvtcode, vResultParam)	
		dispScript = "<script language='javascript'>location.href='/event/eventmain.asp?eventid="&vEvtcode&"&resultParam="&vResultParam&"';</script>"
	end function

	'1차, 2차 이벤트 구분
	if date() < "2018-12-25" then
		chasu = 1
	Else
		chasu = 2	
	end if		

	IF application("Svr_Info") = "Dev" THEN
		eCode = "90200"
	Else
		eCode = "90905"
	End If

	mode 			= request("mode")
	currenttime 	= date()
	LoginUserid		= getencLoginUserid()
	refer 			= request.ServerVariables("HTTP_REFERER")

	device = "W"
	dim alertMsg, resultParam	

if mode = "regAlram" then
	'알림 응모 여부 체크 
	sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE userid= '"&LoginUserid&"' and evt_code="& eCode &" and sub_opt2 = '1' "
	rsget.Open sqlstr, dbget, 1
		cnt = rsget("cnt")
	rsget.close

	If cnt < 1 Then
		sqlStr = ""
		sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code , userid , device, sub_opt2)" & vbCrlf
		sqlstr = sqlstr & " VALUES ("& eCode &", '"& LoginUserid &"', '"&device&"', '1')"
		dbget.execute sqlstr

		Response.write "OK"
		dbget.close()	:	response.End
	Else				
		Response.write "ERR"
		dbget.close()	:	response.End
	End If
else
	if InStr(refer, "10x10.co.kr") < 1 then		' 바로 접속시엔 오류 표시		
		Response.write dispScript(eCode, "1")
		response.end
	elseif InStr(refer, "/login/login_adult.asp") < 1 then		'성인 인증 경로로 들어오지 않았을 시		
		Response.write dispScript(eCode, "2")
		response.end
	elseif Not(currenttime >= "2018-12-05" And currenttime <= "2019-01-10") then	'이벤트 참여기간		
		Response.write dispScript(eCode, "3")
		response.end
 	elseIf Not(IsUserLoginOK) Then			 	
		Response.write dispScript(eCode, "4")
		response.end
	end if
	
	'응모 여부 체크
	sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript]  WHERE userid= '"&LoginUserid&"' and evt_code="& eCode &" and sub_opt3 = '"& chasu &"'"
	rsget.Open sqlstr, dbget, 1
		cnt = rsget("cnt")
	rsget.close

	If cnt < 1 Then
		sqlStr = ""
		sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code , userid , device, sub_opt3)" & vbCrlf
		sqlstr = sqlstr & " VALUES ("& eCode &", '"& LoginUserid &"', '"&device&"', '"&chasu&"')"
		dbget.execute sqlstr

		Response.write dispScript(eCode, "0")
		dbget.close()	:	response.End
	Else				
		Response.write dispScript(eCode, "5")
		dbget.close()	:	response.End
	End If
end if	
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->