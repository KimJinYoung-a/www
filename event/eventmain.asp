<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/eventCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoriteEventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%'쇼핑찬스 이벤트 내용보기
dim eCode : eCode   = getNumeric(requestCheckVar(Request("eventid"),8)) '이벤트 코드번호
dim eventItemDisplayNone : eventItemDisplayNone = Request("eventItemDisplayNone") '기차바 영역 숨김 여부
dim diaryStoryDisplay : diaryStoryDisplay = Request("diarystory") '다이어리스토리 헤더 여부
dim cEvent, cEventItem, arrItem, arrGroup, intI, intG, rdmNo
dim arrRecent, intR
dim bidx, ThemeColorCode, ThemeBarColorCode, ThemeColorImgCode
dim ekind, emanager, escope, ename, esdate, eedate, estate, eregdate, epdate, eOnlyName
dim ecategory, ecateMid, blnsale, blngift, blncoupon, blncomment, blnbbs, blnitemps, blnapply
dim etemplate, emimg, ehtml, eitemsort, ebrand,gimg,blnFull,blnItemifno,blnBlogURL, bimg, edispcate, vDisp, vIsWide, j, itemsort
dim itemid : itemid = ""
Dim evtFile
Dim evtFileyn, MasterSetCnt
dim egCode, itemlimitcnt,iTotCnt, strBrandListURL
dim cdl, cdm, cds
dim com_egCode : com_egCode = 0
Dim blnitempriceyn, clsEvt, isMyFavEvent, favCnt, vDateView
Dim onlyForMDTab, intTab, BrandName, BrandContents, GroupItemPriceView, GroupItemCheck
Dim evt_mo_listbanner , vIsweb , vIsmobile , vIsapp, videoFullLink, CouponVar, videoType
Dim vTmpgcode : vTmpgcode = "" '//상품없는 그룹 숨김용 변수
Dim iPageSize '//마감임박 이벤트용
Dim evt_subcopyk, evt_tag '//서브카피, 태그
Dim sgroup_w '//이벤트 그룹형 랜덤
Dim arrTopGroup '//랜덤 그룹 top1
Dim etc_itemid '// 상품이벤트 상품코드
Dim cEventadd , slide_w_flag '//슬라이드 사용 미사용
Dim comm_isusing, comm_text, freebie_img, comm_start, comm_end, gift_isusing, gift_text1, gift_img1, gift_text2, gift_img2
Dim gift_text3, gift_img3, usinginfo, using_text1, using_contents1, using_text2, using_contents2, using_text3, using_contents3
Dim mdtheme, themecolor, textbgcolor, mdbntype, salePer, saleCPer, SocName_Kor, evt_type, title_pc, endlessView, eventtype_pc, evt_pc_addimg_cnt
Dim eval_isusing, eval_text, eval_freebie_img, eval_start, eval_end, GroupItemType, arrAddTopSlide, giftitemcnt, arrGiftBox
Dim board_isusing, board_text, board_freebie_img, board_start, board_end, contentsAlign, isOnlyTen, isOnePlusOne, isNew, saleTxt, slide_w_flagmulti
Dim CopyHide
'//logparam
Dim logparam : logparam = "&pEtr="&eCode

Dim upin '카카오 이벤트 key값 parameter
	upin = requestCheckVar(Request("upin"),200)
	
dim currentDate : currentDate = date()

IF eCode = "" THEN
	response.redirect("/shoppingtoday/shoppingchance_allevent.asp")
	dbget.close()	:	response.End
elseif Not(isNumeric(eCode)) then
	Call Alert_Return("잘못된 이벤트번호입니다.")
	dbget.close()	:	response.End
ElseIf eCode = "75209" THEN		'2016-12-27 10:46 김진영 수정 / 사은품 품절로 다른 이벤트로 리다이렉트
	response.redirect("/event/eventmain.asp?eventid=75249")
	dbget.close()	:	response.End
ElseIf eCode = "77059" THEN		'소품전
	response.redirect("/event/2017props/")
	dbget.close()	:	response.End
ElseIf eCode = "77060" THEN		'소품랜드
	response.redirect("/event/2017props/sopumland.asp")
	dbget.close()	:	response.End
ElseIf eCode = "77061" THEN		'친구
	response.redirect("/event/2017props/friend.asp")
	dbget.close()	:	response.End
ElseIf eCode = "77062" THEN		'보물
	response.redirect("/event/2017props/treasure.asp")
	dbget.close()	:	response.End
ElseIf eCode = "77063" THEN		'사은품
	response.redirect("/event/2017props/gift.asp")
	dbget.close()	:	response.End
ElseIf eCode = "77064" THEN		'스티커
	response.redirect("/event/2017props/sticker.asp")
	dbget.close()	:	response.End
ElseIf eCode = "78508" THEN		'스티커
	response.redirect("/HSProject/?eventid=78508")
	dbget.close()	:	response.End
ElseIf eCode = "85159" THEN		'2018-03-30 정태훈 수정 // 웨딩 이벤트의 경우 웨딩 메인으로 보낸다
	response.redirect("/wedding/")
	dbget.close()	:	response.End
ElseIf eCode = "85148" THEN		'2018-03-30 정태훈 수정 // 웨딩 이벤트의 경우 웨딩 메인으로 보낸다
	response.redirect("/event/tenq/giftcard.asp")
	dbget.close()	:	response.End
ElseIf eCode = "85144" THEN		'2018-03-30 정태훈 수정 // 웨딩 이벤트의 경우 웨딩 메인으로 보낸다
	response.redirect("/event/tenq/")
	dbget.close()	:	response.End
ElseIf eCode = "85147" THEN		'2018-03-30 정태훈 수정 // 웨딩 이벤트의 경우 웨딩 메인으로 보낸다
	response.redirect("/event/tenq/thx_box.asp")
	dbget.close()	:	response.End
ElseIf eCode = "85145" THEN		'2018-03-30 정태훈 수정 // 웨딩 이벤트의 경우 웨딩 메인으로 보낸다
	response.redirect("/event/tenq/miracle.asp")
	dbget.close()	:	response.End
ElseIf eCode = "89308" THEN		'17주년 - 100원으로 인생역전
	response.redirect("/event/17th/gacha.asp")
	dbget.close()	:	response.End
ElseIf eCode = "89074" THEN		'17주년 - 매일리지
	response.redirect("/event/17th/maeliage17th.asp")
	dbget.close()	:	response.End
ElseIf eCode = "88942" THEN		'17주년 - 구매사은품 잘 사고 잘 받자.
	response.redirect("/event/17th/gift.asp")
	dbget.close()	:	response.End
ElseIf eCode = "120032" Then
	if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
		if Not(Request("mfg")="pc" or session("mfg")="pc") then
			if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
				Response.Redirect "//m.10x10.co.kr/monthlyten/index2020.asp"
				dbget.close()	:	response.End
			end if
		end if
	end if	
END IF

egCode = getNumeric(requestCheckVar(Request("eGC"),8))	'이벤트 그룹코드
slide_w_flagmulti="N"

IF egCode = "" THEN
	egCode = 0
