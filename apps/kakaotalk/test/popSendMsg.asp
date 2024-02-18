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
	dim strUsrKeys, msg, msgType, ticketID, strData, jsData
	dim oResult, strResult, strTicket, sType
	dim iStep
	strUsrKeys = split(request.form("usrKey"),",")
	msg = request.form("msg")
	msgType = request.form("msgType")
	ticketID = request.form("tId")
	sType = request.form("sendType")
	if sType="" then sType="M"

	if msgType<>"-1" then	msg=""

	'// 진행단계
	if ticketID<>"" then
		iStep = 3		'메시지 발송 확인 단계
	elseif ubound(strUsrKeys)>=0 and ((msgType="-1" and msg<>"") or msgType<>"-1") then
		iStep = 2		'메시지 발송 단계
		if sType="I" then
			strUsrKeys = request.form("usrKey")
		end if
	else
		iStep = 1		'전송대기 단계
		strUsrKeys = request.queryString("usrKey")
	end if

	if iStep=2 then
		'DB 발송용 시작
		'response.Write putKakaoMsgFromTenUser(strUsrKeys,msg)
		'response.End
		'DB 발송용 끝

		'JSON데이터 생성
		Set strData = jsObject()
			strData("plus_key") = TentenId
			'strData("hub_key") = TentenId		'메시지를 hub를 통해 보내는 경우 hub의 key(옵션)
			if sType="M" then
				strData("user_keys") = strUsrKeys
			else
				strData("user_key") = strUsrKeys
			end if
			strData("message_id") = msgType
			strData("content") = msg
			jsData = strData.jsString
		Set strData = Nothing
		'response.Write jsData
		'response.End

		'// 카카오톡에 전송/결과 접수
		if sType="M" then
			strResult = fnSendKakaotalk("msg",jsData)
		else
			strResult = fnSendKakaotalk("imsg",jsData)
		end if
		'response.Write strResult
		'response.End

		'// 전송결과 파징
		set oResult = JSON.parse(strResult)
			strResult = oResult.result_code
			if sType="M" then
				strTicket = oResult.id
			end if
		set oResult = Nothing


	elseif iStep=3 then
		'GET데이터 생성
		strData = server.URLEncode(ticketID)
		'response.Write strData
		'response.End

		'// 카카오톡에 전송/결과 접수
		strResult = fnSendKakaotalk("chkMsg",strData)
		'response.Write strResult
		'response.End

		'// 전송결과 파징
		set oResult = JSON.parse(strResult)
			strResult = oResult.result_code
			if strResult="1000" then
				dim sCnt, sScs, sDt
				sCnt = oResult.data.receivers_count
				sScs = oResult.data.success
				sDt = oResult.data.updated_at
			end if 
		set oResult = Nothing

	end if
%>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>플러스친구 메시지 전송팝업</title>
<style type="text/css">
* {font-size:12px;color:#555;font-family:Malgun Gothic;}
</style>
<script type="text/javascript">
<!--
	function chkForm() {
		var f = document.frm;
		if(f.usrKey.value=="") {
			alert("전송할 친구의 Key를 입력해주세요.");
			f.usrKey.focus();
			return;
		}
		if(f.msgType.value=="-1"&&f.msg.value=="") {
			alert("보내실 내용을 작성해주세요.");
			f.msg.focus();
			return;
		}
		f.submit();
	}

	function chkForm2() {
		var f = document.frm;
		f.submit();
	}

	function chgMsgTp() {
		var f = document.frm;
		if(f.msgType.value=="-1") {
			f.msg.disabled=false;
		} else {
			f.msg.disabled=true;
		}
	}
//-->
</script>
</head>
<body>
<div id="content" style="background-color:#C0C0C0">
	<form name="frm" method="POST" style="margin:0px;">
	<table width="100%" cellpadding="3" cellspacing="1" border="0">
	<tr>
		<td colspan="2" bgcolor="#E0D8FF"><b>메세지 보내기</b></td>
	</tr>
	<% if iStep=1 then %>
	<tr>
		<td bgcolor="white" align="center">플친ID</td>
		<td bgcolor="white" align="center"><%=TentenId%></td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">친구Key</td>
		<td bgcolor="white" align="left"><input type="text" name="usrKey" value="<%=strUsrKeys%>" style="width:100%"><br>※ 콤마(,)로 구분</td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">템플릿ID</td>
		<td bgcolor="white" align="center">
			<input type="text" name="msgType" style="width:100%" value="-1" onkeyup="chgMsgTp()" />
		</td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">내용</td>
		<td bgcolor="white" align="center">
			<textarea name="msg" style="border:1px solid #888;width:100%;height:100px;"></textarea>
		</td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">발송방법</td>
		<td bgcolor="white" align="left">
			<label><input type="radio" name="sendType" value="M" checked />복수</label>&nbsp;
			<label><input type="radio" name="sendType" value="I" />개별</label>
		</td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="white" align="center"><input type="button" value=" 발송 " onclick="chkForm()"></td>
	</tr>
	<%	
		elseif iStep=2 then
			if strResult="1000" then
	%>
	<tr>
		<td colspan="2" bgcolor="#F0D8FF"><b>전송완료</b></td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">발송 Ticket ID</td>
		<td bgcolor="white" align="center">
			<input type="hidden" name="tId" value="<%=strTicket %>">
			<%=strTicket %>
		</td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="white" align="center"><input type="button" value=" 전송확인 " onclick="chkForm2()"></td>
	</tr>
	<%		else %>
	<tr>
		<td bgcolor="#FFD0D0" align="center">오류 코드</td>
		<td bgcolor="#FFD0D0" align="center"><%=getErrCodeNm(strResult) & "(" & strResult & ")"%></td>
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
		<td colspan="2" bgcolor="#F0D8FF"><b>발송상황</b></td>
	</tr>
	<tr>
		<td bgcolor="white" align="center">결과내용</td>
		<td bgcolor="white" align="left"><%="- 총발송수: " & sCnt & "<br />- 성 공 수: " & sScs & "<br />- 발송시간: " & sDt%></td>
	</tr>
	<tr>
		<td colspan="2" bgcolor="white" align="center"><input type="button" value=" 뒤로 " onclick="history.back()"></td>
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