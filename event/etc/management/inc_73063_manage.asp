<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 15주년 이벤트 워킹맨
' History : 2016-10-10 원승현
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	dim snscnt1, snscnt2, totalokcnt, i
	Dim mainbannercnt, totalcnt, getitemgocnt
	Dim wincnt1, wincnt2, wincnt3, wincnt4, wincnt5, wincnt6, wincnt7, wincnt8, wincnt9, wincnt10, wincnt11, wincnt12, wincnt13, wincnt14, wincnt15, wincnt16
	Dim wincnt17, wincnt18, wincnt19, wincnt20, wincnt21, wincnt22, wincnt23, wincnt24, wincnt25, wincnt26, wincnt27, wincnt28, wincnt29, wincnt30, wincnt31, wincnt32, wincnt33, wincnt34, wincnt35
	Dim wincnt36, wincnt37, wincnt38, wincnt39, wincnt40, wincnt41, wincnt42, wincnt43, wincnt44
	Dim eCode, userid, sqlStr
	Dim returndate  : returndate = 	request("returndate")
	Dim contect1day, contect2day, contect3day, contect4day, contect5day, contect6day, contect7day, contect8day, contect9day, contect10day, contect11day, contect12day, contect13day, contect14day, contect15day

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode 		= "66215"
	Else
		eCode 		= "73063"
	End If

If userid="baboytw" Or userid="greenteenz" Or userid= "helele223" Or userid="cogusdk" Or userid="jjh" Or userid="thensi7" Then

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
	''총 응모인원
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	''1일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='nomal1' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect1day = rsget(0)
	End IF
	rsget.close

	''2일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='nomal2' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect2day = rsget(0)
	End IF
	rsget.close

	''3일차 응모인원(마일리지)
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='mileage1' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect3day = rsget(0)
	End IF
	rsget.close

	''4일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='nomal4' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect4day = rsget(0)
	End IF
	rsget.close

	''5일차 응모인원(경품응모)
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='gift1' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect5day = rsget(0)
	End IF
	rsget.close

	''6일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='nomal6' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect6day = rsget(0)
	End IF
	rsget.close
	
	''7일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='nomal7' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect7day = rsget(0)
	End IF
	rsget.close

	''8일차 응모인원(cgv)
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='cgv' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect8day = rsget(0)
	End IF
	rsget.close

	''9일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='nomal9' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect9day = rsget(0)
	End IF
	rsget.close

	''10일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='nomal10' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect10day = rsget(0)
	End IF
	rsget.close

	''11일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='mileage2' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect11day = rsget(0)
	End IF
	rsget.close

	''12일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='nomal12' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect12day = rsget(0)
	End IF
	rsget.close

	''13일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='gift2' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect13day = rsget(0)
	End IF
	rsget.close

	''14일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"'  and sub_opt1='nomal14' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect14day = rsget(0)
	End IF
	rsget.close

	''15일차 응모인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='mileage3' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		contect15day = rsget(0)
	End IF
	rsget.close

	''경품응모첫번째 당첨인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='gift1' And sub_opt3='true' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt1 = rsget(0)
	End IF
	rsget.close

	''cgv 당첨인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='cgv' And sub_opt3='true' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt2 = rsget(0)
	End IF
	rsget.close

	''경품응모두번째 당첨인원
	sqlstr = "select count(*) as okcnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt1='gift2' And sub_opt3='true' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt3 = rsget(0)
	End IF
	rsget.close


