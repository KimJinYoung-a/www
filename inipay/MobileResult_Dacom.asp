<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<% Response.Addheader "P3P","policyref=""/w3c/p3p.xml"", CP=""CONi NOI DSP LAW NID PHY ONL OUR IND COM"""%>
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
<%
''신용카드 / 실시간 이체 결제.
'' 사이트 구분
Const sitename = "10x10"

dim i, userid, guestSessionID
userid          = GetLoginUserID
guestSessionID  = GetGuestSessionKey

dim iorderParams
dim subtotalprice
subtotalprice   = request.Form("price")
dim ordersheetyn : ordersheetyn   = request.Form("ordersheetyn")
	if isnull(ordersheetyn) or ordersheetyn="" then ordersheetyn="Y"

set iorderParams = new COrderParams

iorderParams.Fjumundiv          = "1"
iorderParams.Fuserid            = userid
iorderParams.Fipkumdiv          = "0"           '' 초기 주문대기
iorderParams.Faccountdiv        = "400" ''request.Form("Tn_paymethod")
iorderParams.Fsubtotalprice     = subtotalprice
iorderParams.Fdiscountrate      = 1

iorderParams.Fsitename          = sitename
iorderParams.Fordersheetyn		= ordersheetyn
iorderParams.fdevice			="W"
iorderParams.Faccountname       = LeftB((request.Form("acctname")),30)
iorderParams.Faccountno         = "" '''request.Form("acctno")
iorderParams.Fbuyname           = LeftB((request.Form("buyname")),30)
iorderParams.Fbuyphone          = request.Form("buyphone1") + "-" + request.Form("buyphone2") + "-" + request.Form("buyphone3")
iorderParams.Fbuyhp             = request.Form("buyhp1") + "-" + request.Form("buyhp2") + "-" + request.Form("buyhp3")
iorderParams.Fbuyemail          = LeftB((request.Form("buyemail")),100)
iorderParams.Freqname           = LeftB((request.Form("reqname")),30)
'
iorderParams.Freqzipcode        = request.Form("txZip")
if (iorderParams.Freqzipcode="") then
    iorderParams.Freqzipcode        = request.Form("txZip1") + "-" + request.Form("txZip2")
end if
iorderParams.Freqzipaddr        = LeftB((request.Form("txAddr1")),120)
iorderParams.Freqaddress        = LeftB((request.Form("txAddr2")),255)
iorderParams.Freqphone          = request.Form("reqphone1") + "-" + request.Form("reqphone2") + "-" + request.Form("reqphone3")
iorderParams.Freqhp             = request.Form("reqhp1") + "-" + request.Form("reqhp2") + "-" + request.Form("reqhp3")

If Trim(LeftB((request.Form("comment")),255)) = "etc" Then
	iorderParams.Fcomment = Trim(LeftB((request.Form("comment_etc")),255))
Else
	iorderParams.Fcomment = Trim(LeftB((request.Form("comment")),255))
End If

iorderParams.Fmiletotalprice    = request.Form("spendmileage")
iorderParams.Fspendtencash      = request.Form("spendtencash")
iorderParams.Fspendgiftmoney    = request.Form("spendgiftmoney")
iorderParams.Fcouponmoney       = request.Form("couponmoney")
iorderParams.Fitemcouponmoney   = request.Form("itemcouponmoney")
iorderParams.Fcouponid          = request.Form("sailcoupon")                ''할인권 쿠폰번호
iorderParams.FallatDiscountprice= 0

iorderParams.Frdsite            = request.cookies("rdsite")
iorderParams.Frduserid          = ""

iorderParams.FUserLevel         = GetLoginUserLevel
iorderParams.Freferip           = Left(request.ServerVariables("REMOTE_ADDR"),32)
iorderParams.FchkKakaoSend      = request.Form("chkKakaoSend")				''카카오톡 발송여부

''플라워
if (request.Form("yyyy")<>"") then
    iorderParams.Freqdate           = CStr(dateserial(request.Form("yyyy"),request.Form("mm"),request.Form("dd")))
    iorderParams.Freqtime           = request.Form("tt")
    iorderParams.Fcardribbon        = request.Form("cardribbon")
    iorderParams.Fmessage           = LeftB(html2db(request.Form("message")),500)
    iorderParams.Ffromname          = LeftB(html2db(request.Form("fromname")),30)
end if

''현장수령날짜
if (request.Form("yyyymmdd")<>"") then
    iorderParams.Freqdate           = CStr(request.Form("yyyymmdd"))
end if

''해외배송 추가 : 2009 ===================================================================
if (request.Form("countryCode")<>"") and (request.Form("countryCode")<>"KR") and (request.Form("countryCode")<>"ZZ") then
    iorderParams.Freqphone      = iorderParams.Freqphone + "-" + request.Form("reqphone4")
    iorderParams.FemsZipCode    = request.Form("emsZipCode")
    iorderParams.Freqemail      = request.Form("reqemail")
    iorderParams.FemsPrice      = request.Form("emsPrice")
    iorderParams.FcountryCode   = request.Form("countryCode")
elseif (request.Form("countryCode")="ZZ") then
    iorderParams.FcountryCode   = "ZZ"
    iorderParams.FemsPrice      = 0
else
    iorderParams.FcountryCode   = "KR"
    iorderParams.FemsPrice      = 0
end if
''========================================================================================

''사은품 추가=======================
iorderParams.Fgift_code         = request.Form("gift_code")
iorderParams.Fgiftkind_code     = request.Form("giftkind_code")
iorderParams.Fgift_kind_option  = request.Form("gift_kind_option")

''다이어리 사은품 추가=======================
iorderParams.FdGiftCodeArr      = request.Form("dGiftCode")
iorderParams.FDiNoArr           = request.Form("DiNo")

dim checkitemcouponlist
dim Tn_paymethod, packtype

checkitemcouponlist = request.Form("checkitemcouponlist")
if (Right(checkitemcouponlist,1)=",") then checkitemcouponlist=Left(checkitemcouponlist,Len(checkitemcouponlist)-1)
Tn_paymethod        = request.Form("Tn_paymethod")
packtype            = request.Form("packtype")

''Param Check
if (iorderParams.Faccountname="") then iorderParams.Faccountname = iorderParams.Fbuyname
if (Not isNumeric(iorderParams.Fmiletotalprice)) or (iorderParams.Fmiletotalprice="") then iorderParams.Fmiletotalprice=0
if (Not isNumeric(iorderParams.Fspendtencash)) or (iorderParams.Fspendtencash="") then iorderParams.Fspendtencash=0
if (Not isNumeric(iorderParams.Fspendgiftmoney)) or (iorderParams.Fspendgiftmoney="") then iorderParams.Fspendgiftmoney=0
if (Not isNumeric(iorderParams.Fitemcouponmoney)) or (iorderParams.Fitemcouponmoney="") then iorderParams.Fitemcouponmoney=0
if (Not isNumeric(iorderParams.Fcouponmoney)) or (iorderParams.Fcouponmoney="") then iorderParams.Fcouponmoney=0
if (Not isNumeric(iorderParams.Fcouponid)) or (iorderParams.Fcouponid="") then iorderParams.Fcouponid=0
if (Not isNumeric(iorderParams.FemsPrice)) or (iorderParams.FemsPrice="") then iorderParams.FemsPrice=0
if (packtype="") then packtype="0000"

'On Error resume Next
dim sqlStr

''수령인정보 체크 2013/11/28
if (iorderParams.Freqname="") then
    response.write "<script>alert('결제정보 오류 수령인 정보 누락-결제는 이루어지지 않았습니다.')</script>"
	response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp')</script>"
	response.end
end if

'''' ########### 마일리지 사용 체크 - ################################
dim oMileage, availtotalMile
set oMileage = new TenPoint
oMileage.FRectUserID = userid
if (userid<>"") then
    oMileage.getTotalMileage
    availtotalMile = oMileage.FTotalMileage
