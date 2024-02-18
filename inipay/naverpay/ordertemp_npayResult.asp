<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet="UTF-8"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/login/checkBaguniLogin.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/inipay/naverpay/incNaverpayCommon.asp"-->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/util/rndSerial.asp" -->
<!-- #include virtual="/inipay/common/orderTempFunction.asp" -->
<%
Dim vIdx, P_resultCode, P_resultMsg, P_Rid, P_Tid
Dim sqlStr
vIdx = Request("ordsn")
vIdx = rdmSerialDec(vIdx)
P_resultCode = Request("resultCode")
P_resultMsg = Request("resultMessage")
P_Rid = Request("reserveId")
P_Tid = Request("paymentId")

if vIdx="" then
	Response.Write "<script>alert('잘못된 접속입니다. 파라메터 없음[004]');opener.location.replace('" & wwwUrl & "/');self.close();</script>"
	dbget.close()
	Response.End
end if

Dim vQuery
Dim vSitename : vSitename = "10x10"

''선저장 
vQuery = "UPDATE [db_order].[dbo].[tbl_order_temp] "
vQuery = vQuery & " SET P_TID = convert(varchar(50),'" & P_Tid & "')" & VbCRLF
IF (P_resultCode="Success") then
	vQuery = vQuery & " , P_STATUS = 'S01' " & VbCRLF		'인증 성공(승인 전단계)
else
    vQuery = vQuery & " , P_STATUS = 'F01' " & VbCRLF		'인증 실패 (취소 등)
    vQuery = vQuery & " , P_RMESG1 = convert(varchar(500),'" & P_resultMsg & "') " & VbCRLF		'실패사유
end if
vQuery = vQuery & " WHERE temp_idx = '" & vIdx & "'"                                  '' P_NOTI is temp_idx
dbget.execute vQuery


If P_resultCode<>"Success" Then '결제 예약 결과가 실패일 경우
	if P_resultMsg="userCancel" then
		Response.write "<script type='text/javascript'>alert('결제를 취소하셨습니다. 주문 내용 확인 후 다시 결제해주세요.');opener.location.replace('"&SSLUrl&"/inipay/UserInfo.asp');self.close();</script>"
	else
		Response.write "<script type='text/javascript'>alert('01. 네이버페이 실패가 발생하였습니다. 다시 시도해 주세요.');opener.location.replace('"&SSLUrl&"/inipay/UserInfo.asp');self.close();</script>"
	end if

	dbget.close()
	Response.End
End If


Dim paySuccess, partialCancelAvail, payMethod, iPaymethod
paySuccess = false																		' 결제 성공 여부

''======================================================================================================================
'' 네이버페이 처리


'' 0. 동일한 네이버결제번호가 있는지 확인
dim p_orderserial, p_issuccess, p_dumi
vQuery = "Select top 1 P_STATUS, isNULL(orderserial,'') as orderserial,isSuccess From [db_order].[dbo].[tbl_order_temp] where temp_idx = '" & vIdx & "' and P_TID='" & P_Tid & "' order by temp_idx desc"
rsget.CursorLocation = adUseClient
rsget.Open vQuery, dbget, adOpenForwardOnly, adLockReadOnly
IF Not rsget.EOF THEN
    p_orderserial = rsget("orderserial")
    p_issuccess   = rsget("isSuccess")
	if rsget("P_STATUS")<>"S01" then
		response.write "<script>alert('중복된 주문입니다. 확인해 주세요.[EC02] ')</script>"
		response.write "<script>opener.location.replace('" & wwwUrl & "/inipay/shoppingbag.asp')</script>"
		dbget.close()
		response.end
	end if
else
	response.write "<script>alert('주문 또는 결제정보가 잘못되었습니다. 다시 시도해 주세요.[EC01]')</script>"
	response.write "<script>opener.location.replace('" & wwwUrl & "/inipay/shoppingbag.asp')</script>"
	dbget.close()
	response.end
end if
rsget.Close

''Swing Browser 에서 get을 두번 쏨 좀 이상. //2018/03/20-------------------------
Dim isSwingBrouser, isSwingBrouserDuppCASE
isSwingBrouser = Instr(LCASE(request.serverVariables("HTTP_USER_AGENT")),"swing")>0

