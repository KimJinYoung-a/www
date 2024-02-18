<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<% Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>

<!-- include virtual="/lib/checkUserGuestlogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/cashreceiptcls.asp" -->
<%

function OneReceiptCancel(orgtid,cancelCause, iResultCode, iResultMsg, iAuthCode)
    dim INIpay, PInst
    dim ResultCode,ResultMsg, CancelDate, CancelTime, Rcash_cancel_noappl

    '###############################################################################
    '# 1. 객체 생성 #
    '################

    ''Set INIpay = Server.CreateObject("INIreceipt41.INIreceiptTX41.1")
    Set INIpay = Server.CreateObject("INItx41.INItx41.1")

    '###############################################################################
    '# 2. 인스턴스 초기화 #
    '######################
    PInst = INIpay.Initialize("")

    '###############################################################################
    '# 3. 거래 유형 설정 #
    '#####################
    INIpay.SetActionType CLng(PInst), "CANCEL"

    '###############################################################################
    '# 4. 정보 설정 #
    '################
    INIpay.SetField CLng(PInst), "pgid", "IniTechPG_" 'PG ID (고정)
    INIpay.SetField CLng(PInst), "spgip", "203.238.3.10" '예비 PG IP (고정)

    if (application("Svr_Info")	= "Dev") then
    	INIpay.SetField CLng(PInst), "mid", "INIpayTest" '상점아이디
    else
    	INIpay.SetField CLng(PInst), "mid", "teenxteen4" '상점아이디
	end if

    INIpay.SetField CLng(PInst), "admin", "1111" '키패스워드(상점아이디에 따라 변경)
    INIpay.SetField CLng(PInst), "tid", orgtid '취소할 거래번호(TID)
    INIpay.SetField CLng(PInst), "msg", cancelCause '취소 사유
    INIpay.SetField CLng(PInst), "uip", Request.ServerVariables("REMOTE_ADDR") 'IP
    INIpay.SetField CLng(PInst), "debug", "false" '로그모드("true"로 설정하면 상세한 로그를 남김)
    INIpay.SetField CLng(PInst), "merchantreserved", "예비" '예비

    '###############################################################################
    '# 5. 취소 요청 #
    '################
    INIpay.StartAction(CLng(PInst))

    '###############################################################################
    '# 6. 취소 결과 #
    '################
    ResultCode = INIpay.GetResult(CLng(PInst), "resultcode") '결과코드 ("00"이면 취소성공)
    ResultMsg = INIpay.GetResult(CLng(PInst), "resultmsg") '결과내용
    CancelDate = INIpay.GetResult(CLng(PInst), "pgcanceldate") '이니시스 취소날짜
    CancelTime = INIpay.GetResult(CLng(PInst), "pgcanceltime") '이니시스 취소시각
    Rcash_cancel_noappl = INIpay.GetResult(CLng(PInst), "rcash_cancel_noappl") '현금영수증 취소 승인번호

    '###############################################################################
    '# 7. 인스턴스 해제 #
    '####################
    INIpay.Destroy CLng(PInst)


    iResultCode = ResultCode
    iResultMsg  = ResultMsg
    iAuthCode   = Rcash_cancel_noappl  '' Not AuthCode

    OneReceiptCancel = (iResultCode="00")
end function

dim sqlStr, assignedRow
Dim cType : cType = requestCheckvar(request("cType"),10)
Dim orderserial : orderserial = requestCheckvar(request.Form("orderserial"),11)
Dim receiptreqidx : receiptreqidx = requestCheckvar(request.Form("receiptreqidx"),10)

''2016/08/10 추가
if (orderserial="") then
    dbget.Close(): response.end    
end if

