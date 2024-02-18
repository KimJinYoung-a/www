<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<%
Response.CharSet = "UTF-8"

'#######################################################
'	History	: 2021.04.23 이전도 생성
'	Description : 검색 페이지
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
<!-- #include virtual="/lib/util/md5.asp" -->
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

'============== 모바일 접근시 모바일 페이지 이동(referer가 10x10이면 이동안함) ============
if InStr(request.ServerVariables("HTTP_REFERER"),"10x10.co.kr")<1 then
	if Not(Request("mfg")="pc" or session("mfg")="pc") then
		if Not(flgDevice="W" or flgDevice="D" or flgDevice="T") then
			dim mRdSite: mRdSite = requestCheckVar(request("rdsite"),32)
			''Response.Redirect "http://m.10x10.co.kr/search/search_item.asp?rect=" & server.URLEncode(SearchText) & "&exkw=1" & chkIIF(mRdSite<>"","&rdsite=" & mRdSite,"")
			Response.Redirect "https://m.10x10.co.kr/search/search_item.asp?" & request.serverVariables("QUERY_STRING")	'받은값 전부 포워딩

			dbget.Close
			REsponse.End
		end if
	end if
end if

''세라밸
if date() >= "2019-04-01" and date() <= "2019-04-22" then
	if replace(SearchText," ","")="세라밸" Or replace(SearchText," ","")="세라벨" Or replace(SearchText," ","")="정기세일" Or replace(SearchText," ","")="4월세일" then ''텐텐쇼퍼
		Response.Redirect "http://www.10x10.co.kr/event/salelife/index.asp"
	end if
end If
''5월 가정의달
if date() >= "2019-04-18" and date() <= "2019-05-15" then
	if replace(SearchText," ","")="5월의선물" then ''5월 가정의달
		Response.Redirect "http://www.10x10.co.kr/event/family2019/"
	end if
end If
''텐텐쇼퍼 7기
if date() >= "2020-06-01" and date() <= "2020-06-23" then
	if replace(SearchText," ","")="텐텐쇼퍼" Or replace(SearchText," ","")="텐텐쇼퍼11기" Or replace(SearchText," ","")="서포터즈" then '텐텐쇼퍼
		Response.Redirect "http://www.10x10.co.kr/event/eventmain.asp?eventid=103132"
	end if
end If

if date() >= "2019-11-13" and date() <= "2019-12-09" then
	if replace(SearchText," ","")="오마이걸" Or replace(SearchText," ","")="오마이걸이벤트" Or replace(SearchText," ","")="다이어리이벤트" then '다이어리 이벤트
		Response.Redirect "http://www.10x10.co.kr/event/eventmain.asp?eventid=98339"
	end if
end If

'불량어 차단
if InStr(LCase(SearchText),"nuna24.com")>0 or InStr(LCase(SearchText),"factspo.com")>0 or InStr(LCase(SearchText),"ddakbam.com")>0 then
	Response.Redirect "/"
end if

dim PageSize	: PageSize = getNumeric(requestCheckVar(request("psz"),5))
dim SortMet		: SortMet = request("srm")
dim SearchFlag : SearchFlag = request("sflag")
dim dispCate : dispCate = getNumeric(requestCheckVar(request("dispCate"),18))
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
if SellScope = "" then SellScope = "N"
dim ScrollCount : ScrollCount = 10
dim ListDiv : ListDiv = ReplaceRequestSpecialChar(request("lstdiv"))	'카테고리/검색 구분용
dim SubShopCd : SubShopCd = requestCheckVar(request("subshopcd"),3)		' 서브샵코드  100:다이어리스토리
dim giftdiv 	: giftdiv=requestCheckVar(request("giftdiv"),1)			'사은품 (R: 다이어리스토리 사은품 )
dim LogsAccept : LogsAccept = true		'검색Log 사용여부 (검색페이지: 사용)
dim lp, ColsSize
dim sColorMode : sColorMode = "S"
dim icoSize		: icoSize = requestCheckVar(request("icoSize"),1)
Dim vWordBannerChk '// 특정 검색어 링크배너 노출여부

vWordBannerChk = False

'//logparam
Dim logparam : logparam = "&pRtr="& server.URLEncode(SearchText)
dim diarystoryitem 	: diarystoryitem=requestCheckVar(request("diarystoryitem"),1)			'다이어리 스토리 아이템 소팅
dim parentsPage : parentsPage = "search"

if icoSize="" then icoSize="M"	'상품 아이콘 기본(중간)
if SortMet="" then SortMet="be"		'베스트:be, 신상:ne
if ListDiv="" then ListDiv="search"

dim imgSz	: imgSz = chkIIF(icoSize="M",240,150)		'M 사이즈 변경 240 → 200 (20150603; 허진원) -->> 200 → 240 (20180511; 정태훈)

'// 실제 타자로 입력된 검색어인지(2013-08-02 13:08:50 적용)
dim IsRealTypedKeyword : IsRealTypedKeyword = True
if requestCheckVar(request("exkw"),1) = "1" then
	IsRealTypedKeyword = False
end if

dim chkMyKeyword : chkMyKeyword=true		'나의 검색어

if CurrPage="" then CurrPage=1
if colorCD="" then colorCD="0"
IF searchFlag="" Then searchFlag= "n"

if CurrPage > 32767 then
    '// 검색엔진 오버플로우 방지
    CurrPage = 32767
end if

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

''SearchText = RepWord(SearchText,"[^가-힣a-zA-Z0-9.&%\-\_\s]","")
''ExceptText = RepWord(ExceptText,"[^가-힣a-zA-Z0-9.&%\-\_\s]","")

