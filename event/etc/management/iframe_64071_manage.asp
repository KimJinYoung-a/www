<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : (초)능력자들)
' History : 2015-06-26 유태욱
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
		eCode   =  63801
	Else
		eCode   =  64071
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

	'// 4등
	sqlstr = "select count(*) "
	sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
	sqlstr = sqlstr & " where evt_code='"& eCode &"' and convert(varchar(10),regdate,120) ='"&returndate&"' And sub_opt2='4444444' "
	rsget.Open sqlstr, dbget, 1

	If Not rsget.Eof Then
		secproductuserid = rsget(0)
	End IF
	rsget.close

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

	If returndate<"2015-06-30" Then
		pdName1 = "에어휠"
		pdName2 = "드론캠"
		pdName3 = "선풍기"
		pdName4 = "17차"
		evtItemCnt1 = 1
		evtItemCnt2 = 2
		evtItemCnt3 = 300
		evtItemCnt4 = 2697
	elseif returndate="2015-07-06" Then
		pdName1 = "에어휠"
		pdName2 = "드론캠"
		pdName3 = "선풍기"
		pdName4 = "17차"
		evtItemCnt1 = 1
		evtItemCnt2 = 2
		evtItemCnt3 = 299
		evtItemCnt4 = 2688
	elseif returndate="2015-06-30" Then
		pdName1 = "아이폰6+"
		pdName2 = "보조배터리"
		pdName3 = "플모피규어"
		pdName4 = "핫식스"
		evtItemCnt1 = 1
		evtItemCnt2 = 2
		evtItemCnt3 = 700
		evtItemCnt4 = 2297
	elseif returndate="2015-07-07" Then
		pdName1 = "아이폰6+"
		pdName2 = "보조배터리"
		pdName3 = "플모피규어"
		pdName4 = "핫식스"
		evtItemCnt1 = 1
		evtItemCnt2 = 2
		evtItemCnt3 = 300
		evtItemCnt4 = 2697
	elseif returndate="2015-07-01" or returndate="2015-07-08" Then
		pdName1 = "LG클래식tv"
		pdName2 = "손목시계"
		pdName3 = "비밀의정원"
		pdName4 = "태엽토이"
		evtItemCnt1 = 1
		evtItemCnt2 = 2
		evtItemCnt3 = 100
		evtItemCnt4 = 2898
	elseif returndate="2015-07-02" Then
		pdName1 = "아이패드에어2"
		pdName2 = "레이밴"
		pdName3 = "월리퍼즐"
		pdName4 = "하리보"
		evtItemCnt1 = 1
		evtItemCnt2 = 2
		evtItemCnt3 = 700
		evtItemCnt4 = 2297
	elseif returndate="2015-07-09" Then
		pdName1 = "아이패드에어2"
		pdName2 = "레이밴"
		pdName3 = "월리퍼즐"
		pdName4 = "하리보"
		evtItemCnt1 = 1
		evtItemCnt2 = 2
		evtItemCnt3 = 300
		evtItemCnt4 = 2788
	elseif returndate="2015-07-03"  or returndate="2015-07-04" or returndate="2015-07-05" or returndate>="2015-07-10" Then
		pdName1 = "여행100만"
		pdName2 = "스마트빔"
		pdName3 = "고잉캔들"
		pdName4 = "설레임"
		evtItemCnt1 = 1
		evtItemCnt2 = 2
		evtItemCnt3 = 350
		evtItemCnt4 = 2647
	end if
%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>(초)능력자들</strong></th>
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
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64071_manage.asp?returndate=2015-06-29">2015-06-29 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64071_manage.asp?returndate=2015-06-30">2015-06-30 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64071_manage.asp?returndate=2015-07-01">2015-07-01 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64071_manage.asp?returndate=2015-07-02">2015-07-02 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64071_manage.asp?returndate=2015-07-03">2015-07-03 (금)</a></td>
</tr>																				            
<tr bgcolor="#FFFFFF" align="center">
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64071_manage.asp?returndate=2015-07-06">2015-07-06 (월)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64071_manage.asp?returndate=2015-07-07">2015-07-07 (화)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64071_manage.asp?returndate=2015-07-08">2015-07-08 (수)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64071_manage.asp?returndate=2015-07-09">2015-07-09 (목)</a></td>
	<td><a href="http://www.10x10.co.kr/event/etc/management/iframe_64071_manage.asp?returndate=2015-07-10">2015-07-10 (금)</a></td>
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
		<td colspan="10"><font size="4" color="blue">현재확률 1등 0%, 2등 0.01%, 3등 2%, 4등 5%</font></td>
	</tr>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>총 응모자</strong></th>
		<th><strong>1등 [ <%=pdName1%> ]</strong></th>
		<th><strong>2등 [ <%=pdName2%> ]</strong></th>
		<th><strong>3등 [ <%=pdName3%> ]</strong></th>
		<th><strong>4등 [ <%=pdName4%> ]</strong></th>
		<th><strong>쿠폰 당첨자수(무제한)</strong></th>
		<th><strong>전면배너클릭수</strong></th>
		<th><strong>카카오초대클릭수</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF" align="center">
		<td bgcolor=""><%= totalcnt %></td>
		<td bgcolor=""><%= airuserid%><br><font color="RED">(남은수량 : <%= evtItemCnt1-airuserid %> )</font></td>
		<td bgcolor=""><%= ipaduserid%><br><font color="RED">(남은수량 : <%= evtItemCnt2-ipaduserid %> )</font></td>
		<td bgcolor=""><%= ipadcnt %><br><font color="RED">(남은수량 : <%= evtItemCnt3-ipadcnt %> )</font></td>
		<td bgcolor=""><%= secproductuserid %><br><font color="RED">(남은수량 : <%= evtItemCnt4-secproductuserid %> )</font></td>
		<td bgcolor=""><%= forproductuserid %></td>
		<td bgcolor=""><%= mainbannercnt %></td>
		<td bgcolor=""><%= kakaocnt %></td>
	</tr>
</table>
<br>
<font color="red" size="1">
	■ 6월 29일 3등 1개, 4등 9개 오바된것들 7월6일 수량에서 뺌(적용됨)<br>
	■ 7월 2일 4등 91개 남은거 7월 9일에 추가(적용됨)<br>
	■ 7월 1 4등 1개 남은거 7월 8일에 추가(적용됨)
</font>

<!-- #include virtual="/lib/db/dbclose.asp" -->