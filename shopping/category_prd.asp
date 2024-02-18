<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #INCLUDE Virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/base64.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryPrdCls.asp" -->
<!-- #include virtual="/lib/classes/item/ItemOptionCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_item_qnacls.asp" -->
<!-- #include virtual="/lib/classes/item/PlusSaleItemCls.asp" -->
<!-- #include virtual="/lib/classes/item/ticketItemCls.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/diarystory2016/lib/classes/diary_class_B.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/classes/clearancesale/clearancesaleCls.asp"-->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/classes/shopping/offshopcls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/classes/shopping/order_card_discountcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_itemcouponcls.asp" -->
<%
dim itemid, oItem, itEvtImg, itEvtImgMap, itEvtImgNm, sCatNm, lp, LoginUserid, cpid, IsTicketItem, IsSpcTravelItem, oTicket, addEx, clsDiaryPrdCheck, DiaryPreviewImgLoad, DiarySearchValue, GiftSu
dim oADD, i, ix, ISFujiPhotobook, IsPresentItem, IsReceiveSiteItem, catecode, cTalk, vTalkCnt, makerid, itemVideos, itEvtBanner, GiftNotice, Safety
Dim oItemOptionMultiple, oItemOption, isAlarmOptionPushChk, oItemOptionMultipleType, strSql, multiOptionValue
dim isQuickDlv
Dim categoryname, brand_id, IsRentalItem
itemid = requestCheckVar(request("itemid"),9)
LoginUserid = getLoginUserid()
dim parentsPage : parentsPage = "product"

If Request.ServerVariables("SERVER_PORT") = "443" Then
	Response.Redirect "http://" & Request.ServerVariables("SERVER_NAME") & Request.ServerVariables("PATH_INFO") & "?" & Request.ServerVariables("QUERY_STRING")
End If

'// 에코마케팅용 레코벨 스크립트 용(2016.12.21)
Dim vPrtr
vPrtr = requestCheckVar(request("pRtr"),200)

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mQrParam: mQrParam = request.QueryString		'// 유입 전체 파라메터 접수
			Response.Redirect "http://m.10x10.co.kr/category/category_itemPrd.asp?" & mQrParam
			REsponse.End
		end if
	end if
end if


'####### DB에서 가져오는 컴퍼넌트 사용여부 '(ex: 사용후기, 상품문의, 브랜드BEST, 해피투게더, 관련이벤트, 테스터후기 ) #######
''flgDBUse = true			'inc_const.asp에 cFlgDBUse 변수로 이전 (2015.12.18; 허진원)


'======================================== 상품코드 정확성체크 및 상품관련내용 ====================================
if itemid="" or itemid="0" then
	Call Alert_Return("상품번호가 없습니다.")
	response.End
elseif Not(isNumeric(itemid)) then
	Call Alert_Return("잘못된 상품번호입니다.")
	response.End
else	'정수형태로 변환
	itemid=CLng(getNumeric(itemid))
end if

if itemid=0 then
	Call Alert_Return("잘못된 상품번호입니다.")
	response.End
end if

set oItem = new CatePrdCls
oItem.GetItemData itemid

if oItem.FResultCount=0 then
	Call Alert_Return("존재하지 않는 상품입니다.")
	response.End
end If

'// 이벤트 상품 접근 제한 (첫구매샵, 타임특가)
Select Case cStr(itemid)
	Case "3420917","3421394","3421395","3680472","3687012","3733042","3742097","3760104","3758040"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3424997","3424998","3418284","3424999","3425011","3418290","3425012","3425021","3425022"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3465575","3465576","3465577","3465583","3465584","3465585","3465586","3458651","3675389"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3493942","3493958","3493962","3493976","3493993","3493994","3493998","3494000","3494001"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3527551","3554837","3570847","3568687","3589288","3628565","3654550","3654634","3654662"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3577689","3573760","3573757","3577707","3577713","3573758","3573761","3577718","3573759"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3713161","3715297","3708341","3690021","3714968","3715334","3713169","3715328","3715002","3701844"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3713643","3717297","3708348","3715298","3714963","3715197","3709143","3713170","3715332","3717425","3731023"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3707491","3707496","3707497","3707498","3707499","3707500","3721834","3770922","3770926"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3718849","3686950","3709144","3721795","3725107","3721797","3718165","3722309","3730632","3725215"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3741794","3717297","3741793","3731934","3738663","3742256","3738635","3742255","3738453"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3746914","3746908","3722405","3752141","3454935","3742749","3742229","3747691","3747692","3738455"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3753079","3748354","3731940","3739018","3753051","3752204","3754681","3699585","3752630","3738469"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	Case "3797904","3810958","3810962","3810961","3810963","3810964","3810966","3810970","3830803","3855665"
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
End Select

'//2021-06-01 마케팅 전용 상품 접근 불가 정태훈
if (oItem.Prd.FItemDiv = "17") Then
	Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
End If

'//2020-11-02 오리온 쫄깃쫄KIT 추가 정태훈
if (itemid = "3371142") Then
	'이벤트 페이지 이동
	Response.redirect("/event/eventmain.asp?eventid=105097")
End If

'// 특정상품 쿠폰가격 노출 안함 : 적용 범위 - (텐바이텐가 , 쿠폰적용가)
dim isCouponPriceDisplay : isCouponPriceDisplay = true
Select Case cStr(itemid)
	Case "2624996", "2624995"
		isCouponPriceDisplay = false
End Select

'//2022 2월 빅세일 뱃지 노출 체크
'dim bigSaleItemCheck
'bigSaleItemCheck = fnGetBigSaleItemCheck(itemid)

if oItem.Prd.Fisusing="N" then
	if GetLoginUserLevel()=7 then
		'STAFF는 종료상품도 표시
		Response.Write "<script>alert('판매가 종료되었거나 삭제된 상품입니다.');</script>"
	else
		'// 수정 2017-03-09 이종화 - 종료 상품일시 - page redirect
		'Call Alert_Return("판매가 종료되었거나 삭제된 상품입니다.")
		'response.End
		Response.redirect("/shopping/closedprd.asp?"&request.servervariables("QUERY_STRING"))
	end if
end If

Dim gaparamChkVal
	gaparamChkVal = requestCheckVar(request("gaparam"),30)

if (oItem.Prd.FItemDiv = "21") Then
	'딜상품 딜 페이지로 이동
	Response.redirect("/deal/deal.asp?"&request.servervariables("QUERY_STRING"))
End If


itemid = oItem.Prd.FItemid
makerid = oItem.Prd.FMakerid
catecode = requestCheckVar(request("disp"),18)
If catecode <> "" Then
	If IsNumeric(catecode) = False Then
		catecode = ""
	End If
End If

'넘어온 카테고리 없음, 단위가 다름, 깊이가 2이하면 상품 카테고리로 표현
if catecode="" or (len(catecode) mod 3)<>0 or (len(catecode)/3)<=2 then catecode = oItem.Prd.FcateCode

'// fuji FDI photobook 2010-06-14
ISFujiPhotobook = oItem.Prd.FMakerid="fdiphoto"

'// Present상품
IsPresentItem = (oItem.Prd.FItemDiv = "09")

'// 스페셜 항공권 상품 (ex 진에어 이벤트)
IsSpcTravelItem = oitem.Prd.IsTravelItem and oItem.Prd.Fmakerid = "10x10Jinair"

'2015 APP전용 상품 안내
'if IsPresentItem or oItem.Prd.FOrgMakerid="10x10present" or itemid=1250336 then
'	Call Alert_Move("본 상품은 텐바이텐 APP에서만 보실 수 있습니다.","/")
'	dbget.Close: Response.End
'end if

'// 현장수령 상품
IsReceiveSiteItem = (oItem.Prd.FDeliverytype="6")

'// 티켓팅
IsTicketItem = (oItem.Prd.FItemDiv = "08")
If IsTicketItem Then
	set oTicket = new CTicketItem
	oTicket.FRectItemID = itemid
	oTicket.GetOneTicketItem
End If

'// 렌탈상품
IsRentalItem = (oItem.Prd.FItemDiv = "30")

'// 상품설명 추가
set addEx = new CatePrdCls
	addEx.getItemAddExplain itemid

'//제품 안전 인증 정보
set Safety = new CatePrdCls
Safety.getItemSafetyCert itemid

'// 상품상세설명 동영상 추가
Set itemVideos = New catePrdCls
	itemVideos.fnGetItemVideos itemid, "video1"
'================================================================================================================
'=============================== 이메일특가 번호 접수 및 특가 계산 (base64사용) =================================
cpid = requestCheckVar(request("ldv"),12)

'2017-09-18 김진영 추가
Dim RequestRdsite
If requestCheckVar(request("rdsite"),32) <> "" Then
	RequestRdsite = requestCheckVar(request("rdsite"),32)
End If
''''''''''''''''''''''''
if Not(cpid="" or isNull(cpid)) then
	cpid = trim(Base64decode(cpid))
	if isNumeric(cpid) then
		oItem.getTargetCoupon cpid, itemid
	end if
ElseIf ((Left(request.Cookies("rdsite"), 6) = "nvshop") OR (LEFT(RequestRdsite, 6) = "nvshop")) or ((Left(request.Cookies("rdsite"), 8) = "daumshop") OR (LEFT(RequestRdsite, 8) = "daumshop")) Then
	Dim naverSpecialcpID

	Call oItem.getNaverTargetCoupon(itemid) ''2018/03/09

'	if (application("Svr_Info")<>"Dev") then
'		naverSpecialcpID = 13523
'	Else
'		naverSpecialcpID = 11151
'	End If
'
'	if isNumeric(naverSpecialcpID) then
'		oItem.getTargetCoupon naverSpecialcpID, itemid
'	end if
end if

''발행 받은 타겟 쿠폰 존재여부 //2019/05/27 제거(2019/06/10)
' dim idRecevedTargetCpnExists : idRecevedTargetCpnExists = FALSE
' if (IsUserLoginOK) then
' 	idRecevedTargetCpnExists = oItem.getReceivedValidTargetItemCouponExists(LoginUserid, itemid)
' end if

''시크릿 쿠폰 존재여부 //2019/06/10
dim isValidSecretItemcouponExists : isValidSecretItemcouponExists = FALSE
dim secretcouponidx : secretcouponidx=-1
 if (IsUserLoginOK) then
	secretcouponidx = oItem.getValidSecretItemCouponDownIdx(LoginUserid, itemid)
 	isValidSecretItemcouponExists =(secretcouponidx>0)
 end if

'================================================================================================================
'=============================== 추가 이미지 & 추가 이미지-메인 이미지 ==========================================
set oADD = new CatePrdCls
oADD.getAddImage itemid

