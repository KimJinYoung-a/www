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
' Description :  [2016 정기세일] 빙고빙고
' History : 2016.04.11 원승현
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventApplyCls.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim mode, referer, refip, apgubun, toDateVal, userSelVal, vQuery, sqlstr, okTextVal, evt_code, returnBingoVal, userBingoVal, md5userid, RvSelNum, RvConNum
	mode = requestcheckvar(request("mode"),32)
	referer = request.ServerVariables("HTTP_REFERER")
	refip = request.ServerVariables("REMOTE_ADDR")
	userSelVal = requestcheckvar(request("userSelVal"),32)
	userBingoVal = requestcheckvar(request("userBingoVal"),32)


dim eCode, userid
Dim bingochk1, bingochk2, bingochk3, bingochk4, bingochk5, bingochk6, bingochk7, bingochk8, bingochk9, bingochk10, bingochk11, bingochk12, bingochk13, bingochk14, bingochk15, bingochk16
Dim vPstNum1	'// 팡팡척척 찍찍이 캐치볼
Dim vPstNum2	'// 폭스바겐 마이크로버스 60주년 민트
Dim vPstNum3	'// 플레이모빙 미스터리 피규어 시리즈9
Dim vPstNum4	'// INSTAX MINI 8(컬러랜덤)
Dim vPstNum5	'// 스티키몬스터 보조배터리
Dim vPstNum6	'// 200 마일리지
Dim vPstNum7	'// 100 마일리지(무제한)

Dim vPstNum8	'// 앨리스카드
Dim vPstNum9	'// 아이리버 블루투스 스피커 사운드 미니바
Dim vPstNum10	'// 샤오미 액션캠
Dim vPstNum11	'// 램플로우 더어스
Dim vPstNum12	'// 바바파파 수면램프
Dim vPstNum13	'// 에코백
Dim vPstNum14	'// 델리삭스 양말
Dim vPstNum15	'// 멀티비타민 오렌지맛 구미
Dim vPstNum16	'// 100 마일리지(무제한)

IF application("Svr_Info") = "Dev" THEN
	evt_code   =  66101
Else
	evt_code   =  70029
End If

userid = GetEncLoginUserID()

'// 모바일웹&앱전용
'If isApp="1" Then
'	apgubun = "A"
'Else
'	apgubun = "M"
'End If
apgubun = "W"

'// 해당일자 셋팅
toDateVal = Left(now(), 10)

'// 값 초기화
bingochk1 = False
bingochk2 = False
bingochk3 = False
bingochk4 = False
bingochk5 = False
bingochk6 = False
bingochk7 = False
bingochk8 = False
bingochk9 = False
bingochk10 = False
bingochk11 = False
bingochk12 = False
bingochk13 = False
bingochk14 = False
bingochk15 = False
bingochk16 = False

'// 빙고판에 기본적으로 선택되어져 있는 값이 있음.
bingochk6 = true
bingochk11 = true
bingochk14 = true

if InStr(referer,"10x10.co.kr")<1 then
	Response.Write "Err|잘못된 접속입니다."
	dbget.close() : Response.End
end If

If not( left(now(),10)>="2016-04-18" and left(now(),10)<"2016-04-28" ) Then
'If not( left(now(),10)>="2016-04-11" and left(now(),10)<"2016-04-28" ) Then
	Response.Write "Err|이벤트 응모기간이 아닙니다."
	dbget.close() : Response.End
End If

If userid = "" Then
	Response.Write "Err|로그인을 해야 이벤트에 응모하실 수 있습니다."
	dbget.close() : Response.End
End If

'// 안씀
'If Left(now(), 10) = "2016-03-14" Then
'	If Not(TimeSerial(Hour(now()), minute(now()), second(now())) >= TimeSerial(10, 00, 00) And TimeSerial(Hour(now()), minute(now()), second(now())) < TimeSerial(23, 59, 59)) Then
'		Response.Write "Err|오전 10시부터 응모하실 수 있습니다."
'		dbget.close() : Response.End
'	End If
'End If