''2017/09/10
SearchText = RepWord(SearchText,"[^ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9.&%+\-\_\(\)\/\\\[\]\~\s]","")
ExceptText = RepWord(ExceptText,"[^ㄱ-ㅎㅏ-ㅣ가-힣a-zA-Z0-9.&%+\-\_\(\)\/\\\[\]\~\s]","")

IF CheckReSearch Then
	'ReSearchText = ReSearchText & " " & SearchText

	ReSearchText = RepWord(ReSearchText,SearchText,"")
	ReSearchText = RepWord(ReSearchText,"[\s]{2,}"," ")
	ReSearchText = RepWord(ReSearchText,"^[+\s]","")
	ReSearchText = ReSearchText & " " & SearchText
	DocSearchText = ReSearchText
Else
	ReSearchText	=	SearchText
	DocSearchText = SearchText
End if

if CheckExcept then
	ReSearchText	=	ReSearchText
	DocSearchText = ReSearchText
	SearchText = ExceptText
end if

'특정 단어 삭제
DocSearchText = Trim(Replace(DocSearchText,"상품",""))

IF Len(DocSearchText)<>0 and isNumeric(DocSearchText) THEN
	If Left(DocSearchText,1) <> "0" Then
		DocSearchText = Cdbl(DocSearchText)
	End If
'	DocSearchText = Cdbl(DocSearchText)
END IF

dim iRows,i,ix,r

''2018/03/14 AB TEST ============================================================
dim sqlStr
Dim is_AbTestTarget : is_AbTestTarget=FALSE
Dim ab_targetGroup : ab_targetGroup=""

''if (request("abt")="") then
''	sqlStr = "exec db_const.dbo.usp_Ten_Const_ABTEST_Keyword_CHECK '"&DocSearchText&"'"
''	rsget.CursorLocation = adUseClient
''	rsget.Open sqlStr, dbget, adOpenForwardOnly, adLockReadOnly
''	If Not(rsget.EOF) then
''		is_AbTestTarget = True
''	end if
''	rsget.Close
''end if
''
''if (is_AbTestTarget) then
''	if (session.sessionid mod 2=0) then
''		ab_targetGroup="a"
''	else
''		ab_targetGroup="b"
''	end if
''	logparam=logparam&"&ab=023_"&ab_targetGroup
''end if
'================================================================================

'// 총 검색수 산출 - 불필요 제거
' dim oTotalCnt
' set oTotalCnt = new SearchItemCls
' oTotalCnt.FRectSearchTxt = DocSearchText
' oTotalCnt.FRectExceptText = ExceptText
' oTotalCnt.FRectSearchItemDiv = SearchItemDiv
' oTotalCnt.FRectSearchCateDep = SearchCateDep
' oTotalCnt.FListDiv = ListDiv
' oTotalCnt.FSubShopCd = SubShopCd
' oTotalCnt.FGiftDiv = giftdiv
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
if (is_AbTestTarget) and (ab_targetGroup="b") then	'' 2018/03/14 AB TEST 분기
	if (SortMet="be") then
		oDoc.FRectSortMethod	= "vv"
	else
		oDoc.FRectSortMethod	= SortMet
	end if
else
	oDoc.FRectSortMethod	= SortMet
end if
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

'// 숫자만 입력될경우 체크후 상품페이지로 넘기기
IF oDoc.FTotalCount=1 and isNumeric(DocSearchText) Then

	on Error Resume Next

	'// 존재하는 상품인지 검사
	dim objCmd,returnValue

	Set objCmd = Server.CreateObject("ADODB.Command")

	objCmd.ActiveConnection = dbget
	objCmd.CommandType = adCmdStoredProc
	objCmd.CommandText = "[db_item].[dbo].sp_Ten_PrdExists"

	objCmd.Parameters.Append objCmd.CreateParameter("RETURN_VALUE", adInteger, adParamReturnValue)
	objCmd.Parameters.Append objCmd.CreateParameter("@@vItemID",adVarWChar,adParamInput,10,CLng(DocSearchText))

	objCmd.Execute

	returnValue = objCmd("RETURN_VALUE").value

	Set objCmd = Nothing
	IF returnValue=1 Then
		response.redirect "/shopping/category_prd.asp?itemid=" & CLng(DocSearchText)
		dbget.close()	:	response.End
	End IF

	on Error Goto 0

End if

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
' end If


'// 내검색어 쿠키 저장 (검색어 로그 저장 않에 있었으나 뺌 2016/04/22)
if (tmpCurrSearchKeyword <> tmpPrevSearchKeyword) and (Not CheckResearch) then
	call procMySearchKeyword(tmpCurrSearchKeyword)
end If

'// 특정 검색어 들어오면 관련 링크배너 노출
Select Case Trim(Replace(SearchText," ",""))

	Case "결혼", "결혼식", "포토테이블", "부케", "상견례", "웨딩", "신혼", "청첩장", "웨딩소품", "허니문", "신혼여행", "집들이", "웨딩드레스", "웨딩슈즈", "답례품", "셀프웨딩", "브라이덜샤워"
		vWordBannerChk = True
	Case "신혼살림", "셀프웨딩", "인테리어", "주방", "허니문", "집들이", "신혼", "도마", "그릇", "신혼가구", "침대", "협탁", "식탁", "예쁜그릇"
		vWordBannerChk = True
	Case "가전제품", "신혼가전", "청소기", "전자레인지", "오븐", "침구", "이불", "슬리퍼", "전자렌지", "전자랜지", "결혼", "소파", "행거"
		vWordBannerChk = True
	Case "다이어리스토리", "다이어리", "2018 다이어리", "일기장", "일기", "플래너", "스케줄러", "위클리플래너", "먼슬리플래너", "데일리플래너", "위클리다이어리", "먼슬리다이어리", "데일리다이어리", "위클리", "먼슬리", "데일리", "저널", "몰스킨", "diary story", "2018 diary", "diary", "planner", "scheduler", "weekly planner", "monthly planner", "Moleskine", "연간 플래너", "한달 플래너", "날짜형 다이어리", "만년 다이어리 ", "패턴 다이어리 ", "심플 다이어리", "포토 다이어리 ", "일러스트 다이어리", "미도리 ", "미도리 다이어리 ", "아이코닉 다이어리 ", "인바이트엘 다이어리 ", "건망증 다이어리 ", "2018 planner", "weekly planner", "monthly planner ", "pattern diary", "simple diary", "photo diary", "Illust diary"
		vWordBannerChk = True

