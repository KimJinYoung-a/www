<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 매일매일 자란다 - 출석체크
' History : 2015-10-08 이종화 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
Dim userid : userid = getloginuserid()
Dim prize1 : prize1 = 0
Dim prize2 : prize2 = 0 
Dim prize3 : prize3 = 0 
Dim prize4 : prize4 = 0 
Dim prize5 : prize5 = 0 
Dim prize6 : prize6 = 0
Dim win2 , win4 , win6 , eCode , strSql

	If userid = "motions" Or userid = "stella0117" Or userid = "bborami" Or userid = "greenteenz" Then
	Else
		response.write "<script>alert('관계자만 볼 수 있는 페이지 입니다.');window.close();</script>"
		response.End
	End If

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  64908
	Else
		eCode   =  66520
	End If

	If userid = "motions" Or userid = "stella0117" Or userid = "bborami" Or userid = "greenteenz" Then
		strSql = " select "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 1 then 1 else 0 end),0) as prize1 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 2 then 1 else 0 end),0) as prize2 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 3 then 1 else 0 end),0) as prize3 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 4 then 1 else 0 end),0) as prize4 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 5 then 1 else 0 end),0) as prize5 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 6 then 1 else 0 end),0) as prize6  "
		strSql = strSql & "	from db_temp.dbo.tbl_event_66520 "
		strSql = strSql & "	where evt_code = '" & eCode & "' "
		rsget.CursorLocation = adUseClient
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
		'Response.write strSql
		IF Not rsget.Eof Then
			prize1	= rsget("prize1")	'// 2일차 응모 - 마일리지 200point - 전원지급
			prize2	= rsget("prize2")	'//	5일차 응모 - 새싹키우기(랜덤) - 200명 - 5%
			prize3	= rsget("prize3")	'//	8일차 응모 - 마일리지 300point - 전원지급
			prize4	= rsget("prize4")	'//	11일차 응모 - 포그링 가습기(랜덤) - 100명 - 5%
			prize5	= rsget("prize5")	'//	14일차 응모 - 마일리지 500point -  전원지급
			prize6	= rsget("prize6")	'//	17일차 응모 - 샤오미 공기청정기 50명 - 1%
		End IF
		rsget.close()

		strSql = " select "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 2 then 1 else 0 end),0) as win2 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 4 then 1 else 0 end),0) as win4 , "
		strSql = strSql & "	isnull(sum(case when sub_opt1 = 6 then 1 else 0 end),0) as win6  "
		strSql = strSql & "	from db_temp.dbo.tbl_event_66520 "
		strSql = strSql & "	where evt_code = '" & eCode & "' and sub_opt2 = 1 "
		rsget.CursorLocation = adUseClient
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
		'Response.write strSql
		IF Not rsget.Eof Then
			win2	= rsget("win2")		'// 전체당첨수
			win4	= rsget("win4")		'// 전체당첨수
			win6	= rsget("win6")		'// 전체당첨수
		End IF
		rsget.close()
	End If

