<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : tab2 : [참여이벤트] 도리를 찾아서
' History : 2016.06.10 김진영 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim userid, eCode, sqlstr, arrList, i, arrList2, j
Dim vNum1, vNum2, vNum3, vNum4, vNum5 '// 상품별 셋팅
Dim vPstNum1, vPstNum2, vPstNum3, vPstNum4, vPstNum5 '// 일자별 한정갯수 셋팅

userid = getloginuserid()
IF application("Svr_Info") = "Dev" THEN
	eCode = 66148
Else
	eCode = 71111
End If

If userid="kjy8517" Or userid="bborami" Or userid="motions" Or userid="thensi7"  Or userid="baboytw" Or userid="greenteenz" Or userid="1010cs" Then

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
sqlstr = ""
sqlstr = sqlstr & " SELECT "
sqlstr = sqlstr & " COUNT(*) as totcnt "
sqlstr = sqlstr & " ,convert(varchar(10),regdate,120) + ' (' + Left(datename(dw, convert(varchar(10), regdate, 120)),1) + ')' "
sqlstr = sqlstr & " ,isnull(sum(CASE WHEN sub_opt2 = '11111' THEN 1 ELSE 0 END),0) as prize1 "
sqlstr = sqlstr & " ,isnull(sum(CASE WHEN sub_opt2 = '22222' THEN 1 ELSE 0 END),0) as prize2 "
sqlstr = sqlstr & " ,isnull(sum(CASE WHEN sub_opt2 = '33333' THEN 1 ELSE 0 END),0) as prize3 "
sqlstr = sqlstr & " ,convert(varchar(10),regdate,120) "
sqlstr = sqlstr & " FROM db_event.dbo.tbl_event_subscript "
sqlstr = sqlstr & " WHERE evt_code='"&eCode&"'  "
sqlstr = sqlstr & " and regdate >= '2016-06-13'  "
sqlstr = sqlstr & " GROUP BY convert(varchar(10), regdate, 120) "
sqlstr = sqlstr & " ORDER BY convert(varchar(10), regdate, 120) "
rsget.Open sqlstr,dbget
If not rsget.EOF Then
	arrList = rsget.getrows
End If
rsget.close
%>
<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>도리를 찾아서 이벤트</strong></th>
</tr>
</table>
<table class="table" style="width:90%;">
<tr bgcolor="#FFFFFF" align="center">
	<td>날짜</td>
	<td>총 응모자</td>
	<td colspan="2">시사회초대권 (10%)</td>
	<td colspan="2">트럼프 카드 (5%)</td>
	<td colspan="2">아이폰6 케이스 (3%)</td>
