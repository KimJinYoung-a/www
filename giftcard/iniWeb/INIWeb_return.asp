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
<!-- #include virtual="/inipay/iniWeb/INIWeb_Util.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_orderCls2016.asp" -->
<!-- #include virtual="/lib/util/rndSerial.asp" -->
<!-- #include virtual="/inipay/iniWeb/aspJSON1.17.asp" -->
<%
''INIWeb_return.asp
dim i

dim imid : imid = request.form("mid")    ''변수 주의! 
dim resultCode : resultCode = request.form("resultCode")
dim resultMsg : resultMsg = request.form("resultMsg")

dim authUrl : authUrl = request.form("authUrl")
dim authToken : authToken = request.form("authToken")

dim netCancelUrl : netCancelUrl = request.form("netCancelUrl")

dim iTmpIdx : iTmpIdx = request.form("merchantData")    ''임시 주문일련번호

dim icharset : icharset = "UTF-8" 
dim iformat : iformat = "JSON"

if iTmpIdx="" then
    response.write "<script>alert('통신 중 오류가 발생했습니다.(E01)'); history.back();</script>"
    dbget.close() : response.end
end if

'// 임시주문 데이터 접수
Dim oGiftOrder, iPrice, strSql
Set oGiftOrder = New cGiftcardOrderTemp
oGiftOrder.FTempIdx = iTmpIdx
iPrice = oGiftOrder.fnGetTempOrderPrice


''===== 인증 실패 ==============================
if (resultCode<>"0000") then
	'// 실패 정보저장(임시주문테이블)
	strSql = " update [db_order].[dbo].[tbl_giftcard_order_temp] " & vbCrlf
	strSql = strSql & "Set P_STATUS='" & left(resultCode,4) & "'" & vbCrlf
	strSql = strSql & ", P_RMESG1='" & resultMsg & "'" & vbCrlf
	strSql = strSql & ", IsPay='N'" & vbCrlf
	strSql = strSql & " Where temp_idx=" & iTmpIdx
	dbget.Execute strSql

    response.write "<script>alert('인증에 실패하였습니다.\r\n"&replace(resultMsg,"'","")&"'); history.back();</script>"
    dbget.close() : response.end
end if


''===== 인증성공한경우 ==============================

'' 승인 통신
dim timestamp : timestamp = getIniWebTimestamp()
dim signature : signature = (getIniWebConfirmSignature(authToken,timestamp))

dim xmlHttp, postdata, strData, postdata2, strData2

On Error Resume Next

Set xmlHttp = CreateObject("Msxml2.ServerXMLHTTP.3.0")
	postdata = "mid="&imid
	postdata = postdata&"&authToken="&server.URLEncode(authToken)
	postdata = postdata&"&signature="&server.URLEncode(signature)
	postdata = postdata&"&timestamp="&timestamp
	postdata = postdata&"&charset="&server.URLEncode(icharset)
	postdata = postdata&"&format="&server.URLEncode(iformat)  ''&"&mKey="&server.URLEncode(INIWEB_mKey)
	postdata = postdata&"&price="&iPrice

	''response.write "[postdata]"&postdata

	xmlHttp.open "POST",authUrl, False
	xmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded; charset=utf-8"  ''UTF-8 charset 필요.
	xmlHttp.setTimeouts 90000,90000,90000,90000 ''2013/03/14 추가
	xmlHttp.Send postdata	'post data send

	strData = BinaryToText(xmlHttp.responseBody, "UTF-8")
Set xmlHttp = nothing

IF Err.Number <> 0 then
    'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','gift카드:xmlhttp-tidx("&iTmpIdx&"):"&replace(err.Description,"'","")&"'"
	'dbget.Execute sqlStr

    response.write "<script>alert('이니시스에 승인요청 중 오류가 발생하였습니다.(E02)'); history.back();</script>"
    dbget.close() : response.end
End If

On Error Goto 0

'승인결과 Parse
Dim oJSON, oJSON2
dim AuthCode, CardQuota
dim CARD_Interest, CARD_CheckFlag
dim TotPrice, applPrice, tid, MOID, payMethod, payDevice, CardCode
dim DirectBankCode, CardIssuerCode, PrtcCode
dim vBankName, vBankNum, vBankInput, vBankDate
resultCode="": resultMsg=""

Set oJSON = New aspJSON
oJSON.loadJSON(strData)

resultCode		= oJSON.data("resultCode")
resultMsg		= oJSON.data("resultMsg")
AuthCode		= oJSON.data("applNum")			'' 승인번호
CardQuota		= oJSON.data("CARD_Quota")		''카드 할부기간
CARD_Interest	= oJSON.data("CARD_Interest")	'' 카드 할부여부. (“1”이면 무이자할부)
TotPrice		= oJSON.data("TotPrice")		''거래금액
applPrice		= oJSON.data("applPrice")		''승인금액?
tid				= oJSON.data("tid")				''tid
MOID			= oJSON.data("MOID")			''MOID 원주문번호
payMethod		= oJSON.data("payMethod")		''Card:신용카드, DirectBank:실시간계좌이체, OCBPoint:OKCashbag 포인트, HPP:핸드폰, VBank:무통장입금(가상계좌)
payDevice		= oJSON.data("payDevice")		''결제 장치 : PC,ETC
CardCode		= oJSON.data("CARD_Code")		''CARD_Code
PrtcCode		= oJSON.data("CARD_PRTC_CODE")	''부분취소 가능여부?
CardIssuerCode	= oJSON.data("CARD_BankCode")	'' 카드 발급사 코드