end if

''예치금 추가
Dim oTenCash, availtotalTenCash
set oTenCash = new CTenCash
oTenCash.FRectUserID = userid
if (userid<>"") then
    oTenCash.getUserCurrentTenCash
    availtotalTenCash = oTenCash.Fcurrentdeposit
end if

''Gift카드 추가
Dim oGiftCard, availTotalGiftMoney
availTotalGiftMoney = 0
set oGiftCard = new myGiftCard
oGiftCard.FRectUserID = userid
if (userid<>"") then
    availTotalGiftMoney = oGiftCard.myGiftCardCurrentCash
end if

if (availtotalMile<1) then availtotalMile=0
if (availtotalTenCash<1) then availtotalTenCash=0
if (availTotalGiftMoney<1) then availTotalGiftMoney=0
    
if (CLng(iorderParams.Fmiletotalprice)>CLng(availtotalMile)) then
    response.write "<script>alert('장바구니 금액 오류 (사용가능 마일리지 부족) - 다시계산해 주세요.')</script>"
	response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp')</script>"
	response.end
end if

if (CLng(iorderParams.Fspendtencash)>CLng(availtotalTenCash)) then
    response.write "<script>alert('장바구니 금액 오류 (사용가능 예치금 부족) - 다시계산해 주세요.')</script>"
	response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp')</script>"
	response.end
