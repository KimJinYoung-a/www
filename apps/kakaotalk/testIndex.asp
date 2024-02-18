<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Session.CodePage = 65001
Response.Charset = "UTF-8"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/apps/kakaotalk/lib/kakaotalk_config.asp" -->
<%
''Raise Err
1=a
	'STAFF만 허용
	if GetLoginUserLevel<>"7" then
		response.write ":p"
		response.End
	end if
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>카카오톡 연동 테스트</title>
<style type="text/css">
* {font-size:12px;color:#555;font-family:Malgun Gothic;}
</style>
<script type="text/javascript">
<!--
	// 플친등록 팝업
	function fnPopAddFriend() {
		var p = window.open("./test/popAddFriend.asp","plusAddFriend","width=400,height=200");
	}

	// 메시지전송 팝업
	function fnPopSendMsg(kuid) {
		var p = window.open("./test/popSendMsg.asp?usrKey="+kuid,"sendMsg","width=400,height=300");
	}

	// 플친해제 팝업
	function fnPopDelFriend(kuid) {
		var p = window.open("./test/popDelFriend.asp?usrKey="+kuid,"plusDelFriend","width=400,height=200");
	}

//-->
</script>
</head>
<body>
<div id="content" style="width:320px;background-color:#C0C0C0">
	<table width="340" cellpadding="3" cellspacing="1" border="0">
	<tr>
		<td colspan="2" bgcolor="#E0D8FF"><b>1. 플친등록</b></td>
	</tr>
	<tr>
		<td bgcolor="white" width="140">① 인증번호 발송</td>
		<td bgcolor="white" width="200" rowspan="2" align="center"><input type="button" value="등록팝업" onclick="fnPopAddFriend()" /></td>
	</tr>
	<tr>
		<td bgcolor="white">② 친구등록 요청</td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="#E0D8FF"><b>2. 메시지 보내기</b></td>
	</tr>
	<tr>
		<td bgcolor="white">① 메세지 발송</td>
		<td bgcolor="white" rowspan="2" align="center"><input type="button" value="전송팝업" onclick="fnPopSendMsg('')" /></td>
	</tr>
	<tr>
		<td bgcolor="white">② 전송상태 조회</td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="#E0D8FF"><b>3. 친구 해제</b></td>
	</tr>
	<tr>
		<td bgcolor="white">친구 관계 해제</td>
		<td bgcolor="white" align="center"><input type="button" value="해제" onclick="fnPopDelFriend('')" /></td>
	</tr>
	</table>
</div>
<br>
<div id="userlist" style="width:500px;background-color:#C0C0C0">
	<!-- // 텐바이텐 인증 목록 // -->
	<%
		dim strSql
		strSql = "Select top 10 k.userid, u.username, k.kakaoUserKey, k.phoneNum, k.regdate " &_
				" From db_sms.dbo.tbl_kakaoUser as k " &_
				"	Left Join db_user.dbo.tbl_user_n as u " &_
				"		on k.userid=u.userid "
		''strSql = strSql & " Where k.userid='ekfrml0119' "
		rsget.Open strSql,dbget,1
	%>
	<table width="600" cellpadding="3" cellspacing="1" border="0">
	<tr>
		<td colspan="6" bgcolor="#E0D8FF"><b>플친인증 고객목록</b></td>
	</tr>
	<tr>
		<td bgcolor="#F8F0FF" align="center">ID</td>
		<td bgcolor="#F8F0FF" align="center">이름</td>
		<td bgcolor="#F8F0FF" align="center">휴대폰</td>
		<td bgcolor="#F8F0FF" align="center">인증키</td>
		<td bgcolor="#F8F0FF" align="center">등록일시</td>
		<td bgcolor="#F8F0FF" align="center">기능</td>
	</tr>
	<%
		if Not rsget.Eof then
			Do Until rsget.EOF
	%>
	<tr>
		<td bgcolor="white" align="center"><%=rsget("userid")%></td>
		<td bgcolor="white" align="center"><%=rsget("username")%></td>
		<td bgcolor="white" align="center"><%=rsget("phoneNum")%></td>
		<td bgcolor="white" align="center"><%=rsget("kakaoUserKey")%></td>
		<td bgcolor="white" align="center"><%=left(rsget("regdate"),10)%></td>
		<td bgcolor="white" align="center">
			<input type="button" value="메시지" onclick="fnPopSendMsg('<%=rsget("kakaoUserKey")%>');">
			<input type="button" value=" 해제 " onclick="fnPopDelFriend('<%=rsget("kakaoUserKey")%>');">
		</td>
	</tr>
	<%
			rsget.MoveNext
			Loop
		end if

		rsget.Close
	%>
	</table>
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->