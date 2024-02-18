<%@ codepage="65001" language="VBScript" %>
<% Option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/enjoy/weddingCls.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/shopping/sp_evaluatesearchercls.asp" -->
<!-- #include virtual="/lib/classes/membercls/sp_myfavoriteEventCls.asp" -->
<!-- #include virtual="/lib/classes/enjoy/shoppingchanceCls_B.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<%
	'세션 UTF-8 지정
	Session.CodePage = "65001"

	'/서버 주기적 업데이트 위한 공사중 처리 '2011.11.11 한용민 생성
	'/리뉴얼시 이전해 주시고 지우지 말아 주세요
	Call serverupdate_underconstruction()

	'공사중 표시(리뉴얼시)
	''Call Underconstruction()

	'# 현재 포함된 페이지명 접수
	dim nowViewPage, splTemp
	splTemp = Split(request.ServerVariables("SCRIPT_NAME"),"/")
	nowViewPage = splTemp(Ubound(splTemp))

	Dim vSavedID
	vSavedID = tenDec(request.cookies("mSave")("SAVED_ID"))

	'####### .js 파일 연동시 사용 - CC_currentyyyymmdd=V_CURRENTYYYYMM 변수로 .js에서 해당 날짜 이미지/링크등 뿌려줌
	dim CC_currentyyyymmdd
	On Error Resume Next
	CC_currentyyyymmdd=request("yyyymmdd")
	On Error Goto 0
	if CC_currentyyyymmdd="" then CC_currentyyyymmdd = Left(now(),10)
	'#########################################################################


	'###### 제휴사 flag 관련 - 주문 저장시/회원가입시  제휴사 Flag 저장 ######
	dim irdsite20, arrRdSite, irdData
	irdsite20 = requestCheckVar(request("rdsite"),32)
	irdData = requestCheckVar(request("rddata"),100)	'기타 전송 데이터 (회원ID,이벤트 번호 등)
	'//파라메터가 겹쳐있는 경우 중복 제거
	if irdsite20<>"" then
		arrRdSite = split(irdsite20,",")
		irdsite20 = arrRdSite(0)
	end if

	if (irdsite20<>"") then
		if (request.cookies("rdsite")<>irdsite20) then
			response.cookies("rdsite").domain = "10x10.co.kr"
			response.cookies("rdsite") = irdsite20
		end if
		if (request.cookies("rddata")<>irdData) then
			response.cookies("rddata") = irdData
		end if
	end if
	'#########################################################################

	'// 페이지 환경 변수
	Dim strPageTitle, strPageDesc, strPageUrl, strHeaderAddMetaTag, strPageImage, strPageKeyword
	Dim strRecoPickMeta		'RecoPick환경변수

	if strPageTitle="" then strPageTitle = "텐바이텐 10X10 : 감성채널 감성에너지"
	if strPageDesc="" then strPageDesc = "생활감성채널 10x10(텐바이텐)은 디자인소품, 아이디어상품, 독특한 인테리어 및 패션 상품 등으로 고객에게 즐거운 경험을 주는 디자인전문 쇼핑몰 입니다."

	'// 페이지 검색 키워드
	if strPageKeyword="" then
		strPageKeyword = "감성디자인, 디자인상품, 아이디어상품, 즐거움, 선물, 문구, 소품, 인테리어, 가구, 가전, 패션, 화장품, 반려동물, 핸드폰케이스, 패브릭, 조명, 식품"
	else
		strPageKeyword = "10x10, 텐바이텐, 감성, 디자인, " & strPageKeyword
	end if

	'// Facebook 오픈그래프 메타태그 작성 (필요에 따라 변경요망)
	if strHeaderAddMetaTag = "" then
		strHeaderAddMetaTag = "<meta property=""og:title"" content=""" & strPageTitle & """ />" & vbCrLf &_
							"	<meta property=""og:type"" content=""website"" />" & vbCrLf
	end if
	if strPageUrl<>"" then
		strHeaderAddMetaTag = strHeaderAddMetaTag & "	<meta property=""og:url"" content=""" & strPageUrl & """ />" & vbCrLf
	end if
	if Not(strPageImage="" or isNull(strPageImage)) then
		strHeaderAddMetaTag = strHeaderAddMetaTag & "	<meta property=""og:image"" content=""" & strPageImage & """ />" & vbCrLf &_
													"	<link rel=""image_src"" href=""" & strPageImage & """ />" & vbCrLf
	else
		'기본 이미지
		strHeaderAddMetaTag = strHeaderAddMetaTag & "	<meta property=""og:image"" content=""http://www.10x10.co.kr/lib/ico/10x10TouchIcon_150303.png"" />" & vbCrLf &_
													"	<link rel=""image_src"" href=""http://www.10x10.co.kr/lib/ico/10x10TouchIcon_150303.png"" />" & vbCrLf
	end If
	if strRecoPickMeta<>"" then strHeaderAddMetaTag = strHeaderAddMetaTag & strRecoPickMeta
%>
<!-- #include virtual="/lib/inc_const.asp" -->
<%'쇼핑찬스 이벤트 내용보기
dim eCode : eCode   = requestCheckVar(Request("eventid"),10) '이벤트 코드번호
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

If Not(isNumeric(eCode)) then
	Call Alert_Return("잘못된 이벤트번호입니다.")
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

%>
			<% If arrGroup(0,0) <> "" Then %>
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
%>
<!-- #include virtual="/lib/db/dbclose.asp" -->