End Select

'RecoPick 스트립트 관련 내용 추가; 2014.11.17 허진원 추가
RecoPickSCRIPT = "	recoPick('page', 'search', '" & SearchText & "');"										'incFooter.asp 에서 출력

'// 페이지 타이틀 및 페이지 설명 작성
strPageTitle = "텐바이텐 10X10 : 검색결과 - " & SearchText		'페이지 타이틀 (필수)

'Metatag 추가
strPageKeyword = SearchText

'검색결과 없을때 처리
IF oDoc.FTotalCount=0 THEN
	strPageKeyword = ""
	strHeaderAddMetaTag = "<meta property=""og:title"" id=""meta_og_title"" content=""텐바이텐 10X10 : 검색결과"" />" & vbCrLf &_
						"	<meta property=""og:type"" content=""website"" />" & vbCrLf &_
						"	<meta name=""robots"" content=""noindex"" />" & vbCrLf
END IF

'// 구글 ADS 스크립트 관련(2018.09.21 신규버전 추가)
googleADSCRIPT = " <script> "
googleADSCRIPT = googleADSCRIPT & "	gtag('event', 'page_view', { "
googleADSCRIPT = googleADSCRIPT & "	 'send_to': 'AW-851282978', "
googleADSCRIPT = googleADSCRIPT & "	 'ecomm_pagetype': 'searchresults', "
googleADSCRIPT = googleADSCRIPT & "	 'ecomm_prodid': '', "
googleADSCRIPT = googleADSCRIPT & "	 'ecomm_totalvalue': '' "
googleADSCRIPT = googleADSCRIPT & "	}); "
googleADSCRIPT = googleADSCRIPT & " </script> "

'// Kakao Analytics
kakaoAnal_AddScript = "kakaoPixel('6348634682977072419').search({keyword:'"&Server.URLEncode(SearchText)&"'});"

'//=========================== amplitude로 전송할 데이터=============================================

dim vAmplitudeSearchText, vAmplitudeSearchFlag, vAmplitudeStyleCd,vAmplitudeColorCD
dim vAmplitudeDeliType,vAmplitudeMinPrice,vAmplitudeMaxPrice,vAmplitudeReSearchText,vAmplitudeSortMet
dim vAmplitudeSellScope, vAmplitudeMakerid, vAmplitudeArrCate
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
If colorCD = "" or colorCD = "0" Then
	vAmplitudeColorCD = "none"
Else

	dim colarr
	dim arrCnm
	vAmplitudeColorCD = ""

	colarr = split(colorCD,",")
	arrCnm = split("red,orange,yellow,beige,green,skyblue,blue,violet,pink,brown,white,grey,black,silver,gold,mint,babypink,lilac,khaki,navy,camel,charcoal,wine,ivory,check,stripe,dot,flower,drawing,animal,geometric",",")
	For i = 0 To ubound(colarr)
        if IsNumeric(colarr(i)) then
		    vAmplitudeColorCD = vAmplitudeColorCD & arrCnm(cint(colarr(i))-1) & ","
        end if
	Next

    if vAmplitudeColorCD = "" then
        vAmplitudeColorCD = "none"
    else
        vAmplitudeColorCD = left(vAmplitudeColorCD,Len(vAmplitudeColorCD)-1)
    end if
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
'검색 상품 내 검색 키워드
If ReSearchText = "" Then
	vAmplitudeReSearchText = "none"
Else
	vAmplitudeReSearchText = ReSearchText
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
	End Select
End if
'품절 상품 포함 여부
If SellScope = "" Then
	vAmplitudeSellScope = "none"
Else
	vAmplitudeSellScope = SellScope
End if
'메이커
If makerid = "" Then
	vAmplitudeMakerid = "none"
Else
	vAmplitudeMakerid = makerid
End if
'카테고리
if arrCate = "" then
	vAmplitudeArrCate = "none"
else
	vAmplitudeArrCate = arrCate
end if


