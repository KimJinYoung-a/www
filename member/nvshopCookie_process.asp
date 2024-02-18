<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim due, gourl, sqlStr, AssignedRow, couponDownCnt
due = request("due")
gourl = request("gourl")

If IsUserLoginOK() AND due = "" AND gourl = "" Then
	response.write "<script>top.location.href='"&wwwURL&"';</script>"
Else
	If due = "one" Then
		response.Cookies("nvshop").domain = "10x10.co.kr"
		response.cookies("nvshop")("mode") = "x"
		response.cookies("nvshop").Expires = Date + 1
		If gourl <> "" Then
			response.write "<script>top.location.href='"&gourl&"';</script>"
		End If
	ElseIf due = "lg" Then
	'	원할인
		sqlStr = "IF NOT EXISTS(select userid FROM [db_user].[dbo].[tbl_user_coupon] WHERE userid = '" & GetLoginUserID & "' AND masteridx = '1022') " & vbCrlf
		sqlStr = sqlStr & "insert into [db_user].[dbo].tbl_user_coupon " & vbCrlf
		sqlStr = sqlStr & " (masteridx,userid,couponvalue,coupontype,couponname,minbuyprice, " & vbCrlf
		sqlStr = sqlStr & " targetitemlist,startdate,expiredate) " & vbCrlf
		sqlStr = sqlStr & " values(1022,'" & GetLoginUserID & "',3000,'2','[1월 네이버]쿠폰_3000원 할인',30000, " & vbCrlf
		sqlStr = sqlStr & " '','2018-01-01 00:00:00' ,'2018-01-07 23:59:59') " & vbCrlf

	'	%할인
	'	sqlStr = "IF NOT EXISTS(select userid FROM [db_user].[dbo].[tbl_user_coupon] WHERE userid = '" & GetLoginUserID & "' AND masteridx = '565') " & vbCrlf
	'	sqlStr = sqlStr & "insert into [db_user].[dbo].tbl_user_coupon " & vbCrlf
	'	sqlStr = sqlStr & " (masteridx,userid,couponvalue,coupontype,couponname,minbuyprice, " & vbCrlf
	'	sqlStr = sqlStr & " targetitemlist,startdate,expiredate) " & vbCrlf
	'	sqlStr = sqlStr & " values(565,'" & GetLoginUserID & "',5,'1','네이버 유입고객 쿠폰 5%',30000, " & vbCrlf
	'	sqlStr = sqlStr & " '','2014-03-17 00:00:00' ,'2014-03-23 23:59:59') " & vbCrlf
		dbget.Execute sqlStr, AssignedRow
		If (AssignedRow = 1) Then
			response.Cookies("nvshop").domain = "10x10.co.kr"
			response.cookies("nvshop")("mode") = "y"
			response.cookies("nvshop").Expires = Date + 7
			response.write 	"<script language='javascript'>alert('네이버X텐바이텐 할인쿠폰\n\n쿠폰지급 완료');</script>"
		End If
	End If
End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->