﻿<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 12월 30일
' History : 2016-12-19 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	dim snscnt1, snscnt2, totalokcnt
	Dim mainbannercnt, totalcnt, getitemgocnt
	Dim wincnt1, wincnt2, wincnt3, wincnt4, wincnt5, wincnt6, wincnt7, wincnt8, wincnt9, wincnt10, wincnt11, wincnt12, wincnt13, wincnt14, wincnt15, wincnt16
	Dim wincnt17, wincnt18, wincnt19, wincnt20, wincnt21, wincnt22, wincnt23, wincnt24, wincnt25, wincnt26, wincnt27, wincnt28, wincnt29, wincnt30, wincnt31, wincnt32, wincnt33, wincnt34, wincnt35
	Dim wincnt36, wincnt37, wincnt38, wincnt39, wincnt40, wincnt41, wincnt42, wincnt43, wincnt44
	Dim eCode, userid, sqlStr
	Dim returndate  : returndate = 	request("returndate")

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode 		= "66252"
	Else
		eCode 		= "75048"
	End If

If userid="baboytw" Or userid="greenteenz" Or userid= "helele223" Or userid="cogusdk" Or userid="jjh" Or userid="ksy92630" Then

Else
	response.write "<script>alert('관계자만 볼 수 있는 페이지 입니다.');window.close();</script>"
	response.End
End If

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.table {width:900px; margin:0 auto; font-family:'malgun gothic'; border-collapse:collapse;}
.table th {padding:12px 0; font-size:13px; font-weight:bold;  color:#fff; background:#444;}
.table td {padding:12px 3px; font-size:12px; border:1px solid #ddd; border-bottom:2px solid #ddd;}
.table td.lt {text-align:left; padding:12px 10px;}
.tBtn {display:inline-block; border:1px solid #2b90b6; background:#03a0db; padding:0 10px 2px; line-height:26px; height:26px; font-weight:bold; border-radius:5px; color:#fff !important;}
.tBtn:hover {text-decoration:none;}
.table td input {border:1px solid #ddd; height:30px; padding:0 3px; font-size:14px; color:#ec0d02; text-align:right;}
</style>
</head>
<body>
<%
dim ttcnt
	''응모인원
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	''응모건수
	sqlstr = "select isnull(sum(case when sub_opt1 = '1' then 1 else 2 end),0) as sns1 "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		ttcnt = rsget(0)
	End IF
	rsget.close
	
	''당첨인원
'	sqlstr = "select count(*) as okcnt "
'	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
'	sqlstr = sqlstr & " where evt_code='"& eCode &"' And convert(varchar(10),regdate,120) ='"&returndate&"' and sub_opt2<> 5 "
'	rsget.Open sqlstr, dbget, 1
'
'	If Not rsget.Eof Then
'		totalokcnt = rsget(0)
'	End IF
'	rsget.close
	
	''sns 클릭수
	sqlstr = "SELECT " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt3 = 'fb' then 1 else 0 end),0) as sns1, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt3 = 'ka' then 1 else 0 end),0) as sns2 " + vbcrlf
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript where evt_code = '"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' " 
	rsget.Open sqlstr,dbget,1
	IF Not rsget.Eof Then
		snscnt1 = rsget("sns1")	''페이스북
		snscnt2 = rsget("sns2")	''카카오톡
	End If
	rsget.close()

	''상품별 당첨자
'	sqlstr = "SELECT " + vbcrlf
'	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '1' then 1 else 0 end),0) as item1, " + vbcrlf
''	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '2' then 1 else 0 end),0) as item2, " + vbcrlf
''	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '3' then 1 else 0 end),0) as item3, " + vbcrlf
''	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '4' then 1 else 0 end),0) as item4, " + vbcrlf
'	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '5' then 1 else 0 end),0) as item5 " + vbcrlf
'
'	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript where evt_code = '"& eCode &"'  And convert(varchar(10),regdate,120) ='"&returndate&"' " 
'	rsget.Open sqlstr,dbget,1
'	IF Not rsget.Eof Then
'		wincnt1 = rsget("item1")	''
''		wincnt2 = rsget("item2")	''
''		wincnt3 = rsget("item3")	''
''		wincnt4 = rsget("item4")	''
'		wincnt5	= rsget("item5")	''
'	End If
'	rsget.close()

%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>그린 크리스박스</strong></th>
</tr>

</table>
<table class="table" style="width:90%;">
<colgroup>
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
</colgroup>
<tr align="center" bgcolor="#E6E6E6">
	<th colspan="12"><strong>날짜</strong></th>
</tr>
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_75048_manage.asp?returndate=2016-12-19">2016-12-19 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_75048_manage.asp?returndate=2016-12-20">2016-12-20 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_75048_manage.asp?returndate=2016-12-21">2016-12-21 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_75048_manage.asp?returndate=2016-12-22">2016-12-22 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_75048_manage.asp?returndate=2016-12-23">2016-12-23 (금)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_75048_manage.asp?returndate=2016-12-24">2016-12-24 (토)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_75048_manage.asp?returndate=2016-12-25">2016-12-25 (일)</a></td>
</tr>																				            
</table>
<br>

<table class="table" style="width:90%;">

	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr>
		<Td colspan="12"><font size="5">기준일 : <%=returndate%>, 응모자 : <%=totalcnt%>명, 응모건수 : <%= ttcnt %></font></td>
	</tr>

	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>페이스북</strong></th>
		<th><strong>카카오톡</strong></th>
	</tr>

	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= snscnt1 %><br></td>
		<td bgcolor=""><%= snscnt2 %><br></td>
	</tr>
<!--
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>당첨</strong></th>

		<th><strong>꽝 쿠폰</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td><%= wincnt1 %><br></td>

		<td ><%= wincnt5 %></td>

	</tr>
-->
	<tr>
		<td colspan="12" height="20"></td>
	</tr>
</table>
<br>

<!-- #include virtual="/lib/db/dbclose.asp" -->