%>
<% If userid = "motions" Or userid = "stella0117" Or userid = "bborami" Or userid = "greenteenz" Then %>
<style type="text/css">
.table {width:900px; margin:0 auto; font-family:'malgun gothic'; border-collapse:collapse;}
.table th {padding:12px 0; font-size:13px; font-weight:bold;  color:#fff; background:#444;}
.table td {padding:12px 3px; font-size:12px; border:1px solid #ddd; border-bottom:2px solid #ddd;}
.table td.lt {text-align:left; padding:12px 10px;}
.tBtn {display:inline-block; border:1px solid #2b90b6; background:#03a0db; padding:0 10px 2px; line-height:26px; height:26px; font-weight:bold; border-radius:5px; color:#fff !important;}
.tBtn:hover {text-decoration:none;}
.table td input {border:1px solid #ddd; height:30px; padding:0 3px; font-size:14px; color:#ec0d02; text-align:right;}
.lt { float:left;}
div .lt:nth-child(odd) { float:left; padding-top:10px;}
.lr { float:left; clear:both:}
</style>
<table class="table" style="width:90%;">
<tr>
	<td>
		※10/12일 오전 11시10분 기준 출석 응모 부분 -  W M A 구분 추가</br>
		※10/12일 오후 5시 마일리지 합계 추가<br/>
		※10/14일 오전 9시 상품 당첨 확률 5->1% 낮춤<br/>
		※10/16일 오후 1시50분 상품 당첨 확률 1->3% 올림<br/>
		※10/16일 오후 3시50분 상품 당첨 확률 3->5% 올림<br/>
		※10/19일 오전 9시50분 새싹 키우기 상품 당첨 확률 5->15% 올림<br/>
		※10/26일 오전 10시55분 샤오미 공기청정기 상품 당첨 확률 0.5->35% 올림
	</td>
</tr>
</table>

<table class="table" style="width:90%;">
	<colgroup>
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>10/10</strong></th>
		<th><strong>10/11</strong></th>
		<th><strong>10/12</strong></th>
		<th><strong>10/13</strong></th>
		<th><strong>10/14</strong></th>
		<th><strong>10/15</strong></th>
		<th><strong>10/16</strong></th>
		<th><strong>10/17</strong></th>
		<th><strong>10/18</strong></th>
		<th><strong>10/19</strong></th>
		<th><strong>10/20</strong></th>
		<th><strong>10/21</strong></th>
		<th><strong>10/22</strong></th>
		<th><strong>10/23</strong></th>
		<th><strong>10/24</strong></th>
		<th><strong>10/25</strong></th>
		<th><strong>10/26</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<%
			strSql = "select "
			strSql = strSql & " convert(varchar(10),t.regdate,120) "
			strSql = strSql & " , count(*) as totcnt "
			strSql = strSql & " , isnull(sum(case when device = 'W' then 1 else 0 end),0) as totW "
			strSql = strSql & " , isnull(sum(case when device = 'M' then 1 else 0 end),0) as totM "
			strSql = strSql & " , isnull(sum(case when device = 'A' then 1 else 0 end),0) as totA "
			strSql = strSql & " from db_temp.[dbo].[tbl_event_attendance] as t "
			strSql = strSql & " inner join db_event.dbo.tbl_event as e "
			strSql = strSql & " on t.evt_code = e.evt_code and convert(varchar(10),t.regdate,120) between convert(varchar(10),e.evt_startdate,120) and convert(varchar(10),e.evt_enddate,120) "
			strSql = strSql & "	where t.evt_code = '"& eCode &"' " 
			strSql = strSql & "	group by convert(varchar(10),t.regdate,120) " 
			strSql = strSql & "	order by convert(varchar(10),t.regdate,120) asc " 
			'Response.write strSql
			rsget.CursorLocation = adUseClient
			rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
			If Not rsget.Eof Then
				Do Until rsget.eof
		%>
		<td bgcolor="" align="left">총:<%= rsget("totcnt") %><br/><br/>W:<%=rsget("totW")%><br/>M:<%=rsget("totM")%><br/>A:<%=rsget("totA")%></td>
		<%
				rsget.movenext
				Loop
			End IF
			rsget.close
		%>
	</tr>
	<tr>
		<td colspan="2" style="text-align:right;"><div class="lt">마일 200pt</div> <div class="rt"><div>응:<%=FormatNumber(prize1,0)%></div></br><div>합:<%=FormatNumber(prize1*200,0)%></div></td>
		<td colspan="3" style="text-align:right;"><div class="lt">새싹 키우기 (200명)</div> <div class="rt"><div>응:<%=FormatNumber(prize2,0)%></div></br><div>당:<%=FormatNumber(win2,0)%></div></div></td>
		<td colspan="3" style="text-align:right;"><div class="lt">마일 300pt</div> <div class="rt">응:<%=FormatNumber(prize3,0)%></div></br><div>합:<%=FormatNumber(prize3*300,0)%></div></td>
		<td colspan="3" style="text-align:right;"><div class="lt">포그링 가습기 (100명)</div> <div class="rt"><div>응:<%=FormatNumber(prize4,0)%></div></br><div>당:<%=FormatNumber(win4,0)%></div></div></td>
		<td colspan="3" style="text-align:right;"><div class="lt">마일 500pt</div> <div class="rt">응:<%=FormatNumber(prize5,0)%></div></br><div>합:<%=FormatNumber(prize5*500,0)%></div></td>
		<td colspan="3" style="text-align:right;"><div class="lt">샤오미 공기청정기 (10명)</div> <div class="rt"><div>응:<%=FormatNumber(prize6,0)%></div></br><div>당:<%=FormatNumber(win6,0)%></div></div></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>누적<br/>1회</strong></th>
		<th><strong>누적<br/>2회</strong></th>
		<th><strong>누적<br/>3회</strong></th>
		<th><strong>누적<br/>4회</strong></th>
		<th><strong>누적<br/>5회</strong></th>
		<th><strong>누적<br/>6회</strong></th>
		<th><strong>누적<br/>7회</strong></th>
		<th><strong>누적<br/>8회</strong></th>
		<th><strong>누적<br/>9회</strong></th>
		<th><strong>누적<br/>10회</strong></th>
		<th><strong>누적<br/>11회</strong></th>
		<th><strong>누적<br/>12회</strong></th>
		<th><strong>누적<br/>13회</strong></th>
		<th><strong>누적<br/>14회</strong></th>
		<th><strong>누적<br/>15회</strong></th>
		<th><strong>누적<br/>16회</strong></th>
		<th><strong>누적<br/>17회</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF">
	<%
		strSql = " WITH A AS "
		strSql = strSql & " ( "
		strSql = strSql & " SELECT 1 seq, count(t.userid) as totcnt from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"'	group by userid having count(*) = 1 ) as t "
		strSql = strSql & " UNION ALL SELECT 2,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 2 ) as t "
		strSql = strSql & " UNION ALL SELECT 3,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 3 ) as t "
		strSql = strSql & " UNION ALL SELECT 4,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 4 ) as t "
		strSql = strSql & " UNION ALL SELECT 5,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 5 ) as t "
		strSql = strSql & " UNION ALL SELECT 6,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 6 ) as t "
		strSql = strSql & " UNION ALL SELECT 7,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 7 ) as t "
		strSql = strSql & " UNION ALL SELECT 8,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 8 ) as t "
		strSql = strSql & " UNION ALL SELECT 9,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 9 ) as t "
		strSql = strSql & " UNION ALL SELECT 10,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 10 ) as t "
		strSql = strSql & " UNION ALL SELECT 11,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 11 ) as t "
		strSql = strSql & " UNION ALL SELECT 12,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 12 ) as t "
		strSql = strSql & " UNION ALL SELECT 13,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 13 ) as t "
		strSql = strSql & " UNION ALL SELECT 14,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 14 ) as t "
		strSql = strSql & " UNION ALL SELECT 15,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 15 ) as t "
		strSql = strSql & " UNION ALL SELECT 16,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 16 ) as t "
		strSql = strSql & " UNION ALL SELECT 17,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) = 17 ) as t "
		strSql = strSql & " ) "
		strSql = strSql & " SELECT * FROM A "
		'Response.write strSql
		rsget.CursorLocation = adUseClient
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
		If Not rsget.Eof Then
			Do Until rsget.eof
	%>
	<td bgcolor="" style="text-align:center">참여<br/><%= rsget("totcnt") %></td>
	<%
			rsget.movenext
			Loop
		End IF
		rsget.close
	%>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>누적<br/>1회이상</strong></th>
		<th><strong>누적<br/>2회이상</strong></th>
		<th><strong>누적<br/>3회이상</strong></th>
		<th><strong>누적<br/>4회이상</strong></th>
		<th><strong>누적<br/>5회이상</strong></th>
		<th><strong>누적<br/>6회이상</strong></th>
		<th><strong>누적<br/>7회이상</strong></th>
		<th><strong>누적<br/>8회이상</strong></th>
		<th><strong>누적<br/>9회이상</strong></th>
		<th><strong>누적<br/>10회이상</strong></th>
		<th><strong>누적<br/>11회이상</strong></th>
		<th><strong>누적<br/>12회이상</strong></th>
		<th><strong>누적<br/>13회이상</strong></th>
		<th><strong>누적<br/>14회이상</strong></th>
		<th><strong>누적<br/>15회이상</strong></th>
		<th><strong>누적<br/>16회이상</strong></th>
		<th><strong>누적<br/>17회</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF">
	<%
		strSql = " WITH A AS "
		strSql = strSql & " ( "
		strSql = strSql & " SELECT 1 seq, count(t.userid) as totcnt from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"'	group by userid having count(*) >= 1 ) as t "
		strSql = strSql & " UNION ALL SELECT 2,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 2 ) as t "
		strSql = strSql & " UNION ALL SELECT 3,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 3 ) as t "
		strSql = strSql & " UNION ALL SELECT 4,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 4 ) as t "
		strSql = strSql & " UNION ALL SELECT 5,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 5 ) as t "
		strSql = strSql & " UNION ALL SELECT 6,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 6 ) as t "
		strSql = strSql & " UNION ALL SELECT 7,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 7 ) as t "
		strSql = strSql & " UNION ALL SELECT 8,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 8 ) as t "
		strSql = strSql & " UNION ALL SELECT 9,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 9 ) as t "
		strSql = strSql & " UNION ALL SELECT 10,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 10 ) as t "
		strSql = strSql & " UNION ALL SELECT 11,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 11 ) as t "
		strSql = strSql & " UNION ALL SELECT 12,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 12 ) as t "
		strSql = strSql & " UNION ALL SELECT 13,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 13 ) as t "
		strSql = strSql & " UNION ALL SELECT 14,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 14 ) as t "
		strSql = strSql & " UNION ALL SELECT 15,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 15 ) as t "
		strSql = strSql & " UNION ALL SELECT 16,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 16 ) as t "
		strSql = strSql & " UNION ALL SELECT 17,  count(t.userid) from ( select userid from db_temp.dbo.tbl_event_attendance where evt_code = '"& eCode &"' group by userid having count(*) >= 17 ) as t "
		strSql = strSql & " ) "
		strSql = strSql & " SELECT * FROM A "
		'Response.write strSql
		rsget.CursorLocation = adUseClient
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
		If Not rsget.Eof Then
			Do Until rsget.eof
	%>
	<td bgcolor="" style="text-align:center">참여<br/><%= rsget("totcnt") %></td>
	<%
			rsget.movenext
			Loop
		End IF
		rsget.close
	%>
	</tr>
</table>
<% End If %>
<!-- #include virtual="/lib/db/dbclose.asp" -->