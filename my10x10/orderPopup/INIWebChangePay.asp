<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #INCLUDE Virtual="/lib/email/maillib2.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/cscenter/lib/csAsfunction.asp" -->
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

dim userid, orderserial, acctdiv
dim subtotalprice

userid = getEncLoginUserID()
orderserial  = requestCheckvar(request.Form("orderserial"),11)
acctdiv      = requestCheckvar(request.Form("acctdiv"),10)
subtotalprice   = request.Form("price")

dim myorder
set myorder = new CMyOrder

if IsUserLoginOK() then
    myorder.FRectUserID = GetLoginUserID()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
elseif IsGuestLoginOK() then
    orderserial = GetGuestLoginOrderserial()
    myorder.FRectOrderserial = orderserial
    myorder.GetOneOrder
end if



IF (myorder.FOneItem.FCancelYn<>"N") or  (myorder.FOneItem.FIpkumdiv<>"2") or (Trim(myorder.FOneItem.FAccountDiv)<>"7") then
    response.write "<script>alert('결제 변경 불가(무통장 접수 건만 결제 가능) 합니다.')</script>"
	response.write "<script>history.back()</script>"
	response.end
end if


IF (CLNG(subtotalprice)<>CLNG(myorder.FOneItem.TotalMajorPaymentPrice)) then ''FSubTotalPrice
    response.write "<script>alert('장바구니 금액 오류 ')</script>"
	response.write "<script>history.back()</script>"
	response.end
end if

IF (acctdiv="") or (acctdiv<>"100") then
    response.write "<script>alert('필수 파라메터 오류')</script>"
	response.write "<script>history.back()</script>"
	response.end
end if


set myorder = Nothing


Dim sqlStr, iid


''Pre Save Log.
'###############################################################################
sqlStr = "select * from db_order.dbo.tbl_order_Change_Payment where 1=0"
	rsget.Open sqlStr,dbget,1,3
	rsget.AddNew
	    rsget("orderserial")    = orderserial
	    rsget("userid")     = userid
	    rsget("chgAcctDiv") = acctdiv
	    rsget("subtotalPrice") = subtotalprice
	    rsget("refIp") = Left(request.ServerVariables("REMOTE_ADDR"),32)

	    rsget.update
		iid = rsget("idx")
	rsget.close


dim k
dim imid : imid = request.form("mid")    ''변수 주의! 

dim authUrl : authUrl = URLDecode(request.form("authUrl"))              ''인코딩해서 넘어왔음.
dim authToken : authToken = URLDecode(request.form("authToken"))        ''인코딩해서 넘어왔음.
dim icharset : icharset = "UTF-8" 
dim iformat : iformat = "JSON"    
dim price : price=subtotalprice

'' 승인 통신
dim timestamp : timestamp = getIniWebTimestamp()
dim signature : signature = (getIniWebConfirmSignature(authToken,timestamp))
                
dim xmlHttp, postdata, strData, postdata2, strData2

Set xmlHttp = CreateObject("Msxml2.ServerXMLHTTP.3.0")
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
payMethod = oJSON.data("payMethod")                 ''Card:신용카드, DirectBank:실시간계좌이체, OCBPoint:OKCashbag 포인트, HPP:핸드폰, VBank:무통장입금(가상계좌)
payDevice = oJSON.data("payDevice")                 ''PC,ETC
CardCode   = oJSON.data("CARD_Code")                 ''CARD_Code
PrtcCode   = oJSON.data("CARD_PRTC_CODE")           ''부분취소 가능여부?
CardIssuerCode   = oJSON.data("CARD_BankCode")      '' 카드 발급사 코드
applDate   = oJSON.data("applDate")                 ''
applTime   = oJSON.data("applTime")                 ''
goodsName   = oJSON.data("goodsName")                 ''

DirectBankCode = oJSON.data("ACCT_BankCode")         ''은행코드
Set oJSON = Nothing

if (goodsName="") then goodsName="10x10item"


'###############################################################################
'# 9. 지불결과 DB 연동 #
'#######################

dim i_Resultmsg, Fresultmsg, Fauthcode, Fpaygatetid, FIsSuccess, iErrStr, FPayEtcResult
i_Resultmsg = replace(ResultMsg,"|","_")

Fresultmsg  = i_Resultmsg
Fauthcode = AuthCode
Fpaygatetid = Tid
FIsSuccess = (ResultCode = "0000")

''2011-04-27 추가(부분취소시 필요항목)
IF (acctdiv="20") Then
    FPayEtcResult = LEFT(DirectBankCode,16)
ELSe
    FPayEtcResult = LEFT(CardCode&"|"&CardIssuerCode&"|"&CardQuota&"|"&PrtcCode,16)
