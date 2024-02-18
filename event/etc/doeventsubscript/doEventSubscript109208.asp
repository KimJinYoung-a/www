<%@codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet = "UTF-8"
'###########################################################
' Description : 서촌도감01 - 오프투얼론
' History : 2021.02.10 정태훈 생성
'###########################################################
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #INCLUDE Virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/event/lib/event_etc_function.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp"-->
<%
	Response.ContentType = "application/json"
	response.charset = "utf-8"
	dim currentDate, refer, refip, eventStartDate, eventEndDate
	Dim eCode, LoginUserid, mode, sqlStr, device, cnt, chasu, oJson
	dim vIsApp, mktTest, Cidx, txtcomm, booknum, txtcommURL, returnValue

    IF application("Svr_Info") = "Dev" THEN
        eCode = "104316"
    Else
        eCode = "109208"
    End If

	currentDate 	= date()
	LoginUserid		= getencLoginUserid()
	refip = request.ServerVariables("REMOTE_ADDR")
    refer = request.ServerVariables("HTTP_REFERER")
    txtcommURL=""
	eventStartDate  = cdate("2021-02-15")		'이벤트 시작일
	eventEndDate 	= cdate("2021-03-01")		'이벤트 종료일+1

	if LoginUserid="ley330" or LoginUserid="greenteenz" or LoginUserid="rnldusgpfla" or LoginUserid="cjw0515" or LoginUserid="thensi7" or LoginUserid = "motions" or LoginUserid = "jj999a" or LoginUserid = "phsman1" or LoginUserid = "jjia94" or LoginUserid = "seojb1983" or LoginUserid = "kny9480" or LoginUserid = "bestksy0527" or LoginUserid = "mame234" or LoginUserid = "corpse2" or LoginUserid = "starsun726"  or LoginUserid = "bora2116" or LoginUserid = "tozzinet" then
		mktTest = True
	end if

	if mktTest then
		currentDate = cdate("2021-02-15")
	else
		currentDate 	= date()
	end if
	device = "W"
    mode = request("mode")
    Cidx = requestCheckVar(request.Form("Cidx"),10)
    
    Set oJson = jsObject()
    Dim objCmd
    Set objCmd = Server.CreateObject("ADODB.COMMAND")

    if mode="add" then

        txtcomm	= html2db(CheckCurse(request("txtcomm")))
        booknum = requestCheckVar(request("booknum"),1)
        'commentcount = getcommentexistscount(LoginUserid, eCode, "", "", "", "Y")

        if checkNotValidTxt(txtcomm) then
            oJson("response") = "err"
            oJson("faildesc") = "내용에 유효하지 않은 글자가 포함되어 있습니다. 다시 작성 해주세요."
            oJson.flush
            Set oJson = Nothing
            dbget.close()	:	response.End
        end if
        'if commentcount > 0 then
        '    oJson("response") = "err"
        '    oJson("faildesc") = "이미 참여 하였습니다."
        '    oJson.flush
        '    Set oJson = Nothing
        '    dbget.close()	:	response.End
        'end if

		With objCmd
		.ActiveConnection = dbget
		.CommandType = adCmdText
		.CommandText = "{?= call [db_event].[dbo].sp_Ten_event_comment_insert('"&eCode&"','0','"&LoginUserid&"','"&txtcomm&"','"&booknum&"','0','"&refip&"','"&txtcommURL&"','"&device&"')}"
		.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
		.Execute, , adExecuteNoRecords
		End With	
	    returnValue = objCmd(0).Value
	    Set objCmd = Nothing
        
        IF returnValue > 0 THEN	
            oJson("response") = "ok"
            oJson.flush
            Set oJson = Nothing
            dbget.close() : Response.End
        ELSE
            oJson("response") = "err"
            oJson("faildesc") = "데이터처리에 문제가 발생했습니다. 다시 시도 해주세요."
            oJson.flush
            Set oJson = Nothing
            dbget.close()	:	response.End
        END IF
    elseif mode="del" then
		With objCmd
		.ActiveConnection = dbget
		.CommandType = adCmdText
		.CommandText = "{?= call [db_event].[dbo].sp_Ten_event_comment_delete ("&Cidx&",'"&LoginUserid&"',0,0)}"		
		.Parameters.Append .CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
		.Execute, , adExecuteNoRecords
		End With	
	    returnValue = objCmd(0).Value		    	
	    Set objCmd = Nothing
        IF returnValue > 0 THEN	
            oJson("response") = "ok"
            oJson.flush
            Set oJson = Nothing
            dbget.close() : Response.End
        ELSE
            oJson("response") = "err"
            oJson("faildesc") = "데이터처리에 문제가 발생했습니다. 다시 시도 해주세요."
            oJson.flush
            Set oJson = Nothing
            dbget.close()	:	response.End
        END IF
    end if
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->