IF (cType="R") or (cType="S") or (cType="T") then
    ''R - 요청내역 취소  // S 발급내역 취소    //T 계산서 발행 요청내역 취소
    IF (cType="T") then
         sqlStr = " update db_order.[dbo].tbl_taxSheet"& VbCrlf
         sqlStr = sqlStr & " set delYn='Y'"& VbCrlf
         sqlStr = sqlStr & " where taXidx="&receiptreqidx& VbCrlf
         sqlStr = sqlStr & " and orderserial='" & orderserial & "'" & VbCrlf
         sqlStr = sqlStr & " and isueYn='N'" & VbCrlf

         dbget.Execute sqlStr,assignedRow

        if (assignedRow>0) then
            sqlStr = " update [db_order].[dbo].tbl_order_master" & VbCrlf
            sqlStr = sqlStr & " set cashreceiptReq=NULL" & VbCrlf
            sqlStr = sqlStr & " where orderserial='" & orderserial & "'" & VbCrlf

            dbget.Execute sqlStr,assignedRow

            if (assignedRow>0) then
                response.write "<script>alert('발행 요청이 취소되었습니다.');opener.location.reload();window.close();</script>"
                dbget.Close() : response.end
            end if
        end if

        response.write "<script>alert('취소 요청중 오류가 발생 하였습니다..');history.back();</script>"
    elseIF (cType="R") then
        sqlStr = " update [db_log].[dbo].tbl_cash_receipt"& VbCrlf
        sqlStr = sqlStr & " set cancelyn='D'"& VbCrlf
        sqlStr = sqlStr & " where idx="&receiptreqidx& VbCrlf
        sqlStr = sqlStr & " and orderserial='" & orderserial & "'" & VbCrlf
        sqlStr = sqlStr & " and resultcode='R'" & VbCrlf
        sqlStr = sqlStr & " and tid is NULL" & VbCrlf

        dbget.Execute sqlStr,assignedRow

        if (assignedRow>0) then
            sqlStr = " update [db_order].[dbo].tbl_order_master" & VbCrlf
            sqlStr = sqlStr & " set cashreceiptReq=NULL" & VbCrlf
            sqlStr = sqlStr & " where orderserial='" & orderserial & "'" & VbCrlf

            dbget.Execute sqlStr,assignedRow

            if (assignedRow>0) then
                response.write "<script>alert('발행 요청이 취소되었습니다.');opener.location.reload();window.close();</script>"
                dbget.Close() : response.end
            end if
        end if

        response.write "<script>alert('취소 요청중 오류가 발생 하였습니다..');history.back();</script>"
        dbget.Close() : response.end
    elseiF (cType="S") then
        dim bufidx, buforderserial, bufresultcode, bufcancelyn, orgtid
        sqlStr = " select idx, orderserial, resultcode, cancelyn, tid from [db_log].[dbo].tbl_cash_receipt"
        sqlStr = sqlStr + " where idx=" & receiptreqidx

        rsget.Open sqlStr,dbget,1
        if Not rsget.Eof then
            bufidx         = rsget("idx")
            buforderserial = rsget("orderserial")
            bufresultcode  = rsget("resultcode")
            bufcancelyn    = rsget("cancelyn")
            orgtid    = rsget("tid")
        end if
        rsget.close

        if (CStr(bufidx)<>CStr(receiptreqidx)) or (CStr(buforderserial)<>CStr(orderserial)) then
            response.write "<script>alert('취소 요청중 오류가 발생 하였습니다."&buforderserial&","&orderserial&"');history.back();</script>"
            dbget.Close() : response.end
        end if

        if (bufcancelyn="Y") then
            response.write "<script>alert('기 취소된 현금영수증입니다.');history.back();</script>"
            dbget.Close() : response.end
        end if

        Dim icancelCause : icancelCause ="고객요청"
        Dim iResultCode, iResultMsg, iAuthCode, infoMsg
        if (Not OneReceiptCancel(orgtid,icancelCause, iResultCode, iResultMsg, iAuthCode)) then
            infoMsg = infoMsg & " 취소 실패 :" & "[" & iResultCode & "]" & iResultMsg & ""

            response.write "<script>alert('"+infoMsg+"');history.back();</script>"
            dbget.Close() : response.end
        else
            infoMsg = infoMsg & "현금영수증 취소 성공 "

            sqlStr = " update [db_log].[dbo].tbl_cash_receipt" & VbCrlf
            sqlStr = sqlStr & " set canceltid='" & iAuthCode & "'" & VbCrlf
            sqlStr = sqlStr & " ,cancelyn='Y'" & VbCrlf
            sqlStr = sqlStr & " where idx=" & receiptreqidx & ""

            dbget.Execute sqlStr

            sqlStr = " update db_order.dbo.tbl_order_master" & VbCrlf
            sqlStr = sqlStr & " set cashreceiptreq=NULL" & VbCrlf
            sqlStr = sqlStr & " ,authcode = (case when accountdiv in ('7', '20') then NULL else authcode end) " & VbCrlf
            sqlStr = sqlStr & " where orderserial='"&orderserial&"'"

            dbget.Execute sqlStr

            response.write "<script>alert('"+infoMsg+"');opener.location.reload();window.close();</script>"
            dbget.Close() : response.end
        end if
    end if

    dbget.Close() : response.end
end if


dim INIpay, PInst, Tid
dim ResultCode, ResultMsg, AuthCode
dim PGAuthDate, PGAuthTime
dim ResultpCRPice, ResultSupplyPrice, ResultTax
dim ResultServicePrice, ResultUseOpt, ResultCashNoAppl
dim AckResult


dim goodname, cr_price, sup_price, tax, srvc_price, buyername
dim buyeremail, buyertel, reg_num, useopt,  userid, sitename, paymethod


dim iidx

