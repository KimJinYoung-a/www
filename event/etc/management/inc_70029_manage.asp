<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 2016 정기세일 빙고 데이터
' History : 2016-04-18 원승현
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	Dim mainbannercnt, totalcnt, getitemgocnt
	Dim wincnt1, wincnt2, wincnt3, wincnt4, wincnt5, wincnt6, wincnt7, wincnt8, wincnt9, wincnt10, wincnt11, wincnt12, wincnt13, wincnt14, wincnt15, wincnt16
	Dim snscnt1, snscnt2, snscnt3, snscnt4, failcnt
	Dim eCode, userid, sqlStr
	Dim returndate  : returndate = 	request("returndate")
	Dim vPstNum1	'// 팡팡척척 찍찍이 캐치볼
	Dim vPstNum2	'// 폭스바겐 마이크로버스 60주년 민트
	Dim vPstNum3	'// 플레이모빙 미스터리 피규어 시리즈9
	Dim vPstNum4	'// INSTAX MINI 8(컬러랜덤)
	Dim vPstNum5	'// 스티키몬스터 보조배터리
	Dim vPstNum6	'// 200 마일리지
	Dim vPstNum7	'// 100 마일리지(무제한)

	Dim vPstNum8	'// 앨리스카드
	Dim vPstNum9	'// 아이리버 블루투스 스피커 사운드 미니바
	Dim vPstNum10	'// 샤오미 액션캠
	Dim vPstNum11	'// 램플로우 더어스
	Dim vPstNum12	'// 바바파파 수면램프
	Dim vPstNum13	'// 에코백
	Dim vPstNum14	'// 델리삭스 양말
	Dim vPstNum15	'// 멀티비타민 오렌지맛 구미
	Dim vPstNum16	'// 100 마일리지(무제한)

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66101
	Else
		eCode   =  70029
	End If

If userid="baboytw" Or userid="greenteenz" Or userid= "helele223" Or userid= "thensi7" Or userid="cogusdk" Then

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

	'// 각 상품별 한정갯수 셋팅
	vPstNum1 = 200 '// 팡팡척척 찍찍이 캐치볼(캐치볼)(상품번호-1)
	vPstNum2 = 10 '// 폭스바겐 마이크로버스 60주년 민트(마이크로버스)(상품번호-2)
	vPstNum3 = 300 '// 플레이모빌 미스터리 피규어 시리즈9(플레이모빌)(상품번호-3)
	vPstNum4 = 6 '// INSTAX MINI 8(컬러랜덤)(인스탁스)(상품번호-4)
	vPstNum5 = 1 '// 스티키몬스터 보조배터리(스티키몬스터)(상품번호-5)
	vPstNum6 = 10000 '// 200 마일리지(200마일리지)(상품번호-6)
	vPstNum7 = 18 '// 델리삭스 양말(양말)(상품번호-7)
	vPstNum8 = 0 '// 100 마일리지(무제한)(100마일리지)(상품번호-8)

	vPstNum9 = 150 '// 앨리스카드(앨리스카드)(상품번호-9)
	vPstNum10 = 3 '// 아이리버 블루투스 스피커 사운드 미니바(블루투스스피커)(상품번호-10)
	vPstNum11 = 3 '// 샤오미 액션캠(액션캠)(상품번호-11)
	vPstNum12 = 2 '// 램플로우 더어스(램플로우)(상품번호-12)
	vPstNum13 = 5 '// 바바파파 수면램프(수면램프)(상품번호-13)
	vPstNum14 = 356 '// 에코백(에코백)(상품번호-14)
	vPstNum15 = 62 '// 멀티비타민 오렌지맛 구미(멀티비타민)(상품번호-15)
	vPstNum16 = 0 '// 100 마일리지(무제한)(100마일리지)(상품번호-16)

	''총 응모자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_temp.dbo.tbl_event_70029"
	sqlstr = sqlstr & " where convert(varchar(10),regdate,120) ='"&returndate&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	''팡팡척척 찍찍이 캐치볼(캐치볼)(상품번호-1) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=1 And sub_opt3='캐치볼' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt1 = rsget(0)
	End IF
	rsget.close

	''폭스바겐 마이크로버스 60주년 민트(마이크로버스)(상품번호-2) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=2 And sub_opt3='마이크로버스' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt2 = rsget(0)
	End IF
	rsget.close

	''플레이모빌 미스터리 피규어 시리즈9(플레이모빌)(상품번호-3) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=3 And sub_opt3='플레이모빌' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt3 = rsget(0)
	End IF
	rsget.close

	''INSTAX MINI 8(컬러랜덤)(인스탁스)(상품번호-4) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=4 And sub_opt3='인스탁스' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt4 = rsget(0)
	End IF
	rsget.close

	''스티키몬스터 보조배터리(스티키몬스터)(상품번호-5) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=5 And sub_opt3='스티키몬스터' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt5 = rsget(0)
	End IF
	rsget.close

	''200 마일리지(200마일리지)(상품번호-6) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=6 And sub_opt3='200마일리지' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt6 = rsget(0)
	End IF
	rsget.close

	''델리삭스 양말(양말)(상품번호-7) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=7 And sub_opt3='양말' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt7 = rsget(0)
	End IF
	rsget.close

	''앨리스카드(앨리스카드)(상품번호-9) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=9 And sub_opt3='앨리스카드' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt9 = rsget(0)
	End IF
	rsget.close

	''아이리버 블루투스 스피커 사운드 미니바(블루투스스피커)(상품번호-10) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=10 And sub_opt3='블루투스스피커' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt10 = rsget(0)
	End IF
	rsget.close

	''샤오미 액션캠(액션캠)(상품번호-11) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=11 And sub_opt3='액션캠' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt11 = rsget(0)
	End IF
	rsget.close

	''램플로우 더어스(램플로우)(상품번호-12) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=12 And sub_opt3='램플로우' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt12 = rsget(0)
	End IF
	rsget.close

	''바바파파 수면램프(수면램프)(상품번호-13) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=13 And sub_opt3='수면램프' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt13 = rsget(0)
	End IF
	rsget.close

	''에코백(에코백)(상품번호-14) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=14 And sub_opt3='에코백' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt14 = rsget(0)
	End IF
	rsget.close

	''멀티비타민 오렌지맛 구미(멀티비타민)(상품번호-15) 당첨자 수
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2=15 And sub_opt3='멀티비타민' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt15 = rsget(0)
	End IF
	rsget.close

	''100 마일리지(무제한)(100마일리지)(상품번호-8,16)
	sqlstr = "select count(*) as cnt "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' And sub_opt2 in (8, 16) And sub_opt3='100마일리지' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		wincnt16 = rsget(0)
	End IF
	rsget.close