'// 빙고판 클릭시
if mode="bingo" then

	'// 해당일자에 참여한 내역이 있는지 확인한다.
	vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_event_70029] WHERE userid='"&userid&"' And convert(varchar(10), regdate, 120) = '"&toDateVal&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	IF rsget(0) >= 1 Then
		Response.Write "Err|오늘은 이미 응모하셨습니다."
		dbget.close() : Response.End
	End If
	rsget.close

	'// 유저 입력값이 기존에 혹시 입력된 값인지 다시한번 확인한다.
	vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_event_70029] WHERE userid='"&userid&"' And lineNum='"&Trim(userSelVal)&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	IF rsget(0) > 0 Then
		Response.Write "Err|이미 선택하신 번호 입니다.>?n다시한번 확인해주세요."
		dbget.close() : Response.End
	End If
	rsget.close

	'// 빙고 번호 선택값 불러옴
	vQuery = "SELECT idx, userid, lineNum, regdate FROM [db_temp].[dbo].[tbl_event_70029] WHERE userid='"&userid&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		Do Until rsget.eof
			if rsget("lineNum")=1 then bingochk1 = true
			if rsget("lineNum")=2 then bingochk2 = true
			if rsget("lineNum")=3 then bingochk3 = true
			if rsget("lineNum")=4 then bingochk4 = true
			if rsget("lineNum")=5 then bingochk5 = true
			if rsget("lineNum")=7 then bingochk7 = true
			if rsget("lineNum")=8 then bingochk8 = true
			if rsget("lineNum")=9 then bingochk9 = true
			if rsget("lineNum")=10 then bingochk10 = true
			if rsget("lineNum")=12 then bingochk12 = true
			if rsget("lineNum")=13 then bingochk13 = true
			if rsget("lineNum")=15 then bingochk15 = true
			if rsget("lineNum")=16 then bingochk16 = true
		rsget.movenext
		Loop
	End IF
	rsget.close


	'// 번호 클릭시 표시할 값(값은 입력되고 빙고가 안되었을시 표시)
	If toDateVal >= "2016-04-27" Then
		okTextVal = "눌러주셔서 감사합니다.>?n다음에 또 만나요~" 
	Else
		okTextVal = "빙고까지 얼마 안 남았습니다.>?n내일 또 눌러주세요!"
	End If

	'// 유저 입력 값 기준으로 빙고여부 판단
	Select Case Trim(userSelVal)

		Case "1"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk2 And bingochk3 And bingochk4 Then
				'// lineA빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineA', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineA빙고여부 리턴해줌
				returnBingoVal = "lineA"
			End If

			If bingochk6 And bingochk11 And bingochk16 Then
				'// lineI빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineI', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineI빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineI"
			End If 

			If bingochk5 And bingochk9 And bingochk13 Then
				'// lineE빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineE', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineE빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineE"
			End If

		Case "2"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk6 And bingochk10 And bingochk14 Then
				'// lineF빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineF', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineF빙고여부 리턴해줌
				returnBingoVal = "lineF"
			End If

			If bingochk1 And bingochk3 And bingochk4 Then
				'// lineA빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineA', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineA빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineA"
			End If 

		Case "3"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk7 And bingochk11 And bingochk15 Then
				'// lineG빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineG', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineG빙고여부 리턴해줌
				returnBingoVal = "lineG"
			End If

			If bingochk1 And bingochk2 And bingochk4 Then
				'// lineA빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineA', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineA빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineA"
			End If 

		Case "4"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk1 And bingochk2 And bingochk3 Then
				'// lineA빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineA', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineA빙고여부 리턴해줌
				returnBingoVal = "lineA"
			End If

			If bingochk7 And bingochk10 And bingochk13 Then
				'// lineJ빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineJ', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineJ빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineJ"
			End If 

			If bingochk8 And bingochk12 And bingochk16 Then
				'// lineH빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineH', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineH빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineH"
			End If

		Case "5"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk6 And bingochk7 And bingochk8 Then
				'// lineB빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineB', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineB빙고여부 리턴해줌
				returnBingoVal = "lineB"
			End If

			If bingochk1 And bingochk9 And bingochk13 Then
				'// lineE빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineE', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineE빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineE"
			End If 

		Case "7"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk5 And bingochk6 And bingochk8 Then
				'// lineB빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineB', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineB빙고여부 리턴해줌
				returnBingoVal = "lineB"
			End If

			If bingochk3 And bingochk11 And bingochk15 Then
				'// lineG빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineG', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineG빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineG"
			End If 

			If bingochk4 And bingochk10 And bingochk13 Then
				'// lineJ빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineJ', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineJ빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineJ"
			End If 

		Case "8"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk5 And bingochk6 And bingochk7 Then
				'// lineB빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineB', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineB빙고여부 리턴해줌
				returnBingoVal = "lineB"
			End If

			If bingochk4 And bingochk12 And bingochk16 Then
				'// lineH빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineH', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineH빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineH"
			End If 

		Case "9"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk1 And bingochk5 And bingochk13 Then
				'// lineE빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineE', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineE빙고여부 리턴해줌
				returnBingoVal = "lineE"
			End If

			If bingochk10 And bingochk11 And bingochk12 Then
				'// lineC빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineC', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineC빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineC"
			End If 

		Case "10"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk2 And bingochk6 And bingochk14 Then
				'// lineF빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineF', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineF빙고여부 리턴해줌
				returnBingoVal = "lineF"
			End If

			If bingochk9 And bingochk11 And bingochk12 Then
				'// lineC빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineC', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineC빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineC"
			End If 

			If bingochk4 And bingochk7 And bingochk13 Then
				'// lineJ빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineJ', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineJ빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineJ"
			End If 


		Case "12"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk4 And bingochk8 And bingochk16 Then
				'// lineH빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineH', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineH빙고여부 리턴해줌
				returnBingoVal = "lineH"
			End If

			If bingochk9 And bingochk10 And bingochk11 Then
				'// lineC빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineC', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineC빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineC"
			End If 


		Case "13"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk1 And bingochk5 And bingochk9 Then
				'// lineE빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineE', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineE빙고여부 리턴해줌
				returnBingoVal = "lineE"
			End If

			If bingochk4 And bingochk7 And bingochk10 Then
				'// lineJ빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineJ', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineJ빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineJ"
			End If 

			If bingochk14 And bingochk15 And bingochk16 Then
				'// lineD빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineD', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineD빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineD"
			End If


		Case "15"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk3 And bingochk7 And bingochk11 Then
				'// lineG빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineG', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineG빙고여부 리턴해줌
				returnBingoVal = "lineG"
			End If

			If bingochk13 And bingochk14 And bingochk16 Then
				'// lineD빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineD', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineD빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineD"
			End If 


		Case "16"
			'// 번호값 입력
			sqlstr = "INSERT INTO [db_temp].[dbo].[tbl_event_70029](userid, lineNum, regdate)" + vbcrlf
			sqlstr = sqlstr & " VALUES('"& userid &"', '" & userSelVal & "', getdate())" + vbcrlf
			dbget.execute sqlstr

			If bingochk4 And bingochk8 And bingochk12 Then
				'// lineH빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineH', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineH빙고여부 리턴해줌
				returnBingoVal = "lineH"
			End If

			If bingochk13 And bingochk14 And bingochk15 Then
				'// lineD빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineD', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineD빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineD"
			End If 

			If bingochk1 And bingochk6 And bingochk11 Then
				'// lineI빙고
				sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'lineI', '"&apgubun&"')" + vbcrlf
				dbget.execute sqlstr

				'// lineI빙고여부 리턴해줌
				returnBingoVal = returnBingoVal&"|lineI"
			End If


		Case Else
			Response.Write "Err|잘못된 접근입니다."
			dbget.close() : Response.End

	End Select

	'// 빙고여부가 없으면 입력되었다고 표시
	If Trim(returnBingoVal)="" Then
		Response.Write "OK|"&getCntAttend&"|"&getCntBingo&"|"&okTextVal
		dbget.close() : Response.End
	Else
		Response.Write "OKBINGO|"&getCntAttend&"|"&getCntBingo&"|"&returnBingoVal
		dbget.close() : Response.End
	End If