if (isSwingBrouser) and (p_orderserial<>"") then
    response.Cookies("shoppingbag").domain = "10x10.co.kr"
    response.Cookies("shoppingbag")("before_orderserial") = p_orderserial
    response.Cookies("shoppingbag")("before_issuccess") = LCASE(p_issuccess)
    p_dumi=TenOrderSerialHash(p_orderserial)
    %>
    <script type="text/javascript">
    function onLoadFn(){
        try{
            opener.goResultPage("<%=wwwUrl%>/inipay/DisplayOrder.asp?dumi=<%=p_dumi%>");
            self.close();
        }catch(s){
            location.replace("/inipay/DisplayOrder.asp?dumi=<%=p_dumi%>");
        }
	}
    </script>
    <body onload="javascript:onLoadFn()"></body>
    <%
    dbget.close()
    response.end
end if
''-------------------------------------------------------------------------


Dim retChkOK, oshoppingbag, iErrStr, ireserveParam 
iErrStr = ""
retChkOK = fnCheckOrderTemp(vIdx, oshoppingbag,iErrStr, ireserveParam, "NP")

if NOT(retChkOK) then
    response.write "<script>alert('처리중 오류가 발생하였습니다.\r\n- "&replace(iErrStr,"'","")&"');</script>"
    response.write "<script>opener.location.replace('" & wwwUrl & "/inipay/shoppingbag.asp');self.close();</script>"
    dbget.close()
    response.end
end if

if (oshoppingbag is Nothing) then
    response.write "<script>alert('처리중 오류가 발생하였습니다..\r\n- "&replace(iErrStr,"'","")&"');</script>"
    response.write "<script>opener.location.replace('" & wwwUrl & "/inipay/shoppingbag.asp');self.close();</script>"
    dbget.close()
    response.end
end if


''201712 임시장바구니 변경.
dim iorderserial
iErrStr = ""
iorderserial = oshoppingbag.SaveOrderDefaultDB_TmpBaguni(vIdx, iErrStr)

if (iErrStr<>"") then
    response.write iErrStr
    response.write "<script language='javascript'>alert('결제는 이루어 지지 않았습니다. \n\n: 오류 -" & replace(iErrStr,"'","") & "');</script>"

    ''2015/08/16 수정
	'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','주문저장중오류(승인이전) :" + vIdx +":"+ replace(iErrStr,"'","") + "'"
	'dbget.Execute sqlStr
    dbget.close()
	response.end
end if


'' 1. 결제 승인 요청
Dim NPay_Result
Set NPay_Result = fnCallNaverPayApply(P_Tid)
if NPay_Result.code="Success" then
	'// 승인 성공 저장
	vQuery = "UPDATE [db_order].[dbo].[tbl_order_temp] "
	vQuery = vQuery & " SET P_STATUS = 'S02' " & VbCRLF		'승인성공
	vQuery = vQuery & " , PayResultCode = 'ok' " & VbCRLF
	vQuery = vQuery & " WHERE temp_idx = '" & vIdx & "'"
	dbget.execute vQuery	
Else
    payMethod = NPay_Result.primaryPayMeans
    Select Case payMethod
		Case "CARD"
		    iPaymethod = "100"
		Case "BANK"
		    iPaymethod = "20"
		Case Else
		    iPaymethod = "20"
	End Select
	
	'// 결제 실패 사유 저장
	vQuery = "UPDATE [db_order].[dbo].[tbl_order_temp] "
	vQuery = vQuery & " SET P_STATUS = 'F02' " & VbCRLF		'승인 실패
	vQuery = vQuery & " , P_RMESG1 = convert(varchar(500),'" & replace(NPay_Result.message,"'","") & "') " & VbCRLF		'실패사유
	vQuery = vQuery & " , Tn_paymethod = '"&iPaymethod&"'" 
	vQuery = vQuery & " WHERE temp_idx = '" & vIdx & "'"
	dbget.execute vQuery
    
    
    '// 실패 보고 SMS 전송
    'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','승인오류 NP_wwwRst:"&application("Svr_Info")&"-"&vIdx&":" & replace(NPay_Result.message,"'","") &"'"
	'dbget.Execute sqlStr

	'response.write "<script>alert('02. 처리중 오류가 발생했습니다. 다시 시도해 주세요.\n(" & NPay_Result.message & ")')</script>"
	'response.write "<script>opener.location.replace('"&SSLUrl&"/inipay/UserInfo.asp');self.close();</script>"
	'response.end
end if
Set NPay_Result = Nothing

