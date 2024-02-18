<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 또 31 데이터
' History : 2016-05-11 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	Dim mainbannercnt, totalcnt, getitemgocnt, total70923cnt
	Dim wincnt1, wincnt2, wincnt3, wincnt4, wincnt5
	Dim snscnt1, snscnt2, snscnt3, snscnt4
	Dim eCode, userid, sqlStr
	Dim returndate  : returndate = 	request("returndate")

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66124
	Else
		eCode   =  70923
	End If

If userid="baboytw" Or userid="greenteenz" Or userid= "helele223" Or userid= "cogusdk" Then

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
	''총 신청자 수
'	sqlstr = "select count(*) as cnt "
'	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
'	sqlstr = sqlstr & " where evt_code='70923' and convert(varchar(10),regdate,120) ='"&returndate&"'"
'	rsget.Open sqlstr, dbget, 1
'
'	If Not rsget.Eof Then
'		total70923cnt = rsget(0)
'	End IF
'	rsget.close

	''또 담아영 폴더생성수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from [db_my10x10].[dbo].[tbl_myfavorite_folder]"
	sqlstr = sqlstr & " where foldername='또! 담아영' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	''상품별 응모자
	sqlstr = "SELECT " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt1 = '1' then 1 else 0 end),0) as item1, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt1 = '2' then 1 else 0 end),0) as item2, " + vbcrlf
	sqlstr = sqlstr & " isnull(sum(case when sub_opt1 = '3' then 1 else 0 end),0) as item3 " + vbcrlf
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript where evt_code = '"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' " 
	rsget.Open sqlstr,dbget,1
	IF Not rsget.Eof Then
		wincnt1 = rsget("item1")	''10만
		wincnt2 = rsget("item2")	''50만
		wincnt3 = rsget("item3")	''100만
	End If
	rsget.close()

	'// 전면배너 클릭수
'	sqlstr = "select count(*) "
'	sqlstr = sqlstr & " from [db_temp].[dbo].[tbl_event_click_log]"
'	sqlstr = sqlstr & " where eventid='70923' and convert(varchar(10),regdate,120) ='"&returndate&"' "
'	rsget.Open sqlstr, dbget, 1
'
'	If Not rsget.Eof Then
'		mainbannercnt = rsget(0)
'	End IF
'	rsget.close

	''sns 클릭수
'	sqlstr = "SELECT count(*) as snscnt" + vbcrlf
'	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] where evt_code = '70923' and convert(varchar(10),regdate,120) ='"&returndate&"' " 
'	rsget.Open sqlstr,dbget,1
'	If Not rsget.Eof Then
'		snscnt1 = rsget(0)
'	End IF
'	rsget.close

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
	<th><strong>또 담아영</strong></th>
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
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70923_manage.asp?returndate=2016-05-30">2016-05-30 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70923_manage.asp?returndate=2016-05-31">2016-05-31 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70923_manage.asp?returndate=2016-06-01">2016-06-01 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70923_manage.asp?returndate=2016-06-02">2016-06-02 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70923_manage.asp?returndate=2016-06-03">2016-06-03 (금)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70923_manage.asp?returndate=2016-06-04">2016-06-04 (토)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70923_manage.asp?returndate=2016-06-05">2016-06-05 (일)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70923_manage.asp?returndate=2016-06-06">2016-06-06 (월)</a></td>
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
		<th><strong>또! 담아영 폴더 수</strong></th>
		<th><strong>[ 10만 ]</strong></th>
		<th><strong>[ 50만 ]</strong></th>
		<th><strong>[ 100만 ]</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= wincnt1 %><br></td>
		<td bgcolor=""><%= wincnt2 %><br></td>
		<td bgcolor=""><%= wincnt3 %><br></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->