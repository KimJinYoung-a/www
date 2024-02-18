<%
'#######################################################
'	History	:  2013.08.21 허진원 생성
'	Description : 검색 필터링 / 컬러 그룹핑 검색 결과(Ajax용)
'	/street/act_shop_category.asp 에서도 사용
'#######################################################

	'// 결과에 해당되는 컬러칩만 표시 //
	dim oGrClr, chkSrchBtn, chkTempCount
	chkTempCount = 0
	set oGrClr = new SearchItemCls
	'' oGrClr.FRectSortMethod = SortMet		'상품정렬 방법
	oGrClr.FRectSearchTxt = DocSearchText
	oGrClr.FRectExceptText = ExceptText
	'' oGrClr.FminPrice	= minPrice		'가격범위(최소)
	'' oGrClr.FmaxPrice	= maxPrice		'가격범위(최대)
	'' oGrClr.FdeliType	= deliType		'배송방법
	oGrClr.FRectMakerid = makerid
	oGrClr.FRectSearchCateDep = SearchCateDep
	oGrClr.FRectCateCode = dispCate
	oGrClr.FarrCate=arrCate
	oGrClr.FCurrPage = 1
	oGrClr.FPageSize = 31
	oGrClr.FScrollCount =10
	oGrClr.FListDiv = ListDiv
	oGrClr.FSellScope=SellScope			'판매/품절상품 포함 여부
	oGrClr.FLogsAccept = False

	oGrClr.getTotalItemColorCount
%>
<ul class="colorchipV15">
	<li class="all <%=chkiif(cStr(colorCD)="0","selected","")%>"><p><input type="checkbox" id="col0" value="0" /></p><label for="col0">ALL</label></li>
<%
	If oGrClr.FResultCount>0 Then
		FOR lp=0 to oGrClr.FResultCount-1
            if oGrClr is Nothing then
                '// skip
            elseif VarType(oGrClr) <> vbObject then
                '// skip
            elseif VarType(oGrClr.FItemList(lp)) <> vbObject then
                '// skip
			elseif VarType(oGrClr.FItemList(lp).FcolorCode) = vbString then
%>
	<li class="<%=getColorEng(oGrClr.FItemList(lp).FcolorCode) & " " & chkiif(chkArrValue(colorCD,oGrClr.FItemList(lp).FcolorCode),"selected","")%>">
		<p><input type="checkbox" id="col<%=oGrClr.FItemList(lp).FcolorCode%>" value="<%=oGrClr.FItemList(lp).FcolorCode%>" <%=chkiif(chkArrValue(colorCD,oGrClr.FItemList(lp).FcolorCode),"checked","")%> /></p>
		<label for="col<%=oGrClr.FItemList(lp).FcolorCode%>"><%=UCase(getColorEng(oGrClr.FItemList(lp).FcolorCode))%></label>
	</li>
<%
			end if
		Next
	end if
%>
</ul>
<%
	'set oGrClr = Nothing

	function getColorEng(ccd)
		dim arrCnm
		if isNumeric(ccd) then
			if cInt(ccd)>31 then
				getColorEng = "all"
				exit function
			end if

            '2015/04/22 추가 //벌크작업시 오류 있을수 있음.
            if cInt(ccd)<1 then
				getColorEng = "all"
				exit function
			end if

			'컬러명 배열로 세팅 (코드순으로 나열)
			arrCnm = split("red,orange,yellow,beige,green,skyblue,blue,violet,pink,brown,white,grey,black,silver,gold,mint,babypink,lilac,khaki,navy,camel,charcoal,wine,ivory,check,stripe,dot,flower,drawing,animal,geometric",",")

			'반환
			getColorEng = arrCnm(cInt(ccd)-1)
		else
			getColorEng = "all"
		end if
	end function
%>
