<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<%
    Response.Charset="UTF-8"
    Response.AddHeader "Cache-Control","no-cache"
    Response.AddHeader "Expires","0"
    Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<%
Dim refip
Dim eCode, com_egCode, bidx,Cidx
Dim userid, txtcomm, txtcommURL, mode, spoint
Dim returnValue
Dim objCmd

mode        = requestCheckVar(request.Form("mode"),4)
eCode       = requestCheckVar(request.Form("eventid"),10)
com_egCode  = requestCheckVar(request.Form("com_egC"),10)
bidx        = requestCheckVar(request.Form("bidx"),10)
Cidx        = requestCheckVar(request.Form("Cidx"),10)
spoint      = requestCheckVar(request.Form("spoint"),10)
txtcommURL  = requestCheckVar(request.Form("txtcommURL"),128)
txtcommURL  = html2db(txtcommURL)
refip       = request.ServerVariables("REMOTE_ADDR")

IF spoint = "" THEN spoint = 0
IF bidx = "" THEN bidx = 0
IF com_egCode = "" THEN com_egCode = 0
userid      = GetLoginUserID

Set objCmd = Server.CreateObject("ADODB.COMMAND")
IF mode="add" THEN

    txtcomm = request.Form("txtcomm")
    txtcomm = html2db(txtcomm)

	if checkNotValidTxt(txtcomm) then
		Alert_move "내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요.","about:blank"
		dbget.close()	:	response.End
	end if

	With objCmd
		.ActiveConnection = dbget
		.CommandType = adCmdText
		.CommandText = "{?= call [db_event].[dbo].sp_Ten_event_comment_insert ("&eCode&","&com_egCode&",'"&userid&"','"&txtcomm&"',"&spoint&","&bidx&",'"&refip&"','"&txtcommURL&"')}"
		.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
		.Execute, , adExecuteNoRecords
	End With
	returnValue = objCmd(0).Value
	
	Set objCmd = Nothing

	IF returnValue = 1 THEN
		response.write "OK||코멘트 작성이 완료 되었습니다."
		dbget.close()	:	response.End
	ELSEIF returnValue = 2 THEN
		response.write "OK||한번에 5회 이상 연속 등록 불가능합니다."
	 	dbget.close()	:	response.End
    ELSE
        response.write "FAIL||데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해 주십시오."
        dbget.close()	:	response.End
    END IF

ELSEIF mode="del" THEN
	
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
        response.write "OK||삭제가 완료 되었습니다."
	    dbget.close()	:	response.End
    ELSE
        response.write "FAIL||데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해 주십시오."
	    dbget.close()	:	response.End
    END IF 

ELSEIF mode="edit" THEN

    txtcomm = request.Form("txtcomm")
    txtcomm = html2db(txtcomm)

	if checkNotValidTxt(txtcomm) then
		Alert_move "내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요.","about:blank"
		dbget.close()	:	response.End
	end if

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
        response.write "OK||수정이 완료 되었습니다."
        dbget.close()	:	response.End
    ELSE
        response.write "FAIL||데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해 주십시오."
        dbget.close()	:	response.End
    END IF

END IF
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->