'//=========================== amplitude로 전송할 데이터=============================================
%>
<!-- #include virtual="/lib/inc/head.asp" -->
<link rel="stylesheet" type="text/css" href="/lib/css/preVst/section.css" />
<script type="text/javascript" src="/lib/js/search_result.js?v=1.0"></script>
<script type="text/javascript" src="/lib/js/searchFilter.js?v=1.31"></script>
<script type="text/javascript" src="/lib/js/jquery.masonry.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script type="text/javascript">
$(function() {
    if(typeof qg !== "undefined"){
        let appier_searched_data = {
            "keyword" : "<%=SearchText%>"
            , "sort" : "<%=SortMet%>"
        };

        qg("event", "searched", appier_searched_data);
    }

	<% if CurrPage > 1 then %>
	//fnAmplitudeEventMultiPropertiesAction('view_search_result_paging','paging_index|sort','<%=CurrPage%>|<%=vAmplitudeSortMet%>');
	<%end if%>

	//시작 위치 설정
	<% if CurrPage>1 or searchFlag<>"n" then %>
	$(window).scrollTop($(".pdtFilterWrap").offset().top-10);
	<% else %>
	//$('html,body').animate({scrollTop: $("#contentWrap").offset().top+40},'fast');
	$(window).scrollTop($("#contentWrap").offset().top+40);
	// 검색어 입력 강제 포커스(2015.10.02; 허진원)
	/*
	$('.searchV15 .searchWordV15').parent().parent().hide();
	$('.searchingV15').show();
	$('#dimed').show();
	$('.searchWordV15 input[name="sMtxt"]').setCursorToTextEnd(50);
	*/
	<% end if %>

	// Item Image Control
	$(".pdtList li .pdtPhoto").mouseenter(function(e){
		$(this).find("dfn").fadeIn(150);
	}).mouseleave(function(e){
		$(this).find("dfn").fadeOut(150);
	});

	$(".pdtList p").click(function(e){
		e.stopPropagation();
	});

	$('.icoWrappingV15a').mouseover(function() {
		$(this).children('em').fadeIn();
	});

	$('.icoWrappingV15a').mouseleave(function() {
		$(this).children('em').hide();
	});

	<% if oDoc.FTotalCount<1 then %>
		// 스크롤 확인
		var pg = 1;
		$(window).scroll(function(){
			if( $(window).scrollTop()==($(document).height()-$(window).height()) ) {
				pg++;
				//추가 페이지 접수
				$.ajax({
					url: "act_inc_BestItemList.asp?page="+pg,
					cache: false,
					async: false,
					success: function(message) {
						if(pg < 6){
							if(message!="") {
								//추가 내용 Import!
								//$('.cultureList .box').last().after(message);
								$str = $(message)
								// 박스 내용 추가
								$('#bestpdtList').append($str);
							} else {
								//더이상 자료가 없다면 스크롤 이벤트 종료
								$(window).unbind("scroll");
							}
						}else{
							$(window).unbind("scroll");
						}
					}
				});

			}
		});
	<% end if %>

	<%'// Branch Init %>
	<% if application("Svr_Info")="staging" Then %>
		branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
	<% elseIf application("Svr_Info")="Dev" Then %>
		branch.init('key_test_ngVvbkkm1cLkcZTfE55Dshaexsgl87iz');
	<% else %>
		branch.init('key_live_hpOucoij2aQek0GdzW9xFddbvukaW6le');
	<% end if %>
	var branchSearchData = {
		"search_query" : "<%=Replace(SearchText," ","")%>"
	};
	<% If oDoc.FTotalCount > 0 Then %>
		var branchSearchItemsData = [
		<% For r = 0 to oDoc.FResultCount-1 %>
			{
				"$price" : <%=oDoc.FItemList(r).getRealPrice%>,
				"$product_name" : "<%=Server.URLEncode(replace(oDoc.FItemList(r).FItemName,"'",""))%>",
				"$sku" : "<%=oDoc.FItemList(r).FItemID%>",
				"$quantity" : 1,
				"$currency" : "KRW",
				"category" : "<%=Server.URLEncode(fnItemIdToCategory1DepthName(oDoc.FItemList(r).FItemID))%>"
			}
			<%=chkIIF(r < oDoc.FResultCount-1,",","")%>
		<% next %>
		];
	<% End If %>
	branch.logEvent(
		"SEARCH",
		branchSearchData,
		branchSearchItemsData,
		function(err) { console.log(err); }
	);

	if( unescape(location.href).includes('//localhost') || unescape(location.href).includes('//testwww') || unescape(location.href).includes('//localwww')) {
        apiUrl =  '//testfapi.10x10.co.kr/api/web/v1'
        //apiUrl =  '//localhost:8080/api/web/v1';
    } else{
        apiUrl =  '//fapi.10x10.co.kr/api/web/v1';
    }
	$.ajax({
	    url: apiUrl + "/search/kinesis?keywords=<%=ReSearchText%>&page=<%=CurrPage%>&searchType=ksearch"
	    , crossDomain: true
        , xhrFields: {
         	withCredentials: true
        }
	    , type: "get"
	    , success: function (data){
	    }
	});
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

	}
	/*
	fnAmplitudeEventMultiPropertiesAction('click_search_result_change_sort','change_sort|now_sort|keyword|list_type',sendsortvalue+'|<%=vAmplitudeSortMet%>|<%=Replace(vAmplitudeSearchText," ","")%>|<%=vAmplitudeSearchFlag%>');
	*/
}

