<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/classes/search/keywordcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls.asp" -->
<!-- #include virtual="/shopping/category_code_check.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<%
Dim dispCate, vCateName,i
dim classStr, adultChkFlag, adultPopupLink, linkUrl
dispCate = vDisp

'// 전시 카테고리중 사용 안하는 카테고리는 메인 페이지로 넘긴다.
Select Case Left(Trim(vDisp), 3)
	Case "101","102","103","104","121","122", "120", "112", "119", "117", "116", "118", "110", "124", "125"

	Case Else
		Response.write "<script>alert('사용하지 않거나 존재하지 않는 카테고리 입니다.\n메인으로 이동합니다.');location.replace('/');</script>"
		Response.End
End Select

vCateName = CategoryNameUseLeftMenuDB(vDisp)
if isNull(vCateName) then vCateName=""

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			Response.Redirect "http://m.10x10.co.kr/category/category_list.asp?disp=" & vDisp & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			dbget.Close
			REsponse.End
		end if
	end if
end if

dim strCateNmList
Dim cDCa, vCArr, vCi, vBDDNY, vIsDownDep, vCtLiView
	vIsDownDep = "o"
	Set cDCa = New CAutoCategory
	cDCa.FRectDisp = vDisp
	vCArr = cDCa.GetDownCateList
	Set cDCa = Nothing

	strCateNmList = db2html(GetCategoryListAll_B(vDisp))
	if strCateNmList <> "" and IsArray(vCArr) and Not vIsBookCate then
		For i=0 To UBound(vCArr,2)
			strCateNmList = strCateNmList & ", " & db2html(vCArr(1,i))
		next
	end if

'//logparam
Dim logparam : logparam = "&pCtr="&dispCate

	'// 페이지 타이틀 및 페이지 설명 작성
	strPageTitle = "텐바이텐 10X10 : " & vCateName
	if strCateNmList <> "" then
		strPageKeyword = replace(strCateNmList,"""","")
	else
		strPageKeyword = CategoryNameUseLeftMenu(left(vDisp,3)) & ", " & replace(vCateName,"""","")
	end if


Dim isShowSumamry : isShowSumamry = true  ''탭별 검색 갯수 표시 여부 : 느릴경우 FALSE 로
Dim isSaveSearchKeyword : isSaveSearchKeyword = false  ''검색어 DB에 저장 여부
Dim tmpPrevSearchKeyword, tmpCurrSearchKeyword


dim SearchText : SearchText = requestCheckVar(request("rect"),100) '현재 입력된 검색어
dim PrevSearchText : PrevSearchText = requestCheckVar(request("prvtxt"),100) '이전 검색어
dim ReSearchText : ReSearchText=requestCheckVar(request("rstxt"),100) '결과내 재검색용
dim ExceptText : ExceptText=requestCheckVar(request("extxt"),100) '결과내 제외어
dim DocSearchText
dim SearchItemDiv : SearchItemDiv="n"	'추가 카테고리 포함
dim SearchCateDep : SearchCateDep= "T"	'하위카테고리 모두 검색

dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),5))
dim SortMet		: SortMet = request("srm")
dim SearchFlag : SearchFlag = request("sflag")
dim CurrPage : CurrPage = getNumeric(requestCheckVar(request("cpg"),8))
dim CheckResearch : CheckResearch= request("chkr")
dim CheckExcept : CheckExcept= request("chke")
dim makerid : makerid = ReplaceRequestSpecialChar(request("mkr"))
dim minPrice : minPrice = getNumeric(requestCheckVar(request("minPrc"),8))
dim maxPrice : maxPrice = getNumeric(requestCheckVar(request("maxPrc"),8))
dim deliType : deliType = request("deliType")
dim colorCD : colorCD = ReplaceRequestSpecialChar(request("iccd"))
dim styleCD : styleCD = ReplaceRequestSpecialChar(request("styleCd"))
dim attribCd : attribCd = ReplaceRequestSpecialChar(request("attribCd"))
dim arrCate : arrCate = ReplaceRequestSpecialChar(request("arrCate"))
dim SellScope 	: SellScope=requestCheckVar(request("sscp"),1)			'품절상품 제외여부
if SellScope = "" then
	if left(dispCate,6)="104119" Then
		SellScope = "N"                                  ''취미/강좌 카테고리는 기본 품절 포함
	Else
		SellScope = "Y"                                  ''기본 품절제외(eastone)
	end if
end if
dim ScrollCount : ScrollCount = 10
dim ListDiv : ListDiv = "list"		'카테고리/검색 구분용
dim LogsAccept : LogsAccept = true		'검색Log 사용여부 (검색페이지: 사용)
dim lp, ColsSize
dim sColorMode : sColorMode = "S"
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)
if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)

dim imgSz	: imgSz = chkIIF(icoSize="M",240,150)

'// 실제 타자로 입력된 검색어인지(2013-08-02 13:08:50 적용)
dim IsRealTypedKeyword : IsRealTypedKeyword = True
if requestCheckVar(request("exkw"),1) = "1" then
	IsRealTypedKeyword = False
end if

dim chkMyKeyword : chkMyKeyword=false		'나의 검색어 (추후 개발)

dim diarystoryitem 	: diarystoryitem=requestCheckVar(request("diarystoryitem"),1)			'다이어리 스토리 아이템 소팅
dim parentsPage : parentsPage = "categoryList"

' // 2020-06-04 디자인 문구, 패션잡화, 패션의류, 주얼리/시계, 뷰티 하위 모든카테 포함 기본정렬방식 인기순으로 변경
if SortMet="" and ( left(dispCate,3)="101" or left(dispCate,3)="116" or  left(dispCate,3)="117" or  left(dispCate,3)="118" or  left(dispCate,3)="125")  then
	SortMet="be"
end if

if CurrPage="" then CurrPage=1
if colorCD="" then colorCD="0"
IF searchFlag="" Then
	'// 22년 21주년 기간에는 기본으로 세일탭 지정
	if date()>="2022-10-10" and date()<="2022-10-24" then
		'할인상품이 적어도 3건 이상만 할인탭으로 표시
		if getCateListCount("sc",SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText)>=3 then
			searchFlag= "sc"
		Else
			searchFlag= "n"
		end if
	else
		'//기본으로 세일탭 지정 2021.10.01 정태훈 추가
		searchFlag= "n"
	end if
end if

Select Case SearchFlag
	Case "n", "sc", "fv", "pk"
		'상품 목록 크기에 따라 선택
		if icoSize="B" then
			'2행 5열(총10개)
			ColsSize =2
			IF PageSize="" or PageSize<10 then PageSize = 10
		elseif icoSize="M" then
			'4행 10열(총40개)
			ColsSize =4
			IF PageSize="" or PageSize<40 then PageSize = 40
		else
			'6행 12열(총72개)
			ColsSize =6
			IF PageSize="" or PageSize<72 then PageSize = 72
		end if
	Case "ea"
		'일반 상품후기 2행 10열(총 20개)
		PageSize=20
	Case "ep"
		'포토 상품후기 2행 3열(총 6개)
		PageSize=6
	'2012-06-05	김진영 추가
	Case Else
		SearchFlag="n"
		if icoSize="B" then
			'2행 5열(총10개)
			ColsSize =2
			IF PageSize="" or PageSize<10 then PageSize = 10
		elseif icoSize="M" then
			'4행 10열(총40개)
			ColsSize =4
			IF PageSize="" or PageSize<40 then PageSize = 40
		else
			'6행 12열(총72개)
			ColsSize =6
			IF PageSize="" or PageSize<72 then PageSize = 72
		end if
End Select

IF CStr(SearchText)=CStr(PrevSearchText) Then
	LogsAccept = false
End if

	dim enc,rect
	enc = Request("enc")
	'인코딩 여부에 따른 값변환(UTF-8 > ASCII)
	IF enc="UTF-8" THEN
		rect = URLDecodeUTF8(request.ServerVariables("QUERY_STRING"))
		rect = Replace(rect, "enc=UTF-8&", "")
		response.redirect("?" & rect)
		dbget.close()	:	response.End
	END IF

if CheckResearch="undefined" then CheckResearch=""
if len(CheckResearch)>5 then CheckResearch=""
IF CheckResearch="" then CheckResearch=false
if CheckExcept="undefined" then CheckExcept=""
if len(CheckExcept)>5 then CheckExcept=""
IF CheckExcept="" then CheckExcept=false

SearchText = RepWord(SearchText,"[^가-힣a-zA-Z0-9.&%\-\s]","")
ExceptText = RepWord(ExceptText,"[^가-힣a-zA-Z0-9.&%\-\s]","")

