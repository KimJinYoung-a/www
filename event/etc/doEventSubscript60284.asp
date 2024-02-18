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
' Description :  컬쳐스테이션 #07. 바로 그, [진실공방]
' History : 2015.03.16 유태욱 생성
'####################################################
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<%
dim eCode
IF application("Svr_Info") = "Dev" THEN
	eCode   =  21504
Else
	eCode   =  60284
End If

function getnowdate()
	dim nowdate
	
	nowdate = date()
	'nowdate = "2015-03-17"
	
	getnowdate = nowdate
end function

dim mode, userid, txtcomm, com_egCode, bidx, spoint, txtcommURL, Cidx, evtcom_idx
dim tmpcomment, tmpcommentgubun , tmpcommenttext, gubun
	mode = requestcheckvar(request("mode"),32)
	txtcomm = request("txtcomm")
	com_egCode=requestCheckVar(request("com_egC"),10)
	bidx = getNumeric(requestCheckVar(request("bidx"),10))
	spoint = getNumeric(requestCheckVar(request("spoint"),10))
	txtcommURL = requestCheckVar(request("txtcommURL"),128)
	Cidx= getNumeric(requestCheckVar(request("Cidx"),10))
	txtcommURL= getNumeric(requestCheckVar(request("gubun"),1))
	txtcommURL = html2db(txtcommURL)
	userid = getloginuserid()

IF bidx = "" THEN bidx = 0
IF com_egCode = "" THEN com_egCode = 0
IF spoint = "" THEN spoint = 0

dim commentexistscount
commentexistscount=0

dim referer
referer = request.ServerVariables("HTTP_REFERER")
if InStr(referer,"10x10.co.kr")<1 then
	Response.Write "잘못된 접속입니다."
	'dbget.close() : Response.End
end if

dim refip
refip = request.ServerVariables("REMOTE_ADDR")

dim sqlStr, returnValue, objCmd

If not( getnowdate>="2015-03-17" and getnowdate<"2015-04-10") Then
	Response.Write "<script type='text/javascript'>alert('이벤트 응모 기간이 아닙니다.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
	dbget.close() : Response.End
End IF
If userid = "" Then
	Response.Write "<script type='text/javascript'>alert('로그인을 해주세요'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
	dbget.close() : Response.End
End IF

if mode="add" then	
	'// 본인 응모수
	commentexistscount=getcommentexistscount(userid, eCode, "", "", "", "Y")
	if commentexistscount>=1 then
		Response.Write "<script type='text/javascript'>alert('한 아이디당 1회까지만 응모할 수 있습니다.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
		dbget.close() : Response.End
	end if
	if txtcommURL="" then
		Response.Write "<script type='text/javascript'>alert('궁금한점을 선택해주세요.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
		dbget.close() : Response.End
	end if

	Set objCmd = Server.CreateObject("ADODB.COMMAND")
		if checkNotValidTxt(txtcomm) then
			Response.Write "<script type='text/javascript'>alert('내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
			dbget.close() : Response.End
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
		Response.Write "<script type='text/javascript'>"
		Response.Write "	alert('응모완료!');"
		Response.Write " 	parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'"
		Response.Write "</script>"
		dbget.close() : Response.End
	ELSEIF returnValue = 2 THEN	
		Response.Write "<script type='text/javascript'>alert('한번에 5회 이상 연속 등록 불가능합니다.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
		dbget.close() : Response.End
	ELSE
		Response.Write "<script type='text/javascript'>alert('데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해 주십시오.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
		dbget.close() : Response.End
	END IF

elseif mode="del" then
	if Cidx="" then
		Response.Write "<script type='text/javascript'>alert('글번호가 없습니다.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
		dbget.close() : Response.End
	end if

	Set objCmd = Server.CreateObject("ADODB.COMMAND")
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
		Response.Write "<script type='text/javascript'>parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
		dbget.close() : Response.End
   ELSE
		Response.Write "<script type='text/javascript'>alert('데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해 주십시오.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
		dbget.close() : Response.End
   END IF 

elseif mode="edit" then
	if Cidx="" then
		Response.Write "<script type='text/javascript'>alert('글번호가 없습니다.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
		dbget.close() : Response.End
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
		Response.Write "<script type='text/javascript'>parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
		dbget.close() : Response.End
   ELSE
		Response.Write "<script type='text/javascript'>alert('데이터 처리에 문제가 발생하였습니다. 관리자에게 문의해 주십시오.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
		dbget.close() : Response.End
   END IF
   
else
	Response.Write "<script type='text/javascript'>alert('정상적인 경로가 아닙니다.'); parent.top.location.href='/event/eventmain.asp?eventid="&eCode&"'</script>"
	dbget.close() : Response.End
end if
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->