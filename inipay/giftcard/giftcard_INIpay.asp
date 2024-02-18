<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%Response.Addheader "P3P","policyref='/w3c/p3p.xml', CP='NOI DSP LAW NID PSA ADM OUR IND NAV COM'"%>
<%
    Response.AddHeader "Cache-Control","no-cache"
    Response.AddHeader "Expires","0"
    Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/login/checklogin.asp" -->
<!-- #include virtual="/lib/inc_const.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/MD5.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/email/maillib.asp" -->
<!-- #include virtual="/lib/classes/ordercls/smscls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardinfoCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/GiftCardOptionCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_orderCls.asp" -->
<%

'==========================================================================
'	Description: 신용카드/실시간이체 주문 Process
'	History: 2009-03-02 서동석
'            2011.10.09 허진원 - 옮김
'==========================================================================
function getBankCode2Name(icode)
    SELECT CASE icode
        CASE "04" : getBankCode2Name = "국민"
        CASE "03" : getBankCode2Name = "기업"
        CASE "05" : getBankCode2Name = "외환"
        CASE "07" : getBankCode2Name = "수협"
        CASE "11" : getBankCode2Name = "농협"
        CASE "20" : getBankCode2Name = "우리"
        CASE "23" : getBankCode2Name = "SC제일"
        CASE "31" : getBankCode2Name = "대구"
        CASE "32" : getBankCode2Name = "부산"
        CASE "34" : getBankCode2Name = "광주"
        CASE "35" : getBankCode2Name = "제주"
        CASE "37" : getBankCode2Name = "전북"
        CASE "39" : getBankCode2Name = "경남"
        CASE "71" : getBankCode2Name = "우체국"
        CASE "81" : getBankCode2Name = "하나"
        CASE "88" : getBankCode2Name = "신한"
        CASE ELSE : getBankCode2Name = icode
    END SELECT

end function

dim i, userid
userid          = GetLoginUserID

dim subtotalprice
subtotalprice   = request.Form("price")

dim iorderParams
set iorderParams = new COrderParams


iorderParams.Fjumundiv			= "1"									'주문상태 : 결제대기(1)
iorderParams.Fuserid			= userid
iorderParams.Fipkumdiv			= "0"									'입급구분 : 초기 주문대기(0)
iorderParams.Faccountdiv		= request.Form("Tn_paymethod")
iorderParams.Fsubtotalprice		= subtotalprice
iorderParams.Fdiscountrate      = 1										'할인율 : 없음(1)
iorderParams.FcardItemid		= request.Form("cardid")
iorderParams.FcardOption		= request.Form("cardopt")
iorderParams.FcardPrice			= request.Form("cardPrice")

iorderParams.Faccountname		= LeftB((request.Form("acctname")),30)
iorderParams.Faccountno			= "" '''request.Form("acctno")

iorderParams.Fbuyname			= LeftB((request.Form("buyname")),32)
iorderParams.Fbuyphone			= request.Form("buyphone")
iorderParams.Fbuyhp				= request.Form("buyhp")
iorderParams.Fbuyemail			= LeftB((request.Form("buyemail")),128)
iorderParams.Fsendhp			= request.Form("sendhp")
iorderParams.Fsendemail			= LeftB((request.Form("sendemail")),128)
iorderParams.Freqhp				= request.Form("reqhp")
iorderParams.Freqemail			= LeftB((request.Form("reqemail")),128)

iorderParams.FbookingYN			= request.Form("bookingYN")
iorderParams.FbookingDate		= request.Form("bookingDate")
iorderParams.FMMSTitle			= LeftB((request.Form("MMSTitle")),128)
iorderParams.FMMSContent		= LeftB((request.Form("MMSContent")),300)

iorderParams.FsendDiv			= request.Form("sendDiv")
iorderParams.Fdesignid			= request.Form("designid")
iorderParams.FemailTitle		= LeftB((request.Form("emailTitle")),128)
iorderParams.FemailContent		= LeftB((request.Form("emailContent")),600)

iorderParams.Freferip           = Left(request.ServerVariables("REMOTE_ADDR"),32)
iorderParams.Fuserlevel			= GetLoginUserLevel

if (iorderParams.Fdesignid="") then iorderParams.Fdesignid = "101"		'카드디자인 : 기본(101)
if (iorderParams.FsendDiv="") then iorderParams.FsendDiv = "S"			'전송방법 : 문자만(S)/이메일과 함께(E)
if (iorderParams.FbookingYN="") then iorderParams.FbookingYN ="N"

dim sqlStr
'''금액 일치 확인작업 필요'' 파라메터를 조작해서 날릴 수 있음.