function amplitudeDiaryStory() {
	fnAmplitudeEventAction('view_diarystory_main', 'place', 'search');
}
</script>
</head>
<body>
<div class="wrap searchWrapV15">
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
			<!-- 검색 전 -->
			<%'// 검색상단배너 %>
			<div style="position:absolute; top:65px; z-index:53; cursor:pointer;">
				<% server.Execute("/search/include_right_search_banner.asp") %>
			</div>

			<div class="searchV15">
				<div class="searchInputV15">
					<p class="searchWordV15">
						<span class="searchTxtV15" id="viewSTxt"><%= ReSearchText %></span>
						<span><img src="http://fiximage.10x10.co.kr/web2015/common/btn_search.png" alt="검색" class="searchBtnV15" /></span>
					</p>
					<p class="resultSummryV15">
						<%
							'제외어 존재 시
							'if CheckExcept then
								'Response.Write "<span class='crRed'>'" & ExceptText & "'</span>(을)를 제외한 "
							'end if
						%>
						<!--검색결과 <strong><%= FormatNumber(oDoc.FTotalCount,0) %></strong> 상품-->
					</p>
				</div>
				<%
					'// 연관검색어
					if oDoc.FTotalCount>0 then
						dim oRckDoc, arrList
						set oRckDoc = new SearchItemCls
							oRckDoc.FRectSearchTxt = DocSearchText
							arrList = oRckDoc.getRecommendKeyWords()
						Set oRckDoc = nothing

						IF isArray(arrList) THEN
							if Ubound(arrList)>0 then
				%>
				<p class="wordDirectV15">
					<strong><img src="http://fiximage.10x10.co.kr/web2015/common/tit_related_search.png" alt="연관검색어" /></strong>
					<%
						For iRows=0 To Ubound(arrList)
							Response.Write "<span><a href=""/search/search_result.asp?rect=" & Server.URLEncode(arrList(iRows)) & "&exkw=1"" class=""link_red_11px_line"">" & arrList(iRows) & "</a></span>"
						Next
					%>
				</p>
				<%
							end if
						end if
					end if
				%>

				<%
					'// 실시간 인기검색어
					DIM oPpkDoc, arrTg
					SET oPpkDoc = NEW SearchItemCls
						oPpkDoc.FPageSize = 10
						'arrList = oPpkDoc.getPopularKeyWords()					'인기검색어 일반형태
						oPpkDoc.getPopularKeyWords2 arrList,arrTg				'인기검색어 순위정보 포함
						'oPpkDoc.getRealtimePopularKeyWords arrList,arrTg		'실시간 인기검색어(검색어 관리가 안되어 사용안함)
					SET oPpkDoc = NOTHING

					IF isArray(arrList) THEN
						if Ubound(arrList)>0 then
				%>
				<div class="realTRankV15">
					<dl class="realTWordRollingV15">
						<dt><img src="http://fiximage.10x10.co.kr/web2015/common/txt_realtime.png" alt="실시간 인기 검색어" /></dt>
						<dd>
							<div class="swiper-container">
								<ul class="swiper-wrapper realTListV15">
								<%
									dim vArwCss
									FOR iRows =0 To UBOUND(arrList)
										'등락표시
										if cStr(arrTg(iRows))="new" then
											vArwCss = "popNewV15"
										elseif arrTg(iRows)="0" or arrTg(iRows)="" then
											vArwCss = "popStayV15"
										elseif arrTg(iRows)>0 then
											vArwCss = "popUpV15"
										else
											vArwCss = "popDownV15"
										end if
								%>
									<li class="swiper-slide swiper-no-swiping realT<%=Num2Str(iRows+1,2,"0","R")%> popUpV15 <%=vArwCss%>"><a href="/search/search_result.asp?rect=<%=Server.URLEncode(arrList(iRows)) %>&exkw=1"><span><%=arrList(iRows) %></span></a></li>
								<% Next %>
								</ul>
							</div>
						</dd>
					</dl>
				</div>
				<%
						END IF
					END IF
				%>
			</div>
			<!-- 검색 전 -->

			<!-- 검색어 변경시(재검색 시) -->
			<div class="searchingV15" style="display:none">
				<div class="searchInputV15">
					<p class="searchWordV15">
						<span class="searchTxtV15"><input type="text" name="sMtxt" value="<%= ReSearchText %>" maxlength="50" title="검색하고자 하는 단어를 입력해주세요." onkeyup="if(keyCode(event)==13) { fnAmplitudeEventMultiPropertiesAction('click_search','keyword',$(this).val()); fnSearch(document.sFrm.rect,$(this).val(),'re');}" /></span>
						<span><input type="image" id="btnMainSearch" onclick="fnAmplitudeEventMultiPropertiesAction('click_search','keyword',$('input[name=sMtxt]').attr('value'));" src="http://fiximage.10x10.co.kr/web2015/common/btn_search.png" alt="검색" class="searchBtnV15" /></span>
					</p>

					<ul class="searchOptionV15">
						<li><a href="" onclick="fnResearchChk(this); return false;"><span>결과 내 재검색</span></a></li>
						<li><a href="" onclick="fnExceptChk(this); return false;"><span>특정 검색어 제외</span></a></li>
					</ul>
				</div>
				<%
					'// 나의 검색어 (존재시에만 표시)
					if chkMyKeyword then
						dim arrMyKwd: arrMyKwd = split(session("myKeyword"),",")

						if ubound(arrMyKwd)>=0 then
				%>
				<div class="wordDirectV15">
					<strong><img src="http://fiximage.10x10.co.kr/web2015/common/tit_my_search.png" alt="나의검색어" /></strong>
					<p id="lyrMyKeyword">
					<%
						for i=0 to ubound(arrMyKwd)
							Response.Write "<span><a href=""/search/search_result.asp?rect=" & server.URLEncode(arrMyKwd(i)) & "&exkw=1"">" & arrMyKwd(i) & "</a>"
							Response.Write " <a href="""" onclick=""delMyKeyword('" & server.URLEncode(arrMyKwd(i)) & "');return false;""><img src=""http://fiximage.10x10.co.kr/web2013/common/btn_delete.gif"" alt=""Delete"" class=""deleteBtn"" /></a>"
							Response.Write "</span>"
							if i>=4 then Exit For
						next
					%>
					</p>
					<a href="" onclick="delMyKeyword('','da'); return false;" class="btn btnS3 btnGry2 btnW60 fn lMar10">전체삭제</a>
				</div>
				<%
						end if
					end if
				%>
			</div>
			<!-- //검색어 변경시(재검색 시) -->

			<% If vWordBannerChk And Left(Now(), 10) >= "2015-03-23" And Left(Now(), 10) < "2015-04-21" Then %>
				<!-- 2015 diarystory -->
				<div class="btn-diarystory2015"><a href="/event/eventmain.asp?eventid=60385" title="웨딩기획전"><img src="http://webimage.10x10.co.kr/eventIMG/2015/60385/btn_go_homestagram.gif" alt="웨딩기획전" /></a></div>
			<% End If %>

			<!-- 검색결과_카테고리, 이벤트, 브랜드, PLAY Tab -->
			<!-- #Include file="inc_searchExpTabs.asp" -->

			<!-- Include file="inc_bestBrandInfo.asp" -->

			<!-- #Include file="inc_searchEventBox.asp" -->

<%
	'// 검색결과 가 있을 때
	if oDoc.FTotalCount>0 Then

		'// 검색 로그 사용여부(2017.01.12)
		Dim LogUsingCustomChk
		If getLoginUserId="thensi7" Then
			LogUsingCustomChk = True
		Else
			LogUsingCustomChk = True
		End If

		'// 검색어 로그저장(2017.01.11 원승현)
		If LogUsingCustomChk Then
			If IsUserLoginOK() Then
				If CurrPage="1" Then
					Call fnUserLogCheck("rect", getLoginUserid(), "", "", SearchText, "pc")
				End If
			End If
		End If
%>
			<!-- // 상품속성 필터 및 상품정렬 // -->
			<div class="ctgyWrapV15">
			<!-- #Include file="inc_searchFilter.asp" -->
			<!-- #include virtual="/diarystory2023/inc/diary2023_filter.asp" -->

	<form name="sFrm" id="listSFrm" method="get" action="?">
	<input type="hidden" name="rect" value="<%= SearchText %>">
	<input type="hidden" name="prvtxt" value="<%= PrevSearchText %>">
	<input type="hidden" name="rstxt" value="<%= ReSearchText %>">
	<input type="hidden" name="extxt" value="<%= ExceptText %>">
	<input type="hidden" name="sflag" value="<%= SearchFlag %>">
	<input type="hidden" name="dispCate" value="<%= dispCate %>">
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
	<input type="hidden" name="subshopcd" value="<%=subshopcd%>">
	<input type="hidden" name="giftdiv" value="<%=giftdiv%>">
	<input type="hidden" name="prectcnt" value="<%=oDoc.FTotalCount%>">
	<input type="hidden" name="diarystoryitem" value="<%=diarystoryitem%>">
	</form>
	<% if Not(searchFlag="ea" or searchFlag="ep") then %>
			<!-- // 검색결과 상품목록 시작 // -->
			<%
				Dim icol, rcParam
				IF oDoc.FResultCount >0 then
			%>
				<div class="pdtWrap <%=chkIIF(icoSize="M","pdt240V15","pdt150V15")%>">
					<ul class="pdtList">
					<%
						dim classStr, adultChkFlag, adultPopupLink, linkUrl
						For icol=0 To oDoc.FResultCount -1
						'클릭 위치 Parameter 추가
						rcParam = "&rc=rpos_" & CurrPage &"_" & (icol+1)
						classStr = ""
						linkUrl = "/shopping/category_prd.asp?itemid="& oDoc.FItemList(icol).FItemID &"&disp="&getArrayDispCate(dispCate,oDoc.FItemList(icol).FarrCateCd) & logparam & rcParam
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
								<% if adultChkFlag then %>
								<div class="adult-hide">
									<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
								</div>
								<% end if %>
									<a href="/deal/deal.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%= oDoc.FItemList(icol).FcateCode %><%=logparam & rcParam%>">
										<span class="soldOutMask"></span>
										<img src="<%=getThumbImgFromURL(oDoc.FItemList(icol).FImageBasic,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" />
										<% if oDoc.FItemList(icol).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(icol).FAddimage,imgSz,imgSz,"true","false")%>" onerror="$(this).parent().empty();" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" /></dfn><% end if %>
									</a>
								</div>
								<div class="pdtInfo">
									<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oDoc.FItemList(icol).FMakerid %>"><% = oDoc.FItemList(icol).FBrandName %></a></p>
									<p class="pdtName tPad07"><a href="/deal/deal.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%= oDoc.FItemList(icol).FcateCode %><%=logparam & rcParam%>"><% = oDoc.FItemList(icol).FItemName %></a></p>
									<% IF oDoc.FItemList(icol).FItemOptionCnt="" Or oDoc.FItemList(icol).FItemOptionCnt="0" then %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(icol).getRealPrice,0)%>원<% If oDoc.FItemList(icol).FtenOnlyYn="Y" Then %>~<% End If %></span></p>
									<% Else %>
									<p class="pdtPrice"><span class="finalP"><%=FormatNumber(oDoc.FItemList(icol).getRealPrice,0)%>원<% If oDoc.FItemList(icol).FtenOnlyYn="Y" Then %>~<% End If %></span> <strong class="cRd0V15">[<% If oDoc.FItemList(icol).FLimityn="Y" Then %>~<% End If %><%=oDoc.FItemList(icol).FItemOptionCnt%>%]</strong></p>
									<% End If %>
									<p class="pdtStTag tPad10">
									<% IF oDoc.FItemList(icol).isSoldOut Then %>
										<img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" />
									<% else %>
										<% IF oDoc.FItemList(icol).isTempSoldOut Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_soldout.gif" alt="SOLDOUT" /> <% end if %>
										<% IF Not(isNull(oDoc.FItemList(icol).FItemOptionCnt) or trim(oDoc.FItemList(icol).FItemOptionCnt)="") Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_sale.gif" alt="SALE" /> <% end if %>
										<% IF oDoc.FItemList(icol).isCouponItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_coupon.gif" alt="쿠폰" /> <% end if %>
										<% IF oDoc.FItemList(icol).isNewItem Then %><img src="http://fiximage.10x10.co.kr/web2013/shopping/tag_new.gif" alt="NEW" /> <% end if %>
									<% end if %>
									</p>
								</div>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oDoc.FItemList(icol).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" onclick="<%=chkIIF(oDoc.FItemList(icol).FEvalCnt>0,"popEvaluate('" & oDoc.FItemList(icol).FItemid & "');","")%>return false;"><span><%=oDoc.FItemList(icol).FEvalCnt%></span></a></li>
									<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oDoc.FItemList(icol).FItemid %>'); return false;"><span><%=oDoc.FItemList(icol).FfavCount%></span></a></li>
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
								<% if adultChkFlag then %>
								<div class="adult-hide">
									<p><span>19세 이상만</span> <span>구매 가능한 상품입니다</span></p>
								</div>
								<% end if %>
									<a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%= oDoc.FItemList(icol).FcateCode %><%=logparam & rcParam%>">
										<span class="soldOutMask"></span>
										<img src="<%=getThumbImgFromURL(oDoc.FItemList(icol).FImageBasic,imgSz,imgSz,"true","false")%>" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" />
										<% if oDoc.FItemList(icol).FAddimage<>"" then %><dfn><img src="<%=getThumbImgFromURL(oDoc.FItemList(icol).FAddimage,imgSz,imgSz,"true","false")%>" onerror="$(this).parent().empty();" alt="<%=Replace(oDoc.FItemList(icol).FItemName,"""","")%>" /></dfn><% end if %>
									</a>
								</div>
								<div class="pdtInfo">
									<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oDoc.FItemList(icol).FMakerid %>"><% = oDoc.FItemList(icol).FBrandName %></a></p>
									<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%= oDoc.FItemList(icol).FcateCode %><%=logparam & rcParam%>"><% = oDoc.FItemList(icol).FItemName %></a></p>
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
									<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oDoc.FItemList(icol).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" onclick="<%=chkIIF(oDoc.FItemList(icol).FEvalCnt>0,"popEvaluate('" & oDoc.FItemList(icol).FItemid & "');","")%>return false;"><span><%=oDoc.FItemList(icol).FEvalCnt%></span></a></li>
									<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oDoc.FItemList(icol).FItemid %>'); return false;"><span><%=oDoc.FItemList(icol).FfavCount%></span></a></li>
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
									<a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>"><span class="soldOutMask"></span><img src="<%=oEval.FItemList(lp).FIcon1Image%>" width="200px" height="200px" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
								</div>
								<div class="pdtInfo ftRt">
									<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oEval.FItemList(lp).FMakerId%>"><%=oEval.FItemList(lp).Fbrandname%></a></p>
									<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>"><%=oEval.FItemList(lp).Fitemname%></a></p>
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
									<% end if %>
									</p>
								</div>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oEval.FItemList(lp).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" <%=chkIIF(oEval.FItemList(lp).FEvalCnt>0,"onclick=""popEvaluate('" & oEval.FItemList(lp).FItemid & "'); return false;""","")%>><span><%=oEval.FItemList(lp).FEvalcnt%></span></a></li>
									<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oEval.FItemList(lp).FItemid %>'); return false;"><span><%=oEval.FItemList(lp).FfavCount%></span></a></li>
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

								<a href="" onclick="popEvaluate(<%=oEval.FItemList(lp).Fitemid%>);return false;" title="상품 전체 리뷰 보기" class="more1V15">상품 전체 리뷰보기</a>
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
								<a href="" onclick="popEvaluate(<%=oEval.FItemList(lp).Fitemid%>);return false;" title="상품 전체 리뷰 보기" class="more1V15">상품 전체 리뷰보기</a>
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
									<a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>"><span class="soldOutMask"></span><img src="<%=oEval.FItemList(lp).FIcon1Image%>" width="400px" height="400px" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
								</div>
								<div class="pdtInfo">
									<p class="pdtBrand"><a href="/street/street_brand.asp?makerid=<%=oEval.FItemList(lp).FMakerId%>"><%=oEval.FItemList(lp).Fbrandname%></a></p>
									<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>"><%=oEval.FItemList(lp).Fitemname%></a></p>
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
										<% end if %>
										</span>
									</p>
								</div>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oEval.FItemList(lp).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" <%=chkIIF(oEval.FItemList(lp).FEvalCnt>0,"onclick=""popEvaluate('" & oEval.FItemList(lp).FItemid & "'); return false;""","")%>><span><%=oEval.FItemList(lp).FEvalcnt%></span></a></li>
									<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oEval.FItemList(lp).FItemid %>'); return false;"><span><%=oEval.FItemList(lp).FfavCount%></span></a></li>
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
<%
	Else
		'// 검색 결과 없음
