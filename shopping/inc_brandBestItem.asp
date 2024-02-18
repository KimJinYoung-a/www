<%
	'// 브랜드 베스트
	'- 2015.03.30 : 허진원 생성
	dim oBBDoc
	set oBBDoc = new SearchItemCls
		oBBDoc.FRectSortMethod	= "be"		'인기상품
		oBBDoc.FRectSearchFlag = "n"			'일반상품
		oBBDoc.FRectSearchItemDiv = "n"		'기본 카테고리만
		oBBDoc.FRectSearchCateDep = "T"		'하위 카테고리 포함
		oBBDoc.FRectMakerid = makerid
		oBBDoc.FCurrPage = 1
		oBBDoc.FPageSize = 5					'4개 접수
		oBBDoc.FScrollCount = 5
		oBBDoc.FListDiv = "brand"				'브랜드상품
		oBBDoc.FLogsAccept = False			'로그 기록안함
		oBBDoc.FAddLogRemove = true			'추가로그 기록안함
		oBBDoc.FSellScope= "Y"				'판매중인 상품만
		oBBDoc.getSearchList

	ichk = 1
	If oBBDoc.FResultCount > 0 Then
%>
	<a href="/street/street_brand_sub06.asp?makerid=<%=makerid%>&srm=be" class="more"><span>more</span> &gt;</a>
	<ul class="pdtList">
<%
			For iLp=0 To oBBDoc.FResultCount-1
				if cStr(oBBDoc.FItemList(iLp).Fitemid)<>cStr(itemid) then	'현재보는 상품이 아니면 표시
%>
		<li>
			<p class="pdtPhoto"><a href="/shopping/category_prd.asp?itemid=<%= oBBDoc.FItemList(iLp).Fitemid %>&rc=item_brand_<%=ichk%>"><img src="<%=oBBDoc.FItemList(iLp).FImageIcon2%>" alt="<%=Replace(oBBDoc.FItemList(iLp).FitemName,"""","")%>" /></a></p>
			<p class="pdtBrand tPad15"><a href="/street/street_brand_sub06.asp?makerid=<%= oBBDoc.FItemList(iLp).FMakerid %>&rc=item_brand_<%=ichk%>"><%= oBBDoc.FItemList(iLp).FBrandName %></a></p>
			<p class="pdtName tPad05"><a href="/shopping/category_prd.asp?itemid=<%= oBBDoc.FItemList(iLp).Fitemid %>&rc=item_brand_<%=ichk%>"><%=chrbyte(oBBDoc.FItemList(iLp).FitemName,12,"Y")%></a></p>
			<p class="pdtPrice tPad05">
				<strong><% = FormatNumber(oBBDoc.FItemList(iLp).getRealPrice,0) %>원</strong>
				<% If oBBDoc.FItemList(iLp).IsSaleItem Then %>
				<strong class="cRd0V15">[<% = oBBDoc.FItemList(iLp).getSalePro %>]</strong>
				<% end if %>
			</p>
		</li>
<%
				ichk = ichk+1
				end if
				if ichk>4 then Exit For
			Next
%>
	</ul>
<%
	End if

	if ichk<4 then
		'3개가 안되면 버튼없앰
		Response.Write "<script>$('.recommendItemV15 .itemNaviV15 .item03').hide();</script>"
	end if
	
	if ichk>1 then	'현재보는 상품 제외 1개 이상 있으면 박스 show
		Response.Write "<script>$('#recommenditem').show();</script>"
	end if

	set oBBDoc = Nothing
%>