<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.CharSet = "UTF-8"

'#######################################################
'	History	: 2013.08.19 허진원 생성
'				2013.12.30 한용민 수정
'				2015.06.01 허진원 - 2015 리뉴얼
'	Description : 검색 결과
'#######################################################
%>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/util/pageformlib.asp" -->
<!-- #include virtual="/lib/classes/item/iteminfoCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/classes/search/keywordcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/chkDevice.asp" -->
<%
Dim isShowSumamry : isShowSumamry = true	''탭별 검색 갯수 표시 여부 : 느릴경우 FALSE 로
Dim isSaveSearchKeyword : isSaveSearchKeyword = false	''검색어 DB에 저장 여부 // DB저장은 안함. 내검색어 저장여부 procMySearchKeyword (쿠키저장) 분리
Dim tmpPrevSearchKeyword, tmpCurrSearchKeyword


dim SearchText : SearchText = replace(requestCheckVar(request("rect"),100),"%27","") '현재 입력된 검색어
dim PrevSearchText : PrevSearchText = replace(requestCheckVar(request("prvtxt"),100),"%27","") '이전 검색어
dim ReSearchText : ReSearchText = replace(requestCheckVar(request("rstxt"),100),"%27","") '결과내 재검색용
dim ExceptText : ExceptText = replace(requestCheckVar(request("extxt"),100),"%27","") '결과내 제외어
dim DocSearchText
dim SearchItemDiv : SearchItemDiv="y"	'기본 카테고리만
dim SearchCateDep : SearchCateDep= "T"	'하위카테고리 모두 검색

'불량어 차단
if InStr(LCase(SearchText),"nuna24.com")>0 or InStr(LCase(SearchText),"factspo.com")>0 or InStr(LCase(SearchText),"ddakbam.com")>0 then
	Response.Redirect "/"
end if

dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),5))
dim SortMet		: SortMet = request("srm")
dim SearchFlag  : SearchFlag = request("sflag")
dim dispCate    : dispCate = getNumeric(requestCheckVar(request("dispCate"),18))
dim CurrPage    : CurrPage = getNumeric(requestCheckVar(request("cpg"),8))
dim CheckResearch : CheckResearch = request("chkr")
dim CheckExcept : CheckExcept = request("chke")
dim makerid     : makerid = ReplaceRequestSpecialChar(request("mkr"))
dim minPrice    : minPrice = getNumeric(requestCheckVar(request("minPrc"),8))
dim maxPrice    : maxPrice = getNumeric(requestCheckVar(request("maxPrc"),8))
dim deliType    : deliType = request("deliType")
dim colorCD     : colorCD = ReplaceRequestSpecialChar(request("iccd"))
dim styleCD     : styleCD = ReplaceRequestSpecialChar(request("styleCd"))
dim attribCd    : attribCd = ReplaceRequestSpecialChar(request("attribCd"))
dim arrCate     : arrCate = ReplaceRequestSpecialChar(request("arrCate"))
dim SellScope 	: SellScope = requestCheckVar(request("sscp"),1)			'품절상품 제외여부
dim ScrollCount : ScrollCount = 10
dim ListDiv     : ListDiv = ReplaceRequestSpecialChar(request("lstdiv"))	'카테고리/검색 구분용
dim SubShopCd   : SubShopCd = requestCheckVar(request("subshopcd"),3)		' 서브샵코드  100:다이어리스토리
dim giftdiv 	: giftdiv=requestCheckVar(request("giftdiv"),1)			'사은품 (R: 다이어리스토리 사은품 )
dim LogsAccept  : LogsAccept = true		'검색Log 사용여부 (검색페이지: 사용)
dim sColorMode  : sColorMode = "S"
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)
Dim vWordBannerChk : vWordBannerChk = False '// 특정 검색어 링크배너 노출여부
dim chkMyKeyword : chkMyKeyword=true		'나의 검색어
dim lp, ColsSize

if SellScope = "" then SellScope = "N"

'//logparam
Dim logparam : logparam = "&pRtr="& server.URLEncode(SearchText)

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)
if SortMet="" then SortMet="bs"		'베스트:be, 신상:ne
if ListDiv="" then ListDiv="salelist"

dim imgSz	: imgSz = chkIIF(icoSize="M",240,150)		'M 사이즈 변경 240 → 200 (20150603; 허진원) -->> 200 → 240 (20180511; 정태훈)

