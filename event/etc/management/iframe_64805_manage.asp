<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 미니언즈 이벤트
' History : 2015-07-13 원승현
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
	Dim vNum1, vNum2, vNum3, vNum4, vNum5, vNum6, vNum7 '// 상품별 셋팅
	Dim vPstNum1, vPstNum2, vPstNum3, vPstNum4, vPstNum5, vPstNum6, vPstNum7 '// 일자별 한정갯수 셋팅
	Dim vCouponCnt

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode = 64827
	Else
		eCode = 64805
	End If

If userid="thensi7" Or userid="bborami" Or userid="baboytw" Or userid="greenteenz" Or userid="cogusdk" Or userid="jinyeonmi" Then

Else
	response.write "<script>alert('관계자만 볼 수 있는 페이지 입니다.');window.close();</script>"
	response.End
End If


	'// 각 상품별 일자별 한정갯수 셋팅
	Select Case Trim(returndate)
		Case "2015-07-13" '// 이건 테스트 날짜용 셋팅임
			vPstNum1 = 1 '// 미니언즈 피규어
			vPstNum2 = 1 '// 미니언즈 스퀴시
			vPstNum3 = 1 '// 미니언즈 쇼퍼백
			vPstNum4 = 1 '// 미니언즈 비치볼
			vPstNum5 = 1 '// 미니언즈 우산
			vPstNum6 = 1 '// 미니언즈 스티커
			vPstNum7 = 1 '// 미니언즈 예매권

		Case "2015-07-14"
			vPstNum1 = 60 '// 미니언즈 피규어
			vPstNum2 = 20 '// 미니언즈 스퀴시
			vPstNum3 = 20 '// 미니언즈 쇼퍼백
			vPstNum4 = 10 '// 미니언즈 비치볼
			vPstNum5 = 10 '// 미니언즈 우산
			vPstNum6 = 25 '// 미니언즈 스티커
			vPstNum7 = 20 '// 미니언즈 예매권

		Case "2015-07-15"
			vPstNum1 = 60 '// 미니언즈 피규어
			vPstNum2 = 20 '// 미니언즈 스퀴시
			vPstNum3 = 20 '// 미니언즈 쇼퍼백
			vPstNum4 = 5 '// 미니언즈 비치볼
			vPstNum5 = 5 '// 미니언즈 우산
			vPstNum6 = 25 '// 미니언즈 스티커
			vPstNum7 = 20 '// 미니언즈 예매권

		Case "2015-07-16"
			vPstNum1 = 0 '// 미니언즈 피규어
			vPstNum2 = 10 '// 미니언즈 스퀴시
			vPstNum3 = 10 '// 미니언즈 쇼퍼백
			vPstNum4 = 5 '// 미니언즈 비치볼
			vPstNum5 = 5 '// 미니언즈 우산
			vPstNum6 = 25 '// 미니언즈 스티커
			vPstNum7 = 10 '// 미니언즈 예매권

		Case "2015-07-17"
			vPstNum1 = 0 '// 미니언즈 피규어
			vPstNum2 = 20 '// 미니언즈 스퀴시
			vPstNum3 = 20 '// 미니언즈 쇼퍼백
			vPstNum4 = 10 '// 미니언즈 비치볼
			vPstNum5 = 10 '// 미니언즈 우산
			vPstNum6 = 55 '// 미니언즈 스티커
			vPstNum7 = 25 '// 미니언즈 예매권

		Case "2015-07-18"
			vPstNum1 = 0 '// 미니언즈 피규어
			vPstNum2 = 15 '// 미니언즈 스퀴시
			vPstNum3 = 15 '// 미니언즈 쇼퍼백
			vPstNum4 = 10 '// 미니언즈 비치볼
			vPstNum5 = 10 '// 미니언즈 우산
			vPstNum6 = 35 '// 미니언즈 스티커
			vPstNum7 = 10 '// 미니언즈 예매권

		Case "2015-07-19"
			vPstNum1 = 0 '// 미니언즈 피규어
			vPstNum2 = 15 '// 미니언즈 스퀴시
			vPstNum3 = 15 '// 미니언즈 쇼퍼백
			vPstNum4 = 10 '// 미니언즈 비치볼
			vPstNum5 = 10 '// 미니언즈 우산
			vPstNum6 = 35 '// 미니언즈 스티커
			vPstNum7 = 15 '// 미니언즈 예매권

		Case "2015-07-20"
			vPstNum1 = 0 '// 미니언즈 피규어
			vPstNum2 = 0 '// 미니언즈 스퀴시
			vPstNum3 = 0 '// 미니언즈 쇼퍼백
			vPstNum4 = 0 '// 미니언즈 비치볼
			vPstNum5 = 0 '// 미니언즈 우산
			vPstNum6 = 0 '// 미니언즈 스티커
			vPstNum7 = 0 '// 미니언즈 예매권

		Case "2015-07-21"
			vPstNum1 = 0 '// 미니언즈 피규어
			vPstNum2 = 0 '// 미니언즈 스퀴시
			vPstNum3 = 0 '// 미니언즈 쇼퍼백
			vPstNum4 = 0 '// 미니언즈 비치볼
			vPstNum5 = 0 '// 미니언즈 우산
			vPstNum6 = 0 '// 미니언즈 스티커
			vPstNum7 = 0 '// 미니언즈 예매권

		Case "2015-07-22"
			vPstNum1 = 0 '// 미니언즈 피규어
			vPstNum2 = 0 '// 미니언즈 스퀴시
			vPstNum3 = 0 '// 미니언즈 쇼퍼백
			vPstNum4 = 0 '// 미니언즈 비치볼
			vPstNum5 = 0 '// 미니언즈 우산
			vPstNum6 = 0 '// 미니언즈 스티커
			vPstNum7 = 0 '// 미니언즈 예매권

		Case Else
			vPstNum1 = 0 '// 미니언즈 피규어
			vPstNum2 = 0 '// 미니언즈 스퀴시
			vPstNum3 = 0 '// 미니언즈 쇼퍼백
			vPstNum4 = 0 '// 미니언즈 비치볼
			vPstNum5 = 0 '// 미니언즈 우산
			vPstNum6 = 0 '// 미니언즈 스티커
			vPstNum7 = 0 '// 미니언즈 예매권
	End Select

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
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	'// 미니언즈 피규어
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='1' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum1 = rsget(0)
	End IF
	rsget.close
	
	'// 미니언즈 스퀴시
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='2' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum2 = rsget(0)
	End IF
	rsget.close

	'// 미니언즈 쇼퍼백
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='3' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum3 = rsget(0)
	End IF
	rsget.close

	'// 미니언즈 비치볼
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='4' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum4 = rsget(0)
	End IF
	rsget.close

	'// 미니언즈 우산
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='5' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum5 = rsget(0)
	End IF
	rsget.close

	'// 미니언즈 스티커
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='6' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum6 = rsget(0)
	End IF
	rsget.close

	'// 미니언즈 예매권
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='7' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum7 = rsget(0)
	End IF
	rsget.close

	'// 쿠폰 당첨자 수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='0' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		vCouponCnt = rsget(0)
	End IF
	rsget.close

	'// 메인배너 클릭수
