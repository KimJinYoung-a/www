<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
<!-- #include virtual="/lib/util/tenSessionLib.asp" -->
<!-- #include virtual="/lib/db/dbopen.asp" -->
<!-- #include virtual="/lib/classes/item/itemInfoCls.asp" -->
<!-- #include virtual="/lib/classes/item/CategoryCls.asp" -->
<!-- #include virtual="/lib/classes/search/searchcls.asp" -->
<!-- #include virtual="/lib/classes/search/keywordcls.asp" -->
<!-- #include virtual="/lib/classes/shopping/category_main_SpecialCls.asp" -->
<!-- #include virtual="/shopping/category_code_check.asp" -->
<!-- #include virtual="/lib/classes/ordercls/pack_cls.asp" -->
<!-- #include virtual="/lib/util/DBcacheLib.asp" -->
<!-- #include virtual="/lib/util/commlib.asp" -->
<!-- #include virtual="/lib/util/functions.asp" -->
<!-- #include virtual="/lib/util/tenEncUtil.asp" -->
<!-- #include virtual="/lib/util/md5.asp" -->
<!-- #include virtual="/lib/util/paramchecklib.asp" -->
<!-- #include virtual="/lib/util/JSON_2.0.4.asp"-->
<%
'#########################################################
' Description :  다이어리 스토리 검색 필터 검색 총 수량
' History : 2022.08.18 정태훈 생성
'#########################################################
Response.ContentType = "application/json"
response.charset = "utf-8"

Dim dispCate, oJson
dispCate = vDisp
dim SearchItemDiv : SearchItemDiv="n"	'추가 카테고리 포함
dim SearchCateDep : SearchCateDep= "T"	'하위카테고리 모두 검색

dim SearchFlag : SearchFlag = request("sflag")
dim makerid : makerid = ReplaceRequestSpecialChar(request("mkr"))
dim colorCD : colorCD = ReplaceRequestSpecialChar(request("iccd"))
dim attribCd : attribCd = ReplaceRequestSpecialChar(request("attribCd"))
dim arrCate : arrCate = ReplaceRequestSpecialChar(request("arrCate"))
dim SellScope 	: SellScope=requestCheckVar(request("sscp"),1)			'품절상품 제외여부
if SellScope = "" then SellScope = "Y"                                  ''기본 품절제외(eastone)
dim ListDiv : ListDiv = "list"		'카테고리/검색 구분용
dim sColorMode : sColorMode = "S"
dim deliType : deliType = request("deliType")
dim DocSearchText
dim CheckResearch : CheckResearch= request("chkr")
dim SearchText : SearchText = requestCheckVar(request("rect"),100) '현재 입력된 검색어
dim PrevSearchText : PrevSearchText = requestCheckVar(request("prvtxt"),100) '이전 검색어
dim ReSearchText : ReSearchText=requestCheckVar(request("rstxt"),100) '결과내 재검색용
dim ExceptText : ExceptText=requestCheckVar(request("extxt"),100) '결과내 제외어
dim CheckExcept : CheckExcept= request("chke")

if colorCD="" then colorCD="0"

IF searchFlag="" Then
	searchFlag= "n"
end if

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

dim oTotalCnt, getCateListCount
set oTotalCnt = new SearchItemCls
    oTotalCnt.FRectDiaryItem = "R"
    oTotalCnt.FRectSearchFlag = searchFlag
    oTotalCnt.FRectSearchItemDiv = SearchItemDiv
    oTotalCnt.FRectSearchCateDep = SearchCateDep
    oTotalCnt.FRectCateCode	= dispCate
    oTotalCnt.FarrCate=arrCate
    oTotalCnt.FRectMakerid	= makerid
    oTotalCnt.FcolorCode= colorCD
    oTotalCnt.FattribCd = attribCd
    oTotalCnt.FListDiv = ListDiv
    oTotalCnt.FSellScope=SellScope
    oTotalCnt.FdeliType	= deliType
    oTotalCnt.FRectSearchTxt = DocSearchText
    oTotalCnt.FRectExceptText = ExceptText
    oTotalCnt.getTotalCount
    getCateListCount = oTotalCnt.FTotalCount
set oTotalCnt = Nothing

Set oJson = jsObject()

oJson("response") = "ok"
oJson("searchCount") = getCateListCount
oJson.flush
Set oJson = Nothing

%>
<!-- #include virtual="/lib/db/dbclose.asp" -->
