<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/inipay/common/orderTempFunction.asp" -->
<%
Dim vIdx
vIdx = requestCheckvar(Request("LGD_OID"),20)

Dim retChkOK, oshoppingbag, iErrStr, ireserveParam
retChkOK = fnCheckOrderTemp(vIdx, oshoppingbag,iErrStr, ireserveParam, "DH")

if NOT(retChkOK) then
    response.write "<script>alert('처리중 오류가 발생하였습니다.\r\n- "&replace(iErrStr,"'","")&"');</script>"
    response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp');self.close();</script>"
    dbget.close()
    response.end
end if

if (oshoppingbag is Nothing) then
    response.write "<script>alert('처리중 오류가 발생하였습니다..\r\n- "&replace(iErrStr,"'","")&"');</script>"
    response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp');self.close();</script>"
    dbget.close()
    response.end
end if


''##############################################################################
''디비작업
''##############################################################################
''201712 임시장바구니 변경.
dim iorderserial
iErrStr = ""
iorderserial = oshoppingbag.SaveOrderDefaultDB_TmpBaguni(vIdx, iErrStr)
'' iorderserial = oshoppingbag.SaveOrderDefaultDB(iorderParams, iErrStr)

if (iErrStr<>"") then
    response.write iErrStr
    response.write "<script language='javascript'>alert('결제는 이루어 지지 않았습니다. \n\n: 오류 -" & replace(iErrStr,"'","") & "');</script>"

    ''2015/08/16 수정
	'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','주문저장중오류(승인이전)dHp :" + vIdx +":"+ replace(iErrStr,"'","") + "'"
	'dbget.Execute sqlStr

	response.end
end if

'On Error Goto 0

'############################################## 모바일 결제 ################################################
Dim McashObj, M_Userid, M_Username, ResultCode, ResultMsg

    '/*
    ' * [최종결제요청 페이지(STEP2-2)]
    ' *
    ' * LG유플러스으로 부터 내려받은 LGD_PAYKEY(인증Key)를 가지고 최종 결제요청.(파라미터 전달시 POST를 사용하세요)
    ' */

	Dim configPath, CST_PLATFORM, CST_MID, LGD_MID, LGD_PAYKEY, isDBOK
    CST_MID = "tenbyten02"

    configPath = "C:/LGDacom"  'LG유플러스에서 제공한 환경파일("/conf/lgdacom.conf, /conf/mall.conf") 위치 지정.

    '/*
    ' *************************************************
    ' * 1.최종결제 요청 - BEGIN
    ' *  (단, 최종 금액체크를 원하시는 경우 금액체크 부분 주석을 제거 하시면 됩니다.)
    ' *************************************************
    ' */
	IF application("Svr_Info") = "Dev" THEN
		CST_PLATFORM = "test"
	Else
		CST_PLATFORM = "service"
	End If

    ''CST_PLATFORM = "service"
    if CST_PLATFORM = "test" then
        LGD_MID = "t" & CST_MID
    else
        LGD_MID = CST_MID
    end if
    LGD_PAYKEY                 = trim(request("LGD_PAYKEY"))
'rw LGD_PAYKEY
'rw LGD_MID
'rw configPath
'response.end

    Dim xpay            '결제요청 API 객체
    Dim amount_check    '금액비교 결과
    Dim j
    Dim itemName

	'해당 API를 사용하기 위해 setup.exe 를 설치해야 합니다.
    Set xpay = server.CreateObject("XPayClientCOM.XPayClient")
    xpay.Init configPath, CST_PLATFORM

    xpay.Init_TX(LGD_MID)
    xpay.Set "LGD_TXNAME", "PaymentByKey"
    xpay.Set "LGD_PAYKEY", LGD_PAYKEY

    '금액을 체크하시기 원하는 경우 아래 주석을 풀어서 이용하십시요.
	'DB_AMOUNT = "DB나 세션에서 가져온 금액" 	'반드시 위변조가 불가능한 곳(DB나 세션)에서 금액을 가져오십시요.
	'xpay.Set "LGD_AMOUNTCHECKYN", "Y"
	'xpay.Set "LGD_AMOUNT", DB_AMOUNT

    '/*
    ' *************************************************
    ' * 1.최종결제 요청(수정하지 마세요) - END
    ' *************************************************
    ' */

    '/*
    ' * 2. 최종결제 요청 결과처리
    ' *
    ' * 최종 결제요청 결과 리턴 파라미터는 연동메뉴얼을 참고하시기 바랍니다.
    ' */
    Dim Tradeid, vTID, vOrderResult

    if  xpay.TX() then
        '1)결제결과 화면처리(성공,실패 결과 처리를 하시기 바랍니다.)

        '아래는 결제요청 결과 파라미터를 모두 찍어 줍니다.
		Tradeid = Trim(xpay.Response("LGD_OID", 0))
		vTID   = Trim(xpay.Response("LGD_TID", 0))
		vOrderResult = Tradeid & "|" & vTID

		''Dim vErrorMsg
        ''vErrorMsg = "[" & Trim(xpay.Response("LGD_RESPCODE", 0)) & "]" & Trim(xpay.Response("LGD_RESPMSG", 0))

        '' 자동취소 사용안함.
''        if xpay.resCode = "0000" then
''        	'최종결제요청 결과 성공 DB처리
''           	'최종결제요청 결과 성공 DB처리 실패시 Rollback 처리
''           	isDBOK = true 'DB처리 실패시 false로 변경해 주세요.
''
''           	if isDBOK then

''           	else

