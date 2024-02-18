<%
'#######################################################
'	History	:  2013.08.21 허진원 생성
'	Description : 검색 필터링 / 가격범위 최소/최대 검색 결과(Ajax용)
'	/street/act_shop_category.asp 에서도 사용
'#######################################################

	'// 결과에 해당되는 컬러칩만 표시 //
	dim oGrPrc
	chkTempCount = 0
	set oGrPrc = new SearchItemCls
	'' oGrPrc.FRectSortMethod = SortMet		'상품정렬 방법
	oGrPrc.FRectSearchTxt = DocSearchText
	oGrPrc.FRectExceptText = ExceptText
	'' oGrPrc.FminPrice	= minPrice		'가격범위(최소)
	'' oGrPrc.FmaxPrice	= maxPrice		'가격범위(최대)
	'' oGrPrc.FdeliType	= deliType		'배송방법
	oGrPrc.FRectMakerid = makerid
	oGrPrc.FRectSearchCateDep = SearchCateDep
	oGrPrc.FRectCateCode = dispCate
	oGrPrc.FarrCate=arrCate
	oGrPrc.FCurrPage = 1
	oGrPrc.FPageSize = 1
	oGrPrc.FScrollCount =10
	oGrPrc.FListDiv = ListDiv
	oGrPrc.FSellScope=SellScope			'판매/품절상품 포함 여부
	oGrPrc.FLogsAccept = False

	oGrPrc.getItemPriceRange
%>
<div class="amoundBox1"><input type="text" id="amountFirst" readonly class="amoundRange" /><span></span></div>
<div class="amoundBox2"><input type="text" id="amountEnd" readonly class="amoundRange" /><span></span></div>
<div class="sliderWrap"><div id="slider-range"></div></div>
<%
	If oGrPrc.FResultCount>0 Then
%>
	<p class="amountLt amountView"><%=formatNumber(oGrPrc.FItemList(0).FminPrice,0)%>원</p>
	<p class="amountRt amountView"><%=formatNumber(oGrPrc.FItemList(0).FmaxPrice,0)%>원</p>
	<input type="hidden" id="ftMinPrc" value="<%=oGrPrc.FItemList(0).FminPrice%>" />
	<input type="hidden" id="ftMaxPrc" value="<%=oGrPrc.FItemList(0).FmaxPrice%>" />
	<input type="hidden" id="ftSelMin" value="<%=chkIIF(minPrice>0,minPrice,oGrPrc.FItemList(0).FminPrice)%>" />
	<input type="hidden" id="ftSelMax" value="<%=chkIIF(maxPrice>0,maxPrice,oGrPrc.FItemList(0).FmaxPrice)%>" />
<%
	else
		'없으면 기본값
%>
	<p class="amountLt amountView">10,000원</p>
	<p class="amountRt amountView">300,000원</p>
	<input type="hidden" id="ftMinPrc" value="10000" />
	<input type="hidden" id="ftMaxPrc" value="300000" />
	<input type="hidden" id="ftSelMin" value="10000" />
	<input type="hidden" id="ftSelMax" value="300000" />
<%
	end if
%>
</ul>
<%
	set oGrPrc = Nothing
%>