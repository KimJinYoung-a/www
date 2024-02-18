<%
'#######################################################
'	History	:  2013.08.21 허진원 생성
'	Description : 검색 필터링 / 스타일 그룹핑 검색 결과(Ajax용)
'	/street/act_shop_category.asp 에서도 사용
'#######################################################

	'// 결과에 해당되는 컬러칩만 표시 //
	dim oGrStl
	chkTempCount = 0
	set oGrStl = new SearchItemCls
	'' oGrStl.FRectSortMethod = SortMet		'상품정렬 방법
	oGrStl.FRectSearchTxt = DocSearchText
	oGrStl.FRectExceptText = ExceptText
	'' oGrStl.FminPrice	= minPrice		'가격범위(최소)
	'' oGrStl.FmaxPrice	= maxPrice		'가격범위(최대)
	'' oGrStl.FdeliType	= deliType		'배송방법
	oGrStl.FRectMakerid = makerid
	oGrStl.FRectSearchCateDep = SearchCateDep
	oGrStl.FRectCateCode = dispCate
	oGrStl.FarrCate=arrCate
	oGrStl.FCurrPage = 1
	oGrStl.FPageSize = 10
	oGrStl.FScrollCount =10
	oGrStl.FListDiv = ListDiv
	oGrStl.FSellScope=SellScope			'판매/품절상품 포함 여부
	oGrStl.FLogsAccept = False

	oGrStl.getGroupbyStyleList
%>
<ul>
	<li><input type="checkbox" id="stl0" value="" <%=chkiif(cStr(styleCd)="","checked","")%> class="check" /> <label for="stl0">ALL</label></li>
<%
	If oGrStl.FResultCount>0 Then
		FOR lp=0 to oGrStl.FResultCount-1
%>
	<li><input type="checkbox" id="stl<%=oGrStl.FItemList(lp).FstyleCd%>" value="<%=oGrStl.FItemList(lp).FstyleCd%>" <%=chkiif(chkArrValue(styleCd,oGrStl.FItemList(lp).FstyleCd),"checked","")%> class="check" /><label for="stl<%=oGrStl.FItemList(lp).FstyleCd%>"> <%=getStyleKor(oGrStl.FItemList(lp).FStyleCd)%></label></li>
<%
		Next
	else
		'검색된 속성이 없으면 속성탭버튼 숨김
		Response.Write "<script style='text/javascript'>$('#tabStyle').hide();</script>"
	end if
%>
</ul>
<%
	set oGrStl = Nothing

	function getStyleKor(scd)
		dim arrSnm
		if isNumeric(scd) then
			if cInt(scd)>90 then 
				getStyleKor = "all"
				exit function
			end if
            
            ''2015/04/22 추가 //벌크작업시 오류 있을수 있음.
            if cInt(scd)<10 then 
				getStyleKor = "all"
				exit function
			end if
			
			'컬러명 배열로 세팅 (코드순으로 나열)
			arrSnm = split("클래식,큐티,댄디,모던,내추럴,오리엔탈,팝,로맨틱,빈티지",",")

			'반환
			getStyleKor = arrSnm(cInt(scd)/10-1)
		else
			getStyleKor = "all"
		end if
	end function
%>