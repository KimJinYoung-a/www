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
<!-- #include virtual="/lib/util/JSON_2.0.4.asp" -->
<script language="jscript" runat="server" src="/lib/util/JSON_PARSER_JS.asp"></script>
<%
''raise Err
1=a
	'STAFF만 허용
	if GetLoginUserLevel<>"7" then
		response.write ":p"
		response.End
	end if

	'전송값확인(전송시 처리)
	dim strUsrKeys, strData, jsData
	dim oResult, strResult, strTicket
	dim iStep, sMode
	dim sqlStr

	'strUsrKeys = split(request.form("usrKey"),",")	'복수형태(사용안함)
	strUsrKeys = request("usrKey")
	sMode = request("mode")

	'// 진행단계
	if sMode="D" then
		iStep = 2		'해제처리 단계
	else
		iStep = 1		'최초 입력 단계
	end if
	
	if iStep=2 then
		'JSON데이터 생성
		Set strData = jsObject()
			strData("plus_key") = TentenId
			strData("user_key") = strUsrKeys
			'strData("user_keys") = strUsrKeys	'복수형태(사용안함)
			jsData = strData.jsString
		Set strData = Nothing
'		response.Write jsData
'		response.End
		
		'// 카카오톡에 전송/결과 접수
		strResult = fnSendKakaotalk("delUsr",jsData)
'		response.Write strResult
'		response.End

		'// 전송결과 파징
		set oResult = JSON.parse(strResult)
			strResult = oResult.result_code
			if strResult="1000" then
				'// 친구해지 DB 저장 처리
				sqlStr = "Delete From db_sms.dbo.tbl_kakaoUser " &_
						" Where userid='" & GetLoginUserID & "'" &_
						" 	and kakaoUserKey in (" & request.form("usrKey") & ")"
				dbget.execute(sqlStr)

			end if
		set oResult = Nothing

	end if
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>플러스친구 해제팝업</title>
<style type="text/css">
* {font-size:12px;color:#555;font-family:Malgun Gothic;}
</style>
<script type="text/javascript">
<!--
	function chkForm() {
		var f = document.frm;
		if(f.usrKey.value=="") {
			alert("해제할 친구 Key를 입력해주세요.");
			f.usrKey.focus();
			return;
		}
		f.submit();
	}
//-->
</script>
</head>
<body>
<div id="content" style="background-color:#C0C0C0">
	<form name="frm" method="POST" style="margin:0px;">
	<table width="100%" cellpadding="3" cellspacing="1" border="0">
	<tr>
		<td colspan="2" bgcolor="#E0D8FF"><b>플친해제</b></td>
	</tr>
	<% if iStep=1 then %>
	<tr>
		<td bgcolor="white" align="center">플친ID</td>
		<td bgcolor="white" align="center"><%=TentenId%></td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">친구Key</td>
		<td bgcolor="white" align="center">
			<input type="text" name="usrKey" value="<%=strUsrKeys%>">
			<input type="hidden" name="mode" value="D">
		</td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="white" align="center"><input type="button" value=" 해제 " onclick="chkForm()"></td>
	</tr>
	<%	
		elseif iStep=2 then
			if strResult="1000" then
	%>
	<tr>
		<td colspan="2" bgcolor="#F0D8FF"><b>해제완료</b></td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">친구Key</td>
		<td bgcolor="white" align="center"><%=strUsrKeys%></td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">결과값</td>
		<td bgcolor="white" align="center"><%=getErrCodeNm(strResult)%></td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="white" align="center"><input type="button" value=" 창닫기 " onclick="self.close()"></td>
	</tr>
	<%		else %>
	<tr>
		<td bgcolor="#FFD0D0" align="center">오류 코드</td>
		<td bgcolor="#FFD0D0" align="center"><%=getErrCodeNm(strResult)%></td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="white" align="center"><input type="button" value=" 뒤로 " onclick="history.back()"></td>
	</tr>
	<%
			end if
		end if
	%>
	</table>
	</form>
</div>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->