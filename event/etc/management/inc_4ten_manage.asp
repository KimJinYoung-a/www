<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 사대천왕 데이터
' History : 2016-03-17 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	Dim mainbannercnt, totalcnt, getitemgocnt
	Dim wincnt1, wincnt2, wincnt3, wincnt4, wincnt5
	Dim snscnt1, snscnt2, snscnt3, snscnt4
	Dim eCodeticket, userid, sqlStr
	Dim returndate  : returndate = 	request("returndate")

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCodeticket   =  66106
	Else
		eCodeticket   =  70030
	End If

If userid="baboytw" Or userid="greenteenz" Or userid= "helele223" Then

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
	''총 응모자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCodeticket &"' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	''상품별 당첨자
	sqlstr = "SELECT " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when value1 = '2016-04-20' then 1 else 0 end),0) as item1, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when value1 = '2016-04-21' then 1 else 0 end),0) as item2, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when value1 = '2016-04-22' then 1 else 0 end),0) as item3, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when value1 = '2016-04-23' then 1 else 0 end),0) as item4, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when value1 = '2016-04-24' then 1 else 0 end),0) as item5  " + vbcrlf
	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] where evt_code = '"& eCodeticket &"' " 
	rsget.Open sqlstr,dbget,1
	IF Not rsget.Eof Then
		wincnt1 = rsget("item1")	''라미 만년필
		wincnt2 = rsget("item2")	''선글라스
		wincnt3 = rsget("item3")	''폴라로이드 스냅
		wincnt4 = rsget("item4")	''커피메이커
		wincnt5 = rsget("item5")	''마스크팩
	End If
	rsget.close()
	
'	''상품별 당첨자
'	sqlstr = "SELECT " + vbcrlf
'	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '1' then 1 else 0 end),0) as item1, " + vbcrlf
'	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '2' then 1 else 0 end),0) as item2, " + vbcrlf
'	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '3' then 1 else 0 end),0) as item3, " + vbcrlf
'	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '4' then 1 else 0 end),0) as item4, " + vbcrlf
'	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '5' then 1 else 0 end),0) as item5  " + vbcrlf
'	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript where evt_code = '"& eCodeticket &"' and convert(varchar(10),regdate,120) ='"&returndate&"' " 
'	rsget.Open sqlstr,dbget,1
'	IF Not rsget.Eof Then
'		wincnt1 = rsget("item1")	''라미 만년필
'		wincnt2 = rsget("item2")	''선글라스
'		wincnt3 = rsget("item3")	''폴라로이드 스냅
'		wincnt4 = rsget("item4")	''커피메이커
'		wincnt5 = rsget("item5")	''마스크팩
'	End If
'	rsget.close()


	''구매하러가기 클릭수
'	sqlstr = "SELECT count(*)" + vbcrlf
'	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] where evt_code = '"& eCodeticket &"' and value2='getitemno' and convert(varchar(10),regdate,120) ='"&returndate&"' "  + vbcrlf
'	rsget.Open sqlstr,dbget,1
'	IF Not rsget.Eof Then
'		getitemgocnt = rsget(0)
'	End If
'	rsget.close()
%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>가격이터진다</strong></th>
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
	<col width="*" />
	<col width="*" />
	<col width="*" />
</colgroup>
<tr align="center" bgcolor="#E6E6E6">
	<th colspan="11"><strong>날짜</strong></th>
</tr>
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_4ten_manage.asp?returndate=2016-04-18">2016-04-18 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_4ten_manage.asp?returndate=2016-04-19">2016-04-19 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_4ten_manage.asp?returndate=2016-04-20">2016-04-20 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_4ten_manage.asp?returndate=2016-04-21">2016-04-21 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_4ten_manage.asp?returndate=2016-04-22">2016-04-22 (금)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_4ten_manage.asp?returndate=2016-04-23">2016-04-23 (토)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_4ten_manage.asp?returndate=2016-04-24">2016-04-24 (일)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_4ten_manage.asp?returndate=2016-04-25">2016-04-25 (금)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_4ten_manage.asp?returndate=2016-04-26">2016-04-26 (토)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_4ten_manage.asp?returndate=2016-04-27">2016-04-27 (일)</a></td>
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
		<Td colspan="12"><font size="5">기준일 : <%=returndate%></font></td>
	</tr>

	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
	</tr>

	<tr align="center" bgcolor="#E6E6E6">
		<th colspan="11"><strong>구매하러 가기 클릭수</strong></th>
	</tr>

	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>[ 라미 만년필 ]</strong></th>
		<th><strong>[ 선글라스 ]</strong></th>
		<th><strong>[ 폴라로이드 스냅 ]</strong></th>
		<th><strong>[ 커피메이커 ]</strong></th>
		<th><strong>[ 마스크팩 ]</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= wincnt1 %><br></td>
		<td bgcolor=""><%= wincnt2 %><br></td>
		<td bgcolor=""><%= wincnt3 %><br></td>
		<td bgcolor=""><%= wincnt4 %><br></td>
		<td bgcolor=""><%= wincnt5 %></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->