goodname    = requestCheckvar(html2db(request.Form("goodname")),100)
cr_price    = requestCheckvar(request.Form("cr_price"),12)
sup_price   = requestCheckvar(request.Form("sup_price"),12)
tax         = requestCheckvar(request.Form("tax"),12)
srvc_price  = requestCheckvar(request.Form("srvc_price"),12)
buyername   = requestCheckvar(html2db(request.Form("buyername")),100)
buyeremail  = requestCheckvar(html2db(request.Form("buyeremail")),100)
buyertel    = requestCheckvar(request.Form("buyertel"),32)
reg_num     = requestCheckvar(request.Form("reg_num"),40)
useopt      = requestCheckvar(request.Form("useopt"),10)
userid      = getLoginUserid ''request.Form("userid")
sitename    = requestCheckvar(request.Form("sitename"),32)
paymethod   = requestCheckvar(request.Form("paymethod"),10)

'' 발행 검증 필요.
'' 기발 행 check
dim preEvalExists : preEvalExists=false
sqlStr = "select idx from [db_log].[dbo].tbl_cash_receipt "&VbCRLF
sqlStr = sqlStr & " where orderserial='"&orderserial&"'"&VbCRLF
sqlStr = sqlStr & " and cancelyn='N' and resultcode='00'"&VbCRLF
rsget.CursorLocation = adUseClient
rsget.Open sqlStr,dbget,adOpenForwardOnly, adLockReadOnly
if  not rsget.EOF  then
    preEvalExists = true
end if
rsget.close

if (preEvalExists) then
    response.write "<script>alert('기발행 현금영수증 또는 발행 오류입니다.');</script>"
    dbget.Close() : response.end
end if

on Error resume next
sqlStr = " select * from [db_log].[dbo].tbl_cash_receipt where 1=0"
rsget.Open sqlStr,dbget,1,3
rsget.AddNew
rsget("orderserial") = orderserial
rsget("userid") = userid
rsget("sitename") = sitename
rsget("goodname") = goodname
rsget("cr_price") = cr_price
rsget("sup_price") = sup_price
rsget("tax") = tax
rsget("srvc_price") = srvc_price
rsget("buyername") = buyername
rsget("buyeremail") = buyeremail
rsget("buyertel") = buyertel
rsget("reg_num") = reg_num
rsget("useopt") = useopt
rsget("paymethod") = paymethod
rsget("cancelyn") = "N"


rsget.update
iidx = rsget("idx")
rsget.close

if Err then
	response.write "<script>alert('Error - " + Err.description + "');</script>"
	response.write "<script>history.back();</script>"
	response.end
end if

on error goto 0

%>

<%
'*******************************************************************************
'* INIreceipt.asp
'* 현금결제(실시간 은행계좌이체, 무통장입금)에 대한 현금결제 영수증 발행 요청한다.
'*
'* Date : 2004/12
'* Project : INIpay V4.11 for Unix
'*
'* http://www.inicis.com
'* http://support.inicis.com
'* Copyright (C) 2002 Inicis, Co. All rights reserved.
'*******************************************************************************

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
INIpay.SetActionType CLng(PInst), "receipt"

'###############################################################################
'# 4. 발급 정보 설정 #
'###############################################################################
INIpay.SetField CLng(PInst), "pgid","INIpayRECP"	'PG ID (고정)
INIpay.SetField CLng(PInst), "paymethod","CASH"		'지불방법
INIpay.SetField CLng(PInst), "spgip", "203.238.3.10" '예비 PG IP (고정)
INIpay.SetField CLng(PInst), "currency", Request("currency") '화폐단위
INIpay.SetField CLng(PInst), "admin", "1111"
INIpay.SetField CLng(PInst), "mid", Request("mid") '상점아이디
INIpay.SetField CLng(PInst), "uip", Request.ServerVariables("REMOTE_ADDR") '고객IP
INIpay.SetField CLng(PInst), "goodname", Request("goodname") '상품명
INIpay.SetField CLng(PInst), "cr_price", Request("cr_price") '총 현금 결제 금액
INIpay.SetField CLng(PInst), "sup_price", Request("sup_price") '공급가액
INIpay.SetField CLng(PInst), "tax", Request("tax") '부가세
INIpay.SetField CLng(PInst), "srvc_price", Request("srvc_price") '봉사료
INIpay.SetField CLng(PInst), "buyername", Request("buyername") '성명
INIpay.SetField CLng(PInst), "buyertel", Request("buyertel") '이동전화
INIpay.SetField CLng(PInst), "buyeremail", Request("buyeremail") '이메일
INIpay.SetField CLng(PInst), "reg_num", Request("reg_num") '현금결제자 주민등록번호
INIpay.SetField CLng(PInst), "useopt", Request("useopt") '현금영수증 발행용도 ("0" - 소비자 소득공제용, "1" - 사업자 지출증빙용)
INIpay.SetField CLng(PInst), "debug", "false" '로그모드("true"로 설정하면 상세한 로그를 남김)