'// 카드-옵션 정보 접수
dim oCardItem
Set oCardItem = new CItemOption
oCardItem.FRectItemID = iorderParams.FcardItemid
oCardItem.FRectItemOption = iorderParams.FcardOption
oCardItem.GetItemOneOptionInfo

if oCardItem.FResultCount<=0 then
    response.write "<script language='javascript'>alert('판매중인 Gift카드가 아니거나 없는 Gift카드번호 입니다.');location.href='"&wwwUrl&"/shopping/giftcard/giftcard.asp?cardid=101';</script>"
	dbget.close: response.End
elseif oCardItem.FOneItem.FoptSellYn="N" then
    response.write "<script language='javascript'>alert('판매중인 Gift카드가 아니거나 품절된 Gift카드 옵션입니다.');location.href='"&wwwUrl&"/shopping/giftcard/giftcard.asp?cardid=101';</script>"
	dbget.close: response.End
end if

if (CLNG(oCardItem.FOneItem.FcardSellCash)<>CLNG(subtotalprice) or CLNG(oCardItem.FOneItem.FcardSellCash)<>CLng(iorderParams.FcardPrice)) then
    response.write "<script language='javascript'>alert('금액 오류');location.href='"&wwwUrl&"/shopping/giftcard/giftcard.asp?cardid=101';</script>"

	'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','giftcard 금액오류"&iorderParams.Freferip&":" & oCardItem.FOneItem.FcardSellCash &":"&subtotalprice&":"&iorderParams.FcardPrice&"'"
	'dbget.Execute sqlStr
	response.end
end if

set oCardItem=Nothing




''##############################################################################
''디비작업
''##############################################################################
dim giftOrderSerial, iErrStr
dim oGiftCard
set oGiftCard = new COrderGiftCard

giftOrderSerial = oGiftCard.SaveOrderDefaultDB(iorderParams, iErrStr)

if (iErrStr<>"") or (Len(giftOrderSerial)<1) then
    response.write iErrStr
    response.write "<script language='javascript'>alert('결제는 이루어 지지 않았습니다. \n\n: 오류 -" & replace(iErrStr,"'","") & "');</script>"

	'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','GiftCard 주문오류 :" + giftOrderSerial +":"+ replace(iErrStr,"'","") + "'"
	'dbget.Execute sqlStr
	response.end
end if

iorderParams.FgiftOrderSerial = giftOrderSerial


'' ###################### INI.PAY     START     ################################
dim INIpay, PInst
dim Tid, ResultCode, ResultMsg, PayMethod
dim Price1, Price2, AuthCode, CardQuota, QuotaInterest
dim CardCode, AuthCertain, PGAuthDate, PGAuthTime, OCBSaveAuthCode, OCBUseAuthCode, OCBAuthDate, CardIssuerCode, PrtcCode
dim AckResult
dim DirectBankCode, Rcash_rslt, ResultCashNoAppl
Dim Vacct, Vcdbank, Dtinput, Tminput, Nminput


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
INIpay.SetField CLng(PInst), "mid", Request("mid")	''상점아이디
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
INIpay.SetField CLng(PInst), "oid", giftOrderSerial        ''주문번호 -가상계좌시 필수


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

''실시간 이체 현금영수증 관련
if (iorderParams.Faccountdiv="20") and (Rcash_rslt="0000") then
    AuthCode = ResultCashNoAppl
end if

''무통장 가상계좌
Vacct = INIpay.GetResult(CLng(PInst), "Vacct")     '   무통장 입금 예약의 입금할 계좌번호 16byte
Vcdbank = getBankCode2Name(INIpay.GetResult(CLng(PInst), "Vcdbank")) '   무통장 입금 예약의 입금할 은행코드 2byte
Dtinput = INIpay.GetResult(CLng(PInst), "Dtinput") '   무통장 입금 예약의 입금예정일 (YYYYMMDD) 8byte
Nminput = INIpay.GetResult(CLng(PInst), "Nminput") '   무통장 입금 예약의 송금자 명 20 byte

IF (iorderParams.Faccountdiv="7") then
    iorderParams.Faccountno			= Vcdbank & " " & Vacct
    iorderParams.Faccountname		= Nminput
End IF

IF (iorderParams.Faccountdiv="20") Then     ''실시간
    iorderParams.FPayEtcResult = LEFT(DirectBankCode,16)