END IF

''Save Result Order
dbget.BeginTrans
On Error Resume Next

sqlStr = " update db_order.dbo.tbl_order_Change_Payment"
sqlStr = sqlStr & " set paygatetid='"&Tid&"'"
sqlStr = sqlStr & " ,resultMsg='"&Fresultmsg&"'"
sqlStr = sqlStr & " ,resultDate=getdate()"
IF (FIsSuccess) then
    sqlStr = sqlStr & " ,payyn='Y'"
else
    sqlStr = sqlStr & " ,payyn='N'"
end if
sqlStr = sqlStr & " where idx="&iid
dbget.Execute sqlStr

IF (Err) then
    iErrStr = "[ERR.001]"&Err.Description
    dbget.RollBackTrans
	On Error Goto 0
end if

IF (FIsSuccess) and (Not Err) THEN
    sqlStr = " update [db_order].[dbo].tbl_order_master" + vbCrlf
    sqlStr = sqlStr & " SET ipkumdiv='4'" + vbCrlf
    sqlStr = sqlStr & " ,ipkumdate=getdate()" + vbCrlf
    sqlStr = sqlStr & " ,accountdiv='"&acctdiv&"'" + vbCrlf
    sqlStr = sqlStr & " ,paygatetid='"&Tid&"'" + vbCrlf
    sqlStr = sqlStr + " ,resultmsg=convert(varchar(100),'" + Fresultmsg + "')" + vbCrlf
    sqlStr = sqlStr + " ,authcode=convert(varchar(64),'" + Fauthcode + "')" + vbCrlf
    sqlStr = sqlStr & " where orderserial='"&orderserial&"'"
    dbget.Execute sqlStr

    IF (Err) then
        iErrStr = "[ERR.002]"&Err.Description
        dbget.RollBackTrans
	    On Error Goto 0
    end if

    If (Not Err) then
        sqlStr = " update db_order.dbo.tbl_order_PaymentEtc" + vbCrlf
        sqlStr = sqlStr & " SET acctdiv='"&acctdiv&"'" + vbCrlf
        sqlStr = sqlStr & " ,acctAuthCode='"&Fauthcode&"'" + vbCrlf
        sqlStr = sqlStr & " ,PayEtcResult='"&FPayEtcResult&"'" + vbCrlf
        sqlStr = sqlStr & " where orderserial='"&orderserial&"'"
        sqlStr = sqlStr & " and acctdiv='7'"                                ''무통장.
        dbget.Execute sqlStr

        IF (Err) then
            iErrStr = "[ERR.003]"&Err.Description
            dbget.RollBackTrans
    	    On Error Goto 0
        end if
    end if


    If (Not Err) then
        if (userid<>"") then
            sqlStr = " exec db_order.dbo.sp_Ten_recalcuHesJumunmileage '"&userid&"'"
            dbget.Execute sqlStr
        end if

        IF (Err) then
            iErrStr = "[ERR.004]"&Err.Description
            dbget.RollBackTrans
    	    On Error Goto 0
        end if


        sqlStr = " update R"
        sqlStr = sqlStr & " set cancelyn='D'"
        sqlStr = sqlStr & " from db_log. dbo.tbl_cash_receipt R"
        sqlStr = sqlStr & "      Join db_order. dbo.tbl_order_master M"
        sqlStr = sqlStr & "      on R.orderserial=M.orderserial"
        sqlStr = sqlStr & " where R.cancelyn='N'"
        sqlStr = sqlStr & " and R.resultCode='R'"
        sqlStr = sqlStr & " and M.cancelyn='N'"
        sqlStr = sqlStr & " and M.ipkumdiv>3"
        sqlStr = sqlStr & " and M.accountdiv='100'"
        sqlStr = sqlStr & " and M.orderserial='"&orderserial&"'"

        dbget.Execute sqlStr
	end if


END IF

IF Not (Err) then
    dbget.CommitTrans
    On Error Goto 0
End IF

if (iErrStr<>"") then
    'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','주문오류(CHG) :" + iorderserial +":"+ replace(iErrStr,"'","") + "'"
	'dbget.Execute sqlStr

    response.write iErrStr
    response.write "<script language='javascript'>alert('작업중 오류가 발생하였습니다. 고객센터로 문의해 주세요.: \n\n: 오류 -" & replace(iErrStr,"'","") & "');</script>"
    response.end
end if