IF CheckReSearch Then
	ReSearchText = ReSearchText & " " & SearchText

	ReSearchText = RepWord(ReSearchText,SearchText,"")
	ReSearchText = RepWord(ReSearchText,"[\s]{2,}"," ")
	ReSearchText = RepWord(ReSearchText,"^[+\s]","")
	ReSearchText = ReSearchText & " " & SearchText
	DocSearchText = ReSearchText
Else
	ReSearchText  =	SearchText
	DocSearchText = SearchText
End if

if CheckExcept then
	ReSearchText  =	ReSearchText
	DocSearchText = ReSearchText
	SearchText = ExceptText
end if

IF Len(DocSearchText)<>0 and isNumeric(DocSearchText) THEN
	If Left(DocSearchText,1) <> "0" Then
		DocSearchText = Cdbl(DocSearchText)
	End If
'	DocSearchText = Cdbl(DocSearchText)
END IF

if dispCate = "119114" and SortMet="" then SortMet="be"

dim iRows,ix

'// 총 검색수 산출
' dim oTotalCnt
' set oTotalCnt = new SearchItemCls
' oTotalCnt.FRectSearchTxt = DocSearchText
' oTotalCnt.FRectExceptText = ExceptText
' oTotalCnt.FRectSearchItemDiv = SearchItemDiv
' oTotalCnt.FRectSearchCateDep = SearchCateDep
' oTotalCnt.FListDiv = ListDiv
' oTotalCnt.FSellScope=SellScope
' oTotalCnt.getTotalCount

'// 상품검색
dim oDoc,iLp
set oDoc = new SearchItemCls
If now() >= #2022-09-01 00:00:00# and now() < #2023-02-01 00:00:00# Then
	oDoc.FRectDiaryItem = diarystoryitem
elseif application("Svr_Info")="Dev" or application("Svr_Info")="staging" then
	oDoc.FRectDiaryItem = diarystoryitem
end if
oDoc.FRectSearchTxt = DocSearchText
oDoc.FRectPrevSearchTxt = PrevSearchText
oDoc.FRectExceptText = ExceptText
oDoc.FRectSortMethod	= SortMet
oDoc.FRectSearchFlag = searchFlag
oDoc.FRectSearchItemDiv = SearchItemDiv
oDoc.FRectSearchCateDep = SearchCateDep
oDoc.FRectCateCode	= dispCate
oDoc.FRectMakerid	= makerid
oDoc.FminPrice	= minPrice
oDoc.FmaxPrice	= maxPrice
oDoc.FdeliType	= deliType
oDoc.FCurrPage = CurrPage
oDoc.FPageSize = PageSize
oDoc.FScrollCount = ScrollCount
oDoc.FListDiv = ListDiv
oDoc.FLogsAccept = LogsAccept
oDoc.FRectColsSize = ColsSize
oDoc.FcolorCode = colorCD
oDoc.FstyleCd = styleCd
oDoc.FattribCd = attribCd
oDoc.FSellScope=SellScope
oDoc.FarrCate=arrCate

oDoc.getSearchList

'// 검색어 DB저장
tmpPrevSearchKeyword = PrevSearchText
tmpCurrSearchKeyword = SearchText

'// 검색 조건 재설정
PrevSearchText = SearchText
'CheckResearch=false

'// 검색결과 내위시 표시정보 접수
if IsUserLoginOK then
	'// 검색결과 상품목록 작성
	dim rstArrItemid: rstArrItemid=""
	IF oDoc.FResultCount >0 then
		For iLp=0 To oDoc.FResultCount -1
			rstArrItemid = rstArrItemid & chkIIF(rstArrItemid="","",",") & oDoc.FItemList(iLp).FItemID
		Next
	End if
end if

'// 카테고리 총상품수 산출 함수
function getCateListCount(srcFlag,sDiv,sDep,dspCd,arrCt,mkrid,ccd,stcd,atcd,deliT,lDiv,sRect,sExc)
	dim oTotalCnt
	set oTotalCnt = new SearchItemCls
		oTotalCnt.FRectDiaryItem = diarystoryitem
		oTotalCnt.FRectSearchFlag = srcFlag
		oTotalCnt.FRectSearchItemDiv = sDiv
		oTotalCnt.FRectSearchCateDep = sDep
		oTotalCnt.FRectCateCode	= dspCd
		oTotalCnt.FarrCate=arrCt
		oTotalCnt.FRectMakerid	= mkrid
		oTotalCnt.FcolorCode= ccd
		oTotalCnt.FstyleCd= stcd
		oTotalCnt.FattribCd = atcd
		oTotalCnt.FdeliType	= deliT
		oTotalCnt.FListDiv = lDiv
		oTotalCnt.FRectSearchTxt = sRect
		oTotalCnt.FRectExceptText = sExc
		oTotalCnt.FSellScope=SellScope
		oTotalCnt.getTotalCount
		getCateListCount = oTotalCnt.FTotalCount
	set oTotalCnt = Nothing
end function

'//다이어리 스토리  전용 카운트
function getCateListDiaryItemCount(srcFlag,sDiv,sDep,dspCd,arrCt,mkrid,ccd,stcd,atcd,deliT,lDiv,sRect,sExc)
	dim oTotalCnt
	set oTotalCnt = new SearchItemCls
		oTotalCnt.FRectDiaryItem = "R"
		oTotalCnt.FRectSearchFlag = srcFlag
		oTotalCnt.FRectSearchItemDiv = sDiv
		oTotalCnt.FRectSearchCateDep = sDep
		oTotalCnt.FRectCateCode	= dspCd
		oTotalCnt.FarrCate=arrCt
		oTotalCnt.FRectMakerid	= mkrid
		oTotalCnt.FcolorCode= ccd
		oTotalCnt.FstyleCd= stcd
		oTotalCnt.FattribCd = atcd
		oTotalCnt.FdeliType	= deliT
		oTotalCnt.FListDiv = lDiv
		oTotalCnt.FRectSearchTxt = sRect
		oTotalCnt.FRectExceptText = sExc
		oTotalCnt.FSellScope=SellScope
		oTotalCnt.getTotalCount
		getCateListDiaryItemCount = oTotalCnt.FTotalCount
	set oTotalCnt = Nothing
end function

dim diaryItemCnt, categorydiaryItemCnt
If now() >= #2022-09-01 00:00:00# and now() < #2023-02-01 00:00:00# Then
	diaryItemCnt = getCateListCount(searchFlag,SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText)
	categorydiaryItemCnt = getCateListDiaryItemCount(searchFlag,SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText)
elseif application("Svr_Info")="Dev" or application("Svr_Info")="staging" then
	diaryItemCnt = getCateListCount(searchFlag,SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText)
	categorydiaryItemCnt = getCateListDiaryItemCount(searchFlag,SearchItemDiv,SearchCateDep,dispCate,arrCate,makerid,colorCD,styleCd,attribCd,deliType,ListDiv,DocSearchText,ExceptText)
else
	diaryItemCnt=0
	categorydiaryItemCnt=0
end if

'// 검색어 로그 저장
' if isSaveSearchKeyword and (tmpCurrSearchKeyword <> tmpPrevSearchKeyword) and (Not CheckResearch) and IsRealTypedKeyword then
' 	dim oKeyword
' 	dim keywordDataArray(3)
' 	set oKeyword = new CKeywordCls

' 	keywordDataArray(0) = oTotalCnt.FTotalCount

' 	if IsUserLoginOK then
' 		keywordDataArray(1) = GetLoginUserID
' 	else
' 		keywordDataArray(1) = ""
' 	end if

' 	keywordDataArray(2) = Request.ServerVariables("REMOTE_ADDR")

' 	Call oKeyword.SaveToDatabaseWithDataArray(tmpCurrSearchKeyword, tmpPrevSearchKeyword, keywordDataArray)

' 	set oKeyword = Nothing
' end if

'// 카테고리=사용안함, 2016-06-15, skyer9
dim vCateNameToSearchStr : vCateNameToSearchStr = ""
if oDoc.FResultCount < 1 then
	if GetCategoryUseYN(vDisp) = "N" then
		vCateNameToSearchStr = Server.URLEncode(Replace(vCateName, "/", " "))
		Response.Redirect "/search/search_result.asp?rect=" & vCateNameToSearchStr & "&exkw=1"
		dbget.Close
		REsponse.End
	end if
end If

