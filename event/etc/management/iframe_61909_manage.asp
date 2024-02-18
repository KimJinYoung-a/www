<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 61909 bml 이벤트
' History : 2015-05-02 원승현
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
		eCode   =  61768
	Else
		eCode   =  61909
	End If






If userid="thensi7" Or userid="bborami" Or userid="baboytw"Then

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

	'// 프로젝터 당첨자 아이디
	sqlstr = "select top 1 userid "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt3='projector' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		ipaduserid = rsget(0)
	End IF
	rsget.close

	'// lg 스마트빔 당첨자수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt3='projector' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		ipadcnt = rsget(0)
	End IF
	rsget.close

	'// 아이리버 스피커 당첨자 수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt3='speaker' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		secproductuserid = rsget(0)
	End IF
	rsget.close

	'// 장미꽃 밴드 당첨자 수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt3='band' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		thrproductuserid = rsget(0)
	End IF
	rsget.close


	'// 쿠폰 당첨자 수
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&Left(nowdate, 10)&"' And sub_opt3='coupon' "
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
		<td colspan="10">현재확률 lg스마트빔 0.5%, 아이리버 스피커 1%, 장미꽃밴드 50%</td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>lg 스마트빔 당첨자 아이디</strong></th>
		<th><strong>아이리버 스피커 당첨자수(2)</strong></th>
		<th><strong>장미꽃밴드 당첨자수(195)</strong></th>
		<th><strong>쿠폰 당첨자수(무제한)</strong></th>
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