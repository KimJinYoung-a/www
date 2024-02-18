<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 드래곤볼 시사회 이벤트
' History : 2015-09-24 원승현
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	Dim airuserid, ipaduserid, ipadcnt, secproductuserid, forproductuserid, kakaocnt
	Dim mainbannercnt, totalcnt
	Dim eCode, userid, sqlStr
	Dim evtItemCnt1, evtitemcnt2, evtitemcnt3, evtitemcnt4
	Dim pdname1, pdname2, pdname3, pdname4, vfbcnt, vtwcnt, vMoonSticker, vMovieTicket
	Dim returndate  : returndate = 	request("returndate")
	Dim vNum1, vNum2, vNum3, vNum4, vNum5, vNum6, vNum7 '// 상품별 셋팅
	Dim vPstNum1, vPstNum2, vPstNum3, vPstNum4, vPstNum5, vPstNum6, vPstNum7 '// 일자별 한정갯수 셋팅
	Dim vCouponCnt, vPrdCnt1, vPrdCnt2, vPrdCnt3, vPrdName1, vPrdName2, vPrdName3, vPrdCode1, vPrdCode2, vPrdCode3, vinviteCnt, vkakaocnt, vbannercnt

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode = 64896
	Else
		eCode = 66390
	End If

	'// 각 상품별 일자별 한정갯수 셋팅
	Select Case Trim(returndate)
		Case "2015-09-23" 
			vMovieTicket = 0
			vMoonSticker = 0

		Case "2015-09-24"
			vMovieTicket = 30
			vMoonSticker = 30

		Case "2015-09-25"
			vMovieTicket = 20
			vMoonSticker = 21

		Case "2015-09-26"
			vMovieTicket = 20
			vMoonSticker = 20

		Case "2015-09-27"
			vMovieTicket = 5
			vMoonSticker = 5

		Case "2015-09-28"
			vMovieTicket = 5
			vMoonSticker = 5

		Case "2015-09-29"
			vMovieTicket = 10
			vMoonSticker = 10

		Case "2015-09-30"
			vMovieTicket = 10
			vMoonSticker = 10

		Case Else
			vMovieTicket = 0
			vMoonSticker = 0
	End Select

If userid="thensi7" Or userid="bborami" Or userid="baboytw" Or userid="greenteenz" Or userid="cogusdk" Or userid="jinyeonmi" Or userid="icommang" Then

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
	''일자별 총 응모수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	'// 예매권 당첨자
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt2 ='1' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum1 = rsget(0)
	End IF
	rsget.close

	'// 스티커 당첨자
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt2 ='2' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum2 = rsget(0)
	End IF
	rsget.close

	'// 쿠폰 당첨자
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt2 ='0' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum3 = rsget(0)
	End IF
	rsget.close


	'// 카카오클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] "
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10), regdate, 120) ='"&returndate&"' And value1='ka'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vkakaocnt = rsget(0)
	End IF
	rsget.close

	'// 페이스북 클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] "
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10), regdate, 120) ='"&returndate&"' And value1='fb'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vfbcnt = rsget(0)
	End IF
	rsget.close

	'// 트위터 클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] "
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10), regdate, 120) ='"&returndate&"' And value1='tw'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vtwcnt = rsget(0)
	End IF
	rsget.close

%>
<table class="table" style="width:50%;">
<tr align="center">
	<th><strong>드래곤볼 예매권 이벤트</strong></th>
</tr>

</table>
<table class="table" style="width:50%;">
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
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66390_manage.asp?returndate=2015-09-24">2015-09-24 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66390_manage.asp?returndate=2015-09-25">2015-09-25 (금)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66390_manage.asp?returndate=2015-09-26">2015-09-26 (토)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66390_manage.asp?returndate=2015-09-27">2015-09-27 (일)</a></td>
</tr>																				            
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66390_manage.asp?returndate=2015-09-28">2015-09-28 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66390_manage.asp?returndate=2015-09-29">2015-09-29 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_66390_manage.asp?returndate=2015-09-30">2015-09-30 (수)</a></td>
</tr>	
</table>
<br>

<table class="table" style="width:50%;">

	<colgroup>
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
		<col width="10%" />
	</colgroup>
	<tr>
		<Td align="left" colspan="8"><font size="3">&nbsp;&nbsp;&nbsp;&nbsp;기준일 : <%=returndate%></font></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모수</strong></th>
		<th><strong>예매권 당첨자(<%=vMovieTicket%>)</strong></th>
		<th><strong>스티커 당첨자(<%=vMoonSticker%>)</strong></th>
		<th><strong>쿠폰 당첨자(무제한)</strong></th>
		<th><strong>카카오 클릭수</strong></th>
		<th><strong>페이스북 클릭수</strong></th>
		<th><strong>트위터 클릭수</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= vNum1%></td>
		<td bgcolor=""><%= vNum2%></td>
		<td bgcolor=""><%= vNum3%></td>
		<td bgcolor=""><%= vkakaocnt%></td>
		<td bgcolor=""><%= vfbcnt%></td>
		<td bgcolor=""><%= vtwcnt%></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->