'// 구글 ADS 스크립트 관련(2018.09.21 신규버전 추가)
googleADSCRIPT = " <script> "
googleADSCRIPT = googleADSCRIPT & "   gtag('event', 'page_view', { "
googleADSCRIPT = googleADSCRIPT & "     'send_to': 'AW-851282978', "
googleADSCRIPT = googleADSCRIPT & "     'ecomm_pagetype': 'category', "
googleADSCRIPT = googleADSCRIPT & "     'ecomm_prodid': '', "
googleADSCRIPT = googleADSCRIPT & "     'ecomm_totalvalue': '' "
googleADSCRIPT = googleADSCRIPT & "   }); "
googleADSCRIPT = googleADSCRIPT & " </script> "

'//=========================== amplitude로 전송할 데이터=============================================

dim vAmplitudeSearchText, vAmplitudeSearchFlag, vAmplitudeStyleCd,vAmplitudeColorCD
dim vAmplitudeDeliType,vAmplitudeMinPrice,vAmplitudeMaxPrice,vAmplitudeSortMet
dim vAmplitudeSellScope, vAmplitudeCategoryDepth

'검색어
If SearchText = "" Then
	vAmplitudeSearchText = "none"
else
	vAmplitudeSearchText = SearchText
End if
'리스트 타입
if SearchFlag = "" then
	vAmplitudeSearchFlag = "ALL"
else
	Select Case Trim(SearchFlag)
		Case "n"
			vAmplitudeSearchFlag = "ALL"
		Case "sc"
			vAmplitudeSearchFlag = "SALE"
		Case "ea"
			vAmplitudeSearchFlag = "REVIEW"
		Case "ep"
			vAmplitudeSearchFlag = "PHOTO"
		Case "fv"
			vAmplitudeSearchFlag = "WISH"
		Case "pk"
			vAmplitudeSearchFlag = "WRAPPING"
	End Select
end if
'스타일
If styleCD = "" Then
	vAmplitudeStyleCd = "none"
Else
	dim arrSnm
	dim stylearr
	vAmplitudeStyleCd = ""

	arrSnm = split("클래식,큐티,댄디,모던,내추럴,오리엔탈,팝,로맨틱,빈티지",",")
	stylearr = split(styleCD, ",")
	For i = 0 To ubound(stylearr)
		if not(isNumeric(stylearr(i))) then exit for
        if (cint(stylearr(i))/10) <> CInt(cint(stylearr(i))/10) then exit for
		vAmplitudeStyleCd = vAmplitudeStyleCd & arrSnm(cint(stylearr(i))/10-1) & ","
	Next

	if vAmplitudeStyleCd <> "" then
		vAmplitudeStyleCd = left(vAmplitudeStyleCd, len(vAmplitudeStyleCd)-1)
	end if
End if
'컬러
If colorCD = "" or colorCD = 0 Then
	vAmplitudeColorCD = "none"
Else

	dim colarr
	dim arrCnm
	vAmplitudeColorCD = ""

	colarr = split(colorCD,",")
	arrCnm = split("red,orange,yellow,beige,green,skyblue,blue,violet,pink,brown,white,grey,black,silver,gold,mint,babypink,lilac,khaki,navy,camel,charcoal,wine,ivory,check,stripe,dot,flower,drawing,animal,geometric",",")
	For i = 0 To ubound(colarr)
		vAmplitudeColorCD = vAmplitudeColorCD & arrCnm(cint(colarr(i))-1) & ","
	Next

	vAmplitudeColorCD = left(vAmplitudeColorCD,Len(vAmplitudeColorCD)-1)

End if
'배송 방법
If deliType = "" Then
	vAmplitudeDeliType = "none"
Else
	Select Case Trim(deliType)
		Case "FD"
			vAmplitudeDeliType = "free" '무료배송
		Case "TN"
			vAmplitudeDeliType = "tenbyten"'텐바이텐 배송
		Case "FT"
			vAmplitudeDeliType = "free_tenbyten"'무료 + 텐바이텐 배송
		Case "WD"
			vAmplitudeDeliType = "global"'해외배송
	End Select
End if
'최저 가격
If minPrice = "" Then
	vAmplitudeMinPrice = "none"
Else
	vAmplitudeMinPrice = minPrice
End if
'최대 가격
If maxPrice = "" Then
	vAmplitudeMaxPrice = "none"
Else
	vAmplitudeMaxPrice = maxPrice
End if

'정렬 방식
If SortMet = "" Then
	vAmplitudeSortMet = "none"
Else
	Select Case Trim(SortMet)
		Case "ne"
			vAmplitudeSortMet = "new"
		Case "be"
			vAmplitudeSortMet = "best"
		Case "vv"
			vAmplitudeSortMet = "recommend"
		Case "lp"
			vAmplitudeSortMet = "lowprice"
		Case "hp"
			vAmplitudeSortMet = "highprice"
		Case "hs"
			vAmplitudeSortMet = "sale"
		Case "bs"
			vAmplitudeSortMet = "sell"
	End Select
End if
'품절 상품 포함 여부
If SellScope = "" Then
	vAmplitudeSellScope = "none"
Else
	vAmplitudeSellScope = SellScope
End if

'카테고리 dept
If dispcate <> "" Then
	vAmplitudeCategoryDepth = Len(dispcate)/3
Else
	vAmplitudeCategoryDepth = "1"
End If

'//=========================== amplitude로 전송할 데이터=============================================
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/search_result.js?v=1.0"></script>
<script type="text/javascript" src="/lib/js/searchFilter.js?v=1.31"></script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script>
	fnAmplitudeEventMultiPropertiesAction('view_category_list','categorycode|categoryname|depth','<%=dispcate%>|<%=CategoryNameUseLeftMenuDB(Left(dispCate, 3))%>|<%=vAmplitudeCategoryDepth%>');
	<% if CurrPage > 1 then %>
	//fnAmplitudeEventMultiPropertiesAction('click_category_list_paging','paging_index|sort','<%=CurrPage%>|<%=vAmplitudeSortMet%>');
	<%end if%>

    $(function() {
        //LNB Control
        $('.lnbV15 li').mouseover(function() {
            $(this).children('.lnbLyrWrapV15').show();
        });

        $('.lnbV15 li').mouseleave(function() {
            $(this).children('.lnbLyrWrapV15').hide();
        });

        // Item Image Control
        $(".pdtList li .pdtPhoto").mouseenter(function(e){
            $(this).find("dfn").fadeIn(150);
        }).mouseleave(function(e){
            $(this).find("dfn").fadeOut(150);
        });

        $('.icoWrappingV15a').mouseover(function() {
            $(this).children('em').fadeIn();
        });

        $('.icoWrappingV15a').mouseleave(function() {
            $(this).children('em').hide();
        });
        $(".pdtList p").click(function(e){
            e.stopPropagation();
        });

        if(typeof qg !== "undefined"){
            console.log("ok");
            let appier_category_viewed = {
                "category_code" : "<%=dispcate%>"
                , "category_name" : "<%=CategoryNameUseLeftMenuDB(Left(dispCate, 3))%>"
                , "sort" : "<%=vAmplitudeSortMet%>"
            };

            qg("event", "category_viewed", appier_category_viewed);
        }
    });
function amplitudeChangeSortSend(a)
{
	var sendsortvalue;
	switch(a) {
		case "ne":
			sendsortvalue = "new";
			break;
		case "be":
			sendsortvalue = "best";
			break;
		case "vv":
			sendsortvalue = "recommend";
			break;
		case "lp":
			sendsortvalue = "lowprice";
			break;
		case "hp":
			sendsortvalue = "highprice";
			break;
		case "hs":
			sendsortvalue = "sale";
			break;
		case "bs":
			sendsortvalue = "sell";
			break;
	}
	fnAmplitudeEventMultiPropertiesAction('click_category_list_productlist_sort'
	,'change_sort|now_sort|category_code'
	,sendsortvalue+'|<%=vAmplitudeSortMet%>|<%=dispcate%>');
}

