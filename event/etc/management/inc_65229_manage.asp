<%@codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 현상금을 노려라 관리
' History : 2015-08-05 이종화 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim eCode, userid, sqlStr , tItemid
dim totcnt, wincnt , mcnt ,  kcnt
Dim rDate

rDate = Trim(request("Rdate"))
	
If rDate = "" Then rDate = Date()

IF application("Svr_Info") = "Dev" THEN
	eCode   =  64843
Else
	eCode   =  65229
End If

userid=getloginuserid()

If userid = "motions" Or userid = "stella0117"  Or userid = "cogusdk"  Then
Else
	response.write "<script>alert('관계자만 볼 수 있는 페이지 입니다.');window.close();</script>"
	response.End
End If

If rDate = "2015-08-10" then
	tItemid = "1322304"
ElseIf rDate = "2015-08-11" then
	tItemid = "1243628"
ElseIf rDate = "2015-08-12" then
	tItemid = "1246002"
ElseIf rDate = "2015-08-13" then
	tItemid = "1321876"
ElseIf rDate = "2015-08-14" then
	tItemid = "1103524"
Else 
	tItemid = "1322304"
End If 

'/// 카운팅
sqlStr = " select " &_
		" count(*) as tt " &_
		" ,isnull(sum(case when sub_opt1 = '"& tItemid &"' or sub_opt2 = '"& tItemid &"' then 1 else 0 end),0) as wincnt " &_
		" ,(select count(*) from [db_temp].[dbo].[tbl_event_click_log] where eventid='"& eCode &"' and convert(varchar(10),regdate,120) = '"& rDate &"' and chkid='app_Main') as mcnt " &_
		" ,(select count(*) from [db_temp].[dbo].[tbl_event_click_log] where eventid='"& eCode &"' and convert(varchar(10),regdate,120) = '"& rDate &"' and chkid='kakao') as kcnt " &_
		" from db_event.dbo.tbl_event_subscript " &_
		" where evt_code = "& eCode &" and convert(varchar(10),regdate,120) = '"& rDate &"' "
'Response.write sqlStr
rsget.Open sqlStr,dbget,1
	totcnt = rsget("tt")
	wincnt = rsget("wincnt")
	mcnt = rsget("mcnt")
	kcnt = rsget("kcnt")
rsget.Close

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<style type="text/css">
.table {width:95%; margin:0 auto; font-family:'malgun gothic'; border-collapse:collapse;}
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
<div style="text-align:center;font-weight:bold; border-radius:5px;">현상금을 노려라 관리 : 현재 날짜 - (<%=rDate%>)</div>
<p>&nbsp;</p>
<div class="table" style="text-align:center;"><span style="font-weight:bold; border-radius:5px;">검색 일자 - 해당 일자 클릭</span></div>
	<table class="table">
		<colgroup>
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<tr align="center" height="30">
			<td bgcolor="<%=chkiif(rDate="2015-08-10","#F98000","#FFFFFF")%>"><strong><a href="?rDate=2015-08-10">2015-08-10</a></strong></td>
			<td bgcolor="<%=chkiif(rDate="2015-08-11","#F98000","#FFFFFF")%>"><strong><a href="?rDate=2015-08-11">2015-08-11</a></strong></td>
			<td bgcolor="<%=chkiif(rDate="2015-08-12","#F98000","#FFFFFF")%>"><strong><a href="?rDate=2015-08-12">2015-08-12</a></strong></td>
			<td bgcolor="<%=chkiif(rDate="2015-08-13","#F98000","#FFFFFF")%>"><strong><a href="?rDate=2015-08-13">2015-08-13</a></strong></td>
			<td bgcolor="<%=chkiif(rDate="2015-08-14","#F98000","#FFFFFF")%>"><strong><a href="?rDate=2015-08-14">2015-08-14</a></strong></td>
		</tr>
	</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<div class="table" style="text-align:center;"><span style="font-weight:bold; border-radius:5px;"><%=rDate%> 응모현황</span></div>
	<table class="table">
		<colgroup>
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<tr align="center" bgcolor="#E6E6E6" height="30">
			<td><strong>총응모수</strong></td>
			<td><strong>총당첨자수</strong></td>
			<td><strong>메인배너클릭수</strong></td>
			<td><strong>카카오배너클릭수</strong></td>
		</tr>
		<tr bgcolor="#FFFFFF" align="center">
			<td><%=totcnt%></td>
			<td><%=wincnt%></td>
			<td><%=mcnt%></td>
			<td><%=kcnt%></td>
		</tr>
	</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<div class="table" style="text-align:center;"><span style="font-weight:bold; border-radius:5px;">(<%=rDate%>)&nbsp;&nbsp;&nbsp;상품번호&nbsp;:&nbsp;<%=tItemid%>&nbsp;&nbsp;&nbsp;당첨자 명단</span></div>
	<table class="table">
		<colgroup>
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
			<col width="20%" />
		</colgroup>
		<tr align="center" bgcolor="#E6E6E6" height="30">
			<th><strong>회원ID</strong></th>
			<th><strong>등급</strong></th>
			<th><strong>전화번호</strong></th>
			<th><strong>전체이벤트당첨</strong></th>
			<th><strong>최근당첨일</strong></th>
		</tr>
		<%
			sqlStr = " select "&_
					"	s.userid , "&_
					"	case when l.userlevel = 0 then '옐로우' "&_
					"		 when l.userlevel = 1 then '그린' "&_
					"		 when l.userlevel = 2 then '블루' "&_
					"		 when l.userlevel = 3 then 'vip실버' "&_
					"		 when l.userlevel = 4 then 'vip골드' "&_
					"		 when l.userlevel = 5 then '오렌지' "&_
					"		 when l.userlevel = 7 then 'Staff' "&_
					"	end as userlevel, "&_
					"	n.usercell, "&_
					"	(select count(*) FROM [db_event].[dbo].[tbl_event_prize] as p WHERE p.evt_winner = n.userid) as wincnt , "&_
					"	(select top 1 evt_regdate FROM [db_event].[dbo].[tbl_event_prize] as p WHERE p.evt_winner = n.userid order by evt_regdate desc) as windate  "&_
					" from db_event.dbo.tbl_event_subscript as s "&_
					" left outer join db_user.dbo.tbl_user_n as n "&_
					" on s.userid = n.userid "&_
					" left outer join db_user.dbo.tbl_logindata as l "&_
					" on n.userid = l.userid "&_
					" where s.evt_code = "& eCode &" and convert(varchar(10),s.regdate,120) = '"& rDate &"' "&_
					" and (convert(varchar(10),s.sub_opt1) = '"& tItemid &"' or convert(varchar(10),s.sub_opt2) = '"& tItemid &"') " &_
					" order by s.regdate asc , n.usercell asc "
'			Response.write sqlStr
'			Response.end
			rsget.Open sqlStr,dbget,1
			if Not(rsget.EOF or rsget.BOF) Then
				Do Until rsget.eof
		%>
		<tr bgcolor="#FFFFFF" align="center">
			<td><%=rsget("userid")%></td>
			<td><%=rsget("userlevel")%></td>
			<td><%=rsget("usercell")%></td>
			<td><%=rsget("wincnt")%>회</td>
			<td><%=rsget("windate")%></td>
		</tr>
		<%
				rsget.movenext
				Loop
			End If
			rsget.close
		%>
	</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->