end if

if (CLng(iorderParams.Fspendgiftmoney)>CLng(availTotalGiftMoney)) then
    response.write "<script>alert('장바구니 금액 오류 (사용가능 Gift카드 잔액 부족) - 다시계산해 주세요.')</script>"
	response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp')</script>"
	response.end
end if

'''' ##################################################################

dim oshoppingbag,goodname
set oshoppingbag = new CShoppingBag
	oshoppingbag.FRectUserID = userid
	oshoppingbag.FRectSessionID = guestSessionID
	oShoppingBag.FRectSiteName  = sitename
	oShoppingBag.FcountryCode = iorderParams.FcountryCode           ''2009추가
	oshoppingbag.GetShoppingBagDataDB_Checked

if (oshoppingbag.IsShoppingBagVoid) then
	response.write "<script>alert('쇼핑백이 비었습니다. - 결제는 이루어지지 않았습니다.');</script>"
	response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp');</script>"
	response.end
end if

''품절상품체크::임시.연아다이어리
if (oshoppingbag.IsSoldOutSangpumExists) then
    response.write "<script>alert('죄송합니다. 품절된 상품은 구매하실 수 없습니다.');</script>"
	response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp');</script>"
	response.end
end if

''업체 개별 배송비 상품이 있는경우
if (oshoppingbag.IsUpcheParticleBeasongInclude)  then
    oshoppingbag.GetParticleBeasongInfoDB_Checked
end if

goodname = oshoppingbag.getGoodsName

dim tmpitemcoupon, tmp
tmpitemcoupon = split(checkitemcouponlist,",")

'상품쿠폰 적용
for i=LBound(tmpitemcoupon) to UBound(tmpitemcoupon)
	tmp = trim(tmpitemcoupon(i))

	if oshoppingbag.IsCouponItemExistsByCouponIdx(tmp) then
		oshoppingbag.AssignItemCoupon(tmp)
	end if
next

''보너스 쿠폰 적용
if (iorderParams.Fcouponid<>0) then
    oshoppingbag.AssignBonusCoupon(iorderParams.Fcouponid)
end if

''Ems 금액 적용
oshoppingbag.FemsPrice = iorderParams.FemsPrice

''20120202 EMS 금액 체크(해외배송)
if (request.Form("countryCode")<>"") and (request.Form("countryCode")<>"KR") and (request.Form("countryCode")<>"ZZ") and (iorderParams.FemsPrice<1) then
    response.write "<script>alert('장바구니 금액 오류 - EMS 금액오류.')</script>"
	response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp')</script>"
	response.end
end if

''20090602 KB카드 할인 추가. 카드 할인금액 - 위치에 주의 : 상품쿠폰 먼저 적용후 계산.====================
if (request.cookies("rdsite")="kbcard") and (Request("mid")="teenxteen5") then
    oshoppingbag.FDiscountRate = 0.95
    iorderParams.FallatDiscountprice = oshoppingbag.GetAllAtDiscountPrice
end if
'' =================================================================================

''보너스쿠폰 금액 체크 ''2012/11/28-----------------------------------------------------------------
dim mayBCpnDiscountPrc
if (iorderParams.Fcouponmoney<>0) or (iorderParams.Fcouponid<>0) then '' (iorderParams.Fcouponid<>0) 추가
    mayBCpnDiscountPrc = oshoppingbag.getBonusCouponMayDiscountPrice

    if (CLNG(mayBCpnDiscountPrc)<>CLNG(iorderParams.Fcouponmoney)) then
        'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','쿠폰 금액오류(hp) ::"&iorderParams.Freferip&"::"&iorderParams.Fcouponid&":"&mayBCpnDiscountPrc&"::"&iorderParams.Fcouponmoney&"'"
		'dbget.Execute sqlStr

        response.write "<script>alert('장바구니 금액 오류 - 다시계산해 주세요.')</script>"
        response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp')</script>"
	    response.end
    end if
end if
'''-------------------------------------------------------------------------------------------------

