<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

'#######################################################
'	History	:  2009.06.30 허진원 생성
'	Description : 네이트온 알리미 IF - 텐바이텐 배송알림 처리
'#######################################################

response.end  ''2017/04/20
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/apps/nateon/lib/nateon_alarmClass.asp"-->
<%
	dim userid, arid, orderserial, sqlStr
	userid = Request.form("uid")
	arid = Request.form("arid")
	orderserial = Request.form("ordsn")

	'//파라메터 확인
	if (userid="" and orderserial="") or arid="" then
		Response.Write "201"		'잘못된 파라메터
		dbget.close()	:response.End
	end if

	'//아이디가 없으면 주문번호에서 회원아이디 접수
	if userid="" and orderserial<>"" then
		sqlStr = "Select top 1 userid from db_order.dbo.tbl_order_master " &_
				" where orderserial='" & orderserial & "'"
		rsget.Open sqlStr,dbget,1
		if Not(rsget.EOF or rsget.BOF) then
			userid = rsget(0)
		else
			Response.Write "901"	'ERR: 존재하지 않는 서비스
			rsget.Close
			dbget.close()	:response.End
		end if
		rsget.Close
	end if

	'// 알림 발송
	on error resume next
	Call NateonAlarmCheckMsgSend(userid,arid,orderserial)
	If Err.Number = 0 Then
		Response.Write "100"	'성공
	Else
		Response.Write "490"	'ERR: 시스템에러
		dbget.close()	:response.End
	end if
	on error goto 0
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->