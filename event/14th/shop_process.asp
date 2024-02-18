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
' Description : [14주년] 5분안에 매장을 털어라! 습격자들
' History : 2015.10.07 한용민 생성
'####################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<%
dim mode, snsgubun, sqlstr
	mode = requestcheckvar(request("mode"),16)
	snsgubun = requestcheckvar(request("snsgubun"),2)

dim refer
	refer = request.ServerVariables("HTTP_REFERER")
if InStr(refer,"10x10.co.kr")<1 then
	Response.Write "잘못된 접속입니다."
	dbget.close() : Response.End
end If

dim currenttime
	currenttime =  now()
	'currenttime = #10/10/2015 09:00:00#

dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  64913
Else
	eCode   =  66519
End If

dim userid, i
	userid = GetEncLoginUserID()

dim subscriptexistscount, staffconfirm
	subscriptexistscount=0
	staffconfirm=FALSE

if not( left(currenttime,10)>="2015-10-10" and left(currenttime,10)<"2015-10-29" ) then
	Response.Write "DATENOT"
	dbget.close() : Response.End
End If
if userid="" then
	Response.Write "USERNOT"
	dbget.close() : Response.End
End If
'if Hour(currenttime) < 10 then
'	Response.write "TIMENOT"
'	Response.end
'end if

If mode = "snsadd" Then
	if snsgubun="" then
		Response.Write "SNSNOT"
		dbget.close() : Response.End
	End If

	sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code , userid , sub_opt1 , sub_opt2, sub_opt3, regdate, device)" + vbcrlf
	sqlstr = sqlstr & " VALUES("& eCode &", '"& userid &"', '"& snsgubun &"', '0' ,'', getdate(), 'W')" + vbcrlf
	
	'response.write sqlstr & "<br>"
	dbget.execute sqlstr

	Response.write snsgubun
	dbget.close()	:	response.End

elseIf mode = "add" Then
	subscriptexistscount = getevent_subscriptexistscount(eCode, userid, left(currenttime,10), "", "")
	if subscriptexistscount > 0 then
		Response.write "END"
		dbget.close()	:	response.End
	end if

	sqlstr = "INSERT INTO [db_event].[dbo].[tbl_event_subscript] (evt_code , userid , sub_opt1 , sub_opt2, sub_opt3, regdate, device)" + vbcrlf
	sqlstr = sqlstr & " VALUES("& eCode &", '"& userid &"', '"& left(currenttime,10) &"', '0' ,'', getdate(), 'W')" + vbcrlf
	
	'response.write sqlstr & "<br>"
	dbget.execute sqlstr

	Response.write "SUCCESS"
	dbget.close()	:	response.End

Else
	Response.Write "정상적인 경로가 아닙니다."
	dbget.close() : Response.End
end if
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->