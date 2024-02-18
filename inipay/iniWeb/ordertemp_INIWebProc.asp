<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
Response.CharSet="UTF-8"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
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
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/util/rndSerial.asp" -->
<!-- #include virtual="/inipay/common/orderTempFunction.asp" -->
<!-- #include virtual="/inipay/iniWeb/INIWeb_Util.asp" -->
<!-- #include virtual="/inipay/iniWeb/aspJSON1.17.asp" -->
<%
Function URLDecode(sConvert)
    Dim aSplit
    Dim sOutput
    Dim I
    If IsNull(sConvert) Then
       URLDecode = ""
       Exit Function
    End If

    ' convert all pluses to spaces
    sOutput = REPLACE(sConvert, "+", " ")

    ' next convert %hexdigits to the character
    aSplit = Split(sOutput, "%")

    If IsArray(aSplit) Then
      sOutput = aSplit(0)
      For I = 0 to UBound(aSplit) - 1
        sOutput = sOutput & _
          Chr("&H" & Left(aSplit(i + 1), 2)) &_
          Right(aSplit(i + 1), Len(aSplit(i + 1)) - 2)
      Next
    End If

    URLDecode = sOutput
End Function

Dim vIdx, P_resultCode, P_resultMsg, P_Rid, P_Tid
Dim sqlStr
vIdx = Request("oid")

if vIdx="" then
	Response.Write "<script>alert('잘못된 접속입니다. 파라메터 없음[004]');location.replace('" & wwwUrl & "/inipay/shoppingbag.asp');</script>"
	dbget.close()
	Response.End
end if

Dim vQuery
Dim vSitename : vSitename = "10x10"



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

	'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','주문저장중오류IniWeb(승인이전) :" + vIdx +":"+ replace(iErrStr,"'","") + "'"
	'dbget.Execute sqlStr
    dbget.close()
	response.end
end if


dim k
dim imid : imid = request.form("mid")    ''변수 주의! 

dim authUrl : authUrl = URLDecode(request.form("authUrl"))              ''인코딩해서 넘어왔음.
dim authToken : authToken = URLDecode(request.form("authToken"))        ''인코딩해서 넘어왔음.
dim icharset : icharset = "UTF-8" 
dim iformat : iformat = "JSON"    
dim price : price=ireserveParam.FPrice

'' 승인 통신
dim timestamp : timestamp = getIniWebTimestamp()
dim signature : signature = (getIniWebConfirmSignature(authToken,timestamp))
                
dim xmlHttp, postdata, strData, postdata2, strData2
IF application("Svr_Info")="Dev" THEN
    Set xmlHttp = CreateObject("Msxml2.ServerXMLHTTP.3.0")
Else
    Set xmlHttp = CreateObject("Msxml2.ServerXMLHTTP.3.0")
End If
postdata = "mid="&imid
postdata = postdata&"&authToken="&server.URLEncode(authToken)
postdata = postdata&"&signature="&server.URLEncode(signature)
postdata = postdata&"&timestamp="&timestamp
postdata = postdata&"&charset="&server.URLEncode(icharset)
postdata = postdata&"&format="&server.URLEncode(iformat)  ''&"&mKey="&server.URLEncode(INIWEB_mKey)
postdata = postdata&"&price="&price

''response.write "[postdata]"&postdata
On Error Resume Next
xmlHttp.open "POST",authUrl, False
xmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded; charset=utf-8"  ''UTF-8 charset 필요.
xmlHttp.setTimeouts 90000,90000,90000,90000 ''2013/03/14 추가
xmlHttp.Send postdata	'post data send

strData = BinaryToText(xmlHttp.responseBody, "UTF-8")

Set xmlHttp = nothing

IF Err.Number <> 0 then
    'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','xmlhttp :"&application("Svr_Info")&"-"&iorderserial&":"&replace(err.Description,"'","")&"'"
	'dbget.Execute sqlStr
		
	Response.write "<script language='javascript'>alert('002. 이니시스에 승인요청 중 오류가 발생하였습니다. ');</script>"
	dbget.close()
	Response.End
End If

On Error Goto 0

Dim oJSON, oJSON2
dim AuthCode, CARD_ClEvent, CardQuota, CARD_GWCode
dim resultMsg, CARD_Point, CARD_Interest, CARD_CheckFlag
dim resultCode, TotPrice, applPrice, tid, MOID, payMethod, payDevice, CardCode
dim applDate, applTime, goodsName
dim DirectBankCode, CardIssuerCode, PrtcCode
Dim iPaymethod, rentalPeriod, renntalPrice, rentalNo

'', CARD_PurchaseCode

Set oJSON = New aspJSON
oJSON.loadJSON(strData)

