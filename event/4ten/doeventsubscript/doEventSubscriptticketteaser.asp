<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'####################################################
' Description :  [2016 정기세일] 티켓이 터진다 티져
' History : 2016.04.14 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim mode, sqlstr, rvalue, cLayerValue, itemnum
	mode = requestcheckvar(request("mode"),32)

dim evt_code, userid, nowdate, i
	IF application("Svr_Info") = "Dev" THEN
	evt_code   =  66104
Else
	evt_code   =  70031
	End If

nowdate = now()
'	nowdate = #04/18/2016 10:05:00#

userid = GetEncLoginUserID()

dim subscriptcount, subscriptcount1, subscriptcounttotalcnt
subscriptcount=0
subscriptcount1=0
subscriptcounttotalcnt=0

dim refer
	refer = request.ServerVariables("HTTP_REFERER")
if InStr(refer,"10x10.co.kr")<1 then
	Response.Write "01||잘못된 접속입니다."
	dbget.close() : Response.End
end If

If userid = "" Then
	Response.Write "02||로그인을 해주세요."
	dbget.close() : Response.End
End IF

If not( left(nowdate,10)>="2016-04-18" and left(nowdate,10)<"2016-04-28" ) Then
	Response.Write "03||이벤트 기간이 아닙니다."
	dbget.close() : Response.End
End IF

'//본인 참여 여부
if userid<>"" then
	subscriptcount = getevent_subscriptexistscount(evt_code, userid, "", "", "")
end if

if subscriptcount>0 Then
	mode = "addup"
end if

if mode="addok" then
	sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, sub_opt2, sub_opt3, device)" + vbcrlf
	sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', 'Y', '', '', 'W')" + vbcrlf

	'response.write sqlstr & "<Br>"
	dbget.execute sqlstr

	subscriptcounttotalcnt = getevent_subscripttotalcount(evt_code, "Y", "", "")

	Response.Write "11||"&subscriptcounttotalcnt
	dbget.close() : Response.End
Elseif mode="addup" then
	subscriptcount1 = getevent_subscriptexistscount(evt_code, userid, "Y", "", "")

	if subscriptcount1 > 0 then
		sqlstr = "update db_event.dbo.tbl_event_subscript set sub_opt1='N' where evt_code='" & evt_code & "' and userid= '" & userid & "' "

		'response.write sqlstr & "<Br>"
		dbget.execute sqlstr

		subscriptcounttotalcnt = getevent_subscripttotalcount(evt_code, "Y", "", "")

		Response.Write "12||"&subscriptcounttotalcnt
		dbget.close() : Response.End
	else
		sqlstr = "update db_event.dbo.tbl_event_subscript set sub_opt1='Y' where evt_code='" & evt_code & "' and userid= '" & userid & "' "

		'response.write sqlstr & "<Br>"
		dbget.execute sqlstr

		subscriptcounttotalcnt = getevent_subscripttotalcount(evt_code, "Y", "", "")

		Response.Write "11||"&subscriptcounttotalcnt
		dbget.close() : Response.End
	end if
Else
	Response.Write "00||정상적인 경로가 아닙니다."
	dbget.close() : Response.End
end if

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->


