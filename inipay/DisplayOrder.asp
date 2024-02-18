<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/inc/incForceSSL.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" --> 
<!-- #include virtual="/lib/classes/shopping/sp_itemcouponcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_couponcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/apps/nateon/lib/nateon_alarmClass.asp"-->
<!-- #INCLUDE Virtual="/apps/kakaotalk/lib/kakaotalk_sendFunc.asp" -->
<!-- #include virtual="/lib/classes/ordercls/frontGiftCls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<%
strPageTitle = "텐바이텐 10X10 : 주문완료"		'페이지 타이틀 (필수)

'' 사이트 구분
Const sitename = "10x10"


Dim isEvtGiftDisplay : isEvtGiftDisplay = TRUE
Dim isBaguniUserLoginOK

'' RecoPick에 보낼 ItemId값
Dim RecoPickSendItemId : RecoPickSendItemId = ""

'' RecoBell에 보낼 값
Dim RecoBellSendValue : RecoBellSendValue = ""
Dim RecoBellSendValue2 : RecoBellSendValue2 = ""

dim userid,guestSessionID, userlevel
dim orderserial, IsSuccess, vIsDeliveItemExist

userid          = GetLoginUserID
userlevel       = GetLoginUserLevel
guestSessionID  = GetGuestSessionKey

isBaguniUserLoginOK = (userid<>"")

orderserial = request.cookies("shoppingbag")("before_orderserial")
IsSuccess   = request.cookies("shoppingbag")("before_issuccess")

'' cookie is String
if LCase(CStr(IsSuccess))="true" then
    IsSuccess=true
else
    IsSuccess = false
end if

''쿠키 체크 2015/07/15============
if (TenOrderSerialHash(orderserial)<>request("dumi")) then
    ''raize Err
    ''Dim iRaizeERR : SET iRaizeERR= new iRaizeERR  ''초기 에러 발생시킴(관리자확인)
    IsSuccess = false  
    
    if (orderserial<>"") then
        Dim sqlStr 
		'sqlStr = " exec [db_sms].[dbo].[usp_SendSMS] '010-6324-9110','1644-6030','param(w) :"&orderserial&":"&request("dumi")&"::"&TenOrderSerialHash(orderserial)&"'"
    	'dbget.Execute sqlStr
    end if
end if
''''===================================

'''테섭용==============================
IF (application("Svr_Info")="Dev") then
    IF (request("osi")<>"") then
        orderserial = request("osi")
        IsSuccess = true
    end if
End IF
''''===================================

dim myorder
set myorder = new CMyOrder
myorder.FRectOrderserial = orderserial
myorder.GetOneOrder

dim myorderdetail
set myorderdetail = new CMyOrder
	myorderdetail.FRectOrderserial = orderserial
	myorderdetail.FRectUserID = userid
	myorderdetail.GetOrderResultDetail

dim vIsPojangcompleteExists, pojangcash, pojangcnt
	vIsPojangcompleteExists=FALSE
	pojangcash=0
	pojangcnt=0

dim opackmaster

'선물포장서비스 노출		'/2015.11.11 한용민 생성
if G_IsPojangok then
	IF myorderdetail.FResultCount>0 then
		for i=0 to myorderdetail.FResultCount - 1
			'/선물포장비 있을경우
			If myorderdetail.FItemList(i).FItemid = 100 Then
				'/선물포장완료상품존재
				vIsPojangcompleteExists=TRUE
				pojangcash = pojangcash + myorderdetail.FItemList(i).FItemCost * myorderdetail.FItemList(i).Fitemno		'/포장비
				pojangcnt = pojangcnt + myorderdetail.FItemList(i).Fitemno		'/포장박스갯수
			end if
		next
	end if

	'/선물포장완료상품존재
	if vIsPojangcompleteExists then
		set opackmaster = new Cpack
			opackmaster.FRectUserID = userid
			opackmaster.FRectSessionID = guestSessionID
			opackmaster.FRectOrderSerial = orderserial
			opackmaster.FRectCancelyn = "N"
			opackmaster.FRectSort = "DESC"

			if orderserial<>"" and userid<>"" then
				opackmaster.Getpojang_master()
			end if
	end if
end if

''dim oSubPayment
''set oSubPayment = new CMyOrder
''oSubPayment.FRectOrderserial = orderserial
''oSubPayment.getSubPaymentList

dim oSailCoupon
set oSailCoupon = new CCoupon
oSailCoupon.FRectUserID = userid
oSailCoupon.FPageSize=100

if (userid<>"") then
	oSailCoupon.getValidCouponList
end if

dim oItemCoupon
set oItemCoupon = new CUserItemCoupon
oItemCoupon.FRectUserID = userid
oItemCoupon.FPageSize=100

if (userid<>"") then
	oItemCoupon.getValidCouponList
end if

dim oshoppingbag
set oshoppingbag = new CShoppingBag
oshoppingbag.FRectUserID = userid
oshoppingbag.FRectSessionID = guestSessionID
oShoppingBag.FRectSiteName  = sitename

dim oMileage, availtotalMile
set oMileage = new TenPoint
oMileage.FRectUserID = userid
if (userid<>"") then
    oMileage.getTotalMileage

    availtotalMile = oMileage.FTotalMileage
end if

if availtotalMile<1 then availtotalMile=0

''예치금 추가
Dim oTenCash, availtotalTenCash
availtotalTenCash = 0
set oTenCash = new CTenCash
oTenCash.FRectUserID = userid
if (userid<>"") then
    oTenCash.getUserCurrentTenCash

    availtotalTenCash = oTenCash.Fcurrentdeposit
end if

'' GiftCard
Dim oGiftCard, availTotalGiftMoney
availTotalGiftMoney = 0
set oGiftCard = new myGiftCard
oGiftCard.FRectUserID = userid
if (userid<>"") then
    availTotalGiftMoney = oGiftCard.myGiftCardCurrentCash
end if

if (userid<>"") then
    ''쿠폰 갯수/ 마일리지 쿠키 재 세팅
    Call SetLoginCouponCount(oSailCoupon.FTotalCount + oItemCoupon.FTotalCount)
    Call SetLoginCurrentMileage(availtotalMile)
    ''2013추가
    Call SetLoginCurrentTenCash(availtotalTenCash)
    Call SetLoginCurrentTenGiftCard(availTotalGiftMoney)
end if

''구매금액별 선택 사은품
Dim oOpenGift
Set oOpenGift = new CopenGift
oOpenGift.FRectOrderserial = orderserial

if (IsSuccess) and (userid<>"") then
	if (isEvtGiftDisplay) then
		oOpenGift.getGiftListInOrder
	else
	    oOpenGift.getOpenGiftInOrder
	end if
end if

'''비회원 주문 / 현장수령 주문인경우
''if (IsSuccess) and (userid="") then
''    if (myorder.FOneItem.IsReceiveSiteOrder) then
''        ''비회원 로그인.
''        session("userid") = ""
''        session("userdiv") = ""
''        session("userlevel") = ""
''        session("userorderserial") = orderserial
''        session("username") = myorder.FOneItem.Fbuyname
''        session("useremail") = myorder.FOneItem.Fbuyemail
''    end if
''end if

'// 티켓상품정보 접수
if myorder.FOneItem.IsTicketOrder then
	IF myorderdetail.FResultCount>0 then
    	Dim oticketItem, TicketDlvType, ticketPlaceName, ticketPlaceIdx

		Set oticketItem = new CTicketItem
		oticketItem.FRectItemID = myorderdetail.FItemList(0).FItemID
		oticketItem.GetOneTicketItem
		TicketDlvType = oticketItem.FOneItem.FticketDlvType			'티켓수령방법
		ticketPlaceName = oticketItem.FOneItem.FticketPlaceName		'공연장소
		ticketPlaceIdx = oticketItem.FOneItem.FticketPlaceIdx		'약도일련번호
		Set oticketItem = Nothing
	end if
end if

dim i,j
dim CheckRequireDetailMsg
CheckRequireDetailMsg = false

'레코픽/네이버 스크립트 tailer에서 출력	2013-01-24 김진영 추가, 2013-09-09 허진원 네이버 추가
Dim r, rcpItem

Dim add_EXTSCRIPT '' ELK 추가 스크립트
Dim ingItems, ingCpns, ibuf_bcpnCode, ibuf_IcpnCode, ibuf_IcpnCodeArr
Dim add_FcItemIdScript '// 구글 픽셀 스크립트 상품코드용 추가 2016.09.22 원승현
Dim CresendoScriptItemName '// 크레센도 결제완료 데이타 전송용 상품명 2016.11.30 원승현
Dim CresendoScriptItemPrice '// 크레센도 결제완료 데이타 전송용 상품금액 2016.11.30 원승현
Dim CriteoScriptAdsItem	'// 크리테오 스크립트용

