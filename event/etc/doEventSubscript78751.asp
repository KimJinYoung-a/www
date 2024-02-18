<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'#############################################################
' Description : [컬쳐] 영화 <슈퍼배드 3> in 텐바이텐
' History : 2017-07-06 원승현 생성
'#############################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
	dim mode, referer,refip, apgubun, nowDate, nowpos, act, sqlstr, md5userid, eCouponID, vQuery
	referer = request.ServerVariables("HTTP_REFERER")
	refip = request.ServerVariables("REMOTE_ADDR")

	'// 모드값(ins)
	mode = requestcheckvar(request("mode"),32)

	Dim eCode, userid
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66382
	Else
		eCode   =  78751
	End If

	nowdate = Left(Now(), 10)

	'// 아이디
	userid = getEncLoginUserid()

	'// 모바일웹&앱전용
	'If isApp="1" Then
	'	apgubun = "A"
	'Else
	'	apgubun = "M"
	'End If
	apgubun = "W"


	if InStr(referer,"10x10.co.kr")<1 then
		Response.Write "Err|잘못된 접속입니다."
		dbget.close() : Response.End
	end If

	If not(nowdate >= "2017-07-06" and nowdate < "2017-07-18") Then
		Response.Write "Err|이벤트 응모기간이 아닙니다."
		dbget.close() : Response.End
	End IF

	'// 로그인시에만 응모가능
	If not(IsUserLoginOK()) Then
		Response.Write "Err|로그인을 해야>?n이벤트에 참여할 수 있어요."
		dbget.close() : Response.End
	End If

	'// 혹시 오전 10시부터 응모여부 할 수도 있으니 남겨둠
	'If Left(now(), 10) = "2016-10-10" Then
	'	If Not(TimeSerial(Hour(now()), minute(now()), second(now())) >= TimeSerial(10, 00, 00) And TimeSerial(Hour(now()), minute(now()), second(now())) < TimeSerial(23, 59, 59)) Then
	'		Response.Write "Err|오전 10시부터 응모하실 수 있습니다."
	'		dbget.close() : Response.End
	'	End If
	'End If


	'// 이벤트 참여
	if mode="ins" Then
		'// 등록전 오늘 참여를 했는지 확인한다.
		If UserAppearChk() > 0 Then
			Response.Write "Err|이미 이벤트에 응모하셨습니다."
			dbget.close() : Response.End
		Else
			'// 참여 데이터를 넣는다.
			Call InsAppearData(eCode, userid, apgubun, "ins")
			Response.Write "OK|1"
			dbget.close() : Response.End
		End If
	Else
		Response.Write "Err|잘못된 접속입니다."
		dbget.close() : Response.End
	End If


	'// 해당이벤트 참여했는지 확인
	Function UserAppearChk()
		Dim vQuery
		vQuery = "SELECT count(*) FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '" & eCode & "' And userid='"&userid&"' And convert(varchar(10), regdate, 120) = '"&nowdate&"' "
		rsget.CursorLocation = adUseClient
		rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
		IF Not rsget.Eof Then
			UserAppearChk = rsget(0)
		End IF
		rsget.close
	End Function

	'// 참여 데이터 ins
	Function InsAppearData(evt_code, uid, device, sub_opt1)
		Dim vQuery
		vQuery = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code , userid, device, sub_opt1, regdate)" & vbCrlf
		vQuery = vQuery & " VALUES ("& evt_code &", '"& uid &"', '"&apgubun&"','"&sub_opt1&"',getdate())"
		dbget.execute vQuery
	End Function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->


