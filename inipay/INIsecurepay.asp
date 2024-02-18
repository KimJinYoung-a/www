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
iorderParams.Faccountdiv        = request.Form("Tn_paymethod")
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
iorderParams.Freqname           = Trim(LeftB((request.Form("reqname")),30))
'iorderParams.Freqzipcode        = request.Form("txZip1") + "-" + request.Form("txZip2")
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
iorderParams.Fspendgiftmoney      = request.Form("spendgiftmoney")
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

''퀵배송 추가 ================= 2018/01/09
if (request.Form("quickdlv")="QQ") then
    iorderParams.FcountryCode = "QQ"
end if
''개인통관부호================= 2018/01/09
iorderParams.FUnipassNum = requestCheckVar(request("customNumber"),13)    ''' 개인통관부호
''==========================================================================================

dim checkitemcouponlist
dim Tn_paymethod, packtype, gopaymethod

checkitemcouponlist = request.Form("checkitemcouponlist")
if (Right(checkitemcouponlist,1)=",") then checkitemcouponlist=Left(checkitemcouponlist,Len(checkitemcouponlist)-1)
Tn_paymethod        = request.Form("Tn_paymethod")
packtype            = request.Form("packtype")
gopaymethod         = request.Form("gopaymethod")

''휴대폰 결제. Tn_paymethod 가 다른것으로 되는 CASE 있음? 2015/05/21 
if (gopaymethod="HPP") then
    if (Tn_paymethod<>"400") then 
        Tn_paymethod = "400" 
        iorderParams.Faccountdiv = "400"
    end if
end if

''2018/04/17 HanaTenCard
Dim IsHanaTenDiscount : IsHanaTenDiscount = False
Dim ooprice : ooprice = request.Form("ooprice")
if (Tn_paymethod = "190") then 
    iorderParams.Faccountdiv = "100"
    iorderParams.FDiscountRate = 0.95
    IsHanaTenDiscount = true
end if

''결제창이후에 잘못클릭되는 CASE ? //2018/04/20
if (Tn_paymethod = "900") or (Tn_paymethod = "950") or (Tn_paymethod = "7") then
    iorderParams.Faccountdiv = "100"
end if

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

if (Not isNumeric(ooprice)) or (ooprice="") then ooprice=0

'On Error resume Next
dim sqlStr

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

''2013/04/17 추가 (get방식으로 날라올경우?)
if (subtotalprice="") then
    response.write "<script>alert('장바구니 금액 오류 - 다시계산해 주세요..')</script>"
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
	oShoppingBag.Fdiscountrate = iorderParams.FDiscountRate          ''2018/04/18
	
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
        'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','쿠폰 금액오류(ini) ::"&iorderParams.Freferip&"::"&iorderParams.Fcouponid&":"&mayBCpnDiscountPrc&"::"&iorderParams.Fcouponmoney&"'"
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

''2018/04/18
if (IsHanaTenDiscount) then
    if (oshoppingbag.FAssignedBonusCouponType="3") then  ''배송비쿠폰할인은 까지 말자.
        iorderParams.FallatDiscountprice = oshoppingbag.AssignHanaDiscountTotalPrice(CLng(ooprice),CLNG(oshoppingbag.getTotalCouponAssignPrice(""))-CLNG(oshoppingbag.GetTotalBeasongPrice))
    else
        iorderParams.FallatDiscountprice = oshoppingbag.AssignHanaDiscountTotalPrice(CLng(ooprice),CLNG(oshoppingbag.getTotalCouponAssignPrice(""))-iorderParams.Fcouponmoney-CLNG(oshoppingbag.GetTotalBeasongPrice))
    end if
    
    if ABS(iorderParams.FallatDiscountprice-(CLng(ooprice)-CLng(subtotalprice)))>0 then
        'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','hana카드할인오류 ini ::"&iorderParams.Freferip&"::"&iorderParams.FallatDiscountprice&"::"&(CLng(ooprice)-CLng(subtotalprice))&"'"
	    'dbget.Execute sqlStr
	    
	    response.write "<script>alert('장바구니 금액 오류 - 다시계산해 주세요')</script>"
	    response.write "<script>location.replace('" & wwwUrl & "/inipay/shoppingbag.asp')</script>"
	    response.end
    end if
end if

'''금액일치확인 ***
if (CLng(oshoppingbag.getTotalCouponAssignPrice(packtype) + iorderParams.fpojangcash -iorderParams.Fmiletotalprice-iorderParams.Fcouponmoney-iorderParams.FallatDiscountprice-iorderParams.Fspendtencash-iorderParams.Fspendgiftmoney) <> CLng(subtotalprice)) then
    'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','장바구니 금액 오류 ini ::"&iorderParams.Freferip&"::"&oshoppingbag.getTotalCouponAssignPrice(packtype) + iorderParams.fpojangcash &"::"&iorderParams.Fmiletotalprice&"::"&iorderParams.Fcouponmoney&"::"&iorderParams.FallatDiscountprice&"::"&iorderParams.Fspendtencash&"::"&iorderParams.Fspendgiftmoney&"::"&subtotalprice&"'"
	'dbget.Execute sqlStr

	response.write "<script>alert('장바구니 금액 오류 - 다시계산해 주세요')</script>"
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

	'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110,'1644-6030','주문오류 :" + iorderserial +":"+ replace(iErrStr,"'","") + "'"
	'dbget.Execute sqlStr

	response.end