end if
	itemlimitcnt = 105	'상품최대갯수
	'이벤트 개요 가져오기
	set cEvent = new ClsEvtCont
		cEvent.FECode = eCode

		cEvent.fnGetEvent

		eCode		= cEvent.FECode
		ekind		= cEvent.FEKind
		emanager	= cEvent.FEManager
		escope		= cEvent.FEScope
		ename		= cEvent.FEName
		esdate		= cEvent.FESDate
		eedate		= cEvent.FEEDate
		estate		= cEvent.FEState
		eregdate	= cEvent.FERegdate
		epdate		= cEvent.FEPDate
		ecategory	= cEvent.FECategory
		ecateMid	= cEvent.FECateMid
		blnsale		= cEvent.FSale
		blngift		= cEvent.FGift
		blncoupon	= cEvent.FCoupon
		blncomment	= cEvent.FComment
		blnBlogURL	= cEvent.FBlogURL
		blnbbs		= cEvent.FBBS
		blnitemps	= cEvent.FItemeps
		blnapply	= cEvent.FApply
		isOnlyTen	= cEvent.FisOnlyTen
		isOnePlusOne	= cEvent.FisOnePlusOne
		isNew	= cEvent.FisNew
		etemplate	= cEvent.FTemplate
		emimg		= cEvent.FEMimg
		ehtml		= cEvent.FEHtml
		eitemsort	= cEvent.FItemsort
		ebrand		= cEvent.FBrand
		gimg		= cEvent.FGimg
		blnFull		= cEvent.FFullYN
		blnItemifno = cEvent.FIteminfoYN
		evtFile		= cEvent.FevtFile
		evtFileyn	= cEvent.FevtFileyn
		evt_subcopyk= cEvent.FEvt_subcopyK
		evt_tag     = cEvent.Fevt_tag
		etc_itemid = cEvent.FEItemID
		SocName_Kor = cEvent.FSocName_Kor
		evt_pc_addimg_cnt	=	cEvent.FEvt_pc_addimg_cnt '// 이벤트 추가 이미지 카운트

		sgroup_w		= cEvent.FEsgroup_w '//이벤트 그룹랜덤
		slide_w_flag		=	cEvent.FESlide_W_Flag '// 슬라이드 모바일 플레그
		mdtheme = cEvent.Fmdtheme
		themecolor = cEvent.Fthemecolor
		textbgcolor = cEvent.Ftextbgcolor
		mdbntype = cEvent.Fmdbntype
		comm_isusing = cEvent.Fcomm_isusing
		comm_text = cEvent.Fcomm_text
		freebie_img = cEvent.Ffreebie_img
		comm_start = cEvent.Fcomm_start
		comm_end = cEvent.Fcomm_end
		gift_isusing = cEvent.Fgift_isusing
		gift_text1 = cEvent.Fgift_text1
		gift_img1 = cEvent.Fgift_img1
		gift_text2 = cEvent.Fgift_text2
		gift_img2 = cEvent.Fgift_img2
		gift_text3 = cEvent.Fgift_text3
		gift_img3 = cEvent.Fgift_img3
		usinginfo = cEvent.Fusinginfo
		using_text1 = cEvent.Fusing_text1
		using_contents1 = cEvent.Fusing_contents1
		using_text2 = cEvent.Fusing_text2
		using_contents2 = cEvent.Fusing_contents2
		using_text3 = cEvent.Fusing_text3
		using_contents3 = cEvent.Fusing_contents3
		salePer = cEvent.FsalePer
		saleCPer = cEvent.FsaleCPer
		endlessView = cEvent.FendlessView
		evt_type = cEvent.fnEventTypeName
		title_pc = cEvent.Ftitle_pc
		eventtype_pc = cEvent.Feventtype_pc
		videoFullLink = cEvent.FvideoFullLink
		videoType = cEvent.FvideoType
		BrandName = cEvent.FBrandName
		BrandContents = cEvent.FBrandContents
		GroupItemPriceView = cEvent.FGroupItemPriceView
		GroupItemCheck = cEvent.FGroupItemCheck
		GroupItemType = cEvent.FGroupItemType
		eval_isusing = cEvent.Feval_isusing
		eval_text = cEvent.Feval_text
		eval_freebie_img = cEvent.Feval_freebie_img
		eval_start = cEvent.Feval_start
		eval_end = cEvent.Feval_end
		contentsAlign= cEvent.FcontentsAlign
		board_isusing = cEvent.Fboard_isusing
		board_text = cEvent.Fboard_text
		board_freebie_img = cEvent.Fboard_freebie_img
		board_start = cEvent.Fboard_start
		board_end = cEvent.Fboard_end
		CopyHide= cEvent.FCopyHide

        If blnsale Or blncoupon Then
            If blnsale Then
                saleTxt = salePer
            end if
            If blncoupon and saleTxt="" Then
                saleTxt = saleCPer
            end if
        end if
        '수작업 할인율 적용 추가 - 정태훈 2020.02.03
        if saleTxt <> "" then
            ehtml = replace(ehtml,"#[SALEPERCENT]",saleTxt)
        end if

		itemsort = getNumeric(requestCheckVar(Request("itemsort"),2))
		If itemsort<>"" Then eitemsort=itemsort
		If textbgcolor="" Then textbgcolor=1

		If Not(cEvent.FEItemImg="" or isNull(cEvent.FEItemImg)) then
			bimg		= cEvent.FEItemImg
		ElseIf cEvent.FEItemID<>"0" Then
			If cEvent.Fbasicimg600 <> "" Then
				bimg		= "http://webimage.10x10.co.kr/image/basic600/" & GetImageSubFolderByItemid(cEvent.FEItemID) & "/" & cEvent.Fbasicimg600 & ""
			Else
				bimg		= "http://webimage.10x10.co.kr/image/basic/" & GetImageSubFolderByItemid(cEvent.FEItemID) & "/" & cEvent.Fbasicimg & ""
			End IF
		Else
			bimg		= ""
		End If
		if isNull(emimg) then emimg=""

		blnitempriceyn = cEvent.FItempriceYN
		favCnt		= cEvent.FfavCnt
		edispcate	= cEvent.FEDispCate
		vDisp		= edispcate
		vIsWide		= cEvent.FEWideYN
		vDateView	= cEvent.FDateViewYN

		evt_mo_listbanner	= cEvent.FEmolistbanner
		vIsweb				= cEvent.Fisweb
		vIsmobile			= cEvent.Fismobile
		vIsapp				= cEvent.Fisapp

		'PC, 모바일 타입 분리 체크 2017.12.12 정태훈
		If evt_type="90" Then
			If eventtype_pc="80" Then
				etemplate="9"
			End If
		End If

		'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) 2017-01-26 유태욱 추가============
		if vIsmobile = TRUE then
			if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
				if Not(Request("mfg")="pc" or session("mfg")="pc") then
					if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
						dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
						Response.Redirect "http://m.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
						REsponse.End
					end if
				end if
			end if
		end if

		'// PC 전용 추가 이미지
		'#######################################################################################
		Dim arrAddbanner, intAi
		If evt_pc_addimg_cnt > 0 Then
			arrAddbanner	=	cEvent.fnGetPCAddimg
		End If

		If isArray(arrAddbanner) Then '//이미지들 있음
			Dim tArea , mArea , bArea
			For intAi = 0 To UBound(arrAddbanner,2)
				If arrAddbanner(1,intAi) <> "" Then
					If arrAddbanner(0,intAi) = "1" And (CStr(Date()) >= CStr(arrAddbanner(4,intAi)) and CStr(Date()) <= CStr(arrAddbanner(5,intAi))) Then
						tArea = tArea & "<a href='"& chkiif(arrAddbanner(3,intAi) <> "",arrAddbanner(3,intAi),"#") &"'><img src='"& arrAddbanner(1,intAi) &"' alt='"& arrAddbanner(2,intAi) &"'></a>"
					ElseIf arrAddbanner(0,intAi) = "2" And (CStr(Date()) >= CStr(arrAddbanner(4,intAi)) and CStr(Date()) <= CStr(arrAddbanner(5,intAi))) Then
						mArea = mArea & "<a href='"& chkiif(arrAddbanner(3,intAi) <> "",arrAddbanner(3,intAi),"#") &"'><img src='"& arrAddbanner(1,intAi) &"' alt='"& arrAddbanner(2,intAi) &"'></a>"
					ElseIf arrAddbanner(0,intAi) = "3" And (CStr(Date()) >= CStr(arrAddbanner(4,intAi)) and CStr(Date()) <= CStr(arrAddbanner(5,intAi))) Then
						bArea = bArea & "<a href='"& chkiif(arrAddbanner(3,intAi) <> "",arrAddbanner(3,intAi),"#") &"'><img src='"& arrAddbanner(1,intAi) &"' alt='"& arrAddbanner(2,intAi) &"'></a>"
					End If
				End If
			Next
		End If
		'#######################################################################################


		IF etemplate = "3" OR etemplate = "7" OR etemplate = "9" OR etemplate = "10" OR etemplate = "6" THEN	'그룹형(etemplate = "3" or "7")일때만 그룹내용 가져오기
			If sgroup_w And egCode = "0" Then '// 그룹형 랜덤 체크 되었을때
				arrTopGroup = cEvent.fnGetEventGroupTop
				egCode = arrTopGroup(0,0)
			End If
			cEvent.FEGCode = 	egCode
			arrGroup =  cEvent.fnGetEventGroup
			onlyForMDTab = cEvent.fnGetEventGpcode0
		END IF

		'// PC 전용 상단 슬라이드 이미지
		'#######################################################################################
		arrAddTopSlide = cEvent.fnGetTopSlideTemplate
		Dim slideImage , slideLinkURL , slideBGLeft, slideBGRight, slideContentsAlign

		cEvent.FECategory  = ecategory
		arrRecent = cEvent.fnGetRecentEvt_Cache ''fnGetRecentEvt
		ThemeColorCode=cEvent.fnEventColorCode
		ThemeColorImgCode=cEvent.fnEventColorImgCode
		'if etemplate="10" OR etemplate = "6" then
			ThemeBarColorCode=cEvent.fnEventThemeColorCode
		'else
		'	ThemeBarColorCode=cEvent.fnEventBarColorCode
		'end if
		'#######################################################################################
		'// 기프트박스 가져오기
		'#######################################################################################
		arrGiftBox = cEvent.fnGetGiftBox
		Dim newGiftBox
		If gift_isusing>0 Then '//이미지들 있음
			newGiftBox="								<div class='evt-giftV19'>" & vbcrlf
			newGiftBox=newGiftBox+"									<ul>" & vbcrlf

			newGiftBox=newGiftBox+"										<li>" & vbcrlf
			newGiftBox=newGiftBox+"											<div class='box'>" & vbcrlf
			newGiftBox=newGiftBox+"												<div class='desc'>" & vbcrlf
			If gift_isusing>1 Then
			newGiftBox=newGiftBox+"													<p class='tit' style='color:" + ThemeBarColorCode + ";'>GIFT1</p>" & vbcrlf
			else
			newGiftBox=newGiftBox+"													<p class='tit' style='color:" + ThemeBarColorCode + ";'>GIFT</p>" & vbcrlf
			end if
			newGiftBox=newGiftBox+"													<p class='txt'>" + gift_text1 + "</p>" & vbcrlf
			newGiftBox=newGiftBox+"												</div>" & vbcrlf
			newGiftBox=newGiftBox+"												<div class='thumbnail' style='background-image:url(" + gift_img1 + ")'></div>" & vbcrlf
			newGiftBox=newGiftBox+"											</div>" & vbcrlf
			newGiftBox=newGiftBox+"										</li>" & vbcrlf
			If gift_isusing>1 Then
			newGiftBox=newGiftBox+"										<li>" & vbcrlf
			newGiftBox=newGiftBox+"											<div class='box'>" & vbcrlf
			newGiftBox=newGiftBox+"												<div class='desc'>" & vbcrlf
			newGiftBox=newGiftBox+"													<p class='tit' style='color:" + ThemeBarColorCode + ";'>GIFT2</p>" & vbcrlf
			newGiftBox=newGiftBox+"													<p class='txt'>" + gift_text2 + "</p>" & vbcrlf
			newGiftBox=newGiftBox+"												</div>" & vbcrlf
			newGiftBox=newGiftBox+"												<div class='thumbnail' style='background-image:url(" + gift_img2 + ")'></div>" & vbcrlf
			newGiftBox=newGiftBox+"											</div>" & vbcrlf
			newGiftBox=newGiftBox+"										</li>" & vbcrlf
			End If
			If gift_isusing>2 Then
			newGiftBox=newGiftBox+"										<li>" & vbcrlf
			newGiftBox=newGiftBox+"											<div class='box'>" & vbcrlf
			newGiftBox=newGiftBox+"												<div class='desc'>" & vbcrlf
			newGiftBox=newGiftBox+"													<p class='tit' style='color:" + ThemeBarColorCode + ";'>GIFT3</p>" & vbcrlf
			newGiftBox=newGiftBox+"													<p class='txt'>" + gift_text3 + "</p>" & vbcrlf
			newGiftBox=newGiftBox+"												</div>" & vbcrlf
			newGiftBox=newGiftBox+"												<div class='thumbnail' style='background-image:url(" + gift_img3 + ")'></div>" & vbcrlf
			newGiftBox=newGiftBox+"											</div>" & vbcrlf
			newGiftBox=newGiftBox+"										</li>" & vbcrlf
			End If
			newGiftBox=newGiftBox+"									</ul>" & vbcrlf
			if contentsAlign="Y" then
			newGiftBox=newGiftBox+"									<p class='caution'>* 사은품은 한정수량으로 조기소진 또는 종료될 수 있습니다.</p>" & vbcrlf
			End If
			newGiftBox=newGiftBox+"								</div>" & vbcrlf
		End If
		'// 이벤트 멀티 컨텐츠 마스터 추가 설정 카운트
		MasterSetCnt = cEvent.fnGetMultiContentsMasterSetCnt
	set cEvent = nothing
		cdl = ecategory
		cdm = ecateMid

		IF vDisp = "" THEN blnFull= True	'카테고리가 없을경우 전체페이지로
		IF eCode = "" THEN
			Alert_return("유효하지 않은 이벤트 입니다.")
			dbget.close()	:	response.End
		END IF

	'// 이벤트 시작전이면 STAFF를 제외한 이벤트 메인으로 리다이렉션
	if datediff("s",esdate,now())<0 and GetLoginUserLevel<>"7" then
		response.redirect("/shoppingtoday/shoppingchance_allevent.asp")
		dbget.close()	:	response.End
	end if

    '// 컬쳐스테이션일 경우 이벤트 메인으로 리다이렉션
    If Trim(ekind)="5" Then
        response.redirect("/shoppingtoday/shoppingchance_allevent.asp")
        dbget.close()   :   response.End
    End If

	'// 상품이벤트(kind13)일경우 상품상세로 리다이렉션
	If Trim(ekind)="13" Then
		Response.redirect ("/shopping/category_prd.asp?itemid="&etc_itemid&"&pEtr="&eCode)
		dbget.close()	:	response.End
	End If

	'// 상품이벤트(kind13)일경우 상품상세로 리다이렉션
	If etemplate="9" And mdtheme="5" Then
		Response.redirect ("/shopping/category_prd.asp?itemid="&etc_itemid&"&pEtr="&eCode)
		dbget.close()	:	response.End
	End If

	'// 내 관심 이벤트 확인
	if IsUserLoginOK then
		set clsEvt = new CMyFavoriteEvent
			clsEvt.FUserId = getEncLoginUserID
			clsEvt.FevtCode = eCode
			isMyFavEvent = clsEvt.fnIsMyFavEvent
		set clsEvt = nothing
	end if

	'//이벤트 명 할인이나 쿠폰시
	eOnlyName = eName
	If blnsale Or blncoupon Then
		if ubound(Split(eName,"|"))> 0 Then
			eOnlyName = cStr(Split(eName,"|")(0))
			If blnsale Or (blnsale And blncoupon) then
				eName	= cStr(Split(eName,"|")(0)) &" <span style=color:red>"&cStr(Split(eName,"|")(1))&"</span>"
			ElseIf blncoupon Then
				eName	= cStr(Split(eName,"|")(0)) &" <span style=color:green>"&cStr(Split(eName,"|")(1))&"</span>"
				'CouponVar = cStr(Split(eName,"|")(1))
			End If
		end if
	End If

	'// sns공유용 이미지
	dim snpImg, ogImg
	if bimg<>"" then
		snpImg = bimg
	elseIf evt_mo_listbanner <> "" Then
		snpImg = evt_mo_listbanner
	End If
	If evt_mo_listbanner <> "" Then
		ogImg = evt_mo_listbanner
	elseif bimg<>"" then
		ogImg = bimg
	End If

	'// Facebook 오픈그래프 메타태그 작성
	strHeaderAddMetaTag = "<meta property=""og:title"" content=""[텐바이텐] " & replace(eOnlyName,"""","") & """ />" & vbCrLf &_
						"<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"<meta property=""og:url"" content=""http://www.10x10.co.kr/event/eventmain.asp?eventid=" & eCode & """ />" & vbCrLf
	if Not(bimg="" or isNull(bimg)) then
		strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:image"" content=""" & ogImg & """ />" & vbCrLf &_
													"<link rel=""image_src"" href=""" & ogImg & """ />" & vbCrLf
		strPageImage = ogImg
	end If

	If eCode = "72782" Then
		strHeaderAddMetaTag = strHeaderAddMetaTag & "<meta property=""og:description"" content=""[텐바이텐]더핑거스를 응원해줘!핑거스 아카데미가 핸드메이드 전문 플랫폼 더핑거스로 새단장하였습니다.응원 댓글 남기고, 특별한 선물 받아가세요!"">" & vbCrLf
		strPageDesc = "[텐바이텐]더핑거스를 응원해줘!핑거스 아카데미가 핸드메이드 전문 플랫폼 더핑거스로 새단장하였습니다.응원 댓글 남기고, 특별한 선물 받아가세요!"
	End If

	strPageTitle = "텐바이텐 10X10 : " & eOnlyName
	strPageKeyword = "이벤트, " & replace(eOnlyName,"""","")

	If evt_subcopyk <> "" Then
		strPageDesc = evt_subcopyk
	End If

	'//이벤트 종료시
	Dim strExpireMsg : strExpireMsg=""
	If endlessView <> "Y" Then endlessView = "N"
	If endlessView = "N" Then
	IF (datediff("h",eedate,now())>0) OR (estate=9) Then
		strExpireMsg="<div class=""finish-event"">이벤트가 종료되었습니다.</div>"
	%>
		<script type="text/javascript" src="/common/addlog.js?tp=noresult&ror=<%=server.UrlEncode(Request.serverVariables("HTTP_REFERER"))%>"></script>
	<%
	END If
	END If

	'// 구글 ADS 스크립트 관련(2018.09.21 신규버전 추가)
	googleADSCRIPT = " <script> "
	googleADSCRIPT = googleADSCRIPT & "   gtag('event', 'page_view', { "
	googleADSCRIPT = googleADSCRIPT & "     'send_to': 'AW-851282978', "
	googleADSCRIPT = googleADSCRIPT & "     'ecomm_pagetype': 'other', "
	googleADSCRIPT = googleADSCRIPT & "     'ecomm_prodid': '', "
	googleADSCRIPT = googleADSCRIPT & "     'ecomm_totalvalue': '' "
	googleADSCRIPT = googleADSCRIPT & "   }); "
	googleADSCRIPT = googleADSCRIPT & " </script> "

	'// 이벤트 로그 사용여부(2017.01.12)
	Dim LogUsingCustomChk
	If getEncLoginUserId="thensi7" Then
		LogUsingCustomChk = True
	Else
		LogUsingCustomChk = True
	End If

	'// 이벤트 로그저장(2017.01.11 원승현)
	If LogUsingCustomChk Then
		If IsUserLoginOK() Then
			'// 마케팅이벤트(ekind=28)
			If ekind="28" Then
				Call fnUserLogCheck("mktevt", getEncLoginUserId, "", eCode, "", "pc")
			Else
				Call fnUserLogCheck("planevt", getEncLoginUserId, "", eCode, "", "pc")
			End If
		End If
	End If

	'// 이벤트 유형 및 테마번호 Web Log에 추가(2017.06.26; 허진원)
	Response.AppendToLog "&evttp=" & evt_type & mdtheme

	'// 슈퍼루키 위크 기획전 배너(20170418~ 이종화)
	Dim BrWeekHtml
	If ekind = "31" And (Date() >= "2017-04-17" And Date() <= "2017-04-30") Then '//브랜드 week 일경우만
		BrWeekHtml = "<div class=""brWeekLinkBnr""><div><a href=""/shoppingtoday/shoppingchance_allevent.asp?scT=bw""><img src=""http://fiximage.10x10.co.kr/web2017/event/brweek_bnr.png"" alt=""슈퍼루키 위크 기획전"" /></a></div></div>"
	End If

	'// 비회원일경우 회원가입 이후 페이지 이동을 위해 현재 페이지 주소를 쿠키에 저장해놓는다.
	If Not(IsUserLoginOK) Then
		response.cookies("sToMUP") = tenEnc(replace(Request.ServerVariables("url")&"?"&Request.ServerVariables("QUERY_STRING"),"index.asp",""))
		Response.Cookies("sToMUP").expires = dateadd("d",1,now())
	End If

    Dim eventItemTotalCount, eventItems
    set cEventItem = new ClsEvtItem
        cEventItem.FECode 	= eCode
        cEventItem.FEGCode 	= egCode
        cEventItem.FEItemCnt= itemlimitcnt
        cEventItem.FItemsort= eitemsort
        cEventItem.fnGetEventItem

        eventItemTotalCount = cEventItem.FTotCnt
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<%
	if ecode="93475" or ecode="93354" or ecode="93409" or ecode="93410" or ecode="93411" or ecode="93412" or ecode="93413" or ecode="93414" or ecode="93415" or ecode="93416" or ecode="93417" then
%>
<style>
div.fullEvt .evtHead {display:none;}
#contentWrap {padding-top:0;}
.eventContV15.tMar15 {margin-top:0 !important;}
</style>
<% end if %>
<style>
	/* 다꾸2023 페이지에서만! .gnb-wrap{border-bottom:0;} */
	.gnb-wrap{border-bottom:0;}
	.diary2023 .gpimg{width:100%;}
	.diary2023 a:hover{text-decoration:none;}
	.diary2023 a{color:inherit;}
	.diary2023 #contentWrap{width:100%; padding:0; position:relative; overflow:hidden; background:url(//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/back_new_02.jpg/10x10/optimize); background-position:top; background-size:1920px auto; background-repeat:repeat-y;}
	.diary2023_event .top{width:100%; min-height:169px;}
	.diary2023_event .bottom{width:100%; min-height:180px;}
	.diary2023_event .content{width:100%;}
	.diary2023_event .section{margin:0 auto; display:flex; position:relative;}
	.diary2023_event .blur01{position:absolute; width:815px; height:815px; left:50%; top:441px; margin-left:-65px; border-radius:100%; background:radial-gradient(50% 50% at 50% 50%, #353A5F 0%, #353A5F 51.56%, #9ebaf3cc 100%); filter:blur(25px);}
	.diary2023_event .blur02{position:absolute; width:182.2px; height:273.3px; left:50%; top:-138px; margin-left:-635px; background:radial-gradient(50% 50% at 50% 50%, #666ea666 0%, #eba9a366 100%); mix-blend-mode:multiply; filter:blur(15px); border-radius:100px; transform:rotate(-62.45deg);}
	.diary2023_event .blur02::before{position:absolute; width:182.2px; height:273.3px; border-radius:100px; content:''; left:0; top:0; background:#FFF; opacity:0.5;}
	.diary2023_event .line01{position:absolute; width:656.61px; height:547.5px; left:50%; top:379px; margin-left:339px;}
	.diary2023_event .line02{position:absolute; width:736.5px; height:491px; left:50%; top:771px; margin-left:-960px;}
	.diary2023_event .line01 img{width:100%;}
	.diary2023_event .line02 img{width:100%;}
	.diary2023_event .section01 .sect01_link{z-index:50; display:flex; position:absolute; width:1140px; left:50%; justify-content:space-between; margin-left:-570px; top:-90px; }
    .diary2023_event .sect01_link .date p{display:none; font-size:32px; font-weight:400; line-height:31.42px; color:#111; margin-bottom:11px;}
	.diary2023_event .input_box{width:268px; height:40px; border-radius:20px; border:1px solid #999; background:transparent; display:flex; position:relative; box-sizing:border-box;}
	.diary2023_event .input_box .ico_search{width:24.07px; position:absolute; left:232px; top:7px;}
	.diary2023_event .input_box input{caret-color:#FF214F; background:transparent; margin-top:2px; font-size:14px; font-weight:500; line-height:16.8px; padding-left:16px;}
	.diary2023_event .input_box input::placeholder{color:#999;}
	.diary2023_event .reco_search{display:flex; margin:8px 0 0 14px; flex-wrap:wrap;}
	.diary2023_event .reco_search p{font-weight:400; letter-spacing:-0.4px; font-size:13px; line-height:16.8px; margin-right:8px;}
	.diary2023_event .sect01_link .reco_search p a{color:#111;}
	.diary2023_event .sect01_inform{color:#fff; position:absolute; width:200px; height:200px; border-radius:50%; left:50%; margin-left:536px; top:697px; background:#2F3167; font-size:16px; font-weight:500; line-height:24px; text-align:center; display:none;}
	.diary2023_event .sect01_inform p{letter-spacing:-1px; position:absolute; left:53%; transform:translateX(-50%); top:49px;}
	.diary2023_event .sect01_inform span{color:#00C4BD; font-size:20px; line-height:28px; font-weight:600; white-space:nowrap;}
	.diary2023_event .sect01_inform li{padding-top:10px; border-top:2px solid rgba(255, 255, 255, 0.6); letter-spacing:-1px; position:absolute; left:53%; transform:translateX(-50%); top:107px; font-size:14px; line-height:20px; list-style:none; font-weight:500;}
	.diary2023_event .sect01_inform li span{font-size:11px; line-height:16px; color:#fff; background:#00C4BD; text-align:center; display:inline-block; width:38px; border-radius:10px; margin-left:2px;} 
	.diary2023_event .section02{width:1140px; z-index:1; margin:0 auto; box-sizing:border-box;}
	.diary2023_event .section02 .event_cont{background:rgba(255, 255, 255, 1);}
	.diary2023_event .section02 .sticker{width:110px; height:102px; position:absolute; top:123px; right:-39px;}
	.diary2023_event .dropdown .select_wrap{display:none; max-width:390px;}
	.diary2023_event .dropdown .select_wrap.on{display:block;}
	.diary2023_event .dropdown .event_select{display:flex; cursor:pointer; max-width:390px; font-size:24px; font-weight:700; color:#111; margin-bottom:4px;}
	.diary2023_event .dropdown .event_select p{width:fit-content; overflow:hidden; text-overflow:ellipsis; display:-webkit-box; -webkit-line-clamp:1; -webkit-box-orient:vertical; line-height:28.8px;}
	.diary2023_event .dropdown .event_select img{width:20px; height:20px; margin-top:4px; margin-left:2px;}
	.diary2023_event .dropdown .select_ul p{width:100%; overflow:hidden; text-overflow:ellipsis; white-space:nowrap; letter-spacing:-0.4px; font-size:20px; font-weight:500; line-height:24px; color:#242542; padding-bottom:20px; min-width:243px;}
		.diary2023_event .dropdown .select_ul p:last-child{padding-bottom:17px;}
	.diary2023_event .dropdown .select_ul{display:none; background:#FFFFFF; opacity:0.9; border:1px solid #FF603E; padding:17px 24px 0; text-align:left;}
	.diary2023_event .dropdown .select_ul.drop{display:block;}
</style>

<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>

<script src="/vue/2.5/vue.min.js"></script>
<script src="/vue/vue.lazyimg.min.js"></script>
<script src="/vue/vuex.min.js"></script>
<script type="text/javascript" src="/vue/common/common.js"></script>

<link rel="stylesheet" type="text/css" href="/lib/css/numSpinner.css" />
<script type="text/javascript">
$(function(){
    let items_id_list = [];
    <%
        For intI =0 To eventItemTotalCount
    %>
            items_id_list.push(<%=cEventItem.FCategoryPrdList(intI).FItemID%>);
    <%
        NEXT

        set cEventItem = nothing
    %>
    let view_event_data = {
        eventkind : "<%=ekind%>"
        , eventcode  : "<%=eCode%>"
        , eventtype : "<%=evt_type%>"
        , item_id : items_id_list
    };
    fnAmplitudeEventActionJsonData('view_event', JSON.stringify(view_event_data));

    if(typeof qg !== "undefined"){
        let appier_event_view_data = {
            "event_url" : "https://m.10x10.co.kr/event/eventmain.asp?eventid=<%=eCode%>"
            , "event_id" : "<%=eCode%>"
            , "event_name" : "<%=eName%>"
            , "event_detail" : "<%=evt_subcopyK%>"
            , "event_tag" : "<%=evt_tag%>"
        };

        qg("event", "event_view", appier_event_view_data);
    }

	$(".evtSelect dt").click(function(){
		if($(".evtSelect dd").is(":hidden")){
			$(this).parent().children('dd').show("slide", { direction: "up" }, 300);
			$(this).addClass("over");
		}else{
			$(this).parent().children('dd').hide("slide", { direction: "up" }, 200);
		};
	});
	$(".evtSelect dd li").click(function(){
		var evtName = $(this).text();
		$(".evtSelect dt").removeClass("over");
		$(".evtSelect dd li").removeClass("on");
		$(this).addClass("on");
		$(this).parent().parent().parent().children('dt').children('span').text(evtName);
		$(this).parent().parent().hide("slide", { direction: "up" }, 200);
	});
	$(".evtSelect dd").mouseleave(function(){
		$(this).hide();
		$(".evtSelect dt").removeClass("over");
	});

	$(".evtFullZigZag div.evtPdtList:first").css("margin-top", "0");
	$(".evtFullZigZag div.evtPdtList:odd").addClass("evenWrap");
	$(".evtFullZigZag div.evtPdtList:even").addClass("oddWrap");

	//상품 후기
	$(".talkList .talkMore").hide();
	$(".talkList .talkShort").click(function(){
		$(".talkList .talkMore").hide();
		$(this).parent().parent().next('.talkMore').show();
	});

	// Item Image Control
	$(".pdtList li .pdtPhoto").mouseenter(function(e){
		$(this).find("dfn").fadeIn(150);
	}).mouseleave(function(e){
		$(this).find("dfn").fadeOut(150);
	});

	// 지그제그
	$(".evtFullZigZagV15 div.evtPdtListV15:first").css("margin-top", "0");
	$(".evtFullZigZagV15 div.evtPdtListV15:odd").addClass("evenWrap");
	$(".evtFullZigZagV15 div.evtPdtListV15:even").addClass("oddWrap");

});

function fnMyEvent() {
<% If IsUserLoginOK Then %>
	//AJAX처리 후 레이어처리
	$.ajax({
		url: "/my10x10/myfavorite_eventProc.asp?hidM=I&eventid=<%=eCode%>&pop=L",
		cache: false,
		async: false,
		success: function(message) {
			if(message!="0") {
				//확인 창 Open
				var vPopLayer = '<div class="window putPlayLyr" style="width:400px; height:315px;">';
				vPopLayer += '	<div class="popTop pngFix"><div class="pngFix"></div></div>';
				vPopLayer += '	<div class="popContWrap pngFix">';
				vPopLayer += '		<div class="popCont pngFix">';
				vPopLayer += '			<div class="popBody">';
				vPopLayer += '				<div class="popAlert">';
				if(message=="1") {
					vPopLayer += '					<p class="msg"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_event_message.gif" alt="관심 이벤트로 등록되었습니다." /></p>';
				} else {
					vPopLayer += '					<p class="msg"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_event_message_reput.gif" alt="이미 관심 이벤트로 등록되었습니다." /></p>';
				}
				vPopLayer += '					<div class="btnArea">';
				vPopLayer += '						<a href="/my10x10/myfavorite_event.asp" class="btn btnRed btnW150">관심 이벤트 확인하기</a>';
				vPopLayer += '						<a href="" onclick="ClosePopLayer();return false;" class="btn btnWhite btnW150">이벤트 계속보기</a>';
				vPopLayer += '					</div>';
				vPopLayer += '				</div>';
				vPopLayer += '			</div>';
				vPopLayer += '		</div>';
				vPopLayer += '	</div>';
				vPopLayer += '</div>';
				viewPoupLayer('modal',vPopLayer);

				//관심 체크표시
				if(!$("#evtFavCnt").hasClass("myFavor")) {
					var $opObj = $("#evtFavCnt");
					var fcnt = $opObj.find("strong").text().replace(/,/g,"");
					fcnt++;
					wfnt = setComma(fcnt);
					$opObj.find("strong").text(fcnt);
					$opObj.addClass('myFavor');
				}
			} else {
				alert("처리중 오류가 발생했습니다.");
			}
		}
	});

<% Else %>
	if(confirm("로그인 하시겠습니까?") == true) {
		top.location.href = "/login/loginpage.asp?backpath=<%=server.URLEncode(request.ServerVariables("URL"))%>&strGD=<%=server.URLEncode(request.ServerVariables("QUERY_STRING"))%>&strPD=<%=server.URLEncode(fnMakePostData)%>";
	 }
		return  ;
<% End If %>
}

function TnEvtSortChangeView(objval){
	location.href="/event/eventmain.asp?eventid=<%=eCode%>&itemsort="+objval
}

<%
    '// 쇼셜서비스로 글보내기 (2010.07.21; 허진원)
    dim snpTitle, snpLink, snpPre, snpTag, snpTag2
    snpTitle = Server.URLEncode(eOnlyName)
    snpLink = Server.URLEncode("http://10x10.co.kr/event/" & ecode)
    snpPre = Server.URLEncode("텐바이텐 이벤트")
    snpTag = Server.URLEncode("텐바이텐 " & Replace(eOnlyName," ",""))
    snpTag2 = Server.URLEncode("#10x10")
    ''snpImg = Server.URLEncode(emimg)	'상단에서 생성
%>
// 이벤트 공유
function shareEvent(gubun, pre, tag, img) {
    let share_method;
    switch(gubun) {
        case 'tw' : share_method = 'twitter'; break;
        case 'fb' : share_method = 'facebook'; break;
        case 'pt' : share_method = 'pinterest'; break;
    }

    popSNSPost(gubun, '<%=snpTitle%>', '<%=snpLink%>', pre, tag, img);
}

function goEventSubscript(){
    let eCode = '<%= eCode %>';
    let now = '<%=left(currentDate,10)%>';
    let start = '<%=left(esdate,10)%>';
    console.log("goEventSubscript", eCode);
    console.log("date check now, start", now, start);

    <% If Not(IsUserLoginOK) Then %>
        top.location.href = "/login/loginpage.asp?backpath=<%=server.URLEncode(request.ServerVariables("URL"))%>&strGD=<%=server.URLEncode(request.ServerVariables("QUERY_STRING"))%>&strPD=<%=server.URLEncode(fnMakePostData)%>";
        return false;
    <% else %>
        <% If not( left(currentDate,10) >= left(esdate,10) and left(currentDate,10) <= left(eedate,10) ) Then %>
            alert("이벤트 응모 기간이 아닙니다.");
            return;
        <% else %>
            const subscription_apiurl = api_url + '/event/common/subscription';

            const post_data = {
                event_code: '<%=eCode%>',
                check_option1: false
            };
            $.ajax({
                type: "POST",
                url: subscription_apiurl,
                data: post_data,
                ContentType: "json",
                crossDomain: true,
                xhrFields: {
                    withCredentials: true
                },
                success: function (data) {
                    if( data.result ) {
                        alert(data.message);
                        fnAmplitudeEventMultiPropertiesAction('click_event_apply','evtcode', post_data.event_code);
                    } else {
                        alert('데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : 001)');
                    }
                },
                error: function (xhr) {
                    console.log(xhr.responseText);
                    try {
                        const err_obj = JSON.parse(xhr.responseText);
                        console.log(err_obj);
                        switch (err_obj.code) {
                            case -10: alert('알림 신청을 하려면 로그인이 필요합니다.'); return false;
                            default: alert(err_obj.message); return false;
                        }
                    }catch(error) {
                        console.log(error);
                        alert('데이타를 저장하는 도중에 에러가 발생하였습니다. 관리자 문의 요망. (에러코드 : 002)');
                    }
                }
            });
        <% end if %>
    <% End IF %>
}
</script>
</head>
<body>
<div id="eventDetailV15" class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container <%=chkIIF(Not(blnFull),"partEvt","fullEvt") %>">
		<div id="contentWrap">
			<% if Not(blnFull) then %>
			<div class="lnbWrapV15">
				<div class="lnbArea">
					<h2><a href="/shopping/category_main.asp?disp=<%=Left(vDisp,3)%>"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ctgy_tit<%=Left(vDisp,3)%>.gif" alt="<%=CategoryNameUseLeftMenu(Left(vDisp,3))%>" /></a></h2>

				</div>
			</div>
			<% end if %>
			<div class="eventWrapV15">
				<div class="evtHead snsArea">
					<dl class="evtSelect ftLt">
						<dt><span>이벤트 더보기</span></dt>
						<dd>
							<ul>
								<li><strong><a href="/shoppingtoday/shoppingchance_allevent.asp">엔조이 이벤트 전체 보기</a></strong></li>
								<%
								IF isArray(arrRecent) THEN
									For intR = 0 To UBound(arrRecent,2)
										if arrRecent(0,intR)<>eCode then
											Response.Write "<li><a href=""/event/eventmain.asp?eventid=" & arrRecent(0,intR) & """>" & db2html(arrRecent(1,intR)) & "</a></li>" & vbCrLf
										end if
									Next
								End If
								%>
							</ul>
						</dd>
					</dl>
					<div class="ftRt">
						<%IF ebrand<>"" THEN%><a href="javascript:GoToBrandShop('<%=ebrand%>');" class="ftLt btn btnS2 btnGrylight"><em class="gryArr01">브랜드 전상품 보기</em></a><% end if %>
						<div class="sns lMar10">
						<ul>
							<li><a href="" onclick="shareEvent('tw','<%=snpPre%>','<%=snpTag2%>');return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_twitter.gif" alt="트위터" /></a></li>
							<li><a href="" onclick="shareEvent('fb','','');return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_facebook.gif" alt="페이스북" /></a></li>
							<li><a href="" onclick="shareEvent('pt', '', '', '<%=snpImg%>');return false;"><img src="http://fiximage.10x10.co.kr/web2013/common/sns_pinterest.gif" alt="핀터레스트" /></a></li>
						</ul>
						<% If bimg <> "" Then %><div id="evtFavCnt" class="favoriteAct <%=chkIIF(isMyFavEvent,"myFavor","")%>" onclick="fnMyEvent()"><strong><%=formatNumber(favCnt,0)%></strong></div><% End If %>
						</div>
					</div>
				</div>
				<!-- #include virtual="/event/include_event_top_banner.asp" -->
				<%
				j = 0
				SELECT CASE etemplate
					CASE "3"	'그룹형(그룹기본:3)
						IF isArray(arrGroup) THEN
				%>
							<%'// 하단 이벤트 코드 임시배너.. 2016년 3월 14일 이후엔 지워도 됨(2016.02.12 원승현) %>
							<% If eCode="68972" Or eCode="68973" Or eCode="68974" Or eCode="68975" Or eCode="68976" Then %>
								<div style="position:absolute; left:50%; top:50px; margin-left:380px;z-index:40;">
									<p><a href="eventmain.asp?eventid=68662"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68972/bnr_digital.png" alt="선물하기 좋은 디지털" /></a></p>
									<p><a href="eventmain.asp?eventid=69041"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68972/bnr_interior_v2.png" alt="공부방 인테리어" /></a></p>
									<p><a href="eventmain.asp?eventid=69089"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68972/bnr_stationery_v2.png" alt="해외 디자인 문구" /></a></p>
									<p><a href="eventmain.asp?eventid=68993"><img src="http://webimage.10x10.co.kr/eventIMG/2016/68972/bnr_fashion.png" alt="신학기 패션 핫이슈!" /></a></p>
								</div>
							<% End If %>
							<% If arrGroup(0,0) <> "" Then %>
							<div class="eventContV15 tMar15" align="center">
								<div class="bnrTemplate"><%=tArea%></div><%'PC 상단 추가 이미지 %>
								<div class="contF <%=CHKIIF(vIsWide=True,"contW","")%>"><% If eCode <> "68041" Then %><%=strExpireMsg%><% End If %><%=BrWeekHtml%>
								<% If slide_w_flag ="Y" Then %><% sbSlidetemplate '//slide template %><% End If %>
								<% if arrGroup(3,0) <> "" then %>
									<a name="event_namelink0"></a>
									<img src="<%=arrGroup(3,0)%>" alt="<%=egCode%>" usemap="#mapGroup<%=egCode%>" class="gpimg"/>
								<% ElseIf (arrGroup(3,0) = "") and ((date() < esdate) and (estate < 5)) Then
									For intTab = 0 To UBound(onlyForMDTab,2)
										if trim(onlyForMDTab(1, intTab))<>"" then
											response.write "<span style=cursor:pointer; onclick=javascript:TnGotoEventGroupMain('"&eCode&"','"&onlyForMDTab(0, intTab)&"');>"& onlyForMDTab(1, intTab) & "</span>"&"<br>"
										end if
									Next
								%>
								<% end if %>

								<% If Trim(evtFileyn)="" Or evtFileyn = 0 Or isnull(evtFileyn) Then %>
									<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,0))%></map>
								<% Else %>
									<% If checkFilePath(server.mappath(evtFile)) Then %>
										<% server.execute(evtFile)%>
									<% Else %>
										<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,0))%></map>
									<% End If %>
								<% End If %>
								<% If vDateView = False Then %><div class="evtTermWrap"><div class="evtTerm"><p><strong>이벤트기간</strong> : <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></p></div></div><% End If %>
								</div>
							</div>

				<%
							Response.Write "<div class=""evtPdtListWrapV15"">"
								egCode = arrGroup(0,0)
				%>
								<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
				<%
							Response.Write "</div>"
				%>


							<%
							j = 1
							End If %>
				<%
							Response.Write "<div class=""evtPdtListWrapV15"">"
							For intG = j To UBound(arrGroup,2)
								egCode = arrGroup(0,intG)
				%>
								<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,intG))%></map>
								<% if arrGroup(3,intG) <> "" then %>
								<div class="pdtGroupBar" id="groupBar<%=intG%>" name="groupBar<%=intG%>">
									<a name="event_namelink<%=intG%>"></a>
									<img src="<%=arrGroup(3,intG)%>"  usemap="#mapGroup<%=egCode%>" alt="" />
								</div>
								<% Else %>
								<div class="pdtGroupBar" id="groupBar<%=intG%>" name="groupBar<%=intG%>">
									<a name="event_namelink<%=intG%>"></a>
									<%= arrGroup(1,intG) %>
								</div>
								<% end if %>
								<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>" ><% sbEvtItemView %></div>
				<%
							Next
							Response.Write "</div>"
						END IF
					CASE "7" '그룹형(지그재그:7)
				%>
						<!-- #include file="./inc_zigzag_group.asp" -->
				<%
					CASE "5" '수작업
				%>
						<div class="eventContV15 tMar15" align="center">
							<div class="bnrTemplate"><%=tArea%></div><%'PC 상단 추가 이미지 %>
							<div class="contF <%=CHKIIF(vIsWide=True,"contW","")%>"><% If eCode <> "68041" Then %><%=strExpireMsg%><% End If %><%=BrWeekHtml%>
							<% If Trim(evtFileyn)="" Or evtFileyn = 0 Or isnull(evtFileyn) Then %>
								<%=ehtml%>
							<% Else %>
								<% If checkFilePath(server.mappath(evtFile)) Then %>
									<% server.execute(evtFile)%>
								<% Else %>
									<%=ehtml%>
								<% End If %>
							<% End If %>
							<% If vDateView = False Then %><div class="evtTermWrap"><div class="evtTerm"><p><strong>이벤트기간</strong> : <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></p></div></div><% End If %>
							</div>
						</div>
				<%	CASE "6" '수작업+상품목록 %>
						<div class="eventContV15 tMar15" align="center">
							<div class="bnrTemplate"><%=tArea%></div><%'PC 상단 추가 이미지 %>
							<div class="contF <%=CHKIIF(vIsWide=True,"contW","")%>"><% If eCode <> "68041" Then %><%=strExpireMsg%><% End If %>
							<% If Trim(evtFileyn)="" Or evtFileyn = 0 Or isnull(evtFileyn) Then %>
								<%=ehtml%>
							<% Else %>
								<% If checkFilePath(server.mappath(evtFile)) Then %>
									<%=ehtml%>
									<% server.execute(evtFile)%>
								<% Else %>
									<%=ehtml%>
								<% End If %>
							<% End If %>
							<%=BrWeekHtml%>
							<% if emimg<>"" then %><img src="<%=emimg%>" border="0" usemap="#Mainmap" class="gpimg"/><% End If %>
							<% If slide_w_flag ="Y" Then %><% sbSlidetemplate '//slide template %><% End If %>
							<% = newGiftBox %>
						<% IF isArray(arrGroup) THEN %>
							<% If arrGroup(0,0) <> "" Then %>
								<% if arrGroup(3,0) <> "" then %>
									<a name="event_namelink0"></a>
									<img src="<%=arrGroup(3,0)%>" alt="<%=egCode%>" usemap="#mapGroup<%=egCode%>" class="gpimg"/>
								<% ElseIf (arrGroup(3,0) = "") and ((date() < esdate) and (estate < 5)) Then
									For intTab = 0 To UBound(onlyForMDTab,2)
										if trim(onlyForMDTab(1, intTab))<>"" then
											response.write "<span style=cursor:pointer; onclick=javascript:TnGotoEventGroupMain('"&eCode&"','"&onlyForMDTab(0, intTab)&"');>"& onlyForMDTab(1, intTab) & "</span>"&"<br>"
										end if
									Next
								%>
								<% end if %>
								<% If Trim(evtFileyn)="" Or evtFileyn = 0 Or isnull(evtFileyn) Then %>
									<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,0))%></map>
								<% Else %>
										<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,0))%></map>
								<% End If %>
							<% End If %>
						<% End If %>



							<% If vDateView = False Then %><div class="evtTermWrap"><div class="evtTerm"><p><strong>이벤트기간</strong> : <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></p></div></div><% End If %>
							</div>
						</div>
						<% j = 0 %>
						<% IF isArray(arrGroup) THEN %>
						<% If arrGroup(0,0) <> "" Then %>
							<div class="evtPdtListWrapV15">
							<% egCode = arrGroup(0,0) %>
								<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
							</div>
						<% j = 1 %>
						<% End If %>
							<div class="evtPdtListWrapV15">
						<% For intG = j To UBound(arrGroup,2) %>
							<% egCode = arrGroup(0,intG) %>
							<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,intG))%></map>
							<div class="pdt-groupbarV20" id="mapGroup<%=arrGroup(0,intG)%>" style="color:<%=ThemeBarColorCode%>;">
								<p><%= arrGroup(1,intG) %></p>
								<% If arrGroup(11,intG) <> "0" Then %>
									<a href="<%=fnEvtItemGroupLinkInfo(arrGroup(11,intG)) %><%=arrGroup(9,intG)%>" class="btn-go">
									<%=fnEvtItemGroupLinkTitle(arrGroup(11,intG)) %><i></i></a>
								<% End If %>
							</div>
							<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
						<% Next %>
							</div>
						<% else %>
							<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
						<% End If %>
				<%
					CASE "9" 'MD 등록 템플릿(2017.06.08 추가 corpse2)
				%>
					<script type="text/javascript">
					$(function(){
						// slide
						if ($(".fullTemplatev17 .slide div").length > <% sbSlidetemplateCntMD %>) {
							$('.fullTemplatev17 .slide').slidesjs({
								pagination:{effect:'fade'},
								navigation:{effect:'fade'},
								play:{interval:3000, effect:'fade', auto:true},
								effect:{fade: {speed:800, crossfade:true}},
								callback: {
									complete: function(number) {
										var pluginInstance = $('.fullTemplatev17 .slide').data('plugin_slidesjs');
										setTimeout(function() {
											pluginInstance.play(true);
										}, pluginInstance.options.play.interval);
									}
								}
							});
						}

						/* 수정 0627 */
						var textW = $(".fullTemplatev17.typeB .title").outerWidth();
						var textH = $(".fullTemplatev17.typeB .inner").outerHeight()/2;
						var pgnW = $(".fullTemplatev17 .slide .slidesjs-pagination").outerWidth()/2;
						$(".fullTemplatev17.typeB .inner").css("width",textW);
						$(".fullTemplatev17.typeB .inner").css("margin-top",-textH);
						$(".fullTemplatev17.typeB .slide .slidesjs-pagination").css("margin-left",-pgnW);
						$(".fullTemplatev17.typeB .slidesjs-previous").css("margin-left",-pgnW);
						$(".fullTemplatev17.typeB .slidesjs-next").css("margin-left",pgnW - 20);
						/* 수정 0627 */

						// gift
						/* 0628 수정 */
						$(".evtGiftV17 li:nth-child(1) span").text("1");
						$(".evtGiftV17 li:nth-child(2) span").text("2");
						$(".evtGiftV17 li:nth-child(3) span").text("3");
						if ($(".evtGiftV17 .thumbnail li").length == 2) {
							$(".evtGiftV17").addClass("item2");
						}
						if ($(".evtGiftV17 .thumbnail li").length == 3) {
							$(".evtGiftV17").addClass("item3");
						}
						/* 0628 수정 */

					});
					</script>
					<div class="eventContV15 tMar15" align="center">
						<div class="bnrTemplate"><%=tArea%></div><%'PC 상단 추가 이미지 %>
						<!-- MD등록 이벤트 템플릿 -->
						<div class="contF" style="background:#fff;"><%=strExpireMsg%>
						<% If eCode=82918 Or eCode=82919 Or eCode=82892 Or eCode=82967 Then '하드코딩 네개 이벤트일때만 노출 %>
						<div class="bnr" style="margin-bottom:15px;">
							<a href="eventmain.asp?eventid=82890"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82890/img_bnr_manida_day.gif?v=1.0" alt="매일 매일이 매니아 데이 오늘은 푸드 특가! 이벤트 보러가기" /></a>
						</div>
						<% End If %>
						<% If eCode=82864 Or eCode=82865 Then '하드코딩 두개 이벤트일때만 노출 %>
						<div class="bnr" style="margin-bottom:15px;">
							<a href="eventmain.asp?eventid=82863"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82863/img_bnr_82863_manida_day.gif" alt="매일 매일이 매니아 데이 오늘은 뷰티특가! 이벤트 보러가기" /></a>
						</div>
						<% End If %>
						<% If eCode=82965 Then '하드코딩 82965 이벤트일때만 노출 %>
						<div class="bnr" style="margin-bottom:15px;">
							<a href="eventmain.asp?eventid=82920"><img src="http://webimage.10x10.co.kr/eventIMG/2017/82920/img_bnr_manida_day.gif?v=1.0" alt="매일 매일이 매니아 데이 오늘은 쥬얼리 특가! 이벤트 보러가기" /></a>
						</div>
						<% End If %>
						
						<% If mdtheme="4" Then %>
							<div class="fullTemplatev17 typeD"> <!-- for dev msg : 이벤트 유형에 따라 typeD(동영상) -->
								<div class="full-contV18">
									<!-- for dev msg
										할인율 넣어주실때,
										상품할인 color-red
										쿠폰할인 color-green
										상품할인 + 쿠폰할인 color-red / 타이틀 영역에서 할인율 동시에 들어갈 경우 쿠폰할인율 앞에 + 붙여주세요 / 하단 상품 영역에서 동시에 들어갈 경우 할인율 합쳐주세요.
									-->
									<% If (salePer<>"" And salePer>"0") Or (saleCPer<>"" And saleCPer>"0") Then %>
									<p class="discount">
										<% If salePer<>"" And salePer>"0" and blnsale Then %>
										<span class="color-red">~<%=salePer%>%</span>
										<% End If %>
										<% If saleCPer<>"" And saleCPer>"0" and blncoupon Then %>
										<span class="color-green"><% If salePer<>"" And salePer>"0" and blnsale Then %>+ <% End If %><%=saleCPer%>%</span>
										<% End If %>
									</p>
									<% End If %>
									<h2><%=title_pc %></h2> <!-- 30byte 이내 -->
									<div class="sub"><%=chrbyte(evt_subcopyk,50,"Y")%></div> <!-- 100byte 이내 -->
									<div class="btn-group">
										<%If (blnitemps) Then %>
										<a class="btn-go" href="#reviewarea">리뷰 이벤트</a>
										<% End If %>
										<% If comm_isusing="Y" Then %>
										<a class="btn-go" href="#commentarea">코멘트 이벤트</a>
										<% End If %>
									</div>
									<!-- 동영상 -->
									<% If videoType<>"0" Then %>
									<div class="evt-vod">
										<%=videoFullLink%>
									</div>
									<% Else %>
									<!-- 슬라이드일 경우 -->
									<div class="slide">
										<% sbSlidetemplateMD %>
									</div>
									<% End If %>
								</div>
								<i class="bg-color" style="background-color:<%=ThemeBarColorCode%>; background-image:url(<%=ThemeColorImgCode%>)"></i>
								
								<!-- 엠디등록 브랜드 -->
								<div class="evt-brandV18">
									<% if BrandName <> "" then %><h3><a href="javascript:GoToBrandShop('<%=ebrand%>');"><%=BrandName%><span class="arrow-right right1"></span></a></h3><% End If %>
									<div class="txt"><%=nl2br(db2html(BrandContents))%></div>
								</div>
								<!--// 엠디등록 브랜드 -->
								
								<!-- 엠디등록 상품목록 -->
								<% sbMDTemplateItemListView %>
								<!--// 엠디등록 상품목록 -->
								<!-- 엠디등록 기프트 -->
								<%
									
									giftitemcnt=0
									If gift_img1<>"" Then giftitemcnt=giftitemcnt+1 End If
									If gift_img2<>"" Then giftitemcnt=giftitemcnt+1 End If
									If gift_img3<>"" Then giftitemcnt=giftitemcnt+1 End If
								%>
								<div class="evt-giftV18 evtGiftV17 item<%=giftitemcnt%>" style="display:<% If gift_isusing<1 Then %>none<% End If %>"> <!-- for dev msg 상품 갯수에 따라 item1, item2, item3 클래스 붙여주세요.-->
									<p class="tit" style="background-color:<%=ThemeBarColorCode%>;">GIFT EVENT</p> <!-- for dev msg 배경컬러 등록-->
									<ul class="txt">
										<% If gift_text1 <> "" And gift_isusing>0 Then %><li><span></span><%=gift_text1%></li><% End If %>
										<% If gift_text2 <> "" And gift_isusing>1 Then %><li><span></span><%=gift_text2%></li><% End If %>
										<% If gift_text3 <> "" And gift_isusing>2 Then %><li><span></span><%=gift_text3%></li><% End If %>
									</ul>
									<ul class="thumbnail">
										<% If gift_img1 <> "" And gift_isusing>0 Then %><li><span></span><img src="<%=gift_img1%>" alt=""></li><% End If %>
										<% If gift_img2 <> "" And gift_isusing>1 Then %><li><span></span><img src="<%=gift_img2%>" alt=""></li><% End If %>
										<% If gift_img3 <> "" And gift_isusing>2 Then %><li><span></span><img src="<%=gift_img3%>" alt=""></li><% End If %>
									</ul>
								</div>
								<!-- 엠디등록 기프트 -->
								<!-- 엠디등록 텍스트 -->
								<% If using_text1 <> "" And usinginfo>0 Then %>
								<div class="evtDescV17">
									<p class="tit"><%=using_text1%></p>
									<p class="txt"><%=using_contents1%></p>
								</div>
								<% End If %>
								<% If using_text2 <> "" And usinginfo>1 Then %>
								<div class="evtDescV17">
									<p class="tit"><%=using_text2%></p>
									<p class="txt"><%=using_contents2%></p>
								</div>
								<% End If %>
								<% If using_text3 <> "" And usinginfo>2 Then %>
								<div class="evtDescV17">
									<p class="tit"><%=using_text3%></p>
									<p class="txt"><%=using_contents3%></p>
								</div>
								<% End If %>
								<!--// 엠디등록 텍스트 -->
							</div>
						<% Else %>
							<div class="fullTemplatev17<% If mdtheme="1" Then %> typeA<% ElseIf mdtheme="2" Then %> typeB<% If textbgcolor<>1 Then %> typeBblack<% End If %><% ElseIf mdtheme="3" Then %> typeC<% ElseIf mdtheme="4" Then %> typeB<% Else %> typeA<% End If %>" style="background-color:<%=ThemeBarColorCode%>;">
								<div class="fullContV17">
									<div class="txtCont">
										<div class="inner">
											<% If ebrand<>"" Then %><a href="/street/street_brand_sub06.asp?makerid=<%=ebrand%>" class="brandName arrow"><%=SocName_Kor%><i></i></a><% End If %>
											<p class="title" style="word-break:keep-all;"><%=title_pc%></p>
											<p class="subcopy" style="word-break:keep-all;"><%=evt_subcopyk%></p>
											<% If blnsale Or blncoupon Then %>
											<div class="discount">
											<% If blnsale Then %><span class="cRd0V15">~<%=salePer%>%</span><% End If %>
											<% If blncoupon and saleCPer<>"" Then %><span class="cGr0V15"><%if saleCPer>99 then %><% If blnsale Then %>+<% End If %><%=formatNumber(saleCPer,0)%>원<% else %><% If blnsale Then %>+<% End If %><%=saleCPer%>%</span><% End If %><% End If %>
											</div>
											<% End If %>
											<% If blncomment Then %><a href="#commentarea" class="btnGo arrow">코멘트 쓰러가기<i></i></a><% End If %>
											<% IF (blnitemps) THEN %><a href="#reviewarea" class="btnGo arrow">상품후기 쓰러가기<i></i></a><% End If %>
										</div>
									</div>

										<% If mdtheme="2" Then %>
									<div class="slide">
										<% sbSlidetemplateMD %>
									</div>
										<% ElseIf mdtheme="4" Then %>
									<div class="eventContV15 tMar15">
									<div class="contF contW">
										<% sbSlidetemplate %>
									</div>
									</div>
										<% Else %>
									<div class="slide">
										<% sbSlidetemplateItemMD %>
									</div>
										<% End If %>

								</div>
								<!-- 엠디등록 텍스트 -->
								<% If using_text1 <> "" And usinginfo>0 Then %>
								<div class="evtDescV17">
									<p class="tit"><%=using_text1%></p>
									<p class="txt"><%=using_contents1%></p>
								</div>
								<% End If %>
								<% If using_text2 <> "" And usinginfo>1 Then %>
								<div class="evtDescV17">
									<p class="tit"><%=using_text2%></p>
									<p class="txt"><%=using_contents2%></p>
								</div>
								<% End If %>
								<% If using_text3 <> "" And usinginfo>2 Then %>
								<div class="evtDescV17">
									<p class="tit"><%=using_text3%></p>
									<p class="txt"><%=using_contents3%></p>
								</div>
								<% End If %>
								<!--// 엠디등록 텍스트 -->
								<!-- GIFT -->
								<div class="evtGiftV17" style="display:<% If gift_isusing<1 Then %>none<% End If %>">
									<p class="tit">GIFT EVENT</p>
									<ul class="txt">
										<% If gift_text1 <> "" And gift_isusing>0 Then %><li><span></span><%=gift_text1%></li><% End If %>
										<% If gift_text2 <> "" And gift_isusing>1 Then %><li><span></span><%=gift_text2%></li><% End If %>
										<% If gift_text3 <> "" And gift_isusing>2 Then %><li><span></span><%=gift_text3%></li><% End If %>
									</ul>
									<ul class="thumbnail">
										<% If gift_img1 <> "" And gift_isusing>0 Then %><li><span></span><img src="<%=gift_img1%>" alt=""></li><% End If %>
										<% If gift_img2 <> "" And gift_isusing>1 Then %><li><span></span><img src="<%=gift_img2%>" alt=""></li><% End If %>
										<% If gift_img3 <> "" And gift_isusing>2 Then %><li><span></span><img src="<%=gift_img3%>" alt=""></li><% End If %>
									</ul>
								</div>
								<!--// GIFT -->

							</div>
						<% End If %>
							<% If vDateView = False Then %>
							<div class="evtTermWrap">
								<div class="evtTerm"><p><strong>이벤트기간 : </strong><%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></p></div>
							</div>
							<% End If %>
							<% IF isArray(arrGroup) THEN %>
							<% IF UBound(arrGroup,2)=0 Then %>
							<!-- sorting 추가(0725) 기차바 없을 경우 노출 -->
							<div class="evtSortingV17">
								<select id="selSrtMet" class="ftRt optSelect" title="상품 정렬 방식 선택" name="itemsort" onChange="TnEvtSortChangeView(this.value);">
									<option value="1"<% If itemsort="1" Then Response.write " selected" %>>최신순</option>
									<option value="4"<% If itemsort="4" Then Response.write " selected" %>>인기순</option>
									<option value="7"<% If itemsort="7" Then Response.write " selected" %>>위시순</option>
								</select>
							</div>
							<% End If %>
							<% End If %>
							<!--// sorting 추가(0725) -->
						</div>
						<% j = 0 %>
						<% IF isArray(arrGroup) THEN %>
						<% If arrGroup(0,0) <> "" Then %>
							<div class="evtPdtListWrapV15">
							<% egCode = arrGroup(0,0) %>
								<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
							</div>
						<% j = 1 %>
						<% End If %>
							<div class="evtPdtListWrapV15">
						<% For intG = j To UBound(arrGroup,2) %>
							<% egCode = arrGroup(0,intG) %>
							<map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,intG))%></map>
							<div class="pdt-groupbarV20" id="mapGroup<%=arrGroup(0,intG)%>" style="color:<%=ThemeBarColorCode%>;">
								<p><%= arrGroup(1,intG) %></p>
								<% If arrGroup(11,intG) <> "0" Then %>
									<a href="<%=fnEvtItemGroupLinkInfo(arrGroup(11,intG)) %><%=arrGroup(9,intG)%>" class="btn-go">
									<%=fnEvtItemGroupLinkTitle(arrGroup(11,intG)) %><i></i></a>
								<% End If %>
							</div>
							<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
						<% Next %>
						<% End If %>
					</div>
				<%
					CASE "10" 'MD 등록 템플릿 I형 (2019.01.30 추가 corpse2)
				%>
					<script type="text/javascript">
					$(function(){
						$('.full-contV19, .evt-sliderV19').find('.pagination-progressbar-fill').css('background', '<%=ThemeBarColorCode%>'); // for dev msg : 테마색상 등록

						// top slider
						$('.full-contV19 .rolling').each(function(){
							var slider = $(this).find('.slider');
							var amt = slider.find('.rolling-item').length;
							var progress = $(this).find('.pagination-progressbar-fill');
							if (amt > 1) {
								slider.on('init', function(){
									var init = (1 / amt).toFixed(2);
									progress.css('transform', 'scaleX(' + init + ') scaleY(1)');
								});
								slider.on('beforeChange', function(event, slick, currentSlide, nextSlide){
									var calc = ( (nextSlide+1) / slick.slideCount ).toFixed(2);
									progress.css('transform', 'scaleX(' + calc + ') scaleY(1)');
								});
								slider.slick({
									autoplay: true,
									arrows: false,
									fade: true,
									speed: 750
								});
							} else {
								$(this).find('.pagination-progressbar').hide();
							}
						});

						// contents slider
						$('.evt-sliderV19').each(function(){
							var slider = $(this).find('.slider');
							var amt = slider.find('.slide-item').length;
							var progress = $(this).find('.pagination-progressbar-fill');
							if (amt > 1) {
								slider.on('init', function(){
									var init = (1 / amt).toFixed(2);
									progress.css('transform', 'scaleX(' + init + ') scaleY(1)');
								});
								slider.on('beforeChange', function(event, slick, currentSlide, nextSlide){
									var calc = ( (nextSlide+1) / slick.slideCount ).toFixed(2);
									progress.css('transform', 'scaleX(' + calc + ') scaleY(1)');
								});
								slider.slick({
									autoplay: true,
									arrows: true,
									speed: 750,
									adaptiveHeight: true
								});
							} else {
								$(this).find('.pagination-progressbar').hide();
							}
						});

						// only discount
						$(".evt-prdV18 .items .price").each(function(i, e) {
							if ($(this).parents('.evt-prdV18 .items').hasClass('only-discount')) {
								var discount = $(this).children('.discount').text()
								if ($(this).children().hasClass('color-red')) {
									$(this).children('.discount').text(discount + ' SALE');
								} else {
									$(this).children('.discount').text(discount + ' COUPON');
								}
							}
						});
					});
					</script>

					<div class="eventContV15 tMar15">
						<div class="bnrTemplate"><%=tArea%></div><%'PC 상단 추가 이미지 %>
						<!-- MD등록 이벤트 템플릿 -->
						<div id="mdTemplateDiv" class="contF <%=CHKIIF(vIsWide=True,"contW","")%>">
							<%=strExpireMsg%>
							<% If vDateView = False Then %>
							<div class="evt-term-wrap">
								<div class="evt-term"><p><strong>이벤트기간</strong> <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></p></div>
							</div>
							<% End If %>

                            <% If Trim(evtFileyn)="" Or evtFileyn = 0 Or isnull(evtFileyn) Then %>
                                <%=ehtml%>
                            <% Else %>
                                <% If checkFilePath(server.mappath(evtFile)) Then %>
                                    <%=ehtml%>
                                    <% server.execute(evtFile)%>
                                <% Else %>
                                    <%=ehtml%>
                                <% End If %>
                            <% End If %>

                            <% IF diaryStoryDisplay THEN %>
                                <div class="container diary2023">
                                    <div id="contentWrap" class="diary2023_event">
										<div class="blur01"></div>
										<div class="blur02"></div>
										<div class="line01"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/line03.png?v=2" alt=""></div>
										<div class="line02"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/line04.png" alt=""></div>
                                        <div class="top"></div>
                                        <div class="content">
                                            <div class="section">
                                                <div id="diarystory"></div>
                                                <div class="section02">
                                                    <div class="fullTemplatev17 typeI<%=CHKIIF(MasterSetCnt>0," typeI2","")%>">
                                                        <div class="full-contV19<% If textbgcolor<>1 Then %> blk<% else %> wht<% end if %>"<% if newGiftBox="" then %> id="topslide"<% end if %><% if CopyHide="1" then %> style="display:none"<% end if %>>
                                                            <% If isArray(arrAddTopSlide) Then '//이미지들 있음 %>
                                                            <div class="rolling">
                                                                <div class="slider">
                                                                    <% For intAi = 0 To UBound(arrAddTopSlide,2) %>
                                                                    <%
                                                                    slideImage = arrAddTopSlide(0,intAi)
                                                                    slideLinkURL = arrAddTopSlide(1,intAi)
                                                                    slideBGLeft = arrAddTopSlide(2,intAi)
                                                                    slideBGRight = arrAddTopSlide(3,intAi)
                                                                    slideContentsAlign = arrAddTopSlide(4,intAi)
                                                                    %>
                                                                    <% if slideContentsAlign=1 then %>
                                                                    <div class="rolling-item" style="background-image:url(<%=slideImage%>);">
                                                                        <div class="bg-color left" style="background-color:<%=slideBGLeft%>;"></div>
                                                                        <div class="bg-color right" style="background-color:<%=slideBGRight%>;"></div>
                                                                    </div>
                                                                    <% else %>
                                                                    <div class="rolling-item bg-wide" style="background-image:url(<%=slideImage%>);"></div>
                                                                    <% End If %>
                                                                    <% Next %>
                                                                </div>
                                                                <div class="pagination-progressbar"><span class="pagination-progressbar-fill"></span></div>
                                                            </div>
                                                            <% End If %>
                                                            <div class="desc<% if GroupItemType="C" then %> ct<% else %> lt<% end if %>">
                                                                <% If (salePer<>"" And salePer>"0") Or (saleCPer<>"" And saleCPer>"0") or (blngift) or (isOnePlusOne) or (isNew)  or (isOnlyTen) or (blncomment or blnbbs or blnitemps) Then %>
                                                                <div class="labels">
                                                                    <% If salePer<>"" And salePer>"0" and blnsale Then %>
                                                                    <span class="labelV18 label-red">~<%=salePer%>%</span>
                                                                    <% End If %>
                                                                    <% If saleCPer<>"" And saleCPer>"0" and blncoupon Then %>
                                                                    <span class="labelV18 label-green">+<%=saleCPer%>%</span>
                                                                    <% End If %>
                                                                    <% If blngift Then %>&nbsp;<span class="labelV18 label-blue">GIFT</span><% end if %>
                                                                    <% If isOnePlusOne Then %>&nbsp;<span class="labelV18 label-blue">1+1</span><% end if %>
                                                                    <% If isNew Then %>&nbsp;<span class="labelV18 label-black">런칭</span><% end if %>
                                                                    <% If blncomment or blnbbs or blnitemps Then %>&nbsp;<span class="labelV18 label-black">참여</span><% end if %>
                                                                    <% If isOnlyTen Then %>&nbsp;<span class="labelV18 label-blue">단독</span><% end if %>
                                                                </div>
                                                                <% End If %>
                                                                <p class="title"><%=title_pc%></p>
                                                                <p class="subcopy"><%=chrbyte(evt_subcopyk,50,"Y")%></p>
                                                                <div class="btn-group"> <!-- for dev msg : 테마색상 등록 -->
                                                                    <% If (blncomment) Then %>
                                                                    <a href="#commentarea" style="color:<%=ThemeColorCode%>;" class="btn-go">코멘트 이벤트 <span class="arrow" style="border-color:<%=ThemeColorCode%>;"></span></a>
                                                                    <% End If %>
                                                                    <%If (blnbbs) Then %>
                                                                    <a href="#photocmtarea" style="color:<%=ThemeColorCode%>;" class="btn-go">포토 코멘트 이벤트 <span class="arrow" style="border-color:<%=ThemeColorCode%>;"></span></a>
                                                                    <% End If %>
                                                                    <%If (blnitemps) Then %>
                                                                    <a href="#reviewarea" style="color:<%=ThemeColorCode%>;" class="btn-go">상품후기 이벤트 <span class="arrow" style="border-color:<%=ThemeColorCode%>"></span></a>
                                                                    <% End If %>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="cont">
                                                            <!-- I형 이벤트 멀티 컨텐츠 시작 -->
                                                            <% sbMultiContentsView %>
                                                            <!-- 엠디등록 기프트 -->
                                                            <% = newGiftBox %>
                                                        </div>
                                                    </div>
                                                    <!--// typeI -->
                                                    <% IF isArray(arrGroup) THEN %>
                                                        <% IF UBound(arrGroup,2)=0 Then %>
                                                        <!-- sorting 추가(0725) 기차바 없을 경우 노출 -->
                                                        <!-- groupItemSortDisplayFlag 추가 -->
                                                            <div v-show="groupItemSortDisplayFlag" id="selSrtMetDiv" class="evtSortingV17">
                                                                <select id="selSrtMet" class="ftRt optSelect" title="상품 정렬 방식 선택" title="상품 정렬 방식 선택" name="itemsort" onChange="TnEvtSortChangeView(this.value);">
                                                                    <option value="1"<% If itemsort="1" Then Response.write " selected" %>>최신순</option>
                                                                    <option value="4"<% If itemsort="4" Then Response.write " selected" %>>인기순</option>
                                                                    <option value="7"<% If itemsort="7" Then Response.write " selected" %>>위시순</option>
                                                                </select>
                                                            </div>
                                                        <% End If %>
                                                    <% End If %>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="bottom"></div>
                                    </div>
                                </div>
                            <% ELSE %>
                                <div class="fullTemplatev17 typeI<%=CHKIIF(MasterSetCnt>0," typeI2","")%>">
                                    <div class="full-contV19<% If textbgcolor<>1 Then %> blk<% else %> wht<% end if %>"<% if newGiftBox="" then %> id="topslide"<% end if %><% if CopyHide="1" then %> style="display:none"<% end if %>>
                                        <% If isArray(arrAddTopSlide) Then '//이미지들 있음 %>
                                        <div class="rolling">
                                            <div class="slider">
                                                <% For intAi = 0 To UBound(arrAddTopSlide,2) %>
                                                <%
                                                slideImage = arrAddTopSlide(0,intAi)
                                                slideLinkURL = arrAddTopSlide(1,intAi)
                                                slideBGLeft = arrAddTopSlide(2,intAi)
                                                slideBGRight = arrAddTopSlide(3,intAi)
                                                slideContentsAlign = arrAddTopSlide(4,intAi)
                                                %>
                                                <% if slideContentsAlign=1 then %>
                                                <div class="rolling-item" style="background-image:url(<%=slideImage%>);">
                                                    <div class="bg-color left" style="background-color:<%=slideBGLeft%>;"></div>
                                                    <div class="bg-color right" style="background-color:<%=slideBGRight%>;"></div>
                                                </div>
                                                <% else %>
                                                <div class="rolling-item bg-wide" style="background-image:url(<%=slideImage%>);"></div>
                                                <% End If %>
                                                <% Next %>
                                            </div>
                                            <div class="pagination-progressbar"><span class="pagination-progressbar-fill"></span></div>
                                        </div>
                                        <% End If %>
                                        <div class="desc<% if GroupItemType="C" then %> ct<% else %> lt<% end if %>">
                                            <% If (salePer<>"" And salePer>"0") Or (saleCPer<>"" And saleCPer>"0") or (blngift) or (isOnePlusOne) or (isNew)  or (isOnlyTen) or (blncomment or blnbbs or blnitemps) Then %>
                                            <div class="labels">
                                                <% If salePer<>"" And salePer>"0" and blnsale Then %>
                                                <span class="labelV18 label-red">~<%=salePer%>%</span>
                                                <% End If %>
                                                <% If saleCPer<>"" And saleCPer>"0" and blncoupon Then %>
                                                <span class="labelV18 label-green">+<%=saleCPer%>%</span>
                                                <% End If %>
                                                <% If blngift Then %>&nbsp;<span class="labelV18 label-blue">GIFT</span><% end if %>
                                                <% If isOnePlusOne Then %>&nbsp;<span class="labelV18 label-blue">1+1</span><% end if %>
                                                <% If isNew Then %>&nbsp;<span class="labelV18 label-black">런칭</span><% end if %>
                                                <% If blncomment or blnbbs or blnitemps Then %>&nbsp;<span class="labelV18 label-black">참여</span><% end if %>
                                                <% If isOnlyTen Then %>&nbsp;<span class="labelV18 label-blue">단독</span><% end if %>
                                            </div>
                                            <% End If %>
                                            <p class="title"><%=title_pc%></p>
                                            <p class="subcopy"><%=chrbyte(evt_subcopyk,50,"Y")%></p>
                                            <div class="btn-group"> <!-- for dev msg : 테마색상 등록 -->
                                                <% If (blncomment) Then %>
                                                <a href="#commentarea" style="color:<%=ThemeColorCode%>;" class="btn-go">코멘트 이벤트 <span class="arrow" style="border-color:<%=ThemeColorCode%>;"></span></a>
                                                <% End If %>
                                                <%If (blnbbs) Then %>
                                                <a href="#photocmtarea" style="color:<%=ThemeColorCode%>;" class="btn-go">포토 코멘트 이벤트 <span class="arrow" style="border-color:<%=ThemeColorCode%>;"></span></a>
                                                <% End If %>
                                                <%If (blnitemps) Then %>
                                                <a href="#reviewarea" style="color:<%=ThemeColorCode%>;" class="btn-go">상품후기 이벤트 <span class="arrow" style="border-color:<%=ThemeColorCode%>"></span></a>
                                                <% End If %>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="cont">
                                        <!-- I형 이벤트 멀티 컨텐츠 시작 -->
                                        <% sbMultiContentsView %>
                                        <!-- 엠디등록 기프트 -->
                                        <% = newGiftBox %>
                                    </div>
                                </div>
                                <!--// typeI -->
                                <% IF isArray(arrGroup) THEN %>
                                    <% IF UBound(arrGroup,2)=0 Then %>
                                    <!-- sorting 추가(0725) 기차바 없을 경우 노출 -->
                                    <!-- groupItemSortDisplayFlag 추가 -->
                                        <div v-show="groupItemSortDisplayFlag" id="selSrtMetDiv" class="evtSortingV17">
                                            <select id="selSrtMet" class="ftRt optSelect" title="상품 정렬 방식 선택" title="상품 정렬 방식 선택" name="itemsort" onChange="TnEvtSortChangeView(this.value);">
                                                <option value="1"<% If itemsort="1" Then Response.write " selected" %>>최신순</option>
                                                <option value="4"<% If itemsort="4" Then Response.write " selected" %>>인기순</option>
                                                <option value="7"<% If itemsort="7" Then Response.write " selected" %>>위시순</option>
                                            </select>
                                        </div>
                                    <% End If %>
                                <% End If %>
                            <% END IF %>
                        </div>
                        <% j = 0 %>
                        <% IF isArray(arrGroup) THEN %>
                        <% If arrGroup(0,0) <> "" Then %>
                            <div class="evtPdtListWrapV15">
                            <% egCode = arrGroup(0,0) %>
                                <div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
                            </div>
                        <% j = 1 %>
                        <% End If %>
                            <div class="evtPdtListWrapV15">
                        <% For intG = j To UBound(arrGroup,2) %>
                            <% egCode = arrGroup(0,intG) %>
                            <map name="mapGroup<%=egCode%>"><%=db2html(arrGroup(4,intG))%></map>
                            <div class="pdt-groupbarV20" id="mapGroup<%=arrGroup(0,intG)%>" style="color:<%=ThemeBarColorCode%>;">
                                <p><%= arrGroup(1,intG) %></p>
                                <% If arrGroup(11,intG) <> "0" Then %>
                                    <a href="<%=fnEvtItemGroupLinkInfo(arrGroup(11,intG)) %><%=arrGroup(9,intG)%>" class="btn-go">
                                    <%=fnEvtItemGroupLinkTitle(arrGroup(11,intG)) %><i></i></a>
                                <% End If %>
                            </div>
                            <div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
                        <% Next %>
                        	</div>
						<% End If %>
                    </div>
				<%	CASE ELSE '기본:메인이미지+상품목록 %>
					<div class="eventContV15 tMar15" align="center">
						<div class="bnrTemplate"><%=tArea%></div><%'PC 상단 추가 이미지 %>
						<div class="contF <%=CHKIIF(vIsWide=True,"contW","")%>"><% If eCode <> "68041" Then %><%=strExpireMsg%><% End If %><%=BrWeekHtml%>
							<% If slide_w_flag ="Y" Then %><% sbSlidetemplate '//slide template %><% End If %>
							<img src="<%=emimg%>" border="0" usemap="#Mainmap" class="gpimg"/>
							<% If Trim(evtFileyn)="" Or evtFileyn = 0 Or isnull(evtFileyn) Then %>
								<%=ehtml%>
							<% Else %>
								<% If checkFilePath(server.mappath(evtFile)) Then %>
									<% server.execute(evtFile)%>
								<% Else %>
									<%=ehtml%>
								<% End If %>
							<% End If %>
							<% If vDateView = False Then %><div class="evtTermWrap"><div class="evtTerm"><p><strong>이벤트기간</strong> : <%=Replace(esdate,"-",".")%> ~ <%=Replace(eedate,"-",".")%></p></div></div><% End If %>
						</div>
					</div>
					<%
                        IF NOT eventItemDisplayNone THEN
                    %>
					<div class="evtPdtListWrapV15 <% IF Not blnItemifno THEN %>nonePdtInfoV15<% End If %>"><% sbEvtItemView %></div>
					<% END IF %>
				<%	END SELECT %>
				<%'// 하단 이벤트 코드 임시배너.. 2016년 11월 이후엔 지워도 됨(2016.09.13 유태욱) %>
				<% If eCode="72792" or eCode="72793" or eCode="72794" Then %>
					<div class="wedding2016Bnr tMar10 ct">
						<div>
							<img src="http://webimage.10x10.co.kr/eventIMG/2016/72792/bnr_wedding.jpg" alt="" usemap="#relatedMap" />
							<map name="relatedMap" id="relatedMap">
								<area shape="rect" coords="1,1,564,152" href="/event/eventmain.asp?eventid=73012" onfocus="this.blur();" alt="둘이어서 더 행복한 HONEYMOON" />
								<area shape="rect" coords="579,1,1139,152" href="/event/eventmain.asp?eventid=72612" onfocus="this.blur();" alt="가을의 신부를 위한 SELF WEDDING" />
							</map>
						</div>
					</div>
				<% End If %>
				<%IF blnbbs THEN %><!--게시판-->
				<div class="evtPdtListWrapV15" id="photocmtarea">
					<% If board_text<>"" Then %>
					<div style="border-color:<%=ThemeColorCode%>;" class="cmt-group-barV19">
						<div class="inner">
							<p class="tit">Photo Comment Event</p>
							<p class="txt"><%=nl2br(board_text)%></p>
							<p class="date">
								<span><strong>작성 기간 :</strong> <%=Replace(board_start,"-",".")%> ~ <%=Replace(board_end,"-",".")%></span>
								<span><strong>당첨자 발표 :</strong> <%=Replace(epdate,"-",".")%></span>
							</p>
						</div>
						<div class="thumbnail"><% if board_freebie_img<> "" then %><img src="<%=board_freebie_img%>" alt=""><% end if %></div>
					</div>
					<%END IF%>
					<div class="photoCmtWrap tMar40">
						<iframe id="evt_bbs" name="ptCmtView" src="/event/lib/bbs_list.asp?eventid=<%=eCode%>&blnF=<%=blnFull%>" width="100%" class="autoheight" frameborder="0" scrolling="no"></iframe>
					</div>
				</div>
				<%END IF%>

				<%IF (blnitemps) THEN %><!--상품후기-->
				<div class="evtPdtListWrapV15" id="reviewarea">
					<% If eval_text<>"" Then %>
					<div style="border-color:<%=ThemeColorCode%>;" class="cmt-group-barV19">
						<div class="inner">
							<p class="tit">Review Event</p>
							<p class="txt"><%=nl2br(eval_text)%></p>
							<p class="date">
								<span><strong>작성 기간 :</strong> <%=Replace(eval_start,"-",".")%> ~ <%=Replace(eval_end,"-",".")%></span>
								<span><strong>당첨자 발표 :</strong> <%=Replace(epdate,"-",".")%></span>
							</p>
						</div>
						<div class="thumbnail"><% if eval_freebie_img<> "" then %><img src="<%=eval_freebie_img%>" alt=""><% end if %></div>
					</div>
					<% End If %>
					<div class="basicReviewWrap tMar40">
						<!-- #include virtual="/event/lib/evaluate_lib.asp" -->
					</div>
				</div>
				<%END IF%>
				<% If blncomment Then %>
				<div class="evtPdtListWrapV15" id="commentarea">
					<!-- 코멘트 이벤트, 리뷰이벤트 -->
					<% If comm_text<>"" Then %>
					<div style="border-color:<%=ThemeColorCode%>;" class="cmt-group-barV19">
						<div class="inner">
							<p class="tit">Comment Event</p>
							<p class="txt"><%=nl2br(comm_text)%></p>
							<p class="date">
								<span><strong>작성 기간 :</strong> <%=Replace(comm_start,"-",".")%> ~ <%=Replace(comm_end,"-",".")%></span>
								<span><strong>당첨자 발표 :</strong> <%=Replace(epdate,"-",".")%></span>
							</p>
						</div>
						<div class="thumbnail"><% if freebie_img<> "" then %><img src="<%=freebie_img%>" alt=""><% end if %></div>
					</div>
					<% end if %>
					<% if trim(eedate)<>"" then %>
						<% if left(eedate, 10) >= left(now(), 10) then %>
							<div class="basicCmtWrap tMar40" id="commentarea">
								<iframe id="evt_cmt" src="/event/lib/iframe_comment.asp?eventid=<%=eCode%>&blnF=<%=blnFull%>&blnB=<%=blnBlogURL%>&epdate=<%=epdate%>" width="100%" class="autoheight"  frameborder="0" scrolling="no"></iframe>
							</div>
						<% end if %>
					<% end if %>
					<!--// 코멘트 이벤트, 리뷰이벤트 -->
				</div>
				<%END IF%>

				<%'!-- 관련 이벤트 --%>
				<%
				If blnFull Then  '// 풀단일때만
					Dim oArrIssue , oInt , oSale , oLink , oName
					set cEvent = new ClsEvtCont
						cEvent.FECode = eCode
						cEvent.FBrand = ebrand
						cEvent.FDevice = "W" 'device
						cEvent.FEDispCate = edispcate
						cEvent.FEKind = ekind
						oArrIssue = cEvent.fnAnotherEventListGet

					set cEvent = nothing
				%>
				<% If isArray(oArrIssue) THEN %>
				<div class="related-event">
					<div class="inner-cont">
						<h3>관련 이벤트</h3>
						<a href="/shoppingtoday/shoppingchance_allevent.asp?gaparam=event_related_0" class="btn-linkV18 link2">이벤트 더 보기 <span></span></a>
						<div class="list-card item-360">
							<ul>
								<% For oInt = 0 To UBound(oArrIssue,2)
									oSale = ""
									oName = ""
									If oArrIssue(4,oInt) Or oArrIssue(5,oInt) Then '//issale ,  iscoupon
										if ubound(Split(oArrIssue(1,oInt),"|"))> 0 Then
											If oArrIssue(4,oInt) Or (oArrIssue(4,oInt) And oArrIssue(5,oInt)) then
												oName	= cStr(Split(oArrIssue(1,oInt),"|")(0))
												oSale	= cStr(Split(oArrIssue(1,oInt),"|")(1))
											ElseIf oArrIssue(5,oInt) Then
												oName	= cStr(Split(oArrIssue(1,oInt),"|")(0))
												oSale	= cStr(Split(oArrIssue(1,oInt),"|")(1))
											End If
										Else
											oName = oArrIssue(1,oInt)
										end If
									Else
										oName = oArrIssue(1,oInt)
									End If

									IF oArrIssue(2,oInt)="I" and oArrIssue(3,oInt)<>"" THEN '링크타입 체크
										oLink = "location.href='" & oArrIssue(3,oInt) & "?gaparam=event_related_"& oInt &"';"
									ELSE
										oLink = "/event/eventmain.asp?eventid="&oArrIssue(0,oInt)&"&pEtr="&eCode&"&gaparam=event_related_"& oInt+1  ''2018/04/30 
									END If
								%>
								<li>
									<a href="<%=oLink%>">
										<div class="thumbnail"><img src="<%=oArrIssue(6,oInt)%>" alt="<%=db2html(oName)%>" /></div>
										<div class="desc">
											<p class="headline"><span class="ellipsis"><%=db2html(Replace(oName,"<br/>",""))%></span> <% If oSale <>"" Then %><b class="discount color-red"><%=db2html(oSale)%></b><% End If %></p>
											<p class="subcopy subcopy-ellipsis"><% If oArrIssue(5,oInt) Then %><b class="discount color-green">쿠폰</b><% End If %> <%=oArrIssue(7,oInt)%></p>
										</div>
									</a>
								</li>
								<% Next %>
							</ul>
						</div>
					</div>
				</div>
				<% End If %>
				<% End If %>
				<%'!--// 관련 이벤트 --%>
			</div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<form name="frmEvt" method="post">
	<input type="hidden" name="hidM" value="I">
	<input type="hidden" name="eventid" value="<%=eCode%>">
</form>
<iframe id="wishProc1" name="wishProc1" src="about:blank" frameborder="0" width="0" height="0"></iframe>
<script type="text/javascript" src="/lib/js/jquery.iframe-auto-height.js"></script>
<% If slide_w_flag="Y" or slide_w_flagmulti="Y" Then 'flag 있을경우 %>
<script type="text/javascript" src="/lib/js/evt_slide_template.js"></script>
<% End If %>

    <script src="/vue/diarystory2023/store.js?v=1.00"></script>
    <script>
        var evt_code = '<%=eCode%>';

        <% IF diaryStoryDisplay THEN %>
            $("#mdTemplateDiv").addClass('contW');

            var diarystory = new Vue({
                el: "#diarystory"
                , store : store
                , template : `
                    <div  class="section01">
                        <div class="sect01_wrap">
                            <div class="sect01_link">
                                <div>
                                    <div class="date">
                                        <p><a href="/diarystory2023/index.asp">9/1</a></p>
                                    </div>
                                    <div class="dropdown" style="display:block;">
                                        <div class="select_wrap on">
                                            <div class="event_select"><p v-html="evt_name"></p><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/arrow_down.png" alt=""></div>
                                            <ul class="select_ul">
                                                <p><a @click="send_amplitude('click_diary2023_popupmenu', {'index' : 1, 'type' : 'basic'})" href="/diarystory2023/ranking.asp">📈 베스트셀러</a></p>
                                                <p v-for="(item, index) in events_link"><a @click="go_event_with_diary_header(item.evt_code, index)" href="javascript:void(0)" v-html="item.title"></a></p>
                                                <p><a @click="send_amplitude('click_diary2023_popupmenu', {'index' : events_link.length + 2, 'type' : 'basic'})" href="/diarystory2023/category.asp">📖 모든 다꾸템 보기</a></p>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="search">
                                    <ul class="input_box">
                                        <a href="javascript:void(0)" @click="go_search()"><img src="//webimage.10x10.co.kr/fixevent/event/2022/daccu2023/search.png" alt="" class="ico_search"></a>
                                        <input @keyup.enter="go_search()" v-model="search_keyword" type="text" placeholder="텐텐다꾸 상품 검색하기">
                                    </ul>
                                    <ul class="reco_search">
                                        <p><a @click="go_search('캘린더')" href="javascript:void(0)">캘린더</a></p>
                                        <p><a @click="go_search('플래너')" href="javascript:void(0)">플래너</a></p>
                                        <p><a @click="go_search('여행기록')" href="javascript:void(0)">여행기록</a></p>
                                        <p><a @click="go_search('스티커')" href="javascript:void(0)">스티커</a></p>
                                        <p><a @click="go_search('굿노트속지')" href="javascript:void(0)">굿노트속지</a></p>
                                    </ul>
                                </div>
                            </div>
							<a href="/diarystory2023/index.asp"><div class="sect01_inform">
								<p>기록의 즐거움<br><span>2023 텐텐다꾸</span></p>
								<li>추억을 기억하는<br>가장 즐거운 방법!</li>
							</div></a>
                        </div>
                    </div>
                `
                , created(){
                    const _this = this;
                    this.$store.dispatch("GET_EVENTS_LINK").then(function(){
                       _this.events_link.forEach(function(item){
                           if(item.evt_code == <%=eCode%>){
                               _this.evt_name = item.title;
                           }
                       });
                    });
                }
                , computed : {
                    events_link(){
                        return this.$store.getters.events_link;
                    }
                }
                , data(){
                    return {
                        evt_name : ""
                        , search_keyword : ""
                    }
                }
                , methods : {
                    go_event_with_diary_header(evt_code, index){
                        this.send_amplitude('click_diary2023_popupmenu', {'index' : index+2, 'type' : 'event', "eventcode" : evt_code});
                        parent.location.href='/event/eventmain.asp?eventid='+evt_code + '&diarystory=true';
                    }
                    , go_search(keyword){
                        if(keyword){
                            this.send_amplitude('click_diary2023_searchpopup_keyword', {"keyword" : keyword});
                            location.href = "/search/search_result.asp?rect=" + keyword + "&diarystoryitem=R"
                        }else{
                            this.send_amplitude('click_diary2023_searchpopup', "");
                            location.href = "/search/search_result.asp?rect=" + this.search_keyword + "&diarystoryitem=R"
                        }
                    }

                    , send_amplitude(name, data){
                        fnAmplitudeEventActionJsonData(name, JSON.stringify(data));
                    }
                }
            });

            $('.dropdown .event_select').on('click', function () {
                $('.dropdown .select_ul').toggleClass('drop');
                $('.dropdown .event_select').toggleClass('clicked');
            });

            /* 셀렉트 박스 외 클릭시 셀렉트박스 닫기 */
            $('body').on('click', function (e) {
                if ($('.dropdown .select_ul').css('display') == 'block') {
                    if ($('.dropdown .select_wrap').has(e.target).length == 0) {
                        $('.dropdown .select_ul').removeClass('drop');
                    }
                }
            });
        <% END IF %>
    </script>
    <script src="/vue/event/eventmain.js?v=1.00"></script>
	<script>
	function jsDownCoupon(stype,idx){
	<% IF IsUserLoginOK THEN %>
	var frm;
		frm = document.frmC;
		//frm.target = "iframecoupon";
		frm.action = "/shoppingtoday/couponshop_process.asp";
		frm.stype.value = stype;
		frm.idx.value = idx;
		frm.submit();
	<%ELSE%>
		if(confirm("로그인하시겠습니까?")) {
			self.location="/login/loginpage.asp?backpath=<%=Server.URLEncode(CurrURLQ())%>";
		}
	<%END IF%>
	}
	</script>
    <form name="frmC" method="post">
        <input type="hidden" name="stype" value="">
        <input type="hidden" name="idx" value="">
    </form>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->