function amplitudeDiaryStory() {
	fnAmplitudeEventAction('view_diarystory_main', 'place', 'category');
}
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<% If now() >= #2022-09-01 00:00:00# and now() < #2023-02-01 00:00:00# Then %>
		<style>
			.container {position:relative;}
		</style>
		<% elseif application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
		<style>
			.container {position:relative;}
		</style>
		<% End If %>
		<div id="contentWrap">
			<div class="ctgyWrapV15">
				<div class="section">
					<div class="lnbWrapV15">
						<% If vIsBookCate Then %>
							<h2><a href="/shopping/category_main.asp?disp=<%=Left(vDisp,6)%>">BOOK</a></h2>
						<% ElseIf left(vDisp,6)="104119" then %>
							<h2><a href="/shopping/category_main.asp?disp=<%=Left(vDisp,3)%>">클래스</a></h2>
						<% Else %>
							<h2><a href="/shopping/category_main.asp?disp=<%=Left(vDisp,3)%>"><%=CategoryNameUseLeftMenu(Left(vDisp,3))%></a></h2>
						<% End If %>
						<%'// 좌측 카테고리 배너 %>
						<% server.Execute("/shopping/include_category_banner.asp") %>
						<%' If vIsBookCate Then %>
							<!-- include virtual="/chtml/dispcate/menu/loader/leftcate_book.asp" -->
						<%' Else %>
							<!-- #include virtual="/chtml/dispcate/menu/loader/leftcate.asp" -->
							<ul class="addLnbV15">
								<li><a href="/shoppingtoday/shoppingchance_saleitem.asp?disp=<%=Left(vDisp,3)%>">SALE</a></li>
								<li><a href="/shoppingtoday/shoppingchance_allevent.asp?disp=<%=Left(vDisp,3)%>">EVENT</a></li>
							</ul>
						<%' End If %>
					</div>
					<div class="content">
						<% If Not vIsBookCate Then %>
						<div class="locationV15">
							<p><% Call printCategoryHistory_B(vDisp) %></p>
							<% if vDisp="104119" then %>
							<div class="btnWrap">
								<a href="https://docs.google.com/forms/d/1xOAyfs1XCR9JnrKtkyUtTH6W1SdLO6TYqMfuTSXGbuI" target="_blank">기업/단체 문의</a>
								<a href="https://docs.google.com/forms/d/158q_CTXEljRicSRoxNfqtY4ZVYZKE7qj3adlbFTxPLk" target="_blank">강사 신청하기</a>
							</div>
							<% end if %>
						</div>
						<% End If %>
						<%	'### vBDDNY : BookDownDepNoYes 줄임.

							'// vCArr 값 가져오는 클래스호출을 상단으로 이동, 2016-06-17, skyer9

							If vIsBookCate Then
								If IsArray(vCArr) Then
								For i=0 To UBound(vCArr,2)
									If CStr(vCArr(0,i)) = CStr(vDisp) Then
										vBDDNY = "N"	'### 아래뎁스가 없으면 FRectDisp과 동일뎁스의 리스트를 가져옴.
									End If
								Next
								End If
							Else
								If IsArray(vCArr) Then
								For vCi = 0 To UBound(vCArr,2)
									If CStr(vDisp) = CStr(vCArr(0,vCi)) Then
										vIsDownDep = "x"
									End If
								Next
								End If
							End IF

							If vIsBookCate AND vBDDNY = "N" Then
								If Len(vDisp) > 6 Then
									vCtLiView = "o"
								End If
							ElseIf vDisp="104119" then
								'// 클래스(강좌) 카테고리는 하위분류 표시안함
								'vCtLiView = "x"
								vCtLiView = "o"
							Else
								vCtLiView = "o"
							End If

						If vCtLiView = "o" Then
						%>
						<dl class="subCtgyViewV15">
							<!--<dt><%=CategoryNameUseLeftMenuDB(CHKIIF(vIsBookCate,Left(vDisp,3),CHKIIF(vIsDownDep="x",Left(vDisp,(Len(vDisp)-3)),vDisp)))%></dt>-->
							<dt><%=CategoryNameUseLeftMenuDB(CHKIIF(vIsDownDep="x",Left(vDisp,(Len(vDisp)-3)),vDisp))%></dt>
							<dd>
								<ul>
								<%
									If IsArray(vCArr) Then
										For vCi = 0 To UBound(vCArr,2)
											Response.Write "<li " & CHKIIF(CStr(vDisp)=CStr(vCArr(0,vCi)),"class='current'","") & "><a href=""/shopping/category_list.asp?disp="&vCArr(0,vCi)&""" onclick=""fnAmplitudeEventMultiPropertiesAction('view_category_list_subcategory','category_code|category_depth|move_category_code|move_category_depth','"& vDisp &"|"& CInt(Len(vDisp)/3) &"|"& vCArr(0,vCi) &"|"& CInt(Len(vCArr(0,vCi))/3) &"');"">"&db2html(vCArr(1,vCi))&"</a></li>" & vbCrLf
										Next
									End If
								%>
								</ul>
							</dd>
						</dl>
						<% End If %>
						<!-- // 베스트 아이템 Top 3 // -->
						<!-- #include virtual="/shopping/inc_BestItem.asp" -->

					</div>
				</div>
				<!-- #Include virtual="/search/inc_searchFilter.asp" -->
				<!-- #include virtual="/diarystory2023/inc/diary2023_filter.asp" -->
<%
	'// 검색결과 가 있을 때
	if oDoc.FTotalCount>0 then
%>
				<div class="section">
					<form name="sFrm" id="listSFrm" method="get" action="category_list.asp" style="margin:0px;">
					<input type="hidden" name="rect" value="<%= SearchText %>">
					<input type="hidden" name="prvtxt" value="<%= PrevSearchText %>">
					<input type="hidden" name="rstxt" value="<%= ReSearchText %>">
					<input type="hidden" name="extxt" value="<%= ExceptText %>">
					<input type="hidden" name="sflag" value="<%= SearchFlag  %>">
					<input type="hidden" name="disp" value="<%= vDisp %>">
					<input type="hidden" name="cpg" value="">
					<input type="hidden" name="chkr" value="<%= CheckResearch %>">
					<input type="hidden" name="chke" value="<%= CheckExcept %>">
					<input type="hidden" name="mkr" value="<%= makerid %>">
					<input type="hidden" name="sscp" value="<%= SellScope %>">
					<input type="hidden" name="psz" value="<%= PageSize %>">
					<input type="hidden" name="srm" value="<%= SortMet %>">
					<input type="hidden" name="iccd" value="<%=colorCD%>">
					<input type="hidden" name="styleCd" value="<%=styleCd%>">
					<input type="hidden" name="attribCd" value="<%=attribCd%>">
					<input type="hidden" name="icoSize" value="<%=icoSize%>">
					<input type="hidden" name="arrCate" value="<%=arrCate%>">
					<input type="hidden" name="deliType" value="<%=deliType%>">
					<input type="hidden" name="minPrc" value="<%=minPrice%>">
					<input type="hidden" name="maxPrc" value="<%=maxPrice%>">
					<input type="hidden" name="lstDiv" value="<%=ListDiv%>">
					<input type="hidden" name="diarystoryitem" value="<%=diarystoryitem%>">
					</form>
	<% if Not(searchFlag="ea" or searchFlag="ep") then %>
			<!-- // 검색결과 상품목록 시작 // -->
			<%
				Dim icol
				IF oDoc.FResultCount >0 then
			%>
				<div class="pdtWrap <%=chkIIF(icoSize="M","pdt240V15","pdt150V15")%>">
					<ul class="pdtList">
					<%
						For icol=0 To oDoc.FResultCount -1
							classStr = ""
							linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(icol).FItemID &"&disp="&getArrayDispCate(dispCate,oDoc.FItemList(icol).FarrCateCd) & logparam
							adultChkFlag = false
							adultChkFlag = session("isAdult") <> true and oDoc.FItemList(icol).FadultType = 1

							If oDoc.FItemList(icol).FItemDiv="21" then
								classStr = addClassStr(classStr,"deal-item")
							end if
							If oDoc.FItemList(icol).isSoldOut=true then
								classStr = addClassStr(classStr,"soldOut")
							end if
							if adultChkFlag then
								classStr = addClassStr(classStr,"adult-item")
							end if
					%>
						<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"&linkUrl&"');""","")%> >
							<% If oDoc.FItemList(icol).FItemDiv="21" Then %>
							<div class="pdtBox">
								<i class="dealBadge">텐텐<br /><strong>DEAL</strong></i>
								<div class="pdtPhoto">
									<%'<!-- 20190222 성인인증 안내 -->%>
									<% if adultChkFlag then %>
									<div class="adult-hide">
										<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
									</div>
									<% end if %>
									<%'<!-- 20190222 성인인증 안내 -->%>
									<a href="/deal/deal.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%=getArrayDispCate(dispCate,oDoc.FItemList(icol).FarrCateCd)%><%=logparam%>">
										<span class="soldOutMask"></span>
										<% if icoSize="M" then %>
										<img src="<%=getThumbImgFromURL(oDoc.FItemList(icol).FImageBasic,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" />
										<% else %>
										<img src="<%=oDoc.FItemList(icol).FImageIcon2%>" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" />
										<% end if %>
										<% if oDoc.FItemList(icol).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(icol).FAddimage,imgSz,imgSz,"true","false")%>" onerror="$(this).parent().empty();" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" /></dfn><% end if %>
									</a>
								</div>
								<div class="pdtInfo">
									<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oDoc.FItemList(icol).FMakerid %>" onclick="fnAmplitudeEventMultiPropertiesAction('click_category_list_product_brand', 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style','<%=icol+1%>|<%=vAmplitudeSortMet%>|<%=dispcate%>|<%=vAmplitudeCategoryDepth%>|<%=oDoc.FItemList(icol).FItemID%>|<%=fnCateCodeToCategory1DepthName(Left(Trim(oDoc.FItemList(icol).FCateCode),3))%>|<%=Replace(oDoc.FItemList(icol).FBrandName," ","")%>|<%=icoSize%>')";><% = oDoc.FItemList(icol).FBrandName %></a></p>
									<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%=getArrayDispCate(dispCate,oDoc.FItemList(icol).FarrCateCd)%><%=logparam%>"><% = oDoc.FItemList(icol).FItemName %></a></p>
									<% IF oDoc.FItemList(icol).FItemOptionCnt="" Or oDoc.FItemList(icol).FItemOptionCnt="0" then %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(icol).getRealPrice,0)%>원<% If oDoc.FItemList(icol).FtenOnlyYn="Y" Then %>~<% End If %></span></p>
									<% Else %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(icol).getRealPrice,0)%>원<% If oDoc.FItemList(icol).FtenOnlyYn="Y" Then %>~<% End If %></span> <strong class="cRd0V15">[<% If oDoc.FItemList(icol).FLimityn="Y" Then %>~<% End If %><%=oDoc.FItemList(icol).FItemOptionCnt%>%]</strong></p>
									<% End If %>
									<p class="pdtStTag tPad10">
									<% IF oDoc.FItemList(icol).isSoldOut Then %>
										<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
									<% Else %>
										<% IF oDoc.FItemList(icol).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
										<% IF Not(isNull(oDoc.FItemList(icol).FItemOptionCnt) or trim(oDoc.FItemList(icol).FItemOptionCnt)="") Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
										<% IF oDoc.FItemList(icol).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
										<% IF oDoc.FItemList(icol).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
									<% End If %>
									</p>
								</div>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','quick'); ZoomItemInfo('<%=oDoc.FItemList(icol).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" onclick="<%=chkIIF(oDoc.FItemList(icol).FEvalCnt>0,"popEvaluate('" & oDoc.FItemList(icol).FItemid & "');","")%>fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','review'); return false;"><span><%=oDoc.FItemList(icol).FEvalCnt%></span></a></li>
									<li class="wishView"><a href="" onclick=" fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','wish'); TnAddFavorite('<%=oDoc.FItemList(icol).FItemid %>'); return false;"><span><%=oDoc.FItemList(icol).FfavCount%></span></a></li>
								</ul>
							</div>
							<% Else %>
							<div class="pdtBox">
								<% if oDoc.FItemList(icol).Fiskimtentenrecom="Y" or oDoc.FItemList(icol).IsSaleItem or oDoc.FItemList(icol).isCouponItem then %>
									<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
										<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
											<span class="badge_anniv21<% If oDoc.FItemList(icol).FDeliverFixDay <> "L" Then %><% If oDoc.FItemList(icol).FFreeDeliveryYN="Y" Then %> free<% End If %><% End If %>">
												<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
											</span>
										<% end if %>
									<% else %>
										<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
											<span class="badge_anniv21<% If oDoc.FItemList(icol).FDeliverFixDay <> "L" Then %><% If oDoc.FItemList(icol).FFreeDeliveryYN="Y" Then %> free<% End If %><% End If %>">
												<img src="//fiximage.10x10.co.kr/web2022/anniv21/badge_anniv21.png?v=2" alt="21주년">
											</span>
										<% end if %>
									<% end if %>
								<% end if %>
								<% if oDoc.FItemList(icol).FGiftDiv>0 then %>
									<% If now() >= #2022-09-01 00:00:00# and now() < #2022-11-09 00:00:00# Then %>
										<% if application("Svr_Info")="Dev" or application("Svr_Info")="staging" then %>
											<% If now() >= #2022-10-06 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
											<% else %>
												<i class="diary2023Badge"></i>
											<% end if%>
										<% else %>
											<% If now() >= #2022-10-10 10:00:00# and now() < #2022-10-25 00:00:00# Then %>
											<% else %>
												<i class="diary2023Badge"></i>
											<% end if%>
										<% end if%>
									<% end if %>
								<% end if %>
								<% '// 무료배송 작업 %>
								<% If icoSize="M" Then %>
									<% If oDoc.FItemList(icol).FDeliverFixDay <> "L" Then %>
										<% If oDoc.FItemList(icol).FFreeDeliveryYN="Y" Then %>
											<i class="free-shipping-badge">무료<br>배송</i>
										<% End If %>
									<% ElseIf oDoc.FItemList(icol).FDeliverFixDay = "L" Then %>
										<i class="class-badge">텐텐<br><strong>클래스</strong></i>
									<% End If %>
								<% End If %>
								<% '// 해외직구배송작업추가(원승현) %>
								<% If oDoc.FItemList(icol).IsDirectPurchase Then %>
									<i class="abroad-badge">해외직구</i>
								<% End If %>
								<div class="pdtPhoto">
									<%'<!-- 20190222 성인인증 안내 -->%>
									<% if adultChkFlag then %>
									<div class="adult-hide">
										<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
									</div>
									<% end if %>
									<%'<!-- 20190222 성인인증 안내 -->%>
									<a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%=getArrayDispCate(dispCate,oDoc.FItemList(icol).FarrCateCd)%><%=logparam%>" onclick="window.event.cancelBubble=true; fnAmplitudeEventMultiPropertiesAction('click_category_list_product', 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style','<%=icol+1%>|<%=vAmplitudeSortMet%>|<%=dispcate%>|<%=vAmplitudeCategoryDepth%>|<%=oDoc.FItemList(icol).FItemID%>|<%=fnCateCodeToCategory1DepthName(Left(Trim(oDoc.FItemList(icol).FCateCode),3))%>|<%=Replace(oDoc.FItemList(icol).FBrandName," ","")%>|<%=icoSize%>');">
										<span class="soldOutMask"></span>
										<% if icoSize="M" then %>
										<img src="<%=getThumbImgFromURL(oDoc.FItemList(icol).FImageBasic,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" />
										<% else %>
										<img src="<%=oDoc.FItemList(icol).FImageIcon2%>" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" />
										<% end if %>
										<% if oDoc.FItemList(icol).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(icol).FAddimage,imgSz,imgSz,"true","false")%>" onerror="$(this).parent().empty();" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" /></dfn><% end if %>
									</a>
								</div>
								<div class="pdtInfo">
									<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oDoc.FItemList(icol).FMakerid %>" onclick="fnAmplitudeEventMultiPropertiesAction('click_category_list_product_brand', 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style','<%=icol+1%>|<%=vAmplitudeSortMet%>|<%=dispcate%>|<%=vAmplitudeCategoryDepth%>|<%=oDoc.FItemList(icol).FItemID%>|<%=fnCateCodeToCategory1DepthName(Left(Trim(oDoc.FItemList(icol).FCateCode),3))%>|<%=Replace(oDoc.FItemList(icol).FBrandName," ","")%>|<%=icoSize%>')";><% = oDoc.FItemList(icol).FBrandName %></a></p>
									<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%=getArrayDispCate(dispCate,oDoc.FItemList(icol).FarrCateCd)%><%=logparam%>" onclick="window.event.cancelBubble=true; fnAmplitudeEventMultiPropertiesAction('click_category_list_product', 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style','<%=icol+1%>|<%=vAmplitudeSortMet%>|<%=dispcate%>|<%=vAmplitudeCategoryDepth%>|<%=oDoc.FItemList(icol).FItemID%>|<%=fnCateCodeToCategory1DepthName(Left(Trim(oDoc.FItemList(icol).FCateCode),3))%>|<%=Replace(oDoc.FItemList(icol).FBrandName," ","")%>|<%=icoSize%>');"><% = oDoc.FItemList(icol).FItemName %></a></p>
									<% If oDoc.FItemList(icol).FItemDiv="30" Then %>
										<%'' 이니렌탈 가격 표시 %>
										<p class="pdtPrice"><span class="finalP">월 <%=FormatNumber(fnRentalPriceCalculationDataInEventList(oDoc.FItemList(icol).getRealPrice),0)%>원~</span></p>
									<% Else %>
										<% if oDoc.FItemList(icol).IsSaleItem or oDoc.FItemList(icol).isCouponItem Then %>
											<% IF oDoc.FItemList(icol).IsSaleItem then %>
											<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oDoc.FItemList(icol).getOrgPrice,0)%>원</span></p>
											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(icol).getRealPrice,0)%>원</span> <strong class="cRd0V15">[<%=oDoc.FItemList(icol).getSalePro%>]</strong></p>
											<% End If %>
											<% IF oDoc.FItemList(icol).IsCouponItem Then %>
												<% if Not(oDoc.FItemList(icol).IsFreeBeasongCoupon() or oDoc.FItemList(icol).IsSaleItem) Then %>
											<p class="pdtPrice"><span class="txtML"><%=FormatNumber(oDoc.FItemList(icol).getOrgPrice,0)%>원</span></p>
												<% end If %>
											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(icol).GetCouponAssignPrice,0)%>원</span> <strong class="cGr0V15">[<%=oDoc.FItemList(icol).GetCouponDiscountStr%>]</strong></p>
											<% End If %>
										<% Else %>
											<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(icol).getRealPrice,0) & chkIIF(oDoc.FItemList(icol).IsMileShopitem,"Point","원")%></span></p>
										<% End If %>
									<% End If %>
									<p class="pdtStTag tPad10">
									<% IF oDoc.FItemList(icol).isSoldOut Then %>
										<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
									<% else %>
										<% IF oDoc.FItemList(icol).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
										<% IF oDoc.FItemList(icol).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
										<% IF oDoc.FItemList(icol).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
										<% IF oDoc.FItemList(icol).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
										<% IF oDoc.FItemList(icol).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
										<% IF oDoc.FItemList(icol).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
										<% If G_IsPojangok Then %>
										<% IF oDoc.FItemList(icol).IsPojangitem Then %><span class="icoWrappingV15a"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장가능"><em><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png" alt="선물포장가능"></em></span> <% end if %>
										<% End If %>
									<% end if %>
									</p>
								</div>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','quick'); ZoomItemInfo('<%=oDoc.FItemList(icol).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" onclick="<%=chkIIF(oDoc.FItemList(icol).FEvalCnt>0,"popEvaluate('" & oDoc.FItemList(icol).FItemid & "');","")%>fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','review'); return false;"><span><%=oDoc.FItemList(icol).FEvalCnt%></span></a></li>
									<li class="wishView"><a href="" onclick=" fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','wish'); TnAddFavorite('<%=oDoc.FItemList(icol).FItemid %>'); return false;"><span><%=oDoc.FItemList(icol).FfavCount%></span></a></li>
								</ul>
							</div>
							<% End If %>
						</li>
					<% Next %>
					</ul>
				</div>
			<% Else %>
				<div class="ct" style="padding:150px 0;">
					<p style="font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif; font-size:21px; color:#000;"><strong>흠... <span class="cRd0V15">조건에 맞는 상품</span>이 없습니다.</strong></p>
					<p class="tPad10">Filter 조건 선택해제 후, 다시 원하시는 조건을 선택해 주세요.<p>
					<p>일시적으로 상품이 품절일 경우 검색되지 않습니다.</p>
				</div>
			<% End If %>
			<!-- // 검색결과 상품목록 끝 // -->
		<%
			else
			'//상품 리뷰 목록
				Dim oEval, arrEvalTargetItemList
				dim arrUserid, bdgUid, bdgBno

				IF oDoc.FResultCount >0 then

					arrEvalTargetItemList = ""
					for lp=0 to oDoc.FResultCount-1
						arrEvalTargetItemList = arrEvalTargetItemList & oDoc.FItemList(lp).FItemid
						if lp<(oDoc.FResultCount-1) then
							arrEvalTargetItemList = arrEvalTargetItemList & ","
						end if
					next

					set oEval = new SearchItemEvaluate
					oEval.FRectSort = SortMet
					oEval.FRectArrItemid = arrEvalTargetItemList
					if searchFlag="ep" then oEval.FRectMode = "photo"
					oEval.GetBestReviewArrayList
		%>
				<!-- review list -->
				<div class="pdtWrap reviewListV15 <%=chkIIF(searchFlag="ea","txtReviewWrap","photoReviewWrap")%>">
				<%	If oEval.FResultCount > 0 Then %>
					<ul class="pdtList">
				<%
					'사용자 아이디 모음 생성(for Badge)
					for lp = 0 to oEval.FResultCount - 1
						arrUserid = arrUserid & chkIIF(arrUserid<>"",",","") & "''" & trim(oEval.FItemList(lp).FUserID) & "''"
					next

					'뱃지 목록 접수(순서 랜덤)
					Call getUserBadgeList(arrUserid,bdgUid,bdgBno,"Y")

					For lp=0 To (oEval.FResultCount-1)
						classStr = ""
						linkUrl = "/shopping/category_prd.asp?itemid="& oEval.FItemList(lp).Fitemid & logparam
						adultChkFlag = false
						adultChkFlag = session("isAdult") <> true and oEval.FItemList(lp).FadultType = 1

						If oEval.FItemList(lp).FItemDiv="21" then
							classStr = addClassStr(classStr,"deal-item")
						end if
						If oEval.FItemList(lp).isSoldOut=true then
							classStr = addClassStr(classStr,"soldOut")
						end if
						if adultChkFlag then
							classStr = addClassStr(classStr,"adult-item")
						end if
						if searchFlag="ea" then		'/// 일반상품 후기
				%>
						<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"& linkUrl &"');""","")%>>
							<div class="pdtBox">
								<% '// 해외직구배송작업추가(원승현) %>
								<% If oEval.FItemList(lp).IsDirectPurchase Then %>
									<i class="abroad-badge">해외직구</i>
								<% End If %>
								<div class="pdtPhoto">
									<%'성인상품 블라인드%>
									<% if adultChkFlag then %>
									<div class="adult-hide">
										<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
									</div>
									<% end if %>
									<%'성인상품 블라인드%>
									<span class="soldOutMask"></span><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>" onclick="window.event.cancelBubble=true; fnAmplitudeEventMultiPropertiesAction('click_category_list_product', 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style','<%=icol+1%>|<%=vAmplitudeSortMet%>|<%=dispcate%>|<%=vAmplitudeCategoryDepth%>|<%=oDoc.FItemList(icol).FItemID%>|<%=fnCateCodeToCategory1DepthName(Left(Trim(oDoc.FItemList(icol).FCateCode),3))%>|<%=Replace(oDoc.FItemList(icol).FBrandName," ","")%>|<%=icoSize%>');"><img src="<%=oEval.FItemList(lp).FIcon1Image%>" width="200px" height="200px" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
								</div>
								<div class="pdtInfo ftRt">
									<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oEval.FItemList(lp).FMakerId%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_category_list_product_brand', 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style','<%=icol+1%>|<%=vAmplitudeSortMet%>|<%=dispcate%>|<%=vAmplitudeCategoryDepth%>|<%=oDoc.FItemList(icol).FItemID%>|<%=fnCateCodeToCategory1DepthName(Left(Trim(oDoc.FItemList(icol).FCateCode),3))%>|<%=Replace(oDoc.FItemList(icol).FBrandName," ","")%>|<%=icoSize%>')";><%=oEval.FItemList(lp).Fbrandname%></a></p>
									<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>" onclick="window.event.cancelBubble=true; fnAmplitudeEventMultiPropertiesAction('click_category_list_product', 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style','<%=icol+1%>|<%=vAmplitudeSortMet%>|<%=dispcate%>|<%=vAmplitudeCategoryDepth%>|<%=oDoc.FItemList(icol).FItemID%>|<%=fnCateCodeToCategory1DepthName(Left(Trim(oDoc.FItemList(icol).FCateCode),3))%>|<%=Replace(oDoc.FItemList(icol).FBrandName," ","")%>|<%=icoSize%>');"><%=oEval.FItemList(lp).Fitemname%></a></p>
									<p class="pdtPrice">
									<%
										if oEval.FItemList(lp).IsSaleItem or oEval.FItemList(lp).isCouponItem Then
											Response.Write "<span class=""txtML"">" & FormatNumber(oEval.FItemList(lp).getOrgPrice,0) & "원</span>"
											IF oEval.FItemList(lp).IsSaleItem then
												Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
												Response.Write " <strong class=""cRd0V15""> [" & oEval.FItemList(lp).getSalePro & "]</strong>"
											End IF
											IF oEval.FItemList(lp).IsCouponItem then
												Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).GetCouponAssignPrice,0) & "원</span>"
												Response.Write " <strong class=""cGr0V15""> [" & oEval.FItemList(lp).GetCouponDiscountStr & "]</strong>"
											End IF
										Else
											Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
										End if
									%>
									</p>
									<p class="pdtStTag tPad10">
									<% IF oEval.FItemList(lp).isSoldOut Then %>
										<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
									<% else %>
										<% IF oEval.FItemList(lp).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
										<% IF oEval.FItemList(lp).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
										<% IF oEval.FItemList(lp).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
										<% IF oEval.FItemList(lp).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
										<% IF oEval.FItemList(lp).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
										<% IF oEval.FItemList(lp).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
										<% If G_IsPojangok Then %>
										<% IF oEval.FItemList(lp).IsPojangitem Then %><span class="icoWrappingV15a"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장가능"><em><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png" alt="선물포장가능"></em></span> <% end if %>
										<% End If %>
									<% end if %>
									</p>
								</div>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','quick'); ZoomItemInfo('<%=oEval.FItemList(lp).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" <%=chkIIF(oEval.FItemList(lp).FEvalCnt>0,"onclick=""popEvaluate('" & oEval.FItemList(lp).FItemid & "');fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','review');  return false;""","")%>><span><%=oEval.FItemList(lp).FEvalcnt%></span></a></li>
									<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oEval.FItemList(lp).FItemid %>');fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','wish'); return false;"><span><%=oEval.FItemList(lp).FfavCount%></span></a></li>
								</ul>
							</div>
							<div class="reviewBoxV15" <%=chkIIF(adultChkFlag, "style=""display:none""", "")%>>
								<p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoints%>.png" alt="별<%=oEval.FItemList(lp).FPoints%>개" /></p>
							<%
								'//상품고시관련 상품후기 제외 상품이 아닐경우
								if oEval.FItemList(lp).fEval_excludeyn="N" then
							%>
								<div class="reviewTxt"><a href="" onclick="popEvaluateDetail(<%=oEval.FItemList(lp).Fitemid%>,<%=oEval.FItemList(lp).Fidx%>);return false;" title="상세 리뷰 보기"><% = chrbyte(oEval.FItemList(lp).Fcontents,150,"Y") %></a></div>
							<%
								'//상품고시관련 상품후기 제외 상품일경우
								else
							%>
								<ul class="reviewFoodV15">
									<li><span>기능</span> <em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_fun%>.png" alt="별<%=oEval.FItemList(lp).FPoint_fun%>개" /></em></li>
									<li><span>디자인</span> <em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_dgn%>.png" alt="별<%=oEval.FItemList(lp).FPoint_dgn%>개" /></em></li>
									<li><span>가격</span> <em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_prc%>.png" alt="별<%=oEval.FItemList(lp).FPoint_prc%>개" /></em></li>
									<li><span>만족도</span> <em><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoint_stf%>.png" alt="별<%=oEval.FItemList(lp).FPoint_stf%>개" /></em></li>
								</ul>
							<% end if %>

								<a href="" onclick="popEvaluate(<%=oEval.FItemList(lp).Fitemid%>,'');return false;" class="more1V15">상품 전체 리뷰보기</a>
								<div class="reviewWriteV15">
									<p>
										<span><% = printUserId(oEval.FItemList(lp).Fuserid,2,"*") %></span>
										<%=getUserBadgeIcon(oEval.FItemList(lp).FUserID,bdgUid,bdgBno,3)%>
									</p>
									<em>ㅣ</em>
									<span><% = FormatDate(oEval.FItemList(lp).Fregdate,"0000.00.00") %></span>
								</div>
							</div>
						</li>
				<%		else 	'/// 포토 상품 후기 %>
					<%
					'//상품고시관련 상품후기 제외 상품이 아닐경우
					if oEval.FItemList(lp).fEval_excludeyn="N" then
					%>
						<li class="<%=classStr%>" <%=chkIIF(adultChkFlag, "onclick=""confirmAdultAuth('"& Server.URLencode(CurrURLQ()) &"');""","")%>>
							<div class="reviewBoxV15" <%=chkIIF(adultChkFlag, "style=""display:none""", "")%>>
								<p><img src="//fiximage.10x10.co.kr/web2019/common/ico_review_star_0<%=oEval.FItemList(lp).FPoints%>.png" alt="별<%=oEval.FItemList(lp).FPoints%>개" /></p>
								<div class="reviewTxt"><a href="" onclick="popEvaluateDetail(<%=oEval.FItemList(lp).Fitemid%>,<%=oEval.FItemList(lp).Fidx%>);return false;" title="상세 리뷰 보기"><% = chrbyte(oEval.FItemList(lp).Fcontents,120,"Y") %></a></div>
								<div class="reviewWriteV15">
									<p>
										<span><% = printUserId(oEval.FItemList(lp).Fuserid,2,"*") %></span>
										<%=getUserBadgeIcon(oEval.FItemList(lp).FUserID,bdgUid,bdgBno,3)%>
									</p>
									<em>ㅣ</em>
									<span><% = FormatDate(oEval.FItemList(lp).Fregdate,"0000.00.00") %></span>
								</div>
								<a href="" onclick="popEvaluate(<%=oEval.FItemList(lp).Fitemid%>,'');return false;" class="more1V15">상품 전체 리뷰보기</a>
							<div class="pdtPhoto">
								<a href="" onclick="popEvaluateDetail(<%=oEval.FItemList(lp).Fitemid%>,<%=oEval.FItemList(lp).Fidx%>);return false;"><img src="<%=getThumbImgFromURL(chkIIF(oEval.FItemList(lp).FImageIcon1<>"",oEval.FItemList(lp).FImageIcon1,oEval.FItemList(lp).FImageIcon2),400,400,"true","false")%>" width="400px" height="400px" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
							</div>
							</div>
							<div class="pdtBox">
								<% '// 해외직구배송작업추가(원승현) %>
								<% If oEval.FItemList(lp).IsDirectPurchase Then %>
									<i class="abroad-badge">해외직구</i>
								<% End If %>
								<div class="pdtPhoto">
									<%'성인상품 블라인드%>
									<% if adultChkFlag then %>
									<div class="adult-hide">
										<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
									</div>
									<% end if %>
									<%'성인상품 블라인드%>
									<span class="soldOutMask"></span><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>" onclick="window.event.cancelBubble=true; fnAmplitudeEventMultiPropertiesAction('click_category_list_product', 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style','<%=icol+1%>|<%=vAmplitudeSortMet%>|<%=dispcate%>|<%=vAmplitudeCategoryDepth%>|<%=oDoc.FItemList(icol).FItemID%>|<%=fnCateCodeToCategory1DepthName(Left(Trim(oDoc.FItemList(icol).FCateCode),3))%>|<%=Replace(oDoc.FItemList(icol).FBrandName," ","")%>|<%=icoSize%>');"><img src="<%=oEval.FItemList(lp).FIcon1Image%>" width="400px" height="400px" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
								</div>
								<div class="pdtInfo">
									<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oEval.FItemList(lp).FMakerId%>" onclick="fnAmplitudeEventMultiPropertiesAction('click_category_list_product_brand', 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style','<%=icol+1%>|<%=vAmplitudeSortMet%>|<%=dispcate%>|<%=vAmplitudeCategoryDepth%>|<%=oDoc.FItemList(icol).FItemID%>|<%=fnCateCodeToCategory1DepthName(Left(Trim(oDoc.FItemList(icol).FCateCode),3))%>|<%=Replace(oDoc.FItemList(icol).FBrandName," ","")%>|<%=icoSize%>')";><%=oEval.FItemList(lp).Fbrandname%></a></p>
									<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>" onclick="window.event.cancelBubble=true; fnAmplitudeEventMultiPropertiesAction('click_category_list_product', 'item_index|sort|category_code|category_depth|itemid|category_name|brand_name|list_style','<%=icol+1%>|<%=vAmplitudeSortMet%>|<%=dispcate%>|<%=vAmplitudeCategoryDepth%>|<%=oDoc.FItemList(icol).FItemID%>|<%=fnCateCodeToCategory1DepthName(Left(Trim(oDoc.FItemList(icol).FCateCode),3))%>|<%=Replace(oDoc.FItemList(icol).FBrandName," ","")%>|<%=icoSize%>');"><%=oEval.FItemList(lp).Fitemname%></a></p>
									<p class="pdtPrice">
									<%
										if oEval.FItemList(lp).IsSaleItem or oEval.FItemList(lp).isCouponItem Then
											Response.Write "<span class=""txtML"">" & FormatNumber(oEval.FItemList(lp).getOrgPrice,0) & "원</span>"
											IF oEval.FItemList(lp).IsSaleItem then
												Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
												Response.Write " <strong class=""cRd0V15""> [" & oEval.FItemList(lp).getSalePro & "]</strong>"
											End IF
											IF oEval.FItemList(lp).IsCouponItem then
												Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).GetCouponAssignPrice,0) & "원</span>"
												Response.Write " <strong class=""cGr0V15""> [" & oEval.FItemList(lp).GetCouponDiscountStr & "]</strong>"
											End IF
										Else
											Response.Write "<span class=""finalP"">" & FormatNumber(oEval.FItemList(lp).getRealPrice,0) & "원</span>"
										End if
									%>
										<span class="pdtStTag">
										<% IF oEval.FItemList(lp).isSoldOut Then %>
											<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
										<% else %>
											<% IF oEval.FItemList(lp).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
											<% IF oEval.FItemList(lp).isSaleItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
											<% IF oEval.FItemList(lp).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
											<% IF oEval.FItemList(lp).isLimitItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_limited.gif" alt="한정" /> <% end if %>
											<% IF oEval.FItemList(lp).IsTenOnlyitem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_only.gif" alt="ONLY" /> <% end if %>
											<% IF oEval.FItemList(lp).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
											<% If G_IsPojangok Then %>
											<% IF oEval.FItemList(lp).IsPojangitem Then %><span class="icoWrappingV15a"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장가능"><em><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png" alt="선물포장가능"></em></span> <% end if %>
											<% End If %>
										<% end if %>
										</span>
									</p>
								</div>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oEval.FItemList(lp).FItemid %>'); fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','quick'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" <%=chkIIF(oEval.FItemList(lp).FEvalCnt>0,"onclick=""popEvaluate('" & oEval.FItemList(lp).FItemid & "'); fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','review'); return false;""","")%>><span><%=oEval.FItemList(lp).FEvalcnt%></span></a></li>
									<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oEval.FItemList(lp).FItemid %>'); fnAmplitudeEventMultiPropertiesAction('click_category_list_product_info','type','wish'); return false;"><span><%=oEval.FItemList(lp).FfavCount%></span></a></li>
								</ul>
							</div>
						</li>
					<% end if %>
				<%
						end if
					next
				%>
					</ul>
				<% else %>
				<div class="ct" style="padding:150px 0;">
					<p style="font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif; font-size:21px; color:#000;"><strong>흠... <span class="cRd0V15">조건에 맞는 상품</span>이 없습니다.</strong></p>
					<p class="tPad10">Filter 조건 선택해제 후, 다시 원하시는 조건을 선택해 주세요.<p>
					<p>일시적으로 상품이 품절일 경우 검색되지 않습니다.</p>
				</div>
				<% end if %>
				</div>
				<!-- //review list -->
			<% else %>
				<div class="ct" style="padding:150px 0;">
					<p style="font-family:'malgun gothic', '맑은고딕', dotum, '돋움', sans-serif; font-size:21px; color:#000;"><strong>흠... <span class="cRd0V15">조건에 맞는 상품</span>이 없습니다.</strong></p>
					<p class="tPad10">Filter 조건 선택해제 후, 다시 원하시는 조건을 선택해 주세요.<p>
					<p>일시적으로 상품이 품절일 경우 검색되지 않습니다.</p>
				</div>
			<% end if %>
		<% end if %>
				<div class="pageWrapV15 tMar20">
				<!-- //Paging -->
				<%= fnDisplayPaging_New(CurrPage,oDoc.FTotalCount,PageSize,10,"jsGoPage") %>
				</div>
			</div>
		</div>
	</div>