%>
			<script type="text/javascript" src="/common/addlog.js?tp=noresult&ror=<%=server.UrlEncode(Request.serverVariables("HTTP_REFERER"))%>"></script>
			<div class="nodata-search">
				<p>'<b><%= SearchText %></b>' 검색결과가 없습니다.</p>
				<p>해당상품이 품절 되었을 경우 검색이 되지 않습니다.</p>
			</div>

			<form name="sFrm" id="listSFrm" method="get" action="?">
			<input type="hidden" name="rect" value="<%= SearchText %>">
			<input type="hidden" name="prvtxt" value="<%= PrevSearchText %>">
			<input type="hidden" name="rstxt" value="<%= ReSearchText %>">
			<input type="hidden" name="extxt" value="<%= ExceptText %>">
			<input type="hidden" name="sflag" value="<%= SearchFlag %>">
			<input type="hidden" name="dispCate" value="<%= dispCate %>">
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
			<input type="hidden" name="subshopcd" value="<%=subshopcd%>">
			<input type="hidden" name="giftdiv" value="<%=giftdiv%>">
			<input type="hidden" name="prectcnt" value="0">
			</form>

			<!-- 베스트 셀러 -->
			<!-- #Include file="inc_BestItemList.asp" -->
<%
	end if
	''2017/09/04 검색결과 count수 by eastone
	IF (CurrPage="1") then
		if (is_AbTestTarget) then	'' 2018/03/14 AB TEST 분기
			call fn_AddIISAppendToLOG("rectcnt="&oDoc.FTotalCount&"&ab=023_"&ab_targetGroup&CHKIIF(request.ServerVariables("QUERY_STRING")="","&",""))
		else
			call fn_AddIISAppendToLOG("rectcnt="&oDoc.FTotalCount&CHKIIF(request.ServerVariables("QUERY_STRING")="","&","")) '' footer에 addlog가 또 잇으므로.
		end if
	else '' 2018/03/14 AB TEST 분기
		if (is_AbTestTarget) then	'' 2018/03/14 AB TEST 분기
	 		call fn_AddIISAppendToLOG("ab=023_"&ab_targetGroup&CHKIIF(request.ServerVariables("QUERY_STRING")="","&",""))
		end if
	end if
