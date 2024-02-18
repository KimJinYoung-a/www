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
	dim arrList, i, returncnt
	Dim eCode, userid, sqlStr
	Dim pdname1, pdname2, pdname3, pdname4
	Dim returnuserid  : returnuserid = 	request("returnval")

	If returnuserid = "" Then returnuserid = "a"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  66148
	Else
		eCode   =  71111
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
<script type="text/javascript">
	function searchFrm(){
		frm.submit();
	}
</script>

<form name="frm" action="iframe_71111_manage_cs.asp" method="get">
<table class="table" style="width:90%;">
	<tr bgcolor="#ABF200">
		<td>
			[참여이벤트] 도리를 찾아서 [ 이벤트코드 : <%=eCode%> ] 당첨자 검색
		</td>
	</tr>
	<tr bgcolor="#00D8FF">
		<td>
			응모자 ID <input type="text" name="returnval" class="button" size="10" maxlength="20">
			<input type="button" class="button" value="검색" onclick="searchFrm('');">
		</td>
	</tr>
</table>
</form>

<% If returnuserid <> "a" Then %>
	<table class="table" style="width:90%;">
		<tr align="center" bgcolor="#B2EBF4">
		<b>
			<td>
				응모자 ID
			</td>
			<td>
				당첨 상품명
			</td>
			<td>
				당첨 일자
			</td>
		</b>
		</tr>
	<%
		sqlstr = "select userid, sub_opt1, sub_opt2, sub_opt3, regdate "
		sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
		sqlstr = sqlstr & " where evt_code='"& eCode &"' And userid='"&returnuserid&"' "
		rsget.Open sqlstr, dbget, 1

		IF Not rsget.EOF Then
			Do Until rsget.eof
	%>
				<tr align="center" bgcolor="#D4F4FA">
					<td>
						<%=rsget("userid")%>
					</td>
					<td>
					<%
						If rsget("sub_opt2") = "11111" Then
							response.write "시사회초대권"
						ElseIf rsget("sub_opt2") = "22222" Then
							response.write "트럼프 카드"
						ElseIf rsget("sub_opt2") = "33333" Then
							response.write "아이폰6 케이스"
						End If
					%>
					</td>
					<td>
						<%=rsget("regdate")%>
					</td>
				</tr>
	<%
			rsget.movenext
			Loop
	%>

	<%
		Else
	%>
				<tr align="center" bgcolor="#D4F4FA">
					<td colspan="6">
						당첨 내역이 없습니다.
					</td>
				</tr>

	<%
		END IF
		rsget.Close
	%>
	</table>
<% End If %>
<!-- #include virtual="/lib/db/dbclose.asp" -->