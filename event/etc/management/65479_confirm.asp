<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 비밀의방 이벤트 당첨자 확인
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
	Dim vCouponCnt, confirmUserid

	confirmUserid = request("cuid")

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode = 64855
	Else
		eCode = 65479
	End If

If userid="thensi7" Or userid="bborami" Or userid="baboytw" Or userid="greenteenz" Or userid="cogusdk" Or userid="jinyeonmi" Or userid="ilovecozie" Or userid="boyishP" Or userid="1010cs" Then

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
<script>

	function goConfirm()
	{
		if (document.frm.cuid.value=="")
		{
			alert("아이디를 입력해주세요");
			return false;
		}
		else
		{
			document.frm.submit();			
		}
	}

</script>
</head>
<body>

<table class="table" style="width:90%;">
<tr align="center">
	<th><strong>비밀의방 이벤트 당첨자 확인 페이지</strong></th>
</tr>
</table>
<br>
<form name="frm" method="post" action="/event/etc/management/65479_confirm.asp">
<table class="table" style="width:50%;">
	<tr>
		<td>회원 아이디를 입력하세요.</td>
		<td><input type="text" name="cuid">&nbsp;<a href="" onclick="goConfirm();return false;">[확인]</a></td>
	</tr>
</table>
</form>
<% If confirmUserid <> "" Then %>
	<table class="table" style="width:90%;">
		<colgroup>
			<col width="10%" />
			<col width="*" />
			<col width="*" />
			<col width="*" />
		</colgroup>
		<tr align="center" bgcolor="#E6E6E6">
			<th><strong>아이디</strong></th>
			<th><strong>이름</strong></th>
			<th><strong>당첨상품</strong></th>
			<th><strong>당첨일</strong></th>
		</tr>
		<%
			''당첨자
			sqlstr = "select a.userid, b.username, a.sub_opt3, a.regdate "
			sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript A"
			sqlstr = sqlstr & " inner join db_user.dbo.tbl_user_n B on a.userid = b.userid "
			sqlstr = sqlstr & " where A.evt_code='"& eCode &"' And A.userid='"&confirmUserid&"' "
			rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly

			If Not rsget.Eof Then
				Do Until rsget.eof
		%>
			<tr bgcolor="#FFFFFF" align="center">
				<td bgcolor=""><%= rsget("userid") %></td>
				<td bgcolor=""><%= rsget("username")%></td>
				<td bgcolor=""><%= rsget("sub_opt3")%></td>
				<td bgcolor=""><%= rsget("regdate") %></td>
			</tr>
		<%
				rsget.movenext
				Loop
		%>
		<% Else %>
			<tr bgcolor="#FFFFFF" align="center">
				<td bgcolor="" colspan="4">당첨내역이 없습니다.</td>
			</tr>
		<% 
			End IF
			rsget.close
		%>
<% End If %>
<!-- #include virtual="/lib/db/dbclose.asp" -->