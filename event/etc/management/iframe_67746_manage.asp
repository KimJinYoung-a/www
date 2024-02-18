<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 텐바이텐 X 영화 <스누피: 더 피너츠 무비>
' History : 2015.11.30 원승현
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	Dim airuserid, ipaduserid, ipadcnt, secproductuserid, forproductuserid, kakaocnt
	Dim mainbannercnt, totalcnt
	Dim eCode, userid, sqlStr
	Dim evtItemCnt1, evtitemcnt2, evtitemcnt3, evtitemcnt4
	Dim returndate  : returndate = 	request("returndate")
	Dim vNum1, vNum2, vNum3, vNum4, vNum5, vNum6, vNum7 '// 상품별 셋팅
	Dim vPstNum1, vPstNum2, vPstNum3, vPstNum4, vPstNum5, vPstNum6, vPstNum7 '// 일자별 한정갯수 셋팅
	Dim vMovieTicket, vSisaTicket, vTshirt
	Dim vMovieTicketSt, vMovieTicketEd, vSisaTicketSt, vSisaTicketEd, vTshirtSt, vTshirtEd
	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode 		= "65963"
	Else
		eCode 		= "67746"
	End If

	'// 각 상품별 일자별 한정갯수 셋팅
	Select Case Trim(Left(returndate, 10))
		Case "2015-11-30" 
			vMovieTicket = 20
			vSisaTicket = 10
			vTshirt = 5

		Case "2015-12-01"
			vMovieTicket = 30
			vSisaTicket = 20
			vTshirt = 10

		Case "2015-12-02"
			vMovieTicket = 30
			vSisaTicket = 20
			vTshirt = 10

		Case "2015-12-03"
			vMovieTicket = 30
			vSisaTicket = 10
			vTshirt = 10

		Case "2015-12-04"
			vMovieTicket = 30
			vSisaTicket = 10
			vTshirt = 5

		Case "2015-12-05"
			vMovieTicket = 30
			vSisaTicket = 10
			vTshirt = 5

		Case "2015-12-06"
			vMovieTicket = 30
			vSisaTicket = 20
			vTshirt = 5

		Case "2015-12-07"
			vMovieTicket = 15
			vSisaTicket = 7
			vTshirt = 5

		Case "2015-12-08"
			vMovieTicket = 0
			vSisaTicket = 0
			vTshirt = 0

		Case "2015-12-09"
			vMovieTicket = 0
			vSisaTicket = 0
			vTshirt = 0

		Case Else
			vMovieTicket = 0
			vSisaTicket = 0
			vTshirt = 0

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

	'// 영화 예매권 당첨자
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt2 ='1' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum1 = rsget(0)
	End IF
	rsget.close

	'// 시사회 초대 당첨자
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt2 ='2' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum2 = rsget(0)
	End IF
	rsget.close

	'// 티셔츠 당첨자
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt2 ='3' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum3 = rsget(0)
	End IF
	rsget.close


%>
<table class="table" style="width:50%;">
<tr align="center">
	<th><strong>스누피 이벤트</strong></th>
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
	<th colspan="10"><strong>날짜</strong></th>
</tr>
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67746_manage.asp?returndate=2015-11-30">2015-11-30 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67746_manage.asp?returndate=2015-12-01">2015-12-01 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67746_manage.asp?returndate=2015-12-02">2015-12-02 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67746_manage.asp?returndate=2015-12-03">2015-12-03 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67746_manage.asp?returndate=2015-12-04">2015-12-04 (금)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67746_manage.asp?returndate=2015-12-05">2015-12-05 (토)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67746_manage.asp?returndate=2015-12-06">2015-12-06 (일)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67746_manage.asp?returndate=2015-12-07">2015-12-07 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67746_manage.asp?returndate=2015-12-08">2015-12-08 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67746_manage.asp?returndate=2015-12-09">2015-12-09 (수)</a></td>
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
		<th><strong>영화 예매권 당첨자(<%=vMovieTicket%>)</strong></th>
		<th><strong>시사회 초대권 당첨자(<%=vSisaTicket%>)</strong></th>
		<th><strong>티셔츠 당첨자(<%=vTshirt%>)</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= vNum1%></td>
		<td bgcolor=""><%= vNum2%></td>
		<td bgcolor=""><%= vNum3%></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->