<%@  codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Session.CodePage = 65001
Response.Charset = "UTF-8"

'===========================================================
' 발송대기중인 DB의 카카오톡 메시지 전송 처리
'-----------------------------------------------------------
' 2012.06.14 : 허진원 생성
'-----------------------------------------------------------
'tr_status (1:전송대기, 3:전송실패, 5:전송완료, 9:전송불가)
'===========================================================
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/apps/kakaotalk/lib/kakaotalk_config.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp" -->
<script language="jscript" runat="server" src="/lib/util/JSON_PARSER_JS.asp"></script>
<%
	'// 변수 선언
	Dim strSql, strResult, oResult, strData, jsData
	dim orderserial, cntSend
	cntSend = 0

	'주문번호가 있을시엔 해당 메지시만 발송
	orderserial = requestCheckVar(Request.form("ordsn"),12)

	'// LOG테이블 검사 및 LOG테이블로 이동 처리 (--> DB 스케줄로 처리)
	'strSql = "db_sms.dbo.sp_Ten_kakaoTalkMsgLogMove"

	'// 대기중인 메시지 확인 (최대 100건)
	strSql = "Select top 100 tr_idx, tr_kakaoUsrKey, tr_msg, tr_msgType " &_
			" From db_sms.dbo.tbl_kakao_tran " &_
			" Where tr_status in ('1','3') "
		if orderserial<>"" then
			strSql = strSql & " and tr_info1='" & orderserial & "'"
		end if
		rsget.Open strSql,dbget,1

	on error resume next
	if Not(rsget.EOF or rsget.BOF) then
		Do Until rsget.EOF
			'JSON데이터 생성
			Set strData = jsObject()
				strData("plus_key") = TentenId
				strData("user_key") = cStr(rsget("tr_kakaoUsrKey"))
				strData("message_id") = cStr(rsget("tr_msgType"))
				strData("content") = cStr(rsget("tr_msg"))
				jsData = strData.jsString
			Set strData = Nothing

			'메시지 정송
			strResult = fnSendKakaotalk("imsg",jsData)

			'전송결과 파징
			set oResult = JSON.parse(strResult)
				strResult = oResult.result_code
			set oResult = Nothing

			'전송결과값 저장
			strSql = "Update db_sms.dbo.tbl_kakao_tran " &_
					" Set tr_status='" & getSendErrCode(strResult) & "' " & _
					"	,tr_senddate=getdate() " & _
					" Where tr_idx=" & rsget("tr_idx")
			dbget.execute(strSql)
			cntSend = cntSend+1
			''response.Write strResult & "//"

			rsget.MoveNext
		Loop
	end if

	rsget.Close

	If Err.Number = 0 Then
		Response.Write cntSend	'성공
	Else
		Response.Write "Error"	'ERR: 시스템에러
	end if
	on error goto 0

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