if (IsSuccess) then
    if (myorder.FResultCount>0) then
        If myorderdetail.FResultCount > 0 Then
        	For r = 0 to myorderdetail.FResultCount - 1

				'recoPick용
				'레코픽 서비스 종료에 따른 제거(150630 원승현)
				'rcpItem = rcpItem & chkIIF(rcpItem="","",", ") & "{id: '" & myorderdetail.FItemList(r).FItemID & "', count: " & myorderdetail.FItemList(r).FItemNo & "}"

        	Next
        End If

		'RecoPick 스크립트 incFooter.asp에서 출력; 2013.12.05 허진원 추가
		'레코픽 서비스 종료에 따른 제거 (150630 원승현)
		'RecoPickSCRIPT = "	recoPick('sendLog', 'order', " & rcpItem & ");"


		add_FcItemIdScript = ""
		For r = 0 to myorderdetail.FResultCount - 1
			add_FcItemIdScript = add_FcItemIdScript&",'"&myorderdetail.FItemList(r).FItemID&"'"
		Next
		If Trim(add_FcItemIdScript) <> "" Then
			add_FcItemIdScript = Right(add_FcItemIdScript, Len(add_FcItemIdScript)-1)
		End If

		'// 구글 ADS 스크립트 관련(2017.05.29 원승현 추가)
		Dim ADSItem
		For r = 0 to myorderdetail.FResultCount - 1
			ADSItem = ADSItem &"'"&myorderdetail.FItemList(r).FItemID&"',"
		Next
		If ADSItem <> "" Then
			If myorderdetail.FResultCount > 1 Then
				ADSItem = "["&Left(ADSItem, Len(ADSItem)-1)&"]"
			Else
				ADSItem = Left(ADSItem, Len(ADSItem)-1)
			End If
		End If

		'페이스북 스크립트 incFooter.asp에서 출력; 2014.06.12 허진원 추가
		'신규 코드; 2015.12.08 허진원(2016.09.22 원승현 수정)
		facebookSCRIPT = "<script>" & vbCrLf &_
						"!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;" & vbCrLf &_
						"n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;" & vbCrLf &_
						"t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,document,'script','//connect.facebook.net/en_US/fbevents.js');" & vbCrLf &_
						"fbq('init', '260149955247995');" & vbCrLf &_
						"fbq('init', '889484974415237');" & vbCrLf &_
						"fbq('track','PageView');" & vbCrLf &_
						"fbq('track', 'Purchase', {value: '"&myorder.FOneItem.FsubtotalPrice&"', currency: 'KRW', content_ids:["&add_FcItemIdScript&"], content_type:'product'});</script>" & vbCrLf &_
						"<noscript><img height=""1"" width=""1"" style=""display:none"" src=""https://www.facebook.com/tr?id=260149955247995&ev=PageView&noscript=1"" /></noscript>" & vbCrLf &_
						"<noscript><img height=""1"" width=""1"" style=""display:none"" src=""https://www.facebook.com/tr?id=889484974415237&ev=PageView&noscript=1"" /></noscript>"												

		'// 크레센도 스크립트용 displayorder에서만 출력 2016.11.30 원승현
		If (isSuccess) Then
			CresendoScriptItemName = ""
			CresendoScriptItemPrice = ""
			If myorderdetail.FResultCount > 0 Then
		    	For r = 0 to myorderdetail.FResultCount - 1
					CresendoScriptItemName = CresendoScriptItemName&"|"&Replace(replace(myorderdetail.FItemList(r).FItemName,"'",""), "|","")
					CresendoScriptItemPrice = CresendoScriptItemPrice&"|"&myorderdetail.FItemList(r).FItemCost
		    	Next
			End If

			CresendoScriptItemName = Right(CresendoScriptItemName, Len(CresendoScriptItemName)-1)
			CresendoScriptItemPrice = Right(CresendoScriptItemPrice, Len(CresendoScriptItemPrice)-1)

		End If

		'// 에코마케팅용 레코벨 스크립트(2016.12.21) displayorder에서만 출력
		If (isSuccess) Then
			RecoBellSendValue = ""
			If myorderdetail.FResultCount > 0 Then
		    	For r = 0 to myorderdetail.FResultCount - 1
					RecoBellSendValue = RecoBellSendValue&"_rblq.push(['addVar', 'orderItems', {itemId:'"&myorderdetail.FItemList(r).FItemID&"', price:'"&myorderdetail.FItemList(r).FItemCost*myorderdetail.FItemList(r).FItemNo&"', quantity:'"&myorderdetail.FItemList(r).FItemNo&"'}]);"
		    	Next
			End If
		End If

		'// 앱보이 결제로그 전송
		If (isSuccess) Then
			appBoy_ADDPurchases = ""
			If myorderdetail.FresultCount > 0 Then
				For r = 0 To myorderdetail.FResultCount - 1
					appBoy_ADDPurchases = appBoy_ADDPurchases & "appboy.logPurchase('"&myorderdetail.FItemList(r).FItemID&"', "&myorderdetail.FItemList(r).FItemCost*myorderdetail.FItemList(r).FItemNo&", 'KRW', "&myorderdetail.FItemList(r).FItemNo&", {orderserial: '"&orderserial&"'});"
				Next
			End If
		End If

		'// Kakao Analytics
		If (isSuccess) Then
			kakaoAnal_AddScript = "kakaoPixel('6348634682977072419').purchase({"
			kakaoAnal_AddScript = kakaoAnal_AddScript&"total_price:'"&myorder.FOneItem.FsubtotalPrice&"',"
			kakaoAnal_AddScript = kakaoAnal_AddScript&"currency:'KRW',"
			kakaoAnal_AddScript = kakaoAnal_AddScript&"products:["
			For r = 0 To myorderdetail.FResultCount - 1
				kakaoAnal_AddScript = kakaoAnal_AddScript&"{name:'"&myorderdetail.FItemList(r).FItemID&"', quantity:'"&myorderdetail.FItemList(r).FItemNo&"', price:'"&myorderdetail.FItemList(r).FItemCost*myorderdetail.FItemList(r).FItemNo&"'},"
			Next
			kakaoAnal_AddScript = Left(kakaoAnal_AddScript, Len(kakaoAnal_AddScript)-1)
			kakaoAnal_AddScript = kakaoAnal_AddScript&"]});"
		End If

		''네이버 웹로그 스크립트 생성 (cnv - 1:구매완료, 2:회원가입)
		NaverSCRIPT = "<script type='text/javascript'> " & vbCrLf &_
			"var _nasa={};" & vbCrLf &_
			"_nasa['cnv'] = wcs.cnv('1','" & myorder.FOneItem.FsubtotalPrice & "');" & vbCrLf &_
			"</script>"

		''다음 구매로그 스크립트 생성; 2015.08.05 허진원 추가
		DaumSCRIPT = "<script type=""text/javascript"">" & vbCrLf &_
			"//<![CDATA[" & vbCrLf &_
			"var DaumConversionDctSv=""type=P,orderID='"&orderserial&"',amount='"&myorder.FOneItem.FsubtotalPrice&"'"";" & vbCrLf &_
			"var DaumConversionAccountID=""7mD4DqS5ilDMtl4e6Sc7kg00"";" & vbCrLf &_
			"if(typeof DaumConversionScriptLoaded==""undefined""&&location.protocol!=""file:""){" & vbCrLf &_
			"      var DaumConversionScriptLoaded=true;" & vbCrLf &_
			"      document.write(unescape(""%3Cscript%20type%3D%22text/javas""+""cript%22%20src%3D%22""+(location.protocol==""https:""?""https"":""http"")+""%3A//t1.daumcdn.net/cssjs/common/cts/vr200/dcts.js%22%3E%3C/script%3E""));" & vbCrLf &_
			"}" & vbCrLf &_
			"//]]>" & vbCrLf &_
			"</script>"

		'' 구글 어낼리틱스
	    googleANAL_ADDSCRIPT = "_gaq.push(['_addTrans','"&orderserial&"','www','"&myorder.FOneItem.FsubtotalPrice&"','','','','','']);" & VbCrlf
        googleANAL_ADDSCRIPT = googleANAL_ADDSCRIPT & "_gaq.push(['_trackTrans']);"

		'// 구글 ADS 스크립트 관련(2017.05.29 원승현 추가)
		googleADSCRIPT = " <script> "
		googleADSCRIPT = googleADSCRIPT & "   gtag('event', 'page_view', { "
		googleADSCRIPT = googleADSCRIPT & "     'send_to': 'AW-851282978', "
		googleADSCRIPT = googleADSCRIPT & "     'ecomm_pagetype': 'product', "
		googleADSCRIPT = googleADSCRIPT & "     'ecomm_prodid': "&ADSItem&", "
		googleADSCRIPT = googleADSCRIPT & "     'ecomm_totalvalue': "&myorder.FOneItem.FsubtotalPrice&" "
		googleADSCRIPT = googleADSCRIPT & "   }); "
		googleADSCRIPT = googleADSCRIPT & " </script> "

		googleADSCRIPT = googleADSCRIPT & "	<script> "
		googleADSCRIPT = googleADSCRIPT & "	gtag('event', 'conversion', { "
		googleADSCRIPT = googleADSCRIPT & "	'send_to': 'AW-851282978/jBMcCJ2UtqkBEKKY9pUD', "
		googleADSCRIPT = googleADSCRIPT & "	'value': "&myorder.FOneItem.FTotalSum&", "
		googleADSCRIPT = googleADSCRIPT & "	'currency': 'KRW', "
		googleADSCRIPT = googleADSCRIPT & "	'transaction_id': '' "
		googleADSCRIPT = googleADSCRIPT & "	}); "
		googleADSCRIPT = googleADSCRIPT & "	</script> "
    end if
end if
'크리테오 스크립트 tailer에서 출력 끝

if (IsSuccess) Then ''추가//2016/03/30
    '// 구글 애널리틱스 관련 값 셋팅 incFooter.asp 에서 출력 2015.07.22 원승현 추가
    If myorderdetail.FResultCount > 0 Then
    	googleANAL_EXTSCRIPT = "   ga('require', 'ecommerce', 'ecommerce.js'); "
    	googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " ga('ecommerce:addTransaction', { "
    	googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " 'id' : '"&orderserial&"', "
    	googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " 'affiliation' : '', "
    	googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " 'revenue' : '"&myorder.FOneItem.FTotalSum-myorder.FOneItem.FDeliverPrice&"', "
    	googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " 'shipping' : '"&myorder.FOneItem.FDeliverPrice&"' "
    	googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " }); "

    	For r = 0 to myorderdetail.FResultCount - 1
    		googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " ga('ecommerce:addItem', { "
    		googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " 'id' : '"&orderserial&"', "
    		googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " 'name' : '"&replace(myorderdetail.FItemList(r).FItemName,"'","")&"', "
    		googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " 'sku' : '"&myorderdetail.FItemList(r).FItemID&"', "
    		googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " 'category' : '', "
    		googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " 'price' : '"&myorderdetail.FItemList(r).FItemCost*myorderdetail.FItemList(r).FItemNo&"', "
    		googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " 'quantity' : '"&myorderdetail.FItemList(r).FItemNo&"' "
    		googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " }); "

    		add_EXTSCRIPT = add_EXTSCRIPT&myorderdetail.FItemList(r).FItemID&","     ''2016/03/30 추가
    	Next
		googleANAL_EXTSCRIPT = googleANAL_EXTSCRIPT & " ga('ecommerce:send'); "
    	
    	if (add_EXTSCRIPT<>"") then                                                 ''2016/03/30 추가
    	    add_EXTSCRIPT = "tp=ofin&dumi="&request("dumi")&"&itemids="&add_EXTSCRIPT
    	    if (Right(add_EXTSCRIPT,1)=",") then add_EXTSCRIPT=Left(add_EXTSCRIPT,LEN(add_EXTSCRIPT)-1)
    	end if
    End If
