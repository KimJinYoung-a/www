﻿<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'####################################################
' Description :  위시리스트 - 또! 담아영
' History : 2016-05-26 유태욱 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<%
dim mode, sqlstr, device, gb
dim totalcnt1, totalcnt2, totalcnt3
	mode = requestcheckvar(request("mode"),5)
	gb = requestcheckvar(request("gb"),5)

dim eCode, userid, currenttime, i
	IF application("Svr_Info") = "Dev" THEN
		eCode   =  "66139"
	Else
		eCode   =  "70923"
	end if

device = "W"

currenttime = now()
'															currenttime = #05/20/2016 10:05:00#

userid = GetEncLoginUserID()

dim subscriptcount
subscriptcount=0

dim refer
	refer = request.ServerVariables("HTTP_REFERER")
if InStr(refer,"10x10.co.kr")<1 then
	Response.Write "01||잘못된 접속입니다."
	dbget.close() : Response.End
end If

if mode="evtgo" then
	If userid = "" Then
		Response.Write "02||로그인을 해주세요."
		dbget.close() : Response.End
	End IF

	If not( left(currenttime,10)>="2016-05-27" and left(currenttime,10)<"2016-06-06" ) Then
		Response.Write "03||이벤트 응모 기간이 아닙니다."
		dbget.close() : Response.End
	End IF

	'//본인 참여 여부
	if userid<>"" then
		if gb="1" then
			subscriptcount = getevent_subscriptexistscount(eCode, userid, "1", "", "")
		elseif gb="2" then
			subscriptcount = getevent_subscriptexistscount(eCode, userid, "2", "", "")
		elseif gb="3" then
			subscriptcount = getevent_subscriptexistscount(eCode, userid, "3", "", "")
		end if
	end if

	if subscriptcount>0 Then
		Response.Write "04||이미 참여함"		''이미  참여함
		dbget.close() : Response.End
	end if

	sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, sub_opt3, device)" + vbcrlf
	sqlstr = sqlstr & " VALUES("& eCode &", '" & userid & "', '" & gb & "', '" & left(currenttime,10) & "', '" & device & "')" + vbcrlf

	'response.write sqlstr & "<Br>"
	dbget.execute sqlstr

	totalcnt1 = getevent_subscripttotalcount(eCode, "1", "", "")
	totalcnt2 = getevent_subscripttotalcount(eCode, "2", "", "")
	totalcnt3 = getevent_subscripttotalcount(eCode, "3", "", "")

	Response.Write "11||"& totalcnt1 &"||"& totalcnt2 &"||"& totalcnt3 &" "
	dbget.close() : Response.End
Else
	Response.Write "00||정상적인 경로가 아닙니다."
	dbget.close() : Response.End
end if

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->


