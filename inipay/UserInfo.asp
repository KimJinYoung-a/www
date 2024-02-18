<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<%
Response.AddHeader "Cache-Control","no-cache"
Response.AddHeader "Expires","0"
Response.AddHeader "Pragma","no-cache"
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/login/checkBaguniLogin.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/db/dbhelper.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_itemcouponcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_couponcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_pointcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_mileageshopitemcls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_userinfocls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/shoppingbagDBcls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/emscls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/frontGiftCls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_tenCashCls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/classes/giftcard/giftcard_MyCardInfoCls.asp" -->
<!-- #include virtual="/inipay/iniWeb/INIWeb_Util.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/classes/orderCls/clsMyAddress.asp" -->
<!-- #include virtual="/lib/classes/ordercls/sp_myordercls.asp" -->
<!-- #include virtual="/lib/classes/shopping/order_card_discountcls.asp" -->
<%
strPageTitle = "텐바이텐 10X10 : 주문결제"		'페이지 타이틀 (필수)
%>
<!-- #include virtual="/lib/inc/head_SSL.asp" -->
<%
Dim ISQuickDlvUsing : ISQuickDlvUsing = FALSE  ''2018/06/07 , 퀵배송 사용 안할경우 FALSE 로

if (TRUE) or (getLoginUserLevel()="7") then ISQuickDlvUsing=True ''우선 직원만 테스트

'// 바로배송 종료에 따른 처리
If now() > #07/31/2019 12:00:00# Then
	ISQuickDlvUsing = FALSE
End If

Dim G_USE_BAGUNITEMP : G_USE_BAGUNITEMP=TRUE ''임시장바구니 사용여부(2017/12)
if (GetLoginUserLevel="7") then
    G_USE_BAGUNITEMP = TRUE
end if

Dim G_Uagent : G_Uagent = UCASE(Request.ServerVariables("HTTP_USER_AGENT"))
Dim G_IsIE : G_IsIE = InStr(G_Uagent,"MSIE")>0  ''Explore 여부 검사.
G_IsIE = G_IsIE OR (InStr(G_Uagent,"RV:1")>0 and InStr(G_Uagent,"TRIDENT")>0)

Dim G_PG_100_USE_INIWEB : G_PG_100_USE_INIWEB = TRUE ''(NOT G_IsIE) ''INIWEB 사용. (plugin 지원종료 2020.09.01)
Dim isTenLocalUserOrderCheck : isTenLocalUserOrderCheck = TRUE

Dim is20ProDaySeason : is20ProDaySeason = (now()>="2012-10-10") and (now()<"2012-10-23")
'' 상품쿠폰 기본체크 여부 // 20% 행사기간동안 디폴트
Dim IsDefaultItemCouponChecked : IsDefaultItemCouponChecked= is20ProDaySeason '''is20ProDaySeason , False

'' PG 분기 처리
Dim G_PG_400_USE_INIPAY : G_PG_400_USE_INIPAY = TRUE ''true-inipay , false-dacom

Dim G_PG_NAVERPAY_ENABLE : G_PG_NAVERPAY_ENABLE = TRUE	 ''네이버페이 사용여부

Dim G_PG_PAYCO_ENABLE : G_PG_PAYCO_ENABLE = True	''페이코 사용여부

Dim G_PG_HANATEN_ENABLE : G_PG_HANATEN_ENABLE = True	''하나10x10카드 사용여부

Dim G_PG_TOSS_ENABLE : G_PG_TOSS_ENABLE = True ' 토스 사용여부

Dim G_PG_CHAIPAYNEW_ENABLE : G_PG_CHAIPAYNEW_ENABLE = True  ''차이 사용 여부

Dim G_PG_SAMSUNGPAY_ENABLE : G_PG_SAMSUNGPAY_ENABLE = True  ''삼성페이 사용 여부

if (GetLoginUserLevel()="7") or (GetLoginUserID="thensi7") or (GetLoginUserID="skyer9") then
    G_PG_HANATEN_ENABLE = True
	G_PG_TOSS_ENABLE = True
	G_PG_CHAIPAYNEW_ENABLE = True
	G_PG_SAMSUNGPAY_ENABLE= True
end if
if flgDevice="I" then G_PG_SAMSUNGPAY_ENABLE = False

''2015/09/04 추가
if NOT (G_IsIE) then
    ''if (GetLoginUserID="icommang") then
        G_PG_400_USE_INIPAY = FALSE
    ''end if
end if
G_PG_400_USE_INIPAY = FALSE

'// 날짜 선택상자 출력 - 플라워 지정일에만 쓰임 //
Sub DrawOneDateBoxFlower(byval yyyy,mm,dd,tt)
	dim buf,i

	buf = "<select name='yyyy' class='select offInput' title='희망 배송일 년도 선택'>"
    for i=Year(date()-1) to Year(date()+7)
		if (CStr(i)=CStr(yyyy)) then
			buf = buf + "<option value='" + CStr(i) +"' selected>" + CStr(i) + "</option>"
		else
    		buf = buf + "<option value=" + CStr(i) + ">" + CStr(i) + "</option>"
		end if
	next
    buf = buf + "</select>년 "

    buf = buf + "<select name='mm' class='select offInput lMar10' title='희망 배송일 월 선택'>"
    for i=1 to 12
		if (Format00(2,i)=Format00(2,mm)) then
			buf = buf + "<option value='" + Format00(2,i) +"' selected>" + Format00(2,i) + "</option>"
		else
    	    buf = buf + "<option value='" + Format00(2,i) +"'>" + Format00(2,i) + "</option>"
		end if
	next

    buf = buf + "</select>월 "

    buf = buf + "<select name='dd' class='select offInput lMar10' title='희망 배송일 날짜 선택'>"
    for i=1 to 31
		if (Format00(2,i)=Format00(2,dd)) then
	    buf = buf + "<option value='" + Format00(2,i) +"' selected>" + Format00(2,i) + "</option>"
		else
        buf = buf + "<option value='" + Format00(2,i) + "'>" + Format00(2,i) + "</option>"
		end if
    next
    buf = buf + "</select>일 "


    buf = buf & "<select name='tt' class='select offInput lMar10' title='희망 배송일 시간 선택'>"
    for i=9 to 18
		if (Format00(2,i)=Format00(2,tt)) then
        buf = buf & "<option value='" & CStr(i) & "' selected>" & CStr(i) & "~" & CStr(i + 2) & "</option>"
		else
        buf = buf & "<option value='" & CStr(i) & "'>" & CStr(i) & "~" & CStr(i + 2) & "</option>"
		end if
    next
    buf = buf & "</select>시 "

    response.write buf
end Sub

Dim jumunDiv : jumunDiv = request("bTp")
Dim IsForeignDlv : IsForeignDlv = (jumunDiv="f")        ''해외 배송 여부
Dim IsArmyDlv    : IsArmyDlv = (jumunDiv="a")              ''군부대 배송 여부
Dim IsQuickDlv   : IsQuickDlv = (jumunDiv="q")              ''퀵배송가능여부
Dim countryCode  : countryCode = request("ctrCd")
dim reload : reload = requestcheckvar(request("reload"),2)
Dim r

'// 바로배송 업체나 기타 이유로 잠시 중지 할 경우 처리						
Dim isQuickDlvStatusCheck
isQuickDlvStatusCheck = True
If (Now() >= #02/27/2019 13:00:00# AND Now() < #03/01/2019 00:00:00#) Then
	isQuickDlvStatusCheck = False
End if

'// 바로배송일 경우 바로배송 기타 사정으로 제공하지 못할경우 처리
If IsQuickDlv Then
	If Not(isQuickDlvStatusCheck) Then
		IsQuickDlv = false
	End If
End If

if (NOT ISQuickDlvUsing) and (IsQuickDlv) then
    response.write "<script>alert('바로배송(퀵) 서비스가 잠시 중단되었습니다.');</script>"
    IsQuickDlv = FALSE
end if

''20090603추가 KBCARD제휴
Dim IsKBRdSite : IsKBRdSite = (LCase(irdsite20)="kbcard")
IsKBRdSite = FALSE '' 사용중지 2013/12/16
''20090812추가 OKCashBAG
Dim IsOKCashBagRdSite
If LCase(irdsite20)="okcashbag" OR LCase(irdsite20)="pickle" Then
	IsOKCashBagRdSite = False	'로직 수정전까지 비활성홓
Else
	IsOKCashBagRdSite = False
End If

''if (IsOKCashBagRdSite) or (IsKBRdSite) then G_PG_100_USE_INIWEB = false ''2015/11/24 추가

''201004 가상계좌 추가
Dim IsCyberAccountEnable : IsCyberAccountEnable = TRUE      ''가상계좌 사용 여부 : False인경우 기존 무통장

''IsOKCashBagRdSite = FALSE
''if (GetLoginUserID<>"icommang") then IsOKCashBagRdSite=FALSE


Dim kbcardsalemoney : kbcardsalemoney = 0

'' 사이트 구분
Const sitename = "10x10"
'' 할인권 사용 가능 여부
Const IsSailCouponDisabled = False
'' InVail 할인권 Display여부
Const IsShowInValidCoupon =TRUE

'' InVail 상품쿠폰 Display여부
Const IsShowInValidItemCoupon =False

'' 최소 마일리지 사용금액
Const mileageEabledTotal = 30000

'' 마일리지 사용가능여부
Dim IsMileageDisabled, MileageDisabledString
IsMileageDisabled = False

'' 예치금 사용가능 여부
Dim IsTenCashEnabled
IsTenCashEnabled = False

''Gift카드 사용가능여부
Dim IsEGiftMoneyEnable
IsEGiftMoneyEnable = False

''주문제작 상품 문구 적지 않은 상품
dim NotWriteRequireDetailExists

dim userid, guestSessionID, i, j, isBaguniUserLoginOK
If IsUserLoginOK() Then
	userid = getEncLoginUserID ''GetLoginUserID
	isBaguniUserLoginOK = true
Else
	userid = GetLoginUserID
	isBaguniUserLoginOK = false
End If
guestSessionID = GetGuestSessionKey

'//선물포장서비스 해외배송, 군부대배송 지원안함 로직상 처리는 되어 있음. TRUE로 놓으면 동작함		'/2015.11.11 한용민 생성
if IsForeignDlv or IsArmyDlv then
	G_IsPojangok = FALSE
end if

'//선물포장서비스 회원전용		'/2015.11.11 한용민 생성
'if not(isBaguniUserLoginOK) then
'	G_IsPojangok = FALSE
'end if

dim vShoppingBag_pojang_CheckNotexistsitem
	vShoppingBag_pojang_CheckNotexistsitem=0

'선물포장서비스 노출		'/2015.11.11 한용민 생성
''if G_IsPojangok then  '' 주석처리 2017/02/10 eastone
	'//첫로딩시 선물포장서비스 임시 테이블 비움
	if reload <> "ON" then
		'vShoppingBag_pojang_CheckNotexistsitem = getShoppingBag_temppojang_CheckNotexistsitem("","")
		'/선물포장 상품이 장바구니 상품과 일치하지 않음
		'if vShoppingBag_pojang_CheckNotexistsitem=1 then
			'//선물포장서비스 임시 테이블 비움
			call getpojangtemptabledel("")
		'end if
	end if
''end if

dim oUserInfo, chkKakao
set oUserInfo = new CUserInfo
oUserInfo.FRectUserID = userid
if (userid<>"") then
	If GetLoginUserLevel="9" Then
		oUserInfo.GetBizUserData
	Else
		oUserInfo.GetUserData
	End If
    
	chkKakao = oUserInfo.chkKakaoAuthUser	'// 카카오톡 인증여부
    if date>"2015-12-31" then
    	chkKakao = false
	end if
end if

if (oUserInfo.FresultCount<1) then
    ''Default Setting
    set oUserInfo.FOneItem    = new CUserInfoItem
end if

dim oshoppingbag
set oshoppingbag = new CShoppingBag
oshoppingbag.FRectUserID = userid
oshoppingbag.FRectSessionID = guestSessionID
oShoppingBag.FRectSiteName  = sitename

''위치변경 2013/09/12
if (IsForeignDlv) then
    if (countryCode<>"") then
        oshoppingbag.FcountryCode = countryCode
    else
        oshoppingbag.FcountryCode = "AA"
    end if
elseif (IsArmyDlv) then
    oshoppingbag.FcountryCode = "ZZ"
end if

oshoppingbag.GetShoppingBagDataDB_Checked

''위치변경
if oshoppingbag.IsShoppingBagVoid then
    dbget.close()
    response.redirect wwwURL&"/inipay/shoppingbag.asp"
    response.end
end if

dim pojangcash, pojangcnt, vShoppingBag_pojang_checkValidItem, pojangcompleteyn
	pojangcash=0
	pojangcnt=0
	vShoppingBag_pojang_checkValidItem=0
	pojangcompleteyn="N"

'선물포장서비스 노출		'/2015.11.11 한용민 생성
if G_IsPojangok then
	'/선물포장가능상품
	if oshoppingbag.IsPojangValidItemExists then
		'/선물포장완료상품존재
		if oshoppingbag.IsPojangcompleteExists then
			pojangcash = oshoppingbag.FPojangBoxCASH		'/포장비
			pojangcnt = oshoppingbag.FPojangBoxCNT		'/포장박스갯수

			'/장바구니 상품과 선물포장 임시 상품이 유효한 상품인지 체크
			vShoppingBag_pojang_checkValidItem = getShoppingBag_temppojang_checkValidItem("TT","Y")
			if vShoppingBag_pojang_checkValidItem=1 then
				'//선물포장서비스 임시 테이블 비움
				call getpojangtemptabledel("")
				response.write "<script type='text/javascript'>alert('장바구니에 담긴 상품 수량 보다 선물포장이 된 상품 수량이 더많습니다.\n\n다시 포장해 주세요.');</script>"
				'dbget.close()	:	response.end
			elseif vShoppingBag_pojang_checkValidItem=2 then
				'response.write "<script type='text/javascript'>alert('장바구니에 담긴 상품이 없습니다.');</script>"
				'dbget.close()	:	response.end
			elseif vShoppingBag_pojang_checkValidItem=3 then
				pojangcompleteyn="Y"
				'response.write "<script type='text/javascript'>alert('더이상 선물포장이 가능한 상품이 없습니다.');</script>"
				'dbget.close()	:	response.end
			end if
		end if
	end if
end if

''업체 개별 배송비 상품이 있는경우
if (oshoppingbag.IsUpcheParticleBeasongInclude)  then
    oshoppingbag.GetParticleBeasongInfoDB_Checked
end if

dim goodname
goodname = oshoppingbag.getGoodsName
goodname = replace(goodname,"'","")

if (userid="queenkinglove") then 
   goodname = LEFT(goodname,25)  ''은련카드 관련 한글영문관계없이 50Byte :: INICIS에서 수정한다고함. 2015/08/06
end if

''KB카드 할인액
if (IsKBRdSite) then
    oshoppingbag.FDiscountRate = 0.95
    kbcardsalemoney = oshoppingbag.GetAllAtDiscountPrice
end if

Dim IsRsvSiteOrder : IsRsvSiteOrder = oshoppingbag.IsRsvSiteSangpumExists
Dim IsPresentOrder : IsPresentOrder = oshoppingbag.IsPresentSangpumExists
Dim IsEventOrderItem : IsEventOrderItem = oshoppingbag.IsEvtItemSangpumExists
dim availtotalMile
dim oSailCoupon, oItemCoupon, oMileage
availtotalMile = 0

'// 10x10 Present주문일경우 주문 제한수 확인 및 안내
if IsPresentOrder then
	if oshoppingbag.isPresentItemOrderLimitOver(userid,1) then
		''Call Alert_Return("고객님께서는 10x10 PRESENT 상품을 이미 2회 주문하셨습니다.\n(한 ID당 최대 2회까지만 주문가능)")
		Call Alert_Return("고객님께서는 10x10 PRESENT 상품을 이미 주문하셨습니다.\n(한 회차당 1회만 주문가능)")
		dbget.Close: response.End
	end if
end if

'// 구매제한 상품의 주문일 경우 주문 제한수 확인 및 안내
if IsEventOrderItem then
	if (userid="" or isNull(userid)) then
        Call Alert_Return("한정구매 상품이 포함되어 있습니다.\n\n로그인 후 주문을 진행해주세요.")
        dbget.Close: response.End
    else
        dim vEvtItemLmNo: vEvtItemLmNo=1
        if oshoppingbag.isEventOrderItemLimitOver(userid,vEvtItemLmNo) then
            Call Alert_Return("고객님께서는 이벤트 상품을 이미 주문하셨습니다.\n(한 ID당 최대 " & vEvtItemLmNo & "개까지 주문가능)")
            dbget.Close: response.End
        end if
    end if
end if

Dim MaxPresentItemNo: MaxPresentItemNo=1
Dim IsPresentLimitOver : IsPresentLimitOver = FALSE
Dim TenDlvItemPriceCpnNotAssign : TenDlvItemPriceCpnNotAssign = oshoppingbag.GetTenDeliverItemPrice '' 쿠폰적용전 텐배송상품금액 //201210 다이어리이벤트관련 필요
Dim TenDlvItemPrice : TenDlvItemPrice = TenDlvItemPriceCpnNotAssign

if (IsPresentOrder) then
    IsMileageDisabled = true
    MileageDisabledString = "(Present상품은 마일리지 사용 불가)"

    MaxPresentItemNo = oshoppingbag.FItemList(0).GetLimitOrderNo
    IsPresentLimitOver = (oshoppingbag.FItemList(0).FItemEa > MaxPresentItemNo)
end if

set oSailCoupon = new CCoupon
oSailCoupon.FRectUserID = userid
oSailCoupon.FPageSize=100

if (userid<>"") and (Not IsKBRdSite) and (Not IsRsvSiteOrder) and (Not IsPresentOrder) then   ''현장수령/Present 상품 쿠폰 사용 불가
	oSailCoupon.getValidCouponList
end if

'' (%) 보너스쿠폰 존재여부 - %할인쿠폰이 있는경우만 [%할인쿠폰제외상품]표시하기위함
dim intp, IsPercentBonusCouponExists
IsPercentBonusCouponExists = false
for intp=0 to oSailCoupon.FResultCount-1
    if (oSailCoupon.FItemList(intp).FCoupontype=1) then
        IsPercentBonusCouponExists = true
        Exit for
    end if
next

set oItemCoupon = new CUserItemCoupon
oItemCoupon.FRectUserID = userid
oItemCoupon.FPageSize=100

if (userid<>"") and (Not IsKBRdSite) and (Not IsRsvSiteOrder) and (Not IsPresentOrder) then  ''현장수령/Present 상품 쿠폰 사용 불가
	oItemCoupon.getValidItemCouponListInBaguni  ''2018/10/22
end if

'' 상품 쿠폰 적용.
dim IsItemFreeBeasongCouponExists
IsItemFreeBeasongCouponExists = false
for i=0 to oItemCoupon.FResultCount-1
	if oshoppingbag.IsCouponItemExistsByCouponIdx(oItemCoupon.FItemList(i).Fitemcouponidx) then
		oshoppingbag.AssignItemCoupon(oItemCoupon.FItemList(i).Fitemcouponidx)

		if (oshoppingbag.IsCouponItemExistsByCouponIdx(oItemCoupon.FItemList(i).Fitemcouponidx)) and (oitemcoupon.FItemList(i).IsFreeBeasongCoupon) then
		    IsItemFreeBeasongCouponExists = true
		end if
	end if
next

set oMileage = new TenPoint
oMileage.FRectUserID = userid
if (userid<>"") then
    oMileage.getTotalMileage

    availtotalMile = oMileage.FTotalMileage
end if

if availtotalMile<1 then availtotalMile=0


''플라워 배송 기본 값
Dim nowdate,nowtime,yyyy,mm,dd,tt,hh
nowdate = Left(CStr(now()),10)
nowtime = Left(FormatDateTime(CStr(now()),4),2)

if (yyyy="") then
	yyyy = Left(nowdate,4)
	mm   = Mid(nowdate,6,2)
	dd   = Mid(nowdate,9,2)
	hh = nowtime
    tt = nowtime + oshoppingbag.getFixDeliverOrderLimitTime
end if

''실결제액.
dim subtotalprice
'dim itemsumTotal
'if (IsDefaultItemCouponChecked) then
'    itemsumTotal = oshoppingbag.GetTotalItemOrgPrice
'else
'    itemsumTotal = oshoppingbag.GetTotalItemOrgPrice
'end if

subtotalprice = oshoppingbag.GetTotalItemOrgPrice + oshoppingbag.GetOrgBeasongPrice + pojangcash - oshoppingbag.GetMileageShopItemPrice

Dim IsZeroPrice : IsZeroPrice= (subtotalprice=0)
if (userid="") then
    IsMileageDisabled = true
    MileageDisabledString = "(로그인 하셔야 사용 하실 수 있습니다)"
elseif (oshoppingbag.GetMileshopItemCount>0) then
    IsMileageDisabled = true
    MileageDisabledString = "(마일리지샵 상품 구매시 추가 사용 불가)"
elseif (oshoppingbag.GetTotalItemOrgPrice<mileageEabledTotal) then
    IsMileageDisabled = true
    MileageDisabledString = "(상품금액 30,000원 이상 구매시 사용가능)"
end if

''적용 가능한 쿠폰수
dim vaildItemCouponCount, vaildCouponCount
vaildItemCouponCount = 0
vaildCouponCount     = 0

dim checkitemcouponlist

dim iErrMsg

''===EMS 관련============
Dim oems : SET oems = New CEms
Dim oemsPrice : SET oemsPrice = New CEms
if (IsForeignDlv) then
    oems.FRectCurrPage = 1
    oems.FRectPageSize = 200
    oems.FRectisUsing  = "Y"
    oems.GetServiceAreaList

    oemsPrice.FRectWeight = oshoppingbag.getEmsTotalWeight
    oemsPrice.GetWeightPriceListByWeight
end if

''===사은품 선택 전체증정이벤트 =========
Dim OpenGiftExists : OpenGiftExists = FALSE
Dim CouponGiftExists : CouponGiftExists = FALSE
Dim DiaryOpenGiftExists : DiaryOpenGiftExists = FALSE
Dim DiaryGiftCNT : DiaryGiftCNT = 0
Dim TenDlvItemPriceCpnAssign : TenDlvItemPriceCpnAssign = oshoppingbag.GetTenDeliverItemPrice ''상품쿠폰 적용시 값이 달라짐.

if (IsDefaultItemCouponChecked) then
    TenDlvItemPrice = TenDlvItemPriceCpnAssign
end if

Dim OpenEvt_code, banImage, evtDesc, evtStDT, evtEdDt, devtDesc, devtStDT, devtEdDt
Dim Diary_OpenEvt_code, Diary_banImage
Dim oOpenGift, oDiaryOpenGift
Dim oOpenGiftDepth
Dim CGiftsRows
Dim CGiftsCols

Dim CDiGiftsRows : CDiGiftsRows = 1
Dim CDiGiftsCols : CDiGiftsCols = 4

Set oOpenGift = new CopenGift
set oOpenGiftDepth = New CopenGift
Set oDiaryOpenGift = new CopenGift
dim giftCheck : giftCheck = True '사은품 표기 온오프

oOpenGift.FRectGiftScope = "1"		'전체사은이벤트 범위 지정(1:전체,3:모바일,5:APP) - 2014.08.18; 허진원
oDiaryOpenGift.FRectGiftScope = "1"

if (IsUserLoginOK) then
    OpenGiftExists = oOpenGift.IsOpenGiftExists(OpenEvt_code, banImage, evtDesc, evtStDT, evtEdDt)
    DiaryOpenGiftExists = oOpenGift.IsDiaryOpenGiftExistsWithDesc(Diary_OpenEvt_code, Diary_banImage, devtDesc, devtStDT, devtEdDt)
end if

if (OpenGiftExists) then
    oOpenGift.getGiftItemList(OpenEvt_code)
    CouponGiftExists = oOpenGift.IsCouponGiftExists(subtotalPrice)
end if

if (DiaryOpenGiftExists) then
    DiaryGiftCNT = fnGetDiaryGiftsCount(userid,Diary_OpenEvt_code)          ''다이어리갯수==다이어리 증정사은품수량/ 금액체크
    'IF (TenDlvItemPriceCpnNotAssign<15000) then DiaryGiftCNT=0              ''추가/임시
    if (DiaryGiftCNT<1) then
        DiaryOpenGiftExists = FALSE
    else
        oDiaryOpenGift.getDiaryGiftItemList(Diary_OpenEvt_code)
        ''최소 Range보다 금액이 적을경우 표시안함.
        if (subtotalPrice<oDiaryOpenGift.FItemList(0).Fgift_range1) then
            DiaryOpenGiftExists = FALSE
        end if		
    end if
end if
'2022.01.03 정태훈 다이어리 사은품 강제 종료
DiaryOpenGiftExists = FALSE
''최소 Range보다 금액이 적을경우 표시안함. // 텐배송 존재해야 표시.
Dim TenBeasongInclude : TenBeasongInclude = oshoppingbag.IsTenBeasongInclude
if (OpenGiftExists) then
    if (Not TenBeasongInclude) and (Not CouponGiftExists) then
        OpenGiftExists = FALSE
    end if
end if

if (OpenGiftExists) then
    if (oOpenGift.FResultCount>0) then
        oOpenGiftDepth.getOpenGiftDepth(OpenEvt_code)
        CGiftsCols = oOpenGiftDepth.getMaxCols

        ''최소 Range보다 금액이 적을경우 표시안함.
        if (subtotalPrice<oOpenGift.FItemList(0).Fgift_range1) then
            OpenGiftExists = FALSE
        end if
    end if
end if

''예치금 추가
Dim oTenCash, availtotalTenCash
availtotalTenCash = 0
set oTenCash = new CTenCash
oTenCash.FRectUserID = userid
if (userid<>"") then
    oTenCash.getUserCurrentTenCash

    availtotalTenCash = oTenCash.Fcurrentdeposit

    IF (availtotalTenCash>0) then
        IsTenCashEnabled = true
    ELSE
        availtotalTenCash =0    '' 2013/11/06추가
    End IF
end if

'' GiftCard
Dim oGiftCard, availTotalGiftMoney
availTotalGiftMoney = 0
set oGiftCard = new myGiftCard
oGiftCard.FRectUserID = userid
if (userid<>"") then
    availTotalGiftMoney = oGiftCard.myGiftCardCurrentCash

    IF (availTotalGiftMoney>0) then
        IsEGiftMoneyEnable = true
    else
        availTotalGiftMoney = 0   '' 2013/11/06추가
    End IF
end if

'//특정유저 기프트카드 결제를 제한한다(카드 부정사용으로 인한 조치)2021.11.16일 부
If userid="cjstmdgh70" or userid="dudcjf9999" or userid="roqhfo11" or userid="a1771771122" Then
	IsEGiftMoneyEnable = False
End If

Dim IsTicketOrder : IsTicketOrder = oshoppingbag.IsTicketSangpumExists
Dim IsTravelItem : IsTravelItem = oshoppingbag.IsTravelSangpumExists
Dim IsClassItem : IsClassItem =oshoppingbag.IsClassSangpumExists
Dim PreBuyedTicketNo : PreBuyedTicketNo =0
Dim MaxTicketNo: MaxTicketNo=4
Dim IsTicketLimitOver : IsTicketLimitOver = FALSE
if (IsTicketOrder) then
    ''IsMileageDisabled = true
    ''MileageDisabledString = "(티켓상품은 마일리지 사용 불가)"

	' 티켓 상품 중 클래스 상품일 경우 할인쿠폰, 상품쿠폰 적용가능, 일반 티켓은 사용 불가(2018-05-03 정태훈)
	If Not (IsClassItem) Then
		oItemCoupon.FResultCount = 0
		oSailCoupon.FResultCount = 0
	End If

    IF (userid="10x10phone") then
        PreBuyedTicketNo = 0
    else
        PreBuyedTicketNo = GetPreOrderTickets(userid,oshoppingbag.FItemList(0).FItemID,oshoppingbag.FItemList(0).FMakerid)
    end if

    MaxTicketNo = oshoppingbag.FItemList(0).GetLimitOrderNo
    ''IsTicketLimitOver = ((PreBuyedTicketNo + oshoppingbag.FItemList(0).FItemEa) >MaxTicketNo)
    IsTicketLimitOver = ((PreBuyedTicketNo + oshoppingbag.GetTotalItemEa) >MaxTicketNo) 
end if

Dim oTicketItem, TicketDlvType
Dim TicketBookingExired : TicketBookingExired=FALSE

'201204추가 리뉴얼기념 이벤트 // 변경시 js 확인해야함.. //버림 함수
Dim IsUsePaybackMile , ipaybackmile
IsUsePaybackMile = FALSE ''(IsUserLoginOK) and (is20ProDaySeason)
IF (IsUsePaybackMile) then
	IF (subtotalprice>=300000) then
		ipaybackmile = CLNG(Fix(subtotalprice*0.1))
	ELSEIF (subtotalprice>=200000) then
		ipaybackmile = CLNG(Fix(subtotalprice*0.08))
	ELSEIF (subtotalprice>=100000) then
		ipaybackmile = CLNG(Fix(subtotalprice*0.05))
	ELSE
		ipaybackmile = 0
	END IF

	if (ipaybackmile<1) then IsUsePaybackMile=FALSE
end if

Dim isTenLocalUser : isTenLocalUser = false

if (GetLoginUserLevel()="7") or (GetLoginUserLevel()="8") then
    isTenLocalUser = true
end If

Dim vIsTravelItemExist, vIsDeliveItemExist, vIsTravelIPExist, vIsTravelJAExist, isRentalCheck
vIsDeliveItemExist = False
vIsTravelItemExist = False
vIsTravelIPExist = False
vIsTravelJAExist = False
isRentalCheck = False
for i=0 to oshoppingbag.FShoppingBagItemCount - 1
	'### 인터파크여행상품이 있는지 체크
	If oshoppingbag.FItemList(i).Fitemdiv = "18" AND oshoppingbag.FItemList(i).Fmakerid = "interparktour" Then
		vIsTravelItemExist = True
		vIsTravelIPExist = True
	End If
	
	'### 인터파크여행상품이 있으면서 일반 상품도 있는지 체크. 일반상품있는경우 따로 체크되는 변수있어야함.
	If Not(oshoppingbag.FItemList(i).Fitemdiv = "18" AND oshoppingbag.FItemList(i).Fmakerid = "interparktour") Then
		vIsDeliveItemExist = True
	End If

	'### 진에어 항공권 상품이 있는지 체크
	If oshoppingbag.FItemList(i).Fitemdiv = "18" AND oshoppingbag.FItemList(i).Fmakerid = "10x10Jinair" Then
		vIsTravelItemExist = True
		vIsTravelJAExist = True
	End If

	'### 렌탈 상품이 있는지 체크 있으면 userinfoRental로 넘겨야함
	If oshoppingbag.FItemList(i).Fitemdiv = "30" Then
		isRentalCheck = true
	End If
Next

'### 렌탈 상품이 있고 한개일 경우엔 userinforental.asp로 이동 한개 이상일 경우엔 alert 메시지 띄우고 장바구니로 이동시킴
If isRentalCheck Then
	If oshoppingbag.FShoppingBagItemCount = 1 Then
		response.redirect SSLUrl&"/inipay/userinfoRental.asp"
		response.end
	Else
		If oshoppingbag.FShoppingBagItemCount > 1 Then
			response.write "<script>alert('렌탈 상품은 단독으로 1개 상품만 구매 가능합니다.');location.href='/inipay/shoppingbag.asp';</script>"
			response.End
		End If
	End If
End If

Dim cOldMy, vOldCnt, vMyCnt, vKRdeliNotOrder, vGiftTabView, vGiftTabTemp
vOldCnt = 0
vMyCnt = 0
vGiftTabView = 0
vKRdeliNotOrder = "x"
if (IsUserLoginOK) then
	Set cOldMy = New clsMyAddress
	cOldMy.FRectUserId = userid
	cOldMy.FRectCountryCode = CHKIIF(IsForeignDlv,"","KR")
	cOldMy.fnRecentCntMyCnt
	vOldCnt = cOldMy.FOLDCnt
	vMyCnt = cOldMy.FMYCnt
	Set cOldMy = Nothing
	
	'### 국내배송 and 최근배송이 없을때 기본 셋팅
	If IsForeignDlv = False AND CInt(vOldCnt) < 1 Then
		vKRdeliNotOrder = "o"
	End If
end If

'####### 텐바이텐 체크 카드(하나) 전용 결제 상품 확인 (밀키머그) 2018-05-15 정태훈
Dim vlsOnlyHanaTenPayExist
vlsOnlyHanaTenPayExist = False
If (oshoppingbag.IsOnlyHanaTenPayValidItemExists) Then
	vlsOnlyHanaTenPayExist = True
End If

''퀵배송관련(2018/06/07)
Dim isQuickDlvBoxShown
isQuickDlvBoxShown = oshoppingbag.IsOnlyQuickAvailItemExists
isQuickDlvBoxShown = isQuickDlvBoxShown AND (NOT IsForeignDlv) AND (NOT IsArmyDlv) 
isQuickDlvBoxShown = isQuickDlvBoxShown AND (ISQuickDlvUsing)

if (NOT isQuickDlvBoxShown) and (IsQuickDlv) then IsQuickDlv=False
    
Dim IsQuickInvalidTime, IsTodayHoilDay
IsTodayHoilDay = ((weekDay(now())=1) or (weekDay(now())=7))  ''일요일,토요일은 쉼.
IsQuickInvalidTime = (Hour(now())>=13)
IsQuickInvalidTime = IsQuickInvalidTime OR IsTodayHoilDay
''일반 공휴일.. DB쿼리
if (isQuickDlvBoxShown) then
    IsTodayHoilDay = IsTodayHoilDay OR fnIsHolidayFromDB(LEFT(CStr(date()),10))
    IsQuickInvalidTime = IsQuickInvalidTime OR IsTodayHoilDay
end If

'// 하나체크 전용상품 관련
Dim HanaCheckCardItemCheckCount
HanaCheckCardItemCheckCount = 0
for i=0 to oshoppingbag.FShoppingBagItemCount - 1
	If oshoppingbag.FItemList(i).IsOnlyHanaTenPayValidItem() Then
		HanaCheckCardItemCheckCount = HanaCheckCardItemCheckCount + 1
	End If
Next
If HanaCheckCardItemCheckCount > 1 Then
	response.write "<script>alert('본 상품은 이벤트 상품으로 1인 1개만 구매가 가능합니다.');location.href='/inipay/shoppingbag.asp';</script>"
	response.End
End If

'// 제 3자 동의 브랜드 목록
Dim brandEnNames
brandEnNames = ", "
for i=0 to oshoppingbag.FShoppingBagItemCount - 1
    If oshoppingbag.FItemList(i).FBrandNameEn <> "" And Not(InStr(brandEnNames, ", " & oshoppingbag.FItemList(i).FBrandNameEn & ",") > 0) Then
        brandEnNames = brandEnNames & oshoppingbag.FItemList(i).FBrandNameEn & ", "
    End If
Next
If brandEnNames <> ", " Then
    brandEnNames = MID(brandEnNames, 3, LEN(brandEnNames) - 4)
End If
%>
<script src="/lib/js/jquery.form.min.js"></script>
<script type="text/javascript" >
$(document).unbind("dblclick"); //
var ChkErrMsg;
var ChkAlert = true;
// 플러그인 설치(확인)
//StartSmartUpdate();//move

var calByte = {
	getByteLength : function(s) {
		if (s == null || s.length == 0) {
			return 0;
		}
		var size = 0;

		for ( var i = 0; i < s.length; i++) {
			size += this.charByteSize(s.charAt(i));
		}

		return size;
	},
		
	cutByteLength : function(s, len) {
		if (s == null || s.length == 0) {
			return '';
		}
		var size = 0;
		var rIndex = s.length;

		for ( var i = 0; i < s.length; i++) {
			size += this.charByteSize(s.charAt(i));
			if( size == len ) {
				rIndex = i + 1;
				break;
			} else if( size > len ) {
				rIndex = i;
				break;
			}
		}

		return s.substring(0, rIndex);
	},
// db기준
	charByteSize : function(ch) {
		if (ch == null || ch.length == 0) {
			return 0;
		}
		var charCode = ch.toString().charCodeAt(0);

		if ((charCode > 255) || (charCode < 0)){
			return 2
		}else {
			return 1
		}
	}
};

function chkLength(ele, maxByte){
	var currentTxt = ele.value	
	ele.value = calByte.cutByteLength(currentTxt, 32)	
}
function DownloadCouponWithReload(itemcouponidx){
	var popwin=window.open('/my10x10/downloaditemcoupon.asp?itemcouponidx=' + itemcouponidx + '&prload=on','DownloadCoupon','width=550,height=550,scrollbars=no,resizable=no');
	popwin.focus();
}

function check_form_email(email){
	var pos;
	pos = email.indexOf('@');
	if (pos < 0){				//@가 포함되어 있지 않음
		return(false);
	}else{

		pos = email.indexOf('@', pos + 1)
		if (pos >= 0)			//@가 두번이상 포함되어 있음
			return(false);
	}

	pos = email.indexOf('.');

	if (pos < 0){				//@가 포함되어 있지 않음
		return false;
    }
	return(true);
}

function upUserInfo(frm){
    if ((frm.buyphone1.value.length<2)||(!IsDigit(frm.buyphone1.value))){
        alert('주문자 전화번호를 입력하세요.');
        frm.buyphone1.focus();
        return false;
    }

    if ((frm.buyphone2.value.length<3)||(!IsDigit(frm.buyphone2.value))){
        alert('주문자 전화번호를 입력하세요.');
        frm.buyphone2.focus();
        return false;
    }

    if ((frm.buyphone3.value.length<3)||(!IsDigit(frm.buyphone3.value))){
        alert('주문자 전화번호를 입력하세요.');
        frm.buyphone3.focus();
        return false;
    }

    if ((frm.buyhp1.value.length<2)||(!IsDigit(frm.buyhp1.value))){
        alert('주문자 핸드폰번호를 입력하세요.');
        frm.buyhp1.focus();
        return false;
    }

    if ((frm.buyhp2.value.length<3)||(!IsDigit(frm.buyhp2.value))){
        alert('주문자 핸드폰번호를 입력하세요.');
        frm.buyhp2.focus();
        return false;
    }

    if ((frm.buyhp3.value.length<3)||(!IsDigit(frm.buyhp3.value))){
        alert('주문자 핸드폰번호를 입력하세요.');
        frm.buyhp3.focus();
        return false;
    }

    if (frm.buyemail_Pre.value.length<1){
        alert('주문자 이메일 주소를 입력하세요.');
        frm.buyemail_Pre.focus();
        return false;
    }
    if (frm.buyemail_Bx.value.length<4){
        if (!check_form_email(frm.buyemail_Pre.value + '@' + frm.buyemail_Tx.value)){
            alert('주문자 이메일 주소가 올바르지 않습니다.');
            frm.buyemail_Tx.focus();
            return false;
        }
    }

    if (frm.buyemail_Bx.value.length<4){
        frm.buyemail.value = frm.buyemail_Pre.value + '@' + frm.buyemail_Tx.value;
    }else{
        frm.buyemail.value = frm.buyemail_Pre.value + '@' + frm.buyemail_Bx.value;
    }

//    if ((frm.buyZip1.value.length<1)||(frm.buyZip2.value.length<1)||(frm.buyAddr1.value.length<1)){
//        alert('주문자 주소를  입력하세요.');
//        return false;
//    }

    if (frm.buyZip.value.length<1){
        alert('주문자 주소를  입력하세요.');
        return false;
    }

	/*
    if (frm.buyAddr2.value.length<1){
        alert('주문자 상세 주소를  입력하세요.');
        frm.buyAddr2.focus();
        return false;
	}
	*/

    var popwin = window.open('','popOrderBuyerInfoEdit','width=460,height=507,scrollbars=auto,resizable=yes');
    popwin.focus();
    frm.target = "popOrderBuyerInfoEdit";
    frm.action = "/inipay/popOrderBuyerInfoEdit.asp";
    frm.submit();
}

function copyDefaultinfo(comp){
    var frm = document.frmorder;
	$("#lySelMyAddr").hide();

    if (comp.value=="O"){
        frm.reqname.value=frm.buyname.value;

		frm.reqphone1.value=frm.buyphone1.value;
		frm.reqphone2.value=frm.buyphone2.value;
		frm.reqphone3.value=frm.buyphone3.value;

		frm.reqhp1.value=frm.buyhp1.value;
		frm.reqhp2.value=frm.buyhp2.value;
		frm.reqhp3.value=frm.buyhp3.value;

		if (frm.buyZip){
//		    frm.txZip1.value = frm.buyZip1.value;
//		    frm.txZip2.value = frm.buyZip2.value;
            if (frm.txZip){
    		    frm.txZip.value = frm.buyZip.value;
    		    frm.txAddr1.value = frm.buyAddr1.value;
    		    frm.txAddr2.value = frm.buyAddr2.value;
    		}
		}

    }else if (comp.value=="N"){
        frm.reqname.value = "";
        frm.reqphone1.value = "";
        frm.reqphone2.value = "";
        frm.reqphone3.value = "";
        frm.reqhp1.value = "";
        frm.reqhp2.value = "";
        frm.reqhp3.value = "";
//      frm.txZip1.value = "";
//      frm.txZip2.value = "";
        if (frm.txZip){
            frm.txZip.value = "";
            frm.txAddr1.value = "";
            frm.txAddr2.value = "";
        }
    }else if (comp.value=="M"){     //해외주소New
        frm.reqname.value = "";
        frm.reqphone1.value = "";
        frm.reqphone2.value = "";
        frm.reqphone3.value = "";
        frm.reqphone4.value = "";

        frm.reqemail.value = "";
        frm.emsZipCode.value = "";

        frm.txAddr1.value = "";
        frm.txAddr2.value = "";
    }else if (comp.value=="F"){
        PopSeaAddress();
    }else if (comp.value=="P"){
		frm.reqname.value = "";
        frm.reqphone1.value = "";
        frm.reqphone2.value = "";
        frm.reqphone3.value = "";
        frm.reqhp1.value = "";
        frm.reqhp2.value = "";
        frm.reqhp3.value = "";
        if (frm.txZip){
            frm.txZip.value = "";
            frm.txAddr1.value = "";
            frm.txAddr2.value = "";
        }
        fnGetMyAddress("my");
    	$("#lySelMyAddr").show();
    }
}

// 기본 주소록
$(function(){
	fnAmplitudeEventMultiPropertiesAction("view_userinfo","","");
	<% If vIsDeliveItemExist Then %>
		<% If CInt(vOldCnt) > 0 Then %>
			<% If Not(IsTicketOrder) Then %>
				<%'// 최근 배송지%>
				copyDefaultinfo(document.getElementsByName("rdDlvOpt")[1]);
			<% End If %>
		<% else %>
			<%'// 주문고객 정보와 동일%>
	    	copyDefaultinfo(document.getElementsByName("rdDlvOpt")[0]);
		<% End If %>
	<% End If %>
});

// 주소록 접수
function fnGetMyAddress(gb) {
	var strRst = "", vRtn="";
	var defaultexist = "x";
	switch(gb) {
		case "my":
			if($("#lySelMyAddr").html()=="") {
				$.ajax({
					url: "/my10x10/Myaddress/act_MyAddressList.asp?ctrCd=KR&div=old&psz=50",
					cache: false,
					success: function(rst) {
						var vLp=1;
						if($(rst).find("item").length>0) {
							vRtn = '<option value="" tReqname="" tTxAddr1="" tTxAddr2="" tReqPhone="--" tReqHp="--" tReqZipcode="-" tReqemail="" tCountryCode="" tEmsAreaCode="">배송지를 선택 해주세요</option>';
							$(rst).find("item").each(function(){
								vRtn += '<option value="'+ vLp +'" tReqname="'+ $(this).find("name").text() +'" tTxAddr1="'+ $(this).find("addr1").text() +'" tTxAddr2="'+ $(this).find("addr2").text() +'" tReqPhone="'+ $(this).find("tel").text() +'" tReqHp="'+ $(this).find("hp").text() +'" tReqZipcode="'+ $(this).find("zip").text() +'" tReqemail="'+ $(this).find("email").text() +'" tCountryCode="'+ $(this).find("countryCd").text() +'" tEmsAreaCode="'+ $(this).find("emsCd").text() +'"  >';
								vRtn += $(this).find("name").text() + ' | ' + $(this).find("addr1").text() + ' ' + $(this).find("addr2").text();
								vRtn += '</option>';
								vLp++;
							});

							defaultexist = "o";
						} else {
							vRtn = '<option>등록된 최근 배송지가 없습니다.</option>';
							<%'// 등록된 주소록이 없을경우 주문고객 정보와 동일로 돌림%>
							document.getElementsByName("rdDlvOpt")[0].checked = true;
							copyDefaultinfo(document.getElementsByName("rdDlvOpt")[0]);
						}

						strRst = '<th><label for="selPastAddr">최근 배송지</label></th>';
						strRst += '<td colspan="3">';
						strRst += '	<select id="selPastAddr" class="select offInput" title="최근 배송지에서 선택" style="width:310px;" onChange="selAddress(this);">';
						strRst += vRtn;
						strRst += '	</select>';
						strRst += '</td>';
						$("#lySelMyAddr").html(strRst);

						if(defaultexist == "o"){
							$("#selPastAddr > option[value=1]").attr("selected", "true");
							selAddress($("#selPastAddr"));
						}
					}
					,error: function(err) {
						console.log(err.responseText);
					}
				});
			}else{
				$("#selPastAddr > option[value=]").attr("selected", "true");
			}
		break;
	}
}

// 주소록 복사
function selAddress(osel){
	var frm = document.frmorder;

	frm.reqname.value		= $(osel).children("option:selected").attr("tReqname");
	frm.txAddr1.value		= $(osel).children("option:selected").attr("tTxAddr1");
	frm.txAddr2.value	 	= $(osel).children("option:selected").attr("tTxAddr2");

	<% if IsForeignDlv Then %>
		// 해외배송정보
		if(/-/g.test($(osel).children("option:selected").attr("tReqPhone"))) {
			var tel	= $(osel).children("option:selected").attr("tReqPhone").split("-");
			frm.reqphone1.value	= tel[0];
			frm.reqphone2.value	= tel[1];
			frm.reqphone3.value	= tel[2];
			frm.reqphone4.value	= tel[3];
		} else {
			frm.reqphone1.value	= "";
			frm.reqphone2.value	= "";
			frm.reqphone3.value	= "";
			frm.reqphone4.value	= "";
		}

		frm.reqemail.value	= $(osel).children("option:selected").attr("tReqemail");
		frm.emsZipCode.value	= $(osel).children("option:selected").attr("tReqZipcode");

		if (frm.emsCountry)
		{
			frm.emsCountry.value	= $(osel).children("option:selected").attr("tCountryCode");
			frm.countryCode.value	= $(osel).children("option:selected").attr("tCountryCode");
			frm.emsAreaCode.value	= $(osel).children("option:selected").attr("tEmsAreaCode");

			emsBoxChange(frm.emsCountry);
		}

	<% else %>
		// 국내배송정보
		if(/-/g.test($(osel).children("option:selected").attr("tReqPhone"))) {
			var tel	= $(osel).children("option:selected").attr("tReqPhone").split("-");
			frm.reqphone1.value	= tel[0];
			frm.reqphone2.value	= tel[1];
			frm.reqphone3.value	= tel[2];
		} else {
			frm.reqphone1.value	= "";
			frm.reqphone2.value	= "";
			frm.reqphone3.value	= "";
		}

		var hp	= $(osel).children("option:selected").attr("tReqHp").split("-");
		frm.reqhp1.value	= hp[0];
		frm.reqhp2.value	= hp[1];
		frm.reqhp3.value	= hp[2];

		frm.txZip.value = $(osel).children("option:selected").attr("tReqZipcode");
		
	<% end if %>
}

function copyinfo(comp){
	var frm = document.frmorder;

	if (comp.checked==true){
		frm.reqname.value=frm.buyname.value;

		frm.reqphone1.value=frm.buyphone1.value;
		frm.reqphone2.value=frm.buyphone2.value;
		frm.reqphone3.value=frm.buyphone3.value;

		frm.reqhp1.value=frm.buyhp1.value;
		frm.reqhp2.value=frm.buyhp2.value;
		frm.reqhp3.value=frm.buyhp3.value;
	}else{
		frm.reqname.value="";

		frm.reqphone1.value="";
		frm.reqphone2.value="";
		frm.reqphone3.value="";

		frm.reqhp1.value="";
		frm.reqhp2.value="";
		frm.reqhp3.value="";
	};
}

//현장수령 선택시 주소입력
function chgRSVSel(){
	var frm = document.frmorder;
	if($("#rdDlvOpt4").is(":checked")) {
		$("#lyRSVAddr").hide();
		$("#lyRSVCmt").hide();
		$("#lyRSVInfo").show();

		frm.reqname.value=frm.buyname.value;

		frm.reqphone1.value=frm.buyphone1.value;
		frm.reqphone2.value=frm.buyphone2.value;
		frm.reqphone3.value=frm.buyphone3.value;

		frm.reqhp1.value=frm.buyhp1.value;
		frm.reqhp2.value=frm.buyhp2.value;
		frm.reqhp3.value=frm.buyhp3.value;

//        frm.txZip1.value = "";
//        frm.txZip2.value = "";
        frm.txZip.value = "";
        frm.txAddr1.value = "";
        frm.txAddr2.value = "";
        frm.comment.value = "현장수령";
	} else {
		$("#lyRSVAddr").show();
		$("#lyRSVCmt").show();
		$("#lyRSVInfo").hide();
		if (frm.comment){
		    frm.comment.value = "";
		}
	}
}

function checkArmiDlv(){
    var reTest = new RegExp('사서함');
    return reTest.test(document.frmorder.txAddr2.value);

}

function checkQuickArea(){
    var reTest = new RegExp('서울');
    if (document.frmorder.txAddr1.value.length>0){
        return reTest.test(document.frmorder.txAddr1.value);
    }else{
        return true;
    }

}

function checkQuickMaxNo(){
    var frm = document.baguniFrm;
    var maxEa = <%=C_MxQuickAvailMaxNo%>;
    if (frm.itemea.length){
        for(var i=0;i<frm.itemea.length;i++){
        	if (frm.itemea[i].value*1>maxEa){
        	    return false;
        	}
        }
    }else{
        if (frm.itemea.value*1>maxEa){
            return false;
        }
    }
    return true;
}

function chkQuickDlv(comp){
    if (comp.value=="QQ"){
        if (!checkQuickArea()){
            comp.form.quickdlv[0].checked=true;
            alert('바로 배송(퀵배송)은 서울지역만 가능합니다.');   
            return;
        } 
    }
    
    if (comp.form.quickdlv[1].checked){
        document.getElementById("baronoti2").style.display="";
        if (document.getElementById("Tn_paymethod3")){
            document.getElementById("Tn_paymethod3").disabled=true;
        }
        $(".tendlvorquick").each(function(i){
            $(this).text("바로배송");
        })
        document.getElementById("DISP_FIXPRICEUp").innerHTML = plusComma(<%= oshoppingbag.GetTotalItemOrgPrice + C_QUICKDLVPRICE +pojangcash - oshoppingbag.GetMileageShopItemPrice%>);
        if (document.getElementById("DISP_DLVPRICEUp")){
            document.getElementById("DISP_DLVPRICEUp").innerHTML = plusComma(<%=C_QUICKDLVPRICE%>);
        }
    }else{
        document.getElementById("baronoti2").style.display="none";
        <% if NOT (oshoppingbag.IsBuyOrderItemExists) then %>
            if (document.getElementById("Tn_paymethod3")){
                document.getElementById("Tn_paymethod3").disabled=false;
            }
        <% end if %>
        $(".tendlvorquick").each(function(i){
            $(this).text("텐바이텐 배송");
        })
        document.getElementById("DISP_FIXPRICEUp").innerHTML = plusComma(<%= oshoppingbag.GetTotalItemOrgPrice + oshoppingbag.GetOrgBeasongPrice +pojangcash - oshoppingbag.GetMileageShopItemPrice%>);
        if (document.getElementById("DISP_DLVPRICEUp")){
            document.getElementById("DISP_DLVPRICEUp").innerHTML = plusComma(<%=oshoppingbag.GetOrgBeasongPrice%>);
        }
    }
    RecalcuSubTotal(comp);

}

function searchzip(frmName){
	var popwin = window.open('/common/searchzip.asp?target=' + frmName, 'searchzip10', 'width=560,height=680,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function searchzipNew(frmName){
	var popwin = window.open('/common/searchzip_ka.asp?target=' + frmName, 'searchzip10', 'width=580,height=690,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function searchzipBuyerNew(frmName){
	var popwin = window.open('/common/searchzip_ka.asp?target=' + frmName + '&strMode=buyer', 'searchzip10', 'width=580,height=690,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function searchzipBuyer(frmName){
	var popwin = window.open('/common/searchzip.asp?target=' + frmName + '&strMode=buyer', 'searchzip10', 'width=560,height=680,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function PopOldAddress(){
	if ($("#lySelMyAddr").html()!="") {
		$("#lySelMyAddr").hide();
	}
	var popwin = window.open('/my10x10/MyAddress/popMyAddressList.asp','popMyAddressList','width=600,height=300,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function PopSeaAddress(){
	var popwin = window.open('/my10x10/MyAddress/popSeaAddressList.asp','popSeaAddressList','width=600,height=300,scrollbars=yes,resizable=yes');
	popwin.focus();
}

function CheckPayMethod(comp){
    var paymethod = comp.value;

    //if (paymethod=='7'){
    //    alert('현재 데이콤 PG 가상계좌 오류로 가상 계좌 서비스가 원할하지 않습니다. 이점 양해해 주시기 바랍니다.');
    //}

    if (paymethod=="110") paymethod="100";

    document.getElementById("paymethod_desc1_100").style.display = "none";
    document.getElementById("paymethod_desc1_20").style.display = "none";
    document.getElementById("paymethod_desc1_7").style.display = "none";
    //document.getElementById("paymethod_desc1_80").style.display = "none";
    document.getElementById("paymethod_desc1_400").style.display = "none";
    document.getElementById("paymethod_desc1_900").style.display = "none";
    document.getElementById("paymethod_desc1_950").style.display = "none";
	document.getElementById("paymethod_desc1_980").style.display = "none";
	document.getElementById("paymethod_desc1_990").style.display = "none";
	document.getElementById("paymethod_desc1_190").style.display = "none";
	document.getElementById("paymethod_desc1_130").style.display = "none";
	$("#refundInfo1").hide();
	$("#infotxt").empty().html("빠른 주문 처리를 위해 품절 발생 시 별도의 연락을 하지 않고 선택하신 결제 방법으로 안전하게 환불해 드립니다.");
    
    document.getElementById("paymethod_desc1_" + paymethod).style.display = "table-row-group";
    //document.getElementById("paymethod_desc2_" + paymethod).style.display = "block";

	if (paymethod=='7'){
		$("#refundInfo1").show();
		$("#infotxt").empty().html("빠른 주문 처리를 위해 품절 발생 시 별도의 연락을 하지 않고 입력하신 계좌로 안전하게 환불해 드립니다.");
    }

    <% if (Not IsCyberAccountEnable) then %>
    if (paymethod=='7'){
        alert('현재 가상계좌 오류로 가상계좌는 발급되지 않으며 아래 선택한 텐바이텐 계좌로 입금해 주시기 바랍니다..');
    }
    <% end if %>

    <% if IsTicketOrder then %>
    if (paymethod=='7'){
        alert('티켓상품은 무통장 입금 마감일이 티켓예약 익일 24:00까지 입니다. 이점 양해해 주시기 바랍니다.');
    }
    <% end if %>
}

function CheckPayMethodHANA(comp){
    var paymethod = comp;

    //if (paymethod=='7'){
    //    alert('현재 데이콤 PG 가상계좌 오류로 가상 계좌 서비스가 원할하지 않습니다. 이점 양해해 주시기 바랍니다.');
    //}

    if (paymethod=="110") paymethod="100";

    document.getElementById("paymethod_desc1_100").style.display = "none";
    document.getElementById("paymethod_desc1_20").style.display = "none";
    document.getElementById("paymethod_desc1_7").style.display = "none";
    //document.getElementById("paymethod_desc1_80").style.display = "none";
    document.getElementById("paymethod_desc1_400").style.display = "none";
    document.getElementById("paymethod_desc1_900").style.display = "none";
    document.getElementById("paymethod_desc1_950").style.display = "none";
	document.getElementById("paymethod_desc1_980").style.display = "none";
	document.getElementById("paymethod_desc1_990").style.display = "none";	
    document.getElementById("paymethod_desc1_190").style.display = "none";
    
    document.getElementById("paymethod_desc1_" + paymethod).style.display = "table-row-group";
    //document.getElementById("paymethod_desc2_" + paymethod).style.display = "block";

    <% if (Not IsCyberAccountEnable) then %>
    if (paymethod=='7'){
        alert('현재 가상계좌 오류로 가상계좌는 발급되지 않으며 아래 선택한 텐바이텐 계좌로 입금해 주시기 바랍니다..');
    }
    <% end if %>

    <% if IsTicketOrder then %>
    if (paymethod=='7'){
        alert('티켓상품은 무통장 입금 마감일이 티켓예약 익일 24:00까지 입니다. 이점 양해해 주시기 바랍니다.');
    }
    <% end if %>
}

function popansim(p){
	var popwin;
	popwin = window.open('http://www.inicis.com/popup/C_popup/popup_C_'+p+'.html','popansim','scrollbars=yes,resizable=yes,width=620,height=600')
}

<% if (NOT G_PG_400_USE_INIPAY) then %>
    var popupMobileWindow;
<% if (G_USE_BAGUNITEMP) then %>
    function PopMobileOrder(paymethod){
        var ileft = (screen.width-650)/2;
        var itop  = (screen.height-650)/2;
        var iparam = "left="+ileft+",top="+itop+",width=650,height=650,scrollbars=no,resizable=no";
        dcompopwin=window.open('','dcompopwin',iparam);
    	dcompopwin.focus();
    	
    	document.frmorder.target="dcompopwin";
    	var buf = "<div id='LGD_PAYMENTWINDOW_TOP' class='window phonePayLyr' style='width:560px; height:560px;'>";
    				buf=buf+"<div>";
    				buf=buf+"<p class='lyrClose' onclick='ClosePopLayer();'><img src='/fiximage/web2013/common/btn_pop_close02.gif' alt='닫기' /></p>";
    				buf=buf+"<iframe id='LGD_PAYMENTWINDOW_TOP_IFRAME' name='LGD_PAYMENTWINDOW_TOP_IFRAME' height='498' width='100%' scrolling='no' frameborder='0' src='blank.asp'></iframe>";
    				buf=buf+"</div>";
    				buf=buf+"</div>";
    
    	var buf = "<div id='LGD_PAYMENTWINDOW_TOP' class='window phonePayLyr' style='width:190px; height:60px;'>";
    			buf=buf+"<div>";
    			buf=buf+"<p class='lyrClose' >휴대폰 결제 진행중입니다.<img src='/fiximage/web2013/common/btn_pop_close02.gif' alt='닫기' onclick='HidePopLayerDcom();' style='cursor:pointer' /></p>";
    			buf=buf+"</div>";
    			buf=buf+"</div>";
        viewPoupLayer('modal',buf);
    
        //document.LGD_FRM.isAx.value="";
        document.frmorder.action="/inipay/xpay/ordertemp_xpay.asp"
        document.frmorder.submit();
        
    }
    
<% else %>
    function PopMobileOrder(paymethod){
    	 // uplus
        document.LGD_FRM.LGD_BUYER.value = document.frmorder.buyname.value;
        document.LGD_FRM.LGD_PRODUCTINFO.value = document.frmorder.mobileprdtnm.value;
        document.LGD_FRM.LGD_AMOUNT.value = document.frmorder.mobileprdprice.value;
        document.LGD_FRM.LGD_BUYEREMAIL.value = document.frmorder.buyemail.value;
        document.LGD_FRM.LGD_BUYERPHONE.value = document.frmorder.buyhp1.value + "" + document.frmorder.buyhp2.value + "" + document.frmorder.buyhp3.value;
        document.LGD_FRM.action="/inipay/xpay/payreq_crossplatform_pop.asp"
    
        var ileft = (screen.width-650)/2;
        var itop  = (screen.height-650)/2;
        var iparam = "left="+ileft+",top="+itop+",width=650,height=650,scrollbars=no,resizable=no";
        dcompopwin=window.open('','dcompopwin',iparam);
    	dcompopwin.focus();
        document.LGD_FRM.target="dcompopwin";//"LGD_PAYMENTWINDOW_TOP_IFRAME";
    
        if ((1==0) && (navigator.userAgent.indexOf("MSIE") != -1))  {
        // IE일 경우 //activeX
            document.LGD_FRM.isAx.value="Y";
            document.LGD_FRM.submit();
            return;
        // IE일 경우 //modal
            var arg = new Array;
            arg["opener"] = self;
            arg["buyname"] = document.frmorder.buyname.value;
            arg["mobileprdtnm"] = document.frmorder.mobileprdtnm.value;
            arg["mobileprdprice"] = document.frmorder.mobileprdprice.value;
            arg["buyemail"] = document.frmorder.buyemail.value;
            arg["buyhp"] = document.frmorder.buyhp1.value + "" + document.frmorder.buyhp2.value + "" + document.frmorder.buyhp3.value;
    
            popupMobileWindow = window.showModalDialog("/inipay/xpay/step_dlg.asp?isAx=D",arg, "dialogwidth:480px;dialogheight:500px;center:yes;scroll:no;resizable:no;status:no;help:no;");
        }else{
    		// cross
            //setDisableComp();
            //2012버전
            /*
            document.getElementById('LGD_PAYMENTWINDOW_TOP').style.display = "";
            document.LGD_FRM.isAx.value="";
            document.LGD_FRM.submit();
            */
    
    		var buf = "<div id='LGD_PAYMENTWINDOW_TOP' class='window phonePayLyr' style='width:560px; height:560px;'>";
    				buf=buf+"<div>";
    				buf=buf+"<p class='lyrClose' onclick='ClosePopLayer();'><img src='/fiximage/web2013/common/btn_pop_close02.gif' alt='닫기' /></p>";
    				buf=buf+"<iframe id='LGD_PAYMENTWINDOW_TOP_IFRAME' name='LGD_PAYMENTWINDOW_TOP_IFRAME' height='498' width='100%' scrolling='no' frameborder='0' src='blank.asp'></iframe>";
    				buf=buf+"</div>";
    				buf=buf+"</div>";
    
    		var buf = "<div id='LGD_PAYMENTWINDOW_TOP' class='window phonePayLyr' style='width:190px; height:60px;'>";
    				buf=buf+"<div>";
    				buf=buf+"<p class='lyrClose' >휴대폰 결제 진행중입니다.<img src='/fiximage/web2013/common/btn_pop_close02.gif' alt='닫기' onclick='HidePopLayerDcom();' style='cursor:pointer' /></p>";
    				buf=buf+"</div>";
    				buf=buf+"</div>";
            viewPoupLayer('modal',buf);
    
            document.LGD_FRM.isAx.value="";
            document.LGD_FRM.submit();
        }
    }
<% end if %>
<% end if %>

function setDisableComp(){
    var f=document.frmorder;
    if (f.rdDlvOpt){
    	for(i=0;i<f.rdDlvOpt.length;i++) {
    		cnj_var = f.rdDlvOpt[i];
    		cnj_var.disabled = true;
    	}
    }
    if (f.Tn_paymethod){
    	for(i=0;i<f.Tn_paymethod.length;i++) {
    		cnj_var = f.Tn_paymethod[i];
    		cnj_var.disabled = true;
    	}
    }
    if (f.itemcouponOrsailcoupon){
    	for(i=0;i<f.itemcouponOrsailcoupon.length;i++) {
    		cnj_var = f.itemcouponOrsailcoupon[i];
    		cnj_var.disabled = true;
    	}
	}
	if (f.sailcoupon){
	    f.sailcoupon.disabled = true;
	}
	disable_click();
}

function payInI_Web(frm){
    <% if (G_USE_BAGUNITEMP) then %>
        if (frm.itemcouponOrsailcoupon[1].checked){
    	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
    	}else{
    	    frm.checkitemcouponlist.value = "";
    	}

        frm.action = "/inipay/iniWeb/ordertemp_IniWebSegniture.asp";
        $(frm).ajaxSubmit({
    			//submit이후의 처리
    			success: function(responseText, statusText){
    				if(responseText.substr(0,4)=="ERR1") {
    					alert(responseText.substr(5,responseText.length));

    				} else if(responseText.substr(0,4)=="ERR2") {
    					alert(responseText.substr(5,responseText.length));
    					location.replace('<%=wwwUrl%>/inipay/shoppingbag.asp');
    				} else if(responseText.substr(0,2)=="OK") {

    				} else {
    					$("#INIWEB_SIG").empty().html(responseText);
						if (frm.gopaymethod.value=="HPP"){
							frm.nointerest.value = ""; //ini_web
							frm.quotabase.value = ""; //ini_web
						} else if (frm.gopaymethod.value=="onlydbank"){
							frm.gopaymethod.value = "DirectBank";
							frm.nointerest.value = "";
							frm.quotabase.value = "";
						} else if (frm.gopaymethod.value=="onlyocbplus"){
							frm.gopaymethod.value = "OCBPoint";
							frm.nointerest.value = "";
							if (frm.hnprice) { frm.price.value=frm.hnprice.value;}
							if (parseInt(frm.price.value) < 50000){
								frm.quotabase.value = ""; //ini_web
							}else{
								frm.quotabase.value = "2:3:4:5:6:7:8:9:10:11:12";
							}
						} else if (frm.gopaymethod.value=="onlyssp"){
							frm.gopaymethod.value = "onlyssp";
							frm.nointerest.value = "";
							if (frm.hnprice) { frm.price.value=frm.hnprice.value;}
							if (parseInt(frm.price.value) < 50000){
								frm.quotabase.value = ""; //ini_web
							}else{
								frm.quotabase.value = "2:3:4:5:6:7:8:9:10:11:12";
							}
						} else {
							frm.gopaymethod.value = "Card";
							frm.nointerest.value = "";
							if (frm.hnprice) { frm.price.value=frm.hnprice.value;}
							if (parseInt(frm.price.value) < 50000){
								frm.quotabase.value = ""; //ini_web
							}else{
								frm.quotabase.value = "2:3:4:5:6:7:8:9:10:11:12";
							}
						}
                        

                        INIStdPay.pay(frm.name);
                        
                        setTimeout(function(){
                            if(INIStdPay.$stdPopup==null){
                                alert('팝업이 차단되었습니다. 팝업 설정을 허용하여 주십시오.');
                            };
                        },2000);
    				}
    			},
    			//ajax error
    			error: function(err){
    				alert("ERR: " + err.responseText);
    				//alert("처리 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
    				ClosePopLayer();
    				NPayWin.close();
    			}
    		});
    <% else %>
    $.ajax({
		url: "/inipay/iniWeb/getIniWebSegniture.asp?prc="+frm.price.value,
		cache: false,
		async: false,
		success: function(vRst) {
			if(vRst!="") {
				$("#INIWEB_SIG").empty().html(vRst);
				
				frm.gopaymethod.value = "Card";
                frm.nointerest.value = "";
                if (parseInt(frm.price.value) < 50000){
            	    frm.quotabase.value = ""; //ini_web
            	}else{
            	    frm.quotabase.value = "2:3:4:5:6:7:8:9:10:11:12";
            	}
            	
            	if (frm.itemcouponOrsailcoupon[1].checked){
            	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
            	}else{
            	    frm.checkitemcouponlist.value = "";
            	}
                INIStdPay.pay(frm.name);
		    }
		}
		,error: function(err) {
		    alert('죄송합니다. 통신중 오류가 발생하였습니다.');
			//alert(err.responseText);
			//$("#INIWEB_SIG").empty().html(vRst);
		}
	});
	<% end if %>
    
}

function payInI(frm){
	return true;	// 플러그인 처리 중단

	// MakePayMessage()를 호출함으로써 플러그인이 화면에 나타나며, Hidden Field
	// 에 값들이 채워지게 됩니다. 플러그인은 통신을 하는 것이 아니라, Hidden
	// Field의 값들을 채우고 종료한다는 사실에 유의하십시오.

	if(frm.clickcontrol.value == "enable"){
		//if(document.INIpay==null||document.INIpay.object==null){
		if ( ( navigator.userAgent.indexOf("MSIE") >= 0 || navigator.appName == 'Microsoft Internet Explorer' ) && (document.INIpay == null || document.INIpay.object == null) ){
			alert("플러그인을 설치 후 다시 시도 하십시오...");
			return false;
		}else if(document.INIpay==null||document.INIpay.object==null){    //2015/09/04 추가 크롬브라우져 지원중단됨.
		    <% if (G_IsIE) then %>
		    alert("플러그인을 설치 후 다시 시도 하십시오.\r\n플러그인이 자동으로 설치 되지 않는 경우 결제수단 설명 페이지의 [여기] 버튼을 눌러 수동으로 플러그인을 설치해 주세요. ");
			return false;
		    <% else %>
		    alert("신규 크롬 브라우져(버전 45) 등에서 카드/실시간 이체 결제가 원할 하지 않습니다. Internet Explore 또는 무통장(가상계좌) 또는 휴대폰결제를 이용해 주세요.");
			return false;
		    <% end if %>
		}else{
			/*
			 * 플러그인 기동전에 각종 지불옵션을 자바스크립트를 통하여
			 * 처리하시려면 이곳에서 수행하여 주십시오.
			 */
			// 50000원 미만은 할부불가
			if(parseInt(frm.price.value) < 50000)
				frm.quotabase.value = "일시불";

			if (MakePayMessage(frm)){
				disable_click();
				//openwin = window.open("childwin.html","childwin","width=300,height=160");
				/****
				무이자용 상점아이디가 따로 존재하는 경우(자체가맹점) 상점아이디
				를 동적으로	적용하는 코드. (대표가맹점인 경우에는 주석을 해제하
				지 마십시오.

				// 사용자가 무이자할부 조건에 부합하는 카드와 개월수를 선택했음
				// (조건 설정은 하단 quotabase field 부분, 매뉴얼 참조)
				if(frm.quotainterest.value == "1")
				{
					frm.mid.value = "{무이자용 상점아이디}";
				}
				****/

				return true;
			}else{
			    /*
			    if( IsPluginModule() ){     //plugin타입 체크
				    alert("지불에 실패하였습니다.");
				}else{
				    //이니페이 플래시라면 Form 값을 먼저 채울것 MakePayMessage(frm) 이후 리턴값없이 submit 됨.. //2012-01
                    if (ini_IsUseFlash==true){
                        if (frm.itemcouponOrsailcoupon[1].checked){
                    	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
                    	}else{
                    	    frm.checkitemcouponlist.value = "";
                    	}
                	    frm.target = "";
                	    frm.action = "/inipay/INIsecurepay.asp"
                	}
				}
                */
                alert("지불에 실패하였습니다.");
                
				return false;
			}
		}
	}else{
		return false;
	}
}

function CheckForm(frm){

    //var paymethod = frm.Tn_paymethod[getCheckedIndex(frm.Tn_paymethod)].value;

    if (frm.buyname.value.length<1){
        alert('주문자 명을 입력하세요.');
        frm.buyname.focus();
        return false;
    }

    if ((frm.buyphone1.value.length<1)||(!IsDigit(frm.buyphone1.value))){
        alert('주문자 전화번호를 입력하세요.');
        frm.buyphone1.focus();
        return false;
    }

    if ((frm.buyphone2.value.length<1)||(!IsDigit(frm.buyphone2.value))){
        alert('주문자 전화번호를 입력하세요.');
        frm.buyphone2.focus();
        return false;
    }

    if ((frm.buyphone3.value.length<1)||(!IsDigit(frm.buyphone3.value))){
        alert('주문자 전화번호를 입력하세요.');
        frm.buyphone3.focus();
        return false;
    }

    if ((frm.buyhp1.value.length<1)||(!IsDigit(frm.buyhp1.value))){
        alert('주문자 핸드폰번호를 입력하세요.');
        frm.buyhp1.focus();
        return false;
    }

    if ((frm.buyhp2.value.length<1)||(!IsDigit(frm.buyhp2.value))){
        alert('주문자 핸드폰번호를 입력하세요.');
        frm.buyhp2.focus();
        return false;
    }

    if ((frm.buyhp3.value.length<1)||(!IsDigit(frm.buyhp3.value))){
        alert('주문자 핸드폰번호를 입력하세요.');
        frm.buyhp3.focus();
        return false;
    }

    if (frm.buyemail_Pre.value.length<1){
        alert('주문자 이메일 주소를 입력하세요.');
        frm.buyemail_Pre.focus();
        return false;
    }
    if (frm.buyemail_Bx.value.length<4){
        if (!check_form_email(frm.buyemail_Pre.value + '@' + frm.buyemail_Tx.value)){
            alert('주문자 이메일 주소가 올바르지 않습니다.');
            frm.buyemail_Tx.focus();
            return false;
        }
    }

    if (frm.buyemail_Bx.value.length<4){
        frm.buyeremail.value = frm.buyemail_Pre.value + '@' + frm.buyemail_Tx.value;
        frm.buyemail.value   = frm.buyeremail.value;
    }else{
        frm.buyeremail.value = frm.buyemail_Pre.value + '@' + frm.buyemail_Bx.value;
        frm.buyemail.value   = frm.buyeremail.value;
    }

	<% If vIsDeliveItemExist Then %>
	    // 수령인
	    if (frm.reqname.value.length<1){
	        alert('수령인 명을 입력하세요.');
	        frm.reqname.focus();
	        return false;
	    }
	
	    <% if (IsForeignDlv) then %>
		    if (frm.emsCountry.value.length<1){
		        alert('배송 국가를 선택하세요.');
		        frm.emsCountry.focus();
		        return false;
		    }
		
		    if (frm.emsZipCode.value.length<1){
		        alert('우편번호를 입력하세요.');
		        frm.emsZipCode.focus();
		        return false;
		    }
		
		    //필수인지 확인.
		    if ((frm.reqphone3.value.length<1)||(!IsDigit(frm.reqphone3.value))){
		        alert('수령인 전화번호를 입력하세요.');
		        frm.reqphone3.focus();
		        return false;
		    }
		
		    if ((frm.reqphone4.value.length<1)||(!IsDigit(frm.reqphone4.value))){
		        alert('수령인 전화번호를 입력하세요.');
		        frm.reqphone4.focus();
		        return false;
		    }
		
		    if (frm.txAddr1.value.length<1){
		        alert('수령지 도시 및 주를  입력하세요.');
		        frm.txAddr1.focus();
		        return false;
		    }
		
		    if (frm.txAddr2.value.length<1){
		        alert('수령지 상세 주소를  입력하세요.');
		        frm.txAddr2.focus();
		        return false;
		    }
		
		    //영문 체크
		    if (!checkAsc(frm.reqname.value)){
		        alert('영문으로 입력해 주세요.');
		        frm.reqname.focus();
		        return;
		    }
		
		    if (!checkAsc(frm.reqemail.value)){
		        alert('영문으로 입력해 주세요.');
		        frm.reqemail.focus();
		        return;
		    }
		
		    if (!checkAsc(frm.emsZipCode.value)){
		        alert('영문으로 입력해 주세요.');
		        frm.emsZipCode.focus();
		        return;
		    }
		
		    if (!checkAsc(frm.txAddr2.value)){
		        alert('영문으로 입력해 주세요.');
		        frm.txAddr2.focus();
		        return;
		    }
		
		    if (!checkAsc(frm.txAddr1.value)){
		        alert('영문으로 입력해 주세요.');
		        frm.txAddr1.focus();
		        return;
		    }
		
		    if (!frm.overseaDlvYak.checked){
		        alert('해외배송 약관에 동의 하셔야 주문 가능합니다.');
		        frm.overseaDlvYak.focus();
		        return;
		    }
	    <% else %>
		    if ((frm.reqphone1.value.length<1)||(!IsDigit(frm.reqphone1.value))){
		        alert('수령인 전화번호를 입력하세요.');
		        frm.reqphone1.focus();
		        return false;
		    }
		
		    if ((frm.reqphone2.value.length<1)||(!IsDigit(frm.reqphone2.value))){
		        alert('수령인 전화번호를 입력하세요.');
		        frm.reqphone2.focus();
		        return false;
		    }
		
		    if ((frm.reqphone3.value.length<1)||(!IsDigit(frm.reqphone3.value))){
		        alert('수령인 전화번호를 입력하세요.');
		        frm.reqphone3.focus();
		        return false;
		    }
		
		    if ((frm.reqhp1.value.length<1)||(!IsDigit(frm.reqhp1.value))){
		        alert('수령인 핸드폰번호를 입력하세요.');
		        frm.reqhp1.focus();
		        return false;
		    }
		
		    if ((frm.reqhp2.value.length<1)||(!IsDigit(frm.reqhp2.value))){
		        alert('수령인 핸드폰번호를 입력하세요.');
		        frm.reqhp2.focus();
		        return false;
		    }
		
		    if ((frm.reqhp3.value.length<1)||(!IsDigit(frm.reqhp3.value))){
		        alert('수령인 핸드폰번호를 입력하세요.');
		        frm.reqhp3.focus();
		        return false;
		    }

		    <% if Not(IsRsvSiteOrder) then %>
		    try{
		//	    if ((frm.txZip1.value.length<1)||(frm.txZip2.value.length<1)||(frm.txAddr1.value.length<1)){
		//	        alert('수령지 주소를  입력하세요.');
		//	        return false;
		//	    }
		
			    if ((frm.txZip.value.length<2)||(frm.txAddr1.value.length<1)){
			        alert('수령지 주소를  입력하세요.');
			        return false;
			    }
		
				/*
			    if (frm.txAddr2.value.length<1){
			        alert('수령지 상세 주소를  입력하세요.');
			        frm.txAddr2.focus();
			        return false;
				}
				*/
			} catch (e) {}
		    <% end if %>
    	<% end if %>
    <% end if %>

    <% if (IsArmyDlv) then %>
    if (!checkArmiDlv()){
        alert('군부대 배송 주소지는 사서함으로만 가능합니다.');
        frm.txAddr2.focus();
        return false;
    }
    <% end if %>

    //바로배송 체크
	if ((frm.quickdlv)&&(frm.quickdlv[1].checked)){
	    if (!checkQuickArea()) {
	        alert('바로 배송(퀵배송)은 서울지역만 가능합니다.');   
	        frm.quickdlv[0].focus();
	        return;
	    }
	    
	    if (!checkQuickMaxNo()) {
	        alert('바로 배송(퀵배송) 상품당 최대 구매 수량은 <%=C_MxQuickAvailMaxNo%>개 까지 가능합니다.');   
	        frm.quickdlv[0].focus();
	        return;
	    }
	}
	
    //플라워 관련
    <% if (oshoppingbag.IsFixDeliverItemExists) then %>

    var oyear = <%= yyyy %>;
    var omonth = <%= mm %>;
    var odate = <%= dd %>;
    var ohours = <%= hh %>;
    var MinTime = <%= tt %>;

    //Date함수는 0월부터 시작
    var reqDate = new Date(frm.yyyy.value,frm.mm.value-1,frm.dd.value,frm.tt.value);
    var nowDate = new Date(oyear,omonth-1,odate,ohours);
    var nextDay = new Date(oyear,omonth-1,odate,24);
    var fixDate = new Date(oyear,omonth-1,odate,MinTime);

    if (frm.fromname!=undefined){
        if (frm.fromname.value.length<1){
            alert('플라워 메세지 보내는 분 정보를 입력하세요.');
            frm.fromname.focus();
            return false;
        }
    }

    if (nowDate>reqDate){
    	alert("지난 시간은 선택하실 수 없습니다.");
    	frm.tt.focus();
    	return false;
    }else if (fixDate>reqDate){
    	//alert("상품준비 시간이 최소 <%=oshoppingbag.getFixDeliverOrderLimitTime-1 &"-"& oshoppingbag.getFixDeliverOrderLimitTime%>시간입니다!\n좀더 넉넉한 시간을 선택해주세요!");
    	alert("상품준비 시간이 충분하지 않습니다.\n업체별, 지역별로 차이가 있을 수 있으나 당일 배송의 경우 오전 10시 이전에 주문 하시는 것이 좋습니다. (주말/공휴일 제외)");

    	frm.tt.focus();
    	return false;
    }

    <% end if %>

    frm.gift_code.value="";
    frm.gift_kind_option.value="";
    frm.gift_kind_option.value="";

    <% if (OpenGiftExists) then %>
    //사은품 관련 추가
    var vgift_code = "";
    var vgiftkind_code = "";
    var vgift_kind_option = "";
    var openRdCnt = 0;
    if (frm.rRange){
        if (frm.rRange.length){
            for(var i=0;i<frm.rRange.length;i++){
                if (!frm.rRange[i].disabled) openRdCnt++;
                if (frm.rRange[i].checked){
                    vgift_code     = frm.rGiftCode[i].value;
                    vgiftkind_code = frm.rRange[i].value;

                    if (eval("document.frmorder.gOpt_" + frm.rRange[i].value)){
                        var comp = eval("document.frmorder.gOpt_" + frm.rRange[i].value);
                        if (comp.type!="hidden"){
                            if (comp.value ==""){
                                alert('사은품 옵션을 선택하세요');
                                comp.focus();
                                return false;
                                //if (!confirm('사은품 옵션을 선택하지 않으시면 랜덤 발송 됩니다. 계속 하시겠습니까?')){
                                //    comp.focus();
                                //    return false;
                                //}
                            }else if (comp.options[comp.selectedIndex].id =="S"){
                                alert('품절된 옵션은 선택 불가 합니다.');
                                comp.focus();
                                return false;
                            }

                            vgift_kind_option = comp[comp.selectedIndex].value;
                        }else{
                            vgift_kind_option = comp.value;
                        }
                    }
                }
            }

        }else{
            if (!frm.rRange.disabled) openRdCnt++;
            if (frm.rRange.checked){
                vgift_code     = frm.rGiftCode.value;
                vgiftkind_code = frm.rRange.value;
                if (eval("document.frmorder.gOpt_" + frm.rRange.value)){
                    var comp = eval("document.frmorder.gOpt_" + frm.rRange.value);
                    if (comp.type!="hidden"){
                        if (comp.value ==""){
                            alert('사은품 옵션을 선택하세요');
                            comp.focus();
                            return false;

                            //if (!confirm('사은품 옵션을 선택하지 않으시면 랜덤 발송 됩니다. 계속 하시겠습니까?')){
                            //    comp.focus();
                            //    return false;
                            //}
                        }else if (comp.options[comp.selectedIndex].id =="S"){
                            alert('품절된 옵션은 선택 불가 합니다.');
                            comp.focus();
                            return false;
                        }

                        vgift_kind_option = comp[comp.selectedIndex].value;
                    }else{
                        vgift_kind_option = comp.value;
                    }
                }
            }
         }
    }
    
    <% '20170810 전체 사은이벤트 쿠폰사용으로 disabled 되었을경우   %>
    if ((openRdCnt==0)&&(vgift_code!="")){
        vgift_code ="";
        vgiftkind_code ="";
        vgift_kind_option ="";
    }
    
    frm.gift_code.value=vgift_code;
    frm.giftkind_code.value=vgiftkind_code;
    frm.gift_kind_option.value=vgift_kind_option;

    //사은품을 선택 안한경우
    if ((openRdCnt>0)&&(vgift_code=="")){
        if (!confirm('사은품을 선택하지 않으시면 랜덤 발송 됩니다. 계속 하시겠습니까?')){
            return false;
        }
    }
    <% end if %>

    <% if (DiaryOpenGiftExists)  and giftCheck then %>
    var dgift_code = "";
    var dgiftkind_code = "";
    var dgift_kind_option = "";
    var openRdCnt = 0;
    if (frm.dRange){
        if (frm.dRange.length){
            for(var i=0;i<frm.dRange.length;i++){
                if (!frm.dRange[i].disabled) openRdCnt++;
                if (frm.dRange[i].checked){
                    dgift_code     = frm.dtGiftCode[i].value;
                    dgiftkind_code = frm.dRange[i].value;
                }
            }
        }else{
            if (!frm.dRange.disabled) openRdCnt++;
            if (frm.dRange.checked){
                dgift_code     = frm.dtGiftCode.value;
                dgiftkind_code = frm.dRange.value;

            }
         }
    }

    frm.dGiftCode.value=dgift_code;
    //frm.giftkind_code.value=dgiftkind_code;
    //frm.gift_kind_option.value=dgift_kind_option;

	<% end if %>
	try {
		if (frm.txAddr2.value.length > 0){
			frm.txAddr2.value = frm.txAddr2.value.replace(/・/g,"/")
		}		
	} catch (error) {
		return true
	}

    return true;
}

<% if (isTenLocalUser) then %>
var ilocalConfirmd = false;
function fnTenLocalUserOrdCountCheck(){
    var frm = document.baguniFrm;
    var maxEa = 3;
    if (frm.itemea.length){
        for(var i=0;i<frm.itemea.length;i++){
        	if (frm.itemea[i].value*1>maxEa){
        	    return false;
        	}
        }
    }else{
        if (frm.itemea.value*1>maxEa){
            return false;
        }

    }

    return true;
}

function fnTenLocalUserConfirm(){
    var popwin=window.open('popLocalUserConfirm.asp','enLocalUserConfirm','width=460,height=360,scrollbars=yes,resizable=yes')
    popwin.focus();
}

function authPs(){
    ilocalConfirmd = true;
    setTimeout("PayNext(document.frmorder,'');",500);
}
<% end if %>

var iclicked = false;
var dcompopwin;

function checkDblClick(){
    if (iclicked) return true;
    iclicked = true;
    setTimeout("iclicked=false;",1000);
    return false;
}

function goResultPage(iURL){
    document.location.replace(iURL);
}

function PayNext(frm, iErrMsg){
	//alert('잠시 결제 점검중입니다.');
	//return;

	<% If vIsTravelItemExist Then	'### 여행상품있을경우 %>
	if(!frm.travelagree1.checked){
		alert('개인정보 제 3자 제공 동의에 체크해주세요.');
		frm.travelagree1.focus();
		return;
	}
	if(!frm.travelagree2.checked){
		alert('별도의 환불규정 동의에 체크해주세요.');
		frm.travelagree2.focus();
		return;
	}
	<% End If %>

	<% If (Not IsForeignDlv) and (oshoppingbag.IsGlobalShoppingServiceExists) then '## 직구 관련 개인통관고유부호 입력 여부 %>
    	if(!frm.customNumber.value || frm.customNumber.value.length < 13){
    		alert('13자리의 개인통관 고유부호를 입력 해주세요.');
    		frm.customNumber.focus();
    		return;
    	}
    
    	var str1 = frm.customNumber.value.substring(0,1);
    	var str2 = frm.customNumber.value.substring(1,13);
    
    	if((str1.indexOf("P") < 0)&&(str1.indexOf("p") < 0)){
    		alert('P로 시작하는 13자리 번호를 입력 해주세요.');
    		frm.customNumber.focus();
    		return;
    	}
    
    	var regNumber = /^[0-9]*$/;
    	if (!regNumber.test(str2)){
    		alert('번호를 숫자만 입력해주세요.');
    		frm.customNumber.focus();
    		return;
    	}
    <% End If %>
    
    if (checkDblClick()) return;

    if (iErrMsg){
	    alert(iErrMsg);
	    return;
	}

    if (frm.Tn_paymethod.length){
        var paymethod = frm.Tn_paymethod[getCheckedIndex(frm.Tn_paymethod)].value;
    }else{
        var paymethod = frm.Tn_paymethod.value;
    }
    
    if ((paymethod=="7")&&(frm.quickdlv)&&(frm.quickdlv[1].checked)){
        alert('바로배송(퀵배송) 서비스는 무통장 입금 결제 사용이 불가능 합니다.');
		return;
    }
    
    frm.price.value = frm.ooprice.value; //2018/04/18
    if (frm.price.value*1==0){
        paymethod = "000";
    }

    //Check Default Form
    if (!CheckForm(frm)){
        return;
    }

    <% if (isTenLocalUser)and(isTenLocalUserOrderCheck) then %>
    //직원 SMS 인증
    if ((frm.itemcouponOrsailcoupon[0].checked)&&(frm.sailcoupon.value.length>0)){
        var compid = frm.sailcoupon[frm.sailcoupon.selectedIndex].id;
        var icoupontype  = compid.split("|")[0]; //compid.substr(0,1);
        var icouponvalue = compid.split("|")[1]; //compid.substr(2,255);
        var icouponmxdis = compid.split("|")[2];

        if (((icoupontype*1==1)&&(icouponvalue*1>=15))||((icoupontype*1==2)&&(icouponvalue*1>=10000))){
            //if (!fnTenLocalUserOrdCountCheck()) {
            //    alert('직원쿠폰 구매시 한번에 최대 3개로 수량을 제한합니다.');
            //    return; //수량체크
            //}

            <% if session("tnsmsok")<>"ok" then %>
            if (!ilocalConfirmd){
                alert('직원 SMS 인증을 시작합니다.');
                fnTenLocalUserConfirm();
                return;
            }
            <% end if %>
        }
    }

    <% end if %>

	<% If Trim(userid)="" Then %>
	if(!$("#policyY").is(":checked")){
		alert("결제 진행을 위해 구매조건, 개인정보 수집, 개인정보 제공에 동의해 주세요.");
		return;
	}
	<% else %>
	if(!$("#agreeAll").is(":checked")){
		alert("결제 진행을 하시려면 모든 주문 내용 확인 후 구매조건에 동의해주세요.");
		return;
	}
	<% end if %>

    //신용카드
    <% if (G_PG_100_USE_INIWEB) then %>
    if ((paymethod=="100")||(paymethod=="110")||(paymethod=="130")||(paymethod=="190")){
    <% else %>
    if ((paymethod=="100")||(paymethod=="110")){
    <% end if %>
        //alert('현재 BC, 국민카드등 ISP 결제를 이용한 카드결제가 장애로 인해 지연되고 있습니다. \n\n가능한 다른 카드를 이용 부탁드립니다.');
        //alert('현재 삼성카드 카드결제가 장애로 인해 지연되고 있습니다. \n\n가능한 다른 카드를 이용 부탁드립니다.');

    	if (frm.price.value<100){
    		alert('신용카드 최소 결제 금액은 100원 이상입니다.');
    		return;
    	}
    	
    	//if ((paymethod=="190")&&(frm.price.value*1<1053)){
        //    alert('신용카드 최소 결제 금액은 1000원 이상입니다.');
		//	return;
        //}

        frm.ini_onlycardcode.value = "";
    	if (paymethod=="110"){
    	    <% IF application("Svr_Info")="Dev" THEN %>
    	    frm.mid.value="INIpayTest";//"INIpayTest";
    	    <% else %>
    	    frm.mid.value="teenxteen6";
    	    <% end if %>
    	    frm.gopaymethod.value = "onlyocbplus";
			frm.acceptmethod.value ="VERIFY:NOSELF:no_receipt:below1000<%=chkIIF(oshoppingbag.GetTotalBeasongPrice>0,":cd_ps(14-10)","")%>";
    	}else if (paymethod=="130"){
    	    <% IF application("Svr_Info")="Dev" THEN %>
    	    frm.mid.value="INIpayTest";//"INIpayTest";
    	    <% else %>
    	    frm.mid.value="teenteensp";
    	    <% end if %>
    	    frm.gopaymethod.value = "onlyssp";
			frm.acceptmethod.value ="VERIFY:NOSELF:no_receipt:below1000<%=chkIIF(oshoppingbag.GetTotalBeasongPrice>0,":cd_ps(14-10)","")%>:cardonly";
    	}else if (paymethod=="190"){
    	    <% IF application("Svr_Info")="Dev" THEN %>
    	    frm.mid.value="INIpayTest";//"INIpayTest";
    	    <% else %>
    	    frm.mid.value="teenxteeha";
    	    frm.ini_onlycardcode.value = "34";
    	    <% end if %>
    	    frm.gopaymethod.value = "onlycard";
			frm.acceptmethod.value ="VERIFY:NOSELF:no_receipt:below1000<%=chkIIF(oshoppingbag.GetTotalBeasongPrice>0,":cd_ps(14-10)","")%>";
    	}else{
    	    <% IF application("Svr_Info")="Dev" THEN %>
    	    frm.mid.value="INIpayTest";//"INIpayTest";    
    	    <% else %>
    	    frm.mid.value="teenxteen4";
    	    <% end if %>
            frm.gopaymethod.value = "onlycard";
			frm.acceptmethod.value ="VERIFY:NOSELF:no_receipt:below1000<%=chkIIF(oshoppingbag.GetTotalBeasongPrice>0,":cd_ps(14-10)","")%>";
        }

        frm.buyername.value = frm.buyname.value.toString().replace('"', '');
	    frm.buyertel.value = frm.buyhp1.value + "-" + frm.buyhp2.value + frm.buyhp3.value;

        <% if (G_PG_100_USE_INIWEB) then %>
			payInI_Web(frm);
        <% else %>
	    	if (payInI(frm)==true){
	    	    if (frm.itemcouponOrsailcoupon[1].checked){
	        	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
	        	}else{
	        	    frm.checkitemcouponlist.value = "";
	        	}
	
	    	    frm.target = "";
	    	    frm.action = "/inipay/INIsecurepay.asp"
	    		frm.submit();
	    	}
		<% end if %>
		return;
    }

    <% if (NOT G_PG_100_USE_INIWEB) then ''플러그인&&hanaTencard %>
    if (paymethod=="190"){
    	//if (frm.price.value<1053){
    	//	alert('하나 텐바이텐 체크카드 최소 결제 금액은 1000원 이상입니다.');
    	//	return;
    	//}

	    <% IF application("Svr_Info")="Dev" THEN %>
	    frm.mid.value="INIpayTest";//"INIpayTest";    
	    <% else %>
	    frm.mid.value="teenxteeha";
	    frm.ini_onlycardcode.value = "34";
	    <% end if %>
        frm.gopaymethod.value = "onlycard";
        
        frm.buyername.value = frm.buyname.value.toString().replace('"', '');
	    frm.buyertel.value = frm.buyhp1.value + "-" + frm.buyhp2.value + frm.buyhp3.value;
        
        
        frm.action = "/inipay/getHanaTenDiscount.asp"; 
        if (frm.itemcouponOrsailcoupon[1].checked){
    	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
    	}else{
    	    frm.checkitemcouponlist.value = "";
    	}
        
        var disretval = 0;
        $(frm).ajaxSubmit({
    		//submit이후의 처리
    		success: function(responseText, statusText){
    			if(responseText.substr(0,4)=="ERR1") {
    				alert(responseText.substr(5,responseText.length));
    			} else if(responseText.substr(0,2)=="OK") {
                    disretval = responseText.substr(3,responseText.length);
		            frm.price.value=frm.ooprice.value*1-disretval*1;
        	    	if (payInI(frm)==true){
        	    	    frm.target = "";
        	    	    frm.action = "/inipay/INIsecurepay.asp"
        	    		frm.submit();
        	    	}
    			} else {
    				alert("처리중 오류가 발생했습니다.\n" + responseText);
    			}
    		},
    		//ajax error
    		error: function(err){
    			alert("ERR: " + err.responseText);
    			//alert("처리 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
    		}
    	});
        
		return;
    }
    <% end if %>
    
    //실시간 이체
    if (paymethod=="20"){
        //alert('현재 금융결제원 장애로 실시간 이체 결제가 불안정 합니다.  \n\n가능한 다른 결제 수단을 이용 부탁드립니다.');

    	if (frm.price.value<100){
    		alert('실시간 이체 최소 결제 금액은 100원 이상입니다.');
    		return;
    	}

    	// 현금영수증 신청
        if (frm.cashreceiptreq2!=undefined){
            if (frm.cashreceiptreq2.checked){
               if ((!frm.useopt2[0].checked)&&(!frm.useopt2[1].checked)){
                    alert('현금영수증 발행구분을 선택하세요.');
                    return false;
               }

               if (frm.useopt2[0].checked){
                    if (!checkCashreceiptSSN(0,frm.cashReceipt_ssn2)){
                        return false;
                    }
               }

               if (frm.useopt2[1].checked){
                    if (!checkCashreceiptSSN(1,frm.cashReceipt_ssn2)){
                        return false;
                    }
               }
            }
        }
        <% IF application("Svr_Info")="Dev" THEN %>
	    	frm.mid.value="INIpayTest";//"INIpayTest";    
	    <% else %>
	    	frm.mid.value="teenxteen4";
	    <% end if %>
        frm.gopaymethod.value = "onlydbank";
		frm.acceptmethod.value ="VERIFY:NOSELF:no_receipt:below1000<%=chkIIF(oshoppingbag.GetTotalBeasongPrice>0,":cd_ps(14-10)","")%>";

        frm.buyername.value = frm.buyname.value;

	    frm.buyertel.value = frm.buyhp1.value + "-" + frm.buyhp2.value + frm.buyhp3.value;

		<% if (TRUE) then %>
			// iniweb
    		payInI_Web(frm);
		<% Else %>
			if (payInI(frm)==true){
				if (frm.itemcouponOrsailcoupon[1].checked){
					frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
				}else{
					frm.checkitemcouponlist.value = "";
				}

				frm.target = "";
				frm.action = "/inipay/INIsecurepay.asp"
				frm.submit();
			}
		<% End If %>
    	return;
    }


	//모바일
    if (paymethod=="400"){
    	if(document.frmorder.mobileprdprice.value > 500000){
    		alert("휴대폰결제는 결제 최대 금액이 50만원 이하 입니다.");
    		return;
    	}else if(document.frmorder.mobileprdprice.value <100){
    	    alert("휴대폰결제는 결제 최소 금액은 100원 이상입니다.");
    		return;
    	}else{
            
        <% if (G_PG_400_USE_INIPAY) then %>
            <% IF application("Svr_Info")="Dev" THEN %>
    	    frm.mid.value="INIpayTest";//"INIpayTest";
    	    <% else %>
    	    frm.mid.value="teenteen10";
    	    <% end if %>
            frm.gopaymethod.value = "HPP"; //acceptmethod : HPP(2) 필수
			frm.acceptmethod.value ="VERIFY:NOSELF:no_receipt:below1000<%=chkIIF(oshoppingbag.GetTotalBeasongPrice>0,":cd_ps(14-10)","")%>:HPP(2)";
            frm.buyername.value = frm.buyname.value;
            frm.buyertel.value = frm.buyhp1.value + "-" + frm.buyhp2.value + frm.buyhp3.value;
            
        	if (payInI(frm)==true){
        	    if (frm.itemcouponOrsailcoupon[1].checked){
            	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
            	}else{
            	    frm.checkitemcouponlist.value = "";
            	}
        
        	    frm.target = "";
        	    frm.action = "/inipay/INIsecurepay.asp"
        		frm.submit();
        	}
	    <% else %>
			<% if (TRUE) then %>
				// iniweb
				<% IF application("Svr_Info")="Dev" THEN %>
				frm.mid.value="INIpayTest";//"INIpayTest";
				<% else %>
				frm.mid.value="teenteen10";
				<% end if %>
				frm.gopaymethod.value = "HPP"; //acceptmethod : HPP(2) 필수
				frm.acceptmethod.value ="VERIFY:NOSELF:no_receipt:below1000<%=chkIIF(oshoppingbag.GetTotalBeasongPrice>0,":cd_ps(14-10)","")%>:HPP(2)";
				frm.buyername.value = frm.buyname.value;
				frm.buyertel.value = frm.buyhp1.value + "-" + frm.buyhp2.value + frm.buyhp3.value;
				payInI_Web(frm);
			<% else %>
				if (frm.itemcouponOrsailcoupon[1].checked){
					frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
				}else{
					frm.checkitemcouponlist.value = "";
				}

				PopMobileOrder(paymethod);
			<% end if %>
    	<% end if %>
    	}
    	return;
    }
	
    //무통장
    if (paymethod=="7"){
       // alert('현재 무통장(가상계좌) 서비스에 일부 장애가 있습니다. 타결제수단 이용 또는 잠시 후 이용해 주시기 바랍니다.');

        if (frm.acctno.value.length<1){
    		alert('입금하실 은행을 선택하세요. \r\n문자 메세지로 안내해 드립니다.');
    		frm.acctno.focus();
    		return;
    	}

    	if (frm.acctname.value.length<1){
    		alert('입금자성명을 입력하세요..');
    		frm.acctname.focus();
    		return;
    	}

    	if (frm.price.value<0){
    		alert('무통장입금 최소 결제 금액은 0원 이상입니다.');
    		return;
    	}else if (frm.price.value*1==0){
    	    alert('쿠폰 또는 마일리지 사용으로 결제금액이 0원인 경우 주문 후 고객센터로 연락바랍니다.');
    	}

        // 현금영수증 신청
        if (frm.cashreceiptreq!=undefined){
            if (frm.cashreceiptreq.checked){
               if ((!frm.useopt[0].checked)&&(!frm.useopt[1].checked)){
                    alert('현금영수증 발행구분을 선택하세요.');
                    return false;
               }

               if (frm.useopt[0].checked){
                    if (!checkCashreceiptSSN(0,frm.cashReceipt_ssn)){
                        return false;
                    }
               }

               if (frm.useopt[1].checked){
                    if (!checkCashreceiptSSN(1,frm.cashReceipt_ssn)){
                        return false;
                    }
               }
            }
        }

    	// 전자보증서 발급에 필요한 추가 정보 입력 검사 (추가 2006.6.13; 시스템팀 허진원)
    	if (frm.reqInsureChk!=undefined){
        	if ((frm.reqInsureChk.value=="Y")&&(frm.reqInsureChk.checked)){
        		/*
        		if(!frm.insureSsn1.value||frm.insureSsn1.value.length<6) {
        			alert("전자보증서 발급에 필요한 주민등록번호를 입력해주십시요.\n※ 주민등록번호 첫째자리는 6자리입니다.");
        			frm.insureSsn1.focus();
        			return;
        		}

        		if(!frm.insureSsn2.value||frm.insureSsn2.value.length<7) {
        			alert("전자보증서 발급에 필요한 주민등록번호를 입력해주십시요.\n※ 주민등록번호 둘째자리는 7자리입니다.");
        			frm.insureSsn2.focus();
        			return;
        		}
        		*/
        		if(!frm.insureBdYYYY.value||frm.insureBdYYYY.value.length<4||(!IsDigit(frm.insureBdYYYY.value))) {
        			alert("전자보증서 발급에 필요한 생일의 년도를 입력해주십시요.");
        			frm.insureBdYYYY.focus();
        			return;
        		}
        		if(!frm.insureBdMM.value) {
        			alert("전자보증서 발급에 필요한 생일의 월을 선택해주십시요.");
        			frm.insureBdMM.focus();
        			return;
        		}
        		if(!frm.insureBdDD.value) {
        			alert("전자보증서 발급에 필요한 주문고객님의 생일을 선택해주십시요.");
        			frm.insureBdDD.focus();
        			return;
        		}
        		if(!frm.insureSex[0].checked&&!frm.insureSex[1].checked)
        		{
        			alert("전자보증서 발급에 필요한 주문고객님의 성별을 선택해주십시요.");
        			return;
        		}

        		if(frm.agreeInsure[1].checked)
        		{
        			alert("전자보증서 발급에 필요한 개인정보이용에 동의를 하지 않으시면 전자보증서를 발급할 수 없습니다.");
        			return;
        		}
        	}
        }

		if(frm.rebankname.value==""){
			alert('환불 받을 계좌의 은행을 선택해주세요.');
			frm.rebankname.focus();
			return;
		}
        if(frm.encaccount.value==""){
			alert('계좌번호를 정확히 입력해주세요.');
			frm.encaccount.focus();
			return;
		}
		if(frm.rebankownername.value==""){
			alert('예금주를 정확히 입력해주세요.');
			frm.rebankownername.focus();
			return;
		}

    	var ret = confirm('주문 하시겠습니까?');
    	if (ret){
    	    if (frm.itemcouponOrsailcoupon[1].checked){
        	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
        	}else{
        	    frm.checkitemcouponlist.value = "";
        	}

    		frm.target = "";
    		frm.action = "/inipay/AcctResult.asp";
    		frm.submit();
    	}
        return;
    }

    //네이버페이
    if (paymethod=="900"){
    	/* 네이버페이 결제금액 제한 없음
    	if (frm.price.value<1000){
    		alert('네이버페이 최소 결제 금액은 1000원 이상입니다.');
    		return;
    	}
		*/
		// 네이버 페이 장애로 인해 결제 막음 2020-08-12
		<% If Now() >= #08/12/2020 14:00:00# And Now() < #08/12/2020 16:00:01# Then %>
    		alert('네이버페이 서비스 장애로 인해 결제를 하실 수 없습니다.');
    		return;
		<% End If %>
    	// 현금영수증 신청
        if (frm.cashreceiptreq3!=undefined){
            if (frm.cashreceiptreq3.checked){
               if ((!frm.useopt3[0].checked)&&(!frm.useopt3[1].checked)){
                    alert('현금영수증 발행구분을 선택하세요.');
                    return false;
               }

               if (frm.useopt3[0].checked){
                    if (!checkCashreceiptSSN(0,frm.cashReceipt_ssn3)){
                        return false;
                    }
               }

               if (frm.useopt3[1].checked){
                    if (!checkCashreceiptSSN(1,frm.cashReceipt_ssn3)){
                        return false;
                    }
               }
            }
        }

		//Call NaverPay
	    if (frm.itemcouponOrsailcoupon[1].checked){
    	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
    	}else{
    	    frm.checkitemcouponlist.value = "";
    	}

		//결제중 모달창 Open
		viewPoupLayer('modal','<div id="lyNaverpay" class="lyNaverpay"><p>네이버페이 결제가<br /> 진행중입니다.</p><button type="button" onclick="ClosePopLayer()" class="btnClose">닫기</button></div>');

        var NPayWin = window.open('about:blank','NPayPop','width=780,height=830,scrollbars=yes,resizable=no');

		//NaverPay 결제 처리 (Ajax Ver.)
		<% if (G_USE_BAGUNITEMP) then %>
		frm.action = "/inipay/naverpay/ordertemp_npay.asp";    
		<% else %>
		frm.action = "/inipay/naverpay/act_order_temp_save_npay.asp";
	    <% end if %>
		$(frm).ajaxSubmit({
			//submit이후의 처리
			success: function(responseText, statusText){
				if(responseText.substr(0,4)=="ERR1") {
					alert(responseText.substr(5,responseText.length));
					ClosePopLayer();
					NPayWin.close();
				} else if(responseText.substr(0,4)=="ERR2") {
					NPayWin.close();
				    setTimeout(function(){
    					alert(responseText.substr(5,responseText.length));
    					location.replace('<%=wwwUrl%>/inipay/shoppingbag.asp');
    				},500)
				} else if(responseText.substr(0,2)=="OK") {
					//네이버페이 결제창 호출
			        NPayWin.location = '<%=SSLUrl%>/inipay/naverpay/callnaverpay.asp?ordsn='+responseText.substr(3,responseText.length);
				} else {
					alert("처리중 오류가 발생했습니다.\n" + responseText);
					ClosePopLayer();
					NPayWin.close();
				}
			},
			//ajax error
			error: function(err){
				alert("ERR: " + err.responseText);
				//alert("처리 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
				ClosePopLayer();
				NPayWin.close();
			}
		});
    }

    //PAYCO 간편결제
    if (paymethod=="950"){
	    if (frm.itemcouponOrsailcoupon[1].checked){
    	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
    	}else{
    	    frm.checkitemcouponlist.value = "";
    	}

		//결제중 모달창 Open
		viewPoupLayer('modal','<div id="lyPayco" class="lyPayco"><p>PAYCO 간편결제가<br /> 진행중입니다.</p><button type="button" onclick="ClosePopLayer()" class="btnClose">닫기</button></div>');

        var PaycoWin = window.open('about:blank','PaycoPop','top=100, left=300, width=630px, height=560px, resizble=no, scrollbars=yes');

		//Payco 결제 처리 (Ajax Ver.)
		<% if (G_USE_BAGUNITEMP) then %>
		frm.action = "/inipay/payco/ordertemp_payco.asp";
	    <% else %>
	    frm.action = "/inipay/payco/act_order_temp_save_payco.asp";
	    <% end if %>
		$(frm).ajaxSubmit({
			//submit이후의 처리
			success: function(responseText, statusText){
				if(responseText.substr(0,4)=="ERR1") {
					alert(responseText.substr(5,responseText.length));
					ClosePopLayer();
					PaycoWin.close();
				} else if(responseText.substr(0,4)=="ERR2") {
					PaycoWin.close();
				    setTimeout(function(){
    					alert(responseText.substr(5,responseText.length));
    					location.replace('<%=wwwUrl%>/inipay/shoppingbag.asp');
    				},500)
				} else if(responseText.substr(0,2)=="OK") {
					//Payco 결제창 호출 (팝업차단 : 동일 도메인 호출)
			        PaycoWin.location = '<%=SSLUrl%>/inipay/payco/callpayco.asp?rdurl='+responseText.substr(3,responseText.length);
				} else {
					alert("처리중 오류가 발생했습니다.\n" + responseText);
					ClosePopLayer();
					PaycoWin.close();
				}
			},
			//ajax error
			error: function(err){
				alert("ERR: " + err.responseText);
				//alert("처리 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
				ClosePopLayer();
				PaycoWin.close();
			}
		});
    }

    //TOSS 간편결제
    if (paymethod=="980"){
	    if (frm.itemcouponOrsailcoupon[1].checked){
    	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
    	}else{
    	    frm.checkitemcouponlist.value = "";
    	}
		//결제중 모달창 Open
		viewPoupLayer('modal','<div id="lyToss" class="lyPayco"><p>TOSS 결제가<br /> 진행중입니다.</p><button type="button" onclick="ClosePopLayer()" class="btnClose">닫기</button></div>');

        var TossWin = window.open('about:blank','TossPop','top=100, left=300, width=630px, height=560px, resizble=no, scrollbars=yes');

		//Payco 결제 처리 (Ajax Ver.)
		<% if (G_USE_BAGUNITEMP) then %>
			frm.action = "/inipay/tosspay/ordertemp_toss.asp";
	    <% else %>
			alert("현재 토스 결제가 가능하지 않습니다.");
			return false;
	    //frm.action = "/inipay/tosspay/act_order_temp_save_payco.asp";
	    <% end if %>
		$(frm).ajaxSubmit({
			//submit이후의 처리
			success: function(responseText, statusText){
				if(responseText.substr(0,4)=="ERR1") {
					alert(responseText.substr(5,responseText.length));
					ClosePopLayer();
					TossWin.close();
				} else if(responseText.substr(0,4)=="ERR2") {
					TossWin.close();
				    setTimeout(function(){
    					alert(responseText.substr(5,responseText.length));
    					location.replace('<%=wwwUrl%>/inipay/shoppingbag.asp');
    				},500)
				} else if(responseText.substr(0,2)=="OK") {
					//Toss 결제창 호출 (팝업차단 : 동일 도메인 호출)
			        TossWin.location = '<%=SSLUrl%>/inipay/tosspay/calltoss.asp?rdurl='+responseText.substr(3,responseText.length);
				} else {
					alert("처리중 오류가 발생했습니다.\n" + responseText);
					ClosePopLayer();
					TossWin.close();
				}
			},
			//ajax error
			error: function(err){
				alert("ERR: " + err.responseText);
				//alert("처리 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
				ClosePopLayer();
				TossWin.close();
			}
		});
    }

    //CHAI 간편결제
    if (paymethod=="990"){
	    if (frm.itemcouponOrsailcoupon[1].checked){
    	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
    	}else{
    	    frm.checkitemcouponlist.value = "";
    	}

		//결제중 모달창 Open
		viewPoupLayer('modal','<div id="lyChai" class="lyPayco"><p>CHAI 결제가<br /> 진행중입니다.</p><button type="button" onclick="ClosePopLayer()" class="btnClose">닫기</button></div>');

        var ChaiWin = window.open('about:blank','ChaiPop','top=100, left=300, width=520px, height=650px, resizble=no, scrollbars=yes');

		//차이 결제 처리 (Ajax Ver.)
		<% if (G_USE_BAGUNITEMP) then %>
			frm.action = "/inipay/chaipay/ordertemp_chai.asp";
	    <% else %>
			alert("현재 차이 결제가 가능하지 않습니다.");
			return false;
	    //frm.action = "/inipay/tosspay/act_order_temp_save_payco.asp";
	    <% end if %>
		$(frm).ajaxSubmit({
			//submit이후의 처리
			success: function(responseText, statusText){
				if(responseText.substr(0,4)=="ERR1") {
					alert(responseText.substr(5,responseText.length));
					ClosePopLayer();
					ChaiWin.close();
				} else if(responseText.substr(0,4)=="ERR2") {
					ChaiWin.close();
				    setTimeout(function(){
    					alert(responseText.substr(5,responseText.length));
    					location.replace('<%=wwwUrl%>/inipay/shoppingbag.asp');
    				},500)
				} else if(responseText.substr(0,2)=="OK") {
					//Chai 결제창 호출 (팝업차단 : 동일 도메인 호출)
			        ChaiWin.location = '<%=SSLUrl%>/inipay/chaipay/callchai.asp?rdparam='+responseText.substr(3,responseText.length);
				} else {
					alert("처리중 오류가 발생했습니다.\n" + responseText);
					ClosePopLayer();
					ChaiWin.close();
				}
			},
			//ajax error
			error: function(err){
				alert("ERR: " + err.responseText);
				//alert("처리 중 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.");
				ClosePopLayer();
				ChaiWin.close();
			}
		});
    }

    // 0원결제.
    if (paymethod=="000"){
        if (frm.price.value<0){
    		alert('최소 결제 금액은 0원 이상입니다.');
    		return;
    	}

    	var ret = confirm('결제하실 금액은 0원입니다. \n\n주문 하시겠습니까?');
    	if (ret){
    	    if (frm.itemcouponOrsailcoupon[1].checked){
        	    frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
        	}else{
        	    frm.checkitemcouponlist.value = "";
        	}

    		frm.target = "";
    		frm.action = "/inipay/AcctResult.asp";
    		frm.submit();
    	}
    	return;
    }
}

function getCheckedIndex(comp){
    var i =0;
    for( var i = 0 ; i <comp.length;  i++){
        if(comp[i].checked) return i;
    }
    return -1;
}

function HidePopLayerDcom(){
    iclicked =false;
    ClosePopLayer();
    if(dcompopwin) {
        dcompopwin.focus();
        dcompopwin.close();
    }
}

function enable_click(){
	document.frmorder.clickcontrol.value = "enable"
	document.getElementById("nextbutton1").style.display = "";
	document.getElementById("nextbutton2").style.display = "none";
}

function disable_click(){
	document.frmorder.clickcontrol.value = "disable";
	document.getElementById("nextbutton1").style.display = "none";
	document.getElementById("nextbutton2").style.display = "";
}

function defaultCouponSet(comp){
    var frm = document.frmorder;

    if (comp.value=="I"){
        RecalcuSubTotal(comp);
    }else if (comp.value=="S"){
        RecalcuSubTotal(frm.sailcoupon);
    }else if (comp.value=="K"){
        RecalcuSubTotal(frm.kbcardsalemoney);
    }
}

function RecalcuSubTotal(comp){
    var frm = document.frmorder;
    var spendmileage = 0;
    var spendtencash = 0;
    var spendgiftmoney = 0;
    var itemcouponmoney = 0;
    var couponmoney  = 0;

    var availtotalMile = <%= availtotalMile %>;
    var availtotalTenCash = <%= availtotalTenCash %>;
    var availTotalGiftMoney = <%= availTotalGiftMoney %>;
    var isquickdlv   = ((frm.quickdlv)&&(frm.quickdlv[1].checked));

    var emsprice     = 0;

    <% if (IsForeignDlv) then %>
	    var totalbeasongpay= 0;
	    var tenbeasongpay= 0;
	    var pojangcash= <%= pojangcash %>;
	<% elseif (IsArmyDlv) then %>
	    var totalbeasongpay= <%= C_ARMIDLVPRICE %>;
	    var tenbeasongpay= <%= C_ARMIDLVPRICE %>;
	    var pojangcash= <%= pojangcash %>;
    <% else %>
        if (isquickdlv){
            var totalbeasongpay= <%= C_QUICKDLVPRICE %>;
    	    var tenbeasongpay= <%= C_QUICKDLVPRICE %>;
    	    var pojangcash= <%= pojangcash %>;
        }else{
    	    var totalbeasongpay= <%= oshoppingbag.GetOrgBeasongPrice %>;
    	    var tenbeasongpay= <%= oshoppingbag.getTenDeliverItemBeasongPrice %>;
    	    var pojangcash= <%= pojangcash %>;
    	}
    <% end if %>

    var subtotalprice  = <%= subtotalprice %>;
    var fixprice  = <%= subtotalprice %>;

    // 상품 합계금액
    var itemsubtotal   = <%= oshoppingbag.GetTotalItemOrgPrice %>;

    // 보너스 쿠폰 사용시 추가 할인 가능 상품합계.
    var duplicateSailAvailItemTotal = <%= oshoppingbag.GetTotalDuplicateSailAvailItemOrgPrice %>;

    //보너스 쿠폰인지 상품쿠폰인지여부.
    var ItemOrSailCoupon = "";
    var compid;

    //KB카드 할인
    var kbcardsalemoney = 0;

    spendmileage = frm.spendmileage.value*1;
    spendtencash = frm.spendtencash.value*1;
    spendgiftmoney = frm.spendgiftmoney.value*1;
    itemcouponmoney = frm.itemcouponmoney.value*1;
    couponmoney     = frm.couponmoney.value*1;

    //if (comp.name=="sailcoupon"){
    if ((comp.name=="sailcoupon")||((comp.name=="quickdlv")&&(frm.itemcouponOrsailcoupon[0].checked))){
        ItemOrSailCoupon = "S";
        frm.itemcouponOrsailcoupon[0].checked = true;
        //frm.itemcoupon.value="";

        compid = frm.sailcoupon[frm.sailcoupon.selectedIndex].id;
		
        coupontype  = compid.split("|")[0]; //compid.substr(0,1);
        couponvalue = compid.split("|")[1]; //compid.substr(2,255);
        couponmxdis = compid.split("|")[2]; 
        couponmxdis = parseInt(couponmxdis);

        if (coupontype=="0"){
            alert('적용 가능 할인쿠폰이 아니거나 해당 상품이 없습니다.');
            frm.sailcoupon.value=""
            couponmoney = 0;
        }else if (coupontype=="1"){
            // % 보너스쿠폰
		 	//couponmoney = parseInt(duplicateSailAvailItemTotal*1 * (couponvalue / 100)*1);
            couponmoney = parseInt(getPCpnDiscountPrice(couponvalue,couponmxdis,frm.sailcoupon[frm.sailcoupon.selectedIndex].value));

		 	// 추가 할인 불가 상품이 있을경우
		 	if (couponmoney*1==0){
		 	    alert('추가 할인되는 상품이 없습니다.\n\n(' + couponvalue + ' %) 보너스 쿠폰의 경우 일부 추가할인 불가상품은 추가할인이 제외됩니다.');
		 	    frm.sailcoupon.value=""
                couponmoney = 0;
		 	}else if ((itemsubtotal*1-<%= oshoppingbag.GetMileageShopItemPrice %>)!=duplicateSailAvailItemTotal){
		 	    if ((couponmxdis!=0)&&(Math.abs(100-(couponmoney*1/couponmxdis*1)*100)<1)){
		 	        if (couponmxdis==couponmoney){
		 	            alert( '최대 '+plusComma(couponmxdis)+'원 까지 할인되는 쿠폰입니다.');
		 	        }else{
		 	            alert( '최대 '+plusComma(couponmxdis)+'원 까지 할인되는 쿠폰입니다.\r\n1원미만 단위는 반올림 하여 추가로 할인될 수 있습니다.');
		 	        }
		 	    }else{
		 	        alert( '(' + couponvalue + ' %) 보너스 쿠폰의 경우 일부 추가할인 불가상품은 추가할인이 제외됩니다.');
		 	    }
		 	}else if ((couponmxdis!=0)&&(Math.abs(100-(couponmoney*1/couponmxdis*1)*100)<1)){
		 	    if (couponmxdis==couponmoney){
	 	            alert( '최대 '+plusComma(couponmxdis)+'원 까지 할인되는 쿠폰입니다.');
	 	        }else{
	 	            alert( '최대 '+plusComma(couponmxdis)+'원 까지 할인되는 쿠폰입니다.\r\n1원미만 단위는 반올림 하여 추가로 할인될 수 있습니다.');
	 	        }
	 	    }
	 	    
		}else if(coupontype=="2"){
		    // 금액 보너스 쿠폰
		 	couponmoney = couponvalue*1;
		}else if(coupontype=="3"){
		    //배송비 쿠폰.
		    couponmoney = tenbeasongpay;
		    <% if (IsForeignDlv) then %>
		    if (tenbeasongpay==0){
		        alert('해외 배송이므로 추가 할인되지 않습니다.');
		        frm.sailcoupon.value=""
		    }
		    <% elseif (IsArmyDlv) then %>
		    if (tenbeasongpay==0){
		        alert('군부대 배송비는 추가 할인되지 않습니다.');
		        frm.sailcoupon.value=""
		    }
		    <% else %>
		    if (tenbeasongpay==0){
		        alert('무료 배송이므로 추가 할인되지 않습니다.(텐바이텐 배송비만 할인적용가능)');
		        frm.sailcoupon.value=""
		    }else if (isquickdlv){
		        alert('바로배송(퀵배송)은 무료배송쿠폰 적용이 불가합니다..');
		        frm.sailcoupon.value=""
		        couponmoney=0
		    }
		    <% end if %>
		}else{
		    //미선택
		    couponmoney = 0;
		}

        if(coupontype=="2"){
            couponmoney = AssignBonusCoupon(true,coupontype,couponvalue);
            if (couponmoney*1<1){
                alert('추가 할인되는 상품이 없습니다.\n\n일부 추가할인 불가상품은 추가할인이 제외되거나 브라우져 새로고침 후 다시시도하시기 바랍니다..');
                frm.sailcoupon.value=""
                couponmoney = 0;
            }else{
                var altMsg = "금액할인쿠폰을 사용하여 복수의 상품을 구매 하시는 경우,\n상품별 판매가에 따라 쿠폰할인금액이 각각 분할되어 적용되며 이는 주문취소 및 반품시의 기준이 됩니다."
                altMsg+="\n\nex) 1만원상품 X 4개 구매 (2천원 할인쿠폰 사용)"
                altMsg+="\n40,000 - 2,000 (쿠폰) = 38,000원 (상품당 500원 할인)"
                altMsg+="\n4개 중 1개 주문취소 시, 9,500원 환불"
                alert(altMsg);

            }
        }else if((coupontype=="6")||(coupontype=="7")){
            couponmoney = AssignBCBonusCoupon(coupontype,couponvalue,frm.sailcoupon[frm.sailcoupon.selectedIndex].value);
            if (couponmoney*1<1){
                alert('추가 할인되는 상품이 없습니다.\n\n보너스 쿠폰의 경우 일부 추가할인 불가상품은 추가할인이 제외됩니다.');
                frm.sailcoupon.value=""
                couponmoney = 0;
            }else{
                if (coupontype=="7"){
                    var altMsg = "금액할인쿠폰을 사용하여 복수의 상품을 구매 하시는 경우,\n상품별 판매가에 따라 쿠폰할인금액이 각각 분할되어 적용되며 이는 주문취소 및 반품시의 기준이 됩니다."
                    altMsg+="\n\nex) 1만원상품 X 4개 구매 (2천원 할인쿠폰 사용)"
                    altMsg+="\n40,000 - 2,000 (쿠폰) = 38,000원 (상품당 500원 할인)"
                    altMsg+="\n4개 중 1개 주문취소 시, 9,500원 환불"
                    alert(altMsg);
                }

            }
        }

		//원 상품대보다 보너스 쿠폰 금액이 많은경우 = 원상품액 (배송비쿠폰은 제외)
		if ((couponmoney*1>itemsubtotal*1)&&(coupontype!="3")){
		 	couponmoney = itemsubtotal*1;
		}

		itemcouponmoney = 0;

		AssignItemCoupon(false);

        <% if (DiaryOpenGiftExists) and giftCheck then %>
		frm.fixpriceTenItm.value = getCpnDiscountTenPrice(coupontype,couponvalue)
		<% end if %>
    }

    //if (comp.name=="itemcouponOrsailcoupon"){
    if ((comp.name=="itemcouponOrsailcoupon")||((comp.name=="quickdlv")&&(frm.itemcouponOrsailcoupon[1].checked))){
        ItemOrSailCoupon = "I";
        frm.itemcouponOrsailcoupon[1].checked = true;
        frm.sailcoupon.value="";

        couponmoney = 0;
        itemcouponmoney = AssignItemCoupon(true);

        <% if (IsItemFreeBeasongCouponExists) then %>
            if (isquickdlv){
                if (!frm.itemcouponOrsailcoupon[1].disabled){
                    alert('바로배송(퀵배송)은 무료배송쿠폰은 적용되지 않습니다.');
                    itemcouponmoney = itemcouponmoney*1;
                    frm.itemcouponOrsailcoupon[0].checked=true;
                }
            }else{
                itemcouponmoney = itemcouponmoney*1 + tenbeasongpay*1;
            }
        <% end if %>

    }

    //KBCardMall
    if (frm.kbcardsalemoney){
        kbcardsalemoney = frm.kbcardsalemoney.value*1;
    }
    emsprice     = frm.emsprice.value*1;

    if (!IsDigit(frm.spendmileage.value)){
        frm.spendmileage.value = 0;
        alert('마일리지는 숫자만 가능합니다.');
        frm.spendmileage.value = 0;
    }

    if (spendmileage>availtotalMile){
        alert('사용 가능한 최대 마일리지는' + availtotalMile + ' Point 입니다.');
        frm.spendmileage.value = availtotalMile;

    }

    if (!IsDigit(frm.spendtencash.value)){
        frm.spendtencash.value = 0;
        alert('예치금 사용은 숫자만 가능합니다.');
        frm.spendtencash.value = 0;
    }

    if (!IsDigit(frm.spendgiftmoney.value)){
        frm.spendgiftmoney.value = 0;
        alert('Gift카드 사용은 숫자만 가능합니다.');
        frm.spendgiftmoney.value = 0;
    }

    if (spendtencash>availtotalTenCash){
        alert('사용 가능한 최대 예치금은' + availtotalTenCash + ' 원 입니다.');
        frm.spendtencash.value = availtotalTenCash;
    }

    if (spendgiftmoney>availTotalGiftMoney){
        alert('사용 가능한 Gift카드 잔액은' + availTotalGiftMoney + ' 원 입니다.');
        frm.spendgiftmoney.value = availTotalGiftMoney;

    }

    spendmileage = frm.spendmileage.value*1;
    spendtencash = frm.spendtencash.value*1;
    spendgiftmoney = frm.spendgiftmoney.value*1;

    if (spendmileage>(itemsubtotal*1 + totalbeasongpay*1 + pojangcash*1 + emsprice*1 + itemcouponmoney*-1 + couponmoney*-1 + kbcardsalemoney*-1)){
        alert('결제 하실 금액보다 마일리지를 더 사용하실 수 없습니다. 사용가능 마일리지는 ' + (itemsubtotal*1 + totalbeasongpay*1 + pojangcash*1 + emsprice*1 + itemcouponmoney*-1 + couponmoney*-1 + kbcardsalemoney*-1) + ' Point 입니다.');
        frm.spendmileage.value = itemsubtotal*1 + totalbeasongpay*1 + pojangcash*1 + emsprice*1 + itemcouponmoney*-1 + couponmoney*-1 + kbcardsalemoney*-1;
        spendmileage = frm.spendmileage.value*1;
    }

    if (spendtencash>(itemsubtotal*1 + totalbeasongpay*1 + pojangcash*1 + emsprice*1 + itemcouponmoney*-1 + couponmoney*-1 + kbcardsalemoney*-1 + spendmileage*-1)){
        alert('결제 하실 금액보다 예치금을 더 사용하실 수 없습니다. 사용가능 예치금 ' + (itemsubtotal*1 + totalbeasongpay*1 + pojangcash*1 + emsprice*1 + itemcouponmoney*-1 + couponmoney*-1 + kbcardsalemoney*-1 + spendmileage*-1) + ' 원 입니다.');
        frm.spendtencash.value = itemsubtotal*1 + totalbeasongpay*1 + pojangcash*1 + emsprice*1 + itemcouponmoney*-1 + couponmoney*-1 + kbcardsalemoney*-1 + spendmileage*-1;
        spendtencash = frm.spendtencash.value*1;
    }

    if (spendgiftmoney>(itemsubtotal*1 + totalbeasongpay*1 + pojangcash*1 + emsprice*1 + itemcouponmoney*-1 + couponmoney*-1 + kbcardsalemoney*-1 + spendmileage*-1 + spendtencash*-1)){
        alert('결제 하실 금액보다 Gift카드를 더 사용하실 수 없습니다. 사용가능 Gift카드 잔액은 ' + (itemsubtotal*1 + totalbeasongpay*1 + pojangcash*1 + emsprice*1 + itemcouponmoney*-1 + couponmoney*-1 + kbcardsalemoney*-1 + spendmileage*-1 + spendtencash*-1) + ' 원 입니다.');
        frm.spendgiftmoney.value = itemsubtotal*1 + totalbeasongpay*1 + pojangcash*1 + emsprice*1 + itemcouponmoney*-1 + couponmoney*-1 + kbcardsalemoney*-1 + spendmileage*-1 + spendtencash*-1;
        spendgiftmoney = frm.spendgiftmoney.value*1;
    }

    fixprice = itemsubtotal*1 + totalbeasongpay*1 + pojangcash*1 + itemcouponmoney*-1 + couponmoney*-1 + emsprice*1;
    subtotalprice = itemsubtotal*1 + totalbeasongpay*1 + pojangcash*1 + spendmileage*-1 + itemcouponmoney*-1 + couponmoney*-1 + kbcardsalemoney*-1 + spendtencash*-1 + emsprice*1+ spendgiftmoney*-1;

    <% if (IsForeignDlv) then %>
    document.getElementById("DISP_DLVPRICE").innerHTML = plusComma(emsprice*1);
    <% end if %>
    if (comp.name=="quickdlv"){
        document.getElementById("DISP_DLVPRICE").innerHTML = plusComma(totalbeasongpay*1);
    }

    document.getElementById("DISP_SPENDMILEAGE").innerHTML = plusComma(spendmileage*-1);
    document.getElementById("DISP_SPENDTENCASH").innerHTML = plusComma(spendtencash*-1);
    document.getElementById("DISP_SPENDGIFTMONEY").innerHTML = plusComma(spendgiftmoney*-1);

    document.getElementById("DISP_ITEMCOUPON_TOTAL").innerHTML = plusComma(itemcouponmoney*-1);
    document.getElementById("DISP_SAILCOUPON_TOTAL").innerHTML = plusComma(couponmoney*-1);
    if (document.getElementById("DISP_KBCARDSALE_TOTAL")) document.getElementById("DISP_KBCARDSALE_TOTAL").innerHTML = plusComma(kbcardsalemoney*-1);

	document.getElementById("DISP_FIXPRICE").innerHTML = plusComma(fixprice*1);
    document.getElementById("DISP_SUBTOTALPRICE").innerHTML = plusComma(subtotalprice*1);
    document.frmorder.mobileprdprice.value = subtotalprice*1;

    frm.itemcouponmoney.value = itemcouponmoney*1;
    frm.couponmoney.value = couponmoney*1;
    frm.price.value= subtotalprice*1;
    frm.ooprice.value= subtotalprice*1;
    frm.fixprice.value= fixprice*1;

    <% if (IsUsePaybackMile) then %>
    var ipaybackmile = 0;
    var ipaybackBase = subtotalprice*1 + spendtencash*1 + spendgiftmoney*1;
    if (ipaybackBase>=300000){
    	ipaybackmile = parseInt(ipaybackBase*0.1*1);
    }else if (ipaybackBase>=200000){
    	ipaybackmile = parseInt(ipaybackBase*0.08*1);
    }else if (ipaybackBase>=100000){
    	ipaybackmile = parseInt(ipaybackBase*0.05*1);
    }else{
    	ipaybackmile = 0
    }

    document.getElementById("DISP_PAYBACKMILE").innerHTML = plusComma(ipaybackmile*1) + ' Point';
    if (ipaybackmile<1){
    	document.getElementById("idDISP_PAYBACKMILE").style.display = "none";
    }else{
    	document.getElementById("idDISP_PAYBACKMILE").style.display = "";
    }
    //if (ipaybackmile<1){alert('Payback 마일리지는 쿠폰/마일리지 제외금액 10만원 이상 구매시 지급됩니다.');}
    <% end if %>

    CheckGift(false);

    if (subtotalprice==0){
        document.getElementById("i_paymethod").style.display = "none";
		document.getElementById("paymethodTitle").style.display = "none";
		$("#refundInfo1").hide();
    }else{
        if (document.getElementById("i_paymethod").style.display=="none"){
            document.getElementById("i_paymethod").style.display = "inline";
        }
        if (document.getElementById("paymethodTitle").style.display=="none"){
            document.getElementById("paymethodTitle").style.display = "inline";
        }		
    }
}

function chkCouponDefaultSelect(comp){
    var frm = document.frmorder;
    var couponmoney  = 0;

    // 보너스 쿠폰 사용시 추가 할인 가능 상품합계.
    var duplicateSailAvailItemTotal = <%= oshoppingbag.GetTotalDuplicateSailAvailItemOrgPrice %>;

    //보너스 쿠폰인지 상품쿠폰인지여부.
    var ItemOrSailCoupon = "";
    var compid;

    couponmoney     = frm.couponmoney.value*1;

    if (!frm.itemcouponOrsailcoupon[0].checked) return;

    if (comp.name=="sailcoupon"){
        ItemOrSailCoupon = "S";
        frm.itemcouponOrsailcoupon[0].checked = true;
        //frm.itemcoupon.value="";

        compid = frm.sailcoupon[frm.sailcoupon.selectedIndex].id;

        coupontype  = compid.split("|")[0]; //compid.substr(0,1);
        couponvalue = compid.split("|")[1]; //compid.substr(2,255);
        couponmxdis = compid.split("|")[2]; //
        couponmxdis = parseInt(couponmxdis);
        
        if (coupontype=="0"){
            // 적용 가능 할인쿠폰이 아니거나 해당 상품이 없습니다.
            frm.sailcoupon.value="";
            couponmoney = 0;
        }else if (coupontype=="1"){
            // % 보너스쿠폰
		 	// couponmoney = parseInt(duplicateSailAvailItemTotal*1 * (couponvalue / 100)*1);
            couponmoney = parseInt(getPCpnDiscountPrice(couponvalue,couponmxdis,frm.sailcoupon[frm.sailcoupon.selectedIndex].value));
		 	// 추가 할인 불가 상품이 있을경우
		 	if (couponmoney*1==0){
		 	    //추가 할인되는 상품이 없습니다.
		 	    frm.sailcoupon.value="";
                couponmoney = 0;
		 	}
		}

		//RecalcuSubTotal(comp);
    }

}

function giftOptEnable(comp){
    <% if (OpenGiftExists) then %>
        <% for i=0 to oOpenGift.FResultCount-1 %>
        if (document.frmorder.gOpt_<%= oOpenGift.FItemList(i).Fgiftkind_code %>){
            document.frmorder.gOpt_<%= oOpenGift.FItemList(i).Fgiftkind_code %>.disabled = true;
            document.frmorder.gOpt_<%= oOpenGift.FItemList(i).Fgiftkind_code %>.selectedIndex=0;
        }
        <% next %>
    <% end if %>

    if (eval("document.frmorder.gOpt_" + comp.value)){
        eval("document.frmorder.gOpt_" + comp.value).disabled = false;
    }
}

function DgiftOptEnable(comp){
    //
}

function giftOptChange(comp){
    if (comp.options[comp.selectedIndex].id=="S"){
        alert('품절된 옵션은 선택 불가합니다.');
        comp.selectedIndex=0;
        comp.focus();
        return;
    }
}

function CheckGift(isFirst){
    var frm = document.frmorder;
    var fixprice = frm.fixprice.value*1;
    var availCnt = 0;
    var ischked = 0;
    if (frm.rRange){
        if (frm.rRange.length){
            for(var i=0;i<frm.rRange.length;i++){
                if (fixprice*1>=frm.rRange[i].id*1){
                    frm.rRange[i].disabled = false;
                    //default chk tenDlv

                    if (frm.rGiftDlv[i].value=="N"){
                        if (isFirst){
                            frm.rRange[i].checked = true;
                            giftOptEnable(frm.rRange[i]);
                            ischked = 1;
                        }else{
                            //if (frm.rRange[i].checked) ischked = 1;
                        }
                    }

                    //임시 //쿠폰만 있을경우
                    if ((ischked==1)&&(frm.rRange[i].id*1==150000)&&(isFirst)){
                        frm.rRange[i].checked = true;
                        giftOptEnable(frm.rRange[i]);
                        ischked = 1;
                    }

                    if (frm.rRange[i].checked) ischked = 1;

                    if (eval("document.frmorder.gOpt_" + frm.rRange[i].value)){
                        eval("document.frmorder.gOpt_" + frm.rRange[i].value).disabled = false;

                    }

                    availCnt++;
                }else{
                    frm.rRange[i].disabled = true;
                    frm.rRange[i].checked = false;
                    if (eval("document.frmorder.gOpt_" + frm.rRange[i].value)){
                        eval("document.frmorder.gOpt_" + frm.rRange[i].value).disabled = true;
                    }
                }
            }
        }else{
            if (fixprice*1>=frm.rRange.id*1){
                frm.rRange.disabled = false;
                if (isFirst){
                    frm.rRange.checked = true;
                    giftOptEnable(frm.rRange);
                    ischked = 1;
                }else{
                    if (frm.rRange.checked) ischked = 1;
                }

                if (eval("document.frmorder.gOpt_" + frm.rRange.value)){
                    eval("document.frmorder.gOpt_" + frm.rRange.value).disabled = false;
                }
                availCnt++;
            }else{
                frm.rRange.disabled = true;
                frm.rRange.checked = false;
                if (eval("document.frmorder.gOpt_" + frm.rRange.value)){
                    eval("document.frmorder.gOpt_" + frm.rRange.value).disabled = true;
                }
            }
        }

        //When NoChecked Check Last
        if (ischked!=1){
            if (frm.rRange.length){
                for(var i=0;i<frm.rRange.length;i++){
                    if (frm.rRange[i].disabled!=true){
                        frm.rRange[i].checked = true;
                        giftOptEnable(frm.rRange[i]);
                        ischked = 1;
                    }
                }
            }else{
                <% '20170810 전체 사은이벤트 쿠폰사용으로 disabled 되었을경우   %>
                if (frm.rRange.disabled!=true){  
                    frm.rRange.checked = true;
                    giftOptEnable(frm.rRange);
                    ischked = 1;
                }
            }
        }
        
        <% '20170810 전체 사은이벤트 쿠폰사용으로 disabled 되었을경우   %>
        if (ischked!=1){
			if (ChkAlert) {
				//alert('아쉽지만 선착순마감으로 사은품은 해당되지 않으시니 이점 깊은 양해바랍니다');
			}
            ChkAlert = false;
        }
    }

    //20121012
    checkDiaryGift(isFirst);
}


function plusComma(num){
	if (num < 0) { num *= -1; var minus = true}
	else var minus = false

	var dotPos = (num+"").split(".")
	var dotU = dotPos[0]
	var dotD = dotPos[1]
	var commaFlag = dotU.length%3

	if(commaFlag) {
		var out = dotU.substring(0, commaFlag)
		if (dotU.length > 3) out += ","
	}
	else var out = ""

	for (var i=commaFlag; i < dotU.length; i+=3) {
		out += dotU.substring(i, i+3)
		if( i < dotU.length-3) out += ","
	}

	if(minus) out = "-" + out
	if(dotD) return out + "." + dotD
	else return out
}

function AssignBonusCoupon(bool,icoupontype,icouponvalue){
    var iasgnCouponMoney = 0;
    if ((icoupontype=="2")&&(icouponvalue*1>0)){
        $.ajax({
    		url: "/inipay/getPCpndiscount.asp?icoupontype="+icoupontype+"&icouponvalue="+icouponvalue+"&jumunDiv=<%=jumunDiv%>",
    		cache: false,
    		async: false,
    		success: function(message) {
    			iasgnCouponMoney = message;
    		}
    	});
	}
    return iasgnCouponMoney;
}

function AssignBCBonusCoupon(icoupontype,icouponvalue,icouponid){
    var iasgnCouponMoney = 0;
    if (((icoupontype=="6")||(icoupontype=="7"))&&(icouponvalue*1>0)){
        $.ajax({
    		url: "/inipay/getPCpndiscount.asp?icoupontype="+icoupontype+"&icouponvalue="+icouponvalue+"&icouponid="+icouponid+"&jumunDiv=<%=jumunDiv%>",
    		cache: false,
    		async: false,
    		success: function(message) {
    			iasgnCouponMoney = message;
    		}
    	});
    }
    return iasgnCouponMoney;
}

function AssignMXBonusCoupon(icoupontype,icouponvalue,icouponid){
    var iasgnCouponMoney = 0;
    if ((icoupontype=="1")&&(icouponvalue*1>0)&&(icouponid*1>0)){
        $.ajax({
    		url: "/inipay/getPCpndiscount.asp?icoupontype="+icoupontype+"&icouponvalue="+icouponvalue+"&icouponid="+icouponid+"&jumunDiv=<%=jumunDiv%>",
    		cache: false,
    		async: false,
    		success: function(message) {
    			iasgnCouponMoney = message;
    		}
    	});
    }
    return iasgnCouponMoney;
}

function AssignItemCoupon(bool){
    var itemcouponmoney = 0 ;
    var frm = document.baguniFrm;

    if (frm.distinctkey.length==undefined){
        if ((bool)&&(frm.curritemcouponidxflag.value!="")&&(frm.couponsailpriceflag.value*1!=0)){
            itemcouponmoney = frm.couponsailpriceflag.value * 1;
            document.getElementById("HTML_itemcouponcost_0").innerHTML = "<br>" + plusComma(frm.itemcouponsellpriceflag.value) + "원";
            document.getElementById("HTML_itemcouponcostsum_0").innerHTML = "<br>" + plusComma(frm.itemcouponsellpriceflag.value*1*frm.itemea.value*1) + "원";
        }else{
            document.getElementById("HTML_itemcouponcost_0").innerHTML = "";
            document.getElementById("HTML_itemcouponcostsum_0").innerHTML = "";
        }
    }else{
        for (var i=0;i<frm.distinctkey.length;i++){
            if ((bool)&&(frm.curritemcouponidxflag[i].value!="")&&(frm.couponsailpriceflag[i].value*1!=0)){
                itemcouponmoney = itemcouponmoney + frm.couponsailpriceflag[i].value * 1;
                distinctkey = frm.distinctkey[i].value;
                document.getElementById("HTML_itemcouponcost_" + distinctkey).innerHTML = "<br>" + plusComma(frm.itemcouponsellpriceflag[i].value) + "원";
                document.getElementById("HTML_itemcouponcostsum_" + distinctkey).innerHTML = "<br>" + plusComma(frm.itemcouponsellpriceflag[i].value*1*frm.itemea[i].value*1) + "원";

            }else{
                distinctkey = frm.distinctkey[i].value;
                document.getElementById("HTML_itemcouponcost_" + distinctkey).innerHTML = "";
                document.getElementById("HTML_itemcouponcostsum_" + distinctkey).innerHTML = "";
            }
		}
    }

    return itemcouponmoney;
}

function getPCpnDiscountPrice(icouponvalue,couponmxdis,icouponid){
    var pcouponmoney = 0 ;
    var frm = document.baguniFrm;
    if (frm.distinctkey.length==undefined){
		pcouponmoney = parseInt(Math.ceil(frm.pCpnBasePrc.value * icouponvalue / 100)*frm.itemea.value*1)*1;
    }else{
        for (var i=0;i<frm.distinctkey.length;i++){
            pcouponmoney = pcouponmoney*1 + parseInt(Math.ceil(frm.pCpnBasePrc[i].value * icouponvalue / 100)*frm.itemea[i].value*1)*1;
        }
    }
    couponmxdis = parseInt(couponmxdis);
    
    if ((couponmxdis*1>0)&&(pcouponmoney>couponmxdis)){
        pcouponmoney=AssignMXBonusCoupon("1",icouponvalue,icouponid);
    }
    return pcouponmoney;
}

function getPCpnDiscountPriceLimit(icouponvalue){
    var pcouponmoney = 0 ;
    var frm = document.baguniFrm;
    if (frm.distinctkey.length==undefined){
        //pcouponmoney = parseInt(Math.ceil(frm.pCpnBasePrc.value * icouponvalue / 100)*frm.itemea.value*1)*1;
        pcouponmoney = parseInt(Math.ceil(parseInt(frm.pCpnBasePrc.value * icouponvalue*100000)/100000 / 100)*frm.itemea.value*1)*1;
    }else{
        for (var i=0;i<frm.distinctkey.length;i++){
            //pcouponmoney = pcouponmoney*1 + parseInt(Math.ceil(frm.pCpnBasePrc[i].value * icouponvalue / 100)*frm.itemea[i].value*1)*1;
            pcouponmoney = pcouponmoney*1 + parseInt(Math.ceil(parseInt(frm.pCpnBasePrc[i].value * icouponvalue*100000)/100000 / 100)*frm.itemea[i].value*1)*1;
        }
    }
    return pcouponmoney;
}

function getCpnDiscountTenPrice(icoupontype, icouponvalue){
    var frm = document.baguniFrm;
    var dval = <%=TenDlvItemPriceCpnAssign%>;
    var cval = 0
    var udExsists = false;

    if (icoupontype=='1'){
        if (frm.distinctkey.length==undefined){
            if ((frm.dtypflag.value=="1")||(frm.dtypflag.value=="4")){
                cval = frm.isellprc.value*1*frm.itemea.value*1 - parseInt(Math.round(frm.pCpnBasePrc.value * icouponvalue / 100)*frm.itemea.value*1)*1;
            }
        }else{
            for (var i=0;i<frm.distinctkey.length;i++){
                if ((frm.dtypflag[i].value=="1")||(frm.dtypflag[i].value=="4")){
                    cval = cval*1 + frm.isellprc[i].value*1*frm.itemea[i].value*1 - parseInt(Math.round(frm.pCpnBasePrc[i].value * icouponvalue / 100)*frm.itemea[i].value*1)*1;
                }
            }
        }

        return cval;

    }else if (icoupontype=='2'){
        if (frm.distinctkey.length==undefined){
            if ((frm.dtypflag.value!="1")&&(frm.dtypflag.value!="4")){
                udExsists = true
            }
        }else{
            for (var i=0;i<frm.distinctkey.length;i++){
               if ((frm.dtypflag[i].value!="1")&&(frm.dtypflag[i].value!="4")){
                udExsists = true;
                break;
               }
            }
        }
        if (udExsists){
            return dval;
        }else{
            return dval*1-icouponvalue*1;
            alert(icouponvalue)
        }
    }else{
        return dval;
    }
}

function showInsureDetail(comp){
	if (comp.checked){
		document.getElementById("insure_detail").style.display = "inline";
	}else{
		document.getElementById("insure_detail").style.display = "none";
	}
}

function cashReceiptValidClick(comp){
    if (comp.disabled) comp.disabled=false;
}

function showCashReceptDetail(comp){
    var frm = comp.form;

    if (comp.name=="cashreceiptreq3"){
        var comp1 = frm.useopt3[0];
        var comp2 = frm.useopt3[1];
        var comp3 = frm.cashReceipt_ssn3;
    } else if (comp.name=="cashreceiptreq2"){
        var comp1 = frm.useopt2[0];
        var comp2 = frm.useopt2[1];
        var comp3 = frm.cashReceipt_ssn2;
    }else{
        var comp1 = frm.useopt[0];
        var comp2 = frm.useopt[1];
        var comp3 = frm.cashReceipt_ssn;
    }

	if (comp.checked){
	    comp1.disabled=false;
	    comp2.disabled=false;
        comp3.disabled=false;
        comp3.style.backgroundColor="#FFFFFF";
	}else{
	    comp1.checked=false;
	    comp2.checked=false;

	    comp1.disabled=true;
	    comp2.disabled=true;
	    comp3.disabled=true;
	    comp3.style.backgroundColor="#EEEEEE";
	}
}

function showCashReceptSubDetail(comp){
    if (comp.value=="0"){
		//document.getElementById("cashReceipt_subdetail1").style.display = "inline";
		//document.getElementById("cashReceipt_subdetail2").style.display = "none";
	}else{
		//document.getElementById("cashReceipt_subdetail1").style.display = "none";
		//document.getElementById("cashReceipt_subdetail2").style.display = "inline";
	}
}

function emsBoxChange(comp){
    var frm = comp.form;
    var iMaxWeight = 30000;  //(g)
    var totalWeight = <%= oshoppingbag.getEmsTotalWeight %>;
    var contryName = '';

    if (comp.value==''){
        frm.countryCode.value = '';
        frm.emsAreaCode.value = '';
		document.getElementById("divEmsAreaCode").innerHTML = "1";
		contryName = frm.countryCode.text;
    }else{
        frm.countryCode.value = comp.value;

        //for firefox
        frm.emsAreaCode.value = comp[comp.selectedIndex].id.split("|")[0]; 
        iMaxWeight = comp[comp.selectedIndex].id.split("|")[1]; 
        //frm.emsAreaCode.value = comp[comp.selectedIndex].iAreaCode;
        //iMaxWeight = comp[comp.selectedIndex].iMaxWeight;
		document.getElementById("divEmsAreaCode").innerHTML = frm.emsAreaCode.value;
		contryName = comp[comp.selectedIndex].text;
    }

	//2011-03-15 일본대지진으로인한 일본지역 배송 안내
	//if(frm.countryCode.value=="JP") alert("일본동북부에서 발생된 강진및 쓰나미로 인해, 일본해외배송의 일부지역이 배송이 원활하지 않습니다.\n\n배송 중지 지역 등의 자세한 내용은 공지사항을 참조해주세요.");

    //iMaxWeight 체크
    if (totalWeight>iMaxWeight){
        alert('죄송합니다. ' + contryName + ' 최대 배송 가능 중량은 ' + iMaxWeight + ' (g)입니다.');
        comp.value='';
        //return;
    }

    //가격 계산.
    calcuEmsPrice(frm.emsAreaCode.value);

}

function calcuEmsPrice(emsAreaCode){
    //divEmsPrice
    var emsprice = 0;

    var _emsAreaCode = new Array(<%= oemsPrice.FResultCount %>);
    var _emsPrice = new Array(<%= oemsPrice.FResultCount %>);
    var pojangcash= <%= pojangcash %>;

    <% for i=0 to oemsPrice.FResultCount-1 %>
        _emsAreaCode[<%= i %>] = '<%= oemsPrice.FItemList(i).FemsAreaCode %>';
        _emsPrice[<%= i %>] = '<%= oemsPrice.FItemList(i).FemsPrice %>';
    <% next %>

    for (var i=0;i<_emsAreaCode.length;i++){
        if (_emsAreaCode[i]==emsAreaCode){
            emsprice = _emsPrice[i];
            break;
        }
    }

    document.getElementById("divEmsPrice").innerHTML = plusComma(emsprice);
    document.getElementById("DISP_DLVPRICE").innerHTML = plusComma(emsprice);

    document.frmorder.emsprice.value = emsprice;
    RecalcuSubTotal(document.frmorder.emsprice);
    if (document.getElementById("divEmsPriceUp")){
        document.getElementById("divEmsPriceUp").innerHTML = plusComma(emsprice);
        document.getElementById("DISP_FIXPRICEUp").innerHTML = plusComma(<%= oshoppingbag.GetTotalItemOrgPrice %> + emsprice*1 + pojangcash*1);
    }
}

function popEmsApplyGoCondition(){
    var nation = 'GR';
    if (document.frmorder.countryCode.value!='') nation = document.frmorder.countryCode.value;

    var popwin = window.open('http://ems.epost.go.kr:8080/front.EmsApplyGoCondition.postal?nation=' + nation,'EmsApplyGoCondition','scrollbars=yes,resizable=yes,width=620,height=600');
}

function popEmsCharge(){
    var cCode = document.frmorder.emsCountry.value;

    if (cCode==''){
        alert('국가를 먼저 선택 하세요.');
        document.frmorder.emsCountry.focus();
        return;
    }

    var popwin = window.open('popEmsCharge.asp?cCode=' + document.frmorder.emsCountry.value,'popEmsCharge','scrollbars=yes,resizable=yes,width=557,height=660');
    popwin.focus();
}


function popMobileExp(){
	var MobileExp = window.open('<%=wwwUrl%>/inipay/mobile_explain.asp','popLogin','width=500,height=775');
	MobileExp.focus();
}

function popGiftDetail(gKCode,gCode){
    var popWin = window.open('<%=wwwUrl%>/inipay/popGiftDetail.asp?gKCode='+gKCode+'&gCode='+gCode,'popGiftDetail','width=500,height=775');
	popWin.focus();
}

function popOkcashbagPW(){
	var OKCashbagPW = window.open('<%=wwwUrl%>/inipay/popOkCashbag_pw.asp','popOKCashbagPWch','width=540,height=620');
	OKCashbagPW.focus();
}

function popTicketCancelInfo(){
    var popWin = window.open('<%=wwwUrl%>/cscenter/help/pop_tincketRefund.htm','popTicketCancelInfo','scrollbars=yes,resizable=yes,width=736,height=600');
	popWin.focus();
}

//function showTenMoneyNoti(){
//    var comp = document.getElementById("idtenMoney");
//    comp.style.visibility = "visible";
//}
//
//function hideTenMoneyNoti(){
//    var comp = document.getElementById("idtenMoney");
//    comp.style.visibility = "hidden";
//}
//
//function showGiftMoneyNoti(){
//    var comp = document.getElementById("idgiftMoney");
//    comp.style.visibility = "visible";
//}
//
//function hideGiftMoneyNoti(){
//    var comp = document.getElementById("idgiftMoney");
//    comp.style.visibility = "hidden";
//}

function checkCashreceiptSSN(opttype,ssncomp){
    if (opttype==0){
        if(ssncomp.value.length !=10 && ssncomp.value.length !=11 && ssncomp.value.length !=18){
        	alert("올바른 현금영수증카드 번호(18자리) 또는 휴대폰 번호 10자리(11자리)를 입력하세요.");
        	ssncomp.focus();
        	return false;
        } else if(ssncomp.value.length == 11 ||ssncomp.value.length == 10 ){
        	var obj = ssncomp.value;
        	if (obj.substring(0,3)!= "011" && obj.substring(0,3)!= "017" && obj.substring(0,3)!= "016" && obj.substring(0,3)!= "018" && obj.substring(0,3)!= "019" && obj.substring(0,3)!= "010")
        	{
        		alert("올바른 휴대폰 번호 10자리(11자리)를 입력하세요. ");
        		ssncomp.focus();
        		return false;
        	}

        	var chr1;
        	for(var i=0; i<obj.length; i++){

            		chr1 = obj.substr(i, 1);
            		if( chr1 < '0' || chr1 > '9') {
        			alert("숫자가 아닌 문자가 휴대폰 번호에 추가되어 오류가 있습니다, 다시 확인 하십시오. ");
        			ssncomp.focus();
        			return false;
        		}
        	}
        } else if(ssncomp.value.length == 18){
        	var obj = ssncomp.value;

        	var chr1;
        	for(var i=0; i<obj.length; i++){

            		chr1 = obj.substr(i, 1);
            		if( chr1 < '0' || chr1 > '9') {
        			alert("숫자가 아닌 문자가 카드 번호에 추가되어 오류가 있습니다, 다시 확인 하십시오. ");
        			ssncomp.focus();
        			return false;
        		}
        	}
        }
    }

    if (opttype==1){
        if(ssncomp.value.length !=10  && ssncomp.value.length !=11  && ssncomp.value.length !=18 ){
			alert("올바른 현금영수증카드 번호(18자리), 사업자등록번호 10자리 또는 휴대폰 번호 10자리(11자리)를 입력하세요.");
			ssncomp.focus();
			return false;
		} else if(ssncomp.value.length == 10 && ssncomp.value.substring(0,1)!= "0"){
   			var vencod = ssncomp.value;
   			var sum1 = 0;
   			var getlist =new Array(10);
   			var chkvalue =new Array("1","3","7","1","3","7","1","3","5");
   			for(var i=0; i<10; i++) { getlist[i] = vencod.substring(i, i+1); }
   			for(var i=0; i<9; i++) { sum1 += getlist[i]*chkvalue[i]; }
   			sum1 = sum1 + parseInt((getlist[8]*5)/10);
   			sidliy = sum1 % 10;
   			sidchk = 0;
   			if(sidliy != 0) { sidchk = 10 - sidliy; }
   			else { sidchk = 0; }
   			if(sidchk != getlist[9]) {
   				alert("올바른 사업자 번호를 입력하시기 바랍니다. ");
   				ssncomp.focus();
   			    return false;
   			} else {
			    //alert("number ok");
			    //return;
			}

		} else if(ssncomp.value.length == 11 ||ssncomp.value.length == 10 ) {
        	var obj = ssncomp.value;
        	if (obj.substring(0,3)!= "011" && obj.substring(0,3)!= "017" && obj.substring(0,3)!= "016" && obj.substring(0,3)!= "018" && obj.substring(0,3)!= "019" && obj.substring(0,3)!= "010") {
        		alert("실제 번호를 입력하시지 않아 실행에 실패하였습니다. 다시 입력하시기 바랍니다. ");
        		ssncomp.focus();
        		return false;
        	}

        	var chr;
			for(var i=0; i<obj.length; i++){
        		chr = obj.substr(i, 1);
        		if( chr < '0' || chr > '9') {
					alert("실제 번호를 입력하시지 않아 실행에 실패하였습니다. 다시 입력하시기 바랍니다. ");
					ssncomp.focus();
					return false;
				}
			}
		} else if(ssncomp.value.length == 18){
        	var obj = ssncomp.value;

        	var chr1;
        	for(var i=0; i<obj.length; i++){

            		chr1 = obj.substr(i, 1);
            		if( chr1 < '0' || chr1 > '9') {
        			alert("숫자가 아닌 문자가 카드 번호에 추가되어 오류가 있습니다, 다시 확인 하십시오. ");
        			ssncomp.focus();
        			return false;
        		}
        	}
        }
    }
    return true;
}

function fnChgKakaoSend() {
	var frm = document.frmorder;
	if(frm.chkKakaoSend.checked) {
		if(frm.buyhp1.value!=frm.buyhp1.getAttribute("default")||frm.buyhp2.value!=frm.buyhp2.getAttribute("default")||frm.buyhp3.value!=frm.buyhp3.getAttribute("default")) {
			if(confirm("카카오톡으로 받기는 인증을 한 휴대번호인 경우에만 가능합니다.\n인증받으신 번호로 수정하시겠습니까?")) {
				frm.buyhp1.value=frm.buyhp1.getAttribute("default");
				frm.buyhp2.value=frm.buyhp2.getAttribute("default");
				frm.buyhp3.value=frm.buyhp3.getAttribute("default");
				frm.buyhp1.style.backgroundColor="#EEEEEE";
				frm.buyhp2.style.backgroundColor="#EEEEEE";
				frm.buyhp3.style.backgroundColor="#EEEEEE";
				frm.buyhp1.readOnly=true;
				frm.buyhp2.readOnly=true;
				frm.buyhp3.readOnly=true;
			} else {
				frm.chkKakaoSend.checked=false;
			}
		} else {
			frm.buyhp1.style.backgroundColor="#EEEEEE";
			frm.buyhp2.style.backgroundColor="#EEEEEE";
			frm.buyhp3.style.backgroundColor="#EEEEEE";
			frm.buyhp1.readOnly=true;
			frm.buyhp2.readOnly=true;
			frm.buyhp3.readOnly=true;
		}
	} else {
		frm.buyhp1.style.backgroundColor="#FFFFFF";
		frm.buyhp2.style.backgroundColor="#FFFFFF";
		frm.buyhp3.style.backgroundColor="#FFFFFF";
		frm.buyhp1.readOnly=false;
		frm.buyhp2.readOnly=false;
		frm.buyhp3.readOnly=false;
	}
}

function UpDnDiaryGift(i,n){
    var frm = document.frmorder;
    var pVal = 0;
    var ttlDiVal = 0;
    var dgMaxVal = <%=DiaryGiftCNT %>;
    var comp=null;

    if (frm.DiNo[i]){
        comp=frm.DiNo[i];
        if (frm.DiNo_disable[i].value!="Y"){
            pVal = comp.value*1;
            comp.value=comp.value*1+n*1;

            if (comp.value*1<1) comp.value=0;

            if (comp.value*1>dgMaxVal){
                comp.value=dgMaxVal;
                alert('받으실 사은품수량 '+dgMaxVal+'개를 초과할 수 없습니다.');
                return;
            }
        }else{
            comp.value=0;
        }
    }

    if (frm.DiNo.length){
        ttlDiVal=0;
        for (var i=0;i<frm.DiNo.length;i++){
            ttlDiVal = ttlDiVal + frm.DiNo[i].value*1;
        }

        if ((n*1>0)&&(ttlDiVal>dgMaxVal)){
            for (var i=0;i<frm.DiNo.length;i++){
                if (comp!=frm.DiNo[i]){
                    if (frm.DiNo[i].value*1>=n*1){
                        frm.DiNo[i].value=frm.DiNo[i].value*1-n*1;
                        break;
                    }
                }
            }
        }
        ttlDiVal=0;
        for (var i=0;i<frm.DiNo.length;i++){
            ttlDiVal = ttlDiVal + frm.DiNo[i].value*1;
        }
    }

    if (document.getElementById("HTML_DiaryGiftSelCNT")){
        document.getElementById("HTML_DiaryGiftSelCNT").innerHTML = plusComma(ttlDiVal*1);
    }

}

function checkDiaryGift(isFirst){
    var frm = document.frmorder;
    var TenDlvItemPrice = 0;

    if (frm.TenDlvItemPrice){
        frm.TenDlvItemPrice.value=<%=TenDlvItemPriceCpnNotAssign%>;
        if (frm.itemcouponOrsailcoupon[1].checked){
            frm.TenDlvItemPrice.value=<%=TenDlvItemPriceCpnAssign%>;
        }else{
            frm.TenDlvItemPrice.value=frm.fixpriceTenItm.value;
        }

        TenDlvItemPrice = frm.TenDlvItemPrice.value;
    }

	if (document.getElementById("HTML_TenDlvItemPrice")){
        document.getElementById("HTML_TenDlvItemPrice").innerHTML = plusComma(TenDlvItemPrice*1);
    }

    var availCnt = 0;
    var ischked = 0;

	TenDlvItemPrice = frm.fixprice.value*1; //2019/09/04
	
	if (frm.dRange){
        if (frm.dRange.length){
            for(var i=0;i<frm.dRange.length;i++){
                if (TenDlvItemPrice*1>=frm.dRange[i].id*1){
                    frm.dRange[i].disabled = false;
                    //default chk tenDlv

                    if (frm.dGiftDlv[i].value=="N"){
                        if (isFirst){
                            frm.dRange[i].checked = true;
                            //DgiftOptEnable(frm.dRange[i]);
                            ischked = 1;
                        }else{
                            //if (frm.dRange[i].checked) ischked = 1;
                        }
                    }

                    //임시 //쿠폰만 있을경우
                    if ((ischked==1)&&(frm.dRange[i].id*1==150000)&&(isFirst)){
                        frm.dRange[i].checked = true;
                        //DgiftOptEnable(frm.dRange[i]);
                        ischked = 1;
                    }

                    if (frm.dRange[i].checked) ischked = 1;

                    availCnt++;
                }else{
                    frm.dRange[i].disabled = true;
                    frm.dRange[i].checked = false;
                }
            }
        }else{
            if (TenDlvItemPrice*1>=frm.dRange.id*1){
				frm.dRange.disabled = false;
                if (isFirst){
                    frm.dRange.checked = true;
                    //DgiftOptEnable(frm.dRange);
                    ischked = 1;
                }else{
                    if (frm.dRange.checked) ischked = 1;
                }

                availCnt++;
            }else{
                frm.dRange.disabled = true;
                frm.dRange.checked = false;
            }
        }

        //When NoChecked Check Last
        if (ischked!=1){
            if (frm.dRange.length){
                for(var i=0;i<frm.dRange.length;i++){
                    if (frm.dRange[i].disabled!=true){
                        frm.dRange[i].checked = true;
                        //DgiftOptEnable(frm.dRange[i]);
                    }
                }
            }else{
				if (frm.dRange.disabled == false){
					frm.dRange.checked = true;
				}
                //DgiftOptEnable(frm.dRange);
            }
        }
    }
}

function reloadpojang(chval){
	pojangfrm.reload.value=chval;
	pojangfrm.submit();
} 

function packreg(reload){
	//신규등록
	if (reload==''){
		if (confirm('이용중 팝업을 강제로 종료할 경우,\n설정된 포장 내용은 저장되지 않습니다.')){
			var pop_packreg = window.open('<%= SSLURL %>/inipay/pack/pack_step_intro.asp','pop_packreg','width=800,height=800,scrollbars=no,resizable=yes');
			pop_packreg.focus();
		}
	}else{
		var pop_packreg = window.open('<%= SSLURL %>/inipay/pack/pack_step1.asp','pop_packreg','width=800,height=800,scrollbars=no,resizable=yes');
		pop_packreg.focus();
	}
}

$(function() {
	/* wrapping msg */
	$(".wrappingMsgV15a .btnClose").click(function() {
		$(".wrappingMsgV15a").effect("blind");
	});

	/* tootip */
	$('.infoMoreViewV15').mouseover(function(){
		$(this).children('.infoViewLyrV15').show();
	});
	$('.infoMoreViewV15').mouseleave(function(){
		$(this).children('.infoViewLyrV15').hide();
	});
});

function fnCommentMsg(v){
	if(v == "etc"){
		$("#delivmsg").show();
		document.frmorder.comment_etc.focus();
	}else{
		$("#delivmsg").hide();
	}
}

$(function() {
	document.getElementById("delivmsg").style.display = "none";
	<%
		'// 배송 요청사항
		dim myLastOrderComment : myLastOrderComment = fnGetMyLastOrderComment(userid)
		if myLastOrderComment <> "" and not(IsForeignDlv) then
	%>
		var x = document.frmorder.comment.options;
		var etc = document.frmorder.comment_etc;
		for ( var i = 0; i < x.length; i++ ) {
			var commentValue = x[i].value;
			if (commentValue.indexOf("<%=myLastOrderComment%>") > -1 ) {
				x[i].selected = true;
				break;
			} else {
				if (commentValue.indexOf("etc") > -1) {
					x[i].selected = true;
					document.getElementById("delivmsg").style.display = "block";
					etc.value = "<%=myLastOrderComment%>";
				}
			}
		}
	<%
		end if 
	%>
})
</script>
<style type="text/css">
.cartWrap {background:#eee url(/fiximage/web2013/cart/cart_headbg.gif) left top repeat-x; padding:25px 20px 25px 20px;}
.cartHeader {overflow:hidden;}
.orderStep {float:left; width:660px; padding-top:24px;}
.orderStep span {float:left; padding:0 36px; width:148px; height:91px; text-indent:-9999px; overflow:hidden; background-position:center top; background-repeat:no-repeat;}
.orderStep span.step01SSL {background-image:url(/fiximage/web2013/cart/order_step01.gif);}
.orderStep span.step02SSL {background-image:url(/fiximage/web2013/cart/order_step02.gif);}
.orderStep span.step03SSL {background-image:url(/fiximage/web2013/cart/order_step03.gif);}
.orderStep h2 span {background-position:center -91px;}

.btnGrylightNone {color:#555; background:#f4f4f4; border:1px solid #e0e0e0;}
.rmvIEx::-ms-clear {display: none;}

.lyNaverpay {position:fixed; top:50% !important; left:50% !important; z-index:91000; width:180px; height:180px; margin:-90px 0 0 -90px; border-radius:50%; background-color:#fff; text-align:center;}
.lyNaverpay p {padding-top:73px; color:#000; font-weight:bold;}
.lyNaverpay .btnClose {position:absolute; top:-5px; right:-5px; width:30px; height:30px; background:transparent url(//fiximage.10x10.co.kr/web2015/common/btn_close_white.png) no-repeat 50% 50%; text-indent:-9999em;}

.lyPayco {position:fixed; top:50% !important; left:50% !important; z-index:91000; width:180px; height:180px; margin:-90px 0 0 -90px; border-radius:50%; background-color:#fff; text-align:center;}
.lyPayco p {padding-top:73px; color:#000; font-weight:bold;}
.lyPayco .btnClose {position:absolute; top:-5px; right:-5px; width:30px; height:30px; background:transparent url(//fiximage.10x10.co.kr/web2015/common/btn_close_white.png) no-repeat 50% 50%; text-indent:-9999em;}

.lyToss {position:fixed; top:50% !important; left:50% !important; z-index:91000; width:180px; height:180px; margin:-90px 0 0 -90px; border-radius:50%; background-color:#fff; text-align:center;}
.lyToss p {padding-top:73px; color:#000; font-weight:bold;}
.lyToss .btnClose {position:absolute; top:-5px; right:-5px; width:30px; height:30px; background:transparent url(//fiximage.10x10.co.kr/web2015/common/btn_close_white.png) no-repeat 50% 50%; text-indent:-9999em;}
</style>
</head>
<body>
<%
    Dim adult_normal_flag : adult_normal_flag   = "N"
    FOR i=0 to oshoppingbag.FShoppingBagItemCount - 1
        IF oshoppingbag.FItemList(i).FAdultType <> 0 THEN
            adult_normal_flag = "Y"
        END IF
    NEXT

    IF adult_normal_flag <> "Y" OR (adult_normal_flag="Y" AND session("isAdult")=True) THEN
%>
    <div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader_SSL.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="cartWrap orderWrap">
				<div class="cartHeader">
					<div class="orderStep">
						<span class="step01SSL">장바구니</span>
						<h2><span class="step02SSL">주문결제</span></h2>
						<span class="step03SSL">주문완료</span>
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

				<%
				'선물포장서비스 노출
				if G_IsPojangok then
					'/선물포장가능상품
					if oshoppingbag.IsPojangValidItemExists then
				%>
						<%
						'/선물포장완료상품존재
						if oshoppingbag.IsPojangcompleteExists then
						%>
							<div class="wrappingMsgV15a">
								<div class="btnGuide"><a href="#lyWrappingV15a" onclick="fnOpenModal('/shopping/pop_wrappingInfo.html');return false;">선물포장 안내</a></div>
								<p><img src="http://fiximage.10x10.co.kr/web2015/inipay/txt_wrapping_service_done.png" alt="선정성을 담은 선물포장이 완료되었습니다!" /></p>
								<a href="#" onclick="packreg('ON'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/inipay/btn_wrapping_edit.png" alt="선물포장 수정" /></a>
								<!--<button type="button" class="btnClose">닫기</button>-->
							</div>
						<% else %>
							<div class="wrappingMsgV15a">
								<div class="btnGuide"><a href="#lyWrappingV15a" onclick="fnOpenModal('/shopping/pop_wrappingInfo.html');return false;">선물포장 안내</a></div>
								<p><img src="http://fiximage.10x10.co.kr/web2015/inipay/txt_wrapping_service_possible.png" alt="선물포장이 가능한 상품이 있네요?" /></p>
								<a href="#" onclick="packreg(''); return false;"><img src="http://fiximage.10x10.co.kr/web2015/inipay/btn_wrapping_apply.png" alt="선물포장 신청" /></a>
								<!--<button type="button" class="btnClose">닫기</button>-->
							</div>
						<% end if %>

						<% '<!--- for dev msg : 선물포장 안내 Layer --> %>
						<div id="lyWrappingV15a">
							<div class="lyWrappingV15a window">
								<section>
									<div class="inner">
										<h1><img src="http://fiximage.10x10.co.kr/web2015/common/tit_wrapping_guide.png" alt="선물포장 안내" /></h1>
										<div class="figure">
											<img src="http://fiximage.10x10.co.kr/web2015/temp/@img_454x275_01.jpg" width="454" height="275" alt="" /><!-- for dev msg : alt값 상품명 -->
											<p>* 포장비 및 구성은 포장 환경에 맞춰 임의로 변경 될 수 있습니다.</p>
										</div>
										<div class="desc">
											<h2>알아두기</h2>
											<ul class="list01V15">
												<li>불가피한 사정으로 인해 포장 협의가 필요할 경우 회원님께 직접 연락을 드린 후 선물포장을 진행합니다.</li>
												<li>업체배송, 해외배송 상품은 선물포장을 지원하지 않습니다.</li>
												<li>선물패키지의 포장 기준에 맞지 않을 경우 선물포장을 지원하지 않습니다.</li>
											</ul>
		
											<h2>취소 및 환불 정책</h2>
											<ul class="list01V15">
												<li>주문결제 후 &apos;<strong class="cRd0V15 fn">상품준비중</strong>&apos; 단계로 넘어갔을 경우, 이미 선물포장 작업이 들어간 상태이기 때문에 주문을 취소하여도 <strong class="cRd0V15 fn">선물포장비 환불이 불가능</strong>합니다.</li>
												<li>교환/환불시 <strong class="cRd0V15 fn">상품에 문제가 있을 경우</strong>에만 재포장 교환 및 환불이 가능합니다.</li>
											</ul>
										</div>
										<button type="button" onclick="ClosePopLayer()" class="btnClose">close</button>
									</div>
								</section>
							</div>
						</div>
					<% end if %>
				<% end if %>

				<div class="cartBox tMar15">
					<div class="overHidden">
						<h3>주문리스트 확인</h3>
						<% if (IsForeignDlv) then %>
						<span class="fs11 ftLt tPad05 lPad10 cr777">해외 배송비는 <span class="crRed">배송 국가와 상품의 중량에 따라 부과</span>됩니다. (배송방법 : EMS)</span>
						<% elseif (IsArmyDlv) then %>
						<span class="fs11 ftLt tPad05 lPad10 cr777">군부대 주문은 우체국 택배 이용으로 구매금액과 상관없이 <span class="crRed">배송비 3,000원이 부과</span>됩니다.</span>
						<% else %>
						<% end if %>
					</div>
					<table class="baseTable tMar10">
						<caption>주문리스트</caption>
						<colgroup>
							<%
							'선물포장서비스 노출
							if G_IsPojangok then
							%>
								<col width="110px" /><col width="55px" /><col width="" /><% if (IsForeignDlv) then %><col width="60px" /><% end if %><col width="110px" />
	
								<% if IsPresentOrder Then 'Present주문일 경우 %>
									<col width="" />
								<% else %>
									<col width="80px" /><col width="95px" /><col width="95px" /><col width="110px" />
								<% end if %>
	
								<col width="95px" />
							<% else %>
								<col width="120px" /><col width="55px" /><col width="" /><% if (IsForeignDlv) then %><col width="60px" /><% end if %><col width="110px" />
								<% if IsPresentOrder Then 'Present주문일 경우 %>
									<col width="" />
								<% else %>
									<col width="80px" /><col width="95px" /><col width="95px" /><col width="110px" />
								<% end if %>
							<% end if %>
						</colgroup>
						<thead>
						<tr>
							<th>상품코드/배송</th>
							<th colspan="2">상품정보</th>
							<% if (IsForeignDlv) then %>
								<th>상품중량</th>
							<% end if %>
							<th>판매가격</th>
							<% if IsPresentOrder Then 'Present주문일 경우 %>
								<th>배송비</th>
							<% else %>
								<th>수량</th>
								<th>주문금액</th>
								<th>마일리지</th>
								<th>쿠폰</th>
							<% end if %>
							
							<%
							'선물포장서비스 노출
							if G_IsPojangok then
							%>
								<th scope="col" class="pkgInfoLyrV15a">
									<div class="infoMoreViewV15">
										<span>선물포장</span>
										<div class="infoViewLyrV15" style="display:none;">
											<div class="infoViewBoxV15">
												<dfn></dfn>
												<div class="infoViewV15">
													<div class="pad15">
														<p class="pkgOnV15a">선물포장이 <strong>가능</strong>한 상품</p>
														<p class="pkgActV15a">선물포장을 <strong>설정</strong>한 상품</p>
														<p class="pkgNoV15a">아이콘이 미표기된 상품은 선물포장을 <br />지원하지 않는 상품입니다.</p>
													</div>
												</div>
											</div>
										</div>
									</div>
								</th>
							<% end if %>
						</tr>
						</thead>
						<tbody>
						<form name="baguniFrm" onSubmit="return false" style="margin:0px;">
						<% for i=0 to oshoppingbag.FShoppingBagItemCount - 1 %>
						<%
						TicketBookingExired = FALSE
							IF (oshoppingbag.FItemList(i).IsTicketItem) then
									set oTicketItem = new CTicketItem
									oTicketItem.FRectItemID = oshoppingbag.FItemList(0).FItemID
									oTicketItem.GetOneTicketItem
									IF (oTicketItem.FResultCount>0) then
											TicketBookingExired = oTicketItem.FOneItem.IsExpiredBooking
											TicketDlvType = oTicketItem.FOneItem.FticketDlvType
									END IF
									set oTicketItem = Nothing
							end if
						%>
						<input type="hidden" name="distinctkey" value="<%= i %>">
						<input type="hidden" name="itemid" value="<%= oshoppingbag.FItemList(i).FItemID %>">
						<input type="hidden" name="itemoption" value="<%= oshoppingbag.FItemList(i).FItemoption %>">
						<input type="hidden" name="soldoutflag" value="<% if (oshoppingbag.FItemList(i).IsSoldOut or TicketBookingExired) then response.write "Y" else response.write "N" end if %>">
						<input type="hidden" name="itemcouponsellpriceflag" value="<%= oshoppingbag.FItemList(i).GetCouponAssignPrice %>">
						<input type="hidden" name="curritemcouponidxflag" value="<%= oshoppingbag.FItemList(i).Fcurritemcouponidx %>">
						<input type="hidden" name="itemsubtotalflag" value="<%= oshoppingbag.FItemList(i).GetCouponAssignPrice * oshoppingbag.FItemList(i).FItemEa %>">
						<input type="hidden" name="couponsailpriceflag" value="<%= (oshoppingbag.FItemList(i).getRealPrice-oshoppingbag.FItemList(i).GetCouponAssignPrice) * oshoppingbag.FItemList(i).FItemEa %>">
						<input type="hidden" name="itemea" value="<%= oshoppingbag.FItemList(i).FItemEa %>">
						<input type="hidden" name="pCpnBasePrc" value="<%= CHKIIF(oshoppingbag.FItemList(i).IsDuplicatedSailAvailItem,oshoppingbag.FItemList(i).getRealPrice,0) %>">
						<input type="hidden" name="dtypflag" value="<%=oshoppingbag.FItemList(i).Fdeliverytype%>">
						<input type="hidden" name="isellprc" value="<%= oshoppingbag.FItemList(i).getRealPrice %>">
						<tr>
							<td><%= oshoppingbag.FItemList(i).FItemID %><br />
							<% if (oshoppingbag.FItemList(i).IsTicketItem) then %>
								티켓현장수령
							<% elseif (oshoppingbag.FItemList(i).IsGlobalShoppingService) then %>
								해외직구 배송
							<% elseif (oshoppingbag.FItemList(i).IsUpcheBeasong) then %>
								업체배송
    							<% if oshoppingbag.FItemList(i).Fdeliverytype="7" then %>
    								<br />(착불배송)
    							<% end if %>
							<% elseif (oshoppingbag.FItemList(i).IsUpcheParticleBeasong) then %>
								업체조건 배송
							<% elseif (oshoppingbag.FItemList(i).IsReceivePayItem) then %>
								업체착불 배송
							<% elseif (oshoppingbag.FItemList(i).IsReceiveSite) then %>
								현장수령
							<% elseif (oshoppingbag.FItemList(i).IsPresentItem) then %>
								10x10 Present
						    <% elseif (oshoppingbag.FItemList(i).IsQuickAvailItem) and (IsQuickDlv) then %>
						        <div class="tendlvorquick">바로배송</div>
							<% else %>
								<div class="tendlvorquick">텐바이텐 배송</div>
							<% end if %>
							</td>
							<td><img src="<%= Replace(oshoppingbag.FItemList(i).FImageSmall,"http://webimage.10x10.co.kr/","/webimage/") %>" width="50px" height="50px" alt="<%= oshoppingbag.FItemList(i).FItemName %>" /></td>
							<td class="lt">
								<p>
								<% if oshoppingbag.FItemList(i).IsPLusSaleItem then %>
									<span class="crRed">[<strong>+</strong> Sale 상품]</span>
								<% end if %>
								<% if oshoppingbag.FItemList(i).IsMileShopSangpum then %>
									<span class="crRed">[마일리지샵상품]</span>
								<% end if %>
								<% if oshoppingbag.FItemList(i).Is09Sangpum or oshoppingbag.FItemList(i).IsReceiveSite then %>
									<span class="crRed">[단독구매상품]</span>
								<% end if %>
								<% if (oshoppingbag.FItemList(i).IsFreeBeasongItem) and Not(oshoppingbag.FItemList(i).IsReceiveSite) then %>
								<% if (oshoppingbag.FItemList(i).FMakerid<>"goodovening") then %>
									<span class="crRed">[무료배송상품]</span>
								<% end if %>
								<% end if %>
								<% if (oshoppingbag.FItemList(i).IsSpecialUserItem) then %>
									<span class="crGrn">[우수회원샵상품]</span>
								<% end if %>
								<% if (IsPercentBonusCouponExists and (oshoppingbag.FItemList(i).IsUnDiscountedMarginItem and Not oshoppingbag.FItemList(i).IsMileShopSangpum )) then %>
									<span class="crGrn">[%보너스쿠폰제외상품]</span>
								<% end if %>
								<% if (oshoppingbag.FItemList(i).IsBuyOrderItem) then %>
									<span class="crBlu">[선착순구매상품]</span>
								<% end if %>
								<% if (oshoppingbag.FItemList(i).IsForeignDeliverValid) then %>
									<span class="crBlu">[해외배송가능]</span>
								<% end if %>
								<% if (ISQuickDlvUsing) AND (oshoppingbag.FItemList(i).IsQuickAvailItem) then %>
									<span class="crBlu">[바로배송가능]</span>
								<% end if %>
								<%
								'선물포장서비스 노출
								if G_IsPojangok then
								%>
									<% if (oshoppingbag.FItemList(i).FPojangOk="Y") then %>
										<span class="cPk0V15">[선물포장가능]</span>
									<% end if %>
								<% end if %>
								</p>
								<p class="tPad05"><%= oshoppingbag.FItemList(i).FItemName %></p>
								<% if oshoppingbag.FItemList(i).getOptionNameFormat<>"" then %>
								<p class="tPad02"><%= oshoppingbag.FItemList(i).getOptionNameFormat %></p>
								<% end if %>
							</td>
							<% if (IsForeignDlv) then %>
							<td><%= Formatnumber(oshoppingbag.FItemList(i).FitemWeight,0) %> g</td>
							<% end if %>
							<td>
								<% if oshoppingbag.FItemList(i).IsMileShopSangpum then %>
								<%= FormatNumber(oshoppingbag.FItemList(i).getRealPrice,0) %> Pt
									<span id="HTML_itemcouponcost_<%= i %>" class="crGrn" >
								<% if (IsDefaultItemCouponChecked )and (oshoppingbag.FItemList(i).IsValidCouponExists) then %>
									<%= FormatNumber(oshoppingbag.FItemList(i).GetCouponAssignPrice,0) %>Pt
								<% end if %>
								</span>
								<% else %>
								<% if (oshoppingbag.FItemList(i).IsSailItem) then %>
									<p class="txtML cr999"><%= FormatNumber(oshoppingbag.FItemList(i).FOrgPrice+oshoppingbag.FItemList(i).FoptAddPrice,0) %>원</p>
									<p class="crRed"><strong><%= FormatNumber(oshoppingbag.FItemList(i).getRealPrice,0) %>원</strong></p>
								<% else %>
									<%= FormatNumber(oshoppingbag.FItemList(i).getRealPrice,0) %>원
								<% end if %>
								<% if (IsDefaultItemCouponChecked ) and (oshoppingbag.FItemList(i).IsValidCouponExists) then %>
								<span id="HTML_itemcouponcost_<%= i %>" class="crGrn" ><%= FormatNumber(oshoppingbag.FItemList(i).GetCouponAssignPrice,0) %>원</span>
								<% else %>
								<span id="HTML_itemcouponcost_<%= i %>" class="crGrn" ></span>
								<% end if %>
								<% end if %>
							</td>
							<% if IsPresentOrder Then 'Present주문일 경우 %>
							<td><%= FormatNumber(oshoppingbag.GetOrgBeasongPrice,0) %>원</td>
							<% else %>
							<td>
								<%= oshoppingbag.FItemList(i).FItemEa %>

								<%
								'선물포장서비스 노출
								if G_IsPojangok then
								%>
									<%
									'/선물포장가능상품
									if oshoppingbag.FItemList(i).FPojangOk="Y" then
									%>
										<%
										'/선물포장 완료
										if oshoppingbag.FItemList(i).FPojangVaild then
										%>
											<br /><span class="cRd0V15">(포장상품 <%= oshoppingbag.FItemList(i).fpojangitemno %>)</span>
										<% end if %>
									<% end if %>
								<% end if %>
							</td>
							<td>
							<% if (oshoppingbag.FItemList(i).ISsoldOut) or (TicketBookingExired) then %>
								<% if (TicketBookingExired) then %>
								<p class="crRed">매진</p>
								<% else %>
								<p class="crRed">품절</p>
								<% end if %>
								<span id="HTML_itemcouponcostsum_<%= i %>" class="crGrn" >
								<% if (IsDefaultItemCouponChecked ) and (oshoppingbag.FItemList(i).IsValidCouponExists) then %>
									<%= FormatNumber(oshoppingbag.FItemList(i).GetCouponAssignPrice*oshoppingbag.FItemList(i).FItemEa,0) %>원
								<% end if %>
								</span>
							<% else %>
								<% if oshoppingbag.FItemList(i).IsMileShopSangpum then %>
									<%= FormatNumber(oshoppingbag.FItemList(i).GetRealPrice*oshoppingbag.FItemList(i).FItemEa,0) %>Pt
								<% else %>
									<%= FormatNumber(oshoppingbag.FItemList(i).GetRealPrice*oshoppingbag.FItemList(i).FItemEa,0) %>원
								<% end if %>

								<% if (IsDefaultItemCouponChecked )and (oshoppingbag.FItemList(i).IsValidCouponExists) then %>
									<span id="HTML_itemcouponcostsum_<%= i %>" class="crGrn"><%= FormatNumber(oshoppingbag.FItemList(i).GetCouponAssignPrice*oshoppingbag.FItemList(i).FItemEa,0) %>원</span>
								<% else %>
									<span id="HTML_itemcouponcostsum_<%= i %>" class="crGrn"></span>
								<% end if %>

							<% end if %>
							</td>
							<td><% if (Not isBaguniUserLoginOK) then %>회원 구매 시<br /><%end if%><%= Formatnumber(CLng(oshoppingbag.FItemList(i).Fmileage)*oshoppingbag.FItemList(i).FItemEa,0) %> Point</td>
							<td>
							    <% if (oshoppingbag.FItemList(i).FUserVaildCoupon) then %>
		                        <p class="crGrn"><%= oshoppingbag.FItemList(i).getCouponTypeStr %> <br />적용가</p>
		                        <p class="crGrn"><strong><%= FormatNumber(oshoppingbag.FItemList(i).GetCouponAssignPrice*oshoppingbag.FItemList(i).FItemEa,0) %>원</strong></p>
		                        <% elseif Not IsNULL(oshoppingbag.FItemList(i).Fcurritemcouponidx) then %>
		                        <p class="crGrn"><%= oshoppingbag.FItemList(i).getCouponTypeStr %> <br />
		                        <a href="" class="btn btnS3 btnGrn btnW80 fn tMar03" onClick="DownloadCouponWithReload('<%= oshoppingbag.FItemList(i).Fcurritemcouponidx %>');return false;" ><em class="btnDown">쿠폰다운</em></a></p>
		                        <% end if %>
							</td>

							<%
							'선물포장서비스 노출
							if G_IsPojangok then
							%>
								<td>
									<%
									'/선물포장가능상품
									if oshoppingbag.FItemList(i).FPojangOk="Y" then
									%>
										<%
										'/선물포장 완료
										if oshoppingbag.FItemList(i).FPojangVaild then
										%>
											<!--<a href="#" onclick="packreg('ON'); return false;"></a>-->
											<img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장을 설정한 상품">
										<% 
										'/상품포장을 안한 상태
										else
										%>
											<%
											'/선물포장 완료 상품이 존재할경우 수정팝업 띄움
											if oshoppingbag.IsPojangcompleteExists then
											%>
												<!--<a href="#" onclick="packreg('ON'); return false;"></a>-->
												<img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_no.png" alt="선물포장이 가능한 상품">
											<% else %>
												<!--<a href="#" onclick="packreg(''); return false;"></a>-->
												<img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_no.png" alt="선물포장이 가능한 상품">
											<% end if %>
										<% end if %>
									<% end if %>
								</td>
							<% end if %>
							<% end if %>
						</tr>
						<% if (oshoppingbag.FItemList(i).IsManufactureSangpum) then %>
                        <tr class="orderWord">
                			<td class="bdrNone"></td>
                			<td class="bdrNone"></td>
                			<td colspan="6">
                				<dl class="customWord">
                					<dt><strong>주문제작문구</strong> :</dt>
                					<% if (oshoppingbag.FItemList(i).IsManufactureSangpum) and (oshoppingbag.FItemList(i).getRequireDetail="") then %>
                					<dd><p>(! 주문제작문구를 넣어주세요.)</p></dd>
                					<% NotWriteRequireDetailExists = True %>
                					<% else %>
                					<dd><%= oshoppingbag.FItemList(i).getRequireDetailHtml %></dd>
                					<% end if %>
                				</dl>
                			</td>
                			<td class="rt vTop tPad03">
                			<!--
                				<p><a href="" class="btn btnS4 btnGry2 btnW70 fn" onClick="EditRequireDetail('<%= oshoppingbag.FItemList(i).FItemid %>','<%= oshoppingbag.FItemList(i).FItemoption %>');return false;">수정</a></p>
                			-->
                			</td>
                		</tr>
						<% end if %>
						<% next %>
						</tbody>
						</form>
					</table>

					<div class="totalBox tMar30">
						<dl class="totalPriceView">
							<dt><img src="/fiximage/web2013/cart/txt_total.gif" alt="총 주문 금액" /></dt>
							<dd>
								<ul class="priceList">
									<li>
										<span class="ftLt">상품 총 금액</span><strong class="ftRt"><%= FormatNumber(oshoppingbag.GetTotalItemOrgPrice-oshoppingbag.GetMileageShopItemPrice,0) %>원</strong>
									</li>

									<%
									'선물포장서비스 노출
									if G_IsPojangok then
									%>
										<% 
										'/선물포장가능상품
										if oshoppingbag.IsPojangValidItemExists then
											'/선물포장완료상품존재
											if oshoppingbag.IsPojangcompleteExists then
											%>
												<li>
													<span class="ftLt">선물포장비(<a href="#" onclick="packreg('ON'); return false;"><u><%= pojangcnt %>건</u></a>)</span><strong class="ftRt"><%= FormatNumber(pojangcash,0) %>원</strong>
												</li>
											<% end if %>
										<% end if %>
									<% end if %>

									<li>
										<% if (IsForeignDlv) then %>
										<span class="ftLt">해외 배송비</span><strong class="ftRt"><span id="divEmsPriceUp"><%= FormatNumber(oshoppingbag.GetTotalBeasongPrice,0) %></span>원</strong>
										<% elseif (IsArmyDlv) then %>
										<span class="ftLt">군부대 배송비</span><strong class="ftRt"><%= FormatNumber(C_ARMIDLVPRICE,0) %>원</strong>
										<% elseif (IsQuickDlv) then %>
										<span class="ftLt">배송비</span><strong class="ftRt"><span id="DISP_DLVPRICEUp"><%= FormatNumber(C_QUICKDLVPRICE,0) %></span>원</strong>
										<% else %>
										<span class="ftLt">배송비</span><strong class="ftRt"><span id="DISP_DLVPRICEUp"><%= FormatNumber(oshoppingbag.GetOrgBeasongPrice,0) %></span>원</strong>
										<% end if %>
									</li>
								</ul>
							</dd>
						</dl>
						<p class="rt tPad15 bPad05">
							<span class="fs13 cr777">(적립 마일리지 <%= FormatNumber(oshoppingbag.getTotalGainmileage,0) %> P)</span>
							<strong class="lPad10">
							<% if oshoppingbag.GetMileageShopItemPrice<>0 then %>
							마일리지샵 금액 <span class="crRed lPad10"><em class="fs20"><%= FormatNumber(oshoppingbag.GetMileageShopItemPrice,0) %></em>P</span> <em><img src="/fiximage/web2013/cart/ico_plus.gif" alt="더하기" /></em>
							<% end if %>
							<% if (IsQuickDlv) then %>
							결제 예정 금액 <span class="crRed lPad10"><em class="fs20"><span id="DISP_FIXPRICEUp"><%= FormatNumber(oshoppingbag.GetTotalItemOrgPrice + C_QUICKDLVPRICE + pojangcash - oshoppingbag.GetMileageShopItemPrice,0) %></span></em>원</span></strong>
						    <% else %>
							결제 예정 금액 <span class="crRed lPad10"><em class="fs20"><span id="DISP_FIXPRICEUp"><%= FormatNumber(subtotalprice,0) %></span></em>원</span></strong>
							<% end if %>
						</p>
					</div>
                    <%' 원클릭업셀 추가 2017.09.18 원승현 %>
					<% If False Then %>
						<% if (NOT IsForeignDlv) AND (NOT IsArmyDlv) then %>
						<script type="text/javascript">
							$.ajax({
								url: "act_oneClickUpSell.asp",
								cache: false,
								async: true,
								success: function(vRst) {
									if(vRst!="") {
										$("#oneClickUpsellDiv").empty().html(vRst);
										ga('send', {
										  hitType: 'pageview',
										  page: '/inipay/act_oneClickUpsell.asp'
										});
									}
									else
									{
										$('#oneClickUpsellDiv').hide();
									}
								}
								,error: function(err) {
									//alert(err.responseText);
									$('#oneClickUpsellDiv').hide();
								}
							});
						</script>
						<div id="oneClickUpsellDiv"></div>
						<% end if %>
					<% End If %>
					<%'// 원클릭업셀 추가 2017.09.18 원승현 %>
<form name="frmorder" method="post" style="margin:0px;">

					<%
					'선물포장서비스 노출
					if G_IsPojangok then
						'/선물포장가능상품
						if oshoppingbag.IsPojangValidItemExists then
							'/선물포장완료상품존재
							if oshoppingbag.IsPojangcompleteExists then
							%>
								<!--<div class="orderSheetV15a">
									<b>텐바이텐 배송 주문서 포함여부</b>
									<span>
										<input type="radio" id="ordersheetYes" name="ordersheetyn" value="Y" checked class="radio" />
										<label for="ordersheetYes">포함</label>
									</span>
									<span>
										<input type="radio" id="ordersheetNo" name="ordersheetyn" value="N" class="radio" />
										<label for="ordersheetNo">미포함</label>
									</span>
								</div>-->
								<input type="hidden" name="ordersheetyn" value="P">
							<% else %>
								<input type="hidden" name="ordersheetyn" value="Y">
							<% end if %>
						<% else %>
							<input type="hidden" name="ordersheetyn" value="Y">
						<% end if %>
					<% else %>
						<input type="hidden" name="ordersheetyn" value="Y">
					<% end if %>

<!-- 상점아이디 -->
<% IF application("Svr_Info")="Dev" THEN %>
	<input type=hidden name=mid value="INIpayTest">
<% else %>
	<input type=hidden name=mid value="<%= CHKIIF(IsKBRdSite,"teenxteen5","teenxteen4") %>">
<% end if %>

<!-- 화폐단위 -->
<input type=hidden name=currency value="WON">
<!-- 무이자 할부 -->
<input type=hidden name=nointerest value="no">
<input type=hidden name=quotabase value="선택:일시불:2개월:3개월:4개월:5개월:6개월:7개월:8개월:9개월:10개월:11개월:12개월:18개월">
<input type=hidden name=acceptmethod value="VERIFY:NOSELF:no_receipt:HPP(2):below1000<%=chkIIF(oshoppingbag.GetTotalBeasongPrice>0,":cd_ps(14-10)","")%>">

<input type=hidden name=quotainterest value="">
<input type=hidden name=paymethod value="">
<input type=hidden name=cardcode value="">
<input type=hidden name=ini_onlycardcode value="<%= CHKIIF(IsKBRdSite,"06","") %>">
<input type=hidden name=cardquota value="">
<input type=hidden name=rbankcode value="">
<input type=hidden name=reqsign value="DONE">
<input type=hidden name=encrypted value="">
<input type=hidden name=sessionkey value="">
<input type=hidden name=uid value="">
<input type=hidden name=sid value="">

<% if (G_PG_100_USE_INIWEB) then %>
	<input type=hidden name=returnUrl value="<%=INIWEB_returnUrl%>">
	<input type=hidden name=version value="<%=INIWEB_ver%>">
	
	<input type=hidden name=popupUrl value="<%=INIWEB_popupUrl%>">
	<input type=hidden name=closeUrl value="<%=INIWEB_closeUrl%>">
	<input type=hidden name=payViewType value="popup">
	
	<input type=hidden name=authToken value="">
	<input type=hidden name=authUrl value="">
	<div id="INIWEB_SIG"></div>
<% else %>
	<input type=hidden name=version value=4110>
<% end if %>

<input type=hidden name=clickcontrol value="enable">
<input type=hidden name=price value="<%= subtotalprice %>">
<input type=hidden name=ooprice value="<%= subtotalprice %>">
<input type=hidden name=fixprice value="<%= subtotalprice %>">
<input type=hidden name=goodname value='<%= goodname %>'>
<input type=hidden name=buyername value="">
<input type=hidden name=buyeremail value="">
<input type=hidden name=buyemail value="">
<input type=hidden name=buyertel value="">
<input type=hidden name=gopaymethod value="onlycard"> <!-- or onlydbank -->
<input type=hidden name=ini_logoimage_url value="http://fiximage.10x10.co.kr/web2008/shoppingbag/logo2004.gif">

<input type=hidden name=itemcouponmoney value="0">
<input type=hidden name=couponmoney value="0">
<input type=hidden name=emsprice value="0">
<input type=hidden name=jumundiv value="<%=jumundiv%>">

<!-- for All@ -->
<input type=hidden name=card_no value="">
<input type=hidden name=cardvalid_ym value="">
<input type=hidden name=sPASSWD_NO value="">
<input type=hidden name=sREGISTRY_NO value="">
<!--공통부분 끝 -->



<!-- 사은품 -->
<input type=hidden name=gift_code value="">
<input type=hidden name=giftkind_code value="">
<input type=hidden name=gift_kind_option value="">
<input type=hidden name=fixpriceTenItm value="<%=TenDlvItemPriceCpnNotAssign%>">
					<div class="overHidden tMar80">
						<h3>주문고객 정보</h3>
						<% if (IsForeignDlv) then %>
						<span class="fs11 ftRt tPad05 lPad10 cr555">EMS 운송자의 발송인 정보는 TEN BY TEN(www.10x10.co.kr)으로 입력됩니다.</span>
						<% end if%>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>주문고객 정보 입력</caption>
						<colgroup>
							<col width="12%" /><col width="38%" /><col width="12%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th><label for="sendName">보내시는 분</label></th>
							<td><input type="text" class="txtInp" name="buyname" onkeyup="chkLength(this, 32);" maxlength="32" value="<%= doubleQuote(oUserInfo.FOneItem.FUserName) %>" id="sendName" /></td>
							<th>이메일</th>
							<td>
								<p>
									<input type="text" class="txtInp" name="buyemail_Pre" value="<%= Splitvalue(oUserInfo.FOneItem.FUserMail,"@",0) %>" title="이메일 아이디 입력" style="width:120px;" />
									@
									<% call DrawEamilBoxHTML("document.frmorder","buyemail_Tx","buyemail_Bx",Splitvalue(oUserInfo.FOneItem.FUserMail,"@",1)) %>
								</p>
								<p class="tPad05">주문정보를 이메일로 보내드립니다.</p>
							</td>
						</tr>
						<%
							''if (IsUserLoginOK) and (Not IsRsvSiteOrder) then	''현장수령 상품도 주문고객 주소 확인(2014.09.02;허진원)
							if (IsUserLoginOK) then
						%>
						<tr>
							<th>주소</th>
							<td colspan="3">
								<p>
								<input type="text" name="buyZip" value="<%=oUserInfo.FOneItem.FZipCode%>" readonly title="우편번호" class="txtInp focusOn" style="width:60px;" />
								<a href="#" class="btn btnS5 btnGry2 fn lMar5" onClick="searchzipBuyerNew('frmorder');return false;">우편번호 찾기</a>
								<%if (IsArmyDlv) then %>
								<span>군부대 배송의 경우 주소지 선택시 <span class="crRed">사서함</span>으로 검색해서 <span class="crRed">사서함 주소</span>로 입력해주세요.</span></p>
								<% end if %>
								<p class="tPad05"><input name="buyAddr1" type="text" class="txtInp" style="width:420px;background-color:#EEEEEE;" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress1) %>" title="동까지의 주소 입력" readOnly />
								<input name="buyAddr2" type="text" class="txtInp" style="width:440px;" value="<%= doubleQuote(oUserInfo.FOneItem.FAddress2) %>" title="상세주소 입력" /></p>
							</td>
						</tr>
						<% end if %>
						<tr>
							<th><label for="hp01">휴대전화</label></th>
							<td>
								<p><input type="text" class="txtInp" style="width:30px;<%=chkIIF(chkKakao,"background-color:#EEEEEE;","")%>" name="buyhp1" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" default="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" title="주문고객 휴대전화번호 국번 입력" id="hp01" /> -
								<input type="text" class="txtInp" style="width:40px;<%=chkIIF(chkKakao,"background-color:#EEEEEE;","")%>" name="buyhp2" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" default="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" title="주문고객 휴대전화번호 가운데 자리 번호 입력" /> -
								<input type="text" class="txtInp" style="width:40px;<%=chkIIF(chkKakao,"background-color:#EEEEEE;","")%>" name="buyhp3" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" default="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" title="주문고객 휴대전화번호 뒷자리 번호 입력" /></p>
								<p class="tPad10">
								    <% if Not(chkKakao) then %>
								    (주문 정보를 SMS로 보내드립니다)
								    <% else %>
									<input type="checkbox" class="check" name="chkKakaoSend" value="Y" checked onclick="fnChgKakaoSend()" />
									<label for="orderKatalk">주문정보 카카오톡으로 받기 (선택하지 않을 경우 일반 SMS로 전송)</label><br />
									<span class="addInfo"><a href="/apps/kakaotalk/kakaotalkInfo.asp" target="_blank"><em>카카오톡 서비스 안내</em></a></span>
									<% end if %>
								</p>
								</td>
							<th><label for="phone01">전화번호</label></th>
							<td><input type="text" class="txtInp" style="width:30px;" name="buyphone1" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",0) %>" title="주문고객 전화번호 국번 입력" id="phone01" /> -
							<input type="text" class="txtInp" style="width:40px;" name="buyphone2" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",1) %>" title="주문고객 전화번호 가운데 자리 번호 입력" /> -
							<input type="text" class="txtInp" style="width:40px;" name="buyphone3" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",2) %>" title="주문고객 전화번호 뒷자리 번호 입력" /></td>
						</tr>
						</tbody>
					</table>
					<%
						''if (IsUserLoginOK) and (Not IsRsvSiteOrder) then
						if (IsUserLoginOK And GetLoginUserDiv <> "09") then
					%>
					<p class="rt tPad10">
						<span class="fs12 rPad10">위 내용으로 회원정보를 수정하시려면 오른쪽의 수정버튼을 눌러주세요.</span>
						<%' 간편 로그인 팝업
						if GetLoginUserDiv="05" then
						%>
						<a href="#" class="btn btnS3 btnRed fn" onClick="fnPopSnsLoginCheck('mo','upUserInfo','frmorder');return false;"><em class="whiteArr01">개인 정보 수정</em></a>
						<% else %>
						<a href="#" class="btn btnS3 btnRed fn" onClick="upUserInfo(document.frmorder);return false;"><em class="whiteArr01">개인 정보 수정</em></a>
						<% end if %>
					</p>
                    <% end if %>

					<% If vIsTravelItemExist = True Then %>
						<div class="overHidden tMar60">
							<h3>여행상품 개인정보 제 3자 제공 동의</h3>
						</div>
						<div class="fs11 cGy3V15 tBdr4 tMar10 tPad25">
							<p><strong>회원의 개인정보는 당사의 <em class="txtL">개인정보취급방침</em>에 따라 안전하게 보호됩니다.</strong></p>
							<p class="tPad10" style="line-height:16px;">&quot;회사&quot;는 이용자들의 개인정보를 &quot;개인정보 취급방침의 개인정보의 수집 및 이용목적&quot;에서 고지한 범위 내에서 사용하며, 이용자의 사전 동의 없이는 동 범위를 초과하여 이용하거나 원칙적으로 이용자의 개인정보를 외부에 공개하지 않습니다. 회사가 제공하는 서비스를 통하여 주문 및 결제가 이루어진 경우 구매자 확인 및 해피콜 등 거래이행을 위하여 관련된 정보를 필요한 범위 내에서 거래 업체에게 제공합니다.</p>
						</div>
						<% if vIsTravelIPExist then %>
						<table class="baseTable orderForm tMar20" style="border-top:0;">
							<caption>개인정보 제 3자 제공 동의</caption>
							<colgroup>
								<col width="20%" /><col width="20%" /><col width="25%" /><col width="" />
							</colgroup>
							<tr>
								<th class="ct">제공받는 자</th>
								<th class="ct">제공목적</th>
								<th class="ct">제공정보</th>
								<th class="ct">보유 및 이용기간</th>
							</tr>
							<tbody>
							<tr>
								<td class="ct">(주)인터파크투어</td>
								<td class="ct">서비스 제공, 예약 확인,<br/ >해피콜 진행</td>
								<td class="ct">성명, 휴대전화번호, 이메일, <br/ >생년월일, 성별</td>
								<td class="ct">재화 또는 서비스의 제공이 완료된 즉시 파기<br/ >(단, 관계법령에 정해진 규정에 따라 법정기간동안 보관)</td>
							</tr>
							</tbody>
						</table>
						<% elseif vIsTravelJAExist then %>
						<table class="baseTable orderForm tMar20" style="border-top:0;">
							<caption>개인정보 제 3자 제공 동의</caption>
							<colgroup>
								<col width="15%" /><col width="15%" /><col width="20%" /><col width="25%" /><col width="" />
							</colgroup>
							<tr>
								<th class="ct">상품명</th>
								<th class="ct">제공받는 자</th>
								<th class="ct">제공목적</th>
								<th class="ct">제공정보</th>
								<th class="ct">보유 및 이용기간</th>
							</tr>
							<tbody>
							<tr>
								<td class="ct">솔로티켓패키지</td>
								<td class="ct">(주)노니투어</td>
								<td class="ct">서비스 제공, 예약 확인,<br />해피콜 진행</td>
								<td class="ct">예약자: 성명, 휴대전화번호, 이메일<br />실사용자: 성명, 생년월일, 성별</td>
								<td class="ct">재화 또는 서비스의 제공이 완료된 즉시 파기<br />(단, 관계법령에 정해진 규정에 따라 법정기간동안 보관)</td>
							</tr>
							</tbody>
						</table>
						<% end if %>
						<div class="fs11">
							<p class="tPad20 bPad10"><strong>※ 동의 거부권 등에 대한 고지</strong></p>
							<p>개인정보 제공은 서비스 이용을 위해 꼭 필요합니다. 개인정보 제공을 거부하실 수 있으나, 이 경우 서비스 이용이 제한될 수 있습니다.</p>
						</div>
						<div class="fs11 box5 tMar20 pad15 cGy0V15">
							<p><input type="checkbox" class="check" id="travelagree1" /> <label for="travelagree1">본인은 개인정보 제 3자 제공 동의에 관한 내용을 모두 이해하였으며 이에 동의합니다.</label></p>
							<p class="tPad10"><input type="checkbox" class="check" id="travelagree2" /> <label for="travelagree2">본 상품은 특별 구성된 상품으로 별도의 환불규정이 적용됩니다. 상품페이지 내 취소/환불/배송 규정을 모두 이해하였으며 이에 동의합니다.</label></p>
						</div>
					<% end if %>

                    <% if (IsTicketOrder) then
            				Response.Write "<div style=""margin-top:20px;padding-top:10px;padding-bottom:10px;border-top:2px solid #d50c0c; border-bottom:2px solid #d50c0c;"">"
            				Select Case TicketDlvType
            					Case "1"
            						'현장수령
            						Response.Write "<h4>티켓현장수령 상품은 [예매확인서 출력] 후 당일 현장에서 수령하시기 바랍니다.</h4>"
            					Case "2"
            						'일반배송
            						Response.Write ""
            					Case "3"
            						'배송방법 선택
            						Response.Write ""
            					Case "9"
            						'현장수령 + 사은품 배송지
            						Response.Write "<h4>티켓현장수령 상품은 [예매확인서 출력] 후 당일 현장에서 수령하시기 바랍니다. 아래 배송지 정보는 사은품 배송용도로 사용되어집니다.</h4>"
            				End Select
            				Response.Write "</div>"
                    end if %>

				<% If vIsDeliveItemExist Then %>
                    <% if (IsForeignDlv) then %>
                    <!-- 해외 배송 주문시 -->
                    <div class="overHidden tMar60">
						<h3>배송지 정보</h3>
						<% if (IsUserLoginOK) then %>
						<span class="ftLt lPad20 fs12 tPad03">
							<input type="radio" name="rdDlvOpt" class="radio lMar20" id="shipping02" value="M" onClick="copyDefaultinfo(this);" checked /> <label for="shipping02">새로운 주소</label>
							<input type="radio" name="rdDlvOpt" class="radio lMar20" id="shipping03" onClick="PopSeaAddress();" /> <label for="shipping03">나의 주소록</label>
						</span>
						<% end if %>
						<span class="ftRt fs11 tPad05 cr555">배송지 관련 모든 정보는 반드시 영문으로 작성하여 주시기 바랍니다.</span>
					</div>
					<table class="baseTable orderForm tMar10">
					<caption>해외 배송지 정보 입력</caption>
						<colgroup>
							<col width="12.5%" /><col width="38%" /><col width="12.5%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>총 중량</th>
							<td colspan="3"><strong><%= FormatNumber(oshoppingbag.getEmsTotalWeight,0) %>g (<%= CLng(oshoppingbag.getEmsTotalWeight/1000*100)/100 %>Kg)</strong> [상품 순중량 : <%= FormatNumber(oshoppingbag.getEmsTotalWeight-oshoppingbag.getEmsBoxWeight,0) %> g / 포장박스 중량 : <%= FormatNumber(oshoppingbag.getEmsBoxWeight,0) %> g]</td>
						</tr>
						<tr>
							<th>국가 선택</th>
							<td colspan="3">
								<select name="emsCountry" id="emsCountry" class="select rMar05" title="배송할 국가를 선택하세요" onChange="emsBoxChange(this);">
									<option value="">국가선택</option>
									<% for i=0 to oems.FREsultCount-1 %>
									<option value="<%= oems.FItemList(i).FcountryCode %>" id="<%= oems.FItemList(i).FemsAreaCode %>|<%= oems.FItemList(i).FemsMaxWeight %>" iMaxWeight="<%= oems.FItemList(i).FemsMaxWeight %>" iAreaCode="<%= oems.FItemList(i).FemsAreaCode %>"><%= oems.FItemList(i).FcountryNameKr %>(<%= oems.FItemList(i).FcountryNameEn %>)</option>
									<% next %>
								</select>
								<input name="countryCode" type="text" class="txtRead" style="width:20px;" id="" value="" title="국가번호 출력1" readonly="readonly" />
								<input name="emsAreaCode" type="text" class="txtRead" style="width:20px;" id="" value="" title="국가번호 출력2" readonly="readonly" />
								<span class="addInfo"><em onClick="popEmsApplyGoCondition();">국가별 발송조건 보기</em></span>
							</td>
						</tr>
						<tr>
							<th>해외 배송료<br /><span class="fn fs11">(EMS 요금)</span></th>
							<td colspan="3"><strong><span id="divEmsPrice">0</span>원 (EMS <span id="divEmsAreaCode">1</span>지역)</strong><span class="addInfo"><em onClick="popEmsCharge();">EMS 지역요금 보기</em></span></td>
						</tr>
						<tr>
							<th><label for="acceptName02">받으시는 분 <span class="crRed">*</span><br /><span class="fn fs11">(name)</span></label></th>
							<td><input name="reqname" onkeyup="chkLength(this, 32);" maxlength="32" type="text" class="txtInp" style="width:200px;" value="" title="받으시는분 이름을 입력해주세요" /></td>
							<th><label for="acceptEmail">이메일 <span class="fn fs11">(E-mail)</span></label></th>
							<td><input name="reqemail" maxlength="80" type="text" class="txtInp" style="width:200px;" value="" title="받으시는분 이메일을 입력해주세요" /></td>
						</tr>
						<tr>
							<th><label for="abroadTel01">전화번호 <span class="crRed">*</span><br /><span class="fn fs11">(Tel. No)</span></label></th>
							<td colspan="3"><input name="reqphone1" type="text" maxlength="4" class="txtInp" style="width:40px;" value="" title="국가번호 입력" /> -
							<input name="reqphone2" maxlength="4" type="text" class="txtInp" style="width:40px;" value="" title="지역번호 입력" /> -
							<input name="reqphone3" maxlength="4" type="text" class="txtInp" style="width:40px;" value="" title="국번 입력" /> -
							<input name="reqphone4" maxlength="4" type="text" class="txtInp" style="width:40px;" value="" title="전화번호 입력" /> (국가번호 - 지역번호 - 국번 - 전화번호)</td>
						</tr>
						<tr>
							<th><label for="abroadZip">우편번호 <span class="crRed">*</span><br /><span class="fn fs11">(Zip code)</span></label></th>
							<td colspan="3">
							<input type="hidden" name="txZip" value="00000">
							<input name="emsZipCode" maxlength="20" type="text" class="txtInp" style="width:100px;" value="" title="우편번호 입력" /></td>
						</tr>
						<tr>
							<th><label for="abroadDetailAdress">상세주소 <span class="crRed">*</span><br /><span class="fn fs11">(Address)</span></label></th>
							<td colspan="3"><input name="txAddr2" maxlength="100" type="text" class="txtInp" style="width:350px;" value="" title="상세주소 입력" /></td>
						</tr>
						<tr>
							<th><label for="abroadCity">도시 및 주<br /><span class="fn fs11">(City/State)</span></label></th>
							<td colspan="3"><input name="txAddr1" maxlength="200" type="text" class="txtInp" style="width:200px;" value="" title="도시 및 주 입력" /></td>
						</tr>
						</tbody>
					</table>
					<!-- //해외 배송 주문시 -->
					<% elseif (IsRsvSiteOrder) or (IsTicketOrder and TicketDlvType="1") then %>
					<div class="overHidden tMar60">
						<h3>수령자 정보</h3>
						<%
						'// 현장수령 상품일 경우 선택 표시
						if IsRsvSiteOrder then
						%>
							<span class="ftLt lPad20 fs12 tPad03">
							<% if (IsUserLoginOK) then %>
								<input name="rdDlvOpt" id="rdDlvOpt1" value="O" onClick="chgRSVSel();copyDefaultinfo(this);" type="radio" class="radio" disabled /> <label for="rdDlvOpt1">주문고객 정보와 동일</label>
								<input name="rdDlvOpt" id="rdDlvOpt2" value="N" onClick="chgRSVSel();copyDefaultinfo(this);" type="radio" class="radio lMar20" id="shipping02" disabled /> <label for="rdDlvOpt2">새로운 주소</label>
								<input name="rdDlvOpt" id="rdDlvOpt3" value="N" type="radio" class="radio lMar20" id="shipping03" onClick="chgRSVSel();PopOldAddress();" disabled /> <label for="rdDlvOpt3">나의 주소록</label>
							<% else %>
								<input name="rdDlvOpt" id="rdDlvOpt1" value="O" onClick="chgRSVSel();copyDefaultinfo(this);" type="radio" class="radio" disabled /> <label for="rdDlvOpt1">주문고객 정보와 동일</label>
							<% end if %>
								<input name="rdDlvOpt" id="rdDlvOpt4" value="N" onClick="chgRSVSel();" type="radio" checked class="radio lMar20" id="shipping04" /> <label for="rdDlvOpt4" class="crRed">현장 수령</label>
							</span>
							<script type="text/javascript">$(function(){chgRSVSel();});</script>
						<% else %>
							<span class="ftLt lPad20 fs12 tPad03">
							<% if (IsUserLoginOK) then %>
								<input name="rdDlvOpt" id="rdDlvOpt1" value="O" onClick="copyDefaultinfo(this);" type="radio" class="radio" checked /> <label for="rdDlvOpt1">주문고객 정보와 동일</label>
								<input name="rdDlvOpt" id="rdDlvOpt2" value="N" onClick="copyDefaultinfo(this);" type="radio" class="radio lMar20" id="shipping02"  /> <label for="rdDlvOpt2">새로입력</label>
							<% else %>
								<input name="rdDlvOpt" id="rdDlvOpt1" value="O" onClick="copyDefaultinfo(this);" type="radio" class="radio"  /> <label for="rdDlvOpt1">주문고객 정보와 동일</label>
							<% end if %>
							</span>
							<script type="text/javascript">$(function(){chgRSVSel();});</script>
						<%	end if %>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>수령자 정보 입력</caption>
						<colgroup>
							<col width="12.5%" /><col width="38%" /><col width="12.5%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th><label for="acceptName01">받으시는 분</label></th>
							<td colspan="3"><input name="reqname" type="text" class="txtInp" onkeyup="chkLength(this, 32);" maxlength="32" id="acceptName01" value="<%= doubleQuote(oUserInfo.FOneItem.FUserName) %>"  /></td>
						</tr>
						<%
							'// 현장수령 상품일 경우 배송지 표시
							if IsRsvSiteOrder then
						%>
						<tr id="lyRSVAddr">
							<th>주소</th>
							<td colspan="3">
								<p><input name="txZip" ReadOnly type="text" class="txtInp" style="width:30px;background-color:#EEEEEE;" value="" title="우편번호" />
								<a href="#" class="btn btnS5 btnGry2 fn lMar5" onClick="searchzipNew('frmorder');return false;">우편번호 찾기</a>
								<input type="hidden" name="countryCode" value="KR">
								<p class="tPad05"><input name="txAddr1" ReadOnly maxlength="100" type="text" class="txtInp" style="width:420px;background-color:#EEEEEE;" value="" title="동까지의 주소 입력" />
								<input name="txAddr2" maxlength="60" type="text" class="txtInp" style="width:440px;" value="" title="상세주소 입력" /></p>
							</td>
						</tr>
						<% end if %>
						<tr>
							<th><label for="hp11">휴대전화</label></th>
							<td><input name="reqhp1" maxlength="4" type="text" class="txtInp" style="width:30px;" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" default="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" title="받으시는 고객 휴대전화번호 국번 입력" id="hp11" /> -
							<input name="reqhp2" maxlength="4" type="text" class="txtInp" style="width:40px;" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" default="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" title="받으시는 고객 휴대전화번호 가운데 자리 번호 입력" /> -
							<input name="reqhp3" maxlength="4" type="text" class="txtInp" style="width:40px;" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" default="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" title="받으시는 고객 휴대전화번호 뒷자리 번호 입력" /></td>
							<th><label for="phone11">전화번호</label></th>
							<td><input name="reqphone1" maxlength="4" type="text" class="txtInp" style="width:30px;" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",0) %>" title="받으시는 고객 전화번호 국번 입력" id="phone11" /> -
							<input name="reqphone2" maxlength="4" type="text" class="txtInp" style="width:40px;" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",1) %>" title="받으시는 고객 전화번호 가운데자리 번호 입력" /> -
							<input name="reqphone3" maxlength="4" type="text" class="txtInp" style="width:40px;" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",2) %>" title="받으시는 고객 전화번호 뒷자리 번호 입력" /></td>
						</tr>
						<% if IsRsvSiteOrder then %>
						<tr id="lyRSVCmt">
							<th><label for="shippingAttention">배송 요청사항</label></th>
							<td colspan="3">
								<p>
									<select id="shippingAttention" class="select" title="배송 요청사항 선택" style="width:350px;" name="comment" onChange="fnCommentMsg(this.value);">
										<option value="">배송 요청사항 없음</option>
										<option value="배송 전 연락 바랍니다.">배송 전 연락 바랍니다.</option>
										<option value="부재시 경비실(관리실)에 맡겨주세요.">부재시 경비실(관리실)에 맡겨주세요.</option>
										<option value="부재시 휴대폰으로 연락 바랍니다.">부재시 휴대폰으로 연락 바랍니다.</option>
										<option value="etc">직접입력</option>
									</select>
									<input type="text" class="txtInp tMar05" style="width:585px;" value="" name="comment_etc" id="delivmsg" autocomplete="off"/>
								</p>
								<p class="tPad05">주문시 요청사항은 <span class="crRed">배송기사가 배송시 참고하는 사항</span>으로써, 사전에 협의되지 않은 지정일 배송 등의 요청사항은 반영되지 않을 수 있습니다.</p>
							</td>
						</tr>
						<% end if %>
						<tr id="lyRSVInfo" style="display:none;">
							<th></th>
							<td colspan="3">
								<p class="tPad05">현장수령 상품은 [예매/주문 확인서 출력] 후 당일 현장에서 수령하시기 바랍니다. 현장 수령 정보는 현장에서 본인 확인용도로 사용되어집니다.</p>
							</td>
						</tr>
						</tbody>
					</table>
					<% else %>
					<div class="overHidden tMar60">
						<h3>배송지 정보</h3>
						<span class="ftLt lPad20 fs12 tPad03">
						<% if (IsUserLoginOK) then %>
							<input name="rdDlvOpt" id="rdDlvOpt1" value="O" onClick="copyDefaultinfo(this);" type="radio" class="radio" /> <label for="rdDlvOpt1">주문고객 정보와 동일</label>
							<input name="rdDlvOpt" id="rdDlvOpt4" value="P" onClick="copyDefaultinfo(this);" type="radio" class="radio lMar20" checked /> <label for="rdDlvOpt4">최근 배송지</label>
							<input name="rdDlvOpt" id="rdDlvOpt2" value="N" onClick="copyDefaultinfo(this);" type="radio" class="radio lMar20" id="shipping02" /> <label for="rdDlvOpt2">새로운 주소</label>
							<input name="rdDlvOpt" id="rdDlvOpt3" value="N" type="radio" class="radio lMar20" id="shipping03" onClick="PopOldAddress();" /> <label for="rdDlvOpt3">나의 주소록</label>
						<% else %>
							<input name="rdDlvOpt" id="rdDlvOpt1" value="O" onClick="copyDefaultinfo(this);" type="radio" class="radio" /> <label for="rdDlvOpt1">주문고객 정보와 동일</label>
						<% end if %>
						</span>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>배송지 정보 입력</caption>
						<colgroup>
							<col width="12.5%" /><col width="38%" /><col width="12.5%" /><col width="" />
						</colgroup>
						<tbody>
						<tr id="lySelMyAddr" style="display:none;"></tr>
						<tr>
							<th><label for="acceptName01">받으시는 분</label></th>
							<td colspan="3"><input name="reqname" onkeyup="chkLength(this, 32);" maxlength="32" type="text" class="txtInp" value="" id="acceptName01" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td colspan="3">
								<p><input name="txZip" ReadOnly type="text" class="txtInp" style="width:60px;background-color:#EEEEEE;" value="" title="우편번호" />
								<a href="#" class="btn btnS5 btnGry2 fn lMar5" onClick="searchzipNew('frmorder');return false;">우편번호 찾기</a>
								<% if (IsArmyDlv) then %>
								<input type="hidden" name="countryCode" value="ZZ">
								<span>군부대 배송의 경우 주소지 선택시 <span class="crRed">사서함</span>으로 검색해서 <span class="crRed">사서함 주소</span>로 입력해주세요.</span></p>
								<%elseif (IsQuickDlv) or (isQuickDlvBoxShown) then %>
								<span>바로 배송의 경우 주소지가 <span class="crRed">서울</span>인 경우만 가능합니다.</span></p>
								<% else %>
								<input type="hidden" name="countryCode" value="KR">
							<% end if %>
								<p class="tPad05"><input name="txAddr1" ReadOnly maxlength="100" type="text" class="txtInp" style="width:420px;background-color:#EEEEEE;" value="" title="동까지의 주소 입력" />
								<input name="txAddr2" maxlength="60" type="text" class="txtInp" style="width:440px;" value="" title="상세주소 입력" /></p>
							</td>
						</tr>
						<tr>
							<th><label for="hp11">휴대전화</label></th>
							<td><input name="reqhp1" maxlength="4" type="text" class="txtInp" style="width:30px;" value="" id="hp11" title="받으시는 고객 휴대전화번호 국번 입력" /> -
							<input name="reqhp2" maxlength="4" type="text" class="txtInp" style="width:40px;" value="" title="받으시는 고객 휴대전화번호 가운데 자리 번호 입력" /> -
							<input name="reqhp3" maxlength="4" type="text" class="txtInp" style="width:40px;" value="" title="받으시는 고객 휴대전화번호 뒷자리 번호 입력" /></td>
							<th><label for="phone11">전화번호</label></th>
							<td><input name="reqphone1" maxlength="4" type="text" class="txtInp" style="width:30px;" value="" id="phone11" title="받으시는 고객 전화번호 국번 입력" /> -
							<input name="reqphone2" maxlength="4" type="text" class="txtInp" style="width:40px;" value="" title="받으시는 고객 전화번호 가운데자리 번호 입력" /> -
							<input name="reqphone3" maxlength="4" type="text" class="txtInp" style="width:40px;" value="" title="받으시는 고객 전화번호 뒷자리 번호 입력" /></td>
						</tr>
						<tr>
							<th><label for="shippingAttention">배송 요청사항</label></th>
							<td colspan="3">
								<p>
									<select id="shippingAttention" class="select" title="배송 요청사항 선택" style="width:350px;" name="comment" onChange="fnCommentMsg(this.value);">
										<option value="">배송 요청사항 없음</option>
										<option value="배송 전 연락 바랍니다.">배송 전 연락 바랍니다.</option>
										<option value="부재시 경비실(관리실)에 맡겨주세요.">부재시 경비실(관리실)에 맡겨주세요.</option>
										<option value="부재시 휴대폰으로 연락 바랍니다.">부재시 휴대폰으로 연락 바랍니다.</option>
										<option value="etc">직접입력</option>
									</select>
									<input type="text" class="txtInp tMar05" style="width:585px;" value="" name="comment_etc" id="delivmsg" autocomplete="off"/>
								</p>
								<p class="tPad05">주문시 요청사항은 <span class="crRed">배송기사가 배송시 참고하는 사항</span>으로써, 사전에 협의되지 않은 지정일 배송 등의 요청사항은 반영되지 않을 수 있습니다.</p>
							</td>
						</tr>
						</tbody>
					</table>
				<% End If %>
					<% if (Not IsForeignDlv) and (oshoppingbag.IsFixDeliverItemExists) then %>
					<!-- 플라워 배송 주문시 -->
					<div class="overHidden tMar60">
						<h3>플라워 배송 추가 정보</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>플라워 배송 추가 정보 입력</caption>
						<colgroup>
							<col width="12.5%" /><col width="38%" /><col width="12.5%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th><label for="flwSendName">보내시는 분</label></th>
							<td colspan="3"><input name="fromname" onkeyup="chkLength(this, 32);" Maxlength="32" type="text" class="txtInp" id="flwSendName" value="<%= oUserInfo.FOneItem.FUserName %>" /></td>
						</tr>
						<tr>
							<th>희망 배송일</th>
							<td><% DrawOneDateBoxFlower yyyy,mm,dd,tt %></td>
							</td>
							<th>메시지 선택</th>
							<td>
								<input type="radio" name="cardribbon" value="1" class="radio" id="msg01" checked /> <label for="msg01">카드</label>
								<input type="radio" name="cardribbon" value="2" class="radio lMar20" id="msg02" /> <label for="msg02">리본</label>
								<input type="radio" name="cardribbon" value="3" class="radio lMar20" id="msg03" /> <label for="msg03">없음</label>
							</td>
						</tr>
						<tr>
							<th>메시지 내용</th>
							<td colspan="3">
								<textarea name="message" style="width:99%;" rows="4" title="메시지 내용을 입력해주세요"></textarea>
							</td>
						</tr>
						</tbody>
					</table>
					<!-- //플라워 배송 주문시 -->
					<% end if %>
                    
                    <% if (isQuickDlvBoxShown) then %>
				    <div class="tMar60">
						<h3>배송방법 선택</h3>
						<div class="infoMoreViewV15" style="z-index:99;">
							<span class="btn btnS3 btnGry fn lMar10 tMar04"><em class="whiteArr01">바로배송 안내</em></span>
							<div class="infoViewLyrV15">
								<div class="infoViewBoxV15">
									<dfn></dfn>
									<div class="infoViewV15">
										<div class="pad20">
											<p>오전에 주문한 상품을 그날 오후에 바로 받자!<br />서울 전 지역 한정, 오후 1시까지 주문/결제를 완료할 경우 신청할 수 있는 퀵배송 서비스입니다.</p>
											<p class="tMar10">
											    <% if (C_QUICKDLVPRICE=5000) then %>
                								<strong>바로배송 배송료 : <span class="cRd0V15"><%=FormatNUMBER(C_QUICKDLVPRICE,0)%>원</span></strong><br />
                							    <% else %>
                								<strong>바로배송 배송료 : <del class="cGy1V15">5,000원</del> <span class="cRd0V15"><%=FormatNUMBER(C_QUICKDLVPRICE,0)%>원</span></strong><br /><span class="cGy1V15">(오픈기념 이벤트 할인중, 2018년 7월 18일까지)</span>
                							    <% end if %>
											</p>
											<p class="tPad15"><a href="<%= wwwUrl %>/shoppingtoday/barodelivery.asp" class="more1V15" style="color:#888; text-decoration:underline; cursor:pointer;">바로배송 상품 전체보기</a></p>
											<ul class="list01V15 tMar15">
												<li>바로배송은 배송지가 서울 지역일 경우 가능합니다.</li>
												<li>주문 당일 오후 1시전 결제완료된 주문에만 신청 가능하며, 오후 1시 이후 신청 시 다음날 배송이 시작됩니다.</li>
												<li>더욱 더 빠른 배송 서비스를 위해 주말/공휴일에는 쉽니다.</li>
												<li>상품의 부피/무게에 따라 배송 유/무 또는 요금이 달라질 수 있습니다.</li>
												<li>바로배송 서비스에는 무료배송쿠폰을 적용할 수 없습니다.</li>
												<li>회사 또는 사무실로 주문하시는 경우, <span class="cRd0V15">퇴근 시간 이후 배송될 수도 있습니다.</span> 오후 늦게라도 상품 수령이 가능한 주소지를 입력해주시면 감사하겠습니다.</li>
											</ul>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>배송지 정보 입력</caption>
						<tbody>
						<tr>
							<td>
								<div class="tPad05 bPad05 cGy3V15">
									<input type="radio" name="quickdlv" value="" onClick="chkQuickDlv(this)" class="radio" id="tenShipping" <%=CHKIIF(NOT isQuickDlv,"checked","")%>/> <label for="tenShipping"><strong>텐바이텐배송 (택배배송)</strong></label>
									<% If isQuickDlvStatusCheck Then %>
										<input type="radio" name="quickdlv" value="QQ" onClick="chkQuickDlv(this)" class="radio lMar20" id="quickShipping" <%=CHKIIF(isQuickDlv,"checked","")%>/> <label for="quickShipping"><strong>바로배송 (퀵배송)</strong></label>
									<% Else %>
										<input type="radio" name="quickdlv" value="QQ" onClick="chkQuickDlv(this)" class="radio lMar20" id="quickShipping" <%=CHKIIF(isQuickDlv,"checked","")%> disabled/> <label for="quickShipping"><span class="tPad05">바로배송 <span class="cRd0V15">(시스템 점검중)</span></span></label>
									<% End If %>
								</div>
							</td>
						</tr>
						<tr id="baronoti2" style="display:<%=CHKIIF(isQuickDlv,"","none")%>" >
							<td class="bPad10" >
								<ul class="list01V15 tMar10 bMar15" >
									<div id="baronoti1" style="display:<%=CHKIIF(IsQuickInvalidTime,"block","none")%>">
									<li class="cRd0V15"><strong>감사합니다. <%=Day(now())%>일 바로배송 서비스가 마감되었습니다. (<%=CHKIIF(IsTodayHoilDay,"주말/공휴일에는 쉽니다.","운영시간 평일 자정 00:00 ~ 13:00")%>)</strong></li>
								    </div>
									<li class="cRd0V15">바로배송은 서울 지역 한정, 주문 당일 오후 1시전 결제완료된 주문에만 적용되며, 오후 1시 이후 신청 시 다음날 배송이 시작됩니다.</li>
									<li>더욱 더 빠른 배송서비스를 위해 주말/공휴일에는 쉽니다.</li>
									<li>회사 또는 사무실로 주문하시는 경우, <span class="cRd0V15">퇴근 시간 이후 배송될 수도 있습니다.</span> 오후 늦게라도 상품 수령이 가능한 주소지를 입력해주시면 감사하겠습니다.</li>
								</ul>
							</td>
						</tr>
						</tbody>
					</table>
				    <% end if %>
				    
                    <%'해외 직구 배송 %>
					<% If (Not IsForeignDlv) and (oshoppingbag.IsGlobalShoppingServiceExists) Then %>
					<div class="overHidden tMar60">
						<h3>상품 통관 정보</h3>
					</div>
					<table class="baseTable orderForm tMar10">
						<caption>상품 통관 정보 입력</caption>
						<colgroup>
							<col width="12.5%" /><col width="" />
						</colgroup>
						<tbody>
						<tr>
							<th>개인통관<br />고유부호</th>
							<td colspan="3">
								<p class="tPad15"><input type="text"  class="txtInp" style="width:300px;" name="customNumber" id="customNumber" placeholder="P로 시작하는 13자리 번호를 입력 해주세요." maxlength="13"/><a href="https://unipass.customs.go.kr/csp/persIndex.do" class="addInfo" target="_blank"><em class="cBl1V17">발급안내</em></a></p>
                                <div class="tPad10 note01">
                                    <ul class="list01">
                                        <li class="cRd0V15">개인통관고유번호의 발급자명과 수령자명이 일치해야 합니다.</li>
                                        <li class="cGy1V15">통관 시 전체 주문/결제금액이 $150을(를) 초과할 경우 관/부가세가 발생할 수 있습니다.</li>
                                    </ul>
                                </div>
							</td>
						</tr>
						</tbody>
					</table>
					<% End If %>
					<%'해외 직구 배송 %>
					
					<% end if %>
					<div class="overHidden tMar60">
						<div class="ftLt" style="width:690px">
							<div class="overHidden">
								<h3 class="crRed">할인 정보</h3>
							</div>
							<table class="baseTable orderForm payForm tMar10" style="width:690px">
								<caption>할인 정보 입력</caption>
								<colgroup>
									<col width="95px" /><col width="315px" /><col width="" />
								</colgroup>
								<tbody>
								<tr <%= CHKIIF(IsRsvSiteOrder,"style='display:none'","")%>>
									<th width="95px" class="nowrap"><input name="itemcouponOrsailcoupon" value="S" type="radio" class="radio" id="bonusCp" <% if (oSailCoupon.FResultCount<1) or (IsKBRdSite) then response.write "disabled" %> <% if (oSailCoupon.FResultCount>0) and (Not IsKBRdSite) then response.write "checked" %> onClick="defaultCouponSet(this);" /> <label for="bonusCp">보너스 쿠폰</label></th>
									<td width="315px">
										<select name="sailcoupon" class="select offInput" title="보너스 쿠폰 선택하세요" style="width:310px;" onChange="RecalcuSubTotal(this);" onblur="chkCouponDefaultSelect(this);">
											<% if oSailCoupon.FResultCount<1 then %>
    											<option value="">사용 가능한 보너스 쿠폰이 없습니다.</option>
    										<% else %>
    											<option value="">사용 하실 보너스 쿠폰을 선택하세요!</option>
    										<% end if %>

    										<!-- Valid Sail Coupon -->
    										<% for i=0 to oSailCoupon.FResultCount - 1 %>
    										<!-- Not Mobile Coupon -->
    										<% If (osailcoupon.FItemList(i).IsMobileTargetCoupon) or (osailcoupon.FItemList(i).IsAppTargetCoupon) Then %>
    										<!-- not -->
    										<% Else %>
    											<% if (osailcoupon.FItemList(i).IsFreedeliverCoupon) then %>
    												<% if (oshoppingbag.GetOrgBeasongPrice<1) then %>
   													    <% if (IsShowInValidCoupon)  then %>
    														<option style="color:#CCCCCC" value="<%= oSailCoupon.FItemList(i).Fidx %>" id="0|0|0" ><%= oSailCoupon.FItemList(i).Fcouponname %> (<%= CHKIIF(IsForeignDlv or IsArmyDlv,"","현재 무료배송") %>) [<%= oSailCoupon.FItemList(i).getAvailDateStrFinish %>까지]</option>
    													<% end if %>
    												<% elseif (Clng(oshoppingbag.GetCouponNotAssingTenDeliverItemPrice) < osailcoupon.FItemList(i).Fminbuyprice) then %>
    													<% if (IsShowInValidCoupon) then %>
    														<option style="color:#CCCCCC" value="<%= oSailCoupon.FItemList(i).Fidx %>" id="0|0|0" ><%= oSailCoupon.FItemList(i).Fcouponname %> (텐바이텐배송금액기준) [<%= oSailCoupon.FItemList(i).getAvailDateStrFinish %>까지]</option>
    													<% end if %>
    												<% else %>
    													<option value="<%= oSailCoupon.FItemList(i).Fidx %>" id="<%= oSailCoupon.FItemList(i).Fcoupontype %>|<%= oSailCoupon.FItemList(i).Fcouponvalue %>|0"><%= oSailCoupon.FItemList(i).Fcouponname %> (텐바이텐배송금액기준) [<%= oSailCoupon.FItemList(i).getAvailDateStrFinish %>까지]</option>
    													<% vaildCouponCount = vaildCouponCount + 1 %>
    												<% end if %>
    											<% else %>
    												<% if (Clng(oshoppingbag.GetTotalItemOrgPrice) >= osailcoupon.FItemList(i).Fminbuyprice) then %>
    													<% if (osailcoupon.FItemList(i).IsBrandTargetCoupon or osailcoupon.FItemList(i).IsCategoryTargetCoupon) then %>
    													    <% if (IsValidCateBrandCoupon(userid,osailcoupon.FItemList(i).Fidx)) then %>
    													    <option value="<%= oSailCoupon.FItemList(i).Fidx %>" id="<%= (oSailCoupon.FItemList(i).Fcoupontype+5) %>|<%= oSailCoupon.FItemList(i).Fcouponvalue %>|<%= oSailCoupon.FItemList(i).FmxCpnDiscount %>"><%= oSailCoupon.FItemList(i).Fcouponname %> <%=oSailCoupon.FItemList(i).getCouponAddStringInBaguni%></option>
    													    <% vaildCouponCount = vaildCouponCount + 1 %>
    													    <% else %>
        													    <% if (IsShowInValidCoupon) then %>
        													    <option style="color:#CCCCCC" value="<%= oSailCoupon.FItemList(i).Fidx %>" id="0|0|0"><%= oSailCoupon.FItemList(i).Fcouponname %> <%=oSailCoupon.FItemList(i).getCouponAddStringInBaguni%></option>
        													    <% end if %>
    													    <% end if %>
    												    <% else %>
    													<option value="<%= oSailCoupon.FItemList(i).Fidx %>" id="<%= oSailCoupon.FItemList(i).Fcoupontype %>|<%= oSailCoupon.FItemList(i).Fcouponvalue %>|<%= oSailCoupon.FItemList(i).FmxCpnDiscount %>"><%= oSailCoupon.FItemList(i).Fcouponname %> <%=oSailCoupon.FItemList(i).getCouponAddStringInBaguni%></option>
    													<% vaildCouponCount = vaildCouponCount + 1 %>
    													<% end if %>
    												<% else %>
    													<% if (IsShowInValidCoupon) then %>
    														<option style="color:#CCCCCC" value="<%= oSailCoupon.FItemList(i).Fidx %>" id="0|0|0"><%= oSailCoupon.FItemList(i).Fcouponname %> <%=oSailCoupon.FItemList(i).getCouponAddStringInBaguni%></option>
    													<% end if %>
    												<% end if %>
    											<% end if %>
    										<% End If %>
    										<% next %>
										</select>
									</td>
									<td><span class="cmt02 cr555 nowrap">적용가능 보너스 쿠폰 : <strong><%= FormatNumber(vaildCouponCount,0) %></strong>장</span></td>
								</tr>
								<tr <%= CHKIIF(IsRsvSiteOrder,"style='display:none'","")%>>
									<th width="95px" class="nowrap"><input name="itemcouponOrsailcoupon" value="I" type="radio" class="radio" id="pdtCp" <% if (oItemCoupon.FResultCount<1) or (IsKBRdSite) then response.write "disabled" %> <% if (oSailCoupon.FResultCount<1) and (oItemCoupon.FResultCount>0) and (Not IsKBRdSite) then response.write "checked" %> onClick="defaultCouponSet(this);" /> <label for="pdtCp">상품 쿠폰</label></th>
									<td width="315px">
									    <!-- Valid Coupon -->
										<% for i=0 to oItemCoupon.FResultCount - 1 %>
										<% if (oshoppingbag.IsCouponItemExistsByCouponIdx(oItemCoupon.FItemList(i).Fitemcouponidx)) then %>
										    <% if Not ((oitemcoupon.FItemList(i).IsFreeBeasongCoupon) and (oshoppingbag.GetOrgBeasongPrice<1)) then %>
										        <% if NOT (oitemcoupon.FItemList(i).IsFreeBeasongCoupon and (isArmyDlv or IsForeignDlv)) then %> <% ''2018/03/26 추가 %>
										    <p><span class="crGrn">
														<%= oItemCoupon.FItemList(i).Fitemcouponname %> (<strong><%= oItemCoupon.FItemList(i).GetDiscountStr %></strong>)
														<% vaildItemcouponCount = vaildItemcouponCount + 1 %>
														<% checkitemcouponlist = checkitemcouponlist & oItemCoupon.FItemList(i).Fitemcouponidx & "," %>
											</span></p>
											    <% end if %>
										    <% end if %>
										<% end if %>
										<% next %>

										<% if (IsShowInValidItemCoupon) then %>
											<!-- In Valid Coupon -->
											<% for i=0 to oItemCoupon.FResultCount - 1 %>
											<p><span class="crGrn">
													<% if (oshoppingbag.IsCouponItemExistsByCouponIdx(oItemCoupon.FItemList(i).Fitemcouponidx)) then %>
														<% if (oitemcoupon.FItemList(i).IsFreeBeasongCoupon) and (oshoppingbag.GetOrgBeasongPrice<1) then %>
															<%= oItemCoupon.FItemList(i).Fitemcouponidx %><%= oItemCoupon.FItemList(i).Fitemcouponname %> (<%= oItemCoupon.FItemList(i).GetDiscountStr %> <%= CHKIIF(IsForeignDlv or IsArmyDlv,"","/ 현재 무료배송") %> )
														<% end if %>
													<% else %>
														<%= oItemCoupon.FItemList(i).Fitemcouponidx %><%= oItemCoupon.FItemList(i).Fitemcouponname %> (<%= oItemCoupon.FItemList(i).GetDiscountStr %> / 해당 상품 없음 )
													<% end if %>
											</span></p>
											<% next %>
										<% end if %>

										<% if (vaildItemcouponCount<1) then %>
											<p>적용 가능한 상품쿠폰이 없습니다.</p>
													<script language='javascript'>
													document.frmorder.itemcouponOrsailcoupon[1].disabled=true;
													</script>
										<% end if %>
									</td>
									<td><span class="cmt02 cr555 nowrap">적용가능 상품 쿠폰 : <strong><%= FormatNumber(vaildItemcouponCount,0) %></strong>장</span></td>
								</tr>
								<tr>
									<th width="95px" class="nowrap"><label for="mileage">마일리지</label></th>
									<td width="315px">
										<% if (IsMileageDisabled) then %>
											<p><input name="spendmileage" value="<%= oshoppingbag.GetMileageShopItemPrice %>" type="text" class="txtInp" style="width:75px;background-color:#EEEEEE;" id="mileage" onKeyUp="RecalcuSubTotal(this);" ReadOnly /> Point</p>
											<p class="tPad05"><%= MileageDisabledString %></p>
											<% else %>
											<input name="spendmileage" type="text" class="txtInp rmvIEx" style="width:75px;" id="mileage" onKeyUp="RecalcuSubTotal(this);" /> Point
										<% end if %>
									</td>
									<td><span class="cmt02 cr555 nowrap">보유 마일리지 : <strong><%= FormatNumber(oMileage.FTotalMileage,0) %></strong>Point</span></td>
								</tr>
								<tr>
									<th width="95px" class="nowrap"><label for="balance">예치금</label></th>
									<td width="315px">
										<% if (IsTenCashEnabled) then %>
										<input name="spendtencash" type="text" class="txtInp rmvIEx" style="width:75px;" id="balance"  value="" onKeyUp="RecalcuSubTotal(this);" /> 원
										<% else %>
										<input name="spendtencash" type="text" class="txtInp" style="width:75px;background-color:#EEEEEE" value="" ReadOnly id="balance" /> 원
										<% end if %>
										<span class="addInfo" style="position:relative;">
											<em>예치금 이용안내</em>
											<div class="contLyr" id="idtenMoney" style="width:360px; left:17px; top:7px;">
												<div class="contLyrInner">
													예치금은 텐바이텐 온라인 쇼핑몰에서 최소구매금액 제한 없이 언제라도 현금처럼 사용할 수 있습니다.<br /><br />
													자세한 내용은 <span class="crRed"><a href="<%= wwwUrl %>/my10x10/myTenCash.asp" class="crRed">마이텐바이텐 &gt; 예치금</a></span>에서 확인하세요.
												</div>
											</div>
										</span>
									</td>
									<td><span class="cmt02 cr555 nowrap">보유 예치금 : <strong><%= FormatNumber(availtotalTenCash,0) %></strong>원</span></td>
								</tr>
								<tr>
									<th width="95px" class="nowrap"><label for="giftCard">Gift카드</label></th>
									<td width="315px">
										<% if (IsEGiftMoneyEnable) then %>
										<input name="spendgiftmoney" type="text" class="txtInp rmvIEx" style="width:75px;" id="giftCard" onKeyUp="RecalcuSubTotal(this);" /> 원
										<% else %>
										<input name="spendgiftmoney" type="text" class="txtInp" style="width:75px;background-color:#EEEEEE;" ReadOnly id="giftCard"  /> 원
										<% end if %>
										<span class="addInfo">
											<em>Gift카드 이용안내</em>
											<div class="contLyr" id="idtenMoney" style="width:370px; left:17px; top:7px;">
												<div class="contLyrInner">
													Gift 카드는 텐바이텐 온라인 쇼핑몰에서 최소구매금액 제한 없이 언제라도 현금처럼 사용할 수 있습니다.<br /><br />
													자세한 내용은 <span class="crRed"><a href="<%= wwwUrl %>/my10x10/giftcard/index.asp" class="crRed">마이텐바이텐 &gt; GIFT 카드</a></span>에서 확인하세요.
												</div>
											</div>
										</span>
									</td>
									<td><span class="cmt02 cr555 nowrap">Gift 카드 잔액 : <strong><%= FormatNumber(availTotalGiftMoney,0) %></strong>원</span></td>
								</tr>
								<% if (IsKBRdSite) then %>
								<tr>
									<th width="95px" class="nowrap"><input name="itemcouponOrsailcoupon" value="K" type="radio" class="radio" id="kbRdSite" checked onClick="defaultCouponSet(this);" /> <label for="kbRdSite">KB카드몰할인</label></th>
									<td width="315px">
										KB카드몰 5% 할인 (일부상품 제외)
										<input type="hidden" name="kbcardsalemoney" value="<%= kbcardsalemoney %>">
									</td>
									<td></td>
								</tr>
								<% end if %>
								</tbody>
							</table>
							<dl class="note01 tPad30 lPad20">
								<dt><strong class="fs13">유의사항</strong></dt>
								<dd>
									<ul class="list01">
									<% if (IsRsvSiteOrder) then %>
										<li>현장 수령 상품은 쿠폰 사용이 불가 합니다.</li>
									<% end if %>
										<li>마일리지는 상품금액 30,000원 이상 결제시 사용 가능합니다.</li>
										<li>예치금의 적립, 사용 내역 확인 및 무통장입금 신청은 마이텐바이텐에서 가능합니다.</li>
										<li>Gift 카드는 인증번호 등록 후 사용할 수 있으며, 등록 및 사용 내역 확인은 마이텐바이텐에서 가능합니다.</li>
									<% if (IsKBRdSite) then %>
										<li>KB카드로 결제시 상품 금액의 5%를 할인해 드립니다.(KB카드 홈페이지를 경유해서 접속한경우에 한합니다.)</li>
										<li>KB카드로 할인 결제시 쿠폰은 사용하실 수 없습니다.</li>
										<li>기존 할인된 상품은 중복할인은 되지 않습니다.</li>
									<% else %>
										<li>상품쿠폰과 보너스쿠폰은 중복사용이 불가능합니다.</li>
										<li>무료배송 보너스 쿠폰은 텐바이텐 주문 금액 기준입니다.</li>
										<li>보너스쿠폰 중 %할인쿠폰은 이미 할인을 하는 상품에 대해서는 중복 적용이 되지 않습니다.</li>
										<li>정상판매가 상품 중 일부 상품은 %할인쿠폰이 적용되지 않습니다.</li>
										<li>보너스쿠폰 중 금액할인쿠폰을 사용하여 복수의 상품을 구매 하시는 경우, 상품별 판매가에 따라 쿠폰할인금액이 각각 분할되어 적용됩니다.</li>
									<% end if %>
									<% if (IsUsePaybackMile) then %>
										<li>주문취소 및 환불, 반품에 따라 paybak 마일리지 포인트는 변경 및 취소될 수 있습니다.</li>
									<% end if %>
									<% if (IsTicketOrder) and (Not IsTravelItem) then %>
										<li>티켓상품은 예치금과 Gift카드 사용만 가능합니다. (마일리지, 할인쿠폰 등 사용 불가)</li>
										<li>티켓상품 취소시 예매날짜와 공연날짜에 따라 취소수수료가 있습니다. <span class="addInfo"><em onClick="popTicketCancelInfo();">취소 수수료보기</em></span></li>
									<% end if %>
									<% if (IsTravelItem) then %>
										<li>여행상품은 예치금, Gift카드, 마일리지 사용만 가능합니다. (할인쿠폰 등 사용 불가)</li>
										<li>여행상품 취소시 여행일자 및 발권일자에 따라 취소수수료가 있습니다.</li>
									<% end if %>
									</ul>
								</dd>
							</dl>
							<input type="hidden" name=availitemcouponlist value="<%= checkitemcouponlist %>">
							<input type="hidden" name=checkitemcouponlist value="">
						</div>

						<div class="ftRt" style="width:340px">
							<div class="overHidden">
								<h3 class="crRed">결제 금액</h3>
							</div>
							<div class="payForm tMar10">
								<table>
								<caption>결제 금액 보기</caption>
								<colgroup>
									<col width="50%" /><col width="" />
								</colgroup>
								<tbody>
								<tr>
									<th>총 주문금액</th>
									<td><%= FormatNumber(oshoppingbag.GetTotalItemOrgPrice,0) %>원</td>
								</tr>

								<%
								'선물포장서비스 노출
								if G_IsPojangok then
								%>
									<% 
									'/선물포장가능상품
									if oshoppingbag.IsPojangValidItemExists then
										'/선물포장완료상품존재
										if oshoppingbag.IsPojangcompleteExists then
										%>
											<tr>
												<th>선물포장비</th>
												<td><%= FormatNumber(pojangcash,0) %>원</td>
											</tr>
										<% end if %>
									<% end if %>
								<% end if %>

								<% if (IsForeignDlv) then %>
								<tr>
									<th>해외배송비(EMS)</th>
									<td><span id="DISP_DLVPRICE"></span>원</td>
								</tr>
								<% elseif (IsArmyDlv) then %>
								<tr>
									<th>군부대 배송비</th>
									<td><span id="DISP_DLVPRICE"><%= FormatNumber(oshoppingbag.GetTotalBeasongPrice,0) %></span>원</td>
								</tr>
								<% elseif (IsQuickDlv) then %>
								<tr>
									<th>배송비</th>
									<td><span id="DISP_DLVPRICE"><%= FormatNumber(C_QUICKDLVPRICE,0) %></span>원</td>
								</tr>
								<% else %>
								<tr>
									<th>배송비</th>
									<td><span id="DISP_DLVPRICE"><%= FormatNumber(oshoppingbag.GetOrgBeasongPrice,0) %></span>원</td>
								</tr>
								<% end if %>
								<tr>
									<th>보너스쿠폰 사용</th>
									<td><span class="crRed"><span id="DISP_SAILCOUPON_TOTAL" >0</span>원</td>
							</tr>
								<tr>
									<th>상품쿠폰 사용</th>
									<td><span class="crRed"><span id="DISP_ITEMCOUPON_TOTAL" >0</span>원</td>
								</tr>
								<tr class="midMilieage"><!--midTotal-->
									<th><strong class="fs13">구매 확정액</strong></th>
									<td><span class="crRed"><em class="fs18"><span id="DISP_FIXPRICE" ><%= FormatNumber(subtotalprice+oshoppingbag.GetMileageShopItemPrice,0) %></span></em>원</span></td>
								</tr>

								<tr>
									<th>
									<% if (oshoppingbag.GetMileageShopItemPrice>0) then %>
									마일리지샵 금액
									<% else %>
									마일리지 사용
									<% end if %>
									</th>
									<td><span class="crRed"><span id="DISP_SPENDMILEAGE" ><%= FormatNumber(oshoppingbag.GetMileageShopItemPrice*-1,0) %></span>P</span></td>
								</tr>
								<tr>
									<th>예치금 사용</th>
									<td><span id="DISP_SPENDTENCASH" >0</span>원</td>
								</tr>
								<tr>
									<th>Gift카드 사용</th>
									<td><span id="DISP_SPENDGIFTMONEY" >0</span>원</td>
								</tr>
								<% if (IsKBRdSite) then %>
								<tr>
									<th>KB 카드몰 할인</th>
									<td><span id="DISP_KBCARDSALE_TOTAL" >0</span>원</td>
								</tr>
								<% end if %>
								</tbody>
								<tfoot>
								<tr>
									<th><strong class="fs13">최종 결제액</strong></th>
									<td><span class="crRed"><em class="fs20"><span id="DISP_SUBTOTALPRICE" ><%= FormatNumber(subtotalprice,0) %></span></em>원</span></td>
								</tr>
								</tfoot>
								</table>
							</div>
						</div>
					</div>
			<%
			'//2월 구매사은 이벤트 '/2016-02-03 원승현
			if date>="2016-02-04" and date<"2016-02-11" then
			%>
				<p class="tMar20">
					<a href="<%= wwwUrl %>/event/eventmain.asp?eventid=68950" title="68950이벤트"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68950/img_bnr.jpg" alt="2월구매사은이벤트" /></a>
				</p>
			<% end if %>


<% IF (OpenGiftExists) and Not(IsTicketOrder) then %>
<%
Dim giftOpthtml, optAllsoldOut, soCnt
Dim preRange, preRow
Dim k : k=0
Dim cc, tb

if (CGiftsCols=2) Then
	if date>="2017-04-03" and date<"2017-04-18" Then
	    CGiftsRows = 2
	Else
	    CGiftsRows = 3
	End If
else
    CGiftsRows = 2
end if
%>
<!-- 사은품선택 이벤트가 있는 경우 -->
					<div class="freeGiftBox gift120" >
						<dl class="dfn02">
							<dt>
								<p><img src="http://webimage.10x10.co.kr/eventIMG/2017/76534/tit_march_gift.png" alt="구매금액별 사은이벤트" /></p>
								<% if Not (isNULL(evtStDT) or isNULL(evtEdDt)) then %>
								<p class="tPad15">이벤트기간 : <%= replace(evtStDT,"-",".") %> ~ <%= replace(replace(evtEdDt,"-","."),Left(evtStDT,4)&".","") %></p>
								<% end if %>
							</dt>
							<dd>
								<ul class="list01">
								<% if (isNULL(banImage) or (banImage="")) then %>
								<%= evtDesc %>
								<% else %>
								<img src="<%= Replace(banImage,"http://webimage.10x10.co.kr/","/webimage/") %>" alt="사은품 안내" />
								<% end if %>
								</ul>
							</dd>
						</dl>
						<table class="tMar30">
						<caption>사은품 선택</caption>
						<colgroup>
							<% for i=0 to CGiftsCols*CGiftsRows-1 %>
    						    <% if (CGiftsCols<>0) then %>
    							<col width="<%=CLNG(100.0/CGiftsCols/CGiftsRows*100)/100%>%" />
    							<% end if %>
							<% next %>
						</colgroup>
						<tbody>
							<% For j=0 to oOpenGiftDepth.FResultCount-1 Step CGiftsRows %>
							<tr>
							    <% for tb=0 to CGiftsRows-1 %>
								<th colspan="<%=CGiftsCols%>" class="<%=CHKIIF(tb<>0,"lBdr1 ","")%>crRed" >
								<% if (j+tb<=oOpenGiftDepth.FResultCount-1) then %>
								<%= oOpenGiftDepth.FItemList(j+tb).getRangeName %>
								<% end if %>
								</th>
								<% next %>
							</tr>
							<tr>
							    <% for tb=0 to CGiftsRows-1 %>
							    <% k=0 %>
							    <% for i=0 to oOpenGift.FResultCount-1 %>
                                <% if (j+tb<=oOpenGiftDepth.FResultCount-1) then %>
							    <% if (oOpenGiftDepth.FItemList(j+tb).Fgift_range1=oOpenGift.FItemList(i).Fgift_range1) and (oOpenGiftDepth.FItemList(j+tb).Fgift_range2=oOpenGift.FItemList(i).Fgift_range2) then %>
							    <%
							    optAllsoldOut = false
                	            giftOpthtml = oOpenGift.FItemList(i).getGiftOptionHTML(optAllsoldOut)

                                k=k+1
                                %>
								<td <%=CHKIIF(tb<>0 and k=1,"class='lBdr1'","")%> <%=CHKIIF(tb<>0 and k=1," colspan='"&CGiftsCols&"'","")%>>
									<div class="giftWrap">
										<input type="hidden" name="rGiftCode" value="<%= oOpenGift.FItemList(i).Fgift_code %>" />
										<input type="hidden" name="rGiftDlv" value="<%= oOpenGift.FItemList(i).Fgift_delivery %>" />
									<% if oOpenGift.FItemList(i).IsGiftItemSoldOut or (optAllsoldOut) or (Not TenBeasongInclude and oOpenGift.FItemList(i).Fgift_delivery="N") then %>
										<p><input type="radio" name="rRange" id="<%= subtotalprice+1000000 %>" value="<%= oOpenGift.FItemList(i).Fgiftkind_code %>" Disabled  OnClick="giftOptEnable(this);" /></p>
									<% else %>
										<p><input type="radio" name="rRange" id="<%= oOpenGift.FItemList(i).Fgift_range1 %>" value="<%= oOpenGift.FItemList(i).Fgiftkind_code %>" <%= CHKIIF(subtotalPrice>=oOpenGift.FItemList(i).Fgift_range1,"","disabled") %> OnClick="giftOptEnable(this);" /></p>
									<% end if %>
									<% if  Not IsNULL(oOpenGift.FItemList(i).Fimage120) then %>
										<p><label for="gift01"><img src="<%= Replace(oOpenGift.FItemList(i).Fimage120,"http://webimage.10x10.co.kr/","/webimage/") %>" alt="<%= oOpenGift.FItemList(i).Fgiftkind_name %>" <%= CHKIIF(oOpenGift.FItemList(i).Fgift_delivery="C","","onClick=""popGiftDetail('"& oOpenGift.FItemList(i).Fgiftkind_code &"','"&oOpenGift.FItemList(i).Fgift_code&"');"" style='cursor:pointer'") %>/></label></p>
									<% else %>
										<p><label for="gift01"></label></p>
									<% end if %>
										<div>
											<p class="ct"><strong><%= oOpenGift.FItemList(i).Fgiftkind_name %></strong></p>
										<% if (oOpenGift.FItemList(i).IsGiftItemSoldOut) or (optAllsoldOut) then %>
											<p class="ct"><img src="/fiximage/web2013/shopping/tag_soldout.gif" alt="sold out" /></p>
										<% else %>
											<p class="ct"><span class="cr000"><strong><%= oOpenGift.FItemList(i).getGiftLimitStr %></strong></span></p>
										<% end if %>
										<% if (Not TenBeasongInclude and oOpenGift.FItemList(i).Fgift_delivery="N")  then %>
											<p class="ct">(텐바이텐 배송상품 구매시 선택가능)</p>
										<% elseif (oOpenGift.FItemList(i).Fgift_delivery="C") then %>
											<!--<p class="ct">(지정일 일괄발급)</p>-->
										<% end if %>

										<% if (oOpenGift.FItemList(i).Fgift_delivery="N") and InStr(oOpenGift.FItemList(i).Fgiftkind_name,"기프티콘")  then %>
										<p class="ct">(지정일 일괄발급)</p>
										<% end if %>
										</div>
										<p><%= giftOpthtml %></p>
									</div>
								</td>
								<% end if %>
								<% end if %>
								<% next %>
                                <% next %>
							</tr>
							<% next %>

						</tbody>
						</table>
					</div>

<!-- // 사은품 선택 이벤트가 있는 경우 -->
<% end if %>
<% if (DiaryOpenGiftExists) and giftCheck then %>
<%
Dim DgiftSelValid, vDiaryRange
j=0 : i=0
optAllsoldOut = false
%>

                    <div class="freeGiftBox gift120 diaryGift2021">
                    <% if (oDiaryOpenGift.FResultCount>0) then %>
                        <input type="hidden" name="DiNo" value="1">
						<input type="hidden" name="dGiftCode" value="">
						<input type="hidden" name="TenDlvItemPrice" value="<%=TenDlvItemPrice%>">
						<dl class="dfn02">
							<dt>
								<div>
									<p class="crRed">2022 다이어리 스토리</p>
									<strong class="cr000">구매 사은품 증정</strong>
								</div>

								<%' if Not (isNULL(devtStDT) or isNULL(devtEdDt)) then %>
								<!-- <p class="tPad15">※ 선물 증정은 재고 소진 시 조기 종료됩니다</p>-->
								<p class="tPad15">이벤트기간 : 2021.09.01 AM 11:00 ~ 12.31</p>
								<%' end if %>
							</dt>
							<dd>
								<ul class="list01">
									<%=devtDesc%>
								</ul>
							</dd>
						</dl>
						<table class="tMar30">
							<caption>사은품 선택</caption>
							<colgroup>					
								<col width="16.67%" /><col width="16.67%" /><col width="16.67%" /><col width="16.67%" />
							</colgroup>
							<thead>
								<tr>
									<th colspan="2" class="crRed">2만원 이상 구매 시</th>
									<th colspan="2" class="lBdr1 crRed">5만원 이상 구매 시</th>
								</tr>
							</thead>
							<tbody>
							<tr>
							<% for i=0 to oDiaryOpenGift.FResultCount-1 %>
							<%
							optAllsoldOut = false
							giftOpthtml = oDiaryOpenGift.FItemList(i).getGiftOptionHTML(optAllsoldOut)

							k=k+1
							%>
								<% if vDiaryRange <> oDiaryOpenGift.FItemList(i).Fgift_range1 and i<>0 then %>
								<td class="lBdr1">
								<% else %>
								<td>
								<% end if %>
									<div class="giftWrap">
										<input type="hidden" name="dtGiftCode" value="<%= oDiaryOpenGift.FItemList(i).Fgift_code %>" />
										<input type="hidden" name="dGiftDlv" value="<%= oDiaryOpenGift.FItemList(i).Fgift_delivery %>" />
									<% if oDiaryOpenGift.FItemList(i).IsGiftItemSoldOut or (optAllsoldOut) or (Not TenBeasongInclude and oDiaryOpenGift.FItemList(i).Fgift_delivery="N") then %>
										<p><input type="radio" name="dRange" id="<%= subtotalprice+1000000 %>" value="<%= oDiaryOpenGift.FItemList(i).Fgiftkind_code %>" Disabled  OnClick="DgiftOptEnable(this);" /></p>
									<% else %>
										<p><input type="radio" name="dRange" id="<%= oDiaryOpenGift.FItemList(i).Fgift_range1 %>" value="<%= oDiaryOpenGift.FItemList(i).Fgiftkind_code %>" <%= CHKIIF(subtotalprice>=oDiaryOpenGift.FItemList(i).Fgift_range1,"","disabled") %> OnClick="DgiftOptEnable(this);" /></p>
									<% end if %>
									<% if  Not IsNULL(oDiaryOpenGift.FItemList(i).Fimage120) then %>
										<p><label for="gift01"><img src="<%= Replace(oDiaryOpenGift.FItemList(i).Fimage120,"http://webimage.10x10.co.kr/","/webimage/") %>" alt="<%= oDiaryOpenGift.FItemList(i).Fgiftkind_name %>" <%= CHKIIF(oDiaryOpenGift.FItemList(i).Fgift_delivery="C","","onClick=""popGiftDetail('"& oDiaryOpenGift.FItemList(i).Fgiftkind_code &"','"&oDiaryOpenGift.FItemList(i).Fgift_code&"');"" style='cursor:pointer'") %>/></label></p>
									<% else %>
										<p><label for="gift01"><img width="120" src="http://webimage.10x10.co.kr/images/no_image.gif" alt="사은품 이미지" /></label></p>
									<% end if %>
											<div>
											<p><strong><%= oDiaryOpenGift.FItemList(i).Fgiftkind_name %></strong></p>
											<% if (oDiaryOpenGift.FItemList(i).Fgift_delivery="N") then %>
											<p class="ct">랜덤 증정</p>
											<em class="limited"><img src="http://fiximage.10x10.co.kr/web2020/diary2021/txt_limited.png" alt="limited"></em>
											<% end if %>
										<% if (oDiaryOpenGift.FItemList(i).IsGiftItemSoldOut) or (optAllsoldOut) then %>
											<p><img src="/fiximage/web2013/shopping/tag_soldout.gif" alt="sold out" /></p>
										<% else %>
											<p><span class="cr000"><strong><%= oDiaryOpenGift.FItemList(i).getGiftLimitStr %></strong></span></p>
										<% end if %>
										<% if (Not TenBeasongInclude and oDiaryOpenGift.FItemList(i).Fgift_delivery="N")  then %>
											<p>(텐바이텐 배송상품 구매시 선택가능)</p>
										<% elseif (oDiaryOpenGift.FItemList(i).Fgift_delivery="C") then %>
											<p class="crRed">- 모든 상품 출고 후 익일지급</p>
											<p class="crRed">- 지급 후 30일 동안 사용 가능</p>
										<% end if %>
										<% if (oDiaryOpenGift.FItemList(i).Fgift_delivery="N") and InStr(oDiaryOpenGift.FItemList(i).Fgiftkind_name,"기프티콘")  then %>
											<p class="crRed">- 모든 상품 출고 후 익일지급</p>
											<p class="crRed">- 지급 후 30일 동안 사용 가능</p>
										<% end if %>
										</div>
										<p><%= giftOpthtml %></p>
										
									</div>
								</td>
								<% vDiaryRange = oDiaryOpenGift.FItemList(i).Fgift_range1 %>
							<% next %>
							</tr>
							</tbody>
						</table>
						
					<% end if %>
					</div>
<% end if %>

<% if (IsForeignDlv) then %>
					<!-- 해외 배송 주문시 -->
					<div class="overHidden tMar50">
						<h3 class="crRed">해외배송 약관 동의</h3>
					</div>
					<table class="baseTable orderForm payForm tMar10">
						<caption>해외배송 약관 동의</caption>
						<tbody>
						<tr>
							<td>
								<dl class="dfn02">
									<dt><strong>통관/관세 안내</strong></dt>
									<dd>
										<ul class="list01">
											<li>해외에서 배송한 상품을 받을 때 일부 상품에 대해 해당 국가의 관세법의 기준에 따라 관세와 부가세 및 특별세 등의 세금을 징수합니다.</li>
											<li>해외의 각국들 역시 도착지의 세법에 따라 세금을 징수할 수도 있습니다. 그 부담은 상품을 받는 사람이 지게 됩니다.</li>
											<li>하지만 특별한 경우를 제외한다면, 선물용으로 보내는 상품에 대해서는 세금이 없습니다. <a href="" class="crRed" onClick="myqnawrite();return false;">[1:1상담신청하기]</a></li>
											<li>전자제품(ex: 전압, 전류 차이) 등 사용 환경이 다른 상품의 사용 시 발생할 수 있는 모든 문제의 책임은 고객에게 있습니다.</li>
										</ul>
									</dd>
								</dl>
								<dl class="dfn02">
									<dt><strong>해외배송 반품</strong></dt>
									<dd>
										<ul class="list01">
											<li>해외에서 상품을 받으신 후 반송을 해야 할 경우 고객센터에 연락 후 반품해주시길 바라며, 반품 시 발생하는 EMS요금은 고객 부담입니다.</li>
										</ul>
									</dd>
								</dl>
							</td>
						</tr>
						<tr>
							<td class="ct fs12">
								<input type="checkbox" name="overseaDlvYak" id="overseaDlvYak" class="check" /> <label for="overseaDlvYak"><span class="cr000">해외 배송 서비스 이용약관을 확인하였으며 약관에 동의합니다.</span></label>
							</td>
						</tr>
						</tbody>
					</table>
					<!-- //해외 배송 주문시 -->
<% end if %>

<% if (IsZeroPrice) Then %>
<!-- 무통장 금액 0 이면 바로 진행 -->
<input type="hidden" name="Tn_paymethod" id="Tn_paymethod0" value="000" >
<% else %>

					<div class="overHidden tMar50" >
						<h3 class="crRed" id="paymethodTitle">결제 수단</h3>
						<% if (IsTicketOrder) then %>
							<span class="fs11 ftLt tPad05 lPad10 cr777">티켓상품은 무통장 입금 마감일이 티켓예약 익일 24:00까지 입니다.</span>
						<% end if %>
						<% if ("2011-12-31">now()) then %>
							<span class="fs11 ftLt tPad05 lPad10 cr777"><em class="crRed">휴대폰 결제</em> 고객 중 250명에게 2만원 쿠폰 증정! (이벤트 기간 2011년 12월1일~12월31일) 당첨자 공지-2012년 1월6일</span>
						<% end if %>
						<% if ("2012-05-01">now()) then %>
							<% if (Not IsOKCASHBAGRdSite) and (Not IsKBRdSite) then %>
								<script language='javascript'>
									function popLotteEvt(){
										var popwin1=window.open('http://www.10x10.co.kr/event/eventmain.asp?eventid=33498','popLotteCardEvt','width=980,height=700,scrollbars=yes');
										popwin1.focus();
									}
								</script>
								<span class="fs11 ftLt tPad05 lPad10 cr777"><a href="javascript:popLotteEvt();">롯데카드 3만원이상 구매시 <strong class="crRed">5% 청구할인</strong> [~4.30]</a></span>
							<% end if %>
						<% end if %>
					</div>
					<div class="payMethodWrap" id="i_paymethod" name="i_paymethod">
						<table class="baseTable orderForm payForm tMar10">
							<caption>결제 수단 입력</caption>
							<colgroup>
								<col width="12%" /><col width="" /><col width="32%;" />
							</colgroup>
							<thead>
							<tr>
								<td colspan="3">
									<div class="pay-method-tab">
									<%
										'제휴사 할인 이벤트 허진원 2020.08.28
										dim currentDate
										currentDate = date()
									%>
										<% If (vlsOnlyHanaTenPayExist) Then '텐텐하나체크카드 전용결제 상품 %>
											<span><input name="Tn_paymethod" type="radio" class="radio" id="Tn_paymethodH" value="190" OnClick="CheckPayMethod(this);" checked /> <label for="Tn_paymethodH"><strong>텐바이텐 체크카드</strong></label></span>
											<script>
												$(function(){
												CheckPayMethodHANA("190");
												});
											</script>
										<% Else %>
											<span id="tabCard"><input name="Tn_paymethod" type="radio" class="radio" id="Tn_paymethod1" value="100" OnClick="CheckPayMethod(this);" checked /> <label for="Tn_paymethod1"><strong>신용카드 <%= ChkIIF(IsKBRdSite,"(KB카드)","") %></strong></label></span>
											
											<% if (G_PG_HANATEN_ENABLE) then %>
											<span id="tabTenHana"><input name="Tn_paymethod" type="radio" class="radio" id="Tn_paymethodH" value="190" OnClick="CheckPayMethod(this);" /> <label for="Tn_paymethodH"><strong>텐바이텐 체크카드</strong></label></span>
											<% end if %>
											
											<span id="tabDirectBank"><input name="Tn_paymethod" type="radio" class="radio" id="Tn_paymethod2" value="20" OnClick="CheckPayMethod(this);" <%= ChkIIF(IsKBRdSite,"disabled","") %> /> <label for="Tn_paymethod2"><strong>실시간 계좌이체</strong></label></span>

											<span id="tabBank"><input name="Tn_paymethod" type="radio" class="radio" id="Tn_paymethod3" value="7" OnClick="CheckPayMethod(this);" <%= ChkIIF(IsKBRdSite or oshoppingbag.IsBuyOrderItemExists or (isQuickDlv and isQuickDlvBoxShown),"disabled","") %> /> <label for="Tn_paymethod3"><strong>무통장 입금(가상계좌)</strong></label></span>

											<span id="tabHPP"><input name="Tn_paymethod" type="radio" class="radio" id="Tn_paymethod4" value="400" OnClick="CheckPayMethod(this);" <%= ChkIIF(IsKBRdSite,"disabled","") %> /> <label for="Tn_paymethod4"><strong>휴대폰 결제</strong></label></span>

											<% if (G_PG_NAVERPAY_ENABLE) then %>
											<span class="naver" id="tabNPay"><input name="Tn_paymethod" type="radio" class="radio" id="Tn_paymethod8" value="900" OnClick="CheckPayMethod(this);" /> <label for="Tn_paymethod8"><strong>네이버페이</strong></label></span>
											<% end if %>

											<% if (G_PG_SAMSUNGPAY_ENABLE) then %>
												<span class="samsung" id="tabSamsung"><input name="Tn_paymethod" type="radio" class="radio" id="payMethod12" value="130" OnClick="CheckPayMethod(this);" /> <label for="payMethod12">삼성페이</label></span>
											<% End If %>

											<% if (G_PG_PAYCO_ENABLE) then %>
											<span class="payco" id="tabPayco"><input name="Tn_paymethod" type="radio" class="radio" id="Tn_paymethod9" value="950" OnClick="CheckPayMethod(this);" /> <label for="Tn_paymethod9"><strong>PAYCO 간편결제</strong></label></span>
											<% end if %>

											<% if (G_PG_TOSS_ENABLE) then %>
												<span class="toss" id="tabToss"><input name="Tn_paymethod" type="radio" class="radio" id="payMethod10" value="980" OnClick="CheckPayMethod(this);" /> <label for="payMethod10">토스 간편결제</label></span>
											<% End If %>

											<% if (G_PG_CHAIPAYNEW_ENABLE) then %>
												<span class="chai" id="tabChai"><input name="Tn_paymethod" type="radio" class="radio" id="payMethod11" value="990" OnClick="CheckPayMethod(this);" /> <label for="payMethod11">CHAI</label></span>
											<% End If %>

											<% if (IsOKCASHBAGRdSite) then %>
											<span id="tabCashbag"><input name="Tn_paymethod" type="radio" class="radio" id="Tn_paymethod6" value="110" OnClick="CheckPayMethod(this);" /> <label for="Tn_paymethod6"><strong>신용카드+OK캐쉬백</strong></label> <span class="addInfo lMar10"><em class="lPad0" onClick="popOkcashbagPW();">비밀번호 설정 안내</em></span></span>
											<% end if %>
										<% End If %>
									</div>
									<!-- //pay-method-tab-->

                                    <%
                                    '카드할인 배너 정보 가져오기 (2021.12.06 정태훈)
                                    'cardCode	cardGroupName	cardName
                                    '40	            간편결제	kakaopay
                                    '41	            간편결제	Npay
                                    '42	            간편결제	PAYCO
                                    '43	            간편결제	toss
                                    '44	            간편결제	CHAi
                                    '나머지 카드 결제 통합 배너
                                    dim oCardDisInfo, cardCode, salePrice, bannerTitle
                                    set oCardDisInfo = new CCardDiscount
                                    oCardDisInfo.CardDiscountInfo
                                    cardCode = oCardDisInfo.FOneItem.FcardCode
                                    salePrice = oCardDisInfo.FOneItem.FsalePrice
                                    bannerTitle = replace(oCardDisInfo.FOneItem.FbannerTitle,"<br>"," ")
                                    set oCardDisInfo = nothing
                                    %>

									<% If cardCode=41 and salePrice>0 Then %>
									<div class="bnr-naver"><%=bannerTitle%></div>
									<script>
									$(function(){
										//Positioning
										$("#tabNPay").insertBefore("#tabCard");
										$("#Tn_paymethod8").prop("checked",true);
										
										//Description
										$("#paymethod_desc1_100").css("display","none");
										$("#paymethod_desc1_900").css("display","table-row-group");

										//Banner
										$("input[name=Tn_paymethod]").on("click",function(){
											if($(this).val()=="900") {
												$(".bnr-naver").fadeIn();
											} else {
												$(".bnr-naver").fadeOut("fast");
											}
										});
									});
									</script>
									<% elseIf cardCode=42 and salePrice>0 Then %>
									<div class="bnr-payco"><%=bannerTitle%></div>
									<script>
									$(function(){
										//Positioning
										$("#tabPayco").insertBefore("#tabCard");
										$("#Tn_paymethod9").prop("checked",true);
										
										//Description
										$("#paymethod_desc1_100").css("display","none");
										$("#paymethod_desc1_950").css("display","table-row-group");

										//Banner
										$("input[name=Tn_paymethod]").on("click",function(){
											if($(this).val()=="950") {
												$(".bnr-payco").fadeIn();
											} else {
												$(".bnr-payco").fadeOut("fast");
											}
										});
									});
									</script>
									<% elseIf cardCode=43 and salePrice>0 Then %>
									<div class="bnr-toss"><%=bannerTitle%></div>
									<script>
									$(function(){
										//Positioning
										$("#tabToss").insertBefore("#tabCard");
										$("#payMethod10").prop("checked",true);
										
										//Description
										$("#paymethod_desc1_100").css("display","none");
										$("#paymethod_desc1_980").css("display","table-row-group");

										//Banner
										$("input[name=Tn_paymethod]").on("click",function(){
											if($(this).val()=="980") {
												$(".bnr-toss").fadeIn();
											} else {
												$(".bnr-toss").fadeOut("fast");
											}
										});
									});
									</script>
									<% elseIf cardCode=44 and salePrice>0 Then %>
									<div class="bnr-chai"><%=bannerTitle%></div>
									<script>
									$(function(){
										//Positioning
										$("#tabChai").insertBefore("#tabCard");
										$("#payMethod11").prop("checked",true);
										
										//Description
										$("#paymethod_desc1_100").css("display","none");
										$("#paymethod_desc1_990").css("display","table-row-group");

										//Banner
										$("input[name=Tn_paymethod]").on("click",function(){
											if($(this).val()=="990") {
												$(".bnr-chai").fadeIn();
											} else {
												$(".bnr-chai").fadeOut("fast");
											}
										});
									});
									</script>
									<% elseIf cardCode<>40 and salePrice>0 Then %>
									<div class="bnr-pay"><%=bannerTitle%></div>
									<script>
									$(function(){
										$("input[name=Tn_paymethod]").on("click",function(){
											if($(this).val()=="100") {
												$(".bnr-pay").fadeIn();
											} else {
												$(".bnr-pay").fadeOut("fast");
											}
										});
									});
									</script>
									<% End If %>



								</td>
							</tr>
							</thead>
							<tbody id="paymethod_desc1_100" name="paymethod_desc1_100" style="display:table-row-group;">
							<!-- 신용카드 선택의 경우 -->
							<tr>
								<td colspan="3" class="vTop">
									<p class="tPad10">신용카드 결제 시 화면 아래 '결제하기'버튼을 클릭하시면 신용카드 결제 창이 나타납니다. <br>신용카드 결제 창을 통해 입력되는 고객님의 카드 정보는 128bit로 안전하게 암호화되어 전송되며, 승인 처리 후 카드 정보는 승인 성공 / 실패 여부에 상관없이 자동으로 폐기되므로, 안전합니다. <br>신용카드 결제 신청 시 승인 진행에 다소 시간이 소요될 수 있으므로 '중지', '새로고침'을 누르지 마시고 결과 화면이 나타 날때까지 기다려 주십시오.</p>
									<dl class="note01 tPad25">
										<dt><strong class="fs13">유의사항</strong></dt>
										<dd>
											<ul class="list01">
												<li>신용카드/ 실시간 이체는 결제 후, 무통장입금은 입금확인 후 배송이 이루어집니다.</li>
												<li>국내 모든 카드 사용이 가능하며 해외에서 발행된 카드는 해외카드 3D 인증을 통해 사용 가능합니다.</li>
												<li>금요일 오후 6시 ~ 일요일 주문은 결제완료 후 취소 요청 시, <span class="crRed">마이텐바이텐 &gt; 주문취소</span>를 이용하시면 됩니다.<br />(상품출고는 토요일에도 정상적으로 이루어집니다.)</li>
											</ul>
										</dd>
									</dl>

									<p class="tPad20"><span class="addInfo"><em class="lPad0" onClick="popansim('01');">공인인증서 안내</em></span></p>
									<p class="tPad10"><span class="addInfo"><em class="lPad0" onClick="popansim('02');">안심클릭 안내</em></span></p>
									<p class="tPad10"><span class="addInfo"><em class="lPad0" onClick="popansim('03');">안전결제(ISP) 안내</em></span></p>
								</td>
								<!--td class="lBdr1 vTop" width="32%">
									<!-- #include virtual="/chtml/inipay/inc_installment.asp" -->
								</td-->
							</tr>
							<!-- //신용카드 선택의 경우 -->
							</tbody>
							<!-- 실시간 계좌이체 선택의 경우 -->
							<tbody id="paymethod_desc1_20" name="paymethod_desc1_20" style="display:none">
							<tr>
								<td colspan="2">
									<p class="tPad10 bPad10">실시간 이체 결제 시 화면 아래 '결제하기'버튼을 클릭하시면 실시간 이체 결제 창이 나타납니다. 실시간 이체 결제 창을 통해 입력되는 고객님의 정보는 128bit로 안전하게 암호화되어 전송되며 승인 처리 후 정보는 승인 성공/ 실패 여부에 상관없이 자동으로 폐기되므로, 안전합니다. 실시간 이체 결제 신청 시 승인 진행에 다소 시간이 소요될 수 있으므로 '중지', '새로고침'을 누르지 마시고 결과 화면이 나타날 때까지 기다려 주십시오.</p>
								</td>
								<td rowspan="3" class="lBdr1 vTop">
									<dl class="note01 tPad10">
										<dt><strong class="fs11">실시간 계좌이체 안내</strong></dt>
										<dd>
											<ul class="list01">
												<li>실시간 계좌 이체 서비스는 은행계좌만 있으면 누구나 이용하실 수 있는 서비스로, 별도의 신청 없이 그 대금을 자신의 거래은행의 계좌로부터 바로 지불하는 서비스입니다.</li>
												<li class="tMar05">결제 시 공인인증서가 반드시 필요합니다.</li>
												<li class="tMar05">결제 후 1시간 이내에 확인되며, 입금 확인 후 배송이 이루어 집니다.</li>
												<li class="tMar05">은행 이용가능 서비스 시간은 은행사정에 따라 다소 변동될 수 있습니다.</li>
												<li class="tMar05">텐바이텐은 전자보증 서비스에 가입되어있습니다. 현금거래에 대해 전자보증 서비스를 받으시려면 [무통장 입금(가상계좌)] 결제방식을 선택하시기 바랍니다.</li>
											</ul>
										</dd>
									</dl>
								</td>
							</tr>
							<tr>
								<th width="12%" rowspan="2" class="vTop tPad15">
									<p>현금 영수증</p>
									<p class="fn tPad05"><input name="cashreceiptreq2" value="Y" type="checkbox" class="check" id="cashreceiptreq2" onclick="showCashReceptDetail(this);" /> <label for="cashreceiptreq2">발급요청</label></p>
								</th>
								<td >
									<span><input name="useopt2" value="0" type="radio" class="radio" id="deduction01" disabled  /> <label for="deduction01" >소득 공제용</label></span>
									<span class="lPad20"><input name="useopt2" value="1" type="radio" class="radio" id="proof01" disabled /> <label for="proof01">지출 증빙용</label></span>
								</td>
							</tr>
							<tr>
								<td>
									<dl>
										<dt><strong class="cr666"><label for="proofNo01">휴대폰번호 / 현금영수증카드 / 사업자번호</label></strong></dt>
										<dd class="tPad05">
											<input name="cashReceipt_ssn2" type="text" class="txtInp" style="width:120px;background-color:#EEEEEE;" id="proofNo01"  maxlength="18" disabled /> ("-"를 뺀 숫자만 입력하세요)
										</dd>
										<dd class="tPad10">
										- 사업자, 현금영수증카드, 휴대폰번호가 유효하지 않으면 발급되지 않습니다.<br />
										<% if (now()>"2016-07-01") then %>
										- 2016년 7월부터 10만원 이상 무통장 거래건에 대해, 출고후 2일내에 발급하지 않으시면 출고 3일후 자진 발급 합니다. 
										국세청 홈텍스 사이트에서 현금영수증 자진발급분 소비자 등록 메뉴로 수정 가능합니다.
										<% end if %>
										</dd>
									</dl>
								</td>
							</tr>
							</tbody>
							<!-- //실시간 계좌이체 선택의 경우 -->
							<tbody id="paymethod_desc1_7" name="paymethod_desc1_7" style="display:none">
							<!-- 무통장 입금 선택의 경우 -->
							<input type="hidden" name="isCyberAcct" value="<%= CHKIIF(IsCyberAccountEnable,"Y","") %>">
							<input type="hidden" name="CST_PLATFORM" value="<%= CHKIIF(application("Svr_Info")= "Dev","test","") %>">
							<tr>
								<% if ( IsCyberAccountEnable) then %>
								<th>입금하실 은행</th>
								<td>
									<p>
										<select name='acctno' class="select" title="입금 은행 선택">
											<option value="">입금하실 은행을 선택하세요.</option>
											<option value="11">농협</option>
											<option value="06">국민은행</option>
											<option value="20">우리은행</option>
											<option value="26">신한은행</option>
											<option value="81">하나은행</option>
											<option value="03">기업은행</option>
											<!-- option value="05">외환은행 : 사용불가</option -->
											<option value="39">경남은행</option>
											<option value="32">부산은행</option>
											<!-- option value="31">대구은행</option -->
											<option value="71">우체국</option>
											<option value="07">수협</option>
										</select>
										<span class="lPad10">예금주 : (주)텐바이텐</span>
									</p>
									<p class="tPad10">입금하실 은행만 선택하시면 해당주문에 대한 전용 계좌번호는 다음단계인 [주문 완료] 페이지에서 확인하실 수 있으며 SMS 문자로도 안내해 드립니다.  타은행에서 입금하실 때 "송금수수료"가 부과됩니다.</p>
								</td>
								<td rowspan="5" class="lBdr1 vTop">
									<dl class="note01 tPad10">
										<dt><strong class="fs11">가상계좌 안내</strong></dt>
										<dd>
											<ul class="list01">
												<li>무통장 입금 시 사용되는 가상계좌는 매 주문 시마다 새로운 계좌번호(개인전용)가 부여되며 해당 주문에만 유효합니다.</li>
												<li class="tMar05">무통장 입금은 입금 후 1시간 이내에 확인되며, 입금 확인시 배송이 이루어 집니다.</li>
												<%' 무통장 입금 입금 기한 변경 10일->3일%>
												<% If now() >= #2021-11-24 10:00:00# Then %>
													<li class="tMar05">무통장 주문 후 3일 이내에 입금이 되지 않으면 주문은 자동으로 취소됩니다. 한정 상품 주문 시 유의하여 주시기 바랍니다.</li>
												<% Else %>
													<li class="tMar05">무통장 주문 후 7일 이내에 입금이 되지 않으면 주문은 자동으로 취소됩니다. 한정 상품 주문 시 유의하여 주시기 바랍니다.</li>
												<% End If %>
												<li class="tMar05">계좌번호는 주문완료 페이지에서 확인 가능하며, SMS로도 안내 드립니다.</li>
												<li class="tMar05">현금거래에 대해 전자보증 서비스를 받으실수 있습니다. (전자보증보험 발급요청을 체크)</li>
												<li class="tMar05"><strong>무통장 입금(가상계좌)은 국내 계좌를 이용한 송금만 가능합니다. 해외 계좌 송금은 지원하지 않습니다.</strong></li>
											</ul>
										</dd>
									</dl>
								</td>
								<% else %>
								<th>입금하실 은행</th>
								<td>
									<p>
									<% Call DrawTenBankAccount("acctno","") %>
									<span class="lPad10">예금주 : (주)텐바이텐</span>
									</p>
									<p class="tPad10">타은행에서 입금하실 때 "송금수수료"가 부과됩니다.</p>
								</td>
								<td rowspan="5" class="lBdr1 vTop">
									<dl class="note01 tPad10">
										<dt><strong class="fs11">가상계좌 안내</strong></dt>
										<dd>
											<ul class="list01">
												<li class="tMar05">무통장 입금은 입금 후 1일 이내에 확인되며, 입금 확인시 배송이 이루어 집니다.</li>
												<%' 무통장 입금 입금 기한 변경 10일->3일%>
												<% If now() >= #2021-11-24 10:00:00# Then %>
													<li class="tMar05">무통장 주문 후 3일 이내에 입금이 되지 않으면 주문은 자동으로 취소됩니다. 한정 상품 주문 시 유의하여 주시기 바랍니다.</li>
												<% Else %>
													<li class="tMar05">무통장 주문 후 7일 이내에 입금이 되지 않으면 주문은 자동으로 취소됩니다. 한정 상품 주문 시 유의하여 주시기 바랍니다.</li>
												<% End If %>
												<li class="tMar05">계좌번호는 주문완료 페이지에서 확인 가능하며, SMS로도 안내 드립니다.</li>
												<li class="tMar05">현금거래에 대해 전자보증 서비스를 받으실수 있습니다. (전자보증보험 발급요청을 체크)</li>
											</ul>
										</dd>
									</dl>
								</td>
								<% end if %>
							</tr>
							<tr>
								<th><label for="depositName">입금자 명</label></th>
								<td>
									<input name="acctname" type="text" maxlength="12" class="txtInp" style="width:200px;" value="" id="depositName" />
									<% if (Not IsCyberAccountEnable) then %>
									<p class="tPad05">입금자가 부정확하면 입금확인이 안되어 이루어지지 않습니다.<br />변경이 되었을 경우에는 고객센터로 연락을 부탁드립니다.</p>
									<% end if %>
								</td>
							</tr>
							<tr>
								<th rowspan="2" class="vTop tPad15">
									<p>현금 영수증</p>
									<p class="fn tPad05"><input name="cashreceiptreq" value="Y" onclick="showCashReceptDetail(this);" type="checkbox" class="check" id="cashreceiptreq" /> <label for="cashreceiptreq">발급요청</label></p>
								</th>
								<td>
									<span><input name="useopt" value="0" type="radio" class="radio" id="deduction02" disabled /> <label for="deduction02">소득 공제용</label></span>
									<span class="lPad20"><input name="useopt" value="1" type="radio" class="radio" id="proof02" disabled /> <label for="proof02">지출 증빙용</label></span>
								</td>
							</tr>
							<tr >
								<td>
									<dl >
										<dt><strong class="cr666"><label for="proofNo02">휴대폰번호 / 현금영수증카드 / 사업자번호</label></strong></dt>
										<dd class="tPad05">
											<input name="cashReceipt_ssn" maxlength="18" type="text" class="txtInp" style="width:120px;background-color:#EEEEEE;" id="proofNo02" disabled /> ("-"를 뺀 숫자만 입력하세요)
										</dd>
										<dd class="tPad10">
										- 사업자, 현금영수증카드, 휴대폰번호가 유효하지 않으면 발급되지 않습니다.<br />
										<% if (now()>"2016-07-01") then %>
										- 2016년 7월부터 10만원 이상 무통장 거래건에 대해, 출고후 2일내에 발급하지 않으시면 출고 3일후 자진 발급 합니다. 
										국세청 홈텍스 사이트에서 현금영수증 자진발급분 소비자 등록 메뉴로 수정 가능합니다.
										<% end if %>
										</dd>
									</dl>
								</td>
							</tr>
							<%
							'// 5만원 이상 결제 시 전자보증보험 증서 발행 (추가, 2006-06-14; 운영관리팀 허진원)
							'// 5만원 이상-> 모든 결제시 (추가 2013-11-28; 금액 바뀜 시스템팀 허진원)
							if (subtotalPrice>=0) then
							%>
							<tr>
								<th class="vTop tPad15">
									<p>전자보증보험</p>
									<p class="fn tPad05"><input name="reqInsureChk" id="reqInsureChk" value="Y" onclick="showInsureDetail(this);" type="checkbox" class="check" /> <label for="reqInsureChk">발급요청</label></p>
								</th>
								<td>
									<p class="tPad05">
										<strong>안전한 쇼핑 거래를 위해 쇼핑몰 보증보험 서비스를 운영하고 있습니다.</strong>
										<span class="addInfo"><em onClick="usafe('2118700620')">서비스 가입사실 확인하기</em></span>
									</p>
									<div id="insure_detail"  style="display:none;">
										<p class="tPad10">
											<strong>전자보증보험 안내</strong><br />
											"전자상거래 등에서의 소비자보호에 관한 법률" 에 근거한 전자보증서비스는 서울보증보험㈜이 인터넷 쇼핑몰에서의 상품주문(결제) 시점에 소비자에게 보험증서를 발급하여 인터넷 쇼핑몰 사고로 인한 소비자의 금전적 피해를 100% 보상하는 서비스입니다.<br />
											- 보상대상 : 상품 미배송, 환불거부(환불사유시), 반품거부(반품사유시), 쇼핑몰부도<br />
											- 보험기간 : 주문일로부터 37일간(37일 보증)
										</p>

										<div class="box3 pad15 tMar10" style="width:85%;">
											<dl class="dfn01">
												<dt>주문고객 생년월일</dt>
												<dd style="padding:5px 0 4px 40px;">
													<input name="insureBdYYYY" type="text" maxlength="4" class="txtInp" style="width:40px;" title="생년월일의 년도를 입력하세요"> 년
													<select  name="insureBdMM" class="select offInput lMar10" title="생년월일의 월을 선택하세요">
														<option value="">선택</option>
														<option value="01">1</option>
														<option value="02">2</option>
														<option value="03">3</option>
														<option value="04">4</option>
														<option value="05">5</option>
														<option value="06">6</option>
														<option value="07">7</option>
														<option value="08">8</option>
														<option value="09">9</option>
														<option value="10">10</option>
														<option value="11">11</option>
														<option value="12">12</option>
													</select> 월
													<select name="insureBdDD" class="select offInput lMar10" title="생년월일의 날짜를 선택하세요">
														<option value="">선택</option>
														<option value="01">1</option><option value="02">2</option><option value="03">3</option><option value="04">4</option><option value="05">5</option><option value="06">6</option><option value="07">7</option><option value="08">8</option><option value="09">9</option><option value="10">10</option>
														<option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option><option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option>
														<option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option><option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option>
														<option value="31">31</option>
													</select> 일
												</dd>
											</dl>
											<dl class="dfn01">
												<dt>성별</dt>
												<dd>
													<span><input name="insureSex" value="1" type="radio" class="radio" id="male" /> <label for="male">남</label></span>
													<span><input name="insureSex" value="2" type="radio" class="radio" id="female" /> <label for="female">여</label></span>
												</dd>
											</dl>
											<dl class="dfn01">
												<dt>개인정보 이용동의</dt>
												<dd>
													<span><input name="agreeInsure" value="Y" checked type="radio" class="radio" id="agree" /> <label for="agree">동의함</label></span>
													<span><input name="agreeInsure" value="N"  type="radio" class="radio" id="agreeNo" /> <label for="agreeNo">동의안함</label></span>
												</dd>
											</dl>
											<dl class="dfn01">
												<dt>이메일 수신동의</dt>
												<dd>
													<span><input name="agreeEmail" value="Y" checked type="radio" class="radio" id="emailReception" /> <label for="emailReception">수신</label></span>
													<span><input name="agreeEmail" value="N" type="radio" class="radio" id="emailReceptionNo" /> <label for="emailReceptionNo">수신안함</label></span>
												</dd>
											</dl>
											<dl class="dfn01">
												<dt>SMS 수신동의</dt>
												<dd>
													<span><input name="agreeSms" value="Y" checked type="radio" class="radio" id="smsReception" /> <label for="smsReception">수신</label></span>
													<span><input name="agreeSms" value="N" type="radio" class="radio" id="smsReceptionNo" /> <label for="smsReceptionNo">수신안함</label></span>
												</dd>
											</dl>
										</div>
										<p class="tPad10">현금결제분에 대해 당 주문건의 보증기간동안 결제금액 보장.<br />전자보증서 발급에는 별도의 수수료가 부과되지 않습니다.<br />전자보증서 발급에 필요한 최소한의 개인정보가 서울 보증보험사에 제공되며, 다른 용도로 사용되지 않습니다.</p>
									</div>
								</td>
							</tr>
							<% end if %>
							<!-- //무통장 입금 선택의 경우 -->
							</tbody>
							<tbody id="paymethod_desc1_400" name="paymethod_desc1_400" style="display:none">
							<!-- 휴대폰 결제 -->
							<tr>
								<td colspan="2">
									<ul class="list01 tMar10">
										<li class="cr666">텐바이텐에서 휴대폰으로 결제 가능한 최대 금액은 월 30만원이나, 개인별 한도금액은 통신사 및 개인 설정에 따라 다를 수 있습니다.</li>
										<li class="tMar10 cr666">휴대폰으로 결제하신 금액은 익월 휴대폰 요금에 함께 청구되며 별도의 수수료는 부과되지 않습니다.</li>
										<li class="tMar10 cr666">휴대폰 소액결제로 구매하실 경우 현금영수증이 발급되지 않습니다.</li>
										<li class="tMar10 cr666">다음의 경우에는 휴대폰 결제를 이용하실 수 없습니다.<br />
											<p class="cr999">
												- 미납/체납중인 휴대폰 요금이 있을 경우<br />
												- 이동통신사 가입기간(번호이동포함) 6개월 이하인 경우<br />
												- 외국인, 미성년자 요금제, 법인휴대폰, 선불요금제인 경우<br />
												- LGT 이용자 중 통신사로 [자동결제] 차단 신청하신 경우
											</p>
										</li>
										<li class="tMar10 cr666">휴대폰 소액결제로 결제하신 상품을 취소할 경우 결제하신 당월 말까지 가능합니다.</li>
										<li class="tMar10 cr666">휴대폰 결제로 구매하신 상품의 취소/반품은 처리완료 시점에 따라 다음과 같이 이루어집니다.<br />
											<p class="cr999">
												- 결제하신 당월에 취소/반품 처리가 완료되는 경우 휴대폰 이용요금에 부과예정이던 금액이 취소됩니다.<br />
												- 결제하신 당월이 지난 후 취소/반품처리가 완료되는 경우, 환불액이 고객님의 계좌로 현금 입금해 드립니다.
											<p>
										</li>
										<li class="tMar10 cr666">휴대폰결제관련 문의사항은 LG유플러스전자결제 고객센터 1544-7772 또는 텐바이텐 고객센터 1644-6030으로 연락주시기 바랍니다.</li>
									</ul>
								</td>
								<td class="lBdr1 vTop">
									<dl class="note01 tPad10">
										<dt><strong class="fs11">이통사별 휴대폰 결제 정책</strong></dt>
										<dd>
											<ul class="list01">
												<li><strong>KT</strong> : 한달 결제액 기준 최고 30만원까지 가능<br />이용내역 조회 : <a href="http://www.olleh.com" target="_blank" title="새창열림">http://www.olleh.com</a></li>
												<li class="tMar15"><strong>SKT</strong> : 다음 요금제에 해당되는 고객은 사용불가<br />(아이니/아이니플러스/TTL ting 요금제, 선불이동 전화고객)<br />이용내역 조회 : <a href="http://www.tworld.co.kr" target="_blank" title="새창열림">http://www.tworld.co.kr</a></li>
												<li class="tMar15"><strong>LGT</strong> : 한달 결제액 기준 최고 30만원까지 가능<br />이용내역 조회 : <a href="http://www.uplus.co.kr" target="_blank" title="새창열림">http://www.uplus.co.kr</a></li>
											</ul>
										</dd>
									</dl>
								</td>
							</tr>
							<!-- //휴대폰 결제 -->
							</tbody>
							<!-- // 네이버페이 선택 -->
							<tbody id="paymethod_desc1_900" name="paymethod_desc1_900" style="display:none">
							<tr>
								<th rowspan="2" class="vTop tPad15">
									<p>현금 영수증</p>
									<p class="fn tPad05"><input name="cashreceiptreq3" type="checkbox" class="check" id="npay01" value="Y" onclick="showCashReceptDetail(this);" /> <label for="npay01">발급요청</label></p>
								</th>
								<td>
									<span><input name="useopt3" value="0" type="radio" class="radio" id="deduction03" disabled /> <label for="deduction03">소득 공제용</label></span>
									<span class="lPad20"><input name="useopt3" value="1" type="radio" class="radio" id="proof03" disabled /> <label for="proof03">지출 증빙용</label></span>
								</td>
								<td rowspan="2" class="lBdr1 vTop">
									<dl class="note01 tPad10">
										<dt><strong class="fs11">네이버페이 안내</strong></dt>
										<dd>
											<ul class="list01">
												<li>주문 변경 시 카드사 혜택 및 할부 적용 여부는 해당 카드사 정책에 따라 변경될 수 있습니다.</li>
												<li>네이버페이는 네이버ID로 별도 앱 설치 없이 신용카드 또는 은행계좌 정보를 등록하여 네이버페이 비밀번호로 결제할 수 있는 간편결제 서비스입니다.</li>
												<li class="tMar05">결제 가능한 신용카드 : 신한, 삼성, 현대, BC, 국민, 하나, 롯데, NH농협, 씨티</li>
												<li>결제 가능한 은행 : NH농협, 국민, 신한, 우리, 기업, SC제일, 부산, 경남, 수협, 우체국</li>
												<li class="tMar05">네이버페이 카드 간편결제는 네이버페이에서 제공하는 카드사 별 무이자, 청구할인 혜택을 받을 수 있습니다.</li>
											</ul>
										</dd>
									</dl>
								</td>
							</tr>
							<tr>
								<td class="vTop tPad15">
									<dl>
										<dt><strong class="cr666"><label for="proofNo03">휴대폰번호 / 현금영수증카드 / 사업자번호</label></strong></dt>
										<dd class="tPad05">
											<input name="cashReceipt_ssn3" type="text" class="txtInp" style="width:120px;background-color:#EEEEEE;" id="proofNo03" disabled /> ("-"를 뺀 숫자만 입력하세요)
										</dd>
										<dd class="tPad10">
											- 사업자, 현금영수증카드, 휴대폰번호가 유효하지 않으면 발급되지 않습니다.<br />
											- 2016년 7월부터 10만원 이상 무통장 거래건에 대해, 출고후 2일내에 발급하지 않으시면 출고 3일후 자진 발급 합니다.<br />
											&nbsp; 국세청 홈텍스 사이트에서 현금영수증 자진발급분 소비자 등록 메뉴로 수정 가능합니다.
										</dd>
									</dl>
								</td>
							</tr>
							<!-- //네이버페이 선택 -->
							</tbody>
							<tbody id="paymethod_desc1_950" name="paymethod_desc1_950" style="display:none">
							<!-- // PAYCO간편결제 선택 -->
							<tr>
								<td colspan="3" class="vTop">
									<dl class="note01 tPad10">
										<dt><strong class="fs11">PAYCO 간편결제 안내</strong></dt>
										<dd>
											<ul class="list01">
												<li>PAYCO는 온/오프라인 쇼핑은 물론 송금, 멤버십 적립까지 가능한 통합 서비스입니다.</li>
												<li class="tMar10">휴대폰과 카드 명의자가 동일해야 결제 가능하며, 결제금액 제한은 없습니다.</li>
												<li class="tMar10">지원카드<br />
													<p class="cr999">
														- 모든 국내 신용/체크카드
													<p>
												</li>
											</ul>
										</dd>
									</dl>
								</td>
							</tr>
							</tbody>
							<tbody id="paymethod_desc1_980" name="paymethod_desc1_980" style="display:none">
							<!-- // TOSS간편결제 선택 -->
							<tr>
								<td colspan="3" class="vTop">
									<dl class="note01 tPad10">
										<dt><strong class="fs11">토스 간편결제 안내</strong></dt>
										<dd>
											<ul class="list01">
												<li>토스의 간편함이 텐바이텐으로 이어집니다. 계좌 및 카드 등록 후 비밀번호 하나로 간편하게 결제하세요!</li>
												<li class="tMar05">카드사별 무이자 할부, 청구할인 혜택은 토스 내 혜택 안내를 통해 확인하실 수 있습니다.</li>
												<li class="tMar05">토스 결제 문의, 토스 고객센터 1599-4905</li>
											</ul>
										</dd>
									</dl>
								</td>
							</tr>
							</tbody>
							<tbody id="paymethod_desc1_990" name="paymethod_desc1_990" style="display:none">
							<!-- // CHAI 선택 -->
							<tr>
								<td colspan="3" class="vTop">
									<dl class="note01 tPad10">
										<dt><strong class="fs11">CHAI 간편결제 안내</strong></dt>
										<dd>
											<ul class="list01">
												<li>차이는 은행 계좌만 등록하면 간편하게 결제할 수 있는 결제 서비스 입니다.</li>
												<li class="tMar05">은행 점검시간인 23:30~00:30까지는 이용이 불가 합니다.</li>
												<li class="tMar05">차이 결제 문의, 차이 고객센터 1544-7839</li>
											</ul>
										</dd>
									</dl>
								</td>
							</tr>
							</tbody>
							<tbody id="paymethod_desc1_130" name="paymethod_desc1_130"style="display:none;">
							<!-- //삼성페이 선택 -->
							<tr>
								<td colspan="3" class="vTop">
									<dl class="note01 tPad10 samsung">
										<dt><strong class="fs11">삼성페이 간편결제 안내</strong></dt>
										<dd>
											<ul class="list01">
												<li>카드사별 무이자 할부, 청구할인 혜택은 삼성페이 내 혜택 안내를 통해 확인하실 수 있습니다.</li>
												<li class="tMar10">삼성페이 결제 문의, 삼성페이 고객센터 1588-7456</li>
											</ul>
										</dd>
									</dl>
								</td>
							</tr>
							</tbody>
							<tbody id="paymethod_desc1_190" name="paymethod_desc1_190" style="display:none">
							<!-- 하나10x10 선택 -->
							<tr >
								<td colspan="3" class="vTop">
									<p class="tPad10">
									    텐바이텐 체크카드 결제 시<br><br>
									    
									    - 결제금액 기준 5% 할인 혜택이 제공됩니다.<br>
									    - 텐바이텐 비바G 하나 체크카드에 적용되는 혜택으로 일반 하나카드는 '신용카드' 메뉴에서 결제 진행하시기 바랍니다.<br>
									    - 배송비만 결제되는 경우에는 추가 할인이 적용되지 않습니다.
									</p>
									<!--<dl class="note01 tPad25">
										<dt><strong class="fs11">[텐바이텐 하나 체크카드 출시]</strong></dt>
										<dd>
											<ul class="list01">
												<li>텐바이텐 구매상품 5% 할인과 국내 5대 업종 0.5%, 해외 이용 1.5% 캐시백 까지!</li>
												<li>하나은행과 함께하는 이벤트도 확인해 보세요.</li>
												<li><a target=_blank href="/event/eventmain.asp?eventid=85155" style="text-decoration: underline;">텐바이텐 비바G 하나 체크카드 발급안내&gt</a></li>
											</ul>
										</dd>
									</dl>-->

									<p class="tPad20"><span class="addInfo"><em class="lPad0" onClick="popansim('01');">공인인증서 안내</em></span></p>
									<p class="tPad10"><span class="addInfo"><em class="lPad0" onClick="popansim('02');">안심클릭 안내</em></span></p>
									<p class="tPad10"><span class="addInfo"><em class="lPad0" onClick="popansim('03');">안전결제(ISP) 안내</em></span></p>
									
								</td>
							</tr>
							</tbody>
						</table>
					</div>
<% end if %>
				<%
					dim rebankname, rebankownername, encaccount
					if userid<>"" then
						fnSoldOutMyRefundInfo userid, rebankname, rebankownername, encaccount
					end if
				%>
				<% If Trim(userid)="" Then %>
					<script>
						$(function(){
							$("input[type='checkbox']:not('#agreeAll')").click(function(){
								if($(this).attr("id")=="policyY"){
									$("#agreeAll,#agreechk01,#agreechk02").attr("checked",$(this).is(":checked"));
								} else {
									$("#policyY").attr("checked",$("#agreeAll").is(":checked")&&$("#agreechk01").is(":checked")&&$("#agreechk02").is(":checked"));
								}
							});
							$("input[type='checkbox']:not('#agreechk01')").click(function(){
								if($(this).attr("id")=="policyY"){
									$("#agreeAll,#agreechk01,#agreechk02").attr("checked",$(this).is(":checked"));
								} else {
									$("#policyY").attr("checked",$("#agreeAll").is(":checked")&&$("#agreechk01").is(":checked")&&$("#agreechk02").is(":checked"));
								}
							});
							$("input[type='checkbox']:not('#agreechk02')").click(function(){
								if($(this).attr("id")=="policyY"){
									$("#agreeAll,#agreechk01,#agreechk02").attr("checked",$(this).is(":checked"));
								} else {
									$("#policyY").attr("checked",$("#agreeAll").is(":checked")&&$("#agreechk01").is(":checked")&&$("#agreechk02").is(":checked"));
								}
							});
						});
					</script>
					<!-- 20210205 제3자 정보제공동의 -->
					<hr class="lineBar">
					<div class="orderNotiV21 tMar30">
						<p class="txtArrow">품절 발생 시 별도의 연락을 하지 않고 선택하신 결제 방법으로 안전하게 환불해 드립니다.</p>
						<table class="orderForm tMar15" id="refundInfo1" style="display:none;">
							<caption>품절 시 처리 방법</caption>
							<colgroup>
								<col style="width:12%" />
								<col style="width:16%;" />
								<col style="width:32%;" />
								<col style="width:auto;" />
							</colgroup>
							<tbody>
								<tr>
									<th>환불 계좌 정보</th>
									<td class="pad0">
										<div class="pad15">
											<select class="select" name="rebankname" id="rebankname" title="입금하실 은행을 선택하세요." style="width:120px;">
												<option value="">은행선택</option>
												<option value="경남">경남</option>
												<option value="광주">광주</option>
												<option value="국민">국민</option>
												<option value="기업">기업</option>
												<option value="농협">농협</option>
												<option value="단위농협">단위농협</option>
												<option value="대구">대구</option>
												<option value="도이치">도이치</option>
												<option value="부산">부산</option>
												<option value="산업">산업</option>
												<option value="새마을금고">새마을금고</option>
												<option value="수협">수협</option>
												<option value="신한">신한</option>
												<option value="KEB하나">KEB하나</option>
												<option value="우리">우리</option>
												<option value="우체국">우체국</option>
												<option value="전북">전북</option>
												<option value="제일">제일</option>
												<option value="시티">시티</option>
												<option value="홍콩샹하이">홍콩샹하이</option>
												<option value="ABN암로은행">ABN암로은행</option>
												<option value="UFJ은행">UFJ은행</option>
												<option value="신협">신협</option>
												<option value="제주">제주</option>
												<option value="현대스위스상호저축은행">현대스위스상호저축은행</option>
												<option value="케이뱅크">케이뱅크</option>
												<option value="카카오뱅크">카카오뱅크</option>
												<option value="토스뱅크">토스뱅크</option>
											</select>
										</div>
									</td>
									<td class="pad0">
										<div class="pad15">
											<label for="" class="bulletDot cr666">계좌번호</label>
											<input type="text" name="encaccount" class="txtInp" style="width:220px;" placeholder="-를 제외하고 입력하시기 바랍니다.">
										</div>
									</td>
									<td class="pad0">
										<div class="pad15">
											<label for="" class="bulletDot cr666">예금주</label>
											<input type="text" name="rebankownername" class="txtInp" style="width:100px;">
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="pad0">
										<p class="tPad10 cr888">- 주문 취소일 기준, 3-5일(주말 제외) 후 환불 금액이 입금됩니다.</p>
									</td>
								</tr>
							</tbody>
						</table>
						<!-- ISMS 수정 2021.10.20 -->
						<div class="agree">
							<p class="all"><input type="checkbox" id="policyY"><label for="policyY">모두 동의합니다</label></p>
							<div class="agree_chk">
								<div class="tMar30"><input type="checkbox" id="agreeAll"><label for="agreeAll">모든 내용을 확인하였으며 구매조건에 동의합니다.</label></div>
								<p class="tMar15">
									<input type="checkbox" id="agreechk01" value="o">
									<label for="agreechk01">주문 진행을 위해 관련된 개인정보를 수집합니다.
									<a href="" class="btnMore" onClick="window.open('/inipay/popDetailCollect.asp', '', 'width=500, height=580, scrollbars=auto,resizable=yes'); return false;">수집 내용 자세히보기</a></label>
								</p>
								<p class="tMar15">
									<input type="checkbox" id="agreechk02" value="o">
									<label for="agreechk02">주문 진행을 위해 다음의 판매자(제3자)에게 개인정보를 제공합니다.
									<a href="" class="btnMore" onClick="window.open('/inipay/popDetailProvide.asp', '', 'width=500, height=580, scrollbars=auto,resizable=yes'); return false;">제공 내용 자세히보기</a></label>
									<small class="first"><%=brandEnNames%></small>
								</p>
							</div>
						</div>
					</div>
					<!-- ISMS 수정 2021.10.20 -->
				<% else %>
					<!-- 20210205 제3자 정보제공동의 -->
					<hr class="lineBar">
					<div class="orderNotiV21 tMar30">
						<p class="txtArrow">품절 발생 시 별도의 연락을 하지 않고 선택하신 결제 방법으로 안전하게 환불해 드립니다.</p>
						<!-- for dev msg : 무통장 시 환불계좌 입력 노출 -->
						<table class="orderForm tMar15" id="refundInfo1" style="display:none;">
							<caption>품절 시 처리 방법</caption>
							<colgroup>
								<col style="width:12%" />
								<col style="width:16%;" />
								<col style="width:32%;" />
								<col style="width:auto;" />
							</colgroup>
							<tbody>

								<tr>
									<th>환불 계좌 정보</th>
									<td class="pad0">
										<div class="pad15">
											<select class="select" name="rebankname" id="rebankname" title="입금하실 은행을 선택하세요." style="width:120px;">
												<option value="">은행선택</option>
												<option value="경남" <% if rebankname="경남" then response.write "selected" %>>경남</option>
												<option value="광주" <% if rebankname="광주" then response.write "selected" %>>광주</option>
												<option value="국민" <% if rebankname="국민" then response.write "selected" %>>국민</option>
												<option value="기업" <% if rebankname="기업" then response.write "selected" %>>기업</option>
												<option value="농협" <% if rebankname="농협" then response.write "selected" %>>농협</option>
												<option value="단위농협" <% if rebankname="단위농협" then response.write "selected" %>>단위농협</option>
												<option value="대구" <% if rebankname="대구" then response.write "selected" %>>대구</option>
												<option value="도이치" <% if rebankname="도이치" then response.write "selected" %>>도이치</option>
												<option value="부산" <% if rebankname="부산" then response.write "selected" %>>부산</option>
												<option value="산업" <% if rebankname="산업" then response.write "selected" %>>산업</option>
												<option value="새마을금고" <% if rebankname="새마을금고" then response.write "selected" %>>새마을금고</option>
												<option value="수협" <% if rebankname="수협" then response.write "selected" %>>수협</option>
												<option value="신한" <% if rebankname="신한" then response.write "selected" %>>신한</option>
												<option value="KEB하나" <% if rebankname="KEB하나" then response.write "selected" %>>KEB하나</option>
												<option value="우리" <% if rebankname="우리" then response.write "selected" %>>우리</option>
												<option value="우체국" <% if rebankname="우체국" then response.write "selected" %>>우체국</option>
												<option value="전북" <% if rebankname="전북" then response.write "selected" %>>전북</option>
												<option value="제일" <% if rebankname="제일" then response.write "selected" %>>제일</option>
												<option value="시티" <% if rebankname="시티" then response.write "selected" %>>시티</option>
												<option value="홍콩샹하이" <% if rebankname="홍콩샹하이" then response.write "selected" %>>홍콩샹하이</option>
												<option value="ABN암로은행" <% if rebankname="ABN암로은행" then response.write "selected" %>>ABN암로은행</option>
												<option value="UFJ은행" <% if rebankname="UFJ은행" then response.write "selected" %>>UFJ은행</option>
												<option value="신협" <% if rebankname="신협" then response.write "selected" %>>신협</option>
												<option value="제주" <% if rebankname="제주" then response.write "selected" %>>제주</option>
												<option value="현대스위스상호저축은행" <% if rebankname="현대스위스상호저축은행" then response.write "selected" %>>현대스위스상호저축은행</option>
												<option value="케이뱅크" <% if rebankname="케이뱅크" then response.write "selected" %>>케이뱅크</option>
												<option value="카카오뱅크" <% if rebankname="카카오뱅크" then response.write "selected" %>>카카오뱅크</option>
												<option value="토스뱅크" <% if rebankname="토스뱅크" then response.write "selected" %>>토스뱅크</option>
											</select>
										</div>
									</td>
									<td class="pad0">
										<div class="pad15">
											<label for="" class="bulletDot cr666">계좌번호</label>
											<input type="text" name="encaccount" value="<%=encaccount%>" class="txtInp" style="width:220px;" placeholder="-를 제외하고 입력하시기 바랍니다.">
										</div>
									</td>
									<td class="pad0">
										<div class="pad15">
											<label for="" class="bulletDot cr666">예금주</label>
											<input type="text" name="rebankownername" value="<%=rebankownername%>" class="txtInp" style="width:100px;">
										</div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="pad0">
										<p class="tPad10 cr888">- 주문 취소일 기준, 3-5일(주말 제외) 후 환불 금액이 입금됩니다.</p>
									</td>
								</tr>
							</tbody>
						</table>
						<!-- //무통장 시 환불계좌 입력 노출 -->

						<p class="txtArrow tMar15">
							주문 진행을 위해 다음의 판매자(제3자)에게 개인정보를 제공합니다.
							<a href="" class="btnMore" onClick="window.open('/inipay/popDetailProvide.asp', '', 'width=500, height=580, scrollbars=auto,resizable=yes'); return false;">제공 내용 자세히보기</a>
							<small><%=brandEnNames%></small>
						</p>
						<div class="chkAgreeV21 tMar30"><label for="agreeAll"><input type="checkbox" id="agreeAll">모든 내용을 확인하였으며 구매조건에 동의합니다.</label></div>
					</div>
					<!-- //20210205 제3자 정보제공동의 -->
				<% End If %>
<%
''Check Confirm

if (oshoppingbag.IsSoldOutSangpumExists) or (TicketBookingExired) then
    if (TicketBookingExired) then
        iErrMsg = "죄송합니다. 매진된 티켓은 예매하실 수 없습니다."
    else
        iErrMsg = "죄송합니다. 품절된 상품은 구매하실 수 없습니다."
    end if
elseif oshoppingbag.Is09NnormalSangpumExists then
    iErrMsg = "단독구매 상품과 일반상품은 같이 구매하실 수 없습니다."
elseif (oshoppingbag.GetMileshopItemCount>0) and (oshoppingbag.GetTenBeasongCount<1) then
    iErrMsg = "마일리지샾 상품은 텐바이텐 배송상품과 함께 구매 하셔야 배송 가능 합니다."
elseif (availtotalMile<oshoppingbag.GetMileageShopItemPrice) then
    iErrMsg = "마일리지샾 상품을 구매하실 수 있는 마일리지가 부족합니다. 현재 마일리지 : " & FormatNumber(availtotalMile,0) & " point"
elseif (IsTicketLimitOver) then
    iErrMsg ="티켓 상품은 기주문 수량 포함 총 "& MaxTicketNo &"장 까지 구매 가능하십니다. 기 구매하신 수량 ("&PreBuyedTicketNo &") 장"
elseif (IsPresentLimitOver) then
    iErrMsg ="Present상품은 한 주문에 "& MaxPresentItemNo &"개 구매 가능하십니다."
ElseIf (vlsOnlyHanaTenPayExist And oshoppingbag.FShoppingBagItemCount>1) Then
	iErrMsg="본 상품은 이벤트 상품으로 1인 1개만 구매가 가능합니다."
end if


'####### 모바일 결제에 사용될 상품 명. 1개 이상일땐 OO와 O건 으로 입력. 모바일결제쪽 DB에 상품명 길이가 매우 짧아서 12~14로 짜름. #######
Dim vMobilePrdtnm, vMobilePrdtnm_tmp
If oshoppingbag.FShoppingBagItemCount > 1 Then
	vMobilePrdtnm = chrbyte(oshoppingbag.FItemList(0).FItemName,18,"Y") & " 외 " & oshoppingbag.FShoppingBagItemCount-1 & "건"
	vMobilePrdtnm_tmp = oshoppingbag.FItemList(0).FItemName & " 외 " & oshoppingbag.FShoppingBagItemCount-1 & "건"
Else
	vMobilePrdtnm = chrbyte(oshoppingbag.FItemList(0).FItemName,24,"Y")
	vMobilePrdtnm_tmp = oshoppingbag.FItemList(0).FItemName
End IF

vMobilePrdtnm = Replace(vMobilePrdtnm, chr(34), "")		'특수문자 "
vMobilePrdtnm = Replace(vMobilePrdtnm, chr(39), "")		' 특수문자 '
%>
					<div class="ct tPad30 bPad20" id="nextbutton1" name="nextbutton1" style="display: block;">
						<a href="<%=wwwURL%>/inipay/ShoppingBag.asp" class="btn btnB2 btnWhite2 btnW220"><em class="gryArr02">이전 페이지</em></a>
						<a href="#" name="btnPay" id="btnPay" class="lMar10 btn btnB2 btnRed btnW220" onClick="PayNext(document.frmorder,'<%= iErrMsg %>');return false;">결제하기</a>
					</div>
					<div class="ct tPad30 bPad20" id="nextbutton2" name="nextbutton2" style="display: none;">
						<a class="btn btnB2 btnGrylightNone btnW220"><em class="gryArr02" disabled >이전 페이지</em></a>
						<a class="lMar10 btn btnB2 btnGrylightNone btnW220" >결제하기</a>
					</div>
				</div>
			</div>
		</div>
	</div>




<!-- ####### 모바일용 - 에러메세지, 상품명(모바일결제에 사용됨), 모바일 결제 후 결과값 ####### //-->

<input type="hidden" name="ierrmsg" value="<%= iErrMsg %>">

<!-- 실제 모바일쪽에 저장될 상품명 - 매우 짧음. //-->
<input type="hidden" name="mobileprdtnm" value="<%=vMobilePrdtnm%>">

<!-- 실제 모바일쪽에 저장될 가격 //-->
<input type="hidden" name="mobileprdprice" value="<%=subtotalprice%>">

<!-- 실제 모바일쪽에 저장될 상품명이 너무 짧아서 temp용으로 풀 네임으로 사용 //-->
<input type="hidden" name="mobileprdtnm_tmp" value="<%=vMobilePrdtnm_tmp%>">


<input type="hidden" name="M_No" value="">
<input type="hidden" name="M_Socialno" value="">
<input type="hidden" name="M_Email" value="">
<input type="hidden" name="M_Tradeid" value="">
<input type="hidden" name="M_Remainamt" value="">
<input type="hidden" name="M_Phoneid" value="">
<input type="hidden" name="M_Commid" value="">
<input type="hidden" name="M_Emailflag" value="">
<input type="hidden" name="M_Smsval" value="">

<!-- ####### 모바일용 - 에러메세지, 상품명(모바일결제에 사용됨), 모바일 결제 후 결과값 ####### //-->
<!-- Lg Uplus -->
<input type="hidden" name="LGD_OID" value="">
<input type="hidden" name="LGD_PAYKEY" value="">
	</form>

<% if (IsKBRdSite) then %>
<script language='javascript'>
    defaultCouponSet(document.frmorder.itemcouponOrsailcoupon[2]);
    //RecalcuSubTotal(frm.kbcardsalemoney);
</script>
<% elseif (IsDefaultItemCouponChecked) and (vaildItemcouponCount>0) then %>
<script language='javascript'>
    //frmorder.itemcouponOrsailcoupon[1].checked=true;
    defaultCouponSet(document.frmorder.itemcouponOrsailcoupon[1]);
    //RecalcuSubTotal(document.frmorder.itemcouponOrsailcoupon[1]);

    CheckGift(true);
</script>
<% elseif (vaildCouponCount<1) and (vaildItemcouponCount>0) then %>
<script language='javascript'>
    //frmorder.itemcouponOrsailcoupon[1].checked=true;
    defaultCouponSet(document.frmorder.itemcouponOrsailcoupon[1]);
    //RecalcuSubTotal(document.frmorder.itemcouponOrsailcoupon[1]);

    CheckGift(true);
</script>
<% else %>
<script language='javascript'>
//2013 추가
if (document.frmorder.itemcouponOrsailcoupon[0].checked){
	defaultCouponSet(document.frmorder.itemcouponOrsailcoupon[0]);
}else if (document.frmorder.itemcouponOrsailcoupon[1].checked){
	defaultCouponSet(document.frmorder.itemcouponOrsailcoupon[1]);
}else {
	defaultCouponSet(document.frmorder.spendmileage);
}
CheckGift(true);
</script>
<% end if %>

<form name="LGD_FRM" method="post" action="" style="margin:0px;">
<input type="hidden" name="LGD_BUYER" value="">
<input type="hidden" name="LGD_PRODUCTINFO" value="">
<input type="hidden" name="LGD_AMOUNT" value="">
<input type="hidden" name="LGD_BUYEREMAIL" value="">
<input type="hidden" name="LGD_BUYERPHONE" value="">
<input type="hidden" name="isAx" value="">
</form>
<form name="pojangfrm" method="post" action="" style="margin:0px;">
<input type="hidden" name="reload">
<input type="hidden" name="bTp" value="<%= jumunDiv %>">
<input type="hidden" name="ctrCd" value="<%= countryCode %>">
</form>
<%
if (oshoppingbag.IsFixNnormalSangpumExists) then
    response.write "<script language='javascript'> ChkErrMsg = '지정일 배송상품(꽃배달)과 일반택배 상품은 같이 배송되지 않으니 양해하시기 바랍니다.';</script>"
elseif oshoppingbag.Is09NnormalSangpumExists then
    response.write "<script language='javascript'> ChkErrMsg = '단독구매 상품과 일반상품은 같이 구매하실 수 없습니다.';</script>"
elseif (oshoppingbag.GetMileshopItemCount>0) and (oshoppingbag.GetTenBeasongCount<1) then
    response.write "<script language='javascript'> ChkErrMsg = '마일리지샾 상품은 텐바이텐 배송상품과 함께 하셔야 배송 가능 합니다.';</script>"
elseif (oshoppingbag.GetMileageShopItemPrice>availtotalMile) then
    response.write "<script language='javascript'> ChkErrMsg = '사용 가능한 마일리지는 " & availtotalMile & " 입니다. - 마일리지 상품 합계가 현재 마일리지보다 많습니다.';</script>"
elseif (oshoppingbag.IsBuyOrderItemExists) then
    response.write "<script language='javascript'> ChkErrMsg = '선착순 구매상품은 무통장으로 주문 하실 수 없으니 양해해 주시기 바랍니다.';</script>"
end if

if (NotWriteRequireDetailExists) then
    response.write "<script language='javascript'>ChkErrMsg = '주문 제작 문구를 작성하지 않은 상품이 존재합니다. - 주문 제작문구를 작성해주세요.';</script>"
end if

if (IsArmyDlv) then
    response.write "<script language='javascript'>ChkErrMsg = '군부대배송 주문은 우체국택배 이용으로 구매금액과 상관없이 배송비 3,000원이 부과됩니다.';</script>"
end if

if (IsTicketLimitOver) then
    response.write "<script language='javascript'>ChkErrMsg = '티켓 상품은 기주문 수량 포함 총 "& MaxTicketNo &"장 까지 구매 가능하십니다. 기 구매하신 수량 ("&PreBuyedTicketNo &") 장';</script>"
end if
if (IsPresentLimitOver) then
    response.write "<script language='javascript'>ChkErrMsg = 'Present상품은 한 주문에 "& MaxPresentItemNo &"개 구매 가능하십니다.';</script>"
end if
%>
<% if (G_PG_100_USE_INIWEB) then %>
	<script language="javascript" type="text/javascript" src="<%=INIWEB_Jscript%>" charset="UTF-8"></script>
<% else %>
	<script language=javascript src="https://plugin.inicis.com/pay40_unissl.js"></script> <!-- non cross SSL -->
	<!-- script language=javascript src="/inipay/pay40_ssl.js"></script --> <!-- non cross -->
	<!-- script type="text/javascript" src="https://plugin.inicis.com/pay61_unissl_cross.js"></script -->
<% end if %>

<script type="text/javascript">

<% if (G_PG_100_USE_INIWEB) then %>
	//StartSmartUpdate(); //ini_web인경우 필요없음.
<% else %>
	StartSmartUpdate();
<% end if %>

function getOnload(){
    <% if (IsForeignDlv) and (countryCode<>"") and (countryCode<>"AA") then %>
    document.frmorder.emsCountry.value='<%=countryCode%>';
    emsBoxChange(document.frmorder.emsCountry);
    <% end if %>

    showCashReceptDetail(document.frmorder.cashreceiptreq3);
    showCashReceptDetail(document.frmorder.cashreceiptreq2);
    showCashReceptDetail(document.frmorder.cashreceiptreq);


    if (ChkErrMsg){
        alert(ChkErrMsg);
    }
}
window.onload = getOnload;

//alert('현재 신용카드/실시간 이체 결제에 장애가 있습니다. \ 결제시 장애가 나시는분은 잠시후 이용해주세요.\불편을 드려 죄송합니다.');


$(function() {
    $('#mask').unbind('click');

    $('#mask').click(function () {
        // do nothing;
		//$('#boxes').hide();
		//$('.window').hide();
		//$('#lyrPop').hide();
		//$('#freeForm').empty().hide();
	});
})
</script>
    <!-- #include virtual="/lib/inc/incFooter_SSL.asp" -->
</div>
<%
    ELSE
        response.write "<script>alert('정상적인 성인인증을 해주세요.');</script>"
        response.write "<script>history.back();</script>"
    END IF
%>
</body>
</html>
<%
set oUserInfo   = nothing
set oshoppingbag= nothing
set oSailCoupon = nothing
set oMileage    = nothing
set oItemCoupon = nothing
SET oems        = nothing
set oemsPrice   = nothing
set oTenCash    = nothing
set oGiftCard   = nothing
Set oOpenGift   = nothing
Set oOpenGiftDepth = nothing
Set oDiaryOpenGift = nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->