end if
'//아리따움 이벤트
dim artidx
dim isAritaumItem
isAritaumItem = false

If Now() > #09/01/2018 00:00:00# AND Now() < #09/30/2018 23:59:59# Then 
	if myorderdetail.FResultCount > 0 then	
		For artidx = 0 to myorderdetail.FResultCount - 1			
			if myorderdetail.FItemList(artidx).FItemID =2075053 or myorderdetail.FItemList(artidx).FItemID =2075052 or myorderdetail.FItemList(artidx).FItemID =2075051 or myorderdetail.FItemList(artidx).FItemID =2075050 or myorderdetail.FItemList(artidx).FItemID =2075019 or myorderdetail.FItemList(artidx).FItemID =2075018 or myorderdetail.FItemList(artidx).FItemID =2075016 or myorderdetail.FItemList(artidx).FItemID =2074968 or myorderdetail.FItemList(artidx).FItemID =2074965 or myorderdetail.FItemList(artidx).FItemID =2074962 or myorderdetail.FItemList(artidx).FItemID =2074914 or myorderdetail.FItemList(artidx).FItemID =2074907 or myorderdetail.FItemList(artidx).FItemID =2074859 or myorderdetail.FItemList(artidx).FItemID =2074737 then
				isAritaumItem = true
				exit for
			end if			
		Next
	end if
end if	
'//아리따움 이벤트	

'// 배송비 부담 로그
If (isSuccess) Then
	For r = 0 To myorderdetail.FResultCount - 1
		If Trim(userid)="" Then
			Call fnHalfDeliveryLog(orderserial, GetGuestSessionKey, myorderdetail.FItemList(r).FItemID, myorder.FOneItem.FRegDate, myorderdetail.FItemList(r).FItemCost, myorder.FOneItem.FDeliverPrice)	
		Else
			Call fnHalfDeliveryLog(orderserial, userid, myorderdetail.FItemList(r).FItemID, myorder.FOneItem.FRegDate, myorderdetail.FItemList(r).FItemCost, myorder.FOneItem.FDeliverPrice)	
		End If
	Next
End If

'// 이니렌탈 월 납입금액, 렌탈 개월 수 가져오기
dim iniRentalInfoData, tmpRentalInfoData, iniRentalMonthLength, iniRentalMonthPrice
DIM bonuscouponidx
If (isSuccess) Then
	iniRentalInfoData = fnGetIniRentalOrderInfo(orderserial)
	If instr(lcase(iniRentalInfoData),"|") > 0 Then
		tmpRentalInfoData = split(iniRentalInfoData,"|")
		iniRentalMonthLength = tmpRentalInfoData(0)
		iniRentalMonthPrice = tmpRentalInfoData(1)
	Else
		iniRentalMonthLength = ""
		iniRentalMonthPrice = ""
	End If

	'//보너스쿠폰 번호 가져오기
    bonuscouponidx = fnGetBonuscouponidx(orderserial)
End If

'// Criteo Script
If (isSuccess) Then
	'//크리테오에 보낼 md5 유저 이메일값
	If Trim(session("ssnuseremail")) <> "" Then
		CriteoUserMailMD5 = MD5(Trim(session("ssnuseremail")))
	Else
		CriteoUserMailMD5 = ""
	End If
	For r = 0 To myorderdetail.FResultCount - 1
		CriteoScriptAdsItem = CriteoScriptAdsItem&"{id:'"&myorderdetail.FItemList(r).FItemID&"', price:"&myorderdetail.FItemList(r).FItemCost&", quantity:"&myorderdetail.FItemList(r).FItemNo&"},"
	Next
	CriteoScriptAdsItem = Left(CriteoScriptAdsItem, Len(CriteoScriptAdsItem)-1)
