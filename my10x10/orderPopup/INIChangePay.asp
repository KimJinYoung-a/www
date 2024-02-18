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
<%

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


''pay INI
'###############################################################################
dim INIpay, PInst
dim Tid, ResultCode, ResultMsg, PayMethod
dim Price1, Price2, AuthCode, CardQuota, QuotaInterest
dim CardCode, AuthCertain, PGAuthDate, PGAuthTime, OCBSaveAuthCode, OCBUseAuthCode, OCBAuthDate, CardIssuerCode, PrtcCode
dim AckResult
dim DirectBankCode, Rcash_rslt, ResultCashNoAppl

'###############################################################################
'# 1. 객체 생성 #
'################
Set INIpay = Server.CreateObject("INItx41.INItx41.1")

'###############################################################################
'# 2. 인스턴스 초기화 #
'######################
PInst = INIpay.Initialize("")

'###############################################################################
'# 3. 거래 유형 설정 #
'#####################
INIpay.SetActionType CLng(PInst), "SECUREPAY"

'###############################################################################
'# 4. 정보 설정 #
'################
INIpay.SetField CLng(PInst), "pgid", "IniTechPG_" 'PG ID (고정)
INIpay.SetField CLng(PInst), "spgip", "203.238.3.10" '예비 PG IP (고정)
INIpay.SetField CLng(PInst), "uid", Request("uid") 'INIpay User ID
INIpay.SetField CLng(PInst), "mid", Request("mid") '상점아이디
INIpay.SetField CLng(PInst), "admin", "1111" '키패스워드(상점아이디에 따라 변경)
INIpay.SetField CLng(PInst), "goodname", Request("goodname") '상품명
INIpay.SetField CLng(PInst), "currency", Request("currency") '화폐단위
INIpay.SetField CLng(PInst), "price", Request("price") '가격
INIpay.SetField CLng(PInst), "buyername", Request("buyername") '성명
INIpay.SetField CLng(PInst), "buyertel", Request("buyertel") '이동전화
INIpay.SetField CLng(PInst), "buyeremail", Request("buyeremail") '이메일
INIpay.SetField CLng(PInst), "paymethod", Request("paymethod") '지불방법
INIpay.SetField CLng(PInst), "encrypted", Request("encrypted") '암호문
INIpay.SetField CLng(PInst), "sessionkey", Request("sessionkey") '암호문
INIpay.SetField CLng(PInst), "url", "http://www.10x10.co.kr" '홈페이지 주소 (URL)
INIpay.SetField CLng(PInst), "uip", Request.ServerVariables("REMOTE_ADDR") 'IP
INIpay.SetField CLng(PInst), "debug", "false" '로그모드(실서비스시에는 "false"로)

'###############################################################################
'# 5. 지불 요청 #
'################
INIpay.StartAction(CLng(PInst))

'###############################################################################
'# 6. 지불 결과 #
'################
Tid             = INIpay.GetResult(CLng(PInst), "tid")          '거래번호
ResultCode      = INIpay.GetResult(CLng(PInst), "resultcode")   '결과코드 ("00"이면 지불성공)
ResultMsg       = INIpay.GetResult(CLng(PInst), "resultmsg")    '결과내용
PayMethod       = INIpay.GetResult(CLng(PInst), "paymethod")    '지불방법 (매뉴얼 참조)
Price1          = INIpay.GetResult(CLng(PInst), "price1")       'OK Cashbag 복합결재시 신용카드 지불금액
Price2          = INIpay.GetResult(CLng(PInst), "price2")       'OK Cashbag 복합결재시 포인트 지불금액
AuthCode        = INIpay.GetResult(CLng(PInst), "authcode")     '신용카드 승인번호
CardQuota       = INIpay.GetResult(CLng(PInst), "cardquota")    '할부기간
QuotaInterest   = Request("quotainterest")                      '무이자할부 여부("1"이면 무이자할부)
CardCode        = INIpay.GetResult(CLng(PInst), "cardcode")     '신용카드사 코드 (매뉴얼 참조))
AuthCertain     = INIpay.GetResult(CLng(PInst), "authcertain")  '본인인증 수행여부 ("00"이면 수행)
PGAuthDate      = INIpay.GetResult(CLng(PInst), "pgauthdate")   '이니시스 승인날짜
PGAuthTime      = INIpay.GetResult(CLng(PInst), "pgauthtime")   '이니시스 승인시각
OCBSaveAuthCode = INIpay.GetResult(CLng(PInst), "ocbsaveauthcode")  'OK Cashbag 적립 승인번호
OCBUseAuthCode  = INIpay.GetResult(CLng(PInst), "ocbuseauthcode")   'OK Cashbag 사용 승인번호
OCBAuthDate     = INIpay.GetResult(CLng(PInst), "ocbauthdate")      'OK Cashbag 승인일시