%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>정기세일 빙고게임</strong></th>
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
	<th colspan="12"><strong>날짜</strong></th>
</tr>
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70029_manage.asp?returndate=2016-04-18">2016-04-18 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70029_manage.asp?returndate=2016-04-19">2016-04-19 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70029_manage.asp?returndate=2016-04-20">2016-04-20 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70029_manage.asp?returndate=2016-04-21">2016-04-21 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70029_manage.asp?returndate=2016-04-22">2016-04-22 (금)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70029_manage.asp?returndate=2016-04-23">2016-04-23 (토)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70029_manage.asp?returndate=2016-04-24">2016-04-24 (일)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70029_manage.asp?returndate=2016-04-25">2016-04-25 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70029_manage.asp?returndate=2016-04-26">2016-04-26 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/inc_70029_manage.asp?returndate=2016-04-27">2016-04-27 (수)</a></td>
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
		<Td colspan="12"><font size="5">기준일 : <%=returndate%>, 총 응모자 : <%=totalcnt%>명, 100마일리지 발급(비당첨) : <%=wincnt16%>개</font></td>
		<!--<td colspan="10"><font size="4" color="blue">현재확률 <br> 1등 0.05 % <br> 2등 0.5 % <br> 3등 20 % <br></font></td>-->
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>팡팡척척 찍찍이 캐치볼(<%=vPstNum1%>)</strong></th>
		<th><strong>폭스바겐 마이크로버스(<%=vPstNum2%>)</strong></th>
		<th><strong>플레이모빌 미스터리 피규어(<%=vPstNum3%>)</strong></th>
		<th><strong>INSTAX MINI 8(<%=vPstNum4%>)</strong></th>
		<th><strong>스티키몬스터 보조배터리(<%=vPstNum5%>)</strong></th>
		<th><strong>200 마일리지(<%=vPstNum6%>)</strong></th>
		<th><strong>델리삭스 양말(<%=vPstNum7%>)</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= wincnt1 %><br></td>
		<td bgcolor=""><%= wincnt2 %><br></td>
		<td bgcolor=""><%= wincnt3 %></td>
		<td bgcolor=""><%= wincnt4 %></td>
		<td bgcolor=""><%= wincnt5 %></td>
		<td bgcolor=""><%= wincnt6 %></td>
		<td bgcolor=""><%= wincnt7 %></td>
	</tr>
	<tr>
		<td colspan="12" height="20"></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>앨리스카드(<%=vPstNum9%>)</strong></th>
		<th><strong>아이리버 블루투스 스피커(<%=vPstNum10%>)</strong></th>
		<th><strong>샤오미 액션캠(<%=vPstNum11%>)</strong></th>
		<th><strong>램플로우 더어스(<%=vPstNum12%>)</strong></th>
		<th><strong>바바파파 수면램프(<%=vPstNum13%>)</strong></th>
		<th><strong>에코백(<%=vPstNum14%>)</strong></th>
		<th><strong>멀티비타민 오렌지맛 구미(<%=vPstNum15%>)</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= wincnt9 %><br></td>
		<td bgcolor=""><%= wincnt10 %><br></td>
		<td bgcolor=""><%= wincnt11 %></td>
		<td bgcolor=""><%= wincnt12 %></td>
		<td bgcolor=""><%= wincnt13 %></td>
		<td bgcolor=""><%= wincnt14 %></td>
		<td bgcolor=""><%= wincnt15 %></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->