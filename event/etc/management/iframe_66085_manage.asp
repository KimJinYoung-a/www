<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 봉투맨
' History : 2015-09-11 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	Dim airuserid, ipaduserid, ipadcnt, secproductuserid, forproductuserid, kakaocnt
	Dim mainbannercnt, totalcnt
	Dim eCode, userid, sqlStr
	Dim evtItemCnt1, evtitemcnt2, evtitemcnt3, evtitemcnt4
	Dim pdname1, pdname2, pdname3, pdname4
	Dim returndate  : returndate = 	request("returndate")

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  64882
	Else
		eCode   =  66085
	End If

If userid="thensi7" Or userid="bborami" Or userid="baboytw" Or userid="greenteenz" Or userid="cogusdk" Or userid="jinyeonmi" Then

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
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	'// 1등
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='1111111' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		airuserid = rsget(0)
	End IF
	rsget.close
	
	'// 2등
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='2222222' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		ipaduserid = rsget(0)
	End IF
	rsget.close

	'// 3등
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='3333333' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		ipadcnt = rsget(0)
	End IF
	rsget.close

'	'// 4등
'	sqlstr = "select count(*) "
'	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
'	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='4444444' "
'	rsget.Open sqlstr, dbget, 1
'
'	If Not rsget.Eof Then
'		secproductuserid = rsget(0)
'	End IF
'	rsget.close

	'// 쿠폰 당첨자 수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='0' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		forproductuserid = rsget(0)
	End IF
	rsget.close

	'// 메인배너 클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from [db_temp].[dbo].[tbl_event_click_log]"
	sqlstr = sqlstr & " where eventid='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		mainbannercnt = rsget(0)
	End IF
	rsget.close

	'// 카톡 초대 클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log]"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And value1='kakao' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		kakaocnt = rsget(0)
	End IF
	rsget.close

	pdName1 = "1등 10만gift"
	evtItemCnt1 = 1
	pdName2 = "2등 1만gift"
	evtItemCnt2 = 35
	pdName3 = "3등 500마일"
	evtItemCnt3 = 1500
%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>봉투맨</strong></th>
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
</colgroup>
<tr align="center" bgcolor="#E6E6E6">
	<th colspan="8"><strong>날짜</strong></th>
</tr>
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66085_manage.asp?returndate=2015-09-14">2015-09-14 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66085_manage.asp?returndate=2015-09-15">2015-09-15 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66085_manage.asp?returndate=2015-09-16">2015-09-16 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66085_manage.asp?returndate=2015-09-17">2015-09-17 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66085_manage.asp?returndate=2015-09-18">2015-09-18 (금)</a></td>
</tr>																				            
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66085_manage.asp?returndate=2015-09-21">2015-09-21 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66085_manage.asp?returndate=2015-09-22">2015-09-22 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66085_manage.asp?returndate=2015-09-23">2015-09-23 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66085_manage.asp?returndate=2015-09-24">2015-09-24 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66085_manage.asp?returndate=2015-09-25">2015-09-25 (금)</a></td>
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
		<Td colspan="2"><font size="5">기준일 : <%=returndate%></font></td>
		<td colspan="10"><font size="4" color="blue">현재확률 <br> 1등 0.05 % <br> 2등 0.5 % <br> 3등 20 % <br></font></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>1등 [ <%=pdName1%> ]</strong></th>
		<th><strong>2등 [ <%=pdName2%> ]</strong></th>
		<th><strong>3등 [ <%=pdName3%> ]</strong></th>
		<th><strong>쿠폰 당첨자수(무제한)</strong></th>
		<th><strong>전면배너클릭수</strong></th>
		<th><strong>카카오초대클릭수</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= airuserid%><br><font color="RED">(남은수량 : <%= evtItemCnt1-airuserid %> )</font></td>
		<td bgcolor=""><%= ipaduserid%><br><font color="RED">(남은수량 : <%= evtItemCnt2-ipaduserid %> )</font></td>
		<td bgcolor=""><%= ipadcnt %><br><font color="RED">(남은수량 : <%= evtItemCnt3-ipadcnt %> )</font></td>
		<td bgcolor=""><%= forproductuserid %></td>
		<td bgcolor=""><%= mainbannercnt %></td>
		<td bgcolor=""><%= kakaocnt %></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->