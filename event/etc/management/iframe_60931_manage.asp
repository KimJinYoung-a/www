<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 60931 셋콤달콤-요기요
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
	eCode 		= "60748"
Else
	eCode 		= "60931"
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
	<tr><td><strong><font size="5">2015-04-17(금) 셋콤달콤-요기요</font><br></strong></td></tr>
	<tr><td><strong><font size="3">현재 확율- 요기요:20 , 바나나:5, 몬스터감귤:15, 아이패드:0.2</font><br></strong></td></tr>
	<tr><td><strong><font color="red"> * 특이사항 : 17일 요기요 쿠폰 750장 추가(총2000) -> 20일 요기요쿠폰 750장 제외(총500)<font></strong></td></tr>
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
		<th><strong>요기요 (최대 2000)</strong></th>
		<th><strong>바나나당첨자 (최대1639)</strong></th>
		<th><strong>몬스터감귤 당첨자 (최대 375)</strong></th>
		<th><strong>아이패드 당첨자 (최대 1)</strong></th>
		<th><strong>앱전면배너클릭</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">28934</td>
		<td bgcolor="">41633</td>
		<td bgcolor="">2000</td>
		<td bgcolor="">1639</td>
		<td bgcolor="">375</td>
		<td bgcolor="">1</td>
		<td bgcolor="">24398</td>
	</tr>
</table>
<br>
<table style="margin:0 auto;text-align:center;">
	<tr><td><strong><font size="5">2015-04-18(토) 셋콤달콤-요기요</font><br></strong></td></tr>
	<tr><td><strong><font size="3">현재 확율- 요기요:10 , 바나나:10, 몬스터감귤:15, 아이패드:0.2</fonr><br></strong></td></tr>
<!--	<tr><td><strong><font color="red"> * 특이사항 : 17일 요기요 쿠폰 750장 추가(총2000) -> 20일 요기요쿠폰 750장 제외(총500)<font></strong></td></tr>-->
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
		<th><strong>요기요 (최대 1421)</strong></th>
		<th><strong>바나나당첨자 (최대 1424)</strong></th>
		<th><strong>몬스터감귤 당첨자 (최대 375)</strong></th>
		<th><strong>아이패드 당첨자 (최대 1)</strong></th>
		<th><strong>앱전면배너클릭</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">10394</td>
		<td bgcolor="">17281</td>
		<td bgcolor="">1421</td>
		<td bgcolor="">1424</td>
		<td bgcolor="">375</td>
		<td bgcolor="">1</td>
		<td bgcolor="">13729</td>
	</tr>
</table>
<br>
<table style="margin:0 auto;text-align:center;">
	<tr><td><strong><font size="5">2015-04-19(일) 셋콤달콤-요기요</font><br></strong></td></tr>
	<tr><td><strong><font size="3">현재 확율- 요기요:10 , 바나나:10, 몬스터감귤:15, 아이패드:0.2</font><br></strong></td></tr>
<!--	<tr><td><strong><font color="red"> * 특이사항 : 17일 요기요 쿠폰 750장 추가(총2000) -> 20일 요기요쿠폰 750장 제외(총500)<font></strong></td></tr>-->
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
		<th><strong>요기요 (최대 1079)</strong></th>
		<th><strong>바나나당첨자 (최대 1854)</strong></th>
		<th><strong>몬스터감귤 당첨자 (최대 375)</strong></th>
		<th><strong>아이패드 당첨자 (최대 1)</strong></th>
		<th><strong>앱전면배너클릭</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">15400</td>
		<td bgcolor="">25878</td>
		<td bgcolor="">1079</td>
		<td bgcolor="">1854</td>
		<td bgcolor="">375</td>
		<td bgcolor="">1</td>
		<td bgcolor="">21600</td>
	</tr>
</table>
<br>
<%
	''2015-04-19
	''총 응모자 수
	sqlstr = "select count(sub_idx) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='2015-04-20'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		cnt = rsget(0)
	End IF
	rsget.close

	''총 응모건수
	sqlstr = "select sum( convert(integer, sub_opt1)  ) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript "
	sqlstr = sqlstr & " where evt_code='60931' and convert(varchar(10),regdate,120) ='2015-04-20' "
	rsget.Open sqlstr, dbget, 1
	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	''앱 전면배너 클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from [db_temp].[dbo].[tbl_event_click_log] "
	sqlstr = sqlstr & " where eventid='60931' and regdate > '2015-04-20' and regdate < '2015-04-21' "
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
			 "	from db_temp.dbo.tbl_3comdalcom_coupon_2015_yogiyo " &_
			 "	where userid <> '' and convert(varchar(10),regdate,120) ='2015-04-20' "
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
	<tr><td><strong><font size="5">2015-04-20(월) 셋콤달콤-요기요</font><br></strong></td></tr>
	<tr><td><strong><font size="3">현재 확율- 요기요:5 , 바나나:20, 몬스터감귤:5, 아이패드:0.1</font><br></strong></td></tr>
<!--	<tr><td><strong><font color="red"> * 특이사항 : 17일 요기요 쿠폰 750장 추가(총2000) -> 20일 요기요쿠폰 750장 제외(총500)<font></strong></td></tr>-->
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
		<th><strong>요기요 (최대 500)</strong></th>
		<th><strong>바나나당첨자 (최대 1374,실제579)</strong></th>
		<th><strong>몬스터감귤 당첨자 (최대 375)</strong></th>
		<th><strong>아이패드 당첨자 (최대 1)</strong></th>
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