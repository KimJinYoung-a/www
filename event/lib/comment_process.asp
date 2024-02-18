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
dim alertTxt 
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
alertTxt = request("alertTxt")

IF alertTxt = "" THEN alertTxt = "이벤트에 참여 하였습니다."
IF spoint = "" THEN spoint = 0
IF bidx = "" THEN bidx = 0
IF com_egCode = "" THEN com_egCode = 0

If pagereload = "ON" Then 
	pagereload = "&pagereload="&pagereload 
Else 
	pagereload = "" 
End if

dim referer,refip, returnurl
referer = request.ServerVariables("HTTP_REFERER")
refip = request.ServerVariables("REMOTE_ADDR")
returnurl = requestCheckVar(request.Form("returnurl"),100)

Dim vGubun
vGubun = requestCheckVar(request.Form("gubun"),10)

dim sqlStr, returnValue
Dim objCmd
Set objCmd = Server.CreateObject("ADODB.COMMAND")
if mode="add" then
	
	txtcomm = request.Form("txtcomm")

	if checkNotValidTxt(txtcomm) then
		Alert_move "내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요.","about:blank"
		dbget.close()	:	response.End
	end if

	'2017-02-10 76169이벤트 욕체크 유태욱
	txtcomm	= html2db(CheckCurse(request.Form("txtcomm")))

'	txtcomm = html2db(txtcomm)

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
		IF application("Svr_Info") = "Dev" THEN
			if eCode = 90350 then
				response.write "<script>alert('등록되었습니다. 8월 8일 텐바이텐 공지사항을 확인해주세요!');</script>"			
			end if
		Else
			if eCode = 96191 then
				response.write "<script>alert('등록되었습니다. 8월 8일 텐바이텐 공지사항을 확인해주세요!');</script>"
			end if
		End If
		If eCode="80736" Then
		response.write "<script>location.replace('" + Cstr(referer) + CStr(hookcode) + CStr(pagereload) +"&#cmtfrm');</script>"
		elseIf eCode="113476" Then
		response.write "<script>location.replace('" + returnurl +"');</script>"
		elseIf eCode="116737" Then
		response.write "<script>location.replace('" + returnurl +"');</script>"
		Else
		response.write "<script> alert('"& alertTxt &"'); location.replace('" + Cstr(referer) + CStr(hookcode) + CStr(pagereload) +"');</script>"
		End If
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
elseif mode="addo" Then '// 하루 1개 등록

	txtcomm = request.Form("txtcomm")
	
	if checkNotValidTxt(txtcomm) then
		Alert_move "내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요.","about:blank"
		dbget.close()	:	response.End
	end if
	txtcomm = html2db(txtcomm)

	strSql = "select count(*) as cnt from " & vbcrlf
	strSql = strSql & "db_event.dbo.tbl_event_comment " & vbcrlf
	strSql = strSql & "where evt_code='"&eCode&"' " & vbcrlf
	strSql = strSql & "and userid = '"&userid&"' and evtcom_using = 'Y' " & vbcrlf
	strSql = strSql & "and convert(varchar, evtcom_regdate,23) = convert(varchar, getdate(),23) " & vbcrlf
	rsget.Open strSql, dbget, 1
	If rsget("cnt") >= 1 Then
		Response.Write  "<script>" &_
						"	alert('하루에 한번만 참여 가능합니다');" &_
						"	location.replace('" + Cstr(referer&"#need") + "');" &_
						"</script>"
		dbget.close()	:	response.End
	End If
	rsget.Close

	'입력 프로세스
	strSql = ""
	strSql = strSql & "Insert into db_event.dbo.tbl_event_comment " & vbcrlf
	strSql = strSql & "(evt_code, userid, evtcom_txt, blogurl, evtcom_regdate, evtcom_point) " & vbcrlf
	strSql = strSql & "VALUES " & vbcrlf
	strSql = strSql & "('"&eCode&"','"&userid&"','"&txtcomm&"','"&txtcommURL&"', getdate(),'" & spoint &"') "
	dbget.execute strSql
	Response.Write  "<script>" &_
					"	alert('"& alertTxt &"');" &_
					"	location.replace('" + Cstr(referer) + "');" &_
					"</script>"
	dbget.close() : Response.End

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
		If eCode="80736" Then
		response.redirect(referer+"&#cmtfrm")
		Else
		response.redirect(referer)
		End If
		dbget.close()	:	response.End
   ELSE
     response.write "<script>alert('데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해 주십시오.');</script>"
	 response.write "<script>location.replace('" + Cstr(referer) + CStr(pagereload) + "');</script>"
	 dbget.close()	:	response.End
   END IF 

elseif mode="edit" then
	Cidx=requestCheckVar(request.Form("Cidx"),10)	
	
	If vGubun = "red" Then
		txtcomm = request.Form("txtcomm_top") & "|^!1!0x1!0!W!k!d!^|" & request.Form("txtcomm")
	Else
		txtcomm = request.Form("txtcomm")
	End If

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