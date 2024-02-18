<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Session.CodePage = 65001
Response.Charset = "UTF-8"

'===========================================================
' 기기에서 플러스친구 차단/삭제한 유저 목록 정리
'-----------------------------------------------------------
' 2012.07.30 : 허진원 생성
'===========================================================
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/apps/kakaotalk/lib/kakaotalk_config.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp" -->
<!-- #include virtual="/lib/util/JSON2.asp" -->
<%
	'// 변수 선언
	Dim strSql, strResult, oResult, rstCd, rstData, cntChk, iLp, userKeys
	cntChk = 0

	'// 카카톡에서 친구삭제한 목록 접수 (최대 1일간 내용)
	dim oXML

	'카카오톡에 요청 / GET으로 전송
	Set oXML = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")	'xmlHTTP컨퍼넌트 선언
	oXML.open "GET", KakaoTalkURL & "/v1/users/" & TentenId & "/lost", false
	oXML.send 			'전송

	strResult = oXML.responseText		'결과 수신

	Set oXML = Nothing	'컨퍼넌트 해제

'	response.Write strResult
'	response.End

	on error Resume Next

	'// 전송결과 파징
	set oResult = JSON.parse(strResult)
		rstCd = oResult.result_code
		if rstCd="1000" then
			set rstData = oResult.data
		end if
	set oResult = Nothing

	if rstCd="1000" then
		dim key
		for iLp=0 to rstData.length-1
			for each key in rstData.get(iLp).keys()
				if key>0 then
					'// 데이터가 있는 경우 tbl_kakaoUser에서 삭제
					if userKeys<>"" then
						userKeys = userKeys & ",'" & key & "'"
					else
						userKeys = userKeys & "'" & key & "'"
					end if
	
					'Response.write( key & "/" & rstData.get(iLp).get(key) & "<br>")
					cntChk = cntChk+1
				end if
			next
		next

		'Response.write userKeys
		'Response.end

		if userKeys<>"" then
			strSql = "Select userid,kakaoUserKey from db_sms.dbo.tbl_kakaoUser Where kakaoUserKey in (" & userKeys & ")"
			rsget.Open strSql,dbget,1
			if Not(rsget.EOF or rsget.BOF) then
				do Until rsget.EOF
					'Log 저장 (X:차단삭제)
					Call putKakaoAuthLog(rsget("userid"), rsget("kakaoUserKey"), "X")
					rsget.MoveNext
				loop

				'// 삭제처리
				strSql = "Delete from db_sms.dbo.tbl_kakaoUser Where kakaoUserKey in (" & userKeys & ")"
				dbget.execute(strSql)

				'실제처리 건수
				cntChk = rsget.recordCount & " / " & cntChk
			end if
			rsget.Close

		end if

		set rstData = Nothing
	end if

	If Err.Number = 0 Then
		Response.Write cntChk	'성공
	Else
		Response.Write "Error"	'ERR: 시스템에러
	end if
	on error goto 0

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
