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
<!-- #include virtual="/lib/inc/head.asp" -->
<%'쇼핑찬스 이벤트 내용보기
dim eCode
dim cEvent, cEventItem, arrItem, arrGroup, intI, intG, rdmNo
dim arrRecent, intR
dim bidx, ThemeColorCode, ThemeBarColorCode
dim ekind, emanager, escope, ename, esdate, eedate, estate, eregdate, epdate, eOnlyName
dim ecategory, ecateMid, blnsale, blngift, blncoupon, blncomment, blnbbs, blnitemps, blnapply
dim etemplate, emimg, ehtml, eitemsort, ebrand,gimg,blnFull,blnItemifno,blnBlogURL, bimg, edispcate, vDisp, vIsWide, j, itemsort
dim itemid : itemid = ""
Dim evtFile
Dim evtFileyn
dim egCode, itemlimitcnt,iTotCnt, strBrandListURL
dim cdl, cdm, cds
dim com_egCode : com_egCode = 0
Dim blnitempriceyn, clsEvt, isMyFavEvent, favCnt, vDateView
Dim onlyForMDTab, intTab
Dim evt_mo_listbanner , vIsweb , vIsmobile , vIsapp
Dim vTmpgcode : vTmpgcode = "" '//상품없는 그룹 숨김용 변수
Dim iPageSize '//마감임박 이벤트용
Dim evt_subcopyk '//서브카피
Dim sgroup_w '//이벤트 그룹형 랜덤
Dim arrTopGroup '//랜덤 그룹 top1
Dim etc_itemid '// 상품이벤트 상품코드
Dim cEventadd , slide_w_flag '//슬라이드 사용 미사용
Dim comm_isusing, comm_text, freebie_img, comm_start, comm_end, gift_isusing, gift_text1, gift_img1, gift_text2, gift_img2
Dim gift_text3, gift_img3, usinginfo, using_text1, using_contents1, using_text2, using_contents2, using_text3, using_contents3
Dim mdtheme, themecolor, textbgcolor, mdbntype, salePer, saleCPer, SocName_Kor, evt_type, title_pc, endlessView, eventtype_pc, evt_pc_addimg_cnt
'//logparam
Dim logparam : logparam = "&pEtr="&eCode

Dim upin '카카오 이벤트 key값 parameter
	upin = requestCheckVar(Request("upin"),200)

IF application("Svr_Info") = "Dev" THEN
	eCode   =  67500
Else
	eCode   =  85324
End If


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
END IF

egCode = getNumeric(requestCheckVar(Request("eGC"),8))	'이벤트 그룹코드

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


		IF etemplate = "3" OR etemplate = "7" OR etemplate = "9" THEN	'그룹형(etemplate = "3" or "7")일때만 그룹내용 가져오기
			If sgroup_w And egCode = "0" Then '// 그룹형 랜덤 체크 되었을때
				arrTopGroup = cEvent.fnGetEventGroupTop
				egCode = arrTopGroup(0,0)
			End If
			cEvent.FEGCode = 	egCode
			arrGroup =  cEvent.fnGetEventGroup
			onlyForMDTab = cEvent.fnGetEventGpcode0
		END IF

		cEvent.FECategory  = ecategory
		arrRecent = cEvent.fnGetRecentEvt_Cache ''fnGetRecentEvt
		ThemeColorCode=cEvent.fnEventColorCode
		ThemeBarColorCode=cEvent.fnEventBarColorCode
	set cEvent = nothing
		cdl = ecategory
		cdm = ecateMid

		IF vDisp = "" THEN blnFull= True	'카테고리가 없을경우 전체페이지로
		IF eCode = "" THEN
		Alert_return("유효하지 않은 이벤트 입니다.")
		dbget.close()	:	response.End
		END IF

	'// 이벤트 시작전이면 STAFF를 제외한 이벤트 메인으로 리다이렉션
	if datediff("d",esdate,date)<0 and GetLoginUserLevel<>"7" then
		response.redirect("/shoppingtoday/shoppingchance_allevent.asp")
		dbget.close()	:	response.End
	end if

	'// 상품이벤트(kind13)일경우 상품상세로 리다이렉션
	If Trim(ekind)="13" Then
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
	IF (datediff("d",eedate,date()) >0) OR (estate =9) Then
		strExpireMsg="<div class=""finish-event"">이벤트가 종료되었습니다.</div>"
	%>
		<script type="text/javascript" src="/common/addlog.js?tp=noresult&ror=<%=server.UrlEncode(Request.serverVariables("HTTP_REFERER"))%>"></script>
	<%
	END If
	END If

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

%>
<% sbEvtItemView %>
<!-- #include virtual="/lib/db/dbclose.asp" -->