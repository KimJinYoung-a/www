<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
dim eCode, com_egCode, bidx,Cidx , hookcode , pagereload
dim userid, txtcomm, txtcommURL, mode, spoint
mode=requestCheckVar(request.Form("mode"),4)
eCode =requestCheckVar(request.Form("eventid"),10)
com_egCode=requestCheckVar(request.Form("com_egC"),10)
bidx = requestCheckVar(request.Form("bidx"),10)
Cidx = requestCheckVar(request.Form("Cidx"),10)
userid = GetLoginUserID
spoint = requestCheckVar(request.Form("spoint"),10)
txtcommURL = requestCheckVar(request.Form("txtcommURL"),128)
txtcommURL = html2db(txtcommURL)
hookcode = requestCheckVar(request.Form("hookcode"),10)
pagereload = requestCheckVar(request.Form("pagereload"),2)
IF spoint = "" THEN spoint = 0
IF bidx = "" THEN bidx = 0
IF com_egCode = "" THEN com_egCode = 0

dim referer,refip, returnurl
referer = request.ServerVariables("HTTP_REFERER")
refip = request.ServerVariables("REMOTE_ADDR")
returnurl = requestCheckVar(request.Form("returnurl"),100)

If pagereload = "ON" Then 
	If Instr(RefURLQ, "/event/16th/?pagereload") > 0 Then
		pagereload = ""
	ElseIf Instr(RefURLQ, "&pagereload=") > 0 Then	
		pagereload = ""
	ElseIf Instr(RefURLQ, "/event/16th/?") > 0 Then
		pagereload = "&pagereload="&pagereload
	ElseIf Instr(RefURLQ, "/event/16th/?") = 0 Then	
		pagereload = "?pagereload="&pagereload
	Else
		pagereload = ""
	End If
Else 
	pagereload = "" 
End if

dim sqlStr, returnValue
Dim objCmd
Set objCmd = Server.CreateObject("ADODB.COMMAND")
if mode="add" then
	
	txtcomm = request.Form("txtcomm")

	if checkNotValidTxt(txtcomm) then
		Alert_move "내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요.","about:blank"
		dbget.close()	:	response.End
	end if
	txtcomm = html2db(txtcomm)

		With objCmd
		.ActiveConnection = dbget
		.CommandType = adCmdText
		.CommandText = "{?= call [db_event].[dbo].sp_Ten_event_comment_insert("&eCode&","&com_egCode&",'"&userid&"','"&txtcomm&"',"&spoint&","&bidx&",'"&refip&"','"&txtcommURL&"')}"
		
		.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
		.Execute, , adExecuteNoRecords
		End With	
	    returnValue = objCmd(0).Value		    

	Set objCmd = Nothing	

	IF returnValue = 1 THEN	
		'response.write "<script>alert('응모 해주셔서 감사합니다.');</script>"
		response.write "<script>location.replace('" + Cstr(referer) + CStr(hookcode) + CStr(pagereload) +"');</script>"
		dbget.close()	:	response.End
	ELSEIF returnValue = 2 THEN	
		response.write "<script>alert('한번에 5회 이상 연속 등록 불가능합니다.');</script>"
	 	response.write "<script>location.replace('" + Cstr(referer) + CStr(hookcode) + CStr(pagereload) +"');</script>"
	 	dbget.close()	:	response.End
   ELSE
     response.write "<script>alert('데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해 주십시오.');</script>"
	 response.write "<script>location.replace('" + Cstr(referer) + "');</script>"
	 dbget.close()	:	response.End
   END IF 

elseif mode="del" then
	Cidx=requestCheckVar(request.Form("Cidx"),10)	
	
		With objCmd
		.ActiveConnection = dbget
		.CommandType = adCmdText
		.CommandText = "{?= call [db_event].[dbo].sp_Ten_event_comment_delete ("&Cidx&",'"&userid&"',"&bidx&","&com_egCode&")}"		
		.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
		.Execute, , adExecuteNoRecords
		End With	
	    returnValue = objCmd(0).Value		    	
	Set objCmd = Nothing
		
   IF returnValue = 1 THEN	
		response.redirect(referer)
		dbget.close()	:	response.End
   ELSE
     response.write "<script>alert('데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해 주십시오.');</script>"
	 response.write "<script>location.replace('" + Cstr(referer) + CStr(pagereload) + "');</script>"
	 dbget.close()	:	response.End
   END IF 

elseif mode="edit" then
	Cidx=requestCheckVar(request.Form("Cidx"),10)	
	
	txtcomm = request.Form("txtcomm")

	Dim strSql
	strSql ="[db_event].[dbo].sp_Ten_event_comment_update ('U','"&userid&"','"&Cidx&"','"&txtcomm&"','"&txtcommURL&"','"&spoint&"')"
	rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly, adCmdStoredProc
		IF Not (rsget.EOF OR rsget.BOF) THEN
			returnValue = rsget(0)
		ELSE
			returnValue = null
		END IF
	rsget.close
		
   IF returnValue = 1 THEN	
   		If returnurl <> "" Then
   			referer = returnurl
		End If
	response.redirect(referer)	
	dbget.close()	:	response.End
   ELSE
     response.write "<script>alert('데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해 주십시오.');</script>"
	 response.write "<script>location.replace('" + Cstr(referer) + CStr(pagereload) + "');</script>"
	 dbget.close()	:	response.End
   END IF 
   
end if

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->