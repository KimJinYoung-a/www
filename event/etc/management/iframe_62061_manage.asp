<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 61909 bml 이벤트
' History : 2015-05-02 원승현
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim set1,set2,set3,set4
Dim eCode, subscriptcount, userid, evtTotalCnt, sqlStr, cnt, totalcnt, appbannerclick, ipaduserid, secproductuserid, thrproductuserid, forproductuserid, nowdate
Dim dayname, pdname1, evtitemcode1, evtItemCnt1, dayrightnumber, pdname2, evtitemcode2, evtitemcnt2, pdname3, evtitemcode3, evtitemcnt3, pdname4, evtitemcode4, evtitemcnt4, ipadcnt

	userid=getloginuserid()


	nowdate = now()



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
</head>
<body>
<table class="table" style="width:50%;">

	<colgroup>
		<col width="30%" />
		<col width="*" />
	</colgroup>
	<tr>
		<Td >기준일 : <%=Left(nowdate, 10)%></td>
		<td colspan="10">어벤져 카드 일별 응모자수</td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>응모자 수</strong></th>
		<th><strong>일자</strong></th>
	</tr>
<%
	''어벤져 카드 일자별 응모자수
	sqlstr = "select count(*) as cnt, convert(varchar(10), regdate, 120) as regdate"
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='62061' group by convert(varchar(10), regdate, 120) order by regdate asc "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then

		Do Until rsget.eof
%>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= rsget("cnt") %>명</td>
		<td bgcolor=""><%= rsget("regdate") %></td>
	</tr>
<%
		rsget.movenext
		Loop
	End IF
	rsget.close
%>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->