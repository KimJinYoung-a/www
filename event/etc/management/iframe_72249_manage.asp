<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 모기잡이
' History : 2016-08-04 김진영
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim userid : userid = getloginuserid()
Dim prize1 , prize2 , prize3
Dim eCode , strSql

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66179
	Else
		eCode   =  72249
	End If

	If userid = "baboytw" Or userid = "greenteenz" Or userid = "djjung" Or userid = "helele223" OR userid="kjy8517" Then
		strSql = " select "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 2 then 1 else 0 end),0) as prize1 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 5 then 1 else 0 end),0) as prize2 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 7 then 1 else 0 end),0) as prize3  "
		strSql = strSql & "	from db_event.dbo.tbl_event_subscript "
		strSql = strSql & "	where evt_code = '" & eCode & "' "
		rsget.Open strSql,dbget,1
		'Response.write strSql
		IF Not rsget.Eof Then
			prize1	= rsget("prize1")	'// 2일차 응모 - 마일리지 100p
			prize2	= rsget("prize2")	'//	5일차 응모 - 모기기피제
			prize3	= rsget("prize3")	'//	7일차 응모 - 마일리지 700p
		End IF
		rsget.close()
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
<table class="table" style="width:90%;">
	<colgroup>
		<col width="8%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>1Day</strong></th>
		<th><strong>2Day</strong></th>
		<th><strong>3Day</strong></th>
		<th><strong>4Day</strong></th>
		<th><strong>5Day</strong></th>
		<th><strong>6Day</strong></th>
		<th><strong>7Day</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<%
			strSql = "select "
			strSql = strSql & " convert(varchar(10),t.regdate,120) "
			strSql = strSql & " , count(*) as totcnt "
			strSql = strSql & " from db_temp.[dbo].[tbl_event_attendance] as t "
			strSql = strSql & " inner join db_event.dbo.tbl_event as e "
			strSql = strSql & " on t.evt_code = e.evt_code and convert(varchar(10),t.regdate,120) between convert(varchar(10),e.evt_startdate,120) and convert(varchar(10),e.evt_enddate,120) "
			strSql = strSql & "	where t.evt_code = '"& eCode &"' " 
			strSql = strSql & "	group by convert(varchar(10),t.regdate,120) " 
			rsget.Open strSql,dbget,1
			If Not rsget.Eof Then
				Do Until rsget.eof
		%>
		<td bgcolor="yellow">참여<br/><%= rsget("totcnt") %></td>
		<%
				rsget.movenext
				Loop
			End IF
			rsget.close
		%>
	</tr>
	<tr>
		<td colspan="2" style="text-align:right;">2일차 마일리지(100p) : <%=prize1%></td>
		<td colspan="3" style="text-align:right;">5일차 모기기피제 : <%=prize2%></td>
		<td colspan="2" style="text-align:right;">7일차 마일리지(700p) : <%=prize3%></td>
	</tr>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->