End If
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" >
    let appier_shipping_type_data = "";
    let appier_purchase_gift_code = "";

    $(document).unbind("dblclick");

    function popPrint(){
        var openwin = window.open('','orderreceipt','width=920,height=700,scrollbars=yes,resizable=yes');
        openwin.focus();
        document.frmprt.target = "orderreceipt";
        document.frmprt.action = "/my10x10/order/myorder_receipt.asp";
        document.frmprt.submit();
    }

    function popTicketPlace(iplaceIdx){
        var popwin = window.open('/my10x10/popTicketPLace.asp?placeIdx='+iplaceIdx,'popTicketPlace','width=750,height=700,scrollbars=yes,resizable=yes');
        popwin.focus();
    }

    function popRsvSiteOrder(){
        popPrint();
    }

    $(function() {
        <% if (IsSuccess) Then %>
            <% if session("amplitudeorderserialcheck") <> orderserial then %>
                let gifts = new Array();
                <% If myorderdetail.FResultCount > 0 Then %>
                    <% For r = 0 to myorderdetail.FResultCount - 1 %>
                        gifts = new Array();
                        <% if (oOpenGift.FResultCount>0) then %>
                            <% for j=0 to oOpenGift.FREsultCount-1 %>
                                gifts.push('"<%= oOpenGift.FItemList(j).Fchg_giftStr %>"');
                            <% next %>
                        <% end if %>

                        var amprevenue = new amplitude.Revenue().setProductId('<%=myorderdetail.FItemList(r).FItemID%>').setPrice(<%=myorderdetail.FItemList(r).FItemCost*myorderdetail.FItemList(r).FItemNo%>).setQuantity(<%=myorderdetail.FItemList(r).FItemNo%>).setEventProperties(JSON.parse('{"categoryname" : "<%=fnItemIdToCategory1DepthName(myorderdetail.FItemList(r).FItemID)%>", "brand_name" : "<%=fnItemIdToBrandName(myorderdetail.FItemList(r).FItemID)%>", "payment_type" : "<%=myorder.FOneItem.GetAccountdivName%>", "orderserial" : "<%=orderserial%>", "keywords" : ["<%=Replace(myorderdetail.FItemList(r).FKeywords,",",""",""")%>"], "gift" : ['+gifts+']}'));
                        amplitude.getInstance().logRevenueV2(amprevenue);

                        appier_shipping_type_data += ",<%=myorderdetail.FItemList(r).getDeliveryTypeName%>";
                    <% next %>
                <% end if %>
                <% '// Amplitude 체크용 session %>
                <% session("amplitudeorderserialcheck") = orderserial %>
            <% end if %>
        <% end if %>

        <% if (IsSuccess) Then %>
            <% if session("branchorderserialcheck") <> orderserial then %>
                <% If myorderdetail.FResultCount > 0 Then %>
                    <%'// Branch Init %>
                    <% if application("Svr_Info")="staging" Then %>
                        branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
                    <% elseIf application("Svr_Info")="Dev" Then %>
                        branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
                    <% else %>
                        branch.init('key_live_hpOucoij2aQek0GdzW9xFddbvukaW6le');
                    <% end if %>
                    var branchPurchaseData = {
                        "transaction_id" : "<%=orderserial%>",
                        "currency" : "KRW",
                        "revenue" : <%=myorder.FOneItem.FsubtotalPrice%>,
                        "shipping" : <%=myorder.FOneItem.FDeliverPrice%>
                    };
                    var branchPurchaseItemsData = [
                        <% For r = 0 to myorderdetail.FResultCount - 1 %>
                            {
                                "$price" : <%=myorderdetail.FItemList(r).FItemCost*myorderdetail.FItemList(r).FItemNo%>,
                                "$product_name" : "<%=Server.URLEncode(replace(myorderdetail.FItemList(r).FItemName,"'",""))%>",
                                "$sku" : "<%=myorderdetail.FItemList(r).FItemID%>",
                                "$quantity" : <%=myorderdetail.FItemList(r).FItemNo%>,
                                "category" : "<%=Server.URLEncode(fnItemIdToCategory1DepthName(myorderdetail.FItemList(r).FItemID))%>"
                            }
                            <%=chkIIF(r < myorderdetail.FResultCount-1,",","")%>
                        <% next %>
                    ];
                    branch.logEvent(
                        "PURCHASE",
                        branchPurchaseData,
                        branchPurchaseItemsData,
                        function(err) { console.log(err); }
                    );
                <% end if %>
                <% '// Branch 체크용 session %>
                <% session("branchorderserialcheck") = orderserial %>
            <% end if %>
        <% end if %>

    });
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="cartWrap orderWrap">
				<!-- 88637아리따움 프로모션 상품 배너 -->
				<% if isAritaumItem then %>
				<style>
				.cartWrap {position:relative;}
				.aritaum-promotion {position:absolute; top:0; left:0; width:1140px; height:956px;}
				.aritaum-promotion p {position:relative; top:278px; left:50%; z-index:5; margin-left:-256px;}
				.aritaum-promotion:before {position:absolute; top:153px; left:0; z-index:3; width:100%; height:100%; background-color:rgba(0,0,0,.7); content:' '}
				.aritaum-promotion .btn-close {position:absolute; top:238px; right:318px; z-index:5; background-color:transparent;}
				</style>
				<script>
				$(function aritaumPromotion(){
					jsDownCoupon('prd',20814);
				});
				function jsDownCoupon(stype,idx){
					$.ajax({
						type: "post",
						url: "/shoppingtoday/act_couponshop_process.asp",
						data: "idx="+idx+"&stype="+stype,
						cache: false,
						success: function(message) {
							if(typeof(message)=="object") {
								if(message.response=="Ok") {
									popupAritaumLayer();
								} else {
									// alert(message.message);
								}
							} else {
								alert("처리중 오류가 발생했습니다.");
							}
						},
						error: function(err) {
							console.log(err.responseText);
						}
					});
				}
				function popupAritaumLayer(){
					$('.aritaum-promotion').css('display',"");
					window.parent.$('html,body').animate({scrollTop:$('.cartWrap').offset().top},500)
					var contH = $('.cartWrap').height();
					$('.aritaum-promotion').css('height',contH);
					$(".btn-close").on("click", function(e){
						$('.aritaum-promotion').fadeOut(400);
					});
				}
				</script>
				<div class="aritaum-promotion" style="display:none">
					<p class="promotion-item">
						<img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/img_promotion_item.jpg" alt="아리따움 프로모션 상품 4,000원 할인 쿠폰 지급 완료" usemap="#map-item" />
						<map name="map-item" id="map-item">
							<area alt="파우치" href="/shopping/category_prd.asp?itemid=2074432&pEtr=88637" shape="rect" coords="55,208,241,438" onfocus="this.blur();" target="_blank" />
							<area alt="티슈케이스" href="/shopping/category_prd.asp?itemid=2074445&pEtr=88637" shape="rect" coords="263,207,446,438" onfocus="this.blur();" target="_blank" />
							<area alt="노트3종 키트" href="/shopping/category_prd.asp?itemid=2074465&pEtr=88637" shape="rect" coords="56,459,239,698" onfocus="this.blur();" target="_blank" />
							<area alt="하드케이스 노트" href="/shopping/category_prd.asp?itemid=2074453&pEtr=88637" shape="rect" coords="264,459,447,698" onfocus="this.blur();" target="_blank" />
						</map>
					</p>
					<button class="btn-close"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/btn_close.png" alt="닫기" usemap="#map-item" /></button>
				</div>
				<% end if %>
				<!-- 88637아리따움 프로모션 상품 배너 -->
				<div class="cartHeader">
					<div class="orderStep">
						<span class="step01">장바구니</span>
						<span class="step02">주문결제</span>
						<h2><span class="step03">주문완료</span></h2>
					</div>
					<% if (isBaguniUserLoginOK) then %>
					<dl class="myBenefitBox">
						<dt><strong><%= GetLoginUserName %></strong>님 <span class="<%= GetUserLevelCSSClass() %>"><strong>[<%= GetUserLevelStr(GetLoginUserLevel) %>]</strong></span>의 쇼핑혜택</dt>
						<dd>
							<ul>
								<li><strong class="crRed"><%= FormatNumber(oMileage.FTotalMileage,0) %> P</strong><span>마일리지</span></li>
								<li><strong class="crRed"><%= FormatNumber(oSailCoupon.FTotalCount,0) %>장</strong><span>보너스 쿠폰</span></li>
								<li><strong class="crRed"><%= FormatNumber(oItemCoupon.FTotalCount,0) %>장</strong><span>상품쿠폰</span></li>
                                <% if (availtotalTenCash>0) then %>
								<li><strong class="cr000"><%= FormatNumber(availtotalTenCash,0) %>원</strong><span>예치금</span></li>
								<% end if %>
								<% if (availTotalGiftMoney>0) then %>
								<li><strong class="cr000"><%= FormatNumber(availTotalGiftMoney,0) %>원</strong><span>기프트 카드</span></li>
								<% end if %>
							</ul>
						</dd>
					</dl>
					<% end if %>
				</div>
				<div class="cartBox tMar15">
				<% if Not (IsSuccess) then %>
				    <div class="cartBox tMar15">
    					<div class="orderComplete">
    						<p><strong><img src="http://fiximage.10x10.co.kr/web2013/inipay/txt_order_fail.gif" alt="고객님의 주문이 실패하였습니다." /></strong></p>
    						<div class="failCont" style="width:600px;">
    							<strong>오류내용</strong> : <%= myorder.FOneItem.FResultmsg %>
    							<% if InStr(myorder.FOneItem.Fpaygatetid,"teenxteeha")>0 then %>
    							<% if InStr(myorder.FOneItem.Fresultmsg,"거래제한")>0 then %>
    							<br><br>(텐바이텐 체크카드만 결제 가능합니다. 일반카드는 "신용카드" 결제수단을 사용하세요)
    						    <% end if %>
    						    <% end if %>
    							<% if (LEFT(myorder.FOneItem.FResultmsg,8)="[404631]") then %>
    							<br><br><B><font color=red>중복 거래 요청 되었습니다. <br><a href="/my10x10/order/myorderlist.asp"><font color="blue">주문 내역 조회</font></a>에서 결제 내역을 꼭 확인해 주시기 바랍니다.</font></B>
                                <br>
                                <% end if %>
    						</div>
    						<p class="ftDotum"><strong class="cr888">텐바이텐 고객행복센터 <span class="crRed">1644-6030</span> <span class="fn lPad05 rPad05">|</span>
    						<a href="mailto:customer@10x10.co.kr" class="cr888">customer@10x10.co.kr</a></strong></p>
    					</div>

    					<div class="ct tMar60 bPad20">
    						<a href="/inipay/ShoppingBag.asp" class="lMar10 btn btnB2 btnRed btnW220"><em class="whiteArr02" >다시 주문하기</em></a>
    					</div>
    				</div>

                <% else %>
                	<% '<!-- for dev msg : 주문 내역중 선물포장 상품 포함시 wrappingCompleteV15a 클래스명 붙여주세요. 일반 주문 완료시에는 붙지 않아요 --> %>
					<div class="orderComplete <% if G_IsPojangok and vIsPojangcompleteExists then response.write " wrappingCompleteV15a" %>">
						<p><strong><img src="http://fiximage.10x10.co.kr/web2013/inipay/txt_order_complete.gif" alt="주문이 정상적으로 완료되었습니다." /></strong></p>
						<div class="orderNumber">
							<strong>[주문번호] <%= orderserial %></strong>
							<% if (myorder.FOneItem.IsDacomCyberAccountPay)  then %>
                            <% if Not IsNULL(myorder.FOneItem.FAccountNo) then %>
                            <% if (myorder.FOneItem.FAccountNo<>"") then %>
							<strong>[입금은행 가상계좌] <%=myorder.FOneItem.FAccountNo%></strong>
							<% End IF %>
                            <% End IF %>
                            <% End IF %>
						</div>
						<% if (userid="") then %>
						<p><strong class="crRed">비회원 주문시</strong>에는 주문번호를 알아야 홈페이지에서 주문배송조회가 가능합니다.</p>
						<% end if %>
						<p>주문내역 및 배송에 관한 안내는 <em class="crRed" onClick="location.href='/my10x10/order/myorderlist.asp';" style='cursor:pointer'>마이텐바이텐 &gt; 주문배송조회</em>에서 확인 가능합니다.</p>
						<p>현금영수증, 신용카드 매출전표 등 증빙서류발급은 주문 완료 후 <em class="crRed" onClick="location.href='/my10x10/order/document_issue.asp';" style='cursor:pointer'>마이텐바이텐  &gt; 증빙서류발급</em>에서 가능합니다.</p>
					</div>

					<div class="overHidden">
						<h3>결제 정보 확인</h3>
					</div>
					<table class="baseTable orderForm payForm tMar10">
						<caption>결제 정보 확인</caption>
						<colgroup>
							<col width="14%" /><col width="36%" /><col width="14%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>결제 방법</th>
							<td><%= myorder.FOneItem.GetAccountdivName %></td>
							<th>주문일시</th>
							<td><%= myorder.FOneItem.FRegDate %></td>
						</tr>
						<% if (myorder.FOneItem.FAccountdiv = 7) then %>
						<tr>
							<th>입금 예정자명</th>
							<td><%= myorder.FOneItem.Faccountname %></td>
							<th><% if (myorder.FOneItem.IsDacomCyberAccountPay) then %>입금은행 가상계좌<% else %>입금은행 정보<% end if %></th>
							<td><%= myorder.FOneItem.Faccountno %> (주)텐바이텐</td>
						</tr>
						<% end if %>
						<tr>
							<th><%= CHKIIF(IsNULL(myorder.FOneItem.FIpkumDate),"결제하실 금액","결제금액") %></th>
							<% if (myorder.FOneItem.FAccountdiv = 7) then %>
								<td>
							<% Else %>
								<td colspan="3">
							<% End If %>
								<strong class="crRed">
									<% If myorder.FOneItem.Fjumundiv="8" Then '이니렌탈 상품일 경우%>
										<span><%=iniRentalMonthLength%></span>개월 간 월 <span><%=FormatNumber(iniRentalMonthPrice,0)%>원</span>
									<% Else %>
										<%= FormatNumber(myorder.FOneItem.TotalMajorPaymentPrice,0) %>원
									<% End If %>
								</strong>

								<% if (myorder.FOneItem.FAccountDiv="100") or (myorder.FOneItem.FAccountDiv="110") then %>
									<% if (myorder.FOneItem.FokcashbagSpend<>0) then %>
									: <span class="crRed">신용카드 <%= FormatNumber(myorder.FOneItem.TotalMajorPaymentPrice-myorder.FOneItem.FokcashbagSpend,0) %> 원
									, OK캐쉬백 사용 : <%= FormatNumber(myorder.FOneItem.FokcashbagSpend,0) %> 원
									<% end if %>
									</span>
								<% end if %>
							</td>
							<% if (myorder.FOneItem.FAccountdiv = 7) then %>
								<th>입금기한</th>
								<% If now() >= #2021-11-24 10:00:00# Then %>
									<td><%=Left(dateadd("d",3,myorder.FOneItem.FRegDate),10)%> 까지</td>
								<% Else %>
									<td><%=Left(dateadd("d",10,myorder.FOneItem.FRegDate),10)%> 까지</td>
								<% End If %>
							<% End If %>
						</tr>
						<% if myorder.FOneItem.FspendTenCash<>0 then %>
						<tr>
							<th>예치금 사용</th>
							<td colspan="3"><em class="crRed"><%= FormatNumber(myorder.FOneItem.FspendTenCash,0) %>원</em></td>
						</tr>
						<% end if %>
                        <% if myorder.FOneItem.Fspendgiftmoney<>0 then %>
						<tr>
							<th>Gift카드 사용</th>
							<td colspan="3"><em class="crRed"><%= FormatNumber(myorder.FOneItem.Fspendgiftmoney,0) %>원</em></td>
						</tr>
						<% end if %>
						</tbody>
					</table>

					<div class="overHidden tMar55">
						<h3>주문리스트 확인</h3>

					</div>
					<table class="baseTable tMar10">
						<caption>주문리스트</caption>
						<colgroup>
							<%
							'선물포장서비스 노출	'/선물포장완료상품존재
							if G_IsPojangok and vIsPojangcompleteExists then
							%>
							    <% if myorder.FOneItem.Fjumundiv="2" then	'Present배송일 경우 %>
									<col width="120px" /><col width="55px" /><col width="200px" /><col width="" />
							    <% else %>
									<col width="120px" /><col width="55px" /><col width="" /><col width="110px" /><col width="80px" /><col width="95px" />
								<% end if %>

								<col width="95px" />
							<% else %>
							    <% if myorder.FOneItem.Fjumundiv="2" then	'Present배송일 경우 %>
									<col width="120px" /><col width="55px" /><col width="200px" /><col width="" />
							    <% else %>
									<col width="120px" /><col width="55px" /><col width="" /><col width="110px" /><col width="80px" /><col width="95px" /><col width="95px" />
								<% end if %>
							<% end if %>
						</colgroup>
						<thead>
						<tr>
							<th>상품코드/배송</th>
							<th colspan="2">상품정보</th>
							<% If myorder.FOneItem.Fjumundiv<>"8" Then '이니렌탈 상품이 아닐경우만 표시%>
								<th>판매가격</th>
							<% End If %>

							<% if myorder.FOneItem.Fjumundiv="2" then	'Present배송일 경우 %>
								<th>배송비</th>
							<% else %>
								<th>수량</th>
								<% If myorder.FOneItem.Fjumundiv="8" Then '이니렌탈 상품일 경우%>
									<th>이니렌탈 시</th>
								<% Else %>
									<th>주문금액</th>
									<th>마일리지</th>
								<% End If %>
							<% end if %>

							<%
							'선물포장서비스 노출	'/선물포장완료상품존재
							if G_IsPojangok and vIsPojangcompleteExists then
							%>
								<th scope="col">선물포장</th>
							<% end if %>
						</tr>
						</thead>
						<tbody>
						<%
						Dim vItemCnt : vItemCnt = 0	'### 상단 주문수. 상품수 아닌 itemea의 총합.
						vIsDeliveItemExist = False
						for i=0 to myorderdetail.FResultCount - 1

							'### 인터파크여행상품이 있는지 체크
							If Not(myorderdetail.FItemList(i).Fitemdiv = "18" AND myorderdetail.FItemList(i).Fmakerid = "interparktour") Then
								vIsDeliveItemExist = True
							End If

						'/선물포장 일경우 포장비 안뿌림
						If myorderdetail.FItemList(i).FItemid <> 100 Then
							'// RecoPick에 넘길 itemid값
							'// 레코픽 서비스 종료에 따른 제거(150630 원승현)
						   'RecoPickSendItemId = myorderdetail.FItemList(i).FItemID

							'// RecoBell에 넘길 값
							'RecoBellSendValue = RecoBellSendValue & " _rblqueue.push(['addVar', 'orderItems', { itemId:'"&myorderdetail.FItemList(i).FItemID&"', itemName:'"&myorderdetail.FItemList(i).FItemName&"', itemCategory:'', quantity:'"&myorderdetail.FItemList(i).FItemNo&"', price:'"&myorderdetail.FItemList(i).Forgitemcost&"'}]); "
							'RecoBellSendValue2 = RecoBellSendValue2 & " _rlq.push(['addVar', 'orderItems', { itemId:'"&myorderdetail.FItemList(i).FItemID&"', itemName:'"&myorderdetail.FItemList(i).FItemName&"', itemCategory:'', quantity:'"&myorderdetail.FItemList(i).FItemNo&"', price:'"&myorderdetail.FItemList(i).Forgitemcost&"'}]); "

						%>
							<tr>
								<td><%= myorderdetail.FItemList(i).FItemID %><br /><%= myorderdetail.FItemList(i).getDeliveryTypeName %></td>
								<td><img src="<%= myorderdetail.FItemList(i).FImageSmall %>" width="50px" height="50px" alt="<%= myorderdetail.FItemList(i).FItemOptionName %>" /></td>
								<td class="lt">
									<p class="tPad05"><%= myorderdetail.FItemList(i).FItemName %></p>
									<p class="tPad02">
									<% if myorderdetail.FItemList(i).FItemOptionName<>"" then %>
									<%= myorderdetail.FItemList(i).FItemOptionName %>
									<% end if %>
									</p>
								</td>
								<% If myorder.FOneItem.Fjumundiv<>"8" Then '이니렌탈 상품이 아닐경우만 표시%>
									<td>
										<% if (myorderdetail.FItemList(i).IsSaleItem) then %>
										<p class="txtML cr999"><%= FormatNumber(myorderdetail.FItemList(i).Forgitemcost,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
										<p class="crRed"><strong><%= FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></strong></p>
										<% else %>
											<% if (myorderdetail.FItemList(i).IsItemCouponAssignedItem) then %>
											<p class="txtML cr999"><%= FormatNumber(myorderdetail.FItemList(i).getItemcostCouponNotApplied,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
											<% else %>
											<%= FormatNumber(myorderdetail.FItemList(i).FItemCost,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
											<% end if %>
										<% end if %>

										<% if (myorderdetail.FItemList(i).IsItemCouponAssignedItem) then %>
											<p class="crGrn" ><%= FormatNumber(myorderdetail.FItemList(i).FItemCost,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
										<% else %>

										<% end if %>

										<% if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
										<p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
										<% end if %>
									</td>
								<% End If %>

								<% if myorder.FOneItem.Fjumundiv="2" then	'Present배송일 경우 %>
									<td><%= FormatNumber(myorder.FOneItem.FDeliverPrice,0) %> 원</td>
								<% elseif myorder.FOneItem.Fjumundiv="8" then '이니렌탈 상품일 경우 %>
									<td><%= myorderdetail.FItemList(i).FItemNo %></td>
									<td>
										<p><span><%=iniRentalMonthLength%></span>개월 간</p>
										<p>월 <span><%=FormatNumber(iniRentalMonthPrice,0)%>원</span>
									</td>
								<% else %>
									<td>
										<%= myorderdetail.FItemList(i).FItemNo %>

										<%
										'선물포장서비스 노출		'/2015.11.11 한용민 생성
										if G_IsPojangok then
										%>
											<%
											'/선물포장 완료
											If myorderdetail.FItemList(i).FIsPacked="Y" Then
											%>
												<br><strong class="cRd0V15">(포장상품 <%= fnGetPojangItemCount(myorderdetail.FItemList(i).FOrderSerial, myorderdetail.FItemList(i).FItemid, myorderdetail.FItemList(i).FItemoption) %>)</strong>
											<% end if %>
										<% end if %>
									</td>
									<td><%= FormatNumber(myorderdetail.FItemList(i).FItemCost*myorderdetail.FItemList(i).FItemNo,0) %> <%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %>
									<% if (myorderdetail.FItemList(i).IsSaleBonusCouponAssignedItem) then %>
										<p class="crRed"><img src='http://fiximage.10x10.co.kr/web2008/shoppingbag/coupon_icon.gif' width='10' height='10' > <%= FormatNumber(myorderdetail.FItemList(i).getReducedPrice*myorderdetail.FItemList(i).FItemNo,0) %><%= CHKIIF(myorderdetail.FItemList(i).IsMileShopSangpum,"Pt","원") %></p>
									<% end if %>
									</td>
									<td>
										<% if Not isBaguniUserLoginOK then %>
											회원 구매 시<br />
										<% end if %>
										<%= myorderdetail.FItemList(i).FMileage*myorderdetail.FItemList(i).FItemNo %> Point
									</td>
								<% end if %>

								<%
								'선물포장서비스 노출	'/선물포장완료상품존재
								if G_IsPojangok and vIsPojangcompleteExists then
								%>
									<td>
										<%
										'/선물포장가능상품
										if myorderdetail.FItemList(i).FPojangOk="Y" then
										%>
											<%
											'/선물포장 완료
											If myorderdetail.FItemList(i).FIsPacked="Y" Then
											%>
												<img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장을 설정한 상품">
											<%
											'/상품포장을 안한 상태
											'else
											%>
												<!--<img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_no.png" alt="상품 비요청상품" />-->
											<% end if %>
										<% end if %>
									</td>
								<% end if %>
							</tr>


	                        <% if (myorderdetail.FItemList(i).IsRequireDetailExistsItem) and (Not myorderdetail.FItemList(i).ISFujiPhotobookItem) then %>
		                        <% if (myorderdetail.FItemList(i).FItemNo>1) or (myorderdetail.FItemList(i).Frequiredetail="") then CheckRequireDetailMsg = true %>
								<tr class="orderWord">
								    <td class="bdrNone"></td>
		                			<td class="bdrNone"></td>
		                			<td colspan="4">
		                				<dl class="customWord">
		        						    <dt><strong>주문제작문구</strong> :</dt>
		        						    <dd><%= myorderdetail.FItemList(i).getRequireDetailHtml %></dd>
								        </dl>
		                			</td>
		                			<td class="rt vTop tPad03">
		                			    <p><a href="/my10x10/order/order_info_edit_detail.asp?idx=<%= orderserial %>" class="btn btnS4 btnGry2 btnW70 fn" >수정</a></p>
		                		    </td>
								</tr>
							<% end if %>
						<%
						    vItemCnt = vItemCnt + 1
						    end if
						next %>
						</tbody>
					</table>


                    <% if (oOpenGift.FResultCount>0) then %>
					<ul class="box5 tPad10 bPad10 lPad20 list01 cr777 fs11 lh19">
					    <% for j=0 to oOpenGift.FREsultCount-1 %>
					        <script>
                                if(appier_purchase_gift_code != ""){
                                    appier_purchase_gift_code += "<%=oOpenGift.FItemList(j).Fgift_code%>";
                                }else{
                                    appier_purchase_gift_code += ",<%=oOpenGift.FItemList(j).Fgift_code%>";
                                }
                            </script>

                            <% if (oOpenGift.FItemList(j).Fchg_giftStr<>"") then %>
                                <li><%= oOpenGift.FItemList(j).Fevt_name %> - 사은품 선택 : <%= oOpenGift.FItemList(j).Fchg_giftStr %></li>
                            <% else %>
                                <li><%= oOpenGift.FItemList(j).Fevt_name %> : <%= oOpenGift.FItemList(j).Fgiftkind_name %></li>
                            <% end if %>

                            <% if (oOpenGift.FItemList(j).Fgiftkind_cnt>1)  then %>
                                (<%=oOpenGift.FItemList(j).Fgiftkind_cnt%>)개
                            <% end if %>
						<% next %>
					</ul>
                    <% end if %>


					<div class="totalBox tMar30">
						<dl class="totalPriceView">
							<dt><img src="http://fiximage.10x10.co.kr/web2013/cart/txt_total.gif" alt="총 주문 금액" /></dt>
							<dd>
								<% if myorder.FOneItem.Fjumundiv<>"8" then '이니렌탈 상품일 경우 %>
									<ul class="priceList">
										<li>
											<span class="ftLt">상품 총 금액</span><strong class="ftRt"><%= FormatNumber((myorder.FOneItem.FTotalSum-myorder.FOneItem.FDeliverPrice-pojangcash),0) %>원</strong>
										</li>

										<%
										'선물포장서비스 노출		'/2015.11.11 한용민 생성
										if G_IsPojangok then
											'/선물포장완료상품존재
											if vIsPojangcompleteExists then
										%>
												<li>
													<span class="ftLt">선물포장비(<%= pojangcnt %>건)</span><strong class="ftRt"><%= FormatNumber(pojangcash,0) %>원</strong>
												</li>
										<%
											end if
										end if
										%>

										<li>
											<span class="ftLt">배송비</span><strong class="ftRt"><%= FormatNumber(myorder.FOneItem.FDeliverpriceCouponNotApplied,0) %>원</strong>
										</li>
										<% if (myorder.FOneItem.FDeliverpriceCouponNotApplied>myorder.FOneItem.FDeliverprice) then %>
										<li>
											<span class="ftLt">배송비쿠폰할인</span><strong class="ftRt crRed">-<%= FormatNumber(myorder.FOneItem.FDeliverpriceCouponNotApplied-myorder.FOneItem.FDeliverprice,0) %>원</strong>
										</li>
										<% end if %>
										<% IF (myorder.FOneItem.Fmiletotalprice<>0) then %>
										<li>
											<span class="ftLt">마일리지</span><strong class="ftRt crRed">-<%= FormatNumber(myorder.FOneItem.Fmiletotalprice,0) %>P</strong>
										</li>
										<% end if %>
										<% IF (myorder.FOneItem.Ftencardspend<>0) then %>
										<li>
											<span class="ftLt">보너스쿠폰 할인</span><strong class="ftRt crRed">-<%= FormatNumber(myorder.FOneItem.Ftencardspend,0) %>원</strong>
										</li>
										<% end if %>
										<% if (myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership<>0) then %>
										<li>
											<span class="ftLt">기타 할인</span><strong class="ftRt crRed">-<%= FormatNumber((myorder.FOneItem.Fallatdiscountprice + myorder.FOneItem.Fspendmembership),0) %>원</strong>
										</li>
										<% end if %>
									</ul>
								<% End If %>
							</dd>
						</dl>
						<p class="rt tPad15 bPad05">
							<% if myorder.FOneItem.Fjumundiv="8" then '이니렌탈 상품일 경우 %>
								<strong class="lPad10">결제 예정 금액 <span class="crRed lPad10"><em class="fs20"><%=iniRentalMonthLength%></em>개월간 월 <em class="fs20"><%=FormatNumber(iniRentalMonthPrice,0)%></em>원</span></strong>
							<% Else %>
								<% if (isBaguniUserLoginOK) then %>
								<span class="fs13 cr777">(적립 마일리지 <%= FormatNumber(myorder.FOneItem.Ftotalmileage,0) %> P)</span>
								<% end if %>
								<strong class="lPad10">결제 금액 <span class="crRed lPad10"><em class="fs20"><%= FormatNumber(myorder.FOneItem.FsubtotalPrice,0) %></em>원</span></strong>
							<% End If %>
						</p>
					</div>

					<div class="overHidden tMar55">
						<h3>주문고객 정보 확인</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>주문고객 정보 확인</caption>
						<colgroup>
							<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>보내시는 분</th>
							<td><%= myorder.FOneItem.FBuyName %></td>
							<th>이메일</th>
							<td><%= myorder.FOneItem.FBuyEmail %></td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td><%= myorder.FOneItem.FBuyhp %></td>
							<th>전화번호</th>
							<td><%= myorder.FOneItem.FBuyPhone %></td>
						</tr>
						</tbody>
					</table>
                    <% if myorder.FOneItem.IsReceiveSiteOrder or (myorder.FOneItem.IsTicketOrder and TicketDlvType="1") then %>
                    <div class="overHidden tMar55">
						<h3>수령자 정보 확인</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>수령자 정보 확인</caption>
						<colgroup>
							<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>받으시는 분</th>
							<td colspan="3"><%= myorder.FOneItem.FReqName %></td>
						</tr>
						<tr>
							<th>휴대전화</th>
							<td><%= myorder.FOneItem.FReqHp %></td>
							<th>전화번호</th>
							<td><%= myorder.FOneItem.FReqPhone %></td>
						</tr>

						<% if myorder.FOneItem.IsReceiveSiteOrder then %>
						<tr>
							<th>수령방법</th>
							<td colspan="3">현장 수령</td>
						</tr>
						<% end if %>

						<% if 1>1 and Not(myorder.FOneItem.IsTicketOrder and TicketDlvType="1") then %>
						<tr>
							<th>수령날짜</th>
							<td colspan="3"><%= myorder.FOneItem.Freqdate %></td>
						</tr>
						<tr>
							<th>수령장소</th>
							<td colspan="3"><!-- 서울시 송파구 방이동 88-2 올림픽 체조경기장 2-1번 게이트 앞 텐바이텐 예약판매 현장수령 부스--></td>
						</tr>
						<% end if %>
						<tr>
                			<th>유의사항</th>
                			<td colspan="3">
                			    <li>현장수령 시 예약/주문내역서 필수 지참 (미지참시 상품 수령 불가)</li>
                			    <li>인쇄하기 버튼을 눌러 예약/주문내역서를 출력해주세요</li>
                			    <li>마이텐바이텐>주문배송조회> 주문내역서 출력하기가 가능합니다</li>
                			</td>
                		</tr>
						</tbody>
					</table>
                    <% else %>
                    		<% If vIsDeliveItemExist = True Then %>
								<div class="overHidden tMar55">
									<h3>배송지 정보 확인</h3>
									<a href="/my10x10/order/order_info_edit_detail.asp?orderserial=<%=orderserial%>" class="ftRt btn btnS3 btnRed"><span class="whiteArr02 fn">배송지 정보 수정</span></a>
								</div>
								<% if (myorder.FOneItem.IsForeignDeliver) then %>
								<table class="baseTable orderForm tMar10">
									<caption>배송지 정보 확인</caption>
									<colgroup>
										<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
									</colgroup>
									<tbody>
									<tr>
										<th>배송국가 <span class="crRed">*</span><br /><span class="fn fs11">(country)</span></th>
										<td colspan="3"><%= myorder.FOneItem.FDlvcountryName %></td>
									</tr>
									<tr>
										<th>받으시는 분 <span class="crRed">*</span><br /><span class="fn fs11">(name)</span></th>
										<td><%= myorder.FOneItem.FReqName %></td>
										<th>이메일 <span class="fn fs11">(E-mail)</span></th>
										<td><%= myorder.FOneItem.FReqEmail %></td>
									</tr>
									<tr>
										<th>전화번호 <span class="crRed">*</span><br /><span class="fn fs11">(Tel. No)</span></th>
										<td colspan="3"><%= myorder.FOneItem.FReqPhone %></td>
									</tr>
									<tr>
										<th>우편번호 <span class="crRed">*</span><br /><span class="fn fs11">(Zip Code)</span></th>
										<td colspan="3"><%= myorder.FOneItem.FemsZipCode %></td>
									</tr>
									<tr>
										<th>상세주소 <span class="crRed">*</span><br /><span class="fn fs11">(Address)</span></th>
										<td colspan="3"><%= myorder.FOneItem.Freqaddress %></td>
									</tr>
									<tr>
										<th>도시 및 주 <span class="crRed">*</span><br /><span class="fn fs11">(City/State)</span></th>
										<td colspan="3"><%= myorder.FOneItem.Freqzipaddr %></td>
									</tr>
									</tbody>
								</table>
								<% else %>
								<table class="baseTable orderForm tMar10">
									<caption>배송지 정보 확인</caption>
									<colgroup>
										<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
									</colgroup>
									<tbody>
									<tr>
										<th>받으시는 분</th>
										<td colspan="3"><%= myorder.FOneItem.FReqName %></td>
									</tr>
									<tr>
										<th>휴대전화</th>
										<td><%= myorder.FOneItem.FReqHp %></td>
										<th>전화번호</th>
										<td><%= myorder.FOneItem.FReqPhone %></td>
									</tr>
									<tr>
										<th>주소</th>
										<td colspan="3">[<%= Trim(myorder.FOneItem.FreqzipCode) %>] <%= myorder.FOneItem.Freqzipaddr %> <%= myorder.FOneItem.Freqaddress %></td>
									</tr>
									<tr>
										<th>배송 유의사항</th>
										<td colspan="3"><%= nl2Br(myorder.FOneItem.Fcomment) %></td>
									</tr>

									<%
									'선물포장서비스 노출		'/2015.11.11 한용민 생성
									if G_IsPojangok then
										'/선물포장완료상품존재
										if vIsPojangcompleteExists then
									%>
											<!--<tr>
												<th>주문서 포함여부</th>
												<td colspan="3">포함<% ' if myorder.FOneItem.FOrderSheetYN="N" then response.write "하지 않음" %></td>
											</tr>-->
										<% end if %>
									<% end if %>

									</tbody>
								</table>
								<% end if %>
							<% end if %>
                    <% end if %>

					<%
						'// 해외 직구
						Dim oUniPassNumber
						oUniPassNumber = fnUniPassNumber(orderserial)
						If oUniPassNumber <> "" And Not isnull(oUniPassNumber) Then
					%>
					<div class="overHidden tMar55">
						<h3>해외직구 상품 배송정보</h3>
						<a href="/my10x10/order/order_info_edit_detail.asp?orderserial=<%=orderserial%>" class="ftRt btn btnS3 btnRed"><span class="whiteArr02 fn">개인통관 고유부호 수정</span></a>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>해외직구 상품 배송정보</caption>
						<colgroup>
							<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
						</colgroup>
						<tbody>
							<tr>
								<th>개인통관 고유부호</th>
								<td><%=oUniPassNumber%> <!--a href="/my10x10/orderPopup/popCustomsIDEdit.asp?orderserial=<%=orderserial%>" title="새창에서 열림" onclick="window.open(this.href, 'popDepositor', 'width=700, height=500, scrollbars=yes'); return false;" class="btn btnS2 btnGry"><span class="fn">수정</span></a--></td>
							</tr>
						</tbody>
					</table>
					<%
						End If
					%>

                    <% if myorder.FOneItem.IsTicketOrder then %>
                      <%
                            IF myorderdetail.FResultCount>0 then
                            Dim oticketSchedule

                            Set oticketSchedule = new CTicketSchedule
                            oticketSchedule.FRectItemID = myorderdetail.FItemList(0).FItemID
                            oticketSchedule.FRectItemOption = myorderdetail.FItemList(0).FItemOption
                            oticketSchedule.getOneTicketSchdule
                    %>
                    <div class="overHidden tMar55">
						<h3>공연 정보 확인</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>공연 정보 확인</caption>
						<colgroup>
							<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>공연명</th>
							<td><%= myorderdetail.FItemList(0).FItemName %></td>
							<th>공연 일시</th>
							<td><%= oticketSchedule.FOneItem.getScheduleDateStr %></td>
						</tr>
						<tr>
							<th>티켓 수량</th>
							<td><%= myorderdetail.FItemList(0).FItemNo %> 매</td>
							<th>공연 시간</th>
							<td><%= oticketSchedule.FOneItem.getScheduleDateTime %></td>
						</tr>
						<tr>
							<th>공연 장소</th>
							<td><%= ticketPlaceName %></td>
							<th>약도 보기</th>
							<td><img src="http://fiximage.10x10.co.kr/web2011/order/btn_mapview.gif" width="72" height="25" onClick="popTicketPlace('<%= ticketPlaceIdx %>');" style="cursor:hand"></td>
						</tr>
						</tbody>
					</table>
                    <%
                            Set oticketSchedule = Nothing
                            end if
                    %>
                    <% end if %>

					<%
					'선물포장서비스 노출		'/2015.11.11 한용민 생성
					if G_IsPojangok then
						'/선물포장완료상품존재
						if vIsPojangcompleteExists then
					%>
							<div class="overHidden tMar55">
								<h3>선물포장 정보 확인</h3>
								<a href="" onClick="window.open('/inipay/pack/pack_message_edit.asp?idx=<%=orderserial%>', 'pkgMsgEdit', 'width=800, height=800, scrollbars=yes'); return false;" class="ftRt btn btnS3 btnRed">
								<span class="whiteArr02 fn">선물포장 상품확인</span></a>
							</div>
							<table class="baseTable orderForm tMar10">
								<caption>선물포장 정보 확인</caption>
								<colgroup>
									<col width="12%" /><col width="" />
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">포장내역</th>
									<td><%=pojangcnt%>개 <%= FormatNumber(pojangcash,0) %>원</td>
								</tr>

								<% If opackmaster.FResultCount > 0 Then %>
									<tr>
										<th scope="row">입력 메시지</th>
										<td class="fs11 lh19">
											<% For i=0 To opackmaster.FResultCount-1 %>
											<p><strong>[<%= opackmaster.FItemList(i).Ftitle %>]</strong> <%= opackmaster.FItemList(i).Fmessage %></p>
											<% next %>
										</td>
									</tr>
								<% end if %>

								</tbody>
							</table>
						<% end if %>
					<% end if %>

                    <% if (myorder.FOneItem.IsFixDeliverItemExists) then %>
					<div class="overHidden tMar55">
						<h3>플라워 배송 추가 정보 확인</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>플라워 배송 추가 정보 확인</caption>
						<colgroup>
							<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>보내시는 분</th>
							<td colspan="3"><%= myorder.FOneItem.Ffromname %></td>
						</tr>
						<tr>
							<th>희망 배송일</th>
							<td><%= myorder.FOneItem.Freqdate %>일 <%= myorder.FOneItem.GetReqTimeText %></td>
							<th>메시지 선택</th>
							<td><%= myorder.FOneItem.GetCardLibonText %></td>
						</tr>
						<tr>
							<th>메시지 내용</th>
							<td colspan="3"><%= myorder.FOneItem.Fmessage %></td>
						</tr>
						</tbody>
					</table>
                    <% end if %>
					<div class="ct tMar60 bPad20">
					    <% if (IsUserLoginOK) then %>
						<a href="/my10x10/order/myorderlist.asp" class="btn btnB2 btnWhite2 btnW220">주문/배송 조회</a>
						<% end if %>
						<% if myorder.FOneItem.IsReceiveSiteOrder then %>
						<a href="" class="lMar10 btn btnB2 btnWhite2 btnW220" onClick="popRsvSiteOrder();return false;">인쇄하기</a>
						<a href="/" class="lMar10 btn btnB2 btnRed btnW220"><em class="whiteArr02">쇼핑 계속하기</em></a>
						<% else %>
						<a href="" class="lMar10 btn btnB2 btnWhite2 btnW220" onClick="popPrint();return false;" >인쇄하기</a>
						<a href="/" class="lMar10 btn btnB2 btnRed btnW220"><em class="whiteArr02">쇼핑 계속하기</em></a>
						<% end if %>
					</div>

					<%' 네오 스크립트 전송 %>
					<script type="text/javascript">
						var NeoclickConversionDctSv="type=3,orderID=<%=orderserial%>,amount=<%= myorder.FOneItem.FsubtotalPrice %>";
						var NeoclickConversionAccountID="22505";
                        var NeoclickConversionInnAccountNum="895";
                        var NeoclickConversionInnAccountCode="6124a52c47e704b805000009";
					</script>
					<script type="text/javascript" src="//ck.ncclick.co.kr/NCDC_V2.js"></script>
					<%'// 네오 스크립트 전송 %>
<% end if %>

					<%
					'//이벤트 배너 '/2014-09-05 한용민 추가
					if date>="2014-09-10" and date<"2014-10-06" then
					%>
						<div class="tMar40">
							<p><a href="/event/eventmain.asp?eventid=54791"><img src="http://imgstatic.10x10.co.kr/offshop/temp/2014/201409/order_after_w.jpg" alt="" /></a></p>
						</div>
					<% end if %>
					<%
					'//2014 크리스마스 배너 노르딕		'/2014-11-28 한용민 추가
					if date>="2014-12-01" and date<"2014-12-23" then
					%>
						<div class="tMar60">
							<p><a href="/event/x-mas/nordic/" title="크리스마스 이벤트 응모하기"><img src="http://webimage.10x10.co.kr/eventIMG/2014/x-mas/img_bnr_xmas_benefit.jpg" alt="온리포유 지금 크리스마스 기획전 상품을 구매하시면, 추첨을 통해 포근한 겨울을 위한 MAATILA 북유럽 침구세트를 선물로 드립니다. 이벤트 기간은 2014년 12월 1이루터 12월 23일까지입니다." /></a></p>
						</div>
					<% end if %>
				</div>
				<% if date() < "2018-12-24" then  %>
				<div class="tMar40">
					<p><a href="/event/eventmain.asp?eventid=85155"><img src="http://fiximage.10x10.co.kr/web2018/common/bnr_hanacard.png" alt="텐바이텐 상품 구매 시 5% 할인되는 체크카드를 소개합니다!" /></a></p>
				</div>
				<% end if %>
				<% If RecoPickSendItemId <> "" Then %>
				<%' 레코픽 서비스 종료에 따른 제거 %>
				<!--------- Happy Together
				<div id="lyrHPTgr"></div>
				<script type="text/javascript">
					//var vIId=, vDisp='';
				</script>
				<script type="text/javascript" src="./inc_happyTogether_complete.js"></script>
				-->
				<% End If %>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>



<form name="frmprt" method="post" action="/my10x10/order/myorder_receipt.asp">
<input type="hidden" name="idx" value="<%= orderserial %>">
<input type="hidden" name="dumi" value="<%= request("dumi") %>">
</form>
<% IF (IsSuccess) and (request.cookies("rdsite")="okcashbag" or request.cookies("rdsite")="pickle") THEN
	response.write "<script>var pop = window.open('/inipay/okcashbagcardinfo.asp?ods="& orderserial &"','popokcash','width=585,height=690');</script>"
End IF %>
<%
if (IsSuccess) then
	oshoppingbag.ClearShoppingbag
	dim CartCnt : CartCnt = getDBCartCount
    SetCartCount(CartCnt)

	if CheckRequireDetailMsg then
	    response.write "<script>alert('주문제작 문구가 정확히 입력되셨는지 다시한번 확인해 주시기 바랍니다.\n문구를 수정하시려면 내용수정 버튼을 클릭하신후 수정 가능합니다.');</script>"
	end if
end if

'//네이트온 결제알림(166) 확인 및 발송(입금확인시에만 발송) //주석처리 2017/04/20
''if (IsSuccess) and (myorder.FOneItem.IsPayed) then
''	on error resume next
''	Call NateonAlarmCheckMsgSend(userid,166,orderserial)
''	on error goto 0
''end if

'//카카오톡 결제알림 확인 및 발송(발송 DB에 있는경우만 발송)
if (IsSuccess) then
	on error resume next
	Call fnKakaoChkSendMsg(orderserial)
	on error goto 0
end If
%>
<%' 크레센도 스크립트 추가 %>
<% if (IsSuccess) Then %>
	<script type="text/javascript"> csf('event','0','<%=CresendoScriptItemName%>','<%=CresendoScriptItemPrice%>'); </script>
<% End If %>
<%'// 크레센도 스크립트 추가 %>

<%' 에코마케팅용 레코벨 스크립트 삽입(2016.12.21) %>
<% if (IsSuccess) Then %>
	<script type="text/javascript">
	  window._rblq = window._rblq || [];
	  <%=RecoBellSendValue%>

	  window._rblq = window._rblq || [];
	  _rblq.push(['setVar','cuid','0f8265c6-6457-4b4a-b557-905d58f9f216']);
	  _rblq.push(['setVar','device','PW']);
	  _rblq.push(['setVar','orderId','<%=orderserial%>']);
	  _rblq.push(['setVar','orderPrice','<%=myorder.FOneItem.FsubtotalPrice%>']);
//	  _rblq.push(['setVar','userId','{$userId}']); // optional
	  _rblq.push(['track','order']);
	  (function(s,x){s=document.createElement('script');s.type='text/javascript';
	  s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+
	  '://assets.recobell.io/rblc/js/rblc-apne1.min.js';
	  x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
	</script>

	<script type="text/javascript">
        /*
        * 모비온 광고 스크립트
        * */
        var ENP_VAR = { conversion: { product: [] } };

        ENP_VAR.conversion.ordCode= '<%= orderserial %>';
        ENP_VAR.conversion.totalPrice = '<%= myorder.FOneItem.FsubtotalPrice %>';

        (function(a,g,e,n,t){a.enp=a.enp||function(){(a.enp.q=a.enp.q||[]).push(arguments)};n=g.createElement(e);n.async=!0;n.defer=!0;n.src="https://cdn.megadata.co.kr/dist/prod/enp_tracker_self_hosted.min.js";t=g.getElementsByTagName(e)[0];t.parentNode.insertBefore(n,t)})(window,document,"script");
        enp('create', 'conversion', 'your10x10', { device: 'W' }); // W:웹, M: 모바일, B: 반응형
        enp('send', 'conversion', 'your10x10');

        /*
        * 애피어 스크립트
        * */
        !function(q,g,r,a,p,h,js) {
            if(q.qg)return;
            js = q.qg = function() {
                js.callmethod ? js.callmethod.call(js, arguments) : js.queue.push(arguments);
            };
            js.queue = [];
            p=g.createElement(r);p.async=!0;p.src=a;h=g.getElementsByTagName(r)[0];
            h.parentNode.insertBefore(p,h);
        } (window,document,'script','https://cdn.qgr.ph/qgraph.df0854decfeb333174cb.js');

        let appier_product_purchased_data = {};

        if(typeof qg !== "undefined"){
            let appier_checkout_complete_data = {};

            appier_checkout_complete_data.orderserial = "<%=orderserial%>";
            appier_checkout_complete_data.used_mileage_amount = parseInt("<%=myorder.FOneItem.Fmiletotalprice%>");
            appier_checkout_complete_data.confirmed_price = parseInt("<%=myorder.FOneItem.FTotalSum - myorder.FOneItem.FDeliverPrice-pojangcash%>");
            appier_checkout_complete_data.number_of_products = parseInt("<%=vItemCnt%>");
            appier_checkout_complete_data.order_amount = parseInt("<%=FormatNumber(myorder.FOneItem.FsubtotalPrice,0)%>");
            <%
                IF bonuscouponidx <> "" THEN
            %>
                appier_checkout_complete_data.used_couponid = parseInt("<%=bonuscouponidx%>");
                appier_checkout_complete_data.used_couponprice = parseInt("<%=myorder.FOneItem.Ftencardspend%>");
            <%
                END IF
            %>
            appier_checkout_complete_data.payment_type = "<%=myorder.FOneItem.GetAccountdivName%>";
            appier_checkout_complete_data.shipping_type = appier_shipping_type_data.substring(1);
            appier_checkout_complete_data.user_id = "<%=getUserSeqValue(userid)%>";

            qg("event", "checkout_completed", appier_checkout_complete_data);
        }
    </script>
    <%
        DIM mobion_totalQty : mobion_totalQty = 0
		Dim twitterPrice, twitterItemQuantity
        FOR i=0 to myorderdetail.FResultCount - 1
            mobion_totalQty = mobion_totalQty + myorderdetail.FItemList(i).FItemNo
			twitterPrice = twitterPrice + myorderdetail.FItemList(i).FItemCost
			twitterItemQuantity = twitterItemQuantity + myorderdetail.FItemList(i).FItemNo
    %>
            <script type="text/javascript">
                ENP_VAR.conversion.product.push(
                    {
                        productCode : '<%= myorderdetail.FItemList(i).FItemID %>',
                        productName : '<%= myorderdetail.FItemList(i).FItemName %>',
                        price : '<%= myorderdetail.FItemList(i).Forgitemcost %>',
                        dcPrice : '<%= myorderdetail.FItemList(i).FItemCost %>',
                        qty : '<%= myorderdetail.FItemList(i).FItemNo %>'
                    }
                );

                ENP_VAR.conversion.totalQty = '<%= mobion_totalQty %>';

                if(typeof qg !== "undefined"){
                    appier_product_purchased_data = {}

                    appier_product_purchased_data.category_name_depth1 = "<%= myorderdetail.FItemList(i).Ffirst_depth_cate %>";
                    appier_product_purchased_data.category_name_depth2 = "<%= myorderdetail.FItemList(i).Fsecond_depth_cate %>";
                    appier_product_purchased_data.brand_id = "<%= myorderdetail.FItemList(i).FMakerid %>";
                    appier_product_purchased_data.brand_name = "<%=fnItemIdToBrandName(myorderdetail.FItemList(i).FItemID)%>";
                    appier_product_purchased_data.product_id = "<%= myorderdetail.FItemList(i).FItemID %>";
                    appier_product_purchased_data.product_name = "<%= Replace(myorderdetail.FItemList(i).FItemName, """", "") %>";
                    //appier_product_purchased_data.product_select = "";
                    appier_product_purchased_data.product_variant = "<%=myorderdetail.FItemList(i).FItemOptionName%>";
                    appier_product_purchased_data.product_image_url = "<%= myorderdetail.FItemList(i).FImageList %>";
                    appier_product_purchased_data.product_url = "https://m.10x10.co.kr/category/category_itemPrd.asp?itemid=<%= myorderdetail.FItemList(i).FItemID %>";
                    appier_product_purchased_data.product_price = parseInt("<%= myorderdetail.FItemList(i).Forgitemcost %>");
                    appier_product_purchased_data.quantity = parseInt("<%= myorderdetail.FItemList(i).FItemNo %>");
                    appier_product_purchased_data.orderserial = "<%=orderserial%>";
                    appier_product_purchased_data.keywords = "<%=myorderdetail.FItemList(i).FKeywords%>";
                    appier_product_purchased_data.purchase_gift_code = appier_purchase_gift_code;

                    qg("event", "product_purchased", appier_product_purchased_data);
                }
            </script>
    <%
        NEXT
    %>
<% End If %>

<!-- Twitter universal website tag code -->
<script>
	!function(e,t,n,s,u,a){e.twq||(s=e.twq=function(){s.exe?s.exe.apply(s,arguments):s.queue.push(arguments);
	},s.version='1.1',s.queue=[],u=t.createElement(n),u.async=!0,u.src='//static.ads-twitter.com/uwt.js',
	a=t.getElementsByTagName(n)[0],a.parentNode.insertBefore(u,a))}(window,document,'script');
	// Insert Twitter Pixel ID and Standard Event data below
	twq('init','twitter_pixel_id');
	twq('track','Purchase', {
		//required parameters
		value: '<%=twitterPrice%>',
		currency: 'KRW',
		num_items: '<%=twitterItemQuantity%>',
	});
</script>
<!-- End Twitter universal website tag code -->

<%
set oMileage  = Nothing
set oTenCash = Nothing
set oGiftCard = Nothing
set oSailCoupon = Nothing
set oItemCoupon = Nothing
set oshoppingbag = Nothing
set myorder = Nothing
set myorderdetail = Nothing
Set oOpenGift = Nothing
set opackmaster = Nothing

''set oSubPayment = Nothing
%>
<% if (IsSuccess) then %>
<script type="text/javascript">
// 장바구니 표시 재지정
<%
    response.write "document.getElementById('ibgaCNT').innerHTML='"&GetCartCount&"';"
%>
fnDelCartAll();
</script>
<% end if %>
<% if (add_EXTSCRIPT<>"") then %>
<%
    ''추가 로그 //2016/05/18 by eastone
    function AppendLog_DisplayOrder()
        dim iAddLogs
        ''if NOT (application("Svr_Info")="Dev") then exit function ''실서버 잠시 중지시.
            
        iAddLogs=request.Cookies("tinfo")("shix")
        if (request.Cookies("shoppingbag")("GSSN")<>"") then ''비회원 장바구니 =>로그인 한경우 체크위해
            iAddLogs=request.Cookies("shoppingbag")("GSSN")
        end if
        iAddLogs = "uk="&iAddLogs
        
        if (request.ServerVariables("QUERY_STRING")<>"") then iAddLogs="&"&iAddLogs
        iAddLogs=iAddLogs&"&rdsite="&request.cookies("rdsite")
        
        response.AppendToLog iAddLogs
        
    end function
    call AppendLog_DisplayOrder()
%>
<script type="text/javascript" src="/common/addlog.js?<%=add_EXTSCRIPT%>"></script>
<% end if %>
<% if (isSuccess) then %>
	<%'<!-- Criteo 세일즈 태그 -->%>
	<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
	<script type="text/javascript">
	window.criteo_q = window.criteo_q || [];
	var deviceType = /iPad/.test(navigator.userAgent) ? "t" : /Mobile|iP(hone|od)|Android|BlackBerry|IEMobile|Silk/.test(navigator.userAgent) ? "m" : "d";
	window.criteo_q.push(
		{ event: "setAccount", account: 8262},
		{ event: "setEmail", email: "<%=CriteoUserMailMD5%>" }, // 유저가 로그인이 안되 있는 경우 빈 문자열을 전달
		{ event: "setSiteType", type: deviceType},
		{ event: "trackTransaction", id: <%=orderserial%>, item: [<%=CriteoScriptAdsItem%>]}
	);
	</script>
	<%'<!-- END Criteo 세일즈 태그 -->%>
<% End If %>
</body>
</html>