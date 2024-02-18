<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"

'#######################################################
'	History	:  2009.06.17 허진원 생성
'	Description : 네이트온 알리미 IF - 관심 알림 추가/삭제
'#######################################################

response.end  ''2017/04/20
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/apps/nateon/lib/nateon_alarmClass.asp"-->
<!-- #include virtual="/lib/inc_const.asp" -->
<%
dim ticket2, IsSuccess, isCheck, alarmId
dim service_id, ticketVal
dim alarmId_list, nateId, userid, insDate
dim oAlarm

service_id	= Request.form("service_id")
ticketVal	= Request.form("value")

if service_id="" or ticketVal="" then
	Response.Write "201"	'ERR: 파라메터 없음
	dbget.close()	:response.End
end if

'// 데이터 복호화 및 파싱
on error resume next
Set ticket2 = New CoTicket
IsSuccess = ticket2.SetTicket(tenEncKey, ticketVal)	'복호키 설정
if Err then
	Response.Write "490"	'ERR: 시스템에러
	dbget.close()	:response.End
end if
on error goto 0

If IsSuccess Then
	alarmId_list = ticket2("alarm_id_list")
	nateId = ticket2("cmn")
	userid = ticket2("unique_key")
	insDate = ticket2("insert_date")

	'// 연동전 확인사항
	set oAlarm = new CNateonAlarm
	oAlarm.FRectUserID = userid
	isCheck = oAlarm.getTenUserCheck
	set oAlarm = Nothing
	if Not(isCheck) then
		Response.Write "904"	'ERR: 존재하지 않는 회원
		dbget.close()	:response.End
	end if

	set oAlarm = new CNateonAlarm
	oAlarm.FRectUserID = userid
	oAlarm.FRectNateID = nateId
	isCheck = oAlarm.getRelateUserCheck
	set oAlarm = Nothing
	if Not(isCheck) then
		Response.Write "905"	'ERR: 연동되지 않은 회원
		dbget.close()	:response.End
	end if

	'// 연동 처리
	on error resume next
	dbget.beginTrans		'트랜젝션 시작

	alarmId_list = Replace(alarmId_list,"|",",")
	dim strSql

	'## 알림 연동 해제
	strSql = "Delete from db_my10x10.dbo.tbl_nateon_alarm " &_
			" where ten_userid='" & userid & "'" &_
			"	and nateon_id=" & nateId
	dbget.execute(strSql)

	'## 추가된 알림 연동
	if Not(alarmId_list="" or isNull(alarmId_list)) then
		strSql = ""
		alarmId_list = split(alarmId_list,",")
		For Each alarmId in alarmId_list
			strSql = strSql & "Insert into db_my10x10.dbo.tbl_nateon_alarm (ten_userid, nateon_id, alarm_id,insert_date) values " &_
					"('" & userid & "'," & nateId & "," & alarmId & ",'" & covDatetime(insDate) & "');" & vbCrLf
		next
		dbget.execute(strSql)
	end if

	'##### DB 저장 처리 #####
    If Err.Number = 0 Then
    	dbget.CommitTrans				'커밋(정상)
    	Response.Write "100"	'성공
    Else
        dbget.RollBackTrans				'롤백(에러발생시)
        Response.Write "500"	'ERR: DB에러
    End If
	on error goto 0
else
	Response.Write "301"	'ERR: 암호/복호화 에러
end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->