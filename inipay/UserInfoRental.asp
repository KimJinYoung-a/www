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
<%
'#######################################################
'	History	:  2020.10.20 원승현 생성
'	Description : 렌탈상품 전용 결제 정보 입력 페이지
'#######################################################

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

    Dim G_PG_NAVERPAY_ENABLE : G_PG_NAVERPAY_ENABLE = FALSE	 ''네이버페이 사용여부

    Dim G_PG_PAYCO_ENABLE : G_PG_PAYCO_ENABLE = FALSE	''페이코 사용여부

    Dim G_PG_HANATEN_ENABLE : G_PG_HANATEN_ENABLE = FALSE	''하나10x10카드 사용여부

    Dim G_PG_TOSS_ENABLE : G_PG_TOSS_ENABLE = FALSE ' 토스 사용여부

    Dim G_PG_CHAIPAYNEW_ENABLE : G_PG_CHAIPAYNEW_ENABLE = FALSE  ''차이 사용 여부
    if (GetLoginUserLevel()="7") or (GetLoginUserID="thensi7") or (GetLoginUserID="skyer9") then
        G_PG_HANATEN_ENABLE = FALSE
        G_PG_TOSS_ENABLE = FALSE
        G_PG_CHAIPAYNEW_ENABLE = FALSE
    end if

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
    dim iniRentalLength : iniRentalLength = requestcheckvar(request("irenLen"), 2) '' 사용자가 기존에 선택한 이니렌탈 렌탈 개월수
    Dim r

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

    ''201004 가상계좌 추가
    Dim IsCyberAccountEnable : IsCyberAccountEnable = FALSE      ''가상계좌 사용 여부 : False인경우 기존 무통장    

    '' 사이트 구분
    Const sitename = "10x10"
    '' 할인권 사용 가능 여부
    Const IsSailCouponDisabled = TRUE
    '' InVail 할인권 Display여부
    Const IsShowInValidCoupon =FALSE

    '' InVail 상품쿠폰 Display여부
    Const IsShowInValidItemCoupon =False

    '' 최소 마일리지 사용금액
    Const mileageEabledTotal = 30000

    '' 렌탈 상품 여부
    Const isRentalCheck = true

    '' 마일리지 사용가능여부(렌탈은 마일리지 사용 불가)
    Dim IsMileageDisabled, MileageDisabledString
    IsMileageDisabled = True

    '' 예치금 사용가능 여부(렌탈은 예치금 사용 불가)
    Dim IsTenCashEnabled
    IsTenCashEnabled = False

    ''Gift카드 사용가능여부(렌탈은 gift카드 사용 불가)
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
                'call getpojangtemptabledel("")
            'end if
        end if
    ''end if

    '' 렌탈 상품은 선물포장 서비스 사용 안됨
    G_IsPojangok = FALSE

    dim oUserInfo, chkKakao
    set oUserInfo = new CUserInfo
    oUserInfo.FRectUserID = userid
    if (userid<>"") then
        oUserInfo.GetUserData
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
        dim vEvtItemLmNo: vEvtItemLmNo=1
        if oshoppingbag.isEventOrderItemLimitOver(userid,vEvtItemLmNo) then
            Call Alert_Return("고객님께서는 이벤트 상품을 이미 주문하셨습니다.\n(한 ID당 최대 " & vEvtItemLmNo & "개까지 주문가능)")
            dbget.Close: response.End
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

    if (isRentalCheck) Then
        IsMileageDisabled = true
        MileageDisabledString = "(렌탈상품은 마일리지 사용 불가)"
    end if

    set oSailCoupon = new CCoupon
    oSailCoupon.FRectUserID = userid
    oSailCoupon.FPageSize=100

    if (userid<>"") and (Not IsKBRdSite) and (Not IsRsvSiteOrder) and (Not IsPresentOrder) and (Not isRentalCheck) then   ''현장수령/Present/렌탈 상품 쿠폰 사용 불가
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

    if (userid<>"") and (Not IsKBRdSite) and (Not IsRsvSiteOrder) and (Not IsPresentOrder) and (Not isRentalCheck) then  ''현장수령/Present/렌탈 상품 쿠폰 사용 불가
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

    ''렌탈은 예치금 사용 불가
    Dim availtotalTenCash
    availtotalTenCash = 0

    '' 렌탈은 기프트 카드 사용 불가
    Dim availTotalGiftMoney
    availTotalGiftMoney = 0

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

    Dim vIsTravelItemExist, vIsDeliveItemExist, vIsTravelIPExist, vIsTravelJAExist
    vIsDeliveItemExist = False
    vIsTravelItemExist = False
    vIsTravelIPExist = False
    vIsTravelJAExist = False
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

        '### 렌탈 상품이 있는지 체크 없으면 일반 userinfo 로 넘겨야함
        If Not(oshoppingbag.FItemList(i).Fitemdiv = "30") Then
            response.redirect wwwURL&"/inipay/userinfo.asp"
            response.end            
        End If

    Next

    '### 렌탈 상품은 단독(1개)만 구매가능
    If oshoppingbag.FShoppingBagItemCount > 1 Then
        response.write "<script>alert('렌탈 상품은 단독으로 1개 상품만 구매 가능합니다.');location.href='/inipay/shoppingbag.asp';</script>"
        response.End
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

    '// 렌탈상품은 판매자의 정보를 넘겨야 되기 때문에 가져옴.
    Dim sqlStr, sellerUserId, sellerSocNumber, sellerSocName, sellerSocmail, sellerPrcName, sellerSocPhone, sellerSocCell, sellerSocTelNumber
    sqlStr = "select top 1" + vbcrlf
    sqlStr = sqlStr & " id, company_no, company_name, tel, email, manager_hp, manager_name" + vbcrlf
    sqlStr = sqlStr & " from db_partner.dbo.tbl_partner with (nolock)" & vbcrlf
    sqlStr = sqlStr & " where id = '" & oshoppingbag.FItemList(0).FMakerid & "'" & vbcrlf
    'response.write sqlStr & "<Br>"
    rsget.CursorLocation = adUseClient
    rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
    if  not rsget.EOF  then
        sellerUserId    = rsget("id")
        sellerSocNumber = rsget("company_no")
        sellerSocName   = rsget("company_name")
        sellerSocmail   = rsget("email")
        sellerPrcName   = rsget("manager_name")
        sellerSocPhone  = rsget("tel")
        sellerSocCell   = rsget("manager_hp")
    end if
    rsget.Close
    '// 사업자번호 특수문자 제거
    If sellerSocNumber <> "" Then
        sellerSocNumber = replace(sellerSocNumber,"-","")
    End If
    '// 전화번호 특수문자 제거
    If sellerSocPhone <> "" Then
        sellerSocPhone = replace(sellerSocPhone,"-","")
    End If
    '// 핸드폰번호 특수문자 제거
    If sellerSocCell <> "" Then
        sellerSocCell = replace(sellerSocCell,"-","")
    End If
    '// 일반 전화번호가 있으면 일반번호로 없으면 매너저 핸드폰 번호로 넣음
    If Trim(sellerSocPhone) <> "" Then
        sellerSocTelNumber = sellerSocPhone
    Else
        sellerSocTelNumber = sellerSocCell
    End If
    '// 셀러 연락처가 없으면 임의로 넣음
    If Trim(sellerSocTelNumber) = "" Or IsNull(sellerSocTelNumber) Then
        sellerSocTelNumber = "01000000000"
    End If

    '' 이니렌탈 기본 개월수 값이 없을경우 24개월로 기본셋팅함
    If iniRentalLength = "" Then
        If oshoppingbag.FItemList(0).FRentalMonth <> "0" Then
            iniRentalLength = oshoppingbag.FItemList(0).FRentalMonth
        Else
            '// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨
            If now() >= #2021-05-03 09:00:00# and now() < #2021-06-01 00:00:00# Then
                '// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)        
                iniRentalLength = "12"
            Else
                '// 2021년 8월 2일부터 md 요청으로 인해 12개월 기본값으로 변경
                iniRentalLength = "12"
            End If
        End If
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

    '// 이니렌탈 이벤트용으로 할인 판매 기간동안 제품군(카테고리), 제조사, 제품모델 값 넘김(요청사항으로는 SerialNo도 넘겨달라 했지만 해당값은 각 구매 상품별로 틀려서 안넘김)
    '// 일단 이벤트 이후로도 해당 값 있으면 넘겨도 될듯 2021-04-29 원승현
    Dim rentalAdditionalCategory, rentalAdditionalManufacturer, rentalAdditionalModelName, rentalAdditionalData
    sqlStr = "select TOP 1" + vbcrlf
    sqlStr = sqlStr & " i.itemid, i.itemname, dc.catename, s.makername, c.infoContent" + vbcrlf
    sqlStr = sqlStr & " FROM db_item.dbo.tbl_item i WITH(NOLOCK)" & vbcrlf
    sqlStr = sqlStr & " LEFT JOIN db_item.dbo.tbl_item_infoCont c WITH(NOLOCK) ON i.itemid = c.itemid" & vbcrlf
    sqlStr = sqlStr & " LEFT JOIN db_item.dbo.tbl_item_infoCode d WITH(NOLOCK) ON c.infoCd = d.infoCd" & vbcrlf
    sqlStr = sqlStr & " LEFT JOIN db_item.dbo.tbl_item_Contents s WITH(NOLOCK) ON i.itemid = s.itemid" & vbcrlf
    sqlStr = sqlStr & " LEFT JOIN db_item.dbo.tbl_display_cate_item ci WITH(NOLOCK) ON i.itemid = ci.itemid AND ci.isDefault='y'" & vbcrlf
    sqlStr = sqlStr & " LEFT JOIN db_item.dbo.tbl_display_cate dc WITH(NOLOCK) ON ci.catecode = dc.catecode" & vbcrlf
    sqlStr = sqlStr & " WHERE i.itemid = '"&oshoppingbag.FItemList(0).FItemID&"' AND d.infoSort=1" & vbcrlf
    'response.write sqlStr & "<Br>"
    rsget.CursorLocation = adUseClient
    rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
    if  not rsget.EOF  then
        rentalAdditionalCategory		= rsget("catename")
        rentalAdditionalManufacturer	= rsget("makername")
        rentalAdditionalModelName		= rsget("infoContent")
    end if
    rsget.Close

    If Trim(rentalAdditionalCategory) = "" Then
        rentalAdditionalCategory = ""
    End If
    If Trim(rentalAdditionalManufacturer) = "" Then
        rentalAdditionalManufacturer = ""
    End If
    If Trim(rentalAdditionalModelName) = "" Then
        rentalAdditionalModelName = ""
    End If
    '// 렌탈 보험용 데이터 json 형태
    'rentalAdditionalData = "{""product"":[{""category"":"""&rentalAdditionalCategory&""",""manufacturer"":"""&rentalAdditionalManufacturer&""",""modelName"":"""&rentalAdditionalModelName&"""}]}"

    '// 결제 오류로 인한 모델명 길이 조절
    If Trim(rentalAdditionalModelName) <> "" Then
        rentalAdditionalModelName = left(rentalAdditionalModelName, 15)
    End If


    If Trim(rentalAdditionalModelName)="" And Trim(rentalAdditionalManufacturer)="" And Trim(rentalAdditionalCategory)="" Then
        rentalAdditionalData = ""
    Else
        '// 렌탈 보험용 값 EUC-KR로 변환
        Dim getdata, xmlHttp

        getdata = "category="&Server.URLEncode(CStr(rentalAdditionalCategory))
        getdata = getdata&"&manufacturer="&Server.URLEncode(CStr(rentalAdditionalManufacturer))
        getdata = getdata&"&modelName="&Server.URLEncode(Cstr(rentalAdditionalModelName))

        Set xmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP.3.0")
        xmlHttp.open "GET","https://fapi.10x10.co.kr/api/web/v1/encode/encode/inirental/euckr?"&getdata, False
        xmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded; charset=utf-8"  ''UTF-8 charset 필요.
        xmlHttp.setTimeouts 90000,90000,90000,90000 ''2013/03/14 추가
        xmlHttp.Send
        rentalAdditionalData = BinaryToText(xmlHttp.responseBody, "EUC-KR")
        Set xmlHttp = Nothing
    End If