'	sqlstr = "select count(*) "
'	sqlstr = sqlstr & " from [db_temp].[dbo].[tbl_event_click_log]"
'	sqlstr = sqlstr & " where eventid='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' "
'	rsget.Open sqlstr, dbget, 1

'	If Not rsget.Eof Then
'		mainbannercnt = rsget(0)
'	End IF
'	rsget.close


%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>미니언즈 이벤트</strong></th>
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
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64805_manage.asp?returndate=2015-07-14">2015-07-14 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64805_manage.asp?returndate=2015-07-15">2015-07-15 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64805_manage.asp?returndate=2015-07-16">2015-07-16 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64805_manage.asp?returndate=2015-07-17">2015-07-17 (금)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64805_manage.asp?returndate=2015-07-18">2015-07-18 (토)</a></td>
</tr>																				            
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64805_manage.asp?returndate=2015-07-19">2015-07-19 (일)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64805_manage.asp?returndate=2015-07-20">2015-07-20 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64805_manage.asp?returndate=2015-07-21">2015-07-21 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64805_manage.asp?returndate=2015-07-22">2015-07-22 (수)</a></td>
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
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr>
		<Td colspan="2"><font size="5">기준일 : <%=returndate%></font></td>
		<td colspan="10"><font size="4" color="blue">현재확률 피규어 : 0%, 스퀴시 : 2%, 쇼퍼백 : 2%, 비치볼 : 1%, 우산 : 1%, 스티커 : 5%, 예매권 : 2%</font></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>피규어 [ <%=vPstNum1%> ]</strong></th>
		<th><strong>스퀴시 [ <%=vPstNum2%> ]</strong></th>
		<th><strong>쇼퍼백 [ <%=vPstNum3%> ]</strong></th>
		<th><strong>비치볼 [ <%=vPstNum4%> ]</strong></th>
		<th><strong>우산 [ <%=vPstNum5%> ]</strong></th>
		<th><strong>스티커 [ <%=vPstNum6%> ]</strong></th>
		<th><strong>예매권 [ <%=vPstNum7%> ]</strong></th>
		<th><strong>쿠폰 당첨자수(무제한)</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= vNum1%><br><font color="RED">(남은수량 : <%= vPstNum1-vNum1 %> )</font></td>
		<td bgcolor=""><%= vNum2%><br><font color="RED">(남은수량 : <%= vPstNum2-vNum2 %> )</font></td>
		<td bgcolor=""><%= vNum3 %><br><font color="RED">(남은수량 : <%= vPstNum3-vNum3 %> )</font></td>
		<td bgcolor=""><%= vNum4%><br><font color="RED">(남은수량 : <%= vPstNum4-vNum4 %> )</font></td>
		<td bgcolor=""><%= vNum5 %><br><font color="RED">(남은수량 : <%= vPstNum5-vNum5 %> )</font></td>
		<td bgcolor=""><%= vNum6%><br><font color="RED">(남은수량 : <%= vPstNum6-vNum6 %> )</font></td>
		<td bgcolor=""><%= vNum7%><br><font color="RED">(남은수량 : <%= vPstNum7-vNum7 %> )</font></td>
		<td bgcolor=""><%= vCouponCnt %></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->