%>
<table class="table" style="width:100%;">
	<tr align="center">
		<th colspan="2"><strong>15주년 워킹맨</strong></th>
	</tr>
	<tr>
		<td colspan="2" align="center"><font size="5">총 응모자 : <%=totalcnt%>명</font></td>
	</tr>
	<tr>
		<td>
			<table class="table" style="width:50%;">
				<colgroup>
					<col width="50%" />
					<col width="*" />
				</colgroup>
				<tr>
					<td colspan="5" align="center"><strong>일자별 응모 데이터</strong></td>
				</tr>

				<tr align="center" bgcolor="#E6E6E6">
					<th><strong>날짜</strong></th>
					<th><strong>응모자</strong></th>
				</tr>
				<%
					sqlstr = " Select * From  "
					sqlstr = sqlstr & " ( "
					sqlstr = sqlstr & " 	Select convert(varchar(10), regdate, 120) as regdate, count(userid) as cnt "
					sqlstr = sqlstr & " 	From db_event.dbo.tbl_event_subscript Where evt_code=73063 "
					sqlstr = sqlstr & " 	group by convert(varchar(10), regdate, 120) "
					sqlstr = sqlstr & " )AA order by regdate "
					rsget.Open sqlstr, dbget, 1
					If Not(rsget.bof Or rsget.eof) Then
						Do Until rsget.eof
				%>
							<tr bgcolor="#FFFFFF" align="center">
								<td bgcolor=""><%=rsget("regdate")%></td>
								<td bgcolor=""><%=rsget("cnt")%></td>
							</tr>
				<%
						rsget.movenext
						Loop
					End If
					rsget.close
				%>
			</table>
		</td>
		<td>
			<table class="table" style="width:60%;">
				<colgroup>
					<col width="10%" />
					<col width="*" />
					<col width="*" />
					<col width="10%" />
				</colgroup>
				<tr>
					<td colspan="5" align="center"><strong>출석 데이터</strong></td>
				</tr>

				<tr align="center" bgcolor="#E6E6E6">
					<th><strong>출석일차</strong></th>
					<th><strong>응모자수</strong></th>
					<th><strong>비고</strong></th>
					<th><strong>당첨인원수</strong></th>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">1일차</td>
					<td bgcolor=""><%= contect1day %></td>
					<td bgcolor="">얼럿</td>
					<td bgcolor="">X</td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">2일차</td>
					<td bgcolor=""><%= contect2day %></td>
					<td bgcolor="">얼럿</td>
					<td bgcolor="">X</td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">3일차</td>
					<td bgcolor=""><%= contect3day %></td>
					<td bgcolor="">마일리지100</td>
					<td bgcolor="">X</td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">4일차</td>
					<td bgcolor=""><%= contect4day %></td>
					<td bgcolor="">얼럿</td>
					<td bgcolor="">X</td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">5일차</td>
					<td bgcolor=""><%= contect5day %></td>
					<td bgcolor="">경품응모첫번째</td>
					<td bgcolor=""><%=wincnt1%></td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">6일차</td>
					<td bgcolor=""><%= contect6day %></td>
					<td bgcolor="">얼럿</td>
					<td bgcolor="">X</td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">7일차</td>
					<td bgcolor=""><%= contect7day %></td>
					<td bgcolor="">얼럿</td>
					<td bgcolor="">X</td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">8일차</td>
					<td bgcolor=""><%= contect8day %></td>
					<td bgcolor="">cgv이용권</td>
					<td bgcolor=""><%=wincnt2%></td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">9일차</td>
					<td bgcolor=""><%= contect9day %></td>
					<td bgcolor="">얼럿</td>
					<td bgcolor="">X</td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">10일차</td>
					<td bgcolor=""><%= contect10day %></td>
					<td bgcolor="">얼럿</td>
					<td bgcolor="">X</td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">11일차</td>
					<td bgcolor=""><%= contect11day %></td>
					<td bgcolor="">마일리지100</td>
					<td bgcolor="">X</td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">12일차</td>
					<td bgcolor=""><%= contect12day %></td>
					<td bgcolor="">얼럿</td>
					<td bgcolor="">X</td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">13일차</td>
					<td bgcolor=""><%= contect13day %></td>
					<td bgcolor="">경품응모두번째</td>
					<td bgcolor=""><%=wincnt3%></td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">14일차</td>
					<td bgcolor=""><%= contect14day %></td>
					<td bgcolor="">얼럿</td>
					<td bgcolor="">X</td>
				</tr>
				<tr bgcolor="#FFFFFF" align="center">
					<td bgcolor="">15일차</td>
					<td bgcolor=""><%= contect15day %></td>
					<td bgcolor="">마일리지500</td>
					<td bgcolor="">X</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<!-- #include virtual="/lib/db/dbclose.asp" -->