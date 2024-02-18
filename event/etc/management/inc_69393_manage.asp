<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
'####################################################
' Description : 3월 신규고객 이벤트
' History : 2016-03-02 이종화 생성
'####################################################
%>
<!-- #include Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<%
	Dim userid 
	Dim eCode , strSql

	userid = getloginuserid()

	If userid = "motions" Or userid = "helele223" Then
	Else
		response.write "<script>alert('정다진 대리님 만 볼 수 있는 페이지 입니다.');window.close();</script>"
		response.End
	End If

	IF application("Svr_Info") = "Dev" THEN
		eCode   =  64908
	Else
		eCode   =  69393
	End If
%>
<% If userid = "motions" Or userid = "helele223" Then %>
<style type="text/css">
.table {width:900px; margin:0 auto; font-family:'malgun gothic'; border-collapse:collapse;}
.table th {padding:12px 0; font-size:13px; font-weight:bold;  color:#fff; background:#444;}
.table td {padding:12px 3px; font-size:12px; border:1px solid #ddd; border-bottom:2px solid #ddd;}
.table td.lt {text-align:left; padding:12px 10px;}
.tBtn {display:inline-block; border:1px solid #2b90b6; background:#03a0db; padding:0 10px 2px; line-height:26px; height:26px; font-weight:bold; border-radius:5px; color:#fff !important;}
.tBtn:hover {text-decoration:none;}
.table td input {border:1px solid #ddd; height:30px; padding:0 3px; font-size:14px; color:#ec0d02; text-align:right;}
.lt { float:left;}
div .lt:nth-child(odd) { float:left; padding-top:10px;}
.lr { float:left; clear:both:}
</style>
<table class="table" style="width:50%;">
<tr>
	<td>
		※ NOTICE ※</br>
		※ 당첨된 회원이 있을경우 아래의 리스트에 나옵니다.
	</td>
</tr>
</table>
<table class="table" style="width:50%;">
	<colgroup>
		<col width="5.88%" />
		<col width="5.88%" />
		<col width="5.88%" />
	</colgroup>
	<tr align="center" bgcolor="#E6E6E6">
		<th><strong>회원ID</strong></th>
		<th><strong>당첨일</strong></th>
		<th><strong>응모기기(PC/MOBILE)</strong></th>
	</tr>
	<tr bgcolor="#FFFFFF">
	<%
		strSql = " select userid , regdate , device from db_event.dbo.tbl_event_subscript "
		strSql = strSql & " where evt_code = '"& eCode &"' and sub_opt2 = 1 "
		strSql = strSql & " order by regdate asc "
		'Response.write strSql
		rsget.CursorLocation = adUseClient
		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly
		If Not rsget.Eof Then
			Do Until rsget.eof
	%>
	<td bgcolor="" style="text-align:center"><%= rsget("userid") %></td>
	<td bgcolor="" style="text-align:center"><%= rsget("regdate") %></td>
	<td bgcolor="" style="text-align:center"><%= rsget("device") %></td>
	<%
			rsget.movenext
			Loop
		End IF
		rsget.close
	%>
	</tr>
</table>
<% End If %>
<!-- #include virtual="/lib/db/dbclose.asp" -->