DirectBankCode  = INIpay.GetResult(CLng(PInst), "directbankcode") '은행코드
Rcash_rslt      = INIpay.GetResult(CLng(PInst), "rcash_rslt") '현금영주증 결과코드 ("0000"이면 지불성공)
ResultCashNoAppl = INIpay.GetResult(CLng(PInst), "Rcash_noappl") '승인번호

CardIssuerCode  = INIpay.GetResult(CLng(PInst), "CardIssuerCode") '카드 발급사코드 (부분취소시 필요)
PrtcCode        = INIpay.GetResult(CLng(PInst), "PrtcCode")       '부분취소 가능여부('0':불가, '1':가능)

''실시간 이체 현금영수증 관련
if (acctdiv="20") and (Rcash_rslt="0000") then
    AuthCode = ResultCashNoAppl
end if

''''OKCashBag 관련
''if (Tn_paymethod="110") then
''    iorderParams.FOKCashbagSpend = 0
''
''    if IsNumeric(Price2) then
''        if (Price2<>0) then
''            iorderParams.FOKCashbagSpend = Price2
''            iorderParams.FOKCashbagUseAuthCode = OCBUseAuthCode
''            iorderParams.FOKCashbagAuthDate = OCBAuthDate
''        end if
''    end if
''    'response.write "Price1="&Price1              'OK Cashbag 복합결재시 신용카드 지불금액
''    'response.write "Price2="&Price2              'OK Cashbag 복합결재시 포인트 지불금액
''    'response.write "OCBSaveAuthCode="&OCBSaveAuthCode     'OK Cashbag 적립 승인번호
''    'response.write "OCBUseAuthCode="&OCBUseAuthCode      'OK Cashbag 사용 승인번호
''    'response.write "OCBAuthDate="&OCBAuthDate         'OK Cashbag 승인일시
''end if


'response.write "Rcash_rslt=" & Rcash_rslt & "<br>"
'response.write "ResultCashNoAppl=" & ResultCashNoAppl & "<br>"


'###############################################################################
'# 7. 결과 수신 확인 #
'#####################
'지불결과를 잘 수신하였음을 이니시스에 통보.
'[주의] 이 과정이 누락되면 모든 거래가 자동취소됩니다.
IF ResultCode = "00" THEN
	AckResult = INIpay.Ack(CLng(PInst))
	IF AckResult <> "SUCCESS" THEN '(실패)
		'=================================================================
		' 정상수신 통보 실패인 경우 이 승인은 이니시스에서 자동 취소되므로
		' 지불결과를 다시 받아옵니다(성공 -> 실패).
		'=================================================================
		ResultCode = INIpay.GetResult(CLng(PInst), "resultcode")
		ResultMsg = INIpay.GetResult(CLng(PInst), "resultmsg")
	END IF
END IF


'###############################################################################
'# 8. 인스턴스 해제 #
'####################
INIpay.Destroy CLng(PInst)


'###############################################################################
'# 9. 지불결과 DB 연동 #
'#######################


dim i_Resultmsg, Fresultmsg, Fauthcode, Fpaygatetid, FIsSuccess, iErrStr, FPayEtcResult
i_Resultmsg = replace(ResultMsg,"|","_")

Fresultmsg  = i_Resultmsg
Fauthcode = AuthCode
Fpaygatetid = Tid
FIsSuccess = (ResultCode = "00")

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

Set INIpay = Nothing

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