ELSEIF (iorderParams.Faccountdiv="7") then    ''가상계좌
    iorderParams.FPayEtcResult = ""
ELSe                                        ''신용카드
    iorderParams.FPayEtcResult = LEFT(CardCode&"|"&CardIssuerCode&"|"&CardQuota,16)
END IF


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


dim i_Resultmsg
i_Resultmsg = replace(ResultMsg,"|","_")

iorderParams.Fresultmsg  = i_Resultmsg
iorderParams.Fauthcode = AuthCode
iorderParams.Fpaygatetid = Tid
iorderParams.IsSuccess = (ResultCode = "00")

IF (iorderParams.IsSuccess) then
    if (iorderParams.Faccountdiv="7") then
        iorderParams.FIsCyberAccount = true
        iorderParams.FFINANCECODE = Vcdbank	'가상계좌 은행코드
        iorderParams.FACCOUNTNUM = Vacct	'가상 계좌번호
        iorderParams.FCLOSEDATE	= Dtinput	'입금만료일
        iorderParams.Fipkumdiv = 3			'입금대기

    else
        iorderParams.Fipkumdiv = 4			'결제완료
        iorderParams.Fjumundiv = 3
    end if
ELSE
    iorderParams.Fipkumdiv = 1				'결제실패
END IF

''카드통신후.
Call oGiftCard.SaveOrderResultDB(iorderParams, iErrStr)

if (iErrStr<>"") then
    response.write "<script language='javascript'>alert('작업중 오류가 발생하였습니다. 고객센터로 문의해 주세요. \n\n: 오류 - " & Replace(iErrStr,"'","") &" ');</script>"
    response.end
end if

	if (Err) then
        iErrStr = replace(err.Description,"'","")

    	response.write "<script>javascript:alert('작업중 오류가 발생하였습니다. 고객센터로 문의해 주세요.: \n\n" & iErrStr & "')</script>"
    	response.write "<script>javascript:history.back();</script>"
		response.end
	end if

Set INIpay = Nothing

'' ###################### INI.PAY     END     ################################

IF (iorderParams.IsSuccess) and (iorderParams.Faccountdiv="7") then
	'' ================ 보증보험 추가(2006.06.13; 허진원)  ================
	dim objUsafe, result, result_code, result_msg
	dim reqInsureChk, insureSsn1, insureSsn2
	dim isign, lp
	dim InsureErrorMsg
	reqInsureChk = request.Form("reqInsureChk")
	insureSsn1 = request.Form("insureSsn1")
	insureSsn2 = request.Form("insureSsn2")
	isign = request.Form("agreeInsure") & request.Form("agreeEmail") & request.Form("agreeSms")

	if reqInsureChk="Y" then
		Set objUsafe = CreateObject( "USafeCom.guarantee.1"  )

		IF application("Svr_Info")="Dev" THEN
			'Test일 때
			objUsafe.Port = 80
			objUsafe.Url = "gateway2.usafe.co.kr"
			objUsafe.CallForm = "/esafe/guartrn.asp"
		Else
		    ' Real일 때
		    objUsafe.Port = 80
		    objUsafe.Url = "gateway.usafe.co.kr"
		    objUsafe.CallForm = "/esafe/guartrn.asp"
		End If

	    '   데이터 64Bit 암호화시 사용
	    objUsafe.EncKey = ""		'20230120 보증보험 업그레이드>빈값사용

	    objUsafe.AddGoods goodname
	    objUsafe.AddGoodsPrice subtotalprice
	    objUsafe.AddGoodsCnt 1

	    objUsafe.gubun			= "A0"								'// 전문구분 (A0:신규발급, B0:보증서취소, C0:입금확인)
	    objUsafe.mallId			= "ZZcube1010"						'// 쇼핑몰ID
	    objUsafe.oId			= giftOrderSerial					'// 주문번호
	    objUsafe.totalMoney		= subtotalprice						'// 결제금액
	    objUsafe.pId			= insureSsn1 & insureSsn2			'// 실제 주민등록번호 13자리
	    objUsafe.payMethod		= "CAS"								'// 결제방법 (MON:무통장, CAS:가상계좌, BMC:계좌이체, CAD:신용카드)
	    objUsafe.payInfo1		= Vcdbank							'// 무통장 - 계좌명
	    objUsafe.payInfo2		= Vacct								'// 무통장 - 계좌번호
	    objUsafe.orderNm		= iorderParams.Fbuyname				'// 주문자 이름
	    objUsafe.orderHomeTel	= iorderParams.Fbuyphone			'// 주문자 전화1
	    objUsafe.orderHpTel		= iorderParams.Fbuyhp				'// 주문자 전화2
	    objUsafe.orderEmail		= iorderParams.Fbuyemail		    '// 주문자 이메일
	    objUsafe.goodsCount		= 1                                 ''oshoppingbag.FShoppingBagItemCount	'// 상품종류수 (Default: 1)
	    objUsafe.acceptor		= iorderParams.Freqname				'// 수령인 이름
	    objUsafe.deliveryTel1	= iorderParams.Freqhp				'// 수령인 전화1
	    objUsafe.deliveryTel2	= iorderParams.Freqphone			'// 수령인 전화2
	    objUsafe.sign			= isign								'// 개인정보동의(1) Email수신동의(2) SMS수신동의(3)

	    '정보 전송 및 결과 접수
	    result = objUsafe.contractInsurance

	    result_code	= Left( result , 1 )
	    result_msg	= Mid( result , 3 )

	    '결과 저장
	    Call oshoppingbag.PutInsureMsg(giftOrderSerial, result_code, result_msg)

	    '결과에 따른 처리(오류 무시하고 진행 - 수정 2006.06.15; 운영관리팀 허진원)
	    Select Case result_code
	        Case "0" '// 성공
	        Case "1" '// 실패
	        Case Else '// 예외 오류
	    End Select
	    Set objUsafe = Nothing

	    if (result_code<>"0") then
	        InsureErrorMsg = "보증보험 발행 실패 : [" & Replace(result_msg,"'","") & "]"
	        InsureErrorMsg = InsureErrorMsg & "\n\n 보증보험이 발행 안된 경우 본 주문 건에 대해 "
	        InsureErrorMsg = InsureErrorMsg & "\n 인터넷 쇼핑몰 사고 등으로 인한 소비자의 금전적 피해에 대해 보장 받으실 수 없습니다."
	        InsureErrorMsg = InsureErrorMsg & "\n 재주문 해주시거나. 보증보험 발행이 계속 안되실 경우 "
	        InsureErrorMsg = InsureErrorMsg & "\n 고객센터로 문의해 주세요 (1644-6030)"
	    end if

	End if

	'' ================ 보증보험 끝 ================================

