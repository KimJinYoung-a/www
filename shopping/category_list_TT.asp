<%@ codepage="65001" language="VBScript" %>
<% option Explicit %>
<% response.Charset="UTF-8" %>
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
<%
Dim dispCate, vCateName,i
dispCate = vDisp
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
if SellScope = "" then SellScope = "Y"                                  ''기본 품절제외(eastone)
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

if CurrPage="" then CurrPage=1
if colorCD="" then colorCD="0"
IF searchFlag="" Then
	'// 2016년 봄 정기 세일 기간에는 기본으로 세일탭 지정
	if date()>="2016-04-18" and date()<="2016-04-27" then
		searchFlag= "sc"
	else
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

dim iRows,ix

'// 총 검색수 산출
dim oTotalCnt
set oTotalCnt = new SearchItemCls
oTotalCnt.FRectSearchTxt = DocSearchText
oTotalCnt.FRectExceptText = ExceptText
oTotalCnt.FRectSearchItemDiv = SearchItemDiv
oTotalCnt.FRectSearchCateDep = SearchCateDep
oTotalCnt.FListDiv = ListDiv
oTotalCnt.FSellScope=SellScope
oTotalCnt.getTotalCount

'// 상품검색
dim oDoc,iLp
set oDoc = new SearchItemCls
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

'// 검색어 로그 저장
if isSaveSearchKeyword and (tmpCurrSearchKeyword <> tmpPrevSearchKeyword) and (Not CheckResearch) and IsRealTypedKeyword then
	dim oKeyword
	dim keywordDataArray(3)
	set oKeyword = new CKeywordCls

	keywordDataArray(0) = oTotalCnt.FTotalCount

	if IsUserLoginOK then
		keywordDataArray(1) = GetLoginUserID
	else
		keywordDataArray(1) = ""
	end if

	keywordDataArray(2) = Request.ServerVariables("REMOTE_ADDR")

	Call oKeyword.SaveToDatabaseWithDataArray(tmpCurrSearchKeyword, tmpPrevSearchKeyword, keywordDataArray)

	set oKeyword = Nothing
end if

'// 카테고리=사용안함, 2016-06-15, skyer9
dim vCateNameToSearchStr : vCateNameToSearchStr = ""
if oDoc.FResultCount < 1 then
	if GetCategoryUseYN(vDisp) = "N" then
		vCateNameToSearchStr = Server.URLEncode(Replace(vCateName, "/", " "))
		Response.Redirect "/search/search_result.asp?rect=" & vCateNameToSearchStr & "&exkw=1"
		dbget.Close
		REsponse.End
	end if
end if