<%
	Else
		'// 검색 결과 없음
%>
			<script type="text/javascript" src="/common/addlog.js?tp=noresult&ror=<%=server.UrlEncode(Request.serverVariables("HTTP_REFERER"))%>"></script>
			<div class="ct" style="min-height:300px;">
				<p class="tPad30"><img src="http://fiximage.10x10.co.kr/web2013/common/txt_search_no.png" alt="흠… 검색 결과가 없습니다." /></p>
				<p class="tPad10">해당상품이 품절 되었을 경우 검색이 되지 않습니다.</p>
			</div>

			<form name="sFrm" id="listSFrm" method="get" action="?">
			<input type="hidden" name="rect" value="<%= SearchText %>">
			<input type="hidden" name="prvtxt" value="<%= PrevSearchText %>">
			<input type="hidden" name="rstxt" value="<%= ReSearchText %>">
			<input type="hidden" name="extxt" value="<%= ExceptText %>">
			<input type="hidden" name="sflag" value="<%= SearchFlag  %>">
			<input type="hidden" name="disp" value="<%= dispCate %>">
			<input type="hidden" name="cpg" value="">
			<input type="hidden" name="chkr" value="<%= CheckResearch %>">
			<input type="hidden" name="chke" value="<%= CheckExcept %>">
			<input type="hidden" name="mkr" value="<%= makerid %>">
			<input type="hidden" name="sscp" value="<%= SellScope %>">
			<input type="hidden" name="psz" value="<%= PageSize %>">
			<input type="hidden" name="srm" value="<%= SortMet %>">
			<input type="hidden" name="iccd" value="<%=colorCD%>">
			<input type="hidden" name="styleCd" value="<%=styleCd%>">
			<input type="hidden" name="attribCd" value="<%=attribCd%>">
			<input type="hidden" name="icoSize" value="<%=icoSize%>">
			<input type="hidden" name="arrCate" value="<%=arrCate%>">
			<input type="hidden" name="deliType" value="<%=deliType%>">
			<input type="hidden" name="minPrc" value="<%=minPrice%>">
			<input type="hidden" name="maxPrc" value="<%=maxPrice%>">
			<input type="hidden" name="lstDiv" value="<%=ListDiv%>">
			</form>
		</div>
	</div>