'' 2. 결제 확인
Set NPay_Result = fnCallNaverPayCheck(P_Tid)
if NPay_Result.code="Success" then

	'// 결제관련 결과 변수 저장
	paySuccess = true				'결제 성공여부
	partialCancelAvail = "1"		'부분취소 가능여부('0':불가, '1':가능)
	payMethod = NPay_Result.body.list.get(0).primaryPayMeans

	'// 결제 확인 성공 저장
    vQuery = "UPDATE [db_order].[dbo].[tbl_order_temp] " &VBCRLF
    vQuery = vQuery & " SET P_STATUS = '00'" &VBCRLF					'무조건 성공은 "00"!!

	'주결제 수단
	Select Case payMethod
		Case "CARD"
			vQuery = vQuery & " , Tn_paymethod = '100'" & VbCRLF																	''신용카드
			vQuery = vQuery & " , P_FN_CD1 = convert(varchar(5),'" & NPay_Result.body.list.get(0).cardCorpCode & "')" &VBCRLF			''신용카드코드
			iPaymethod = "100"
		Case "BANK"
			vQuery = vQuery & " , Tn_paymethod = '20'" & VbCRLF																		''실시간계좌이체
			vQuery = vQuery & " , P_FN_CD1 = convert(varchar(5),'" & NPay_Result.body.list.get(0).bankCorpCode & "')" &VBCRLF			''은행코드
			iPaymethod = "20"
		Case Else
			'// 네이버 포인트만 사용했을 시 구분값 없음 > 실시간이체로 처리
			vQuery = vQuery & " , Tn_paymethod = '20'" & VbCRLF
			iPaymethod = "20"
	End Select

    vQuery = vQuery & " , P_AUTH_NO = convert(varchar(50),'" & NPay_Result.body.list.get(0).cardAuthNo & "')" &VBCRLF				''승인번호.
    vQuery = vQuery & " , P_RMESG1 = convert(varchar(500),'" & replace(NPay_Result.message,"'","") & "') " &VBCRLF					''결제 결과메세지
    vQuery = vQuery & " , P_RMESG2 = convert(varchar(500),'" & NPay_Result.body.list.get(0).cardInstCount & "')" &VBCRLF			''할부개월수로사용.
    vQuery = vQuery & " , P_CARD_PRTC_CODE = convert(varchar(10),'" & partialCancelAvail & "') " &VBCRLF							''부분취소 가능여부
    vQuery = vQuery & " , pDiscount="& NPay_Result.body.list.get(0).npointPayAmount &"" &VBCRLF									''네이버페이 포인트 사용액
    vQuery = vQuery & " WHERE temp_idx = '" & vIdx & "'"
	dbget.execute vQuery
''else
''	'// 확인 실패 사유 저장
''	vQuery = "UPDATE [db_order].[dbo].[tbl_order_temp] "
''	vQuery = vQuery & " SET P_STATUS = 'F03' " & VbCRLF		'확인 실패
''	vQuery = vQuery & " , P_RMESG1 = convert(varchar(500),'" & replace(NPay_Result.message,"'","") & "') " & VbCRLF		'실패사유
''	vQuery = vQuery & " WHERE temp_idx = '" & vIdx & "'"
''	dbget.execute vQuery
''
''    '// 실패 보고 SMS 전송
''    sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','확인오류 NP_wwwRst:"&application("Svr_Info")&"-"&vIdx&":" & replace(NPay_Result.message,"'","") &"'"
''	dbget.Execute sqlStr
''
''	response.write "<script>alert('03. 처리중 오류가 발생했습니다. 고객센터로 문의해 주세요.\n(" & NPay_Result.message & ")')</script>"
''	response.write "<script>opener.location.replace('"&SSLUrl&"/inipay/shoppingbag.asp');self.close();</script>"
''	response.end
End if
Set NPay_Result = Nothing


'' 3. 실 주문정보 저장 
Dim vResult, vIsSuccess
iErrStr = ""
Call oshoppingbag.SaveOrderResultDB_TmpBaguni(vIdx, iPaymethod, iErrStr, vResult, vIsSuccess)

if (iErrStr<>"") then
    response.write iErrStr
    Response.write "<script type='text/javascript'>alert('04. 주문 처리 과정중 오류가 발생하였습니다. 고객센터로 문의해 주세요.');</script>"
    response.write "<script>opener.location.replace('"&SSLUrl&"/inipay/shoppingbag.asp');self.close();</script>"
	dbget.close()
    response.end
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

response.Cookies("shoppingbag").domain = "10x10.co.kr"
response.Cookies("shoppingbag")("before_orderserial") = iorderserial

if (vIsSuccess) then
	response.Cookies("shoppingbag")("before_issuccess") = "true"
else
	response.Cookies("shoppingbag")("before_issuccess") = "false"
