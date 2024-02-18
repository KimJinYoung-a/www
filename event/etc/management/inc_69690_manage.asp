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
	Dim eCode, userid, sqlStr
	Dim returndate  : returndate = 	request("returndate")

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66073
	Else
		eCode   =  69690
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
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	''상품별 당첨자
	sqlstr = "SELECT " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '1' then 1 else 0 end),0) as item1, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '2' then 1 else 0 end),0) as item2, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '3' then 1 else 0 end),0) as item3, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '4' then 1 else 0 end),0) as item4, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt2 = '5' then 1 else 0 end),0) as item5  " + vbcrlf
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript where evt_code = '"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' " 
	rsget.Open sqlstr,dbget,1
	IF Not rsget.Eof Then
		wincnt1 = rsget("item1")	''라인 프렌드 공기청정기
		wincnt2 = rsget("item2")	''아이리버 스피커
		wincnt3 = rsget("item3")	''에코백
		wincnt4 = rsget("item4")	''토끼램프
		wincnt5 = rsget("item5")	''무배쿠폰
	End If
	rsget.close()

	'// 전면배너 클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from [db_temp].[dbo].[tbl_event_click_log]"
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
	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] where evt_code = '"& eCode &"' and value2='getitemno' and convert(varchar(10),regdate,120) ='"&returndate&"' "  + vbcrlf
	rsget.Open sqlstr,dbget,1
	IF Not rsget.Eof Then
		getitemgocnt = rsget(0)
	End If
	rsget.close()
%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>사대천왕</strong></th>
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
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69690_manage.asp?returndate=2016-03-21">2016-03-21 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69690_manage.asp?returndate=2016-03-22">2016-03-22 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69690_manage.asp?returndate=2016-03-23">2016-03-23 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69690_manage.asp?returndate=2016-03-24">2016-03-24 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69690_manage.asp?returndate=2016-03-25">2016-03-25 (금)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69690_manage.asp?returndate=2016-03-26">2016-03-26 (토)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_69690_manage.asp?returndate=2016-03-27">2016-03-27 (일)</a></td>
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
		<th><strong>[ 라인 프렌드 공기청정기 ]</strong></th>
		<th><strong>[ 아이리버 스피커 ]</strong></th>
		<th><strong>[ 에코백 ]</strong></th>
		<th><strong>[ 토끼램프 ]</strong></th>
		<th><strong>[ 무배쿠폰 ]</strong></th>
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
		<td bgcolor=""><%= wincnt2 %><br></td>
		<td bgcolor=""><%= wincnt3 %><br></td>
		<td bgcolor=""><%= wincnt4 %><br></td>
		<td bgcolor=""><%= wincnt5 %></td>
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