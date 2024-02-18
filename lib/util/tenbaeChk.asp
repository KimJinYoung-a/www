<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
	Response.AddHeader "Cache-Control","no-cache"
	Response.AddHeader "Expires","0"
	Response.AddHeader "Pragma","no-cache"
%>
<%
'#############################################################
' Description : 텐배유저체크
' History : 2017-08-09 원승현 생성
'#############################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
	Dim userid, UserAppearChk, sqlstr, referer

	referer = request.ServerVariables("HTTP_REFERER")

	'// 아이디
	userid = getEncLoginUserid()

	if InStr(referer,"10x10.co.kr")<1 then
		Response.Write "0"
		Response.End
	end If

	sqlstr = "SELECT count(*) FROM db_temp.dbo.tbl_tempDistroDojoUserDataYes Where userid='"&userid&"' "
	rsget.CursorLocation = adUseClient
	rsget.Open sqlstr, dbget, adOpenForwardOnly, adLockReadOnly
	IF Not rsget.Eof Then
		UserAppearChk = rsget(0)
	End IF
	rsget.close


	If UserAppearChk > 0 Then
		session("tenBaeChkVal")="1"
		Response.Write "1"
		Response.End
	Else
		session("tenBaeChkVal")="0"
		Response.Write "0"
		Response.End
	End If
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->


