<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 10원의 마술상 데이터
' History : 2016-03-28 원승현
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	Dim mainbannercnt, totalcnt, getitemgocnt
	Dim wincnt1, wincnt2, wincnt3, wincnt4, wincnt5
	Dim snscnt1, snscnt2, snscnt3, snscnt4, failcnt
	Dim eCode, userid, sqlStr
	Dim returndate  : returndate = 	request("returndate")

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66090
	Else
		eCode   =  69883
	End If

If userid="baboytw" Or userid="greenteenz" Or userid= "helele223" Or userid= "thensi7" Or userid="cogusdk" Then

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
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	''당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='1' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt1 = rsget(0)
	End IF
	rsget.close

	''비당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='0' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		failcnt = rsget(0)
	End IF
	rsget.close

	'// 전면배너 클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_temp.[dbo].[tbl_event_click_log]"
	sqlstr = sqlstr & " where eventid='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		mainbannercnt = rsget(0)
	End IF
	rsget.close

	''sns 클릭수
	sqlstr = "SELECT " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when value1 = 'fb' then 1 else 0 end),0) as sns1, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when value1 = 'tw' then 1 else 0 end),0) as sns2, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when value1 = 'ka' then 1 else 0 end),0) as sns3, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when value1 = 'ln' then 1 else 0 end),0) as sns4  " + vbcrlf
	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] where evt_code = '"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' " 
	rsget.Open sqlstr,dbget,1
	IF Not rsget.Eof Then
		snscnt1 = rsget("sns1")	''페이스북
		snscnt2 = rsget("sns2")	''트위터
		snscnt3 = rsget("sns3")	''카카오톡
		snscnt4 = rsget("sns4")	''라인
	End If
	rsget.close()

	''구매하러가기 클릭수
	sqlstr = "SELECT count(*)" + vbcrlf
	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] where evt_code = '"& eCode &"' and value1='2' and convert(varchar(10),regdate,120) ='"&returndate&"' "  + vbcrlf
	rsget.Open sqlstr,dbget,1
	IF Not rsget.Eof Then
		getitemgocnt = rsget(0)
	End If
	rsget.close()
%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>10원의 마술상</strong></th>
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
	<th colspan="8"><strong>날짜</strong></th>
</tr>
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69883_manage.asp?returndate=2016-03-28">2016-03-28 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69883_manage.asp?returndate=2016-03-29">2016-03-29 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69883_manage.asp?returndate=2016-03-30">2016-03-30 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69883_manage.asp?returndate=2016-03-31">2016-03-31 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69883_manage.asp?returndate=2016-04-01">2016-04-01 (금)</a></td>
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
		<!--<td colspan="10"><font size="4" color="blue">현재확률 <br> 1등 0.05 % <br> 2등 0.5 % <br> 3등 20 % <br></font></td>-->
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>[ 당첨자 수 ]</strong></th>
		<th><strong>[ 비당첨자수 ]</strong></th>
		<th><strong>전면배너클릭수</strong></th>
		<th><strong>구매하러가기클릭수</strong></th>
		<th><strong>페이스북</strong></th>
		<th><strong>트위터</strong></th>
		<th><strong>카카오톡</strong></th>
		<th><strong>라인</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= wincnt1 %><br></td>
		<td bgcolor=""><%= failcnt %><br></td>
		<td bgcolor=""><%= mainbannercnt %></td>
		<td bgcolor=""><%= getitemgocnt %></td>
		<td bgcolor=""><%= snscnt1 %></td>
		<td bgcolor=""><%= snscnt2 %></td>
		<td bgcolor=""><%= snscnt3 %></td>
		<td bgcolor=""><%= snscnt4 %></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->