%>
<!-- #include virtual="/lib/inc/head.asp" -->
<script type="text/javascript" src="/lib/js/search_result.js?v=1.0"></script>
<script type="text/javascript" src="/lib/js/searchFilter.js?v=1.0"></script>
<script type="text/javascript" src="/lib/js/jquery.numspinner.min.js"></script>
<script>
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

});
</script>
</head>
<body>
<div class="wrap">
	<!-- #include virtual="/lib/inc/incHeader.asp" -->
	<div class="container">
		<div id="contentWrap">
			<div class="ctgyWrapV15">
				<div class="section">
					<div class="lnbWrapV15">
						<% If vIsBookCate Then %>
							<h2><img src="http://fiximage.10x10.co.kr/web2015/shopping/ctgy_titbook.gif" alt="BOOK" /></h2>
						<% Else %>
							<h2><a href="/shopping/category_main.asp?disp=<%=Left(vDisp,3)%>"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ctgy_tit<%=Left(vDisp,3)%>.gif" alt="<%=CategoryNameUseLeftMenu(vDisp)%>" /></a></h2>
						<% End If %>
						<!-- #include virtual="/shopping/include_category_banner.asp" -->
						<% If vIsBookCate Then %>
							<!-- #include virtual="/chtml/dispcate/menu/loader/leftcate_book.asp" -->
						<% Else %>
							<!-- #include virtual="/chtml/dispcate/menu/loader/leftcate.asp" -->
							<ul class="addLnbV15">
								<li><a href="/shoppingtoday/shoppingchance_saleitem.asp?disp=<%=Left(vDisp,3)%>">SALE</a></li>
								<li><a href="/shoppingtoday/shoppingchance_allevent.asp?disp=<%=Left(vDisp,3)%>">EVENT</a></li>
							</ul>
						<% End If %>
					</div>
					<div class="content">
						<% If Not vIsBookCate Then %>
						<div class="locationV15">
							<p><% Call printCategoryHistory_B(vDisp) %></p>
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
							Else
								vCtLiView = "o"
							End If

						If vCtLiView = "o" Then
						%>
						<dl class="subCtgyViewV15">
							<dt><%=CategoryNameUseLeftMenuDB(CHKIIF(vIsBookCate,Left(vDisp,3),CHKIIF(vIsDownDep="x",Left(vDisp,(Len(vDisp)-3)),vDisp)))%></dt>
							<dd>
								<ul>
								<%
									If IsArray(vCArr) Then
										For vCi = 0 To UBound(vCArr,2)
											Response.Write "<li " & CHKIIF(CStr(vDisp)=CStr(vCArr(0,vCi)),"class='current'","") & "><a href=""/shopping/category_list.asp?disp="&vCArr(0,vCi)&""">"&db2html(vCArr(1,vCi))&"</a></li>" & vbCrLf
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
					</form>
	<% if Not(searchFlag="ea" or searchFlag="ep") then %>
			<!-- // 검색결과 상품목록 시작 // -->
			<%
				Dim icol
				IF oDoc.FResultCount >0 then
			%>
				<div class="pdtWrap <%=chkIIF(icoSize="M","pdt240V15","pdt150V15")%>">
					<ul class="pdtList">
					<% For icol=0 To oDoc.FResultCount -1 %>
						<li<%=chkIIF(oDoc.FItemList(icol).isSoldOut," class=""soldOut""","")%>>
							<div class="pdtBox">
								<div class="pdtPhoto">
									<a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%=getArrayDispCate(dispCate,oDoc.FItemList(icol).FarrCateCd)%><%=logparam%>">
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
									<p class="pdtBrand tPad20"><a href="/street/street_brand.asp?makerid=<%= oDoc.FItemList(icol).FMakerid %>"><% = oDoc.FItemList(icol).FBrandName %></a></p>
									<p class="pdtName tPad07"><a href="/shopping/category_prd.asp?itemid=<%= oDoc.FItemList(icol).FItemID %>&disp=<%=getArrayDispCate(dispCate,oDoc.FItemList(icol).FarrCateCd)%><%=logparam%>"><% = oDoc.FItemList(icol).FItemName %></a></p>
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
						</li>
					<% Next %>
					</ul>
				</div>
			<% else %>
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
						if searchFlag="ea" then		'/// 일반상품 후기
				%>
						<li<%=chkIIF(oEval.FItemList(lp).isSoldOut," class=""soldOut""","")%>>
							<div class="pdtBox">
								<div class="pdtPhoto">
									<span class="soldOutMask"></span><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>"><img src="<%=oEval.FItemList(lp).FIcon1Image%>" width="200px" height="200px" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
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
										<% If G_IsPojangok Then %>
										<% IF oEval.FItemList(lp).IsPojangitem Then %><span class="icoWrappingV15a"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장가능"><em><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png" alt="선물포장가능"></em></span> <% end if %>
										<% End If %>
									<% end if %>
									</p>
								</div>
								<ul class="pdtActionV15">
									<li class="largeView"><a href="" onclick="ZoomItemInfo('<%=oEval.FItemList(lp).FItemid %>'); return false;"><img src="http://fiximage.10x10.co.kr/web2015/common/btn_quick.png" alt="QUICK" /></a></li>
									<li class="postView"><a href="" <%=chkIIF(oEval.FItemList(lp).FEvalCnt>0,"onclick=""popEvaluate('" & oEval.FItemList(lp).FItemid & "'); return false;""","")%>><span><%=oEval.FItemList(lp).FEvalcnt%></span></a></li>
									<li class="wishView"><a href="" onclick="TnAddFavorite('<%=oEval.FItemList(lp).FItemid %>'); return false;"><span><%=oEval.FItemList(lp).FfavCount%></span></a></li>
								</ul>
							</div>
							<div class="reviewBoxV15">
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
						<li<%=chkIIF(oEval.FItemList(lp).isSoldOut," class=""soldOut""","")%>>
							<div class="reviewBoxV15">
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
								<div class="pdtPhoto">
									<span class="soldOutMask"></span><a href="/shopping/category_prd.asp?itemid=<%=oEval.FItemList(lp).Fitemid%><%=logparam%>"><img src="<%=oEval.FItemList(lp).FIcon1Image%>" width="400px" height="400px" alt="<%=replace(oEval.FItemList(lp).Fitemname,"""","")%>" /></a>
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
											<% If G_IsPojangok Then %>
											<% IF oEval.FItemList(lp).IsPojangitem Then %><span class="icoWrappingV15a"><img src="http://fiximage.10x10.co.kr/web2015/shopping/ico_pakage_act.png" alt="선물포장가능"><em><img src="http://fiximage.10x10.co.kr/web2015/common/pkg_tip.png" alt="선물포장가능"></em></span> <% end if %>
											<% End If %>
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

<%
if Not(searchFlag="ea" or searchFlag="ep") then
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
			"@type": "Thing",
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