end if

'// 주문번호 저장(결과 페이지용)
response.Cookies("shoppingbag").domain = "10x10.co.kr"
response.Cookies("shoppingbag")("before_GiftOrdSerial") = giftOrderSerial

if (iorderParams.IsSuccess) then
	response.Cookies("shoppingbag")("before_GiftisSuccess") = "true"
else
	response.Cookies("shoppingbag")("before_GiftisSuccess") = "false"
end if

If (iorderParams.IsSuccess) then
    On Error Resume Next
    '// 결제 완료 메일 발송::주문자에게 발송.
    Call SendMailGiftOrder(userid,giftOrderSerial,"텐바이텐<customer@10x10.co.kr>")

	dim osms
    if (iorderParams.Faccountdiv="7") then
        '// 결제 완료 SMS 발송(무통장)
        set osms = new CSMSClass
        osms.SendAcctJumunOkMsg2 iorderParams.Fbuyhp, giftOrderSerial, iorderParams.FFINANCECODE + " " + iorderParams.FACCOUNTNUM, iorderParams.Fsubtotalprice ''수정 2015/08/16
        set osms = Nothing
    else
        '// 결제 완료 SMS 발송
        set osms = new CSMSClass
        osms.SendJumunOkMsg iorderParams.Fbuyhp, giftOrderSerial
        set osms = Nothing

	    if (iorderParams.FbookingYN<>"Y") then
	        if iorderParams.FbookingYN.FsendDiv="E" then
		        '// Gift카드 메일 발송::수령인에게
		        Call sendGiftCardEmail_SMTP(giftOrderSerial)
			end if

	        '// Gift카드 MMS 발송::수령인에게
	        Call sendGiftCardLMSMsg(giftOrderSerial)

			'// 메지시 발송 처리
			Call oGiftCard.SaveOrderSendOKDB(giftOrderSerial)
	    end if
    end if

    On Error Goto 0
end if

Set iorderParams= Nothing
Set oGiftCard= Nothing

'' 주문 결과 페이지로 이동
response.write "<script language='javascript'>location.replace('" & wwwUrl & "/inipay/giftcard/giftcard_dispOrder.asp');</script>"
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