end if

'On Error Goto 0

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
if (Tn_paymethod="20") and (Rcash_rslt="0000") then
    AuthCode = ResultCashNoAppl
end if

''휴대폰 결제. 실결제 번호 2015/04/21 
if (PayMethod="HPP") then
    AuthCode = INIpay.GetResult(CLng(PInst), "nohpp")  ''버전별로 다름.
end if

''OKCashBag 관련
if (Tn_paymethod="110") then
    iorderParams.FOKCashbagSpend = 0

    if IsNumeric(Price2) then
        if (Price2<>0) then
            iorderParams.FOKCashbagSpend = Price2
            iorderParams.FOKCashbagUseAuthCode = OCBUseAuthCode
            iorderParams.FOKCashbagAuthDate = OCBAuthDate
        end if
    end if
    'response.write "Price1="&Price1              'OK Cashbag 복합결재시 신용카드 지불금액
    'response.write "Price2="&Price2              'OK Cashbag 복합결재시 포인트 지불금액
    'response.write "OCBSaveAuthCode="&OCBSaveAuthCode     'OK Cashbag 적립 승인번호
    'response.write "OCBUseAuthCode="&OCBUseAuthCode      'OK Cashbag 사용 승인번호
    'response.write "OCBAuthDate="&OCBAuthDate         'OK Cashbag 승인일시
end if

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

dim i_Resultmsg
i_Resultmsg = replace(ResultMsg,"|","_")

iorderParams.Fresultmsg  = i_Resultmsg
iorderParams.Fauthcode = AuthCode
iorderParams.Fpaygatetid = Tid
iorderParams.IsSuccess = (ResultCode = "00")

''2011-04-27 추가(부분취소시 필요항목)
IF (Tn_paymethod="20") Then
    iorderParams.FPayEtcResult = LEFT(DirectBankCode,16)
ELSe
    iorderParams.FPayEtcResult = LEFT(CardCode&"|"&CardIssuerCode&"|"&CardQuota&"|"&PrtcCode,16)
END IF

Call oshoppingbag.SaveOrderResultDB(iorderParams, iErrStr)

if (iErrStr<>"") then
    response.write iErrStr
    response.write "<script language='javascript'>alert('작업중 오류가 발생하였습니다. 고객센터로 문의해 주세요.: \n\n: 오류 -" & replace(iErrStr,"'","") & "');</script>"
    response.end
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
    	'response.write "<script>javascript:history.back();</script>"
		response.end
	end if

Set INIpay = Nothing

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

'' ================ 현금 영수증 신청 추가 =============================
'' 입금 확인시 또는 야간 배치 발행 :: 실시간 이체건도 배치로 발행 (이니시스 팝업창에서 발행 안함)
''On Error resume Next
dim cashreceiptreq, useopt, cashReceipt_ssn
dim cr_price, sup_price, tax, srvc_price, reg_num

cashreceiptreq     = request.Form("cashreceiptreq2")
useopt             = request.Form("useopt2")
cashReceipt_ssn    = request.Form("cashReceipt_ssn2")
reg_num = cashReceipt_ssn

cr_price    = CLng(subtotalprice) + CLng(iorderParams.Fspendtencash) + CLng(iorderParams.Fspendgiftmoney)   '''예치금 사용내역 추가..
sup_price   = CLng(cr_price*10/11)
tax         = cr_price - sup_price
srvc_price  = 0

if (iorderParams.IsSuccess) and (Tn_paymethod="20") and (cashreceiptreq="Y") then
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
    sqlStr = sqlStr + " ,'" & html2db(goodname) & "'"
    sqlStr = sqlStr + " ," & CStr(cr_price) & ""
    sqlStr = sqlStr + " ," & CStr(sup_price) & ""
    sqlStr = sqlStr + " ," & CStr(tax) & ""
    sqlStr = sqlStr + " ," & CStr(srvc_price) & ""
    sqlStr = sqlStr + " ,'" & iorderParams.Fbuyname & "'"
    sqlStr = sqlStr + " ,'" & iorderParams.Fbuyemail & "'"
    sqlStr = sqlStr + " ,'" & iorderParams.Fbuyhp & "'"
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
set oTenCash = Nothing
set oGiftCard = Nothing
set oshoppingbag = Nothing

'' 주문 결과 페이지로 이동
''SSL 경우 스크립트로 replace
'response.write "<script language='javascript'>location.replace('" & wwwUrl & "/inipay/displayorder.asp?dumi="&dumi&"');</script>"
'response.redirect wwwUrl&"/inipay/displayorder.asp"
%>

<!-- #include virtual="/lib/db/dbclose.asp" -->


<script language="javascript">
    setTimeout(function(){
        try{
            location.replace("<%=wwwUrl%>/inipay/displayorder.asp?dumi=<%=dumi%>");
        }catch(ss){
            location.href="/inipay/displayorder.asp?dumi=<%=dumi%>";
        }
    },300);
</script>