resultCode = oJSON.data("resultCode")
resultMsg    = oJSON.data("resultMsg")
AuthCode    = oJSON.data("applNum")                        '' 승인번호
CARD_ClEvent    = oJSON.data("CARD_ClEvent")               ''??
CardQuota    = oJSON.data("CARD_Quota")                    ''카드 할부기간
CARD_GWCode    = oJSON.data("CARD_GWCode")                 ''??
CARD_Point    = oJSON.data("CARD_Point")                   ''
CARD_Interest    = oJSON.data("CARD_Interest")             '' 카드 할부여부. (“1”이면 무이자할부)
''CARD_CheckFlag    = oJSON.data("CARD_CheckFlag")           ''??
''CARD_PurchaseCode    = oJSON.data("CARD_PurchaseCode")     ''??
TotPrice    = oJSON.data("TotPrice")                       ''거래금액
applPrice    = oJSON.data("applPrice")                     ''승인금액?
tid    = oJSON.data("tid")                          ''tid
MOID    = oJSON.data("MOID")                        ''MOID 원주문번호
payMethod = oJSON.data("payMethod")                 ''Card:신용카드, DirectBank:실시간계좌이체, OCBPoint:OKCashbag 포인트, HPP:핸드폰, VBank:무통장입금(가상계좌), RTPAY(이니렌탈)
payDevice = oJSON.data("payDevice")                 ''PC,ETC
CardCode   = oJSON.data("CARD_Code")                 ''CARD_Code
PrtcCode   = oJSON.data("CARD_PRTC_CODE")           ''부분취소 가능여부?
CardIssuerCode   = oJSON.data("CARD_BankCode")      '' 카드 발급사 코드
applDate   = oJSON.data("applDate")                 ''
applTime   = oJSON.data("applTime")                 ''
goodsName   = oJSON.data("goodsName")                 ''

DirectBankCode = oJSON.data("ACCT_BankCode")         ''은행코드

rentalPeriod = oJSON.data("RTPAY_rentalPeriod")         ''렌탈기간
renntalPrice = oJSON.data("RTPAY_rentalPrice")          ''월납입금액
rentalNo     = oJSON.data("RTPAY_rentalNo")             ''렌탈번호
Set oJSON = Nothing

if (goodsName="") then goodsName="10x10item"

''-------------------------------------------------------
dim i_Resultmsg
i_Resultmsg = replace(ResultMsg,"|","_")

'iorderParams.Fresultmsg  = i_Resultmsg
'iorderParams.Fauthcode = AuthCode
'iorderParams.Fpaygatetid = Tid
'iorderParams.IsSuccess = (ResultCode = "0000")

if (LCASE(payMethod)="directbank") or (LCASE(payMethod)="idirectbank") then
    iPaymethod = "20"
elseif (LCASE(payMethod)="hpp") then
    iPaymethod = "400"
elseif (LCASE(payMethod)="card") or (LCASE(payMethod)="vcard") then
    iPaymethod = "100"
elseif (LCASE(payMethod)="rtpay") then
    iPaymethod = "150"
end if

''response.write iPaymethod
if (iPaymethod="") then
    iPaymethod = request.Form("Tn_paymethod")
end if

vQuery = "UPDATE [db_order].[dbo].[tbl_order_temp] "
vQuery = vQuery & " SET P_STATUS = '"&CHKIIF((ResultCode = "0000"),"00","F02")&"' " & VbCRLF		'승인 실패
vQuery = vQuery & " , P_RMESG1 = convert(varchar(500),'" & replace(i_Resultmsg,"'","") & "') " & VbCRLF		'실패사유
vQuery = vQuery & " , Tn_paymethod = '"&iPaymethod&"'" & VbCRLF
vQuery = vQuery & " , P_AUTH_NO = '"&AuthCode&"'" & VbCRLF
vQuery = vQuery & " , P_TID = '"&Tid&"'" & VbCRLF
vQuery = vQuery & " , P_FN_CD1 = '"&CardCode&"'" & VbCRLF
vQuery = vQuery & " , P_CARD_ISSUER_CODE= '"&CardIssuerCode&"'" & VbCRLF
If iPaymethod = "150" then
    vQuery = vQuery & " , P_RMESG2 = '"&rentalPeriod&"|"&renntalPrice&"|"&rentalNo&"'" & VbCRLF ''이니렌탈일 경우 렌탈개월수|월납입금액|렌탈번호
Else
    vQuery = vQuery & " , P_RMESG2 = '"&CardQuota&"'" & VbCRLF ''할부개월수
End If
vQuery = vQuery & " , P_CARD_PRTC_CODE = '"&PrtcCode&"'" & VbCRLF
vQuery = vQuery & " WHERE temp_idx = '" & vIdx & "'"
dbget.execute vQuery

