<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
'###########################################################
' Description : 2016  비밀의방
' History : 2016-05-20 유태욱
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
	dim arrList, i, returncnt
	Dim eCode1, eCode2, userid, sqlStr
	Dim pdname1, pdname2, pdname3, pdname4
	Dim returnuserid  : returnuserid = 	request("returnval")

	If returnuserid = "" Then returnuserid = "a"

	userid=getloginuserid()

	IF application("Svr_Info") = "Dev" THEN
		eCode1   =  66101
		eCode2   =  66101
	Else
		eCode1  =  70714
		eCode2  =  70715
	End If
  
If userid="baboytw" Or userid="greenteenz" Or userid= "helele223" Or userid= "thensi7" Then

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

<form name="frm" action="inc_70714_manage_cs.asp" method="get">
<table class="table" style="width:90%;">
	<tr bgcolor="#ABF200">
		<td>
			<font><b>비밀의방 응모자 및 당첨자  검색</b></font>
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

<br><br><br>
<% If returnuserid <> "a" Then %>

	<table class="table" style="width:90%;">
		<tr align="center" bgcolor="#B2EBF4">
			<td>
				<font><b>70715 비밀의방 신청 내역</b></font>
			</td>
		</tr>
		<tr align="center" bgcolor="#B2EBF4">
		<b>
			<td>
				응모자 ID
			</td>
			<td>
				신청 일자
			</td>
		</b>
		</tr>
	<%
		sqlstr = "select userid, regdate "
		sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
		sqlstr = sqlstr & " where evt_code='"& eCode2 &"' And userid='"&returnuserid&"' "
		rsget.Open sqlstr, dbget, 1

		IF Not rsget.EOF Then
			Do Until rsget.eof
	%>
				<tr align="center" bgcolor="#D4F4FA">
					<td>
						<%=rsget("userid")%>
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
						신청 내역이 없습니다.
					</td>
				</tr>

	<%
		END IF
		rsget.Close
	%>
	</table>
<% End If %>

<br><br><br>
<% If returnuserid <> "a" Then %>

	<table class="table" style="width:90%;">
		<tr align="center" bgcolor="#B2EBF4">
			<td>
				<font><b>70714 비밀의방 당첨 내역</b></font>
			</td>
		</tr>
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
		sqlstr = "select userid, sub_opt2, regdate "
		sqlstr = sqlstr & " from db_event.dbo.tbl_event_subscript"
		sqlstr = sqlstr & " where evt_code='"& eCode1 &"' And userid='"&returnuserid&"' "
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
						if rsget("sub_opt2") = "" then
							response.write "무료배송 쿠폰"
						elseif rsget("sub_opt2") = "1111111" then
							response.write "폴라로이드 디지털 즉석 카메라"
						elseif rsget("sub_opt2") = "2222222" then
							response.write "아이리버 블루투스 스피커"
						elseif rsget("sub_opt2") = "3333333" then
							response.write "베스킨라빈스 싱글레귤러"
						else
							response.write "무료배송 쿠폰"
						end if
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