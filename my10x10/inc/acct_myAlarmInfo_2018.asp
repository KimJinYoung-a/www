<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<%
response.Charset="UTF-8"
%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/myalarmlib.asp" -->
<%

''한글

dim returnResult : returnResult = False

if IsUserLoginOK() and GetLoginUserID() <> "" then
	if (Not MyAlarm_IsExist_CheckDateCookie()) then
		returnResult = MyAlarm_CheckNewMyAlarm(GetLoginUserID(), GetLoginUserLevel())
	else
		returnResult = MyAlarm_IsExist_NewMyAlarmCookie()
	end if

	if (returnResult = True) then
		response.write "Y"
	end if
end if

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
