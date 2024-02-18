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
' Description :  [2016 정기세일] 가격이 터진다
' History : 2016.04.12 유태욱
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim mode, sqlstr, rvalue, cLayerValue, itemnum
	mode = requestcheckvar(request("mode"),32)

dim evt_code, userid, nowdate, i
	IF application("Svr_Info") = "Dev" THEN
		evt_code   =  66102
	Else
		evt_code   =  70030
	End If

nowdate = now()
'	nowdate = #04/20/2016 10:05:00#

userid = GetEncLoginUserID()

if left(nowdate,10) < "2016-04-20" then
	itemnum = 1
elseif left(nowdate,10) >= "2016-04-20" and left(nowdate,10) < "2016-04-22" then
	itemnum = 2
elseif left(nowdate,10) >= "2016-04-22" and left(nowdate,10) < "2016-04-24" then
	itemnum = 3
elseif left(nowdate,10) >= "2016-04-24" and left(nowdate,10) < "2016-04-26" then
	itemnum = 4
elseif left(nowdate,10) >= "2016-04-26" then
	itemnum = 5
end if

dim subscriptcount
subscriptcount=0

dim refer
	refer = request.ServerVariables("HTTP_REFERER")
if InStr(refer,"10x10.co.kr")<1 then
	Response.Write "01||잘못된 접속입니다."
	dbget.close() : Response.End
end If

if mode="addok" then
	If userid = "" Then
		Response.Write "02||로그인을 해주세요."
		dbget.close() : Response.End
	End IF
	If not( left(nowdate,10)>="2016-04-18" and left(nowdate,10)<"2016-04-28" ) Then
		Response.Write "03||이벤트 응모 기간이 아닙니다."
		dbget.close() : Response.End
	End IF

	'//본인 참여 여부
	if userid<>"" then
		subscriptcount = getevent_subscriptexistscount(evt_code, userid, "", itemnum, "")
	end if

'	if left(nowdate,10) = "2016-04-23" then
		if userid="greenteenz" or userid="cogusdk" or userid="helele223"  then
			subscriptcount = 0
		end if
'	end if
	
	if subscriptcount>0 Then
		Response.Write "04||이미 참여 하셨습니다."
		dbget.close() : Response.End
	end if

	sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript](evt_code, userid, sub_opt1, sub_opt2, sub_opt3, device)" + vbcrlf
	sqlstr = sqlstr & " VALUES("& evt_code &", '" & userid & "', '"& left(nowdate,10) &"', "& itemnum &", '', 'W')" + vbcrlf

	'response.write sqlstr & "<Br>"
	dbget.execute sqlstr

	Response.Write "11||응모 완료!"
	dbget.close() : Response.End

elseif mode="itget" then
	If userid = "" Then
		Response.Write "02||로그인을 해주세요."
		dbget.close() : Response.End
	End IF
	If not( left(nowdate,10)>="2016-04-18" and left(nowdate,10)<"2016-04-29" ) Then
		Response.Write "03||이벤트 응모 기간이 아닙니다."
		dbget.close() : Response.End
	End IF

	Call fnCautionEventLog(evt_code, userid, left(nowdate,10), "", "", "W")

	Response.Write "11||응모 완료!"
	dbget.close() : Response.End
Else
	Response.Write "00||정상적인 경로가 아닙니다."
	dbget.close() : Response.End
end if

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->


