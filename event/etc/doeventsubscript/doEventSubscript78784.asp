﻿<%@codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet = "UTF-8"
'###########################################################
' Description : [2017 신규가입이벤트] 쿠폰
' History : 2017.06.30 유태욱
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
Dim eCode, LoginUserid, mode, sqlStr, device, cnt
		
IF application("Svr_Info") = "Dev" THEN
	eCode = "66378"
Else
	eCode = "78784"
End If

currenttime = date()
mode			= requestcheckvar(request("mode"),32)
LoginUserid		= getencLoginUserid()
refer 			= request.ServerVariables("HTTP_REFERER")

'// 바로 접속시엔 오류 표시
If InStr(refer, "10x10.co.kr") < 1 Then
	Response.Write "Err|잘못된 접속입니다."
	dbget.close: Response.End
End If

'// expiredate
If not(currenttime >= "2017-07-01") Then
	Response.Write "Err|이벤트 기간이 아닙니다."
	dbget.close: Response.End
End If

'// 로그인 여부 체크
If Not(IsUserLoginOK) Then
	Response.Write "Err|로그인 후 참여하실 수 있습니다."
	dbget.close: Response.End
End If

device = "W"

If mode = "down" Then
	'해당월 신규 회원가입인지 확인
'	sqlstr = "SELECT COUNT(*) as cnt FROM db_user.dbo.tbl_user_n WHERE userid= '"&LoginUserid&"' and regdate between '2017-06-01 00:00:00' and '2017-06-30 23:59:59' "
'	sqlstr = "SELECT COUNT(*) as cnt FROM db_user.dbo.tbl_user_n WHERE userid= '"&LoginUserid&"' and year(regdate) = year(getdate()) and Month(regdate) = Month(getdate()) "
	sqlstr = "SELECT COUNT(*) as cnt FROM db_user.dbo.tbl_user_n WHERE userid= '"&LoginUserid&"' and datediff(day,regdate,getdate()) <= 30 "
	rsget.Open sqlstr, dbget, 1
		cnt = rsget("cnt")
	rsget.close

	If cnt > 0 Then
		sqlstr = "SELECT COUNT(*) as cnt FROM [db_event].[dbo].[tbl_event_subscript] WHERE evt_code = '"& eCode &"' and userid= '"&LoginUserid&"' and sub_opt2=LEFT(CONVERT(varchar(30), GETDATE(),112),6) "
		rsget.Open sqlstr, dbget, 1
			mysubsctiptcnt = rsget("cnt")
		rsget.close

		If mysubsctiptcnt < 1 Then
			sqlStr = ""
			sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code , userid , sub_opt1 , sub_opt2, device)" & vbCrlf
			sqlstr = sqlstr & " VALUES ("& eCode &", '"& LoginUserid &"', '1', LEFT(CONVERT(varchar(30), GETDATE(),112),6), '"&device&"')"
			dbget.execute sqlstr

			sqlStr = "IF NOT EXISTS(select userid FROM [db_user].[dbo].[tbl_user_coupon] WHERE userid = '" & LoginUserid & "' AND masteridx = '989') " & vbCrlf
			sqlStr = sqlStr & "BEGIN " & vbCrlf
			sqlStr = sqlStr & "	INSERT INTO [db_user].[dbo].tbl_user_coupon" & vbCrlf
			sqlStr = sqlStr & " (masteridx, userid, couponvalue, coupontype, couponname, minbuyprice, " & vbCrlf
			sqlStr = sqlStr & " targetitemlist, startdate, expiredate)" & vbCrlf
			sqlStr = sqlStr & " values(989,'" & LoginUserid & "',5000,'2','신규가입쿠폰 (5,000원)',70000," & vbCrlf
			sqlStr = sqlStr & " '',getdate() ,dateadd(hh, +24, getdate()))" & vbCrlf
			sqlStr = sqlStr & "END " & vbCrlf
			dbget.execute(sqlStr)

			sqlStr = "IF NOT EXISTS(select userid FROM [db_user].[dbo].[tbl_user_coupon] WHERE userid = '" & LoginUserid & "' AND masteridx = '990') " & vbCrlf
			sqlStr = sqlStr & "BEGIN " & vbCrlf
			sqlStr = sqlStr & "	INSERT INTO [db_user].[dbo].tbl_user_coupon" & vbCrlf
			sqlStr = sqlStr & " (masteridx, userid, couponvalue, coupontype, couponname, minbuyprice, " & vbCrlf
			sqlStr = sqlStr & " targetitemlist, startdate, expiredate)" & vbCrlf
			sqlStr = sqlStr & " values(990,'" & LoginUserid & "',10000,'2','신규가입쿠폰 (10,000원)',150000," & vbCrlf
			sqlStr = sqlStr & " '',getdate() ,dateadd(hh, +24, getdate()))" & vbCrlf
			sqlStr = sqlStr & "END " & vbCrlf
			dbget.execute(sqlStr)
			Response.write "OK|dn"
			dbget.close()	:	response.End
		ElseIf mysubsctiptcnt > 0 Then
			Response.Write "Err|이미 쿠폰을 다운받으셨습니다."
			dbget.close()	:	response.End
		Else
			Response.write "Err|정상적인 경로로 참여해주시기 바랍니다."
			dbget.close()	:	response.End
		End If
	Else
		Response.write "Err|이벤트 대상이 아닙니다!"
		dbget.close()	:	response.End
	End If
Else
	Response.Write "Err|정상적인 경로로 참여해주시기 바랍니다."
	dbget.close() : Response.End
End If	
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->