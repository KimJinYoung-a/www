<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/apps/nateon/lib/nateon_alarmClass.asp"-->
<%

response.end  ''2017/04/20


	dim userid, arid, orderserial, sqlStr
	userid = Request("uid")
	arid = Request("arid")
	orderserial = Request("ordsn")

	'//텐바이텐 회원정보 확인
	if userid<>"" then
		sqlStr = "Select count(*) from db_user.dbo.tbl_logindata " &_
				" where userid='" & userid & "'"
		rsget.Open sqlStr,dbget,1
		if rsget(0)<=0 then
			Response.Write "<script langauge=javascript>alert('텐바이텐에 가입되지 않은 ID입니다.');</script>"
			userid = ""
		end if
		rsget.Close
	end if

	'//연동정보 확인
	if userid<>"" then
		sqlStr = "Select count(*) from db_my10x10.dbo.tbl_nateon_sync " &_
				" where ten_userid='" & userid & "'"
		rsget.Open sqlStr,dbget,1
		if rsget(0)<=0 then
			Response.Write "<script langauge=javascript>" &_
				"if(confirm('네이트온과 연동되지 않은 ID입니다.\n\n네이트온 알리미 연동페이지를 보시겠습니까?')){" &_
				"	window.open('http://nateonalarm.nate.com/mynate/iframe_service.php?view=simple&my=no');" &_
				"}" &_
				"</script>"
			userid = ""
		end if
		rsget.Close
	end if

	if userid<>"" then
		sqlStr = "Select count(*) from db_my10x10.dbo.tbl_nateon_alarm " &_
				" where ten_userid='" & userid & "'" &_
				"	and alarm_id=" & arid
		rsget.Open sqlStr,dbget,1
		if rsget(0)<=0 then
			Response.Write "<script langauge=javascript>alert('MY알림을 선택하지 않은 발송입니다.\n알리미 연동 페이지에서 알림을 선택해주세요.');</script>"
			userid = ""
		end if
		rsget.Close
	end if

	'// 알림 발송
	if userid<>"" then
		Call NateonAlarmCheckMsgSend(userid,arid,orderserial)
		Response.Write "<script langauge=javascript>alert('알림을 발송했습니다.');</script>"
	end if
%>
<style type="text/css">
<!--
body,table,tr,td {font-family: 맑은 고딕,돋움; color:#888888; font-size:12px; word-spacing: -2px;scrollbar-face-color: F2F2F2; scrollbar-shadow-color:#bbbbbb; scrollbar-highlight-color: #bbbbbb; scrollbar-3dlight-color: #FFFFFF; scrollbar-darkshadow-color: #FFFFFF; scrollbar-track-color: #F2F2F2; scrollbar-arrow-color: #bbbbbb; scrollbar-base-color:#E9E8E8;}
td {word-break:break-all;}
img,table {border:0px;}
b {letter-spacing:-1px;}
input {padding-top:3px; height:21px;}
textarea {line-height:18px; padding:3px;}
-->
</style>
<script language="javascript">
function chkForm(fm) {
	if(!fm.uid.value) {
		alert("텐바이텐 회원 ID를 입력해주세요.");
		fm.uid.focus();
		return false;
	}
}
</script>
<table width="320" border="0" cellspacing="0" cellpadding="0" align="center">
<form name="frm" method="post" onsubmit="return chkForm(this);">
<tr>
	<td style="padding:4 0 4 3;font-size:16px;color:#FFFFFF" bgcolor="#AE0A0B"><b>텐바이텐 - 네이트온 알림 TEST Page</b></td>
</tr>
<tr>
	<td>
		<table width="100%" cellspacing="0" cellpadding="2" style="border:1px solid #F0F0F0">
		<tr>
			<td width="70">알림구분</td>
			<td>
				<select name="arid">
					<option value="165">배송알림</option>
					<option value="166">결제알림</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>텐바이텐ID</td>
			<td><input type="text" name="uid"></td>
		</tr>
		<tr>
			<td>주문번호</td>
			<td><input type="text" name="ordsn"></td>
		</tr>
		<tr>
			<td></td>
			<td>※주문번호는 알고 있는 경우에 넣어주세요.<br>주문 상세페이지로 연동됩니다.</td>
		</tr>
		<tr>
			<td colspan="2" align="center" bgcolor="#F0F0F0">
				<input type="submit" value="전송">
			</td>
		</tr>
		</table>
	</td>
</tr>
</form>
</table>
<!-- #include virtual="/lib/db/dbclose.asp" -->