''''2011-04-27 추가(부분취소시 필요항목)
''IF (Tn_paymethod="20") Then
''    iorderParams.FPayEtcResult = LEFT(DirectBankCode,16)
''else
''    iorderParams.FPayEtcResult = LEFT(CardCode&"|"&CardIssuerCode&"|"&CardQuota&"|"&PrtcCode,16)
''END IF
''    iorderParams.FPayEtcResult = LEFT(vP_FN_CD1&"|"&vP_CARD_ISSUER_CODE&"|"&vP_RMESG2&"|"&vP_CARD_PRTC_CODE,16)



'' 3. 실 주문정보 저장 
Dim vResult, vIsSuccess
iErrStr = ""
Call oshoppingbag.SaveOrderResultDB_TmpBaguni(vIdx, iPaymethod, iErrStr, vResult, vIsSuccess)

if (iErrStr<>"") then
    response.write iErrStr
    Response.write "<script type='text/javascript'>alert('04. 주문 처리 과정중 오류가 발생하였습니다. 고객센터로 문의해 주세요.');</script>"
    response.write "<script>location.replace('"&SSLUrl&"/inipay/shoppingbag.asp');</script>"
	dbget.close()
    response.end
end if

''Call oshoppingbag.SaveOrderResultDB(iorderParams, iErrStr)


On Error resume Next
dim osms, helpmail
helpmail = oshoppingbag.GetHelpMailURL

    IF (vIsSuccess) THEN
        call sendmailorder(iorderserial,helpmail)

        set osms = new CSMSClass
		osms.SendJumunOkMsg ireserveParam.Fbuyhp, iorderserial
	    set osms = Nothing

    end if
on Error Goto 0

'' ================ 현금 영수증 신청 추가 =============================
'' 입금 확인시 또는 야간 배치 발행 :: 실시간 이체건도 배치로 발행 (이니시스 팝업창에서 발행 안함)
''On Error resume Next
dim cashreceiptreq, useopt, cashReceipt_ssn
dim cr_price, sup_price, tax, srvc_price, reg_num

cashreceiptreq     = ireserveParam.FCashreceiptreq
useopt             = ireserveParam.FCashreceiptuseopt
cashReceipt_ssn    = ireserveParam.FCashReceipt_ssn
reg_num = cashReceipt_ssn

cr_price    = CLng(ireserveParam.FPrice) + CLng(ireserveParam.Fspendtencash) + CLng(ireserveParam.Fspendgiftmoney)   '''예치금 사용내역 추가..
sup_price   = CLng(cr_price*10/11)
tax         = cr_price - sup_price
srvc_price  = 0

if (vIsSuccess) and (iPaymethod="20") and (cashreceiptreq="Y") then
    ''무조건 이니시스 현금영수증으로 변경
    sqlStr = " update [db_order].[dbo].tbl_order_master"
    sqlStr = sqlStr + " set cashreceiptreq='R'"
    sqlStr = sqlStr + " where orderserial='" + iorderserial + "'"

    dbget.Execute sqlStr

    sqlStr = " insert into [db_log].[dbo].tbl_cash_receipt"
    sqlStr = sqlStr + " (orderserial,userid,sitename,goodname, cr_price, sup_price, tax, srvc_price"
    sqlStr = sqlStr + " ,buyername, buyeremail, buyertel, reg_num, useopt, cancelyn, resultcode)"
    sqlStr = sqlStr + " values("
    sqlStr = sqlStr + " '" & iorderserial & "'"
    sqlStr = sqlStr + " ,'" & userid & "'"
    sqlStr = sqlStr + " ,'" & sitename & "'"
    sqlStr = sqlStr + " ,'" & html2db(ireserveParam.Fgoodname) & "'"
    sqlStr = sqlStr + " ," & CStr(cr_price) & ""
    sqlStr = sqlStr + " ," & CStr(sup_price) & ""
    sqlStr = sqlStr + " ," & CStr(tax) & ""
    sqlStr = sqlStr + " ," & CStr(srvc_price) & ""
    sqlStr = sqlStr + " ,'" & ireserveParam.FBuyname & "'"
    sqlStr = sqlStr + " ,'" & ireserveParam.Fbuyemail & "'"
    sqlStr = sqlStr + " ,'" & ireserveParam.Fbuyhp & "'"
    sqlStr = sqlStr + " ,'" & reg_num & "'"
    sqlStr = sqlStr + " ,'" & useopt & "'"
    sqlStr = sqlStr + " ,'N'"
    sqlStr = sqlStr + " ,'R'"
    sqlStr = sqlStr + " )"

    dbget.Execute sqlStr
end IF
on Error Goto 0
'' ================ 현금 영수증 신청 추가  끝 =============================

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

set ireserveParam = Nothing
set oshoppingbag = Nothing

'' 주문 결과 페이지로 이동
''SSL 경우 스크립트로 replace
''response.write "<script language='javascript'>location.replace('" & wwwUrl & "/inipay/displayorder.asp?dumi="&dumi&"');</script>"
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
<script language="javascript">
    setTimeout(function(){
        try{
            window.location.replace("<%=wwwUrl%>/inipay/displayorder.asp?dumi=<%=dumi%>");
        }catch(ss){
            location.href="/inipay/displayorder.asp?dumi=<%=dumi%>";
        }
    },200);
</script>