end if



dim dumi : dumi=TenOrderSerialHash(iorderserial)

''비회원인 경우 orderserial-uk 값 저장. 2017/10/23 require commlib
IF (vResult = "ok") and (ireserveParam.FUserID="") then
    Call fnUserLogCheck_AddGuestOrderserial_UK(iorderserial,request.Cookies("shoppingbag")("GSSN")) 
end if

'' 4. 현금 영수증 대상 금액 확인
''    - 실시간계좌 이체이면서 현금영수증 발급 신청을 한경우에 한함
if paySuccess and ireserveParam.FCashreceiptreq="Y" then				'and payMethod="BANK" (계좌이체만 > 네이버포인트로 신용카드도 포함)
	Set NPay_Result = fnCallNaverPayCashAmt(P_Tid)

	if NPay_Result.code="Success" then
		dim cr_price, sup_price, tax, srvc_price, TenSpendCash
		
		TenSpendCash = CLng(ireserveParam.FSpendtencash) + CLng(ireserveParam.FSpendgiftmoney)     '''예치금 사용내역 추가..

		cr_price = CLng(NPay_Result.body.totalCashAmount) + TenSpendCash					'// 총 대상금액
		sup_price   = CLng(NPay_Result.body.supplyCashAmount) + CLng(TenSpendCash*10/11)	'// 현금성 공급가
		tax         = cr_price - sup_price													'// 현금성 과세액
		srvc_price  = 0

		if cr_price>0 then
	        sqlStr = " update [db_order].[dbo].tbl_order_master"
	        sqlStr = sqlStr + " set cashreceiptreq='R'"
	        sqlStr = sqlStr + " where orderserial='" + iorderserial + "'"
	        dbget.Execute sqlStr

	        sqlStr = " insert into [db_log].[dbo].tbl_cash_receipt"
	        sqlStr = sqlStr + " (orderserial,userid,sitename,goodname, cr_price, sup_price, tax, srvc_price"
	        sqlStr = sqlStr + " ,buyername, buyeremail, buyertel, reg_num, useopt, cancelyn, resultcode)"
	        sqlStr = sqlStr + " values("
	        sqlStr = sqlStr + " '" & iorderserial & "'"
	        sqlStr = sqlStr + " ,'" & ireserveParam.FUserID & "'"
	        sqlStr = sqlStr + " ,'" & vSitename & "'"
	        sqlStr = sqlStr + " ,'" & html2db(ireserveParam.Fgoodname) & "'"
	        sqlStr = sqlStr + " ," & CStr(cr_price) & ""
	        sqlStr = sqlStr + " ," & CStr(sup_price) & ""
	        sqlStr = sqlStr + " ," & CStr(tax) & ""
	        sqlStr = sqlStr + " ," & CStr(srvc_price) & ""
	        sqlStr = sqlStr + " ,'" & ireserveParam.FBuyname & "'"
	        sqlStr = sqlStr + " ,'" & ireserveParam.FBuyemail & "'"
	        sqlStr = sqlStr + " ,'" & ireserveParam.FBuyhp & "'"
	        sqlStr = sqlStr + " ,'" & ireserveParam.FCashReceipt_ssn & "'"
	        sqlStr = sqlStr + " ,'" & ireserveParam.FCashreceiptuseopt & "'"
	        sqlStr = sqlStr + " ,'N'"
	        sqlStr = sqlStr + " ,'R'"
	        sqlStr = sqlStr + " )"

	        dbget.Execute sqlStr
		end if

	else
	    '// 실패 보고 SMS 전송
	    'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','현금영수증 처리오류 NP_wwwRst:"&application("Svr_Info")&"-"&iorderserial&":" & replace(NPay_Result.message,"'","") &"'"
		'dbget.Execute sqlStr
	End if

	Set NPay_Result = Nothing
end if

set ireserveParam = Nothing
set oshoppingbag = Nothing
%>
<script type="text/javascript">
    function onLoadFn(){
        try{
            opener.goResultPage("<%=wwwUrl%>/inipay/DisplayOrder.asp?dumi=<%=dumi%>");
            self.close();
        }catch(s){
            location.replace("/inipay/DisplayOrder.asp?dumi=<%=dumi%>");
        }
    	//opener.location.replace("<%=wwwUrl%>/inipay/DisplayOrder.asp?dumi=<%=dumi%>");self.close();
	}
</script>
<body onload="javascript:onLoadFn()"></body>
<!-- #include virtual="/lib/db/dbclose.asp" -->