function ImageExists(byval iimg)
	if (IsNull(iimg)) or (trim(iimg)="") or (Right(trim(iimg),1)="\") or (Right(trim(iimg),1)="/") then
		ImageExists = false
	else
		ImageExists = true
	end if
end function

Function getFirstAddimage()
	if ImageExists(oitem.Prd.FImageBasic) then
		getFirstAddimage= oitem.Prd.FImageBasic
	elseif ImageExists(oitem.Prd.FImageMask) then
		getFirstAddimage= oitem.Prd.FImageMask
	elseif (oAdd.FResultCount>0) then
		if ImageExists(oAdd.FADD(0).FAddimage) then
			getFirstAddimage= oAdd.FADD(0).FAddimage
		end if
	else
		getFirstAddimage= oitem.Prd.FImageMain
	end if
end Function

'=============================== 추가 정보 ==========================================
dim isMyFavBrand: isMyFavBrand=false
dim isMyFavItem: isMyFavItem=false
if IsUserLoginOK then
	isMyFavBrand = getIsMyFavBrand(LoginUserid,oItem.Prd.FMakerid)
	isMyFavItem = getIsMyFavItem(LoginUserid,itemid)
end if

'클리어런스 상품 여부 확인
dim isClearaceSaleItem, oCLS
set oCLS = new CClearancesalelist
oCLS.Fitemid = itemid
isClearaceSaleItem = oCLS.fnIsClearanceItem
set oCLS = Nothing

'판매 매장 정보
dim arrOffShopList
arrOffShopList = oItem.GetSellOffShopList(itemid,2)

'================================================================================================================
'=============================== 해더의 타이틀 및 관련태그의 삽입처리 ===========================================
'타이틀 설정
strPageTitle = "텐바이텐 10X10 : " & Replace(oItem.Prd.FItemName,"""","")
if oItem.Prd.isSoldout then
	strPageKeyword = ""
else
	strPageKeyword = Replace(oItem.Prd.FItemName,"""","") & ", " & Replace(oItem.Prd.FBrandName,"""","") & ", " & Replace(oItem.Prd.FBrandName_kor,"""","")
end if


'페이지 설명 설정
if trim(oItem.Prd.FDesignerComment)<>"" then strPageDesc = "생활감성채널 텐바이텐- " & Replace(Trim(oItem.Prd.FDesignerComment),"""","")
'페이지 요약 이미지(SNS 퍼가기용)
strPageImage = getFirstAddimage
'페이지 URL(SNS 퍼가기용)
strPageUrl = "http://10x10.co.kr/shopping/category_prd.asp?itemid=" & itemid

'RecoPick 스트립트 관련 내용 추가; 2013.12.05 허진원 추가
'레코픽 서비스 종료로 인한 제거 150630 원승현
'strRecoPickMeta = "	<meta property=""recopick:price"" content=""" & oItem.Prd.getRealPrice & """>"	'head.asp에서 출력
'if oItem.Prd.IsSoldOut then	strRecoPickMeta = strRecoPickMeta & vbCrLf & "	<meta property=""product:availability"" content=""oos"">"
'RecoPickSCRIPT = "	recoPick('sendLog', 'view', '" & itemid & "');"										'incFooter.asp 에서 출력

'// 구글 어낼리틱스 유니버셜 스크립트용으로 전환(2016.03.10)
googleANAL_PRESCRIPT = "ga('set','dimension1','"&itemid&"');" & VbCrlf

'//기프트톡 카운트
vTalkCnt = oItem.fnGetGiftTalkCount(itemid)
'================================================================================================================
'=============================== 다이어리 상품 체크 유무. 사용때만 주석풀기 맨아래 clsDiaryPrdCheck Nothing 에도.
set clsDiaryPrdCheck = new cdiary_list
	clsDiaryPrdCheck.FItemID = itemid
	clsDiaryPrdCheck.DiaryStoryProdCheck
	If clsDiaryPrdCheck.FResultCount > 0 then
		'GiftSu = clsDiaryPrdCheck.getGiftDiaryExists(itemid)	'다이어리 상은품 남은수량
		GiftSu = 0
	end If
GiftNotice=False '사은품 소진 메세지 출력 유무
dim giftCheck : giftCheck = False '사은품 표기 온오프

'If clsDiaryPrdCheck.FResultCount > 0 Then
	'// 다이어리 프리뷰 이미지.
	Set DiaryPreviewImgLoad = new cdiary_list
	'	DiaryPreviewImgLoad.Fidx		= clsDiaryPrdCheck.FDiaryID
	'	DiaryPreviewImgLoad.getPreviewImgLoad
	DiaryPreviewImgLoad.FTotalCount=0
	'// 다이어리 검색어값
	'Set DiarySearchValue = new cdiary_list
	'	DiarySearchValue.Fidx		= clsDiaryPrdCheck.FDiaryID
	'	DiarySearchValue.getSearchValueSet

'End If

'// 제품상세 facebook 픽셀 스크립트 추가 2016.09.22 원승현
facebookSCRIPT = "<script>" & vbCrLf &_
				"!function(f,b,e,v,n,t,s){if(f.fbq)return;n=f.fbq=function(){n.callMethod?n.callMethod.apply(n,arguments):n.queue.push(arguments)};if(!f._fbq)f._fbq=n;" & vbCrLf &_
				"n.push=n;n.loaded=!0;n.version='2.0';n.queue=[];t=b.createElement(e);t.async=!0;" & vbCrLf &_
				"t.src=v;s=b.getElementsByTagName(e)[0];s.parentNode.insertBefore(t,s)}(window,document,'script','//connect.facebook.net/en_US/fbevents.js');" & vbCrLf &_
				"fbq('init', '260149955247995');" & vbCrLf &_
				"fbq('init', '889484974415237');" & vbCrLf &_				
				"if (Array.from){fbq('track','PageView');" & vbCrLf &_
				"fbq('track', 'ViewContent',{content_ids:['"&itemid&"'],content_type:'product'});}</script>" & vbCrLf &_
				"<noscript><img height=""1"" width=""1"" style=""display:none"" src=""https://www.facebook.com/tr?id=260149955247995&ev=PageView&noscript=1"" /></noscript>" & vbCrLf &_
				"<noscript><img height=""1"" width=""1"" style=""display:none"" src=""https://www.facebook.com/tr?id=889484974415237&ev=PageView&noscript=1"" /></noscript>"								


'// 상품상세 로그 사용여부(2017.01.12)
Dim LogUsingCustomChk
If LoginUserId="thensi7" Then
	LogUsingCustomChk = True
Else
	LogUsingCustomChk = True
End If

'// 상품상세 로그저장(2017.01.11 원승현)
If LogUsingCustomChk Then
	If IsUserLoginOK() Then
		'// 검색을 통해서 들어왔을경우
		If Trim(vPrtr)<>"" Then
			Call fnUserLogCheck("itemrect", LoginUserid, itemid, "", Trim(vPrtr), "pc")
		Else
			Call fnUserLogCheck("item", LoginUserid, itemid, "", "", "pc")
		End If
	End If
End If

'// 구글 ADS 스크립트 관련(2018.09.21 신규버전 추가)
googleADSCRIPT = " <script> "
googleADSCRIPT = googleADSCRIPT & "	gtag('event', 'page_view', { "
googleADSCRIPT = googleADSCRIPT & "	 'send_to': 'AW-851282978', "
googleADSCRIPT = googleADSCRIPT & "	 'ecomm_pagetype': 'product', "
googleADSCRIPT = googleADSCRIPT & "	 'ecomm_prodid': '"&itemid&"', "
googleADSCRIPT = googleADSCRIPT & "	 'ecomm_totalvalue': "&oItem.Prd.FSellCash&" "
googleADSCRIPT = googleADSCRIPT & "	}); "
googleADSCRIPT = googleADSCRIPT & " </script> "

'// appBoy CustomEvent
appBoyCustomEvent = "appboy.logCustomEvent('userProductView');"

'// Kakao Analytics
kakaoAnal_AddScript = "kakaoPixel('6348634682977072419').viewContent({id:'"&itemid&"'});"

'// 옵션이 있는 상품중 단일 또는 복합옵션일 경우 해당 옵션의 품절여부를 가져온다.
If trim(oItem.Prd.FSellYn) = "Y" Then
	isAlarmOptionPushChk = False
	'// 옵션정보를 가져온다.
	set oItemOption = new CItemOption
	oItemOption.FRectItemID = itemid
	oItemOption.FRectIsUsing = "Y"
	oItemOption.GetOptionList

	If oItemOption.FResultCount>0 Then
		set oItemOptionMultiple = new CItemOption
		oItemOptionMultiple.FRectItemID = itemid
		oItemOptionMultiple.GetOptionMultipleList

		If oItemOptionMultiple.FResultCount>0 Then
			'// 멀티옵션일 경우
			set oItemOptionMultipleType = new CItemOption
			oItemOptionMultipleType.FRectItemId = itemid
			oItemOptionMultipleType.GetOptionMultipleTypeList

			strSql = " Select top 1 "
			strSql = strSql & "	itemid, "
			strSql = strSql & "		stuff( "
			strSql = strSql & "				( "
			strSql = strSql & "					Select ','''+substring(itemoption, 1, "&oItemOptionMultipleType.FResultCount&")+'''' "
			strSql = strSql & "					From db_item.[dbo].[tbl_item_option] "
			strSql = strSql & "					Where itemid = o.itemid And optsellyn='Y' "
			strSql = strSql & "					group by itemid, substring(itemoption, 1, "&oItemOptionMultipleType.FResultCount&") "
			strSql = strSql & "					FOR XML PATH('') "
			strSql = strSql & "				),1,1,'' "
			strSql = strSql & "			 ) as availableOpt "
			strSql = strSql & "	From db_item.[dbo].[tbl_item_option] o Where itemid='"&itemid&"' And optsellyn='Y' "
			strSql = strSql & "	group by itemid "
			rsget.Open strSql, dbget, 1
			if Not rsget.Eof Then
				multiOptionValue = rsget("availableOpt")
			End If
			rsget.close

			strSql = " Select * From db_item.dbo.tbl_item_option Where itemid='"&itemid&"' And substring(itemoption, 1, "&oItemOptionMultipleType.FResultCount&") in ("&multiOptionValue&") And "
			strSql = strSql & "		case when optlimityn='N' then "
			strSql = strSql & "			case when optsellyn='N' then 0 "
			strSql = strSql & "			else 1 end "
			strSql = strSql & "		else (optlimitno-optlimitsold) end < 1 "
			rsget.Open strSql, dbget, 1
			if Not rsget.Eof Then
				Do Until rsget.eof
					isAlarmOptionPushChk = True
				rsget.movenext
				Loop
			End If
			rsget.close
		Else
			'// 단일옵션일 경우
			for i=0 to oItemOption.FResultCount-1
				If ((oitem.Prd.IsSoldOut) or (oItemOption.FItemList(i).IsOptionSoldOut)) Then
					isAlarmOptionPushChk = True
				End If
			Next
		End If

		Set oItemOptionMultiple = Nothing
	End If

	Set oItemOption = Nothing
End If
'================================================================================================================
'=============================== 바로 배송 상품 여부 2018/06/15 최종원
	isQuickDlv = 0
	' If NOT (itemid="" or itemid="0") Then
	' 	if(oitem.Prd.FDeliverytype="1" or oitem.Prd.FDeliverytype="4") then
	' 		strSql = " SELECT COUNT(*) AS RESULT"
	' 		strSql = strSql & "	FROM DB_ITEM.DBO.TBL_ITEM_QUICKDLV "
	' 		strSql = strSql & "	WHERE ITEMID = '"&itemid&"'"

	' 		rsget.CursorLocation = adUseClient
	' 		rsget.Open strSql, dbget, adOpenForwardOnly, adLockReadOnly

	' 		if Not rsget.Eof Then
	' 		isQuickDlv = rsget("RESULT")
	' 		End If
	' 		rsget.close
	' 	end if
	' End If
	' '// 바로배송 종료에 따른 처리
	' If now() > #07/31/2019 12:00:00# Then
	' 	isQuickDlv = 0
	' End If
'==================================아리따움 이벤트 상품=========================================================
	dim isAritaumItem
	isAritaumItem = false
	If Now() > #08/31/2018 00:00:00# AND Now() < #09/30/2018 23:59:59# Then
		If NOT (itemid="" or itemid="0") Then
			if itemid = 2075053 or itemid = 2075052 or itemid = 2075051 or itemid = 2075050 or itemid = 2075019 or itemid = 2075018 or itemid = 2075016 or itemid = 2074968 or itemid = 2074965 or itemid = 2074962 or itemid = 2074914 or itemid = 2074907 or itemid = 2074859 or itemid = 2074737 or itemid = 2074432 or itemid = 2074445 or itemid = 2074465 or itemid = 2074453 then
				isAritaumItem = true
			end if
		end if
	end if
'// 하나 텐바이텐 체크카드로만 구매되는 상품인지 확인.
'// 하나체크 전용상품 관련
Dim IsOnlyHanaTenPayValidItemInPrd
IsOnlyHanaTenPayValidItemInPrd = False
Select Case Trim(itemid)
	Case "1967223","2014099"
		IsOnlyHanaTenPayValidItemInPrd = True
	Case Else
		IsOnlyHanaTenPayValidItemInPrd = False
End Select

''카테브랜드 쿠폰 관련
dim cateBrandCpnArr, isCateBrandCpnExists : isCateBrandCpnExists = FALSE
cateBrandCpnArr = oitem.getCatebrandCPnTop1(itemid)
isCateBrandCpnExists = IsArray(cateBrandCpnArr)

'// 천원의 기적 상품 접근시 alert 표시
if (trim(itemid)="2135191" Or trim(itemid)="2145838" Or trim(itemid)="2145984" Or trim(itemid)="2146034" Or trim(itemid)="2165571" Or trim(itemid)="2181366" Or trim(itemid)="2199320") then
	Call Alert_Return("본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.")
	response.End
end If
'// 2019-03-27 100원의 기적 상품
if (trim(itemid)="2290327") or (trim(itemid)="2292048") or (trim(itemid)="2292964") or (trim(itemid)="2292057") or (trim(itemid)="2292077") or (trim(itemid)="2292085") or (trim(itemid)="2292103") or (trim(itemid)="2292160") or (trim(itemid)="2292200") or (trim(itemid)="2292207") or (trim(itemid)="2292988") or (trim(itemid)="2293045") or (trim(itemid)="2293047") or (trim(itemid)="2293053") or (trim(itemid)="2293059") or (trim(itemid)="2293060") or (trim(itemid)="2292208") then
	Call Alert_Return("본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.")
	response.End
end if

'// 2019-06-17 100원 자판기 상품
if (trim(itemid)="2394974") or (trim(itemid)="2394975") or (trim(itemid)="2395008") or (trim(itemid)="2395002") or (trim(itemid)="2395009") or (trim(itemid)="2395062") or (trim(itemid)="2394978") then
	Call Alert_Return("본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.")
	response.End
end if

'// 2019-09-26 18주년 - 100원 자판기 상품
if (trim(itemid)="2521744") or (trim(itemid)="2521751") or (trim(itemid)="2521754") or (trim(itemid)="2521803") or (trim(itemid)="2521842") or (trim(itemid)="2521860") or (trim(itemid)="2521861") or (trim(itemid)="2521862") then
	Call Alert_Return("본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.")
	response.End
end if

'// 2019-11-20 메리라이트
if trim(itemid)="2574336" or trim(itemid)="2618838" then
	Call Alert_Return("본 상품은 이벤트 페이지에서만 확인하실 수 있습니다.")
	response.End
end if


'// 비회원일경우 회원가입 이후 페이지 이동을 위해 현재 페이지 주소를 쿠키에 저장해놓는다.
If Not(IsUserLoginOK) Then
	response.cookies("sToMUP") = tenEnc(replace(Request.ServerVariables("url")&"?"&Request.ServerVariables("QUERY_STRING"),"index.asp",""))
	Response.Cookies("sToMUP").expires = dateadd("d",1,now())
End If

'//크리테오에 보낼 md5 유저 이메일값
If Trim(session("ssnuseremail")) <> "" Then
	CriteoUserMailMD5 = MD5(Trim(session("ssnuseremail")))
Else
	CriteoUserMailMD5 = ""
End If

    '//모비온 매진값
	Dim mobion_soldout

    IF oItem.Prd.isSoldout or oItem.Prd.isTempSoldOut THEN
        mobion_soldout = "Y"
    ELSE
        mobion_soldout = "N"
    END IF
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	'// Biz상품 여부
	Dim isBizItem : isBizItem = (oItem.Prd.FItemDiv = "23")

	'// Biz상품 O And Biz회원 X 여부
	Dim isBizNotConfirm : isBizNotConfirm = (isBizUser <> "Y" And isBizItem)

	'//특정 브랜드 외부 검색엔진 제외 처리; 2017-10-25 허진원
	if makerid="kpage" then
%>
<meta name="robots" content="noindex">
<% end if %>
<link rel="canonical" href="http://www.10x10.co.kr/shopping/category_prd.asp?itemid=<%= itemid %>" />
<link rel="stylesheet" type="text/css" href="/lib/css/temp_w.css?v=1.00" />
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script type="text/javascript">
<!-- #include file="./inc_Item_Javascript.asp" -->
</script>
<script type="text/javascript" src="/lib/js/category_prd.js?v=1.1"></script>
<script>
    var menuTop=0;

    let cate1_name = "<%= getCateName(oItem.Prd.FcateCode, 1) %>";
    let cate2_name = "<%= getCateName(oItem.Prd.FcateCode, 2) %>";

    $(function() {
        let view_product_data = {
            itemid : "<%=itemid%>"
            , keyword : "<%=vPrtr%>"
            , ABTest : "control"
            , productkeywords : ["<%=Replace(Replace(oitem.Prd.FKeywords,",",""","""), "'","")%>"]
			, brand_id  : "<%=oItem.Prd.Fmakerid%>"
			, brand_name  : "<%=replace(oItem.Prd.FBrandName,"'","")%>"			
            , category_name_depth1  : cate1_name
            , category_name_depth2  : cate2_name
			, categoryname  : cate1_name
        };
        fnAmplitudeEventActionJsonData("view_product", JSON.stringify(view_product_data));

        if ($('.item-bnr .figure .image').length > 1) {
            $('.item-bnr .figure').slidesjs({
                width:145,
                height:145,
                navigation:{active:true, effect:"fade"},
                pagination:false,
                play:{interval:2000, active:false, effect:"fade", auto:true},
                effect:{fade:{speed:600, crossfade:true}}
            });
        }

        <% If isRentalItem Then %>
            <%'// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨%>
            <% If now() >= #2021-05-03 09:00:00# and now() < #2021-06-01 00:00:00# Then %>
                <%'// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)%>
                iniRentalPriceCalculation('12');
                $("#rentalmonth").val('12');
            <% Else %>
                <%'// 2021년 8월 2일부터 md 요청으로 인해 12개월 기본값으로 변경%>
                iniRentalPriceCalculation('12');
                $("#rentalmonth").val('12');
            <% End If %>
        <% End If %>

        <%' Branch Event Logging %>
            <%'// Branch Init %>
            <% if application("Svr_Info")="staging" Then %>
                branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
            <% elseIf application("Svr_Info")="Dev" Then %>
                branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
            <% else %>
                branch.init('key_live_hpOucoij2aQek0GdzW9xFddbvukaW6le');
            <% end if %>
            var branchContentsItemCustomData = {};
            var branchContentsItem = [{
                "$sku":"<%=itemid%>",
                "$price":<%=oItem.Prd.FSellCash%>,
                "$product_name":"<%=Server.URLEncode(replace(oItem.Prd.FItemName,"'",""))%>",
                "$quantity":1,
                "$currency":"KRW",
                "category":"<%=Server.URLEncode(fnItemIdToCategory1DepthName(itemid))%>"
            }];
            branch.logEvent(
                "VIEW_ITEM",
                branchContentsItemCustomData,
                branchContentsItem,
                function(err) { console.log(err); }
            );
        <%'// Branch Event Logging %>

    });

    /*
    *  Start of Function About Amplitude
    * */
    function amplitude_click_shoppingbag_in_product(){
        let view_product_data = {
            itemid : "<%=itemid%>"
            , brand_id  : "<%=oItem.Prd.Fmakerid%>"
            , brand_name  : "<%=oItem.Prd.FBrandName%>"			
            , category_name_depth1  : cate1_name
            , category_name_depth2  : cate2_name
            , product_name  : "<%= Replace(oItem.Prd.FItemName, """", "") %>"
            , categoryname  : cate1_name						
        };
        fnAmplitudeEventActionJsonData('click_shoppingbag_in_product', JSON.stringify(view_product_data));
    }

    function amplitude_click_directorder_in_product(){
        let view_product_data = {
            itemid : "<%=itemid%>"
            , brand_id  : "<%=oItem.Prd.Fmakerid%>"
            , brand_name  : "<%=oItem.Prd.FBrandName%>"			
            , category_name_depth1  : cate1_name
            , category_name_depth2  : cate2_name
            , product_name  : "<%= Replace(oItem.Prd.FItemName, """", "") %>"
            , categoryname  : cate1_name						
        };
        fnAmplitudeEventActionJsonData('click_directorder_in_product', JSON.stringify(view_product_data));
    }	

    function amplitude_click_wish_in_product(){
        let view_product_data = {
            action : "on"
            , brand_id  : "<%=oItem.Prd.Fmakerid%>"
            , brand_name  : "<%=oItem.Prd.FBrandName%>"
            , category_name_depth1  : cate1_name
            , category_name_depth2  : cate2_name
            , item_id  : "<%=itemid%>"
            , product_name  : "<%= Replace(oItem.Prd.FItemName, """", "") %>"
            , categoryname  : cate1_name			
        };

        fnAmplitudeEventActionJsonData('click_wish_in_product', JSON.stringify(view_product_data));
    }
    /*
    * End of Function About Amplitude
    * */
</script>
<%' 쿠폰배너 스타일, 스크립트%>
<style>
.bnr-coupon {display:block; margin-top:10px; margin-bottom:-10px; cursor:pointer;}
.bnr-coupon img {width:440px;}
.popup-lyr {display:none;}
.lyr-coupon {display:none; position:relative; width:412px; padding:40px 0; font-family:'Roboto', 'Noto Sans KR'; text-align:center; background-color:#fff; -webkit-border-radius:5px; border-radius:5px;}
.lyr-coupon h2 {font-weight:normal; font-family:inherit; font-size:21px; color:#444;}
.lyr-coupon .btn-close1 {position:absolute; top:0; right:0; width:60px; height:60px; font-size:0; color:transparent; background:url(//fiximage.10x10.co.kr/web2019/common/ico_x.png) no-repeat 50% / 20px;}
.lyr-coupon .cpn {width:189px; height:96px; margin:20px auto 18px; background:url(//fiximage.10x10.co.kr/web2019/common/bg_cpn.png) no-repeat 50% / 100%;}
.lyr-coupon .cpn .amt {padding-top:12px; font-size:24px; color:#fff; line-height:1.3;}
.lyr-coupon .cpn .amt b {margin-right:3px; font-weight:bold; font-size:37px; vertical-align:-2px;}
.lyr-coupon .cpn .txt1 {font-size:11px; color:#919ff2; letter-spacing:-1px;}
.lyr-coupon .cpn .txt1 b {display:inline-block; margin-right:2px; font-size:12px; vertical-align:-0.5px;}
.lyr-coupon .txt2 {font-size:14px; color:#999; line-height:1.6;}
.lyr-coupon .txt2 strong {font-weight:normal; color:#ff3434;}
.lyr-coupon .btn-area {margin-top:20px; font-size:0;}
.lyr-coupon .btn-area button {height:48px; font:inherit; font-size:15px; -webkit-border-radius:5px; border-radius:5px;}
.lyr-coupon .btn-area .btn-close2 {width:113px; background-color:#c2c2c2; color:#444;}
.lyr-coupon .btn-area .btn-down {width:149px; margin-left:9px; background-color:#222; color:#fff;}
</style>
<script>
function jsEvtCouponDown(stype, idx, cb) {
	<% If IsUserLoginOK() Then %>
	$.ajax({
			type: "POST",
			url: "/event/etc/coupon/couponshop_process.asp",
			data: "mode=cpok&stype="+stype+"&idx="+idx,
			dataType: "text",
			success: function(message) {
				if(message) {
					var str1 = message.split("||")
					if (str1[0] == "11"){
						fnAmplitudeEventMultiPropertiesAction('click_marketing_top_bnr','','')
						cb();
						return false;
					}else if (str1[0] == "12"){
						alert('기간이 종료되었거나 유효하지 않은 쿠폰입니다.');
						return false;
					}else if (str1[0] == "13"){
						alert('이미 다운로드 받으셨습니다.');
						return false;
					}else if (str1[0] == "02"){
						alert('로그인 후 쿠폰을 받을 수 있습니다!');
						return false;
					}else if (str1[0] == "01"){
						alert('잘못된 접속입니다.');
						return false;
					}else if (str1[0] == "00"){
						alert('정상적인 경로가 아닙니다.');
						return false;
					}else{
						alert('오류가 발생했습니다.');
						return false;
					}
				}
			}
	})
	<% Else %>
		jsChklogin('<%=IsUserLoginOK%>');
		return;
	<% End IF %>
}
function handleClicKBanner(link, bannerType, couponidx, lyrId, ampEvt){
	var couponType

	if(ampEvt != '') fnAmplitudeEventMultiPropertiesAction(ampEvt,'','')
	if(bannerType == 1){ // 링크배너
			window.location.href = link
	}else if(bannerType == 2){ // 쿠폰배너
		couponType = couponidx == 1190 ? 'month' : 'evtsel'
		jsEvtCouponDown(couponType, couponidx, function(){
			popupLayer(lyrId)
		})
	}else{ // 레이어팝업배너
		popupLayer(lyrId);
	}
}
function popupLayer(lyrId){
	viewPoupLayer('modal', $("#"+lyrId).html())
}
function handleClickBtn(url){
	window.location.href = url
}
function eventClicKBanner(link, actionEvent, actionEventProperty, actionEventPropertyValue){
	fnAmplitudeEventMultiPropertiesAction(actionEvent, actionEventProperty, actionEventPropertyValue)
	window.location.href = link
}

function branchAddToCartEventLoging() {
	var frm = document.sbagfrm;
	var branchQuantity;
	if (frm.itemea.value===undefined || frm.itemea.value=="") {
		branchQuantity = 1;
	} else {
		branchQuantity = frm.itemea.value;
	}
	<%'// Branch Init %>
	<% if application("Svr_Info")="staging" Then %>
		branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
	<% elseIf application("Svr_Info")="Dev" Then %>
		branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
	<% else %>
		branch.init('key_live_hpOucoij2aQek0GdzW9xFddbvukaW6le');
	<% end if %>
	var branchAddToCartCustomData = {};
	var branchAddToCartItem = [{
		"$sku":"<%=itemid%>",
		"$price":<%=oItem.Prd.FSellCash%>,
		"$product_name":"<%=Server.URLEncode(replace(oItem.Prd.FItemName,"'",""))%>",
		"$quantity":parseInt(branchQuantity),
		"$currency":"KRW",
		"category" : "<%=Server.URLEncode(fnItemIdToCategory1DepthName(itemid))%>"		
	}];
	branch.logEvent(
		"ADD_TO_CART",
		branchAddToCartCustomData,
		branchAddToCartItem,
		function(err) { console.log(err); }
	);
}

function iniRentalPriceCalculation(period) {
	var inirentalPrice = 0;
	var iniRentalTmpValuePrd;
	if (period!="") {
		<%'// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨%>
		<% If now() >= #2021-05-03 09:00:00# and now() < #2021-06-01 00:00:00# Then %>
			<%'// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)%>	
			inirentalPrice = getIniRentalMonthPriceCalculationForEvent('<%=oItem.Prd.FSellCash%>', period);
		<% Else %>
			inirentalPrice = getIniRentalMonthPriceCalculation('<%=oItem.Prd.FSellCash%>', period);
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
		$("#rentalmonth").val(period);
	} else {
		<%'// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨%>
		<% If now() >= #2021-05-03 09:00:00# and now() < #2021-06-01 00:00:00# Then %>
			<%'// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)%>	
			inirentalPrice = getIniRentalMonthPriceCalculationForEvent('<%=oItem.Prd.FSellCash%>', '12');
		<% Else %>
			inirentalPrice = getIniRentalMonthPriceCalculation('<%=oItem.Prd.FSellCash%>', '12');
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
		<%'// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨%>
		<% If now() >= #2021-05-03 09:00:00# and now() < #2021-06-01 00:00:00# Then %>
			<%'// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)%>	
			$("#rentalmonth").val('12');
		<% Else %>
			<%'// 2021년 8월 2일부터 md 요청으로 인해 12개월 기본값으로 변경%>
			$("#rentalmonth").val('12');
		<% End If %>
	}
	inirentalPrice = inirentalPrice.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,')+"원";
	$("#rentalMonthPrice").empty().html(" "+inirentalPrice);
}

// 관심 품목 담기 - 상품 페이지 전용 : 상품 코드로 변경
function TnAddFavoritePrd(iitemid){
    <% If GetLoginUserID <> "" Then %>
        var params = "";
        params = "mode=add&itemid=" + iitemid ;
        var FavWin = window.open('<%=wwwUrl%>/my10x10/popMyFavorite.asp?' + params ,'FavWin','width=480,height=530,scrollbars=auto,resizable=no');
        FavWin.focus();
	<% Else %>
	    location.href = '/login/loginpage.asp?backpath=' + encodeURIComponent(location.pathname + location.search);
	<% End If %>
}

function go_subscribe(){
    location.href="/shopping/category_prd.asp?hAmpt=sub&itemid=1496196";
}

function go_tenten_exclusive(){
    location.href="/search/search_result.asp?rect=텐텐단독";
}

function amplitudeDiaryStory() {
	fnAmplitudeEventAction('view_diarystory_main', 'place', 'product');
}
</script>
<%' 쿠폰배너 스타일, 스크립트%>
<%
If oItem.Prd.FAdultType <> 0 and session("isAdult")<>True then
	response.write "<script>confirmAdultAuth('"& Server.URLencode(CurrURLQ()) &"'); location.href='" & SSLUrl & "/';</script>"
end if
%>
<%
' 네이버광고 이미지 작업자 돋보기 기능 제거
if not(GetLoginUserID()="tkwon" or GetLoginUserID()="mydrizzle" or GetLoginUserID()="kbm503") then
%>
	<link href="/lib/js/jquery.magnify/magnify.min.css" rel="stylesheet">
	<script src="/lib/js/jquery.magnify/jquery.magnify.min.js"></script>
	<script type="text/javascript">
	$(document).ready(function() {
	$('.bsImage').magnify({
		'timeout': 1,
		'limitBounds': false
	});
	});
	</script>
	<style type="text/css">
	.magnify > .magnify-lens {
	width: 260px;
	height: 260px;
	}
	</style>
<%end if%>

</head>
<body>
<%
    If oItem.Prd.FAdultType = 0 or (oItem.Prd.FAdultType <> 0 and session("isAdult")=True) then
%>
    <div class="wrap">
	<!-- #include virtual="/lib/inc/incHeaderPrdDetail.asp" -->
	<div class="container">
		<% If now() >= #2022-09-01 00:00:00# and now() < #2023-02-01 00:00:00# Then %>
		<style>
			.container{position:relative;}
			.item-bnr .label{height:180px;}
		</style>
		<% elseif application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
		<style>
			.container{position:relative;}
			.item-bnr .label{height:180px;}
		</style>
		<% end if %>
		<div id="contentWrap" class="categoryPrd">
			<% '' 2017 정기세일-숨은 보물을 찾아라 레이어 팝업(4/3~4/17) %>
			<!-- #include virtual="/event/2017props/2017props_77062.asp" -->

			<% '' 상품상세 플로팅 배너 %>
			<% server.Execute("/chtml/main/loader/2018loader/prdFloatingBanner.asp") %>

			<p class="tPad10"><% If catecode <> "0" Then Call printCategoryHistory_B(catecode) End If %></p>

			<% if oItem.Prd.FisJust1Day then %>
			<div id="lyrjust1day"></div>
			<script type="text/javascript">
				$.ajax({
					type: "get",
					url: "act_just1day.asp?itemid=<%=itemid%>",
					success: function(message) {
						if(message) {
							$("#lyrjust1day").empty().html(message);
						}
					}
				});
			</script>
			<% else %>
			<p id="lyItemEventBanner" class="tPad10" style="display:none;"></p>
			<% end if %>
			<%'' 상품상세 이벤트 배너%>
			<% if IsUserLoginOK() then %>
				<% server.Execute("/chtml/main/loader/banner/exc_itemprd_banner.asp") %>
			<% else %>
				<% server.Execute("/chtml/main/loader/banner/exc_itemprd_nomember_banner.asp") %>
			<% end if %>
			<div class="pdtInfoWrapV15">
				<div class="pdtPhotoWrap">
					<div class="pdtPhotoBox">
						<div class="photoSlideV15">
						<%
							'// 상품 이미지 출력
							dim viBsimg, viMkimg, viAdImg
							dim viBstmb, viMktmb, viAdtmb

							'기본 이미지 (큰이미지가 있으면 큰걸로 취합)
							'if ImageExists(oitem.Prd.FImageBasic1000) then
							'	viBsimg = oitem.Prd.FImageBasic1000
							if ImageExists(oitem.Prd.FImageBasic600) then
								viBsimg = oitem.Prd.FImageBasic600
							elseif ImageExists(oitem.Prd.FImageBasic) then
								viBsimg = oitem.Prd.FImageBasic
							end if

							if viBsimg<>"" then
								viBstmb = getThumbImgFromURL(viBsimg,40,40,"true","false")		'썸네일 먼저
								viBsimg = getThumbImgFromURL(viBsimg,500,500,"true","false")

								if ImageExists(oitem.Prd.FImageBasic1000) then
									Response.write "<p><img class=""bsImage"" src=""" & viBsimg & """ thumb=""" & viBstmb & """ data-magnify-src=""" & oitem.Prd.FImageBasic1000 & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
								else
									Response.write "<p><img src=""" & viBsimg & """ thumb=""" & viBstmb & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
								end if
							end if

							'누끼 이미지 (큰이미지가 있으면 큰걸로 취합)
							if ImageExists(oitem.Prd.FImageMask1000) then
								viMkimg = oitem.Prd.FImageMask1000
							elseif ImageExists(oitem.Prd.FImageMask) then
								viMkimg = oitem.Prd.FImageMask
							end if

							if viMkimg<>"" then
								viMktmb = getThumbImgFromURL(viMkimg,40,40,"true","false")
								viMkimg = getThumbImgFromURL(viMkimg,500,500,"true","false")

								if ImageExists(oitem.Prd.FImageMask1000) then
									Response.write "<p><img class=""bsImage"" src=""" & viMkimg & """ thumb=""" & viMktmb & """ data-magnify-src=""" & oitem.Prd.FImageMask1000 & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
								else
									Response.write "<p><img src=""" & viMkimg & """ thumb=""" & viMktmb & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
								end if
							end if

							'추가 이미지 (큰이미지가 있으면 큰걸로 취합)
							If oAdd.FResultCount > 0 Then
								For i= 0 to oAdd.FResultCount-1
									viAdImg = "": viAdtmb=""
									If oAdd.FADD(i).FAddImageType=0 Then
										'if ImageExists(oAdd.FADD(i).FAddimage1000) then
										'	viAdImg = oAdd.FADD(i).FAddimage1000
										if ImageExists(oAdd.FADD(i).FAddimage600) then
											viAdImg = oAdd.FADD(i).FAddimage600
										elseif ImageExists(oAdd.FADD(i).FAddimage) then
											viAdImg = oAdd.FADD(i).FAddimage
										end if

										if viAdImg<>"" then
											viAdtmb = getThumbImgFromURL(viAdImg,40,40,"true","false")
											viAdImg = getThumbImgFromURL(viAdImg,500,500,"true","false")

											if ImageExists(oAdd.FADD(i).FAddimage1000) then
												Response.write "<p><img class=""bsImage"" src=""" & viAdImg & """ thumb=""" & viAdtmb & """ data-magnify-src=""" & oAdd.FADD(i).FAddimage1000 & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
											else
												Response.write "<p><img src=""" & viAdImg & """ thumb=""" & viAdtmb & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
											end if
										end if
									end if
								Next
							End If

							'// 텐바이텐 기본이미지 추가(이미지 올렸을시 생성되는 50*50사이즈 이미지 추가노출)
							If Not(isNull(oitem.Prd.Ftentenimage) Or oitem.Prd.Ftentenimage = "") Then
								Dim viTentenimg, viTententmb
								if ImageExists(oitem.Prd.Ftentenimage1000) Then
									viTentenimg = oitem.Prd.Ftentenimage1000
								ElseIf ImageExists(oitem.Prd.Ftentenimage600) Then
									viTentenimg = oitem.Prd.Ftentenimage600
								ElseIf ImageExists(oitem.Prd.Ftentenimage) Then
									viTentenimg = oitem.Prd.Ftentenimage
								End If

								If viTentenimg<>"" Then
									viTententmb = oitem.Prd.Ftentenimage50
								End If
								if ImageExists(oitem.Prd.Ftentenimage1000) then
									Response.write "<p><img class=""bsImage"" src=""" & viTentenimg & """ thumb=""" & viTententmb & """ data-magnify-src=""" & oitem.Prd.Ftentenimage1000 & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
								else
									Response.write "<p><img src=""" & viTentenimg & """ thumb=""" & viTententmb & """ alt=""" & replace(oItem.Prd.FItemName,"""","") & """ /></p>"
								end if

							End If
						%>
						</div>
					</div>
					<% IF (oItem.Prd.isLimitItem) and not (oItem.Prd.isSoldout or oItem.Prd.isTempSoldOut) and (Not IsReceiveSiteItem) and Not(IsPresentItem and oItem.Prd.FRemainCount>200 ) Then %>
					<p class="limitV15"><strong><% = oItem.Prd.FRemainCount & chkIIF(IsTicketItem,"좌석","개") %></strong> 남았습니다.</p>
					<% end if %>

					<%' diartstory 배너 %>
					<% if (oItem.Prd.Fdeliverytype = "1" Or oItem.Prd.Fdeliverytype = "4") and (oItem.Prd.FOrgPrice >= 8800) and (date() > "2020-09-06") and giftCheck then %>
						<%'// 사은품 소진시 해당 배너 나오지 않게 수정해야됨 2020-04-14 %>
						<% If clsDiaryPrdCheck.isDiaryStoryItem Then %>
							<p class="badge-diarygift"><a href="<%=SSLUrl%>/diarystory2022/special_benefit.asp" onclick="window.open(this.href, 'popbenefit', 'width=800,height=800,left=300,scrollbars=auto,resizable=yes'); return false;"><img src="http://fiximage.10x10.co.kr/web2020/diary2021/bnr_dr_bnf_v2.png" alt="사은품증정"></a></p>
						<% End If %>
					<% end if %>
					<%' diartstory 배너 %>
					<!-- 맛있는 정기세일 -->
					<% if (((oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0)) or oitem.Prd.isCouponItem) and Not(isBizItem) then %>
						<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
							<% If now() >= #2022-10-06 00:00:00# and now() < #2022-10-25 00:00:00# Then %>
								<a href="/event/21th/index.asp?tabType=benefit" class="badge_anniv21"><img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21_detail.png" alt="21주년"></a>
							<% end if %>
						<% else %>
							<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
								<a href="/event/21th/index.asp?tabType=benefit" class="badge_anniv21"><img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21_detail.png" alt="21주년"></a>
							<% end if %>
						<% end if %>
					<% end if %>
					<% If clsDiaryPrdCheck.FResultCount > 0 Then %>
						<% If now() >= #2022-09-01 00:00:00# and now() < #2022-11-09 00:00:00# Then %>
							<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
								<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
								<% else %>
									<a href="/diarystory2023/index.asp" onclick="amplitudeDiaryStory()"><i class="diary2023Badge_t2"></i></a>
								<% end if%>
							<% else %>
								<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
								<% else %>
									<a href="/diarystory2023/index.asp" onclick="amplitudeDiaryStory()"><i class="diary2023Badge_t2"></i></a>
								<% end if%>
							<% end if%>
						<% end if %>
					<% end if %>
				</div>
				<div class="pdtDetailWrap">
				<%' 배너영역 %>
                    <!-- 텐텐 체크카드 배너 -->
                    <%if itemid=2014099 then%>
                    <div class="bnr" style="margin-top:10px">
                        <a href="<%=SSLUrl%>/event/eventmain.asp?eventid=85155"><img src="http://webimage.10x10.co.kr/eventIMG/2018/87210/bnr_detail.jpg" alt="텐바이텐 체크카드 신청하러 가기"></a>
                    </div>
                    <%end if%>
                    <%'<!-- 이벤트 배너 : 88637 아리따움바로 가기 -->%>
                    <% if isAritaumItem then %>
                    <div class="bnr" style="margin-top:10px;">
                        <a href="<%=SSLUrl%>/event/eventmain.asp?eventid=88637"><img src="http://webimage.10x10.co.kr/fixevent/event/2018/88637/bnr_aritaum.png" alt="아리따움 10주년 기념 프로모션 상품을 1,000원에 만나보세요!"></a>
                    </div>
                    <% end if %>
                    <%
                        '텐바이텐 무료배송 행사 안내 배너 노출
                        if date>="2017-12-29" and date<="2017-12-31" and oitem.Prd.IsTenBeasong then
                    %>
                        <div class="bnr" style="margin:10px 0 -10px;"><a href="<%=SSLUrl%>/event/eventmain.asp?eventid=83398&gaparam=item_banner_0"><img src="http://webimage.10x10.co.kr/eventIMG/2017/83398/bnr_free_delivery1.jpg" alt="텐바이텐 무료배송 12월 31일까지"></a></div>
                    <%	end if %>
                    <%
                        'Clearance Sale 상품 안내 배너
                        if isClearaceSaleItem then
                    %>
                        <div class="bnr" style="margin:10px 0 -10px;"><a href="<%=SSLUrl%>/clearancesale/?gaparam=item_banner_0" title="클리어런스 세일 페이지로 이동"><img src="http://fiximage.10x10.co.kr/web2017/shopping/img_bnr_clear.jpg" alt="CLEARANCE SALE 보물같은 상품들을 할인된 가격으로!"></a></div>
                    <%	end if %>
					<% if (isValidSecretItemcouponExists) then %>
						<form name="frmSecretCpn" method="post" action="/shoppingtoday/couponshop_process.asp" style="margin:0px;">
						<input type="hidden" name="stype" value="prdsecret">
						<input type="hidden" name="idx" value="">
						</form>
						<script>
							function jsDownSecretCoupon(idx){
							<% if (NOT IsUserLoginOK) then %>
								jsChklogin('<%=IsUserLoginOK%>');
								return;
							<% else %>
								var frm;
								frm = document.frmSecretCpn;
								frm.idx.value = idx;
								frm.submit();
							<% end if %>
							}
						</script>
					<% end if %>
					<% if (isCateBrandCpnExists) then %>
						<form name="frmCpn" method="post" action="/shoppingtoday/couponshop_process.asp" style="margin:0px;">
						<input type="hidden" name="stype" value="">
						<input type="hidden" name="idx" value="">
						</form>
						<script>
							function jsDownCoupon(stype,idx){
							<% if (NOT IsUserLoginOK) then %>
								jsChklogin('<%=IsUserLoginOK%>');
								return;
							<% else %>
								var frm;
								frm = document.frmCpn;
								frm.stype.value = stype;
								frm.idx.value = idx;
								frm.submit();
							<% end if %>
							}
						</script>
					<% end if %>
					<div class="pdtInfoV15">
						<div class="pdtSaleInfoV15">
						<form name="amplitudeFrm" method="post" action="" style="margin:0px;">
						    <input type="hidden" name="brand_id" value="<%=oItem.Prd.FMakerid %>">
						    <input type="hidden" name="brand_name" value='<%=Server.URLEncode(replace(oItem.Prd.FBrandName,"'",""))%>'>
						    <input type="hidden" name="category_name" value="<%=Trim(fnCateCodeToCategory1DepthName(catecode))%>">
						    <input type="hidden" name="item_id" value="<%=itemid%>">
						    <input type="hidden" name="product_name" value="<%=oItem.Prd.FItemName%>">
						</form>
						<form name="sbagfrm" method="post" action="" style="margin:0px;">
						<input type="hidden" name="mode" value="add">
						<input type="hidden" name="itemid" value="<% = oitem.Prd.FItemid %>">
						<input type="hidden" name="sitename" value="<%= session("rd_sitename") %>">
						<input type="hidden" name="itemoption" value="">
						<input type="hidden" name="userid" value="<%= LoginUserid %>">
						<input type="hidden" name="itemPrice" value="<%= oItem.Prd.getRealPrice %>">
						<input type="hidden" name="isPhotobook" value="<%= ISFujiPhotobook %>">
						<input type="hidden" name="isPresentItem" value="<%= isPresentItem %>">
						<input type="hidden" name="IsSpcTravelItem" value="<%= IsSpcTravelItem %>">
						<input type="hidden" name="itemRemain" id="itemRamainLimit" value="<%=chkIIF(oItem.Prd.IsLimitItemReal,CHKIIF(oItem.Prd.FRemainCount<=oItem.Prd.ForderMaxNum,oItem.Prd.FRemainCount,oItem.Prd.ForderMaxNum),oItem.Prd.ForderMaxNum)%>">
						<input type="hidden" name="rentalmonth" id="rentalmonth" value="">
							<%If oItem.Prd.FAdultType <> 0 then%>
							<!-- 성인인증 -->
							<div class="adult-text">
								<div class="inner">
									<p>관계법령에 따라 미성년자는 구매할 수 없으며, 성인인증을 하셔야 구매 가능한 상품입니다.</p>
								</div>
							</div>
							<%End if%>
                            <% IF Not(isBizItem) THEN %>
                                <% If (IsRentalItem) Then %>
                                    <%' 이니렌탈상품 배너 %>
                                    <div style="margin-top:10px">
                                        <a href="<%=SSLUrl%>/event/eventmain.asp?eventid=107600"><img src="//fiximage.10x10.co.kr/web2020/common/bnr_rental.png" alt="이니렌탈"></a><%'<!-- 이벤트 변경 : 107600 -->%>
                                    </div>
                                    <%'// 이니렌탈상품 배너 %>
                                <% Else %>
                                    <%' 마케팅 쿠폰다운 배너 %>
                                    <% server.Execute("/chtml/main/loader/banner/exc_itemprd_banner_coupon.asp") %>
                                    <%'// 마케팅 쿠폰다운 배너 %>
                                <% End If %>
                            <% End If %>
							<div class="pdtBasicV15">
								<p class="pdtBrand">
									<%'// 2017.06.08 수정 %>
									<a href="" id="zzimBrandCnt" onclick="TnMyBrandJJim('<%= oItem.Prd.FMakerid %>', '<%= oItem.Prd.FBrandName %>'); return false;">
									<dfn id="zzimBr_<%= oItem.Prd.FMakerid %>" class="<%=chkIIF(isMyFavBrand,"zzimBrV15","")%>">찜브랜드</dfn></a> <a href="<%=SSLUrl%>/street/street_brand.asp?makerid=<%= oItem.Prd.FMakerid %>&ab=012_a_1"><span><%= UCase(oItem.Prd.FBrandName) %></span></a>
									<a href="<%=SSLUrl%>/street/street_brand.asp?makerid=<%= oItem.Prd.FMakerid %>&ab=012_a_2" class="btn btnS6 btnGry2 fn lMar10" style="display:none;"><em class="whiteArr03">브랜드샵</em></a>
								</p>
								<h2><p class="pdtName"><%= replace(replace(oItem.Prd.FItemName,"<br>"," "),"<br />"," ") %></p></h2>
								<p class="pdtDesp"><%= oItem.Prd.FDesignerComment %></p>
							</div>
							<div class="detailInfoV15">
								<% If (IsRentalItem) Then %>
									<%'!-- for dev msg : 이니시스 렌탈 상품상세 추가 --> %>
									<dl class="saleInfo">
										<dt>이니렌탈 시</dt>
										<dd>
											<div class="rental-info">
												<div class="pick-month">
													<select class="optSelect2 select" onchange="iniRentalPriceCalculation(this.value);">
														<%'// 테스트용으로 4월 19일 부터 셋팅 실서버 배포시에는 5월 3일 10시로 바꿔야됨%>
														<% If now() >= #2021-05-03 09:00:00# and now() < #2021-06-01 00:00:00# Then %>
															<%'// 이니렌탈 이벤트(2021년 5월 3일~2021년 5월 31일)%>
															<option value="12">12개월 간</option>
															<option value="24">24개월 간</option>
															<option value="36">36개월 간</option>
															<% If oItem.Prd.FSellCash > 1000000 Then %>
																<option value="48">48개월 간</option>
															<% End If %>
														<% Else %>
															<option value="12" checked>12개월 간</option>
															<option value="24">24개월 간</option>
															<option value="36">36개월 간</option>
															<%'// 아래 기간동안 48개월 간 표시 안함%>
															<% If now() >= #2021-07-27 00:00:00# and now() < #2022-01-10 00:00:00# Then %>
															<% Else %>															
																<% If oItem.Prd.FSellCash > 1000000 Then %>
																	<option value="48">48개월 간</option>
																<% End If %>
															<% End If %>
														<% End If %>
													</select>
													<strong class="cRd0V15">월<span id="rentalMonthPrice"> 0원</span></strong>
												</div>
												<div class="link">
													<a href="<%=SSLUrl%>/shopping/pop_rental_info.asp" onclick="window.open(this.href, 'popbenefit', 'width=1000,height=800,left=300,scrollbars=auto,resizable=yes'); return false;" >이니렌탈이 뭔가요?</a>
												</div>
											</div>
										</dd>
									</dl>
								<% Else %>
									<dl class="saleInfo">
										<dt>판매가</dt>
										<% If isBizNotConfirm Then %>
											<dd><strong class="cBk0V15">BIZ 회원전용 공개</strong></dd>
										<% ElseIf oItem.Prd.FSellCash>oItem.Prd.getOrgPrice then ''이상한 CASE %>
											<dd><strong class="cBk0V15"><%= FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원")%></strong></dd>
										<% else %>
											<dd><strong class="cBk0V15"><%= FormatNumber(oItem.Prd.getOrgPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원")%></strong></dd>
										<% end if %>
									</dl>
									<% IF (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) THEN %>
									<dl class="saleInfo">
										<dt>할인판매가</dt>
										<dd><strong class="cRd0V15">
											<%
												If isBizNotConfirm Then
													Response.Write "BIZ 회원전용 공개"
												Else
													Response.Write FormatNumber(oItem.Prd.FSellCash,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원") & " ["
													If oItem.Prd.FOrgprice = 0 Then
														Response.Write "0%]"
													Else
														Response.Write CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100) & "%]"
													End If
												End If
											%>
										</strong></dd>
									</dl>
									<% End If %>
									<%
										'21년 6월 14일까지 상품쿠폰이 없으며 가격범위(최소7만원이상)를 만족하면 출력
										dim isAvailBonusCoupon
										isAvailBonusCoupon = oItem.getIsAvailableBonusCoupon(itemid, makerid)
										IF date<="2021-06-14" and Not(oitem.Prd.isCouponItem) and oItem.Prd.GetCouponAssignPrice>=70000 and isAvailBonusCoupon THEN
											dim bonusCouponValue
											if oItem.Prd.GetCouponAssignPrice>=70000 and oItem.Prd.GetCouponAssignPrice<150000 then
												bonusCouponValue = 5000
											elseif oItem.Prd.GetCouponAssignPrice>=150000 and oItem.Prd.GetCouponAssignPrice<300000 then
												bonusCouponValue = 10000
											elseif oItem.Prd.GetCouponAssignPrice>=300000 then
												bonusCouponValue = 30000
											end if
									%>
									<dl class="saleInfo">
										<dt>쿠폰적용가</dt>
										<dd><strong class="cRd0V15">
										<%
											If isBizNotConfirm Then
												Response.Write "BIZ 회원전용 공개"
											Else
												Response.Write FormatNumber(oItem.Prd.GetCouponAssignPrice-bonusCouponValue,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원")
												Response.Write " [가입쿠폰 " & FormatNumber(bonusCouponValue,0) & "원 사용 시]"
											End If
										%>
										</strong>
										</dd>
										<dd class="couponTxt">쿠폰은 회원가입 후 24시간 내 1회만 사용하실 수 있으며, 여러 조건에 따라 최종 결제 금액이 변동될 수 있습니다.</dd>
									</dl>
									<% End If %>
								<% End If %>
								<%'// 하나체크 전용상품 관련 %>
								<% If IsOnlyHanaTenPayValidItemInPrd And Not(isBizNotConfirm) Then %>
								<dl class="saleInfo">
									<dt></dt>
									<dd>텐바이텐 카드 5% 즉시할인 적용시, <strong><%=FormatNumber(Fix(oItem.Prd.FSellCash*0.95),0)%>원</strong>에 결제 가능!</dd>
								</dl>
								<% End If %>
								<% if oItem.Prd.IsSaleItem and oItem.Prd.IsSpecialUserItem and Not(isBizNotConfirm) then %>
								<dl class="saleInfo">
									<dt>우수회원가</dt>
									<dd><strong class="cRd0V15"><%= FormatNumber(oItem.Prd.getRealPrice,0) & chkIIF(oItem.Prd.IsMileShopitem,"Point","원")%> [<% = getSpecialShopPercent() %>%]</strong> <a href="<%=SSLUrl%>/my10x10/special_shop.asp" class="btn btnS3 btnRed lMar10"><em class="whiteArr01 fn">우수회원샵</em></a></dd>
								</dl>
								<% end if %>
								<% if oitem.Prd.isCouponItem Then %>
								<dl class="saleInfo">
									<dt>쿠폰적용가</dt>
									<dd>
										<% If isBizNotConfirm Then %>
											<strong class="cGr0V15">BIZ 회원전용 공개</strong>
										<% ElseIf isCouponPriceDisplay then %>
										<strong class="cGr0V15"><%= FormatNumber(oItem.Prd.GetCouponAssignPrice,0) %>원 [<%= oItem.Prd.GetCouponDiscountStr %>]</strong>&nbsp;
										<% end if %>
										<% if Not(isBizNotConfirm) and Not(IsPresentItem) and oitem.Prd.isCouponItem Then %>
											<% if (isValidSecretItemcouponExists) then %>
											<a href="" onclick="jsDownSecretCoupon('<%= secretcouponidx %>'); return false;" class="btn btnS2 btnGrn fn btnW120"><span class="download">시크릿 쿠폰다운</span></a>&nbsp;
											<% else %>
											    <% If GetLoginUserId <> "" Then %>
													<% if oitem.Prd.FCurrItemCouponIdx="154678" or oitem.Prd.FCurrItemCouponIdx="154677" or oitem.Prd.FCurrItemCouponIdx="154676" or oitem.Prd.FCurrItemCouponIdx="154675" or oitem.Prd.FCurrItemCouponIdx="154674" or oitem.Prd.FCurrItemCouponIdx="154673" or oitem.Prd.FCurrItemCouponIdx="154672" or oitem.Prd.FCurrItemCouponIdx="154671" then %>
											        	<a href="" onclick="DownloadCoupon('<%= oitem.Prd.FCurrItemCouponIdx %>'); return false;" class="btn btnS2 btnGrn fn btnW134"><span class="download">20주년 할인쿠폰받기</span></a>&nbsp;
													<% else %>
														<a href="" onclick="DownloadCoupon('<%= oitem.Prd.FCurrItemCouponIdx %>'); return false;" class="btn btnS2 btnGrn fn btnW75"><span class="download">쿠폰다운</span></a>&nbsp;
													<% end if %>
                                                <% Else %>
                                                    <a href="" onclick="goLoginPage(); return false;" class="btn btnS2 btnGrn fn btnW75"><span class="download">쿠폰다운</span></a>&nbsp;
                                                <% End If %>
											<% end if %>
										<% end if %>
										<!-- '2013년 1월 1일부로 모든 카드 무이자혜택 제거 - 추후 필요하면 설정
										<div class="infoMoreViewV15">
											<span class="more1V15">무이자 할부 안내</span>
											<div class="infoViewLyrV15">
												<div class="infoViewBoxV15">
													<dfn></dfn>
													<div class="infoViewV15">
														<div class="pad15">무이자 할부 안내</div>
													</div>
												</div>
											</div>
										</div>
										//-->
									</dd>
								</dl>
								<% ElseIf (isCateBrandCpnExists) then '' 카테고리쿠폰 %>
								<% if isArray(cateBrandCpnArr) then %>
								<dl class="saleInfo">
									<dt><%=CHKIIF(cateBrandCpnArr(8,0)="B","브랜드 쿠폰","카테고리 쿠폰")%></dt>
									<dd>
										<strong class="txt-cpn cBk0V15"><%=replace(cateBrandCpnArr(11,0),"^^","&gt;")%>&nbsp;<%=replace(FormatNumber(cateBrandCpnArr(4,0),0),"0,000","만") %>원이상</strong> 구매 시&nbsp;
										<a href="#" class="btn btnS2 btnGrn fn bgc-red" onclick="jsDownCoupon('event','<%=cateBrandCpnArr(0,0)%>')"><span class="download"><%=FormatNumber(cateBrandCpnArr(2,0),0) %><%=chkiif(cateBrandCpnArr(1,0) = 1,"%","원")%> 쿠폰 다운</span></a>
									</dd>
								</dl>
								<% end if %>
								<% End If %>
							</div>
<%
'카드할인 정보 가져오기 (2022.01.28 정태훈)
dim oCardDisInfo, cardName, salePrice, CardminPrice
set oCardDisInfo = new CCardDiscount
oCardDisInfo.ItemCardDiscountInfo
cardName = oCardDisInfo.FOneItem.FcardName
salePrice = oCardDisInfo.FOneItem.FsalePrice
CardminPrice = oCardDisInfo.FOneItem.FminPrice
set oCardDisInfo = nothing
dim DiscountCash, DiscountInfo
DiscountCash = 0
DiscountInfo = False
if oitem.Prd.isCouponItem and isCouponPriceDisplay Then
    if (oItem.Prd.GetCouponAssignPrice >= 30000) then
        if Clng(GetLoginCurrentMileage()) >= 100 then
			if Clng(GetLoginCurrentMileage()) >= oItem.Prd.GetCouponAssignPrice then
                DiscountCash = oItem.Prd.GetCouponAssignPrice
			else
				DiscountCash = oItem.Prd.GetCouponAssignPrice-GetLoginCurrentMileage()
			end if
            DiscountInfo = True
		else
			DiscountCash = oItem.Prd.GetCouponAssignPrice
        end if
	else
		DiscountCash = oItem.Prd.GetCouponAssignPrice
    end if
else
    if (oItem.Prd.FSellCash >= 30000) then
        if Clng(GetLoginCurrentMileage()) >= 100 then
			if Clng(GetLoginCurrentMileage()) >= oItem.Prd.FSellCash then
                DiscountCash = oItem.Prd.FSellCash
			else
				DiscountCash = oItem.Prd.FSellCash-GetLoginCurrentMileage()
			end if
            DiscountInfo = True
		else
			DiscountCash = oItem.Prd.FSellCash
        end if
	else
		DiscountCash = oItem.Prd.FSellCash
    end if
end if
if cardName <> "" then
    if DiscountCash >= CardminPrice then
        DiscountInfo = True
    end if
end if
if DiscountCash >=50000 then
    DiscountInfo = True
end if
%>
							<% if DiscountInfo then %>
							<div class="discount">
								<dl class="saleInfo">
									<dt>할인의 참견</dt>
									<dd>
										<div class="dis_wrap">
											<% if oitem.Prd.isCouponItem and isCouponPriceDisplay Then '쿠폰할인시(더블할인 포함) %>
												<% if (oItem.Prd.GetCouponAssignPrice >= 30000) then %>
													<% if Clng(GetLoginCurrentMileage()) >= 100 then %>
														<% if Clng(GetLoginCurrentMileage()) >= oItem.Prd.GetCouponAssignPrice then '상품가격보다 마일리지가 더 많을 시 %>
															<p><span>0원</span>내 마일리지를 모두 사용한다면</p>
														<% else %>
															<% DiscountCash = oItem.Prd.GetCouponAssignPrice-GetLoginCurrentMileage() %>
															<p><span><%=FormatNumber(oItem.Prd.GetCouponAssignPrice-GetLoginCurrentMileage(),0)%>원</span>내 마일리지를 모두 사용한다면</p>
														<% end if %>
													<% else %>
														<% DiscountCash = oItem.Prd.GetCouponAssignPrice %>
													<% end if %>
												<% else %>
													<% DiscountCash = oItem.Prd.GetCouponAssignPrice %>
												<% end if %>
											<% else '할인시 또는 비 할인시 %>
												<% if (oItem.Prd.FSellCash >= 30000) then %>
													<% if Clng(GetLoginCurrentMileage()) >= 100 then %>
														<% if Clng(GetLoginCurrentMileage()) >= oItem.Prd.FSellCash then '상품가격보다 마일리지가 더 많을 시 %>
															<p><span>0원</span>내 마일리지를 모두 사용한다면</p>
														<% else %>
															<% DiscountCash = oItem.Prd.FSellCash-GetLoginCurrentMileage() %>
															<p><span><%=FormatNumber(oItem.Prd.FSellCash-GetLoginCurrentMileage(),0)%>원</span>내 마일리지를 모두 사용한다면</p>
														<% end if %>
													<% else %>
														<% DiscountCash = oItem.Prd.FSellCash %>
													<% end if %>
												<% else %>
													<% DiscountCash = oItem.Prd.FSellCash %>
												<% end if %>
											<% end if %>
											<% if cardName <> "" then %>
												<% if DiscountCash >= CardminPrice then %>
													<% if DiscountCash-salePrice > 0 then %>
														<p><span><%=FormatNumber(DiscountCash-salePrice,0)%>원</span>결제 시 <%=cardName%>로 <%=FormatNumber(salePrice,0)%>원 추가할인 받으면</p>
													<% else %>
														<p><span>0원</span>결제 시 <%=cardName%>로 <%=FormatNumber(salePrice,0)%>원 추가할인 받으면</p>
													<% end if %>
												<% end if %>
											<% end if %>
											<% if DiscountCash >=50000 then %>
											<p><span>월 <%=FormatNumber(Fix(DiscountCash/6),0)%>원</span>무이자 6개월 할부 시 <a href="javascript:viewPoupLayer('modal', $('#layerCard').html());">안내</a> <i></i></p>
											<% end if %>
										</div>
									</dd>
								</dl>
							</div>
							<div id="layerCard" style="display:none">
								<div class="slideWrap layerDeal layerCard">
									<div class="slide march">
									<p class="title">카드사 무이자 할부 혜택 안내</p>
										<div class="contents">
											<%
												If Trim(getCardInstallmentsInfo(date())) <> "" Then
													Response.write db2html(getCardInstallmentsInfo(date()))
												Else
													Response.write db2html(getCardInstallmentsInfo(DateAdd("m", -1, date())))
												End If
											%>											
										</div>
									</div>
									<button type="button" class="btnClose" onclick="ClosePopLayer();"><span>닫기</span></button>
								</div>
							</div>
							<% end if %>
							<div class="detailInfoV15">
								<% If Not(IsRentalItem) and Not(isBizItem) Then %>
									<% if oItem.Prd.FMileage then %>
									<dl class="saleInfo">
										<dt>마일리지</dt>
										<%'// 2018 회원등급 개편%>
										<dd><strong><% = formatNumber(oItem.Prd.FMileage,0) %> Point <% If Not(IsUserLoginOK()) Then %>~<% End If %></strong></dd>
									</dl>
									<% End If %>
								<% End If %>
								<% If (IsTicketItem) Then '티켓상품 %>
								<dl class="saleInfo">
									<dt>티켓수령</dt>
									<dd><% = oTicket.FOneItem.getTicketDlvName %></dd>
								</dl>
								<% else '일반상품%>
								<dl class="saleInfo">
									<dt>배송구분</dt>
									<dd>
									<% if oItem.Prd.IsAboardBeasong then %>
										<span class="icoAbroadV15"><em class="cRd0V15">텐텐<%=chkIIF(oItem.Prd.IsFreeBeasong,"무료","")%>배송</em> + 해외배송</span>&nbsp;
										<div class="infoMoreViewV15" style="z-index:100;">
											<span class="more1V15">배송비 안내</span>
											<div class="infoViewLyrV15">
												<div class="infoViewBoxV15">
													<dfn></dfn>
													<div class="infoViewV15">
														<div class="pad20">
														<% if Not(oItem.Prd.IsFreeBeasong) then %>
															<% '// 텐텐배송 2500으로 변경 %>
															<% If (Left(Now, 10) >= "2019-01-01") Then %>
																<p class="bPad10">텐바이텐 배송 상품으로만 <%=formatNumber(oItem.Prd.getFreeBeasongLimitByUserLevel,0)%>원 이상 구매 시 무료배송. 배송비(2,500원)</p>
															<% Else %>
																<p class="bPad10">텐바이텐 배송 상품으로만 <%=formatNumber(oItem.Prd.getFreeBeasongLimitByUserLevel,0)%>원 이상 구매 시 무료배송. 배송비(2,000원)</p>
															<% End If %>
														<% end if %>
															<p<%=chkIIF(Not(oItem.Prd.IsFreeBeasong)," class=""tPad13 bdrTop00""","")%>>텐바이텐에서는 구매한 상품을 해외 친구나 친지들이 받아 보실 수 있도록 해외배송 서비스(항공편 이용)를 신설하여 운영을 시작합니다.</p>
															<p class="tPad10">해외배송을 대행해줄 곳은 국가기관인 우정사업본부이며, 개인적으로 우체국을 통하여 해외배송 서비스를 받을때 보다 편리하게 이용하실 수 있습니다.</p>
															<p class="tPad10">EMS(Express Mail Service) 는 전세계 59개국(계속 확대중)으로 배송하며, 외국 우편당국과 체결한 특별협정에 따라 취급합니다.</p>
															<p class="tPad10 cRd0V15">이 상품의 해외배송 기준 중량 : 30g (1차 포장 포함 중량)</p>
															<p class="tPad10"><a href="<%=SSLUrl%>/cscenter/oversea/emsIntro.asp" class="btn btnS2 btnRed"><span class="whiteArr02 fn">해외배송 안내 자세히 보기</span></a></p>
														</div>
													</div>
												</div>
											</div>
										</div>
									<% elseif IsPresentItem then %>
										<span><% = oItem.Prd.GetDeliveryName %></span>&nbsp;
										<div class="infoMoreViewV15" style="z-index:100;">
											<span class="more1V15">배송비 안내</span>
											<div class="infoViewLyrV15">
												<div class="infoViewBoxV15">
													<dfn></dfn>
													<div class="infoViewV15">
														<div class="pad20">
															<% '// 텐텐배송 2500으로 변경 %>
															<% If (Left(Now, 10) >= "2019-01-01") Then %>
																<p>해당 상품은 10X10 Present 상품으로 주문 건당 2,500원의 배송비가 부과됩니다.</p>
															<% Else %>
																<p>해당 상품은 10X10 Present 상품으로 주문 건당 2,000원의 배송비가 부과됩니다.</p>
															<% End If %>
														</div>
													</div>
												</div>
											</div>
										</div>
									<% ElseIf oItem.Prd.IsOverseasDirectPurchase Then '//해외 직구 배송 %>
										<div class="tPad01">
											<span class="icoDirectV17"><em class="cBl0V17">해외직구 배송</em></span>&nbsp;&nbsp;<a href="" onclick="ODPorderinfo();return false;"><span class="more1V15">배송정보 안내</span></a>
										</div>
									<% else %>
										<span><% = oItem.Prd.GetDeliveryName %></span>&nbsp;
										<% if Not(oItem.Prd.IsFreeBeasong) then %>
										<div class="infoMoreViewV15" style="z-index:100;">
											<span class="more1V15">배송비 안내</span>
											<div class="infoViewLyrV15">
												<div class="infoViewBoxV15">
													<dfn></dfn>
													<div class="infoViewV15">
														<div class="pad20">
														<% if (oItem.Prd.IsUpcheParticleDeliverItem) or (oItem.Prd.IsUpcheReceivePayDeliverItem) then %>
															<p><%= oItem.Prd.getDeliverNoticsStr %></p>
															<p class="tPad05"><a href="<%=SSLUrl%>/street/street_brand.asp?makerid=<%= oItem.Prd.FMakerid %>&ab=012_b_1" class="more1V15"><%=oItem.Prd.FBrandName & "(" & oItem.Prd.FBrandName_kor & ")"%> 상품 더보기</a></p>
														<% else %>
															<% '// 텐텐배송 2500으로 변경 %>
															<% If (Left(Now, 10) >= "2019-01-01") Then %>
																<p>텐바이텐 배송 상품으로만 <%=formatNumber(oItem.Prd.getFreeBeasongLimitByUserLevel,0)%>원 이상 구매 시 무료배송. 배송비(2,500원)</p>
															<% Else %>
																<p>텐바이텐 배송 상품으로만 <%=formatNumber(oItem.Prd.getFreeBeasongLimitByUserLevel,0)%>원 이상 구매 시 무료배송. 배송비(2,000원)</p>
															<% End If %>
															<!--<p class="tPad05"><a href="" class="more1V15">텐바이텐 배송상품 더보기</a></p>-->
														<% end if %>
														</div>
													</div>
												</div>
											</div>
										</div>
										<% end if %>
									<% end if %>
									<% If isQuickDlv > 0 Then '//바로 배송 2018/06/15 최종원%>
										<div class="tPad01">
										<span>바로배송</span>&nbsp;
										<div class="infoMoreViewV15" style="z-index:99;">
											<span class="more1V15">바로배송 안내</span>
											<div class="infoViewLyrV15">
												<div class="infoViewBoxV15">
													<dfn></dfn>
													<div class="infoViewV15">
														<div class="pad20">
															<p>오전에 주문한 상품을 그날 오후에 바로 받자!<br />서울 전 지역 한정, 오후 1시까지 주문/결제를 완료할 경우 신청할 수 있는 퀵배송 서비스입니다.</p>
															<p class="tMar10"><strong>바로배송 배송료 :
															<% IF (now()<#19/07/2018 00:00:00#) then %>
																<del class="cGy1V15">5,000원</del> <span class="cRd0V15">2,500원</span></strong><br /><span class="cGy1V15">(오픈기념 이벤트 할인중, 2018년 7월 18일까지)</span></p>
															<%Else%>
																5,000원</strong>
															<%End if%>
															<p class="tPad15"><a href="<%=SSLUrl%>/shoppingtoday/barodelivery.asp" class="more1V15">바로배송 상품 전체보기</a></p>
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
									<% end if %>
									</dd>
								</dl>
								<% end if %>
								<% If Not oitem.Prd.IsTravelItem Then %>

								<%	if isArray(arrOffShopList) then %>
								<dl class="saleInfo">
									<dt>판매매장</dt>
									<dd>
									<%
										'매장 정보 가져오기
										Dim offshoplist
										Set offshoplist = New COffShop
										offshoplist.GetOffShopList

										Dim dicStore, firstDic
										set dicStore = Server.CreateObject("Scripting.Dictionary")
										For ix=0 To offshoplist.FResultCount-1
											dicStore.Add offshoplist.FItemList(ix).FShopID, Array(offshoplist.FItemList(ix).FShopName, offshoplist.FItemList(ix).FShopAddr1 + " " + offshoplist.FItemList(ix).FShopAddr2, offshoplist.FItemList(ix).FMobileWorkHour, offshoplist.FItemList(ix).FShopPhone, offshoplist.FItemList(ix).FMobileLatitude, offshoplist.FItemList(ix).FMobileLongitude, "텐바이텐 " + offshoplist.FItemList(ix).FShopName,"<b>텐바이텐 " + offshoplist.FItemList(ix).FShopName + "</b><ul><li>주소 : " + offshoplist.FItemList(ix).FShopAddr1 + " " + offshoplist.FItemList(ix).FShopAddr2 + "</li><li>전화 : " + offshoplist.FItemList(ix).FShopPhone + "</li></ul>")
										Next
										Set offshoplist = Nothing
									%>
									<%
										for lp=0 to ubound(arrOffShopList,2)
											If lp = 0 Then
												firstDic = arrOffShopList(0,lp)
											End If
											Response.Write "<span>" & arrOffShopList(1,lp) & "</span>" & chkIIF(lp<ubound(arrOffShopList,2),", ","")
										Next
									%>
									<% If dicStore.Exists(firstDic) Then %>
										<div class="lMar10 infoMoreViewV15" style="z-index:48;">
											<a href="javascript:viewPoupLayer('modal', $('#lyr-offshop').html());offLineGoogleMapinitialize('<%=dicStore(firstDic)(4)%>', '<%=dicStore(firstDic)(5)%>', '<%=dicStore(firstDic)(6)%>', '<%=dicStore(firstDic)(7)%>', 'opoffmap');"><span class="more1V15">매장정보 안내</span></a>
										</div>
									<% End If %>
										<!--div class="lMar05 infoMoreViewV15" style="z-index:48;">
											<span class="more1V15">확인사항</span>
											<div class="infoViewLyrV15">
												<div class="infoViewBoxV15">
													<dfn></dfn>
													<div class="infoViewV15">
														<div class="pad20">
														구매 가능한 재고와 판매가격은 매장별로 다를 수 있으니,<br />매장에 확인 후 방문해주세요.
														<% if itemid=1828808 then 'GS샾과의 콜라보 상품으로 2개매장 정보 추가 %>
														<br /><br />대학로점 : 02-741-9010 (영업시간 11:00 ~ 22:30)
														<br />DDP점 : 02-2153-0734 (영업시간 10:00 ~ 21:00)
														<% end if %>
														</div>
													</div>
												</div>
											</div>
										</div-->
										<%' 오프매장 안내 팝업(20171129) %>
										<div id="lyr-offshop">
											<div class="lyr-offshop window">
												<div class="inner">
													<h4><img src="http://fiximage.10x10.co.kr/web2017/shopping/tit_offshop.png" alt="판매 매장 안내" /></h4>
													<p class="fs13">구매 가능한 재고와 판매가격은 매장별로 다를 수 있으니, 매장에 확인 후 방문해주세요.</p>
													<div class="shop-list-container">
														<div class="bPad10">
															<p><strong>전체</strong> <%=ubound(arrOffShopList,2)+1%></p>
														</div>
														<div class="shop-list">
															<%
																for lp=0 to ubound(arrOffShopList,2)
																	if dicStore.Exists(arrOffShopList(0,lp)) then
															%>
																		<dl class="shop-unit" onclick="offLineGoogleMapinitialize('<%=dicStore(arrOffShopList(0,lp))(4)%>', '<%=dicStore(arrOffShopList(0,lp))(5)%>', '<%=dicStore(arrOffShopList(0,lp))(6)%>', '<%=dicStore(arrOffShopList(0,lp))(7)%>', this);return false;"><%' for dev msg : 선택 매장 클래스명 selected 추가해주세요 %>
																			<dt>
																				<strong><%=dicStore(arrOffShopList(0,lp))(0)%></strong>
																				<p><%=dicStore(arrOffShopList(0,lp))(1)%></p>
																			</dt>
																			<dd>
																				<strong class="info-time">영업시간</strong>
																				<span><b><%=dicStore(arrOffShopList(0,lp))(2)%></b> (휴무시 별도 공지)</span>
																			</dd>
																			<dd>
																				<strong class="info-tel">매장문의</strong>
																				<span><b><%=dicStore(arrOffShopList(0,lp))(3)%></b></span>
																			</dd>
																		</dl>
															<%
																	End if
																next
															%>
														</div>

														<div class="ftRt">
															<div id="mapView" style="width:400px; height:400px;"></div>
															<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>
															<script>
																function offLineGoogleMapinitialize(Y, X, MarkerTitle, ContentString, t) {
																	if (t == 'opoffmap')
																	{
																		$(".shop-list .shop-unit").eq(0).addClass('selected');
																	}
																	else
																	{
																		$(".shop-list .shop-unit").removeClass('selected');
																		$(t).addClass('selected');
																	}
																	var Y_point = Y; // Y 좌표
																	var X_point = X; // X 좌표
																	var zoomLevel = 15; // 첫 로딩시 보일 지도의 확대 레벨
																	var markerTitle = MarkerTitle; // 현재 위치 마커에 마우스를 올렸을때 나타나는 이름
																	var markerMaxWidth = 300; // 마커를 클릭했을때 나타나는 말풍선의 최대 크기
																	// 말풍선 내용
																	var contentString = ContentString;

																	var myLatlng = new google.maps.LatLng(Y_point, X_point);
																	var mapOptions = {
																		zoom: zoomLevel,
																		center: myLatlng,
																		draggable: true,
																		mapTypeControl:false,
																		zoomControlOptions: {
																			style:google.maps.ZoomControlStyle.SMALL,
																			position: google.maps.ControlPosition.RIGHT_TOP
																		},
																		streetViewControl:false,
																		mapTypeId: google.maps.MapTypeId.ROADMAP,
																		gestureHandling: 'greedy'
																	}
																	var map = new google.maps.Map(document.getElementById('mapView'), mapOptions);
																	var marker = new google.maps.Marker({
																		position: myLatlng,
																		map: map,
																		title: markerTitle
																	});

																	var infowindow = new google.maps.InfoWindow(
																		{
																		content: contentString,
																		maxWidth: markerMaxWidth
																		}
																	);

																	google.maps.event.addListener(marker, 'click', function() {
																		infowindow.open(map, marker);
																	});
																}
															</script>
														</div>
													</div>
													<button type="button" class="btn-close" onclick="ClosePopLayer();">레이어 닫기</button>
												</div>
											</div>
										</div>
										<%
											set dicStore = nothing
										%>
										<%'// 오프매장 안내 팝업(20171129) %>
									</dd>
								</dl>
								<%
									end if
								End If

								Dim vOneAndOne, vOneAndOneSDate
								vOneAndOne = getDiaryoneandonegubun2(itemid)
								If vOneAndOne <> "" Then
									vOneAndOneSDate = Split(vOneAndOne,"||")(1)
									vOneAndOne = Split(vOneAndOne,"||")(0)
								End If

								if giftsu > 0 then %>
									<dl class="saleInfo">
										<dt>
											<%
												if vOneAndOne="" then
													'response.write "사은품"
												else
													if vOneAndOne="1" then
														response.write "1+1"
													elseif vOneAndOne="2" then
														response.write "1:1"
												'	else
												'		response.write "사은품"
													end if
												end if
											%><% if vOneAndOne="1" or vOneAndOne="2" then %> 남은수량 <% end if %>
										</dt>
										<% if vOneAndOne="1" or vOneAndOne="2" then %>
											<dd><strong class="cRd0V15"><%= giftsu %>개</strong></dd>
										<% end if %>
									</dl>
								<% else %>
									<%
									If date() = CDate(vOneAndOneSDate) Then
										if vOneAndOne <> "" then %>
										<dl class="saleInfo">
											<dt>
												<%
													if vOneAndOne="" then
														response.write "사은품"
													else
														if vOneAndOne="1" then
															response.write "1+1"
														elseif vOneAndOne="2" then
															response.write "1:1"
														else
															response.write "사은품"
														end if
													end if
												%> 남은수량
											</dt>
											<dd><strong class="cRd0V15">0 개</strong></dd>
										</dl>
									<%
										GiftNotice=True '사은품 소진 노티
										end if
									end if
									%>
								<% end if %>
							</div>
							<% If (IsTicketItem) Then '티켓상품 %>
							<div class="detailInfoV15">
								<dl class="saleInfo">
									<dt>장르</dt>
									<dd><% = oTicket.FOneItem.FtxGenre %></dd>
								</dl>
								<dl class="saleInfo">
									<dt>일시</dt>
									<dd><%= FormatDate(oTicket.FOneItem.FstDt,"0000.00.00") %>~<%= FormatDate(oTicket.FOneItem.FedDt,"0000.00.00") %></dd>
								</dl>
								<dl class="saleInfo">
									<dt>시간</dt>
									<dd><%= oTicket.FOneItem.FtxRunTime%></dd>
								</dl>
								<dl class="saleInfo">
									<dt>장소</dt>
									<dd><%= oTicket.FOneItem.FticketPlaceName %></dd>
								</dl>
								<dl class="saleInfo">
									<dt>등급</dt>
									<dd><%= oTicket.FOneItem.FtxGrade%></dd>
								</dl>
							</div>
							<% end if %>
							<% If Not(isBizNotConfirm) Then %>
								<div class="detailInfoV15">
									<dl class="saleInfo">
										<dt><%=chkIIF(IsTicketItem,"예매수량","주문수량")%></dt>
										<dd id="lyItemEa" style="margin-top:-2px;">
										<% if Not(IsPresentItem) then %>
											<input type="text" id="itemea" style="width:30px" class="txtInp ct" />
											<span class="orderNumAtc"></span>
											<script type="text/javascript">
											$("#itemea").numSpinner({min:<%=chkIIF(oItem.Prd.IsLimitItemReal and oItem.Prd.FRemainCount<=0,"0",oItem.Prd.ForderMinNum)%>,max:<%=chkIIF(oItem.Prd.IsLimitItemReal,CHKIIF(oItem.Prd.FRemainCount<=oItem.Prd.ForderMaxNum,oItem.Prd.FRemainCount,oItem.Prd.ForderMaxNum),oItem.Prd.ForderMaxNum)%>,step:1,value:1});
											</script>
										<% else %>
											<input type="hidden" name="itemea" value="1" />
											<span>1</span>개 (한번에 하나씩만 구매가 가능합니다.)
										<% end if %>
										</dd>
									</dl>
								</div>
								<% If G_IsPojangok Then %>
								<% If oItem.Prd.IsPojangitem Then %>
								<div class="detailInfoV15">
									<dl class="saleInfo wrappingInfoV15a">
										<dt>선물포장</dt>
										<dd>
											<b class="ico cRd0V15 fn"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="" /> 포장가능</b>
											<a href="#lyWrappingV15a" onclick="fnOpenModal('/shopping/pop_wrappingInfo.html');return false;"><span class="more1V15">선물포장 안내</span></a>
										</dd>
									</dl>
								</div>
								<% End If %>
								<% End If %>
								<div class="detailInfoV15">
									<% if (oItem.Prd.FItemDiv = "06") and (Not ISFujiPhotobook) then %>
									<dl class="saleInfo" <%=chkIIF(oItem.Prd.FOptionCnt>0,"style=""display:none;""","")%>>
										<dt>문구입력란</dt>
										<dd style="margin-top:-2px;">
											<textarea style="width:330px; height:50px;" name="requiredetail" id="requiredetail"></textarea>
										</dd>
									</dl>
									<% end if %>
									<% IF oItem.Prd.FOptionCnt>0 then %>
									<dl class="saleInfo">
										<dt>옵션선택</dt>
										<dd style="margin-top:-2px;">
											<p class="itemoption">
											<% if (IsReceiveSiteItem) or (IsPresentItem) or (IsTicketItem) or (oItem.Prd.Flimitdispyn="N") then %>
											<%= GetOptionBoxDpLimitHTML(itemid, oitem.Prd.IsSoldOut, Not(IsReceiveSiteItem) and Not(IsPresentItem and oItem.Prd.FRemainCount>200) and Not(IsTicketItem and oItem.Prd.FRemainCount>100) and Not(oItem.Prd.Flimitdispyn="N")) %>
											<% else %>
											<%= GetOptionBoxHTML(itemid, oitem.Prd.IsSoldOut) %>
											<% end if %>
											</p>
											<% if (oItem.Prd.FItemDiv = "06") and (Not ISFujiPhotobook) then %>
											<p class="tPad10">옵션을 선택하시면 원하는 문구를 입력하실 수 있습니다.</p>
											<% end if %>
											<% If isAlarmOptionPushChk Then %>
											<p class="tPad10"><a href="javascript:popStock();" class="stock-alarm"><span class="more1V15">품절된 옵션 재입고 알림 받기</span></a></p>
											<% End If %>
										</dd>
									</dl>
									<% end if %>
								</div>
							<% End If %>
							<!-- 플러스 할인 plus sale -->
							<!-- #include file="./inc_PlusSale.asp" -->

							<!-- 간편선택 바구니 -->
							<div id="lySpBag" style="display:none;">
								<div class="easeCartV15">
									<div class="easeTxtV15">
										<p>다른옵션도 구매하시려면 옵션을 반복하여 선택해 주세요.</p>
									</div>
									<div class="optSelectListWrap">
										<table class="optSelectList">
											<caption>상품 옵션별 선택 리스트</caption>
											<colgroup>
												<col width="*" /><col width="100px" /><col width="75px" /><col width="18px" />
											</colgroup>
											<tbody id="lySpBagList"></tbody>
										</table>
									</div>
									<div class="totalPrice">
										<span>상품 금액 합계</span>
										<strong><span id="spTotalPrc">0원</span></strong>
									</div>
								</div>
								<p class="rt tPad10 cGy1V15">(쿠폰 적용은 주문결제 단계에서 가능합니다.)</p>
							</div>

							<!-- 주문 확인 사항 -->
							<% IF oItem.Prd.FAvailPayType="9" OR oItem.Prd.FAvailPayType="8" or IsPresentItem or oItem.Prd.FrequireMakeDay>0 Then %>
							<div class="checkContV15">
								<dl class="saleInfo">
									<dt>필수 확인사항</dt>
									<dd>
										<ul class="checkListV15">
										<% IF oItem.Prd.FAvailPayType="9" OR oItem.Prd.FAvailPayType="8" Then %>
											<li>선착순 판매 상품은 실시간 결제로만 구매 가능(무통장 결제 불가)</li>
										<% end if %>
										<% if oItem.Prd.FrequireMakeDay>0 then %>
											<li>상품 발송 전 <strong>상품제작 예상기간 <%=oItem.Prd.FrequireMakeDay%>일 소요</strong> 예상</li>
										<% end if %>
										<% if (IsPresentItem) then %>
											<li>텐바이텐 회원만 주문 가능</li>
											<li>일반상품과 함께 주문 불가 (단독주문)</li>
											<li>한 ID당 1회 주문 가능</li>
											<% '// 텐텐배송 2500으로 변경 %>
											<% If (Left(Now, 10) >= "2019-01-01") Then %>
												<li>주문 건당 2,500원의 배송비 부과</li>
											<% Else %>
												<li>주문 건당 2,000원의 배송비 부과</li>
											<% End If %>
										<% end if %>
										</ul>
									</dd>
								</dl>
							</div>
							<% end if %>
						</form>
						<form name="BagArrFrm" method="post" action="" onsubmit="return false;" >
						<input type="hidden" name="mode" value="arr">
						<input type="hidden" name="bagarr" value="">
						<input type="hidden" name="giftnotice" value="<%=GiftNotice%>">
						</form>
						</div>
						<div class="pdtAddInfoV15">
							<div class="pdtTagV15">
								<% if oItem.Prd.IsNewItem then %><p><img src="http://fiximage.10x10.co.kr/web2015/shopping/tag_new.png" alt="NEW" /></p><% end if %>
								<% if oItem.Prd.isBestRankItem then %><p><img src="http://fiximage.10x10.co.kr/web2015/shopping/tag_best.png" alt="BEST" /></p><% end if %>
							</div>
							<div class="interactInfoV15">
								<dl>
									<dt>상품코드</dt>
									<dd><% = oitem.Prd.FItemid %></dd>
								</dl>
								<dl>
									<dt>Review</dt>
									<dd><img id="rtRvImg" src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_00.png" alt="별점" /></dd>
									<% if oItem.Prd.FEvalCnt>0 then %>
									<dd>(<a href="" onClick="goToByScroll('2'); return false;"><%=oItem.Prd.FEvalCnt%></a>)</dd>
									<% else %>
									<dd>(<a href="<%=SSLUrl%>/my10x10/goodsUsing.asp?EvaluatedYN=N">쓰기</a>)</dd>
									<% end if %>
								</dl>
								<% IF oItem.Prd.FItemDiv <> "23" THEN %>
                                    <dl>
                                        <dt>Gift Talk
                                            <div class="infoMoreViewV15a">
                                                <span class="vMid">
                                                    <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="12" height="12" viewBox="0 0 12 12">
                                                        <g fill="none" fill-rule="evenodd">
                                                            <path fill="#555" d="M6.142 7.169c-.063.02-.127.031-.19.031-.251 0-.485-.159-.57-.41-.104-.315.066-.654.38-.76.36-.121 1.39-.61 1.39-1.23 0-.51-.321-.966-.801-1.134-.624-.22-1.31.109-1.531.733-.11.313-.452.477-.766.367-.312-.11-.476-.452-.366-.765.44-1.249 1.813-1.905 3.06-1.468.961.338 1.606 1.25 1.604 2.268 0 1.586-1.984 2.293-2.21 2.368M6.006 9.6c-.332 0-.603-.269-.603-.6 0-.332.265-.6.597-.6h.006c.331 0 .6.268.6.6 0 .331-.269.6-.6.6M6 0C2.686 0 0 2.686 0 6c0 3.313 2.686 6 6 6 3.313 0 6-2.687 6-6 0-3.314-2.687-6-6-6"/>
                                                        </g>
                                                    </svg>
                                                </span>
                                                <div class="infoViewLyrV15a">
                                                    <div class="infoViewBoxV15a">
                                                        <dfn></dfn>
                                                        <div class="infoViewV15a">
                                                            <div class="pad15">텐텐 가족들이 여러분의 선물 고민을 해결해 드립니다!<br />마음을 전하는 선물가이드, 텐바이텐 기프트톡!</div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </dt>
                                        <dd>(<% if vTalkCnt>0 then %><a href="<%=SSLUrl%>/gift/talk/search.asp?itemid=<%=itemid%>"><%=vTalkCnt%></a> ㅣ <% end if %><a href="" onClick="frmtalk.submit(); return false;">쓰기</a>)</dd>
                                    </dl>
                                <% END IF %>
							</div>
						</div>
					</div>
					<% If Not(isBizNotConfirm) Then %>
						<div class="btnArea">
						<%	'### 상품 종류 : 일반, 포토북, 티켓	(Case 정리; 2011-04-20 강준구.)
							Dim vBuyButton : vBuyButton = ""
							Dim vBuyAlert		'장바구니 담기 안내 팝업레이어
							vBuyAlert = "<div class=""alertLyrV15"" style=""display:none;"">" & vbCrLf
							vBuyAlert = vBuyAlert & "	<div class=""alertBox"">" & vbCrLf
							vBuyAlert = vBuyAlert & "		<em class=""closeBtnV15"" onclick=""$('.alertLyrV15').fadeOut('fast');"">&times;</em>" & vbCrLf
							vBuyAlert = vBuyAlert & "		<div class=""alertInner"">" & vbCrLf
							vBuyAlert = vBuyAlert & "			<p><strong class=""cBk0V15"" id=""alertMsgV15"">선택하신 상품을<br />장바구니에 담았습니다.</strong></p>" & vbCrLf
							vBuyAlert = vBuyAlert & "			<p class=""tPad10"">" & vbCrLf
							vBuyAlert = vBuyAlert & "				<a href=""#"" onclick=""$('.alertLyrV15').fadeOut('fast'); return false;"" class=""btn btnS1 btnRed"">쇼핑 계속하기</a>" & vbCrLf
							vBuyAlert = vBuyAlert & "				<a href=""" & SSLUrl & "/inipay/shoppingbag.asp"" class=""btn btnS1 btnWhite"">장바구니 가기</a>" & vbCrLf
							vBuyAlert = vBuyAlert & "			</p>" & vbCrLf
							vBuyAlert = vBuyAlert & "		</div>" & vbCrLf
							vBuyAlert = vBuyAlert & "	</div>" & vbCrLf
							vBuyAlert = vBuyAlert & "</div>" & vbCrLf


							If oItem.Prd.isSoldout or oItem.Prd.isTempSoldOut Then	'### 일반, 포토북, 티켓 품절일 경우
								'vBuyButton = vBuyButton & "<span style=""width:390px;""><a href=""#"" class=""btn btnB1 btnGry"" onclick=""return false;"">SOLD OUT</a></span>"
								vBuyButton = vBuyButton & "<span style='width:390px;'><a href='javascript:popStock();' class='btn btnB1 btnWhite btn-stock'><em>재입고 알림</em></a></span>"
							Else
								If (ISFujiPhotobook) Then	'### 포토북 일 경우
									vBuyButton = vBuyButton & "<span style=""width:390px;""><a href=""#"" onclick=""loadPhotolooks('" & itemid & "'); return false;"" class=""btn btnB1 btnRed"">포토북 편집 후 구매</a></span>"
								ElseIf (isPresentItem) Then	'### Present상품일 경우
									If IsUserLoginOK() Then		'# 로그인한 경우
										vBuyButton = vBuyButton & "<span style=""width:190px;""><a href=""#"" onclick=""appierProductFunction('click_directorder_in_product', 'present');TnAddShoppingBag();fnGaSendCheckValue();amplitude_click_directorder_in_product();return false;"" class=""btn btnB1 btnRed"">바로신청</a></span>"
										vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15"" style=""width:190px;""><a href=""#"" onclick=""appierProductFunction('product_added_to_cart');FnAddShoppingBag(true);fnGaSendCheckValue(true); branchAddToCartEventLoging();amplitude_click_shoppingbag_in_product();return false;"" class=""btn btnB1 btnWhite"">장바구니</a>" & vBuyAlert & "</span>"
									Else
										vBuyButton = vBuyButton & "<span style=""width:190px;""><a href=""#"" onclick=""jsChkConfirmLogin('회원 구매만 가능합니다. 로그인 후 구매해 주세요.'); return false;"" class=""btn btnB1 btnRed"">바로신청</a></span>"
										vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15"" style=""width:190px;""><a href=""#"" onclick=""jsChkConfirmLogin('회원 구매만 가능합니다. 로그인 후 장바구니에 담아 주세요.'); return false;"" class=""btn btnB1 btnWhite"">장바구니</a></span>"
									End If
								ElseIf (IsSpcTravelItem) Then	'### 스페셜 항공권 상품일 경우
									If IsUserLoginOK() Then		'# 로그인한 경우
										vBuyButton = vBuyButton & "<span style=""width:390px;""><a href=""#"" onclick=""appierProductFunction('click_directorder_in_product', 'specialtravel');TnAddShoppingBag();fnGaSendCheckValue();branchAddToCartEventLoging();amplitude_click_directorder_in_product();return false;"" class=""btn btnB1 btnRed"">바로구매</a></span>"
									Else
										vBuyButton = vBuyButton & "<span style=""width:390px;""><a href=""#"" onclick=""jsChkConfirmLogin('회원 구매만 가능합니다. 로그인 후 구매해 주세요.'); return false;"" class=""btn btnB1 btnRed"">바로구매</a></span>"
									End If
								ElseIf (oItem.Prd.IsReserveItem) Then '#단독(예약)구매 상품인 경우
									If (isRentalItem) Then '// 렌탈 상품일 경우..
										vBuyButton = vBuyButton & chkIIF(oItem.Prd.IsMileShopitem,"","<span style=""width:290px;""><a href=""#"" onclick=""appierProductFunction('click_directorder_in_product', 'normal');FnAddShoppingBag();fnGaSendCheckValue();branchAddToCartEventLoging();amplitude_click_directorder_in_product();return false;"" class=""btn btnB1 btnRed"">렌탈하기</a></span>")
									Else
										vBuyButton = vBuyButton & chkIIF(oItem.Prd.IsMileShopitem,"","<span style=""width:290px;""><a href=""#"" onclick=""appierProductFunction('click_directorder_in_product', 'normal');FnAddShoppingBag();fnGaSendCheckValue();branchAddToCartEventLoging();amplitude_click_directorder_in_product();return false;"" class=""btn btnB1 btnRed"">바로구매</a></span>")
									End If
								ElseIf (isRentalItem) Then	'### 이니렌탈 상품일 경우
									If IsUserLoginOK() Then		'# 로그인한 경우
										vBuyButton = vBuyButton & "<span style=""width:190px;""><a href=""#"" onclick=""appierProductFunction('click_directorder_in_product', 'normal');TnAddShoppingBag();fnGaSendCheckValue();amplitude_click_directorder_in_product();return false;"" class=""btn btnB1 btnRed"">렌탈하기</a></span>"
										vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15"" style=""width:190px;""><a href=""#"" onclick=""appierProductFunction('product_added_to_cart');FnAddShoppingBag(true);fnGaSendCheckValue(true); branchAddToCartEventLoging();return false;"" class=""btn btnB1 btnWhite"">장바구니</a>" & vBuyAlert & "</span>"
									Else
										vBuyButton = vBuyButton & "<span style=""width:190px;""><a href=""#"" onclick=""jsChkConfirmLogin('회원 구매만 가능합니다. 로그인 후 구매해 주세요.'); return false;"" class=""btn btnB1 btnRed"">렌탈하기</a></span>"
										vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15"" style=""width:190px;""><a href=""#"" onclick=""jsChkConfirmLogin('회원 구매만 가능합니다. 로그인 후 장바구니에 담아 주세요.'); return false;"" class=""btn btnB1 btnWhite"">장바구니</a></span>"
									End If
								Else
									If (Not IsTicketItem) Then	'### 일반 상품인 경우
										vBuyButton = vBuyButton & chkIIF(oItem.Prd.IsMileShopitem,"","<span style=""width:190px;""><a href=""#"" onclick=""appierProductFunction('click_directorder_in_product', 'normal');FnAddShoppingBag();fnGaSendCheckValue(); branchAddToCartEventLoging();amplitude_click_directorder_in_product();return false;"" class=""btn btnB1 btnRed"">바로구매</a></span>")
										vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15"" style=""width:190px;""><a href=""#"" id=""btn_shoppingbag"" onclick=""appierProductFunction('product_added_to_cart');FnAddShoppingBag(true);fnGaSendCheckValue(true); branchAddToCartEventLoging();amplitude_click_shoppingbag_in_product();return false;"" class=""btn btnB1 btnWhite"">장바구니</a>" & vBuyAlert & "</span>"
									Else
										'### 티켓 상품인 경우
										If Not oTicket.FOneItem.IsExpiredBooking Then	'판매 기간중 일 경우
											If IsUserLoginOK() Then		'# 로그인한 경우
												vBuyButton = vBuyButton & "<span style=""width:190px;""><a href=""#"" onclick=""FnAddShoppingBag();fnGaSendCheckValue();branchAddToCartEventLoging();amplitude_click_directorder_in_product();return false;"" class=""btn btnB1 btnRed"">바로신청</a></span>"
												vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15"" style=""width:190px;""><a href=""#"" id=""btn_shoppingbag"" onclick=""FnAddShoppingBag(true);fnGaSendCheckValue(true);branchAddToCartEventLoging();amplitude_click_shoppingbag_in_product();return false;"" class=""btn btnB1 btnWhite"">장바구니</a>" & vBuyAlert & "</span>"
											Else
												vBuyButton = vBuyButton & "<span style=""width:190px;""><a href=""#"" onclick=""jsChkConfirmLogin('회원 구매만 가능합니다. 로그인 후 구매해 주세요.'); return false;"" class=""btn btnB1 btnRed"">바로신청</a></span>"
												vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15"" style=""width:190px;""><a href=""#"" onclick=""jsChkConfirmLogin('회원 구매만 가능합니다. 로그인 후 장바구니에 담아 주세요.'); return false;"" class=""btn btnB1 btnWhite"">장바구니</a></span>"
											End If
										Else
											vBuyButton = vBuyButton & "<span style=""width:390px;""><a href=""#"" class=""btn btnB1 btnGry"" onclick=""return false;"">SOLD OUT</a></span>"
										End IF
									End IF
								End IF
							End IF
							If oItem.Prd.FAdultType <> 0 and session("isAdult")<>True then
								vBuyButton = "<span style=""width:190px;""><a href=""#"" onclick=""confirmAdultAuth('"&Server.URLencode(CurrURLQ())&"');"" class=""btn btnB1 btnRed"">바로구매</a></span>"
								vBuyButton = vBuyButton & "<span class=""lPad10 btnCartV15"" style=""width:190px;""><a href=""#"" onclick=""confirmAdultAuth('"&Server.URLencode(CurrURLQ())&"');"" class=""btn btnB1 btnWhite"">장바구니</a>" & vBuyAlert & "</span>"
							End If
							Response.Write vBuyButton
						%>
							<% If Not isBizItem Then %>
							    <span class="lPad10" style="*width:168px;"><a href="" id="wsIco<%=Itemid %>" onclick="TnAddFavoritePrd(<%=itemid%>);appierProductFunction('product_added_to_wishlist');amplitude_click_wish_in_product();return false;" class="btn btnB1 btnWhite3 <%=chkIIF(isMyFavItem,"myWishMarkV15","")%>"><em class="wishActionV15"><%= FormatNumber(oItem.Prd.FfavCount,0) %></em></a></span>
							<% End If %>
						</div>
					<% Else %>
						<div class="notiNomember">
							<p>가입이 승인된 BIZ 회원만 상품 구매가 가능합니다</p>
						</div>
					<% End If %>

					<div class="evtSnsV17a">
						<% if cFlgDBUse then %>
						<!-- ### 관련 이벤트 event -->
						<!-- #Include File="./inc_ItemEventList.asp" -->
						<% end if %>
						<ul class="pdtSnsV15">
							<li class="twShareV15"><a href="" onclick="shareProduct('tw','<%=snpPre%>','<%=snpTag2%>',''); return false;">Twitter</a></li>
							<li class="fbShareV15"><a href="" onclick="shareProduct('fb','','',''); return false;">Facebook</a></li>
							<li class="ptShareV15"><a href="" onclick="shareProduct('pt','','','<%=snpImg%>'); return false;">Pinterest</a></li>
						</ul>
					</div>
				</div>
			</div>

			<%'// 비공개 상품일 경우엔 추천영역 자체를 숨김(2015.10.07원승현 수정)%>
			<% If catecode <> "0" AND oItem.Prd.FItemDiv <> "23" Then %>
				<% If False Then %>
				<!-- 추천상품 -->
				<!--div class="recommendItemV15" id="recommenditem" style="display:none;">
					<ul class="itemNaviV15">
						<li class="item02"><a href="#rcmdPrd02" class="on" onclick="return false;">HAPPY TOGETHER</a></li>
						<li class="item01"><a href="#rcmdPrd01" onclick="return false;">CATEGORY BEST</a></li>
						<li class="item03"><a href="#rcmdPrd03" onclick="return false;">BRAND BEST</a></li>
					</ul>
					<div class="itemContainerV15">
						<script type="text/javascript">
							var vIId='<%=itemid%>', vDisp='<%=catecode%>';
						</script>
						<script type="text/javascript" src="./inc_happyTogether.js"></script>
						<!-- # Happy Together
						<div id="rcmdPrd02" class="itemContV15"></div>
						<!-- # Category Best
						<div id="rcmdPrd01" class="itemContV15">
						<!-- # Include File="./inc_categoryBestItem.asp" -->
						<!--/div-->
						<!-- #Brand Best
						<div id="rcmdPrd03" class="itemContV15">
						<!-- # Include File="./inc_brandBestItem.asp" -->
						<!--/div>
					</div>
				</div>
				<!--// 추천상품 -->
				<% End If %>
				<%'// 2017.06.08 수정 해피투게더만 (원승현) %>
				<script type="text/javascript">
					<% if InStr(request.QueryString("rdsite"),"nvshop")>0 then %>
					var vIId='<%=itemid%>', vDisp='<%=catecode%>&rtype=1';
					<% else %>
					var vIId='<%=itemid%>', vDisp='<%=catecode%>';
					<% end if %>
				</script>
				<script type="text/javascript" src="./inc_happyTogether.js"></script>
				<div id="rcmdPrd"></div>
			<% End If %>

			<div class="pdtDetailV15 <%=chkiif(isBizMode = "Y", "pdtBizDetail tMar10", "")%>">
				<!-- 상품 TAB -->
				<div id="lyrPrdTabLink" class="pdtTabLinkV15">
					<ul>
					<% If IsPresentItem then 'Present상품 %>
						<li id="tab01" onclick="goToByScroll('1');"><p>상품 설명</p></li>
						<% if cFlgDBUse then %>
						<li id="tab02" onclick="goToByScroll('2');"><p>10x10 Present 후기 <span class="fn">(<strong class="fs11"><%= oItem.Prd.FEvalCnt %></strong>)</span></p></li>
						<% end if %>
					<% ElseIf (Not IsTicketItem) Then '티켓아닌경우 - 일반상품 %>
						<li id="tab01" onclick="goToByScroll('1');"><p>상품 설명</p></li>
						<% if cFlgDBUse then %>
						<li id="tab02" onclick="goToByScroll('2');"><p>상품 후기 (<strong class="fs11"><%= oItem.Prd.FEvalCnt %></strong>)</p></li>
						<li id="tab03" onclick="goToByScroll('3');" style="display:none;"><p>테스터 후기 <span class="fn">(<strong class="fs11"><span id="lyTesterCnt">0</span></strong>)</span></p></li>
						<li id="tab04" style="display:none;" onclick="goToByScroll('4');"><p>Q&amp;A <span class="fn">(<strong class="fs11"><span id="lyQnACnt">0</span></strong>)</span></p></li>
						<% end if %>
						<li id="tab06" onclick="goToByScroll('6');"><p><%=CHKIIF(oitem.Prd.IsTravelItem,"유의사항/취소/환불","배송/교환/환불")%></p></li>
					<% Else %>
						<li id="tab01" onclick="goToByScroll('1');"><p>티켓 정보</p></li>
						<li id="tab05" onclick="goToByScroll('5');"><p>위치 정보</p></li>
						<% if cFlgDBUse then %>
						<li id="tab02" onclick="goToByScroll('2');"><p>후기 <span class="fn">(<strong class="fs11"><%= oItem.Prd.FEvalCnt %></strong>)</span></p></li>
						<li id="tab04" style="display:none;" onclick="goToByScroll('4');"><p>Q&amp;A <span class="fn">(<strong class="fs11"><span id="lyQnACnt">0</span></strong>)</span></p></li>
						<% end if %>
						<li id="tab06" onclick="goToByScroll('6');"><p>티켓수령 및 취소/환불</p></li>
					<% end if %>
					<% if cFlgDBUse and Not(IsTicketItem) and Not(IsPresentItem) AND oItem.Prd.FItemDiv <> "23" then %>
						<li id="tab07" onclick="goToByScroll('7');"><p>WISH COLLECTION</p></li>
					<% end if %>
					</ul>
					<!-- 다스배너 -->
					<%' //<a href="/diarystory2022/" class="bnr-diary"><img src="//fiximage.10x10.co.kr/web2021/diary2022/bnr_sm_diary2022.png?v=2" alt=""><span style="display:none;">2022 다이어리 준비하셨나요?</span></a> %>
				</div>

				<!-- 상품 설명 -->
				<div class="section pdtExplanV15" id="detail01">
                    <% if Left(oItem.Prd.FcateCode,9) = "119113" then %>
					<%'<!-- 주류 통신판매에 관한 명령위임고시 2021-09-06 태훈 -->%>
                    <div class="notiV17 notiV21 notiGray">
						<span class="ico"></span>
						<div class="texarea">
							<div class="inner">
								<h3>주류의 통신판매에 관한 안내</h3>
								<p class="txt">
									- 관계법령에 따라 19세 미만 미성년자는 주류상품을 구매할 수 없습니다.<br>
									- 19세 이상 성인인증을 하셔야 구매가능한 상품입니다.<br>
									- 사업자 회원은 구매가 불가능한 상품입니다.
								</p>
							</div>
						</div>
					</div>
					<% end if %>
					<% '// 설 연휴 배송안내 %>
					<% if now() >= "2019-01-28" And now() < "2019-02-07" Then %>
						<% if oitem.Prd.IsTenBeasong then %>
							<div class="notiV18 notiDelivery">
								<p><span class="ico"></span>설 연휴 배송 안내</p>
								<div>
									<strong>텐바이텐 배송</strong><br/>
									1월 30일 오후 3시 마감 (도서산간 지역 29일 마감)
									<br/><br/>
									<strong>바로 배송</strong><br/>
									2월 1일 오후 1시 마감
									<br /><br />
									※ 이후 주문 건은 2월 7일부터 발송될 예정입니다.
								</div>
							</div>
						<% end if %>
					<% End If %>
					<% '// 설 연휴 배송 안내 %>
					<!-- (1/9) 주문 유의 사항&브랜드 공지 --------------------------->
					<!-- #include file="./inc_OrderNotice.asp" -->

					<!-- (2/9) 상품설명 -------------------------------->
					<!-- #include file="./inc_ItemDescription.asp" -->

					<!-- (3/9) 상품 필수정보(고시정보) ----------------->
					<!-- #include file="./inc_ItemInfomation.asp" -->
				</div>
				<!-- //상품 설명 -->

				<!-- 플러스 메인 상품일 경우 서브상품 표시, 서브상품일 경우 메인상품 표시-->
				<!-- #include file="./inc_PlusProductList.asp" -->

				<!-- 다스배너 -->
                <% If now() >= #2021-12-25 23:59:59# Then %>
                <% Else %>
                <div class="ct" style="margin-top:-30px;"><a href="/diarystory2021/"><img src="//fiximage.10x10.co.kr/web2021/diary2022/bnr_big_diary2022_02.png" alt="12월인데 아직 다이어리 구매 안 한 사람 있니?"></a></div>
                <% End If %>
				<% if cFlgDBUse then %>
					<% if IsTicketItem and Not(IsPresentItem) then %>
					<!-- (7/9) 위치 정보 ------------------------------------->
					<!-- #include file="./inc_ticketPlaceInfo.asp" -->
					<% end if %>

					<!-- (4/9) 상품후기 -------------------------------->
					<!-- #include file="./inc_itemEvaluate.asp" -->

					<!-- (5/9) 테스트후기 ------------------------------>
					<!-- #include file="./inc_testerEvaluate.asp" -->

					<!-- (6/9) Q&A ------------------------------------->
					<!-- #include file="./inc_itemQnA.asp" -->

					<%
						Dim vDescriptionGubun: vDescriptionGubun = "itemdetail"
						If oItem.Prd.FItemDiv = "18" AND oItem.Prd.Fmakerid = "interparktour" Then	'### 여행상품인경우
					%>
					<!-- #include virtual="/shopping/inc_TravelItem_description_interparktour.asp" -->
					<% End If %>

					<% If IsSpcTravelItem Then	'### 스페셜 항공권 상품인경우
					%>
					<!-- #include virtual="/shopping/inc_TravelItem_description_Jinair.asp" -->
					<% End If %>
				<% end if %>

				<% If Not(IsPresentItem) AND oitem.Prd.Fitemdiv <> "18" then %>
					<!-- (8/9) 배송/교환/환불 -------------------------->
					<!-- #include file="./inc_DeliveryDescription.asp" -->
				<% End If %>

				<% if cFlgDBUse and Not(IsTicketItem) and Not(IsPresentItem) AND oItem.Prd.FItemDiv <> "23" then %>
					<!-- (8/9) wish 컬렉션 -------------------------->
					<%'// 2017.07.28 수정 (원승현) %>
					<%'// a/b 테스트롤 통해 카테고리 베스트만 하단에 표시 %>
					<% '' 2017/09/27 특정 카테고리는 브랜드를 뿌리자 a/b %>
					<%
						dim iact_catebrdURL : iact_catebrdURL = "act_categoryBestItem.asp?itemid="&itemid&"&catecode="&catecode
						dim isBrndBestView : isBrndBestView=false
						'if (LEFT(catecode,3)="101" or LEFT(catecode,3)="112" or LEFT(catecode,3)="120" or LEFT(catecode,3)="117" or LEFT(catecode,3)="116") then
							''A/B로 나누자
						'	if (RIGHT(request.serverVariables("REMOTE_ADDR"),1) mod 2) = 1 then
						'		iact_catebrdURL = iact_catebrdURL&"&ab=013_a_1"
						'	else
						'		iact_catebrdURL = "act_brandBestItem.asp?itemid="&itemid&"&makerid="&makerid&"&catecode="&catecode&"&ab=013_b_1"
						'		isBrndBestView = true
						'	end if
						'end if
					%>
						<script type="text/javascript">
							$.ajax({
								url: "act_categoryBestItem.asp?itemid=<%=itemid%>&catecode=<%=catecode%>",
								async: true,
								success: function(vRst) {
									if(vRst!="") {
										$("#lyrCateBest").empty().html(vRst);
										$("#tab07").empty().html('<p><%=CHKIIF(isBrndBestView,"BRAND BEST","CATEGORY BEST")%></p>');
									}
									else
									{
										$('#lyrCateBest').hide();
										$("#tab07").hide();
									}
								}
								,error: function(err) {
									//alert(err.responseText);
									$('#lyrCateBest').hide();
									$("#tab07").hide();
								}
							});
						</script>
						<div id="lyrCateBest"></div>
					<!--div id="detail07"><div id="lyrWishCol"></div></div-->
					<script type="text/javascript">
						/*
						$.ajax({
							type: "get",
							url: "act_wishCollection.asp?itemid=<%=itemid%>",
							success: function(message) {
								if(message) {
									$("#lyrWishCol").empty().html(message);
								} else {
									$("#tab07").hide();
								}
							}
						});
						*/
					</script>
				<% End If %>
			</div>
		</div>
	</div>

	<form name="frmtalk" method="post" action="<%=SSLUrl%>/gift/talk/write.asp">
	<input type="hidden" name="isitemdetail" value="o">
	<input type="hidden" name="ritemid" value="<%=itemid%>">
	<script>
	$(function() {
		// 탑메뉴위치값 저장
		if ($("#lyrPrdTabLink").length){
			menuTop = $("#lyrPrdTabLink").offset().top;
		}
		$("#tab01").addClass("current");

		$(window).scroll(function(){
			//메뉴표시 (스크롤 위치가 해당메뉴 위치값을 지나면 탑메뉴 선택표시)
			$('.pdtTabLinkV15 ul li').removeClass('current');
            
			$('.pdtTabLinkV15 ul li').each(function(){
				if ($(this).css("display") != "none"){
					var idnumber = $(this).attr("id");
					idnumber = idnumber.substring(3,5);

					if($("#detail"+idnumber).length < 7) {
						// 아래 셀렉터로 엘리먼트를 찾지 못한경우를 보호
						if ($("#detail"+idnumber).offset() != null) {
							if($(window).scrollTop()>=$("#detail"+idnumber).offset().top-$(".pdtTabLinkV15").outerHeight()-25) {
								$('.pdtTabLinkV15 ul li').removeClass('current');
								$("#tab"+idnumber).addClass("current");
							}
						}
					}else{
						if( $(window).scrollTop()>=$("#detail07").offset().top-$(".pdtTabLinkV15").outerHeight()-160 || $(window).scrollTop()>=($(document).height()-$(window).height())) {
							$('.pdtTabLinkV15 ul li').removeClass('current');
							if($("#tab07").css("display")!="none") {
								$("#tab07").addClass("current");
							} else {
								$("#tab06").addClass("current");
							}
						}
					}
				}
			})

			//탑메뉴 플로팅
			if( $(window).scrollTop()>=menuTop ) {
				//스크롤 위치가 탑메뉴의 위치 보다 크면 플로팅
				$(".pdtTabLinkV15").css("position","fixed");
                $('.bnr-diary').css('display','none' );
			} else {
				//스크롤 위치가 탑메뉴의 위치 보다 작으면 원래위치
				$(".pdtTabLinkV15").css("position","absolute");
				$("#tab01").addClass("current");
                $('.bnr-diary').css('display','block');
			}
		});

		if($('.photoSlideV15 p').length>1) {
			$('.photoSlideV15').slidesjs({
				width:500,
				height:500,
				start:1,
				navigation:{active:true, effect:"fade"},
				pagination:{active:true, effect:"fade"},
				effect:{
					fade:{speed:200, crossfade:true}
				}
			});
			$('.photoSlideV15 .slidesjs-container').mouseover(function(){
				$('.photoSlideV15 .slidesjs-navigation').fadeIn();
			});
			$('.photoSlideV15').mouseleave(function(){
				$('.photoSlideV15 .slidesjs-navigation').fadeOut();
			});
			$('.photoSlideV15 .slidesjs-pagination > li a').append('<span></span>');
			//photo thumbnail pagination control
			$('.photoSlideV15 p img').each(function(i){
				$('.photoSlideV15 .slidesjs-pagination > li').eq(i).children("a").css('background-image', 'url('+$(this).attr("thumb")+')');
			});
			//mouse page control
			$('.photoSlideV15 .slidesjs-pagination > li a').mouseenter(function(){
				$('a[data-slidesjs-item="' + $(this).attr("data-slidesjs-item") + '"]').trigger('click');
			});
		} else {
			$('.photoSlideV15 p img').css({"width":500,"height":500});
			$('.photoSlideV15').append('<ul class="slidesjs-pagination"><li><a href="" class="active" onclick="return false;"><span></span></a></li></ul>');
			$('.photoSlideV15 .slidesjs-pagination > li').css('background-image', 'url('+$('.photoSlideV15 p img').attr("thumb")+')');
		}
	});

	// 품절입고알림 팝업
	function popStock() {
		<% If IsUserLoginOK Then %>
			window.open('pop_stock.asp?itemid=<%=itemid%>','','width=800, height=700, resizable=no, scrollbars=no, status=no');
		<% Else %>
			goLoginPage();
		<% End If %>
		return false;
	}
	</script>
	</form>
	<!-- #include virtual="/lib/inc/incFooterPrdDetail.asp" -->
</div>

    <%' 에코마케팅용 레코벨 스크립트 삽입(2016.12.21) %>
    <script type="text/javascript">
        /*
        window._rblq = window._rblq || [];
        _rblq.push(['setVar','cuid','0f8265c6-6457-4b4a-b557-905d58f9f216']);
        _rblq.push(['setVar','device','PW']);
        _rblq.push(['setVar','itemId','<%=itemid%>']);
    //	_rblq.push(['setVar','userId','{$userId}']); // optional
        _rblq.push(['setVar','searchTerm','<%=vPrtr%>']);
        _rblq.push(['track','view']);
        (function(s,x){s=document.createElement('script');s.type='text/javascript';
        s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+
        '://assets.recobell.io/rblc/js/rblc-apne1.min.js';
        x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
        */
    </script>

    <script>
    // 구글 애널리틱스 관련
    function fnGaSendCheckValue(bool)
    {
        (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
        (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
        m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
        })(window,document,'script','//www.google-analytics.com/analytics.js','ga');
        ga('create', 'UA-16971867-10', 'auto');

        // 구글 애널리틱스 값
        if (bool==true){
            ga('send', 'event', 'UX', 'click', 'add');
        }
        else
        {
            ga('send', 'event', 'UX', 'click', 'DO1');
        }
    }

	function goLoginPage() {
        location.href = '/login/loginpage.asp?backpath=' + encodeURIComponent(location.pathname + location.search);
    }

    // 상품 공유
    <%	'// 쇼셜서비스로 글보내기
        dim snpTitle, snpLink, snpPre, snpTag, snpTag2, snpImg
        snpTitle = Server.URLEncode(oItem.Prd.FItemName)
        snpLink = Server.URLEncode("http://10x10.co.kr/" & itemid)

        '기본 태그
        snpPre = Server.URLEncode("텐바이텐 HOT ITEM!")
        snpTag = Server.URLEncode("텐바이텐 " & Replace(oItem.Prd.FItemName," ",""))
        snpTag2 = Server.URLEncode("#10x10")
        snpImg = Server.URLEncode(oItem.Prd.FImageBasic)
    %>
    function shareProduct(gubun, pre, tag, img) {
        let share_method;
        switch(gubun) {
            case 'tw' : share_method = 'twitter'; break;
            case 'fb' : share_method = 'facebook'; break;
            case 'pt' : share_method = 'pinterest'; break;
        }

        popSNSPost(gubun, '<%=snpTitle%>', '<%=snpLink%>', pre, tag, img);
    }
    </script>

    <%'크리테오 스크립트 삽입 %>
    <script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
    <script type="text/javascript">
    window.criteo_q = window.criteo_q || [];
    var deviceType = /iPad/.test(navigator.userAgent) ? "t" : /Mobile|iP(hone|od)|Android|BlackBerry|IEMobile|Silk/.test(navigator.userAgent) ? "m" : "d";
    window.criteo_q.push(
        { event: "setAccount", account: 8262},
        { event: "setEmail", email: "<%=CriteoUserMailMD5%>" },
        { event: "setSiteType", type: deviceType},
        { event: "viewItem", item: "<%=itemid%>" }
    );
    </script>
    <%'// 크리테오 스크립트 삽입 %>

    <script type="text/javascript">
        let Advertisement_image_url = "<%=getThumbImgFromURL(oItem.Prd.FImageBasic,400,400,"true","false")%>";
        /*
        * 모비온 광고 스크립트
        * */
        var ENP_VAR = {
            collect: {},
            conversion: { product: [] }
        };
        ENP_VAR.collect.productCode = '<%=itemid%>';
        ENP_VAR.collect.productName = '<%=Server.URLEncode(replace(oItem.Prd.FItemName,"'",""))%>';
        ENP_VAR.collect.price = '<%=oItem.Prd.getOrgPrice%>';
        ENP_VAR.collect.dcPrice = '<%=oItem.Prd.FSellCash%>';
        ENP_VAR.collect.soldOut = '<%= mobion_soldout %>';
        ENP_VAR.collect.imageUrl = Advertisement_image_url;
        ENP_VAR.collect.topCategory = '<%=fnItemIdToCategory1DepthName(itemid)%>';

        (function(a,g,e,n,t){a.enp=a.enp||function(){(a.enp.q=a.enp.q||[]).push(arguments)};n=g.createElement(e);n.async=!0;n.defer=!0;n.src="https://cdn.megadata.co.kr/dist/prod/enp_tracker_self_hosted.min.js";t=g.getElementsByTagName(e)[0];t.parentNode.insertBefore(n,t)})(window,document,"script");
        /* 상품수집 */
        enp('create', 'collect', 'your10x10', { device: 'W' });
        /* 장바구니 버튼 타겟팅 (이용하지 않는 경우 삭제) */
        enp('create', 'cart', 'your10x10', { device: 'W', btnSelector: '#btn_shoppingbag' });
        /* 찜 버튼 타겟팅 (이용하지 않는 경우 삭제) */
        enp('create', 'wish', 'your10x10', { device: 'W', btnSelector: '#wsIco<%=Itemid %>' });

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

        appierProductFunction("product_viewed");

        function appierProductFunction(caller_name, product_type){
            if(typeof qg !== "undefined"){
                let appier_product_data = {
                    "category_name_depth1" : cate1_name
                    , "category_name_depth2" : cate2_name
                    , "brand_id" : "<%=oItem.Prd.Fmakerid%>"
                    , "brand_name" : "<%=oItem.Prd.FBrandName%>"
                    , "product_id" : "<%=itemid%>"
                    , "product_name" : "<%= Replace(oItem.Prd.FItemName, """", "") %>"
                    , "product_image_url" : Advertisement_image_url
                    , "product_url" : "https://m.10x10.co.kr/category/category_itemPrd.asp?itemid=<%=itemid%>"
                    , "product_price" : parseInt("<%=oItem.Prd.getOrgPrice%>")
                };

                switch (caller_name){
                    case "product_viewed" : case "product_added_to_wishlist" :
                        appier_product_data.keyword = "<%=Replace(oitem.Prd.FKeywords, """", "")%>";
                        qg("event", caller_name, appier_product_data);
                        break;
                    case "product_added_to_cart" : case "click_directorder_in_product" :
                        <%
                            IF oItem.Prd.FOptionCnt>0 THEN
                        %>
                            $("#lySpBagList").find("tr").each(function () {
                                appier_product_data = {
                                    "category_name_depth1" : cate1_name
                                    , "category_name_depth2" : cate2_name
                                    , "brand_id" : "<%=oItem.Prd.Fmakerid%>"
                                    , "brand_name" : "<%=oItem.Prd.FBrandName%>"
                                    , "product_id" : "<%=itemid%>"
                                    , "product_name" : "<%= Replace(oItem.Prd.FItemName, """", "") %>"
                                    , "product_image_url" : Advertisement_image_url
                                    , "product_url" : "https://m.10x10.co.kr/category/category_itemPrd.asp?itemid=<%=itemid%>"
                                };
                                appier_product_data.quantity =  parseInt($(this).find("[name='optItemEa']").val());
                                appier_product_data.product_price =  parseInt($(this).find("[name='optItemPrc']").val());
                                if($(this).find(".optContV16a p:nth-child(2)").html()){
                                    appier_product_data.product_select =  $(this).find(".optContV16a p").html();
                                    appier_product_data.product_variant =  $(this).find(".optContV16a p:nth-child(2)").html();
                                }else{
                                    appier_product_data.product_variant =  $(this).find(".optContV16a p").html();
                                }

                                if(caller_name == "click_directorder_in_product"){
                                    appier_product_data.type = product_type;
                                }

                                qg("event", caller_name, appier_product_data);
                            });
                        <%
                            ELSE
                        %>
                            appier_product_data.quantity =  document.sbagfrm.itemea.value;
                            appier_product_data.product_select = null;
                            appier_product_data.product_variant = null;
                            if(caller_name == "click_directorder_in_product"){
                                appier_product_data.type = product_type;
                            }
                            qg("event", caller_name, appier_product_data);
                        <%
                            END IF
                        %>
                        break;
                }
            }
        }
    </script>

    <script type="application/ld+json">
    {
        "@context": "http://schema.org/",
        "@type": "Product",
        "name": "<%= Replace(oItem.Prd.FItemName,"""","") %>",
        <% if viBsimg<>"" then %>
        "image": "<%= viBsimg %>",
        <% end if %>
        "mpn": "<%= itemid %>",
        "brand": {
            "@type": "Brand",
            "name": "<%= Replace(UCase(oItem.Prd.FBrandName),"""","") %>"
        },
        <%
        dim BeasongPayDescription : BeasongPayDescription = ""
        if Not oItem.Prd.FMileage and Not IsTicketItem then
            BeasongPayDescription = " 배송구분:"
            if oItem.Prd.IsAboardBeasong then
                BeasongPayDescription = BeasongPayDescription & " 텐텐" + chkIIF(oItem.Prd.IsFreeBeasong,"무료","") + "배송 + 해외배송"
                if Not(oItem.Prd.IsFreeBeasong) then
                    BeasongPayDescription = BeasongPayDescription & " 배송비 안내: 텐바이텐 배송 상품으로만 " & formatNumber(oItem.Prd.getFreeBeasongLimitByUserLevel,0) & " 원 이상 구매 시 무료배송. 배송비(2,500원)"
                end if
            elseif IsPresentItem then
                BeasongPayDescription = BeasongPayDescription & " " & oItem.Prd.GetDeliveryName
                BeasongPayDescription = BeasongPayDescription & " 배송비 안내: 해당 상품은 10X10 Present 상품으로 주문 건당 2,500원의 배송비가 부과됩니다."
            ElseIf oItem.Prd.IsOverseasDirectPurchase Then
                BeasongPayDescription = BeasongPayDescription & " 해외직구 배송"
            else
                BeasongPayDescription = BeasongPayDescription & " " & oItem.Prd.GetDeliveryName
                if Not(oItem.Prd.IsFreeBeasong) then
                    if (oItem.Prd.IsUpcheParticleDeliverItem) or (oItem.Prd.IsUpcheReceivePayDeliverItem) then
                        BeasongPayDescription = BeasongPayDescription & " " & oItem.Prd.getDeliverNoticsStr
                    else
                        BeasongPayDescription = BeasongPayDescription & " 배송비 안내: 텐바이텐 배송 상품으로만 " & formatNumber(oItem.Prd.getFreeBeasongLimitByUserLevel,0) & " 원 이상 구매 시 무료배송. 배송비(2,500원)"
                    end if
                end if
            end if

            BeasongPayDescription = Replace(BeasongPayDescription, "<br>", "")
            BeasongPayDescription = Replace(BeasongPayDescription, "제품으로만", "제품으로만 ")
            BeasongPayDescription = Replace(BeasongPayDescription, "배송비(", " 배송비(")
        end if

        %>"description": "<%= Replace(oItem.Prd.FItemName,"""","") %>. 판매가: <%= FormatNumber(CHKIIF(oItem.Prd.FSellCash>oItem.Prd.getOrgPrice, oItem.Prd.FSellCash, oItem.Prd.getOrgPrice), 0) %> 원.<% if (oItem.Prd.FSaleYn="Y") and (oItem.Prd.FOrgPrice-oItem.Prd.FSellCash>0) then %> 할인판매가: <%= FormatNumber(oItem.Prd.FSellCash,0) %> 원 [<%= CHKIIF(oItem.Prd.FOrgprice = 0, 0, CLng((oItem.Prd.FOrgPrice-oItem.Prd.FSellCash)/oItem.Prd.FOrgPrice*100)) %>%].<% end if %><% if Not oItem.Prd.FMileage and Not IsTicketItem then %> <%= BeasongPayDescription %><% end if %>",
        "offers": {
            "@type": "Offer",
            "url": "https://www.10x10.co.kr/shopping/category_prd.asp?itemid=<%= itemid %>",
            "priceCurrency": "KRW",
            "availability": "https://schema.org/InStock",
            "priceValidUntil": "<%= Left(DateAdd("yyyy", 1, Now()), 10) %>",
            "price": "<%= CHKIIF(oItem.Prd.FSellCash>oItem.Prd.getOrgPrice, oItem.Prd.FSellCash, oItem.Prd.getOrgPrice) %>"
        }<%
         if (oItem.Prd.FEvalCnt > 0) then
             dim avgEvalPoint : avgEvalPoint = getEvaluateAvgPoint(itemid)
             if (avgEvalPoint > 0) then
         %>,
        "aggregateRating": {
            "@type": "AggregateRating",
            "ratingValue": "<%= avgEvalPoint %>",
            "reviewCount": "<%= oItem.Prd.FEvalCnt %>"
        }<%
            end if
         end if
         %>
    }
    </script>
<%
    ELSE
        response.write "<script>alert('정상적인 성인인증을 해주세요.');</script>"
        response.write "<script>history.back();</script>"
    end if
%>
</body>
</html>
<%
	Set oItem = nothing
	set oADD = Nothing
	Set itemVideos = Nothing
	If IsTicketItem Then
		set oTicket = Nothing
	end If
	If clsDiaryPrdCheck.FResultCount > 0 Then
		set DiaryPreviewImgLoad = Nothing
		Set DiarySearchValue = Nothing
	End If

	'다이어리 스토리 체크 '이벤트 종료후 삭제
	set clsDiaryPrdCheck = Nothing
	Set addEx = Nothing
	Set Safety = Nothing

	''검색추가로그
	Call AddSearchAddLogItemClick()
%>
<% if cFlgDBUse then %><script language="JavaScript" type="text/javascript" SRC="/lib/js/todayview.js"></script><% end if %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
