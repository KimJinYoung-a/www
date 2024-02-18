<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 62086 디스전 이벤트
' History : 2015-05-14 원승현
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim set1,set2,set3,set4
Dim eCode, subscriptcount, userid, evtTotalCnt, sqlStr, cnt, totalcnt, appbannerclick, ipaduserid, secproductuserid, thrproductuserid, forproductuserid, nowdate, receive_cnt, banner_cnt
Dim dayname, pdname1, evtitemcode1, evtItemCnt1, dayrightnumber, pdname2, evtitemcode2, evtitemcnt2, pdname3, evtitemcode3, evtitemcnt3, pdname4, evtitemcode4, evtitemcnt4, ipadcnt, i, invite_cnt

	userid=getloginuserid()


	nowdate = request("nd")


	If nowdate="" Then
		nowdate = now()
	End If


	i = 1


If userid="winnie" Or userid="gawisonten10" Or userid ="greenteenz" Or userid = "edojun" Or userid = "baboytw" Or userid = "tozzinet" Or userid = "motions" Or userid="thensi7" Or userid="helele223" Then

Else
	response.write "<script>alert('관계자만 볼 수 있는 페이지 입니다.');window.close();</script>"
	response.End
End If

	'// 초대자 수
	sqlstr = "	Select count(*) "
	sqlstr = sqlstr & " 	From db_event.dbo.tbl_event_subscript e "
	sqlstr = sqlstr & " 	Where e.evt_code=62086 and convert(varchar(10), e.regdate, 120) = '"&Left(nowdate,10)&"' "
	rsget.Open sqlstr, dbget, 1

		invite_cnt = rsget(0)

	rsget.close

	'// 인증 수
	sqlstr = "	Select count(*) "
	sqlstr = sqlstr & " 	From db_temp.dbo.tbl_disEvent "
	sqlstr = sqlstr & " 	Where evt_code=62086 and convert(varchar(10), receivedate, 120) = '"&Left(nowdate,10)&"' "
	rsget.Open sqlstr, dbget, 1

		receive_cnt = rsget(0)

	rsget.close

	'// 전면배너 클릭 수
	sqlstr = "	Select count(*) "
	sqlstr = sqlstr & " 	From [db_temp].[dbo].[tbl_event_click_log] "
	sqlstr = sqlstr & " 	Where eventid=62086 And convert(varchar(10), regdate, 120) = '"&Left(nowdate,10)&"' "
	rsget.Open sqlstr, dbget, 1

		banner_cnt = rsget(0)

	rsget.close

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
<script>

	function goDateView(nd)
	{
		location.href='/event/etc/management/iframe_62086_manage.asp?nd='+nd;
	}
</script>
</head>
<body>

<table class="table" style="width:50%;">

	<colgroup>
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr>
		<Td colspan="3">기준일 : 
			<select name="nd" onchange="goDateView(this.value)">
				<option value="2015-05-13" <% If Left(nowdate, 10)="2015-05-13" Then %>selected<% End If %>>2015-05-13</option>
				<option value="2015-05-14" <% If Left(nowdate, 10)="2015-05-14" Then %>selected<% End If %>>2015-05-14</option>
				<option value="2015-05-15" <% If Left(nowdate, 10)="2015-05-15" Then %>selected<% End If %>>2015-05-15</option>
				<option value="2015-05-18" <% If Left(nowdate, 10)="2015-05-18" Then %>selected<% End If %>>2015-05-18</option>
				<option value="2015-05-19" <% If Left(nowdate, 10)="2015-05-19" Then %>selected<% End If %>>2015-05-19</option>
				<option value="2015-05-20" <% If Left(nowdate, 10)="2015-05-20" Then %>selected<% End If %>>2015-05-20</option>
				<option value="2015-05-21" <% If Left(nowdate, 10)="2015-05-21" Then %>selected<% End If %>>2015-05-21</option>
				<option value="2015-05-22" <% If Left(nowdate, 10)="2015-05-22" Then %>selected<% End If %>>2015-05-22</option>
				<option value="2015-05-25" <% If Left(nowdate, 10)="2015-05-25" Then %>selected<% End If %>>2015-05-25</option>
				<option value="2015-05-26" <% If Left(nowdate, 10)="2015-05-26" Then %>selected<% End If %>>2015-05-26</option>
				<option value="2015-05-27" <% If Left(nowdate, 10)="2015-05-27" Then %>selected<% End If %>>2015-05-27</option>
				<option value="2015-05-28" <% If Left(nowdate, 10)="2015-05-28" Then %>selected<% End If %>>2015-05-28</option>
				<option value="2015-05-29" <% If Left(nowdate, 10)="2015-05-29" Then %>selected<% End If %>>2015-05-29</option>

			</select>
			디스전 초대/인증 현황
		</td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>초대자 수</strong></th>
		<th><strong>인증자 수</strong></th>
		<th><strong>전면배너 클릭 수</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= invite_cnt %>명</td>
		<td bgcolor=""><%= receive_cnt %>명</td>
		<td bgcolor=""><%= banner_cnt %>명</td>
	</tr>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->