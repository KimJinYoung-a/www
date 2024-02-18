<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 냉동실을 부탁해
' History : 2015-07-24 유태욱
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
		eCode   =  64837
	Else
		eCode   =  65010
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
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt3='kakao' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		kakaocnt = rsget(0)
	End IF
	rsget.close

	If returndate<"2015-07-28" or returndate="2015-08-03" Then
		pdName1 = "베스킨베리"
		evtItemCnt1 = 5
		pdName2 = "설레임밀크"
		evtItemCnt2 = 485
		pdName3 = "파리팥빙수"
		evtItemCnt3 = 10
	elseif returndate="2015-07-28" or returndate="2015-08-04" Then
		pdName1 = "던킨아이스"
		evtItemCnt1 = 10
		pdName2 = "우유속모카"
		evtItemCnt2 = 480
		pdName3 = "스타아이스"
		evtItemCnt3 = 10
	elseif returndate="2015-07-29" or returndate="2015-08-05" Then
		pdName1 = "스무디베리"
		evtItemCnt1 = 10
		pdName2 = "메로나"
		evtItemCnt2 = 480
		pdName3 = "베스킨사과"
		evtItemCnt3 = 10
	elseif returndate="2015-07-30" or returndate="2015-08-06" Then
		pdName1 = "베스킨엄마"
		evtItemCnt1 = 10
		pdName2 = "베스킨롤"
		evtItemCnt2 = 470
		pdName3 = "스타초콜릿"
		evtItemCnt3 = 20
	elseif returndate="2015-07-31" Then
		pdName1 = "베스킨감사"
		evtItemCnt1 = 5
		pdName2 = "베스킨마카롱"
		evtItemCnt2 = 45
		pdName3 = "베스킨싱글"
		evtItemCnt3 = 450
	elseif returndate>="2015-08-07" Then
		pdName1 = "베스킨감사"
		evtItemCnt1 = 5
		pdName2 = "베스킨마카롱"
		evtItemCnt2 = 10
		pdName3 = "베스킨싱글"
		evtItemCnt3 = 485

	end if
%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>냉동실을 부탁해</strong></th>
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
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65010_manage.asp?returndate=2015-07-27">2015-07-27 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65010_manage.asp?returndate=2015-07-28">2015-07-28 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65010_manage.asp?returndate=2015-07-29">2015-07-29 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65010_manage.asp?returndate=2015-07-30">2015-07-30 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65010_manage.asp?returndate=2015-07-31">2015-07-31 (금)</a></td>
</tr>																				            
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65010_manage.asp?returndate=2015-08-03">2015-08-03 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65010_manage.asp?returndate=2015-08-04">2015-08-04 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65010_manage.asp?returndate=2015-08-05">2015-08-05 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65010_manage.asp?returndate=2015-08-06">2015-08-06 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65010_manage.asp?returndate=2015-08-07">2015-08-07 (금)</a></td>
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
		<td colspan="10"><font size="4" color="blue">현재확률 <br> 1번쉐프 0 % <br> 2번쉐프 5 % <br> 3번쉐프 10 % <br></font></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>1번쉐프 [ <%=pdName1%> ]</strong></th>
		<th><strong>2번쉐프 [ <%=pdName2%> ]</strong></th>
		<th><strong>3번쉐프 [ <%=pdName3%> ]</strong></th>
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