''           		xpay.Rollback("상점 DB처리 실패로 인하여 Rollback 처리 [TID:" & xpay.Response("LGD_TID",0) & ",MID:" & xpay.Response("LGD_MID",0) & ",OID:" & xpay.Response("LGD_OID",0) & "]")
''                Response.Write("TX Rollback Response_code = " & xpay.resCode & "<br>")
''                Response.Write("TX Rollback Response_msg = " & xpay.resMsg & "<p>")
''
''                if "0000" = xpay.resCode then
''                 	Response.Write("자동취소가 정상적으로 완료 되었습니다.<br>")
''                else
''                 	Response.Write("자동취소가 정상적으로 처리되지 않았습니다.<br>")
''                end if
''          	end if
''        else

''          	'결제결제요청 결과 실패 DB처리
''			Set cErrLog = New CShoppingBag
''			Call cErrLog.MobileDacomErrorLog(GetLoginUserID(), request("userphone"), xpay.resCode, Replace(xpay.resMsg,"'","w"))
''			Set cErrLog = Nothing
''          	Response.Write "<script language='javascript'>alert('최종결제요청이 실패하였습니다.\n\n메세지:" & vErrorMsg & "\n\n결제를 다시 시도 해보시고 그래도 같은 결과면\n위의 메세지 코드와 내용을 모메해두셨다가\n고객센터(Tel.1644-6030)에 연락을 주시기 바랍니다.');window.close();</script>"
''        end if
    else
    	dim cErrLog
		''Set cErrLog = New CShoppingBag
		''Call cErrLog.MobileDacomErrorLog(GetLoginUserID(), request("userphone"), xpay.resCode, Replace(Left(xpay.resMsg,60),"'",""))
		''Set cErrLog = Nothing

		'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','Hp-W-"&application("Svr_Info")&" [" + xpay.resCode + "] " & Replace(Left(xpay.resMsg,60),"'","") & "'"
    	'dbget.Execute sqlStr

    end if

	ResultCode = xpay.resCode
	ResultMsg = Left(xpay.resMsg,90)

Set xpay = Nothing

'############################################## 모바일 결제 ################################################

dim i_Resultmsg, AuthCode
i_Resultmsg = replace(ResultMsg,"|","_")

'iorderParams.Fresultmsg  = i_Resultmsg
'iorderParams.Fauthcode = AuthCode
'iorderParams.Fpaygatetid = vOrderResult
'iorderParams.IsSuccess = (ResultCode = "0000")

Dim vQuery
vQuery = "UPDATE [db_order].[dbo].[tbl_order_temp] " &VBCRLF
vQuery = vQuery & " SET P_STATUS = convert(varchar(3),'"&CHKIIF(ResultCode = "0000","00",ResultCode)&"')" &VBCRLF
vQuery = vQuery & " , P_TID= convert(varchar(50),'" & vOrderResult & "')" &VBCRLF				''승인번호.
vQuery = vQuery & " , P_AUTH_NO = convert(varchar(50),'" & AuthCode & "')" &VBCRLF				''승인번호.
vQuery = vQuery & " , P_RMESG1 = convert(varchar(500),'" & replace(i_Resultmsg,"'","") & "') " &VBCRLF					''결제 결과메세지
vQuery = vQuery & " , pDiscount=0" &VBCRLF									''네이버페이 포인트 사용액
vQuery = vQuery & " WHERE temp_idx = '" & vIdx & "'"
dbget.execute vQuery

        
Dim vResult, vIsSuccess
iErrStr = ""

Call oshoppingbag.SaveOrderResultDB_TmpBaguni(vIdx, "", iErrStr, vResult, vIsSuccess)
''Call oshoppingbag.SaveOrderResultDB(iorderParams, iErrStr)


if (iErrStr<>"") then
    response.write iErrStr
    response.write "<script language='javascript'>alert('작업중 오류가 발생하였습니다. 고객센터로 문의해 주세요.: \n\n: 오류 -" & replace(iErrStr,"'","") & "');</script>"
    dbget.close() : response.end
end if

if (Err) then
    iErrStr = replace(err.Description,"'","")

	response.write "<script>javascript:alert('작업중 오류가 발생하였습니다. 고객센터로 문의해 주세요.: \n\n" & iErrStr & "')</script>"
	response.write "<script>javascript:history.back();</script>"
	dbget.close() : response.end
end if


On Error resume Next
dim osms, helpmail
helpmail = oshoppingbag.GetHelpMailURL

    IF (vIsSuccess) THEN
        call sendmailorder(iorderserial,helpmail)

        set osms = new CSMSClass
		osms.SendJumunOkMsg ireserveParam.FBuyhp, iorderserial
	    set osms = Nothing

    end if
on Error Goto 0

''Save OrderSerial / UserID or SSN Key
response.Cookies("shoppingbag").domain = "10x10.co.kr"
response.Cookies("shoppingbag")("before_orderserial") = iorderserial

if (vIsSuccess) then
	response.Cookies("shoppingbag")("before_issuccess") = "true"
else
	response.Cookies("shoppingbag")("before_issuccess") = "false"
end if

dim dumi : dumi=TenOrderSerialHash(iorderserial)

''비회원인 경우 orderserial-uk 값 저장. 2017/10/23 require commlib
IF (vIsSuccess) and (ireserveParam.FUserID="") then
    Call fnUserLogCheck_AddGuestOrderserial_UK(iorderserial,request.Cookies("shoppingbag")("GSSN")) 
end if



'' 주문 결과 페이지로 이동
''SSL 경우 스크립트로 replace
response.write "<script language='javascript'>location.replace('" & wwwUrl & "/inipay/displayorder.asp?dumi="&dumi&"');</script>"
'response.redirect wwwUrl&"/inipay/displayorder.asp"
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->