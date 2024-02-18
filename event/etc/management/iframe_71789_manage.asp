<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 마이펫의 이중생활 이벤트
' History : 2016-07-14 김진영
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim userid, eCode, sqlstr, arrList, i
Dim selDate
Dim smsCNT1, smsCNT2			'smsCNT1 : 중복제거 없는 카운트, smsCNT2 : 중복제거한 카운트
Dim appCNT1, appCNT2			'appCNT1 : 중복제거 없는 카운트, appCNT2 : 중복제거한 카운트

userid	= getloginuserid()
selDate = request("selDate")

IF application("Svr_Info") = "Dev" THEN
	eCode = 66170
Else
	eCode = 71789
End If

If userid="kjy8517" Or userid="bjh2546" Or userid="motions" Or userid="thensi7"  Or userid="baboytw" Or userid="greenteenz" Then

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
<script>
function goList(v){
	if (v == ""){
		alert('조회할 날짜를 선택하세요');
	}else{
		location.replace('/event/etc/management/iframe_71789_manage.asp?selDate='+v)
	}
}
</script>
<body>
<%
sqlstr = " SELECT COUNT(*) as cnt FROM db_event.dbo.tbl_event_subscript where evt_code = '71790' "
rsget.Open sqlstr,dbget
	smsCNT1 = rsget("cnt")
rsget.Close

sqlstr = " SELECT COUNT(Distinct userid) as cnt FROM db_event.dbo.tbl_event_subscript where evt_code = '71790' "
rsget.Open sqlstr,dbget
	smsCNT2 = rsget("cnt")
rsget.Close

sqlstr = " SELECT COUNT(*) as cnt FROM db_event.dbo.tbl_event_subscript where evt_code = '"&eCode&"' "
rsget.Open sqlstr,dbget
	appCNT1 = rsget("cnt")
rsget.Close

sqlstr = " SELECT COUNT(Distinct userid) as cnt FROM db_event.dbo.tbl_event_subscript where evt_code = '"&eCode&"' "
rsget.Open sqlstr,dbget
	appCNT2 = rsget("cnt")
rsget.Close

%>
<table class="table" style="width:90%;">
<tr bgcolor="#FFFFFF" align="left">
	<td width="70%">
		조회 날짜 :
		<select name="selDate" onchange="goList(this.value);" class="select">
			<option value="">-CHOICE-</option>
		<% For i = 12 to 30 %>
			<option value="<%=i%>" <%= Chkiif( CStr(i) = CStr(selDate), "selected", "") %>  >7월 <%=i%>일</option>
		<% Next %>
		</select>
	</td>
	<td>
		<table class="table" style="width:90%;" align="right">
		<tr bgcolor="#FFFFFF" align="center">
			<td width="50%">PC_SMS전체수</td>
			<td><%= smsCNT1 %></td>
		</tr>
		<tr bgcolor="#FFFFFF" align="center">
			<td>PC_SMS중복제거수</td>
			<td><%= smsCNT2 %></td>
		</tr>
		<tr bgcolor="#FFFFFF" align="center">
			<td width="50%">APP_전체 참여수</td>
			<td><%= appCNT1 %></td>
		</tr>
		<tr bgcolor="#FFFFFF" align="center">
			<td>APP_중복제거 참여수</td>
			<td><%= appCNT2 %></td>
		</tr>
		</table>
	</td>
</tr>
</table>
<%
If selDate <> "" Then
	sqlstr = ""
	sqlstr = sqlstr & " SELECT "
	sqlstr = sqlstr & " n.userid "
	sqlstr = sqlstr & " ,n.username "
	sqlstr = sqlstr & " ,CASE WHEN l.userlevel = 0 then 'YELLOW' "
	sqlstr = sqlstr & "     WHEN l.userlevel = 1 then 'GREEN' "
	sqlstr = sqlstr & "     WHEN l.userlevel = 2 then 'BLUE' "
	sqlstr = sqlstr & "     WHEN l.userlevel = 3 then 'VIP SILVER' "
	sqlstr = sqlstr & "     WHEN l.userlevel = 4 then 'VIP GOLD' "
	sqlstr = sqlstr & "     WHEN l.userlevel = 5 then 'ORANGE' "
	sqlstr = sqlstr & "     WHEN l.userlevel = 7 then 'STAFF' "
	sqlstr = sqlstr & " END as userlevel "
	sqlstr = sqlstr & " ,n.birthday ,n.usercell ,n.usermail ,n.zipcode ,n.zipaddr ,n.useraddr  "
	sqlstr = sqlstr & " ,(select count(*) FROM [db_event].[dbo].[tbl_event_prize] as p WHERE p.evt_winner = n.userid) as wincnt "
	sqlstr = sqlstr & " ,(select top 1 evt_regdate FROM [db_event].[dbo].[tbl_event_prize] as p WHERE p.evt_winner = n.userid order by evt_regdate desc) as windate "
	sqlstr = sqlstr & " ,s.regdate "
	sqlstr = sqlstr & " FROM db_event.dbo.tbl_event_subscript as s "
	sqlstr = sqlstr & " INNER join db_user.dbo.tbl_user_n as n on s.userid = n.userid  "
	sqlstr = sqlstr & " INNER join db_user.dbo.tbl_logindata as l on n.userid = l.userid "
	sqlstr = sqlstr & " WHERE s.evt_code = '"&eCode&"' "
	sqlstr = sqlstr & " AND s.regdate between '2016-07-"&selDate&" 00:00:00' and '2016-07-"&selDate&" 23:59:59' "
	sqlstr = sqlstr & " ORDER BY s.regdate ASC "
	rsget.Open sqlstr,dbget
	If not rsget.EOF Then
		arrList = rsget.getrows
	End If
	rsget.close
%>
<br>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>마이펫 참여 이벤트</strong></th>
</tr>
</table>
<table class="table" style="width:90%;">
<tr bgcolor="PINK" align="center">
	<td>No.</td>
	<td>ID</td>
	<td>이름</td>
	<td>등급</td>
	<td>생년월일</td>
	<td>핸드폰번호</td>
	<td>이메일주소</td>
	<td>우편번호</td>
	<td>주소1</td>
	<td>주소2</td>
	<td>당첨횟수</td>
	<td>최근당첨일</td>
	<td>참여날짜</td>
</tr>
<%
IF isArray(arrList) THEN
	For i = 0 to ubound(arrList,2)
%>
<tr bgcolor="#FFFFFF" align="center">
	<td><% response.write i + 1 %></td>
	<td><%= arrList(0, i) %></td>
	<td><%= arrList(1, i) %></td>
	<td><%= arrList(2, i) %></td>
	<td><%= arrList(3, i) %></td>
	<td><%= arrList(4, i) %></td>
	<td><%= arrList(5, i) %></td>
	<td><%= arrList(6, i) %></td>
	<td><%= arrList(7, i) %></td>
	<td><%= arrList(8, i) %></td>
	<td><%= arrList(9, i) %></td>
	<td><%= arrList(10, i) %></td>
	<td><%= arrList(11, i) %></td>
</tr>
<%
	Next 
End If
End If
%>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->