vBankName		= getBankCode2Name(oJSON.data("VACT_BankCode"))	''가상계좌 은행코드 (2byte) > 은행명
vBankNum		= oJSON.data("VACT_Num")		''가상 계좌번호 (20byte)
vBankInput		= oJSON.data("VACT_InputName")	''입금자이름
vBankDate		= oJSON.data("VACT_Date")		''입금만료일 (YYYYMMDD)

DirectBankCode	= oJSON.data("ACCT_BankCode")	''은행코드(실시간이체)
Set oJSON = Nothing


'// 승인 정보저장(임시주문테이블)
strSql = " update [db_order].[dbo].[tbl_giftcard_order_temp] " & vbCrlf
strSql = strSql & "Set P_STATUS='" & left(resultCode,4) & "'" & vbCrlf
strSql = strSql & ", P_TID='" & tid & "'" & vbCrlf
strSql = strSql & ", P_AUTH_NO='" & AuthCode & "'" & vbCrlf
strSql = strSql & ", P_RMESG1='" & resultMsg & "'" & vbCrlf
strSql = strSql & ", P_RMESG2='" & CardQuota & "'" & vbCrlf
strSql = strSql & ", P_FN_CD1='" & DirectBankCode & "'" & vbCrlf
strSql = strSql & ", P_CARD_ISSUER_CODE='" & CardIssuerCode & "'" & vbCrlf
strSql = strSql & ", P_CARD_PRTC_CODE='" & PrtcCode & "'" & vbCrlf

IF payMethod="VBank" then
	strSql = strSql & ", accountno='" & vBankName & " " & vBankNum & "'" & vbCrlf
	strSql = strSql & ", accountname='" & vBankInput & "'" & vbCrlf
End IF

strSql = strSql & ", IsPay='Y'" & vbCrlf
strSql = strSql & ", IsSuccess='" & (ResultCode = "0000") & "'" & vbCrlf
strSql = strSql & " Where temp_idx=" & iTmpIdx
dbget.Execute strSql



'// 임시주문정보 > 실주문정보 처리
Dim vTemp, vResult, vRstMsg, vIOrder, vIsSuccess
vTemp 		= OrderRealSaveProc(iTmpIdx)
vResult		= Split(vTemp,"|")(0)
vIOrder		= Split(vTemp,"|")(1)
vRstMsg		= Split(vTemp,"|")(2)
vIsSuccess	= Split(vTemp,"|")(3)

IF vResult = "ok" Then
	'// 주문 정보저장(임시주문테이블)
	strSql = " update [db_order].[dbo].[tbl_giftcard_order_temp] " & vbCrlf
	strSql = strSql & "Set giftOrderSerial='" & vIOrder & "'" & vbCrlf
	strSql = strSql & ", PayResultCode='" & vResult & "'" & vbCrlf
	strSql = strSql & " Where temp_idx=" & iTmpIdx
	dbget.Execute strSql

	''Save OrderSerial / UserID or SSN Key
	response.Cookies("shoppingbag").domain = "10x10.co.kr"
	response.Cookies("shoppingbag")("before_GiftOrdSerial") = vIOrder

	if (vIsSuccess) then
		response.Cookies("shoppingbag")("before_GiftisSuccess") = "true"
	else
		response.Cookies("shoppingbag")("before_GiftisSuccess") = "false"
	end if

	dim dumi : dumi=LEFT(MD5(vIOrder&"ten"&vIOrder),20)	''TenOrderSerialHash(vIOrder)	in "/lib/classes/ordercls/sp_myordercls.asp"

	'// 결제 완료 페이지로 이동
	Response.Write "<script>document.location.replace(""" & wwwUrl & "/giftcard/giftcard_DispOrder.asp?dumi=" & dumi & """);</script>"	''캐시 먹음. post or dumi

Else
	'// 주문 정보저장(임시주문테이블)
	strSql = " update [db_order].[dbo].[tbl_giftcard_order_temp] " & vbCrlf
	strSql = strSql & "Set giftOrderSerial='" & vIOrder & "'" & vbCrlf
	strSql = strSql & ", P_RMESG2='" & vRstMsg & "'" & vbCrlf
	strSql = strSql & ", PayResultCode='" & vResult & "'" & vbCrlf
	strSql = strSql & " Where temp_idx=" & iTmpIdx
	dbget.Execute strSql

    response.write "<script>alert('"&replace(vRstMsg,"'","\'") &" (" & vResult & ")'); history.back();</script>"
    dbget.close() : response.end
End If

Set oGiftOrder = Nothing

'// IniWeb표준 결제 무통장 은행명 반환
function getBankCode2Name(icode)
    SELECT CASE icode
        CASE "03" : getBankCode2Name = "기업"
        CASE "04" : getBankCode2Name = "국민"
        CASE "05" : getBankCode2Name = "외환"
        CASE "07" : getBankCode2Name = "수협"
        CASE "11" : getBankCode2Name = "농협"
        CASE "20" : getBankCode2Name = "우리"
        CASE "23" : getBankCode2Name = "SC제일"
        CASE "31" : getBankCode2Name = "대구"
        CASE "32" : getBankCode2Name = "부산"
        CASE "34" : getBankCode2Name = "광주"
        CASE "37" : getBankCode2Name = "전북"
        CASE "39" : getBankCode2Name = "경남"
        CASE "53" : getBankCode2Name = "씨티"
        CASE "71" : getBankCode2Name = "우체국"
        CASE "81" : getBankCode2Name = "하나"
        CASE "88" : getBankCode2Name = "신한"
        CASE ELSE : getBankCode2Name = icode
    END SELECT
end function
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->