'###############################################################################
'# 5. 지불 요청 #
'################
INIpay.StartAction(CLng(PInst))

'###############################################################################
'6. 발급 결과 #
'###############################################################################
'-------------------------------------------------------------------------------
' 가.모든 결제 수단에 공통되는 결제 결과 내용
'-------------------------------------------------------------------------------
Tid = INIpay.GetResult(CLng(PInst), "tid") '거래번호
ResultCode = INIpay.GetResult(CLng(PInst), "resultcode") '결과코드 ("00"이면 지불성공)
ResultMsg = INIpay.GetResult(CLng(PInst), "resultmsg") '결과내용
AuthCode = INIpay.GetResult(CLng(PInst), "authcode") '현금영수증 발생 승인번호
PGAuthDate = INIpay.GetResult(CLng(PInst), "pgauthdate") '이니시스 승인날짜
PGAuthTime = INIpay.GetResult(CLng(PInst), "pgauthtime") '이니시스 승인시각

ResultpCRPice = INIpay.GetResult(CLng(PInst), "ResultpCRPice") '결제 되는 금액
ResultSupplyPrice = INIpay.GetResult(CLng(PInst), "ResultSupplyPrice") '공급가액
ResultTax = INIpay.GetResult(CLng(PInst), "ResultTax") '부가세
ResultServicePrice = INIpay.GetResult(CLng(PInst), "ResultServicePrice") '봉사료
ResultUseOpt = INIpay.GetResult(CLng(PInst), "ResultUseOpt") '발행구분
ResultCashNoAppl = INIpay.GetResult(CLng(PInst), "ResultCashNoAppl") '승인번호

''결과 저장
AuthCode = ResultCashNoAppl   ''이것이 승인번호;;


''결과 저장
sqlStr = "update [db_log].[dbo].tbl_cash_receipt" + VbCrlf
sqlStr = sqlStr + " set tid='" + CStr(Tid) + "'" + VbCrlf
sqlStr = sqlStr + " , resultcode='" + CStr(ResultCode) + "'" + VbCrlf
sqlStr = sqlStr + " , resultmsg='" + html2db(LeftB(CStr(ResultMsg),200)) + "'" + VbCrlf
sqlStr = sqlStr + " , authcode='" + CStr(AuthCode) + "'" + VbCrlf
sqlStr = sqlStr + " , resultcashnoappl='" + CStr(ResultCashNoAppl) + "'" + VbCrlf
sqlStr = sqlStr + " where idx=" + CStr(iidx)

'response.write sqlStr
dbget.Execute sqlStr

''2016/08/09 추가. 승인일
sqlStr = "update [db_log].[dbo].tbl_cash_receipt" + VbCrlf
sqlStr = sqlStr + " SET evalDt='"&LEFT(PGAuthDate,4)&"-"&MID(PGAuthDate,5,2)&"-"&MID(PGAuthDate,7,2)&" "&LEFT(PGAuthTime,2)&":"&MID(PGAuthTime,3,2)&":"&MID(PGAuthTime,5,2)&"'" + VbCrlf
sqlStr = sqlStr + " where idx=" + CStr(iidx)
dbget.Execute sqlStr


''2009추가
IF ResultCode = "00" THEN
    sqlStr = " update [db_order].[dbo].tbl_order_master" & VbCrlf
    sqlStr = sqlStr & " set " & VbCrlf
    sqlStr = sqlStr & " authcode = (case when accountdiv in ('7', '20') then '" & AuthCode & "' else authcode end) " + VbCrlf
    sqlStr = sqlStr & " , cashreceiptreq = (case when accountdiv in ('7', '20') then 'R' else 'S' end) " + VbCrlf
    sqlStr = sqlStr & " where orderserial='" & orderserial & "'"

    dbget.Execute sqlStr
end if

''2010추가 - 기존 요청 내역이 있으면 삭제
IF ResultCode = "00" THEN
    sqlStr = " update [db_log].[dbo].tbl_cash_receipt"& VbCrlf
    sqlStr = sqlStr & " set cancelyn='D'"& VbCrlf
    sqlStr = sqlStr & " where orderserial='" & orderserial & "'" & VbCrlf
    sqlStr = sqlStr & " and resultcode='R'" & VbCrlf
    sqlStr = sqlStr & " and tid is NULL" & VbCrlf

    dbget.Execute sqlStr
end if

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

Set INIpay = Nothing
%>

<%
session("lastreceiptidx") = iidx
%>

<script language='javascript'>
<% IF ResultCode = "00" THEN %>
opener.location.reload();
<% END IF %>
location.replace('displayreceipt.asp');
</script>
<!-- #include virtual="/lib/db/dbclose.asp" -->