''	set oTotalCnt = Nothing  '' 미사용
%>
		<div id="dimed"></div>
		</div>
	</div>
	<!-- #include virtual="/lib/inc/incFooter.asp" -->
</div>
<% '2015-09-24 레코벨 신규 스크립트 원승현 추가 %>
<% '2015-11-30 레코벨 서비스 종료 원승현 추가 %>
<script type="text/javascript">
//	var _rblqueue = _rblqueue || [];
//	_rblqueue.push(['setVar','cuid','0f8265c6-6457-4b4a-b557-905d58f9f216']);
//	_rblqueue.push(['setVar','device','PW']);
//	_rblqueue.push(['setVar','userId','<%=request.Cookies("tinfo")("shix")%>']);		// optional
//	_rblqueue.push(['setVar','searchTerm','<%=SearchText%>']);
//	_rblqueue.push(['track','search']);
//	setTimeout(function() {
//		(function(s,x){s=document.createElement('script');s.type='text/javascript';
//		s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+
//		'://d1hn8mrtxasu7m.cloudfront.net/rblc/js/rblc-apne1.min.js';
//		x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
//	}, 0);
</script>
<%' 에코마케팅용 레코벨 스크립트 삽입(2016.12.21) %>
<script type="text/javascript">
	window._rblq = window._rblq || [];
	_rblq.push(['setVar','cuid','0f8265c6-6457-4b4a-b557-905d58f9f216']);
	_rblq.push(['setVar','device','PW']);
