<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 60932 셋콤달콤-메가박스
' History : 2015-04-16 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim set1,set2,set3,set4
Dim eCode, subscriptcount, userid, evtTotalCnt, sqlStr, cnt, totalcnt, appbannerclick

	userid=getloginuserid()

IF application("Svr_Info") = "Dev" THEN
	eCode 		= "61757"
Else
	eCode 		= "60932"
End If

If userid="winnie" Or userid="gawisonten10" Or userid ="greenteenz" Or userid = "edojun" Or userid = "baboytw" Or userid = "tozzinet" Or userid = "motions" Then

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
<p>&nbsp;</p>
<table style="margin:0 auto;text-align:center;">
	<tr><td><strong><font color="red">마지막날 메가박스 999개(이유 : 22일 1개 오바됨)</font><br></strong></td></tr>
</table>


<table style="margin:0 auto;text-align:center;">
	<tr><td><strong><font size="3">2015-04-21(화) 셋콤달콤-메가박스</font><br></strong></td></tr>
	<tr><td><strong><font size="3">현재 확율- 메가박스:50 , 팝콘:50, 토이스토리:3, lgbeam:0.1</font><br></strong></td></tr>
</table>
<br>
<table class="table" style="width:90%;">
	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>총 응모건수</strong></th>
		<th><strong>메가박스 (최대 1000)</strong></th>
		<th><strong>팝콘당첨자 (최대 1699)</strong></th>
		<th><strong>토이스토리 당첨자 (최대 300)</strong></th>
		<th><strong>lgbeam 당첨자 (최대 1)</strong></th>
		<th><strong>앱전면배너클릭</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">29726</td>
		<td bgcolor="">46518</td>
		<td bgcolor="">1000</td>
		<td bgcolor="">1699</td>
		<td bgcolor="">300</td>
		<td bgcolor="">1</td>
		<td bgcolor="">25239</td>
	</tr>
</table>
<br>
<table style="margin:0 auto;text-align:center;">
	<tr><td><strong><font size="3">2015-04-22(수) 셋콤달콤-메가박스</font><br></strong></td></tr>
	<tr><td><strong><font size="3">현재 확율- 메가박스:1 , 팝콘:20, 토이스토리:3, lgbeam:0.1</font><br></strong></td></tr>
</table>
<br>
<table class="table" style="width:90%;">
	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>총 응모건수</strong></th>
		<th><strong>메가박스 (최대 1001)</strong></th>
		<th><strong>팝콘당첨자 (최대 1699)</strong></th>
		<th><strong>토이스토리 당첨자 (최대 300)</strong></th>
		<th><strong>lgbeam 당첨자 (최대 1)</strong></th>
		<th><strong>앱전면배너클릭</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">21479</td>
		<td bgcolor="">36112</td>
		<td bgcolor="">1001</td>
		<td bgcolor="">1699</td>
		<td bgcolor="">300</td>
		<td bgcolor="">1</td>
		<td bgcolor="">24426</td>
	</tr>
</table>
<br>
<table style="margin:0 auto;text-align:center;">
	<tr><td><strong><font size="3">2015-04-23(목) 셋콤달콤-메가박스</font><br></strong></td></tr>
	<tr><td><strong><font size="3">현재 확율- 메가박스:1 , 팝콘:20, 토이스토리:3, lgbeam:0.1</font><br></strong></td></tr>
</table>
<br>
<table class="table" style="width:90%;">
	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>총 응모건수</strong></th>
		<th><strong>메가박스 (최대 1000)</strong></th>
		<th><strong>팝콘당첨자 (최대 1699)</strong></th>
		<th><strong>토이스토리 당첨자 (최대 300)</strong></th>
		<th><strong>lgbeam 당첨자 (최대 1)</strong></th>
		<th><strong>앱전면배너클릭</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">21315</td>
		<td bgcolor="">36108</td>
		<td bgcolor="">1000</td>
		<td bgcolor="">1699</td>
		<td bgcolor="">300</td>
		<td bgcolor="">1</td>
		<td bgcolor="">24933</td>
	</tr>
</table>
<br>
<%
	''총 응모자 수
	sqlstr = "select count(sub_idx) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='2015-04-24'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		cnt = rsget(0)
	End IF
	rsget.close

	''총 응모건수
	sqlstr = "select sum( convert(integer, sub_opt1)  ) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript "
	sqlstr = sqlstr & " where evt_code='60932' and convert(varchar(10),regdate,120) ='2015-04-24' "
	rsget.Open sqlstr, dbget, 1
	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	''앱 전면배너 클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from [db_temp].[dbo].[tbl_event_click_log] "
	sqlstr = sqlstr & " where eventid='60932' and regdate > '2015-04-24' and regdate < '2015-04-25' "
	rsget.Open sqlstr, dbget, 1
	If Not rsget.Eof Then
		appbannerclick = rsget(0)
	End IF
	rsget.close

	''상품별 당첨자 수
	sqlStr = "	select " &_
			 "		count(case when gubun=1 then gubun end) as set1 " &_
			 "		, count(case when gubun=2 then gubun end) as set2 " &_
			 "		, count(case when gubun=3 then gubun end) as set3 " &_
			 "		, count(case when gubun=4 then gubun end) as set4  " &_
			 "	from db_temp.dbo.tbl_3comdalcom_coupon_2015_megabox " &_
			 "	where userid <> '' and convert(varchar(10),regdate,120) ='2015-04-24' "
	rsget.Open sqlstr, dbget, 1
	'Response.write sqlStr
	If Not rsget.Eof Then
		set1 = rsget(0)
		set2 = rsget(1)
		set3 = rsget(2)
		set4 = rsget(3)
	End IF
	rsget.close
%>

<table style="margin:0 auto;text-align:center;">
	<tr><td><strong><font color="blue" size="5">2015-04-24(금) 셋콤달콤-메가박스</font><br></strong></td></tr>
	<tr><td><strong><font size="3">현재 확율- 메가박스:10 , 팝콘:70, 토이스토리:3, lgbeam:0.1</font><br></strong></td></tr>
</table>
<br>
<table class="table" style="width:90%;">
	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>총 응모건수</strong></th>
		<th><strong>메가박스 (최대 999)</strong></th>
		<th><strong>팝콘당첨자 (최대 1699)</strong></th>
		<th><strong>토이스토리 당첨자 (최대 300)</strong></th>
		<th><strong>lgbeam 당첨자 (최대 1)</strong></th>
		<th><strong>앱전면배너클릭</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= cnt %></td>
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= set1 %></td>
		<td bgcolor=""><%= set2 %></td>
		<td bgcolor=""><%= set3 %></td>
		<td bgcolor=""><%= set4 %></td>
		<td bgcolor=""><%= appbannerclick %></td>
	</tr>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->