<%
	end if
%>


	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<%'<!-- Criteo 카테고리/리스팅 태그 -->%>
<%
	If oDoc.FResultCount > 0 Then
		Dim CriteoCategoryItemLists
		'// 크리테오 전송용 상품코드
		CriteoCategoryItemLists = ""

		For icol = 0 To oDoc.FResultCount - 1
			If icol < 3 Then
				CriteoCategoryItemLists = CriteoCategoryItemLists & "'"&oDoc.FItemList(icol).FItemID&"',"
			End If
		Next
		If Trim(CriteoCategoryItemLists) <> "" Then
			CriteoCategoryItemLists = Left(CriteoCategoryItemLists, Len(CriteoCategoryItemLists)-1)
		End If
		'//크리테오에 보낼 md5 유저 이메일값
		Dim CriteoUserMailMD5InCategory
		If Trim(session("ssnuseremail")) <> "" Then
			CriteoUserMailMD5InCategory = MD5(Trim(session("ssnuseremail")))
		Else
			CriteoUserMailMD5InCategory = ""
		End If
%>
		<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
		<script type="text/javascript">
		window.criteo_q = window.criteo_q || [];
		var deviceType = /iPad/.test(navigator.userAgent) ? "t" : /Mobile|iP(hone|od)|Android|BlackBerry|IEMobile|Silk/.test(navigator.userAgent) ? "m" : "d";
		window.criteo_q.push(
			{ event: "setAccount", account: 8262},
			{ event: "setEmail", email: "<%=CriteoUserMailMD5InCategory%>" },
			{ event: "setSiteType", type: deviceType},
			{ event: "viewList", item: [<%=CriteoCategoryItemLists%>] }
		);
		</script>
<%
	End If
%>
<%'<!-- END 카테고리/리스팅 태그 -->%>

<%
if False and Not(searchFlag="ea" or searchFlag="ep") then
	IF oDoc.FResultCount >0 then
%>
<script type="application/ld+json">
{
	"@context" : "http://schema.org",
	"@type" : "ItemList",
	"itemListElement" : [<% For icol = 0 To oDoc.FResultCount - 1 %>{
		"@context": "http://schema.org/",
		"@type": "Product",
		"name": "<%= Replace(oDoc.FItemList(icol).FItemName,"""","") %>",
		"image": "<%= getThumbImgFromURL(oDoc.FItemList(icol).FImageBasic,imgSz,imgSz,"true","false")%>",
		"mpn": "<%= oDoc.FItemList(icol).FItemID %>",
		"brand": {
			"@type": "Brand",
			"name": "<%= Replace(oDoc.FItemList(icol).FBrandName,"""","") %>"
		}
	}<%
		if (icol < (oDoc.FResultCount - 1)) then
			response.write ","
		end if
	next
	%>]
}
</script>
<%
	end if
end if
%>
</body>
</html>
<% set oDoc = Nothing %>
<!-- #include virtual="/lib/db/dbclose.asp" -->
