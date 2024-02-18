<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<%
'###########################################################
' Description :  브랜드스트리트
' History : 2015.04.07 한용민 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim backurl,userid, sMode, sqlStr
	userid = GetLoginUserID
	backurl = request.ServerVariables("HTTP_REFERER")

if InStr(LCase(backurl),"10x10.co.kr") < 0 then
	Response.Write "E02"
	dbget.close()	:	response.End
end if

if Not(IsUserLoginOK) then
	Response.Write "E01"
	dbget.close()	:	response.End
end if

dim makerid
	makerid = requestCheckVar(Request("makerid"),32)

if makerid="" then
	Response.Write "E03"
	dbget.close()	:	response.End
end if

sqlStr = "SELECT COUNT(makerid) FROM [db_my10x10].[dbo].tbl_mybrand WHERE userid = '" & userid & "' AND makerid = '" & makerid & "'"

'response.write sqlStr & "<br>"
rsget.Open sqlStr, dbget, 1
If rsget(0) > 0 Then
	sMode = "D"
Else
	sMode = "I"
End If
rsget.close

if sMode = "I" then
	sqlStr = "exec [db_my10x10].[dbo].sp_Ten_AddZzimBrand '" & userid & "','" & makerid & "'"

	'response.write sqlStr & "<br>"
	dbget.Execute sqlStr

	sqlStr = " Update db_user.dbo.tbl_user_c SET recommendcount = recommendcount + 1 WHERE userid = '"&makerid&"' "

	'response.write sqlStr & "<br>"
	dbget.Execute sqlStr

	Response.Write "IOK"
	dbget.close()	:	response.end

elseif sMode = "D" then
    sqlStr = "DELETE FROM [db_my10x10].[dbo].[tbl_mybrand] WHERE" + VbCrlf
    sqlStr = sqlStr + " userid='"& userid &"'" + VbCrlf
    sqlStr = sqlStr + " and makerid ='"& makerid &"'"
    
    'response.write sqlStr & "<br>"
    dbget.execute sqlStr

	sqlStr = " Update db_user.dbo.tbl_user_c SET recommendcount = recommendcount - 1 WHERE userid = '"&makerid&"' "

	'response.write sqlStr & "<br>"
	dbget.Execute sqlStr

	Response.Write "DOK"
	dbget.close()	:	response.end

else
	Response.Write "FAIL"
	dbget.close()	:	response.end
end if

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
