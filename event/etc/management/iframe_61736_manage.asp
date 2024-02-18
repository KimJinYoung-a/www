<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 61736 주인을 찾습니다.
' History : 2015-04-27 원승현
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

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  61762
	Else
		eCode   =  61736
	End If


	Select Case Left(nowdate, 10)
		Case "2015-04-27"
			DayName = "mon"

			pdName1 = "애플 아이패드 미니3 16GB"
			evtItemCode1 = "1182605"
			evtItemCnt1 = "1"
			DayRightNumber = "1235"

			pdName2 = "단보 보조배터리(랜덤)"
			evtItemCode2 = "1190691"
			evtItemCnt2 = "50"

			pdName3 = "울랄라 CANVAS POUCH(랜덤)"
			evtItemCode3 = "1060478"
			evtItemCnt3 = "100"

			pdName4 = "스누피시리즈(랜덤)"
			evtItemCode4 = "1137825"
			evtItemCnt4 = "300"

		Case "2015-04-28"
			DayName = "tue"

			pdName1 = "애플 아이패드 미니3 16GB"
			evtItemCode1 = "1182605"
			evtItemCnt1 = "1"
			DayRightNumber = "8687"

			pdName2 = "샤오미 5,000mAh"
			evtItemCode2 = "1234675"
			evtItemCnt2 = "138"

			pdName3 = "무민 카드지갑"
			evtItemCode3 = "1239727"
			evtItemCnt3 = "396"

			pdName4 = "아이스바 비누(컬러랜덤)"
			evtItemCode4 = "914161"
			evtItemCnt4 = "197"

		Case "2015-04-29"
			DayName = "wed"

			pdName1 = "애플 아이패드 미니3 16GB"
			evtItemCode1 = "1182605"
			evtItemCnt1 = "1"
			DayRightNumber = "8282"

			pdName2 = "엄브렐러 보틀"
			evtItemCode2 = "1171539"
			evtItemCnt2 = "85"

			pdName3 = "아이리버 이어마이크(컬러 랜덤)"
			evtItemCode3 = "1234645"
			evtItemCnt3 = "120"

			pdName4 = "무민 마스코트 피규어(랜덤)"
			evtItemCode4 = "1229782"
			evtItemCnt4 = "250"

		Case "2015-04-30"
			DayName = "thu"

			pdName1 = "애플 아이패드 미니3 16GB"
			evtItemCode1 = "1182605"
			evtItemCnt1 = "1"
			DayRightNumber = "5882"

			pdName2 = "비밀의 정원"
			evtItemCode2 = "1234646"
			evtItemCnt2 = "29"

			pdName3 = "Card case(랜덤)"
			evtItemCode3 = "1146210"
			evtItemCnt3 = "66"

			pdName4 = "Monotask 한달 플래너(랜덤)"
			evtItemCode4 = "1193295"
			evtItemCnt4 = "336"

		Case "2015-05-01"
			DayName = "fri"

			pdName1 = "애플 아이패드 미니3 16GB"
			evtItemCode1 = "1182605"
			evtItemCnt1 = "1"
			DayRightNumber = "1551"

			pdName2 = "무민 원형접시(2size)"
			evtItemCode2 = "1181799"
			evtItemCnt2 = "49"

			pdName3 = "캡슐 태엽 토이(랜덤)"
			evtItemCode3 = "1202920"
			evtItemCnt3 = "90"

			pdName4 = "야광 달빛스티커 GRAY (small)"
			evtItemCode4 = "1234674"
			evtItemCnt4 = "193"

	End Select



If userid="winnie" Or userid="gawisonten10" Or userid ="greenteenz" Or userid = "edojun" Or userid = "baboytw" Or userid = "tozzinet" Or userid = "motions" Or userid="thensi7" Then

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
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"'"
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		totalcnt = rsget(0)
	End IF
	rsget.close

	'// 아이패드 당첨자 아이디
	sqlstr = "select top 1 userid "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt2='"&evtItemCode1&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		ipaduserid = rsget(0)
	End IF
	rsget.close

	'// 아이패드 당첨자수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt2='"&evtItemCode1&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		ipadcnt = rsget(0)
	End IF
	rsget.close

	'// 두번째 상품 당첨자 수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt2='"&evtItemCode2&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		secproductuserid = rsget(0)
	End IF
	rsget.close

	'// 세번째 상품 당첨자 수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt2='"&evtItemCode3&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		thrproductuserid = rsget(0)
	End IF
	rsget.close


	'// 네번째 상품 당첨자 수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt2='"&evtItemCode4&"' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		forproductuserid = rsget(0)
	End IF
	rsget.close



%>
<table class="table" style="width:90%;">

	<colgroup>
		<col width="10%" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
		<col width="*" />
	</colgroup>
	<tr>
		<Td colspan="2">기준일 : <%=Left(nowdate, 10)%></td>
		<td colspan="10">현재확률 무민접시 1%, 캡슐태엽토이 2%, 야광달빛스티커 3%</td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>아이패드 당첨자 아이디</strong></th>
		<th><strong><%=pdName2%> 당첨자수(<%=evtItemCnt2%>)</strong></th>
		<th><strong><%=pdName3%> 당첨자수(<%=evtItemCnt3%>)</strong></th>
		<th><strong><%=pdName4%> 당첨자수(<%=evtItemCnt4%>)</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %>명</td>
		<td bgcolor=""><%= ipaduserid %>(<%=ipadcnt%>)</td>
		<td bgcolor=""><%= secproductuserid %>명</td>
		<td bgcolor=""><%= thrproductuserid %>명</td>
		<td bgcolor=""><%= forproductuserid %>명</td>
	</tr>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->