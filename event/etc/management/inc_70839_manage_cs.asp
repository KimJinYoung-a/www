<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 스냅스 관리
' History : 2016-05-25 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	Dim mainbannercnt, totalcnt, getitemgocnt, total70715cnt
	Dim wincnt1, wincnt2, wincnt3, wincnt4, wincnt5
	Dim snscnt1, snscnt2, snscnt3, snscnt4
	Dim eCode, userid, sqlStr
	Dim returndate  : returndate = 	request("returndate")

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66124
	Else
		eCode   =  70839
	End If

If userid="baboytw" Or userid="greenteenz" Or userid= "helele223" Or userid= "thensi7" Or userid= "cogusdk" Then

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
	''총 신청자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='70839' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		total70715cnt = rsget(0)
	End IF
	rsget.close

%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>비밀의방</strong></th>
</tr>

</table>
<table class="table" style="width:90%;">
<colgroup>
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
	<col width="*" />
</colgroup>
<tr align="center" bgcolor="#E6E6E6">
	<th colspan="8"><strong>날짜</strong></th>
</tr>
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70839_manage_cs.asp?returndate=2016-05-23">2016-05-23 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70839_manage_cs.asp?returndate=2016-05-24">2016-05-24 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70839_manage_cs.asp?returndate=2016-05-25">2016-05-25 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70839_manage_cs.asp?returndate=2016-05-26">2016-05-26 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70839_manage_cs.asp?returndate=2016-05-27">2016-05-27 (금)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70839_manage_cs.asp?returndate=2016-05-28">2016-05-28 (토)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70839_manage_cs.asp?returndate=2016-05-29">2016-05-29 (일)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70839_manage_cs.asp?returndate=2016-05-30">2016-05-30 (월)</a></td>
</tr>																				            
</table>
<br>

<table class="table" style="width:90%;">

	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr>
		<Td colspan="12"><font size="5">기준일 : <%=returndate%></font></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>응모자</strong></th>

	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= total70715cnt %></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->