dim ipojangcnt, ipojangcash
	ipojangcnt=0
	ipojangcash=0

'선물포장서비스 노출		'/2015.11.11 한용민 생성
if G_IsPojangok then
	ipojangcnt = oshoppingbag.FPojangBoxCNT		'/포장박스갯수
	ipojangcash = oshoppingbag.FPojangBoxCASH		'/포장비
end if

iorderParams.fpojangcnt = ipojangcnt
iorderParams.fpojangcash = ipojangcash

'''금액일치확인 ***
if (CLng(oshoppingbag.getTotalCouponAssignPrice(packtype) + iorderParams.fpojangcash - iorderParams.Fmiletotalprice-iorderParams.Fcouponmoney-iorderParams.FallatDiscountprice-iorderParams.Fspendtencash-iorderParams.Fspendgiftmoney) <> CLng(subtotalprice)) then
	'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','장바구니 금액 오류 hp ::"&iorderParams.Freferip&"::"&iorderParams.Fmiletotalprice&"::"&iorderParams.Fcouponmoney&"::"&iorderParams.Fspendtencash&"::"&iorderParams.Fspendgiftmoney&"::"&subtotalprice&"'"
	'dbget.Execute sqlStr

	response.write "<script>alert('장바구니 금액 오류 - 다시계산해 주세요')</script>"
	'response.write "<script>alert('"&oshoppingbag.getTotalCouponAssignPrice(packtype) + iorderParams.fpojangcash - iorderParams.Fmiletotalprice-iorderParams.Fcouponmoney-iorderParams.FallatDiscountprice&","&subtotalprice&"')</script>"
	response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp')</script>"
	response.end
end if

''##############################################################################
''디비작업
''##############################################################################
dim iorderserial, iErrStr

iorderserial = oshoppingbag.SaveOrderDefaultDB(iorderParams, iErrStr)

if (iErrStr<>"") then
    response.write iErrStr
    response.write "<script language='javascript'>alert('결제는 이루어 지지 않았습니다. \n\n: 오류 -" & replace(iErrStr,"'","") & "');</script>"
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
    Dim itemName, vIsSuccess
    vIsSuccess = "x"

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
''            vIsSuccess = "o"
''
''           	if isDBOK then
''           		vIsSuccess = "o"
''           	else
''           		vIsSuccess = "x"
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
''        	vIsSuccess = "x"
''          	'결제결제요청 결과 실패 DB처리
''			Set cErrLog = New CShoppingBag
''			Call cErrLog.MobileDacomErrorLog(GetLoginUserID(), request("userphone"), xpay.resCode, Replace(xpay.resMsg,"'","w"))
''			Set cErrLog = Nothing
''          	Response.Write "<script language='javascript'>alert('최종결제요청이 실패하였습니다.\n\n메세지:" & vErrorMsg & "\n\n결제를 다시 시도 해보시고 그래도 같은 결과면\n위의 메세지 코드와 내용을 모메해두셨다가\n고객센터(Tel.1644-6030)에 연락을 주시기 바랍니다.');window.close();</script>"
''        end if
    else
    	vIsSuccess = "x"
    	dim cErrLog
		Set cErrLog = New CShoppingBag
		Call cErrLog.MobileDacomErrorLog(GetLoginUserID(), request("userphone"), xpay.resCode, Replace(Left(xpay.resMsg,60),"'",""))
		Set cErrLog = Nothing

		'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','Hp-W-"&application("Svr_Info")&" [" + xpay.resCode + "] " & Replace(Left(xpay.resMsg,60),"'","") & "'"
    	'dbget.Execute sqlStr

    end if

	ResultCode = xpay.resCode
	ResultMsg = Left(xpay.resMsg,90)

Set xpay = Nothing

'############################################## 모바일 결제 ################################################

dim i_Resultmsg, AuthCode
i_Resultmsg = replace(ResultMsg,"|","_")

iorderParams.Fresultmsg  = i_Resultmsg
iorderParams.Fauthcode = AuthCode
iorderParams.Fpaygatetid = vOrderResult
iorderParams.IsSuccess = (ResultCode = "0000")

Call oshoppingbag.SaveOrderResultDB(iorderParams, iErrStr)

if (iErrStr<>"") then
    response.write iErrStr
    response.write "<script language='javascript'>alert('작업중 오류가 발생하였습니다. 고객센터로 문의해 주세요.: \n\n: 오류 -" & replace(iErrStr,"'","") & "');</script>"
    response.end
end if

if (Err) then

    iErrStr = replace(err.Description,"'","")

	response.write "<script>javascript:alert('작업중 오류가 발생하였습니다. 고객센터로 문의해 주세요.: \n\n" & iErrStr & "')</script>"
	response.write "<script>javascript:history.back();</script>"
	response.end
end if


On Error resume Next
dim osms, helpmail
helpmail = oshoppingbag.GetHelpMailURL

    IF (iorderParams.IsSuccess) THEN
        call sendmailorder(iorderserial,helpmail)

        set osms = new CSMSClass
		osms.SendJumunOkMsg iorderParams.Fbuyhp, iorderserial
	    set osms = Nothing

    end if
on Error Goto 0

''Save OrderSerial / UserID or SSN Key
response.Cookies("shoppingbag").domain = "10x10.co.kr"
response.Cookies("shoppingbag")("before_orderserial") = iorderserial

if (iorderParams.IsSuccess) then
	response.Cookies("shoppingbag")("before_issuccess") = "true"
else
	response.Cookies("shoppingbag")("before_issuccess") = "false"
end if

dim dumi : dumi=TenOrderSerialHash(iorderserial)

''비회원인 경우 orderserial-uk 값 저장. 2017/10/23 require commlib
IF (iorderParams.IsSuccess) and (userid="") then
    Call fnUserLogCheck_AddGuestOrderserial_UK(iorderserial,request.Cookies("shoppingbag")("GSSN")) 
end if

set iorderParams = Nothing
set oMileage = Nothing
set oshoppingbag = Nothing
set oGiftCard = Nothing
set oTenCash = Nothing

'' 주문 결과 페이지로 이동
''SSL 경우 스크립트로 replace
response.write "<script language='javascript'>location.replace('" & wwwUrl & "/inipay/displayorder.asp?dumi="&dumi&"');</script>"
'response.redirect wwwUrl&"/inipay/displayorder.asp"
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->