%>
<script src="/lib/js/jquery.form.min.js"></script>
<script type="text/javascript" >
    $(document).unbind("dblclick");
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
        <%'// 렌탈 개월 수 기본 셋팅 %>
        iniRentalPriceCalculation('<%=iniRentalLength%>');
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
                            frm.nointerest.value = "";
                            frm.quotabase.value = ""; //ini_web
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

        <% if (DiaryOpenGiftExists) then %>
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

        if(!frm.agreeAll.checked){
            alert('결제 진행을 하시려면 모든 주문 내용 확인 후 구매조건에 동의해주세요.');
            frm.agreeAll.focus();
            return;
        }

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

        //이니렌탈
        if ((paymethod=="150")) {
            if (frm.price.value<200000){
                alert('렌탈 상품 최소 결제 금액은 200,000원 이상입니다.');
                return;
            }
            frm.ini_onlycardcode.value = "";
            frm.quotabase.value = "";
            frm.buyername.value = frm.buyname.value.toString().replace('"', '');
            frm.buyertel.value = frm.buyhp1.value + "-" + frm.buyhp2.value + frm.buyhp3.value;

            // 수령인 우편번호
            frm.postNum.value = $.trim(frm.txZip.value);
            // 수령인 이름
            frm.rentalRecipientNm.value = frm.reqname.value;
            // 수령인 핸드폰번호
            frm.rentalRecipientPhone.value = frm.reqhp1.value+''+frm.reqhp2.value+''+frm.reqhp3.value;
            // 수령인 기본주소
            frm.address.value = frm.txAddr1.value
            // 수령인 상세주소
            frm.addressDtl.value = frm.txAddr2.value

            <% '// 이니시스 월 렌탈 계산 및 검증 %>
            var iniRentalCheckValue;
            var iniRentalTmpValue;
            <%'// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨%>
            <% If now() >= #2021-05-03 09:00:00# and now() < #2021-06-01 00:00:00# Then %>
                <%'// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)%>						
                iniRentalCheckValue = getIniRentalMonthPriceCalculationForEvent(frm.price.value, frm.rentalPeriod.value);
            <% Else %>
                iniRentalCheckValue = getIniRentalMonthPriceCalculation(frm.price.value, frm.rentalPeriod.value);
            <% End If %>
            iniRentalTmpValue = iniRentalCheckValue.split('|');
            if (iniRentalTmpValue[0]=="error") {
                alert(iniRentalTmpValue[1]);
                return;
            } else if (iniRentalTmpValue[0]=="ok") {
                frm.rentalPrice.value = iniRentalTmpValue[1]
            } else {
                alert("월 렌탈료에 문제가 발생하였습니다.\n고객센터로 문의해주세요.");
                return;
            }

            <% if (G_PG_100_USE_INIWEB) then %>
                payInI_Web(frm);
            <% else %>
                if (payInI(frm)==true){
                    if (frm.itemcouponOrsailcoupon[1].checked){
                        frm.checkitemcouponlist.value = frm.availitemcouponlist.value;
                    }else{
                        frm.checkitemcouponlist.value = "";
                    }
    
                    //frm.target = "";
                    frm.action = "/inipay/INIsecurepay.asp"
                    frm.submit();
                }
            <% end if %>
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

            <% if (DiaryOpenGiftExists) then %>
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
            pcouponmoney = parseInt(Math.round(frm.pCpnBasePrc.value * icouponvalue / 100)*frm.itemea.value*1)*1;
        }else{
            for (var i=0;i<frm.distinctkey.length;i++){
                pcouponmoney = pcouponmoney*1 + parseInt(Math.round(frm.pCpnBasePrc[i].value * icouponvalue / 100)*frm.itemea[i].value*1)*1;
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

    function iniRentalPriceCalculation(period) {
        var inirentalPrice = 0;
        var iniRentalTmpValuePrd;
        if (period!="") {
            <%'// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨%>
            <% If now() >= #2021-05-03 09:00:00# and now() < #2021-06-01 00:00:00# Then %>
                <%'// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)%>
                inirentalPrice = getIniRentalMonthPriceCalculationForEvent('<%=subtotalprice+oshoppingbag.GetMileageShopItemPrice%>', period);
            <% Else %>
                inirentalPrice = getIniRentalMonthPriceCalculation('<%=subtotalprice+oshoppingbag.GetMileageShopItemPrice%>', period);
            <% End If %>
            iniRentalTmpValuePrd = inirentalPrice.split('|');
            if (iniRentalTmpValuePrd[0]=="error") {
                inirentalPrice = 0;
                return;
            } else if (iniRentalTmpValuePrd[0]=="ok") {
                inirentalPrice = iniRentalTmpValuePrd[1]
            } else {
                inirentalPrice = 0;
                return;
            }		
        } else {
            <%'// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨%>
            <% If now() >= #2021-05-03 09:00:00# and now() < #2021-06-01 00:00:00# Then %>
                <%'// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)%>
                inirentalPrice = getIniRentalMonthPriceCalculationForEvent('<%=subtotalprice+oshoppingbag.GetMileageShopItemPrice%>', '12');
            <% Else %>
                inirentalPrice = getIniRentalMonthPriceCalculation('<%=subtotalprice+oshoppingbag.GetMileageShopItemPrice%>', '12');
            <% End If %>
            iniRentalTmpValuePrd = inirentalPrice.split('|');
            if (iniRentalTmpValuePrd[0]=="error") {
                inirentalPrice = 0;
                return;
            } else if (iniRentalTmpValuePrd[0]=="ok") {
                inirentalPrice = iniRentalTmpValuePrd[1]
            } else {
                inirentalPrice = 0;
                return;
            }		
        }
        $("#rentalChangeMonthPrice").empty().html("<em class='crRed'>"+period+"</em>개월 간 월 <em class='crRed'>"+inirentalPrice.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+"</em>원씩 납부됩니다.");
        $("#rentalFinalMonthPrice").empty().html("<span class='crRed'><em class='fs20'>"+period+"</em>개월 간 월</span> <span class='crRed'><em class='fs20'>"+inirentalPrice.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+"</em>원</span>");
        document.frmorder.rentalPeriod.value=period;
        document.frmorder.rentalPrice.value=inirentalPrice;
    }    
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
                            <th colspan="3">상품정보</th>
                            <th></th>
                            <th>수량</th>
                            <th colspan="2">이니렌탈 시</th>
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
                                    <td>
                                        <%= oshoppingbag.FItemList(i).FItemID %><br />
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
                                    <td>
                                        <img src="<%= Replace(oshoppingbag.FItemList(i).FImageSmall,"http://webimage.10x10.co.kr/","/webimage/") %>" width="50px" height="50px" alt="<%= oshoppingbag.FItemList(i).FItemName %>" />
                                    </td>
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
                                    <td></td>
                                    <td></td>
                                    <td>
                                        <%= oshoppingbag.FItemList(i).FItemEa %>
                                    </td>
                                    <td colspan="2">
                                        <% if (oshoppingbag.FItemList(i).ISsoldOut) or (TicketBookingExired) then %>
                                            <% if (TicketBookingExired) then %>
                                                <p class="crRed">매진</p>
                                            <% else %>
                                                <p class="crRed">품절</p>
                                            <% end if %>
                                        <% else %> 
                                            <%
                                                If oshoppingbag.FItemList(i).FRentalMonth <> "0" Then
                                                    Response.write oshoppingbag.FItemList(i).FRentalMonth&"개월간 월 "&Formatnumber(RentalPriceCalculationData(oshoppingbag.FItemList(i).FRentalMonth, (oshoppingbag.FItemList(i).GetCouponAssignPrice*oshoppingbag.FItemList(i).FItemEa)),0)&"원"
                                                Else
                                                    Response.write "12개월간 월 "&Formatnumber(RentalPriceCalculationData("12", (oshoppingbag.FItemList(i).GetCouponAssignPrice*oshoppingbag.FItemList(i).FItemEa)),0)&"원"
                                                End If
                                            %>
                                        <% end if %>
                                    </td>
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
                        </form>
                        </tbody>
					</table>

					<!--div class="totalBox tMar30">
						<dl class="totalPriceView">
							<dt><img src="/fiximage/web2013/cart/txt_total.gif" alt="총 주문 금액" /></dt>
							<dd>
								<ul class="priceList">
									<li>
										<span class="ftLt">상품 총 금액</span><strong class="ftRt"><%'FormatNumber(oshoppingbag.GetTotalItemOrgPrice-oshoppingbag.GetMileageShopItemPrice,0) %>원</strong>
									</li>
									<li>
										<%' if (IsForeignDlv) then %>
										<span class="ftLt">해외 배송비</span><strong class="ftRt"><span id="divEmsPriceUp"><%'FormatNumber(oshoppingbag.GetTotalBeasongPrice,0) %></span>원</strong>
										<%' elseif (IsArmyDlv) then %>
										<span class="ftLt">군부대 배송비</span><strong class="ftRt"><%'FormatNumber(C_ARMIDLVPRICE,0) %>원</strong>
										<%' elseif (IsQuickDlv) then %>
										<span class="ftLt">배송비</span><strong class="ftRt"><span id="DISP_DLVPRICEUp"><%'FormatNumber(C_QUICKDLVPRICE,0) %></span>원</strong>
										<%' else %>
										<span class="ftLt">배송비</span><strong class="ftRt"><span id="DISP_DLVPRICEUp"><%'FormatNumber(oshoppingbag.GetOrgBeasongPrice,0) %></span>원</strong>
										<%' end if %>
									</li>
								</ul>
							</dd>
						</dl>
						<p class="rt tPad15 bPad05">
							<span class="fs13 cr777">(적립 마일리지 <%'FormatNumber(oshoppingbag.getTotalGainmileage,0) %> P)</span>
							<strong class="lPad10">
							<%' if oshoppingbag.GetMileageShopItemPrice<>0 then %>
                                마일리지샵 금액 <span class="crRed lPad10"><em class="fs20"><%'FormatNumber(oshoppingbag.GetMileageShopItemPrice,0) %></em>P</span> <em><img src="/fiximage/web2013/cart/ico_plus.gif" alt="더하기" /></em>
							<%' end if %>
                            결제 예정 금액 <span class="crRed lPad10"><em class="fs20"><span id="DISP_FIXPRICEUp"><%'FormatNumber(subtotalprice,0) %></span></em>원</span></strong>
						</p>
					</div-->

                    <form name="frmorder" method="post" style="margin:0px;">
                        <input type="hidden" name="ordersheetyn" value="Y">

                        <!-- 상점아이디 -->
                        <% IF application("Svr_Info")="Dev" THEN %>
                            <input type=hidden name=mid value="teenxtest1"> 
                        <% else %>
                            <%'## 렌탈 전용 %>
                            <input type=hidden name=mid value="teenxteenr">
                        <% end if %>

                        <!-- 화폐단위 -->
                        <input type=hidden name=currency value="WON">
                        <!-- 무이자 할부 -->
                        <input type=hidden name=nointerest value="no">
                        <input type=hidden name=quotabase value="선택:일시불:2개월:3개월:4개월:5개월:6개월:7개월:8개월:9개월:10개월:11개월:12개월:18개월">
                        <input type=hidden name=acceptmethod value="rtpay">

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

                        <%'### 이니렌탈 추가 파라미터 %>
                        <input type="hidden" name="postNum" value=""><%'수령자 기준 우편번호%>
                        <input type="hidden" name="address" value=""><%'수령자 기준 주소%>
                        <input type="hidden" name="addressDtl" value=""><%'수령자 기준 상세주소%>
                        <input type="hidden" name="rentalRecipientNm" value=""><%'수령자 이름%>
                        <input type="hidden" name="rentalRecipientPhone" value=""><%'수령자 전화번호%>                        
                        <input type="hidden" name="rentalPeriod" value="<%=iniRentalLength%>"><%'렌탈 기간%>
                        <input type="hidden" name="rentalPrice" value=""><%'월 렌탈료%>
                        <input type="hidden" name="rentalCompNm" value="<%=sellerSocName%>"><%'사업자명(셀러기준)%>
                        <input type="hidden" name="rentalCompNo" value="<%=sellerSocNumber%>"><%'사업자번호(셀러기준)%>
                        <input type="hidden" name="rentalCompPhone" value="<%=sellerSocTelNumber%>"><%'사업자휴대폰번호(셀러기준)%>
                        <% If Trim(rentalAdditionalData) <> "" Then %>
                            <input type="hidden" name="additionalData" value="<%=rentalAdditionalData%>"><%'렌탈 추가 데이터(렌탈 보험용)%>
                        <% End If %>
                        <%'//### 이니렌탈 추가 파라미터 %>

                        <input type=hidden name=clickcontrol value="enable">
                        <input type=hidden name=price value="<%= subtotalprice %>">
                        <input type=hidden name=ooprice value="<%= subtotalprice %>">
                        <input type=hidden name=fixprice value="<%= subtotalprice %>">
                        <input type=hidden name=goodname value='<%= goodname %>'>
                        <input type=hidden name=buyername value="">
                        <input type=hidden name=buyeremail value="">
                        <input type=hidden name=buyemail value="">
                        <input type=hidden name=buyertel value="">
                        <input type=hidden name=gopaymethod value="rtpay">
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
                                <th>
                                    <label for="sendName">보내시는 분</label>
                                </th>
                                <td>
                                    <input type="text" class="txtInp" name="buyname" onkeyup="chkLength(this, 32);" maxlength="32" value="<%= doubleQuote(oUserInfo.FOneItem.FUserName) %>" id="sendName" />
                                </td>
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
                                <th>
                                    <label for="hp01">휴대전화</label>
                                </th>
                                <td>
                                    <p>
                                        <input type="text" class="txtInp" style="width:30px;<%=chkIIF(chkKakao,"background-color:#EEEEEE;","")%>" name="buyhp1" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" default="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",0) %>" title="주문고객 휴대전화번호 국번 입력" id="hp01" /> -
                                        
                                        <input type="text" class="txtInp" style="width:40px;<%=chkIIF(chkKakao,"background-color:#EEEEEE;","")%>" name="buyhp2" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" default="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",1) %>" title="주문고객 휴대전화번호 가운데 자리 번호 입력" /> -
                                        
                                        <input type="text" class="txtInp" style="width:40px;<%=chkIIF(chkKakao,"background-color:#EEEEEE;","")%>" name="buyhp3" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" default="<%= Splitvalue(oUserInfo.FOneItem.Fusercell,"-",2) %>" title="주문고객 휴대전화번호 뒷자리 번호 입력" />
                                    </p>
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
                                <th>
                                    <label for="phone01">전화번호</label>
                                </th>
                                <td>
                                    <input type="text" class="txtInp" style="width:30px;" name="buyphone1" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",0) %>" title="주문고객 전화번호 국번 입력" id="phone01" /> -
                                    
                                    <input type="text" class="txtInp" style="width:40px;" name="buyphone2" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",1) %>" title="주문고객 전화번호 가운데 자리 번호 입력" /> -
                                    
                                    <input type="text" class="txtInp" style="width:40px;" name="buyphone3" maxlength="4" value="<%= Splitvalue(oUserInfo.FOneItem.Fuserphone,"-",2) %>" title="주문고객 전화번호 뒷자리 번호 입력" />
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <%
                            ''if (IsUserLoginOK) and (Not IsRsvSiteOrder) then
                            if (IsUserLoginOK) then
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
                        <% 
                            end if 
                        %>

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
					    <% end if %>
                        <div class="overHidden tMar50">
                            <div style="width:1060px">
                                <div class="overHidden">
                                    <h3 class="crRed">결제 수단</h3>
                                </div>
                                <table class="baseTable orderForm payForm tMar10">
                                    <caption>렌탈/납부 기간 선택</caption>
                                    <colgroup>
                                        <col width="130x" /><col width="" />
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th class="pay-rental">
                                            <p>이니렌탈</p>
                                            <p>렌탈/납부 기간 선택</p>
                                        </th>
                                        <td>
                                            <div class="pay-info">
                                                <select class="select offInput" title="납부 기간 선택" onchange="iniRentalPriceCalculation(this.value);">
                                                    <%'// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨%>
                                                    <% If now() >= #2021-04-19 14:00:00# and now() < #2021-06-01 00:00:00# Then %>
                                                        <%'// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)%>
                                                        <option value="12" <% If iniRentalLength = "12" Then %>selected<% End If %>>12 개월</option>
                                                        <option value="24" <% If iniRentalLength = "24" Then %>selected<% End If %>>24 개월</option>
                                                        <option value="36" <% If iniRentalLength = "36" Then %>selected<% End If %>>36 개월</option>
                                                        <% If subtotalprice+oshoppingbag.GetMileageShopItemPrice > 1000000 Then %>
                                                            <option value="48" <% If iniRentalLength = "48" Then %>selected<% End If %>>48 개월</option>
                                                        <% End If %>
                                                    <% Else %>
                                                        <option value="12" <% If iniRentalLength = "12" Then %>selected<% End If %>>12 개월</option>
                                                        <option value="24" <% If iniRentalLength = "24" Then %>selected<% End If %>>24 개월</option>
                                                        <option value="36" <% If iniRentalLength = "36" Then %>selected<% End If %>>36 개월</option>
                                                        <%'// 아래 기간동안 48개월 간 표시 안함%>
                                                        <% If now() >= #2021-07-27 00:00:00# and now() < #2022-01-10 00:00:00# Then %>
                                                        <% Else %>															                                                        
                                                            <% If subtotalprice+oshoppingbag.GetMileageShopItemPrice > 1000000 Then %>                                                    
                                                                <option value="48" <% If iniRentalLength = "48" Then %>selected<% End If %>>48 개월</option>
                                                            <% End If %>
                                                        <% End If %>
                                                    <% End If %>
                                                </select>
                                                <div class="pay-month">
                                                    <strong><span id="rentalChangeMonthPrice"></span></strong>
                                                </div>
                                            </div>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                                <div class="note01 tPad20 lPad20">
                                    <ul class="list01">
                                        <li><a href="/shopping/pop_rental_info.asp" onclick="window.open(this.href, 'popbenefit', 'width=1000,height=800,left=300,scrollbars=auto,resizable=yes'); return false;" class="link-blue">이니렌탈이 뭔가요?</a></li>
                                        <li>구매가 아닌 렌탈 결제 상품입니다.</li>
                                        <li>약정한 월 납부금액이 완납되면 상품의 소유권은 고객님께 이전됩니다.</li>
                                    </ul>
                                    <div class="tPad20 service-rent-info">
                                        <p class="tit">[서비스 문의]</p>
                                        <p class="sub-txt">KG 이니시스 렌탈 고객센탈 고객센터 <span>1800-1739</span></p>
                                    </div>
                                </div>
                            </div>

                            <!--div class="ftLt" style="width:340px">
                                <div class="overHidden">
                                    <h3 class="crRed">결제 금액</h3>
                                </div>
                                <div class="payForm tMar10">
                                    <table>
                                    <caption>결제 금액 보기</caption>
                                    <colgroup>
                                        <col width="35%" /><col width="" />
                                    </colgroup>
                                    <tbody>
                                    <tr>
                                        <th>총 주문금액</th>
                                        <td><%'FormatNumber(oshoppingbag.GetTotalItemOrgPrice,0) %>원</td>
                                    </tr>
                                    <%' if (IsForeignDlv) then %>
                                    <tr>
                                        <th>해외배송비(EMS)</th>
                                        <td><span id="DISP_DLVPRICE"></span>원</td>
                                    </tr>
                                    <%' elseif (IsArmyDlv) then %>
                                    <tr>
                                        <th>군부대 배송비</th>
                                        <td><span id="DISP_DLVPRICE"><%'FormatNumber(oshoppingbag.GetTotalBeasongPrice,0) %></span>원</td>
                                    </tr>
                                    <%'elseif (IsQuickDlv) then %>
                                    <tr>
                                        <th>배송비</th>
                                        <td><span id="DISP_DLVPRICE"><%' FormatNumber(C_QUICKDLVPRICE,0) %></span>원</td>
                                    </tr>
                                    <%' else %>
                                    <tr>
                                        <th>배송비</th>
                                        <td><span id="DISP_DLVPRICE"><%' FormatNumber(oshoppingbag.GetOrgBeasongPrice,0) %></span>원</td>
                                    </tr>
                                    <%' end if %>
                                    <tr class="midMilieage">
                                        <th><strong class="fs12">구매 확정액</strong></th>
                                        <td><span class="crRed"><em class="fs18"><%' FormatNumber(subtotalprice+oshoppingbag.GetMileageShopItemPrice,0) %></em>원</span></td>
                                    </tr>
                                    </tbody>
                                    <tfoot>
                                    <tr>
                                        <th><strong class="fs12">최종 결제액</strong></th>
                                        <td><span id="rentalFinalMonthPrice"></span></td>
                                    </tr>
                                    </tfoot>
                                    </table>
                                </div>
                            </div-->
                        </div>



                        <% 
                            IF (OpenGiftExists) and Not(IsTicketOrder) then 
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
                                <%'<!-- 사은품선택 이벤트가 있는 경우 -->%>
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
                                <%' <!-- // 사은품 선택 이벤트가 있는 경우 --> %>
                        <% 
                            end if 
                        %>
                        <% 
                            if (DiaryOpenGiftExists) then
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
                                                    <p class="crRed">다이어리 스토리</p>
                                                    <strong class="cr000">선물 증정</strong>
                                                </div>

                                                <%' if Not (isNULL(devtStDT) or isNULL(devtEdDt)) then %>
                                                <p class="tPad15">※ 선물 증정은 재고 소진 시 조기 종료됩니다</p>
                                                <!-- <p class="tPad15">이벤트기간 : <%= replace(devtStDT,"-",".") %> ~ <%= replace(replace(devtEdDt,"-","."),Left(devtEdDt,4)&".","") %></p>-->
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
                                                <col width="16.67%" /><col width="16.67%" /><col width="16.67%" /><col width="16.67%" /><col width="16.67%" /><col width="" />
                                            </colgroup>
                                            <thead>
                                                <tr>
                                                    <th colspan="1" class="crRed">15,000원 이상 구매 시</th>
                                                    <th colspan="2" class="lBdr1 crRed">3만원 이상 구매 시</th>
                                                    <th colspan="2" class="lBdr1 crRed">6만원 이상 구매 시</th>
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
                        <% 
                            end if
                        %>
                        <input name="Tn_paymethod" type="hidden" id="Tn_paymethodR" value="150" checked />
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

                        <!-- 20210205 제3자 정보제공동의 -->
                        <hr class="lineBar">
                        <div class="orderNotiV21 tMar30">
                            <% If userid="" Then %>
                                <p class="txtArrow tMar15">
                                    주문 진행을 위해 관련된 개인정보를 수집합니다.
                                    <a href="" class="btnMore" onClick="window.open('/inipay/popDetailCollect.asp', '', 'width=500, height=580, scrollbars=auto,resizable=yes'); return false;">수집 내용 자세히보기</a>
                                </p>
                            <% End If %>

                            <p class="txtArrow tMar15">
                                주문 진행을 위해 다음의 판매자에게 개인정보를 제공합니다.
                                <a href="" class="btnMore" onClick="window.open('/inipay/popDetailProvide.asp', '', 'width=500, height=580, scrollbars=auto,resizable=yes'); return false;">제공 내용 자세히보기</a>
                                <small>케이지이니시스, <%=brandEnNames%></small>
                            </p>
                            <div class="chkAgreeV21 tMar30"><label for="agreeAll"><input type="checkbox" id="agreeAll">모든 내용을 확인하였으며 구매조건에 동의합니다.</label></div>
                        </div>
                        <!-- //20210205 제3자 정보제공동의 -->

                        <div class="ct tPad30 bPad20" id="nextbutton1" name="nextbutton1" style="display: block;">
                            <a href="<%=wwwURL%>/inipay/ShoppingBag.asp" class="btn btnB2 btnWhite2 btnW220"><em class="gryArr02">이전 페이지</em></a>
                            <a href="#" name="btnPay" id="btnPay" class="lMar10 btn btnB2 btnRed btnW220" onClick="PayNext(document.frmorder,'<%= iErrMsg %>');return false;">결제하기</a>
                        </div>
                        <div class="ct tPad30 bPad20" id="nextbutton2" name="nextbutton2" style="display: none;">
                            <a class="btn btnB2 btnGrylightNone btnW220"><em class="gryArr02" disabled >이전 페이지</em></a>
                            <a class="lMar10 btn btnB2 btnGrylightNone btnW220" >결제하기</a>
                        </div>
                        <%'<!-- ####### 모바일용 - 에러메세지, 상품명(모바일결제에 사용됨), 모바일 결제 후 결과값 ####### //-->%>
                            <input type="hidden" name="ierrmsg" value="<%= iErrMsg %>">
                            
                            <%'<!-- 실제 모바일쪽에 저장될 상품명 - 매우 짧음. //-->%>
                            <input type="hidden" name="mobileprdtnm" value="<%=vMobilePrdtnm%>">
                            
                            <%'<!-- 실제 모바일쪽에 저장될 가격 //-->%>
                            <input type="hidden" name="mobileprdprice" value="<%=subtotalprice%>">

                            <%'<!-- 실제 모바일쪽에 저장될 상품명이 너무 짧아서 temp용으로 풀 네임으로 사용 //-->%>
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
                        <%'<!-- ####### 모바일용 - 에러메세지, 상품명(모바일결제에 사용됨), 모바일 결제 후 결과값 ####### //-->%>

                        <%' <!-- Lg Uplus --> %>
                        <input type="hidden" name="LGD_OID" value="">
                        <input type="hidden" name="LGD_PAYKEY" value="">

                        <%' 이니렌탈에선 필요없는 값들 %>
                        <input name="cashreceiptreq" value="" type="hidden" id="cashreceiptreq" />
                        <input name="cashreceiptreq2" value="" type="hidden" id="cashreceiptreq2" />
                        <input name="cashreceiptreq3" type="hidden" id="npay01" value="" />
                        <input name="itemcouponOrsailcoupon" value="S" type="hidden" id="bonusCp" disabled />
                        <input name="itemcouponOrsailcoupon" value="I" type="hidden" id="pdtCp" disabled />
                        <input name="itemcouponOrsailcoupon" value="K" type="hidden" id="kbRdSite" disabled />
                        <input type="hidden" name=availitemcouponlist value="<%= checkitemcouponlist %>">
                        <input type="hidden" name=checkitemcouponlist value="">                        
                    </form>				    
                    
                </div>
			</div>
		</div>
	</div>
    <% if (IsKBRdSite) then %>
        <script language='javascript'>
            //defaultCouponSet(document.frmorder.itemcouponOrsailcoupon[2]);
            //RecalcuSubTotal(frm.kbcardsalemoney);
        </script>
    <% elseif (IsDefaultItemCouponChecked) and (vaildItemcouponCount>0) then %>
        <script language='javascript'>
            //frmorder.itemcouponOrsailcoupon[1].checked=true;
            //defaultCouponSet(document.frmorder.itemcouponOrsailcoupon[1]);
            //RecalcuSubTotal(document.frmorder.itemcouponOrsailcoupon[1]);

            CheckGift(true);
        </script>
    <% elseif (vaildCouponCount<1) and (vaildItemcouponCount>0) then %>
        <script language='javascript'>
            //frmorder.itemcouponOrsailcoupon[1].checked=true;
            //defaultCouponSet(document.frmorder.itemcouponOrsailcoupon[1]);
            //RecalcuSubTotal(document.frmorder.itemcouponOrsailcoupon[1]);

            CheckGift(true);
        </script>
    <% else %>
        <script language='javascript'>
        //2013 추가
        if (document.frmorder.itemcouponOrsailcoupon[0].checked){
            //defaultCouponSet(document.frmorder.itemcouponOrsailcoupon[0]);
        }else if (document.frmorder.itemcouponOrsailcoupon[1].checked){
            //defaultCouponSet(document.frmorder.itemcouponOrsailcoupon[1]);
        }else {
            //defaultCouponSet(document.frmorder.spendmileage);
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

            //showCashReceptDetail(document.frmorder.cashreceiptreq3);
            //showCashReceptDetail(document.frmorder.cashreceiptreq2);
            //showCashReceptDetail(document.frmorder.cashreceiptreq);


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
    Set oOpenGift   = nothing
    Set oOpenGiftDepth = nothing
    Set oDiaryOpenGift = nothing
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->