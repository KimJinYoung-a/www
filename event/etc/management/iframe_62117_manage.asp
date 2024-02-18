<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 62117 도와줘 히어로 이벤트
' History : 2015-05-02 원승현
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim set1,set2,set3,set4
Dim eCode, subscriptcount, userid, evtTotalCnt, sqlStr, cnt, totalcnt, appbannerclick, ipaduserid, secproductuserid, thrproductuserid, forproductuserid, nowdate
Dim dayname, pdname1, evtitemcode1, evtItemCnt1, dayrightnumber, pdname2, evtitemcode2, evtitemcnt2, pdname3, evtitemcode3, evtitemcnt3, pdname4, evtitemcode4, evtitemcnt4, ipadcnt, i

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
		location.href='/event/etc/management/iframe_62117_manage.asp?nd='+nd;
	}
</script>
</head>
<body>

<table class="table" style="width:50%;">

	<colgroup>
		<col width="10%" />
		<col width="*" />
	</colgroup>
	<tr>
		<Td colspan="2">기준일 : 
			<select name="nd" onchange="goDateView(this.value)">
				<option value="2015-05-06" <% If Left(nowdate, 10)="2015-05-06" Then %>selected<% End If %>>2015-05-06</option>
				<option value="2015-05-07" <% If Left(nowdate, 10)="2015-05-07" Then %>selected<% End If %>>2015-05-07</option>
				<option value="2015-05-08" <% If Left(nowdate, 10)="2015-05-08" Then %>selected<% End If %>>2015-05-08</option>
				<option value="2015-05-09" <% If Left(nowdate, 10)="2015-05-09" Then %>selected<% End If %>>2015-05-09</option>
				<option value="2015-05-10" <% If Left(nowdate, 10)="2015-05-10" Then %>selected<% End If %>>2015-05-10</option>
				<option value="2015-05-11" <% If Left(nowdate, 10)="2015-05-11" Then %>selected<% End If %>>2015-05-11</option>
				<option value="2015-05-12" <% If Left(nowdate, 10)="2015-05-12" Then %>selected<% End If %>>2015-05-12</option>
			</select>
			
		</td>
		<td colspan="10">도와줘 히어로 일별 응모자</td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>번호</strong></th>
		<th><strong>아이디</strong></th>
		<th><strong>이름</strong></th>
		<th><strong>회원등급</strong></th>
		<th><strong>핸드폰번호</strong></th>
		<th><strong>응모시간</strong></th>
	</tr>
<%

	''도와줘 히어로 일별 응모자수
	sqlstr = "	Select e.userid, u.username, "
	sqlstr = sqlstr & " 		case when c.userlevel=5 then 'ORANGE' when C.userlevel=0 then 'YELLOW'  "
	sqlstr = sqlstr & " 		when C.userlevel=1 then 'GREEN' when C.userlevel=2 then 'BLUE' "
	sqlstr = sqlstr & " 		when C.userlevel=3 then 'VIP SILVER' when C.userlevel=4 then 'VIP GOLD' "
	sqlstr = sqlstr & " 		when C.userlevel=7 then 'STAFF' when C.userlevel=6 then 'FRIENDS' "
	sqlstr = sqlstr & " 		when C.userlevel=8 then 'FAMILY' when C.userlevel=9 then 'MANIA' "
	sqlstr = sqlstr & " 		else 'ORANGE' end as level, u.usercell, e.regdate "
	sqlstr = sqlstr & " 	From db_event.dbo.tbl_event_subscript e "
	sqlstr = sqlstr & " 	inner join db_user.dbo.tbl_user_n u on e.userid = u.userid "
	sqlstr = sqlstr & " 	inner join db_user.dbo.tbl_logindata c on e.userid = c.userid "
	sqlstr = sqlstr & " 	Where e.evt_code=62117 and convert(varchar(10), e.regdate, 120) = '"&Left(nowdate,10)&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then

		Do Until rsget.eof
%>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= i %></td>
		<td bgcolor=""><%= rsget("userid") %></td>
		<td bgcolor=""><%= rsget("username") %></td>
		<td bgcolor=""><%= rsget("level") %></td>
		<td bgcolor=""><%= rsget("usercell") %></td>
		<td bgcolor=""><%= rsget("regdate") %></td>
	</tr>
<%
		rsget.movenext
		i = i + 1
		Loop

	Else
%>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor="" colspan="10">응모자 없음</td>
	</tr>
<%
	End IF
	rsget.close
%>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->