</tr>
<%
IF isArray(arrList) THEN
	For i = 0 to ubound(arrList,2)
		'// 각 상품별 일자별 한정갯수 셋팅
		Select Case Trim(arrList(5, i))
			Case "2016-06-09" '// 이건 테스트 날짜용 셋팅임
				vPstNum1 = 1 '// 시사회초대권
				vPstNum2 = 1 '// 트럼프 카드
				vPstNum3 = 1 '// 아이폰6 케이스
			Case "2016-06-10"
				vPstNum1 = 1 '// 시사회초대권
				vPstNum2 = 1 '// 트럼프 카드
				vPstNum3 = 1 '// 아이폰6 케이스
			Case "2016-06-11"
				vPstNum1 = 1 '// 시사회초대권
				vPstNum2 = 1 '// 트럼프 카드
				vPstNum3 = 1 '// 아이폰6 케이스
			Case "2016-06-12"
				vPstNum1 = 1 '// 시사회초대권
				vPstNum2 = 1 '// 트럼프 카드
				vPstNum3 = 1 '// 아이폰6 케이스
			Case "2016-06-13"
				vPstNum1 = 40 '// 시사회초대권
				vPstNum2 = 30 '// 트럼프 카드
				vPstNum3 = 5 '// 아이폰6 케이스
			Case "2016-06-14"
				vPstNum1 = 71 '// 영화예매권
				vPstNum2 = 51 '// 트럼프 카드
				vPstNum3 = 10 '// 아이폰6 케이스
			Case "2016-06-15"
				vPstNum1 = 30 '// 시사회초대권
				vPstNum2 = 30 '// 트럼프 카드
				vPstNum3 = 0 '// 아이폰6 케이스
			Case "2016-06-16"
				vPstNum1 = 20 '// 시사회초대권
				vPstNum2 = 30 '// 트럼프 카드
				vPstNum3 = 0 '// 아이폰6 케이스
			Case "2016-06-17"
				vPstNum1 = 20 '// 시사회초대권
				vPstNum2 = 10 '// 트럼프 카드
				vPstNum3 = 0 '// 아이폰6 케이스
			Case "2016-06-18"
				vPstNum1 = 0 '// 시사회초대권
				vPstNum2 = 0 '// 트럼프 카드
				vPstNum3 = 0 '// 아이폰6 케이스
			Case "2016-06-19"
				vPstNum1 = 0 '// 시사회초대권
				vPstNum2 = 0 '// 트럼프 카드
				vPstNum3 = 0 '// 아이폰6 케이스
			Case "2016-06-20"
				vPstNum1 = 20 '// 시사회초대권
				vPstNum2 = 10 '// 트럼프 카드
				vPstNum3 = 0 '// 아이폰6 케이스
			Case "2016-06-21"
				vPstNum1 = 10 '// 시사회초대권
				vPstNum2 = 13 '// 트럼프 카드
				vPstNum3 = 0 '// 아이폰6 케이스
			Case "2016-06-22"
				vPstNum1 = 0 '// 시사회초대권
				vPstNum2 = 0 '// 트럼프 카드
				vPstNum3 = 0 '// 아이폰6 케이스
		End Select
%>
<tr bgcolor="#FFFFFF" align="center">
	<td rowspan="3"><%= arrList(1, i) %></td>
	<td rowspan="3"><%= arrList(0, i) %></td>
	<td>일별재고</td>
	<td><%= vPstNum1 %></td>
	<td>일별재고</td>
	<td><%= vPstNum2 %></td>
	<td>일별재고</td>
	<td><%= vPstNum3 %></td>
</tr>
<tr bgcolor="#FFFFFF" align="center">
	<td>당첨수</td>
	<td><font color="blue"><%= arrList(2, i) %></font></td>
	<td>당첨수</td>
	<td><font color="blue"><%= arrList(3, i) %></font></td>
	<td>당첨수</td>
	<td><font color="blue"><%= arrList(4, i) %></font></td>
</tr>
<tr bgcolor="#FFFFFF" align="center" onmouseout="this.style.backgroundColor='#FFFFFF'" onmouseover="this.style.backgroundColor='#F1F1F1'">
	<td>남은수량</td>
	<td>
	<%
		If vPstNum1 - arrList(2, i) = vPstNum1 Then
			response.write vPstNum1 - arrList(2, i)
		Else
			response.write "<font color = 'red'><strong>" & vPstNum1 - arrList(2, i) & "</strong></font>"
		End If
	%>
	</td>
	<td>남은수량</td>
	<td>
	<%
		If vPstNum2 - arrList(3, i) = vPstNum2 Then
			response.write vPstNum2 - arrList(3, i)
		Else
			response.write "<font color = 'red'><strong>" & vPstNum2 - arrList(3, i) & "</strong></font>"
		End If
	%>
	</td>
	<td>남은수량</td>
	<td>
	<%
		If vPstNum3 - arrList(4, i) = vPstNum3 Then
			response.write vPstNum3 - arrList(4, i)
		Else
			response.write "<font color = 'red'><strong>" & vPstNum3 - arrList(4, i) & "</strong></font>"
		End If
	%>
	</td>
</tr>
<%
	Next 
End If
%>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->