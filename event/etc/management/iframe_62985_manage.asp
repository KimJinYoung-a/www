<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 티켓킹
' History : 2015-06-01 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim mainbannercnt
Dim set1,set2,set3,set4
Dim eCode, subscriptcount, userid, evtTotalCnt, sqlStr, cnt, totalcnt, appbannerclick, ipaduserid, secproductuserid, thrproductuserid, forproductuserid, nowdate
Dim dayname, pdname1, evtitemcode1, evtItemCnt1, dayrightnumber, pdname2, evtitemcode2, evtitemcnt2, pdname3, evtitemcode3, evtitemcnt3, pdname4, evtitemcode4, evtitemcnt4, ipadcnt, evtitemcnt5

	userid=getloginuserid()


	nowdate = now()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  63772
	Else
		eCode   =  62985
	End If

If userid="thensi7" Or userid="bborami" Or userid="baboytw" Or userid="greenteenz" Or userid="cogusdk" Then

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
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	'// 2등
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt2='2222222' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		ipaduserid = rsget(0)
	End IF
	rsget.close

	'// 3등
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt2='3333333' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		ipadcnt = rsget(0)
	End IF
	rsget.close

	'// 4등
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt2='4444444' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		secproductuserid = rsget(0)
	End IF
	rsget.close

	'// 기프트카드
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt2='5555555' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		thrproductuserid = rsget(0)
	End IF
	rsget.close

	'// 쿠폰 당첨자 수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt2='0' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		forproductuserid = rsget(0)
	End IF
	rsget.close

	'// 메인배너 클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from [db_temp].[dbo].[tbl_event_click_log]"
	sqlstr = sqlstr & " where eventid='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		mainbannercnt = rsget(0)
	End IF
	rsget.close


	evtItemCnt2 = 2
	evtItemCnt3 = 1000
	evtItemCnt4 = 1998
	evtItemCnt5 = 10

%>
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
	<tr>
		<Td colspan="2">기준일 : <%=Left(nowdate, 10)%></td>
			<td colspan="10"><font color="RED" size="4">확률 2등 0.01%, 3등 70%, 4등 25%, 기프트카드 0.5%</font></td>
	
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>2등</strong></th>
		<th><strong>3등</strong></th>
		<th><strong>4등</strong></th>
		<th><strong>기프트카드</strong></th>
		<th><strong>쿠폰 당첨자수(무제한)</strong></th>
		<th><strong>APP메인배너클릭수</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= ipaduserid %><br><font color="RED">(남은수량 : <%= evtItemCnt2-ipaduserid %> )</font></td>
		<td bgcolor=""><%= ipadcnt %><br><font color="RED">(남은수량 : <%= evtItemCnt3-ipadcnt %> )</font></td>
		<td bgcolor=""><%= secproductuserid %><br><font color="RED">(남은수량 : <%= evtItemCnt4-secproductuserid %> )</font></td>
		<td bgcolor=""><%= thrproductuserid %><br><font color="RED">(남은수량 : <%= evtItemCnt5-thrproductuserid %> )</font></td>
		<td bgcolor=""><%= forproductuserid %></td>
		<td bgcolor=""><%= mainbannercnt %></td>
	</tr>
</table>
<br><br><br>
<table class="table" style="width:90%;">

	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>

	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>구분</strong></th>
		<th><strong>2등상품</strong></th>
		<th><strong>3등상품</strong></th>
		<th><strong>4등상품</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">월</td>
		<td bgcolor="">2</td>
		<td bgcolor="">495</td>
		<td bgcolor="">2503</td>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">화</td>
		<td bgcolor="">2</td>
		<td bgcolor="">700</td>
		<td bgcolor="">2297</td>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">수</td>
		<td bgcolor="">2</td>
		<td bgcolor="">745</td>
		<td bgcolor="">2253</td>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">목</td>
		<td bgcolor="">2</td>
		<td bgcolor="">295</td>
		<td bgcolor="">2703</td>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="">금</td>
		<td bgcolor="">2</td>
		<td bgcolor="">1000</td>
		<td bgcolor="">1998</td>
	</tr>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->