'// 빙고 된 후 라인 클릭시
ElseIf mode="add" Then

	'// 빙고라인 값이 있는지 확인한다.
	vQuery = "SELECT sub_opt3 FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid='"&userid&"' And sub_opt1='"&userBingoVal&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		'// 값이 있을경우 기존에 응모한건지 다시한번 확인
		If Not(rsget("sub_opt3")="" Or isnull(rsget("sub_opt3"))) Then
			Response.Write "Err|이미 응모하신 빙고라인 입니다."
			dbget.close() : Response.End
		End If

	Else
		'// 값이 없으면 빙고가 당첨되지 않은건데 들어온거므로 alert표시
		Response.Write "Err|정상적인 경로로 응모해주세요."
		dbget.close() : Response.End

	End If
	rsget.close


	'// 각 상품별 한정갯수 셋팅
	vPstNum1 = 200 '// 팡팡척척 찍찍이 캐치볼(캐치볼)(상품번호-1)
	vPstNum2 = 10 '// 폭스바겐 마이크로버스 60주년 민트(마이크로버스)(상품번호-2)
	vPstNum3 = 300 '// 플레이모빌 미스터리 피규어 시리즈9(플레이모빌)(상품번호-3)
	vPstNum4 = 6 '// INSTAX MINI 8(컬러랜덤)(인스탁스)(상품번호-4)
	vPstNum5 = 1 '// 스티키몬스터 보조배터리(스티키몬스터)(상품번호-5)
	vPstNum6 = 10000 '// 200 마일리지(200마일리지)(상품번호-6)
	vPstNum7 = 18 '// 델리삭스 양말(양말)(상품번호-7)
	vPstNum8 = 0 '// 100 마일리지(무제한)(100마일리지)(상품번호-8)

	vPstNum9 = 150 '// 앨리스카드(앨리스카드)(상품번호-9)
	vPstNum10 = 3 '// 아이리버 블루투스 스피커 사운드 미니바(블루투스스피커)(상품번호-10)
	vPstNum11 = 3 '// 샤오미 액션캠(액션캠)(상품번호-11)
	vPstNum12 = 2 '// 램플로우 더어스(램플로우)(상품번호-12)
	vPstNum13 = 5 '// 바바파파 수면램프(수면램프)(상품번호-13)
	vPstNum14 = 356 '// 에코백(에코백)(상품번호-14)
	vPstNum15 = 62 '// 멀티비타민 오렌지맛 구미(멀티비타민)(상품번호-15)
	vPstNum16 = 0 '// 100 마일리지(무제한)(100마일리지)(상품번호-16)
	

	'// 당첨시 확실히 판단하기 위해 userid에 "10"스트링으로 더해 md5값 만들어 보여줌
	md5userid = md5(userid&"10")

	'// 당첨 상품 랜덤 셀렉트(일자별로 가른다.)
	randomize
	If toDateVal >= "2016-04-14" And toDateVal < "2016-04-23" Then
		RvSelNum=int(Rnd*8)+1
	ElseIf toDateVal >= "2016-04-23" And toDateVal < "2016-04-28" Then
		RvSelNum=int(Rnd*8)+9	
	Else
		Response.Write "Err|이벤트 기간이 아닙니다."
		dbget.close() : Response.End
	End If


	Select Case Trim(RvSelNum)
		Case "1" '// 팡팡척척 찍찍이 캐치볼
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=1 And sub_opt3='캐치볼' "			
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum1 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=8, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '팡팡척척 찍찍이 캐치볼 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 당첨처리
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=1, sub_opt3='캐치볼'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '팡팡척척 찍찍이 캐치볼 당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift13_zzicball.png' alt='팡팡척척 찍찍이 캐치볼' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			End If
			rsget.close

		Case "2" '// 폭스바겐 마이크로버스 60주년 민트
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=2 And sub_opt3='마이크로버스' "			
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum2 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=8, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '폭스바겐 마이크로버스 60주년 민트 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 당첨처리
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=2, sub_opt3='마이크로버스'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '폭스바겐 마이크로버스 60주년 민트 당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift10_fox60mint.png' alt='폭스바겐 마이크로버스 60주년 민트' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			End If
			rsget.close

		Case "3" '// 플레이모빌 미스터리 피규어 시리즈9
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=3 And sub_opt3='플레이모빌' "			
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum3 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=8, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '플레이모빌 미스터리 피규어 시리즈9 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 당첨처리
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=3, sub_opt3='플레이모빌'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '플레이모빌 미스터리 피규어 시리즈9 당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift12_plymysty.png' alt='플레이모빌 미스터리 시리즈' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			End If
			rsget.close

		Case "4" '// 인스탁스
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=4 And sub_opt3='인스탁스' "			
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum4 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=8, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', 'INSTAX MINI 8(컬러랜덤) 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 당첨처리
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=4, sub_opt3='인스탁스'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', 'INSTAX MINI 8(컬러랜덤) 당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift01_insta8.png' alt='INSTAX MINI 8' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			End If
			rsget.close

		Case "5" '// 스티키몬스터 보조배터리
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=5 And sub_opt3='스티키몬스터' "			
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum5 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=8, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '스티키몬스터 보조배터리 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 당첨처리
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=5, sub_opt3='스티키몬스터'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '스티키몬스터 보조배터리 당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift03_stikym.png' alt='스티키몬스터 보조배터리' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			End If
			rsget.close

		Case "6" '// 200 마일리지
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=6 And sub_opt3='200마일리지' "
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum6 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=8, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '200 마일리지 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 당첨처리
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=6, sub_opt3='200마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '200 마일리지 당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift15_mige200.png' alt='200마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			End If
			rsget.close

		Case "7" '// 델리삭스 양말
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=7 And sub_opt3='양말' "
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum7 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=8, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '델리삭스 양말 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 당첨처리
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=7, sub_opt3='양말'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '델리삭스 양말 당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift09_delly2.png' alt='델리삭스 양말(2켤레)' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			End If
			rsget.close

		Case "8" '// 100 마일리지(4월18일부터 22일까지는 8번으로 발급)
			'// 100 마일리지는 무제한 발급이므로 걸리면 무조건 준다.
			vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=8, sub_opt3='100마일리지'"
			vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
			dbget.execute vQuery

			'// 해당 유저의 로그값 집어넣는다.
			sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
			sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '100 마일리지 당첨', '"&apgubun&"')"
			dbget.execute sqlstr

			Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
			dbget.close()	:	response.End

		Case "9" '// 앨리스카드
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=9 And sub_opt3='앨리스카드' "
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum9 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '앨리스카드 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 2차(23일부터 27일 까지)부터는 50:50확률로 조정)
				randomize
				RvConNum=int(Rnd*1000)+1 '100%

				If RvConNum >= 1 And RvConNum < 500 Then '// 1부터 499까진 당첨
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=9, sub_opt3='앨리스카드'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '앨리스카드 당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift08_dysnyc.png' alt='디즈니 앨리스카드' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				Else
					'// 비당첨일 경우 무조건 100마일리지 지급
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '앨리스카드 비당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				End If
			End If
			rsget.close

		Case "10" '// 아이리버 블루투스 스피커 사운드 미니바
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=10 And sub_opt3='블루투스스피커' "
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum10 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '아이리버 블루투스 스피커 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 2차(23일부터 27일 까지)부터는 50:50확률로 조정)
				randomize
				RvConNum=int(Rnd*1000)+1 '100%

				If RvConNum >= 1 And RvConNum < 500 Then '// 1부터 499까진 당첨
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=10, sub_opt3='블루투스스피커'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '아이리버 블루투스 스피커 당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift05_irivspkr.png' alt='아이리버 블루투스 스피커' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				Else
					'// 비당첨일 경우 무조건 100마일리지 지급
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '아이리버 블루투스 스피커 비당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				End If
			End If
			rsget.close

		Case "11" '// 샤오미 액션캠
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=11 And sub_opt3='액션캠' "
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum11 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '샤오미 액션캠 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 2차(23일부터 27일 까지)부터는 50:50확률로 조정)
				randomize
				RvConNum=int(Rnd*1000)+1 '100%

				If RvConNum >= 1 And RvConNum < 500 Then '// 1부터 499까진 당첨
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=11, sub_opt3='액션캠'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '샤오미 액션캠 당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift02_xaomicam.png' alt='샤오미 액션캠' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				Else
					'// 비당첨일 경우 무조건 100마일리지 지급
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '샤오미 액션캠 비당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				End If
			End If
			rsget.close

		Case "12" '// 램플로우 더어스
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=12 And sub_opt3='램플로우' "
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum12 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '램플로우 더어스 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 2차(23일부터 27일 까지)부터는 50:50확률로 조정)
				randomize
				RvConNum=int(Rnd*1000)+1 '100%

				If RvConNum >= 1 And RvConNum < 500 Then '// 1부터 499까진 당첨
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=12, sub_opt3='램플로우'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '램플로우 더어스 당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift04_ramflo.png' alt='램플로우 더어스' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				Else
					'// 비당첨일 경우 무조건 100마일리지 지급
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '램플로우 더어스 비당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				End If
			End If
			rsget.close

		Case "13" '// 바바파파 수면램프
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=13 And sub_opt3='수면램프' "
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum13 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '바바파파 수면램프 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 2차(23일부터 27일 까지)부터는 50:50확률로 조정)
				randomize
				RvConNum=int(Rnd*1000)+1 '100%

				If RvConNum >= 1 And RvConNum < 500 Then '// 1부터 499까진 당첨
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=13, sub_opt3='수면램프'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '바바파파 수면램프 당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift06_bapalamp.png' alt='바바파파 수면램프' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				Else
					'// 비당첨일 경우 무조건 100마일리지 지급
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '바바파파 수면램프 비당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				End If
			End If
			rsget.close

		Case "14" '// 에코백
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=14 And sub_opt3='에코백' "
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum14 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '에코백 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 2차(23일부터 27일 까지)부터는 50:50확률로 조정)
				randomize
				RvConNum=int(Rnd*1000)+1 '100%

				If RvConNum >= 1 And RvConNum < 500 Then '// 1부터 499까진 당첨
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=14, sub_opt3='에코백'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '에코백 당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift07_miminbag.png' alt='에코백' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				Else
					'// 비당첨일 경우 무조건 100마일리지 지급
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '에코백 비당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				End If
			End If
			rsget.close

		Case "15" '// 멀티비타민 오렌지맛 구미
			'// 현재 재고 파악
			sqlstr = "select count(*) From [db_event].[dbo].[tbl_event_subscript] Where evt_code="& evt_code &" And sub_opt2=15 And sub_opt3='멀티비타민' "
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
			If rsget(0) >= vPstNum15 Then
				'// 정해진 수량이 넘었을 경운 무조건 100마일리지 지급
				vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
				vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
				dbget.execute vQuery

				'// 해당 유저의 로그값 집어넣는다.
				sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
				sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '멀티비타민 오렌지맛 구미 비당첨', '"&apgubun&"')"
				dbget.execute sqlstr

				Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
				dbget.close()	:	response.End
			Else
				'// 수량이 있을경우 2차(23일부터 27일 까지)부터는 50:50확률로 조정)
				randomize
				RvConNum=int(Rnd*1000)+1 '100%

				If RvConNum >= 1 And RvConNum < 500 Then '// 1부터 499까진 당첨
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=15, sub_opt3='멀티비타민'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '멀티비타민 오렌지맛 구미 당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift11_orangvita.png' alt='멀티비타민 오렌지맛 구미' /><a href='/my10x10/userinfo/membermodify.asp' class='goMyten' target='_blank'>기본 배송지 확인하러 가기</a><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				Else
					'// 비당첨일 경우 무조건 100마일리지 지급
					vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
					vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
					dbget.execute vQuery

					'// 해당 유저의 로그값 집어넣는다.
					sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
					sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '멀티비타민 오렌지맛 구미 비당첨', '"&apgubun&"')"
					dbget.execute sqlstr

					Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
					dbget.close()	:	response.End
				End If
			End If
			rsget.close

		Case "16" '// 100 마일리지(4월23일부터 27일까지는 16번으로 발급)
			'// 100 마일리지는 무제한 발급이므로 걸리면 무조건 준다.
			vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=16, sub_opt3='100마일리지'"
			vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
			dbget.execute vQuery

			'// 해당 유저의 로그값 집어넣는다.
			sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
			sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '100 마일리지 당첨', '"&apgubun&"')"
			dbget.execute sqlstr

			Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
			dbget.close()	:	response.End


		Case Else '// 이도저도 아니면 걍 100마일리지 줌
			'// 100 마일리지는 무제한 발급(이도저도 아니게 주는 100마일리지는 8번으로 발급)
			vQuery = " update [db_event].[dbo].[tbl_event_subscript] set sub_opt2=8, sub_opt3='100마일리지(특이)'"
			vQuery = vQuery & " Where userid='"&userid&"' And evt_code='"&evt_code&"' And sub_opt1='"&Trim(userBingoVal)&"' "
			dbget.execute vQuery

			'// 해당 유저의 로그값 집어넣는다.
			sqlstr = "INSERT INTO db_log.[dbo].[tbl_caution_event_log] (evt_code , userid , refip ,  value3, device)" + vbcrlf
			sqlstr = sqlstr & " VALUES("& evt_code &", '"& userid &"' ,'"&refip&"', '100 마일리지 당첨(특이)', '"&apgubun&"')"
			dbget.execute sqlstr

			Response.write "OK|<div class='giftLyr window'><div><img src='http://webimage.10x10.co.kr/eventIMG/2016/fourten/70029/img_bingo_gift14_500mlg.png' alt='100마일리지' /><p class='code'>"&md5userid&"<p><button type='button' onclick='ClosePopLayer()' class='lyrClose'>닫기</button></div></div>"
			dbget.close()	:	response.End

	End Select


Else
	Response.Write "Err|잘못된 접속입니다."
	dbget.close() : Response.End
End If



Function getCntAttend()
	Dim vQuery
	vQuery = "SELECT count(*) FROM [db_temp].[dbo].[tbl_event_70029] WHERE userid='"&userid&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
		getCntAttend = rsget(0)
	rsget.close
End Function

Function getCntBingo()
	Dim vQuery
	vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE userid='"&userid&"' And evt_code='"&evt_code&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
		getCntBingo = rsget(0)
	rsget.close

End Function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->