'// 실제 타자로 입력된 검색어인지(2013-08-02 13:08:50 적용)
dim IsRealTypedKeyword : IsRealTypedKeyword = True
if requestCheckVar(request("exkw"),1) = "1" then
	IsRealTypedKeyword = False
end if

if CurrPage="" then CurrPage=1
if colorCD="" then colorCD="0"
IF searchFlag="" Then searchFlag= "sale"

Select Case SearchFlag
	Case "n", "sc", "fv", "pk"
		'상품 목록 크기에 따라 선택
		if icoSize="B" then
			'2행 5열(총10개)
			ColsSize =2
			IF PageSize="" or PageSize<10 then PageSize = 10
		elseif icoSize="M" then
			'5행 10열(총50개)
			ColsSize =5
			IF PageSize="" or PageSize<40 then PageSize = 60
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
			'5행 10열(총50개)
			ColsSize =5
			IF PageSize="" or PageSize<40 then PageSize = 60
		else
			'6행 12열(총72개)
			ColsSize =6
			IF PageSize="" or PageSize<72 then PageSize = 72
		end if
End Select

IF CStr(SearchText)=CStr(PrevSearchText) Then
	LogsAccept = false
End if

if CheckResearch="undefined" then CheckResearch=""
if len(CheckResearch)>5 then CheckResearch=""
IF CheckResearch="" then CheckResearch=false
if CheckExcept="undefined" then CheckExcept=""
if len(CheckExcept)>5 then CheckExcept=""
IF CheckExcept="" then CheckExcept=false

SearchText = RepWord(SearchText,"[^ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9.&%+\-\_\s]","")
ExceptText = RepWord(ExceptText,"[^ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9.&%+\-\_\s]","")

IF CheckReSearch Then
	ReSearchText = RepWord(ReSearchText,SearchText,"")
	ReSearchText = RepWord(ReSearchText,"[\s]{2,}"," ")
	ReSearchText = RepWord(ReSearchText,"^[+\s]","")
	ReSearchText = ReSearchText & " " & SearchText
	DocSearchText = ReSearchText
Else
	ReSearchText	= SearchText
	DocSearchText   = SearchText
End if

if CheckExcept then
	ReSearchText    = ReSearchText
	DocSearchText   = ReSearchText
	SearchText      = ExceptText
end if

'특정 단어 삭제
DocSearchText = Trim(Replace(DocSearchText,"상품",""))

IF Len(DocSearchText)<>0 and isNumeric(DocSearchText) THEN
	If Left(DocSearchText,1) <> "0" Then
		DocSearchText = Cdbl(DocSearchText)
	End If
'	DocSearchText = Cdbl(DocSearchText)
END IF

Select Case sPercent
	Case "99"
		oDoc.FSalePercentLow = "0"
		oDoc.FSalePercentHigh = "0.3"
	Case "70"
		oDoc.FSalePercentLow = "0.3"
		oDoc.FSalePercentHigh = "0.5"
	Case "50"
		oDoc.FSalePercentLow = "0.5"
		oDoc.FSalePercentHigh = "0.8"
	Case "20"
		oDoc.FSalePercentLow = "0.8"
		oDoc.FSalePercentHigh = "1"
end Select

'// 상품검색
dim oDoc,iLp
set oDoc = new SearchItemCls
    oDoc.FRectSearchTxt = DocSearchText
    oDoc.FRectPrevSearchTxt = PrevSearchText
    oDoc.FRectExceptText    = ExceptText
    oDoc.FRectSortMethod	= SortMet
    oDoc.FRectSearchFlag    = searchFlag
    oDoc.FRectSearchItemDiv = SearchItemDiv
    oDoc.FRectSearchCateDep = SearchCateDep
    oDoc.FRectCateCode	    = dispCate
    oDoc.FRectMakerid	    = makerid
    oDoc.FminPrice	        = minPrice
    oDoc.FmaxPrice	        = maxPrice
    oDoc.FdeliType	        = deliType
    oDoc.FCurrPage          = CurrPage
    oDoc.FPageSize          = PageSize
    oDoc.FScrollCount       = ScrollCount
    oDoc.FListDiv           = ListDiv
    oDoc.FLogsAccept        = LogsAccept
    oDoc.FRectColsSize      = ColsSize
    oDoc.FcolorCode         = colorCD
    oDoc.FstyleCd           = styleCd
    oDoc.FattribCd          = attribCd
    oDoc.FSellScope         = SellScope
    oDoc.FarrCate           = arrCate
    oDoc.getSearchList

    '// 추후 작업 예정

    '// 추후 작업 예정

set oDoc = Nothing
%>