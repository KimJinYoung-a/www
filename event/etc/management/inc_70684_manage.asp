<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 오벤져스 데이터
' History : 2016-05-12 허진원
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	Dim mainbannercnt, totalcnt, getitemgocnt
	Dim wincnt1, wincnt2, wincnt3, wincnt4, wincnt5
	Dim eCode, userid, sqlStr
	Dim returndate  : returndate = 	request("returndate")

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode = "66128"
	Else
		eCode = "70684"
	End If

If userid="kobula" or userid="motions" or userid="greenteenz" or userid= "helele223" or userid="cogusdk" Then

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
	sqlstr = sqlstr & " isnull(sum(case when sub_opt1 = '1' then 1 else 0 end),0) as item1, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt1 = '2' then 1 else 0 end),0) as item2, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt1 = '3' then 1 else 0 end),0) as item3, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt1 = '4' then 1 else 0 end),0) as item4 " + vbcrlf
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript where evt_code = '"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' " 
	rsget.Open sqlstr,dbget,1
	IF Not rsget.Eof Then
		wincnt1 = rsget("item1")	''인스탁스
		wincnt2 = rsget("item2")	''스티키몬스터
		wincnt3 = rsget("item3")	''선풍기
		wincnt4 = rsget("item4")	''마일리지
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

	''구매하러가기 클릭수
'	sqlstr = "SELECT count(*)" + vbcrlf
'	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] where evt_code = '"& eCode &"' and value2='getitemno' and convert(varchar(10),regdate,120) ='"&returndate&"' "  + vbcrlf
'	rsget.Open sqlstr,dbget,1
'	IF Not rsget.Eof Then
'		getitemgocnt = rsget(0)
'	End If
'	rsget.close()
%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>오벤져스</strong></th>
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
	<td><a href="/event/etc/management/inc_70684_manage.asp?returndate=2016-05-16">2016-05-16 (월)</a></td>
	<td><a href="/event/etc/management/inc_70684_manage.asp?returndate=2016-05-17">2016-05-17 (화)</a></td>
	<td><a href="/event/etc/management/inc_70684_manage.asp?returndate=2016-05-18">2016-05-18 (수)</a></td>
	<td><a href="/event/etc/management/inc_70684_manage.asp?returndate=2016-05-19">2016-05-19 (목)</a></td>
	<td><a href="/event/etc/management/inc_70684_manage.asp?returndate=2016-05-20">2016-05-20 (금)</a></td>
	<td><a href="/event/etc/management/inc_70684_manage.asp?returndate=2016-05-21">2016-05-21 (토)</a></td>
	<td><a href="/event/etc/management/inc_70684_manage.asp?returndate=2016-05-22">2016-05-22 (일)</a></td>
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
		<Td colspan="6"><font size="5">기준일 : <%=returndate%></font></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>[ 인스탁스 ]</strong></th>
		<th><strong>[ 스티키몬스터 ]</strong></th>
		<th><strong>[ 선풍기 ]</strong></th>
		<th><strong>[ 마일리지 ]</strong></th>
		<th><strong>전면배너클릭수</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= wincnt1 %><br></td>
		<td bgcolor=""><%= wincnt2 %><br></td>
		<td bgcolor=""><%= wincnt3 %><br></td>
		<td bgcolor=""><%= wincnt4 %><br></td>
		<td bgcolor=""><%= mainbannercnt %></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->