<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 호우호우 이벤트
' History : 2015-11-23 원승현
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
	Dim vHiter, vGlassBottle, vTumblr1, vTumblr2, vhouhoucnt
	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode 		= "65954"
	Else
		eCode 		= "67421"
	End If

	'// 각 상품별 일자별 한정갯수 셋팅
	Select Case Trim(Left(returndate, 10))
		Case "2015-11-23" 
			vHiter = 1
			vGlassBottle = 20
			vTumblr1 = 30
			vTumblr2 = 30

		Case "2015-11-24"
			vHiter = 1
			vGlassBottle = 20
			vTumblr1 = 30
			vTumblr2 = 30

		Case "2015-11-25"
			vHiter = 1
			vGlassBottle = 20
			vTumblr1 = 30
			vTumblr2 = 30

		Case "2015-11-26"
			vHiter = 1
			vGlassBottle = 20
			vTumblr1 = 30
			vTumblr2 = 30

		Case "2015-11-27"
			vHiter = 1
			vGlassBottle = 23
			vTumblr1 = 30
			vTumblr2 = 30

		Case Else
			vHiter = 0
			vGlassBottle = 0
			vTumblr1 = 0
			vTumblr2 = 0
			'vHiter = 1
			'vGlassBottle = 1
			'vTumblr1 = 1
			'vTumblr2 = 1

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

	'// 히터 당첨자
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt2 ='1' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum1 = rsget(0)
	End IF
	rsget.close

	'// 글래스보틀 당첨자
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt2 ='2' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum2 = rsget(0)
	End IF
	rsget.close

	'// 텀블러1 당첨자
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt2 ='3' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum3 = rsget(0)
	End IF
	rsget.close

	'// 텀블러2 당첨자
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and sub_opt2 ='4' and convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum4 = rsget(0)
	End IF
	rsget.close


	'// 호우호우다운로드클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] "
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10), regdate, 120) ='"&returndate&"' And value3='호우호우앱다운로드클릭'"
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vhouhoucnt = rsget(0)
	End IF
	rsget.close


%>
<table class="table" style="width:50%;">
<tr align="center">
	<th><strong>호우호우 이벤트</strong></th>
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
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67421_manage.asp?returndate=2015-11-23">2015-11-23 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67421_manage.asp?returndate=2015-11-24">2015-11-24 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67421_manage.asp?returndate=2015-11-25">2015-11-25 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67421_manage.asp?returndate=2015-11-26">2015-11-26 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_67421_manage.asp?returndate=2015-11-27">2015-11-27 (금)</a></td>
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
		<th><strong>히터 당첨자(<%=vHiter%>)</strong></th>
		<th><strong>유리병 당첨자(<%=vGlassBottle%>)</strong></th>
		<th><strong>텀블러1 당첨자(<%=vTumblr1%>)</strong></th>
		<th><strong>텀블러2 당첨자(<%=vTumblr2%>)</strong></th>
		<th><strong>앱 다운로드 클릭수</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= vNum1%></td>
		<td bgcolor=""><%= vNum2%></td>
		<td bgcolor=""><%= vNum3%></td>
		<td bgcolor=""><%= vNum4%></td>
		<td bgcolor=""><%= vhouhoucnt%></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->