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
	dim strhp, strNtn, certcd, strData, jsData, iStep
	dim oResult, strResult, strUserKey
	dim sqlStr

	strhp = request.form("hpnum")
	strNtn = request.form("nation")
	certcd = request.form("certcd")

	'// 진행단계
	if strhp<>"" and certcd<>"" then
		iStep = 3		'친구관계 연결 단계
	elseif strhp<>"" then
		iStep = 2		'인증번호 확인 단계
	else
		iStep = 1		'최초인증번호 발송 단계
	end if
	
	if iStep=2 then
		strhp = tranPhoneNo(strhp,strNtn)
		'JSON데이터 생성
		Set strData = jsObject()
			strData("plus_key") = TentenId
			strData("phone_number") = strhp
			jsData = strData.jsString
		Set strData = Nothing
		'response.Write jsData
		'response.End
		
		'// 카카오톡에 전송/결과 접수
		strResult = fnSendKakaotalk("cert",jsData)
		'response.Write strResult
		'response.End

		'// 전송결과 파징
		set oResult = JSON.parse(strResult)
			strResult = oResult.result_code
		set oResult = Nothing
	elseif iStep=3 then
		'JSON데이터 생성
		Set strData = jsObject()
			strData("plus_key") = TentenId
			strData("phone_number") = strhp
			strData("cert_code") = certcd
			jsData = strData.jsString
		Set strData = Nothing
'		response.Write jsData
'		response.End
		
		'// 카카오톡에 전송/결과 접수
		strResult = fnSendKakaotalk("usr",jsData)
'		response.Write strResult
'		response.End

		'// 전송결과 파징
		on Error Resume Next
		set oResult = JSON.parse(strResult)
			strResult = oResult.result_code
			if strResult="1000" then
				strUserKey = oResult.user_key
				'response.Write cstr(strUserKey)
				'response.End
			end if
		set oResult = Nothing

	    IF (Err) then
		    response.Write strResult
		    response.End
		end if
		On Error Goto 0

		'// 친구관계 및 DB 저장 처리
		if strResult="1000" then
			sqlStr = "Insert into db_sms.dbo.tbl_kakaoUser (userid,kakaoUserKey,phoneNum) values " &_
					" ('" & GetLoginUserID & "'" &_
					" ,'" & strUserKey & "'" &_
					" ,'" & strhp & "')"
			dbget.execute(sqlStr)
		end if
	
	end if
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>플러스친구 요청팝업</title>
<style type="text/css">
* {font-size:12px;color:#555;font-family:Malgun Gothic;}
</style>
<script type="text/javascript">
<!--
	function chkForm() {
		var f = document.frm;
		if(f.hpnum.value=="") {
			alert("플러스친구에 등록할 휴대폰번호를 입력해주세요.");
			f.hpnum.focus();
			return;
		}
		f.submit();
	}

	function chkForm2() {
		var f = document.frm;
		if(f.certcd.value=="") {
			alert("인증번호를 입력해주세요.");
			f.certcd.focus();
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
		<td colspan="2" bgcolor="#E0D8FF"><b>플친등록</b></td>
	</tr>
	<% if iStep=1 then %>
	<tr>
		<td bgcolor="white" align="center">플친ID</td>
		<td bgcolor="white" align="center"><%=TentenId%></td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">추가할 휴대폰</td>
		<td bgcolor="white" align="center">
			<select name="nation">
				<option value="KR">한국(+82)</option>
				<option value="US">미국(+1)</option>
				<option value="JP">일본(+81)</option>
				<option value="CN">중국(+86)</option>
			</select>
			<input type="text" name="hpnum">
		</td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="white" align="center"><input type="button" value=" 요청 " onclick="chkForm()"></td>
	</tr>
	<%	
		elseif iStep=2 then
			if strResult="1000" or strResult="3009" then
	%>
	<tr>
		<td bgcolor="white" align="center">휴대폰번호</td>
		<td bgcolor="white" align="center">
			<%=strhp%>
			<input type="hidden" name="hpnum" value="<%=strhp%>">
		</td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">인증번호</td>
		<td bgcolor="white" align="center"><input type="text" name="certcd"></td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="white" align="center"><input type="button" value=" 친구등록 " onclick="chkForm2()"></td>
	</tr>
	<%		else %>
	<tr>
		<td bgcolor="#FFD0D0" align="center">오류 코드(<%=strhp%>)</td>
		<td bgcolor="#FFD0D0" align="center"><%=getErrCodeNm(strResult)%></td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="white" align="center"><input type="button" value=" 뒤로 " onclick="history.back()"></td>
	</tr>
	<%
			end if
		elseif iStep=3 then
			if strResult="1000" then
	%>
	<tr>
		<td colspan="2" bgcolor="#F0D8FF"><b>등록완료</b></td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">휴대폰번호</td>
		<td bgcolor="white" align="center"><%=strhp%></td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">카카오톡 UserKey</td>
		<td bgcolor="white" align="center"><%=strUserKey%></td>
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