<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 비밀의방 이벤트
' History : 2015-08-17 원승현
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
	Dim vCouponCnt, vPrdCnt1, vPrdCnt2, vPrdCnt3, vPrdName1, vPrdName2, vPrdName3, vPrdCode1, vPrdCode2, vPrdCode3, vinviteCnt, vkakaocnt

	If returndate = "" Then returndate = Date()
	'returndate = "2015-06-19"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode = 64855
	Else
		eCode = 65479
	End If

If userid="thensi7" Or userid="bborami" Or userid="baboytw" Or userid="greenteenz" Or userid="cogusdk" Or userid="jinyeonmi" Then

Else
	response.write "<script>alert('관계자만 볼 수 있는 페이지 입니다.');window.close();</script>"
	response.End
End If


	'// 일자별 상품갯수 셋팅
	Select Case Trim(returndate)

		Case "2015-08-17"
			vPrdCnt1 = 1
			vPrdName1 = "핏 비트 스마트 밴드"
			vPrdCode1 = "1265396"

			vPrdCnt2 = 200
			vPrdName2 = "스티키 몬스터 노트"
			vPrdCode2 = "1135303"

			vPrdCnt3 = 299
			vPrdName3 = "스플래쉬 펭귄 자동칫솔 걸이"
			vPrdCode3 = "1295437"

		Case "2015-08-18"
			vPrdCnt1 = 1
			vPrdName1 = "Pixie Bag"
			vPrdCode1 = "1068178"

			vPrdCnt2 = 250
			vPrdName2 = "무민 네일케어 세트"
			vPrdCode2 = "1330312"

			vPrdCnt3 = 250
			vPrdName3 = "딸기 타르트 비누"
			vPrdCode3 = "837392"

		Case "2015-08-19"
			vPrdCnt1 = 10
			vPrdName1 = "미니언 캐릭터 USB 메모리 (8G)"
			vPrdCode1 = "1292307"

			vPrdCnt2 = 250
			vPrdName2 = "러버덕"
			vPrdCode2 = "1102543"

			vPrdCnt3 = 240
			vPrdName3 = "애니멀 파우치 플랫"
			vPrdCode3 = "1328415"

		Case "2015-08-20"
			vPrdCnt1 = 1
			vPrdName1 = "Q5 보조배터리 7200mAh"
			vPrdCode1 = "1328232"

			vPrdCnt2 = 200
			vPrdName2 = "Canvas pouch"
			vPrdCode2 = "1320974"

			vPrdCnt3 = 299
			vPrdName3 = "1 PARAGRAPH DIARY"
			vPrdCode3 = "1235463"

		Case "2015-08-21"
			vPrdCnt1 = 1
			vPrdName1 = "스마트빔 큐브 미니빔 프로젝터"
			vPrdCode1 = "1151190"

			vPrdCnt2 = 10
			vPrdName2 = "샤오미 미스케일 스마트체중계"
			vPrdCode2 = "1284396"

			vPrdCnt3 = 489
			vPrdName3 = "미니자명종(화이트)"
			vPrdCode3 = "736701"

		Case "2015-08-24"
			vPrdCnt1 = 1
			vPrdName1 = "핏 비트 스마트 밴드"
			vPrdCode1 = "1265396"

			vPrdCnt2 = 100
			vPrdName2 = "스티키 몬스터 노트"
			vPrdCode2 = "1135303"

			vPrdCnt3 = 399
			vPrdName3 = "SMILES SWITCH LED LIGHT"
			vPrdCode3 = "1133679"

		Case "2015-08-25"
			vPrdCnt1 = 1
			vPrdName1 = "수화물용 캐리어(핑크)"
			vPrdCode1 = "939299"

			vPrdCnt2 = 50
			vPrdName2 = "무민 네일케어 세트"
			vPrdCode2 = "1330312"

			vPrdCnt3 = 449
			vPrdName3 = "딸기 타르트 비누"
			vPrdCode3 = "837392"

		Case "2015-08-26"
			vPrdCnt1 = 10
			vPrdName1 = "미니언 캐릭터 USB 메모리 (8G)"
			vPrdCode1 = "1292307"

			vPrdCnt2 = 50
			vPrdName2 = "러버덕"
			vPrdCode2 = "1102543"

			vPrdCnt3 = 440
			vPrdName3 = "애니멀 파우치 플랫"
			vPrdCode3 = "1328415"

		Case "2015-08-27"
			vPrdCnt1 = 1
			vPrdName1 = "레카코후 그늘막(light blue)"
			vPrdCode1 = "1308234"

			vPrdCnt2 = 50
			vPrdName2 = "Canvas pouch"
			vPrdCode2 = "1320974"

			vPrdCnt3 = 449
			vPrdName3 = "1 PARAGRAPH DIARY"
			vPrdCode3 = "1235463"

		Case "2015-08-28"
			vPrdCnt1 = 1
			vPrdName1 = "스마트빔 큐브 미니빔 프로젝터"
			vPrdCode1 = "1151190"

			vPrdCnt2 = 10
			vPrdName2 = "샤오미 미스케일 스마트체중계"
			vPrdCode2 = "1284396"

			vPrdCnt3 = 489
			vPrdName3 = "삭스신드롬 양말(랜덤)"
			vPrdCode3 = "1333740"

		Case Else
			vPrdCnt1 = 1
			vPrdName1 = "핏 비트 스마트 밴드"
			vPrdCode1 = "1265396"

			vPrdCnt2 = 200
			vPrdName2 = "스티키 몬스터 노트"
			vPrdCode2 = "1135303"

			vPrdCnt3 = 299
			vPrdName3 = "스플래쉬 펭귄 자동칫솔 걸이"
			vPrdCode3 = "1295437"
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

	'// 1등 상품 당첨자수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='"&vPrdCode1&"' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum1 = rsget(0)
	End IF
	rsget.close
	
	'// 2등 상품 당첨자수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='"&vPrdCode2&"' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum2 = rsget(0)
	End IF
	rsget.close

	'// 3등 상품 당첨자수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And  sub_opt2='"&vPrdCode3&"' "
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

	If Not rsget.Eof Then
		vNum3 = rsget(0)
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

	'// 비밀의방 신청자수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='65477' and sub_opt1 ='"&returndate&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		vinviteCnt = rsget(0)
	End IF
	rsget.close

	'// 카카오클릭수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_log.[dbo].[tbl_caution_event_log] "
	sqlstr = sqlstr & " where evt_code='65477' and convert(varchar(10), regdate, 120) ='"&returndate&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		vkakaocnt = rsget(0)
	End IF
	rsget.close