//	_rblq.push(['setVar','userId','{$userId}']); // optional
	_rblq.push(['setVar','searchTerm','<%=SearchText%>']);
	_rblq.push(['track','search']);
	(function(s,x){s=document.createElement('script');s.type='text/javascript';
	s.async=true;s.defer=true;s.src=(('https:'==document.location.protocol)?'https':'http')+
	'://assets.recobell.io/rblc/js/rblc-apne1.min.js';
	x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s, x);})();
</script>
<%'<!-- Criteo 카테고리/리스팅 태그 -->%>
<%
	If oDoc.FResultCount > 0 Then
		Dim CriteoSearchItemLists
		'// 크리테오 전송용 상품코드
		CriteoSearchItemLists = ""

		For icol = 0 To oDoc.FResultCount - 1
			If icol < 3 Then
				CriteoSearchItemLists = CriteoSearchItemLists & "'"&oDoc.FItemList(icol).FItemID&"',"
			End If
		Next
		If Trim(CriteoSearchItemLists) <> "" Then
			CriteoSearchItemLists = Left(CriteoSearchItemLists, Len(CriteoSearchItemLists)-1)
		End If
		'//크리테오에 보낼 md5 유저 이메일값
		Dim CriteoUserMailMD5InSearch
		If Trim(session("ssnuseremail")) <> "" Then
			CriteoUserMailMD5InSearch = MD5(Trim(session("ssnuseremail")))
		Else
			CriteoUserMailMD5InSearch = ""
		End If
%>
		<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
		<script type="text/javascript">
		window.criteo_q = window.criteo_q || [];
		var deviceType = /iPad/.test(navigator.userAgent) ? "t" : /Mobile|iP(hone|od)|Android|BlackBerry|IEMobile|Silk/.test(navigator.userAgent) ? "m" : "d";
		window.criteo_q.push(
			{ event: "setAccount", account: 8262},
			{ event: "setEmail", email: "<%=CriteoUserMailMD5InSearch%>" },
			{ event: "setSiteType", type: deviceType},
			{ event: "viewList", item: [<%=CriteoSearchItemLists%>] }
		);
		</script>
<%
	End If
%>
<%'<!-- END 카테고리/리스팅 태그 -->%>

<% IF oDoc.FResultCount > 0 then %>
<script type="application/ld+json">
{
	"@context": "http://schema.org",
	"@type": "SearchResultsPage",
	"mainEntity": [{
		"@type": "ItemList",
		"itemListOrder": "http://schema.org/ItemListOrderAscending",
		"itemListElement":[
			<%
			dim dispItemCnt : dispItemCnt = 0
			For icol = 0 To oDoc.FResultCount -1
				'// 성인용품 제외
				if (oDoc.FItemList(icol).FadultType <> 1) and oDoc.FItemList(icol).FAddimage<>"" then
					if (dispItemCnt > 0) then
						response.write ","
					end if
			%>{
				"@context": "http://schema.org/",
				"@type": "Product",
				"name": "<%= Replace(oDoc.FItemList(icol).FItemName,"""","") %>",
				"image": "<%= getThumbImgFromURL(oDoc.FItemList(icol).FAddimage,imgSz,imgSz,"true","false") %>",
				"mpn": "<%= oDoc.FItemList(icol).FItemID %>"
			}<%
			 		dispItemCnt = dispItemCnt + 1

					if (dispItemCnt >= 10) then exit for
				end if
			next
			%>
		]
	}]
}
</script>
<% end if %>
<%
set oDoc = Nothing
%>
</body>
</html>
<!-- #include virtual="/lib/db/dbclose.asp" -->
