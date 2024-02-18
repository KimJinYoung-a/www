<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Session.CodePage = 65001
Response.Charset = "UTF-8"

'===========================================================
' 카카오톡 서비스 해제 처리
'-----------------------------------------------------------
' 2012.07.18 : 허진원 생성
'===========================================================
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/apps/kakaotalk/lib/kakaotalk_config.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp" -->
<script language="jscript" runat="server" src="/lib/util/JSON_PARSER_JS.asp"></script>
<%
	'// 변수 선언
	Dim sqlStr, strResult, oResult, strData, jsData
	dim userid, clearChk, strUserKey

	userid = requestCheckVar(Request.form("uid"),32)
	clearChk = requestCheckVar(Request.form("clearChk"),1)

	if userid="" or clearChk="" then
		Response.Write false
		Response.End
	end if

	'// 카카오톡 UserKey 접수
	sqlStr = "Select top 1 kakaoUserKey From db_sms.dbo.tbl_kakaoUser Where userid='" & userid & "'"
	rsget.Open sqlStr,dbget,1
	if Not(rsget.EOF or rsget.BOF) then
		strUserKey = rsget(0)
	end if
	rsget.Close

	if strUserKey<>"" then
		'JSON데이터 생성
		Set strData = jsObject()
			strData("plus_key") = TentenId
			strData("user_key") = strUserKey
			jsData = strData.jsString
		Set strData = Nothing

		'// 카카오톡에 전송/결과 접수
		strResult = fnSendKakaotalk("delUsr",jsData)

		'// 전송결과 파징
		set oResult = JSON.parse(strResult)
			strResult = oResult.result_code
		set oResult = Nothing

		'// 친구관계 정리 처리
		Select Case strResult
			Case "1000", "2101", "2102"
				sqlStr = "Delete From db_sms.dbo.tbl_kakaoUser " &_
						" Where userid='" & userid & "'"
				dbget.execute(sqlStr)

				'Log 저장
				Call putKakaoAuthLog(userid, strUserKey, "D")

				Response.Write true
		end Select
	else
		Response.Write false
	end if

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