%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>비밀의방 이벤트</strong></th>
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
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65479_manage.asp?returndate=2015-08-17">2015-08-17 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65479_manage.asp?returndate=2015-08-18">2015-08-18 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65479_manage.asp?returndate=2015-08-19">2015-08-19 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65479_manage.asp?returndate=2015-08-20">2015-08-20 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65479_manage.asp?returndate=2015-08-21">2015-08-21 (금)</a></td>
</tr>																				            
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65479_manage.asp?returndate=2015-08-24">2015-08-24 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65479_manage.asp?returndate=2015-08-25">2015-08-25 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65479_manage.asp?returndate=2015-08-26">2015-08-26 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65479_manage.asp?returndate=2015-08-27">2015-08-27 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_65479_manage.asp?returndate=2015-08-28">2015-08-28 (금)</a></td>
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
		<Td align="center"><font size="3">기준일 <br><%=returndate%></font></td>
		<td align="center"><font size="3">친구초대수 : <%=FormatNumber(vkakaocnt, 0)%>명</font></td>
		<td align="center"><font size="3">신청자수 : <%=FormatNumber(vinviteCnt, 0)%>명</font></td>
		<td colspan="2"><font size="3" color="blue">※ 현재확률<br> - <%=vPrdName1%> : 0.1%, <%=vPrdName2%> : 0.5%, <%=vPrdName3%> : 5%</font></td>

	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong><%=vPrdName1%> [ <%=vPrdCnt1%> ]</strong></th>
		<th><strong><%=vPrdName2%> [ <%=vPrdCnt2%> ]</strong></th>
		<th><strong><%=vPrdName3%> [ <%=vPrdCnt3%> ]</strong></th>
		<th><strong>쿠폰 당첨자수(무제한)</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= vNum1%><br><font color="RED">(남은수량 : <%= vPrdCnt1-vNum1 %> )</font></td>
		<td bgcolor=""><%= vNum2%><br><font color="RED">(남은수량 : <%= vPrdCnt2-vNum2 %> )</font></td>
		<td bgcolor=""><%= vNum3 %><br><font color="RED">(남은수량 : <%= vPrdCnt3-vNum3 %> )</font></td>
		<td bgcolor=""><%= vCouponCnt %></td>
	</tr>
</table>
<br>
<font color="red" size="1">

</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->