dim osms, buyeremail, buyertel, iAsID
dim reguserid, divcd, title, gubun01, gubun02, contents_jupsu, contents_finish, finishuser
IF (FIsSuccess) then
    On Error Resume Next

    buyeremail = Request("buyeremail")
    buyertel = Request("buyertel")
    ''call sendmailorder(iorderserial,buyeremail)   '''이메일은 나중에.

    ''SMS =====================================================================================
    set osms = new CSMSClass
	osms.SendJumunOkMsg buyertel, orderserial
    set osms = Nothing

    ''재고수량 업데이트========================================================================
	sqlStr = " exec [db_summary].[dbo].sp_ten_RealtimeStock_regAccChange '"&orderserial&"'"

	''CS 처리 내역 입력.========================================================================
	reguserid   = userid
    divcd       = "A900"
    title       = "[고객변경]결제수단 변경"
    gubun01     = "C004"
    gubun02     = "CD99"

    contents_jupsu  = "결제수단 변경 무통장->신용카드"
    contents_finish = contents_jupsu
    finishuser      = "system"

	iAsID = RegCSMaster(divcd , orderserial, reguserid, title, contents_jupsu, gubun01, gubun02)
    Call FinishCSMaster(iAsid, finishuser, html2db(contents_finish))

    sqlStr = "update [db_cs].[dbo].tbl_new_as_list"
    sqlStr = sqlStr & " set opentitle='결제수단 변경 무통장->신용카드'"
    sqlStr = sqlStr & " where id=" + CStr(iAsid)
    dbget.Execute sqlStr

	On Error Goto 0
end if

	if (Err) then
	    '''자동 취소 사용 안함.
    	'DB를 운영하는 경우 지불결과에 따라 이곳에 데이터베이스 연동 코드 등을 추가.
		'DB 입력에 실패하면 다음의 취소 코드를 수행하여 DB에 없는 거래가 발생하는 것을
		'막아주십시오.
		'CancelInst = INIpay.Initialize("")
		'INIpay.SetActionType CLng(CancelInst), "CANCEL"
		'INIpay.SetField CLng(CancelInst), "pgid", "IniTechPG_" 'PG ID (고정)
		'INIpay.SetField CLng(CancelInst), "spgip", "203.238.3.10" '예비 PG IP (고정)
		'INIpay.SetField CLng(CancelInst), "admin", "5946" '키패스워드(상점아이디에 따라 변경)
		'INIpay.SetField CLng(CancelInst), "debug", "false" '로그모드(실서비스시에는 "false"로)
		'INIpay.SetField CLng(CancelInst), "mid", Request("mid")
		'INIpay.SetField CLng(CancelInst), "tid", Tid
		'INIpay.SetField CLng(CancelInst), "uip", Request.ServerVariables("REMOTE_ADDR") 'IP
		'INIpay.SetField CLng(CancelInst), "msg", "DB FAIL"
		'INIpay.StartAction(CLng(CancelInst))
		'CancelResultCode = INIpay.GetResult(CLng(CancelInst), "resultcode")
		'CancelResultMsg = INIpay.GetResult(CLng(CancelInst), "resultmsg")
		'INIpay.Destroy CLng(CancelInst)
		'IF CancelResultCode = "00" THEN '취소성공이면 지불결과 변경
		'		ResultCode = "01"
		'		ResultMsg = "DB FAIL"
		'END IF
    	''승인후 자동취소
    	'dim sqlstr
    	'sqlstr = "update [db_order].[10x10].tbl_order_master" + VbCrlf
    	'sqlstr = sqlstr + " set cancelyn='Y'" + VbCrlf
    	'sqlstr = sqlstr + " , ipkumdiv='0'" + VbCrlf
    	'sqlstr = sqlstr + " , comment=comment + ' " + errmsg + "'" + VbCrlf
    	'sqlstr = sqlstr + " where orderserial='" + iorderserial + "'" + VbCrlf
    	'rsget.Open sqlStr,dbget,1

        iErrStr = replace(err.Description,"'","")

    	response.write "<script>javascript:alert('작업중 오류가 발생하였습니다. 고객센터로 문의해 주세요.: \n\n" & iErrStr & "')</script>"
    	response.write "<script>javascript:history.back();</script>"
		response.end
	end if

%>
<% IF (FIsSuccess) then %>
<script language='javascript'>
alert('결제 완료 되었습니다.');
opener.location.href='/my10x10/order/myorderdetail.asp?idx=<%=orderserial %>';
window.close();
</script>
<% else %>
<script language='javascript'>
alert('주문이 실패 하였습니다.\n\n<%= replace(Fresultmsg,"'","") %>')
location.replace('<%= wwwUrl%>/my10x10/orderPopup/dpResult.asp?iid=<%=iid%>');
</script>
<% end if %>

<!-- #include virtual="/lib/db/dbclose.asp" -->
