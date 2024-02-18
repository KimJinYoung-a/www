<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 2018 4월 정기 이벤트 매일리지 푸쉬알림 신청자 보기
' History : 2014.07.01 이종화
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<title>매일리지푸쉬알람신청현황</title>
</head>
<body>
<% If GetEncLoginUserID()="thensi7" Or GetEncLoginUserID()="greenteenz" Or GetEncLoginUserID()="ley330" Or GetEncLoginUserID()="ttlforyou" Or GetEncLoginUserId="yangpa" Then %>
<div class="heightGrid">
	<div class="mainSection">
		<div class="container">
		external_id<br>
		<%
			Dim query1, external_id
			query1 = ""
			query1 = query1 + "	Select mp.idx, mp.userid, mp.SendDate, mp.SendStatus, mp.Regdate, l.useq*3 as useq "
			query1 = query1 + "	From db_temp.[dbo].[tbl_maeliagePushMay] mp "
			query1 = query1 + "	inner join db_user.dbo.tbl_logindata l on mp.userid = l.userid "
			query1 = query1 + "	WHERE mp.SendStatus='N'  "
'			query1 = query1 + "		AND mp.userid='thensi7' "
			query1 = query1 + "		And Convert(varchar(10), mp.SendDate, 120) = convert(varchar(10), getdate(), 120) "
			rsget.Open query1,dbget, adOpenForwardOnly, adLockReadOnly
			If Not(rsget.bof Or rsget.eof) Then
				Do Until rsget.eof

					Response.write rsget("useq")&"<br>"

				rsget.movenext
				Loop
			Else
				response.write "발송할 대상자가 없습니다."
				response.End
			End If
			rsget.close
		%>
		</div>
	</div>
</div>
<% Else %>
권한이 없습니다.
<% End If %>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->